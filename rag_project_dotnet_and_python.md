# 🚀 RAG Capstone: A Production-Shaped Project in Python and C#

> Take RAG from "one script per mechanism" to one cohesive, multi-file project — ingest real documents, store vectors, retrieve, cite, and answer — in both Python and C#, then prove it's a two-line swap to point the same architecture at a cloud provider.

## 🎯 What You Will Build

A small but properly structured local-document Q&A project, built twice (Python and C#), each with separate ingest/store/query modules instead of one script:

```text
docs/*.md  →  ingest (load + chunk + embed)  →  vector store (SQLite)
                                                        ↓
                                   user question  →  embed  →  top-k retrieve
                                                        ↓
                                grounded prompt with citations  →  local LLM
                                                        ↓
                                     answer printed with sources
```

This builds directly on the mechanism-level teaching in [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — that lab's Labs 0–10 already explain *why* each step works (chunking, embeddings, cosine similarity, citations, evaluation). **This guide does not re-derive any of that**; it assembles the same verified Ollama HTTP pattern into a realistic multi-file project shape, and adds one new piece: a lightweight persistent store (SQLite) instead of an in-memory list, so your embeddings survive a restart.

## 📚 Prerequisites

- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — complete through at least [Lab 8](rag_embeddings_lab.md#rag-lab8) (citations). This capstone assumes you already understand chunking, embeddings, and cosine similarity; it will not re-teach them.
- [`local_ai_learning_lab.md`](local_ai_learning_lab.md#lab-build) — Ollama installed, with `nomic-embed-text` (embeddings) and `qwen3.5:9b-q4_K_M` (generation) pulled.
- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md) — only needed for the optional "Switching from Local to Cloud" section near the end.
- Python 3.10+, no extra packages beyond the standard library's `sqlite3` + `requests`/`ollama`. .NET 8+, no NuGet package required (SQLite is accessed in C# below via the `Microsoft.Data.Sqlite` package, the smallest standard way to talk to SQLite from .NET — noted explicitly since it's the one dependency this guide adds beyond the repo's usual zero-package pattern).

## 🏷️ Difficulty: 🔴 Advanced — 🏆 Capstone project

## 🛠️ Setup

```powershell
ollama pull nomic-embed-text
ollama pull qwen3.5:9b-q4_K_M

New-Item -ItemType Directory -Force rag_capstone\docs | Out-Null
Set-Location rag_capstone
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install requests
```

```powershell
dotnet new console -o RagCapstone
Set-Location RagCapstone
dotnet add package Microsoft.Data.Sqlite
```

---

## 🚀 Step 1 — The sample document set

Create these five small Markdown files in `docs/` (deliberately short and topically distinct so retrieval quality is easy to eyeball):

`docs/retry-policy.md`:

```markdown
# Retry Policy
## Transient failures
Network calls may fail transiently. Retry up to 3 times with exponential backoff
starting at 500ms. Do not retry on 4xx client errors.
## Non-retryable errors
Authentication failures (401) and validation errors (400) must never be retried
automatically. Surface them to the caller immediately.
```

`docs/onboarding.md`:

```markdown
# New Hire Onboarding
## First day
New hires receive a laptop, VPN access, and a mentor assignment on day one.
## First week
Complete the security training module and shadow one on-call rotation.
```

`docs/incident-response.md`:

```markdown
# Incident Response
## Severity levels
Sev1 means full outage; page on-call immediately. Sev3 means minor degradation
with no customer impact; file a ticket during business hours.
## Postmortems
Every Sev1 and Sev2 incident requires a blameless postmortem within 5 business days.
```

`docs/expense-policy.md`:

```markdown
# Expense Policy
## Reimbursable items
Travel, client meals, and conference tickets are reimbursable with a receipt.
## Non-reimbursable items
Personal entertainment and alcohol at non-client events are never reimbursable.
```

`docs/deployment-windows.md`:

```markdown
# Deployment Windows
## Standard windows
Deployments happen Tuesday–Thursday, 10am–3pm, to keep on-call coverage light
if something goes wrong.
## Freeze periods
No deployments during the last week of each quarter or the week of a major holiday.
```

## 🚀 Step 2 — Python implementation

### `store.py` — the SQLite-backed vector store

```python
import json
import sqlite3
import numpy as np

DB_PATH = "vectors.db"

def init_db() -> sqlite3.Connection:
    conn = sqlite3.connect(DB_PATH)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS chunks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source TEXT NOT NULL,
            heading TEXT NOT NULL,
            text TEXT NOT NULL,
            embedding TEXT NOT NULL  -- JSON-encoded list[float]; fine at this scale
        )
    """)
    return conn

def add_chunk(conn: sqlite3.Connection, source: str, heading: str, text: str, embedding: list[float]) -> None:
    conn.execute(
        "INSERT INTO chunks (source, heading, text, embedding) VALUES (?, ?, ?, ?)",
        (source, heading, text, json.dumps(embedding)),
    )
    conn.commit()

def cosine_similarity(a: list[float], b: list[float]) -> float:
    a, b = np.array(a), np.array(b)
    return float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))

def search(conn: sqlite3.Connection, query_embedding: list[float], top_k: int = 3) -> list[dict]:
    rows = conn.execute("SELECT source, heading, text, embedding FROM chunks").fetchall()
    scored = [
        {
            "source": source,
            "heading": heading,
            "text": text,
            "score": cosine_similarity(query_embedding, json.loads(embedding_json)),
        }
        for source, heading, text, embedding_json in rows
    ]
    scored.sort(key=lambda r: r["score"], reverse=True)
    return scored[:top_k]
```

> [!NOTE]
> Scanning every row and scoring it in Python is exactly the "fine for a few hundred chunks" in-memory-style approach [`rag_embeddings_lab.md`'s Lab 5](rag_embeddings_lab.md#rag-lab5) already teaches — this guide's only change is persisting rows in SQLite instead of a JSON file, so restarting the process doesn't lose your embeddings. See that lab's [scaling-up section](rag_embeddings_lab.md#rag-scale) before reaching for a dedicated vector database; don't add one here until this approach actually becomes too slow for your real document count.

### `ingest.py` — load, chunk, embed, store

```python
import os
import re
import requests

OLLAMA_URL = "http://127.0.0.1:11434"
EMBED_MODEL = "nomic-embed-text"

def load_document(path: str) -> str:
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def chunk_by_heading(text: str) -> list[dict]:
    """Split on '## ' headings, same approach as rag_embeddings_lab.md Lab 2."""
    sections = re.split(r"\n(?=## )", text)
    chunks = []
    for section in sections:
        section = section.strip()
        if not section or section.startswith("# ") and "\n" not in section:
            continue
        heading_match = re.match(r"#+\s*(.+)", section)
        heading = heading_match.group(1) if heading_match else "Untitled"
        chunks.append({"heading": heading, "text": section})
    return chunks

def embed(text: str) -> list[float]:
    response = requests.post(f"{OLLAMA_URL}/api/embeddings", json={"model": EMBED_MODEL, "prompt": text}, timeout=30)
    response.raise_for_status()
    return response.json()["embedding"]

def ingest_folder(conn, folder: str = "docs") -> int:
    from store import add_chunk
    count = 0
    for filename in sorted(os.listdir(folder)):
        if not filename.endswith(".md"):
            continue
        path = os.path.join(folder, filename)
        text = load_document(path)
        for chunk in chunk_by_heading(text):
            vector = embed(chunk["text"])
            add_chunk(conn, source=filename, heading=chunk["heading"], text=chunk["text"], embedding=vector)
            count += 1
    return count

if __name__ == "__main__":
    from store import init_db
    conn = init_db()
    total = ingest_folder(conn)
    print(f"Ingested {total} chunks from docs/")
```

### `query.py` — retrieve, build a grounded + cited prompt, generate

```python
import requests

OLLAMA_URL = "http://127.0.0.1:11434"
GENERATE_MODEL = "qwen3.5:9b-q4_K_M"

def build_prompt(question: str, chunks: list[dict]) -> str:
    context = "\n\n".join(
        f"[Source {i + 1}: {c['source']}#{c['heading']}]\n{c['text']}"
        for i, c in enumerate(chunks)
    )
    return f"""Answer using ONLY the context below. After your answer, list which
Source numbers you used, like: Sources used: 1, 2
If the context does not contain the answer, say "I don't have that information."
and list no sources.

Context:
{context}

Question: {question}
Answer:"""

def answer(conn, question: str, top_k: int = 3) -> dict:
    from ingest import embed
    from store import search
    query_vector = embed(question)
    chunks = search(conn, query_vector, top_k=top_k)
    prompt = build_prompt(question, chunks)
    response = requests.post(
        f"{OLLAMA_URL}/api/generate",
        json={"model": GENERATE_MODEL, "prompt": prompt, "stream": False},
        timeout=120,
    )
    response.raise_for_status()
    return {
        "answer": response.json()["response"],
        "available_sources": [f"{c['source']}#{c['heading']} (score={c['score']:.3f})" for c in chunks],
    }
```

### `main.py` — the entry point

```python
import sys
from store import init_db
from ingest import ingest_folder
from query import answer

def main():
    conn = init_db()
    # Re-ingest is idempotent-ish for this demo (re-running adds duplicate rows);
    # a real project would check "already ingested" per file before re-embedding.
    if "--ingest" in sys.argv:
        total = ingest_folder(conn)
        print(f"Ingested {total} chunks.\n")

    question = "What severity requires paging on-call immediately, and what's required afterward?"
    result = answer(conn, question)
    print("Q:", question)
    print("A:", result["answer"])
    print("Sources available to the model:", result["available_sources"])

if __name__ == "__main__":
    main()
```

```powershell
python main.py --ingest
```

## 🚀 Step 3 — C# implementation

### `VectorStore.cs` — SQLite-backed store

```csharp
using Microsoft.Data.Sqlite;
using System.Text.Json;

public record ScoredChunk(string Source, string Heading, string Text, double Score);

public class VectorStore
{
    private readonly string _connectionString;

    public VectorStore(string dbPath = "vectors.db")
    {
        _connectionString = $"Data Source={dbPath}";
        using var conn = new SqliteConnection(_connectionString);
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = """
            CREATE TABLE IF NOT EXISTS chunks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source TEXT NOT NULL,
                heading TEXT NOT NULL,
                text TEXT NOT NULL,
                embedding TEXT NOT NULL
            )
            """;
        cmd.ExecuteNonQuery();
    }

    public void AddChunk(string source, string heading, string text, float[] embedding)
    {
        using var conn = new SqliteConnection(_connectionString);
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = "INSERT INTO chunks (source, heading, text, embedding) VALUES ($s, $h, $t, $e)";
        cmd.Parameters.AddWithValue("$s", source);
        cmd.Parameters.AddWithValue("$h", heading);
        cmd.Parameters.AddWithValue("$t", text);
        cmd.Parameters.AddWithValue("$e", JsonSerializer.Serialize(embedding));
        cmd.ExecuteNonQuery();
    }

    private static double CosineSimilarity(float[] a, float[] b)
    {
        double dot = 0, normA = 0, normB = 0;
        for (int i = 0; i < a.Length; i++)
        {
            dot += a[i] * b[i];
            normA += a[i] * a[i];
            normB += b[i] * b[i];
        }
        return dot / (Math.Sqrt(normA) * Math.Sqrt(normB));
    }

    public List<ScoredChunk> Search(float[] queryEmbedding, int topK = 3)
    {
        using var conn = new SqliteConnection(_connectionString);
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = "SELECT source, heading, text, embedding FROM chunks";
        using var reader = cmd.ExecuteReader();

        var scored = new List<ScoredChunk>();
        while (reader.Read())
        {
            string source = reader.GetString(0);
            string heading = reader.GetString(1);
            string text = reader.GetString(2);
            float[] embedding = JsonSerializer.Deserialize<float[]>(reader.GetString(3))!;
            scored.Add(new ScoredChunk(source, heading, text, CosineSimilarity(queryEmbedding, embedding)));
        }
        return scored.OrderByDescending(c => c.Score).Take(topK).ToList();
    }
}
```

### `Ingest.cs` — load, chunk, embed, store

```csharp
using System.Net.Http.Json;
using System.Text.Json;
using System.Text.RegularExpressions;

public record DocChunk(string Heading, string Text);

public static class Ingest
{
    private static readonly HttpClient Client = new() { BaseAddress = new Uri("http://127.0.0.1:11434") };

    public static List<DocChunk> ChunkByHeading(string text)
    {
        var sections = Regex.Split(text, @"\n(?=## )");
        var chunks = new List<DocChunk>();
        foreach (var raw in sections)
        {
            string section = raw.Trim();
            if (string.IsNullOrEmpty(section)) continue;
            var match = Regex.Match(section, @"^#+\s*(.+)");
            string heading = match.Success ? match.Groups[1].Value : "Untitled";
            chunks.Add(new DocChunk(heading, section));
        }
        return chunks;
    }

    public static async Task<float[]> EmbedAsync(string text)
    {
        var request = new { model = "nomic-embed-text", prompt = text };
        using var response = await Client.PostAsJsonAsync("/api/embeddings", request);
        response.EnsureSuccessStatusCode();
        using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
        return doc.RootElement.GetProperty("embedding").EnumerateArray().Select(e => e.GetSingle()).ToArray();
    }

    public static async Task<int> IngestFolderAsync(VectorStore store, string folder = "docs")
    {
        int count = 0;
        foreach (var path in Directory.GetFiles(folder, "*.md").OrderBy(p => p))
        {
            string text = await File.ReadAllTextAsync(path);
            string filename = Path.GetFileName(path);
            foreach (var chunk in ChunkByHeading(text))
            {
                float[] vector = await EmbedAsync(chunk.Text);
                store.AddChunk(filename, chunk.Heading, chunk.Text, vector);
                count++;
            }
        }
        return count;
    }
}
```

### `Query.cs` — retrieve, grounded + cited prompt, generate

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public record CapstoneAnswer(string Answer, List<string> AvailableSources);

public static class Query
{
    private static readonly HttpClient Client = new()
    {
        BaseAddress = new Uri("http://127.0.0.1:11434"),
        Timeout = TimeSpan.FromSeconds(120)
    };

    public static string BuildPrompt(string question, List<ScoredChunk> chunks)
    {
        string context = string.Join("\n\n", chunks.Select((c, i) =>
            $"[Source {i + 1}: {c.Source}#{c.Heading}]\n{c.Text}"));

        return $"""
            Answer using ONLY the context below. After your answer, list which
            Source numbers you used, like: Sources used: 1, 2
            If the context does not contain the answer, say "I don't have that information."
            and list no sources.

            Context:
            {context}

            Question: {question}
            Answer:
            """;
    }

    public static async Task<CapstoneAnswer> AnswerAsync(VectorStore store, string question, int topK = 3)
    {
        float[] queryVector = await Ingest.EmbedAsync(question);
        var chunks = store.Search(queryVector, topK);
        string prompt = BuildPrompt(question, chunks);

        var request = new { model = "qwen3.5:9b-q4_K_M", prompt, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
        string answerText = doc.RootElement.GetProperty("response").GetString()!;

        var sources = chunks.Select(c => $"{c.Source}#{c.Heading} (score={c.Score:F3})").ToList();
        return new CapstoneAnswer(answerText, sources);
    }
}
```

### `Program.cs` — the entry point

```csharp
var store = new VectorStore();

if (args.Contains("--ingest"))
{
    int total = await Ingest.IngestFolderAsync(store);
    Console.WriteLine($"Ingested {total} chunks.\n");
}

string question = "What severity requires paging on-call immediately, and what's required afterward?";
var result = await Query.AnswerAsync(store, question);

Console.WriteLine($"Q: {question}");
Console.WriteLine($"A: {result.Answer}");
Console.WriteLine("Sources available to the model: " + string.Join(", ", result.AvailableSources));
```

```powershell
dotnet run -- --ingest
```

## 👀 Expected Output

```text
Q: What severity requires paging on-call immediately, and what's required afterward?
A: Sev1 (full outage) requires paging on-call immediately. Every Sev1 incident
also requires a blameless postmortem within 5 business days.
Sources used: 1, 2
Sources available to the model: incident-response.md#Severity levels (score=0.842), incident-response.md#Postmortems (score=0.781), deployment-windows.md#Standard windows (score=0.512)
```

⚠️ **Needs runtime verification on your machine:** exact scores and wording depend on your embedding/generation model versions; the *pattern* (the two `incident-response.md` chunks ranking above the unrelated `deployment-windows.md` chunk, and the answer citing only the relevant sources) is what to check for, not exact numbers.

## 🧠 What Just Happened?

Nothing here is a new RAG mechanism — every step (chunk, embed, cosine similarity, grounded+cited prompt) is exactly what [`rag_embeddings_lab.md`](rag_embeddings_lab.md) already taught. What changed is **project shape**: four single-responsibility files instead of one script, and a real persistent store instead of an in-memory list — the difference between a teaching lab and something you could actually keep running and adding documents to over time.

---

## 🔄 Switching from Local to Cloud

The entire retrieval/storage/prompt-construction architecture above is **engine-agnostic** — only the two HTTP calls inside `Ingest.EmbedAsync` / `embed()` and `Query.AnswerAsync` / `answer()` need to change. Nothing about `VectorStore`/`store.py`, chunking, or prompt-building changes at all.

**Python — minimal diff in `query.py`'s generation call:**

```python
# Before (local):
response = requests.post(
    f"{OLLAMA_URL}/api/generate",
    json={"model": GENERATE_MODEL, "prompt": prompt, "stream": False},
    timeout=120,
)
answer_text = response.json()["response"]

# After (cloud — see cloud_llm_practical_guide.md for the full field reference):
import os
response = requests.post(
    "https://api.openai.com/v1/responses",
    headers={"Authorization": f"Bearer {os.environ['OPENAI_API_KEY']}", "Content-Type": "application/json"},
    json={"model": "gpt-5.5", "input": prompt},
    timeout=120,
)
body = response.json()
answer_text = next(item for item in body["output"] if item["type"] == "message")["content"][0]["text"]
```

**C# — minimal diff in `Query.cs`'s `AnswerAsync`:**

```csharp
// Before (local):
// using var client = new HttpClient { BaseAddress = new Uri("http://127.0.0.1:11434") };

// After (cloud):
using var client = new HttpClient { BaseAddress = new Uri("https://api.openai.com") };
client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(
    "Bearer", Environment.GetEnvironmentVariable("OPENAI_API_KEY")!);
var request = new { model = "gpt-5.5", input = prompt }; // was: new { model, prompt, stream = false }
using var response = await client.PostAsJsonAsync("/v1/responses", request); // was: "/api/generate"
```

That's the complete change: swap the base address, add an `Authorization` header, rename `prompt`→`input` and the model name, and parse the differently-shaped (but still JSON) reply — exactly as documented field-by-field in [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md). The embedding call can be swapped the same way against any cloud embeddings endpoint; `VectorStore`/`store.py` neither knows nor cares which engine produced the vectors it stores, as long as every vector in a given database came from the *same* embedding model (mixing embedding models in one store silently breaks cosine-similarity comparisons — don't do it).

## 🏋️ Exercise

Add a sixth document of your own choosing to `docs/`, re-run with `--ingest`, and ask a question whose answer requires combining information from your new document and one of the original five. Confirm the citations in the output correctly list both sources.

## ✅ Checkpoint — 🏆 Capstone Complete

You have a working, restart-safe, multi-file RAG project in both Python and C#, built from documents you authored, retrieving and citing correctly, and you've proven — not just read — that swapping the underlying LLM engine from local to cloud is a localized, few-line change rather than a rebuild. This is the RAG track's capstone; everything in [`rag_embeddings_lab.md`](rag_embeddings_lab.md) and this guide together form the complete from-scratch-to-production arc.

## 🔗 Related Topics

- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — the mechanism-level teaching this capstone assembles into a project.
- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md) — full field reference for the cloud swap above.
- [`ai_evaluation_guide.md`](ai_evaluation_guide.md) — measure this project's retrieval/answer quality rigorously instead of eyeballing one example question.
- [`ai_security_guide.md`](ai_security_guide.md) — before pointing this at untrusted/user-uploaded documents, read the indirect-injection section; retrieved content is still untrusted input even though it came from "your own" document folder.

## ➡️ Next

You've completed the RAG track. Return to [`ai_journey.md`](ai_journey.md#course-rag) for the next topic in the broader curriculum, or explore [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) to give a model tool access on top of retrieval.
