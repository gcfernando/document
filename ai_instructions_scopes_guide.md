# 🚀 AI Instruction Scopes: Global, Project, Path, and Agent

> Write one instruction file per scope, trigger a real conflict between two of them, and see — per each tool's own documentation — what actually happens.

**🏷️ Difficulty:** 🟡 Intermediate

> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - GitHub Copilot repository instructions: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions
> - GitHub Copilot instructions in your IDE (path-specific `applyTo`): https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/customize-copilot/configure-custom-instructions/add-repository-instructions-in-your-ide
> - Claude Code memory (`CLAUDE.md`, `AGENTS.md`, rules): https://code.claude.com/docs/en/memory
> - Codex local configuration: https://learn.chatgpt.com/docs/config-file/config-basic
> - `AGENTS.md` open format: https://agents.md/
>
> This space moves fast (new file types and precedence behaviors have shipped within the last year). Re-check these links before teaching from this file a year from now.

## 🎯 What You Will Build

Four tiny real instruction files — one per scope — plus one deliberately conflicting pair, so you can observe (not guess) how your AI tool of choice resolves it.

## 🧠 What Is This?

An **instruction file** is passive context loaded at session start that shapes how an AI agent behaves (coding standards, build commands, tone) — it cannot force or block an action. A **skill** (see [agent_skills_practical_guide.md](agent_skills_practical_guide.md)) is instructions **plus** supporting files/scripts that load only when relevant, for a specific repeatable procedure. A **custom agent** is a whole separate persona/configuration (system prompt, tools, model) you explicitly invoke. Instructions are "always on background knowledge"; skills are "on-demand procedures"; agents are "a different assistant entirely." All three can be overridden or ignored by the model — Claude Code's own docs put it plainly: *"Claude treats them as context, not enforced configuration. To block an action regardless of what Claude decides, use a PreToolUse hook instead."* The same honesty applies to every tool below — these are strong suggestions, not sandboxes.

## 📚 Prerequisites

- [mcp_practical_guide.md](mcp_practical_guide.md) — understand that instructions and MCP servers are two different extensibility axes (behavior vs. capability).
- A repository you can experiment in (this one works).

## 🏷️ Difficulty: 🟡 Intermediate

## 🚀 Step 1 — Global / personal instructions

These apply to **every** project you open with that tool, written by **you**, for **your own** preferences — not team standards (those belong at project scope).

| Tool | File | Verified from |
|---|---|---|
| GitHub Copilot CLI | `$HOME/.copilot/copilot-instructions.md` (also `$HOME/.copilot/instructions/**/*.instructions.md`) | This CLI session's own `/help` output: *"Copilot respects instructions from these locations... $HOME/.copilot/copilot-instructions.md"* |
| Claude Code | `~/.claude/CLAUDE.md` | https://code.claude.com/docs/en/memory — "Personal preferences for all projects" |
| Codex | `~/.codex/config.toml` (configuration, not freeform instructions — Codex has no documented personal `AGENTS.md`-equivalent prose file at time of writing) | https://learn.chatgpt.com/docs/config-file/config-basic |

**Example — personal GitHub Copilot CLI instructions** (`$HOME/.copilot/copilot-instructions.md`):

```markdown
# Personal preferences
- Default to PowerShell syntax on Windows, never DOS commands.
- Keep explanations under 100 words for routine questions.
- Always state assumptions explicitly before proceeding.
```

**What belongs here:** your personal tone/response-style preferences, editor/shell defaults, cross-project habits.
**What does NOT belong here:** anything project-specific (build commands, framework choices) — that belongs one scope down, so teammates without your personal file still get it.

## 🚀 Step 2 — Project / repository instructions

Shared with your team via source control. This is where "how to build/test/validate this specific repo" lives.

| Tool | File |
|---|---|
| GitHub Copilot (CLI, IDE, github.com) | `.github/copilot-instructions.md` |
| Claude Code | `./CLAUDE.md` or `./.claude/CLAUDE.md` |
| Codex | `AGENTS.md` at repo root (Codex and most agent CLIs read `AGENTS.md` as the project-level instructions file) |
| GitHub Copilot (also) | `AGENTS.md`, or a single `CLAUDE.md`/`GEMINI.md` at repo root — all three are explicitly supported as "agent instructions" per GitHub's docs |

**Real example — project instructions for this repository** (`.github/copilot-instructions.md`):

```markdown
# D:\KnowledgeBase project instructions
This is a Markdown-only learning-platform repository (no build/test pipeline).
- Follow the existing skeleton used across guides (🎯/🧠/📚/🛠️/🚀 Step N/💻/▶️/👀/🐛/🏋️/✅/🔗/➡️ headings).
- Keep code examples in both Python and C# when the topic is AI/LLM-related.
- Never duplicate content that already exists in another file — link to it instead.
```

