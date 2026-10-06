# 🚀 AI Observability & Tracing: Finding Out Why It Answered Wrong

> Build a structured, inspectable trace log of every model and tool call so a wrong answer can be root-caused from the log instead of re-run-and-guess.

> [!NOTE]
> **Execution status:** reasoned through carefully against the Ollama API and standard `System.Text.Json`/`json` library behavior, but not executed against a live model in this sandbox (no local Ollama server available here). ⚠️ **Needs runtime verification** is called out inline wherever the exact shape of real output matters.

## 🎯 What You Will Build

- A reusable **structured logger** — Python writes JSON Lines to a file; C# does the same with `System.Text.Json` — capturing timestamp, step name, input, output, duration, token counts, and a cost-estimate placeholder for every model/tool call.
- A deliberately **seeded bad trace**: an agent that answers wrong, and a walkthrough of reading the log to find the exact faulty step without re-running anything.
- A conceptual table of the **metrics worth tracking in production** (latency percentiles, error rate, token usage, cost, tool-call failure rate).
- A short, honest pointer to **OpenTelemetry** as the standard for production-grade tracing, without reimplementing it here.

## 📚 Prerequisites

- [Local AI Learning Lab](local_ai_learning_lab.md#lab-build) — Ollama installed, `qwen3.5:9b-q4_K_M` pulled.
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) Lab 7 — read this first. It builds the basic in-memory trace list for a single orchestrator call (`trace.append({...})`, printed at the end). This guide takes that same idea and makes it **persistent, structured, and searchable after the fact** — across many calls, not just one.
- Comfortable with basic Python dicts/JSON and reading a `.jsonl` file.

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced

## 🛠️ Setup

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install ollama
```

```powershell
dotnet new console -o TraceLab
Set-Location TraceLab
```

`OllamaClient.cs` (same shared pattern used across every lab in this repo):

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

    public static async Task<JsonDocument> GenerateRawAsync(string prompt)
    {
        var request = new { model = "qwen3.5:9b-q4_K_M", prompt, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        return JsonDocument.Parse(await response.Content.ReadAsByteArrayAsync());
    }
}
```

---

## 🚀 Step 1 — A reusable structured trace logger

Lab 7's `trace.append({...})` list is perfect for one call, printed once. The moment you have many calls across many sessions, you need it on disk, one JSON object per line, so you can grep/filter/diff it later — the exact same JSONL pattern used for eval sets in [`ai_evaluation_guide.md`](ai_evaluation_guide.md#-step-1--build-the-eval-set).

### 💻 Code

`trace_logger.py`:

```python
import json
import time
import uuid
from pathlib import Path
from contextlib import contextmanager

class TraceLogger:
    """Appends one JSON object per logged step to a .jsonl file. Never overwrites previous runs."""

    def __init__(self, path: str = "traces.jsonl"):
        self.path = Path(path)
        self.run_id = str(uuid.uuid4())[:8]

    def _write(self, record: dict) -> None:
        record["run_id"] = self.run_id
        with self.path.open("a", encoding="utf-8") as f:
            f.write(json.dumps(record) + "\n")

    @contextmanager
    def step(self, name: str, input_data=None):
        """Usage: with logger.step('route', input_data=question) as rec: rec['output'] = ..."""
        start = time.time()
        record = {
            "timestamp": time.time(),
            "step": name,
            "input": input_data,
            "output": None,
            "duration_s": None,
            "prompt_tokens": None,
            "response_tokens": None,
            "cost_estimate_usd": None,  # see ai_cost_performance_guide.md for how to fill this in honestly
            "error": None,
        }
        try:
            yield record
        except Exception as e:
            record["error"] = str(e)
            raise
        finally:
            record["duration_s"] = round(time.time() - start, 3)
            self._write(record)
```

Using it to log an Ollama call (capturing real token counts from the response, not estimates):

```python
import ollama
from trace_logger import TraceLogger

logger = TraceLogger("traces.jsonl")

def logged_generate(prompt: str, step_name: str) -> str:
    with logger.step(step_name, input_data=prompt) as rec:
        response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
        rec["output"] = response["response"]
        rec["prompt_tokens"] = response.get("prompt_eval_count")
        rec["response_tokens"] = response.get("eval_count")
        return response["response"]
```

`TraceLogger.cs`:

