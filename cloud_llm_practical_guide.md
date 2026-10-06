# 🚀 Cloud LLM APIs: A Practical, Vendor-Honest Guide

> Call a real cloud LLM API from Python and C# — with a real credential, a real request/response shape, real error handling, and an honest cost estimate — using one verified provider as the worked example.

## 🎯 What You Will Build

- A minimal Python script and a minimal C# console app that each send one prompt to a cloud LLM over **plain HTTPS** (no SDK dependency) and print the reply.
- Credential loading from an environment variable, never a hardcoded string.
- Error handling for a bad key (401) and a rate limit (429), including a retry-with-backoff helper.
- A short streaming example (forward-referenced to the dedicated streaming guide).
- A token-usage readout and a cost estimate built from clearly labeled **placeholder** per-token rates.

## 📚 Prerequisites

- [`ai_journey.md`](ai_journey.md#local-model-call) Section 4 — you should already have made one local model call (Ollama) before adding a second, billed, networked dependency.
- An account with the chosen provider and an API key. This guide never asks you to paste that key into a file that gets committed.
- Python 3.10+ with `pip install requests`, **or** .NET 8+ for the C# samples (built-in `System.Net.Http`, no NuGet package required).

## 🏷️ Difficulty: 🟡 Intermediate

## ⚠️ Scope and verification note

This guide demonstrates **one representative provider — OpenAI's Responses API** — with field names verified on `2026-10-06` by fetching OpenAI's own current developer documentation (`developers.openai.com/api/...`, which now mirrors `platform.openai.com/docs/...`). **Other providers (Anthropic's Messages API, Azure OpenAI, Google Gemini, local-model gateways, etc.) follow a broadly similar shape — an auth header, a `model` field, a messages/input array, a JSON reply with usage counts — but their exact field names, endpoints, and error codes are NOT identical.** Don't copy this code against another vendor's endpoint and assume it will just work; go read that vendor's equivalent current API reference page the same way this guide read OpenAI's. Where a field below could not be confirmed from the fetched docs, it is marked ⚠️.

Everything here was fetched and reasoned through, not executed against a live, billed API key in this sandbox. Treat every code block as `⚠️ Needs runtime verification` against your own account until you've run it once.

## 🛠️ Setup

Never hardcode a key. Set it as an environment variable for the current shell session:

```powershell
$env:OPENAI_API_KEY = "sk-...your-real-key..."
```

For anything beyond a single disposable shell, put it in a `.env` file that is **listed in `.gitignore`** and loaded at startup (e.g. Python's `python-dotenv`, or .NET User Secrets as already shown in [`ai_journey.md`](ai_journey.md#cloud-and-python)) — never commit a `.env` file, and never paste a key into a prompt, log line, or exception message.

```gitignore
# .gitignore
.env
*.env.local
```

```powershell
pip install requests
```

---

## 🚀 Step 1 — The current recommended endpoint: Responses API

OpenAI's documentation, fetched directly, states: **"While Chat Completions remains supported, Responses is recommended for all new projects."** The older `/v1/chat/completions` endpoint (`messages` array, `choices[0].message.content`) still works and you'll see it in a lot of existing code and tutorials, but this guide teaches the currently-recommended shape so you don't start a new project on a path OpenAI itself says to migrate away from.

**Verified endpoint:** `POST https://api.openai.com/v1/responses`

**Verified required body fields:**
- `model` (string) — which model to use.
- `input` (string, **or** an array of `{role, content}` message objects) — your prompt or conversation so far.

**Verified message roles** (confirmed directly from OpenAI's Responses API reference): `"user"`, `"assistant"`, `"system"`, `"developer"`. The reference text for the `developer` role on the Chat Completions message types states: *"With o1 models and newer, `developer` messages replace the previous `system` messages."* — `system` is still accepted and documented as a valid role on Responses API message inputs; treat `developer` as the newer-model-family convention rather than a hard requirement for every model. If you're unsure which your target model expects, `system` remains documented and safe to use.

**Verified optional field:** `instructions` (string) — "gives the model high-level instructions on how it should behave... Any instructions provided this way will take priority over a prompt in the `input` parameter." This is a clean separate channel for a system prompt instead of (or in addition to) a `system`/`developer` message.

## 💻 Code — minimal request/response round trip

### Python (`plain requests`, no SDK)

```python
import os
import requests

API_KEY = os.environ.get("OPENAI_API_KEY")
if not API_KEY:
    raise RuntimeError("Set OPENAI_API_KEY before running this script.")

def ask(prompt: str, model: str = "gpt-5.5") -> dict:
    """Send one prompt to the Responses API and return the parsed JSON body."""
    response = requests.post(
        "https://api.openai.com/v1/responses",
        headers={
            "Authorization": f"Bearer {API_KEY}",
            "Content-Type": "application/json",
        },
        json={"model": model, "input": prompt},
        timeout=30,  # seconds — see Step 5 for why this matters
    )
    response.raise_for_status()
    return response.json()

if __name__ == "__main__":
    body = ask("Reply with one sentence about why retries need backoff.")
    # Verified shape: body["output"] is a list of typed items. A text reply
    # is the item with type == "message"; its text lives at
    # content[0]["text"] on that item. (The convenience `output_text`
    # field exists only in OpenAI's official SDKs, NOT in the raw HTTP
    # JSON body — since we're calling raw HTTPS, we must find the text
    # ourselves.)
    message_item = next(item for item in body["output"] if item["type"] == "message")
    print(message_item["content"][0]["text"])
```

### C# (`HttpClient`, no SDK/NuGet package)

```csharp
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;

string apiKey = Environment.GetEnvironmentVariable("OPENAI_API_KEY")
    ?? throw new InvalidOperationException("Set OPENAI_API_KEY before running this app.");

using var client = new HttpClient
{
    BaseAddress = new Uri("https://api.openai.com"),
    Timeout = TimeSpan.FromSeconds(30) // see Step 5 for why this matters
};
client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);

var request = new { model = "gpt-5.5", input = "Reply with one sentence about why retries need backoff." };

using var response = await client.PostAsJsonAsync("/v1/responses", request);
response.EnsureSuccessStatusCode();

using JsonDocument body = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());

// Verified shape: body.output is an array of typed items; find the "message" item.
foreach (JsonElement item in body.RootElement.GetProperty("output").EnumerateArray())
{
    if (item.GetProperty("type").GetString() == "message")
    {
        string text = item.GetProperty("content")[0].GetProperty("text").GetString()!;
        Console.WriteLine(text);
        break;
    }
}
```

## 👀 Expected Output

One generated sentence of text, e.g. `Retries need backoff so repeated failures don't pile up requests faster than the dependency can recover.` Exact wording varies — that's expected for a generative model.

Verified shape of the raw JSON body (confirmed from OpenAI's own migration-guide example response, field names exactly as shown, `...` marks fields present but not expanded in the fetched doc excerpt):

```json
{
  "id": "resp_68af4030592c81938ec0a5fbab4a3e9f05438e46b5f69a3b",
  "object": "response",
  "created_at": 1756315696,
  "model": "gpt-5.5",
  "output": [
    {
      "id": "msg_68af40337e58819392e935fb404414d005438e46b5f69a3b",
      "type": "message",
      "status": "completed",
      "role": "assistant",
      "content": [
        {
          "type": "output_text",
          "annotations": [],
          "logprobs": [],
          "text": "..."
        }
      ]
    }
  ]
}
```

> ⚠️ **Not fully verified this session:** the fetched example response was truncated with `...` before reaching the `usage` object. Based on the consistent pattern across OpenAI's APIs (Chat Completions uses `usage.prompt_tokens` / `usage.completion_tokens` / `usage.total_tokens`), the Responses API is widely documented elsewhere as returning `usage.input_tokens` / `usage.output_tokens` / `usage.total_tokens` — **confirm the exact key names against your own live response body** (print `body["usage"]` / `body.RootElement.GetProperty("usage")`) before relying on them in production code, since this specific field list was not visible in the successfully fetched excerpt.

## 🧠 What Just Happened?

Your process made one outbound HTTPS request carrying your prompt and your bearer token; OpenAI's servers ran the model and returned one JSON document containing a typed `output` array (not a single flat string) — the Responses API models output as **Items**, where a plain text reply is one possible item type (`"message"`) among several (tool calls, reasoning items, etc.), which is why the code above filters for `type == "message"` rather than assuming `output[0]` is always the text.

## 🚀 Step 2 — Model selection (and why no model name is a permanent fact)

The examples above use `gpt-5.5` and OpenAI's current docs also reference `gpt-6-astra` as a current example model. **Do not treat either name as a permanent fact** — providers retire and rename models continuously, and anything written down today about "the current model" goes stale. OpenAI's own prompt-engineering guidance, fetched directly, recommends: *"Pinning your production applications to specific model snapshots (like `gpt-5.5-2026-04-23` for example) to ensure consistent behavior"* and *"Building tests and evaluation suites that measure prompt behavior so you can monitor performance as you iterate, or when you change and upgrade model versions."*

**Practical rule:** before shipping anything, check the provider's current live model-list page yourself (for OpenAI: `https://platform.openai.com/docs/models`) rather than trusting any hardcoded name in a guide, including this one — and prefer a dated snapshot name over a rolling alias in anything you deploy, so a silent upstream model swap can't silently change your application's behavior.

## 🚀 Step 3 — Errors: a real documented 401 and 429, handled

Verified directly from OpenAI's fetched error-codes guide:

| Status | Example cause (verified text from docs) | What to do |
|---|---|---|
| `401` | *"Invalid Authentication... You are using a revoked API key... a different API key than the one assigned to the requesting organization or project."* | Don't retry — fix the credential. |
| `429` | *"Rate limit reached for requests... Pace your requests and follow the `Retry-After` header when it's present."* Also documented: `429 - Credit balance exhausted`, `429 - Slow down` (`rate_limit_error` / `slow_down`). | Retry with backoff, honoring `Retry-After` if present. |
| `500` | *"The server had an error while processing your request."* | Retry with backoff. |
| `503` | *"Model temporarily overloaded"* (`service_unavailable_error` / `server_is_overloaded`). *"Follow the `Retry-After` header when it's present, then retry your request."* | Retry with backoff. |

### 💻 Code — retry with exponential backoff

**Python:**

```python
import time
import random
import requests

def ask_with_retry(prompt: str, model: str = "gpt-5.5", max_attempts: int = 4) -> dict:
    for attempt in range(1, max_attempts + 1):
        response = requests.post(
            "https://api.openai.com/v1/responses",
            headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
            json={"model": model, "input": prompt},
            timeout=30,
        )
        if response.status_code == 401:
            # Never retry a bad credential — it will not fix itself.
            raise RuntimeError(f"Invalid API key (401): {response.text}")
        if response.status_code in (429, 500, 503) and attempt < max_attempts:
            retry_after = response.headers.get("Retry-After")
            delay = float(retry_after) if retry_after else (2 ** attempt) + random.uniform(0, 1)
            time.sleep(delay)
            continue
        response.raise_for_status()
        return response.json()
    raise RuntimeError("Exhausted retries")
```

**C#:**

```csharp
public static async Task<JsonDocument> AskWithRetryAsync(
    HttpClient client, string prompt, string model = "gpt-5.5", int maxAttempts = 4)
{
    for (int attempt = 1; attempt <= maxAttempts; attempt++)
    {
        var request = new { model, input = prompt };
        using var response = await client.PostAsJsonAsync("/v1/responses", request);

        if (response.StatusCode == System.Net.HttpStatusCode.Unauthorized)
        {
            // Never retry a bad credential — it will not fix itself.
            string body = await response.Content.ReadAsStringAsync();
            throw new InvalidOperationException($"Invalid API key (401): {body}");
        }

        bool retryable = response.StatusCode == System.Net.HttpStatusCode.TooManyRequests
            || (int)response.StatusCode == 500
            || (int)response.StatusCode == 503;

        if (retryable && attempt < maxAttempts)
        {
            TimeSpan delay = response.Headers.RetryAfter?.Delta
                ?? TimeSpan.FromSeconds(Math.Pow(2, attempt) + Random.Shared.NextDouble());
            await Task.Delay(delay);
            continue;
        }

        response.EnsureSuccessStatusCode();
        return JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
    }
    throw new InvalidOperationException("Exhausted retries");
}
```

> ❌ **Bad:** retrying a 401 in a loop — it will never succeed and just burns time/log noise.
> ✅ **Good:** fail fast on 401/403, back off and retry on 429/500/503, and always prefer the server's `Retry-After` header over a guessed delay.

## 🚀 Step 4 — Streaming (brief)

Set `"stream": true` on the same request body to receive output incrementally over Server-Sent Events instead of one blocked response. The full mechanics — reading SSE line-by-line in Python and C#, cancellation, and mid-stream failure handling — are covered in depth in [`prompting_structured_output_streaming_guide.md`](prompting_structured_output_streaming_guide.md#part-c--streaming); this guide only flags that the capability exists and uses the same endpoint and auth header shown above.

## 🚀 Step 5 — Timeout handling

Both samples above already set an explicit timeout (`timeout=30` in Python, `client.Timeout` in C#) rather than relying on a library default, because a hung network call to a billed external API is worse than a fast, visible failure. On timeout:

```python
try:
    body = ask("Summarize this in one sentence.")
except requests.exceptions.Timeout:
    print("Request timed out — the network call did not complete in time; do not assume it was billed or not billed.")
```

```csharp
try
{
    using var response = await client.PostAsJsonAsync("/v1/responses", request);
}
catch (TaskCanceledException) // HttpClient surfaces its own Timeout as TaskCanceledException
{
    Console.WriteLine("Request timed out — do not assume it was billed or not billed.");
}
```

## 🚀 Step 6 — Token usage and a cost-awareness estimate

> ⚠️ **PLACEHOLDER RATES — do not use these numbers for a real budget.** Real per-token prices change often and differ by model tier; this guide intentionally fabricates nothing about real current pricing. Look up the provider's current pricing page yourself before estimating a real bill.

```python
# PLACEHOLDER rates — replace with the provider's current published price
# for the exact model you called, read directly from their pricing page.
PLACEHOLDER_INPUT_RATE_PER_1K = 0.0  # <- fill in from current docs, do not trust this guide's number
PLACEHOLDER_OUTPUT_RATE_PER_1K = 0.0  # <- fill in from current docs, do not trust this guide's number

def estimate_cost(usage: dict) -> float:
    input_tokens = usage.get("input_tokens", usage.get("prompt_tokens", 0))
    output_tokens = usage.get("output_tokens", usage.get("completion_tokens", 0))
    return (
        (input_tokens / 1000) * PLACEHOLDER_INPUT_RATE_PER_1K
        + (output_tokens / 1000) * PLACEHOLDER_OUTPUT_RATE_PER_1K
    )
```

The `usage.get(...)` fallback chain above exists specifically because this guide could not verify Responses API's exact usage key names this session (Step 1) — check both key spellings against your own live response body and delete whichever branch doesn't apply once you've confirmed it.

## 🏋️ Exercise

Modify the retry helper so it logs the attempt number and computed delay before each retry, then deliberately point `API_KEY` at an empty string and confirm it fails fast on the very first attempt (401) instead of retrying — proving your fail-fast branch actually runs before your backoff branch.

## ✅ Checkpoint

You can explain, without looking back: which header carries the credential, which documented status code must never be retried, which header the server uses to tell you how long to wait, and where in the JSON body the actual reply text lives (and why it isn't simply `response.text`).

## 🔗 Related Topics

- [`ai_journey.md`](ai_journey.md#cloud-and-python) — the SDK-based version of a first cloud call, for comparison with this guide's plain-HTTP version.
- [`ai_local_vs_cloud_comparison_lab.md`](ai_local_vs_cloud_comparison_lab.md) — runs this same provider head-to-head against a local Ollama model.
- [`prompting_structured_output_streaming_guide.md`](prompting_structured_output_streaming_guide.md) — full streaming, structured output, and prompting mechanics.
- [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md) — deeper cost/caching/routing treatment beyond this guide's single placeholder estimate.
- [`ai_security_guide.md`](ai_security_guide.md) — secrets handling and not trusting model output, applied beyond just this one API call.

## ➡️ Next

Continue to [`ai_local_vs_cloud_comparison_lab.md`](ai_local_vs_cloud_comparison_lab.md) to run the exact same task against this provider and a local model side by side.
