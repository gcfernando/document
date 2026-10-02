# 🌈 The Universal AI CLI Operating Handbook

> **VS Code update (2026-10-02):** Part VI now includes exact file paths, Explorer setup steps, copyable templates, extension-specific behavior, troubleshooting, and official sources. Codex skills and Claude AGENTS loading claims were corrected. Historical CLI examples outside this scope retain their original validation status.


> **Claude Code · OpenAI Codex · GitHub Copilot CLI**
> Global instructions · Project instructions · Task briefs · Skills · Agents · MCP · Daily workflows · Parallel agents · Troubleshooting
>
> **Release:** 8.1 · **Validated:** 2026-10-02 · **Audience:** complete beginners → professional engineers

---

## 🟢 How to read this handbook

This file is the **primary human-facing handbook**. The four sibling files (`ENGINEERING.md`, `CLAUDE.md`, `AGENTS.md`, `copilot-instructions.md`) are **machine-loaded instruction files** kept short on purpose. Everything long — tutorials, decision trees, labs, troubleshooting, templates — lives here.

**Legend used throughout:**

| Symbol | Meaning |
|---|---|
| 🟣 | Claude Code specific |
| 🔵 | OpenAI Codex specific |
| 🟢 | GitHub Copilot CLI specific |
| 🟠 | Shared / universal concept |
| 🌍 | Global instructions | 📁 | Project instructions | 📝 | Task brief / user story |
| 🧠 | Skills | 🤖 | Agents / subagents | ⚡ | Parallel agents |
| 🔌 | MCP | 🛡️ | Security / authorization | 🧪 | Testing / verification |
| 🧭 | Decision guide | ▶️ | Commands / daily use | 🛠️ | Troubleshooting |
| ⚠️ | Warning | 💡 | Tip | ✅ | Executed/verified | 📚 | Official-doc verified only |

**Validation legend for every command shown:**

- **✅ Executed** — actually run in this session's environment.
- **📚 Official-doc verified** — confirmed against current vendor documentation fetched during this validation pass; the vendor binary was not installed locally, so it was not executed.
- **🖥️ Platform syntax reviewed** — standard shell/PowerShell form, not independently executed here.

> [!IMPORTANT]
> This environment does not have the `claude`, `codex`, or `copilot` binaries installed as separate executables (you are reading this inside a Copilot CLI session itself). Every product-CLI command below is therefore labeled **📚 Official-doc verified**, not ✅ Executed, unless it is a plain filesystem/PowerShell operation that genuinely ran.

---

## 📑 Table of Contents

```text
Part 0  — Mental model, terminology, product comparison
Part I  — Setup & architecture (ENGINEERING.md → CLAUDE.md/AGENTS.md/copilot-instructions.md)
Part II — "I set it up — now what?" + daily command cheat sheets
Part III— The decision engine (instruction vs skill vs agent vs task brief vs doc)
Part IV — Task briefs & the user-story workflow (all three tools, worked example)
Part V  — Skills, custom agents/subagents, and MCP (per product)
Part VI — VS Code file creation, skills, named agents, tools, and verification
Part VII— Project-type playbooks (maintenance, bugs, new project, DevOps, security,
           data, design, music, docs/research) — each with a parallel-agent subsection
Part VIII — Parallel agents deep dive (framework, patterns, labs, contracts, hazards)
Part IX — Writing & maintaining instructions (hygiene, context cost, precedence, security)
Part X  — Troubleshooting matrix, FAQ, quick-decision tables
Part XI — Copy/paste templates
Part XII— Expert quick-reference appendix
Part XIII — Official sources & validation notes
Part XIV — Installation from absolute zero (all three tools, Windows-first)
Part XV — Zero-knowledge acceptance tests (answered directly)
```

---

# Part 0 — Mental Model, Terminology, Comparison

## 🚀 0.0 Absolute-beginner glossary — read this first if any of this is new

> [!NOTE]
> Skip this section if you already know what a terminal, Git, and an AI agent are. If any single term below is unfamiliar, **read it before continuing** — nothing later assumes you already know it.

| Term | Plain-English meaning |
|---|---|
| **AI model** | The underlying "brain" (e.g., Claude, GPT) that reads text and produces answers. You don't install it — you install a *program* that talks to it. |
| **AI agent** | An AI model wired up to also read/write files, run commands, and take multi-step action — not just chat. Claude Code, Codex, and Copilot CLI are all AI agents. |
| **CLI (command-line interface)** | A program you control entirely by typing text commands, instead of clicking buttons. |
| **Terminal** | The black/dark window where you type text commands and see text output. On Windows: PowerShell or Command Prompt. On macOS: Terminal.app. On Linux: your distro's terminal app. |
| **Shell** | The program *inside* the terminal that actually reads and runs your commands (PowerShell, bash, zsh). "Terminal" and "shell" are often used loosely to mean the same thing. |
| **Command** | A single line of text you type and press Enter to run, e.g. `claude --version`. |
| **Working directory** | The folder your shell is "standing in" right now. Commands like "create a file here" mean *here, in the working directory*. Change it with `cd <folder>`. |
| **Project / repository ("repo")** | A folder containing one piece of software (or one body of work) — code, docs, assets. A repository is a project folder that is also tracked by Git. |
| **Git** | A version-control program that records the history of changes to files in a project. Not required for every project, but extremely common. |
| **Markdown (`.md`)** | A plain-text format for writing documents with simple symbols for headings/lists/bold (like this handbook). All five files in this project are Markdown. |
| **Global instruction** | A Markdown file in *your user profile* (not inside any one project) that an AI tool reads every time, for every project, automatically. |
| **Project instruction** | A Markdown file *inside one project folder* that an AI tool reads automatically only while you work in that project. |
| **Local / private instruction** | Like a project instruction, but meant only for you (not committed/shared with teammates). |
| **Path-specific instruction** | An instruction that only applies to files under one subfolder (e.g., only `src/api/**`). |
| **Context / context window** | Everything the AI can "see" at once in a conversation: your instructions, the chat so far, and any files it has read. It is limited in size. |
| **Prompt** | The message you type to the AI. |
| **Task brief** | An ordinary text/Markdown document describing one specific task (like a user story) — the AI does **not** read it automatically; you must tell it to. |
| **Skill** | A saved, reusable set of instructions for a repeatable procedure, which the AI can load only when relevant — supported by some, not all, of these tools. |
| **Custom agent / subagent** | A specialized "mode" of the AI with its own narrower instructions and tools, used for one kind of job (e.g., "security reviewer"). |
| **Parallel agent** | Running more than one AI session/worker at the same time on different parts of a task. |
| **MCP (Model Context Protocol)** | A standard way to plug external tools/services (e.g., a database, a search engine) into an AI agent so it can use them. |
| **MCP server** | One such external tool/service, made available over MCP. |
| **Tool (in an agent)** | One capability the AI can invoke, e.g. "read a file," "run a shell command," "search the web." |
| **Resource (in MCP)** | A piece of external data an MCP server can hand to the AI (e.g., a document, a database row). |
| **Hook** | A small script that automatically runs at a specific moment (e.g., right before the AI uses a tool). |
| **Permission** | A rule about what the AI is allowed to do without asking you first. |
| **Sandbox** | A restricted environment where the AI's actions (file/network access) are technically limited, regardless of what any instruction file says. |
| **Approval (mode)** | A setting controlling whether the AI must ask you before taking an action. |
| **Environment variable** | A named value set in your shell/operating system (e.g., `CODEX_HOME`) that programs can read to change their behavior. |
| **Configuration directory / "home"** | The folder where a program keeps its settings — usually hidden, usually under your user profile. |
| **Session** | One continuous conversation with the AI agent, from when you start it to when you close it. |
| **Git branch** | A named, independent line of changes within a Git repository, so multiple changes can exist without colliding. |
| **Git worktree** | A second, separate folder checked out from the *same* Git repository on a different branch, so two branches can be worked on at once without interfering. |
| **`~` (tilde)** | Shorthand for *your user profile/home folder*. On Windows that's `C:\Users\<YourName>`; on macOS/Linux it's `/Users/<you>` or `/home/<you>`. Your shell expands `~` automatically. |
| **Hidden file/folder (dotfile)** | A file or folder whose name starts with `.` (e.g., `.claude`), hidden from normal folder views by default on most systems. You can still create/open it directly by typing its full name. |

## 🧠 0.1 The five-minute mental model

```text
GLOBAL DEFAULTS            → stable personal principles, used across every project
PROJECT INSTRUCTIONS       → stable rules for one project, shared with the team
LOCAL / PRIVATE INSTR.     → stable personal preferences for one project, not shared
PATH-SPECIFIC INSTR.       → stable rules that apply only to part of a project
TASK BRIEF / USER STORY    → temporary context for the current task only
SKILL                      → a reusable, repeatable procedure
CUSTOM AGENT / SUBAGENT    → a specialized delegated worker
MCP                        → external tools/data/services exposed to the agent
ORDINARY PROJECT DOCS      → architecture, ADRs, API docs, runbooks, user stories
PERMISSIONS / SANDBOX      → actual technical enforcement, not Markdown
```

> [!TIP]
> If you remember only one rule from this whole handbook: **Markdown instructions are behavioral guidance. Permissions, sandboxes, CI, IAM, and branch protection are enforcement.** Never substitute one for the other.

## 📖 0.2 Terminology, explained once

| Term | What it is | Why it matters |
|---|---|---|
| **CLI** | Command-line interface — a program you operate by typing text commands in a terminal | Claude Code, Codex, and Copilot CLI are all CLIs |
| **Terminal / shell** | The program that accepts your typed commands (PowerShell, bash, zsh) | Where you launch the agent |
| **Working directory** | The folder your terminal is "in" right now | Determines what the agent can see first and which project instructions are discovered |
| **Repository / project root** | The top folder of a project, often containing `.git` | Where project-level instruction files usually live |
| **Context / context window** | Everything the model can "see" in one turn: instructions, conversation, file contents | A finite resource — bloated instructions crowd out real work |
| **Instruction file** | A Markdown file the tool loads automatically to shape behavior | `CLAUDE.md`, `AGENTS.md`, `copilot-instructions.md`, `.github/copilot-instructions.md`, etc. |
| **Global instruction** | An instruction file in your user/home directory, applied to every project | `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.copilot/copilot-instructions.md` |
| **Project instruction** | An instruction file checked into (or local to) one repository | Repo-root `CLAUDE.md`/`AGENTS.md`, `.github/copilot-instructions.md` |
| **Task brief** | An ordinary Markdown document describing one task/story — not auto-loaded | `docs/tasks/ABC-123.md` |
| **Skill** | A packaged, reusable procedure the agent can invoke or be given | `SKILL.md` files |
| **Agent / subagent** | A specialized worker with its own context, tools, and permissions | Built-in or custom-defined |
| **MCP (Model Context Protocol)** | An open protocol for exposing external tools/resources to an agent | `codex mcp add`, GitHub MCP server, etc. |
| **Hook** | A script triggered at a defined lifecycle point (e.g., before a commit) | Automates enforcement/validation |
| **Sandbox** | A technical restriction on filesystem/network/process access | Real enforcement, not a suggestion |
| **Approval / permission mode** | A configured policy for which actions require human confirmation | Controls blast radius |
| **Session** | One running conversation with the agent, from launch to exit | Instruction reloading is usually session-scoped |

## 🆚 0.3 Product comparison card

| Capability | 🟣 Claude Code | 🔵 Codex | 🟢 Copilot CLI |
|---|---|---|---|
| Global instruction file | `~/.claude/CLAUDE.md` | `~/.codex/AGENTS.md` | `~/.copilot/copilot-instructions.md` |
| Project instruction file | `CLAUDE.md`; `AGENTS.md` support depends on version/settings or explicit import | `AGENTS.md` (root → cwd walk) | `.github/copilot-instructions.md`, `AGENTS.md`, `CLAUDE.md` |
| Local/private instructions | `CLAUDE.local.md` | Not documented as a distinct mechanism | Personal dirs via `COPILOT_HOME`/`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` |
| Self-written persistent memory | ✅ **Auto memory** — Claude's own notes, per-repo, every session, 200-line/25KB cap | Not documented | Not documented |
| Path-specific instructions | `.claude/rules/**/*.md` | One file per directory on the root→cwd walk | `.github/instructions/**/*.instructions.md` with `applyTo` |
| Inspect loaded instructions | `/context`, `/memory`, `/doctor prompt-audit` | Ask the agent; no dedicated inspector command documented | `/instructions`, `copilot instruction list` |
| Reload behavior | New/continued session picks up edits; imports re-resolved per session | New run/session required | New/resumed session required |
| Skills | `SKILL.md` under `.claude/skills/**`, Agent Skills open standard | Native skills: `.agents/skills/<name>/SKILL.md` | `skill` tool / `.copilot` skills surfaced to session + `general-purpose` subagent |
| Custom agents / subagents | Built-in (Explore, Plan, General-purpose) + user/project-defined subagents | ✅ Native subagent workflows (`[agents]` in `config.toml`, triggered by request or via `AGENTS.md`/skill instructions, inspect with `/agent`) | Built-in (`explore`, `task`, `general-purpose`, `code-review`, `security-review`, `research`, `rubber-duck`) + custom subagents |
| Background / parallel sessions | `claude agents` (agent view), agent teams (experimental), Projects (cloud) | Native subagent threads (`/agent`); also multiple independent CLI invocations; cloud tasks in ChatGPT/Codex cloud | `task` tool background mode, `write_agent`/`read_agent` multi-turn agents |
| MCP support | ✅ documented | ✅ documented (`codex mcp add`, `config.toml`) | ✅ documented (MCP servers configured per session/project) |
| Worktree integration | Native awareness (`/docs/en/worktrees`), agent view auto-isolates | Manual Git workflow | Manual Git workflow |
| Context/size limits | ~200 lines recommended per `CLAUDE.md`; subagent descriptions capped at 15,000 tokens combined | `project_doc_max_bytes` defaults to 32 KiB | Not documented as a hard byte limit; practical context budget still applies |

---

# Part I — Setup & Architecture

## 🧩 I.1 The architecture in one picture

```text
                         CANONICAL SOURCE
                     ~/.ai/ENGINEERING.md
                              │
          ┌───────────────────┼───────────────────┐
          │                   │                   │
          ▼                   ▼                   ▼
       🟣 CLAUDE            🔵 CODEX            🟢 COPILOT
   ~/.claude/CLAUDE.md   ~/.codex/AGENTS.md   ~/.copilot/
                                              copilot-instructions.md
```

| File | Job |
|---|---|
| `ENGINEERING.md` | Universal, vendor-neutral engineering behavior |
| `CLAUDE.md` | Claude Code adapter — imports the universal file |
| `AGENTS.md` | Codex's **effective** global file = `ENGINEERING.md` content + Codex-specific footer |
| `copilot-instructions.md` | Copilot adapter — imports a locally deployed copy of the universal file |

> [!NOTE]
> Claude, Codex, and Copilot do **not** share one `@import` syntax. Each tool's delivery mechanism below is chosen to match its own documented behavior — do not assume symmetry.

## 🧭 I.2 Which `@` form is correct, per tool

**🟣 Claude Code** — officially supports relative and absolute imports, including a home-directory import:

```markdown
@~/.ai/ENGINEERING.md
```

```text
~/.claude/CLAUDE.md ──@~/.ai/ENGINEERING.md──▶ ~/.ai/ENGINEERING.md
```

> [!WARNING]
> Claude Code desktop **Cowork** sessions apply stricter rules to external/home-directory imports. If Cowork compatibility matters, deploy an in-scope copy instead of relying on the external import.

> [!NOTE]
> 🟣 Claude Code also has a **second, separate** memory mechanism: **auto memory** — notes Claude writes itself from your corrections/preferences, stored per-repository and shared across worktrees, loaded every session (capped at the first 200 lines / 25 KB). `CLAUDE.md` is *you* writing instructions; auto memory is *Claude* writing its own learnings. Both are context, not enforcement — use a `PreToolUse` hook if an action must be technically blocked regardless of what Claude decides. 📚

**🟢 Copilot CLI** — GitHub's custom-instructions documentation requires local `@path` references to stay **inside** the custom-instructions directory; absolute or `~/`-rooted paths are not loaded. Use:

```markdown
@ENGINEERING.md
```

```text
~/.copilot/
├── copilot-instructions.md   (contains: @ENGINEERING.md)
└── ENGINEERING.md            (synced copy of the canonical file)
```

**🔵 Codex** — does **not** document a Claude-style `@file` import for its global instruction mechanism. Its documented mechanism is `AGENTS.md` discovery. The architecture therefore **generates** the effective file:

```text
ENGINEERING.md + Codex-specific footer  →  ~/.codex/AGENTS.md
```

## 🏆 I.3 Recommended setup — one choice per tool

| Tool | Method | Why |
|---|---|---|
| 🟣 Claude Code | `@~/.ai/ENGINEERING.md` inside `~/.claude/CLAUDE.md` | Directly documented user-scope import |
| 🔵 Codex | Generate `~/.codex/AGENTS.md` = canonical file + Codex footer | Matches documented Codex discovery; no import mechanism to rely on |
| 🟢 Copilot CLI | Sync canonical file to `~/.copilot/ENGINEERING.md`, import with `@ENGINEERING.md` | Matches the only documented safe local-reference pattern |

> [!TIP]
> Hard links (`ln`) can replace copy/sync on Unix-like systems if you understand filesystem semantics (same inode, same filesystem, some editors break the link on save). This is a **filesystem feature**, not a vendor feature — treat it as an advanced option, not the default.

## 📁 I.4 Final folder layout

**Windows**

```text
C:\Users\<YOU>\
├── .ai\ENGINEERING.md
├── .claude\CLAUDE.md
├── .codex\AGENTS.md
└── .copilot\
    ├── ENGINEERING.md
    └── copilot-instructions.md
```

**macOS / Linux**

