# 📙 AI Coding-Agent Configuration Handbook

> **The operational manual:** choose the harness, create the exact artifact, discover it, invoke it, inspect what happened, break it, and repair it.
>
> This is not a universal configuration guide. VS Code is an editor and can host different harnesses. **The selected product/harness owns the schema and runtime.** Copy only the block for the tool you actually use.

**Checked against official vendor documentation:** 2026-10-03.
**Execution status:** commands and config examples below are documentation-checked teaching examples; they were not run against your machine or account. Test non-destructive examples in a disposable repository first.

## 🧭 Start here: identify your actual harness

Before writing a file, write down:

```text
Editor: VS Code / Visual Studio / other
Harness: Copilot (Local or Agent Host) / Codex / Claude Code / CLI / other
Version:
Workspace or user customization:
Does this harness support the feature and file format?
```

**Selecting a Claude model in Copilot does not make the session Claude Code.** Likewise, opening a Codex CLI in VS Code’s terminal remains a Codex CLI session. Select the session target/harness and verify it before creating configuration.

### ⛔ Universal security rule

| Mechanism | What it does | What it does **not** do |
|---|---|---|
| Instructions / prompt / skill | Guides model behavior | Enforce a permission boundary |
| Agent tool list | Limits available capabilities when honored by that harness | Replace OS sandbox/IAM |
| Hook | Deterministic automation at a supported lifecycle event | Guarantee organization-wide release policy |
| Sandbox | Restricts process/filesystem/network capabilities where configured | Authorize access in a remote business system |
| IAM / service authorization | Decides external system access | Prove an AI answer is correct |
| CI / branch protection | Enforces shared build/review/merge checks | Protect local credentials from a compromised process |

> [!CAUTION]
> Never put API keys, PATs, passwords, customer records, or production credentials in Markdown, a checked-in config file, a prompt, a skill, or a hook log. Use a secret manager or approved environment/identity mechanism. Review third-party skills, MCP servers, hooks, scripts, and plugins as executable dependencies.

---

# 1. 🧭 Choose the right artifact before making a file

| Real need | First choice | Does it load automatically? |
|---|---|---|
| One ticket, one bug, one request | Normal prompt or task brief | A task brief does **not**; reference/attach it |
| Stable repository facts/rules | Project instructions | Product-specific discovery |
| Rule for a file type/subtree | Scoped instruction/rule | Only when matching/supported |
| Repeated multi-step procedure | Skill | Discovered, then explicit/relevance invocation |
| Recurring specialist with a distinct tool policy | Custom agent/subagent | Definition discovered; invoke/delegate |
| External API/data/tool | MCP or native integration | Configure server; host discovers tools |
| Predictable lifecycle action | Hook | Runs only on supported event/config |
| Shared pass/fail gate | CI, branch protection, IAM | Not an AI customization |

### ❌ Do not

Put a ticket’s acceptance criteria in global instructions, create a role just to avoid one prompt, add MCP when a built-in tool already solves it, or add a hook because a reminder was forgotten once.

### ✅ Do

Observe the same problem repeatedly → choose the smallest mechanism → create one artifact → test on a safe representative task → keep or delete based on evidence.

---

# 2. 📁 Instructions, task briefs, prompts, and skills

## 2.1 Task brief: one engineering task

**Why:** long acceptance criteria should persist in an ordinary project file without becoming always-on rules.

### Create

```text
repo/
└── docs/
    └── tasks/
        └── ABC-123.md
```

Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force docs\tasks | Out-Null
notepad docs\tasks\ABC-123.md
```

VS Code: open **File → Open Folder** on the repo root → Explorer (`Ctrl+Shift+E`) → New Folder `docs/tasks` → New File `ABC-123.md` → paste and save.

```markdown
# ABC-123 — vehicle query returns null
## Goal and expected behavior
## Actual behavior and reproduction
## Acceptance criteria
## Non-goals and compatibility constraints
## Evidence available
## Required tests and definition of done
```

### Invoke and verify

Tell the assistant to read/attach `docs/tasks/ABC-123.md`. Ask it to restate acceptance criteria before edits. Inspect its citations/tool activity and compare the summary to the brief.

**Break it:** use a made-up filename. Repair by checking current directory, exact spelling, file saved, and path relative to workspace. A task brief is never proof of auto-loading.

## 2.2 Project instructions

### Paths are product-specific

| Product/session | Common project convention | Scope note |
|---|---|---|
| Codex CLI/IDE | `AGENTS.md`; Codex walks from project root to current directory, with override behavior | Project `.codex/` config is trust-gated |
| Claude Code | `CLAUDE.md`; `.claude/rules/` supports scoped rules | Read current Claude memory docs; files above cwd load at launch, nested files can load when read |
| GitHub Copilot CLI | `.github/copilot-instructions.md`, `AGENTS.md`, `CLAUDE.md`, modular instructions | `/instructions`; no general precedence order |
| VS Code Local | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`, settings/profile formats | Local behavior is not the same as Agent Host |
| VS Code Agent Host | Depends on selected harness; use its supported format/path | Use Session Target and customization editor |

### Make a useful shared rule

```markdown
# Repository working agreements
- Read the linked task brief before changing behavior.
- Preserve public API and existing behavior unless acceptance criteria authorize a change.
- Run `dotnet test <verified-project-or-solution>` for code changes.
- Report actual commands/results; distinguish blocked checks from passes.
- Do not commit, push, or deploy unless explicitly requested.
```

Replace example commands after checking README, solution files, CI, and team guidance.

### Manual workflow

1. Choose one target harness and scope: workspace for shared rules; user scope for personal habits.
2. Create the *exact* product-supported path/file; do not create near-matches like `agents.md` if the tool requires `AGENTS.md`.
3. Keep content short, stable, and checkable. Link to detailed architecture/runbooks instead of duplicating them.
4. Save. For cross-session discovery, start a fresh session where required.
5. Use the product’s instruction/context inspector when available.
6. Ask a harmless question whose correct answer is only in the file.
7. Confirm behavior through file references and tool results; “I loaded it” is not sufficient.

**VS Code creation:** select the actual **Session Target** first → run **Chat: Open Customizations** → select **Instructions** → **New (Workspace/User)** → choose the supported format/location → save. In Copilot CLI, create `.github/copilot-instructions.md` using Explorer or an editor, then run `/instructions` to check discovery and enablement. In Claude Code, create `CLAUDE.md` and start a session from the project; inspect loaded instructions or ask for a project fact. In Codex, create `AGENTS.md` at repository root, start Codex in that repository, and ask it to identify a verified project command from the file. These files are not interchangeable merely because they contain Markdown.

**Prompt to draft (not blindly install) instructions:**

```text
Inspect this repository's README, source layout, tests, CI, and existing
instruction files. Propose only stable, evidenced rules for [chosen harness
and path]. Cite evidence for every build/test command. Do not create or edit
files yet. Identify conflicts, unsupported assumptions, secrets, and a
harmless discovery test; wait for approval.
```

### Path-specific instructions

VS Code/Copilot `*.instructions.md` can use frontmatter such as:

```markdown
---
description: Apply GraphQL resolver guidance
applyTo: "src/Api/GraphQL/**"
---

- Preserve schema names, types, and nullability unless the ticket authorizes a contract change.
- Check authorization, cancellation, error behavior, and resolver-to-service boundaries.
```

`applyTo` patterns are workspace-relative. Claude rules use Claude’s `paths` mechanism instead. Do not copy VS Code fields into Claude or Codex config. Verify the real target file path matches the glob; a plausible-looking rule can silently never activate.

## 2.3 Prompt files vs task briefs vs skills

**VS Code prompt files:** `.prompt.md` under `.github/prompts` are manually invoked in the Local agent. Official VS Code docs currently say prompt files are **deprecated for Agent Host sessions**, are not loaded there, and Local is planned for removal. For new Agent Host work, prefer a supported skill. For an existing prompt file, check the selected harness and migrate only after verifying the replacement.

**Codex CLI / Claude Code / Copilot CLI:** do not assume VS Code prompt-file schema or `/prompt-name` behavior. Use the product’s documented task/command mechanism or a normal prompt.

VS Code Local example:

```markdown
---
name: investigate-bug
description: Investigate a reproducible bug before edits
argument-hint: "Ticket ID and symptom"
agent: agent
---
Investigate ${input:ticket}. Read the task brief, reproduce the symptom,
trace the code, and report evidence and a minimal test plan. Do not edit yet.
```

Manual use: create `.github/prompts/investigate-bug.prompt.md`, save, select **Local** harness, type `/investigate-bug`, provide the argument, inspect response and references. If it does not appear, check Local-vs-Agent-Host and file extension. Prompt files are not an authorization boundary.

**Prompt to draft one:** “Create a one-task VS Code Local prompt file for [workflow]. Use only current `.prompt.md` frontmatter fields, scope the work, request evidence, and state expected output. Show the exact file and a manual invocation/failure test. Do not write it until I approve. If I selected Agent Host, recommend a supported skill instead.”

## 2.4 Create a skill from zero

A skill packages a reusable **procedure**, often with references/scripts. It is not a specialist agent, and does not inherently provide a secure tool sandbox.

### Agent Skills portable core

