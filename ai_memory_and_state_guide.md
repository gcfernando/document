# 🧠 AI Memory & State: From Stateless Calls to Persistent, Searchable Memory

> Learn the real differences between conversation history, session state, persisted memory, and vector-based long-term memory — by running all four, locally, and watching each one fail where the next one succeeds.

## 🎯 What You Will Build

Four small, runnable experiments that build on each other: a stateless agent that forgets everything, an in-memory session store that remembers within one run, a JSON-file-backed memory that survives a process restart, and a semantic/vector memory that retrieves the *relevant* past fact instead of replaying the whole conversation.

## 📚 Prerequisites

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md#agent-lab3) — Lab 3 already covers in-conversation history (`self.history`); this guide starts from that lab's stateless failure mode and goes further (session state, persisted memory, vector memory), so skim Lab 3 first rather than skipping straight here.
- [rag_embeddings_lab.md](rag_embeddings_lab.md#rag-lab3) — Experiment 4 below reuses that lab's embedding and cosine-similarity code directly instead of re-deriving it.
- [local_ai_learning_lab.md](local_ai_learning_lab.md#lab-build) — Ollama installed and a model pulled.

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced (Experiment 4)

## 🛠️ Setup

A new folder, `MemoryLab/`, separate from the agents and RAG labs (though Experiment 4 imports the RAG lab's embedding function by reference/pattern, not by file-sharing):

```powershell
mkdir MemoryLab
cd MemoryLab
```

Python: no new packages beyond `ollama` (already installed from the earlier labs) and the standard library (`json`, `sqlite3`, `pathlib`).
C#: a new console project, same `OllamaClient.cs` pattern as the other labs:

```powershell
dotnet new console -o MemoryLab
```

---

## 🚀 Experiment 1 — Stateless calls (the failure mode)

This is the same two-question exchange as [agents_and_subagents_lab.md Lab 3](agents_and_subagents_lab.md#agent-lab3), but deliberately **without** history, to make the failure concrete before fixing it. Kept short on purpose — see Lab 3 for the "with history" fix and the full explanation of why it works.

`exp1_stateless.py`:

```python
import ollama

def ask_stateless(question: str) -> str:
    response = ollama.chat(model="qwen3.5:9b-q4_K_M", messages=[
        {"role": "user", "content": question},  # a brand-new message list every call — no memory of prior turns
    ])
    return response["message"]["content"]

if __name__ == "__main__":
    print(ask_stateless("My favorite order category is electronics."))
    print(ask_stateless("What's my favorite order category?"))
```

```powershell
python exp1_stateless.py
```

## 👀 Expected Output

```text
Got it — I'll keep that in mind! (electronics is a popular category...)
I don't have any information about your favorite order category — could you tell me?
```

## 🧠 What Just Happened?

Every call builds a fresh `messages` list with only the current question — the model has no access to the first turn when answering the second. This is the exact mechanism [Lab 3](agents_and_subagents_lab.md#agent-lab3) fixes with a persistent `self.history` list; go there for the working version and the C# equivalent. The rest of this guide assumes you understand that fix and extends past it.

---

## 🚀 Experiment 2 — Session state (survives the run, not the process)

A conversation history is one specific kind of state (the literal turn-by-turn transcript). **Session state** is broader: arbitrary key-value facts the application chooses to remember *about* the conversation, separate from the raw message log — e.g., "the user's preferred order category" extracted once and reused many turns later without resending the whole transcript.

### 💻 Code — Python

`exp2_session_state.py`:

```python
import ollama

class SessionStore:
    """Plain in-memory dict — gone the instant the process exits."""
    def __init__(self):
        self._facts: dict[str, str] = {}

    def remember(self, key: str, value: str) -> None:
        self._facts[key] = value

    def recall(self, key: str) -> str | None:
        return self._facts.get(key)

session = SessionStore()

def ask_with_session(question: str) -> str:
    # A tiny, deliberately simple extraction rule — a real system would use
    # the model itself or a proper NLU step to decide what to remember.
    if "favorite order category is" in question.lower():
        category = question.lower().split("favorite order category is")[-1].strip().rstrip(".")
        session.remember("preferred_category", category)

    context = ""
    remembered = session.recall("preferred_category")
    if remembered:
        context = f"(Known fact: the user's preferred order category is {remembered}.) "

    response = ollama.chat(model="qwen3.5:9b-q4_K_M", messages=[
        {"role": "user", "content": context + question},
    ])
    return response["message"]["content"]

if __name__ == "__main__":
    print(ask_with_session("My favorite order category is electronics."))
    print(ask_with_session("What's my favorite order category?"))
```

```powershell
python exp2_session_state.py
```

### 💻 Code — C#

`SessionState.cs`:

```csharp
public class SessionStore
{
    private readonly Dictionary<string, string> _facts = new(); // in-memory only — lost on process exit

    public void Remember(string key, string value) => _facts[key] = value;
    public string? Recall(string key) => _facts.GetValueOrDefault(key);
}

public static class Exp2
{
    private static readonly SessionStore Session = new();

    public static async Task<string> AskWithSessionAsync(string question)
    {
        if (question.ToLowerInvariant().Contains("favorite order category is"))
        {
            var category = question.ToLowerInvariant()
                .Split("favorite order category is")[^1].Trim().TrimEnd('.');
            Session.Remember("preferred_category", category);
        }

        var remembered = Session.Recall("preferred_category");
        var context = remembered is not null
            ? $"(Known fact: the user's preferred order category is {remembered}.) "
            : "";

        return await OllamaClient.ChatAsync(new List<ChatMessage> { new("user", context + question) });
    }
}
```

`Program.cs`:

```csharp
Console.WriteLine(await Exp2.AskWithSessionAsync("My favorite order category is electronics."));
Console.WriteLine(await Exp2.AskWithSessionAsync("What's my favorite order category?"));
```

```powershell
dotnet run
```

## 👀 Expected Output

```text
Got it — I'll keep that in mind! (electronics is a popular category...)
Your favorite order category is electronics.
```

⚠️ **Needs runtime verification** — exact model phrasing varies; the key invariant is that the second answer correctly states "electronics" because `SessionStore` injected it as known context, not because the model remembered it independently.

## 🧠 What Just Happened?

`SessionStore` is a dict, not a conversation list — it holds *derived facts*, not raw turns. This matters because facts can be injected compactly into every future prompt (`context + question`) without resending the entire conversation history, which is cheaper at scale. The cost: restart the Python/C# process and `session`/`Session` resets to empty — this is **still not durable**.

## 🏋️ Exercise

Add a second fact type (e.g., "preferred shipping speed") to `SessionStore`, extract it the same naive way, and confirm both facts get injected into a third question's context simultaneously.

---

## 🚀 Experiment 3 — Persisted memory (survives a process restart)

Write facts to a small local JSON file so they outlive the process. This is the simplest form of **durable** memory.

### 💻 Code — Python

`exp3_persisted.py`:

```python
import json
from pathlib import Path
import ollama

MEMORY_FILE = Path("memory.json")

def load_memory() -> dict:
    if MEMORY_FILE.exists():
        return json.loads(MEMORY_FILE.read_text(encoding="utf-8"))
    return {}

def save_memory(facts: dict) -> None:
    MEMORY_FILE.write_text(json.dumps(facts), encoding="utf-8")

def ask_with_persisted_memory(question: str) -> str:
    facts = load_memory()

    if "favorite order category is" in question.lower():
        category = question.lower().split("favorite order category is")[-1].strip().rstrip(".")
        facts["preferred_category"] = category
        save_memory(facts)

    context = ""
    if "preferred_category" in facts:
        context = f"(Known fact: the user's preferred order category is {facts['preferred_category']}.) "

    response = ollama.chat(model="qwen3.5:9b-q4_K_M", messages=[
        {"role": "user", "content": context + question},
    ])
    return response["message"]["content"]

if __name__ == "__main__":
    print(ask_with_persisted_memory("My favorite order category is electronics."))
    # Now STOP the process, start a new one, and run only the line below:
    print(ask_with_persisted_memory("What's my favorite order category?"))
```

```powershell
python exp3_persisted.py
```

### 💻 Code — C#

`PersistedMemory.cs`:

```csharp
using System.Text.Json;

public static class PersistedMemory
{
    private const string MemoryFile = "memory.json";

    public static Dictionary<string, string> Load() =>
        File.Exists(MemoryFile)
            ? JsonSerializer.Deserialize<Dictionary<string, string>>(File.ReadAllText(MemoryFile))!
            : new();

    public static void Save(Dictionary<string, string> facts) =>
        File.WriteAllText(MemoryFile, JsonSerializer.Serialize(facts));

    public static async Task<string> AskAsync(string question)
    {
        var facts = Load();

        if (question.ToLowerInvariant().Contains("favorite order category is"))
        {
            var category = question.ToLowerInvariant()
                .Split("favorite order category is")[^1].Trim().TrimEnd('.');
            facts["preferred_category"] = category;
            Save(facts);
        }

        var context = facts.TryGetValue("preferred_category", out var cat)
            ? $"(Known fact: the user's preferred order category is {cat}.) "
            : "";

        return await OllamaClient.ChatAsync(new List<ChatMessage> { new("user", context + question) });
    }
}
```

`Program.cs`:

```csharp
Console.WriteLine(await PersistedMemory.AskAsync("My favorite order category is electronics."));
// Now STOP the process (Ctrl+C), start a fresh `dotnet run`, and run only the line below:
Console.WriteLine(await PersistedMemory.AskAsync("What's my favorite order category?"));
```

```powershell
dotnet run
```

## 👀 Expected Output

Open `memory.json` after the first run — it should contain `{"preferred_category": "electronics"}` on disk. Kill the process entirely, run the second question in a **brand-new process**, and it still answers correctly because it reads `memory.json` from disk, not from any in-memory state.

## 🧠 What Just Happened?

The difference from Experiment 2 is entirely about **where the dict lives**: Experiment 2's `SessionStore` lived in process memory (RAM) and died with the process; Experiment 3's `facts` dict is reloaded from a file on every call, so it survives a full restart. A small SQLite database (`sqlite3` in Python, `Microsoft.Data.Sqlite` in C#) is the natural next step once you need concurrent-safe writes or queries beyond simple key lookup — same durability principle, a more robust storage engine.

## 🏋️ Exercise

Convert `memory.json` to a tiny SQLite table (`facts(key TEXT PRIMARY KEY, value TEXT)`) using Python's built-in `sqlite3` module, and confirm the same restart-survives-it behavior holds with `INSERT OR REPLACE`/`SELECT` instead of JSON read/write.

---

## 🚀 Experiment 4 — Vector/semantic memory (retrieve the relevant fact, not the whole history)

Experiments 2–3 inject *every* remembered fact into *every* prompt — fine for a handful of facts, but it doesn't scale: a user with 200 remembered facts shouldn't have all 200 resent on every question. Instead, **embed each memory** (reusing [rag_embeddings_lab.md Lab 3's embedding approach](rag_embeddings_lab.md#rag-lab3) and [Lab 4's cosine similarity](rag_embeddings_lab.md#rag-lab4) directly) and retrieve only the most relevant one(s) for the current question — exactly the RAG retrieval pattern, applied to conversation memories instead of document chunks.

### 💻 Code — Python

`exp4_vector_memory.py`:

```python
import json
from pathlib import Path
import ollama
import numpy as np

MEMORY_FILE = Path("vector_memory.json")

def embed(text: str) -> list[float]:
    # Same embedding call as rag_embeddings_lab.md Lab 3 — not re-derived here, just reused.
    return ollama.embeddings(model="nomic-embed-text", prompt=text)["embedding"]

def cosine_similarity(a: list[float], b: list[float]) -> float:
    # Same function as rag_embeddings_lab.md Lab 4 — not re-derived here, just reused.
    a, b = np.array(a), np.array(b)
    return float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))

def load_vector_memory() -> list[dict]:
    if MEMORY_FILE.exists():
        return json.loads(MEMORY_FILE.read_text(encoding="utf-8"))
    return []

def remember(summary: str) -> None:
    memories = load_vector_memory()
    memories.append({"summary": summary, "embedding": embed(summary)})
    MEMORY_FILE.write_text(json.dumps(memories), encoding="utf-8")

def recall_relevant(question: str, top_k: int = 1) -> list[str]:
    memories = load_vector_memory()
    if not memories:
        return []
    q_vec = embed(question)
    scored = [(m["summary"], cosine_similarity(q_vec, m["embedding"])) for m in memories]
    scored.sort(key=lambda x: x[1], reverse=True)
    return [summary for summary, score in scored[:top_k]]

def ask_with_vector_memory(question: str) -> str:
    relevant = recall_relevant(question)
    context = f"(Relevant past memory: {relevant[0]}) " if relevant else ""
    response = ollama.chat(model="qwen3.5:9b-q4_K_M", messages=[
        {"role": "user", "content": context + question},
    ])
    return response["message"]["content"]

if __name__ == "__main__":
    remember("The user's favorite order category is electronics.")
    remember("The user prefers standard shipping, not express.")
    remember("The user once complained about a late delivery for order A100.")

    print(ask_with_vector_memory("What category of products do I usually order?"))
    print(ask_with_vector_memory("Did I have a problem with a past delivery?"))
```

```powershell
python exp4_vector_memory.py
```

### 💻 Code — C#

`VectorMemory.cs`:

```csharp
using System.Text.Json;

public record Memory(string Summary, float[] Embedding);

public static class VectorMemory
{
    private const string MemoryFile = "vector_memory.json";

    // Reuses rag_embeddings_lab.md Lab 3's Lab3.EmbedAsync and Lab 4's Lab4.CosineSimilarity directly.

    public static List<Memory> Load() =>
        File.Exists(MemoryFile)
            ? JsonSerializer.Deserialize<List<Memory>>(File.ReadAllText(MemoryFile))!
            : new();

    public static async Task RememberAsync(string summary)
    {
        var memories = Load();
        memories.Add(new Memory(summary, await Lab3.EmbedAsync(summary)));
        File.WriteAllText(MemoryFile, JsonSerializer.Serialize(memories));
    }

    public static async Task<List<string>> RecallRelevantAsync(string question, int topK = 1)
    {
        var memories = Load();
        if (memories.Count == 0) return new();
        var qVec = await Lab3.EmbedAsync(question);
        return memories
            .Select(m => (m.Summary, Score: Lab4.CosineSimilarity(qVec, m.Embedding)))
            .OrderByDescending(x => x.Score)
            .Take(topK)
            .Select(x => x.Summary)
            .ToList();
    }

    public static async Task<string> AskAsync(string question)
    {
        var relevant = await RecallRelevantAsync(question);
        var context = relevant.Count > 0 ? $"(Relevant past memory: {relevant[0]}) " : "";
        return await OllamaClient.ChatAsync(new List<ChatMessage> { new("user", context + question) });
    }
}
```

`Program.cs`:

```csharp
await VectorMemory.RememberAsync("The user's favorite order category is electronics.");
await VectorMemory.RememberAsync("The user prefers standard shipping, not express.");
await VectorMemory.RememberAsync("The user once complained about a late delivery for order A100.");

Console.WriteLine(await VectorMemory.AskAsync("What category of products do I usually order?"));
Console.WriteLine(await VectorMemory.AskAsync("Did I have a problem with a past delivery?"));
```

```powershell
dotnet run
```

## 👀 Expected Output

```text
Based on what I know, you usually order electronics.
Yes — you reported a late delivery for order A100 in the past.
```

⚠️ **Needs runtime verification.** Exact phrasing varies with the model; the invariant that matters is that each question retrieves the **semantically closest** of the three memories (category question → category memory; delivery question → delivery memory), not all three stuffed into context every time.

## 🧠 What Just Happened?

Each stored memory is now a point in embedding space, same as a document chunk in the RAG lab. `recall_relevant` performs the exact same top-k cosine-similarity search as [rag_embeddings_lab.md Lab 6](rag_embeddings_lab.md#rag-lab6), except the "documents" are past conversation summaries instead of file chunks. This is the mechanism behind "the AI remembers things from weeks ago" in production systems — it is retrieval, not an ever-growing prompt.

## 🏋️ Exercise

Add a fourth memory about a completely unrelated topic (e.g., "The user asked about office hours once") and confirm `recall_relevant` correctly ranks it **last** (or excludes it) for both the category and delivery questions — proving the retrieval is actually discriminating by meaning, not just returning whatever was stored first or most recently.

---

## 🧠 Terminology: one row each, one sentence each

| Term | One-sentence definition |
|---|---|
| **Prompt context** | Whatever text is actually sent to the model in a single call — the full assembled input, regardless of where its pieces came from. |
| **Conversation history** | The literal, ordered list of prior turns in one conversation, resent (in full or truncated) on each new call — see [Lab 3](agents_and_subagents_lab.md#agent-lab3). |
| **Session state** | Arbitrary derived key-value facts an application tracks about the current run, separate from the raw turn-by-turn transcript (Experiment 2 above). |
| **Short-term memory** | Memory that lives only as long as the current process/session — conversation history and session state are both short-term unless explicitly persisted. |
| **Long-term memory** | Memory intended to outlive a single session, typically written to and read from durable storage (Experiment 3 above). |
| **Vector/semantic memory** | Long-term memory indexed by embedding similarity so a new query retrieves the *most relevant* past memory instead of replaying everything (Experiment 4 above). |
| **Database-backed memory** | Long-term memory stored in a structured database (SQL or otherwise) rather than a flat file, typically chosen once you need concurrent access, querying, or scale beyond a single JSON file. |

## 🔒 Privacy Note

Every experiment above writes real user-derived data to disk (`memory.json`, `vector_memory.json`). That is **stored personal data**, not an abstraction — treat it with the same care as any other user record:

- Decide and document a **retention/expiry policy** (e.g., auto-delete facts older than N days, or on explicit user request) instead of letting memory files grow forever.
- Provide a real **deletion path** — a function that removes a specific user's facts entirely, not just "stop reading them." Test that deletion actually removes the data from disk, not just from the in-memory view.
- Avoid persisting sensitive categories (payment details, health information, credentials) into a plain-text memory file at all; if you must, encrypt at rest and restrict file permissions.
- If memory is later shared across multiple agents or conversations, make sure stale or incorrect memories can be corrected or removed — a system that "remembers" an error indefinitely is worse than one with no memory at all.

This is a real operational requirement in production systems (data-protection regulations typically require both a deletion and an access/export mechanism for stored personal data), not just a footnote to skim past.

## ✅ Checkpoint

- [ ] Ran Experiment 1 and can explain in one sentence why the second answer fails
- [ ] Ran Experiment 2 and confirmed the session fact resets after restarting the process
- [ ] Ran Experiment 3, confirmed `memory.json` on disk, and confirmed a **new process** still recalls the fact
- [ ] Ran Experiment 4 and confirmed two different questions each retrieve a different, relevant memory
- [ ] Can state, without checking this file, the one-sentence difference between session state and long-term memory

## 🏋️ Exercise (capstone)

Combine Experiments 3 and 4: store every remembered fact as a vector-embedded record (Experiment 4's format) persisted to disk (Experiment 3's durability), implement a `forget(summary_substring)` function that deletes a specific memory by content match, and prove it works by remembering three facts, forgetting one, restarting the process, and confirming only two remain and are still correctly retrieved by relevance.

## 🔗 Related Topics

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md#agent-lab3) — the base conversation-history mechanism this guide starts from.
- [rag_embeddings_lab.md](rag_embeddings_lab.md) — the embedding and retrieval mechanism reused directly in Experiment 4.
- [parallel_agents_and_fleets_guide.md](parallel_agents_and_fleets_guide.md) — what changes about memory consistency when multiple agents might read/write it concurrently.

## ➡️ Next

Continue to [hooks_permissions_human_approval_guide.md](hooks_permissions_human_approval_guide.md) to see how to govern what an agent with memory and tools is actually allowed to *do*. Or return to the **[README](README.md)** for the full map.
