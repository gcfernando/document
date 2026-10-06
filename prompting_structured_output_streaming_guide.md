# 🚀 Prompting, Structured Output, and Streaming

> Write prompts that reliably produce the shape of answer you need, validate that shape before trusting it, and stream the reply instead of making users stare at a spinner.

## 🎯 What You Will Build

- **Part A:** a prompt that fails zero-shot and succeeds with few-shot examples, a prompt-injection-safe delimiter pattern, a plain-English output-format constraint, and a reusable prompt template with variable substitution.
- **Part B:** a text → JSON → validated-schema → typed-object pipeline against local Ollama's real `format` parameter, in Python (`pydantic`) and C# (POCO + `System.Text.Json`), including a retry-on-invalid-JSON loop.
- **Part C:** a real streaming client in Python and C# against Ollama's actual streaming response shape, with cancellation and mid-stream failure handling.

## 📚 Prerequisites

- [`local_ai_learning_lab.md`](local_ai_learning_lab.md#lab-build) — Ollama installed, a model pulled.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — the established `http://127.0.0.1:11434` HTTP pattern used throughout this guide.
- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md) — if you want to compare the cloud provider's streaming shape against Ollama's (Part C notes the difference rather than re-deriving the cloud call).
- Python: `pip install requests pydantic`. C#: .NET 8+, no NuGet package required.

## 🏷️ Difficulty: 🟡 Intermediate

## 🛠️ Setup

```powershell
ollama pull qwen3.5:9b-q4_K_M
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install requests pydantic
```

```powershell
dotnet new console -o PromptLab
Set-Location PromptLab
```

---

# Part A — Prompting Fundamentals

## 🚀 Step 1 — Message roles

Verified directly from OpenAI's Responses API reference (fetched `2026-10-06`): accepted message `role` values are `"user"`, `"assistant"`, `"system"`, and `"developer"`, with the documentation noting *"With o1 models and newer, `developer` messages replace the previous `system` messages"* for that model family, while `system` remains a documented, valid role. Ollama's `/api/chat` endpoint uses the same three conventional roles — `system`, `user`, `assistant` — but its docs do not document a `developer` role; **don't assume `developer` works against a local Ollama model** just because it's valid for newer OpenAI models.

```python
messages = [
    {"role": "system", "content": "You are a terse code reviewer. Answer in one sentence."},
    {"role": "user", "content": "Is `except:` without a type a good idea in Python?"},
]
```

```csharp
var messages = new object[]
{
    new { role = "system", content = "You are a terse code reviewer. Answer in one sentence." },
    new { role = "user", content = "Is `except:` without a type a good idea in Python?" },
};
```

## 🚀 Step 2 — Few-shot examples: failing zero-shot, succeeding with examples

**❌ Zero-shot — ambiguous output format, model picks its own style:**

```python
import ollama

prompt_zero_shot = "Extract the city and the date from: 'We'll meet in Lisbon on the 3rd of March.'"
print(ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt_zero_shot)["response"])
# Observed-pattern risk: a full sentence like "The meeting will take place in
# Lisbon on March 3rd." — correct content, wrong, inconsistent shape for a
# program to parse reliably.
```

**✅ Few-shot — 2–3 examples pin down the exact output shape:**

```python
import ollama

prompt_few_shot = """Extract the city and date as "city | date". Examples:

Text: "Let's grab lunch in Porto next Tuesday."
Output: Porto | next Tuesday

Text: "The conference is in Berlin on June 10th."
Output: Berlin | June 10th

Text: "We'll meet in Lisbon on the 3rd of March."
Output:"""

print(ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt_few_shot)["response"])
```

👀 **Expected output:** the zero-shot version produces prose of inconsistent shape across repeated runs; the few-shot version reliably produces `Lisbon | the 3rd of March` (or very close to it) because the two worked examples establish the exact delimiter and field order, which plain instructions alone often don't pin down as reliably.

### 💜 C# equivalent

```csharp
using System.Net.Http.Json;
using System.Text.Json;

using var client = new HttpClient { BaseAddress = new Uri("http://127.0.0.1:11434") };

string fewShotPrompt = """
    Extract the city and date as "city | date". Examples:

    Text: "Let's grab lunch in Porto next Tuesday."
    Output: Porto | next Tuesday

    Text: "The conference is in Berlin on June 10th."
    Output: Berlin | June 10th

    Text: "We'll meet in Lisbon on the 3rd of March."
    Output:
    """;

var request = new { model = "qwen3.5:9b-q4_K_M", prompt = fewShotPrompt, stream = false };
using var response = await client.PostAsJsonAsync("/api/generate", request);
response.EnsureSuccessStatusCode();
using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
Console.WriteLine(doc.RootElement.GetProperty("response").GetString());
```