```text
~/.ai/ENGINEERING.md
~/.claude/CLAUDE.md
~/.codex/AGENTS.md
~/.copilot/ENGINEERING.md
~/.copilot/copilot-instructions.md
```

## 🧱 I.5 Install step-by-step

> [!NOTE]
> "Place the file there" is not a real instruction — below is the exact command that both **creates the folder** and **writes real file content** (not just an empty file), plus how to open it in a text editor instead if you prefer typing/pasting by hand. Every step also shows how to confirm the content is actually what you expect, not just that the file exists.

### Step 1 — canonical file

```bash
mkdir -p ~/.ai                 # macOS/Linux — 🖥️ platform syntax reviewed
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.ai" | Out-Null   # 🪟 Windows — creates the hidden folder; -Force means "don't error if it already exists"
```
Now create the file **with content** — pick whichever is easiest:

- **Option A — open it in a text editor and paste/save** (easiest for a first attempt):
  ```powershell
  notepad "$HOME\.ai\ENGINEERING.md"       # 🪟 Windows Notepad opens (and offers to create) the file
  ```
  ```powershell
  code "$HOME\.ai\ENGINEERING.md"          # 🖥️ if VS Code's `code` command is installed/on PATH
  ```
  Paste the full released `ENGINEERING.md` content, then **save** (Ctrl+S) and close.
- **Option B — copy an existing file you already have** (e.g., downloaded alongside this handbook):
  ```powershell
  Copy-Item "C:\path\to\downloaded\ENGINEERING.md" "$HOME\.ai\ENGINEERING.md"
  ```

