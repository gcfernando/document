# 🚀 Claude Code — Practical Guide
> Install Claude Code, teach it your project with `CLAUDE.md`, and use subagents/hooks/MCP to fix a real bug.

## 🎯 What You Will Build
You will install Claude Code, create a project `CLAUDE.md`, and use Claude Code's agentic workflow to find and fix a deliberate off-by-one bug in a tiny `reverse.py` script — the same mini-project used in the Codex, GitHub Copilot, and VS Code guides so you can compare real workflows, not just descriptions of them. You'll also create one custom subagent and one safe (non-blocking) hook.

## 📚 Prerequisites
- A terminal and Python 3 installed.
- A Claude subscription or Anthropic Console/API account.
- Read [`coding_agents_overview.md`](coding_agents_overview.md) first if you haven't picked a tool yet.
- For shared configuration concepts (instructions vs. skills vs. agents vs. hooks, in general), see [`deep-research-report.md`](deep-research-report.md#1--choose-the-right-artifact-before-making-a-file). This guide only covers what is **Claude-Code-specific**, using Claude Code's own current terminology (which differs in places from this repo's other guides — don't assume file names or locations match another vendor).

## 🏷️ Difficulty: 🟢 Beginner (Steps 1-4) → 🟡 Intermediate (Step 5-6, subagents/hooks/MCP)
> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - Overview: https://code.claude.com/docs/en/overview
> - Memory (CLAUDE.md / AGENTS.md): https://code.claude.com/docs/en/memory
> - Subagents: https://code.claude.com/docs/en/sub-agents
> - Hooks: https://code.claude.com/docs/en/hooks-guide
> - MCP: https://code.claude.com/docs/en/mcp

## 🛠️ Setup

### Install Claude Code
Official current install methods (Windows):

```powershell
# Native installer (recommended) — auto-updates
irm https://claude.ai/install.ps1 | iex

# OR WinGet
winget install Anthropic.ClaudeCode
```

Start it in a project directory:

```powershell
cd your-project
claude
```

You'll be prompted to log in on first use (or it reads `ANTHROPIC_API_KEY` if set). Confirm:

```powershell
claude --version
```

## 🚀 Step 1 — Create the buggy mini-project

```powershell
mkdir claude-lab; cd claude-lab
```

Create `reverse.py` with the same deliberate off-by-one bug used across all four vendor guides (the backward `range()` stops one index too early, silently dropping the first character of the input from the output):

```python
def reverse_string(s: str) -> str:
    result = ""
    for i in range(len(s) - 1, 0, -1):  # BUG: stop value should be -1, not 0
        result += s[i]
    return result

if __name__ == "__main__":
    text = "coding"
    print(f"Original: {text}")
    print(f"Reversed: {reverse_string(text)}")
```

Reproduce the bug yourself first:
```powershell
python reverse.py
```
**Expected (buggy) output:**
```
Original: coding
Reversed: gnido
```
Notice the leading `c` is missing — the correct reversal is `gnidoc`.

## 🚀 Step 2 — Project instructions with `CLAUDE.md`

Start Claude Code in the folder:
```powershell
claude
```

Claude Code's memory system is **CLAUDE.md** (it can also read a repo's existing `AGENTS.md`, alone or alongside `CLAUDE.md`). Per the official docs, `./CLAUDE.md` is loaded at the start of every session — it is Claude's own persistent-instructions mechanism, distinct from Codex's `AGENTS.md` chain and from Copilot's `.github/copilot-instructions.md`, even though all three serve a similar purpose.

Create `CLAUDE.md`:
```markdown
# CLAUDE.md
## Working agreements
- After editing reverse.py, always rerun it and show the output.
- Explain any loop-boundary bug in plain language before fixing it.
```

Ask Claude to confirm it loaded the file:
```
What working agreements are defined for this project?
```
Expected: Claude quotes back the two bullet points above.

## 🚀 Step 3 — Ask Claude Code to find and fix the bug

```
reverse_string() in reverse.py has a bug that drops a character for some inputs. Find it, explain it, fix it, and rerun the script to prove the fix.
```

Claude Code reads the file, edits it, and (per your permission mode) runs `python reverse.py` to verify — this loop of read → edit → run → check is the core of its agentic workflow.

**Expected fix:**
```python
def reverse_string(s: str) -> str:
    result = ""
    for i in range(len(s) - 1, -1, -1):  # fixed: -1 as the stop value includes index 0
        result += s[i]
    return result
```

## 🚀 Step 4 — Verify independently

```powershell
python reverse.py
```
**Expected (fixed) output:**
```
Original: coding
Reversed: gnidoc
```

## 🚀 Step 5 — Create a custom subagent (verified exact mechanism)

