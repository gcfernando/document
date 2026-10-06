# 🚀 Local vs. Cloud LLM: A Hands-On Head-to-Head

> Run the exact same small task against your local Ollama model and a cloud provider, back-to-back, and compare latency, output, and tokens with real numbers instead of assumptions.

## 🎯 What You Will Build

One Python script that sends the same sentiment-classification prompt to **both** a local Ollama model and a cloud provider (OpenAI, as set up in [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md)), times each call, and prints a side-by-side comparison. Then a reference comparison table and decision guidance for choosing local vs. cloud vs. hybrid in a real project.

## 📚 Prerequisites

- [`local_ai_learning_lab.md`](local_ai_learning_lab.md#lab-build) — Ollama installed and a model pulled (this lab assumes `qwen3.5:9b-q4_K_M`, substitute whatever you pulled).
- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md) — your `OPENAI_API_KEY` environment variable set, and familiarity with the Responses API shape used below.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) if you want the deeper mechanism-level background on what's happening inside the local call; not required to run this lab.

## 🏷️ Difficulty: 🟡 Intermediate

## 🛠️ Setup

```powershell
ollama pull qwen3.5:9b-q4_K_M
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install requests
$env:OPENAI_API_KEY = "sk-...your-real-key..."
```

---

## 🚀 Experiment 1 — the same task, two engines, one script

The task: classify the sentiment of one short sentence as exactly `positive`, `negative`, or `neutral`, measuring wall-clock latency for each call.

### 💻 Code (Python — the only language needed for this comparison script)

`compare.py`:

```python
import os
import time
import requests

OLLAMA_URL = "http://127.0.0.1:11434/api/generate"
OLLAMA_MODEL = "qwen3.5:9b-q4_K_M"

OPENAI_URL = "https://api.openai.com/v1/responses"
OPENAI_MODEL = "gpt-5.5"
OPENAI_KEY = os.environ.get("OPENAI_API_KEY")

SENTENCE = "The onboarding docs were confusing, but support fixed it within minutes."
PROMPT = f'Classify the sentiment of this sentence as exactly one word — positive, negative, or neutral: "{SENTENCE}"'


def run_local() -> dict:
    start = time.perf_counter()
    response = requests.post(
        OLLAMA_URL,
        json={"model": OLLAMA_MODEL, "prompt": PROMPT, "stream": False},
        timeout=60,
    )
    response.raise_for_status()
    elapsed = time.perf_counter() - start
    body = response.json()
    return {
        "engine": "local (Ollama)",
        "text": body["response"].strip(),
        "latency_s": round(elapsed, 2),
        # Verified Ollama response fields (api.md): prompt_eval_count = input
        # tokens, eval_count = output tokens.
        "input_tokens": body.get("prompt_eval_count"),
        "output_tokens": body.get("eval_count"),
    }


def run_cloud() -> dict:
    if not OPENAI_KEY:
        raise RuntimeError("Set OPENAI_API_KEY before running the cloud half of this comparison.")
    start = time.perf_counter()
    response = requests.post(
        OPENAI_URL,
        headers={"Authorization": f"Bearer {OPENAI_KEY}", "Content-Type": "application/json"},
        json={"model": OPENAI_MODEL, "input": PROMPT},
        timeout=60,
    )
    response.raise_for_status()
    elapsed = time.perf_counter() - start
    body = response.json()
    message_item = next(item for item in body["output"] if item["type"] == "message")
    text = message_item["content"][0]["text"].strip()
    # ⚠️ Exact usage key names unverified this session — see cloud_llm_practical_guide.md Step 6.
    usage = body.get("usage", {})
    return {
        "engine": "cloud (OpenAI Responses API)",
        "text": text,
        "latency_s": round(elapsed, 2),
        "input_tokens": usage.get("input_tokens", usage.get("prompt_tokens")),
        "output_tokens": usage.get("output_tokens", usage.get("completion_tokens")),
    }


if __name__ == "__main__":
    results = [run_local(), run_cloud()]
    print(f"{'Engine':<32} {'Latency (s)':<12} {'In tok':<8} {'Out tok':<8} Reply")
    for r in results:
        print(f"{r['engine']:<32} {r['latency_s']:<12} {str(r['input_tokens']):<8} {str(r['output_tokens']):<8} {r['text']}")
```

```powershell
python compare.py
```

## 👀 Expected Output

Two rows, one per engine, something like:

```text
Engine                          Latency (s)  In tok   Out tok  Reply
local (Ollama)                  1.8          24       3        positive
cloud (OpenAI Responses API)    0.6          26       3        positive
```

⚠️ **Needs runtime verification on your machine:** actual numbers depend entirely on your hardware (local), your network (cloud), and both providers' live load. Don't trust these illustrative numbers; run the script and record what you actually see. A slower-than-expected local result on modest hardware without a GPU is common and expected, not a bug.

## 🧠 What Just Happened?

