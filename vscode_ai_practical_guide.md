# 🚀 VS Code AI Features — Practical Guide
> Use VS Code's native Chat/Agents UI — ask, agent, and plan modes, custom instructions, MCP, and debugging AI — on the same real bug.

## 🎯 What You Will Build
You will fix the same deliberate off-by-one bug in `reverse.py` using VS Code's built-in Chat view and agent modes, add workspace custom instructions, configure an MCP server in `.vscode/mcp.json`, and use VS Code's "Explain" smart action plus a breakpoint to understand the bug before fixing it — completing the same mini-project used across the Codex, Claude Code, and GitHub Copilot guides.

## 📚 Prerequisites
- VS Code installed, with the GitHub Copilot extension (the quickstart harness used in official docs) signed in. VS Code can also run Claude or Codex as an alternate "harness" — this guide uses the default Copilot harness for its click-paths.
- Python 3 and the VS Code Python extension for the debugging step.
- For shared configuration concepts (instructions vs. skills vs. agents vs. hooks, in general), see [`deep-research-report.md`](deep-research-report.md#1--choose-the-right-artifact-before-making-a-file). This guide covers what is **VS Code-UI-specific**.

## 🏷️ Difficulty: 🟢 Beginner (Steps 1-4) → 🟡 Intermediate (Step 5-6, MCP/debugging)
> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - Build with AI in VS Code (overview): https://code.visualstudio.com/docs/agents/overview
> - Chat overview: https://code.visualstudio.com/docs/chat/chat-overview
> - Choose an agent harness: https://code.visualstudio.com/docs/agents/run/agent-harnesses
> - Custom instructions: https://code.visualstudio.com/docs/agent-customization/custom-instructions
> - Prompt files: https://code.visualstudio.com/docs/agent-customization/prompt-files
> - MCP servers in VS Code: https://code.visualstudio.com/docs/agent-customization/mcp-servers
> - AI-powered inline suggestions: https://code.visualstudio.com/docs/editing/ai-powered-suggestions
> - Smart actions (Explain/Fix): https://code.visualstudio.com/docs/editing/copilot-smart-actions

## 🛠️ Setup
1. Install VS Code and open a folder.
2. Install the GitHub Copilot extension and sign in (Command Palette → `GitHub Copilot: Sign In`, exact wording may vary by version — ⚠️ UI may have changed, verify in your installed version).
3. Open the Chat view: `Ctrl+Alt+I`.

## 🚀 Step 1 — Create the buggy mini-project

Create a folder and open it in VS Code:
```powershell
mkdir vscode-lab; cd vscode-lab
code .
```
Create `reverse.py`:
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
Run it in the integrated terminal:
```powershell
python reverse.py
```
**Expected (buggy) output:** `Reversed: gnido` (missing leading `c`; correct is `gnidoc`).

## 🚀 Step 2 — Explain the bug without editing (smart action)

Select the `reverse_string` function body in the editor. Right-click and select **Explain** (a current, documented smart action). VS Code opens Chat with an explanation grounded in the selected code — no prompt-writing needed. ⚠️ Exact menu wording/placement may change between VS Code versions; if **Explain** isn't in the right-click menu, check the lightbulb/Code Actions menu instead.

## 🚀 Step 3 — Debug it with a breakpoint first

1. Click in the gutter to the left of `result += s[i]` to set a breakpoint.
2. Open the Run and Debug view and start debugging `reverse.py` (select the Python debugger if prompted).
3. Step through and inspect `i` each iteration — you'll see it never reaches `0`, confirming the off-by-one visually before asking AI to fix anything.

This pairs standard VS Code debugging (breakpoints, variable inspection) with the "Explain" step above — useful for building your own understanding alongside, not instead of, the agent's explanation.

## 🚀 Step 4 — Fix it with Chat (Ask → Agent → Plan)

Open the Chat view (`Ctrl+Alt+I`). Per current docs, the session controls include **Session Target** (which harness — e.g., Copilot) and **Agent** (which mode — **Ask**, **Agent**, or **Plan**; older "Edit mode" terminology from earlier Copilot releases is no longer the current documented model, so don't assume a separate "Edit" mode still exists in your version without checking).

1. Select **Ask** and confirm your own diagnosis:
   ```
   Confirm: does the range() in reverse_string stop one index too early?
   ```
2. Select **Agent** mode and ask it to implement the fix:
   ```
   Fix the off-by-one bug in reverse_string in reverse.py so it reverses the whole string. Run reverse.py afterward and show the output.
   ```
3. Review the proposed diff in the inline review UI before accepting.

**Expected fix:**
```python
for i in range(len(s) - 1, -1, -1):  # fixed
```
Verify yourself in the terminal:
```powershell
python reverse.py
```
**Expected (fixed) output:** `Reversed: gnidoc`

## 🚀 Step 5 — Workspace custom instructions

Custom instructions let you avoid repeating guidance in every prompt. Create `.github/copilot-instructions.md` at the workspace root (discovered automatically for Copilot sessions when the `github.copilot.chat.codeGeneration.useInstructionFiles` setting is enabled for the Local agent; Agent Host sessions read it directly):
```markdown
# Workspace instructions
- After fixing a bug in a Python file, always rerun it and paste the output.
```
For instructions scoped to specific files only, create `.github/instructions/python.instructions.md`:
```markdown
---
applyTo: "**/*.py"
---
Add a one-line comment explaining any fixed loop-boundary bug.
```
Verify via the Command Palette: run **Chat: Open Customizations** to see discovered instruction files for your currently selected harness.

🧪 **Preview / deprecated note:** Prompt files (`.prompt.md`, invoked as slash commands) are officially marked **deprecated for Agent Host sessions** in current docs — they still work with the older "Local agent" for now but are being migrated toward Agent Skills. Don't build new workflows around prompt files without checking their current status first.

## 🚀 Step 6 — Configure an MCP server

Current documented locations for MCP server configuration in VS Code:

| Location | Format | Scope |
|---|---|---|
| `.vscode/mcp.json` | top-level `servers` object | Workspace (VS Code-native format) |
| `.mcp.json` (project root) | top-level `mcpServers` object | Workspace (portable format, shared with other tools like Claude Code) |
| User profile `mcp.json` (via **MCP: Open User Configuration** command) | — | All your workspaces |

Example `.vscode/mcp.json`:
```json
{
  "servers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    }
  }
}
```
Add it via the Command Palette too: **MCP: Add Server**. Confirm it loaded by opening Chat and checking the **Configure Tools** button for the new server's tools.

## 👀 Expected Result
- The bug diagnosed via **Explain**, confirmed by stepping through with a breakpoint, fixed via **Agent** mode, and independently re-verified in the terminal.
- A workspace `.github/copilot-instructions.md` and a path-specific `.github/instructions/python.instructions.md`, both visible in **Chat: Open Customizations**.
- A configured `.vscode/mcp.json` with at least one server whose tools appear in Chat.

## 🐛 Troubleshooting
- **No "Session Target" or "Agent" dropdown visible** — these controls are part of the newer Agents/Agent Host UI; older VS Code versions used different wording ("Chat modes: Ask/Edit/Agent"). ⚠️ UI may have changed — verify in your installed version rather than assuming this guide's exact labels match.
- **Instructions file seems ignored** — for the Local agent, confirm `github.copilot.chat.codeGeneration.useInstructionFiles` is enabled in Settings; Agent Host sessions read `.github/copilot-instructions.md` without that setting.
- **MCP server doesn't appear in Chat** — confirm you accepted the trust prompt when VS Code asked to start the server; local MCP servers can run arbitrary code, so only add ones from sources you trust.

## 🏋️ Exercise
Add a second, deliberately-broken function to `reverse.py` (e.g., a palindrome checker with a similar off-by-one), then use **Plan** mode to have the agent propose a fix plan for both bugs before implementing anything — review the plan card, request one change to it, and only then approve implementation.

## ✅ Checkpoint
- [ ] Bug diagnosed with **Explain** and a breakpoint, then fixed via **Agent** mode, and independently re-verified.
- [ ] Workspace and path-specific instruction files created and confirmed via **Chat: Open Customizations**.
- [ ] `.vscode/mcp.json` configured with a working server.
- [ ] You know prompt files are currently marked deprecated for Agent Host sessions, so you won't build new work around them without checking status first.

## 🔗 Related Topics
- [`coding_agents_overview.md`](coding_agents_overview.md) — the cross-vendor comparison table.
- [`codex_practical_guide.md`](codex_practical_guide.md), [`claude_code_practical_guide.md`](claude_code_practical_guide.md), [`github_copilot_practical_guide.md`](github_copilot_practical_guide.md) — the same mini-project with each vendor's own CLI/cloud workflow (VS Code can run Claude and Codex as alternate harnesses too).
- [`deep-research-report.md`](deep-research-report.md) — shared configuration concepts; see its [Minimal VS Code workflow](deep-research-report.md#minimal-vs-code-workflow) and [VS Code custom agent](deep-research-report.md#vs-code-custom-agent-create-through-the-selected-harness) sections for more depth.

## ➡️ Next
Return to [`coding_agents_overview.md`](coding_agents_overview.md) to compare all four tools' current capabilities side by side, or revisit [`deep-research-report.md`](deep-research-report.md) for the underlying configuration concepts (instructions, skills, agents, hooks) shared across vendors.
