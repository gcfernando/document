# 🚀 Evaluating LLM Applications: Beyond the Demo

> Build repeatable, automated evaluation for an LLM feature so "it looked right in three tries" becomes "it scores 9/10 on a labeled set, and I can prove a prompt change made it better or worse."

> [!NOTE]
> **Execution status:** every snippet below was carefully reasoned through against the documented Ollama API and the `ollama` Python package's behavior, but this sandbox has no local Ollama server running, so nothing here was actually executed this session. Run it yourself against your own `qwen3.5:9b-q4_K_M` install before trusting exact numbers. Anything with a materially higher chance of needing a tweak on your machine is flagged inline with ⚠️ **Needs runtime verification**.

## 🎯 What You Will Build

- A small labeled **eval set** (JSONL, 10 cases) for an intent classifier ("complaint" / "question" / "spam") — a different task from the retrieval eval set in [`rag_embeddings_lab.md`](rag_embeddings_lab.md#rag-lab9), so you practice building one from scratch instead of reusing one.
- Three scoring strategies: **exact-match**, **structured-output validation** (is the JSON well-formed and schema-conformant?), and **LLM-as-judge** (with an honest look at why that pattern is shaky).
- A **regression-detection workflow**: run the eval, save scores to a timestamped file, change the prompt, re-run, and diff the two score files to see exactly what got better or worse.
- A short map of the other things a real eval suite checks — known-answer tests, groundedness/citations, tool-call correctness, latency, and token usage — each linked to where this repo already covers the mechanics, not re-derived.

## 📚 Prerequisites

- [Local AI Learning Lab](local_ai_learning_lab.md#lab-build) — Ollama installed, `qwen3.5:9b-q4_K_M` pulled, Python 3.10+.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) Lab 9 — read this first. It covers the basics of a labeled eval set and retrieval accuracy; this guide assumes that and goes further (scoring strategies, regression detection, judge models).
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) — needed for the tool-call-correctness section, which links back to Lab 2 (routing) and Lab 7 (tracing) rather than repeating them.

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced

(🔴 Advanced from the regression-detection step onward, and for the LLM-as-judge caveats.)

## 🛠️ Setup

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install ollama
```

```powershell
dotnet new console -o EvalLab
Set-Location EvalLab
```

`OllamaClient.cs` (same shared pattern as the RAG and Agents labs — create once):

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

    // Returns the full response document so callers can read "response", "eval_count", etc.
    public static async Task<JsonDocument> GenerateRawAsync(string prompt, object? format = null)
    {
        var request = new { model = "qwen3.5:9b-q4_K_M", prompt, format, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        var bytes = await response.Content.ReadAsByteArrayAsync();
        return JsonDocument.Parse(bytes);
    }
}
```

---

## 🚀 Step 1 — Build the eval set

Ten labeled cases for a 3-way intent classifier. Save as `intent_eval.jsonl` (one JSON object per line — this format is easy to diff in git and to append to):

```jsonl
{"message": "This is the third time my order has arrived broken. I want a refund.", "label": "complaint"}
{"message": "Does this plan include international shipping?", "label": "question"}
{"message": "CONGRATULATIONS!! You've WON a $1000 gift card, click here now!!!", "label": "spam"}
{"message": "Your support agent hung up on me twice. Completely unacceptable service.", "label": "complaint"}
{"message": "How do I reset my password?", "label": "question"}
{"message": "Make $5000/week from home, no experience needed, limited slots!!!", "label": "spam"}
{"message": "What time does the warehouse close on weekends?", "label": "question"}
{"message": "I've emailed three times about my missing package and nobody has replied.", "label": "complaint"}
{"message": "Claim your free iPhone now - offer expires in 10 minutes, act fast!", "label": "spam"}
{"message": "Can I change my delivery address after placing an order?", "label": "question"}
```

### 💻 Code

`load_eval.py`:

```python
import json
from pathlib import Path

def load_eval_set(path: str) -> list[dict]:
    cases = []
    for line in Path(path).read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line:
            cases.append(json.loads(line))
    return cases

if __name__ == "__main__":
    cases = load_eval_set("intent_eval.jsonl")
    print(f"Loaded {len(cases)} cases")
    print(cases[0])
```

`EvalCase.cs`:

```csharp
using System.Text.Json;

public record EvalCase(string Message, string Label);

public static class EvalLoader
{
    public static List<EvalCase> Load(string path)
    {
        var cases = new List<EvalCase>();
        foreach (var line in File.ReadAllLines(path))
        {
            if (string.IsNullOrWhiteSpace(line)) continue;
            var doc = JsonDocument.Parse(line);
            cases.Add(new EvalCase(
                doc.RootElement.GetProperty("message").GetString()!,
                doc.RootElement.GetProperty("label").GetString()!));
        }
        return cases;
    }
}
```

### 👀 Expected Output

```text
Loaded 10 cases
{'message': "This is the third time my order has arrived broken. I want a refund.", 'label': 'complaint'}
```

### 🧠 What Just Happened?

A labeled eval set is just data — the value is that it's small, version-controlled, and reusable across every scoring method below. Ten cases is enough to catch an obviously broken prompt; it is not enough to catch subtle regressions (see [`rag_embeddings_lab.md`](rag_embeddings_lab.md#rag-lab9) for the same honest caveat about eval-set size).

---

## 🚀 Step 2 — Exact-match scoring

The simplest scorer: ask the model for exactly one label word, compare it to the expected label.

### 💻 Code

`exact_match.py`:

```python
import ollama
from load_eval import load_eval_set

def classify(message: str) -> str:
    prompt = f"""Classify this customer message as exactly one word: "complaint", "question", or "spam".
Message: {message}
Answer with ONLY the single word."""
    response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    return response["response"].strip().lower().strip(".")

def run_exact_match(path: str) -> list[dict]:
    results = []
    for case in load_eval_set(path):
        predicted = classify(case["message"])
        correct = predicted == case["label"]
        results.append({"message": case["message"], "expected": case["label"], "predicted": predicted, "correct": correct})
    return results

if __name__ == "__main__":
    results = run_exact_match("intent_eval.jsonl")
    correct = sum(r["correct"] for r in results)
    for r in results:
        mark = "✅" if r["correct"] else "❌"
        print(f"{mark} expected={r['expected']:10s} got={r['predicted']:10s} | {r['message'][:50]}")
    print(f"\nAccuracy: {correct}/{len(results)}")
```

`ExactMatch.cs`:

```csharp
public record ScoredCase(string Message, string Expected, string Predicted, bool Correct);

public static class ExactMatch
{
    public static async Task<string> ClassifyAsync(string message)
    {
        var prompt = $"""
            Classify this customer message as exactly one word: "complaint", "question", or "spam".
            Message: {message}
            Answer with ONLY the single word.
            """;
        using var doc = await OllamaClient.GenerateRawAsync(prompt);
        return doc.RootElement.GetProperty("response").GetString()!.Trim().ToLowerInvariant().TrimEnd('.');
    }

    public static async Task<List<ScoredCase>> RunAsync(string path)
    {
        var results = new List<ScoredCase>();
        foreach (var c in EvalLoader.Load(path))
        {
            var predicted = await ClassifyAsync(c.Message);
            results.Add(new ScoredCase(c.Message, c.Label, predicted, predicted == c.Label));
        }
        return results;
    }
}
```

`Program.cs`:

```csharp
var results = await ExactMatch.RunAsync("intent_eval.jsonl");
int correct = results.Count(r => r.Correct);
foreach (var r in results)
    Console.WriteLine($"{(r.Correct ? "✅" : "❌")} expected={r.Expected,-10} got={r.Predicted,-10} | {r.Message[..Math.Min(50, r.Message.Length)]}");
Console.WriteLine($"\nAccuracy: {correct}/{results.Count}");
```

### 👀 Expected Output

```text
✅ expected=complaint got=complaint | This is the third time my order has arrived brok
✅ expected=question  got=question  | Does this plan include international shipping?
✅ expected=spam      got=spam      | CONGRATULATIONS!! You've WON a $1000 gift card, c
...
Accuracy: 9/10
```

⚠️ **Needs runtime verification** — exact wording the model returns (e.g. whether it adds punctuation or a trailing explanation despite the instruction) varies by model and prompt phrasing; the `.strip().lower().strip(".")` normalization above is a reasonable starting point, not a guarantee. Expect 1-2 cases to need prompt tweaks on first run.

### 🧠 What Just Happened?

Exact-match is cheap and deterministic to grade, but it only works when the task has one unambiguous correct string. It breaks down the moment "correct" means "a reasonable paraphrase" rather than "this exact token" — that's what the next two scoring methods are for.

---

## 🚀 Step 3 — Structured-output validation scoring

Instead of a single word, ask for a JSON object and score whether it is **valid JSON that matches a schema** — a different, often more useful, question than "is the content correct."

Ollama's `/api/generate` accepts a `format` field that can be a JSON Schema, and the server then constrains generation to match it (confirmed in Ollama's official API docs). This is a stronger guarantee than JSON-mode (`format: "json"`) alone, which only guarantees *some* valid JSON, not a particular shape.

