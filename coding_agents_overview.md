# 🚀 Coding Agents Overview — Codex, Claude Code, GitHub Copilot, VS Code
> One table, one shared mini-project, four real vendor workflows — so you can compare how these tools actually behave, not just what their marketing says.

> 🗓️ Last verified: 2026-10-06

## 🎯 What You Will Build
Nothing here directly — this file is the map. The real hands-on work happens in the four vendor-specific guides below, where you'll each time create the same tiny broken Python script, `reverse.py` (a console program that reverses a string but has a deliberate off-by-one bug that drops the first character), and use that vendor's actual tooling to find and fix it. Following the same mini-project through all four tools is the fastest way to feel the real differences between them instead of just reading about features.

## 📚 Prerequisites
- Basic comfort with a terminal and Python.
- No prior AI-tool experience needed — each vendor guide starts from installation.
- If you've used this repo's [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) or [`ai_journey.md`](ai_journey.md), note the distinction up front: those guides are about **building your own application agents** (an LLM deciding which tool to call to satisfy a user request, in software you write and run). This file and its four companions are about **coding assistants** — Codex, Claude Code, GitHub Copilot, and VS Code's AI features — that help *you* write code. Both use the word "agent"; they solve different problems.

## 🏷️ Difficulty: 🟢 Beginner

## What is a "coding agent"?
A coding agent is a tool that can **read your repository, decide what to do, take multiple actions (edit files, run commands, run tests), and check its own results** across a multi-step task — as opposed to an autocomplete-only assistant, which only predicts the next few tokens or lines as you type and has no independent ability to read other files, run a command, or verify its own output. Inline "ghost text" suggestions (like classic Copilot completions) are the autocomplete end of the spectrum; Codex, Claude Code, and the agent modes of GitHub Copilot and VS Code are the "coding agent" end — they plan, act, and verify in a loop, with varying levels of human approval required at each step.

## 🧩 Comparison Table
Every cell below reflects what each vendor's **own current official documentation** states, fetched and read on the "last verified" date above — not an assumption of feature parity. Where a capability wasn't confirmable from an official source during this research pass, the cell honestly says so instead of guessing.

| Capability | Codex | Claude Code | GitHub Copilot | VS Code |
|---|---|---|---|---|
| Project instructions | ✅ `AGENTS.md` (directory chain, closest wins) | ✅ `CLAUDE.md` (also reads repo `AGENTS.md`) | ✅ `.github/copilot-instructions.md` | ✅ Reads the selected harness's project instructions; Local agent also supports `.github/copilot-instructions.md` via a setting |
| User/global instructions | ✅ `~/.codex/AGENTS.md` | ✅ `~/.claude/CLAUDE.md` | ✅ `~/.copilot/copilot-instructions.md` | ✅ User-profile instructions (Local agent, roams via Settings Sync) or harness-specific user folders (Agent Host, does not roam) |
| Path-specific instructions | ⚠️ Partial — nested per-directory `AGENTS.md`/`AGENTS.override.md`, not glob-pattern file-type scoping | ✅ `.claude/rules/` with `paths` frontmatter | ✅ `.github/instructions/*.instructions.md` with `applyTo` | ✅ `*.instructions.md` with `applyTo` glob matching (Local agent) |
| Skills | ✅ `SKILL.md` in `.agents/skills/` (open Agent Skills standard) | ✅ Documented skills mechanism (same open standard) | ✅ `SKILL.md` in `.github/skills/` or `~/.copilot/skills/` (observed directly in this CLI) | ⚠️ Partial — depends entirely on selected harness; VS Code's own deprecated "prompt files" are being migrated toward Agent Skills |
| Custom/sub-agents | ⚠️ Partial/🧪 — parallel subagent delegation ships by default; no user-authored CLI subagent file format documented (only `agents/openai.yaml` metadata inside a skill) | ✅ `.claude/agents/*.md` or `~/.claude/agents/*.md`, YAML frontmatter | ✅ `.github/agents/*.agent.md` or `~/.copilot/agents/*.agent.md` (observed directly in this CLI) | ✅ Custom agents created through the selected harness's own mechanism |
| Parallel/background agents | ✅ Parallel subagents (default-on) + Codex Cloud for remote/background tasks | ✅ Documented background-agent view and cross-session messaging | ✅ Cloud sandbox (`copilot --cloud`) + Copilot coding agent (cloud, issue/PR/chat-triggered) | ✅ **Cloud** session target groups available cloud agents; Agent Host supports background sessions |
| MCP support | ✅ Documented under "Customization: project guidance, skills, MCP, and subagents" | ✅ `claude mcp add`, `.mcp.json` (portable `mcpServers` format) | ✅ `/mcp add` inside a session, or `~/.copilot/mcp-config.json` | ✅ `.vscode/mcp.json` (`servers`) or portable `.mcp.json` (`mcpServers`) at workspace root, or user-profile `mcp.json` |
| Hooks | ✅ Documented lifecycle hooks (`PreToolUse`, `PostToolUse`, `SessionStart`, etc.) in `hooks.json`/`config.toml`, with explicit per-hash trust review | ✅ Documented in `settings.json` (`hooks` block), e.g. `PostToolUse`, `Notification` | 🧪 Preview in VS Code's Agent Host integration, but the underlying Copilot SDK hook implementation itself is documented as generally available | 🧪 Preview — VS Code's own hooks UI/experience is explicitly labeled Preview; behavior and event names depend on the selected harness |
| Approval/permission model | ✅ Two-layer model: sandbox mode (`read-only`/`workspace-write`/`danger-full-access`) + approval policy (`on-request`/`never`); `untrusted` policy is retired | ✅ Permission modes per session, plus hook-enforced blocking (`PreToolUse`) for deterministic control | ✅ Manual tool approval by default; `--allow-tool`/`--allow-all-tools` for automatic approval; local/cloud sandboxing (🧪 Preview) | ✅ Per-session **Permissions** control (e.g., Manual permissions); worktree sessions default to Allow all |
| IDE integration | ✅ Codex IDE extension, plus a VS Code "Codex" session target/harness | ✅ Claude Code IDE extensions (VS Code, JetBrains) and a VS Code "Claude" session target/harness | ✅ Native Copilot extension across VS Code, JetBrains, Visual Studio, and more | ✅ Native — VS Code is the IDE being integrated into |

