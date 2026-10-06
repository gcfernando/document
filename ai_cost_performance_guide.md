# 🚀 AI Cost & Performance: Tokens, Caching, Routing, and Honest Pricing Math

> Measure what an AI feature actually costs and how fast it runs, then reduce both with caching and model routing — without hardcoding prices that will be wrong within months.

> [!NOTE]
> **Execution status:** reasoned through carefully against the documented Ollama API, Python's standard library, and `System.Text.Json`, but not executed against a live model in this sandbox (no local Ollama server available here). ⚠️ **Needs runtime verification** flags anything whose exact numbers depend on your hardware/model and weren't actually measured this session.

## 🎯 What You Will Build

- Token counting using the model's **own reported counts** from the Ollama response (not a third-party tokenizer), with an honest note on why approximate counting is fine for cost estimates but not for hard context-limit enforcement.
- A simple **local cache** (dict/file-backed) for identical prompt+model pairs, with a measured before/after speedup on a repeated call.
- **Model routing**: a cheap heuristic sends "simple" requests to a smaller model and "complex" ones to a larger one, extending the agent-routing pattern from [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md).
- A one-paragraph note on **batching** and why it mostly doesn't apply to interactive chat.
- A worked cost estimate using clearly-labeled **placeholder rates** — never a hardcoded real price.

## 📚 Prerequisites

- [Local AI Learning Lab](local_ai_learning_lab.md#lab-build) — Ollama installed, `qwen3.5:9b-q4_K_M` pulled. For the routing step you'll also want one smaller model, e.g. `ollama pull qwen2.5:1.5b` (any noticeably smaller model you have available works for the demo).
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) Lab 2 — the routing-decision pattern this guide's model-routing step extends.
- [`ai_evaluation_guide.md`](ai_evaluation_guide.md) Step 6 — this guide reuses the same `eval_count`/`eval_duration` fields from the Ollama response rather than re-deriving them.

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced

## 🛠️ Setup

```powershell
ollama pull qwen2.5:1.5b
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install ollama
```

```powershell
dotnet new console -o CostLab
Set-Location CostLab
```