## 🚀 Step 3 — Delimiters for untrusted input

Never splice untrusted text (a user message, a retrieved document, a tool result) directly next to your instructions with no boundary — a classic indirect prompt-injection vector. This repo already teaches that failure mode and its mitigation mechanism-by-mechanism; see [`ai_security_guide.md`](ai_security_guide.md#-step-1--seed-an-indirect-prompt-injection-and-watch-it-try-to-work) rather than re-deriving it here. The short version reused from that guide: wrap untrusted content in clear delimiters (e.g. triple backticks or an XML-like tag) and explicitly instruct the model to treat that block as **data to analyze, not instructions to follow**.

## 🚀 Step 4 — Output-format constraints in plain prompting

Before reaching for the structured-output mechanism in Part B, a surprising number of cases just need a precise instruction:

```python
prompt = 'Respond with exactly one word — "yes" or "no": Is 17 a prime number?'
```

This works for simple, low-stakes cases. It is **not** reliable enough to parse blindly in production — a model can still occasionally add punctuation, a stray word, or explanatory text despite the instruction. Part B's schema-validated pipeline exists precisely because plain-English constraints are a starting point, not a guarantee.

## 🚀 Step 5 — Prompt templates and variable substitution

```python
TEMPLATE = "Summarize this {doc_type} in {max_sentences} sentences for a {audience} audience:\n\n{text}"

prompt = TEMPLATE.format(
    doc_type="incident report",
    max_sentences=2,
    audience="non-technical",
    text="...",
)
```

```csharp
string docType = "incident report";
int maxSentences = 2;
string audience = "non-technical";
string text = "...";

string prompt = $"Summarize this {docType} in {maxSentences} sentences for a {audience} audience:\n\n{text}";
```

> [!NOTE]
> **Prompt versioning:** treat a prompt template the same way you treat code — keep it in version control, review changes to it like a pull request, and write down *why* a wording change was made (fixing a specific observed failure, not just "felt better"). A prompt that silently drifts across commits with no history is exactly as risky as untracked production code, and just as hard to debug when quality regresses.

---

# Part B — Structured Output

## 🚀 Step 1 — Verify the mechanism before claiming it

Verified directly from Ollama's official blog post and API docs (fetched `2026-10-06`): Ollama supports a `format` request parameter on both `/api/generate` and `/api/chat`. Setting `"format": "json"` enables basic JSON mode; **passing a full JSON Schema object as `format` constrains the model's output to match that schema** — this is the mechanism used below, not a guess. Ollama's own docs explicitly recommend driving this from a Pydantic model's `model_json_schema()` output rather than hand-writing the schema.

## 💻 Code — Python (`pydantic` model + validation + retry loop)

```python
import ollama
from pydantic import BaseModel, ValidationError

class TicketTriage(BaseModel):
    severity: str   # expected: "low" | "medium" | "high"
    one_line_summary: str
    needs_escalation: bool

def triage(report: str, max_attempts: int = 3) -> TicketTriage:
    last_error = None
    for attempt in range(1, max_attempts + 1):
        response = ollama.generate(
            model="qwen3.5:9b-q4_K_M",
            prompt=f"Triage this support report:\n\n{report}",
            format=TicketTriage.model_json_schema(),  # verified Ollama mechanism
        )
        try:
            return TicketTriage.model_validate_json(response["response"])
        except ValidationError as err:
            last_error = err  # the model produced text that didn't match the schema; retry
    raise RuntimeError(f"Model never produced a valid TicketTriage after {max_attempts} attempts: {last_error}")

if __name__ == "__main__":
    result = triage("Checkout page returns a 500 error for all EU customers since this morning.")
    print(result)
```

👀 **Expected output:** `severity='high' one_line_summary='Checkout returns 500 for all EU customers' needs_escalation=True` (exact wording varies; the *shape* — three fields with the declared types — is what the schema constraint guarantees, not the exact words chosen).

## 💻 Code — C# (POCO + `System.Text.Json` + retry-on-invalid-JSON loop)

```csharp
using System.Net.Http.Json;
using System.Text.Json;
using System.Text.Json.Serialization;

public class TicketTriage
{
    [JsonPropertyName("severity")] public string Severity { get; set; } = "";
    [JsonPropertyName("one_line_summary")] public string OneLineSummary { get; set; } = "";
    [JsonPropertyName("needs_escalation")] public bool NeedsEscalation { get; set; }
}

public static class Triage
{
    // Hand-written JSON Schema matching TicketTriage — Ollama's `format`
    // parameter accepts a JSON Schema object directly, verified mechanism
    // from Ollama's own docs; C# has no `pydantic`-style auto-schema helper,
    // so the schema is written out explicitly here.
    private static readonly object Schema = new
    {
        type = "object",
        properties = new
        {
            severity = new { type = "string" },
            one_line_summary = new { type = "string" },
            needs_escalation = new { type = "boolean" },
        },
        required = new[] { "severity", "one_line_summary", "needs_escalation" },
    };

    public static async Task<TicketTriage> RunAsync(HttpClient client, string report, int maxAttempts = 3)
    {
        Exception? lastError = null;
        for (int attempt = 1; attempt <= maxAttempts; attempt++)
        {
            var request = new
            {
                model = "qwen3.5:9b-q4_K_M",
                prompt = $"Triage this support report:\n\n{report}",
                format = Schema,
                stream = false,
            };

            using var response = await client.PostAsJsonAsync("/api/generate", request);
            response.EnsureSuccessStatusCode();
            using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
            string rawJson = doc.RootElement.GetProperty("response").GetString()!;

            try
            {
                return JsonSerializer.Deserialize<TicketTriage>(rawJson)
                    ?? throw new JsonException("Deserialized to null");
            }
            catch (JsonException ex)
            {
                // Malformed/non-conforming output — retry rather than crash.
                lastError = ex;
            }
        }
        throw new InvalidOperationException(
            $"Model never produced a valid TicketTriage after {maxAttempts} attempts.", lastError);
    }
}
```

```csharp
using var client = new HttpClient { BaseAddress = new Uri("http://127.0.0.1:11434"), Timeout = TimeSpan.FromSeconds(60) };
var result = await Triage.RunAsync(client, "Checkout page returns a 500 error for all EU customers since this morning.");
Console.WriteLine($"{result.Severity} | {result.OneLineSummary} | escalate={result.NeedsEscalation}");
```

## 🧠 What Just Happened?

The schema passed to `format` constrains the model's token generation itself, not just a post-hoc check — but the retry loop still exists in both languages because "constrained to match a schema" is not the same guarantee as "contains correct information"; a model can satisfy the shape (`severity: "high"`) while still misjudging the actual severity. Schema validation catches *malformed* output; it does not catch *wrong-but-well-formed* output — that's an evaluation problem, covered in [`ai_evaluation_guide.md`](ai_evaluation_guide.md).

## 🏋️ Exercise

Add a fourth field, `affected_region: str`, to both the Python and C# schema/POCO, and confirm the retry loop still works by temporarily lowering `max_attempts`/`maxAttempts` to `1` and observing it occasionally raise its "never produced valid output" error on a harder prompt — then restore it to `3` and observe the retry recovering.

## ✅ Checkpoint

You can produce a validated, typed object from a local model's output in both languages, and you can explain why the retry loop is still necessary even with schema-constrained generation.

---

# Part C — Streaming

## 🚀 Step 1 — Why streaming improves perceived latency

A non-streamed call blocks until the **entire** reply is generated before you see anything. A streamed call shows the first token(s) almost immediately and keeps appending — the total generation time is the same or slightly worse (per-chunk overhead), but the *perceived* latency (time until the user sees something happening) drops dramatically, which matters enormously for interactive chat UIs and barely at all for a batch job.

## 🚀 Step 2 — Ollama's real streaming shape (verified)

Verified directly from Ollama's API docs (fetched `2026-10-06`): with `"stream": true` (the default if `stream` is omitted), `/api/generate` returns a sequence of **newline-delimited JSON objects (NDJSON)**, not Server-Sent Events. Each line looks like `{"model": "...", "created_at": "...", "response": "The", "done": false}`; the final line has `"done": true` plus aggregate fields (`eval_count`, `eval_duration`, etc.) and an **empty** `"response"` field.

### 💻 Code — Python (`requests`, `stream=True`, line-by-line NDJSON)

```python
import json
import requests

def stream_answer(prompt: str, stop_flag: dict):
    with requests.post(
        "http://127.0.0.1:11434/api/generate",
        json={"model": "qwen3.5:9b-q4_K_M", "prompt": prompt},  # stream defaults to true
        stream=True,
        timeout=60,
    ) as response:
        response.raise_for_status()
        for line in response.iter_lines():
            if stop_flag.get("stop"):
                print("\n[cancelled by caller]")
                break
            if not line:
                continue
            try:
                chunk = json.loads(line)
            except json.JSONDecodeError:
                print("\n[mid-stream failure: received a malformed line, stopping]")
                break
            print(chunk.get("response", ""), end="", flush=True)
            if chunk.get("done"):
                break

if __name__ == "__main__":
    stop_flag = {"stop": False}  # a real app would flip this from another thread/signal handler
    stream_answer("Explain exponential backoff in three sentences.", stop_flag)
```

### 💜 C# equivalent (`HttpClient` + `ResponseHeadersRead` + line-by-line + `CancellationToken`)

```csharp
using System.Text;
using System.Text.Json;

public static class Streamer
{
    public static async Task StreamAnswerAsync(HttpClient client, string prompt, CancellationToken cancellationToken)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/generate")
        {
            Content = new StringContent(
                JsonSerializer.Serialize(new { model = "qwen3.5:9b-q4_K_M", prompt }),
                Encoding.UTF8, "application/json")
        };

        // ResponseHeadersRead: start reading as soon as headers arrive, don't
        // buffer the whole (potentially long) streamed body first.
        using var response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead, cancellationToken);
        response.EnsureSuccessStatusCode();

        using var stream = await response.Content.ReadAsStreamAsync(cancellationToken);
        using var reader = new StreamReader(stream);

        while (!reader.EndOfStream)
        {
            cancellationToken.ThrowIfCancellationRequested();
            string? line = await reader.ReadLineAsync(cancellationToken);
            if (string.IsNullOrWhiteSpace(line)) continue;

            JsonDocument chunk;
            try
            {
                chunk = JsonDocument.Parse(line);
            }
            catch (JsonException)
            {
                Console.WriteLine("\n[mid-stream failure: received a malformed line, stopping]");
                break;
            }

            using (chunk)
            {
                Console.Write(chunk.RootElement.GetProperty("response").GetString());
                if (chunk.RootElement.TryGetProperty("done", out var done) && done.GetBoolean())
                    break;
            }
        }
    }
}
```

```csharp
using var client = new HttpClient { BaseAddress = new Uri("http://127.0.0.1:11434") };
using var cts = new CancellationTokenSource();
// cts.CancelAfter(TimeSpan.FromSeconds(5)); // example: cancel mid-stream after 5s
await Streamer.StreamAnswerAsync(client, "Explain exponential backoff in three sentences.", cts.Token);
```

## 👀 Expected Output

Text appearing incrementally in the console as the model generates it, rather than all at once after a pause. Cancelling (`stop_flag["stop"] = True` in Python from another thread, or `cts.Cancel()` in C#) stops the loop before `done: true` is ever reached — note this stops *reading further chunks on your side*; it does not necessarily stop Ollama from finishing generation server-side unless the underlying connection is actually closed, which disposing the `HttpResponseMessage`/breaking the `with` block does.

## 🚀 Step 3 — Cloud provider streaming (noted, not re-derived)

Verified from OpenAI's streaming guide (fetched `2026-10-06`): the Responses API uses **Server-Sent Events** with **typed, named events** — not Ollama's flat NDJSON. Example event names seen directly in the fetched docs: `response.output_text.delta` (carries a `delta` field with the next text chunk), `response.completed`, and `error`. This is a genuinely different wire format from Ollama's, not a cosmetic difference — code written for one will not parse the other. If you need cloud streaming, parse SSE (`data: {...}` lines, blank-line-delimited events) and switch on the event's `type` field rather than assuming every line is a plain text delta.

## 🏋️ Exercise

In the Python streaming example, add a running token/character counter that prints the total once `done` is `True`, and compare it against the non-streamed `eval_count` field from Part B's response to confirm they're counting the same underlying generation.

## ✅ Checkpoint

You can stream a local model's reply incrementally in both languages, cancel mid-stream, detect a malformed/truncated chunk without crashing, and explain why Ollama's NDJSON and a cloud SSE stream cannot share one parser.

## 🔗 Related Topics

- [`ai_security_guide.md`](ai_security_guide.md#-step-1--seed-an-indirect-prompt-injection-and-watch-it-try-to-work) — the delimiter/untrusted-input concept referenced in Part A.
- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md#-step-4--streaming-brief) — the cloud call this guide's Part C streaming note extends.
- [`ai_evaluation_guide.md`](ai_evaluation_guide.md) — measuring whether structured output is not just well-formed but *correct*.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — grounded prompting with retrieved context, a direct extension of Part A's templating.

## ➡️ Next

Continue to [`rag_project_dotnet_and_python.md`](rag_project_dotnet_and_python.md) to combine structured, grounded prompting into one full project.