The [Agent Skills specification](https://agentskills.io/specification) requires `SKILL.md` YAML frontmatter with `name` and `description`; it defines optional `license`, `compatibility`, `metadata`, and experimental `allowed-tools`. A `SKILL.md` can sit with `scripts/`, `references/`, and `assets/`.

### Do not confuse same metadata with same runtime meaning

| Product | Example project location | Tool-field meaning and caveat |
|---|---|---|
| Agent Skills standard | A product-discovered skill directory | `allowed-tools` is experimental; implementations vary |
| Copilot CLI | `.github/skills/<name>/SKILL.md`, `.claude/skills/`, `.agents/skills/` | Frontmatter `allowed-tools` can **pre-approve** listed tools. It does not create/limit a sandbox. Avoid pre-approving shell unless every script/source was reviewed |
| Codex | `.agents/skills/<name>/SKILL.md` | Optional `agents/openai.yaml` declares UI metadata, invocation policy, and **tool dependencies** (e.g., required MCP server); it is not an `allowed-tools` security allowlist. Actual MCP/tool config and approvals are host settings |
| Claude Code | `.claude/skills/<name>/SKILL.md` | Claude-specific `allowed-tools` can skip permission prompts for those tools during that skill’s turn; `disallowed-tools` removes tools while active. These grants/restrictions clear after the turn and remain distinct from organization/IAM controls |
| VS Code | `.github/skills/`, `.claude/skills/`, `.agents/skills/` | Agent Skills discovery works across supported harnesses; optional frontmatter and invocation behavior remain harness-specific |

The Agent Skills spec marks `allowed-tools` experimental; do not assume every host implements it. These examples are deliberately **not equivalent**:

```yaml
# Copilot CLI SKILL.md: this pre-approves shell (intentionally shown as a warning).
allowed-tools: shell
```

> [!WARNING]
> The Copilot example above is **not** a safe default. It demonstrates why the same-looking field is operational: the skill can run shell without the usual confirmation. Beginner skills should omit it unless the skill and every referenced script have been reviewed and the approval change is intentional.

```yaml
# Claude Code SKILL.md: skip prompts for Read/Grep this skill turn; remove Bash while active.
allowed-tools: Read, Grep
disallowed-tools: Bash
```

```yaml
# Codex agents/openai.yaml: presentation/invocation metadata plus an MCP dependency.
# This does not grant/limit tools or permissions.
interface:
  display_name: "Build investigation"
  short_description: "Diagnose .NET build failures"
policy:
  allow_implicit_invocation: false
dependencies:
  tools:
    - type: "mcp"
      value: "companyDocs"
      description: "Company documentation MCP server"
      transport: "streamable_http"
      url: "https://mcp.example.invalid/docs"
```

The Codex server name/URL above are placeholders; replace them with an approved, configured MCP server or omit `dependencies` for a skill that uses only host-provided tools. Do not copy `allowed-tools` into `agents/openai.yaml`.

### Create an investigation skill

Example for **Copilot CLI only**:

```text
repo/
└── .github/
    └── skills/
        └── dotnet-build-investigation/
            ├── SKILL.md
            └── references/
                └── build-log-guide.md
```

```markdown
---
name: dotnet-build-investigation
description: Diagnose a failed .NET build from real logs. Use for dotnet build failures, CI compiler errors, or MSBuild failures; do not use for production incident response.
---

1. Read the actual task and repository instructions.
2. Capture the exact command, working directory, exit code, and first causal error.
3. Reproduce only with the documented safe build command.
4. Trace the error to project/source/config. Separate evidence from hypothesis.
5. Report a smallest fix and regression check; do not edit unless asked.
6. If authorized to edit, preserve unrelated changes and rerun the focused check.
7. Report actual results and anything blocked. Never invent a pass.
```

### Create and use, step by step

1. Identify a repeated process (not a one-time ticket).
2. Select the actual product and use its table above to choose a path.
3. Create folder and exact uppercase `SKILL.md` in VS Code Explorer or shell.
4. Keep `name` lowercase/hyphenated, matching the skill folder when required; make `description` say both purpose and trigger.
5. Put clear steps in body; link optional scripts/references by relative path.
6. Do not copy `allowed-tools` across products. Start with no elevated permissions.
7. Save; refresh/reload according to that product. Copilot CLI supports `/skills reload` and `/skills info NAME`; Claude Code supports `/skill-name` and `/skills` and `/reload-skills` when a new top-level skills directory was created during the session; Codex detects changes automatically and can be restarted if a new skill is not detected. VS Code selection/invocation follows the selected harness.
8. Invoke explicitly first. Then inspect skill list/picker/references/tool activity. Compare output against the procedure.
9. Check `git status` and tests. A skill’s existence is not evidence the run followed it.

**VS Code GUI route:** select the intended harness in **Session Target** → **Chat: Open Customizations** → **Skills** → **New Skill (Workspace/User)** → choose the location and name → edit `SKILL.md` frontmatter/body → save. Mention `/skill-name` in Chat for explicit invocation when enabled; otherwise request a task whose description clearly matches. Expand **References** in the response to verify the skill was used. If absent, check harness, path, exact `SKILL.md` casing, name/description validation, and refresh the skill list.

**Prompt to draft a skill:** “Inspect these three completed examples of our repeated workflow. Propose one narrowly scoped skill with exact product-specific destination, frontmatter, and invocation. Keep deterministic checks in scripts/tests, no secrets, and no elevated tool permissions. Show a break/fix verification. Do not create files until I approve.”

**Break/fix:** rename `SKILL.md` to `skill.md`; make description “helps coding”; edit after session start; put a Copilot-only field in Codex. Diagnose exact directory → exact case/name → valid YAML/frontmatter → invocation → session refresh → tool permission. Repair one issue at a time.

---

# 3. 🤖 Custom agents and subagents

## Choose an agent only if role/tool separation pays for itself

An agent is useful when a recurring specialist role has a different context or tool boundary. A prompt is sufficient for one review; a skill is better for a reusable sequence; agent config should not be created just to decorate a role name.

## Product schemas are different

| Harness | Definition | Creation/use |
|---|---|---|
| VS Code custom agent | `.agent.md`; workspace `.github/agents/`, Claude-format `.claude/agents/`, user paths depend on host | Agent Customizations editor or file; select Session Target, choose from Agent dropdown |
| Copilot CLI custom agent | `.agent.md` in `.github/agents/` or `~/.copilot/agents/`; frontmatter includes role/description and optional tools | `/agent` or file; restart CLI after adding/editing; explicit `/agent`, prompt, or `copilot --agent ID --prompt ...` |
| Claude Code custom subagent | Markdown with YAML in `.claude/agents/` or user `~/.claude/agents/` | Invoke by asking Claude to delegate to its name; tools are Claude tool names, and subagents have independent context/permission behavior |
| Codex custom agent | TOML under `.codex/agents/` or `~/.codex/agents/` | Native subagents; custom agent config requires `name`, `description`, `developer_instructions`; use current Codex docs; no `.agent.md` interchange |

### Copilot CLI read-only reviewer template (illustrative)

```markdown
---
name: diff-reviewer
description: Reviews an attached code diff for correctness and compatibility. Use after a code change when independent findings are needed.
tools: ["read", "grep", "glob"]
---

Review only the supplied diff and directly relevant files. Do not edit.
Report each confirmed issue with file/line, trigger, impact, and evidence.
Separate questions from defects. State what was not reviewed.
```

Copilot tool identifiers are runtime-specific. Validate names against the current CLI’s agent/tool documentation; a typo may remove intended capability or cause config validation errors. Copilot subagents do not inherit repository instructions by default. `include-custom-instructions: true` is a Copilot CLI-specific option for a custom agent acting as a subagent; `--no-custom-instructions` overrides it. Do not generalize this field to VS Code custom agents.

### Create, discover, invoke, verify

1. Write the job in one sentence and define read/write scope.
2. Ask whether a normal prompt or skill is enough. If so, stop here.
3. Choose harness; consult only its schema table and current linked docs.
4. Create in its exact destination (VS Code Explorer: open root → New Folder → New File → exact extension → paste → save).
5. Review every field, especially `tools`, model/permission values, scripts, and whether tool names are valid.
6. Reload/restart as indicated above.
7. Discover through the actual picker/list; do not rely on “agent says it exists.”
8. Invoke against a low-risk representative task, with read-only constraints.
9. Inspect tool activity, output, diff/status, and forbidden actions. If the agent was expected not to edit, verify no edits occurred.
10. Break its filename, malformed metadata, or tool ID in a disposable copy; inspect diagnostics; repair and rerun.

### Minimal Copilot CLI workflow

```powershell
New-Item -ItemType Directory -Force .github\agents | Out-Null
code .github\agents\diff-reviewer.agent.md
```

Save the template above → restart `copilot` → run `/agent` to select it → provide an actual diff/read-only review task → inspect its tool calls and `git status`.

### Minimal VS Code workflow

Open Chat → select intended **Session Target** → **Configure Chat / Chat: Open Customizations** → Agents → New Agent (Workspace/User) → choose exact filename → inspect frontmatter and tool access → save → select the named agent from Agent dropdown → provide a bounded task → inspect tool calls and references. For missing agent: verify target/harness, location, visibility, extension/schema, trust, and Agent Debug Logs.

### Codex CLI custom agent: create an actual TOML file

Create `.codex/agents/reviewer.toml`:

```toml
name = "reviewer"
description = "Read-only reviewer for correctness, security, and test gaps."
sandbox_mode = "read-only"
developer_instructions = """
Review the supplied change and directly relevant code only.
Do not edit files. Cite evidence and triggering conditions for each finding.
Separate confirmed defects from questions and say what you did not inspect.
"""
```

The required fields are `name`, `description`, and `developer_instructions`; `sandbox_mode` is a Codex session configuration key. Create folders with Explorer or `New-Item -ItemType Directory -Force .codex\agents`, save the exact TOML file, then start Codex in the trusted repository. Prompt: “Use the reviewer agent to review the current diff read-only; report findings with paths, line references, triggers, and evidence.” Inspect `/agent` threads, actual tool activity, and `git status`; do not treat prose saying “read-only” as enforcement. Break it by changing `sandbox_mode` to an invalid value in a disposable copy, read the parser/startup error, repair and retry.

### Claude Code subagent: create an actual Markdown file

Create `.claude/agents/reviewer.md`:

```markdown
---
name: reviewer
description: Reviews a change for correctness and test gaps. Use after implementation; never edits.
tools: Read, Grep, Glob
---

Review the supplied diff and directly relevant files only. Do not edit.
For each confirmed finding, include evidence, trigger, impact, and file location.
Separate questions from defects and state what you did not inspect.
```

Use VS Code Explorer or PowerShell to create `.claude\agents`, save as `reviewer.md`, and start/restart Claude Code if the directory was newly created. Ask: “Use the reviewer subagent on the current diff, read-only.” Verify the delegation tool row names `reviewer`, inspect findings, then check `git status`. Claude’s `tools` field names (`Read, Grep, Glob`) are not Copilot’s tool aliases or VS Code’s selected-harness tool catalog.

### VS Code custom agent: create through the selected harness

Open **Chat: Open Customizations** → **Agents** → **New Agent (Workspace)** → save in `.github/agents/reviewer.agent.md` → inspect `name`, `description`, `tools`, and body → save. A minimal Copilot-compatible file is:

```markdown
---
name: reviewer
description: Read-only review of a focused code diff for correctness and missing tests.
tools: ["read", "search"]
---

Review only the supplied diff and relevant files. Do not edit.
Report concrete evidence, trigger, impact, and test gaps.
```

Tool names are harness-specific: choose from the selected target’s tool picker/reference, not by copying another product’s list. Select the new reviewer in Chat’s **Agent** dropdown; check tool calls and `git status`. In a Copilot CLI session, use the separate documented Copilot CLI agent schema and restart after creation.

**Prompt to draft an agent:** “Propose a [read-only or bounded-write] agent for [one recurring role]. First inspect current project conventions and available tools for [selected product/harness]. Show the exact target file and every field, explain whether each field changes capability/permissions, and give a safe discovery/invocation/verification task. Do not create the file or run tools until I approve.”

### Subagent vs parallel agent

- **Subagent:** bounded worker inside an orchestrated conversation, own context, product-specific inheritance/permissions.
- **Parallel agents:** independent tasks run concurrently; may be subagents, isolated worktrees, or multiple sessions depending on the product.
- Prefer parallel **read-only** work first. For edits, assign non-overlapping files or isolated branches/worktrees and one integrator.

**Good:** architecture investigation | test-gap analysis | independent security review.
**Bad:** three workers modifying the same resolver and test file on one branch.

**Verify:** wait for all requested work, inspect each report/source/tool trace, reconcile contradictions using evidence (not majority vote), then integrate and run tests.

**Parallel-work prompt:** “Delegate three independent, read-only tasks: (1) trace the failing call path, (2) find relevant regression tests, (3) inspect public-contract/security risks. Give each worker the same ticket, repo root, and no-edit/no-external-side-effect rule. Wait for all results; require paths, symbols, evidence, and unknowns. Reconcile disagreements yourself and do not let workers edit shared files.” Run this through the selected product’s documented subagent feature; inspect the activity/thread view. If that harness cannot delegate, do not pretend separate shell sessions are built-in agents.

---

# 4. ⚡ Hooks: deterministic event automation

## Choose a hook only when a runtime event should trigger predictable work

Instruction: “run formatting.” Hook: run a vetted formatter at a supported event. CI: authoritative check on the shared branch. Sandbox/IAM: restrict capability. A local hook is not a CI policy.

### Product comparison — not interchangeable

| Owner | Config location/schema | Important operational detail |
|---|---|---|
| GitHub Copilot CLI | `.github/hooks/*.json` or user hooks; top-level `{ "version": 1, "hooks": { "sessionStart": [...] } }`; command may specify `bash`, `powershell`, `cwd`, `timeoutSec` | Events are lower camel case; hook config loads at CLI startup; restart after edits |
| Claude Code | `.claude/settings.json` / user settings; `hooks` map with event groups, matchers, handlers | Events include `PreToolUse`, `PostToolUse`, `SessionStart`, etc.; hooks receive JSON; exit/JSON decisions are Claude-specific |
| Codex | `~/.codex/hooks.json`, `~/.codex/config.toml`, project `.codex/hooks.json` or config; event/matcher/handler format | Project hooks need trusted project; inspect `/hooks` and review/trust each changed non-managed hook |
| VS Code Local | `.github/hooks/*.json`, PascalCase event names, Local command keys/schema | Preview; not the same behavior as Agent Host; `chat.useHooks` and Workspace Trust matter |
| VS Code Agent Host | Harness-owned hook system | Some file formats overlap, but event names, payloads, output, and filters can differ; follow selected provider docs |

**VS Code route:** select **Session Target** → open **Chat: Open Customizations** → **Hooks**, or enter `/hooks`. To generate a starting point, run `/create-hook <description>`; review the result against the selected harness’s official reference before enabling it. VS Code hooks are Preview. Its **Local** hook schema is not automatically the schema used by Copilot, Claude, or Codex on Agent Host.

### Safe first hook: log, do not block

Copilot CLI teaching example, repository-level `.github/hooks/audit.json`:

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "powershell": "Add-Content -Path .github/hooks/session.log -Value \"Session started: $(Get-Date -Format o)\"",
        "bash": "printf 'Session started: %s\\n' \"$(date)\" >> .github/hooks/session.log",
        "cwd": ".",
        "timeoutSec": 10
      }
    ]
  }
}
```

Do not commit the resulting log if it can contain private data. Create `.github/hooks/` and the JSON with Explorer or PowerShell, validate JSON (e.g. `Get-Content ... -Raw | ConvertFrom-Json`), run the exact platform command manually, then start a fresh Copilot CLI session. On Windows, the documented example expects PowerShell 7 (`pwsh --version`). Confirm one timestamp appears. Remove/break the script path in a test branch and inspect CLI errors; repair and trigger again.

**Prompt to draft a hook:** “For [selected product/version], propose a minimal non-blocking hook that [one deterministic action] at [supported event]. Use only the current official schema. Show exact files, platform-specific command, input/output behavior, timeout, and how to trigger/diagnose it. Do not create, enable, or trust the hook; wait for approval.”

**VS Code Local hook lab:** create `.github/hooks/audit.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "command": "node .github/hooks/log-tool-use.cjs"
      }
    ]
  }
}
```

Create `.github/hooks/log-tool-use.cjs`:

```javascript
const fs = require("node:fs");
let input = "";
process.stdin.setEncoding("utf8");
process.stdin.on("data", (chunk) => (input += chunk));
process.stdin.on("end", () => {
  const event = JSON.parse(input);
  fs.appendFileSync(
    ".github/hooks/tool-use.log",
    `${event.timestamp} ${event.tool_name}\n`,
  );
});
```

Select **Local**, create both files in Explorer, add `tool-use.log` to `.git/info/exclude`, and start a Local session. Ask it to perform a harmless task that reads a file; verify the tool name appears. Break the script path and check Agent Debug Logs, restore it, and retest. Local payload/tool names differ from Agent Host; never reuse this hook as a permission-control policy.

### Claude Code hook: log session start

Create `.claude/hooks/session_start.py`:

```python
from datetime import datetime, timezone
from pathlib import Path

