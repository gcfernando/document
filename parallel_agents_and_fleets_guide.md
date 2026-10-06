# 🚀 Parallel Agents & Fleets: Running Multiple Agents at Once

> Learn when and how to dispatch independent agent work concurrently — and prove the speedup yourself, instead of taking it on faith.

## 🎯 What You Will Build

A concurrent version of the [Lab 6 orchestrator](agents_and_subagents_lab.md#agent-lab6) that runs its Order Agent and Policy Agent **at the same time** for two independent questions, with a wall-clock timer so you can empirically see the speedup over running them one after another. Along the way you'll deliberately build and then fix a race-condition bug, and learn the real, verified names vendors use for "run many agent tasks at once" — instead of guessing.

## 📚 Prerequisites

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md) — **required**. This guide extends Lab 6 (orchestrator + specialists) and Lab 5 (approval gates) directly; it does not re-explain the base agent loop, routing, or tool-calling mechanism.
- [local_ai_learning_lab.md](local_ai_learning_lab.md#lab-build) — Ollama installed and a model pulled.
- Comfortable with Python `asyncio` basics and C# `async`/`await` basics (both used below, no deep expertise required).

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced (race-condition section)

## 🛠️ Setup

Reuse the exact project/files from the agents lab:

- Python: the same folder with `tools.py` and `multi_agent.py` from [Lab 6](agents_and_subagents_lab.md#agent-lab6). Add a new file `parallel_agent.py`.
- C#: the same `AgentLab` console project and its `OllamaClient.cs`/`Tools.cs`. Add a new file `Parallel.cs`.

No new packages are required — Python's `asyncio` and the `ollama` client's async support, and C#'s `Task`/`HttpClient`, are already available from the base lab.

> [!NOTE]
> **What I verified vs. did not verify:** I directly observed, from this CLI session's own tool list, that GitHub Copilot CLI ships a `task` tool (subagents in `sync` or background mode) and a `run_dynamic_workflow` / `dynamic_workflows_manage` capability that spawns many parallel subagents under `maxConcurrentSubagents` / `maxTotalSubagents` limits — this is first-hand, not a claim from external docs. I additionally fetched this session's own `/help` output and found a documented `/fleet` command described as **"Enable fleet mode for parallel subagent execution"** — so for GitHub Copilot CLI specifically, "fleet" **is** a verified, officially-named feature (not a guess). I also fetched Anthropic's current Claude Code docs for its own, separately-named mechanisms. Anything below not backed by a successful fetch or direct observation is labeled accordingly.

---

## 🚀 Step 1 — Why and when to parallelize

Parallel dispatch only makes sense for **independent, non-overlapping** work — tasks that don't read or write the same state and whose outputs don't depend on each other's results.

| Good candidate for parallel | Why |
|---|---|
| Security review + test-coverage review + performance review of the *same* diff | Three different lenses on read-only input; none needs the others' output to start |
| "What's the status of order A100?" + "What's the return policy for electronics?" | Two unrelated questions, two unrelated specialists, no shared state |
| Fetching 5 independent API endpoints to build one report | Each fetch is read-only and self-contained |

| Bad candidate for parallel | Why |
|---|---|
| "Refund order A100" then "check if the refund succeeded" | The second step depends on the first step's result — sequential by nature |
| Two agents both editing the same file | Writes can race and corrupt or silently lose data (see Step 3) |
| A multi-step conversation where turn 2 needs turn 1's answer | Conversation state (see [agents_and_subagents_lab.md Lab 3](agents_and_subagents_lab.md#agent-lab3)) is inherently sequential |

**Rule of thumb:** parallelize *across* independent requests/specialists, never *within* a single dependent chain of reasoning.

---

## 🚀 Step 2 — Measuring the speedup: sequential vs. concurrent orchestration

This extends [Lab 6's orchestrator](agents_and_subagents_lab.md#agent-lab6) directly — same `order_agent`/`policy_agent` functions, same tools, same Ollama model. We ask **two independent questions** and time both approaches.

### 💻 Code — Python

`parallel_agent.py`:

```python
import asyncio
import time
import ollama
from tools import get_order_status, get_return_policy

async def order_agent_async(question: str) -> str:
    prompt = f"""You are the Order Agent. You have ONE tool:
get_order_status(order_id: str) -> str
Respond with ONLY: {{"order_id": "<id>"}}

Question: {question}"""
    client = ollama.AsyncClient()
    response = await client.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    import json
    args = json.loads(response["response"])
    return get_order_status(**args)

async def policy_agent_async(question: str) -> str:
    prompt = f"""You are the Policy Agent. You have ONE tool:
get_return_policy(category: str) -> str
Respond with ONLY: {{"category": "<category>"}}

Question: {question}"""
    client = ollama.AsyncClient()
    response = await client.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    import json
    args = json.loads(response["response"])
    return get_return_policy(**args)

async def run_sequential(q1: str, q2: str):
    start = time.perf_counter()
    r1 = await order_agent_async(q1)
    r2 = await policy_agent_async(q2)
    elapsed = time.perf_counter() - start
    return [r1, r2], elapsed

async def run_concurrent(q1: str, q2: str):
    start = time.perf_counter()
    r1, r2 = await asyncio.gather(
        order_agent_async(q1),
        policy_agent_async(q2),
    )
    elapsed = time.perf_counter() - start
    return [r1, r2], elapsed

async def main():
    q1 = "What's the status of order A102?"
    q2 = "Can I return clothing after 45 days?"

    results_seq, t_seq = await run_sequential(q1, q2)
    print(f"Sequential: {results_seq} in {t_seq:.2f}s")

    results_conc, t_conc = await run_concurrent(q1, q2)
    print(f"Concurrent: {results_conc} in {t_conc:.2f}s")

    print(f"Speedup: {t_seq / t_conc:.2f}x")

if __name__ == "__main__":
    asyncio.run(main())
```

```powershell
python parallel_agent.py
```

### 💻 Code — C#

`Parallel.cs`:

```csharp
using System.Diagnostics;
using System.Text.Json;

public static class ParallelDemo
{
    static async Task<string> OrderAgentAsync(string question)
    {
        var prompt = $"""
            You are the Order Agent. You have ONE tool:
            get_order_status(order_id: str) -> str
            Respond with ONLY: {{"order_id": "<id>"}}

            Question: {question}
            """;
        var raw = await OllamaClient.GenerateAsync(prompt);
        using var doc = JsonDocument.Parse(raw);
        return Tools.GetOrderStatus(doc.RootElement.GetProperty("order_id").GetString()!);
    }

    static async Task<string> PolicyAgentAsync(string question)
    {
        var prompt = $"""
            You are the Policy Agent. You have ONE tool:
            get_return_policy(category: str) -> str
            Respond with ONLY: {{"category": "<category>"}}

            Question: {question}
            """;
        var raw = await OllamaClient.GenerateAsync(prompt);
        using var doc = JsonDocument.Parse(raw);
        return Tools.GetReturnPolicy(doc.RootElement.GetProperty("category").GetString()!);
    }

    public static async Task RunAsync()
    {
        const string q1 = "What's the status of order A102?";
        const string q2 = "Can I return clothing after 45 days?";

        var sw = Stopwatch.StartNew();
        var seq1 = await OrderAgentAsync(q1);
        var seq2 = await PolicyAgentAsync(q2);
        sw.Stop();
        Console.WriteLine($"Sequential: [{seq1}, {seq2}] in {sw.Elapsed.TotalSeconds:F2}s");
        var tSeq = sw.Elapsed.TotalSeconds;

        sw.Restart();
        var task1 = OrderAgentAsync(q1);
        var task2 = PolicyAgentAsync(q2);
        await Task.WhenAll(task1, task2);
        sw.Stop();
        Console.WriteLine($"Concurrent: [{task1.Result}, {task2.Result}] in {sw.Elapsed.TotalSeconds:F2}s");

        Console.WriteLine($"Speedup: {tSeq / sw.Elapsed.TotalSeconds:F2}x");
    }
}
```

`Program.cs`:

```csharp
await ParallelDemo.RunAsync();
```

```powershell
dotnet run
```

## 👀 Expected Output

```text
Sequential: ['Delivered', '60-day return window, tags must be attached.'] in 4.1s
Concurrent: ['Delivered', '60-day return window, tags must be attached.'] in 2.2s
Speedup: 1.86x
```

⚠️ **Needs runtime verification.** Exact timings depend on your model, hardware, and whether Ollama serializes requests internally (some local Ollama configurations process one request at a time per model, which would show a smaller-than-expected speedup — if so, that itself is a useful, observable finding about your local setup's concurrency limits, not a bug in the code above). Run it and record your own numbers; the ordering (concurrent ≤ sequential) is what matters, not a specific ratio.

## 🧠 What Just Happened?

`asyncio.gather` (Python) and `Task.WhenAll` (C#) start both specialist calls **before** either finishes, instead of awaiting the first call to completion before starting the second. Wall-clock time for two independent, roughly-equal-latency calls drops toward the slower of the two (not the sum of both) — the core benefit of concurrency for I/O-bound work like waiting on a model's HTTP response.

---

## 🚀 Step 3 — Race conditions: a concrete unsafe example, and the fix

Parallel agents sharing mutable state is where real bugs happen. Here is a deliberately broken example, then the fix.

### ❌ Unsafe: two agents appending to the same in-memory list

```python
# UNSAFE — do not copy this pattern
results = []

async def worker(question, agent_fn):
    answer = await agent_fn(question)
    results.append(answer)  # two coroutines can interleave here

async def main():
    await asyncio.gather(
        worker(q1, order_agent_async),
        worker(q2, policy_agent_async),
    )
```

In pure Python `asyncio` this specific case is usually safe because `list.append` is a single bytecode-level operation and there's no OS-thread preemption — but the **pattern** is still the hazard to learn: the moment you add a *second* mutation per worker (e.g., `results.append(x); counter += 1`), or move to real multi-threading / multi-process parallelism, these are no longer atomic together, and you can lose updates or interleave partial writes.

A more universally dangerous version of the same mistake — **two agents writing to the same file**:

```python
# UNSAFE — both coroutines open, modify, and overwrite the same file
async def save_result(answer: str):
    with open("results.json", "r") as f:
        data = json.load(f)
    data.append(answer)
    with open("results.json", "w") as f:  # last writer wins — the other agent's result is silently lost
        json.dump(data, f)
```

If both agents read `results.json` before either writes it back, one agent's update is silently overwritten — a classic **read-modify-write race**.

### ✅ Fix 1 — Partition work so outputs never collide

Give each agent its own output slot (file, dict key, list index) instead of a shared mutable target:

```python
results = {}

async def worker(key, question, agent_fn):
    results[key] = await agent_fn(question)  # each worker owns a distinct key — no overlap possible

await asyncio.gather(
    worker("order", q1, order_agent_async),
    worker("policy", q2, policy_agent_async),
)
```

For the file case: write to `results_order.json` and `results_policy.json` separately, and merge them in a final, single-writer step after both finish.

### ✅ Fix 2 — Synchronize with a lock when partitioning isn't possible

```python
lock = asyncio.Lock()

async def save_result(answer: str):
    async with lock:  # only one coroutine touches the file at a time
        with open("results.json", "r") as f:
            data = json.load(f)
        data.append(answer)
        with open("results.json", "w") as f:
            json.dump(data, f)
```

C# equivalent using `SemaphoreSlim` (the idiomatic async-safe lock, since `lock` cannot wrap an `await`):

```csharp
private static readonly SemaphoreSlim FileLock = new(1, 1);

static async Task SaveResultAsync(string answer)
{
    await FileLock.WaitAsync();
    try
    {
        var data = JsonSerializer.Deserialize<List<string>>(await File.ReadAllTextAsync("results.json")) ?? new();
        data.Add(answer);
        await File.WriteAllTextAsync("results.json", JsonSerializer.Serialize(data));
    }
    finally
    {
        FileLock.Release();
    }
}
```

**Prefer Fix 1 (partition) whenever possible** — it has zero lock contention and zero chance of deadlock. Reach for Fix 2 (lock) only when the shared resource genuinely cannot be split.

## 🏋️ Exercise

Reproduce the unsafe file-race on purpose: run four coroutines concurrently, each reading, appending its own ID, and writing back to one shared `race.json` with **no lock**, and no artificial delay. Run it 5 times and count how many of the 4 IDs survive in the final file (expect it to vary — sometimes 4, sometimes fewer). Then add the `asyncio.Lock()` fix and confirm all 4 IDs survive on every run.

---

## 🚀 Step 4 — Aggregating N parallel results, including partial failure

Real orchestration needs to combine several parallel outputs into one final answer — and keep going if one sub-task fails while the others succeed.

### 💻 Code — Python

```python
async def safe_call(name: str, coro):
    try:
        return name, await coro, None
    except Exception as e:
        return name, None, str(e)

async def aggregate(question_order: str, question_policy: str, question_bad: str):
    tasks = [
        safe_call("order", order_agent_async(question_order)),
        safe_call("policy", policy_agent_async(question_policy)),
        safe_call("broken", order_agent_async(question_bad)),  # e.g. a malformed question that trips JSON parsing
    ]
    outcomes = await asyncio.gather(*tasks)

    succeeded = {name: result for name, result, err in outcomes if err is None}
    failed = {name: err for name, result, err in outcomes if err is not None}

    summary = "\n".join(f"- {k}: {v}" for k, v in succeeded.items())
    if failed:
        summary += "\n⚠️ Failed sub-tasks: " + ", ".join(f"{k} ({v})" for k, v in failed.items())
    return summary
```

### 💻 Code — C#

```csharp
static async Task<(string Name, string? Result, string? Error)> SafeCallAsync(string name, Task<string> work)
{
    try
    {
        return (name, await work, null);
    }
    catch (Exception e)
    {
        return (name, null, e.Message);
    }
}

static async Task<string> AggregateAsync(string qOrder, string qPolicy, string qBad)
{
    var outcomes = await Task.WhenAll(
        SafeCallAsync("order", OrderAgentAsync(qOrder)),
        SafeCallAsync("policy", PolicyAgentAsync(qPolicy)),
        SafeCallAsync("broken", OrderAgentAsync(qBad))
    );

    var succeeded = outcomes.Where(o => o.Error is null);
    var failed = outcomes.Where(o => o.Error is not null);

    var summary = string.Join("\n", succeeded.Select(o => $"- {o.Name}: {o.Result}"));
    if (failed.Any())
        summary += "\n⚠️ Failed sub-tasks: " + string.Join(", ", failed.Select(o => $"{o.Name} ({o.Error})"));
    return summary;
}
```

👀 **Expected output:** the two healthy specialists' answers, plus a visible `⚠️ Failed sub-tasks: broken (...)` line — the whole aggregation does not crash or silently drop the failure. This is `asyncio.gather(..., return_exceptions=False)` wrapped per-task in `safe_call` instead of raising on the first exception, so one bad sub-task never aborts the others (`Task.WhenAll` in C# similarly waits for every task and only then surfaces an `AggregateException`, which is why each call is wrapped individually here instead of relying on that default).

## 🏋️ Exercise

Change `question_bad` to something that genuinely breaks `order_agent_async`'s JSON parsing (e.g., ask a question so ambiguous the model doesn't return valid JSON) and confirm the aggregate summary still prints the two good results plus one failure line — never an unhandled stack trace from the whole program.

---

## 🚀 Step 5 — Cost and latency tradeoffs (read before you parallelize everything)

> [!WARNING]
> Parallel dispatch improves **wall-clock time only**. It does not reduce total cost — it usually increases *peak concurrent* cost, because N agents calling a model at once means N simultaneous billed calls instead of N sequential ones.

| Dimension | Sequential | Parallel (N agents) |
|---|---|---|
| Wall-clock time | Sum of all calls | ≈ the slowest single call (if truly independent) |
| Total tokens/cost | Same total | Same total (you still pay for every call) |
| Peak concurrent cost/rate-limit pressure | Low (1 call in flight) | High (N calls in flight at once) |
| Risk of hitting provider rate limits | Low | Higher — bursts of concurrent requests are what rate limits are designed to catch |
| Debuggability | Easy to reason about, one trace at a time | Harder — interleaved logs/traces need correlation IDs (see [Lab 7's trace](agents_and_subagents_lab.md#agent-lab7)) |

**Practical guidance:** parallelize when you have genuinely independent work *and* wall-clock time matters more than peak concurrency (e.g., an interactive UI waiting on 3 review agents). Don't parallelize merely to "feel faster" if it's actually the same single sequential dependent task — you'll pay the same cost with no speedup and more complexity.

---

## 🧠 Terminology: what's actually what (verified vs. not)

Be precise — these four things get conflated constantly:

| Term | What it means here | Verified? |
|---|---|---|
| **Sub-agent** | One helper call/session invoked by a parent to do a bounded piece of work and return a result (e.g., [Lab 6's `order_agent`](agents_and_subagents_lab.md#agent-lab6), or this CLI's own `task` tool for a single delegated agent) | ✅ Directly observed in this session's own tool surface |
| **Parallel sub-agents** | Several such helper calls dispatched *concurrently* for independent pieces of one task (Step 2 above; this CLI's `run_dynamic_workflow`/`dynamic_workflows_manage` with `maxConcurrentSubagents`) | ✅ Directly observed in this session's own tool surface |
| **Multi-agent system** | Persistent, distinctly-specialized agents (Order Agent, Policy Agent) that exist as a standing design, called repeatedly over time — whether or not any single call runs them in parallel | ✅ Already covered in [agents_and_subagents_lab.md Lab 6](agents_and_subagents_lab.md#agent-lab6) |
| **GitHub Copilot CLI's "fleet mode"** | This session's own `/help` output documents a `/fleet` command: *"Enable fleet mode for parallel subagent execution."* | ✅ Verified — directly fetched from this CLI's own built-in help, not inferred |
| **Claude Code's "agent teams"** | Anthropic's documented mechanism for multiple Claude Code *sessions* working together with a team lead, shared tasks, and direct inter-agent messaging — explicitly compared against (and distinct from) Claude Code's single-session "subagents" | ✅ Verified via a successful fetch of Anthropic's current `code.claude.com/docs/en/agent-teams` page |
| **Claude Code's "agent view" / background agents** | Anthropic's documented screen (`claude agents`) for dispatching and monitoring several independent Claude Code *sessions* running in parallel on your machine | ✅ Verified via a successful fetch of `code.claude.com/docs/en/agent-view` |
| **OpenAI Codex cloud "tasks"** | Codex's cloud product lets you start independent tasks against an environment and review/commit each separately | ⚠️ Partially verified — fetched `developers.openai.com/codex` docs confirming the "task" concept for cloud environments; I did **not** find a distinct, officially-branded name specifically for *running many Codex tasks concurrently* (as opposed to one at a time) in the pages I was able to fetch, so I am not asserting one exists |
| **"Fleet" as a universal/general-purpose term** | — | ❌ **Not verified as a universal term.** It is confirmed real only for GitHub Copilot CLI's own `/fleet` command. Do not assume other vendors use this word; this guide does not use "fleet" to describe Claude Code's or Codex's mechanisms, since their own docs use different names ("agent teams", "agent view", "tasks") |

## ✅ Checkpoint

- [ ] Ran Step 2 and recorded your own sequential vs. concurrent timings (not just copied the example numbers)
- [ ] Can explain, unprompted, why `asyncio.gather`/`Task.WhenAll` only helps when the work is I/O-bound and independent
- [ ] Reproduced the unsafe file race in Step 3 and fixed it with partitioning, not just a lock
- [ ] Can state, without checking this file, which term (sub-agent / parallel sub-agents / multi-agent system) describes the Lab 6 orchestrator itself vs. Step 2's concurrent run of it

## 🏋️ Exercise (capstone)

Extend Step 4's `aggregate` function to a third, genuinely independent specialist of your own design (e.g., a fake `shipping_estimate_agent`), run all three concurrently, time it against the fully-sequential version, and write one paragraph stating: (a) the measured speedup, (b) one task from this guide's "bad candidate for parallel" table that you deliberately did *not* try to parallelize, and why.

## 🔗 Related Topics

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md) — the base single-agent, routing, state, failure-handling, approval-gate, and orchestrator mechanisms this guide extends.
- [ai_memory_and_state_guide.md](ai_memory_and_state_guide.md) — state that must stay consistent even when agents run concurrently.
- [hooks_permissions_human_approval_guide.md](hooks_permissions_human_approval_guide.md) — approval gates become more important, not less, once multiple agents can act concurrently and unsupervised.

## ➡️ Next

Continue to [ai_memory_and_state_guide.md](ai_memory_and_state_guide.md) to see how agents remember things across turns and process restarts — including what changes once multiple agents might read or write that memory concurrently. Or return to the **[README](README.md)** for the full map.
