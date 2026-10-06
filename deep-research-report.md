# 📙 AI Coding-Agent Configuration Handbook

**🏷️ Difficulty:** 🟡 Intermediate (reference/runbook — no coding prerequisite, but assumes Git fluency)

> **The operational manual:** choose the harness, create the exact artifact, discover it, invoke it, inspect what happened, break it, and repair it.
>
> This is not a universal configuration guide. VS Code is an editor and can host different harnesses. **The selected product/harness owns the schema and runtime.** Copy only the block for the tool you actually use.

**Checked against official vendor documentation:** 2026-10-03.
**Execution status:** commands and config examples below are documentation-checked teaching examples; they were not run against your machine or account. Test non-destructive examples in a disposable repository first.

<a id="choose-product"></a>

## Start here: choose one product

This handbook configures **the assistant that helps you work on a repository**. It does not build your application's AI runtime. Choose your product below and finish one ordinary read-only task before adding customizations. A *harness* is the product runtime that loads instructions and controls tools; VS Code is the editor, and a model name is not the harness.

- [Copilot CLI or Copilot in VS Code](#route-copilot)
- [Codex CLI or Codex IDE extension](#route-codex)
- [Claude Code CLI or its VS Code extension](#route-claude)

**Common prerequisites:** an approved account/access for your chosen product, its installed CLI or extension, a trusted test repository, and permission to inspect that repository. Use the chosen product's official installation instructions; do not install all three. CLI commands run in PowerShell/your terminal; slash commands run inside that CLI's interactive chat; “Chat: …” and “MCP: …” run in the editor's Command Palette.

**First success:** ask for the real build/test commands and verify its file citations against README/CI. No skill, agent, hook, MCP server, global template, or provider key is required merely to request that explanation. Account and organization restrictions may still apply.

The sections below the routes are a **lookup reference**. Follow only the link for the artifact you need. Configuration examples inherit the product, path, and scope named in their subsection; placeholders must be replaced with your verified paths. They are documentation examples, not runtime-tested configurations. No exact installed CLI/extension version was tested in this review.

<a id="route-copilot"></a>

### Copilot route

1. Use [GitHub's Copilot CLI documentation](https://docs.github.com/en/copilot/concepts/agents/about-copilot-cli) or the installed Copilot extension's setup. In VS Code, identify the selected session harness using [Choose an agent harness](https://code.visualstudio.com/docs/agents/run/agent-harnesses); Local and Agent Host differ.
2. Open the correct repository. In a CLI terminal, start `copilot`; in VS Code, use the Copilot session. Ask: “Inspect README and CI read-only. Cite the build/test commands. Do not change files.” Verify the cited files yourself.
3. Reuse existing project instructions. If a stable rule is missing, create **only** `.github/copilot-instructions.md` at the project root; [instructions](#handbook-instructions) provides the content and discovery exercise. In CLI use `/instructions`; in VS Code inspect References/Customizations.
4. For a repeated procedure, use [skills](#handbook-skills). CLI `/skills reload`, `/skills info NAME`, then `/NAME` in a prompt are separate from starting a custom agent. For a recurring reviewer, use [agents](#handbook-agents); restart CLI and select `/agent`.
5. Use [hooks](#handbook-hooks) only for needed lifecycle automation; CLI config reloads at startup. Use [MCP](#handbook-mcp) only for a missing approved integration. Confirm tools, permissions, activity, and `git status` after the harmless test.
6. If a file is absent, check exact path/schema and selected harness before creating a duplicate. Remove a test customization only if you created it, then repeat discovery and verify that it is gone.

For new Agent Host workflows use supported skills; keep `.prompt.md` migration in the [legacy prompt-file reference](#handbook-prompts). Prompt files still work in Local but are not loaded by Agent Host, according to [VS Code's prompt-file documentation](https://code.visualstudio.com/docs/agent-customization/prompt-files).

<a id="route-codex"></a>

### Codex route

1. Install/enable only the approved [Codex CLI](https://learn.chatgpt.com/docs/codex-cli) or [IDE extension](https://learn.chatgpt.com/docs/codex-ide). Sign in through its supported flow. Open the repository in that product; an unrelated Copilot session does not verify Codex configuration.
2. Ask the same read-only README/CI question. Verify the citations and active permission mode. If launching a CLI, run `codex` from the intended repository directory.
3. Reuse the actual instruction chain. Add a short root `AGENTS.md` only for stable rules that are missing. Same-directory `AGENTS.override.md` takes precedence; restart for a new instruction chain. See [instructions](#handbook-instructions) and [official AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md).
4. For a repeated procedure, use `.agents/skills/NAME/SKILL.md`; invoke `$NAME` or select a skill. For a specialist, use `.codex/agents/NAME.toml`; verify the required fields and child activity in [agents](#handbook-agents).
5. Use [hooks](#handbook-hooks) or [MCP](#handbook-mcp) only when needed. Review project hook trust and actual permissions; parent live sandbox/approval choices can override agent-file defaults. Inspect actual tool calls and Git state.
6. Diagnose discovery in this order: intended working directory → exact path → metadata → trust → restart/refresh → runtime transcript. Remove only your disposable test artifact and prove it no longer applies.

Optional `agents/openai.yaml` describes skill UI/invocation metadata and dependencies; it is not a permission allowlist. Skills are discovered under repository `.agents/skills`; see [official skills guidance](https://learn.chatgpt.com/docs/build-skills). Do not copy Copilot or Claude tool-grant fields into Codex metadata.

<a id="route-claude"></a>

### Claude Code route

1. Use the approved [Claude Code setup](https://code.claude.com/docs/en/setup) or its official VS Code extension. Open a test repository and choose an appropriate permission mode. A Claude model inside Copilot is a different product runtime.
2. Start `claude` in the repository, or use the Claude Code extension panel. Ask the read-only README/CI question and inspect `/context`, citations, and tool activity.
3. Reuse `CLAUDE.md` and applicable `.claude/rules/`. Add a stable project instruction only when needed; [instructions](#handbook-instructions) gives the discovery exercise.
4. Put repeated procedures in `.claude/skills/NAME/SKILL.md`; invoke `/NAME`. Put a recurring reviewer in `.claude/agents/NAME.md`; ask Claude to delegate to it. Use only Claude's actual tool names. See [skills](#handbook-skills) and [agents](#handbook-agents).
5. For hooks use Claude settings/event/matcher schemas; for MCP use Claude's documented scope/transport. Run only a harmless approved representative task and inspect the transcript and full diff.
6. If missing, check location/name/frontmatter/context and restart when discovery needs it. Remove only a test artifact you created; verify discovery and activity again.

Claude skill tool grants can be affected by managed permission policy. Built-in Explore/Plan skip CLAUDE.md; other built-in/custom subagents load it unless a supported `omitClaudeMd` configuration excludes it. These are product-specific distinctions: [Claude skills](https://code.claude.com/docs/en/skills), [Claude subagents](https://code.claude.com/docs/en/sub-agents).

### Route completion checkpoint

Stop after completing **one** chosen-product route when all of the following
are true:

- you used the product in the intended repository;
- it answered the README/CI question without editing files;
- you verified its cited files and its active permission mode; and
- you know where that product exposes its instructions or context.

That is a complete first success. Do not read or configure skills, custom
agents, hooks, or MCP merely to finish this handbook. Return to the reference
sections only when a repeated, evidenced need requires one of those artifacts.

**Next:** apply your chosen route to the [existing-project workbook](end_to_end_ai_agent_graphql_workflow.md#existing-project), or read [the decision card](#handbook-decisions) when a repeated problem requires a customization.

---

## Identify your actual harness (reference)

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

<a id="handbook-decisions"></a>

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

### 🏋️ Exercise: pick an artifact, then build the smallest one

For each scenario, write one sentence naming the artifact type (prompt file, task brief, skill, custom agent, or hook) and why:

1. A teammate filed one ticket asking why `GetVehicleById` returns null for a specific ID.
2. Three different reviewers keep forgetting to check nullability and cancellation before approving a GraphQL resolver change.
3. Every session start should silently append a timestamp to a local audit log.

Expected reasoning: (1) is one-off acceptance criteria → task brief, not an always-on rule. (2) is a repeated, evidenced procedure → skill (or a scoped `applyTo` instruction if it is a pure rule rather than a sequence of steps). (3) is a deterministic lifecycle action → hook, not an instruction that merely asks politely.

Now build the smallest real artifact for scenario 1: create `docs/tasks/ABC-100.md` using the task-brief template in §2.1 (just below), with real goal/acceptance-criteria text for a null-return bug in your own repo. Confirm the file exists with `Get-Item docs\tasks\ABC-100.md`. You have completed the exercise when the file exists on disk and you can state, in one sentence, why the other two scenarios would have produced a different artifact.

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

<a id="handbook-instructions"></a>

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

<a id="handbook-prompts"></a>

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

<a id="handbook-skills"></a>

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

### 🏋️ Section exercise: one real task brief + one real skill

Using your own project (not a toy example) and your chosen harness from the [product route](#choose-product):

1. Identify one real, currently-open issue or recurring friction in that project. Create an actual `docs/tasks/<ID>.md` task brief for it, following §2.1's template above with real goal/acceptance-criteria text.
2. Identify one procedure you have done at least twice in that project (e.g., diagnosing a failed build, reviewing a migration, triaging a flaky test). Create an actual `SKILL.md` for it in your harness's supported path from the [table above](#handbook-skills), following the "Create and use, step by step" sequence.
3. Verify discovery for both: reference the task brief in a prompt and confirm the assistant restates its acceptance criteria; reload/restart as required and confirm the skill appears in your harness's skill list/picker (`/skills info NAME`, `/skills`, or the VS Code Skills customization view).

You have completed the exercise when both files exist on disk, the assistant demonstrably used the brief's content (not guessed content), and the skill is listed as discovered by name — not merely present in the folder.

---

<a id="handbook-agents"></a>

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
tools: ["read", "search"]
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

### 🏋️ Exercise: create one minimal subagent and invoke it

1. Choose your actual harness and copy the matching minimal reviewer template above (Copilot CLI `.github/agents/diff-reviewer.agent.md`, Claude `.claude/agents/reviewer.md`, Codex `.codex/agents/reviewer.toml`, or VS Code's Agent customization equivalent).
2. Create the file at its exact required path, with no edits to the template fields beyond what the schema requires.
3. Reload/restart as that harness requires (CLI restart, VS Code Agent dropdown refresh, Codex/Claude session restart).
4. Invoke it on a harmless, bounded task: “Use the reviewer/diff-reviewer agent to review the current `git diff` read-only and report findings.”
5. Confirm it responds: the agent must appear by name in the picker/`/agent` list/delegation row, and its reply must contain concrete findings or “no diff found,” not a generic assistant answer.

You have completed the exercise when you can point to the actual file path, the actual invocation command/selection, and the actual response showing the named subagent — not the default assistant — handled the task. Then confirm `git status` shows no unexpected edits, since this subagent was read-only.

---

<a id="handbook-hooks"></a>

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

### ✅ Checkpoint: confirm your hook actually fired

Pick the hook lab matching your harness above (Copilot CLI `sessionStart` audit, VS Code Local `PreToolUse` logger, Claude `SessionStart` logger, or Codex `SessionStart` logger). Before declaring it done, confirm all of the following with real evidence, not expectation:

- [ ] The exact command ran manually once outside the hook and produced the expected log line.
- [ ] The hook config file is valid (parsed without error) and lives at the exact required path for your harness.
- [ ] A **new** session/event of the matching type was started or triggered after saving the hook.
- [ ] The log file contains one **additional** line with a timestamp later than the manual test — proving the harness, not you, produced it.
- [ ] Breaking the command path (typo) produces a visible diagnostic (hook log, `/hooks`, Agent Debug Logs, or startup error), and restoring the path makes the log grow again on the next matching event.

You have completed the exercise only when the last checkbox is true for both the broken and the repaired state — a single successful log line can be a coincidence, but reproducing failure then repair confirms the hook, not something else, is the cause.

---

<a id="handbook-mcp"></a>

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

### Connect a tested local C# MCP server

Build and independently inspect the server in [AI Journey's MCP server lesson](ai_journey.md#course-mcp). Return here with its actual project path, startup command, tool names, and valid/invalid request results. Server development belongs in that course; this handbook owns the host configuration. The current [Microsoft MCP quickstart](https://learn.microsoft.com/en-us/dotnet/ai/quickstarts/build-mcp-server) remains the version-sensitive template reference.

Before connecting, confirm stdout is reserved for stdio protocol messages, diagnostics go to stderr, the tool is read-only, and the test identity cannot access excluded data. A server listed by a host proves discovery, not authorization or successful invocation.

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

### ✅ Checkpoint: connect one server and invoke one tool

Using the [AI Journey local C# MCP server](ai_journey.md#course-mcp) (or any other server you have reviewed), confirm all of the following in order:

- [ ] The server runs standalone with its real startup command and responds to the MCP Inspector/SDK client without your host configured yet.
- [ ] You configured exactly one host (VS Code, Copilot CLI, Codex, or Claude Code) using that host's real config file/command from [§5.2](#handbook-mcp) above, with a real path — not a copied placeholder.
- [ ] The host's own MCP panel/list (`/mcp`, `codex mcp list`, `claude mcp list`, or VS Code's MCP view) shows the server **and** its tools, confirming discovery.
- [ ] You asked the assistant to invoke one specific read-only tool by name and inspected the actual tool call and its structured result in the transcript — not just a plausible-sounding answer.
- [ ] You stopped the server process and confirmed the host now reports the tool as unavailable, proving the result in the previous step came from the real server.

You have completed the exercise when you can name the server, the tool invoked, and the exact result returned, and you have evidence (transcript + stopped-server test) that the call went through the real server rather than the model guessing.

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

### 🏋️ Runnable check: compare config-file locations across CLI and VS Code

Run this in the repository root to see exactly which customization files each surface will actually discover, then compare against what you expect from the tables above:

```powershell
Write-Host "--- Copilot CLI project files ---"
Get-ChildItem -Recurse -Force -ErrorAction SilentlyContinue `
  .github\copilot-instructions.md, .github\skills, .github\agents, .github\hooks, .mcp.json |
  Select-Object FullName

Write-Host "--- VS Code-specific files ---"
Get-ChildItem -Recurse -Force -ErrorAction SilentlyContinue `
  .vscode\mcp.json |
  Select-Object FullName

Write-Host "--- Shared/cross-product files ---"
Get-ChildItem -Force -ErrorAction SilentlyContinue AGENTS.md, CLAUDE.md |
  Select-Object FullName
```

**Expected result:** every file your chosen harness is supposed to read appears under the matching heading, and any file meant for a *different* harness (e.g., `.vscode\mcp.json`) does **not** appear under Copilot CLI's heading. If a file you created is missing from its expected heading, you have the exact same evidence a harness would use to say "not discovered" — fix the path before trusting the config, rather than assuming the content is correct.

---

# 7. Apply configuration to an engineering task

Project/branch working practices live once in the [company workbook](end_to_end_ai_agent_graphql_workflow.md#workbook-path). Use its [new-project foundation](end_to_end_ai_agent_graphql_workflow.md#new-project) or [existing-project inspection](end_to_end_ai_agent_graphql_workflow.md#existing-project), then return to your selected product route here only if a configuration gap exists.

For each added customization, record purpose, owner, scope, authoritative source, discovery/invocation test, permissions, reload behavior, and removal steps. Keep ticket facts in the brief and stable rules in project instructions. Reuse valid team configuration rather than adding a duplicate.

### 🏋️ End-to-end runnable task: chain one artifact onto one trivial task

Pick one artifact you already created earlier in this handbook (the `docs/tasks/ABC-100.md` brief from [Section 1](#handbook-decisions), the skill from [Section 2](#handbook-skills), or the subagent from [Section 3](#handbook-agents)). Then:

1. Pick one trivial, real, low-risk task in your project (e.g., add a missing docstring, fix one obviously-wrong comment, or list the files touched by the last commit).
2. Start a fresh session in your chosen harness and explicitly reference the artifact (attach the brief, invoke the skill by name, or delegate to the subagent) as part of asking for the trivial task.
3. Record: which artifact you used, the exact invocation, the files the assistant touched or read, and whether `git status`/the transcript shows it actually used the artifact's content rather than generic knowledge.

**Expected outcome:** the trivial task is completed correctly, and you have concrete evidence (a citation, a restated acceptance criterion, a named skill/agent in the transcript) that the artifact — not just the base assistant — drove the result. If the artifact wasn't used, diagnose with the "Troubleshooting by symptom" table in Section 8 below before retrying.

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

<a id="handbook-permissions"></a>

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

## Selected documentation recheck — 5 October 2026

The reorganization rechecked the linked official pages for VS Code prompt-file deprecation/portable MCP, Copilot agent aliases/subagent inheritance/skill reload/hook startup, Codex instruction/skill/agent/hook formats, and Claude skill/subagent controls. It did not execute these product configurations. The 3 October statement above is historical; it is not a test result for an installed product version.

GitHub documents `read` and `search` aliases, with `Grep`/`Glob` compatible with search; unknown aliases are ignored. The earlier `grep`/`glob` example is therefore not by itself a defect. Prefer the consistent `tools: ["read", "search"]` spelling for teaching: [custom-agent configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration).

For new compatible VS Code/Copilot MCP setups prefer root `.mcp.json`; keep `.vscode/mcp.json` as a compatibility route and label its distinct `servers` schema: [VS Code MCP documentation](https://code.visualstudio.com/docs/agent-customization/mcp-servers). Parent permissions, user/project scope and organizational policy must still be tested locally.