### 💻 Code

`structured_eval.py`:

```python
import json
import ollama
from load_eval import load_eval_set

SCHEMA = {
    "type": "object",
    "properties": {
        "label": {"type": "string", "enum": ["complaint", "question", "spam"]},
        "confidence": {"type": "number"},
    },
    "required": ["label", "confidence"],
}

def classify_structured(message: str) -> dict:
    prompt = f"""Classify this customer message. Message: {message}"""
    response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt, format=SCHEMA)
    return json.loads(response["response"])

def validate_schema(obj: dict) -> tuple[bool, str]:
    """Minimal hand-rolled validator — no extra dependency needed for this small schema."""
    if not isinstance(obj, dict):
        return False, "not a JSON object"
    if "label" not in obj or obj["label"] not in ("complaint", "question", "spam"):
        return False, f"invalid or missing 'label': {obj.get('label')!r}"
    if "confidence" not in obj or not isinstance(obj["confidence"], (int, float)):
        return False, f"invalid or missing 'confidence': {obj.get('confidence')!r}"
    return True, "ok"

def run_structured_eval(path: str) -> list[dict]:
    results = []
    for case in load_eval_set(path):
        try:
            parsed = classify_structured(case["message"])
            valid, reason = validate_schema(parsed)
            label_correct = valid and parsed["label"] == case["label"]
        except json.JSONDecodeError as e:
            parsed, valid, reason, label_correct = None, False, f"not valid JSON: {e}", False
        results.append({"message": case["message"], "schema_valid": valid, "reason": reason, "label_correct": label_correct})
    return results

if __name__ == "__main__":
    results = run_structured_eval("intent_eval.jsonl")
    schema_ok = sum(r["schema_valid"] for r in results)
    label_ok = sum(r["label_correct"] for r in results)
    print(f"Schema-valid: {schema_ok}/{len(results)}   Label-correct (and schema-valid): {label_ok}/{len(results)}")
```

