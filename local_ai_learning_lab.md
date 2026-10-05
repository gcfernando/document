# Local AI Learning Lab: your first local chat app

## Start here

Build a browser chat app with **Ollama, Qwen3.5 9B, Python, and Streamlit on Windows/PowerShell**. A local runtime runs the model; your Python app supplies messages and displays the reply. This is a chat application, not a coding agent, RAG system, or autonomous assistant.

**Minimum prerequisites:** install Python 3.12 if available; be able to create a file and run a PowerShell command. VS Code is a convenient editor. You do not need .NET, Azure, SQL, Codex, Claude Code, or MCP for this lab.

Follow [1–4](#lab-build): prepare the folder → install Ollama → get one base-model answer → create the profile used by this app. Then [5–8](#lab-packages): install two Python packages → create the app → start it → verify it. Stop at the browser-chat checkpoint. Profile experiments, 64K context, removal and uninstall are [optional reference](#lab-reference).

**Commands have different destinations:** `ollama ...` and `python ...` run in PowerShell; `/bye` runs inside the Ollama chat; code goes in the named file; chat questions go in the browser. A long-running command occupies its terminal—use a second PowerShell to inspect it.

This workshop deliberately uses the interpreter selected by `python`, without a virtual environment. This is an **existing-workshop exception**, not general Python project guidance: installing packages changes that interpreter's shared environment. Prefer the separate `.venv` setup in [AI Journey's optional Python route](ai_journey.md#cloud-and-python) for a new independent project. Keep using `python -m pip` and `python -m streamlit` here so all commands use the same interpreter. Do not mix these two setups halfway through the lab.

**Execution status:** the application is a teaching example. Syntax checks do not prove that Ollama, the selected model, your GPU, or the browser app works on your computer. Complete the observable checkpoints yourself.

### Essential path

1. [Prepare and install](#lab-build)
2. [Create the named model profile](#lab-profile)
3. [Install packages](#lab-packages)
4. [Create and run the chat app](#lab-app)
5. [Verify, stop, and resume](#lab-verify)
6. [Continue learning](#lab-next)

---


---

<a id="lab-build"></a>

---

# 1. Prepare your workspace

```text
Windows
  └─ Ollama                         ← runtime, model manager, local API server
       └─ qwen3.5:9b-q4_K_M         ← downloaded base model
            └─ qwen35-9b-32k        ← reusable profile with a 32,768-token context
                 └─ Python + Streamlit app
```

**Ollama** runs and manages models.
**Base model** is the downloaded Qwen package.
**Custom profile** is another Ollama model entry built from the base model with saved settings, such as `num_ctx`.

Creating `qwen35-9b-32k` does **not** download another complete 9B model.
Ollama reuses shared model layers. `ollama ls` shows the model/profile entries
and their reported sizes, but those sizes should not be interpreted as the
additional physical disk space consumed by each profile.

### Do we really need these?

| Item | Need it now? | Why |
|---|---|---|
| Ollama | **Required** | It runs the local model and exposes the local API. |
| Base model | **Required** | A runtime cannot answer without a model. |
| Modelfile/profile | **Optional** | Useful when you want repeatable saved settings. |
| 32K context | **Workshop default** | A practical starting point, not a universal best value. |
| 64K+ context | **Not needed yet** | Use only after measuring a workload that requires it. |
| Python Ollama client | **Required for this app** | Python uses it to call Ollama. |
| Streamlit | **Required for this app** | It provides the browser chat UI. |

---

---

## Before you start

### 2.1 Confirm PowerShell and your working folder

Open **PowerShell**. Commands in this guide are PowerShell commands unless stated otherwise.

```powershell
Get-Location
```

**Expected:** the folder where you want to keep the lab files. To create and enter a lab folder:

```powershell
New-Item -ItemType Directory -Path "$HOME\LocalAI-Learning-Lab" -Force
Set-Location "$HOME\LocalAI-Learning-Lab"
Get-Location
```

**Verify:** the final command prints a path ending in `LocalAI-Learning-Lab`.

### 2.2 Check Python

```powershell
python --version
python -c "import sys; print(sys.executable)"
```

**Expected:** Python reports a version; Python 3.12 is preferred for this workshop. The second command prints the exact interpreter that will receive packages.

**If it fails:**

1. Install Python from [python.org](https://www.python.org/downloads/).
2. Close and reopen PowerShell so its PATH is refreshed.
3. Run both commands again.
4. In VS Code, select this same interpreter with **Python: Select Interpreter**.

### 2.3 Check machine resources before choosing a larger context

This does **not** decide a context size for you. It gives you information for the later test.

```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors
Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM
```

`TotalPhysicalMemory` and `AdapterRAM` are byte values. Windows may not report dedicated VRAM accurately for every GPU; Task Manager is often clearer:

1. Press `Ctrl+Shift+Esc`.
2. Open **Performance**.
3. Select **Memory** and your **GPU**.
4. Note available RAM and dedicated GPU memory.

> 💡 **Why:** larger model + larger context needs more RAM/VRAM. There is no reliable universal “RAM ÷ number = context” formula: model architecture, quantization, KV cache implementation, CPU/GPU offloading, runtime version, and workload all affect usage.

---

---

# 2. Install and check Ollama

Ollama's normal Windows installer installs for your user account, adds the CLI to your user PATH, runs the application in the background, and serves the local API at `http://localhost:11434`.

## 3.1 Check whether Ollama already exists

```powershell
ollama --version
```

**Expected:** an Ollama version such as `ollama version is ...`.

**If PowerShell says that `ollama` is not recognized:** it is not installed or this terminal has an old PATH. Continue to the next step.

## 3.2 Install with the official Windows installer

1. Open [Ollama for Windows](https://ollama.com/download/windows).
2. Download and run the official `OllamaSetup.exe`.
3. Follow the installer prompts.

This workshop recommends the GUI installer. It is the official, simplest Windows setup and keeps Ollama updated. The standalone ZIP is intended for embedding Ollama or deliberately running it as a service; it is not needed here.

> 💡 **Why not use `ollama serve` now?** The normal Windows application starts its own background server. `ollama serve` is mainly for an explicit/manual server process or standalone CLI setup.

## 3.3 Close and reopen PowerShell

Close the terminal window and open a **new** PowerShell. A terminal already open during installation may not see the PATH change.

## 3.4 Verify the installation and local server

```powershell
ollama --version
ollama ls
Invoke-RestMethod http://localhost:11434/api/tags
```

**Expected:**

- `ollama --version` prints a version.
- `ollama ls` prints a table. An empty table is normal before downloading models.
- `Invoke-RestMethod` returns an object with a `models` property, such as `models : {}`.

**If `ollama ls` or the API check cannot connect:**

1. Look for the Ollama icon in the Windows notification area (system tray).
2. If it is absent, start **Ollama** from the Start menu.
3. Wait a few seconds and retry all three commands.
4. If it still fails, see [Troubleshooting](#troubleshooting-the-essential-path).

### ✅ Checkpoint — Ollama ready

Do not continue until these both work:

```powershell
ollama --version
ollama ls
```

---

---

# 3. Download and test the base model

## 5.1 Select the workshop model

This workshop uses the model selected for this project:

```text
qwen3.5:9b-q4_K_M
```

Find model details and current package information in the official [Ollama model library](https://ollama.com/library/qwen3.5:9b-q4_K_M). Do not substitute a similar-looking name unless you deliberately want a different model.

## 5.2 Download it

**Ollama must be running.**

```powershell
ollama pull qwen3.5:9b-q4_K_M
```

**Expected:** download progress followed by a successful completion. The download can take time and needs several GB of disk space.

**If it fails:**

1. Confirm the exact model name above.
2. Confirm `ollama ls` works.
3. Check your internet connection and free disk space.
4. Retry the same command; Ollama can reuse already downloaded layers.
5. Check `server.log` at `%LOCALAPPDATA%\Ollama` if the failure persists.

## 5.3 Verify the download

```powershell
ollama ls
```

**Expected:** a row named `qwen3.5:9b-q4_K_M`.

## 5.4 Run the base model before creating any profile

```powershell
ollama run qwen3.5:9b-q4_K_M
```

At the `>>>` prompt, type:

```text
Reply with exactly: Base model is working.
```

**Expected:** Qwen produces that sentence or an equivalent answer.

### Deliberate failure — wrong model name

In a separate PowerShell, try a name that does not exist:

```powershell
ollama run qwen35-9b-32k
```

**Expected before profile creation:** Ollama reports that the model is not found. This is useful evidence: `qwen35-9b-32k` is not built in and must be created later.

Return to the base-model chat after this test.

## 5.5 Exit chat vs. stop the loaded model

In the base-model chat:

```text
/bye
```

This exits the interactive prompt. Now check whether the model remains loaded:

```powershell
ollama ps
```

**Expected:** it may still show the model and columns such as `NAME`, `PROCESSOR`, `CONTEXT`, and `UNTIL`.

To unload it deliberately:

```powershell
ollama stop qwen3.5:9b-q4_K_M
ollama ps
```

**Expected:** after the stop command, the model no longer appears in `ollama ps`.

### ✅ Checkpoint — base model ready

You can now:

```powershell
ollama run qwen3.5:9b-q4_K_M
```

and receive an answer, then:

```powershell
ollama stop qwen3.5:9b-q4_K_M
```

to unload it.

---

---

<a id="lab-profile"></a>

---

# 4. Create the profile used by this app

A profile is optional for Ollama in general, but **required for the bundled app's default model name**. A profile saves runtime settings; it does not train a model. This route uses `qwen35-9b-32k`. If the computer cannot run it responsively, use the separate 16K profile below rather than changing a 32K-named profile to 16K.

## 4.1 What is a Modelfile?

A **Modelfile** is a small blueprint that tells Ollama how to create a customized model entry. Here, it says: “use the existing Qwen base model and run it with a 32,768-token context.”

## 4.2 Confirm the project folder and prevent a path mistake

```powershell
Get-Location
Get-ChildItem
```

**Expected:** you see the lab folder. If not, return to it:

```powershell
Set-Location "$HOME\LocalAI-Learning-Lab"
```

## 4.3 Create `Modelfile.32k` in VS Code

1. Open the lab folder in VS Code.
2. Create a file named exactly:

```text
Modelfile.32k
```

3. Paste and save:

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 32768
```

## 4.4 Or create it from PowerShell

Run this only from the lab folder:

```powershell
@'
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 32768
'@ | Set-Content -Encoding ascii .\Modelfile.32k
```

## 4.5 Verify the Modelfile before using it

```powershell
Get-Content .\Modelfile.32k
Get-ChildItem -Name Modelfile.32k*
```

**Expected content:**

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 32768
```

**Expected filename:** exactly `Modelfile.32k`.

### Deliberate failure — accidental `.txt` extension

If the second command shows `Modelfile.32k.txt`, Windows/your editor added an extension. Rename it:

```powershell
Rename-Item -LiteralPath .\Modelfile.32k.txt -NewName Modelfile.32k
Get-ChildItem -Name Modelfile.32k*
```

If both files exist, inspect both with `Get-Content`, keep the correct one, and delete only the known incorrect file:

```powershell
Remove-Item -LiteralPath .\Modelfile.32k.txt
```

## 4.6 Create the profile

**Ollama must be running and the base model must exist.**

```powershell
ollama create qwen35-9b-32k -f .\Modelfile.32k
```

**Expected:** Ollama ends with `success`.

**If it fails:**

1. Run `Get-Location` and `Get-ChildItem` to confirm the file path.
2. Run `Get-Content .\Modelfile.32k` and compare it exactly with the two required lines.
3. Run `ollama ls` and confirm `qwen3.5:9b-q4_K_M` exists.
4. Run `ollama ls` to confirm the server is running.

## 4.7 Verify the profile configuration

```powershell
ollama ls
ollama show --modelfile qwen35-9b-32k
```

**Expected:** `ollama ls` includes both names:

```text
qwen3.5:9b-q4_K_M
qwen35-9b-32k
```

`ollama show --modelfile` prints the generated definition. Look for `PARAMETER num_ctx 32768` or an equivalent generated configuration. This verifies what Ollama saved.

## 4.8 Run and prove the 32K context

In the first PowerShell:

```powershell
ollama run qwen35-9b-32k
```

At the prompt:

```text
Reply with exactly: 32K profile is working.
```

Keep this chat open. In a **second** PowerShell:

```powershell
ollama ps
```

**Expected:** the profile row has `CONTEXT` equal to `32768`.

Now in the first PowerShell:

```text
/bye
```

Then deliberately unload it:

```powershell
ollama stop qwen35-9b-32k
ollama ps
```

**Expected:** the custom profile no longer appears in `ollama ps`.

## Resource-limited alternative: a separate 16K profile

In the lab folder, save `Modelfile.16k` with these two lines:

```text
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 16384
```

In PowerShell, create it and select it for this app session:

```powershell
ollama create qwen35-9b-16k -f .\Modelfile.16k
$env:LOCAL_AI_MODEL = "qwen35-9b-16k"
```

While this profile runs, inspect `ollama ps` in another PowerShell; expect `CONTEXT` 16384. The app reads `LOCAL_AI_MODEL`; otherwise it uses 32K. If even 16K is unresponsive, stop and use the base-model console checkpoint while assessing a smaller supported model. There is no universal RAM/VRAM minimum that guarantees acceptable latency. Do not increase context to fix slow generation.


---

<a id="lab-packages"></a>

---

# 5. Install packages for this app

Return to the lab folder:

```powershell
Set-Location "$HOME\LocalAI-Learning-Lab"
```

Install into the selected global Python interpreter:

```powershell
python -m pip install ollama streamlit
```

Verify both imports:

```powershell
python -c "from ollama import Client, ResponseError; import streamlit; print('Ollama Python + Streamlit: OK')"
```

**Expected:**

```text
Ollama Python + Streamlit: OK
```

**If it fails:**

1. Run `python -c "import sys; print(sys.executable)"`.
2. Run `python -m pip --version`.
3. Ensure both paths identify the same Python installation.
4. Re-run the install command with that `python`.

Create a minimal dependency record:

```powershell
@'
ollama
streamlit
'@ | Set-Content -Encoding ascii .\requirements.txt

Get-Content .\requirements.txt
```

---

Record the versions that actually work before a later upgrade:

```powershell
python --version
python -m pip show ollama streamlit
python -m pip check
```

The two unpinned entries in `requirements.txt` describe dependencies, not a reproducible lockfile. After successful browser verification, record the installed `ollama` and `streamlit` versions in the lab notes; use those tested versions when sharing the exercise. Do not copy another machine's complete global `pip freeze` into this project's requirements.


---

<a id="lab-app"></a>

---

# 6. Create the Streamlit local chat app

The app uses the verified 32K profile. Complete the profile checkpoint before continuing.

## 6.1 Create `main.py`

Create `main.py` in VS Code and paste this complete teaching application:

```python
"""Local Streamlit chat assistant powered by Ollama."""

import os
from collections.abc import Iterator

import streamlit as st
from ollama import Client, ResponseError

OLLAMA_HOST = "http://127.0.0.1:11434"
MODEL_NAME = os.environ.get("LOCAL_AI_MODEL", "qwen35-9b-32k")
MAX_USER_CHARACTERS = 4000
MAX_HISTORY_CHARACTERS = 12000
MAX_COMPLETED_TURNS = 6

SYSTEM_PROMPT = """
You are an Expert Chat Assistant.

Give accurate, clear, practical answers. Do not invent facts, APIs, commands,
libraries, capabilities, sources, or results. Say when you are uncertain.

For technical questions, prefer simple maintainable solutions and mention
important errors, edge cases, security, performance, and compatibility concerns.
You are a local model: do not claim to access the internet, private files,
databases, APIs, or external systems unless the application actually provides them.
""".strip()


def initialize_session_state() -> None:
    """Initialize values that survive Streamlit reruns for this browser session."""

    if "messages" not in st.session_state:
        st.session_state["messages"] = []
    if "temperature" not in st.session_state:
        st.session_state["temperature"] = 0.2


@st.cache_resource
def get_ollama_client() -> Client:
    """Create one Ollama client for the Streamlit process."""

    return Client(host=OLLAMA_HOST, timeout=120.0)


def build_messages() -> list[dict[str, str]]:
    """Build the system prompt plus current conversation for Ollama."""

    return [
        {"role": "system", "content": SYSTEM_PROMPT},
        *st.session_state["messages"],
    ]


def stream_response(
    client: Client,
    messages: list[dict[str, str]],
    temperature: float,
) -> Iterator[str]:
    """Yield non-empty streamed text chunks from Ollama."""

    response_stream = client.chat(
        model=MODEL_NAME,
        messages=messages,
        stream=True,
        think=False,
        options={"temperature": temperature},
        keep_alive="10m",
    )

    for chunk in response_stream:
        if content := chunk.message.content:
            yield content


def clear_conversation() -> None:
    """Remove only the browser session's conversation history."""

    st.session_state["messages"] = []


def render_sidebar() -> None:
    """Render application controls."""

    with st.sidebar:
        st.header("⚙️ Settings")
        st.write("### Model")
        st.code(MODEL_NAME, language=None)
        st.divider()
        st.session_state["temperature"] = st.slider(
            "Temperature",
            min_value=0.0,
            max_value=1.0,
            value=st.session_state["temperature"],
            step=0.1,
            help="Lower values are more consistent. Higher values are more varied.",
        )
        if st.button("🗑️ Clear Conversation", use_container_width=True):
            clear_conversation()
            st.rerun()
        st.divider()
        st.caption(f"Ollama server: {OLLAMA_HOST}")


def render_messages() -> None:
    """Render the welcome text and conversation history."""

    if not st.session_state["messages"]:
        with st.chat_message("assistant"):
            st.markdown(
                f"Hello! I am running locally with **{MODEL_NAME}**. "
                "What would you like to work on?"
            )

    for message in st.session_state["messages"]:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])


def process_user_message(client: Client) -> None:
    """Read one user message, stream the reply, and store both."""

    if not (user_prompt := st.chat_input("Ask your local assistant...")):
        return

    if len(user_prompt) > MAX_USER_CHARACTERS:
        st.warning("Please shorten this message to 4,000 characters.")
        return

    history = st.session_state["messages"]
    history_was_trimmed = False
    while history and (
        len(history) >= MAX_COMPLETED_TURNS * 2
        or sum(len(message["content"]) for message in history) > MAX_HISTORY_CHARACTERS
    ):
        del history[:2]  # Remove the oldest complete user/assistant pair.
        history_was_trimmed = True

    if history_was_trimmed:
        st.info("Older conversation turns are no longer being sent to the model.")

    history.append({"role": "user", "content": user_prompt})
    with st.chat_message("user"):
        st.markdown(user_prompt)

    with st.chat_message("assistant"):
        try:
            assistant_response = st.write_stream(
                stream_response(
                    client,
                    build_messages(),
                    st.session_state["temperature"],
                )
            )
            st.session_state["messages"].append(
                {"role": "assistant", "content": assistant_response}
            )
        except ResponseError as error:
            st.session_state["messages"].pop()
            st.error(f"Ollama returned an error:\n\n{error.error}")
        except ConnectionError:
            st.session_state["messages"].pop()
            st.error(
                "Cannot connect to Ollama. Start the Ollama Windows application "
                f"and verify {OLLAMA_HOST}."
            )
        except TimeoutError:
            st.session_state["messages"].pop()
            st.error(
                "Ollama did not respond before the timeout. Check the loaded model "
                "and machine resources, then submit the message again when ready."
            )


def main() -> None:
    """Run the Streamlit application."""

    st.set_page_config(page_title="Expert Chat Assistant", page_icon="🤖")
    initialize_session_state()
    render_sidebar()
    st.title("🤖 Expert Chat Assistant")
    st.caption(f"Local AI • {MODEL_NAME} • Ollama")
    st.divider()
    render_messages()
    process_user_message(get_ollama_client())


if __name__ == "__main__":
    main()
```

> 💡 **Why does the app use `keep_alive="10m"`?** It keeps this model loaded for up to ten minutes after a request to make nearby requests faster. Stop it explicitly with `ollama stop qwen35-9b-32k` when you need to free memory.

## 6.2 Validate before starting the app

```powershell
python -m py_compile .\main.py
python -c "from ollama import Client, ResponseError; import streamlit; print('Imports: OK')"
ollama ls
```

**Expected:**

- `py_compile` prints nothing: that means Python syntax is valid.
- The import command prints `Imports: OK`.
- `ollama ls` includes `qwen35-9b-32k`.

---

### What the app remembers and how it fails

`st.session_state` stores this browser session's completed messages. It is not a database or durable model memory. Reloading the browser or losing its WebSocket resets the session; see [Streamlit Session State](https://docs.streamlit.io/develop/api-reference/caching-and-state/st.session_state). Clear Conversation removes the supplied chat history.

The app limits message size and removes old completed turns. When it removes them, it displays a notice that they are no longer sent to the model. These character/turn limits are a conservative teaching policy, **not a token counter or a proof of fit inside a context window**. Token budgeting and summarization belong in a later application lesson.

Requests have a timeout and no automatic retry. A handled connection, Ollama, or timeout failure removes the unfinished user turn from stored history so a later submission does not repeatedly send it. Other unexpected errors remain visible in Streamlit's normal error output rather than being mistaken for a successful reply. Streaming may already have displayed partial text before an error; that partial text is not stored as a successful answer. Check the server, then submit again deliberately. Do not use this demo for shared/public access without a separate security and privacy design.


---

# 7. Run and test Streamlit

## 7.1 Start the application correctly

**Wrong:**

```powershell
python .\main.py
```

This runs a normal Python script, not the Streamlit runtime. It can produce `missing ScriptRunContext` warnings and Streamlit session state will not work as intended.

**Correct:**

```powershell
python -m streamlit run .\main.py
```

**Expected:** Streamlit starts and prints a local URL, normally `http://localhost:8501`. Open it in a browser if it does not open automatically.

> 💡 **Why this command?** `python -m streamlit` guarantees that Streamlit comes from the exact interpreter used for `python -m pip install`.

## 7.2 Test the application

| Test | Do this | Expected |
|---|---|---|
| Basic chat | Ask: `Reply with exactly: Streamlit is working.` | A streamed response appears. |
| Conversation | Say: `For this chat, my project is Alpha.` Then ask for the project name. | It answers `Alpha` while the session remains active. |
| Clear chat | Click **🗑️ Clear Conversation**, then ask for the project name. | Earlier chat history is no longer supplied. |
| Local model | Run `ollama ps` in a second PowerShell while the app responds. | The selected profile appears: `32768` for 32K or `16384` for the explicit 16K alternative. |

`Clear Conversation` clears only Streamlit's browser session history. It does not delete the model, profile, or Ollama files.

## 7.3 Stop the application and model

1. Return to the terminal running Streamlit.
2. Press `Ctrl+C`.
3. Verify Streamlit stopped by refreshing its URL; it should no longer respond.
4. Stop the loaded model if you no longer need it:

```powershell
ollama stop qwen35-9b-32k
ollama ps
```

---

---

<a id="lab-verify"></a>

---

# 8. Verify, stop, and resume

Run these one at a time after completing the workshop:

```powershell
python --version
python -c "import sys; print(sys.executable)"
python -c "from ollama import Client, ResponseError; import streamlit; print('Python packages: OK')"
ollama --version
ollama ls
```

Run and verify the base model:

```powershell
ollama run qwen3.5:9b-q4_K_M
```

Type `/bye`, then:

```powershell
ollama stop qwen3.5:9b-q4_K_M
```

Run and verify the profile:

```powershell
ollama run qwen35-9b-32k
```

In another PowerShell:

```powershell
ollama ps
```

Confirm `CONTEXT` is `32768`. Exit with `/bye`, then:

```powershell
ollama stop qwen35-9b-32k
python -m py_compile .\main.py
python -m streamlit run .\main.py
```

### Final verification checklist

- [ ] Correct Python executable verified
- [ ] Ollama installed and version verified
- [ ] Local Ollama API/server answered
- [ ] Qwen base model downloaded
- [ ] Base model answered a prompt
- [ ] Base model was explicitly stopped
- [ ] `Modelfile.32k` exists without an accidental `.txt` extension
- [ ] `qwen35-9b-32k` was created
- [ ] `ollama ps` showed context `32768`
- [ ] Selected profile and live allocated context agree (32K, or the explicit 16K route)
- [ ] Python packages imported from the selected interpreter
- [ ] `main.py` syntax compiled
- [ ] Streamlit started with `python -m streamlit run .\main.py`
- [ ] Browser chat worked
- [ ] Clear Conversation worked
- [ ] Streamlit and loaded model were stopped correctly

---

## Resume tomorrow

Open PowerShell, return to `$HOME\LocalAI-Learning-Lab`, and start the Ollama Windows app if `ollama ls` cannot connect. If you chose 16K, set `LOCAL_AI_MODEL` again in this shell. Then run `python -m streamlit run .\main.py`. You do not need to pull the model, create the profile, or reinstall packages again. This demo does not restore yesterday's conversation.

**You are done:** a browser reply appears, a follow-up uses the current session, Clear Conversation removes that context, and `ollama ps` shows the selected model. For another application capability, continue to [AI Journey's local C# bridge](ai_journey.md#local-model-call). To operate a coding assistant, use the [configuration handbook's product routes](deep-research-report.md#choose-product).


---

# Troubleshooting the essential path

## `ollama` is not recognized

Close and reopen PowerShell. If it remains unavailable, reinstall using the official Windows installer and verify:

```powershell
ollama --version
```

## Ollama cannot connect / API request fails

```powershell
ollama ls
Invoke-RestMethod http://localhost:11434/api/tags
```

Start Ollama from the Start menu if both fail. If the app appears to be running but failures continue, quit it from the tray menu, start it again, and retry. Inspect `%LOCALAPPDATA%\Ollama\server.log` for server errors.

## A profile is missing

```powershell
ollama ls
Get-Location
Get-ChildItem
Get-Content .\Modelfile.32k
ollama create qwen35-9b-32k -f .\Modelfile.32k
```

The first command tells you whether the profile exists. The next commands prove you are in the folder containing the correct Modelfile.

## `CONTEXT` is not what you expected

Do not infer context from the profile name. Run the profile, keep it loaded, then inspect:

```powershell
ollama ps
```

If it is not `32768`, inspect the saved definition:

```powershell
ollama show --modelfile qwen35-9b-32k
```

Correct `Modelfile.32k`, recreate the named profile with `ollama create`, then repeat the live test.

## Python package was installed but cannot be imported

```powershell
python -c "import sys; print(sys.executable)"
python -m pip --version
python -m pip install --upgrade ollama streamlit
```

The first two commands must point to the same Python installation.

## `missing ScriptRunContext`

You started the app with `python main.py`. Stop it and use:

```powershell
python -m streamlit run .\main.py
```

## The computer is slow

```powershell
ollama ps
```

Check `PROCESSOR` and `CONTEXT`. Stop unneeded models:

```powershell
ollama stop qwen35-9b-32k
```

Use 32K for normal work. Test 64K only when a measured workload requires it. Update GPU drivers if the model unexpectedly runs on CPU and consult Ollama's Windows/GPU documentation for supported hardware.

---

---

<a id="lab-next"></a>

---

# What to learn next

Use [AI Journey](ai_journey.md#course-path) for: model call → structured result/state → guarded tool → bounded agent loop → keyword retrieval/RAG → evaluations and reliability. MCP is an optional way to connect capabilities; persistent memory is optional when retention is actually required. Neither is a prerequisite for this chat app.

Use the [coding-agent handbook](deep-research-report.md#choose-product) to choose one coding assistant and the [company workbook](end_to_end_ai_agent_graphql_workflow.md#workbook-path) to apply it to a ticket. This lab does not configure Codex or Claude Code or promise that they use your local Qwen model.


---

<a id="lab-reference"></a>

# Optional operations and reference

Stop the essential path at the working browser app. Everything below is optional. Removal exercises change installed entries; uninstall removes the runtime/data. Before returning to the app, recheck the server, recreate the app's selected profile if removed, and repeat the package/import/model checks. Run deletion only when you intentionally want that specific data removed.


---

## A. Context and profile reference

## 6.1 What is context?

**Context** is the model's temporary working space for:

```text
system instructions + conversation + code/documents + tool results
+ current request + expected response
```

It is not permanent memory and it does not make the model more intelligent.

| Name | Token capacity |
|---|---:|
| 8K | 8,192 |
| 16K | 16,384 |
| 32K | 32,768 |
| 64K | 65,536 |
| 96K | 98,304 |

“94K” is **not** the conventional value next to 96K. Use `96K` only when you actually mean 98,304 tokens. An unusual value may be a hardware-limited calculation, but should not be chosen merely because it looks large.

## 6.2 Do I really need an Ollama profile?

**No.** You can run the downloaded base model directly:

```powershell
ollama run qwen3.5:9b-q4_K_M
```

A profile is useful when you want a saved, reusable configuration:

- a fixed context size;
- a friendly workload name;
- the same settings across commands and applications; or
- separate named setups such as 32K chat and 64K coding.

It is unnecessary when your application/API always supplies the required runtime options and you do not need a persistent reusable setting. Ollama can also set context at runtime through its app, interactive `/set parameter num_ctx ...`, API options, or the server default. This lab uses a profile to make the setting visible, repeatable, and easy to verify.

## 6.3 The four different context values

The official Ollama library lists **Qwen3.5 9B** with a **256K-token maximum context**: `262,144` tokens. This is a model capability, not a recommended starting setting.

```text
Model maximum context (Qwen3.5 9B)       = 262,144 tokens (256K)
Context this computer can run comfortably = depends on RAM, VRAM, and offloading
Context this workload needs               = depends on the information sent per request
Workshop profile                          = 32,768 tokens (32K)
```

> 💡 **Why this matters:** a model may support 256K while your machine should run 32K, and your normal chat may only need 32K. This workshop starts at 32K because it is a practical, measurable baseline with less memory pressure. Increase only for a real workload that needs more working space.

## 6.4 What happens without a profile?

Yes, Ollama chooses a default context when you run the base model without a custom profile:

```powershell
ollama run qwen3.5:9b-q4_K_M
```

Current Ollama context-length guidance selects its default from available VRAM:

| Available VRAM | Ollama default context |
|---:|---:|
| Less than 24 GiB | 4K |
| 24–48 GiB | 32K |
| 48 GiB or more | 256K |

The effective value can also be changed by the Ollama app/server configuration, environment variables, or runtime options. Therefore, do not guess what your machine chose. **Inspect it.**

```powershell
ollama run qwen3.5:9b-q4_K_M
```

Leave that chat open. In a second PowerShell:

```powershell
ollama ps
```

Record the base-model row:

| Field | Record it |
|---|---|
| `NAME` | Base model name |
| `CONTEXT` | Actual allocated context |
| `PROCESSOR` | CPU/GPU split |
| `UNTIL` | Loaded-model expiry |

Read the `CONTEXT` number as the context Ollama actually allocated to this loaded model. For example, `4096` means 4K; `32768` means 32K; and `262144` means 256K.

```text
Qwen3.5 maximum: 262,144
        ↓
Ollama selects an effective default for this machine
        ↓
ollama ps proves what is actually running
```

Exit with `/bye`, then unload it:

```powershell
ollama stop qwen3.5:9b-q4_K_M
```

> 💡 **Why inspect with `ollama ps`?** It proves the allocated context and shows whether the model runs on GPU, CPU, or both. A configuration file alone does not prove the running process used it.

## 6.5 Why start with 32K?

`32K` is the **starting profile for this workshop**, not a universal recommendation.

- It is enough for normal local chat, beginner exercises, and modest code/document tasks.
- It establishes a practical baseline before asking the computer for more working memory.
- It usually creates less memory pressure than 64K or 96K.
- Larger context does **not** make Qwen smarter. It gives the same model more text to consider.
- Context/KV cache allocation has memory and performance costs, even if your workload does not use all available space.

Ollama's current documentation says its default context can vary with available VRAM and that large-context work such as agents, web search, and coding tools should use at least 64,000 tokens. That is a workload guideline, not a reason to make 64K the default for every chat.

## 6.6 How to choose a context size

Use this as an **estimation method**, not an exact hardware formula:

```text
required context =
  instructions
+ conversation history
+ files/code/documents sent to the model
+ retrieved/tool results
+ current request
+ expected response
+ safety margin
```

### Example: normal local chat

```text
System prompt                 2K
Conversation                 10K
Small code/document           8K
Current request               1K
Expected answer               3K
Safety margin                 4K
-------------------------------
Estimated need               28K
```

Choose **32K**.

### Example: coding-agent workload

```text
System and tool definitions   8K
Repository files/snippets    24K
Conversation                 10K
Tool output / diagnostics    10K
Expected answer               4K
Safety margin                 8K
-------------------------------
Estimated need               64K
```

Choose **64K**, then test it with the actual workload and watch `ollama ps`, Windows Task Manager, response speed, and stability.

| Context | Typical use | Memory pressure | Use in this lab? |
|---|---|---|---|
| 8K | Very short prompts | Lower | Only for constrained experiments |
| 16K | Short chat/small code | Low–medium | Possible |
| 32K | Normal learning/chat | Medium | **Default** |
| 64K | Larger coding/agent work | Higher | Optional, only if justified |
| 96K | Large working sets | Much higher | Not a default |
| 256K (model maximum) | Special large-context workloads | Potentially very high | Not a default |

The selected Qwen3.5 9B model has a 256K maximum, but that does not mean 256K is comfortable or useful on every computer. Use `ollama ps`, Task Manager, response speed, and real workload results before increasing context.

> ⚠️ **Do not blindly choose 64K, 94K, or 96K.** Start at 16K or 32K, measure the real workload, increase only when information you need is falling outside context and the machine remains responsive.

---

---

## B. Optional base-model/profile comparison

This experiment gives evidence instead of relying on a written claim.

## Experiment A — base model

```powershell
ollama run qwen3.5:9b-q4_K_M
```

In a second PowerShell:

```powershell
ollama ps
```

Record the result, then exit `/bye` and unload:

```powershell
ollama stop qwen3.5:9b-q4_K_M
```

## Experiment B — 32K profile

```powershell
ollama run qwen35-9b-32k
```

In a second PowerShell:

```powershell
ollama ps
```

Record the result, then exit `/bye` and unload:

```powershell
ollama stop qwen35-9b-32k
```

## Compare your observations

| Test | Base model | `qwen35-9b-32k` profile |
|---|---|---|
| Model name shown by `ollama ps` | `qwen3.5:9b-q4_K_M` | `qwen35-9b-32k` |
| Underlying model | Qwen base model | Same Qwen base model |
| Explicit saved context configuration | Not in this lab's Modelfile | `32768` |
| Actual allocated context | Record `ollama ps` output | Must be `32768` |
| Repeatable named setting | Depends on runtime configuration | Yes |
| Second full 9B download required? | N/A | No; profile reuses base layers |

**What this proves:** a profile does not make Qwen smarter or create a second independent model. It makes a chosen configuration repeatable. The `CONTEXT` column is the proof of the live allocation.

---

---

## C. Optional 64K profile

Create a separate profile rather than overwriting 32K. Clear names make comparison and cleanup safe.

```powershell
@'
FROM qwen3.5:9b-q4_K_M
PARAMETER num_ctx 65536
'@ | Set-Content -Encoding ascii .\Modelfile.64k

Get-Content .\Modelfile.64k
ollama create qwen35-9b-64k -f .\Modelfile.64k
ollama ls
```

Run it:

```powershell
ollama run qwen35-9b-64k
```

In another PowerShell:

```powershell
ollama ps
```

**Expected:** `CONTEXT` is `65536`.

Exit `/bye`, then unload:

```powershell
ollama stop qwen35-9b-64k
```

> 💡 **When should you move from 32K to 64K?** When your measured estimate and real workload need it: for example, instructions + repository context + tool output + conversation + expected answer exceed 32K. If normal chat works well at 32K, do not change it.

---

---

## D. Ollama lifecycle reference

## What normally happens on Windows

The standard Windows app normally runs in the background after installation. You usually **do not** need to start a server manually before running `ollama pull`, `ollama run`, or the Streamlit app.

| Action | What it stops |
|---|---|
| `/bye` in chat | The interactive chat session only. |
| `ollama stop <model>` | One loaded model; frees its loaded memory. |
| Quit Ollama from the tray menu | The Ollama application/server; models cannot be queried or run. |
| `Ctrl+C` in a manual `ollama serve` terminal | That manually started server process. |

Ollama normally keeps a recently used model in memory for a short time (by default, five minutes). Therefore, leaving chat with `/bye` does not guarantee the model is unloaded.

## 4.1 Check that the server is running

```powershell
ollama ls
Invoke-RestMethod http://localhost:11434/api/tags
```

**Expected:** both succeed. `ollama ls` is the everyday check; the API call proves that the local server answers HTTP requests.

## 4.2 Start it when it is not running

**Recommended normal Windows method:** open **Ollama** from the Start menu, then repeat the checks above.

If you deliberately use a standalone/manual server instead of the normal app, run this in a dedicated PowerShell window:

```powershell
ollama serve
```

Keep that window open. A running server prints logs and keeps the terminal occupied. Open a **second** PowerShell for `ollama ls`, `ollama pull`, and other commands.

## 4.3 Stop the Ollama server/application

For the normal Windows app:

1. Locate the Ollama icon in the system tray. Use the `^` overflow area if necessary.
2. Open its menu and choose **Quit**.
3. In PowerShell, run:

```powershell
ollama ls
```

**Expected after a successful quit:** a connection error because the server is no longer listening.

For a manually started `ollama serve`, press `Ctrl+C` in the window that runs it, then run `ollama ls` in the other window to confirm the same connection failure.

> [!NOTE]
> Stopping the server is different from removing models. Your model files remain installed unless you explicitly run `ollama rm`.

---

---

## E. Deliberate model removal and reset

Run `ollama ls` before and after every removal. `ollama rm` removes the **named entry**, not every similarly named model.

## 10.1 Reset only the loaded state

This keeps all downloaded models and profiles.

```powershell
ollama ps
ollama stop qwen35-9b-32k
ollama stop qwen35-9b-64k
ollama stop qwen3.5:9b-q4_K_M
ollama ps
```

If a named model is not loaded, `ollama stop` can report that it is not found; that is fine. `ollama ps` is the final proof that no model remains loaded.

## 10.2 Remove only custom profiles

This preserves the base download:

```powershell
ollama ls
ollama rm qwen35-9b-32k
ollama rm qwen35-9b-64k
ollama ls
```

Only run the command for a profile that actually exists. Afterward, `ollama ls` should still show `qwen3.5:9b-q4_K_M` and should not show the removed profile.

## 10.3 Experiment — remove the base-model entry while keeping the profile

> 💡 **Why this matters:** model/profile names are entries (manifests), while Ollama can share model layers between entries. This experiment proves why users must use `ollama ls` rather than guessing what is still available.

Start only when both entries exist and no model is loaded:

```powershell
ollama ps
ollama ls
```

**Expected starting state:**

```text
qwen3.5:9b-q4_K_M
qwen35-9b-32k
```

Remove only the base-model entry:

```powershell
ollama rm qwen3.5:9b-q4_K_M
ollama ls
```

**Expected:** `qwen3.5:9b-q4_K_M` no longer appears, while `qwen35-9b-32k` remains.

Now prove that the profile still works:

```powershell
ollama run qwen35-9b-32k
```

Ask:

```text
Reply with exactly: Profile still works.
```

**Expected:** the profile answers. In another PowerShell, run:

```powershell
ollama ps
```

**Expected:** `qwen35-9b-32k` is loaded with `CONTEXT` equal to `32768`.

Exit `/bye`, then unload it:

```powershell
ollama stop qwen35-9b-32k
```

The profile has its own manifest that still references the shared layers, so removing the base entry does not necessarily delete those shared layers immediately. Ollama manages referenced and unreferenced blobs itself. **Do not manually delete individual blobs** inside `.ollama`.

### Restore the normal workshop state

Pull the base entry again:

```powershell
ollama pull qwen3.5:9b-q4_K_M
ollama ls
```

**Expected:** both the base model and `qwen35-9b-32k` appear again.

**If it fails:** do not delete blobs. Confirm `ollama ls` can contact the server, then rerun the `ollama pull` command. If the profile is missing too, recreate it from `Modelfile.32k` with `ollama create qwen35-9b-32k -f .\Modelfile.32k`.

## 10.4 Remove the base model too

First remove every profile based on it that you no longer need, then remove the base entry:

First run `ollama ls`. Run each `ollama rm` command only for a model/profile
name that actually exists on your machine. If you never created the optional
`qwen35-9b-64k` profile, skip that command.

```powershell
ollama ls
ollama rm qwen35-9b-32k
ollama rm qwen35-9b-64k
ollama rm qwen3.5:9b-q4_K_M
ollama ls
```

The profile entries depend on the same underlying model layers. Remove profiles first so the remaining `ollama ls` list matches your intention. Ollama garbage-collects layers no longer referenced by installed models; do not manually delete individual model blobs.

**Verify removal:** the desired names no longer appear in `ollama ls`. Trying to run a removed profile should produce a model-not-found error:

```powershell
ollama run qwen35-9b-32k
```

---

---

## F. Deliberate uninstall

Use this section only for a deliberate full reset or removal. It distinguishes uninstalling the application from removing models and data.

| Action | What it removes |
|---|---|
| `ollama rm <name>` | One model/profile entry and unreferenced model layers |
| Windows **Uninstall** | Ollama application/binaries |
| Full cleanup below | Application files, model/configuration data, logs, and chosen model location |

## 11.1 Normal uninstall

1. Stop loaded models with `ollama ps` and `ollama stop <model>`.
2. Quit Ollama from the system-tray menu.
3. Open **Settings → Apps → Installed apps** (or **Add or remove programs**).
4. Find **Ollama** and choose **Uninstall**.

**Important:** if `OLLAMA_MODELS` was configured to store models elsewhere, the installer does not remove that separate location.

## 11.2 Full cleanup/reset

This permanently deletes Ollama models, configuration, logs, and files in the listed locations. Back up anything you need first.

### A. Check whether a custom model location was used

```powershell
[Environment]::GetEnvironmentVariable('OLLAMA_MODELS', 'User')
[Environment]::GetEnvironmentVariable('OLLAMA_MODELS', 'Machine')
```

If either prints a path, write it down. It may hold downloaded models outside the default folder.

### B. Uninstall and then inspect official Windows locations

After completing the normal uninstall, run:

```powershell
$paths = @(
  (Join-Path $env:LOCALAPPDATA 'Ollama'),
  (Join-Path $env:LOCALAPPDATA 'Programs\Ollama'),
  (Join-Path $env:USERPROFILE '.ollama')
)
$paths | ForEach-Object { [PSCustomObject]@{ Path = $_; Exists = Test-Path -LiteralPath $_ } }
```

**Expected:** the command lists each known location and whether it remains. These are the locations documented by Ollama for logs/update data, binaries, and models/configuration.

### C. Delete only confirmed leftover locations

Run each command **only if the inspection says `Exists : True`** and you want to delete that data:

```powershell
Remove-Item -LiteralPath (Join-Path $env:LOCALAPPDATA 'Ollama') -Recurse -Force
Remove-Item -LiteralPath (Join-Path $env:LOCALAPPDATA 'Programs\Ollama') -Recurse -Force
Remove-Item -LiteralPath (Join-Path $env:USERPROFILE '.ollama') -Recurse -Force
```

If `OLLAMA_MODELS` pointed to a custom folder, inspect that exact path first:

```powershell
Test-Path -LiteralPath 'C:\replace-with-your-confirmed-model-folder'
```

Then delete only that confirmed folder, replacing the example path yourself:

```powershell
Remove-Item -LiteralPath 'C:\replace-with-your-confirmed-model-folder' -Recurse -Force
```

### D. Verify the persistent locations are gone

Run the same inspection again:

```powershell
$paths | ForEach-Object {
    [PSCustomObject]@{
        Path   = $_
        Exists = Test-Path -LiteralPath $_
    }
}
```

**Expected after deleting all confirmed default locations:**

```text
Exists
------
False
False
False
```

If a row still shows `True`, inspect that exact path before taking further action:

```powershell
Get-ChildItem -LiteralPath 'C:\replace-with-the-path-that-still-exists' -Force
```

Do not delete a location merely because its name looks similar to Ollama. Delete only a confirmed official Ollama location or your own confirmed `OLLAMA_MODELS` location.

### E. Inspect temporary Ollama files separately

Ollama documents temporary executable files in one or more `ollama*` directories under `%TEMP%`. These are separate from persistent models/configuration. **Inspect them; do not use a wildcard delete command.**

```powershell
Get-ChildItem -Path $env:TEMP -Directory -Filter 'ollama*' -Force |
    Select-Object FullName, LastWriteTime
```

**Expected:** zero or more temporary directories. If a directory is listed and you deliberately need to remove it, first inspect the exact printed path:

```powershell
Get-ChildItem -LiteralPath 'C:\replace-with-one-confirmed-TEMP-path' -Force
```

Only then decide whether that one specific path is safe to remove. Do not delete all `%TEMP%` contents and do not use `Remove-Item "$env:TEMP\ollama*"` or another wildcard removal command.

### F. Inspect custom Ollama environment variables

Ollama on Windows inherits user and system environment variables. Inspect variables that may affect its location, host, context, or model lifetime:

```powershell
$scopes = 'User', 'Machine'
foreach ($scope in $scopes) {
    [Environment]::GetEnvironmentVariables($scope).GetEnumerator() |
        Where-Object { $_.Key -like 'OLLAMA_*' } |
        Select-Object @{ Name = 'Scope'; Expression = { $scope } }, Key, Value
}
```

Only remove a variable that **you deliberately created** and no longer need. For example:

```powershell
[Environment]::SetEnvironmentVariable('OLLAMA_MODELS', $null, 'User')
[Environment]::SetEnvironmentVariable('OLLAMA_HOST', $null, 'User')
[Environment]::SetEnvironmentVariable('OLLAMA_CONTEXT_LENGTH', $null, 'User')
[Environment]::SetEnvironmentVariable('OLLAMA_KEEP_ALIVE', $null, 'User')
```

Close and reopen PowerShell after changing variables. Do not remove a machine-scoped variable unless you know who configured it and why.

### G. Verify the application is gone

```powershell
ollama --version
```

**Expected after a complete uninstall:** PowerShell says `ollama` is not recognized. If it still prints a version, the app/path remains installed; revisit the normal uninstall and inspect the binary location above.

### The three cleanup levels

```text
Normal uninstall
  → removes the Ollama application.

Remove models
  → `ollama rm <model-name>` removes named model/profile entries.

Full persistent-data cleanup
  → removes only confirmed Ollama data/configuration/model locations.

Temporary files
  → inspect separately; never mass-delete unrelated TEMP contents.
```

To reinstall, return to [Install Ollama](#lab-build).

---

---

## G. Lifecycle cheat sheet

| Task | Command or action |
|---|---|
| Check Ollama CLI | `ollama --version` |
| Check server/API | `ollama ls` or `Invoke-RestMethod http://localhost:11434/api/tags` |
| Start normal Windows Ollama | Start **Ollama** from Start menu |
| Start manual server | `ollama serve` |
| Stop normal Windows Ollama | Quit from the system-tray menu |
| List installed models | `ollama ls` |
| Download model | `ollama pull qwen3.5:9b-q4_K_M` |
| Run base model | `ollama run qwen3.5:9b-q4_K_M` |
| Exit interactive chat | `/bye` |
| Show loaded models/context | `ollama ps` |
| Stop loaded model | `ollama stop <model-name>` |
| Remove one model/profile | `ollama rm <model-name>` |
| Create 32K profile | `ollama create qwen35-9b-32k -f .\Modelfile.32k` |
| Inspect profile | `ollama show --modelfile qwen35-9b-32k` |
| Run 32K profile | `ollama run qwen35-9b-32k` |
| Start Streamlit | `python -m streamlit run .\main.py` |
| Stop Streamlit | `Ctrl+C` in its terminal |

---

---

## 📚 Official References

- [Ollama for Windows](https://docs.ollama.com/windows)
- [Ollama CLI reference](https://docs.ollama.com/cli)
- [Ollama Modelfile reference](https://docs.ollama.com/modelfile)
- [Ollama context length guidance](https://docs.ollama.com/context-length)
- [Ollama FAQ: context, unloading, locations, Windows environment variables](https://docs.ollama.com/faq)
- [Qwen3.5 9B Q4_K_M in the Ollama library](https://ollama.com/library/qwen3.5:9b-q4_K_M)
- [Official Ollama Python library](https://github.com/ollama/ollama-python)
- [Streamlit command-line installation and running apps](https://docs.streamlit.io/get-started/installation/command-line)
- [VS Code Python setup](https://code.visualstudio.com/docs/python/python-tutorial)