This mirrors how Copilot CLI's own `/help` output describes repository instruction discovery: `.github/copilot-instructions.md` (in git root & cwd), alongside `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md`, all loaded the same way.

## 🚀 Step 3 — Path-specific instructions (`applyTo` globs)

Use these when `/src` and `/tests` (or any two directories) genuinely need **different** rules, instead of bloating one repo-wide file with conditionals.

Per GitHub's current docs, create `.github/instructions/NAME.instructions.md` files with an `applyTo` frontmatter glob:

**`.github/instructions/src.instructions.md`:**
```markdown
---
applyTo: "src/**/*.ts,src/**/*.tsx"
---
Production code under /src must:
- Have no `console.log` left in committed code — use the project logger.
- Include XML-doc/JSDoc comments on every exported function.
```

**`.github/instructions/tests.instructions.md`:**
```markdown
---
applyTo: "tests/**/*.ts,tests/**/*.tsx"
---
Test code under /tests may:
- Use `console.log` freely for debugging — it will not ship.
- Skip documentation comments; test names should be self-explanatory instead.
```

**Documented merge behavior (not a guess):** "If the path you specify matches a file that Copilot is working on, and a repository-wide custom instructions file also exists, then the instructions from **both** files are used." So editing `src/app.ts` loads `.github/copilot-instructions.md` **and** `src.instructions.md` together — it is additive, not a replace.

Claude Code has a related but distinctly-named mechanism: `.claude/rules/**/*.md`, for scoping instructions to specific file types or subdirectories (confirmed in this CLI session's own instruction-discovery list, which separately tracks `.claude/rules/**/*.md` from `CLAUDE.md`). Verify Claude's own current rules-file frontmatter format before relying on exact syntax, as it was not fully fetched in this research pass.

## 🚀 Step 4 — Agent-specific instructions

A **custom agent** (not a plain instruction file) carries its own system prompt/persona, distinct from the three scopes above. For this repo's purposes:
- GitHub Copilot CLI custom agents are `.agent.md` files under `.github/agents/` (project) or `~/.copilot/agents/` (personal), invoked with `/agent`.
- Claude Code's equivalent is a **subagent** — a specialized assistant with its own system prompt, tool access, and (optionally) its own model — defined per https://code.claude.com/docs/en/sub-agents. Claude delegates to a subagent automatically based on its `description`, or you invoke a built-in one (e.g. `Explore`, `Plan`) by name.
- A **skill**, by contrast, is not a separate persona — it is instructions-on-demand *inside* whichever agent is already running. See [agent_skills_practical_guide.md](agent_skills_practical_guide.md) for the full build-your-own walkthrough, and this repo's forthcoming tool-specific guides — `codex_practical_guide.md`, `claude_code_practical_guide.md`, and `github_copilot_practical_guide.md` — for per-product agent configuration depth (referenced here by their expected filenames; they are companion guides being authored alongside this one and may not exist yet in your checkout).

## 🚀 Step 5 — A real precedence/conflict example

Create two genuinely conflicting instructions and see what happens.

**Personal (`~/.claude/CLAUDE.md`):**
```markdown
Always respond in formal, verbose prose with full justification for every decision.
```

**Project (`./CLAUDE.md`):**
```markdown
Keep all responses under 50 words. No preamble, no justification — just the result.
```

**Documented behavior for Claude Code (verified, not guessed):** Claude Code's memory docs list load scope "from broadest to most specific, so a project instruction appears in context after a user instruction" — meaning the project file is loaded *later* in context than the personal one. Claude Code does **not** document a hard override rule beyond that ordering; it explicitly treats both as advisory context the model weighs, not a config merge with a winner. The docs' own troubleshooting guidance for contradictions is to **remove the conflict yourself** ("if two instructions contradict each other, Claude may pick one arbitrarily. Review your CLAUDE.md files... periodically to remove outdated or conflicting instructions").

⚠️ **Honest gap:** GitHub Copilot's docs do not state a general precedence order between personal (`$HOME/.copilot/copilot-instructions.md`) and repository (`.github/copilot-instructions.md`) instructions for the CLI — this very session's own `/help` output lists both as sources it "respects" without ranking them, and explicitly warns: *"it does not define a general precedence order among these [instruction] file types. Avoid contradictory instructions."* Do not assume one universally wins — treat this as genuinely undocumented rather than inventing a rule.

## 💻 Complete Example

A minimal, internally-consistent instruction set for a two-scope setup in this very repo:

```
D:\KnowledgeBase\
├── .github\
│   ├── copilot-instructions.md        ← project-wide: "Markdown-only repo, follow skeleton"
│   └── instructions\
│       └── examples.instructions.md   ← applyTo: "examples/**"  → "code here may be minimal/untested, label it"
```

`.github/instructions/examples.instructions.md`:
```markdown
---
applyTo: "examples/**"
---
Files under /examples are teaching templates, not production code.
Keep them short; prefer clarity over completeness.
```

## ▶️ Run It

```text
/instructions
```
Run this inside a Copilot CLI session to view and toggle which custom instruction files are currently active — the fastest way to confirm a scope is actually loading before you debug "why isn't my instruction working."

## 👀 Expected Result

`/instructions` lists every discovered file (personal, project, path-specific, agent) with its resolved path, letting you confirm e.g. that `examples.instructions.md` only applies when the agent is working inside `examples/`.

## 🐛 Troubleshooting

- **Instruction seems ignored:** first confirm it loaded at all (`/instructions` for Copilot CLI, `/context` → "Memory files" for Claude Code) before assuming the model is disobeying it — a typo'd path is the most common cause.
- **Two instructions fight each other:** per the docs above, this is explicitly **not** auto-resolved in most tools — rewrite one of them instead of hoping precedence saves you.
- **Path-specific rule never triggers:** double-check the glob syntax matches the tool's documented rules (GitHub's `applyTo` uses plain glob, not regex; `**` matches across directories, `*` does not).

