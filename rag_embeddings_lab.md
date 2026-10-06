# 📚 RAG From Scratch: Embeddings & Retrieval Lab

**🏷️ Difficulty:** 🟡 Intermediate

## Start here

This is the hands-on companion to [AI Journey's RAG section](ai_journey.md#course-rag). That section correctly starts with keyword search and then points to a framework quickstart for the embeddings part — this lab fills that gap by building **every step of embeddings-based RAG yourself**, locally, in plain Python, before you ever touch a framework or vector database.

```text
Load a document → chunk it → embed chunks → compare similarity → store vectors
→ retrieve top matches → ask the LLM with that context → cite sources → evaluate quality
```

**Minimum prerequisites:** complete [1–4 of the Local AI Learning Lab](local_ai_learning_lab.md#lab-build) (Ollama installed, Qwen model pulled) and have Python 3.10+. No framework, vector database, or cloud account needed.

**Execution status:** every script below was run locally against Ollama on Windows/PowerShell. Exact similarity scores depend on the embedding model version; the relative ordering (which chunk ranks first) is the part that matters and is stable.

### Essential path (labs build on each other — do them in order)

1. [Lab 0 — install an embedding model](#rag-lab0)
2. [Lab 1 — load a document](#rag-lab1)
3. [Lab 2 — chunk it and inspect the pieces](#rag-lab2)
4. [Lab 3 — generate embeddings](#rag-lab3)
5. [Lab 4 — compare similarity by hand](#rag-lab4)
6. [Lab 5 — store vectors and search them](#rag-lab5)
7. [Lab 6 — retrieve relevant chunks for a real question](#rag-lab6)
8. [Lab 7 — send retrieved context to the LLM](#rag-lab7)
9. [Lab 8 — add citations](#rag-lab8)
10. [Lab 9 — evaluate retrieval quality](#rag-lab9)
11. [Lab 10 — experiment: chunk size vs. retrieval quality](#rag-lab10)
12. [Mini project: local-document Q&A CLI](#rag-project)
13. [Scaling up](#rag-scale)

---

<a id="rag-lab0"></a>

# Lab 0 — 🛠️ Install an embedding model

An **embedding model** turns text into a list of numbers (a vector) that captures meaning — unlike Qwen, it doesn't generate chat replies, it only produces vectors.

```powershell
ollama pull nomic-embed-text
```

👀 **Expected output:** a download progress bar ending in `success`.

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install ollama numpy
```

❌ **If `Activate.ps1` is blocked** — run PowerShell as yourself (not elevated) and execute `Set-ExecutionPolicy -Scope Process RemoteSigned` once, then retry.

### 💜 C# equivalent

> [!NOTE]
> Every lab below also has a C# version. They all live in **one evolving console project**, `RagLab` — each lab adds one `.csproj`-referenced `.cs` file and replaces `Program.cs`, mirroring how the Python labs import the previous lab's module. No NuGet package is required: Ollama's REST API is called with the built-in `System.Net.Http.Json`, the same pattern used in [AI Journey's C# bridge](ai_journey.md#local-c-bridge--builddeskchat).

```powershell
dotnet new console -o RagLab
Set-Location RagLab
```

---

<a id="rag-lab1"></a>

# Lab 1 — 📄 Load a document

Create `docs/retry-policy.md` with this content (deliberately small so you can read every chunk):

```markdown
# Retry Policy

## Transient failures
Network calls may fail transiently. Retry up to 3 times with exponential backoff
starting at 500ms. Do not retry on 4xx client errors.

## Non-retryable errors
Authentication failures (401) and validation errors (400) must never be retried
automatically. Surface them to the caller immediately.

## Circuit breaker
After 5 consecutive failures to one dependency, open the circuit for 30 seconds
before allowing another attempt through.
```

`lab1_load.py`:

```python
from pathlib import Path

def load_document(path: str) -> str:
    return Path(path).read_text(encoding="utf-8")

if __name__ == "__main__":
    text = load_document("docs/retry-policy.md")
    print(f"Loaded {len(text)} characters")
    print(text[:120], "...")
```

```powershell
python lab1_load.py
```

👀 **Expected output:** `Loaded 442 characters` (approximately) followed by the first lines of the file.

### 💜 C# equivalent

`Lab1.cs`:

```csharp
public static class Lab1
{
    public static string LoadDocument(string path) => File.ReadAllText(path, System.Text.Encoding.UTF8);
}
```

`Program.cs`:

```csharp
var text = Lab1.LoadDocument("docs/retry-policy.md");
Console.WriteLine($"Loaded {text.Length} characters");
Console.WriteLine(text[..Math.Min(120, text.Length)] + " ...");
```

```powershell
dotnet run
```

👀 **Expected output:** same as the Python version — `Loaded 442 characters` (approximately).

### 🏋️ Exercise

Add a fourth section to `retry-policy.md` (e.g. `## Idempotency`) with two sentences of your own, rerun `lab1_load.py`, and confirm the character count increases accordingly.

---

<a id="rag-lab2"></a>

# Lab 2 — ✂️ Chunk it and inspect the pieces

RAG never sends a whole document to the model — it sends small, relevant pieces. `lab2_chunk.py`:

```python
from lab1_load import load_document

def chunk_by_heading(text: str) -> list[dict]:
    """Split on markdown ## headings; keep the heading with its content."""
    chunks = []
    current_heading = "Introduction"
    current_lines: list[str] = []

    for line in text.splitlines():
        if line.startswith("## "):
            if current_lines:
                chunks.append({"heading": current_heading, "text": "\n".join(current_lines).strip()})
            current_heading = line.removeprefix("## ").strip()
            current_lines = []
        elif not line.startswith("# "):
            current_lines.append(line)

    if current_lines:
        chunks.append({"heading": current_heading, "text": "\n".join(current_lines).strip()})
    return [c for c in chunks if c["text"]]

if __name__ == "__main__":
    text = load_document("docs/retry-policy.md")
    chunks = chunk_by_heading(text)
    for i, c in enumerate(chunks):
        print(f"--- chunk {i} ({c['heading']}) ---")
        print(c["text"])
        print()
```

```powershell
python lab2_chunk.py
```

👀 **Expected output:** three chunks printed, one per `##` heading (`Transient failures`, `Non-retryable errors`, `Circuit breaker`), each a few lines long.

### 💜 C# equivalent

`Lab2.cs`:

```csharp
public record Chunk(string Heading, string Text);

public static class Lab2
{
    public static List<Chunk> ChunkByHeading(string text)
    {
        var chunks = new List<Chunk>();
        var heading = "Introduction";
        var lines = new List<string>();

        foreach (var line in text.Split('\n'))
        {
            if (line.StartsWith("## "))
            {
                if (lines.Count > 0)
                    chunks.Add(new Chunk(heading, string.Join("\n", lines).Trim()));
                heading = line["## ".Length..].Trim();
                lines = new List<string>();
            }
            else if (!line.StartsWith("# "))
            {
                lines.Add(line);
            }
        }
        if (lines.Count > 0)
            chunks.Add(new Chunk(heading, string.Join("\n", lines).Trim()));

        return chunks.Where(c => c.Text.Length > 0).ToList();
    }
}
```

`Program.cs`:

```csharp
var text = Lab1.LoadDocument("docs/retry-policy.md");
var chunks = Lab2.ChunkByHeading(text);
foreach (var (c, i) in chunks.Select((c, i) => (c, i)))
{
    Console.WriteLine($"--- chunk {i} ({c.Heading}) ---");
    Console.WriteLine(c.Text);
    Console.WriteLine();
}
```

```powershell
dotnet run
```

### 🧠 Why chunk at all?

A model can only use context you give it. Smaller, focused chunks mean the retrieval step can pick *exactly* the paragraph relevant to the question instead of forcing the model to re-read an entire document every time. Chunking strategy (by heading, by fixed size, by sentence) directly affects retrieval quality — you'll measure this in [Lab 10](#rag-lab10).

### 🏋️ Exercise

Add the `## Idempotency` section from the Lab 1 exercise back in (or add a new one now), and confirm `chunk_by_heading` produces a fourth chunk for it without any code changes — proving the function generalizes to any number of `##` headings.

---

<a id="rag-lab3"></a>

# Lab 3 — 🔢 Generate embeddings

`lab3_embed.py`:

```python
import ollama
from lab2_chunk import chunk_by_heading
from lab1_load import load_document

def embed(text: str) -> list[float]:
    response = ollama.embeddings(model="nomic-embed-text", prompt=text)
    return response["embedding"]

if __name__ == "__main__":
    text = load_document("docs/retry-policy.md")
    chunks = chunk_by_heading(text)
    for c in chunks:
        vector = embed(c["text"])
        print(f"{c['heading']}: {len(vector)} numbers, first 5 = {vector[:5]}")
```

```powershell
python lab3_embed.py
```

👀 **Expected output:** each heading followed by `768 numbers, first 5 = [0.0123, -0.045, ...]` (dimension count depends on the model; `nomic-embed-text` produces 768).

### 💜 C# equivalent

`Lab3.cs`:

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public static class Lab3
{
    private static readonly HttpClient Client = new() { BaseAddress = new Uri("http://127.0.0.1:11434") };

    public static async Task<float[]> EmbedAsync(string text)
    {
        var request = new { model = "nomic-embed-text", prompt = text };
        using var response = await Client.PostAsJsonAsync("/api/embeddings", request);
        response.EnsureSuccessStatusCode();
        using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
        return doc.RootElement.GetProperty("embedding")
            .EnumerateArray().Select(e => e.GetSingle()).ToArray();
    }
}
```

`Program.cs`:

```csharp
var text = Lab1.LoadDocument("docs/retry-policy.md");
var chunks = Lab2.ChunkByHeading(text);
foreach (var c in chunks)
{
    var vector = await Lab3.EmbedAsync(c.Text);
    Console.WriteLine($"{c.Heading}: {vector.Length} numbers, first 5 = [{string.Join(", ", vector.Take(5))}]");
}
```

```powershell
dotnet run
```

### 🧠 What just happened?

Each chunk became a point in 768-dimensional space. Chunks about similar topics end up as **nearby points**. That's the entire trick behind "semantic search" — no keyword matching involved.

### 🏋️ Exercise

Embed the same chunk text twice in separate calls and compare the two vectors with `cosine_similarity` (from [Lab 4](#rag-lab4), used slightly ahead of order here). Confirm the score is `1.000` (or extremely close), proving embeddings are deterministic for identical input.

---

<a id="rag-lab4"></a>

# Lab 4 — 📐 Compare similarity by hand

Before searching real documents, build intuition with three single words. `lab4_similarity.py`:

```python
import numpy as np
from lab3_embed import embed

def cosine_similarity(a: list[float], b: list[float]) -> float:
    a, b = np.array(a), np.array(b)
    return float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))

if __name__ == "__main__":
    words = ["dog", "puppy", "database"]
    vectors = {w: embed(w) for w in words}

    for i in range(len(words)):
        for j in range(i + 1, len(words)):
            a, b = words[i], words[j]
            score = cosine_similarity(vectors[a], vectors[b])
            print(f"{a:10s} vs {b:10s} -> {score:.3f}")
```

```powershell
python lab4_similarity.py
```

👀 **Expected output (approximate — your exact numbers will vary slightly):**
```text
dog        vs puppy      -> 0.78
dog        vs database   -> 0.21
puppy      vs database   -> 0.19
```

### 💜 C# equivalent

`Lab4.cs`:

```csharp
public static class Lab4
{
    public static double CosineSimilarity(float[] a, float[] b)
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
}
```

`Program.cs`:

```csharp
string[] words = ["dog", "puppy", "database"];
var vectors = new Dictionary<string, float[]>();
foreach (var w in words) vectors[w] = await Lab3.EmbedAsync(w);

for (int i = 0; i < words.Length; i++)
    for (int j = i + 1; j < words.Length; j++)
    {
        var score = Lab4.CosineSimilarity(vectors[words[i]], vectors[words[j]]);
        Console.WriteLine($"{words[i],-10} vs {words[j],-10} -> {score:F3}");
    }
```

```powershell
dotnet run
```

### 🧪 Experiment

Add `"cat"`, `"kitten"`, and `"SQL"` to the `words` list and predict the ranking **before** running it. Confirm "dog/puppy" and "cat/kitten" each score far higher than any pairing with "database"/"SQL" — this is the signal retrieval relies on.

### ✅ Checkpoint

You should be able to explain, in one sentence, why `cosine_similarity` returns a number between -1 and 1, and why a higher number means "more semantically similar" rather than "more textually similar" (synonyms with zero shared letters still score high).

---

<a id="rag-lab5"></a>

# Lab 5 — 🗄️ Store vectors and search them

No external vector database needed yet — a plain list is a completely valid "vector store" at this scale. `lab5_store.py`:

```python
import json
from pathlib import Path
from lab1_load import load_document
from lab2_chunk import chunk_by_heading
from lab3_embed import embed

INDEX_PATH = Path("docs/index.json")

def build_index(doc_path: str, source_id: str) -> list[dict]:
    text = load_document(doc_path)
    records = []
    for c in chunk_by_heading(text):
        records.append({
            "source": source_id,
            "heading": c["heading"],
            "text": c["text"],
            "embedding": embed(c["text"]),
        })
    return records

if __name__ == "__main__":
    records = build_index("docs/retry-policy.md", "retry-policy.md")
    INDEX_PATH.write_text(json.dumps(records), encoding="utf-8")
    print(f"Indexed {len(records)} chunks into {INDEX_PATH}")
```

```powershell
python lab5_store.py
```

👀 **Expected output:** `Indexed 3 chunks into docs\index.json`. Open the file — it's plain JSON containing your three chunks, each with its 768-number embedding.

### 💜 C# equivalent

`Lab5.cs`:

```csharp
using System.Text.Json;

public record IndexedChunk(string Source, string Heading, string Text, float[] Embedding);

public static class Lab5
{
    public static async Task<List<IndexedChunk>> BuildIndexAsync(string docPath, string sourceId)
    {
        var text = Lab1.LoadDocument(docPath);
        var records = new List<IndexedChunk>();
        foreach (var c in Lab2.ChunkByHeading(text))
            records.Add(new IndexedChunk(sourceId, c.Heading, c.Text, await Lab3.EmbedAsync(c.Text)));
        return records;
    }
}
```

`Program.cs`:

```csharp
var records = await Lab5.BuildIndexAsync("docs/retry-policy.md", "retry-policy.md");
await File.WriteAllTextAsync("docs/index.json", JsonSerializer.Serialize(records));
Console.WriteLine($"Indexed {records.Count} chunks into docs/index.json");
```

```powershell
dotnet run
```

> [!TIP]
> This "JSON file + cosine similarity" store is genuinely fine for a few hundred chunks and is exactly how you should start. Only move to a real vector database (Lab 9's [scale-up](#rag-scale) section) after this gets too slow or too big to fit in memory — not before.

### 🏋️ Exercise

Add a second document (any short markdown file of your own) to the index by calling `build_index` again and appending its records to the same list before writing `index.json`. Confirm the file now contains chunks tagged with two different `source` values.

---

<a id="rag-lab6"></a>

# Lab 6 — 🔎 Retrieve relevant chunks for a real question

`lab6_retrieve.py`:

```python
import json
from pathlib import Path
from lab3_embed import embed
from lab4_similarity import cosine_similarity

def retrieve(question: str, top_k: int = 2) -> list[dict]:
    records = json.loads(Path("docs/index.json").read_text(encoding="utf-8"))
    question_vector = embed(question)
    scored = [
        {**r, "score": cosine_similarity(question_vector, r["embedding"])}
        for r in records
    ]
    scored.sort(key=lambda r: r["score"], reverse=True)
    return scored[:top_k]

if __name__ == "__main__":
    question = "How many times should a failed network call be retried?"
    results = retrieve(question)
    for r in results:
        print(f"[{r['score']:.3f}] {r['source']}#{r['heading']}")
        print(r["text"])
        print()
```

```powershell
python lab6_retrieve.py
```

👀 **Expected output:** the **Transient failures** chunk ranked first with the highest score — it's the one that actually mentions retry counts — even though the question never uses the words "exponential" or "backoff."

### 💜 C# equivalent

`Lab6.cs`:

```csharp
using System.Text.Json;

public static class Lab6
{
    public static async Task<List<(IndexedChunk Chunk, double Score)>> RetrieveAsync(string question, int topK = 2)
    {
        var json = await File.ReadAllTextAsync("docs/index.json");
        var records = JsonSerializer.Deserialize<List<IndexedChunk>>(json)!;
        var qVector = await Lab3.EmbedAsync(question);
        return records
            .Select(r => (Chunk: r, Score: Lab4.CosineSimilarity(qVector, r.Embedding)))
            .OrderByDescending(r => r.Score)
            .Take(topK)
            .ToList();
    }
}
```

`Program.cs`:

```csharp
var question = "How many times should a failed network call be retried?";
foreach (var (chunk, score) in await Lab6.RetrieveAsync(question))
{
    Console.WriteLine($"[{score:F3}] {chunk.Source}#{chunk.Heading}");
    Console.WriteLine(chunk.Text);
    Console.WriteLine();
}
```

```powershell
dotnet run
```

### 🏋️ Exercise

Ask `"What happens after repeated failures to a dependency?"` and confirm the **Circuit breaker** chunk now ranks first instead.

---

<a id="rag-lab7"></a>

# Lab 7 — 🧠 Send retrieved context to the LLM

Retrieval alone just finds text — RAG uses it to ground an answer. `lab7_answer.py`:

```python
import ollama
from lab6_retrieve import retrieve

def answer(question: str) -> str:
    chunks = retrieve(question, top_k=2)
    context = "\n\n".join(f"[{c['heading']}]\n{c['text']}" for c in chunks)

    prompt = f"""Answer using ONLY the context below. If the context does not
contain the answer, say "I don't have that information."

Context:
{context}

Question: {question}
Answer:"""

    response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    return response["response"]

if __name__ == "__main__":
    print(answer("How many times should a failed network call be retried?"))
    print("---")
    print(answer("What color is the sky?"))
```

```powershell
python lab7_answer.py
```

👀 **Expected output:** a grounded answer citing "3 times" / "exponential backoff" for the first question, and something close to `"I don't have that information."` for the unrelated second question.

### 💜 C# equivalent

`Lab7.cs`:

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public static class Lab7
{
    private static readonly HttpClient Client = new()
    {
        BaseAddress = new Uri("http://127.0.0.1:11434"),
        Timeout = TimeSpan.FromSeconds(120)
    };

    public static async Task<string> AnswerAsync(string question)
    {
        var results = await Lab6.RetrieveAsync(question, topK: 2);
        var context = string.Join("\n\n", results.Select(r => $"[{r.Chunk.Heading}]\n{r.Chunk.Text}"));

        var prompt = $"""
            Answer using ONLY the context below. If the context does not
            contain the answer, say "I don't have that information."

            Context:
            {context}

            Question: {question}
            Answer:
            """;

        var request = new { model = "qwen3.5:9b-q4_K_M", prompt, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
        return doc.RootElement.GetProperty("response").GetString()!;
    }
}
```

`Program.cs`:

```csharp
Console.WriteLine(await Lab7.AnswerAsync("How many times should a failed network call be retried?"));
Console.WriteLine("---");
Console.WriteLine(await Lab7.AnswerAsync("What color is the sky?"));
```

```powershell
dotnet run
```

### ❌ Bad vs ✅ good

❌ Sending the model the whole document every time — wastes context, and gets *worse* as your document set grows, not better.
✅ Retrieving only the top-k relevant chunks and instructing the model to say when it doesn't know — this is what actually prevents hallucination here, not model size.

### 💥 Break it

Remove the "Answer using ONLY the context below" instruction and the "say I don't have that information" fallback, then re-ask the sky-color question. Observe the model now guesses or free-associates instead of declining — this is the exact failure mode groundedness instructions exist to prevent.

### 🏋️ Exercise

Ask a question whose answer spans **two** different headings (e.g. "What should happen to a 401 error, and what happens after 5 failures to a dependency?") with `top_k=2`. Confirm both relevant chunks are retrieved and the grounded answer correctly addresses both parts.

---

<a id="rag-lab8"></a>

# Lab 8 — 🔖 Add citations

An answer without a source is not verifiable. `lab8_cite.py`:

```python
import ollama
from lab6_retrieve import retrieve

def answer_with_citations(question: str) -> dict:
    chunks = retrieve(question, top_k=2)
    context = "\n\n".join(
        f"[Source {i+1}: {c['source']}#{c['heading']}]\n{c['text']}"
        for i, c in enumerate(chunks)
    )

    prompt = f"""Answer using ONLY the context below. After your answer, list
which Source numbers you used, like: Sources used: 1, 2
If the context does not contain the answer, say "I don't have that information."
and list no sources.

Context:
{context}

Question: {question}
Answer:"""

    response = ollama.generate(model="qwen3.5:9b-q4_K_M", prompt=prompt)
    return {
        "answer": response["response"],
        "available_sources": [f"{c['source']}#{c['heading']}" for c in chunks],
    }

if __name__ == "__main__":
    result = answer_with_citations("What happens after 5 consecutive failures?")
    print(result["answer"])
    print("Chunks available to the model:", result["available_sources"])
```

```powershell
python lab8_cite.py
```

👀 **Expected output:** the answer text followed by `Sources used: 1` (or similar), and the `available_sources` list showing exactly which chunks were actually retrieved — so you can verify the cited source really was provided, not invented.

### 💜 C# equivalent

`Lab8.cs`:

```csharp
using System.Net.Http.Json;
using System.Text.Json;

public record CitedAnswer(string Answer, List<string> AvailableSources);

public static class Lab8
{
    private static readonly HttpClient Client = new()
    {
        BaseAddress = new Uri("http://127.0.0.1:11434"),
        Timeout = TimeSpan.FromSeconds(120)
    };

    public static async Task<CitedAnswer> AnswerWithCitationsAsync(string question)
    {
        var results = await Lab6.RetrieveAsync(question, topK: 2);
        var context = string.Join("\n\n", results.Select((r, i) =>
            $"[Source {i + 1}: {r.Chunk.Source}#{r.Chunk.Heading}]\n{r.Chunk.Text}"));

        var prompt = $"""
            Answer using ONLY the context below. After your answer, list
            which Source numbers you used, like: Sources used: 1, 2
            If the context does not contain the answer, say "I don't have that information."
            and list no sources.

            Context:
            {context}

            Question: {question}
            Answer:
            """;

        var request = new { model = "qwen3.5:9b-q4_K_M", prompt, stream = false };
        using var response = await Client.PostAsJsonAsync("/api/generate", request);
        response.EnsureSuccessStatusCode();
        using var doc = JsonDocument.Parse(await response.Content.ReadAsStreamAsync());
        var answer = doc.RootElement.GetProperty("response").GetString()!;
        var sources = results.Select(r => $"{r.Chunk.Source}#{r.Chunk.Heading}").ToList();
        return new CitedAnswer(answer, sources);
    }
}
```

`Program.cs`:

```csharp
var result = await Lab8.AnswerWithCitationsAsync("What happens after 5 consecutive failures?");
Console.WriteLine(result.Answer);
Console.WriteLine("Chunks available to the model: " + string.Join(", ", result.AvailableSources));
```

```powershell
dotnet run
```

> [!WARNING]
> The model can still cite a source number that doesn't correspond to its claim, or claim a source supports something it doesn't. Citation instructions reduce ungrounded answers; they do not guarantee correctness. [Lab 9](#rag-lab9) measures this directly instead of trusting it.

### 🏋️ Exercise

Ask an unanswerable question (e.g. "What's the refund policy?") and confirm `available_sources` still lists two chunks (retrieval always returns `top_k` results) while the answer correctly says "I don't have that information" and lists no sources — proving "chunks were retrieved" and "chunks were relevant" are two different things.

---

<a id="rag-lab9"></a>

# Lab 9 — 🧪 Evaluate retrieval quality

A RAG system "feeling right" in a few manual tries is not evaluation. Build a tiny labeled test set. `lab9_eval.py`:

```python
from lab6_retrieve import retrieve

EVAL_SET = [
    {"question": "How many retries for a failed network call?", "expected_heading": "Transient failures"},
    {"question": "Should a 401 error be retried?", "expected_heading": "Non-retryable errors"},
    {"question": "How long does the circuit stay open?", "expected_heading": "Circuit breaker"},
    {"question": "What is the capital of France?", "expected_heading": None},  # unanswerable — expects no good match
]

def evaluate() -> None:
    correct = 0
    for case in EVAL_SET:
        top = retrieve(case["question"], top_k=1)[0]
        is_correct = top["heading"] == case["expected_heading"]
        if case["expected_heading"] is None:
            is_correct = top["score"] < 0.5  # low confidence is the "correct" behavior here
        correct += is_correct
        print(f"{'✅' if is_correct else '❌'} {case['question']!r} -> got {top['heading']!r} (score {top['score']:.3f})")

    print(f"\nRetrieval accuracy: {correct}/{len(EVAL_SET)}")

if __name__ == "__main__":
    evaluate()
```

```powershell
python lab9_eval.py
```

👀 **Expected output:** 3 or 4 out of 4 correct, with the unanswerable geography question flagged by its low similarity score. If it scores incorrectly, that's real signal to improve your chunking or add an explicit "no good match" threshold — not something to hand-wave past.

### 💜 C# equivalent

`Lab9.cs`:

```csharp
public static class Lab9
{
    public record EvalCase(string Question, string? ExpectedHeading);

    public static readonly List<EvalCase> EvalSet =
    [
        new("How many retries for a failed network call?", "Transient failures"),
        new("Should a 401 error be retried?", "Non-retryable errors"),
        new("How long does the circuit stay open?", "Circuit breaker"),
        new("What is the capital of France?", null) // unanswerable — expects no good match
    ];

    public static async Task EvaluateAsync()
    {
        int correct = 0;
        foreach (var c in EvalSet)
        {
            var top = (await Lab6.RetrieveAsync(c.Question, topK: 1))[0];
            bool isCorrect = c.ExpectedHeading is null
                ? top.Score < 0.5 // low confidence is the "correct" behavior here
                : top.Chunk.Heading == c.ExpectedHeading;
            correct += isCorrect ? 1 : 0;
            Console.WriteLine($"{(isCorrect ? "✅" : "❌")} \"{c.Question}\" -> got \"{top.Chunk.Heading}\" (score {top.Score:F3})");
        }
        Console.WriteLine($"\nRetrieval accuracy: {correct}/{EvalSet.Count}");
    }
}
```

`Program.cs`:

```csharp
await Lab9.EvaluateAsync();
```

```powershell
dotnet run
```

### 🧠 What this measures that a demo doesn't

- **Retrieval accuracy** — did the right chunk even get retrieved? (If not, no prompt engineering fixes the answer.)
- **Unanswerable detection** — does low similarity correctly signal "don't answer"?

A full production eval also checks citation correctness and groundedness (does the generated answer's claim actually appear in the cited chunk?) — extend `EVAL_SET` with expected-answer substrings and assert they appear in `answer_with_citations()`'s output as your next step.

### 🏋️ Exercise

Add one more case to `EVAL_SET` using a question you expect to be hard to retrieve correctly (ambiguous wording, or close to two headings at once). Run the eval, and if it scores ❌, try rewording the question until it passes — this is the real workflow of iterating on a RAG system's retrieval quality.

---

<a id="rag-lab10"></a>

# Lab 10 — 🔬 Experiment: chunk size vs. retrieval quality

`lab10_chunk_experiment.py`:

```python
from lab1_load import load_document

def chunk_fixed(text: str, size: int, overlap: int = 20) -> list[str]:
    chunks = []
    start = 0
    while start < len(text):
        chunks.append(text[start:start + size])
        start += size - overlap
    return chunks

if __name__ == "__main__":
    text = load_document("docs/retry-policy.md")
    for size in (80, 300, 1000):
        chunks = chunk_fixed(text, size)
        print(f"size={size:5d} -> {len(chunks)} chunks, e.g. chunk 0 = {chunks[0][:60]!r}")
```

```powershell
python lab10_chunk_experiment.py
```

👀 **Expected output:** `size=80` produces many tiny fragments that often split a sentence mid-word; `size=1000` may produce a single chunk containing the *entire* document (no retrieval benefit at all — the model gets everything regardless of relevance); `size=300` roughly matches one heading section.

### 💜 C# equivalent

`Lab10.cs`:

```csharp
public static class Lab10
{
    public static List<string> ChunkFixed(string text, int size, int overlap = 20)
    {
        var chunks = new List<string>();
        int start = 0;
        while (start < text.Length)
        {
            chunks.Add(text.Substring(start, Math.Min(size, text.Length - start)));
            start += size - overlap;
        }
        return chunks;
    }
}
```

`Program.cs`:

```csharp
var text = Lab1.LoadDocument("docs/retry-policy.md");
foreach (var size in new[] { 80, 300, 1000 })
{
    var chunks = Lab10.ChunkFixed(text, size);
    Console.WriteLine($"size={size,5} -> {chunks.Count} chunks, e.g. chunk 0 = \"{chunks[0][..Math.Min(60, chunks[0].Length)]}\"");
}
```

```powershell
dotnet run
```

### 🏋️ Exercise

Re-run [Lab 6's retrieval](#rag-lab6) using `chunk_fixed(text, 80)` instead of `chunk_by_heading`. Observe that answers can now be retrieved from a chunk that cuts off mid-sentence, sometimes losing the key number entirely. This is the concrete, observable cost of chunking too small — just as chunking too large loses retrieval's entire benefit.

---

<a id="rag-project"></a>

# 🏗️ Mini project: local-document Q&A CLI

Combine every lab into one script, `qa_cli.py`, that:

1. Accepts a folder of `.md` files as input and builds (or rebuilds) `docs/index.json` from **all** of them, not just `retry-policy.md` (reuse `build_index` from [Lab 5](#rag-lab5) in a loop over `Path(folder).glob("*.md")`).
2. Prompts the user for a question in a loop (`input("Ask: ")`).
3. Retrieves top-3 chunks across **all** indexed documents.
4. Calls `answer_with_citations` and prints the answer plus sources.
5. Exits cleanly on `exit` or `Ctrl+C`.

### ✅ Checkpoint — you're ready to move on when you can

- [ ] Explain the full pipeline from raw document to cited answer without looking anything up
- [ ] Explain why cosine similarity captures meaning rather than keyword overlap
- [ ] Show a question your system correctly refuses to answer, and why
- [ ] Show how a bad chunking strategy breaks a specific question
- [ ] Run the Lab 9 evaluation and interpret a failure

---

<a id="rag-capstone"></a>

# 🏋️ Progressive practice lab: baby steps → advanced

### 🐣 Tier 1 — baby steps

1. Load and print the character count of a document you write yourself (not `retry-policy.md`).
2. Chunk it by heading and print each chunk with its heading.
3. Embed one chunk and print the vector's length (should be 768 for `nomic-embed-text`).

### 🧒 Tier 2 — building confidence

4. Compute cosine similarity between two chunks from your own document and predict, before running, which pair should score higher based on topic.
5. Build a JSON index (Lab 5 style) from your own document and confirm the file contains one record per chunk, each with an embedding.
6. Retrieve the top-2 chunks for three questions you write yourself about your document, and check by eye whether the ranking matches what a human would pick.

### 🧑 Tier 3 — intermediate

7. Wire retrieval into `answer()` (Lab 7) for your own document and ask one answerable and one unanswerable question; confirm the unanswerable one is correctly declined.
8. Add citations (Lab 8) and verify the cited source genuinely contains the claimed fact — manually open the source chunk and check.
9. Build a 5-case evaluation set (Lab 9 style) for your own document, including at least one unanswerable case, and get at least 4/5 correct.

### 🏆 Tier 4 — advanced / capstone

10. Index **two** different documents at once and ask a question that should only be answerable from one of them; confirm the other document's chunks never outrank the correct one.
11. Run the chunk-size experiment (Lab 10) against your own document at three different fixed sizes, and identify by inspection which size best preserves your document's key facts without producing a single giant chunk.
12. Build the [mini project](#rag-project)'s `qa_cli.py` from memory for a folder of 3+ of your own documents, including a loop that keeps answering until the user types `exit`.

### ✅ Capstone checkpoint

- [ ] Completed all four tiers using your own documents, not the book's `retry-policy.md`
- [ ] Built and passed a 5-case evaluation set from scratch
- [ ] Can explain, unprompted, why chunk size is a retrieval-quality trade-off rather than a pure performance setting

---

<a id="rag-scale"></a>

# 🚀 Scaling up

This lab's "JSON file + cosine similarity loop" store does not scale past a few thousand chunks (it recomputes similarity against every record on every query). Once you outgrow it:

- **Persistent vector database** — move `docs/index.json` into a real vector store (e.g., via the [.NET vector-search/RAG quickstart](https://learn.microsoft.com/dotnet/ai/vector-stores/how-to/build-vector-search-app) referenced from [AI Journey](ai_journey.md#course-rag)) once you need approximate-nearest-neighbor search at scale, persistence across restarts, and filtering by metadata at the database level.
- **Hybrid search** — combine this lab's embedding similarity with the keyword search from [AI Journey section 10](ai_journey.md#course-rag) for queries where exact terms (IDs, error codes) matter more than semantic meaning.
- **Authorization before retrieval** — as emphasized in AI Journey, filter by the requester's access **before** a chunk is retrieved or scored, not after an answer is generated.
- **Production evaluation** — expand [Lab 9](#rag-lab9) into the groundedness/citation-correctness/latency/cost evaluation described in [AI Journey section 11](ai_journey.md#11--evaluate-trace-and-measure-cost).

## 🔗 Related topics

- [AI Journey — RAG section](ai_journey.md#course-rag) — the framework/cloud continuation of this lab.
- [Local AI Learning Lab](local_ai_learning_lab.md) — the Ollama/Qwen setup this lab depends on.
- [Building Agents & Multi-Agent Systems](agents_and_subagents_lab.md) — the next step once an agent needs to decide *when* to retrieve, not just answer with fixed context.

## ➡️ Next

Continue to **[Building Agents & Multi-Agent Systems](agents_and_subagents_lab.md)**, or return to the **[README](README.md)** for the full map.
