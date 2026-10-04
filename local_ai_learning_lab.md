# 🚀 Local AI Learning Lab
## 🧠 Qwen3.5 9B · 🦙 Ollama · 🐍 Python · 🎨 Streamlit · 🤖 Agents · 📚 RAG · 🔌 MCP

> **Validated guide — 4 October 2026**
>
> This edition was rebuilt from scratch. Commands were checked against the current
> official Ollama, Streamlit, VS Code, OpenAI Codex, and Claude Code documentation.
> The included `main.py` was also syntax-checked with Python.

---

## 🎨 Project Configuration

| Area | Configuration |
|---|---|
| 🧠 Model family | **Qwen3.5 9B** |
| 📦 Ollama model | `qwen3.5:9b-q4_K_M` |
| 🗜️ Quantization | `Q4_K_M` |
| 💾 Current Ollama package size | about **6.6 GB** |
| 💬 Chat profile | `qwen35-9b-32k` |
| 🤖 Coding-agent profile | `qwen35-9b-64k` |
| 🦙 Runtime | **Ollama** |
| 🐍 Python | **3.12** in this project |
| 🎨 Chat UI | **Streamlit** |
| 🎭 Role | **Expert Chat Assistant** |

> [!NOTE]
> This document is **hardware-neutral**. It does not assume a particular CPU, GPU,
> RAM amount, or laptop model. Larger models and larger contexts require more memory.

---

# 🧭 Read This First

This guide is written for **Windows + PowerShell + VS Code**.

It intentionally does **not** use a Python virtual environment.

Official Streamlit documentation recommends isolated Python environments for normal
project work, but the commands below follow the chosen setup: packages are installed
into the Python interpreter returned by the `python` command.

### 🟢 Rule 1 — Run one command at a time

Do not copy terminal output back into the terminal.

### 🟢 Rule 2 — Do not type the prompt symbol

If your terminal shows:

```text
PS C:\Projects\AIChat>
```

you type only the command after `>`.

### 🟢 Rule 3 — Stop if a verification step fails

Do not continue to the next section until the current verification succeeds.

### 🟢 Rule 4 — For this Streamlit app, never start it with `python main.py`

Use:

```powershell
python -m streamlit run main.py
```

That distinction is extremely important.

---

# 🐍 Step 0 — Verify Python

Run:

```powershell
python --version
```

For this guide, Python **3.12** is ideal.

Current Streamlit 1.64 supports Python **3.10 through 3.14**.

Now verify which Python executable is actually being used:

```powershell
python -c "import sys; print(sys.executable)"
```

Example:

```text
C:\Program Files\Python312\python.exe
```

> [!IMPORTANT]
> Remember this path. Every `python -m pip ...` command below installs packages into
> this Python interpreter.

---

# 🦙 Step 1 — Verify Ollama

Run:

```powershell
ollama --version
```

If you see a version number, the Ollama CLI is installed.

Now check that the Ollama Windows application/server is available:

```powershell
ollama ls
```

A valid result looks similar to:

```text
NAME                     ID              SIZE      MODIFIED
qwen3.5:9b-q4_K_M        ...             6.6 GB    ...
```

It is also normal for the list to be empty before downloading a model.

> [!NOTE]
> On Windows, the normal Ollama application runs in the background and serves its API
> on `http://localhost:11434`. You normally do **not** need to run `ollama serve`
> manually when the Windows app is already running.

If Ollama is not installed, install the official Windows application from:

**https://ollama.com/download/windows**

Then close and reopen PowerShell before repeating the checks above.

---

# 📥 Step 2 — Download the Exact Qwen Model

Run:

```powershell
ollama pull qwen3.5:9b-q4_K_M
```

Wait for the pull to finish.

Now verify:

```powershell
ollama ls
```

You should see:

```text
qwen3.5:9b-q4_K_M
```

The current Ollama registry reports this package at approximately **6.6 GB**. The
main model is reported as **8.95B Q4_K_M**, with a separate **456M BF16 vision
projector**.

---

# 🧪 Step 3 — Test the Base Model Before Customizing Anything

Run:

```powershell
ollama run qwen3.5:9b-q4_K_M
```

Ollama now enters interactive chat mode.

Type:

```text
Hello. Reply with exactly: Qwen is working.
```

You should receive a response from the model.

To leave the Ollama chat:

```text
/bye
```

> 🟢 **Do not continue until the base model responds successfully.**