Both calls answered the *same* classification prompt through the *same* kind of HTTP interface (one against `localhost`, one across the internet) — the only things that differ are where the model executes, how it's billed, and what "network latency" includes for each. Note qualitatively: for a sentence this short and a task this constrained, both engines typically agree on the label and reply with the exact one word you asked for; the interesting differences usually show up on *longer, more ambiguous, or more open-ended* prompts, where a larger cloud model has an edge in nuance and a small local model has an edge in... nothing except cost and privacy. Try a harder sentence (sarcasm, mixed sentiment) yourself and compare the two replies' quality, not just their speed.

## 🏋️ Exercise

Change `SENTENCE` to a genuinely ambiguous or sarcastic example (e.g. `"Oh great, another Monday meeting that could have been an email."`) and run the script again. Record whether the local and cloud models agree on the label, and write one sentence on which felt more "correct" to you and why — this is a qualitative judgment call, not something the script can measure for you.

## ✅ Checkpoint

You've run one real task against both engines and can point to an actual measured latency number for each, not a guess.

---

## 🚀 Experiment 2 — the structural comparison

| Dimension | Local (Ollama) | Cloud (OpenAI-style API) |
|---|---|---|
| **Setup complexity** | Install runtime + pull model (~GBs download), no account needed. | Create account, generate API key, add billing — no local install. |
| **Privacy / data residency** | Prompt and response never leave your machine. | Prompt and response are sent to the provider's servers; subject to their data-use/retention policy (Responses API is **stored by default** per OpenAI's own migration guide — set `store: false` if you need to disable that). |
| **Offline availability** | Works with no internet connection once the model is pulled. | Requires network connectivity; outages on either side break the call. |
| **Cost model** | No per-call price; cost is your hardware + electricity, already sunk/ongoing regardless of usage. | Per-token billing (see [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md#-step-6--token-usage-and-a-cost-awareness-estimate) — use real current rates, not placeholders, for a real budget). |
| **Context window (approximate)** | ❓ Not independently verified this session for `qwen3.5` — the model's own publisher page did not surface a single definitive context-length figure in the portion fetched; check `ollama show qwen3.5:9b-q4_K_M` locally (`PARAMETER` section) for your exact pulled build's configured context, or fall back to one you already configured yourself, e.g. the `32,768`-token profile built in [`local_ai_learning_lab.md`](local_ai_learning_lab.md#lab-profile). | ❓ Not independently verified this session — check the provider's current, model-specific context-window figure on their live model list (e.g. `platform.openai.com/docs/models`) rather than trusting any number written in a guide like this one, since this changes per model and over time. |
| **Scalability** | Bounded by your own hardware (one machine, one GPU/CPU) — scaling out means buying/provisioning more machines yourself. | Provider scales capacity for you; you scale by paying for more calls, subject to your [rate limit tier](cloud_llm_practical_guide.md#-step-3--errors-a-real-documented-401-and-429-handled). |
| **Maintainability** | You own model updates, driver/runtime upgrades, and uptime. | Provider owns model hosting/uptime; you own API-version and model-deprecation migration (see [model selection](cloud_llm_practical_guide.md#-step-2--model-selection-and-why-no-model-name-is-a-permanent-fact)). |

## 🧠 Decision Guidance

**Choose local when:** the data must never leave the machine/network (compliance, confidential source material), you need offline/air-gapped operation, you're iterating rapidly and don't want per-call billing anxiety, or the task is simple enough that a small local model's quality is good enough (as Experiment 1 showed for plain sentiment classification).

**Choose cloud when:** you need the strongest available reasoning/quality for a hard or ambiguous task, you don't want to own GPU hardware or model-update maintenance, you need to scale request volume elastically without provisioning your own capacity, or your users are distributed and a provider's global infrastructure beats your own single machine's latency.

**Consider hybrid when:** you route *simple/cheap/sensitive* requests to local and *hard/complex* requests to cloud (the routing pattern in [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md) is directly reusable here with "local vs. cloud" as the routing axis instead of "small vs. large model") — or when you prototype against a free local model and only switch specific, validated prompts to a paid cloud model once you've proven they need the extra quality.

## 🔗 Related Topics

- [`cloud_llm_practical_guide.md`](cloud_llm_practical_guide.md) — full cloud API mechanics used in Experiment 1's cloud half.
- [`local_ai_learning_lab.md`](local_ai_learning_lab.md) — full local setup used in Experiment 1's local half.
- [`rag_embeddings_lab.md`](rag_embeddings_lab.md) — what to build once you've picked an engine (or both, via the hybrid pattern) for a real retrieval-augmented application.
- [`ai_cost_performance_guide.md`](ai_cost_performance_guide.md) — the deeper routing/caching pattern referenced in the hybrid guidance above.

## ➡️ Next

Continue to [`prompting_structured_output_streaming_guide.md`](prompting_structured_output_streaming_guide.md) to get more reliable, structured answers out of either engine — or to [`rag_project_dotnet_and_python.md`](rag_project_dotnet_and_python.md) to build a full application on top of whichever engine (or both) you chose here.