`StructuredEval.cs`:

```csharp
using System.Text.Json;

public static class StructuredEval
{
    private static readonly object Schema = new
    {
        type = "object",
        properties = new
        {
            label = new { type = "string", @enum = new[] { "complaint", "question", "spam" } },
            confidence = new { type = "number" },
        },
        required = new[] { "label", "confidence" },
    };

    public static async Task<JsonDocument> ClassifyStructuredAsync(string message)
    {
        var prompt = $"Classify this customer message. Message: {message}";
        using var doc = await OllamaClient.GenerateRawAsync(prompt, Schema);
        var raw = doc.RootElement.GetProperty("response").GetString()!;
        return JsonDocument.Parse(raw); // throws JsonException if not valid JSON
    }

    public static (bool Valid, string Reason) ValidateSchema(JsonElement obj)
    {
        if (obj.ValueKind != JsonValueKind.Object) return (false, "not a JSON object");
        if (!obj.TryGetProperty("label", out var labelProp) ||
            !new[] { "complaint", "question", "spam" }.Contains(labelProp.GetString()))
            return (false, "invalid or missing 'label'");
        if (!obj.TryGetProperty("confidence", out var confProp) ||
            (confProp.ValueKind != JsonValueKind.Number))
            return (false, "invalid or missing 'confidence'");
        return (true, "ok");
    }
}
```