`OllamaClient.cs` (same shared pattern as every other lab in this repo):

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public static class OllamaClient
{
    private static readonly HttpClient Client = new()
    {
        BaseAddress = new Uri("http://127.0.0.1:11434"),
        Timeout = TimeSpan.FromSeconds(120)
    };

    public static async Task<JsonDocument> GenerateRawAsync(string model, string prompt)
    {
        var request = new { model, prompt, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        return JsonDocument.Parse(await response.Content.ReadAsByteArrayAsync());
    }
}
```

---

## 🚀 Step 1 — Token counting: why it matters, and the honest caveat

Tokens drive two unrelated things: **cost** (most providers bill per token) and **context limits** (a model can only attend to so many tokens total). The Ollama response already reports exactly how many tokens it used — `prompt_eval_count` (prompt) and `eval_count` (response), confirmed field names from Ollama's official API documentation — so for a locally-run model, the honest approach is to read what the model itself reports rather than estimate.

### 💻 Code

`token_counting.py`:

```python
import ollama

def count_tokens_from_response(prompt: str, model: str = "qwen3.5:9b-q4_K_M") -> dict:
    response = ollama.generate(model=model, prompt=prompt)
    return {
        "prompt_tokens": response.get("prompt_eval_count"),
        "response_tokens": response.get("eval_count"),
        "total_tokens": (response.get("prompt_eval_count") or 0) + (response.get("eval_count") or 0),
    }

def rough_estimate(text: str) -> int:
    """A quick, approximate estimate when you don't have an API response yet
    (e.g. to decide whether a prompt is likely to fit before sending it).
    The ~4-characters-per-token rule of thumb is a rough average for English text
    with common tokenizers — NOT exact for any specific model's actual tokenizer,
    and noticeably worse for code, non-English text, or lots of punctuation."""
    return max(1, len(text) // 4)

if __name__ == "__main__":
    prompt = "Explain exponential backoff in one sentence."
    print("Reported by model:", count_tokens_from_response(prompt))
    print("Rough pre-send estimate:", rough_estimate(prompt))
```

`TokenCounting.cs`:

```csharp
public static class TokenCounting
{
    public static async Task<(long PromptTokens, long ResponseTokens, long TotalTokens)> CountTokensFromResponseAsync(
        string prompt, string model = "qwen3.5:9b-q4_K_M")
    {
        using var doc = await OllamaClient.GenerateRawAsync(model, prompt);
        var root = doc.RootElement;
        long promptTokens = root.TryGetProperty("prompt_eval_count", out var pc) ? pc.GetInt64() : 0;
        long responseTokens = root.TryGetProperty("eval_count", out var ec) ? ec.GetInt64() : 0;
        return (promptTokens, responseTokens, promptTokens + responseTokens);
    }

    // Rough, approximate estimate only — see the caveat below.
    public static int RoughEstimate(string text) => Math.Max(1, text.Length / 4);
}
```

### 👀 Expected Output

```text
Reported by model: {'prompt_tokens': 11, 'response_tokens': 24, 'total_tokens': 35}
Rough pre-send estimate: 11
```

⚠️ **Needs runtime verification** — actual counts depend on the model's specific tokenizer (every model family tokenizes differently), so these numbers are illustrative shape, not exact values to expect.

### 🧠 What Just Happened?

> [!WARNING]
> **Exact tokenization varies by model.** Two different models given the identical prompt string can report different `prompt_eval_count` values, because each has its own vocabulary/tokenizer. The `len(text) // 4` rule of thumb is good enough to *estimate cost before you've made the call*, or to budget roughly; it is **not** reliable enough to enforce a hard context-limit cutoff — for that, use the model's own reported count after the fact, or that specific model's actual tokenizer library if you need to check *before* sending (e.g. `tiktoken` for OpenAI models — not applicable to every local model).

---

## 🚀 Step 2 — Caching identical prompt+model pairs

If the exact same prompt is sent to the exact same model again, there's no reason to pay for (or wait for) a second generation.

### 💻 Code

`prompt_cache.py`:

```python
import hashlib
import json
import time
from pathlib import Path
import ollama

class PromptCache:
    """File-backed cache keyed on a hash of (model, prompt). Survives across process runs,
    unlike a plain in-memory dict."""

    def __init__(self, path: str = "prompt_cache.json"):
        self.path = Path(path)
        self._data = json.loads(self.path.read_text(encoding="utf-8")) if self.path.exists() else {}

    def _key(self, model: str, prompt: str) -> str:
        return hashlib.sha256(f"{model}:{prompt}".encode("utf-8")).hexdigest()

    def get_or_generate(self, model: str, prompt: str) -> tuple[str, bool]:
        """Returns (response_text, was_cache_hit)."""
        key = self._key(model, prompt)
        if key in self._data:
            return self._data[key], True
        response = ollama.generate(model=model, prompt=prompt)["response"]
        self._data[key] = response
        self.path.write_text(json.dumps(self._data), encoding="utf-8")
        return response, False

if __name__ == "__main__":
    cache = PromptCache()
    prompt = "Explain exponential backoff in one sentence."

    start = time.time()
    _, hit1 = cache.get_or_generate("qwen3.5:9b-q4_K_M", prompt)
    elapsed1 = time.time() - start

    start = time.time()
    _, hit2 = cache.get_or_generate("qwen3.5:9b-q4_K_M", prompt)
    elapsed2 = time.time() - start

    print(f"First call:  cache_hit={hit1}  {elapsed1:.2f}s")
    print(f"Second call: cache_hit={hit2}  {elapsed2:.2f}s")
    print(f"Speedup: {elapsed1 / max(elapsed2, 0.0001):.0f}x, and zero additional tokens billed on the second call")
```

`PromptCache.cs`:

```csharp
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

public class PromptCache
{
    private readonly string _path;
    private Dictionary<string, string> _data;

    public PromptCache(string path = "prompt_cache.json")
    {
        _path = path;
        _data = File.Exists(_path)
            ? JsonSerializer.Deserialize<Dictionary<string, string>>(File.ReadAllText(_path)) ?? new()
            : new();
    }

    private static string Key(string model, string prompt)
    {
        var bytes = Encoding.UTF8.GetBytes($"{model}:{prompt}");
        return Convert.ToHexString(SHA256.HashData(bytes));
    }

    public async Task<(string Response, bool WasCacheHit)> GetOrGenerateAsync(string model, string prompt)
    {
        var key = Key(model, prompt);
        if (_data.TryGetValue(key, out var cached))
            return (cached, true);

        using var doc = await OllamaClient.GenerateRawAsync(model, prompt);
        var response = doc.RootElement.GetProperty("response").GetString()!;
        _data[key] = response;
        File.WriteAllText(_path, JsonSerializer.Serialize(_data));
        return (response, false);
    }
}
```

### 👀 Expected Output

```text
First call:  cache_hit=False  1.92s
Second call: cache_hit=True   0.00s
Speedup: 1900x, and zero additional tokens billed on the second call
```

⚠️ **Needs runtime verification** — the speedup ratio depends entirely on your original generation latency; the structural result (second call is near-instant, no tokens billed) is what to verify, not the exact multiplier.

### 🧠 What Just Happened?

A cache hit skips the model entirely — zero latency beyond a hash lookup, zero tokens, zero cost. This only helps for **exact** repeats (identical prompt string, identical model); a single changed word produces a different hash and a cache miss. That's a real limitation for free-form chat (users rarely phrase things identically) but a strong win for templated, programmatic calls — e.g. the same classification prompt applied to the same recurring input, or repeated calls during iterative development/testing of a prompt (don't re-pay for re-running `ai_evaluation_guide.md`'s eval set on every unrelated code change).

---

## 🚀 Step 3 — Model routing: cheap heuristic, two models

Extend the structured-JSON routing idea from [`agents_and_subagents_lab.md` Lab 2](agents_and_subagents_lab.md#agent-lab2): instead of routing between *tools*, route between *models* based on how complex the request looks.

### 💻 Code

`model_router.py`:

```python
import ollama

SMALL_MODEL = "qwen2.5:1.5b"
LARGE_MODEL = "qwen3.5:9b-q4_K_M"

def is_simple(request: str) -> bool:
    """Cheap heuristic: short, single-sentence, no multi-step/reasoning language.
    This is intentionally crude — a classifier-prompt heuristic (asking a model
    to label the request first) is more accurate but costs an extra call; whether
    that tradeoff is worth it depends on how skewed your traffic is toward simple
    requests."""
    word_count = len(request.split())
    reasoning_markers = ("step by step", "compare", "why", "explain the difference", "analyze")
    return word_count < 15 and not any(marker in request.lower() for marker in reasoning_markers)

def route_and_generate(request: str) -> dict:
    model = SMALL_MODEL if is_simple(request) else LARGE_MODEL
    response = ollama.generate(model=model, prompt=request)
    return {
        "model_used": model,
        "response": response["response"],
        "response_tokens": response.get("eval_count"),
    }

if __name__ == "__main__":
    for request in [
        "What time zone is UTC?",
        "Compare exponential backoff and fixed-delay retry strategies, and explain the tradeoffs step by step.",
    ]:
        result = route_and_generate(request)
        print(f"[{result['model_used']}] {request[:50]!r} -> {result['response'][:80]!r}")
```

`ModelRouter.cs`:

```csharp
public static class ModelRouter
{
    private const string SmallModel = "qwen2.5:1.5b";
    private const string LargeModel = "qwen3.5:9b-q4_K_M";
    private static readonly string[] ReasoningMarkers =
        { "step by step", "compare", "why", "explain the difference", "analyze" };

    public static bool IsSimple(string request)
    {
        int wordCount = request.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
        var lowered = request.ToLowerInvariant();
        return wordCount < 15 && !ReasoningMarkers.Any(lowered.Contains);
    }

    public static async Task<(string ModelUsed, string Response, long? ResponseTokens)> RouteAndGenerateAsync(string request)
    {
        var model = IsSimple(request) ? SmallModel : LargeModel;
        using var doc = await OllamaClient.GenerateRawAsync(model, request);
        var root = doc.RootElement;
        return (model,
                root.GetProperty("response").GetString()!,
                root.TryGetProperty("eval_count", out var ec) ? ec.GetInt64() : null);
    }
}
```

### 👀 Expected Output

```text
[qwen2.5:1.5b] 'What time zone is UTC?' -> 'UTC stands for Coordinated Universal Time...'
[qwen3.5:9b-q4_K_M] 'Compare exponential backoff and fixed-delay retry str' -> 'Exponential backoff increases the wait time...'
```

### 🧠 What Just Happened?

The heuristic avoids paying for (or waiting on) the larger model for requests that don't need its extra capability. This is a real cost/latency lever precisely because, unlike caching, it helps on **every unique request**, not just repeats — but a crude length-based heuristic will misroute sometimes (a short request can still be conceptually hard, a long one can still be simple). Treat `is_simple` as a tunable starting point: run it through the eval-set pattern from [`ai_evaluation_guide.md`](ai_evaluation_guide.md) against a labeled set of "should route small" / "should route large" examples before trusting it in production, exactly the way routing-decision correctness is scored there for tool calls.

---

## 🧭 Batching (conceptual)

Batching — grouping many requests into one larger call, or running many independent requests concurrently against a model server that can parallelize them — reduces per-request overhead and can improve total throughput substantially for **bulk/offline** workloads: scoring a large eval set overnight, classifying a backlog of support tickets, or re-embedding an entire document corpus after a chunking-strategy change (see [RAG Lab 10](rag_embeddings_lab.md#rag-lab10)). It's much less applicable to **interactive chat**, where each request needs its own response as fast as possible and there's nothing to batch it with — a user waiting on an answer doesn't benefit from their request being grouped with someone else's. If your workload is bulk/offline, batching is usually a bigger win than either caching or routing alone; if it's interactive chat, focus on routing and caching instead.

---

## 🧭 Cost estimation: honest placeholder math, not fabricated prices

Cloud model pricing changes frequently and varies by provider, model, and region — any specific number quoted here would likely be wrong by the time you read it. Instead, here's how to compute a real estimate yourself:

1. Open your provider's **current** pricing page (e.g. the Azure OpenAI, OpenAI, or Anthropic pricing page) and find the per-1K-token (or per-1M-token) input and output rates for the model you're using.
2. Measure real token usage per request using the techniques in Step 1 (or your cloud provider's equivalent usage field, if not using Ollama).
3. Multiply.

Worked example using clearly-labeled **placeholder** rates — substitute the real numbers from your provider's pricing page before using this for a real budget:

```python
# PLACEHOLDER RATES — replace with your provider's current published pricing page numbers.
PLACEHOLDER_INPUT_RATE_PER_1K = 0.0030   # USD per 1,000 input/prompt tokens — NOT A REAL PRICE
PLACEHOLDER_OUTPUT_RATE_PER_1K = 0.0150  # USD per 1,000 output/response tokens — NOT A REAL PRICE

def estimate_cost_usd(prompt_tokens: int, response_tokens: int) -> float:
    input_cost = (prompt_tokens / 1000) * PLACEHOLDER_INPUT_RATE_PER_1K
    output_cost = (response_tokens / 1000) * PLACEHOLDER_OUTPUT_RATE_PER_1K
    return round(input_cost + output_cost, 6)

if __name__ == "__main__":
    # Example: 500 prompt tokens, 150 response tokens, using PLACEHOLDER rates above
    cost = estimate_cost_usd(prompt_tokens=500, response_tokens=150)
    print(f"Estimated cost for this call (PLACEHOLDER rates): ${cost}")
    print(f"Estimated cost for 10,000 such calls/month (PLACEHOLDER rates): ${cost * 10000:.2f}")
```

```text
Estimated cost for this call (PLACEHOLDER rates): $0.00375
Estimated cost for 10,000 such calls/month (PLACEHOLDER rates): $37.50
```

```csharp
// PLACEHOLDER RATES — replace with your provider's current published pricing page numbers.
const double PlaceholderInputRatePer1K = 0.0030;   // USD per 1,000 input/prompt tokens — NOT A REAL PRICE
const double PlaceholderOutputRatePer1K = 0.0150;  // USD per 1,000 output/response tokens — NOT A REAL PRICE

double EstimateCostUsd(long promptTokens, long responseTokens)
{
    double inputCost = (promptTokens / 1000.0) * PlaceholderInputRatePer1K;
    double outputCost = (responseTokens / 1000.0) * PlaceholderOutputRatePer1K;
    return Math.Round(inputCost + outputCost, 6);
}

var cost = EstimateCostUsd(promptTokens: 500, responseTokens: 150);
Console.WriteLine($"Estimated cost for this call (PLACEHOLDER rates): ${cost}");
Console.WriteLine($"Estimated cost for 10,000 such calls/month (PLACEHOLDER rates): ${cost * 10000:F2}");
```

The arithmetic pattern (tokens ÷ 1000 × rate, summed across input and output, multiplied by expected volume) is what's reusable here — not the `0.0030`/`0.0150` numbers, which are deliberately fictional placeholders and must be replaced with your provider's real, current published rates before this means anything financially.

---

## 🏋️ Exercise

Combine Steps 2 and 3: wrap `route_and_generate`/`RouteAndGenerateAsync` with the `PromptCache` from Step 2, keyed on `(model_used, request)` rather than a single fixed model, so a repeated simple request hits the cache against the small model specifically. Send the same simple request twice and confirm the second call is a cache hit without ever touching the large model.

## ✅ Checkpoint

- [ ] Explain why `len(text) // 4` is good enough for a cost estimate but not for enforcing a context limit
- [ ] Show a cache hit avoiding a model call entirely, with before/after timing
- [ ] Explain one concrete case where your `is_simple` heuristic would misroute, and how you'd detect that with an eval set
- [ ] Explain why batching helps a bulk overnight job but not an interactive chat UI
- [ ] Compute a cost estimate using placeholder rates and explain why the rates themselves must never be hardcoded as fact

## 🔗 Related Topics

- [`ai_evaluation_guide.md`](ai_evaluation_guide.md) — reuses the same `eval_count`/`prompt_eval_count` fields, and is where you'd validate a routing heuristic's accuracy before trusting it.
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) Lab 2 — the routing-decision pattern this guide's model routing extends from tools to models.
- [`ai_observability_tracing_guide.md`](ai_observability_tracing_guide.md) — the trace logger's `cost_estimate_usd` field is exactly where this guide's cost math plugs in.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) Lab 10 — a concrete bulk/offline scenario (re-embedding after a chunking change) where batching matters most.

## ➡️ Next

You've now covered evaluation, observability, security, and cost/performance — the four pillars beyond "it works in a demo." Revisit [`ai_journey.md`](ai_journey.md) to see how these fit into the broader learning path, or pick whichever of these four guides maps to your current feature's biggest open risk and go deeper there.