---

# 🧠 Step 4 — Create the 32K Chat Profile

The downloaded model and the 32K model are not two different LLMs.

```text
qwen3.5:9b-q4_K_M
        │
        │ same underlying model
        ▼
qwen35-9b-32k
        │
        └── context configured to 32,768 tokens
```

## 4.1 Create the Modelfile

In your project folder, create a plain-text file named:

```text
Modelfile.32k
```

Put **exactly** this inside:

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 32768
```

Save the file.

## 4.2 Verify the file before using it

In PowerShell, from the folder containing the file:

```powershell
Get-Content .\Modelfile.32k
```

Expected output:

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 32768
```

## 4.3 Create the custom Ollama profile

Run:

```powershell
ollama create qwen35-9b-32k -f .\Modelfile.32k
```

Wait for:

```text
success
```

## 4.4 Verify that the profile exists

Run:

```powershell
ollama ls
```

You should now see both names:

```text
qwen3.5:9b-q4_K_M
qwen35-9b-32k
```

## 4.5 Inspect its generated Modelfile

Run:

```powershell
ollama show --modelfile qwen35-9b-32k
```

Look for a context parameter corresponding to your configuration.

## 4.6 Run it

```powershell
ollama run qwen35-9b-32k
```

Ask:

```text
Reply with exactly: 32K profile is working.
```

Keep this terminal open.

Open a **second PowerShell terminal** and run:

```powershell
ollama ps
```

Check the `CONTEXT` column. The loaded custom profile should report:

```text
32768
```

Return to the first terminal and exit:

```text
/bye
```

---

# 🧠 What Does 32K Mean?

`32K` means a context window of approximately:

```text
32,768 tokens
```

It does **not** mean a 32-billion-parameter model.

The context contains information such as:

```text
System prompt
+ previous user messages
+ previous assistant responses
+ source code
+ tool definitions
+ tool results
+ RAG chunks
+ the current question
+ generated output
```

### Example

```text
System prompt              2K
Conversation              12K
Source code                8K
RAG context                5K
Current question           1K
-----------------------------
Total                     28K
```

This fits inside 32K.

---

# 🧹 What Happens When the Context Gets Full?

The model does **not** permanently run out of tokens.

The context window is temporary working memory.

As a chat grows, older information can eventually fall outside the active context or
be truncated/managed by the calling application.

That is why a long conversation can appear to "forget" something mentioned much
earlier.

Inside Ollama interactive chat, clear the current chat with:

```text
/clear
```

This clears conversation context. It does **not** delete the model.

Exit with:

```text
/bye
```

In the Streamlit application in this guide, the equivalent operation is:

```python
st.session_state["messages"] = []
```

---

# 🟠 32K vs 64K — Use Them for Different Jobs

Current Ollama documentation says large-context workloads such as **web search,
agents, and coding tools should use at least 64,000 tokens**, while also warning
that larger context requires more memory.

Use this simple rule:

| Workload | Profile |
|---|---|
| 💬 Streamlit chat | `qwen35-9b-32k` |
| 🧪 Normal AI learning | `qwen35-9b-32k` |
| 📚 Basic RAG practice | `qwen35-9b-32k` |
| 🛠️ Tool-calling practice | `qwen35-9b-32k` |
| 💾 Memory practice | `qwen35-9b-32k` |
| 🤖 Small agents | `qwen35-9b-32k` |
| 🧑‍💻 Codex | `qwen35-9b-64k` |
| 🛠️ Claude Code | `qwen35-9b-64k` |
| 📂 Large repository agent work | `qwen35-9b-64k` |

---

# 🤖 Step 5 — Optional: Create the 64K Coding-Agent Profile

Create another file:

```text
Modelfile.64k
```