### 👀 Expected Output

```text
Schema-valid: 10/10   Label-correct (and schema-valid): 9/10
```

⚠️ **Needs runtime verification** — the `format` JSON-Schema constraint is Ollama's enforcement, so schema-valid should be close to 10/10 by design; `confidence` being a sensible number (not e.g. always `1.0`) still needs eyeballing.

### 🧠 What Just Happened?

This separates two failure modes that exact-match conflates: "the model answered in the wrong shape" (schema invalid — a parsing/integration bug) versus "the model answered in the right shape but got the content wrong" (label incorrect — a reasoning/prompt problem). Production systems that parse model output into code (tool calls, API payloads, database rows) should score both, because a schema-valid-but-wrong answer fails differently from a code-crashing malformed one.

---

## 🚀 Step 4 — LLM-as-judge (and why to distrust it a little)

Some outputs have no single correct string to match — e.g. "write a one-sentence apology for the complaint above." A common pattern is to have a second prompt grade the first model's answer against a rubric.

### 💻 Code

`llm_judge.py`:

```python
import ollama

def generate_apology(complaint: str) -> str:
    prompt = f"Write a one-sentence, professional apology in response to this complaint:\n{complaint}"
    return ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)["response"].strip()

def judge_apology(complaint: str, apology: str) -> dict:
    rubric = """Grade the APOLOGY below on a 1-5 scale against this rubric:
- 5: Acknowledges the specific issue, apologizes sincerely, offers a next step
- 3: Generic apology, doesn't reference the specific issue
- 1: Dismissive, defensive, or irrelevant

COMPLAINT: {complaint}
APOLOGY: {apology}

Respond as JSON: {{"score": <1-5>, "reason": "<one sentence>"}}"""
    schema = {"type": "object", "properties": {"score": {"type": "integer"}, "reason": {"type": "string"}},
              "required": ["score", "reason"]}
    response = ollama.generate(model="qwen3.5:9b-q4_K_M",
                                prompt=rubric.format(complaint=complaint, apology=apology),
                                format=schema)
    import json
    return json.loads(response["response"])

if __name__ == "__main__":
    complaint = "This is the third time my order has arrived broken. I want a refund."
    apology = generate_apology(complaint)
    verdict = judge_apology(complaint, apology)
    print("Apology:", apology)
    print("Judge verdict:", verdict)
```

`LlmJudge.cs`:

```csharp
using System.Text.Json;

public static class LlmJudge
{
    public static async Task<string> GenerateApologyAsync(string complaint)
    {
        var prompt = $"Write a one-sentence, professional apology in response to this complaint:\n{complaint}";
        using var doc = await OllamaClient.GenerateRawAsync(prompt);
        return doc.RootElement.GetProperty("response").GetString()!.Trim();
    }

    public static async Task<JsonDocument> JudgeApologyAsync(string complaint, string apology)
    {
        var schema = new
        {
            type = "object",
            properties = new { score = new { type = "integer" }, reason = new { type = "string" } },
            required = new[] { "score", "reason" },
        };
        var rubric = $"""
            Grade the APOLOGY below on a 1-5 scale against this rubric:
            - 5: Acknowledges the specific issue, apologizes sincerely, offers a next step
            - 3: Generic apology, doesn't reference the specific issue
            - 1: Dismissive, defensive, or irrelevant

            COMPLAINT: {complaint}
            APOLOGY: {apology}

            Respond as JSON: {{"score": <1-5>, "reason": "<one sentence>"}}
            """;
        using var doc = await OllamaClient.GenerateRawAsync(rubric, schema);
        return JsonDocument.Parse(doc.RootElement.GetProperty("response").GetString()!);
    }
}
```

### 👀 Expected Output