```csharp
using System.Text.Json;

public class TraceRecord
{
    public double Timestamp { get; set; }
    public string Step { get; set; } = "";
    public string? Input { get; set; }
    public string? Output { get; set; }
    public double? DurationS { get; set; }
    public long? PromptTokens { get; set; }
    public long? ResponseTokens { get; set; }
    public double? CostEstimateUsd { get; set; } // see ai_cost_performance_guide.md for how to fill this in honestly
    public string? Error { get; set; }
    public string RunId { get; set; } = "";
}

public class TraceLogger
{
    private readonly string _path;
    private readonly string _runId = Guid.NewGuid().ToString()[..8];

    public TraceLogger(string path = "traces.jsonl") => _path = path;

    public async Task<T> StepAsync<T>(string name, string? input, Func<TraceRecord, Task<T>> body)
    {
        var record = new TraceRecord { Timestamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0, Step = name, Input = input, RunId = _runId };
        var start = DateTime.UtcNow;
        try
        {
            return await body(record);
        }
        catch (Exception e)
        {
            record.Error = e.Message;
            throw;
        }
        finally
        {
            record.DurationS = Math.Round((DateTime.UtcNow - start).TotalSeconds, 3);
            await File.AppendAllTextAsync(_path, JsonSerializer.Serialize(record) + "\n");
        }
    }
}
```

Using it:

```csharp
var logger = new TraceLogger("traces.jsonl");

async Task<string> LoggedGenerateAsync(string prompt, string stepName) =>
    await logger.StepAsync(stepName, prompt, async rec =>
    {
        using var doc = await OllamaClient.GenerateRawAsync(prompt);
        var root = doc.RootElement;
        rec.Output = root.GetProperty("response").GetString();
        rec.PromptTokens = root.TryGetProperty("prompt_eval_count", out var pc) ? pc.GetInt64() : null;
        rec.ResponseTokens = root.TryGetProperty("eval_count", out var ec) ? ec.GetInt64() : null;
        return rec.Output!;
    });
```

### 👀 Expected Output

One line appended to `traces.jsonl` per call, e.g.:

```json
{"timestamp": 1719859200.12, "step": "route", "input": "What's the status of order A102?", "output": "order", "duration_s": 0.84, "prompt_tokens": 22, "response_tokens": 2, "cost_estimate_usd": null, "error": null, "run_id": "a1b2c3d4"}
```

### 🧠 What Just Happened?

Every call writes a self-contained, timestamped record — including a `run_id` so you can filter one whole conversation/session's steps out of a log file that accumulates calls from many runs over time. The `error` field is populated and the record is still written even when the step raises, which matters: a failed step is exactly the thing you need in the log to debug it, not a gap in the file.

---

## 🚀 Step 2 — Diagnosing a deliberately-seeded bad trace

