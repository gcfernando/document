# 🚀 OpenAI Codex — Practical Guide
> Install Codex, teach it your project with `AGENTS.md`, and use it to find and fix a real bug.

## 🎯 What You Will Build
You will install the Codex CLI, point it at a tiny broken Python script (`reverse.py`), and use Codex's agentic loop (read → plan → edit → run) to locate and fix a deliberate off-by-one bug — the same mini-project used in the Claude Code, GitHub Copilot, and VS Code guides so you can compare how each tool actually works.

## 📚 Prerequisites
- A terminal (PowerShell on Windows is fine) and Python 3 installed.
- A ChatGPT account (Plus/Pro/Team/Business/Edu/Enterprise) or an OpenAI API key — Codex CLI supports both sign-in methods.
- Read [`coding_agents_overview.md`](coding_agents_overview.md) first if you haven't picked a tool yet.
- For shared configuration concepts (instructions vs. skills vs. agents vs. hooks, in general), see [`deep-research-report.md`](deep-research-report.md#1--choose-the-right-artifact-before-making-a-file). This guide only covers what is **Codex-specific**.

## 🏷️ Difficulty: 🟢 Beginner (Steps 1-4) → 🟡 Intermediate (Step 5, subagents/skills)
> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - Codex CLI: https://learn.chatgpt.com/docs/codex/cli
> - AGENTS.md discovery: https://learn.chatgpt.com/docs/agent-configuration/agents-md
> - Agent approvals & security (sandbox/approval policy): https://learn.chatgpt.com/docs/agent-approvals-security
> - Subagents: https://learn.chatgpt.com/docs/agent-configuration/subagents
> - Build skills: https://learn.chatgpt.com/docs/build-skills
> - Codex Cloud: https://learn.chatgpt.com/docs/cloud

## 🛠️ Setup

### Install Codex CLI
Official docs list three install methods (all verified current as of 2026-10-06):

```powershell
# Windows PowerShell — standalone installer
powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"

# OR via npm (cross-platform, requires Node.js)
npm install -g @openai/codex
```

Then sign in:

```powershell
codex
```

On first run you'll be prompted to **Sign in with ChatGPT** (or another supported method). Confirm it worked:

```powershell
codex --version
```

> ⚠️ If `codex` isn't recognized after an npm install, open a new terminal so your `PATH` picks up the global npm bin directory.

## 🚀 Step 1 — Create the buggy mini-project

```powershell
mkdir codex-lab; cd codex-lab
```

Create `reverse.py` with a **deliberate off-by-one bug** (the `range` stops one character short, so the first character of the input is dropped from the reversal):

```python
def reverse_string(s: str) -> str:
    result = ""
    for i in range(len(s) - 1, 0, -1):  # BUG: should be -1, -1, -1 (stop at index 0 inclusive)
        result += s[i]
    return result

if __name__ == "__main__":
    text = "hello"
    print(f"Original: {text}")
    print(f"Reversed: {reverse_string(text)}")
```

Run it to see the bug yourself first (this is the "before" baseline):

```powershell
python reverse.py
```

**Expected (buggy) output:**
```
Original: hello
Reversed: olleh
```
Wait — that actually looks right for "hello" because the dropped character happens to be `h`... but it silently drops the **first character of any input** from the output. Prove it with a clearer input:

```powershell
python -c "from reverse import reverse_string; print(reverse_string('coding'))"
```
Expected buggy output: `gnido` (the leading `c` is missing — correct reversal is `gnidoc`).

## 🚀 Step 2 — Let Codex read repo context

Start an interactive session in the project folder:

```powershell
codex
```

Ask it to orient itself first (this exercises Codex's repo-reading behavior, not a special command):
```
Tell me about this project
```
Codex reads the files in your working directory to answer — there is no separate "index" step to run.

### ✅ Verified: `AGENTS.md` is real and currently supported
Codex reads `AGENTS.md` files **before doing any work**, building an instruction chain from your Codex home directory (`~/.codex/AGENTS.md`) down through the project root to your current directory, closest file wins for conflicts. Try it:

```powershell
notepad AGENTS.md
```
Add:
```markdown
# AGENTS.md
## Working agreements
- Always run `python reverse.py` after changing reverse.py to confirm behavior.
- Keep functions small and add a one-line docstring to any function you fix.
```
Verify Codex picked it up:
```powershell
codex --ask-for-approval never "Summarize the current instructions."
```
Expected: Codex echoes back the working agreements you just wrote.

## 🚀 Step 3 — Ask Codex to find and fix the bug

Back in the interactive session (or via `codex exec` for a one-shot run):

```
This reverse_string function has a bug — it drops a character for some inputs. Find the bug, fix it, and show me the diff.
```

Codex will typically: read `reverse.py`, reason about the `range()` bounds, propose an edit, and (depending on your approval policy) ask before applying it or running commands.

**Expected fix** — the loop bound should include index 0:
```python
def reverse_string(s: str) -> str:
    result = ""
    for i in range(len(s) - 1, -1, -1):  # fixed: stop value -1 means index 0 is included
        result += s[i]
    return result
```

## 🚀 Step 4 — Verify the fix yourself

Don't just trust the agent — rerun the exact check that exposed the bug:

```powershell
python -c "from reverse import reverse_string; print(reverse_string('coding'))"
```
**Expected (fixed) output:** `gnidoc`

## 🚀 Step 5 — Approval and sandbox model (as currently documented)

Codex's safety model has two independent layers, confirmed from the official "Agent approvals & security" page:

| Layer | What it controls | Example values |
|---|---|---|
| **Sandbox mode** | What Codex can technically do (filesystem/network) | `read-only`, `workspace-write`, `danger-full-access` |
| **Approval policy** | When Codex must stop and ask before acting | `on-request`, `never` (the older `untrusted` policy is **retired**) |

By default, Codex CLI runs with **no network access** and file writes limited to your current workspace. A common safe combination for this lab:

```powershell
codex --sandbox workspace-write --ask-for-approval on-request
```

🧪 **Preview features, explicitly labeled by OpenAI's own docs:**
- **Subagents** — Codex can delegate independent sub-tasks (e.g., codebase exploration) to parallel specialized agents and fold their results back into the main thread. Current CLI releases enable this by default; use `/agent` in the interactive CLI to inspect/switch threads. This is **not** the same mechanism as Claude Code's `.claude/agents/*.md` files or GitHub Copilot's `.github/agents/*.agent.md` — Codex does not document a user-authored custom-subagent file format in the CLI the way those two do (only via its own `agents/openai.yaml` metadata inside a skill).
- **Skills** — Codex supports **Agent Skills** (the same open `SKILL.md` standard referenced by Claude Code and Copilot). Codex looks for skills in `.agents/skills/` in your repo (and user/admin/system locations). Create one with the built-in `$skill-creator` or by hand:
  ```markdown
  ---
  name: fix-reverse-bugs
  description: Explain exactly when this skill should trigger — e.g. "Use when asked to debug off-by-one errors in string/array reversal code."
  ---
  Check loop bounds carefully: for reversing a sequence of length n, a
  backward range must stop at -1, not 0, to include index 0.
  ```
  Invoke explicitly with `$fix-reverse-bugs` in the CLI, or let Codex match it implicitly from the task description.
- **Codex Cloud** — background/remote task execution in OpenAI-managed containers, started from the ChatGPT app/web by publishing an "environment" tied to a GitHub repo, then sending it a task. This is Codex's equivalent of a cloud/background coding agent; it is **not** triggered from a GitHub issue assignment the way the GitHub Copilot coding agent is.

- **Hooks** — Codex does support a documented hooks extensibility framework (events include `PreToolUse`, `PostToolUse`, `SessionStart`, `SessionEnd`, `SubagentStart/Stop`, and more), configured via `hooks.json` or inline `[hooks]` tables in `config.toml` at `~/.codex/` (user) or `<repo>/.codex/` (project). Unlike Claude Code's model, Codex requires you to explicitly **review and trust** each non-managed hook (by hash) via `/hooks` before it runs — a safety step worth calling out since it differs from how Claude Code hooks activate once written to `settings.json`.

## 👀 Expected Result
- `reverse.py` now correctly reverses any string, verified by rerunning the Python one-liner.
- You have a project-root `AGENTS.md` whose instructions Codex echoed back to you, proving it was actually read.
- You can state, accurately, which Codex features are stable (AGENTS.md, CLI install, sandbox/approval model, skills) vs. preview/default-on-but-newer (subagents) vs. unverified (hooks).

## 🐛 Troubleshooting
- **`codex` command not found after install** — open a new terminal/PowerShell window so `PATH` updates take effect.
- **Codex doesn't mention your `AGENTS.md` content** — confirm the file isn't empty (Codex skips empty files) and that you're running `codex` from inside the project directory (or a subdirectory of it).
- **Codex asks for approval on every command** — that's the default `on-request` approval policy working as documented; use `--ask-for-approval never` only in a disposable/sandboxed environment, never on a machine with sensitive data, since it removes a real safety control.

## 🏋️ Exercise
Add a second bug to a copy of `reverse.py` (e.g., an off-by-one in a palindrome checker), write an `AGENTS.md` rule requiring Codex to add a unit test for every bug it fixes, and confirm in a fresh `codex` session that it both fixes the bug **and** adds the test without being told to write tests again in your prompt.

## ✅ Checkpoint
- [ ] Codex CLI installed and signed in (`codex --version` works).
- [ ] `reverse.py` bug reproduced and confirmed via direct Python execution (not agent claims).
- [ ] `AGENTS.md` written and confirmed loaded by Codex.
- [ ] Bug fixed by Codex and independently re-verified by you.
- [ ] You can name which Codex capabilities are stable vs. preview vs. unverified, per this file.

## 🔗 Related Topics
- [`coding_agents_overview.md`](coding_agents_overview.md) — the cross-vendor comparison table.
- [`claude_code_practical_guide.md`](claude_code_practical_guide.md) — same mini-project with Claude Code.
- [`github_copilot_practical_guide.md`](github_copilot_practical_guide.md) — same mini-project with GitHub Copilot.
- [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) — same mini-project inside VS Code's own UI (which can also run a Codex session as a harness).
- [`deep-research-report.md`](deep-research-report.md) — shared configuration concepts (instructions, skills, agents, hooks) across all three vendors.

## ➡️ Next
Continue to [`claude_code_practical_guide.md`](claude_code_practical_guide.md) to run the identical bug-fix task through Claude Code, then compare the two workflows side by side using the table in [`coding_agents_overview.md`](coding_agents_overview.md).