```text
Apology: We're truly sorry your order arrived broken again, and we're issuing a full refund right away.
Judge verdict: {'score': 5, 'reason': 'Acknowledges the repeated issue and offers a concrete next step.'}
```

### 🧠 What Just Happened?

> [!WARNING]
> **LLM-as-judge is a convenience, not ground truth.** Known failure modes: judges tend to favor longer answers regardless of quality, favor answers written in a style similar to their own, can be inconsistent across runs (ask it to re-grade the same pair and you may get a different score), and can be fooled by confident-sounding but wrong apologies. Treat judge scores as a cheap first filter for catching obvious regressions at scale, and keep a small set of **human-graded** cases as the real ground truth you periodically check the judge against. Never ship a feature's go/no-go decision on judge score alone for anything high-stakes.

---

## 🚀 Step 5 — Regression detection: did this prompt change help or hurt?

The real value of an eval set is catching regressions automatically instead of noticing them in production. Save scores with a timestamp, change the prompt, re-run, and diff.

### 💻 Code

`run_eval.py` (saves a timestamped score file every run):

```python
import json
import time
from pathlib import Path
from exact_match import run_exact_match

def save_scores(results: list[dict], out_dir: str = "eval_results") -> str:
    Path(out_dir).mkdir(exist_ok=True)
    filename = f"{out_dir}/scores_{int(time.time())}.json"
    summary = {
        "timestamp": int(time.time()),
        "accuracy": sum(r["correct"] for r in results) / len(results),
        "cases": {r["message"]: r["correct"] for r in results},
    }
    Path(filename).write_text(json.dumps(summary, indent=2), encoding="utf-8")
    return filename

if __name__ == "__main__":
    results = run_exact_match("intent_eval.jsonl")
    path = save_scores(results)
    print(f"Saved: {path}  (accuracy={sum(r['correct'] for r in results)}/{len(results)})")
```

`diff_scores.py` (compare any two score files, in order):

```python
import json
import sys

def diff_scores(before_path: str, after_path: str) -> None:
    before = json.loads(open(before_path, encoding="utf-8").read())
    after = json.loads(open(after_path, encoding="utf-8").read())

    print(f"Accuracy: {before['accuracy']:.0%} -> {after['accuracy']:.0%}")
    all_messages = set(before["cases"]) | set(after["cases"])
    for msg in sorted(all_messages):
        b = before["cases"].get(msg)
        a = after["cases"].get(msg)
        if b == a:
            continue
        arrow = "✅ fixed" if (b is False and a is True) else "❌ REGRESSED" if (b is True and a is False) else "new case"
        print(f"{arrow}: {msg[:60]}")

if __name__ == "__main__":
    diff_scores(sys.argv[1], sys.argv[2])
```

```powershell
python run_eval.py            # before the prompt change -> eval_results/scores_<ts1>.json
# ... edit the classification prompt in exact_match.py ...
python run_eval.py            # after the prompt change -> eval_results/scores_<ts2>.json
python diff_scores.py eval_results/scores_<ts1>.json eval_results/scores_<ts2>.json
```