Reuse the orchestrator pattern from [Lab 6/7 of `agents_and_subagents_lab.md`](agents_and_subagents_lab.md#agent-lab7), but seed a bug on purpose: the routing prompt will be made ambiguous so it sometimes misroutes, and we'll find that from the log alone.

### 💻 Code

`bad_orchestrator.py`:

```python
import ollama
from trace_logger import TraceLogger

logger = TraceLogger("bad_run.jsonl")

SPECIALISTS = {
    "order": lambda q: "Order A102 shipped yesterday, arriving Thursday.",
    "policy": lambda q: "Returns are accepted within 30 days with a receipt.",
}

def orchestrator(question: str) -> str:
    # 🐛 Seeded bug: the routing prompt is ambiguous — "status" can mean order status
    # OR account status, but the prompt only offers "order"/"policy", biasing misroutes
    # toward "policy" for anything that doesn't literally say "order".
    routing_prompt = f"""Classify this as "order" or "policy": {question}
Answer with ONLY the single word."""

    with logger.step("route", input_data=question) as rec:
        response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=routing_prompt)
        route = response["response"].strip().lower()
        rec["output"] = route
        rec["prompt_tokens"] = response.get("prompt_eval_count")
        rec["response_tokens"] = response.get("eval_count")

    specialist = SPECIALISTS.get(route)
    if specialist is None:
        with logger.step("error", input_data=route) as rec:
            rec["output"] = f"unroutable: {route}"
        return "Could not route question."

    with logger.step("specialist_call", input_data=route) as rec:
        result = specialist(question)
        rec["output"] = result

    return result

if __name__ == "__main__":
    print(orchestrator("What's the status of my account verification?"))
```

👀 **Expected (wrong) output:** the question is about *account verification status*, has nothing to do with order shipping or return policy, yet the two-option routing prompt forces a choice — it will likely pick `"policy"` or `"order"` and the specialist will confidently return an irrelevant answer like the returns policy.

`inspect_trace.py` — read the log back and find the faulty step without re-running the agent:

```python
import json

def inspect(path: str) -> None:
    for line in open(path, encoding="utf-8"):
        rec = json.loads(line)
        print(f"[{rec['step']:16s}] input={str(rec['input'])[:50]!r:52s} -> output={str(rec['output'])[:50]!r}")

if __name__ == "__main__":
    inspect("bad_run.jsonl")
```

```powershell
python bad_orchestrator.py
python inspect_trace.py
```

### 👀 Expected Output

```text
[route           ] input='What\'s the status of my account verification?' -> output='policy'
[specialist_call ] input='policy'                                          -> output='Returns are accepted within 30 days with a receipt.'
```

### 🧠 What Just Happened?

Reading the trace top-to-bottom shows the final wrong answer came from the `specialist_call` step — but that step did exactly what it was told; the `route` step is where things actually went wrong, because the question never fit either of the two offered categories. Without the trace, you'd only see "the agent gave an irrelevant answer about return policy" and have to guess which of several steps caused it. With it, you can point at the exact faulty decision and its exact input: **the routing prompt's category set doesn't cover this question.** The fix is adding a third `"other"`/`"unsure"` category (or a confidence threshold) — not fiddling with the specialist, which was never the problem.

### 🏋️ Mini-exercise within this step

Fix `bad_orchestrator.py` by adding an `"unsure"` route that returns "Could not confidently route this question — can you rephrase?" instead of forcing a choice. Re-run and confirm the new trace shows the honest `"unsure"` route instead of a confident wrong one.

---

## 🧭 Metrics worth tracking in production

A single trace file is enough to debug one bad answer. A production system additionally needs **aggregates across many traces** to catch problems before a user reports them:

| Metric | Why it matters | Rough source |
|---|---|---|
| **Latency percentiles (p50/p95/p99)** | Averages hide the slow tail that frustrates real users; p99 catches rare but severe slowdowns an average would mask | `duration_s` across all trace records, bucketed by step name |
| **Error rate** | A rising error rate (bad JSON, tool exceptions, HTTP failures) is an early warning before users notice | Fraction of records with non-null `error` per time window |
| **Token usage (prompt + response)** | Directly drives both cost and context-limit risk | `prompt_tokens`/`response_tokens` fields — same ones captured in Step 1 |
| **Cost** | Token usage × your provider's current rate (never hardcode a rate — see [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md)) | Computed from token usage, not measured directly |
| **Tool-call failure rate** | A specific tool silently failing (wrong arguments, downstream API down) is often invisible in the final answer if the agent papers over it | Fraction of `specialist_call`/tool-step records with `error` set, grouped by tool name |

This is a conceptual map, not a dashboard build-out — pick the 2-3 metrics that matter most for your feature before building tooling around all five.

---

## 🧭 OpenTelemetry: the production standard

Everything above is a minimal, dependency-free version of what [OpenTelemetry](https://opentelemetry.io/) does at production scale: traces (spans with parent/child relationships across process and service boundaries), metrics (the aggregates in the table above, pre-built for percentile/rate calculations), and structured export to a backend (Jaeger, Grafana, vendor APM tools) instead of a flat JSONL file you grep by hand. If this guide's logger pattern is useful but your system has more than one process or more than one person debugging it, that's the point at which to adopt OpenTelemetry's SDKs (`opentelemetry-python`, `OpenTelemetry.NET`) rather than growing this homemade logger further — see the [official OpenTelemetry documentation](https://opentelemetry.io/docs/) for the real implementation.

---

## 🏋️ Exercise

Extend `TraceLogger` with a method that reads back a `.jsonl` file and prints a one-line summary per `run_id`: total steps, total duration, and whether any step had a non-null `error`. Run it against both `traces.jsonl` (from Step 1) and `bad_run.jsonl` (from Step 2) and confirm the bad run is visibly flagged without opening the file manually.

## ✅ Checkpoint

- [ ] Explain why writing a trace record in a `finally` block (even on error) matters
- [ ] Read a trace file and identify which step caused a wrong final answer, without re-running the code
- [ ] Name three production metrics this file's per-call trace data could aggregate into, and which field each comes from
- [ ] Explain in one sentence why OpenTelemetry exists and when you'd reach for it over this guide's logger

## 🔗 Related Topics

- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) Lab 7 — the single-call, in-memory trace this guide extends into a persistent, multi-call log.
- [`ai_evaluation_guide.md`](ai_evaluation_guide.md) — eval failures are exactly the kind of thing this guide's trace logs help you root-cause.
- [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md) — turns the `prompt_tokens`/`response_tokens` captured here into real cost estimates.
- [`ai_security_guide.md`](ai_security_guide.md) — a trace log is also where you'd notice a prompt-injection attempt succeeded, after the fact.

## ➡️ Next

Read [`ai_security_guide.md`](ai_security_guide.md) — once you can see every step an agent takes, the next question is which of those steps can be abused by untrusted input.