❓ If you find a cell above has changed since 2026-10-06 (these products ship fast), treat this table as a snapshot, not a permanent reference — re-check the linked official docs in each vendor guide before relying on a specific capability.

## 🚀 The shared mini-project, in one place
Across all four guides below you will, each time, in that vendor's own tooling:
1. Create `reverse.py` with a function that reverses a string but has a one-line off-by-one bug (`range(len(s) - 1, 0, -1)` instead of `range(len(s) - 1, -1, -1)`), which silently drops the first character of the input.
2. Reproduce the bug yourself by running the script directly — never trust an agent's claim of a bug without seeing it fail first.
3. Use that vendor's project-instructions mechanism (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, or VS Code's instructions settings) to give the agent a standing working agreement.
4. Ask the agent to find, explain, and fix the bug.
5. Re-run the script yourself to independently confirm the fix (`gnidoc`, not `gnido`, for input `"coding"`).
6. Go one step further with that vendor's distinguishing feature — a skill, a subagent, a hook, or an MCP server.

Doing this once per tool, back to back, makes the real differences in approval flow, instruction precedence, and extensibility concrete instead of abstract.

## 👀 Expected Result
After working through all four companion guides you should be able to state, for your own projects: which tool you'd reach for a quick terminal fix, which for a background/cloud task you can walk away from, and which instruction file format to standardize on if your team uses more than one of these tools (hint: `AGENTS.md` is explicitly a cross-agent, non-Codex-specific format that multiple vendors recognize).

## 🐛 Troubleshooting
If a claim in any of the four guides doesn't match what you observe in your installed version, trust your own observation and the vendor's current docs over this file — AI coding tools change their UI and defaults frequently, which is exactly why every guide here carries a "Last verified" date and direct documentation links instead of only prose descriptions.

## 🏋️ Exercise
Pick the two tools from the table above that you're most likely to use together on a real team (e.g., GitHub Copilot CLI + VS Code, or Claude Code + VS Code). Write down, in your own words, which single instruction file format you'd standardize on across both, and why — then verify your choice against both tools' "Project instructions" row in the table above.

## ✅ Checkpoint
- [ ] You can explain the autocomplete-vs-coding-agent distinction in one sentence.
- [ ] You understand this table reflects verified vendor docs as of 2026-10-06, not permanent fact.
- [ ] You know the four companion guides share one mini-project so you can compare like-for-like.

## 🔗 Related Topics
- [`codex_practical_guide.md`](codex_practical_guide.md) — OpenAI Codex, hands-on.
- [`claude_code_practical_guide.md`](claude_code_practical_guide.md) — Anthropic Claude Code, hands-on.
- [`github_copilot_practical_guide.md`](github_copilot_practical_guide.md) — GitHub Copilot (Chat, agent mode, coding agent, CLI), hands-on.
- [`vscode_ai_practical_guide.md`](vscode_ai_practical_guide.md) — VS Code's native AI UI, hands-on.
- [`deep-research-report.md`](deep-research-report.md) — the "AI Coding-Agent Configuration Handbook": shared configuration concepts (instructions, task briefs, skills, custom agents, hooks) explained once, in depth, across these same three vendor CLIs.
- [`agents_and_subagents_lab.md`](agents_and_subagents_lab.md) — a different concept: building your **own** application agents, not using a coding assistant.

## ➡️ Next
Start with [`codex_practical_guide.md`](codex_practical_guide.md), or jump straight to whichever vendor you already use — each guide is self-contained and begins with installation.