Put exactly:

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 65536
```

Verify it:

```powershell
Get-Content .\Modelfile.64k
```

Create the profile:

```powershell
ollama create qwen35-9b-64k -f .\Modelfile.64k
```

Verify:

```powershell
ollama ls
```

Run it:

```powershell
ollama run qwen35-9b-64k
```

In a second terminal:

```powershell
ollama ps
```

Check for:

```text
CONTEXT
65536
```

Then exit the interactive model:

```text
/bye
```

> [!WARNING]
> A 64K context uses more memory than 32K. If the computer becomes noticeably slow,
> use the 32K profile for normal learning and reserve 64K for coding-agent tests.

---

# 📦 Step 6 — Install the Python Packages

This guide intentionally does not create `.venv`.

First update pip for the selected Python interpreter:

```powershell
python -m pip install --upgrade pip
```

Install the official Ollama Python client and Streamlit:

```powershell
python -m pip install --upgrade ollama streamlit
```

Now verify **both imports using the same Python interpreter**:

```powershell
python -c "from ollama import Client, ResponseError; import streamlit; print('Ollama Python + Streamlit: OK')"
```

Expected:

```text
Ollama Python + Streamlit: OK
```

Check the installed versions:

```powershell
python -c "import ollama, streamlit; print('Ollama Python:', ollama.__version__); print('Streamlit:', streamlit.__version__)"
```

> 🟢 **Do not create or run the application until the import verification prints OK.**

---

# 📁 Step 7 — Create the Project Files

Use this structure:

```text
AIChat/
└── Console_Code/
    ├── main.py
    ├── requirements.txt
    ├── Modelfile.32k
    └── Modelfile.64k
```

`Modelfile.64k` is optional.

## `requirements.txt`

Create `requirements.txt` containing exactly:

```text
ollama
streamlit
```

You can verify that file with:

```powershell
Get-Content .\requirements.txt
```

Expected:

```text
ollama
streamlit
```

---

# 💻 Step 8 — Create `main.py`

Use the following code exactly.

```python
# Developer ::> Gehan Fernando

"""Local Streamlit chat assistant powered by Ollama."""

from collections.abc import Iterator

import streamlit as st
from ollama import Client, ResponseError

# ============================================================
# Application Configuration
# ============================================================

OLLAMA_HOST = "http://127.0.0.1:11434"
MODEL_NAME = "qwen35-9b-32k"


# ============================================================
# Expert Chat Assistant System Prompt
# ============================================================

SYSTEM_PROMPT = """
You are an Expert Chat Assistant.

Your role is to provide accurate, clear, practical, and reliable answers
across software engineering, artificial intelligence, general knowledge,
writing, learning, problem solving, and everyday questions.

Follow these rules:

1. Accuracy
   - Prioritize correctness over speed.
   - Do not invent facts, APIs, commands, libraries, functions, sources,
     capabilities, or results.
   - If you are uncertain, clearly say what is uncertain.
   - Distinguish facts from assumptions and estimates.

2. Technical Questions
   - Give technically correct and practical answers.
   - Prefer simple, maintainable solutions.
   - Explain important concepts clearly.
   - When giving code, provide complete working examples when appropriate.
   - Consider errors, edge cases, security, performance, and compatibility.
   - Never claim code was tested unless it was actually tested.

3. AI and Software Engineering
   - Explain concepts from first principles when useful.
   - Clearly distinguish concepts such as:
       * LLMs
       * prompts
       * context windows
       * embeddings
       * RAG
       * memory
       * tools
       * function calling
       * agents
       * agentic workflows
       * MCP
   - Prefer practical examples that can be implemented locally.

4. Coding
   - Use clear and maintainable code.
   - Avoid unnecessary complexity.
   - Explain why important parts of the solution exist.
   - Do not use imaginary APIs or packages.
   - Mention required dependencies when relevant.

5. Reasoning
   - Think carefully before answering.
   - Break complicated problems into understandable parts.
   - Do not expose private chain-of-thought.
   - Provide concise explanations of reasoning when useful.

6. Writing
   - Preserve the intended meaning.
   - Use clear and professional language.
   - Match the requested tone and audience.

7. General Questions
   - Answer the question directly first.
   - Then provide only the explanation needed to understand the answer.
   - Avoid unnecessary filler or repetition.

8. Limitations
   - You are a locally running language model.
   - You do not automatically have access to the internet, current news,
     private files, databases, APIs, or external systems.
   - Never pretend that you accessed information you cannot access.

Default behavior:
- Be helpful.
- Be precise.
- Be practical.
- Be concise unless the user asks for more detail.
""".strip()


# ============================================================
# Session State
# ============================================================


def initialize_session_state() -> None:
    """Initialize application session-state values."""

    if "messages" not in st.session_state:
        st.session_state["messages"] = []

    if "temperature" not in st.session_state:
        st.session_state["temperature"] = 0.2


# ============================================================
# Ollama
# ============================================================


@st.cache_resource
def get_ollama_client() -> Client:
    """Create and cache the Ollama client."""

    return Client(host=OLLAMA_HOST)


