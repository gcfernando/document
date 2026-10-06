# 🚀 GitHub Copilot — Practical Guide (Chat, Agent Mode, Coding Agent, CLI)
> Fix the same real bug four ways: Copilot Chat in an IDE, the cloud coding agent, and GitHub Copilot CLI.

## 🎯 What You Will Build
Using the same tiny broken `reverse.py` script (an off-by-one bug) from the other vendor guides, you will: (1) fix it with Copilot Chat's ask/agent modes in an IDE, (2) delegate the same fix to the GitHub Copilot **coding agent** via an issue, and (3) fix it again from the terminal with **GitHub Copilot CLI** — the tool you are reading this inside of right now — including repository instructions, path-specific instructions, a custom agent, a skill, and MCP.

## 📚 Prerequisites
- A GitHub Copilot subscription (Free tier covers Chat/inline suggestions with monthly limits; agent/coding-agent features may require a paid plan — check your org's entitlements).
- A code editor with the GitHub Copilot extension (VS Code, JetBrains, etc.) for the Chat/agent-mode steps — or follow the CLI-only steps if you don't have an IDE handy.
- Node.js (for `npm install -g @github/copilot`), if installing Copilot CLI that way.
- For shared configuration concepts (instructions vs. skills vs. agents vs. hooks, in general), see [`deep-research-report.md`](deep-research-report.md#1--choose-the-right-artifact-before-making-a-file). This guide covers what is **GitHub-Copilot-specific** across its four surfaces.

## 🏷️ Difficulty: 🟢 Beginner (Steps 1-3) → 🟡 Intermediate (Step 4, coding agent) → 🟡 Intermediate (Step 5, CLI customization)
> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - Copilot CLI: https://docs.github.com/en/copilot/concepts/copilot-surfaces/copilot-cli
> - Copilot on GitHub.com (cloud/coding agent): https://docs.github.com/en/copilot/concepts/copilot-surfaces/copilot-on-github
> - Repository custom instructions: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions
> - VS Code AI overview (for the IDE Chat steps): https://code.visualstudio.com/docs/agents/overview

## 🛠️ Setup

### IDE Chat (Steps 1-3)
Install the GitHub Copilot extension in your editor and sign in. This guide uses VS Code's wording; see [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) for VS Code-specific UI click-paths.

### Copilot CLI (Steps 4-5)
```powershell
npm install -g @github/copilot
copilot
```
Confirm you can start an interactive session (the welcome screen appears). This guide's CLI-specific claims (custom agents, skills, MCP, repository instructions) describe mechanisms directly observable in a real Copilot CLI session, not just docs claims.

## 🚀 Step 1 — Create the buggy mini-project

```powershell
mkdir copilot-lab; cd copilot-lab
```
```python
# reverse.py
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
Reproduce the bug:
```powershell
python reverse.py
```
**Expected (buggy) output:** `Reversed: gnido` (missing leading `c`; correct is `gnidoc`).

## 🚀 Step 2 — Fix it with Copilot Chat (ask mode) in your IDE

Open Copilot Chat, select **Ask** (for a question/explanation without edits), and ask:
```
Why does reverse_string() in reverse.py produce "gnido" instead of "gnidoc" for input "coding"?
```
Expected: Copilot explains the `range()` stop-value off-by-one without touching the file.

## 🚀 Step 3 — Fix it with agent mode

Switch to **Agent** mode (per current VS Code/Copilot docs, modes are **Ask**, **Agent**, and **Plan** — note that the "Edit mode" terminology from earlier Copilot releases has been superseded; verify the mode names shown in your installed version, since UI terminology has changed more than once ⚠️):
```
Fix the off-by-one bug in reverse_string so it reverses the full string. Then run reverse.py and show me the output.
```
Review and accept the proposed edit. **Expected fix:**
```python
for i in range(len(s) - 1, -1, -1):  # fixed
```
Verify yourself:
```powershell
python reverse.py
```
**Expected (fixed) output:** `Reversed: gnidoc`

## 🚀 Step 4 — Delegate the fix to the Copilot coding agent (cloud/background agent)

This is GitHub's cloud agent that works in an ephemeral environment and opens a pull request. Per current docs, you can start this work from **the agents panel on GitHub.com, a Copilot Chat conversation, or directly from a GitHub issue or pull request** — not only by "assigning" an issue the way older docs described; verify the exact entry point in your own repository's UI, since GitHub continues to add starting points for this feature.

1. Push `reverse.py` (with the bug reintroduced) to a GitHub repository.
2. Open an issue: *"reverse_string() drops the first character of the input for some strings — fix the off-by-one bug in reverse.py."*
3. From the issue (or the agents panel at `github.com/copilot/agents`), delegate the task to Copilot's coding agent.
4. Copilot researches the repo, edits the file in a cloud dev environment, runs available tests/linters, and opens a pull request for your review.

**Expected result:** A PR containing the same one-line fix, with session logs showing what Copilot read, changed, and verified. You review and merge — the coding agent does not merge on its own.

## 🚀 Step 5 — Fix it again with GitHub Copilot CLI (this tool), including customizations

These mechanisms are directly observable in this CLI session, so they're stated here as verified, not guessed:

```powershell
cd copilot-lab
copilot
```
Ask Copilot CLI to find and fix the same bug:
```
Find and fix the off-by-one bug in reverse.py, then rerun it to prove the fix.
```

### Repository instructions
Create `.github/copilot-instructions.md` at the repo root for project-wide guidance Copilot reads automatically:
```markdown
# Repository instructions
- After fixing any bug in a Python file, rerun the script and paste the output.
- Prefer minimal, single-purpose diffs.
```

### Path-specific instructions
Create `.github/instructions/python.instructions.md` to scope guidance to only matching files:
```markdown
---
applyTo: "**/*.py"
---
Add a one-line comment explaining any fixed loop-boundary bug.
```

### Custom agent
Copilot CLI custom agents are Markdown files with `.agent.md` extension in `.github/agents/` (project) or `~/.copilot/agents/` (personal), invoked with `/agent` or `copilot --agent <id>`:
```markdown
---
name: bug-fixer
description: Finds and fixes off-by-one bugs in small Python scripts, then reruns them to verify.
---
You are a careful bug-fixing specialist. Explain each bug in one sentence,
show the fix, and always rerun the affected script to confirm correct output.
```

### Skill
Skills are folders with a `SKILL.md` file under `.github/skills/` (project) or `~/.copilot/skills/` (personal):
```markdown
---
name: verify-reverse-fix
description: Use when asked to fix a string-reversal bug in reverse.py. Reruns the script after any edit to confirm output.
---
After editing reverse.py, always run `python reverse.py` and paste the output
before declaring the task done.
```

### MCP
Add an MCP server interactively with `/mcp add` inside a Copilot CLI session, or configure it directly in `~/.copilot/mcp-config.json` (or `$COPILOT_HOME/mcp-config.json` if that variable is set) under a top-level `mcpServers` key.

## 👀 Expected Result
- Bug explained via Ask mode, then fixed via Agent mode, both verified by rerunning `reverse.py` yourself.
- A coding-agent pull request containing the equivalent fix (if you have access to a real GitHub repo to test with).
- A Copilot CLI session that reads your `.github/copilot-instructions.md` and path-specific instructions, and can invoke your custom agent and skill.

## 🐛 Troubleshooting
- **Agent mode not visible in your IDE** — confirm your Copilot extension is updated; mode names and the mode-switcher UI have changed across releases — if you don't see Ask/Agent/Plan exactly as described, check your installed version's own release notes.
- **Coding agent option missing from an issue/PR** — this feature's availability and entry points depend on your plan and organization policy; check `github.com/copilot/agents` directly rather than assuming a specific UI element exists.
- **Copilot CLI doesn't pick up `.github/copilot-instructions.md`** — confirm you're running `copilot` from inside the repository root or a subdirectory, and that the file isn't empty.

## 🏋️ Exercise
Write a `.github/instructions/tests.instructions.md` path-specific instruction scoped to `**/*_test.py` requiring a docstring on every test function, then ask Copilot CLI to add a test file for `reverse_string` and confirm the generated test follows that rule without you repeating it in the prompt.

## ✅ Checkpoint
- [ ] Bug explained via Ask mode and fixed via Agent mode in an IDE, both independently verified.
- [ ] You understand the coding agent's actual entry points (agents panel, chat, issue/PR) rather than assuming only one trigger exists.
- [ ] Copilot CLI used to fix the same bug, with repository instructions, path-specific instructions, a custom agent, and a skill all created and exercised.

## 🔗 Related Topics
- [`coding_agents_overview.md`](coding_agents_overview.md) — the cross-vendor comparison table.
- [`codex_practical_guide.md`](codex_practical_guide.md) and [`claude_code_practical_guide.md`](claude_code_practical_guide.md) — the same mini-project with the other two vendors.
- [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) — VS Code's own native UI workflow, which can use Copilot, Claude, or Codex as a harness.
- [`deep-research-report.md`](deep-research-report.md) — shared configuration concepts; see its [Copilot CLI read-only reviewer template](deep-research-report.md#copilot-cli-read-only-reviewer-template-illustrative) for another worked custom-agent example.

## ➡️ Next
Continue to [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) to see the same mini-project through VS Code's native chat/agent UI, including its own instructions, prompt files, and MCP configuration.