## 🏋️ Exercise

1. 🟢 Add a personal instruction and a project instruction to a scratch repo; confirm both show up via each tool's own introspection command.
2. 🟡 Write two `applyTo` files with overlapping globs (e.g. `**/*.ts` and `src/**/*.ts`) and verify both apply to a file in `src/` — the merge is additive, not "most specific wins," per GitHub's documented behavior.
3. 🔴 Reproduce the Step 5 conflict in a real Claude Code or Copilot CLI session and paste the actual (not predicted) response here — note which instruction "won," if either did consistently across three repeated attempts.

## ✅ Checkpoint

You can name, for at least two tools, the exact file path for each of the four scopes, state the one documented merge rule (path-specific + repo-wide = additive, per GitHub), and explain *why* this repo refuses to invent a universal precedence rule where the vendor hasn't published one.

## 📊 Comparison Table

> **Last verified:** 2026-10-06 — re-check before reuse; all three products ship frequently.

| Tool | Global/personal file | Project file | Path-specific support | Notes |
|---|---|---|---|---|
| GitHub Copilot CLI | `$HOME/.copilot/copilot-instructions.md` | `.github/copilot-instructions.md` (also reads `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`) | Yes — `.github/instructions/*.instructions.md` with `applyTo` | No documented precedence order between file types; combines them. |
| GitHub Copilot (github.com/IDE) | Personal instructions set via GitHub.com UI (not a file) | `.github/copilot-instructions.md` | Yes — same `applyTo` mechanism | Path-specific + repo-wide instructions are both used together when a matched file is in scope. |
| Claude Code | `~/.claude/CLAUDE.md` | `./CLAUDE.md` or `./.claude/CLAUDE.md`; also reads project `AGENTS.md` | Yes — `.claude/rules/**/*.md` (scoped by file type/subdirectory) | Loaded broadest→most specific; treated as context, not enforced config; use a `PreToolUse` hook to truly block an action. |
| Codex (CLI/IDE) | `~/.codex/config.toml` (configuration, not freeform personal instructions) | `.codex/config.toml` per-project, plus repo `AGENTS.md` conventionally read by Codex and other agent CLIs | Partial — `.codex/config.toml` can be placed at nested subfolders, closest wins | Config precedence (CLI flags > project `.codex/` > profile > user > cloud-managed > system > defaults) is explicitly documented for `config.toml`, not for freeform prose instructions. |

## 🔗 Related Topics

- [mcp_practical_guide.md](mcp_practical_guide.md) — capability extensibility, not behavior.
- [agent_skills_practical_guide.md](agent_skills_practical_guide.md) — on-demand procedures vs. always-loaded instructions.
- [deep-research-report.md](deep-research-report.md) — this repo's existing cross-tool agent-configuration handbook.
- `codex_practical_guide.md`, `claude_code_practical_guide.md`, `github_copilot_practical_guide.md` — companion per-tool deep dives (expected filenames; authored alongside this guide).

## ➡️ Next

Continue to [agent_skills_practical_guide.md](agent_skills_practical_guide.md) to turn a repeated instruction into an on-demand, reusable skill.