Path(".claude/session.log").parent.mkdir(parents=True, exist_ok=True)
with Path(".claude/session.log").open("a", encoding="utf-8") as log:
    log.write(f"session started: {datetime.now(timezone.utc).isoformat()}\n")
```

Add this to `.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python .claude/hooks/session_start.py",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

Use a disposable repo and add `.claude/session.log` to `.git/info/exclude`. From repo root, run `python .claude/hooks/session_start.py` manually and confirm one timestamp; start a new Claude Code session and confirm one additional line. Break the script path, observe hook diagnostics, restore it, and retest. This is an audit/logging demonstration only—not a security gate. Claude events, matchers, stdin JSON, exit status, and permission decisions are specific; consult the [hooks reference](https://code.claude.com/docs/en/hooks) before making a blocking hook. Do not reuse VS Code Local payload code.

### Codex hook workflow

Create `.codex/hooks.json` in a disposable repo. For a first smoke test, log a session start:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume",
        "hooks": [
          {
            "type": "command",
            "command": "python3 .codex/hooks/session_start.py",
            "commandWindows": "py -3 .codex/hooks/session_start.py",
            "timeout": 3,
            "statusMessage": "Recording test session start"
          }
        ]
      }
    ]
  }
}
```

Create `.codex/hooks/session_start.py`:

```python
from datetime import datetime, timezone
from pathlib import Path

with Path(".codex/session.log").open("a", encoding="utf-8") as log:
    log.write(f"session started: {datetime.now(timezone.utc).isoformat()}\n")
```

Create `.codex/session.log` and add it to `.git/info/exclude`. Start Codex from the repository root, enter `/hooks`, review the exact hook, and trust it only after inspecting the script. Trigger a new session, inspect the log, change the command path to a nonexistent file and observe the diagnostic, then repair it. Codex hook commands execute in session `cwd`; use a stable repository-root path if your team starts sessions from subdirectories. Use either hooks JSON or inline TOML for a config layer, not both. Project hooks are trust-gated, and a changed hook hash may require review again.

**Codex hook creation prompt:** “Propose a Codex-only `.codex/hooks.json` entry for a harmless session-start audit action. Check current Codex hook events and command fields. Include a disposable test script, trust/review steps, failure test, Windows command, and cleanup. Do not create or trust anything until I approve.”

### Troubleshoot in this order

```text
Wrong product/harness?
→ unsupported event or wrong casing?
→ file location/scope and trust?
→ valid JSON/TOML/frontmatter?
→ command exists and runs manually?
→ correct cwd, interpreter, permissions, environment?
→ timeout or non-zero exit?
→ event actually triggered?
→ inspect product hook log and tool transcript
```

---

# 5. 🔌 MCP: build, connect, invoke, diagnose

## 5.1 Server-side responsibilities

An MCP server owns tools/resources/prompts. **The model proposes a tool call; the host and server validate it.** Validate every argument; authenticate users; authorize every resource/action; limit results; log safely; use read-only access by default. Never expose generic `exec`, unrestricted SQL, or all-filesystem access as a first example.

```text
Host → client → transport → server
     → schema validation → authz → handler → external system
     ← structured result ← server ← audited operation