Verify the **file exists**:
```bash
test -f ~/.ai/ENGINEERING.md && echo "found"
```
```powershell
Test-Path "$HOME\.ai\ENGINEERING.md"              # returns True/False
```
Verify the **content is correct** (prints the first lines back to you — confirm it isn't empty and starts with the expected heading):
```powershell
Get-Content "$HOME\.ai\ENGINEERING.md" -TotalCount 5
```

### Step 2 — 🟣 Claude Code

```bash
mkdir -p ~/.claude
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude" | Out-Null   # 🪟 Windows
```
Create `CLAUDE.md` inside it, containing the single import line, using the same editor-or-copy choice as Step 1:
```powershell
notepad "$HOME\.claude\CLAUDE.md"          # 🪟 type/paste: @~/.ai/ENGINEERING.md  (plus the Claude-specific bullets from the released file)
```
Verify it exists and has the right first line:
```powershell
Get-Content "$HOME\.claude\CLAUDE.md" -TotalCount 1   # expect: @~/.ai/ENGINEERING.md
```
Verify inside Claude (📚 official-doc verified):
```text
/context
/memory
/doctor prompt-audit     # Claude Code v2.1.283+
```
Expected: the user-level `CLAUDE.md` appears among loaded memory/instruction files.

### Step 3 — 🔵 Codex

```bash
mkdir -p ~/.codex
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.codex" | Out-Null   # 🪟 Windows
```
Codex has no `@import`, so `AGENTS.md` must contain the **full combined text** (canonical file + Codex footer), not a one-line pointer. Easiest zero-knowledge approach: open an editor and paste the complete released `AGENTS.md` content directly:
```powershell
notepad "$HOME\.codex\AGENTS.md"           # 🪟 paste the full released AGENTS.md content, then save
```
Or, if you already have both pieces as separate files on macOS/Linux, concatenate them:
```bash
cat ~/.ai/ENGINEERING.md > ~/.codex/AGENTS.md
cat codex-footer.md >> ~/.codex/AGENTS.md
```
Verify the file is non-empty:
```bash
test -s ~/.codex/AGENTS.md && echo "generated"
```
```powershell
(Get-Item "$HOME\.codex\AGENTS.md").Length   # expect a non-zero byte count
```
Verify inside Codex (📚 official-doc verified — no dedicated "show instructions" command is documented):
```bash
codex --ask-for-approval never "Summarize the current instructions."
```

### Step 4 — 🟢 Copilot CLI

```bash
mkdir -p ~/.copilot
cp ~/.ai/ENGINEERING.md ~/.copilot/ENGINEERING.md
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.copilot" | Out-Null   # 🪟 Windows
Copy-Item "$HOME\.ai\ENGINEERING.md" "$HOME\.copilot\ENGINEERING.md"
```
Create `copilot-instructions.md` inside `~/.copilot/` containing `@ENGINEERING.md` plus the Copilot-specific bullets:
```powershell
notepad "$HOME\.copilot\copilot-instructions.md"   # 🪟 paste/save the released file's content
```
Verify it exists:
```powershell
Test-Path "$HOME\.copilot\copilot-instructions.md"
```
Verify inside Copilot CLI (📚 official-doc verified):
```text
/instructions
```
```bash
copilot instruction list
```

## 🔄 I.6 After you edit `ENGINEERING.md`

| Tool | What to do |
|---|---|
| 🟣 Claude | No copy needed — it imports live. Start a new/resumed session to pick up the change. |
| 🔵 Codex | **Regenerate** `~/.codex/AGENTS.md` (copy + footer), then start a new run/session. |
| 🟢 Copilot | **Re-sync** `~/.ai/ENGINEERING.md` → `~/.copilot/ENGINEERING.md`, then start/resume a session. |

## ⚠️ I.7 Gotchas — one per tool family

**🔵 Codex**
1. `ENGINEERING.md` and `AGENTS.md` in the same folder are **not** auto-combined; `AGENTS.md` is the only file Codex loads unless you configure `project_doc_fallback_filenames`.
2. `AGENTS.override.md` silently replaces `AGENTS.md` at a given scope — check for it before assuming your edits are ignored.
3. The instruction chain is built **once per run/session** — edits mid-session do not retroactively apply.
4. Only **one** applicable instruction file per directory is used on the root→cwd walk.
5. Deeper/later directories are treated as **more specific**, not "overriding" in a strict sense.
6. Combined project-doc content is capped at `project_doc_max_bytes` (**default 32 KiB**) — oversized docs get truncated/dropped.

**🟢 Copilot CLI**
1. Copilot can combine **many** instruction sources at once (`copilot-instructions.md`, `instructions/**/*.instructions.md`, `.github/copilot-instructions.md`, `.github/instructions/**/*.instructions.md`, `AGENTS.md`, `CLAUDE.md`) — there is **no general precedence order**, so avoid writing contradictory rules across files.
2. `@path` imports are supported in `.github/copilot-instructions.md`, `AGENTS.md`, `CLAUDE.md` — **not** in `GEMINI.md` or `*.instructions.md`.
3. Local imports must stay inside the custom-instructions directory — use `@ENGINEERING.md`, never `@~/.ai/ENGINEERING.md`.
4. Path-specific instruction files are conditional on `applyTo` frontmatter matching the files in play.
5. Edits to instruction files are **not** hot-reloaded into an already-running session — start a new/resumed session.
6. Subagent instruction inheritance differs by agent type (see Part V.2) — never assume parity with the main session.
7. `--no-custom-instructions` disables repository custom instructions for **all** agents, overriding any subagent's `include-custom-instructions: true`.
8. `COPILOT_HOME` relocates the entire personal configuration directory — check it first when instructions seem "missing."

**🟣 Claude**
1. Imports organize instructions; they do **not** make the content context-free. Big imports still cost tokens.
2. Applicable `CLAUDE.md` files are **concatenated**, not stacked as strict overrides — keep them consistent rather than relying on one "winning."
3. Claude Code also reads repository `AGENTS.md` files — keep overlapping guidance consistent across both.
4. Built-in **Explore** and **Plan** subagents deliberately **skip** `CLAUDE.md` and git-status to stay fast/cheap; every other subagent loads it unless `omitClaudeMd` is set.

## ✅ I.8 Internal consistency checklist

```text
🟣 Claude:  @~/.ai/ENGINEERING.md                       (direct import)
🔵 Codex:   generated AGENTS.md (no import mechanism)
🟢 Copilot: @ENGINEERING.md + locally synced copy       (relative import only)
```
These forms are **not interchangeable** — do not copy one tool's pattern into another.

---

# Part II — "I Set It Up. How Do I Actually Use It?" ▶️

> **User:** "Okay, I configured everything. What do I actually type?"

## 🙋 II.0 "I just created these files — now what? Do I have to load them myself?"

Answering the exact questions people ask right after Part I, before touching a tool:

**Q: I created `CLAUDE.md` in my project. Do I need to tell Claude to read it, or open it myself?**
A: No. Claude Code **automatically** reads project `CLAUDE.md` (and the user-level one in `~/.claude/`) the moment you start a session in that folder. You never open or load it manually — just run `claude` from inside the project.

**Q: Same question for `AGENTS.md` with Codex, and `copilot-instructions.md` with Copilot CLI?**
A: Same answer — both are **auto-discovered**. Codex reads every `AGENTS.md` from your project root down to your current folder, plus `~/.codex/AGENTS.md`. Copilot reads `copilot-instructions.md` (project and `~/.copilot/`) plus `.github/copilot-instructions.md`. You just launch `codex` / `copilot` from the project folder — nothing to open or run.

**Q: Then what does "automatically loaded" actually mean — do I have to run a command?**
A: It means the CLI reads the file's **content** into the session's context **when the session starts**, with zero action from you beyond being in the right folder. It is not a command you run; it is not a plugin you enable. If the file exists in the right location, it is read.

**Q: I also have `ENGINEERING.md` (my canonical custom-instruction file, shared across all three tools, per Part I). Is that auto-loaded too?**
A: **Not directly, and this is the part people miss.** None of the three tools auto-discover a file literally named `ENGINEERING.md`. Instead, Part I's setup made each tool's *own* auto-discovered file **pull it in**:
- 🟣 Claude: `~/.claude/CLAUDE.md` contains the line `@~/.ai/ENGINEERING.md` — Claude auto-loads `CLAUDE.md`, sees that `@` import line, and **then** also loads `ENGINEERING.md`'s content. Two files, one load, no extra step from you.
- 🔵 Codex: there is **no import syntax** at all — so Part I's setup **copies** `ENGINEERING.md`'s content directly into `~/.codex/AGENTS.md` (plus a Codex-specific footer) at setup time. Codex auto-loads `AGENTS.md`, which already *contains* the ENGINEERING.md content verbatim — there is no live "import" happening, just a one-time copy you must redo after every edit (Part I.6).
- 🟢 Copilot: `copilot-instructions.md` contains `@ENGINEERING.md`, and a synced copy of `ENGINEERING.md` sits next to it in `~/.copilot/`. Copilot auto-loads `copilot-instructions.md`, resolves the `@` import against that local copy.

**Q: So if I edit `ENGINEERING.md`, does every tool pick up the change immediately?**
A: No for all three — each needs the step in Part I.6 (Claude: nothing extra, the import re-resolves next session; Codex: re-copy into `AGENTS.md`; Copilot: re-sync the copy) **and** a fresh/new session, because instructions are read once at session start, not watched live.

**Q: How do I actually prove any of this worked, in plain terms?**
A: Start the tool in the project folder, then ask it directly — these are real, typeable prompts:
```text
🟣 claude  →  /context                         (lists every file it loaded)
🔵 codex   →  "List the exact instruction files you were given, in order."
🟢 copilot →  /instructions                    (lists every file it loaded)
```
If your `ENGINEERING.md` content (or its Codex-footer/Copilot-synced form) does **not** appear in that output, something in Part I.5 wasn't completed — redo the relevant step before continuing.

**Q: I wrote my own custom instruction file with my own name (not `CLAUDE.md`/`AGENTS.md`/`copilot-instructions.md`) — how do I actually get each tool to use it?**
A: None of the three tools auto-discover an arbitrarily-named file. You have exactly two options, per tool:

| Tool | Option A — rename/move it to an auto-discovered name | Option B — keep your name, pull it in explicitly |
|---|---|---|
| 🟣 Claude | Save/move it to `CLAUDE.md` (project root) or `~/.claude/CLAUDE.md` (global) | Add one line inside an auto-discovered `CLAUDE.md`: `@my-custom-name.md` (relative) |
| 🔵 Codex | Save/move it to `AGENTS.md` at the relevant directory, or `~/.codex/AGENTS.md` (global) | **Not supported** — Codex has no import syntax; either copy its content into `AGENTS.md`, or tell Codex each session: `"Read my-custom-name.md and follow it for this session."` (session-only, not persistent) |
| 🟢 Copilot | Save/move it to `copilot-instructions.md` (project or `~/.copilot/`) or `.github/copilot-instructions.md` | Add one line inside an auto-discovered file: `@my-custom-name.md` (must stay inside the custom-instructions directory) |

In short: **Option A (use the exact expected filename) is the only guaranteed-working approach for all three tools.** Option B (`@import`) only exists for Claude and Copilot, never Codex.

**Q: I wrote a `SKILL.md` — how do I actually get Claude/Codex/Copilot to use it?**
A: A skill is **never** auto-loaded into every session the way `CLAUDE.md`/`AGENTS.md` are — its content loads only when the tool decides it's relevant, or when you invoke it by name. Steps, per tool:

- 🟣 **Claude Code:** file must be at `.claude/skills/<name>/SKILL.md` (project) or the equivalent user-level skills folder. Then either type `/<name>` (e.g., `/release-checklist`), or just ask naturally — Claude matches your request against the skill's `description` field and loads it only if relevant.
- 🟢 **Copilot CLI:** file must be at `.github/skills/<name>/SKILL.md`, `.claude/skills/<name>/SKILL.md`, or `.agents/skills/<name>/SKILL.md` (project), or `~/.copilot/skills/`/`~/.agents/skills/` (personal). Invoke the same way — by relevance or by naming it explicitly in your prompt (Copilot's CLI does not document a `/<name>` slash form for skills the way Claude does — use `"Use the <name> skill..."` instead).
- 🔵 **Codex:** native skills use `.agents/skills/<name>/SKILL.md` (project) or `~/.agents/skills/<name>/SKILL.md` (personal). Ask explicitly to use the named skill; see Part VI.

> [!IMPORTANT]
> Creating the file is never enough by itself for *any* of these mechanisms — "will this tool read it without me saying anything" depends entirely on whether it is (a) an auto-discovered filename (`CLAUDE.md`/`AGENTS.md`/`copilot-instructions.md`), (b) pulled in via `@import` from one of those, (c) a properly-located skill invoked by name/relevance, or (d) something you must explicitly tell the agent to read every time. If it's none of those four, the tool will never see it.

This chapter is deliberately mechanical. For each tool: open a terminal → navigate → launch → verify → work.

## ▶️ II.1 🟣 Claude Code — concrete walkthrough

```text
MyProject/
├── CLAUDE.md            ← project instructions (optional)
├── src/
└── tests/
```

```bash
cd ~/work/MyProject        # 🖥️ working directory matters: discovery starts here
claude                      # 📚 launches an interactive session
```
Verify loaded context:
```text
/context
/memory
```
Ask directly:
```text
"Summarize the project instructions currently active for this session.
Do not reveal hidden system instructions; summarize only project/user
instruction sources that the product exposes."
```
- **Auto-discovered:** user `~/.claude/CLAUDE.md`, project `CLAUDE.md` (root + nested), repository `AGENTS.md`, `.claude/rules/**`, `CLAUDE.local.md`.
- **Not auto-discovered:** an arbitrary task file like `docs/tasks/ABC-123.md` — tell Claude to read it explicitly.
- **Subfolder launch:** launching from `src/service/` still discovers CLAUDE.md files on the path up to the project root plus the user-level file; nested/path-specific rules closer to the cwd are also picked up.
- **Fresh session needed after instruction edits:** yes — `/context` reflects what was loaded **at session start**, not live edits.
- **Env var:** no documented Claude-specific "home" override comparable to `CODEX_HOME`/`COPILOT_HOME`; Claude uses the OS home directory for `~/.claude`.

## ▶️ II.2 🔵 Codex — concrete walkthrough

```bash
cd ~/work/MyProject
codex                        # 📚 launches interactive TUI
```
No dedicated "show instructions" command is documented; verify by asking:
```text
codex --ask-for-approval never "Summarize the current instructions you were given."
```
- **Auto-discovered:** `~/.codex/AGENTS.md` (or `AGENTS.override.md` if present) + one `AGENTS.md` per directory from the repository root down to the cwd.
- **Not auto-discovered:** task briefs, issue text, anything not named per Codex's documented filename priority.
- **Subfolder launch:** changes the starting point of the root→cwd walk; instructions from directories *above* the actual project root used by Codex's root detection may not be included if Codex does not consider that folder part of the project.
- **Monorepo:** nested `AGENTS.md` files at each service's folder add increasingly specific guidance later in the merged prompt.
- **Reload:** the instruction chain builds once per run — start a new run after edits.
- **Env var:** `CODEX_HOME` relocates the whole Codex config directory, including `AGENTS.md`/`AGENTS.override.md`.

## ▶️ II.3 🟢 Copilot CLI — concrete walkthrough

```bash
cd ~/work/MyProject
copilot                      # 📚 launches interactive session; trust prompt appears first time
```
Verify:
```text
/instructions
```
```bash
copilot instruction list
```
- **Auto-discovered:** `$HOME/.copilot/copilot-instructions.md`, `$HOME/.copilot/instructions/**/*.instructions.md`, `.github/copilot-instructions.md`, `.github/instructions/**/*.instructions.md` (conditional on `applyTo`), `AGENTS.md`, `CLAUDE.md`.
- **Not auto-discovered:** ordinary task docs; `.instructions.md`/`GEMINI.md` files do **not** expand `@path` imports.
- **Subfolder launch:** Copilot still discovers repository-root instruction files; working-directory changes mainly affect what gets edited/read first, not instruction discovery, which is repo-rooted.
- **Reload:** start a new session, or use `/new`, after editing instructions.
- **Env var:** `COPILOT_HOME` relocates personal config; `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` adds extra personal instruction directories (main session only — not guaranteed for subagents).
- **Flags:** `--no-custom-instructions` disables repo instructions for every agent in the session, including custom subagents that request `include-custom-instructions: true`.

## 🧾 II.4 Daily command cheat sheet

### 🟣 Claude Code

| Command | What it does | Session-changing? | Interactive? |
|---|---|---|---|
| `claude` | Start in current project | New session | Yes |
| `claude agents` | Open agent view (dispatch/monitor background sessions) | New view | Yes |
| `/context` | Inspect loaded context/instruction sources | No | Yes |
| `/memory` | Inspect memory/instruction configuration | No | Yes |
| `/doctor prompt-audit` | Detect stale/conflicting/invalid instructions (v2.1.283+) | No | Yes |
| `/skill-name` | Invoke a specific skill directly | No | Yes |
| `claude mcp add/list/remove` | Manage MCP servers | No | No |

### 🔵 Codex

| Command | What it does | Session-changing? | Interactive? |
|---|---|---|---|
| `codex` | Start interactive TUI in cwd | New session | Yes |
| `codex --ask-for-approval never "<prompt>"` | Non-interactive run with a given approval policy | New session | No |
| `codex mcp add <name> -- <cmd>` | Add an MCP server | No | No |
| `codex mcp list` | List configured MCP servers | No | No |
| `codex mcp login <name>` | OAuth-login an MCP server | No | Semi |
| `/mcp` (inside TUI) | View active MCP servers | No | Yes |

### 🟢 Copilot CLI

| Command | What it does | Session-changing? | Interactive? |
|---|---|---|---|
| `copilot` | Start interactive session | New session | Yes |
| `copilot -p "<prompt>" --allow-tool='shell(git)'` | Programmatic one-shot run | New session | No |
| `copilot --cloud` | Start a cloud-sandboxed session | New session | Yes |
| `/instructions` | Inspect discovered instruction sources | No | Yes |
| `copilot instruction list` | Same, from the shell | No | No |
| `/sandbox enable` | Turn on local sandboxing mid-session | No | Yes |
| `/login` | Authenticate to GitHub | No | Yes |
| `/new` | Start a fresh session (reload instructions) | New session | Yes |

## 🆚 II.5 Cross-tool "I want to…" table

| I want to… | 🟣 Claude Code | 🔵 Codex | 🟢 Copilot CLI |
|---|---|---|---|
| Start working in this project | `cd` + `claude` | `cd` + `codex` | `cd` + `copilot` |
| See loaded instructions | `/context`, `/memory` | Ask the agent (no dedicated command) | `/instructions` |
| Start a fresh session | exit + relaunch, or new agent-view row | new `codex` run | `/new` or relaunch |
| Check MCP servers | `claude mcp list` | `codex mcp list`, `/mcp` | ask agent / session config |
| Add MCP server | `claude mcp add` | `codex mcp add` | configure in session/project MCP config |
| Run non-interactively | scripted prompt (📚 doc-verified pattern) | `codex --ask-for-approval never "<prompt>"` | `copilot -p "<prompt>"` |
| Run in a sandbox | N/A (use OS/CI sandboxing) | approval/sandbox policy flags | `/sandbox enable`, `copilot --cloud` |
| Dispatch background work | `claude agents` | multiple independent runs | `task` tool background mode (session-internal) |
| Invoke a specific skill | `/skill-name` | Ask to use the named skill | built-in `skill` invocation surfaced to session |

---

# Part III — The Decision Engine 🧭

> **User:** "I received new information. Where does it go — instruction, skill, task brief, agent, or MCP?"

## 🧭 III.1 Primary decision tree

```text
I received new information.
        │
        ▼
Is it only for THIS task/ticket?
        │
       YES → Is it already in Jira/Azure DevOps/GitHub issues?
        │        YES → keep it there; read/reference it for the task
        │        NO  → optionally create a TASK BRIEF (see Part IV)
        │               do NOT make it a permanent instruction
        │
        NO
        │
        ▼
Is it stable knowledge/rule for the WHOLE project?
       YES → PROJECT INSTRUCTIONS or ordinary PROJECT DOCS
        │
        NO
        │
        ▼
Does it apply only to one folder/file class?
       YES → PATH-SPECIFIC INSTRUCTION (where supported)
        │
        NO
        │
        ▼
Is it a REPEATABLE PROCEDURE used again and again?
       YES → SKILL (if the tool supports it)
        │
        NO
        │
        ▼
Does the work benefit from a SPECIALIZED DELEGATED WORKER?
       YES → CUSTOM AGENT / SUBAGENT (if supported)
        │
        NO
        │
        ▼
Does the agent need an EXTERNAL tool/data/service?
       YES → MCP / native tool integration
        │
        NO → keep it in the task prompt or ordinary documentation
```

## 🧭 III.2 Second axis — what kind of information is it?

| Kind of information | Belongs in |
|---|---|
| Behavior/rule ("always do X before Y") | Instruction (global/project/path-specific) |
| Fact/architecture/requirement | Project documentation, maybe summarized by an instruction |
| One-time task | Task prompt / task brief |
| Repeated procedure | Skill |
| Specialized role | Agent |
| External capability | MCP / tool |
| Security restriction | Real permission/policy/sandbox — **not only Markdown** |

## 📊 III.3 Instruction vs. documentation

| Information | Project instruction? | Ordinary project documentation? |
|---|---:|---:|
| "Run tests before reporting completion" | ✅ | optional |
| "Architecture uses event sourcing" | concise reference maybe | ✅ detailed |
| Full domain model | ❌ usually | ✅ |
| 200-line deployment runbook | ❌ | ✅ |
| "Use the documented deployment runbook; never deploy without approval" | ✅ | ✅ |
| Current user story | ❌ normally | ✅ / issue tracker |
| Permanent coding convention | ✅ | maybe |
| API reference | ❌ | ✅ |
| One-time investigation notes | ❌ | ✅/temporary |
| Stable security boundary | ✅ concise | ✅ detailed + enforcement |

## 📋 III.4 Quick decision table — real user sentences

| User says | Likely action |
|---|---|
| "Implement user story ABC-123" | Task prompt/task brief, not global instruction |
| "Every API endpoint must use our error envelope" | Project instruction + architecture docs |
| "Whenever we release, follow this 12-step process" | Skill if supported |
| "Only files under `frontend/` use this style" | Path-specific instruction |
| "I personally prefer concise summaries in every project" | Global instruction |
| "Never run production deployment without approval" | Instruction + real permission/policy enforcement |
| "Use Jira to fetch my assigned story" | MCP/native integration |
| "Have a separate specialist review security" | Agent/subagent if supported |
| "This architecture diagram explains the system" | Project documentation |
| "These acceptance criteria apply only to this ticket" | Task brief |
| "This test command changed permanently" | Project instructions/docs update |
| "Use this secret token" | Secret manager/environment mechanism — never Markdown |
| "Only run this script when debugging flaky CI" | Skill or scoped doc, not global instruction |
| "Future endpoints must emit correlation IDs" | Project instruction (stable rule) |
| "This sprint only touches the billing service" | Task brief, not instruction |

## 📎 III.5 "Do I have to load the file manually?" quick reference

| File type | Auto-discovered? | Explicit invocation needed? | Session restart needed after edit? | Verify with |
|---|---|---|---|---|
| `ENGINEERING.md` | Only via the adapters (Claude import / generated Codex file / Copilot import) | No | Yes | per-tool inspector |
| `CLAUDE.md` (user/project) | Yes | No | Yes | `/context`, `/memory` |
| `AGENTS.md` (Codex/Copilot) | Yes | No | Yes | ask agent / `/instructions` |
| `copilot-instructions.md` | Yes | No | Yes | `/instructions` |
| `CLAUDE.local.md` | Yes (if present) | No | Yes | `/context` |
| Path-specific rules (`.claude/rules`, `.github/instructions`) | Conditional on scope/`applyTo` | No | Yes | per-tool inspector |
| Skills (`SKILL.md`) | Conditional — relevance-based or `/skill-name` | Sometimes (`/skill-name`) | Yes (new skills) | tool-specific skill list |
| Task briefs | **No** | **Yes — tell the agent to read it** | N/A (just re-reference it) | n/a |
| Ordinary docs | No | Yes | N/A | n/a |
| MCP configs | Yes, once added | No (tool discovery is automatic once configured) | Sometimes (restart/`Restart extension`) | `/mcp`, `codex mcp list`, `copilot instruction list` |
| Custom agents | Yes (definition discovered) | Invocation may be automatic (description-matched) or explicit | Yes for new/edited definitions | agent list commands |

> [!IMPORTANT]
> A normal task Markdown file (`docs/tasks/ABC-123.md`) is **documentation**, not an automatically loaded instruction file, in any of the three products. Tell the agent to read it, or supply it via `@file` in-prompt (Copilot), file attachment, or explicit reference.

## 💬 III.6 Worked prompts for every decision-tree outcome

Each row shows the **exact sentence** you'd actually type, matched to the Part III.1 branch it lands on.

| Decision outcome | Example prompt you actually type |
|---|---|
| Task brief (one ticket) | `"Read docs/tasks/ABC-123.md. Confirm acceptance criteria, then propose the smallest complete change before implementing."` |
| Project instruction (stable rule) | `"Add a rule to CLAUDE.md: all new API endpoints must return errors using our standard error envelope (see src/errors/envelope.ts). Keep it to two sentences."` |
| Path-specific instruction | *(Claude)* `"Create .claude/rules/frontend.md that applies only to frontend/**: use Tailwind utility classes, never inline styles."` — *(Copilot)* `"Create .github/instructions/frontend.instructions.md with applyTo: 'frontend/**' containing: use Tailwind utility classes, never inline styles."` |
| Skill (repeatable procedure) | *(Claude/Copilot)* `"We keep repeating a 6-step release checklist. Create a skill called release-checklist that captures it."` |
| Custom agent (specialized role) | *(Copilot)* `"Create a custom agent called security-auditor that only reviews code for vulnerabilities and never edits files."` |
| MCP / external tool | `"I need you to query our Postgres database directly. Is there an MCP server configured for that, or do I need to add one?"` |
| Keep in task prompt only | `"For this session only, ignore the slow integration tests and just run unit tests."` (a one-off override — never promote this into a permanent instruction) |

---

# Part IV — Task Briefs & the User-Story Workflow 📝

## 📝 IV.1 Why task briefs exist

Many users mistakenly paste a user story directly into `CLAUDE.md`, `AGENTS.md`, or global instructions. This pollutes always-loaded context with one-time information and makes stale requirements masquerade as permanent rules.

> [!NOTE]
> A task brief is an **ordinary project document**. None of the three products auto-load it. You must tell the agent to read it (or attach/reference it).

## 📝 IV.2 Task brief template

```markdown
# ABC-123 — Add retry status to order processing

## Goal
## Business context
## Acceptance criteria
## Non-goals
## Relevant components
## Known constraints
## Source links / issue references
## Required tests
## Risks
## Open questions
## Definition of done
```

Suggested (not auto-loaded) locations: `docs/tasks/ABC-123.md`, `tasks/ABC-123.md`, `.work/ABC-123.md`.

To create it: `mkdir -p docs/tasks` (or `New-Item -ItemType Directory -Force docs\tasks` 🪟), then `notepad docs\tasks\ABC-123.md` (or `code docs\tasks\ABC-123.md`) and paste the template below. This is an **ordinary project file** — creating it does nothing by itself; you must tell the agent to read it (next section).

## 🧭 IV.3 Three options for handling a user story

| Option | Use when | Where it lives |
|---|---|---|
| **A — In the task prompt** | Short, one-off, already in an issue tracker | The conversation itself |
| **B — Temporary task brief** | Long story, many acceptance criteria, multi-session work | `docs/tasks/*.md` (ordinary doc) |
| **C — Update project instructions** | The story reveals a **stable rule** for all future work | `CLAUDE.md`/`AGENTS.md`/`copilot-instructions.md` project-level file |
| **D — Update/create a skill** | The story reveals a **repeatable procedure** | `SKILL.md` where supported |
| **E — Create a specialized agent** | Repeated delegated specialization is valuable (e.g., a recurring "regression-review" role) | Custom agent definition |

> [!WARNING]
> Do not create a skill or agent for a single ticket. Do not promote "ABC-123's acceptance criteria" into `AGENTS.md`. Only the **generalizable rule** behind the story (if any) belongs in permanent instructions.

## 🧪 IV.4 Worked example — same story, all three tools

**Story:** *"ABC-123 — When an order is cancelled, persist a cancellation reason and expose it on the order-status API."*

### 🟣 Claude Code

```bash
cd ~/work/OrderService
claude
```
```text
/context                                    # confirm CLAUDE.md + project rules loaded
"Read docs/tasks/ABC-123.md and summarize the acceptance criteria."
"Inspect src/orders/** and tests/orders/** relevant to cancellation handling."
"Propose the smallest complete change. Do not implement yet."
# after reviewing the plan:
"Implement the plan, add tests, then run the orders test suite."
```
Review diff with `git diff`; ask Claude to summarize what changed and run `/doctor prompt-audit` if instructions seem off afterward.

### 🔵 Codex

```bash
cd ~/work/OrderService
codex
```
```text
Read docs/tasks/ABC-123.md and summarize the acceptance criteria.
Inspect src/orders/** and tests/orders/** relevant to cancellation handling.
Propose the smallest complete change before editing any files.
```
After approval, let Codex implement and run the project's test command; review `git diff` before accepting.

### 🟢 Copilot CLI

```bash
cd ~/work/OrderService
copilot
```
```text
Explain @docs/tasks/ABC-123.md and summarize the acceptance criteria.
Inspect src/orders/** and tests/orders/** relevant to cancellation handling.
Propose the smallest complete change before editing any files.
```
`@docs/tasks/ABC-123.md` attaches the file's contents directly into the prompt. Approve tool use as prompted; review `git diff` at the end.

### 🔄 IV.5 After the story ships

```text
Did this task reveal a stable rule useful for future tasks?
        │
       YES → add a concise rule to project instructions / docs, or a skill if it's a procedure
        │
        NO → do nothing; let the task brief be archived/deleted per team workflow
```

Do **not** automatically fold ABC-123's specifics into global/project instructions.

---

# Part V — Skills, Custom Agents/Subagents, and MCP 🧠🤖🔌

## 🧠 V.1 Skills

### 🟣 Claude Code skills

- A skill is a `SKILL.md` file (optionally with a supporting directory). Claude uses a skill when relevant, or you invoke it directly with `/skill-name`.
- Claude Code skills follow the open **Agent Skills** standard (agentskills.io), with Claude-specific extensions: invocation control, subagent execution, dynamic context injection.
- **Where personal skills live:** user-level skill directories (parallel to `.claude/skills/**` at project scope).
- **Where project skills live:** `.claude/skills/<name>/SKILL.md`.
- Custom commands (`.claude/commands/*.md`) have been **merged** into skills — both forms still work and create the same `/name` invocation.
- A skill's body loads **only when used** — unlike `CLAUDE.md` content, which is always loaded. This is the key cost advantage: move long procedures out of `CLAUDE.md` into skills.
- Bundled skills ship with Claude Code (`/doctor`, `/code-review`, `/batch`, `/debug`, `/loop`, `/verify`, `/run`, `/run-skill-generator`). Turn them off with the `disableBundledSkills` setting.
- `/run-skill-generator` and `/verify` can **record** a per-project skill (e.g., `.claude/skills/run-<name>/`) so future sessions and other agents reuse the discovered recipe instead of rediscovering it.
- **Create a skill when:** you keep pasting the same instructions/checklist/procedure into chat, or a section of `CLAUDE.md` has grown into a procedure rather than a fact.

### 🟢 Copilot CLI skills ("agent skills")

- A skill is a folder containing `SKILL.md` (YAML frontmatter: `name`, `description`, optional `license`) plus optional scripts/resources, discovered automatically alongside the skill when invoked.
- **Project skills:** `.github/skills/`, `.claude/skills/`, or `.agents/skills/` in the repository.
- **Personal skills:** `~/.copilot/skills/` or `~/.agents/skills/`.
- `allowed-tools` in frontmatter pre-approves specific tools for that skill (e.g., `shell`) — only do this for scripts you trust, since pre-approving `shell`/`bash` removes the confirmation step and can enable prompt-injection attacks to run arbitrary commands.
- Skills are selected by Copilot based on relevance to the task (`description` field), similar to custom agents.

### 🔵 Codex — native skills

Codex supports skills in its CLI and IDE extension. Use `.agents/skills/<name>/SKILL.md` with `name` and `description` frontmatter. Part VI includes a complete example and official sources.

**🧪 Worked example — creating and using a skill (Claude Code):**
```text
mkdir -p .claude/skills/release-checklist
notepad .claude/skills/release-checklist/SKILL.md
```
```markdown
---
name: release-checklist
description: Run this before any production release — version bump, changelog, tag, smoke test.
---
1. Confirm all CI checks are green on main.
2. Bump the version in package.json (semver).
3. Add a CHANGELOG.md entry summarizing user-facing changes.
4. Create and push a git tag matching the new version.
5. Run the smoke-test suite against staging.
6. Only after all above pass, trigger the production deploy.
```
Use it with `/release-checklist`, or naturally: `"Run the release checklist before we deploy."` — Claude loads the skill body only when it's actually relevant, not on every session like `CLAUDE.md`.

**🧪 Worked example — creating and using a skill (Copilot CLI):**
```text
mkdir -p .github/skills/release-checklist
notepad .github/skills/release-checklist/SKILL.md     :: same YAML frontmatter + steps as above
```
Use it: `"Use the release-checklist skill before we deploy."`

### 🧠 V.2 When NOT to create a skill

Skills are **not** for: one user story; one bug; one temporary requirement; project facts that belong in normal documentation; permanent global behavior; secrets; permission restrictions; a single obvious command.

## 🤖 V.3 Custom agents and subagents

### 🟣 Claude Code

| Mechanism | What it gives you | Notes |
|---|---|---|
| **Subagents** | Delegated workers inside one session; own context window, own system prompt, own tool access/permissions; count toward the same usage limits as the main conversation | Built-in: Explore (read-only, fast), Plan (read-only, planning research), General-purpose (full capability) |
| **Agent view** (`claude agents`) | One screen to dispatch/monitor independent background sessions on your machine | Research preview; each dispatched session auto-isolates into its own worktree before editing files |
| **Agent teams** | Multiple coordinated sessions, shared task list, inter-agent messaging, managed by a lead | Experimental, disabled by default |
| **Dynamic workflows** | A script running many subagents and cross-checking results | For work too big for one turn — codebase-wide audits, large migrations |
| **Projects** (cloud) | One ongoing conversation; Claude starts parallel cloud "threads" | Public beta, Pro/Max plans |

- Built-in Explore/Plan subagents **skip** `CLAUDE.md` and git-status for speed; every other subagent (built-in or custom) loads both unless `omitClaudeMd` is set in its definition.
- Custom subagent descriptions are capped at a **combined 15,000 tokens** (excluding built-ins) — Claude Code warns at startup if exceeded.
- Worktrees give each parallel session its own Git checkout so sessions don't collide on files; subagents you spawn can each get one too.

### 🟢 Copilot CLI

- Built-in subagents available via the `task` tool: `explore`, `task`, `general-purpose`, `rubber-duck`, `code-review`, `research`, `security-review` (exact set depends on current CLI/runtime).
- **Custom agents** are `.agent.md` files with YAML frontmatter (name, description, instructions, optional `tools` restriction).
  - **Project scope:** `.github/agents/`
  - **User scope:** `~/.copilot/agents/`
  - If a personal and a repository agent share the same **ID**, the personal one wins; agents sharing a **name** but different IDs both load.
  - Restart the CLI after creating/editing a custom agent to load it.
- **Invocation methods:** `/agent` slash command, explicit instruction ("Use the security-auditor agent on..."), inference from the agent's description/trigger words, or programmatically with `copilot --agent <id> --prompt "..."`.
- **Instruction inheritance (see Part I.7):** session agent and `general-purpose` ✅; built-in `explore`/`task`/`code-review` ❌ by default; custom agents only with `include-custom-instructions: true`, and never beyond what `--no-custom-instructions` allows.

**🧪 Worked example — creating and using a Copilot custom agent:**
```text
mkdir -p .github/agents
notepad .github/agents/security-auditor.agent.md
```
```markdown
---
name: security-auditor
id: security-auditor
description: Reviews code changes for vulnerabilities. Never edits files.
tools: ["read", "grep", "glob"]
---
You review code for security issues only: injection, auth/authz flaws,
secrets in code, unsafe deserialization, missing input validation.
You never modify files — you only report findings with file/line references
and a severity rating.
```
Restart the CLI, then use it:
```text
/agent
```
or explicitly: `"Use the security-auditor agent to review my current changes."` Verify it loaded with `/agent` (it should appear in the list) before relying on it.

### 🔵 Codex — native subagent workflows (verified current, supersedes earlier "no native subagents" guidance)

- Codex CLI **does** have a documented native subagent/multi-agent feature: Codex can spawn parallel "subagents" for independent work (exploration, tests, triage, log analysis) and fold their summaries back into the main thread, keeping the main conversation free of noisy intermediate output ("context pollution"/"context rot"). Official doc: `https://developers.openai.com/codex/multi-agent`.
- **Trigger it explicitly** — ask directly, e.g.:
  ```text
  Review this branch with parallel subagents. Spawn one subagent for
  security risks, one for test gaps, and one for maintainability.
  Wait for all three, then summarize the findings by category with
  file references.
  ```
  Codex also delegates automatically when `AGENTS.md` or skill instructions request it — use `/agent` in an interactive CLI session to inspect and switch between running agent threads.
- **Configure it in `~/.codex/config.toml` (or project `.codex/config.toml`)** under `[agents]`:
  ```toml
  [agents]
  enabled = true                                # on by default
  default_subagent_model = "gpt-6.1-sol"        # model for spawned agents (else inherits parent's)
  default_subagent_reasoning_effort = "high"    # else inherits parent's reasoning effort
  interrupt_message = true                      # record a model-visible note if an agent turn is interrupted
  # max_concurrent_threads_per_session = 4       # leave unset to let Codex choose its own concurrency
  ```
  and ensure `[features] multi_agent = true` (the default in current Codex releases).
- Best for **read-heavy, parallelizable** work (exploration, tests, triage, summarization); be more careful delegating **write-heavy** work since multiple agents editing code concurrently can create conflicts.
- Each subagent does its own model/tool work, so subagent workflows consume **more tokens** than an equivalent single-agent run — don't default to parallel agents for small or tightly-coupled tasks.
- This supersedes the previously documented position in this handbook that Codex had no native subagent concept — that was accurate for older Codex releases but is no longer current; always re-verify against `https://developers.openai.com/codex/multi-agent` since this is an actively evolving area.

## 🔌 V.4 MCP — Model Context Protocol

```text
Agent
  ├── instructions
  ├── skills
  ├── native tools
  └── MCP client ──▶ MCP server ──▶ tools / resources / external systems
```

### 🟣 Claude Code

- `claude mcp add` / `claude mcp list` / `claude mcp remove` manage servers (📚 doc-verified; exact flags vary by transport).
- MCP servers can be scoped locally, per-project, or at user level.

### 🔵 Codex

- Config lives in `~/.codex/config.toml` (user scope) or `.codex/config.toml` (project scope, **trusted projects only**), under `[mcp_servers.<name>]`.
- Add a server: `codex mcp add <server-name> --env VAR=VALUE -- <stdio-command>` (e.g., `codex mcp add context7 -- npx -y @upstash/context7-mcp`).
- List: `codex mcp list`. Help: `codex mcp --help`. OAuth login: `codex mcp login <server-name>`.
- Inside the TUI: `/mcp` shows active servers.
- Supports **STDIO** and **Streamable HTTP** servers; HTTP servers can use OAuth (including CIMD/DCR) or ChatGPT session auth for trusted first-party servers.
- Codex reads the MCP server's `instructions` field at initialization and uses it as server-wide guidance — server authors are told to keep the first 512 characters self-contained.
- The ChatGPT desktop app, Codex CLI, and the IDE extension **share** this MCP configuration for the same Codex host.

### 🟢 Copilot CLI

- The **GitHub MCP server is built in** — no configuration needed for GitHub.com interactions.
- Add other servers with `/mcp add` (interactive form: name, type [Local/STDIO or HTTP/SSE], command or URL, env vars/headers, tool allowlist) — saved **immediately, no restart required**.
- Or non-interactively: `copilot mcp add SERVER-NAME -- COMMAND [ARGS...]` (stdio) or `copilot mcp add --transport http SERVER-NAME URL` (remote), with `--env`, `--header`, `--transport`, `--tools`, `--timeout` options.
- User config file: `~/.copilot/mcp-config.json`. Per-repository MCP servers are also supported (see the "Adding per-repository MCP servers" section of GitHub's MCP doc).
- An **experimental** registry search/install flow exists; organizations/enterprises can configure a registry URL + allowlist policy that Copilot CLI enforces.

**🧪 Worked example — adding and using an MCP server (filesystem server, one per tool):**

*Claude Code:*
```text
claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem C:\Gehan\engineering-instructions-final
claude mcp list                              :: verify it shows "fs"
```
Then in a session: `"List the files under the project root using the fs MCP server."`

*Codex:*
```text
codex mcp add fs -- npx -y @modelcontextprotocol/server-filesystem C:\Gehan\engineering-instructions-final
codex mcp list                               :: verify it shows "fs"
```
Inside the TUI: `/mcp` to confirm it's active, then: `"Using the fs tool, list the project's top-level files."`

*Copilot CLI:*
```text
copilot mcp add fs -- npx -y @modelcontextprotocol/server-filesystem C:\Gehan\engineering-instructions-final
```
Then: `/mcp` (confirm it's listed) and: `"List the project's files using the fs MCP server."`

> [!NOTE]
> This is a real, commonly used reference MCP server (`@modelcontextprotocol/server-filesystem`) shown for illustration; always confirm the exact package/server you add is one you trust before running it, per the warning below.

### 🔌 V.5 Daily MCP use

```text
I configured an MCP server. Now what?
    → ask the agent to use it naturally, or reference its tool by name
How do I see its tools?
    → Claude: claude mcp list · Codex: /mcp, codex mcp list · Copilot: /mcp, ask agent
Do I need to explicitly mention the server?
    → usually no; the agent selects tools based on relevance, like skills
How do I know which server performed an action?
    → tool-call transcripts/logs identify the server + tool name
How do I disable it?
    → remove/comment out its config entry; Copilot also supports per-repo allowlists
How do I remove credentials safely?
    → delete the env var/header entry from the config file; rotate the credential at its source, not just in the config
```

> [!WARNING]
> Do not assume MCP servers are trustworthy by default. A malicious or compromised MCP server can see every tool call you route through it. Treat `allowed-tools`/auto-approval settings for MCP-exposed tools with the same caution as `shell`.

---

# Part VI — Configure AI Agents in Visual Studio Code

Updated 2026-10-02. The paths and capabilities below were checked against the official sources linked at the end. Templates are original examples for the fictional VehiclesApi repository; they were not executed in a customer repository or tested inside VS Code.

## VI.1 Choose the agent before creating files

VS Code is the editor; the selected extension or agent harness determines which configuration it reads. Copilot Chat, the OpenAI Codex extension, and the Claude Code extension are separate surfaces. Selecting a Claude model in Copilot does not turn Copilot into the Claude Code extension. Running a CLI in **Terminal → New Terminal** still uses that CLI's rules.

Open **File → Open Folder** and select the repository root. Install the intended vendor extension through Extensions (`Ctrl+Shift+X`), using the installation link on its official documentation page. Sign in using your organization's approved account. Open that extension's chat panel. In newer VS Code agent interfaces, also check the selected session target/harness. Features can depend on installed version and enterprise policy. [S7–S9]

## VI.2 Which file means what?

| File | Purpose | Automatic behavior |
|---|---|---|
| `AGENTS.md` | Shared project rules | Codex discovers it; Copilot support depends on the session/settings |
| `src/Api/AGENTS.md` | Rules for one subtree | Discovery differs by agent; see VI.4 |
| `.github/copilot-instructions.md` | Copilot project guidance | Supported Copilot sessions load it |
| `.github/instructions/graphql.instructions.md` | Targeted Copilot guidance | Uses `applyTo` and/or relevance |
| `.github/agents/graphql-reviewer.agent.md` | Named Copilot role | Appears in the agent picker when discovered |
| `<skill-folder>/SKILL.md` | Reusable procedure | Discovery makes it available; invocation loads the procedure |
| `CLAUDE.md` | Claude project guidance | Claude's native instruction mechanism |
| `.claude/agents/graphql-reviewer.md` | Claude subagent | Claude-specific agent definition |
| `docs/ai/tools.md` | Human-readable tool/runbook notes | Ordinary documentation; explicitly reference or attach it |
| `docs/ai/instructions.md` | Optional ordinary guidance document | The name alone does not register instructions |

Use exact capitalization for `AGENTS.md` and `SKILL.md`. `agents.md`, `agents-review.md`, `tools.md`, and `instructions.md` are not interchangeable with the recognized formats. `AGENTS.md` does not create several workers, and writing tool names in Markdown does not install or authorize tools. [S1–S6]

## VI.3 Create files through the VS Code Explorer

1. Open Explorer (`Ctrl+Shift+E`). Confirm the top-level folder is the repository.
2. Right-click that folder and choose **New Folder** to create the required directories.
3. Right-click the destination folder, choose **New File**, and enter the exact filename from a template below.
4. Paste the content, replace example paths and commands with repository facts, and save (`Ctrl+S`). Ensure the filename has not become `SKILL.md.txt`.
5. Use Markdown preview (`Ctrl+Shift+V`) to check readability. Preview does not validate agent discovery.

For supported Copilot/VS Code sessions, `Ctrl+Shift+P` → **Chat: Open Customizations** provides an alternative editor for Instructions, Skills, and Agents. Select the intended harness first. If this preview UI is absent in your installed version, create the files manually. [S1–S3]

## VI.4 Root and nested AGENTS.md

Create `AGENTS.md` at the repository root:

```markdown
# VehiclesApi working agreements

- Read the relevant ticket before proposing a change.
- Follow the existing dependency direction: API → Application → Infrastructure.
- Preserve public GraphQL field names, argument types, and nullability unless
  the ticket explicitly requires a contract change.
- Establish the root cause before changing production behavior.
- Add a meaningful regression test for each bug fix.
- Read docs/ai/tools.md for verification commands; confirm them against CI.
- Report commands actually executed, outcomes, and anything unverified.
- Do not commit, push, or deploy unless the user requests that action.
```

Create `src/Api/AGENTS.md`:

```markdown
# API-layer guidance

- Keep resolvers focused on translating GraphQL requests to application calls.
- Preserve authorization checks and cancellation propagation.
- Distinguish external business identifiers from internal database keys.
- Check GraphQL errors as well as data when validating a response.
```

Create `tests/AGENTS.md`:

```markdown
# Test guidance

- Reuse this repository's fixtures and test naming conventions.
- Assert observable behavior, not private implementation details.
- Keep external-ID fixtures distinct from internal numeric IDs.
- Do not use production data or credentials in tests.
```

Codex builds its instruction chain from its global instructions and the project root down to its current working directory. It uses at most one instruction file per directory, preferring `AGENTS.override.md` over `AGENTS.md`; deeper guidance overrides earlier guidance. A root session should not be assumed to preload every descendant file. Start at the appropriate working folder or explicitly ask it to inspect applicable nested rules. [S5]

VS Code Local sessions have separate `chat.useAgentsMdFile` and experimental `chat.useNestedAgentsMdFiles` settings; nested support is disabled by default. Other harnesses follow their own discovery rules. For predictable Copilot targeting, use the next template. [S1]

## VI.5 Copilot project and path-specific instructions

Create `.github/copilot-instructions.md`:

```markdown
# Copilot project guidance

Before editing, read the shared working agreements in [AGENTS.md](../AGENTS.md).
Read [verification notes](../docs/ai/tools.md) before running project checks.
Keep ticket-specific acceptance criteria in docs/tasks rather than this file.
```

Create `.github/instructions/graphql.instructions.md`:

```markdown
---
description: Guidance for GraphQL resolvers and schema changes
applyTo: "src/Api/GraphQL/**"
---

- Preserve the published schema unless the ticket authorizes a change.
- Verify ID semantics across resolver, service, and repository boundaries.
- Check authorization, nullability, error handling, and query amplification.
- Cover the affected query through the existing integration-test fixture.
```

The glob is relative to the workspace root. Adjust it to the real source layout. Keep shared and targeted rules consistent; do not rely on a universal precedence order across products. [S1]

## VI.6 Create a reusable SKILL.md

Choose a destination for the product you use:

| Product | Repository destination | Personal destination |
|---|---|---|
| Copilot in VS Code | `.github/skills/graphql-bugfix/SKILL.md` | `~/.copilot/skills/graphql-bugfix/SKILL.md` |
| Codex extension/CLI | `.agents/skills/graphql-bugfix/SKILL.md` | `~/.agents/skills/graphql-bugfix/SKILL.md` |
| Claude Code | `.claude/skills/graphql-bugfix/SKILL.md` | `~/.claude/skills/graphql-bugfix/SKILL.md` |

Copilot also supports `.agents/skills` and `.claude/skills`. Prefer one discovered copy per skill name for a given agent. Portable metadata does not make vendor-specific commands or permissions portable. [S2, S4, S10]

Paste this into the selected `SKILL.md`:

```markdown
---
name: graphql-bugfix
description: Investigate and fix a GraphQL behavior bug with evidence, a regression test, and contract verification. Use for incorrect data, null results, or resolver lookup failures.
---

# GraphQL bug-fix procedure

1. Read the supplied ticket and applicable project instructions.
2. Confirm the working tree state; preserve unrelated local changes.
3. Trace the query through schema, resolver, service, repository, and data source.
4. Reproduce the reported behavior using the project's actual setup.
5. Explain the root cause with file references and observed evidence.
6. Propose the smallest fix and a regression test. If asked to investigate
   only, stop here and report findings.
7. When implementation is authorized, show the regression test failing for
   the expected reason, implement the fix, and rerun the test.
8. Run relevant broader checks and verify the GraphQL response directly
   when the required local environment is available.
9. Review the diff for contract changes, authorization, and unrelated edits.
10. Report the cause, fix, commands, real results, and remaining uncertainty.

Never invent test output or treat an unavailable environment as a passing check.
```

Keep the folder name and `name` aligned. For initial verification, explicitly ask: **“Use the graphql-bugfix skill to investigate the attached ticket; do not edit yet.”** Claude also supports `/graphql-bugfix`. Check the actual skill picker/menu supported by your client instead of assuming every extension shares slash commands. [S2, S4, S10]

## VI.7 Create different named agents

Different roles need separate definitions, not renamed copies of `AGENTS.md`. Suggested original roles:

| Role | Assignment | Expected result |
|---|---|---|
| GraphQL investigator | Trace behavior without editing | Ranked hypotheses and evidence |
| GraphQL reviewer | Inspect a supplied diff and source | Findings ordered by severity |
| Test planner | Identify missing behavioral coverage | Test cases and fixture requirements |

For Copilot, create `.github/agents/graphql-reviewer.agent.md`:

```markdown
---
name: GraphQL Reviewer
description: Review a supplied GraphQL diff for correctness and contract risks.
tools: ['search/codebase', 'search/usages']
---

Review the supplied diff and relevant source. Do not implement changes.
Check ID semantics, authorization, nullability, and missing regression coverage.
For each finding, give severity, file location, triggering condition, and impact.
Distinguish confirmed defects from questions. If source or diff context is
insufficient, request that context instead of claiming a complete review.
```

Select **GraphQL Reviewer** from the agent dropdown. Attach the diff: this deliberately limited example has no terminal tool to obtain it. Use the editor's tool configuration to select additional tools supported by your actual harness. Copy the format to create `graphql-investigator.agent.md` and `test-planner.agent.md`, changing their names, descriptions, and assignment bodies. [S3]

For Claude Code, create `.claude/agents/graphql-reviewer.md`:

```markdown
---
name: graphql-reviewer
description: Review GraphQL changes when an independent code review is requested.
tools: Read, Grep, Glob
---

Read the supplied diff and relevant source without editing.
Check external versus internal identifiers, authorization, nullability,
and whether tests exercise the failing behavior.
Return prioritized findings with file references and concrete impact.
State what could not be verified. Request a diff if none was supplied.
```

Ask Claude to use the `graphql-reviewer` subagent. The allowlist excludes shell and editing tools; prose alone is not a sandbox. [S6]

Codex has native subagents and its own custom-agent configuration. Do not put Copilot `.agent.md` files in the repository and assume Codex registers them. Use the current [Codex custom-agent documentation](https://learn.chatgpt.com/docs/agent-configuration/subagents) for its configuration format. A configuration-free starting prompt is: “Delegate a read-only review of this diff to a subagent; report correctness and authorization findings.” This is a requested role, not a persisted named-agent file. [S11]

## VI.8 tools.md versus actual tool configuration

Create `docs/ai/tools.md` as a runbook, for example:

```markdown
# Local verification tools

## Repository checks
- Build: dotnet build
- Tests: dotnet test
- Focused regression: dotnet test --filter FullyQualifiedName~Vehicle_WithExternalId_ReturnsVehicle
- Review: git status --short and git diff

Run these from the solution directory. These are starter commands: replace
them with the exact solution/project arguments and prerequisites used in CI.
Record required local services here, without passwords or access tokens.

## Evidence
Report the command, working directory, exit status, and relevant result.
If a database or SDK is unavailable, report the blocked check explicitly.
```

This file explains usage; it cannot register an MCP server, enable shell access, or change approvals. For Copilot, use **MCP: Add Server** in the Command Palette. Current VS Code guidance prefers portable `.mcp.json` with a top-level `mcpServers` object for new workspace setups. Legacy `.vscode/mcp.json` uses `servers`; do not mix schemas. Use the provider's documented transport, executable/URL, and authentication. No MCP server is required for this local GraphQL exercise. [S12]

## VI.9 Claude adapter and extension workflow

When sharing the root agreements, create `CLAUDE.md`:

```markdown
@AGENTS.md

Read docs/ai/tools.md before selecting verification commands.
```

This is Claude's documented import syntax. Current Claude AGENTS support depends on version/settings: its default can use AGENTS as a fallback when CLAUDE files are absent; it does not unconditionally load both. The explicit import is useful when retaining a Claude adapter. [S9]

In the Claude Code VS Code panel, attach the ticket and use the skill prompt from VI.6. In the Codex extension, open the same repository, attach the ticket, and request its skill. Review edits through VS Code Source Control. Extension settings and permissions belong to the selected product, even when the files are edited in the same window. [S7, S8]

## VI.10 Check that the setup works

Use a new conversation after configuration changes and run this harmless check:

```text
Do not modify files. Identify the project instructions you can actually access.
Read docs/ai/tools.md. State the verification commands and the rule for external
versus internal IDs. Tell me whether graphql-bugfix is discoverable as a skill.
Distinguish automatically supplied instructions from files you opened on request.
```

Then request investigation of ABC-123. Confirm the agent inspects code before proposing an ID lookup change. A statement that it loaded instructions is not proof of compliance: inspect file references, tool activity, and the resulting behavior. For Copilot, check discovered customizations and response References; use agent debug logs when discovery fails. [S1]

| Symptom | Check |
|---|---|
| File is ignored | Exact name, saved content, repository root, selected extension/harness |
| Targeted rules do not apply | Actual path versus `applyTo`; active session type |
| Skill is absent | Supported directory, valid YAML, matching folder/name, descriptive trigger |
| Named agent is absent | Correct vendor directory and extension; valid frontmatter |
| Reviewer cannot inspect enough | Attach missing context or deliberately adjust its tool allowlist |
| Local setup works but remote does not | Verify which host/container owns the workspace and user configuration |
| Command fails | Check installed SDK, working directory, project arguments, and service prerequisites |

Commit shared configuration with normal code review. Keep personal preferences in user scope, secrets out of Markdown, and task details in `docs/tasks/ABC-123.md`. Update guidance when real repository commands or architecture change.

## VI.11 Official sources

Retrieved 2026-10-02. These references substantiate the new VS Code section and the related corrections; the rest of the historical handbook is not newly certified by this update.

- [S1 — VS Code custom instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions)
- [S2 — VS Code agent skills](https://code.visualstudio.com/docs/agent-customization/agent-skills)
- [S3 — VS Code custom agents](https://code.visualstudio.com/docs/agent-customization/custom-agents)
- [S4 — OpenAI skills](https://learn.chatgpt.com/docs/build-skills)
- [S5 — Codex AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
- [S6 — Claude subagents](https://code.claude.com/docs/en/sub-agents)
- [S7 — Codex IDE extension](https://learn.chatgpt.com/docs/codex/ide)
- [S8 — Claude Code in VS Code](https://code.claude.com/docs/en/vs-code)
- [S9 — Claude project memory and imports](https://code.claude.com/docs/en/memory)
- [S10 — Claude skills](https://code.claude.com/docs/en/skills)
- [S11 — Codex subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- [S12 — VS Code MCP configuration](https://code.visualstudio.com/docs/agent-customization/mcp-servers)

---


# Part VII — Project-Type Playbooks 🧭

Every playbook below follows the same shape: **stable instructions vs. task-specific requests**, plus a **"Can parallel agents help here?"** subsection. Parallelism depends on task structure and shared mutable state — not on the project label — see Part VIII for the full framework.

## 🔧 VII.1 Maintenance project

**Stable project instructions might include:** test/build/lint commands, coding conventions, module ownership map, deployment boundaries.
**Task-specific (not instructions):** the current ticket's acceptance criteria.

```text
1. Pull/sync changes          10. Make the smallest complete change
2. Inspect repo state (git)   11. Add/update tests
3. Read user story/issue      12. Run strongest relevant checks
4. Identify acceptance        13. Review diff
   criteria                   14. Review security/compatibility
5. Start agent in correct     15. Update relevant docs
   scope                      16. Summarize what changed
6. Confirm instruction        17. Decide whether a stable rule
   sources                        should update project instructions
7. Give/read task brief       18. Do NOT auto-modify global instructions
8. Inspect relevant evidence
9. Confirm assumptions
```

**Can parallel agents help here?**
- Best: read-only investigation split across implementation / tests / docs / compatibility.
- Unsafe: several agents independently changing the same legacy component.
- Ownership: one agent per bounded module; coordinator integrates.
- Review agents: test-gap, security, documentation reviewers after implementation.

**📝 Exactly which file do I create or edit, and what do I write in it?**

| What you're capturing | Exact file (project root) | How to create/open it |
|---|---|---|
| Stable rule (test/build/lint commands, conventions, ownership map) | `CLAUDE.md` **and/or** `AGENTS.md` **and/or** `copilot-instructions.md` — whichever tool(s) you use, same project root as Part I.5 | `notepad CLAUDE.md` (or `code CLAUDE.md`) if the file doesn't exist yet; otherwise open and append |
| This ticket's acceptance criteria | A **new** ordinary file, e.g. `docs/tasks/TICKET-456.md` — never inside `CLAUDE.md`/`AGENTS.md` | `mkdir -p docs/tasks` → `notepad docs\tasks\TICKET-456.md`, paste the Part IV.2 template |

Minimal literal example to append to `CLAUDE.md`/`AGENTS.md` (a **stable rule**, generalizable beyond this one ticket):
```markdown
## Testing
Run `npm test` before every commit. Run `npm run lint` and fix all warnings.

## Module ownership
`src/billing/**` is owned by the billing team — flag any cross-module change there for review.
```
Then, in the agent session, point it at the ticket (not at the instruction file — the agent already auto-loads that):
```text
"Read docs/tasks/TICKET-456.md. Confirm acceptance criteria, then propose
the smallest complete change before implementing."
```
If, after fixing the ticket, you realize a **new rule** should apply to all future work (e.g., "always add a changelog entry"), that is when you go back and append it to `CLAUDE.md`/`AGENTS.md`/`copilot-instructions.md` — not before, and not for a one-off request.

## 🐛 VII.2 Bug-fixing

```text
Bug report
   │
   ├── Agent A → reproduce / inspect logs
   ├── Agent B → inspect implementation path
   ├── Agent C → inspect tests/regressions
   └── Agent D → alternate root-cause hypothesis
          ↓
   Coordinator compares evidence → identifies root cause (not by vote)
          ↓
   Minimal fix → implement → regression test → full verification
```
- If several candidate fixes are worth comparing, use **isolated branches/worktrees**, not concurrent edits to the same checkout.
- Never ask multiple agents to "just fix the bug" in the same working tree simultaneously.

**📝 Exactly which file do I create, and what do I write in it?**

A bug report is **task-specific** — it never goes into `CLAUDE.md`/`AGENTS.md`/`copilot-instructions.md`. Create one ordinary file per bug:

```text
mkdir -p docs/tasks                                         # or: New-Item -ItemType Directory -Force docs\tasks  (🪟)
notepad docs\tasks\BUG-789.md                                # or: code docs\tasks\BUG-789.md
```
Paste a short brief (same shape as Part IV.2, trimmed):
```markdown
# BUG-789 — Order totals off by $0.01 on multi-currency carts

## Symptom
Cart total shown to the customer differs from the amount actually charged
by $0.01 when the cart contains items in two different currencies.

## Steps to reproduce
1. Add one USD item and one EUR item to the cart.
2. View cart total vs. checkout charge.

## Evidence so far
Suspect rounding in src/pricing/convert.ts — not yet confirmed.

## Definition of done
Root cause identified, smallest complete fix, regression test added,
existing pricing tests still pass.
```
Then, in a **single-agent session**, tell it to read that file (do not paste the whole bug report into every message):
```text
"Read docs/tasks/BUG-789.md. Reproduce the symptom by inspecting
src/pricing/** and tests/pricing/**. Identify the root cause before
proposing a fix."
```
If you deliberately want **multiple agents** exploring different hypotheses (Part VIII covers the full framework), give each one the **same brief file** but a **different, explicit instruction**, e.g.:
```text
# Agent A (reproduce/logs):
"Read docs/tasks/BUG-789.md. Reproduce the bug and report exact log output. Do not modify any files."

# Agent B (implementation path):
"Read docs/tasks/BUG-789.md. Trace the code path in src/pricing/** that computes the total. Do not modify any files."
```
Only **you** (or a coordinator agent) merge their findings and decide the fix; only **one** agent then implements it.

## 🚀 VII.3 New project

```text
parallel discovery (requirements / architecture options / security / test strategy)
      ↓
shared architecture decision (sync point)
      ↓
clear module boundaries / interfaces frozen
      ↓
parallel isolated implementation (one owner per module)
      ↓
integration
```
- Do not let agents independently invent incompatible architectures before the interface is settled.
- A temporary **project brief** (not permanent instructions) is the right home for the initial goal until conventions stabilize.

**📝 Exactly which file do I create first, and what do I write in it?**

A brand-new project has **no instruction file yet** — you are creating one for the first time, not editing an existing one.

1. Create the project folder and move into it (skip if it already exists):
   ```text
   mkdir MyNewApp
   cd MyNewApp
   git init                               # optional but recommended
   ```
2. Create the **temporary project brief** first (the overall goal — this is *not* a permanent instruction, it will likely be deleted once the project has real conventions):
   ```text
   notepad PROJECT-BRIEF.md                 # or: code PROJECT-BRIEF.md
   ```
   ```markdown
   # Project brief — MyNewApp

   ## Goal
   A REST API for managing customer orders, written in Node.js + PostgreSQL.

   ## Constraints
   Must run on Azure App Service. Must use TypeScript.

   ## Not yet decided
   Final folder structure, test framework, CI pipeline — the agent should
   propose options before implementing.
   ```
3. **After** the architecture decision is made (the sync point in the diagram above), create the **permanent** project instruction file — same mechanics as Part I.5 Steps 2–4, just run inside `MyNewApp` instead of the user home folder:
   ```text
   notepad CLAUDE.md          :: or AGENTS.md / copilot-instructions.md, matching the tool(s) you use
   ```
   ```markdown
   ## Stack
   TypeScript, Node.js 22, PostgreSQL via Prisma.

   ## Structure
   src/routes, src/services, src/db, tests/ — one folder per concern.

   ## Testing
   Run `npm test` before every commit.
   ```
4. In the agent session, reference the brief explicitly for the first request, then rely on auto-discovery afterward:
   ```text
   "Read PROJECT-BRIEF.md. Propose two or three architecture options with
   trade-offs before writing any code."
   ```

## ☁️ VII.4 DevOps / infrastructure

| Statement | Belongs in |
|---|---|
| "Never deploy without explicit approval" | Instruction + real CI/IAM enforcement |
| "Production AWS account ID" | Not casually in global instructions — use config/secret management |
| "Terraform plan must be reviewed before apply" | Stable project/organization rule |
| "Deploy this feature to staging today" | Task-specific request |

**Parallel read-only:** Terraform plan review, Kubernetes manifest review, IAM review, CI/CD analysis, observability review.
**Parallel isolated writes:** separate modules, independent docs, separate test environments.
**Single-owner:** `apply`/`deploy` and any external mutation.

## 🛡️ VII.5 Cybersecurity (authorized/defensive work)

Project instructions should capture: written scope, authorized targets, prohibited systems, data-handling requirements, evidence handling, credential restrictions, destructive-action boundaries, reporting requirements, human approval points. **Enforcement** (network segmentation, access control, IAM) is separate from Markdown guidance.

**Parallel read-only specialization:** authN/authZ review, dependency/supply-chain review, input validation, secrets handling, configuration, threat-model review — each independent and non-mutating. Authorized scope must stay explicit; parallelism never broadens authorized activity.

## 🗄️ VII.6 Data / database projects

Cover schema changes, migrations, ETL, analytics, data quality, PII, production queries, rollback in project instructions/docs as appropriate.

**Parallel read-only:** schema impact analysis, query/caller analysis, rollback design, data-volume analysis, compatibility review.
**Avoid:** concurrent mutation of the same database; migration **execution** should have one controlled owner.

## 🎨 VII.7 Graphic design

```text
BrandCampaign/
├── assets/  ├── source/  ├── exports/  ├── references/
└── project instructions
```
**Stable instructions:** brand colors, approved fonts, export dimensions, naming conventions, accessibility rules, do-not-overwrite source files, export/compression formats, approval workflow.
**Task-specific:** one campaign request — keep as a task brief.

**Parallel agents:** asset inventory, accessibility review, copy consistency, design-system compliance, export checklist, variant exploration — all read-only/independent-output. Never let agents overwrite shared source assets concurrently without isolation/versioning.

## 🎵 VII.8 Music / audio

```text
AlbumProject/
├── sessions/  ├── stems/  ├── samples/  ├── masters/
└── project instructions
```
**Stable instructions:** DAW/session conventions, sample rate, bit depth, track naming, source preservation, sample licensing, export/archive formats, do-not-overwrite rules.
**Task-specific:** "Create a radio edit of Track 4" — task brief, not instruction.

**Parallel agents:** session organization review, track naming audit, metadata/license inventory, export validation, mix notes — read-only. Avoid simultaneous destructive edits to the same DAW session/source assets without proper version isolation.

## 📚 VII.9 Documentation / research

**Stable instructions:** source quality bar, citation rules, terminology, document structure, fact-verification process, review workflow.
**Task-specific:** one report/article request.

**Parallel agents:** excellent fit — independent source research, fact-checking, terminology review, independent section drafting. The coordinator must reconcile contradictions and normalize terminology before publishing; never resolve conflicting research by majority vote.

## 📱 VII.10 Mobile app development (iOS/Android/cross-platform)

**Stable project instructions might include:** target platforms/OS versions, UI framework (SwiftUI/Jetpack Compose/React Native/Flutter), app-store review guidelines to respect, offline-first rules, permission/privacy requirements, crash-reporting conventions, release/versioning scheme.
**Task-specific (not instructions):** "add a dark-mode toggle to Settings," "fix the crash on login for Android 14."

**📝 Exactly which file, and what to write:**
```text
notepad CLAUDE.md          :: or AGENTS.md / copilot-instructions.md, at the app repo root
```
```markdown
## Platforms
iOS 16+ (SwiftUI) and Android 13+ (Jetpack Compose). Shared logic in src/shared/.

## Store compliance
Never request a permission not justified in the App Store/Play Store listing.
All network calls must use HTTPS; no hardcoded API keys in source.

## Release process
Version bump follows semver; changelog entry required in CHANGELOG.md.
```
**Parallel agents:** read-only split works well — iOS-specific review, Android-specific review, shared-logic review, accessibility (VoiceOver/TalkBack) review, store-compliance review, each independent. **Unsafe:** two agents editing the same shared module (e.g., `src/shared/networking/`) concurrently — give it one owner.

## 🤖 VII.11 Machine learning / data science projects

**Stable project instructions might include:** approved data sources, PII/consent handling, model evaluation metrics and thresholds, reproducibility requirements (seeds, versioned datasets), experiment-tracking tool/location, notebook-vs-production-code boundary, model card/documentation requirement before deployment.
**Task-specific (not instructions):** "try a gradient-boosted model on the Q3 churn dataset."

**📝 Exactly which file, and what to write:**
```text
notepad AGENTS.md          :: or CLAUDE.md / copilot-instructions.md, at the repo root
```
```markdown
## Data handling
Only use data from data/approved/. Never read from data/raw_pii/ directly —
it must go through the anonymization pipeline in src/pipeline/anonymize.py first.

## Evaluation
Report precision/recall/F1 on the held-out test set in results/eval/.
A model is not "done" until it beats the current baseline in results/baseline.json.

## Reproducibility
Set random_state=42 everywhere. Record dataset version + git commit in every experiment log.
```
**Parallel agents:** read-only hypothesis exploration (try model A vs. model B vs. feature set C) is a strong fit **if each writes to its own experiment-output folder** (e.g., `results/exp-A/`, `results/exp-B/`) — never the same output file. A coordinator then compares metrics and picks a winner; never average/vote on model choice without inspecting the actual evaluation evidence.

## 🕹️ VII.12 Game development

**Stable project instructions might include:** engine/version (Unity, Unreal, Godot), target frame-rate/platform budget, asset-pipeline conventions, save-file/version compatibility rules, scripting language conventions, do-not-break-multiplayer-protocol rule.
**Task-specific (not instructions):** "add a double-jump ability to the player controller."

**📝 Exactly which file, and what to write:**
```text
notepad CLAUDE.md
```
```markdown
## Engine
Unity 2022 LTS, C#. Target 60fps on the minimum-spec device listed in docs/min-spec.md.

## Save compatibility
Never change the shape of existing save-file fields without a migration path —
old saves must still load after an update.

## Assets
Textures go through scripts/texture-import-preset.json; do not hand-edit import settings.
```
**Parallel agents:** read-only split across gameplay-code review, performance/frame-budget review, save-compatibility review, asset-pipeline audit. **Unsafe:** multiple agents editing the same scene file or prefab concurrently (binary/semi-binary formats merge poorly) — one owner per scene/prefab, or isolate in separate branches.

## 📦 VII.13 Open-source library / SDK maintenance

**Stable project instructions might include:** public API stability/semver policy, supported language/runtime versions, contribution/PR conventions, required changelog format, breaking-change approval process, documentation-generation tooling.
**Task-specific (not instructions):** "add a `retry()` helper to the HTTP client."

**📝 Exactly which file, and what to write:**
```text
notepad AGENTS.md          :: open-source repos commonly read this one; add CLAUDE.md/copilot-instructions.md too if used
```
```markdown
## Public API policy
This is a published package (semver). Do not change any exported function's
signature without a major-version bump and a CHANGELOG.md "BREAKING" entry.

## Supported versions
Node.js 18, 20, 22. Do not use syntax newer than what Node 18 supports.

## Docs
Public API docs are generated from TSDoc comments — update the comment, not docs/api/*.md directly.
```
**Parallel agents:** excellent fit for read-only — API-surface diff review, changelog-completeness check, backward-compatibility review, docs-drift check, each independent. Only one agent should ever touch the actual version number / publish step.

## 🏚️ VII.14 Legacy system migration / modernization

**Stable project instructions might include:** which legacy behaviors must be preserved byte-for-byte vs. which are allowed to change, the target framework/language, a list of "do not touch yet" modules, feature-flag/rollout strategy, parallel-run/shadow-testing requirements.
**Task-specific (not instructions):** "migrate the invoice-printing module to the new template engine."

**📝 Exactly which file, and what to write:**
```text
notepad AGENTS.md
```
```markdown
## Migration scope
Target: migrate from AngularJS to React, module by module, behind feature flags.
Do NOT touch src/legacy/payroll/** yet — it is out of scope for this phase.

## Behavior preservation
Any migrated screen must produce identical output for the existing test fixtures
in tests/golden/** before it is considered complete.
```
**Parallel agents:** read-only discovery (inventory legacy modules, map dependencies, identify hidden behavior via tests/logs) is a strong early-phase fit. Once migration begins, assign **one module per agent/owner** — never two agents migrating the same legacy module at once, since shared legacy code tends to have undocumented coupling.

## 🚨 VII.15 Incident response / on-call (SRE)

**Stable project instructions might include:** severity definitions, who/what must be paged, read-only-until-authorized rule during live incidents, required postmortem template/location, rollback-first-investigate-after policy, audit-logging requirement for any production change.
**Task-specific (not instructions):** "P1 — checkout service returning 500s since 09:42 UTC."

**📝 Exactly which file, and what to write:**
```text
notepad docs/tasks/INCIDENT-2026-10-02.md     :: incident details are always task-specific, never a stable instruction
```
```markdown
# INCIDENT-2026-10-02 — Checkout 500s

## Timeline
09:42 UTC — error rate spike detected
09:45 UTC — on-call paged

## Current hypothesis
Recent deploy (commit abc1234) introduced a null-pointer on empty cart.

## Constraint
Read-only investigation only until a human approves any production change.

## Definition of done
Root cause confirmed, rollback or fix approved and applied, postmortem drafted.
```
Prompt example:
```text
"Read docs/tasks/INCIDENT-2026-10-02.md. Investigate read-only — inspect logs,
recent commits, and the deploy diff. Propose a rollback or fix. Do NOT apply
any change without explicit human approval."
```
**Parallel agents:** read-only investigation (logs, recent-deploy diff, dependency/infra health, customer-impact scope) run well in parallel **during** an incident. **The actual remediation action (rollback/deploy/config change) must have exactly one human-approved owner** — never parallelized.

## ✅ VII.16 QA / test-automation project

**Stable project instructions might include:** test framework/runner, flaky-test policy, required coverage areas, test-data management rules, what counts as a "real" bug vs. environment flake, CI gating rules.
**Task-specific (not instructions):** "add regression tests for the ABC-123 cancellation-reason bug."

**📝 Exactly which file, and what to write:**
```text
notepad copilot-instructions.md     :: or CLAUDE.md / AGENTS.md, at the repo root
```
```markdown
## Test framework
Jest for unit tests, Playwright for end-to-end. New features require both.

## Flaky tests
Never add `test.skip` to silence a flaky test — open a tracked issue and
quarantine it in tests/quarantine/ instead.

## Test data
Use factories in tests/factories/, never hand-written fixtures with real-looking PII.
```
**Parallel agents:** strong fit — coverage-gap analysis, flaky-test inventory, test-data audit, and new-regression-test authoring can run independently as long as each writes to its own new test file; have one reviewer merge and dedupe overlapping test additions.

## 🧩 VII.17 Any other project type

```text
1. identify independent workstreams      6. isolate write work if needed
2. identify shared mutable state         7. define deliverables
3. assign ownership                      8. run agents
4. decide read-only vs write             9. reconcile evidence
5. isolate write work if needed         10. integrate centrally, verify the whole result
```

---

# Part VIII — Parallel Agents Deep Dive ⚡

> [!NOTE]
> Parallelism is a property of **task structure**, not project type. Ask: *can this work be safely decomposed into independent or isolated workstreams whose results can later be reconciled?*

## 🧭 VIII.1 Decision framework

```text
Can the work be split into independent questions/outputs?
        │
        ├── NO → prefer one agent / sequential work
        │
        └── YES
              ▼
Will agents need to modify the same files/shared state?
        │
        ├── YES → read-only parallel investigation first;
        │         isolated branches/worktrees only if genuinely needed;
        │         centralize integration
        │
        └── NO
              ▼
Can ownership be assigned clearly?
        │
        ├── NO → sequential coordination is safer
        │
        └── YES
              ▼
Can environments/resources be isolated?
        │
        ├── NO → parallel reads fine; parallel mutations risky
        │
        └── YES
              ▼
Is coordination/merge cost lower than time saved?
        │
        ├── NO → one agent is simpler
        └── YES → parallel work may help
```

Evaluate: independence of subproblems, overlapping file ownership, shared mutable state, external side effects, reversibility, production exposure, security/privacy risk, merge complexity, instruction inheritance, context availability, environment isolation, tool limitations, cost/token overhead, verification requirements. **More agents ≠ a better answer.**

## 🧱 VIII.2 Three patterns

**Pattern A — Parallel read-only investigation** (safest default for uncertain/complex work)
```text
                         Coordinator
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
  Implementation         Test analysis      Security/API
   investigation         investigation       investigation
          └───────────────────┼───────────────────┘
                              ▼
                     Evidence reconciliation → controlled implementation
```
Good for: unfamiliar repos, bug investigation, root-cause hypotheses, test-gap analysis, security review, performance investigation, dependency research, architecture discovery, documentation research.
**Default rule:** if ownership is unclear, parallelize reading/reasoning before parallelizing writes.

**Pattern B — Parallel isolated implementation** — use when workstreams are clearly separable:
```text
Repository
├── Worktree A → backend branch → Agent A
├── Worktree B → tests branch   → Agent B
└── Worktree C → docs branch    → Agent C
```
Coordinator reviews and integrates afterward.

**Pattern C — Parallel external/tool operations** (highest risk): multiple agents calling MCP tools, editing issues/tickets, cloud changes, DB mutations, deployments, package publishing, messaging. These require stricter coordination and often stay single-owner/sequential. Never recommend parallel execution merely because it is technically possible.

## 🔬 VIII.3 Product capabilities — researched, not assumed

| Capability | 🟣 Claude Code | 🔵 Codex | 🟢 Copilot CLI |
|---|---|---|---|
| Native subagents | ✅ documented (Explore, Plan, General-purpose, custom) | ❌ not documented | ✅ documented (`explore`, `task`, `general-purpose`, `code-review`, `security-review`, `research`, `rubber-duck`, custom `.agent.md`) |
| Native parallel dispatch/monitoring | ✅ `claude agents` (agent view, research preview) | ❌ not documented | ✅ background `task` invocations within a session; `write_agent`/`read_agent` for follow-ups |
| Agent-team/swarm feature | ✅ "agent teams" (experimental, disabled by default) | ❌ not documented | ❌ not documented as a named feature |
| Background/cloud agents | ✅ "Projects" (cloud threads, public beta) | ✅ ChatGPT/Codex cloud tasks | ✅ `copilot --cloud` sandboxed sessions |
| Multiple independent CLI sessions | ✅ (ordinary OS/terminal capability) | ✅ (ordinary OS/terminal capability) | ✅ (ordinary OS/terminal capability) |
| Built-in Git worktree integration | ✅ documented native awareness; agent-view sessions auto-isolate into worktrees | ❌ manual Git workflow | ❌ manual Git workflow |
| Context/instruction inheritance documented | ✅ (CLAUDE.md loaded by default except Explore/Plan, `omitClaudeMd`) | N/A (no subagents) | ✅ documented per-agent-type (see Part I.7) |
| Maximum documented concurrency | Not a fixed number; limited practically by usage/cost | Not documented | Not documented |

> [!IMPORTANT]
> Distinguish: **(A)** a native product capability, **(B)** ordinary OS/terminal capability (e.g., "open three terminals"), **(C)** an ordinary Git branch/worktree workflow, **(D)** a recommended engineering pattern. Never blur these. If a vendor does not document a capability, say: *"Not documented / not guaranteed."*

## ▶️ VIII.4 Exact commands for parallel use

| Product | Command | Purpose | Creates new session? | Can mutate files? |
|---|---|---|---|---|
| 🟣 Claude | `claude agents` | Dispatch/monitor background sessions | Yes, per dispatched row | Yes, in its own worktree |
| 🟣 Claude | subagent delegation via prompt / `Task`-style tool | Delegate a side task within one session | New context, same session | Depends on subagent's tool access |
| 🔵 Codex | separate `codex` invocations (terminals/scripts) | Manual parallel sessions | Yes, each is independent | Yes — coordinate working directories yourself |
| 🟢 Copilot | `task` tool (background mode) | Dispatch a subagent within the current session | New sub-context | Depends on agent type/tools granted |
| 🟢 Copilot | `write_agent` / `read_agent` | Message/poll a running or idle background agent | No (same agent) | N/A |

If there is no dedicated command for a pattern, the supported alternative is a manual multi-session workflow (next section).

## 🧵 VIII.5 Manual multi-session workflow when native orchestration is absent/insufficient

```text
Terminal 1 → Agent/session A
Terminal 2 → Agent/session B
Terminal 3 → Agent/session C
```

**Same working tree:** safe mainly for read-only investigation; risky for concurrent writes.
**Separate worktrees/isolated directories:** suitable for independent writes.

```text
repo/
worktree-agent-a/
worktree-agent-b/
worktree-agent-c/
```

This is **Git functionality**, not a Claude/Codex/Copilot feature (except Claude's documented worktree-aware agent view). Consider: branches, worktrees, uncommitted changes, merge/rebase, lockfiles, generated files, shared ignored files, common external resources. Do not add worktree complexity for trivial tasks.

## 📄 VIII.6 Parallel agent task-contract template

```markdown
# Agent Assignment

## Objective
Investigate integration-test failures related to order cancellation.

## Mode
Read-only investigation.

## Scope
Inspect: src/orders/**, tests/integration/orders/**
Do not inspect unrelated services unless required to explain a direct dependency.

## Questions
1. Can the failure be reproduced?
2. What is the likely root cause?
3. Which evidence supports the conclusion?
4. Which regression test would detect the bug?

## Allowed actions
- read files, search history if available, run non-destructive tests if appropriate

## Forbidden actions
- no production changes, no deployment, no database mutation, no source edits, no external communication

## Output
Findings, supporting evidence, relevant files/tests, uncertainties, recommended next step.
```

Write-enabled version adds:
```markdown
## Ownership
You may modify only: docs/**
Do not modify: src/**, tests/**, package/lock files
```

Every worker should know: objective, scope, ownership, allowed/forbidden actions, expected output, dependencies, completion criteria.

## 🧪 VIII.7 Labs

**Lab 1 — Parallel bug-fixing.** Symptom: *orders occasionally transition to Paid after cancellation.*
```text
Agent A → state-transition implementation      Agent D → tests & reproduction
Agent B → concurrency/race analysis            Agent E → logs/observability assumptions
Agent C → persistence/transaction behavior
        ↓
Coordinator compares evidence → root cause established (not by vote)
        ↓
Minimal fix → one controlled implementation → regression test → full verification
```
Two isolated candidate fixes may be explored in separate worktrees when comparison is genuinely useful — never ask five agents to "fix the bug" in the same checkout.

**Lab 2 — Recurring workflow → skill.** Before: every maintenance ticket repeats the same long investigation prompt. After: that stable procedure becomes a 🟣/🔵/🟢 skill (including a Codex skill under `.agents/skills`) — but the ticket's specific content stays out of the skill.

**Lab 3 — External system → MCP.** Configure a safe, read-only documentation/search MCP server; verify with `/mcp` (Codex/Copilot) or `claude mcp list`; call it naturally in a prompt; remove/rotate credentials when done.

**Lab 4 — Multi-agent review.** After implementation:
```text
Implementation
     ├── Agent A → correctness review          ├── Agent D → compatibility review
     ├── Agent B → test-gap review              └── Agent E → documentation review
     └── Agent C → security/privacy review
```
Reviewers stay read-only; the coordinator examines evidence and decides which findings require action — never accept a finding merely because multiple agents repeat it.

**Lab 5 — Parallel new-project lab.** Starting a new service/application:
```text
Phase 1 — independent read-only exploration (parallel)
  Agent A → requirements decomposition   Agent D → test strategy
  Agent B → architecture options         Agent E → operational concerns
  Agent C → security/threat considerations
        ↓
Coordinator chooses/records the foundational decisions (one owner, not a vote)
        ↓
Phase 2 — define stable module boundaries/interfaces (coordinator or single agent)
        ↓
Phase 3 — parallel implementation only after interfaces are frozen
  Agent A → domain module   Agent C → API layer
  Agent B → persistence adapter   Agent D → documentation
        ↓
Integration checkpoints: each agent's output compiles/tests against the frozen interface;
coordinator integrates and runs full verification.
```
Do not let several agents independently invent incompatible architectures — Phase 1 output is advisory input to one coordinator decision, and Phase 3 only starts once module contracts are frozen.

## ⚠️ VIII.8 Shared mutable state hazards

```text
Git index / working tree      build output / artifacts      ports
lockfiles                     temporary files                Docker containers
package caches                local databases                migration state
message queues                browser sessions                shared test accounts
cloud environments            CI resources                    external APIs
MCP servers                   issue trackers                  synced/network-storage files
```

Examples: two agents running migrations against the same local DB; two agents rewriting the same lockfile via different dependency changes; two agents binding the same port; two agents creating the same ticket via MCP.

**Prevention:** read-only mode; separate worktrees; separate build dirs; unique ports; separate DBs/schemas/containers/test accounts; idempotency; single-owner external mutations; coordinator approval.

## 🔌 VIII.9 Parallel agents + MCP / skills / instructions

- **MCP:** parallel reads are often fine; parallel mutations (create/update/delete issues, cloud changes, deployments, financial actions) require explicit single-owner coordination. Verify whether multiple agents can call the same MCP server concurrently and whether state/credentials are shared before assuming it's safe.
- **Skills:** a shared skill can be used by many agents concurrently, but the skill's *actions* still need concurrency-safe design — the skill itself doesn't grant safety.
- **Instructions:** never infer inheritance from the fact that the parent has access.

| Context source | Main/session agent | Built-in subagent | Custom subagent | Guaranteed/documented? |
|---|---|---|---|---|
| Global instructions | ✅ | varies by type | varies by config | 🟢 documented per-type; 🟣 documented (CLAUDE.md loaded unless `omitClaudeMd`); 🔵 N/A |
| Project instructions | ✅ | varies | varies | same as above |
| Skills | ✅ | varies | varies | 🟣 documented; 🟢 documented; 🔵 N/A |
| MCP/tools | ✅ | varies | varies | check per-agent tool grants |
| Permissions/sandbox | ✅ | inherited, often restricted | configurable | 🟣 "inherits parent's permission rules, most run with restricted tool set" |

If inheritance is not guaranteed, include essential constraints explicitly in the delegated task (see VIII.6 template).

## 🧑‍✈️ VIII.10 Coordinator responsibilities & synchronization points

The coordinator: understands the task, chooses whether parallelism helps, decomposes work, defines scope, prevents overlapping ownership, passes necessary context, sets safety boundaries, tracks dependencies, collects results, compares evidence, resolves contradictions, integrates changes, reviews the final diff, runs final verification, reports actual results. The coordinator must **not**: blindly trust a subagent summary, merge everything automatically, decide by majority vote, assume full instruction inheritance, allow parallel destructive actions without coordination, or declare completion before integrated verification.

```text
Phase 1 — parallel investigation
        ↓ SYNC POINT — reconcile facts
Phase 2 — architecture/plan decision
        ↓ SYNC POINT — freeze interfaces/ownership
Phase 3 — isolated implementation
        ↓ SYNC POINT — integrate branches/results
Phase 4 — parallel read-only review
        ↓ SYNC POINT — fix findings
Final verification
```

## ❌ VIII.11 When parallel agents are a bad idea

Tiny one-line fix; single tightly coupled function; one config file; single migration execution; production deployment; credential rotation; destructive data repair; single lockfile update; unpartitioned refactor; unclear requirements; tasks where every worker needs every other worker's intermediate result. **One capable agent is often faster and safer for small/tightly coupled work.**

## 💰 VIII.12 Cost, context, and quality trade-offs

More agents can mean more token/compute usage, duplicated repository reading, duplicated web research, more merge work, more inconsistencies, more context transfer, higher tool/API load. Parallelism should optimize the overall task outcome, not maximize agent count. Cite official usage/limit documentation when available (e.g., Claude subagent requests "count toward the same usage limits as your main conversation") rather than inventing numbers.

## 🔍 VIII.13 Observability & failure recovery

**Observability:** inspect running agents/tasks (`claude agents`; Copilot `list_agents`/`read_agent`), identify which agent produced a result, inspect logs/transcripts, cancel (`stop_powershell`-equivalent/process controls), resume, trace tool/MCP actions, distinguish completed vs failed work.

| Failure | Detection | Containment | Recovery |
|---|---|---|---|
| Agent hangs/fails | No status update; error status | Cancel/stop the agent | Re-run with narrower scope |
| Edits forbidden files | Diff review | Revert via git | Re-issue task with explicit ownership |
| Conflicts with another agent | Merge conflict / overlapping diffs | Pause both | Sequential reconciliation |
| Stale state / lost instructions | Unexpected behavior | New session | Re-verify instruction sources |
| Duplicated external action | Two identical tickets/deployments | Flag immediately | Manual cleanup; add idempotency |

Never hide a failure merely to finish the workflow.

## 📋 VIII.14 Parallel-agent quick-decision table

| Situation | Parallel agents? | Recommended pattern |
|---|---|---|
| Small typo | Usually no | One agent |
| One-file bug | Usually no | One agent + optional reviewer |
| Difficult intermittent bug | Often useful | Parallel read-only hypotheses |
| New system architecture | Discovery yes; implementation later | Parallel research → sync |
| Large monorepo investigation | Often useful | Partition by service/domain |
| Security review | Often useful | Independent read-only reviewers |
| Dependency upgrade | Useful for research | Parallel research, single manifest owner |
| Database migration | Analysis yes; execution controlled | Parallel review, one migration owner |
| Production deployment | Usually no for mutations | One controlled owner |
| Documentation research | Very useful | Parallel source research |
| Shared DAW/source editing | Risky | Isolate or sequential |
| Multiple independent modules | Often useful | Isolated branches/worktrees |
| Same file modification | Usually avoid | Sequential or isolated alternatives |

## 💬 VIII.15 Natural-language delegation examples (not special syntax)

```text
"Use multiple agents to investigate this bug in parallel. Keep all agents
read-only. One should inspect implementation, one tests, one API
compatibility. Reconcile the evidence before proposing a fix."

"Split this feature into independent workstreams. Do not allow concurrent
edits to the same files. Use isolated workspaces/worktrees if supported.
Return with the integration plan before any destructive or external action."

"Run an independent security review and test-gap review in parallel after
implementation. Do not modify files."
```
These are natural-language requests interpreted by the agent/orchestrator — not dedicated CLI flags, except where Part VIII.4 lists an actual command.

---

# Part IX — Writing & Maintaining Instructions 📐

## ✍️ IX.1 Writing effective instructions

Good instructions are: specific, stable, actionable, scoped, non-contradictory, verifiable where possible, proportional, short enough to remain useful.

| ❌ Bad | ✅ Better |
|---|---|
| "Always make perfect code." | "Before modifying public APIs, inspect callers and existing compatibility tests." |
| "Use best practices." | "Preserve backward compatibility unless the task explicitly authorizes a breaking change." |
| "Never make mistakes." | "Run the project's test command before reporting completion." |
| "Do everything professionally." | "State assumptions that materially affect implementation or verification." |

Use imperative wording, conditional rules, explicit scope, explicit approval boundaries, and pointers to sources of truth instead of duplicating detail.

## 🔄 IX.2 Instruction hygiene lifecycle

```text
Add only stable, useful guidance
        ↓
Observe real agent behavior
        ↓
Fix ambiguous instructions
        ↓
Remove obsolete rules
        ↓
Split narrowly-scoped rules into path-specific files
        ↓
Move procedures to skills
        ↓
Move detailed facts to docs
        ↓
Audit for contradictions
```

**Audit checklist:** Is this rule still true? Does another file contradict it? Is this project-specific or global? Is this rule really a procedure? Is this content actually documentation? Does it leak secrets? Is it too broad? Is it testable? Does the product still support this behavior?

## 📦 IX.3 Context cost and file size

```text
More instructions ≠ a better agent
```
Symptoms of instruction bloat: important rules ignored, conflicts, reduced task context, harder maintenance, duplicated guidance, later project instructions crowded out (Codex's 32 KiB cap makes this literal).

| Refactor this... | ...into |
|---|---|
| Global rules | Concise principles only |
| Project instructions | Concise rules only |
| Detailed architecture | Project documentation |
| Repeatable workflows | Skills |
| Path-specific rules | Scoped instruction files |
| One-time requirements | Task briefs |

## ⚖️ IX.4 Conflicts and precedence — per tool, never universal

| Tool | What's defined | What's NOT defined |
|---|---|---|
| 🟣 Claude | Applicable `CLAUDE.md` files are concatenated; Explore/Plan skip them unless overridden | No strict override stack — don't rely on "project always beats user" |
| 🔵 Codex | Root→cwd walk, one file per directory, deeper = more specific, `AGENTS.override.md` replaces `AGENTS.md` at its scope | No cross-directory "wins" semantics beyond ordering |
| 🟢 Copilot | Many sources combined | **No general precedence order** across instruction-file types — explicitly documented |

**Conflict-debugging workflow:** 1) inspect discovered instruction sources (`/context`, ask Codex, `/instructions`) 2) locate overlapping rules 3) identify the product's scope behavior 4) remove the contradiction 5) start a fresh session 6) retest.

## 🔐 IX.5 Security and enforcement

```text
Markdown: "Never delete production data."     → behavioral guidance
IAM / DB permissions / sandbox / approval     → technical enforcement
```
Enforcement layers: instructions, permissions, sandbox, approval modes, hooks, OS permissions, CI checks, branch protection, IAM, secret managers, network controls. **Never** store passwords, API keys, tokens, private keys, production credentials, or customer secrets inside instruction files.

---

# Part X — Troubleshooting, FAQ, Quick Decisions 🛠️

## 🛠️ X.1 Troubleshooting matrix

| Symptom | Likely causes | Check | Fix | Verify |
|---|---|---|---|---|
| Command not found | Binary not installed / not on PATH | `which`/`Get-Command` | Install per official docs | Re-run `--version` |
| Global instructions ignored (🟣) | Wrong path; not in a new session | `/context`, `/memory` | Fix path; new session | `/context` shows file |
| Global instructions ignored (🔵) | `AGENTS.override.md` present; wrong `CODEX_HOME`; stale run | check override file; `echo $CODEX_HOME` | remove/merge override; new run | ask agent to summarize instructions |
| Global instructions ignored (🟢) | Wrong `COPILOT_HOME`; stale session; `--no-custom-instructions` set | `/instructions`; check launch flags | fix home/flags; new session | `/instructions` shows file |
| Project instructions ignored | Launched from wrong directory; nested-dir discovery miss | confirm cwd; check repo root | `cd` to project root or correct subfolder | re-inspect instructions |
| Instruction size limit reached (🔵) | Combined project docs > 32 KiB | count bytes of all `AGENTS.md` on path | shrink/move content to skills/docs | re-run and check which content loaded |
| Skill missing | Wrong directory/frontmatter; CLI not restarted | list skill dirs; check `name`/`description` | fix location/frontmatter; restart | invoke `/skill-name` or trigger phrase |
| Custom agent missing (🟢) | Wrong `.agent.md` location; CLI not restarted | check `.github/agents/`, `~/.copilot/agents/` | fix location; restart CLI | `/agent` lists it |
| Subagent missing expected context | Built-in subagent type excludes it by default | check Part I.7/V.3 inheritance table | pass constraints explicitly in the task | review subagent's actual output |
| MCP server missing | Not added / wrong config file | `codex mcp list`, `/mcp`, `copilot mcp add` history | add/correct config | `/mcp` shows it |
| MCP authentication failure | Missing env var/header, expired OAuth | check config file, `mcp login` | re-auth, fix env/header | server responds |
| Permission denied / sandbox blocks | Expected enforcement working as designed | review sandbox/approval mode | adjust approval policy deliberately | re-run action |
| CLI and IDE behave differently | Different product surfaces (Part VI) | confirm which surface is active | treat as separate contexts | n/a |
| Task file not automatically read | Expected — no product auto-loads task docs | n/a | explicitly reference/attach the file | agent confirms it read the file |
| Agent follows stale project rule | Instructions edited mid-session | check session start time vs edit time | new/resumed session | re-ask agent to summarize rules |
| Conflicting instruction files | Multiple sources disagree (esp. 🟢) | `/instructions`, review all discovered files | remove contradiction | retest |

## ❓ X.2 "What happens if…?" FAQ

| Question | Answer |
|---|---|
| I change global instructions while the CLI is open? | Not applied to the current run/session in any of the three tools; start a new/resumed session. |
| I change project instructions mid-session? | Same — treat as not applied until a new session. |
| I launch from the wrong folder? | Discovery is rooted differently per tool (Part II); `cd` to the intended root/subfolder and relaunch. |
| I launch from a nested folder? | 🔵 Codex walks root→cwd; 🟣 Claude discovers CLAUDE.md on the path + user level; 🟢 Copilot is largely repo-root-based regardless of cwd. |
| I use a monorepo? | Nested instruction files add increasingly specific guidance (🔵), or are all combined (🟢/🟣) — keep shared conventions at the root and narrow rules near the code they govern. |
| Both `CLAUDE.md` and `AGENTS.md` exist? | Claude loading depends on settings/version; use `@AGENTS.md` in `CLAUDE.md` for explicit sharing. Copilot discovery is harness-specific. See Part VI. |
| Copilot discovers another agent instruction file (`GEMINI.md`)? | It can be combined into context, but does not support `@path` import expansion. |
| An override file exists (🔵 `AGENTS.override.md`)? | It replaces `AGENTS.md` at that scope entirely. |
| Instructions conflict? | No universal rule resolves this; fix the contradiction rather than guessing a precedence. |
| My instruction file is huge? | Move content to skills/docs; 🔵 risks hitting the 32 KiB project-doc cap. |
| I don't have Git? | All the "review the diff" guidance becomes manual file comparison; preserve copies before large changes. |
| This is not a software project? | The same instruction/skill/task-brief model applies (Part VII.7–VII.9, VII.11, VII.13). |
| I want private personal rules inside a team project? | 🟣 `CLAUDE.local.md`; 🟢 personal `~/.copilot/` dirs / `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`; 🔵 not a documented distinct mechanism — keep personal rules in your own global file. |
| I want the agent to read Jira/Azure DevOps/GitHub issues? | Use the relevant MCP server or native integration — not a Markdown-loading mechanism. |
| I want a subagent to use the same project rules? | Don't assume it — verify per Part I.7/V.3 and pass constraints explicitly if not guaranteed. |
| The skill isn't detected? | Check exact directory, `SKILL.md` filename/frontmatter, and restart the session. |
| MCP works in one project but not another? | Check project-scoped vs user-scoped config, and any org-level allowlist/registry policy (🟢). |
| I need to temporarily disable custom instructions (🟢)? | `--no-custom-instructions` at launch. |
| I want to test what context the agent sees? | `/context`/`/memory` (🟣), `/instructions` (🟢), or directly ask the agent to summarize its instructions (🔵, no dedicated inspector documented). |

## 📋 X.3 Quick decision table recap

See Part III.4 for the full "user says → likely action" table, and Part VIII.14 for the parallel-agent quick-decision table.

---

# Part XI — Copy/Paste Templates 📋

**A — Minimal global instructions:** see `ENGINEERING.md` in this release; copy as-is.

**B — Maintenance project instructions (project-level, concise):**
```markdown
# Project Instructions — <ProjectName>

- Build: <command>  ·  Test: <command>  ·  Lint: <command>
- Module ownership: <short map>
- Never deploy without <approval mechanism>.
- Preserve existing public API in `src/api/**` without explicit authorization.
```

**C — New software project instructions:** same shape as B, intentionally thinner; expand as conventions stabilize (Part VII.3).

**D — DevOps/infrastructure:**
```markdown
- Terraform plan must be reviewed before apply.
- Never run `apply`/`destroy` without explicit human approval.
- Production account/project IDs: see <secret manager>, not this file.
```

**E — Cybersecurity:**
```markdown
- Authorized scope: <systems/targets>. Do not test systems outside this scope.
- Evidence handling: <storage/retention rule>. Report findings via <channel>.
```

**F — Graphic design:**
```markdown
- Brand colors: <hex list>. Approved fonts: <list>.
- Never overwrite files under `source/`. Export format: <format/DPI>.
```

**G — Music/audio:**
```markdown
- Sample rate: <rate>. Bit depth: <depth>. Track naming: <pattern>.
- Never overwrite files under `sessions/` or `masters/`.
```

**H — Research/documentation:**
```markdown
- Cite primary/official sources. State verification date for version-sensitive claims.
- Document structure: <template/ToC>.
```

**I — Temporary user-story task brief:** use the template in Part IV.2.

**J — Bug-fix task brief:**
```markdown
# Bug — <title>
## Symptom  ## Reproduction steps  ## Expected vs actual  ## Suspected area
## Evidence gathered  ## Root cause (once known)  ## Fix approach  ## Regression test
```

**K — Investigation task brief:**
```markdown
# Investigation — <question>
## Hypotheses  ## Evidence per hypothesis  ## Conclusion  ## Confidence  ## Follow-up
```

**L — Skill template (🟣/🟢 where supported):**
```markdown
---
name: my-skill
description: What it does, and specifically when to use it.
---
Step-by-step instructions for Claude/Copilot to follow when this skill is invoked.
```

**M — Custom agent template (🟢 `.agent.md` / 🟣 subagent definition):**
```markdown
---
name: security-auditor
description: Reviews code changes for common security issues. Use for security review requests.
tools: [read, grep, glob]
---
You are a security reviewer. Identify injection, auth, and secret-handling issues.
Report findings with file, line, severity, and confidence. Do not modify files.
```

**N — MCP configuration template:**
```jsonc
// Codex: ~/.codex/config.toml excerpt (TOML, shown here conceptually)
// [mcp_servers.context7]
// command = "npx"
// args = ["-y", "@upstash/context7-mcp"]

// Copilot: ~/.copilot/mcp-config.json excerpt
{
  "mcpServers": {
    "context7": { "type": "local", "command": "npx", "args": ["-y", "@upstash/context7-mcp"], "tools": "*" }
  }
}
```

For every template: **when to use it, where to place it, whether it auto-loads, how to invoke/verify it, and what not to put in it** are all specified in the surrounding sections of this handbook (Parts III–V).

---

# Part XII — Expert Quick-Reference Appendix 📎

| Item | 🟣 Claude Code | 🔵 Codex | 🟢 Copilot CLI |
|---|---|---|---|
| Global file | `~/.claude/CLAUDE.md` | `~/.codex/AGENTS.md` (or `AGENTS.override.md`) | `~/.copilot/copilot-instructions.md` |
| Home override env var | not documented | `CODEX_HOME` | `COPILOT_HOME` |
| Project file(s) | `CLAUDE.md`; `AGENTS.md` via supported discovery/import | `AGENTS.md` per directory, root→cwd | `.github/copilot-instructions.md`, `AGENTS.md`, `CLAUDE.md` |
| Path-specific | `.claude/rules/**/*.md` | one file per directory (specificity by depth) | `.github/instructions/**/*.instructions.md` + `applyTo` |
| Local/private | `CLAUDE.local.md` | not documented | `COPILOT_CUSTOM_INSTRUCTIONS_DIRS`, personal dirs |
| Imports | `@path` (relative/absolute) | not documented | `@relative-path` (stays inside custom-instructions dir); not in `GEMINI.md`/`*.instructions.md` |
| Inspect context | `/context`, `/memory`, `/doctor prompt-audit` | ask agent directly (no dedicated command documented) | `/instructions`, `copilot instruction list` |
| Reload rule | new/resumed session | new run/session (chain built once per run) | new/resumed session (`/new`) |
| Skills location | `.claude/skills/<name>/SKILL.md` | `.agents/skills/<name>/SKILL.md` | `.github/skills/`, `.claude/skills/`, `.agents/skills/`, `~/.copilot/skills/`, `~/.agents/skills/` |
| Skill invocation | automatic (relevance) or `/skill-name` | relevance or explicit request | automatic (relevance) |
| Agent definitions | built-in + user/project subagents | ✅ native subagents via `[agents]` in `config.toml` (model/reasoning-effort/concurrency configurable) | `.github/agents/*.agent.md`, `~/.copilot/agents/*.agent.md` |
| Agent invocation | Claude delegates automatically by description | explicit request, or automatic via `AGENTS.md`/skill instructions; inspect with `/agent` | `/agent`, explicit instruction, inference, `copilot --agent <id>` |
| MCP config | `claude mcp add/list/remove` | `~/.codex/config.toml` or `.codex/config.toml`; `codex mcp add/list/login` | `~/.copilot/mcp-config.json`; `/mcp add`; `copilot mcp add` |
| MCP built-in server | none documented as built-in | none documented as built-in | **GitHub MCP server built in** |
| Hooks | yes (lifecycle hooks documented) | ✅ native lifecycle hooks (`~/.codex/hooks.json` or inline `[hooks]` in `config.toml`; `PreToolUse`, `PostToolUse`, `SessionStart`, `SubagentStart`/`SubagentStop`, `Stop`, etc.) | `.github/hooks/*.json` (sessionStart, preToolUse, etc.) |
| Context/size limits | ~200 lines/`CLAUDE.md` recommended; 15,000-token combined subagent-description cap | `project_doc_max_bytes` default 32 KiB | not documented as a hard limit |
| Approval/sandbox | permission modes, plan mode | `--ask-for-approval`, sandbox policy | approval prompts per tool, `/sandbox enable`, `copilot --cloud` |
| Parallel dispatch | `claude agents` (agent view), agent teams (experimental), Projects (cloud) | independent CLI invocations; cloud tasks | `task` tool background mode; `write_agent`/`read_agent` |
| Worktree integration | native awareness; auto-isolation for dispatched sessions | manual | manual |

---

# Part XIII — Official Sources & Validation 📚

## Anthropic Claude Code
- https://code.claude.com/docs/en/memory — user/project `CLAUDE.md`, imports, `/context`, `/memory`, `/doctor prompt-audit`, 200-line guidance, concatenation behavior, Cowork caveat.
- https://code.claude.com/docs/en/sub-agents — built-in subagents (Explore/Plan/General-purpose), `omitClaudeMd`, 15,000-token description cap, usage-limit sharing.
- https://code.claude.com/docs/en/skills — `SKILL.md`, Agent Skills standard, bundled skills, `/run`, `/verify`, `/run-skill-generator`, `disableBundledSkills`.
- https://code.claude.com/docs/en/agent-view — `claude agents`, background sessions, auto-worktree isolation.
- https://code.claude.com/docs/en/agents — comparison of subagents, agent view, agent teams, dynamic workflows, Projects, worktrees, cross-session messaging, `/batch`.
- https://code.claude.com/docs/en/quickstart — install commands (native installer, Homebrew, WinGet), `claude --version`, login flow, account types, first session.
- https://code.claude.com/docs/en/troubleshoot-install — install/login error-to-fix mapping (PATH, PowerShell vs CMD, 403s, permissions, architecture mismatches).

## OpenAI Codex
- https://developers.openai.com/codex/guides/agents-md — `AGENTS.md` discovery, overrides, `CODEX_HOME`, root→cwd walk, `project_doc_max_bytes` default 32 KiB.
- https://learn.chatgpt.com/docs/extend/mcp?surface=cli — MCP support, STDIO/Streamable HTTP, `config.toml`, `codex mcp add/list/login`, `/mcp`, shared config across ChatGPT desktop/CLI/IDE extension.
- https://github.com/openai/codex — official repository README: install script URLs, npm/Homebrew install commands, GitHub release binaries, `codex` first run, "Sign in with ChatGPT" vs API key.

## GitHub Copilot CLI
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot — customization index (instructions, settings, hooks, skills, MCP, custom agents, BYOK models, plugins).
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions — instruction file locations, `@path` import rules, `/instructions`, `copilot instruction list`, subagent inheritance, `--no-custom-instructions`.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-mcp-servers — built-in GitHub MCP server, `/mcp add`, `copilot mcp add`, `~/.copilot/mcp-config.json`, per-repo servers, registry/allowlist.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli — `.agent.md` files, `.github/agents/`, `~/.copilot/agents/`, ID/name dedup rules, `/agent`, `copilot --agent`.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills — `SKILL.md`, skill directories, `allowed-tools`, script-enabled skills.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/use-hooks — `.github/hooks/*.json`, lifecycle events, bash/powershell keys.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/overview — launch flow, trust prompts, plan mode, `-p`/`--prompt`, approval options.
- https://docs.github.com/en/copilot/concepts/agents/copilot-cli/about-copilot-cli — supported OSes, interactive/programmatic modes, local/cloud sandboxing, `/sandbox enable`, `copilot --cloud`.
- https://docs.github.com/en/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli — prerequisites (subscription, PowerShell v6+, Node 22+), npm/WinGet/Homebrew/script install, PAT authentication, `COPILOT_GITHUB_TOKEN`/`GH_TOKEN`/`GITHUB_TOKEN`.

## Model Context Protocol
- Referenced via the above Codex and Copilot CLI documentation; no separate MCP-spec claim is made beyond what each vendor page documents.

## 🧾 Validation summary

```text
Research performed:            official-doc fetches for Claude Code (memory, sub-agents,
                                skills, agent-view, agents comparison), Codex (AGENTS.md
                                guide, MCP guide), GitHub Copilot CLI (customize index,
                                custom instructions, MCP servers, custom agents, skills,
                                hooks, CLI overview, about-copilot-cli) during this session.
Commands actually executed:    filesystem-only operations (mkdir/Remove-Item) in this
                                environment; no claude/codex/copilot binary was present
                                to execute product commands.
Commands doc-verified only:    all claude/codex/copilot slash-commands, CLI flags, and
                                MCP/agent/skill commands shown throughout this handbook.
Cross-file conflicts fixed:    none found between ENGINEERING.md/CLAUDE.md/AGENTS.md/
                                copilot-instructions.md during this pass; all four remain
                                mutually consistent with this report.
Outdated claims removed:       two stale Copilot CLI URLs (extend-with-mcp,
                                customize-copilot/create-a-custom-agent) replaced with the
                                current official pages (add-mcp-servers,
                                create-custom-agents-for-cli) found via the customize index.
Remaining uncertainties:       exact maximum parallel-agent concurrency is not documented
                                for any of the three products; Codex has no documented
                                skills/subagent concept, so no commands are invented for it;
                                some Copilot CLI features (registry search/install, BYOK,
                                plugins) are summarized only to the depth needed for this
                                handbook's scope.
```

---

# Part XIV — Installation From Absolute Zero 🚀

> [!NOTE]
> Every step below follows: **Prerequisite → Action → Path → Command → Expected result → Verify → Common failure → Fix → Next step.** Windows (PowerShell) is shown first since that's this handbook's primary environment; macOS/Linux equivalents are included. Every command is labeled with the validation legend from Part 0.

## 🪟 XIV.0 Opening a terminal on Windows (if you've never done this)

1. Press the **Windows key**, type `powershell`, press **Enter**. A dark window opens showing a prompt like `PS C:\Users\YourName>`. That is your terminal, running the PowerShell shell.
2. Everything you type until you press Enter is one **command**.
3. Your **working directory** is shown in the prompt (`C:\Users\YourName`). Change it with `cd path\to\folder`.

## 🟣 XIV.1 Claude Code — install from zero

| Step | Detail |
|---|---|
| Prerequisite | A terminal (above) and a Claude account — Pro/Max/Team/Enterprise subscription, or a Claude Console (API) account. No Git/Node required for the native installer. |
| Action | Run the official installer for your OS. |
| Command (Windows PowerShell) | `irm https://claude.ai/install.ps1 | iex` 📚 |
| Command (macOS/Linux/WSL) | `curl -fsSL https://claude.ai/install.sh | bash` 📚 |
| Command (Windows, Homebrew alt.) | `brew install --cask claude-code` 📚 |
| Command (Windows, WinGet alt.) | `winget install Anthropic.ClaudeCode` 📚 |
| Expected result | Installer downloads and finishes with no red error text. |
| Verify | Open a **new** terminal window, run `claude --version`. 📚 — a version number followed by `(Claude Code)` confirms success. |
| Common failure | `'claude' is not recognized` / `command not found: claude` | The install directory isn't on your PATH yet. |
| Fix | Open a brand-new terminal window (PATH changes don't apply to windows already open); if still missing, see the official [Troubleshoot installation](https://code.claude.com/docs/en/troubleshoot-install) page, which maps each exact error message to a fix. 📚 |
| Other common errors | `irm is not recognized` → you're in Command Prompt, not PowerShell (prompt shows `C:\>` without `PS`); use the CMD-specific command instead. `syntax error near unexpected token '<'` or a `403` → the install script fetch failed; see the troubleshooting page for alternatives. 📚 |
| Login | Run `claude` (starts an interactive session) → follow the browser prompt to sign in. If `ANTHROPIC_API_KEY` is already set, it asks you to approve the key instead. Re-authenticate anytime with `/login` inside a session. 📚 |
| First harmless command | Inside a project folder, run `claude`, then type: `"List the files in this folder and tell me what this project is."` 📚 |
| Update | Native installer auto-updates in the background. Homebrew: `brew upgrade claude-code`. WinGet: `winget upgrade Anthropic.ClaudeCode`. 📚 |
| Uninstall | Remove the installed binary/cask/package via the same tool you installed it with (e.g., `brew uninstall --cask claude-code`, `winget uninstall Anthropic.ClaudeCode`), then delete `~/.claude/` if you want to remove all configuration. 🖥️ |
| Next step | Create your global `CLAUDE.md` (Part I). |

## 🔵 XIV.2 OpenAI Codex CLI — install from zero

| Step | Detail |
|---|---|
| Prerequisite | A terminal and a ChatGPT account (Plus/Pro/Business/Edu/Enterprise) or an OpenAI API key. |
| Action | Run the official installer, or use npm/Homebrew if you already have them. |
| Command (Windows PowerShell) | `powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"` 📚 |
| Command (macOS/Linux) | `curl -fsSL https://chatgpt.com/codex/install.sh | sh` 📚 |
| Command (npm, all platforms, if Node.js is installed) | `npm install -g @openai/codex` 📚 |
| Command (Homebrew) | `brew install --cask codex` 📚 |
| Expected result | Installer completes without error. |
| Verify | Run `codex --version` 📚 in a new terminal; a version string confirms success. |
| Common failure | Command not found after install | Same PATH issue as Claude — open a brand-new terminal window first. |
| Fix | Re-open terminal; if still failing, download the platform binary directly from the [latest GitHub release](https://github.com/openai/codex/releases/latest) and place it on your PATH. 📚 |
| Login | Run `codex`, choose **Sign in with ChatGPT**, and complete the browser flow. API-key sign-in is documented separately for advanced/billing-sensitive setups. 📚 |
| First harmless command | Inside a project folder, run `codex`, then type: `"Tell me about this project."` 📚 |
| Update | Re-run the install script, or `npm update -g @openai/codex`, or `brew upgrade --cask codex`, matching whichever method you used originally. 🖥️ |
| Uninstall | Remove the binary/package via the same install method, then delete `~/.codex/` to remove configuration. 🖥️ |
| Next step | Create your global `AGENTS.md` (Part I). |

## 🟢 XIV.3 GitHub Copilot CLI — install from zero

| Step | Detail |
|---|---|
| Prerequisite | An active **GitHub Copilot subscription**; on Windows, **PowerShell v6+** (not the oldest built-in `powershell.exe` v5 in some cases — check with `$PSVersionTable.PSVersion`). For the npm method, Node.js 22+. |
| Action | Install via npm, WinGet, Homebrew, or the install script. |
| Command (npm, all platforms) | `npm install -g @github/copilot` 📚 |
| Command (WinGet, Windows) | `winget install GitHub.Copilot` 📚 |
| Command (Homebrew, macOS/Linux) | `brew install --cask copilot-cli` 📚 |
| Command (install script, macOS/Linux) | `curl -fsSL https://gh.io/copilot-install | bash` 📚 |
| Expected result | Installer/package manager reports success with no error. |
| Verify | Run `copilot --version` 📚 in a new terminal. |
| Common failure | `npm install` fails with a scripts-ignored warning | Your `~/.npmrc` has `ignore-scripts=true`; use `npm_config_ignore_scripts=false npm install -g @github/copilot` instead. 📚 |
| Fix | See above; otherwise confirm Node.js version with `node --version` (needs 22+). |
| Login | Launch `copilot`, then run `/login` and follow the on-screen GitHub sign-in instructions. Organization/enterprise Copilot policies can disable CLI access — if login fails repeatedly, check with your GitHub admin. 📚 |
| Login (alternative) | A fine-grained personal access token with the **Copilot Requests** permission, exported as `COPILOT_GITHUB_TOKEN`, `GH_TOKEN`, or `GITHUB_TOKEN` (checked in that order). 📚 |
| First harmless command | Inside a project folder, run `copilot`, then type: `"Explain what this project does."` 📚 |
| Update | Re-run the same install method (`npm install -g @github/copilot` again, `winget upgrade GitHub.Copilot`, or `brew upgrade --cask copilot-cli`). 🖥️ |
| Uninstall | Remove via the same package manager (`npm uninstall -g @github/copilot`, etc.), then delete `~/.copilot/` to remove configuration. 🖥️ |
| Next step | Create your global `copilot-instructions.md` (Part I). |

## 🛠️ XIV.4 Installation troubleshooting quick table

| Symptom | Tool(s) | Likely cause | Fix |
|---|---|---|---|
| Command not found right after install | 🟣🔵🟢 | PATH not refreshed in the already-open terminal | Open a brand-new terminal window |
| Wrong install command used | 🟣🔵🟢 | PowerShell vs Command Prompt confusion — prompt shows `PS C:\` for PowerShell, plain `C:\` for CMD | Match the command to the shown prompt type |
| `npm install` silently does nothing useful | 🟢 | `ignore-scripts=true` in `~/.npmrc` | Use the `npm_config_ignore_scripts=false` prefix shown above |
| Login loops or fails | 🟣🔵🟢 | Expired/blocked session, or org policy disabling CLI | Retry `/login`; for 🟢 ask your GitHub org/enterprise admin whether Copilot CLI is disabled by policy |
| Installed but an old version runs | 🟣🔵🟢 | A second, older copy earlier on PATH | Check `where claude` / `where codex` / `where copilot` (Windows) or `which` (macOS/Linux) and remove/reorder the stale copy |

---

# Part XV — Zero-Knowledge Acceptance Tests ✅

Each test below is answered directly, pointing to the handbook section that proves it, rather than re-explained from scratch.

| # | Question | Answer / pointer |
|---|---|---|
| 1 | *Windows + VS Code, never used an AI CLI — install/configure Claude Code* | Part XIV.0 (open PowerShell) → Part XIV.1 (install, verify, login) → Part I (create `~/.claude/CLAUDE.md`) → Part VI (use inside VS Code's integrated terminal). |
| 2 | *Installed all global files — what exact command do I run now?* | `cd` into a real project folder, then run `claude` / `codex` / `copilot` (Part II.1 per-tool walkthroughs). |
| 3 | *How do I know my global instructions actually loaded?* | 🟣 `/context` or `/memory`; 🔵 ask the agent to summarize its instructions (no dedicated inspector documented); 🟢 `/instructions` or `copilot instruction list` (Part 0.3, Part XII table). |
| 4 | *Existing maintenance project, user story ABC-123 — what `.md` file do I create?* | Usually none required — put it in the prompt, or create a **task brief** (`docs/tasks/ABC-123.md`) if long; it is not auto-loaded (Part IV). |
| 5 | *Should I put this user story into `AGENTS.md`?* | No — `AGENTS.md`/`CLAUDE.md`/`copilot-instructions.md` are for **stable, permanent** rules, not one ticket's content (Part III, Part IV.3 Option C vs B). |
| 6 | *We repeat the same release procedure every week — should it become a skill?* | Yes, all three products support skills. Use the correct product directory and a repeatable procedure; see Parts V–VI. |
| 7 | *Can three agents investigate my difficult bug at the same time?* | Yes, as independent **read-only** investigators producing evidence for one coordinator to reconcile (Part VIII.7 Lab 1, Part VIII.10). |
| 8 | *Can they edit files in parallel safely?* | Only with partitioned ownership and/or isolated branches/worktrees — never concurrent edits to the same files (Part VIII.2, VIII.8). |
| 9 | *I configured MCP — how do I know the agent sees it?* | 🟣 `claude mcp list`; 🔵 `/mcp` or `codex mcp list`; 🟢 `/mcp` or ask the agent to list available tools (Part V.3, Part XII). |
| 10 | *My project is graphic design, not software* | Part VII's graphic-design playbook — same five-file architecture, different stable facts (brand colors, fonts, export rules) (Part VII.7, templates F in Part XI). |
| 11 | *My project is music/audio* | Part VII's music/audio playbook (sample rate, bit depth, naming, source preservation) (Part VII.8, template G in Part XI). |
| 12 | *The tool appears to ignore my instructions* | Part X.1 troubleshooting matrix — check file path, working directory, session freshness, override files, and `--no-custom-instructions`-style flags. |
| 13 | *An official documentation link now returns 404* | Part IX / Part XIII protocol: never treat a 404 as "feature removed" — search the vendor's current doc site/index, verify the official domain, use the current page, record it, and continue (demonstrated live for Copilot CLI MCP/agents URLs in this release). |

---

> [!TIP]
> **Final mental model:** Set up → Load/discover → Verify → Use → Decide the right context type → Work → Verify the result → Promote only stable knowledge → Maintain. Everything in this handbook exists to make each arrow in that chain concrete for Claude Code, Codex, and GitHub Copilot CLI.