`RegressionDiff.cs` (same idea, C#):

```csharp
using System.Text.Json;

public static class RegressionDiff
{
    public static void SaveScores(List<ScoredCase> results, string outDir = "eval_results")
    {
        Directory.CreateDirectory(outDir);
        var timestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
        var summary = new
        {
            timestamp,
            accuracy = (double)results.Count(r => r.Correct) / results.Count,
            cases = results.ToDictionary(r => r.Message, r => r.Correct),
        };
        File.WriteAllText(Path.Combine(outDir, $"scores_{timestamp}.json"),
            JsonSerializer.Serialize(summary, new JsonSerializerOptions { WriteIndented = true }));
    }

    public static void Diff(string beforePath, string afterPath)
    {
        using var before = JsonDocument.Parse(File.ReadAllText(beforePath));
        using var after = JsonDocument.Parse(File.ReadAllText(afterPath));
        Console.WriteLine($"Accuracy: {before.RootElement.GetProperty("accuracy").GetDouble():P0} -> " +
                           $"{after.RootElement.GetProperty("accuracy").GetDouble():P0}");

        var beforeCases = before.RootElement.GetProperty("cases");
        var afterCases = after.RootElement.GetProperty("cases");
        var allKeys = beforeCases.EnumerateObject().Select(p => p.Name)
            .Union(afterCases.EnumerateObject().Select(p => p.Name));

        foreach (var key in allKeys.OrderBy(k => k))
        {
            bool? b = beforeCases.TryGetProperty(key, out var bv) ? bv.GetBoolean() : null;
            bool? a = afterCases.TryGetProperty(key, out var av) ? av.GetBoolean() : null;
            if (b == a) continue;
            var arrow = (b == false && a == true) ? "✅ fixed" : (b == true && a == false) ? "❌ REGRESSED" : "new case";
            Console.WriteLine($"{arrow}: {key[..Math.Min(60, key.Length)]}");
        }
    }
}
```

### 👀 Expected Output

```text
Accuracy: 90% -> 80%
❌ REGRESSED: Can I change my delivery address after placing an order?
```

### 🧠 What Just Happened?

This is the entire point of having an eval set: a prompt change that "feels like an improvement" (clearer wording, shorter instructions) is only actually an improvement if the score file proves it. Keep every `eval_results/*.json` file — committed to git alongside the prompt change that produced it — so a regression months later can be traced back to the exact commit that caused it.

---

## 🧭 The rest of the map: what else a real eval suite checks

These are real, important eval categories — covered here by pointer, not re-derived, because this repo already builds the underlying mechanism elsewhere:

| Category | What it checks | Where it's already covered |
|---|---|---|
| **Known-answer tests** | Does the model get a small set of facts right every time? | The `EvalCase`/`EVAL_SET` pattern in this guide and in [RAG Lab 9](rag_embeddings_lab.md#rag-lab9) *is* a known-answer test — just applied to a different task here. |
| **Groundedness / citation correctness** | Does a cited source actually support the claim? | [RAG Lab 8 — Add citations](rag_embeddings_lab.md#rag-lab8) and [RAG Lab 9](rag_embeddings_lab.md#rag-lab9)'s note on extending `EVAL_SET` with expected-answer substrings. Don't re-derive it — extend it. |
| **Tool-call correctness** | Did the agent call the *right* tool with the *right* arguments? | [`agents_and_subagents_lab.md` Lab 2](agents_and_subagents_lab.md#agent-lab2) defines the `{"tool": ..., "args": ...}` routing decision; scoring it is comparing that parsed decision dict to an expected one per eval case (same exact-match idea as Step 2 above, applied to a dict instead of a string). [Lab 7's trace](agents_and_subagents_lab.md#agent-lab7) is what you inspect when a tool-call eval case fails, to see *why* the wrong tool was picked. |
| **Latency and token usage** | How slow and how expensive is each call? | See Step 6 below — captured directly from the Ollama response. |

---

## 🚀 Step 6 — Measuring latency and token usage

Ollama's `/api/generate` response includes real measurement fields (confirmed against Ollama's official API documentation, not guessed): `total_duration`, `load_duration`, `prompt_eval_count`, `prompt_eval_duration`, `eval_count`, `eval_duration` — **all durations in nanoseconds**, and `eval_count` is the number of tokens generated in the response. Tokens/second is `eval_count / (eval_duration / 1e9)`.

### 💻 Code

`latency_and_tokens.py`:

```python
import ollama
import time

def timed_generate(prompt: str) -> dict:
    wall_start = time.time()
    response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    wall_elapsed = time.time() - wall_start

    eval_count = response.get("eval_count", 0)
    eval_duration_s = response.get("eval_duration", 0) / 1e9
    tokens_per_s = eval_count / eval_duration_s if eval_duration_s > 0 else 0

    return {
        "wall_clock_s": round(wall_elapsed, 2),
        "prompt_tokens": response.get("prompt_eval_count"),
        "response_tokens": eval_count,
        "tokens_per_second": round(tokens_per_s, 1),
        "total_duration_s": round(response.get("total_duration", 0) / 1e9, 2),
    }

if __name__ == "__main__":
    stats = timed_generate("Explain exponential backoff in one sentence.")
    print(stats)
```

`LatencyAndTokens.cs`:

```csharp
public static class LatencyAndTokens
{
    public static async Task<Dictionary<string, object>> TimedGenerateAsync(string prompt)
    {
        var sw = System.Diagnostics.Stopwatch.StartNew();
        using var doc = await OllamaClient.GenerateRawAsync(prompt);
        sw.Stop();

        var root = doc.RootElement;
        long evalCount = root.TryGetProperty("eval_count", out var ec) ? ec.GetInt64() : 0;
        long evalDurationNs = root.TryGetProperty("eval_duration", out var ed) ? ed.GetInt64() : 0;
        double tokensPerSecond = evalDurationNs > 0 ? evalCount / (evalDurationNs / 1e9) : 0;

        return new Dictionary<string, object>
        {
            ["wall_clock_s"] = Math.Round(sw.Elapsed.TotalSeconds, 2),
            ["prompt_tokens"] = root.TryGetProperty("prompt_eval_count", out var pc) ? pc.GetInt64() : 0,
            ["response_tokens"] = evalCount,
            ["tokens_per_second"] = Math.Round(tokensPerSecond, 1),
            ["total_duration_s"] = Math.Round((root.TryGetProperty("total_duration", out var td) ? td.GetInt64() : 0) / 1e9, 2),
        };
    }
}
```

### 👀 Expected Output

```text
{'wall_clock_s': 1.84, 'prompt_tokens': 14, 'response_tokens': 27, 'tokens_per_second': 18.2, 'total_duration_s': 1.82}
```

⚠️ **Needs runtime verification** — actual values depend entirely on your hardware (CPU vs. GPU, VRAM) and the specific model/quantization loaded; treat the sample numbers above as illustrative shape, not a performance target.

### 🧠 What Just Happened?

`wall_clock_s` (measured client-side) and `total_duration_s` (reported by Ollama) should be close but not identical — the gap is HTTP/serialization overhead. `eval_count`/`eval_duration` isolate *generation* time from *prompt processing* time (`prompt_eval_duration`), which matters when you're deciding whether a slow response is caused by a long prompt (e.g. too much RAG context — see [RAG Lab 10](rag_embeddings_lab.md#rag-lab10) on chunk-size tradeoffs) or by the model generating a long answer.

---

## 🏋️ Exercise

Add two harder cases to `intent_eval.jsonl` — one message that's genuinely ambiguous between "complaint" and "question" (e.g. "Why does my order keep arriving late?"), and one spam message disguised as a legitimate question. Run `exact_match.py`, confirm at least one scores ❌, then try rewording the classification prompt (not the eval cases) until both pass — and re-run the regression diff from Step 5 to prove the change was a net improvement, not just a fix for those two cases at the expense of the other eight.

## ✅ Checkpoint

- [ ] Explain the difference between exact-match, schema-validation, and LLM-as-judge scoring, and when each is appropriate
- [ ] State two concrete reasons an LLM judge's score shouldn't be trusted blindly
- [ ] Produce two score files and a diff showing one case that regressed and one that improved
- [ ] Explain what `eval_count` and `eval_duration` measure and compute tokens/second from them by hand

## 🔗 Related Topics

- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — Lab 8 (citations) and Lab 9 (retrieval evaluation), which this guide extends rather than repeats.
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) — Lab 2 (routing decisions to score for tool-call correctness) and Lab 7 (tracing, for debugging *why* an eval case failed).
- [`ai_observability_tracing_guide.md`](ai_observability_tracing_guide.md) — once an eval case fails, this is how you log enough detail to diagnose why without re-running it interactively.
- [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md) — token-usage measurement here feeds directly into cost estimation there.

## ➡️ Next

Read [`ai_observability_tracing_guide.md`](ai_observability_tracing_guide.md) to learn how to log every model/tool call in production so a failing eval case (or a real user complaint) can be root-caused from a trace instead of guessed at.