Claude Code subagents are **Markdown files with YAML frontmatter**, stored at:
- `~/.claude/agents/*.md` — personal, all projects
- `.claude/agents/*.md` — project-level, shared via source control

This is Claude Code's own file location/format — do not assume it matches Codex (which has no equivalent user-authored subagent file in the CLI) or GitHub Copilot CLI (which uses `.github/agents/*.agent.md`).

Ask Claude to generate one, or write it by hand:
```powershell
mkdir .claude\agents
notepad .claude\agents\bug-finder.md
```
```markdown
---
name: bug-finder
description: Scans small Python scripts for off-by-one errors in loop bounds and range() calls. Use after any reported "wrong output" bug in this repo.
tools: Read, Grep, Glob
model: sonnet
---

You are a focused bug-finding specialist. For each file you inspect, check
every range()/loop boundary, explain the problem in one sentence, show the
current code, and propose the corrected line. Do not make unrelated changes.
```
Verify Claude Code recognizes it:
```
List the available subagents for this project.
```
Expected: `bug-finder` appears alongside Claude Code's built-in subagents (`Explore`, `Plan`, `general-purpose`).

## 🚀 Step 6 — Hooks and MCP (confirmed current mechanisms)

**Hooks** are deterministic shell commands triggered by lifecycle events (`PreToolUse`, `PostToolUse`, `Notification`, etc.), configured in a settings file such as `~/.claude/settings.json` or a project `.claude/settings.json`. A safe, non-blocking example — log every file edit:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "echo Edited: >> .claude/edit-log.txt" }
        ]
      }
    ]
  }
}
```
Verify with `/hooks` inside a Claude Code session — your hook should appear under `PostToolUse`.

**MCP (Model Context Protocol)** connects Claude Code to external tools/data. Add a remote server with:
```powershell
claude mcp add --transport http notion https://mcp.notion.com/mcp
```
Servers can also be declared in a portable `.mcp.json` file at the project root (`mcpServers` top-level key) — this is the same portable format VS Code's workspace MCP configuration supports, so a server definition can often be shared between the two.

## 👀 Expected Result
- `reverse.py` fixed and the correct output (`gnidoc`) reproduced independently.
- A working `CLAUDE.md` whose contents Claude echoed back, proving it loaded.
- A custom `bug-finder` subagent recognized by Claude Code in `.claude/agents/`.
- A non-blocking `PostToolUse` hook visible via `/hooks`.

## 🐛 Troubleshooting
- **`claude` not found after install** — open a new terminal so PATH updates apply; on native Windows, installing Git for Windows is recommended so Claude Code can use the Bash tool (otherwise it falls back to PowerShell).
- **CLAUDE.md seems ignored** — confirm the file is at the project root (`./CLAUDE.md`) and that you started `claude` from within that project directory; CLAUDE.md files in parent directories above your working directory also load, so check for conflicting rules higher up.
- **Subagent doesn't appear** — check YAML frontmatter is valid (`name` and `description` are required) and that the file has a `.md` extension inside `.claude/agents/`.

## 🏋️ Exercise
Create a second subagent, `test-writer`, restricted to `Read, Write` tools, whose description says to trigger "after bug-finder identifies and reverse_string is fixed." Then ask Claude Code, in one message, to fix a newly introduced bug and let it delegate test-writing to `test-writer` automatically — confirm in the transcript that delegation actually happened rather than the main agent writing the test itself.

## ✅ Checkpoint
- [ ] Claude Code installed and signed in (`claude --version` works).
- [ ] `reverse.py` bug reproduced, fixed, and independently re-verified.
- [ ] `CLAUDE.md` created and confirmed loaded.
- [ ] `.claude/agents/bug-finder.md` subagent created and listed by Claude Code.
- [ ] A `PostToolUse` hook configured and confirmed via `/hooks`.

## 🔗 Related Topics
- [`coding_agents_overview.md`](coding_agents_overview.md) — the cross-vendor comparison table.
- [`codex_practical_guide.md`](codex_practical_guide.md) — same mini-project with OpenAI Codex.
- [`github_copilot_practical_guide.md`](github_copilot_practical_guide.md) — same mini-project with GitHub Copilot.
- [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) — same mini-project inside VS Code's own UI (which can also run a Claude session as a harness).
- [`deep-research-report.md`](deep-research-report.md) — shared configuration concepts across vendors; see its [Claude Code subagent example](deep-research-report.md#claude-code-subagent-create-an-actual-markdown-file) for another worked walkthrough.

## ➡️ Next
Continue to [`github_copilot_practical_guide.md`](github_copilot_practical_guide.md) to run the identical bug-fix task through GitHub Copilot's Chat, agent mode, coding agent, and CLI.