def build_messages() -> list[dict[str, str]]:
    """Build the conversation sent to Ollama."""

    messages = [
        {
            "role": "system",
            "content": SYSTEM_PROMPT,
        }
    ]

    messages.extend(st.session_state["messages"])

    return messages


def stream_response(
    client: Client,
    messages: list[dict[str, str]],
    temperature: float,
) -> Iterator[str]:
    """Stream an Ollama chat response one chunk at a time."""

    response_stream = client.chat(
        model=MODEL_NAME,
        messages=messages,
        stream=True,
        think=False,
        options={
            "temperature": temperature,
        },
        keep_alive="10m",
    )

    for chunk in response_stream:
        content = chunk.message.content

        if content:
            yield content


# ============================================================
# Conversation Management
# ============================================================


def clear_conversation() -> None:
    """Clear the current conversation history."""

    st.session_state["messages"] = []


# ============================================================
# Sidebar
# ============================================================


def render_sidebar() -> None:
    """Render the application settings sidebar."""

    with st.sidebar:
        st.header("⚙️ Settings")

        st.write("### Model")
        st.code(MODEL_NAME, language=None)

        st.write("### Role")
        st.success("Expert Chat Assistant")

        st.divider()

        st.session_state["temperature"] = st.slider(
            "Temperature",
            min_value=0.0,
            max_value=1.0,
            value=st.session_state["temperature"],
            step=0.1,
            help=(
                "Lower values are more consistent and deterministic. "
                "Higher values give more creative responses."
            ),
        )

        st.divider()

        if st.button(
            "🗑️ Clear Conversation",
            use_container_width=True,
            type="secondary",
        ):
            clear_conversation()
            st.rerun()

        st.divider()

        st.caption("Ollama Server")
        st.code(OLLAMA_HOST, language=None)

        st.caption("The model runs locally through Ollama.")


# ============================================================
# Welcome Message
# ============================================================


def render_welcome_message() -> None:
    """Display the initial welcome message."""

    if st.session_state["messages"]:
        return

    with st.chat_message("assistant"):
        st.markdown(f"""
Hello! I'm your **Expert Chat Assistant** running locally using
**{MODEL_NAME}**.

You can ask me about:

- Software development
- Python
- C# / .NET
- AI and machine learning
- RAG
- Agents
- Agentic AI
- MCP
- Architecture
- Debugging
- Writing
- Learning
- General questions

What would you like to work on?
""")


# ============================================================
# Conversation History
# ============================================================


def render_conversation_history() -> None:
    """Display all messages from the current conversation."""

    for message in st.session_state["messages"]:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])


# ============================================================
# User Message Processing
# ============================================================


def process_user_message(client: Client) -> None:
    """Process the current user input and generate a response."""

    user_prompt = st.chat_input("Ask your Expert Chat Assistant...")

    if not user_prompt:
        return

    user_message = {
        "role": "user",
        "content": user_prompt,
    }

    st.session_state["messages"].append(user_message)

    with st.chat_message("user"):
        st.markdown(user_prompt)

    with st.chat_message("assistant"):
        try:
            messages = build_messages()

            assistant_response = st.write_stream(
                stream_response(
                    client=client,
                    messages=messages,
                    temperature=st.session_state["temperature"],
                )
            )

            st.session_state["messages"].append(
                {
                    "role": "assistant",
                    "content": assistant_response,
                }
            )

        except ResponseError as error:
            st.error(f"Ollama returned an error:\n\n{error.error}")

        except ConnectionError:
            st.error(f"""
Cannot connect to Ollama.

Make sure Ollama is running on:

{OLLAMA_HOST}
""")


# ============================================================
# Application
# ============================================================


def main() -> None:
    """Run the Streamlit application."""

    st.set_page_config(
        page_title="Expert Chat Assistant",
        page_icon="🤖",
        layout="wide",
    )

    initialize_session_state()

    client = get_ollama_client()

    render_sidebar()

    st.title("🤖 Expert Chat Assistant")
    st.caption(f"Local AI • {MODEL_NAME} • Ollama")
    st.divider()

    render_welcome_message()
    render_conversation_history()
    process_user_message(client)


if __name__ == "__main__":
    main()

