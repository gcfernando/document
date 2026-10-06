# 🚀 Agent Skills: Packaging Expertise an AI Can Load On Demand

> Build a real `SKILL.md` folder on disk, verify its frontmatter against the current open spec, and see it get invoked.

**🏷️ Difficulty:** 🟡 Intermediate

> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - Agent Skills open specification: https://agentskills.io/specification
> - Claude Code skills: https://code.claude.com/docs/en/skills
> - This CLI's own skill discovery/behavior: see this session's `/help` output and the `skill` tool description (`.github/skills/`, `.claude/skills/`, `~/.copilot/skills/`, `~/.agents/skills/`)

## 🎯 What You Will Build

Two real, working skill folders on disk at `examples\skills\` in this repository:
- `dotnet-test-debugger/` — a fuller example with `SKILL.md`, `checklist.md`, and a verified PowerShell helper script.
- `documentation-validator/` — a shorter example demonstrating the same pattern with less ceremony.

Both are copy-as-a-template material: correct frontmatter, a sensible body, and an honest security note.

## 🧠 What Is This?

A **skill** is a folder containing a `SKILL.md` (YAML frontmatter + Markdown instructions) that an AI agent loads **only when relevant** — unlike an instruction file (always loaded every session) or a custom agent (a whole separate persona you explicitly switch to). Anthropic's own framing: *"Create a skill when you keep pasting the same instructions, checklist, or multi-step procedure into chat, or when a section of your instructions file has grown into a procedure rather than a fact."* The key cost difference: an instruction file's content is loaded at every session start whether used or not; a skill's body loads **only when it's actually used**, so long reference material costs almost nothing until needed. See [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) for the fuller instructions-vs-skill-vs-agent comparison.

Claude Code skills explicitly follow the **Agent Skills** open standard ([agentskills.io](https://agentskills.io/specification)), which multiple AI tools beyond Claude Code implement (Gemini CLI, OpenCode, OpenHands, Junie, and others, per the standard's own site) — meaning a correctly-formatted `SKILL.md` is genuinely portable, not Claude-specific. This repository's own CLI session (GitHub Copilot CLI) loads skills the same shape, from `.github/skills/`, `.claude/skills/`, `~/.copilot/skills/`, or `~/.agents/skills/` — confirmed directly from this session's own `skill` tool description.

## 📚 Prerequisites

- [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) — skills vs. instructions vs. agents.
- [mcp_practical_guide.md](mcp_practical_guide.md) — a skill's procedure can itself call MCP tools; they're complementary, not competing, mechanisms.

## 🛠️ Setup

Nothing to install — the two example skills already exist on disk in this repo at `examples\skills\dotnet-test-debugger\` and `examples\skills\documentation-validator\`. You can copy either folder into `.github/skills/`, `.claude/skills/`, or `~/.copilot/skills/` in any project to use it for real.

## 🚀 Step 1 — Inspect the verified frontmatter format

Per the current Agent Skills specification, `SKILL.md` frontmatter supports:

| Field | Required | Constraint |
|---|---|---|
| `name` | Yes | Max 64 chars, lowercase letters/digits/hyphens only, no leading/trailing/consecutive hyphens, **must match the parent directory name** |
| `description` | Yes | Max 1024 chars; must describe both *what* the skill does and *when* to use it |
| `license` | No | License name or reference to a bundled license file |
| `compatibility` | No | Max 500 chars; environment requirements (tooling, network access) |
| `metadata` | No | Arbitrary string→string map for tool-specific extensions |
| `allowed-tools` | No | Space-separated list of pre-approved tools (marked **experimental** by the spec itself — support varies between agent implementations) |

Open `examples\skills\dotnet-test-debugger\SKILL.md` in this repo and compare it line by line against this table — every field present there maps to a row above, nothing invented.

## 🚀 Step 2 — Build the fuller example: `dotnet-test-debugger`

Already created at `examples\skills\dotnet-test-debugger\`:

```
dotnet-test-debugger/
├── SKILL.md              # frontmatter + the triage procedure
├── checklist.md           # ordered triage checklist referenced from SKILL.md
└── scripts/
    └── parse-failures.ps1 # extracts failing test names + error messages from a dotnet test log
```

The helper script was smoke-tested in this session against a synthetic `dotnet test` log and correctly
extracted both failing test names and their error messages — see the file's own doc comment for the
verified/unverified boundary (synthetic log tested; a real project's exact console format was not).

## 🚀 Step 3 — Build the shorter example: `documentation-validator`

Already created at `examples\skills\documentation-validator\`, intentionally lighter: `SKILL.md` plus one
helper script, no separate checklist file — demonstrating that **not every skill needs every optional
file**. Its helper script, `scripts\list-anchors.ps1`, was run in this session against this guide's sibling
file `mcp_practical_guide.md` and correctly reproduced GitHub's leading-hyphen anchor behavior for
emoji-prefixed headings (e.g. `## 🚀 Setup` → `#-setup`), confirming the rule this repo's own prior link
audit discovered.

## 🚀 Step 4 — Invocation: how a skill actually gets triggered

Verified, product-by-product:

- **Claude Code:** Claude loads a skill automatically when the conversation matches its `description`, or you invoke it directly by typing `/skill-name` (the directory name, or an explicit `name` override, becomes the command). Claude Code additionally supports `disable-model-invocation: true` in frontmatter to force **explicit-only** invocation — a Claude Code extension to the base standard, not part of the open spec.
- **GitHub Copilot CLI (this session):** skills are discovered from `.github/skills/`, `.claude/skills/`, `~/.copilot/skills/`, and `~/.agents/skills/`; the harness instructs: *"Before acting on a task, check current or previously listed available skills. If a skill matches, invoking it is mandatory... before any response."* — i.e. automatic, description-matched discovery, the same spirit as Claude Code's automatic path, surfaced as a dedicated `skill` tool call rather than a slash command.
- **Cross-tool honesty:** the open spec itself only defines `name`/`description`/`license`/`compatibility`/`metadata`/`allowed-tools` — invocation mechanics (`/skill-name`, automatic matching, `disable-model-invocation`) are **product extensions**, not guaranteed identical across every implementer on [agentskills.io](https://agentskills.io)'s list (Gemini CLI, OpenCode, Junie, etc.). Verify per-product before assuming a Claude Code-specific frontmatter field (like `disable-model-invocation`) works elsewhere.

## 💻 Complete Example

The minimal valid `SKILL.md` per the spec — useful as a starting skeleton before you add any optional field:

```markdown
---
name: skill-name
description: A description of what this skill does and when to use it.
---

Instructions for the agent go here, in plain Markdown.
```

Compare against the real, fuller example already on disk: [`examples/skills/dotnet-test-debugger/SKILL.md`](examples/skills/dotnet-test-debugger/SKILL.md).

## ▶️ Run It

```powershell
# From this repo root — exercise the verified helper scripts directly
powershell -File .\examples\skills\dotnet-test-debugger\scripts\parse-failures.ps1 -LogPath .\your-test-log.txt
powershell -File .\examples\skills\documentation-validator\scripts\list-anchors.ps1 -FilePath .\README.md
```

To actually have an agent *invoke* the skill rather than just run its script, copy the folder into one of the
discovery locations for your tool (e.g. `.claude/skills/dotnet-test-debugger/` for Claude Code, or
`.github/skills/dotnet-test-debugger/` for a project-level Copilot CLI skill) and then ask a matching
question in a new session.

## 👀 Expected Result

- Both PowerShell scripts run standalone and print structured, readable output (verified above).
- Once copied into a discovery location, asking "why are my tests failing?" (Claude Code) or pasting a
  failing `dotnet test` log (Copilot CLI) should trigger the skill automatically, without typing its name.

## 🐛 Troubleshooting

- **Skill never auto-triggers:** the `description` field is the *only* signal most tools use for automatic
  matching — if it's vague ("Helps with tests"), broaden it with concrete keywords, per the spec's own
  guidance contrasting a "poor" vs. "good" description example.
- **`name` mismatch error:** the directory name and frontmatter `name` must match exactly — this is a hard
  spec requirement, not a style suggestion.
- **Script runs but prints nothing:** confirm your log file's actual format matches the regex in
  `parse-failures.ps1`; different test adapters format `Failed`/`[FAIL]` lines slightly differently, which
  is exactly why the script is labeled `⚠️ Needs runtime verification` against *your* project's real output.

## 🏋️ Exercise

1. 🟢 Copy `documentation-validator/` into `.claude/skills/` or `.github/skills/` in a scratch repo and confirm it's discovered (e.g. via `/env` in Copilot CLI, or `/context` in Claude Code).
2. 🟡 Extend `dotnet-test-debugger`'s `checklist.md` with one more triage item specific to a bug class your own team hits repeatedly — keep it to one new line, consistent with the existing format.
3. 🔴 Write a brand-new skill from scratch for a procedure you personally repeat often (e.g. "write a changelog entry", "review a SQL migration for backward compatibility"), following the minimal valid frontmatter from Step-4's complete example, then test real auto-invocation in a live session.

## ✅ Checkpoint

You can state the one spec-mandated constraint linking a skill's folder name to its frontmatter, name the
one field explicitly marked experimental by the spec itself, and explain why invocation mechanics
(`/skill-name`, automatic matching) are product extensions rather than part of the portable standard.

## 🔒 Security Note

- Skills are portable files you might copy from someone else's repo or a public gallery — treat an
  unfamiliar skill folder the same as unfamiliar shell script: read `SKILL.md` and every file in
  `scripts/`/`references/`/`assets/` before trusting it.
- **Do not pre-approve `shell`/`bash` tools in a skill's `allowed-tools` unless you trust its source** — this
  is the same guidance already established for this repository's own custom instructions, repeated here for
  consistency: the `allowed-tools` field is explicitly experimental and, where supported, grants real
  execution capability.
- Both example skills in this repo deliberately omit shell/bash from `allowed-tools` (the `.NET` one lists
  only `Read Grep`), so copying them is safe by default — any execution step is left for you to run and
  review manually, not auto-approved.

## 🔗 Related Topics

- [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) — instructions vs. skills vs. agents, and where each lives per scope.
- [mcp_practical_guide.md](mcp_practical_guide.md) — the complementary capability-extension mechanism.
- [deep-research-report.md](deep-research-report.md) — broader coding-agent configuration handbook.
- `claude_code_practical_guide.md`, `github_copilot_practical_guide.md`, `codex_practical_guide.md` — companion per-tool guides (expected filenames; authored alongside this one).

## ➡️ Next

Return to [mcp_practical_guide.md](mcp_practical_guide.md) or [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) if you haven't yet, or try building a third skill of your own under `examples\skills\` using the two shipped here as templates.