```

### Safe build/run test loop

1. Implement one harmless read-only handler with strict input bounds.
2. Run the server by itself with its actual startup command.
3. Send a protocol request using the official MCP Inspector/SDK client.
4. List tools and inspect each JSON schema.
5. Call a valid input and invalid/unauthorized input.
6. Check server logs; for stdio, protocol messages own stdout, so direct logs to stderr.
7. Configure exactly one AI host.
8. Verify host’s tool list, invoke from prompt, inspect actual tool call and result.
9. Stop the server and test unavailable behavior.

Official starting points: [MCP server guide](https://modelcontextprotocol.io/docs/develop/build-server), [MCP spec](https://modelcontextprotocol.io/specification), [Inspector](https://github.com/modelcontextprotocol/inspector), [.NET MCP quickstart](https://learn.microsoft.com/dotnet/ai/quickstarts/build-mcp-server).

### Create a real C# MCP server (local stdio)

The current Microsoft quickstart requires the **.NET 10 SDK** and uses a **preview** project template. In PowerShell, create the sample:

```powershell
dotnet new install Microsoft.McpServer.ProjectTemplates
dotnet new mcpserver -n ProjectMcp
Set-Location ProjectMcp
dotnet build
```

Open the generated project. `Program.cs` wires up MCP transport and tool registration; `RandomNumberTools.cs` contains the sample `get_random_number` tool. Replace or supplement the sample with a harmless read-only operation whose input bounds, user authorization, and response size you can enforce in deterministic C#. Keep stdio protocol output on stdout and send diagnostics to stderr.

**Run and verify:** use [MCP Inspector](https://github.com/modelcontextprotocol/inspector) with the current SDK-compatible instructions to start the generated project and list/call the sample tool. Test a valid and an invalid input. Then connect to one host only:

- **VS Code:** install the generated tool server via **MCP: Add Server** (stdio → command `dotnet`, args `run --project <relative-path-to-ProjectMcp.csproj>`, workspace scope). The VS Code workspace file is typically `.vscode/mcp.json` with top-level `servers`; let the UI generate the selected version’s schema.
- **Copilot CLI:** from the repo, run `copilot mcp add project-readonly -- dotnet run --project <path-to-ProjectMcp.csproj>` or configure its `.mcp.json`/`.github/mcp.json` format. Inspect `/mcp`; use a narrow tool list and confirm project trust.
- **Codex CLI/IDE:** run `codex mcp add project-readonly -- dotnet run --project <path-to-ProjectMcp.csproj>`; check `codex mcp list` and `/mcp`.
- **Claude Code:** run `claude mcp add --transport stdio project-readonly -- dotnet run --project <path-to-ProjectMcp.csproj>`; check `claude mcp list`.

Ask the host to call the harmless tool. Verify the visible tool invocation and actual result; stop the server to test unavailable-server behavior. Delete the sample tool or deny it after the lab. This quickstart is not a production template: before deployment add real authentication/authorization, transport security, resource limits, observability, and operational ownership. See the current Microsoft quickstart for Visual Studio connection paths and evolving template details.

**Prompt to draft a server:** “Using the current official .NET MCP server template/SDK, propose a local stdio server for [one harmless read-only company task]. Show exact .NET version, creation commands, files/tools, argument validation, authorization boundary, logging behavior, Inspector test, and one selected host's configuration. Do not include secrets or unrestricted file/SQL/shell tools. Label preview APIs. Do not create or connect it until I approve.”

## 5.2 Host configuration: exact differences

### VS Code

VS Code offers two workspace formats: portable root `.mcp.json` uses `mcpServers`; VS Code-specific `.vscode/mcp.json` uses `servers`. The MCP UI can add a server, start it after trust, and show/toggle tools. VS Code Agent Host reads the portable format natively and forwards supported `.vscode/mcp.json` configurations, but some features (such as interactive input variables) are not portable. Copilot CLI reads root `.mcp.json` but explicitly does **not** read `.vscode/mcp.json`. For a new setup, run **MCP: Add Server** → choose the portable `.mcp.json` destination when cross-tool support is needed → inspect the generated schema.

Teaching example for a **local, reviewed, no-secret** server in portable workspace `.mcp.json`:

```json
{
  "mcpServers": {
    "project-readonly": {
      "type": "stdio",
      "command": "dotnet",
      "args": ["run", "--project", "${workspaceFolder}/tools/ProjectMcp/ProjectMcp.csproj"]
    }
  }
}
```

For VS Code-specific `.vscode/mcp.json`, the corresponding entry uses top-level `servers`, a `type` of `"stdio"`, and an `args` array; generate this format through **MCP: Add Server** to avoid schema drift. The path above is a teaching placeholder. Start/refresh server from UI, inspect available tools, invoke harmless tool, then inspect output.

### Copilot CLI

User config `~/.copilot/mcp-config.json` (or `$COPILOT_HOME/mcp-config.json`):

```json
{
  "mcpServers": {
    "project-readonly": {
      "type": "local",
      "command": "dotnet",
      "args": ["run", "--project", "C:\\work\\repo\\tools\\ProjectMcp\\ProjectMcp.csproj"],
      "tools": ["list_projects", "get_build_status"]
    }
  }
}
```

The path is a teaching placeholder. Better for shared repo config: `.mcp.json` or `.github/mcp.json` supported by Copilot CLI; commit only nonsecret server metadata. It does **not** read VS Code `.vscode/mcp.json`. Folder trust is required for project-level MCP. Configure in CLI with `/mcp add` or `copilot mcp add SERVER -- COMMAND ARGS`; inspect with `/mcp`, then ask it to invoke one tool. Existing CLI docs say adding an MCP server can be immediate; check current version and server list rather than assuming restart.

### Codex CLI / IDE

Codex CLI and IDE share host MCP configuration. Add a local server:

```powershell
codex mcp add project-readonly -- dotnet run --project C:\work\repo\tools\ProjectMcp\ProjectMcp.csproj
codex mcp list
```

Or in `~/.codex/config.toml`:

```toml
[mcp_servers.project-readonly]
command = "dotnet"
args = ["run", "--project", "C:\\work\\repo\\tools\\ProjectMcp\\ProjectMcp.csproj"]
enabled_tools = ["list_projects", "get_build_status"]
```

Codex project `.codex/config.toml` is trust-gated. Verify `codex mcp list` and `/mcp` in TUI. For IDE/desktop, use MCP settings and restart extension if prompted. Current Codex docs support stdio and Streamable HTTP; configure auth, timeouts, tools, and approval per server as needed.

### Claude Code CLI

Local server:

```powershell
claude mcp add --transport stdio project-readonly -- dotnet run --project C:\work\repo\tools\ProjectMcp\ProjectMcp.csproj
claude mcp list
```

The `--` separates Claude options from the server command/args. For remote HTTP, use current `claude mcp add --transport http NAME URL` and approved credentials/header flow. Project `.mcp.json` and user config scopes have separate trust implications; inspect `claude mcp list`, then invoke and review tool activity.

> [!WARNING]
> Configuring MCP makes capabilities available; it does not make a server trustworthy. Prefer narrow tool lists, read-only scopes, nonproduction accounts, rotating credentials, and human approval for writes. Remote MCP needs TLS, authentication, authorization, rate limits, tenant isolation, and audit logs. Never commit access tokens in JSON/TOML.

## 5.3 Troubleshoot MCP

```text
Server command works alone?
→ protocol initialization succeeds?
→ stdout clean for stdio / transport URL valid?
→ host reads this exact config format/path?
→ project trusted? process on local vs remote host?
→ authentication present and current?
→ tool appears with expected schema?
→ user/tool permission allows invocation?
→ handler validates args and returns expected result?
→ logs identify call without secrets?
```

Break one thing at a time: typo command, stop process, alter tool name, remove credentials. Repair from the first failing layer. Do not “fix” a missing server by enabling all tools or exposing broad credentials.

---

# 6. 🖥️ Use the same customizations from CLI and VS Code

1. Open the intended repository in VS Code (`File → Open Folder`).
2. Open Chat and identify **Session Target**.
3. Select **Chat: Open Customizations** or use the editor’s customization panel.
4. Create a user/workspace instruction, skill, or `.agent.md` only if that selected target supports it.
5. In terminal, run a CLI separately if desired; that CLI has its own discovery and permissions.
6. After editing a customization, start a fresh chat/session if the product says it is startup-loaded; otherwise use its reload command or refresh action.
7. Verify via customization list, instruction/context view, skill info, MCP tool list, debug logs, response references, and actual tool activity.
8. Inspect Git diff/status and test outcomes. Do not infer behavior from the file preview.

VS Code Agent Customizations editor and Agent Debug Logs are useful inspection surfaces, but the harness controls what executes. VS Code prompt files continue only in Local (currently deprecated there too); Agent Host does not load them. For new work, use the selected harness’s supported skill/instruction format.

---

# 7. 🏢 Project playbooks: create only what the project needs

## 🆕 Brand-new project

1. Start with a one-page `PROJECT-BRIEF.md` and normal prompt; state goals, constraints, unknowns.
2. Ask for architecture options and tests; do not pretend team conventions exist.
3. After choices are made, add concise project instructions with real commands and decisions.
4. Add one skill only after a workflow repeats.
5. Add MCP only for a real external integration, initially read-only.
6. Add hook/CI gates only after deciding which checks are deterministic and authoritative.
7. Keep agent count small; use one main agent until independent work appears.

## 🔄 Existing / running project

```text
inspect git status + CI + source + tests + docs
→ verify actual conventions
→ identify repeated AI mistake
→ create smallest useful customization
→ test discovery and behavior on representative task
```

Do not overwrite existing instruction files. Review them, preserve local edits, resolve conflicts, and add rules only when supported by current code/team policy.

## 🧱 Maintenance / legacy project

- Start read-only; inspect compatibility tests, release notes, public contract, runtime support, and migration history.
- Add characterization/regression tests before behavioral edits where feasible.
- Use task-specific brief and exact acceptance criteria.
- Give reviewers read-only tools. Require a human to authorize writes with external/production effects.
- Use worktrees for genuinely independent edits; one owner for a shared file or migration.
- Report unavailable databases, credentials, or environments honestly.

---

# 8. 🛠️ Troubleshooting by symptom

| Symptom | Diagnosis order | Repair / proof |
|---|---|---|
| Instruction ignored | Harness → exact filename/path → scope/target → conflicting rules → session age → inspector | Correct one source, fresh session, ask a hidden-fact check; verify behavior |
| Skill missing | Harness → supported root → `SKILL.md` exact case → YAML/name → trigger/invocation → reload | Product-specific skill list/info or VS Code picker; run explicit low-risk task |
| Agent missing | Selected harness → vendor-specific extension/path/schema → visibility/ID → reload → workspace trust | Open agent picker/list, invoke, inspect actual tool set |
| Hook not firing | Event owner/casing → file path → valid schema → startup loaded → event match → command cwd/interpreter | Run script manually; inspect hook logs and exit status; retest in disposable workspace |
| MCP absent | Config file/format → server process → transport → trust → auth → enabled tool list | Check host MCP panel/list, initialize independently, call harmless tool |
| CLI differs from editor | Identify each active harness and host; compare version, cwd, trust, config source | Run one harmless test independently in each; don’t infer one’s behavior from the other |
| Agent claims tests passed | Inspect exact command, cwd, exit status, tool transcript | Run tests yourself; distinguish pass, failure, skipped, and blocked |

### Deliberate fault exercise

Create a disposable copy of a customization and introduce exactly one: wrong filename, invalid frontmatter, stale session, wrong glob, tool-name typo, invalid JSON, unavailable MCP process, or script path error. Capture the first diagnostic, repair only that defect, and repeat. Record which surface proved discovery and which proved runtime behavior.

---

# 9. 🔐 Security operating checklist

- [ ] Least privilege for files, commands, MCP tools, database roles, and service identities.
- [ ] Independent validation and authorization in deterministic code.
- [ ] Sandbox/approval mode appropriate to task risk; network access reviewed.
- [ ] Separate production from development credentials and endpoints.
- [ ] Prompt-injection content (issues, docs, web pages, tool output) treated as untrusted data.
- [ ] Hooks, scripts, skills, MCP servers, extensions, and plugins reviewed/pinned per supply-chain policy.
- [ ] Sensitive input/output excluded or redacted from logs, traces, and recordings.
- [ ] CI, protected branches, code-owner review, and release approvals enforce shared gates.
- [ ] Incident investigations remain read-only until an authorized operator approves remediation.

## Set the runtime boundary before invoking an agent

| Product surface | Practical setup for a read-only investigation | What to verify |
|---|---|---|
| Codex CLI / IDE | In CLI, start with `codex --sandbox read-only --ask-for-approval on-request`; in an interactive session inspect/change `/permissions`. Codex defaults network access off for local CLI/IDE execution. | Ask it to read a file and then attempt a harmless workspace write; verify the write is blocked. Check network settings separately. Custom agent `sandbox_mode` is a default that can be overridden by the parent session’s live permission choice. |
| Claude Code CLI / VS Code integration | Run `/permissions`; choose Manual or Plan for investigation. Deny/ask/allow rules are enforced by Claude Code, separately from prompt wording. Avoid `bypassPermissions` except in an isolated container/VM. | Test a read and a write; inspect permission prompts and rules. The IDE harness/session target must actually be Claude Code. |
| GitHub Copilot CLI | Keep tool approval prompts enabled; inspect tool/command requests before approving. Omit skill `allowed-tools` for shell unless reviewed because it can pre-approve execution. | Attempt a harmless unapproved command and confirm the runtime asks/blocks as configured; check trust state for project MCP. |
| VS Code | Select the intended harness, review its tool picker, and use Workspace Trust for repository content and MCP startup. | Verify actual runtime tool availability and approval behavior; do not assume workspace trust alone sandboxed an external service. |
| Application / CI | Use service identity, authorization checks, branch protection, required CI, and release approval independent of agent setup. | Attempt an unauthorized request and ensure deterministic application/CI policy denies it. |

Sandboxing constrains local process capabilities; approval controls when the product asks; IAM authorizes external resources; CI enforces shared merge/release rules. They are separate layers. Make a harmless blocked-action test in every execution surface because VS Code, CLI, local, and cloud execution can have different policies.

> [!CAUTION]
> “Never do anything dangerous” in a prompt is not a technical security control. A hook is not a substitute for IAM. A read-only label in an agent’s prose is not proof the tools are read-only.

---

# 10. 📚 Official sources checked

These current official pages were consulted on **2026-10-03** for the product-specific claims above. Availability, preview status, and exact UI labels can vary by version/account; follow the linked live reference before rolling out a config.

| Area | Official sources |
|---|---|
| VS Code harness/customizations | [Overview](https://code.visualstudio.com/docs/agent-customization/overview), [instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions), [skills](https://code.visualstudio.com/docs/agent-customization/agent-skills), [agents](https://code.visualstudio.com/docs/agent-customization/custom-agents), [hooks](https://code.visualstudio.com/docs/agent-customization/hooks), [MCP](https://code.visualstudio.com/docs/agent-customization/mcp-servers), [prompt files](https://code.visualstudio.com/docs/agent-customization/prompt-files) |
| GitHub Copilot CLI | [Instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions), [skills](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills), [custom agents](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli), [hooks](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/use-hooks), [MCP](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-mcp-servers) |
| OpenAI Codex | [Skills](https://developers.openai.com/codex/skills), [subagents/custom-agent TOML](https://developers.openai.com/codex/subagents), [sandbox, approvals, network](https://developers.openai.com/codex/agent-approvals-security), [MCP](https://developers.openai.com/codex/mcp), [hooks](https://developers.openai.com/codex/hooks), [config](https://developers.openai.com/codex/config-advanced), [AGENTS.md](https://developers.openai.com/codex/guides/agents-md) |
| Claude Code | [Memory/instructions](https://code.claude.com/docs/en/memory), [skills](https://code.claude.com/docs/en/skills), [subagents](https://code.claude.com/docs/en/sub-agents), [permissions](https://code.claude.com/docs/en/permissions), [hooks](https://code.claude.com/docs/en/hooks), [MCP](https://code.claude.com/docs/en/mcp) |
| Standards and .NET | [Agent Skills](https://agentskills.io/specification), [MCP](https://modelcontextprotocol.io/specification), [.NET AI](https://learn.microsoft.com/dotnet/ai/overview), [.NET MCP server quickstart](https://learn.microsoft.com/dotnet/ai/quickstarts/build-mcp-server), [Microsoft Agent Framework](https://learn.microsoft.com/agent-framework/) |

**What was not verified:** whether any sample config will work unchanged on a particular workstation, account, operating system, organization policy, extension version, model/provider subscription, or private repository. No product CLI configuration was executed as part of this documentation review. The examples are explicitly templates to validate locally, not claimed test results.

---

# 🧭 PRACTICAL RUNBOOK — NEW PROJECT VS EXISTING PROJECT

This runbook applies to both starting a project and opening a repository already in production. It is intentionally procedural: **inspect → choose the smallest mechanism → create it in the correct harness → invoke → observe → verify → repair or remove**.

> [!IMPORTANT]
> VS Code is an editor that can host multiple agent harnesses. Select **Session Target** first. Local, Copilot Agent Host, Copilot CLI, Codex, and Claude Code have different discovery rules, commands, hook formats, and permission controls. Changing the model does not change the harness.

## 1. 🆕 Brand-new project: establish evidence before configuration

### 🎯 Goal / 🧩 Problem

Create a useful baseline before encoding conventions that do not exist yet.

### 📁 First files and manual creation

Create only the project folder and an ordinary, explicitly referenced brief:

```text
MyService/
└── PROJECT-BRIEF.md
```

In VS Code Explorer, open the folder, click **New File**, enter `PROJECT-BRIEF.md`, paste the brief, and save. A terminal user can open a text editor in the project directory. The brief is ordinary documentation; none of these agent products should be assumed to auto-load it.

```md
# Project brief
## User problem and desired result
## Acceptance examples
## Non-goals
## Confirmed technical/business constraints
## Security and data classification
## Decisions still owned by a human
```

🤖 **AI-assisted creation prompt:**

```text
Help me turn these product requirements into PROJECT-BRIEF.md.
Separate confirmed facts, assumptions, non-goals, acceptance examples,
security/data questions, and decisions requiring an owner. Do not invent
company standards, create code, or add agent configuration. Ask only
questions that block a safe first vertical slice.
```

▶️ **Invoke:** In any supported harness, ask: `Read PROJECT-BRIEF.md. Summarize its facts and open decisions. Propose two small architecture options and a vertical slice. Do not create files yet.`
✅ **Expected:** a reviewable proposal with assumptions labeled.
🔍 **Verify:** compare each assertion with the brief and approved standards.

### Add configuration only after the first work

1. A human selects stack/architecture/security decisions.
2. Scaffold with the framework's official generator.
3. Discover actual README/build/test/CI commands and run a vertical slice.
4. Record only stable, verified rules in the selected harness's project instruction format.
5. Wait for a repeated procedure before making a skill; a recurring role before a custom agent; an external-system need before MCP.
6. A hook is only for deterministic lifecycle automation; required team gates belong in CI too.
7. Use a normal prompt for one task. A reusable prompt or skill is not a day-one prerequisite.

### Six product routes — new project

| Surface | Select / start | First durable customization, only if evidence supports it |
|---|---|---|
| VS Code + Copilot | Open folder → select **Copilot** Session Target → Ask/Plan before edits; Agent after scope is approved. | `.github/copilot-instructions.md` for stable shared project facts. Skills/agents/hooks/MCP are separate, later decisions. |
| Copilot CLI | `cd` to trusted repository root → `copilot` → `/instructions` → ask for proposal and explicitly reference `PROJECT-BRIEF.md`. | `.github/copilot-instructions.md`; inspect with `/instructions`. |
| Codex CLI | `cd` to project root → `codex` → explicitly name `PROJECT-BRIEF.md`; start read-only/plan-first when available. | `AGENTS.md`; loaded when a run starts. |
| Codex IDE / VS Code | Open the repository and Codex panel, select **Codex** Session Target, sign in; inspect the project before editing. | Same Codex `AGENTS.md`, `.agents/skills`, `.codex/agents/*.toml`, hooks and MCP as the Codex host. |
| Claude Code CLI | `cd` to root → `claude` → `/context` → explicitly name brief. | `CLAUDE.md`/`.claude/CLAUDE.md`; use `/context` to verify. |
| Claude Code in VS Code | Install the Claude Code extension, open its panel, sign in, choose Manual/Plan for first work, attach/name brief. | Same Claude project files and settings. The extension has its own CLI runtime; its built-in panel is not the VS Code Local agent. |

### 🚫 Do not configure on day one

Do not create global instructions from a project decision; a prompt file for a one-time task; a skill for one occurrence; a custom agent without a recurring role; parallel agents for dependent architecture choices; hooks as a substitute for permission controls; MCP when native tools suffice; broad write/shell/network permissions; production credentials; or RAG for a handful of files already available in the workspace.

### 💣 Break-it / repair / checkpoint

Ask the model to “follow our standard API layout” before any standard exists. A correct response labels an assumption and requests the decision; it does not state invented rules as facts. If generated files contain an invented convention, remove or fix them and rerun the exercise. Ask it to run tests before a test project exists; it must report the missing command rather than claim a pass.

🏢 Company: require architecture/security owner approval.
🔄 Existing project: use the next scenario instead.
🧱 Legacy: do not scaffold over existing behavior; characterize it.
🏋️ Challenge: deliver a passing vertical slice with no skill, agent, hook, or MCP.
🎓 Checkpoint: identify the human decisions and the evidence supporting each permanent rule.

## 2. 🔄 Existing / ongoing project: repository and branch first

### 🎯 Goal / 🧩 Problem

Use existing team configuration and protect work already in progress. Avoid duplicate instructions, tools, or hook behavior.

### Exact inspection sequence

1. Confirm repo root, current branch, ticket/PR, and `git status --short`. Do not discard or overwrite unrelated changes.
2. Read README, architecture docs, relevant source/tests, manifests, scripts, CI and release/runbook files.
3. Inventory existing project and nested instructions, skills, agents, hooks, MCP configs, and local/personal settings where accessible.
4. Ask the active harness which instructions/customizations it actually discovered; inspect UI/logs as well.
5. Compare the ticket to observed behavior and acceptance criteria. Keep facts separate from hypotheses.
6. Reuse a valid existing customization. Edit/remove stale or contradictory files; do not create a second copy to work around discovery failure.
7. Select normal prompt, task brief, instruction, prompt file/skill, agent, subagent, parallel agents, hook, MCP, deterministic code, or CI using the decision tree below.
8. Before editing, state ownership/scope and forbidden external side effects. After editing inspect full diff, actual tool activity, and tests.

```text
git status --short
git branch --show-current
```

🤖 **Read-only inventory request:**

```text
Before editing, inspect this repository and current task. Cite paths for:
Git root/branch/working tree; issue acceptance criteria; instructions,
skills, agents, hooks and MCP config; build/test/lint commands and CI;
relevant source and tests. Separate facts from inference. Do not create
configuration, change files, run migrations, access production, or perform
external mutations. Report unknowns and the smallest appropriate next step.
```

✅ **Expected:** evidence-backed inventory and bounded task proposal.
🔍 **Verify:** open referenced files, compare commands with CI, verify current branch/status, then check the active runtime's discovery view.

### Branch playbook

| Branch/work context | How to begin | Safe AI role | Required completion check |
|---|---|---|---|
| `main` / `develop` | Confirm whether changes are prohibited; inspect status, protection and CI. | Read-only repository explanation, release status, or diff review. | No edits unless policy explicitly permits them; CI/branch rules remain decisive. |
| Feature branch | Confirm ticket, base branch, acceptance criteria, in-flight changes and ownership. | Plan, then scoped implementation; reuse a proven skill. | Focused tests, relevant broader checks, compatibility and full diff. |
| Bug branch | Capture expected/actual, reproduce and trace before root-cause claim. | Read-only investigation first; test-first implementation only after cause is evidenced. | Repro or test fails for the actual symptom, then passes after fix; no fabricated output. |
| Hotfix branch | Confirm incident lead, target branch, authorized scope, mitigation and rollback. | Narrow investigation; no parallel write or speculative cleanup. | Emergency tests and backport/merge checks; human operator controls production action. |
| Maintenance / legacy | Discover supported versions, callers, release history, characterization tests and hidden contracts. | Risk and impact review; isolated minimal patch only when authorized. | Compatibility tests, code-owner review, migration/rollback notes as needed. |
| Release branch | Read freeze, signing, version, changelog, artifact and deployment rules. | Checklist/notes/review; never autonomous publish or deployment. | CI/artifact verification and explicit release-owner approval. |
| Security-sensitive branch | Write scope, authorization, exclusions, data rules, allowed tools, evidence format and approval point. | Default to read-only; treat repository/ticket/log text as untrusted data. | Reproduce findings; verify no prohibited access/effects; IAM/sandbox/CI enforce real boundaries. |

### Mechanism decision card

| Situation | Start with | Only add when justified |
|---|---|---|
| One task-specific fact | Normal prompt or brief | Never permanent instructions for ticket-only requirements |
| Stable rule repeated across tasks | Project instruction | Path-specific file if truly scoped |
| Saved task initiated on demand | A normal prompt/task brief | Product-specific prompt file only if selected harness supports it |
| Repeated procedure / checklist | A skill | Script/CI for deterministic steps |
| Recurring specialist role / different tools | A custom agent | Real runtime/tool permissions; description is not enforcement |
| Separate bounded question | One subagent | Parallel agents only when independent, with a coordinator |
| Mandatory action at a lifecycle point | Product-specific hook | CI for an authoritative shared gate |
| External data/action not in native tools | MCP after security review | Least-privilege account, limited tools, approval and audit |
| Exact business rules/security decision | Normal code/tests/IAM | Model may assist with language interpretation; it never authorizes |

## 3. Product-specific behavior and configuration traps

These are the current official-document-backed distinctions. Link targets are checked in the **Official docs checked** table at the end.

### Instructions and custom prompts

| Harness | Stable project instructions | Reusable prompt/task behavior |
|---|---|---|
| VS Code Copilot Agent Host | `.github/copilot-instructions.md`; scoped `.github/instructions/*.instructions.md` with `applyTo`; root `AGENTS.md` where supported. | `.prompt.md` files are deprecated and **not loaded by Agent Host**. Use a skill for a reusable Agent Host workflow. |
| VS Code Local | VS Code's instruction formats/settings; `AGENTS.md` support depends on Local settings. | `.github/prompts/*.prompt.md` is a Local feature for manually invoked `/prompt`; migration to skills is available. |
| Copilot CLI | Root/nested `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, modular instructions and user files; `/instructions` inspects discovery. No general precedence order across all source types. | Normal prompt/task brief first; skill for reusable procedures. CLI does not use the VS Code prompt-file system. |
| Codex CLI/IDE | `AGENTS.md`; project instructions built on run start; `AGENTS.override.md` may replace same-scope file. | Normal prompt/task brief or skill (`$skill` / `/skills`). Do not assume a VS Code prompt file is a Codex command. |
| Claude Code CLI/VS Code | `CLAUDE.md` / `.claude/CLAUDE.md`, `.claude/rules/`; `/context`; `AGENTS.md` supported as described by current Claude docs. | Normal prompt/task brief or skill; older `.claude/commands/*.md` still work, but skills are preferred for new reusable procedures. |

Manual instruction creation: inspect existing facts first; create only the selected harness's file; record one real command/rule; start/reload a session as required; ask it to state the rule and point to its source; try a harmless representative task. If it is one task only, keep it in the prompt/brief.

### Skills: `SKILL.md` is a shared shape, not a universal tool grant

All skill examples must keep the required `name` and `description` aligned with the folder. A skill is a directory with `SKILL.md`; scripts/resources are optional and must be reviewed.

| Runtime | Typical project path | Invocation / reload | Tool semantics that must not be copied to another product |
|---|---|---|---|
| VS Code Copilot / Copilot CLI | `.github/skills/<name>/SKILL.md`; also compatible locations documented by Copilot | Prompt `/name`; CLI `/skills list`, `/skills info NAME`, `/skills reload` or restart. VS Code skill UI/References verifies discovery. | Copilot skill frontmatter `allowed-tools` pre-approves listed tools (not a sandbox). Omit it unless execution is intentionally pre-approved. |
| Codex CLI / IDE | `.agents/skills/<name>/SKILL.md` | `$name` or `/skills`; Codex detects changes, restart if it does not. | `agents/openai.yaml` is optional UI metadata, invocation policy and declared tool dependencies (for example MCP); it is not the runtime permission allowlist. Actual MCP, sandbox and approval config governs access. |
| Claude Code CLI / VS Code | `.claude/skills/<name>/SKILL.md` | `/name` or relevance; `/skills` lists. New folder-discovery/reload behavior depends on where the skill was added; restart when not discovered. | Claude-specific skill invocation/tool controls differ from Copilot. Do not transplant `allowed-tools`/`disallowed-tools` as if they had shared meanings or as if prose replaces permissions. |

**Open standard:** the Agent Skills spec calls `allowed-tools` experimental and warns support varies. Product extensions and limits take precedence in product workflows. Do not put Codex `dependencies.tools` or Claude-specific frontmatter into a purportedly portable skill and call it universal.

**Safe sample skill (instruction-only):**

```text
.github/skills/bug-investigation/SKILL.md
```

```md
---
name: bug-investigation
description: Investigate a reproducible application bug with evidence and a regression test. Use for a bug ticket; do not use for release or deployment tasks.
---

1. Read the ticket and the existing project instructions.
2. Preserve the working tree; reproduce the symptom using the documented test setup.
3. Trace the actual call path and label facts, hypotheses, and unknowns.
4. Propose the smallest regression test and wait for approval before editing.
5. Implement only when authorized; report the actual commands and results.
```

📁 **Manual:** create the selected product's skill directory and exact `SKILL.md` filename; paste this example; save; validate YAML/name; restart/reload per product.
🤖 **AI-assisted:** “Inspect current issue and project guidance. Propose a `<product>` skill under its documented path. Explain every frontmatter field and whether it changes permissions. Do not write it until I approve.”
▶️ **Invoke:** run a disposable/local ticket and explicitly request `Use the bug-investigation skill...`; in Claude `/bug-investigation`, Codex `$bug-investigation` or `/skills`, Copilot `/bug-investigation`.
✅ **Expected:** the workflow is followed, but no claim of actual test success without execution.
🔍 **Verify:** inspect References/tool activity, the actual files changed, and actual test exit/result.
💣 **Break it:** misspell folder or frontmatter name, test discovery, repair, reload and repeat.
🛠️ **Troubleshoot:** exact filename, valid YAML, name/description, location, duplicate names, selected harness, invocation syntax and reload.
🏢 Company: include approved internal steps, not secrets. 🆕 New project: wait until repeated. 🔄 Existing project: audit for duplicate skills. 🧱 Legacy: add characterization/compatibility steps. 🚫 Do not use for a one-off ticket or permission boundary. 🏋️ Challenge: run it on two tickets and remove steps that are not repeatable. 🎓 Checkpoint: explain why its metadata is product-specific.

### Custom agents and subagents: roles, tool surfaces, and parallelism

| Runtime | Exact definition form | Discovery / invocation | Important boundary |
|---|---|---|---|
| VS Code Local/Copilot | `.github/agents/<name>.agent.md` YAML + Markdown instructions. `tools` is the selected harness's tool/toolset list; VS Code custom-agent files may be used by more than one harness but tools differ. | Agent Customizations editor; select Session Target, then Agent dropdown. | Tool selection is a runtime capability choice, not OS sandbox/IAM. The active harness may not support every tool name. |
| Copilot CLI | `.github/agents/<name>.agent.md` or `~/.copilot/agents/<name>.agent.md`. | `/agent`, explicit instruction, inference, or `copilot --agent ID --prompt ...`; restart after creating/editing. | CLI custom-agent subagents do not inherit repository instructions by default; `include-custom-instructions: true` is CLI-specific and can be disabled by `--no-custom-instructions`. |
| Codex CLI/IDE | `.codex/agents/<name>.toml` project or `~/.codex/agents/<name>.toml` user. Required `name`, `description`, `developer_instructions`. | Ask Codex to delegate to the named agent; `/agent` in CLI or IDE agent activity inspects threads. | Custom agent's `sandbox_mode` can be overridden by parent live runtime permissions; subagents inherit parent sandbox/approval. |
| Claude Code CLI/VS Code | `.claude/agents/<name>.md` or `~/.claude/agents/<name>.md`; Markdown body plus frontmatter such as `name`, `description`, `tools`. | Ask Claude to delegate to the agent name; inspect transcript/delegation. | Subagent has a distinct context and tool access. Explore/Plan are read-only and skip CLAUDE.md; verify inheritance for the chosen type. |

**Copilot CLI read-only role example:**

```md
---
name: api-reviewer
description: Reviews an API diff for compatibility, authorization, and test gaps. Use after a proposed API change; do not implement fixes.
tools: ["read", "search"]
include-custom-instructions: true
---
Review only the supplied diff and relevant source. Return evidence, file
locations, triggering conditions, impact, and uncertainty. Do not edit.
```

**Codex TOML role example:**

```toml
name = "api_reviewer"
description = "Read-only API compatibility and authorization reviewer."
sandbox_mode = "read-only"
developer_instructions = """
Review the supplied diff and relevant callers/tests. Return only evidence-
supported findings with file references and impact. Do not edit.
"""
```

**Claude Code subagent example:**

```md
---
name: api-reviewer
description: Read-only review of API contract and authorization changes.
tools: Read, Grep, Glob
---
Review the supplied diff and relevant callers/tests. Do not edit. Cite evidence.
```

📁 **Manual:** create the correct path/file for one selected tool; use only that product's metadata; save, reopen the active harness, and confirm the role appears/is delegated.
🤖 **AI-assisted:** ask it to propose (not install) a read-only agent, list its tools, prove the names are valid for the selected runtime, and show which real sandbox/approval controls still apply.
▶️ **Invoke:** hand it one bounded review/investigation.
✅ **Expected:** separate findings/report without unauthorized edits.
🔍 **Verify:** inspect agent transcript and complete `git diff`; run a harmless blocked-write test only in a disposable repository.
💣 **Break it:** add an invalid tool name or omit needed context; observe discovery/failure, repair and retest.
🛠️ **Troubleshoot:** wrong extension/path, duplicate ID/name, stale CLI, unsupported tools, missing repo instructions, parent sandbox policy, untrusted project config.
🏢 Company: delegate independent security/test/contract reviews. 🆕 New project: don't split unsettled architecture. 🔄 Existing project: parallelize read-only maps if large. 🧱 Legacy: one owner per mutable module. 🚫 No parallel writers on same files, migrations, releases, production or shared external state. 🏋️ Challenge: two read-only workers analyze distinct evidence and one coordinator reconciles. 🎓 Checkpoint: verify independent evidence, not majority vote.

### Hooks: current implementations are harness-specific

First justify the event: if the task repeats but does not need deterministic event timing, use a skill or script; if the gate must be authoritative for the team, use CI/policy. Hooks execute code and can have side effects. Test harmlessly and inspect trust/permissions.

| Harness | Format and path | Events / test requirements |
|---|---|---|
| VS Code Local | `.github/hooks/*.json`, PascalCase event names, `command`/`windows`/`timeout`; optional user hooks in `~/.copilot/hooks/`. | Local events include `SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PreCompact`, `SubagentStart`, `SubagentStop`, `Stop`. Selected Session Target changes implementation. |
| VS Code Agent Host + Copilot | Copilot SDK hook implementation, compatible with Copilot CLI; `.github/hooks/*.json` where supported by selected version. | Use GitHub Copilot hook event names/payloads; VS Code preview support can differ from CLI. Do not reuse Local event/payload syntax as proof. |
| Copilot CLI | `.github/hooks/*.json`; JSON top level `version: 1`, `hooks` keys in lower camel case. | Current documented events include `sessionStart`, `sessionEnd`, `userPromptSubmitted`, `preToolUse`, `postToolUse`, `errorOccurred`, and `agentStop`; verify reference for exact event/surface. Config loads when CLI starts. |
| Codex | `~/.codex/hooks.json`, `~/.codex/config.toml`, `<repo>/.codex/hooks.json` or `.codex/config.toml`. | Event → matcher group → handler; command hooks need review/trust via `/hooks`. Project hooks require trusted project. |
| Claude Code | `.claude/settings.json`, `.claude/settings.local.json`, or user-level settings. | Event → matcher → handler; e.g. `PreToolUse`, `PostToolUse`, `SessionStart`, `Stop`, `SessionEnd`. Inspect `/hooks`. |

**Copilot CLI harmless Windows session-start example:**

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "powershell": "Add-Content -Path .github/hooks/session.log -Value 'session started'",
        "cwd": ".",
        "timeoutSec": 10
      }
    ]
  }
}
```

Use both `bash` and `powershell` when a shared hook is intended for all OSes. Do not log prompts, credentials, or customer data. Start/restart CLI, invoke a harmless session, verify the log, then deliberately break the path and confirm troubleshooting catches it. Remove the test hook/log after the exercise.

**VS Code Local harmless tool-audit example** (not Copilot CLI JSON and not a general Agent Host hook):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "command": "node .github/hooks/log-tool-use.cjs",
        "timeout": 15
      }
    ]
  }
}
```

VS Code's published Local example reads the JSON event on stdin and logs `event.tool_name`. Local hook payloads and output decisions are different from Copilot CLI's. For Claude and Codex use their own config/event/matcher formats, exact official references, and product hook browser.

📁 **Manual:** create a disposable repository hook file only after choosing the harness/event; use a harmless log-only script; exclude the log from Git if appropriate.
🤖 **AI-assisted:** ask for the selected harness's supported event list, exact schema and harmless dry-run test; prohibit writes until approved.
▶️ **Invoke:** trigger the event once; verify via product hook UI/log and observable test file.
💣 **Break it:** invalid JSON, unsupported event, bad script path, and timeout; diagnose each without treating a missing hook as success.
🏢 Company: prefer centrally enforced controls for security gates. 🆕 New project: no hook before a repeated event need. 🔄 Existing: inspect all merged scopes and existing scripts. 🧱 Legacy: use hooks only if scripts are supported and won't mutate data. 🚫 Do not use hooks as IAM, approval, sandbox, or CI replacement. 🏋️ Challenge: compare Copilot CLI and VS Code Local configurations and identify why one cannot simply be pasted into the other. 🎓 Checkpoint: show hook event, execution, output, and non-execution of prohibited effects.

### MCP: add only a real missing integration

🎯 **Goal:** avoid repeatedly copying data from an authorized external system.
🧩 **Problem:** native tools cannot access the system; avoid MCP if built-in tools or a file already suffice.
🧠 **Flow:**

```text
Agent harness → MCP client → approved server → scoped identity → external system
```

**Portable VS Code/Copilot example:** VS Code recommends root `.mcp.json` with top-level `mcpServers`; Copilot CLI can read `.mcp.json` or `.github/mcp.json`. A VS Code-specific `.vscode/mcp.json` uses `servers`, but Copilot CLI explicitly does not read that file.

```json
{
  "mcpServers": {
    "docs-readonly": {
      "type": "http",
      "url": "https://approved.example.com/mcp",
      "tools": ["search_docs"]
    }
  }
}
```

The URL and server/tool names above are placeholders, not a working public endpoint. Never add a real secret to committed config.

| Product | Add/configure | Discovery / invocation |
|---|---|---|
| VS Code | **MCP: Add Server** and prefer `.mcp.json` for portable workspace config; `.vscode/mcp.json` has its own `servers` schema. | Trust reviewed server; inspect tools and toggle allowlist; ask a harmless read-only query. |
| Copilot CLI | `/mcp add` or `copilot mcp add NAME -- COMMAND [ARGS]`; project config `.mcp.json`/`.github/mcp.json`; user `~/.copilot/mcp-config.json`. | Project server loads after folder trust; `/mcp`, `/mcp show NAME`; CLI reads `.mcp.json`, not `.vscode/mcp.json`. |
| Codex | `[mcp_servers.<name>]` in `~/.codex/config.toml` or trusted project `.codex/config.toml`; `codex mcp add NAME -- COMMAND [ARGS]`. | `codex mcp list`, TUI `/mcp`; IDE shares MCP config for the same Codex host. |
| Claude Code | `claude mcp add --transport http NAME URL` or `claude mcp add [options] NAME -- COMMAND [ARGS]`; project `.mcp.json` uses Claude schema. | `claude mcp list`; use `/mcp` or ask a harmless query; verify permissions/scope. |

**End-to-end verification:** 1) review publisher/source/version/permissions; 2) use a read-only test identity and narrow server tools; 3) configure selected product; 4) verify server appears and only intended tools are available; 5) call one harmless query; 6) inspect tool activity and data returned; 7) test expected denial on an excluded resource; 8) remove test config and rotate any exposed credential.
🤖 AI-assisted creation: have AI draft a placeholder config with no secrets, then compare every key against that product's docs.
💣 Break it: wrong transport/key/tool; verify server fails clearly, repair and retest.
🏢 Company: review data residency, IAM, audit and supply chain. 🆕 New project: no MCP by default. 🔄 Existing: reuse approved integration. 🧱 Legacy: use read-only first; no production mutation. 🚫 Do not connect broad admin tools for convenience. 🏋️ Challenge: prove one allowed query and one denied query. 🎓 Checkpoint: identify which identity and sandbox actually constrain the server.

## 4. Permissions, sandbox, IAM, CI — separate controls

| Control | What it governs | Does not mean |
|---|---|---|
| Instructions / prompts | Behavioral guidance | Enforcement of forbidden actions |
| Agent `tools` selection | Tools exposed to a role/harness | Host OS containment or external IAM |
| Product approval | When runtime pauses for confirmation | Permission of the selected external identity |
| Sandbox | Filesystem/process/network limits for a runtime | Application authorization or branch protection |
| IAM / service identity | Access to cloud/data/API resources | Correct generated code |
| CI / branch rules / code owners | Shared validation and merge/release gates | Local agent sandboxing |
| Hook | Deterministic local/product lifecycle behavior | Reliable organizational audit or complete access control |

For each task, identify the execution host, user/service identity, network boundary, writable paths, approvals and CI gate. Test one harmless allowed and one denied action in a disposable environment. Codex's subagents inherit parent sandbox/approval; VS Code worktree isolation is not itself a security boundary; Copilot and Claude have their own tool/permission behavior. Never infer safety from a “read-only” label or a prompt.

## 5. 🔄 Same workflow in all six surfaces

| Surface | New project day | Existing project day |
|---|---|---|
| VS Code + Copilot | Open folder, select Copilot target, brief → Ask/Plan → human architecture choice → baseline → stable rules later. | Select correct target, inspect Git/config/CI/ticket, inspect Customizations/References, reuse existing rules, then scoped task and diff/test. |
| Copilot CLI | Launch at trusted root; `/instructions`; normal prompt naming brief; scaffold only after approval. | `/instructions`, `/skills list`, `/agent`, `/mcp`; audit `.github/hooks` and MCP files; `/new`/restart when docs require; inspect tool activity. |
| Codex CLI | Start at root; reference brief; plan/read-only first; use `AGENTS.md` only after decisions. | Read `AGENTS.md` and overrides; inspect `/skills`, `/agent`, `/hooks`, `/mcp`; preserve parent sandbox; report verified test results. |
| Codex IDE/VS Code | Open Codex panel/target; same brief-first workflow; Codex owns config and approval settings. | Audit same Codex config as CLI; use IDE activity for subagents and review actual diff in editor; do not confuse local VS Code settings with Codex. |
| Claude Code CLI | Start from project root; `/context`; brief first, then confirmed rules in `CLAUDE.md`. | `/context`, `/hooks`, `/skills`; inspect `.claude`/MCP config; choose Manual/Plan; inspect transcript and diff. |
| Claude Code VS Code | Open Claude Code extension panel; attach/name brief; use Plan/Manual for first implementation. | Inspect same Claude instructions/skills/hooks/MCP; check active permission mode, inline diff and actual tools; extension CLI is not the Local harness. |

For a brand-new and an existing project, the resulting artifacts must remain distinct: project brief/task facts stay temporary; stable project rules stay in instructions; repeatable workflows stay in skills; specialist tool configuration stays in agents; external capabilities stay in MCP; deterministic lifecycle work stays in hooks/CI.

## 6. Practical audit and removal test

For every customization added, keep a one-line purpose, owner, scope, source-of-truth, verification task, reload/discovery procedure, and removal path. After one or two representative uses ask:

```text
Did this customization prevent a repeated problem? Did it duplicate docs,
contradict another rule, add unnecessary tools, or create noise? If so,
propose the smallest edit or removal. Do not change files until approved.
```

Check it into version control only if it is genuinely team-owned. Remove unused duplicates and re-run discovery. A successful configuration check means only that the runtime found it—not that it behaved safely or produced correct code.

## 7. Official references checked for this runbook

- [VS Code harnesses](https://code.visualstudio.com/docs/agents/run/agent-harnesses), [customization overview](https://code.visualstudio.com/docs/agent-customization/overview), [custom instructions](https://code.visualstudio.com/docs/agent-customization/custom-instructions), [prompt files](https://code.visualstudio.com/docs/agent-customization/prompt-files), [skills](https://code.visualstudio.com/docs/agent-customization/agent-skills), [custom agents](https://code.visualstudio.com/docs/agent-customization/custom-agents), [hooks](https://code.visualstudio.com/docs/agent-customization/hooks), [MCP](https://code.visualstudio.com/docs/agent-customization/mcp-servers).
- [Copilot CLI instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions), [skills](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills), [agents](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli), [hooks](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/use-hooks), [hook reference](https://docs.github.com/en/copilot/reference/hooks-reference), [MCP](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-mcp-servers).
- [Codex skills](https://developers.openai.com/codex/skills), [AGENTS.md](https://developers.openai.com/codex/agent-configuration/agents-md), [subagents/custom agents](https://developers.openai.com/codex/agent-configuration/subagents), [MCP](https://developers.openai.com/codex/mcp), [hooks](https://developers.openai.com/codex/hooks), [sandbox and approvals](https://developers.openai.com/codex/agent-approvals-security), [IDE](https://developers.openai.com/codex/ide).
- [Claude Code memory/instructions](https://code.claude.com/docs/en/memory), [skills](https://code.claude.com/docs/en/skills), [subagents](https://code.claude.com/docs/en/sub-agents), [hooks guide](https://code.claude.com/docs/en/hooks-guide), [hooks reference](https://code.claude.com/docs/en/hooks), [MCP](https://code.claude.com/docs/en/mcp), [VS Code](https://code.claude.com/docs/en/vs-code).
- [Agent Skills specification](https://agentskills.io/specification), [MCP specification](https://modelcontextprotocol.io/specification).

**Verification boundary:** documentation pages and configuration distinctions were checked. These examples were not executed in Copilot, Codex, Claude Code, or a specific VS Code version; availability can vary by version, OS, account, organization policy, extension, and workspace trust. No test/build/product command is claimed to have run.