```

---

# 🔍 Step 9 — Validate `main.py` Before Starting Streamlit

From the folder containing `main.py`, run:

```powershell
python -m py_compile main.py
```

### Expected result

**No output means the Python syntax is valid.**

Now verify the imports one more time:

```powershell
python -c "from ollama import Client, ResponseError; import streamlit as st; print('Imports: OK')"
```

Expected:

```text
Imports: OK
```

Make sure your 32K Ollama profile exists:

```powershell
ollama ls
```

You must see:

```text
qwen35-9b-32k
```

---

# ▶️ Step 10 — Start Streamlit the Correct Way

## ❌ Wrong

Do **not** run:

```powershell
python main.py
```

A Streamlit application started this way runs without Streamlit's normal runtime
context and can produce warnings such as:

```text
missing ScriptRunContext
Session state does not function when running a script without `streamlit run`
```

## ✅ Correct

Run:

```powershell
python -m streamlit run main.py
```

Streamlit should print a local URL, normally:

```text
http://localhost:8501
```

Open that address in a browser if it does not open automatically.

### Stop the app

Return to the terminal and press:

```text
Ctrl+C
```

> [!TIP]
> `streamlit run main.py` is also valid when the `streamlit` executable is on PATH.
> This guide uses `python -m streamlit run main.py` as the primary command because it
> guarantees Streamlit comes from the same Python interpreter used for package
> installation.

---

# 💬 Step 11 — Test the Chat Application

## Test 1 — Basic response

Ask:

```text
Who are you and what is your role?
```

Expected behavior: it should identify itself as an Expert Chat Assistant.

## Test 2 — Technical behavior

Ask:

```text
Explain dependency injection in ASP.NET Core for a beginner.
```

## Test 3 — Conversation state

Ask:

```text
For this conversation, my project name is Alpha.
```

Then ask:

```text
What is my project name?
```

Expected:

```text
Alpha
```

Why? Because `st.session_state["messages"]` stores the current conversation and your
code sends those messages back to the model.

## Test 4 — Clear conversation

Click:

```text
🗑️ Clear Conversation
```

Then ask:

```text
What is my project name?
```

The previous conversation should no longer be available.

This is **conversation state**, not persistent long-term memory.

---

# 🧩 Validated API Map for `main.py`

| Code used | Why it is valid |
|---|---|
| `Client(host=OLLAMA_HOST)` | Supported by the official Ollama Python client |
| `ResponseError` | Official Ollama Python exception type |
| `ConnectionError` | Ollama client converts connection failures to this exception |
| `client.chat(...)` | Official chat API |
| `stream=True` | Official streaming mode |
| `think=False` | Current Ollama chat parameter |
| `options={"temperature": ...}` | Current Ollama runtime options |
| `keep_alive="10m"` | Current Ollama chat parameter |
| `chunk.message.content` | Current `ChatResponse` object access pattern |
| `@st.cache_resource` | Current Streamlit resource cache API |
| `st.session_state[...]` | Current Streamlit session state API |
| `st.chat_message(...)` | Current Streamlit chat API |
| `st.chat_input(...)` | Current Streamlit chat API |
| `st.write_stream(...)` | Current Streamlit streaming output API |
| `st.rerun()` | Current Streamlit rerun API |

---

# 🔄 How the Chat Application Works

```text
┌────────────────────────────────────────────┐
│                 👤 USER                    │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│             🎨 STREAMLIT UI                │
│  chat_input · chat_message · session_state │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│              🐍 PYTHON APP                 │
│    system prompt + conversation history    │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│         🦙 OLLAMA PYTHON CLIENT            │
│          http://127.0.0.1:11434            │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│           🧠 qwen35-9b-32k                 │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
                 streamed answer
```

---

# 🎭 System Prompt vs Conversation

Every model request is built like this:

```text
SYSTEM
"You are an Expert Chat Assistant ..."

USER
First question

ASSISTANT
First answer

USER
Next question
```

The permanent role comes from:

```python
SYSTEM_PROMPT
```

The temporary conversation comes from:

```python
st.session_state["messages"]
```

Clicking **Clear Conversation** removes the second part, but the system prompt is still
added again on the next request.

---

# 🌡️ Temperature

Your app starts with:

```python
0.2
```

Use this mental model:

| Value | Typical behavior |
|---:|---|
| `0.0 – 0.2` | focused, consistent, technical |
| `0.2 – 0.4` | coding and general assistant |
| `0.5 – 0.7` | brainstorming |
| `0.7 – 1.0` | more varied / creative |

For an Expert Chat Assistant, `0.2` is a sensible starting value.

---

# ⚡ Streaming

Your code uses:

```python
stream=True
```

Without streaming:

```text
question
   ↓
wait
   ↓
full response
```

With streaming:

```text
question
   ↓
The
The answer
The answer is ...
```

The Ollama client yields response chunks and Streamlit displays them with:

```python
st.write_stream(...)
```

---

# 🧠 Conversation State Is Not Long-Term Memory

Current app:

```text
Browser session
      │
      ▼
st.session_state["messages"]
      │
      ▼
Qwen context
```

If the Streamlit session disappears or conversation is cleared, that history is gone.

Future persistent memory will look more like:

```text
User
  │
  ▼
Agent
  ├── recent conversation
  ├── SQLite / PostgreSQL
  └── vector/semantic memory
            │
            ▼
          Qwen
```

---

# 📚 RAG Is Different From Memory

RAG:

```text
Documents
   ↓
Chunking
   ↓
Embeddings
   ↓
Vector database
   ↓
Retrieve relevant chunks
   ↓
Qwen
   ↓
Grounded answer
```

Memory:

```text
Conversation / events
   ↓
Extract useful facts or state
   ↓
Persistent store
   ↓
Retrieve later when relevant
```

They solve related but different problems.

---

# 🤖 What Makes an Agent?

A plain chatbot:

```text
User → LLM → Answer
```

An agent:

```text
User goal
   ↓
LLM decides next action
   ↓
Tool call
   ↓
Tool result
   ↓
LLM observes
   ↓
Decides again
   ↓
Final result
```

The LLM is the **brain**.

The agent is the **system around the brain**.

---

# 🔌 What Is MCP?

MCP gives AI clients a standardized way to work with external tools/resources.

```text
Agent
  ↓
MCP Client
  ↓
MCP Server
  ├── files
  ├── databases
  ├── APIs
  └── developer tools
```

Learn normal tool/function calling before MCP. The MCP architecture becomes much
easier to understand afterward.

---

# 🟦 VS Code + Local Qwen

Current VS Code documentation says the old built-in Ollama provider is deprecated.
Use the **official Ollama extension**.

## Install the extension using the VS Code UI

1. Open VS Code.
2. Press:

```text
Ctrl+Shift+X
```

3. Search for:

```text
@id:Ollama.ollama
```

4. Confirm the publisher is **Ollama**.
5. Install it.

If the `code` CLI is already available, this command is also valid:

```powershell
code --install-extension Ollama.ollama
```

## Configure the model

Press:

```text
Ctrl+Shift+P
```

Run:

```text
Chat: Manage Language Models
```

Select the Ollama-provided local model and choose the profile you want to use.

### Important Copilot limitation

Local Ollama models can be used for supported VS Code **chat/tools/MCP workflows**.

They do **not** replace GitHub Copilot's cloud-backed inline code suggestions.

---

# 🟧 Codex + Local Qwen

> [!IMPORTANT]
> Current Ollama Codex documentation says to use **at least 64K context** for Codex.

Use:

```text
qwen35-9b-64k
```

First verify Node.js/npm:

```powershell
node --version
```

```powershell
npm --version
```

If either command is missing, install the current Node.js LTS release from:

**https://nodejs.org/**

Then install/update Codex CLI:

```powershell
npm install -g @openai/codex@latest
```

Verify:

```powershell
codex --version
```

Start Codex using the local Ollama model:

```powershell
codex --oss -m qwen35-9b-64k
```

This uses Codex's Ollama/open-source mode with the specified local model.

---

# 🟥 Claude Code + Local Qwen

> [!IMPORTANT]
> Current Ollama Claude Code documentation recommends **64K+ context** for local
> models and larger repositories.

Install Claude Code on Windows PowerShell:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Then launch Claude Code through Ollama with your 64K local profile:

```powershell
ollama launch claude --model qwen35-9b-64k
```

Conceptually:

```text
Claude Code
    │
    ├── reads files
    ├── edits files
    ├── runs commands
    ├── uses tools
    └── manages agent loops
          │
          ▼
       Ollama
          │
          ▼
  qwen35-9b-64k
```

Qwen is the model; Claude Code is the coding/agent harness.

---

# 🛠️ Troubleshooting — Follow the Exact Error

## ❌ Error: `No module named 'ollama'`

Run:

```powershell
python -m pip install --upgrade ollama
```

Verify:

```powershell
python -c "import ollama; print('Ollama Python import: OK')"
```

---

## ❌ Error: `No module named 'streamlit'`

Run:

```powershell
python -m pip install --upgrade streamlit
```

Verify:

```powershell
python -c "import streamlit; print('Streamlit import: OK')"
```

---

## ⚠️ Warning: `missing ScriptRunContext`

You probably ran:

```powershell
python main.py
```

Stop.

Run:

```powershell
python -m streamlit run main.py
```

---

## ❌ Python package installed but import still fails

Find the Python interpreter:

```powershell
python -c "import sys; print(sys.executable)"
```

Then check where pip is installing:

```powershell
python -m pip --version
```

Both commands should refer to the same Python installation.

---

## ❌ Cannot connect to Ollama

First check whether the Ollama CLI can communicate with its server:

```powershell
ollama ls
```

Then test the model directly:

```powershell
ollama run qwen35-9b-32k
```

If the model works in the Ollama terminal but not in Python, verify the Python client
with:

```powershell
python -c "from ollama import Client; c=Client(host='http://127.0.0.1:11434'); print(c.list())"
```

---

## ❌ `qwen35-9b-32k` not found

Check:

```powershell
ollama ls
```

If it is absent, make sure `Modelfile.32k` exists:

```powershell
Get-Content .\Modelfile.32k
```

Then recreate it:

```powershell
ollama create qwen35-9b-32k -f .\Modelfile.32k
```

---

## 🐌 Computer becomes slow

Check loaded models and allocated context:

```powershell
ollama ps
```

Stop the model if needed:

```powershell
ollama stop qwen35-9b-32k
```

For the 64K profile:

```powershell
ollama stop qwen35-9b-64k
```

Larger context uses more memory. Use 32K when 64K is unnecessary.

---

# 🗺️ Recommended Learning Order

```text
┌─────────────────────────────────────┐
│ 01 🟢 Local Chat                    │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 02 📝 Prompt + System Instructions  │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 03 📦 Structured Output             │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 04 🛠️ Tool / Function Calling       │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 05 🤖 Agent Loop                    │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 06 🔢 Embeddings                    │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 07 📚 RAG                           │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 08 💾 Persistent Memory             │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 09 🔌 MCP                           │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 10 🚀 Agent + RAG + Memory + MCP    │
└───────────────────┬─────────────────┘
                    ▼
┌─────────────────────────────────────┐
│ 11 👥 Multi-Agent Systems           │
└─────────────────────────────────────┘
```

---

# ✅ Final Health Check

Run these commands **one by one**.

### 1. Python

```powershell
python --version
```

### 2. Python executable

```powershell
python -c "import sys; print(sys.executable)"
```

### 3. Packages

```powershell
python -c "from ollama import Client, ResponseError; import streamlit; print('Python packages: OK')"
```

### 4. Ollama

```powershell
ollama --version
```

### 5. Models

```powershell
ollama ls
```

### 6. Base Qwen model

```powershell
ollama run qwen3.5:9b-q4_K_M
```

Exit it with:

```text
/bye
```

### 7. 32K profile

```powershell
ollama run qwen35-9b-32k
```

In a second terminal:

```powershell
ollama ps
```

Confirm:

```text
CONTEXT = 32768
```

Exit with:

```text
/bye
```

### 8. Python syntax

```powershell
python -m py_compile main.py
```

Expected: no output.

### 9. Start the actual app

```powershell
python -m streamlit run main.py
```

### ✅ Success means

- the browser opens the Streamlit app,
- the Expert Chat Assistant UI appears,
- the model responds,
- conversation history works,
- Clear Conversation resets the current chat.

---

# 📋 Command Cheat Sheet

| Goal | Command |
|---|---|
| Check Python | `python --version` |
| Check Python path | `python -c "import sys; print(sys.executable)"` |
| Install Python packages | `python -m pip install --upgrade ollama streamlit` |
| List Ollama models | `ollama ls` |
| Pull Qwen | `ollama pull qwen3.5:9b-q4_K_M` |
| Run base model | `ollama run qwen3.5:9b-q4_K_M` |
| Create 32K profile | `ollama create qwen35-9b-32k -f .\Modelfile.32k` |
| Run 32K profile | `ollama run qwen35-9b-32k` |
| Create 64K profile | `ollama create qwen35-9b-64k -f .\Modelfile.64k` |
| Run 64K profile | `ollama run qwen35-9b-64k` |
| Show running model/context | `ollama ps` |
| Inspect custom model | `ollama show --modelfile qwen35-9b-32k` |
| Stop 32K model | `ollama stop qwen35-9b-32k` |
| Clear Ollama chat | `/clear` |
| Exit Ollama chat | `/bye` |
| Check Python syntax | `python -m py_compile main.py` |
| Run Streamlit app | `python -m streamlit run main.py` |
| Install Codex | `npm install -g @openai/codex@latest` |
| Local Codex/Qwen | `codex --oss -m qwen35-9b-64k` |
| Install Ollama VS Code extension | `code --install-extension Ollama.ollama` |
| Local Claude Code/Qwen | `ollama launch claude --model qwen35-9b-64k` |

---

# 📚 Official Sources Used for Validation

These were the primary references used to rebuild this document:

1. **Ollama — Windows**
   - https://docs.ollama.com/windows

2. **Ollama — CLI Reference**
   - https://docs.ollama.com/cli

3. **Ollama — Modelfile Reference**
   - https://docs.ollama.com/modelfile

4. **Ollama — Context Length**
   - https://docs.ollama.com/context-length

5. **Ollama — Qwen3.5 9B Q4_K_M**
   - https://ollama.com/library/qwen3.5:9b-q4_K_M

6. **Official Ollama Python Library**
   - https://github.com/ollama/ollama-python

7. **Streamlit — Installation / Running Apps**
   - https://docs.streamlit.io/get-started/installation/command-line

8. **Streamlit — Session State**
   - https://docs.streamlit.io/develop/api-reference/caching-and-state/st.session_state

9. **Streamlit — `st.cache_resource`**
   - https://docs.streamlit.io/develop/api-reference/caching-and-state/st.cache_resource

10. **Streamlit — `st.chat_input`**
    - https://docs.streamlit.io/develop/api-reference/chat/st.chat_input

11. **Streamlit — `st.chat_message`**
    - https://docs.streamlit.io/develop/api-reference/chat/st.chat_message

12. **Streamlit — `st.write_stream`**
    - https://docs.streamlit.io/develop/api-reference/write-magic/st.write_stream

13. **VS Code — AI Language Models / Ollama**
    - https://code.visualstudio.com/docs/agent-customization/language-models

14. **Ollama — Codex CLI**
    - https://docs.ollama.com/integrations/codex

15. **Ollama — Claude Code**
    - https://docs.ollama.com/integrations/claude-code

---

# 🔎 Validation Notes

### ✅ Python code
The complete `main.py` in this document was syntax-compiled successfully before this
Markdown file was generated.

### ✅ Ollama Python APIs
The current Ollama Python source was checked for:

```text
Client
ResponseError
ConnectionError
client.chat
stream
think
options
keep_alive
ChatResponse.message.content
```

### ✅ Streamlit APIs
Current Streamlit documentation was checked for:

```text
st.cache_resource
st.session_state
st.chat_message
st.chat_input
st.write_stream
```

### ✅ Context guidance
Current Ollama documentation says:

```text
large-context tasks such as web search, agents, and coding tools:
at least 64,000 tokens
```

Therefore this guide deliberately uses:

```text
32K → normal chat and learning
64K → Codex / Claude Code / larger agent workloads
```

---

# 🌟 Five Rules Worth Remembering

> 🟣 **1. Context is not permanent memory.**  
> Context is temporary working space.

> 🔵 **2. An LLM is not an agent.**  
> An agent adds tools, state, decisions, actions, and control flow.

> 🟢 **3. RAG is not the same thing as memory.**  
> RAG retrieves knowledge; memory persists useful state.

> 🟠 **4. Bigger context does not make the model smarter.**  
> It gives the same model a larger working space and uses more memory.

> 🔴 **5. Build incrementally.**  
> Chat → structured output → tools → agent → embeddings → RAG → memory → MCP.

---

# 🚀 Next Workshop

The next upgrade should be **Tool / Function Calling**.

Today:

```text
User
  ↓
Qwen
  ↓
Text answer
```

Next:

```text
User
  ↓
Qwen
  ↓
Tool decision
  ↓
Python function
  ↓
Tool result
  ↓
Qwen
  ↓
Final answer
```

That is the first major step from a **chatbot** toward a real **AI agent**.

---

## 🧠 Learn the model · 🛠️ Build the tools · 🤖 Create the agent
