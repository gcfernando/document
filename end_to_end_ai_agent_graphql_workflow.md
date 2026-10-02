# 🛠️ Practical Guide: Fixing a GraphQL Bug with Codex, Claude Code, and Copilot in VS Code or CLI

> **VS Code edition, updated 2026-10-02:** Start with Parts B1–B2 for file creation and extension chat workflows. Parts C–E retain the original CLI walkthroughs. New templates are documentation examples, not an executed project or verified VS Code session.


This is a hands-on, do-this-then-this guide. One realistic ticket, solved three times — once per tool — with the exact commands and prompts to run, in order. Background/theory is kept to a short reference appendix at the end; everything above it is practical.

> All commands/prompts below are real and copy-pasteable. All "agent responses" and command *output* shown are **simulated examples** (no such repository exists on disk here) — they show you what to expect, not a real session transcript. Replace file names/paths with your own repo's actual ones.

---

## 🎫 Part A — The Ticket (ABC-123)

| Field | Value |
|---|---|
| ID | ABC-123 |
| Title | `vehicle(id:)` GraphQL query returns `null` for a vehicle that exists |
| Expected | `vehicle(id: "V-1042")` returns the vehicle's data |
| Actual | Returns `"vehicle": null`, even though the vehicle is active and `GET /api/vehicles/V-1042` (REST) works |
| Constraint | Public GraphQL schema `vehicle(id: ID!): Vehicle` must not change; no unrelated refactors |
| Done when | Root cause proven with evidence; regression test added (fails before fix, passes after); targeted + full tests pass; GraphQL query verified directly; diff reviewed; report + PR summary written |

Repo layout used below:
```text
VehiclesApi/
├── src/Api/GraphQL/VehicleResolver.cs
├── src/Application/Vehicles/VehicleService.cs
├── src/Infrastructure/Vehicles/VehicleRepository.cs
└── tests/Api.IntegrationTests/GraphQL/VehicleQueryTests.cs
```

---

## ⚙️ Part B — Setup (same for every tool)

```bash
cd VehiclesApi
git fetch origin
git switch main
git pull
git switch -c fix/ABC-123-vehicle-graphql-null
git status
dotnet build
```

Confirm: clean working tree, correct branch, build succeeds. Do not continue until all three are true.

---

## 💻 Part B1 — VS Code Setup: Create the Instruction, Skill, and Agent Files

Updated 2026-10-02. The paths and capabilities below were checked against the official sources linked at the end. Templates are original examples for the fictional VehiclesApi repository; they were not executed in a customer repository or tested inside VS Code.

### 🧭 B1.1 Choose the agent before creating files

VS Code is the editor; the selected extension or agent harness determines which configuration it reads. Copilot Chat, the OpenAI Codex extension, and the Claude Code extension are separate surfaces. Selecting a Claude model in Copilot does not turn Copilot into the Claude Code extension. Running a CLI in **Terminal → New Terminal** still uses that CLI's rules.

Open **File → Open Folder** and select the repository root. Install the intended vendor extension through Extensions (`Ctrl+Shift+X`), using the installation link on its official documentation page. Sign in using your organization's approved account. Open that extension's chat panel. In newer VS Code agent interfaces, also check the selected session target/harness. Features can depend on installed version and enterprise policy. [S7–S9]

### 📂 B1.2 Which file means what?

| File | Purpose | Automatic behavior |
|---|---|---|
| `AGENTS.md` | Shared project rules | Codex discovers it; Copilot support depends on the session/settings |
| `src/Api/AGENTS.md` | Rules for one subtree | Discovery differs by agent; see B1.4 |
| `.github/copilot-instructions.md` | Copilot project guidance | Supported Copilot sessions load it |
| `.github/instructions/graphql.instructions.md` | Targeted Copilot guidance | Uses `applyTo` and/or relevance |
| `.github/agents/graphql-reviewer.agent.md` | Named Copilot role | Appears in the agent picker when discovered |
| `<skill-folder>/SKILL.md` | Reusable procedure | Discovery makes it available; invocation loads the procedure |
| `CLAUDE.md` | Claude project guidance | Claude's native instruction mechanism |
| `.claude/agents/graphql-reviewer.md` | Claude subagent | Claude-specific agent definition |
| `docs/ai/tools.md` | Human-readable tool/runbook notes | Ordinary documentation; explicitly reference or attach it |
| `docs/ai/instructions.md` | Optional ordinary guidance document | The name alone does not register instructions |

Use exact capitalization for `AGENTS.md` and `SKILL.md`. `agents.md`, `agents-review.md`, `tools.md`, and `instructions.md` are not interchangeable with the recognized formats. `AGENTS.md` does not create several workers, and writing tool names in Markdown does not install or authorize tools. [S1–S6]

### 📝 B1.3 Create files through the VS Code Explorer

1. Open Explorer (`Ctrl+Shift+E`). Confirm the top-level folder is the repository.
2. Right-click that folder and choose **New Folder** to create the required directories.
3. Right-click the destination folder, choose **New File**, and enter the exact filename from a template below.
4. Paste the content, replace example paths and commands with repository facts, and save (`Ctrl+S`). Ensure the filename has not become `SKILL.md.txt`.
5. Use Markdown preview (`Ctrl+Shift+V`) to check readability. Preview does not validate agent discovery.

For supported Copilot/VS Code sessions, `Ctrl+Shift+P` → **Chat: Open Customizations** provides an alternative editor for Instructions, Skills, and Agents. Select the intended harness first. If this preview UI is absent in your installed version, create the files manually. [S1–S3]

### 📋 B1.4 Root and nested AGENTS.md

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

### 🎯 B1.5 Copilot project and path-specific instructions

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

### 🧠 B1.6 Create a reusable SKILL.md

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

### 🤖 B1.7 Create different named agents

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

### 🔧 B1.8 tools.md versus actual tool configuration

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

### 🟣 B1.9 Claude adapter and extension workflow

When sharing the root agreements, create `CLAUDE.md`:

```markdown
@AGENTS.md

Read docs/ai/tools.md before selecting verification commands.
```

This is Claude's documented import syntax. Current Claude AGENTS support depends on version/settings: its default can use AGENTS as a fallback when CLAUDE files are absent; it does not unconditionally load both. The explicit import is useful when retaining a Claude adapter. [S9]

In the Claude Code VS Code panel, attach the ticket and use the skill prompt from B1.6. In the Codex extension, open the same repository, attach the ticket, and request its skill. Review edits through VS Code Source Control. Extension settings and permissions belong to the selected product, even when the files are edited in the same window. [S7, S8]

### ✅ B1.10 Check that the setup works

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

### 📚 B1.11 Official sources

Retrieved 2026-10-02. These references substantiate the new VS Code section and the related corrections; the historical CLI walkthroughs is not newly certified by this update.

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

## ▶️ Part B2 — Run ABC-123 from the VS Code Chat Panel

The templates above are for this guide's fictional repository. Confirm the real solution path and commands before use. Keep the reported symptom separate from the proposed root cause: do not assume an internal/external-ID mix-up until code and a reproduction prove it.

1. Create `docs/tasks/ABC-123.md` and copy the ticket's expected behavior, actual behavior, constraints, and acceptance criteria from Part A.
2. Create the shared `AGENTS.md`, tool runbook, and the skill at the path for your chosen extension. Add only the vendor-specific files you need. Do not create all variants just to run one agent.
3. Open the intended extension or Copilot session. Run the harmless configuration check in B1.10.
4. Attach `docs/tasks/ABC-123.md` using that panel's file attachment control. Submit:

```text
Use the graphql-bugfix skill to investigate docs/tasks/ABC-123.md.
Read applicable project and folder instructions and docs/ai/tools.md.
Trace vehicle(id:) through the resolver, service, and repository.
Reproduce the null response and distinguish facts from hypotheses.
Do not edit code yet. Report the root cause only if the evidence establishes it.
```

5. Review the evidence. If it establishes the ID lookup defect, request:

```text
Implement the smallest fix for the confirmed cause. First add a regression
that fails for the observed defect, then make it pass. Preserve the public
GraphQL schema. Run the relevant tests and directly check the query if the
local API is available. Report actual results and blocked checks. Do not commit.
```

6. Inspect changed files in VS Code Source Control. Review test output and confirm that the test distinguishes the two ID types. An HTTP 200 alone does not establish GraphQL success; inspect the response's data and errors.
7. For a risky change, obtain an independent review. In Copilot select **GraphQL Reviewer** and attach the diff; in Claude request `graphql-reviewer` with the diff; in Codex explicitly request a read-only reviewer subagent. Supply missing context to limited-tool reviewers.
8. Resolve substantiated findings, rerun affected checks, and ask for the final verification report and PR summary. Review and perform any commit/push yourself, as in the original walkthrough.

The named reviewer does not replace the regression test. Its output is another source of findings, not proof that the code is correct. The reusable skill holds the procedure; the task document holds this ticket's facts; instructions hold lasting repository rules.

---

## 🔵 Part C — Codex: Full Walkthrough

```bash
codex
```

**0. Verify instructions loaded**
```text
Which instruction files did you load for this session, and from which paths?
```
*Check:* answer lists your real `~/.codex/AGENTS.md` (or `AGENTS.override.md` if present) and any project `AGENTS.md`. If not, stop and fix your setup before continuing.

**1. Start investigation**
```text
Investigate ticket ABC-123: the GraphQL query vehicle(id: "V-1042") returns
null even though the vehicle exists and is active, while
GET /api/vehicles/V-1042 (REST) returns it correctly. Investigate only, do
not change code yet.
```
*Simulated response:* "Understood. I'll check repo conventions, git state, the request path, and existing tests before forming a hypothesis."

**2. Check repo conventions**
```text
Check this repo's instruction files (.github/copilot-instructions.md, any
CLAUDE.md/AGENTS.md, .github/instructions/**) and tell me what conventions
apply to the GraphQL/Application/Infrastructure layers.
```
*Simulated response:* "Resolvers must call services, not repositories directly. Tests use xUnit via `dotnet test`."

**3. Check git state**
```text
Run git status and git log -5 --oneline.
```
*Simulated response:* clean tree, branch `fix/ABC-123-vehicle-graphql-null`, last commit `a1b2c3d Add vehicle search filters`.
*Check:* matches what you expect.

**4. Map the request path**
```text
Trace the full request path for the vehicle(id: ID!) field: the GraphQL
type definition, the resolver, the service it calls, the repository, and
the database query. Show me the files and the call chain.
```
*Simulated response:*
```text
VehicleResolver.GetVehicleAsync(string id)
  -> VehicleService.GetByInternalIdAsync(string id)
  -> VehicleRepository.FindByIdAsync(int id)
  -> SELECT * FROM Vehicles WHERE Id = @id
```

**5. Find existing tests**
```text
Find existing tests that cover the vehicle GraphQL query and the
VehicleService/VehicleRepository methods in the call chain you just found.
```
*Simulated response:* `Vehicle_WithValidInternalId_ReturnsVehicle()` exists but only uses a raw integer ID — no test uses a public `"V-xxxx"` ID.

**6. Reproduce the bug**
```text
Reproduce the bug: run the existing GraphQL integration test suite, and
also run a direct query for vehicle(id: "V-1042") against a test/dev
instance if one is available. Show me the actual output.
```
*Simulated response:*
```bash
dotnet test --filter FullyQualifiedName~VehicleQueryTests
# Passed! Failed: 0, Passed: 3

curl -s -X POST http://localhost:5080/graphql -H "Content-Type: application/json" \
  -d '{"query":"{ vehicle(id: \"V-1042\") { id make model } }"}'
# {"data":{"vehicle":null}}
```
*Check:* bug reproduced with real output, matches the ticket.

**7. Form hypotheses**
```text
Based on the request path and the reproduction, give me 2-3 ranked
root-cause hypotheses, each with the evidence that supports it and any
evidence that would contradict it.
```
*Simulated response:* Hypothesis 1 (strongest): resolver passes the external ID into `GetByInternalIdAsync`, which expects an integer — `"V-1042"` fails `int.TryParse`. Hypotheses 2–3 (Hot Chocolate swallowing an exception; an "active" filter bug) both contradicted by evidence already gathered.

**8. Prove root cause**
```text
Prove hypothesis 1. State the root cause as: "Because [X], when [Y], the
system produces [Z]." Show me the exact lines of code.
```
*Simulated response:*
```csharp
// VehicleService.cs
if (!int.TryParse(id, out var internalId)) return null;  // "V-1042" fails here
```
"Because `VehicleResolver.GetVehicleAsync()` forwards the external ID into `GetByInternalIdAsync()`, when a client queries `vehicle(id: "V-1042")`, the system produces `null` via the silent `int.TryParse` failure."
*Check:* approve this as the confirmed root cause before anything else happens.

**9. Create the implementation plan**
```text
Create an implementation plan: the regression test to add, the smallest
production fix, the commands to verify it, the files that will change, and
any risks. No unrelated refactoring.
```
*Simulated response:* add `Vehicle_WithExternalId_ReturnsVehicle()`; change resolver to call `GetByExternalIdAsync`; verify with `dotnet test`; 2 files touched; risk: confirm active-vehicle filtering stays consistent.

**10. Add the regression test first**
```text
Add the regression test from the plan. Do not change VehicleResolver.cs
yet. Run it and show me that it fails for the right reason.
```
*Simulated response:*
```bash
dotnet test --filter FullyQualifiedName~Vehicle_WithExternalId_ReturnsVehicle
# Failed! Assert.NotNull() Failure — Actual: null
```
*Check:* fails with the same symptom as the ticket, not a compile error.

**11. Implement the fix**
```text
Implement the fix from the plan: change VehicleResolver.GetVehicleAsync()
to call GetByExternalIdAsync instead of GetByInternalIdAsync. Do not touch
anything else. Preserve the public GraphQL contract.
```
*Simulated response:*
```diff
-        return await service.GetByInternalIdAsync(id, ct);
+        return await service.GetByExternalIdAsync(id, ct);
```

**12. Run the targeted test**
```text
Run the regression test again: dotnet test --filter
FullyQualifiedName~Vehicle_WithExternalId_ReturnsVehicle
```
*Simulated response:* `Passed! Failed: 0, Passed: 1`.

**13. If it still fails (branch — skip if Step 12 passed)**
```text
That test still fails. Show me the exact failure message, and compare it
against our hypothesis before changing anything else.
```
*Rule:* never make a second guess without new evidence from the actual failure message.

**14. Run the broader test suite**
```text
Run the full test suite using this repo's real test command (check the
README or CI config if you're not sure) and show me the full result.
```
*Simulated response:* `dotnet test VehiclesApi.sln` → `Passed! 142/142, 0 failed`.

**15. Verify GraphQL directly**
```text
Run the exact GraphQL query from the ticket against a local/dev instance
and show me the real response.
```
*Simulated response:* `{"data":{"vehicle":{"id":"V-1042","make":"Toyota","model":"Corolla"}}}`

**16. Review the diff**
```text
Show me git status and the full git diff. Do not commit or push anything.
```
*Check:* only `VehicleResolver.cs` and the new test file changed — nothing else.

**17. Self-review**
```text
Review your own change against this checklist: correctness, GraphQL
contract compatibility, nullability, authorization, edge cases, test
quality, any unnecessary changes, error handling, and N+1/performance
concerns. Report findings only — do not change any code.
```
*Simulated response:* all good; one noted gap — special-character external IDs untested.

**18. Independent review (only if this were a bigger/riskier change — skip for ABC-123)**
```text
# In a NEW codex session, pointed only at the diff:
Review this diff for authorization and data-exposure issues only. Report
findings, do not change code.
```

**19. Final verification report**
```text
Write the final verification report: root cause, the fix, files changed,
the regression test, the exact commands you ran, their real results, the
GraphQL verification, the diff/status review, remaining risks, and
anything not verified.
```

**20. PR summary**
```text
Prepare a PR summary with Problem / Root Cause / Fix / Testing / Risk,
based only on what we actually verified. Do not commit or open the PR —
I'll do that myself.
```

```bash
git add -A
git commit -m "Fix ABC-123: vehicle GraphQL query uses wrong ID lookup"
git push -u origin fix/ABC-123-vehicle-graphql-null
```

---

## 🟣 Part D — Claude Code: Full Walkthrough

```bash
claude
```

**0. Verify instructions loaded**
```text
/context
/memory
```
*Check:* confirm your repo's `CLAUDE.md`, any `.claude/rules/**`, and `AGENTS.md` (if present) are listed. Run `/doctor prompt-audit` if your version supports it.

**1. Start investigation**
```text
Investigate ticket ABC-123: the GraphQL query vehicle(id: "V-1042") returns
null even though the vehicle exists and is active, while
GET /api/vehicles/V-1042 (REST) returns it correctly. Investigate only, do
not change code yet.
```

**2. Check repo conventions**
```text
Check this repo's instruction files (.github/copilot-instructions.md, any
CLAUDE.md/AGENTS.md, .github/instructions/**) and tell me what conventions
apply to the GraphQL/Application/Infrastructure layers.
```

**3. Check git state**
```text
Run git status and git log -5 --oneline.
```

**4. Map the request path**
```text
Trace the full request path for the vehicle(id: ID!) field: the GraphQL
type definition, the resolver, the service it calls, the repository, and
the database query. Show me the files and the call chain.
```
*Simulated response:* `VehicleResolver.GetVehicleAsync` → `VehicleService.GetByInternalIdAsync` → `VehicleRepository.FindByIdAsync` → `SELECT ... WHERE Id = @id`.

**5. Find existing tests**
```text
Find existing tests that cover the vehicle GraphQL query and the
VehicleService/VehicleRepository methods in the call chain you just found.
```

**6. Reproduce the bug**
```text
Reproduce the bug: run the existing GraphQL integration test suite, and
also run a direct query for vehicle(id: "V-1042") against a test/dev
instance if one is available. Show me the actual output.
```
*Simulated response:* existing tests pass (3/3, none cover this input shape); direct query returns `{"data":{"vehicle":null}}`.

**7. Form hypotheses**
```text
Based on the request path and the reproduction, give me 2-3 ranked
root-cause hypotheses, each with the evidence that supports it and any
evidence that would contradict it.
```

**8. Prove root cause**
```text
Prove hypothesis 1. State the root cause as: "Because [X], when [Y], the
system produces [Z]." Show me the exact lines of code.
```
*Check:* approve this as confirmed root cause before any code changes.

**9. Create the implementation plan**
```text
Create an implementation plan: the regression test to add, the smallest
production fix, the commands to verify it, the files that will change, and
any risks. No unrelated refactoring.
```

**10. Add the regression test first**
```text
Add the regression test from the plan. Do not change VehicleResolver.cs
yet. Run it and show me that it fails for the right reason.
```
*Simulated response:* `Vehicle_WithExternalId_ReturnsVehicle` added, run, fails with `Assert.NotNull() Failure — Actual: null`.

**11. Implement the fix**
```text
Implement the fix from the plan: change VehicleResolver.GetVehicleAsync()
to call GetByExternalIdAsync instead of GetByInternalIdAsync. Do not touch
anything else. Preserve the public GraphQL contract.
```

**12. Run the targeted test**
```text
Run the regression test again: dotnet test --filter
FullyQualifiedName~Vehicle_WithExternalId_ReturnsVehicle
```
*Simulated response:* `Passed! 1/1`.

**13. If it still fails (branch — skip if Step 12 passed)**
```text
That test still fails. Show me the exact failure message, and compare it
against our hypothesis before changing anything else.
```

**14. Run the broader test suite**
```text
Run the full test suite using this repo's real test command (check the
README or CI config if you're not sure) and show me the full result.
```
*Simulated response:* `dotnet test VehiclesApi.sln` → `142 passed, 0 failed`.

**15. Verify GraphQL directly**
```text
Run the exact GraphQL query from the ticket against a local/dev instance
and show me the real response.
```

**16. Review the diff**
```text
Show me git status and the full git diff. Do not commit or push anything.
```

**17. Self-review**
```text
Review your own change against this checklist: correctness, GraphQL
contract compatibility, nullability, authorization, edge cases, test
quality, any unnecessary changes, error handling, and N+1/performance
concerns. Report findings only — do not change any code.
```
Optional, for a bounded second pass within the same session:
```text
Launch a read-only review subagent to check this diff for authorization and
nullability issues, then report back.
```

**18. Independent review (only if this were a bigger/riskier change — skip for ABC-123)**
```text
Launch a separate review sub-task with fresh context, read-only, to review
this diff for authorization and data-exposure issues only.
```

**19. Final verification report**
```text
Write the final verification report: root cause, the fix, files changed,
the regression test, the exact commands you ran, their real results, the
GraphQL verification, the diff/status review, remaining risks, and
anything not verified.
```

**20. PR summary**
```text
Prepare a PR summary with Problem / Root Cause / Fix / Testing / Risk,
based only on what we actually verified. Do not commit or open the PR —
I'll do that myself.
```

```bash
git add -A
git commit -m "Fix ABC-123: vehicle GraphQL query uses wrong ID lookup"
git push -u origin fix/ABC-123-vehicle-graphql-null
```

---

## 🟢 Part E — GitHub Copilot CLI: Full Walkthrough

```bash
copilot
```

**0. Verify instructions loaded**
```text
/instructions
```
*Check:* confirm `.github/copilot-instructions.md` and any `.github/instructions/**/*.instructions.md` are listed. Run the rest of this walkthrough in the **main session agent** (not a built-in `explore`/`task`/`code-review` subagent) — those don't receive repo instructions by default.

**1. Start investigation**
```text
Investigate ticket ABC-123: the GraphQL query vehicle(id: "V-1042") returns
null even though the vehicle exists and is active, while
GET /api/vehicles/V-1042 (REST) returns it correctly. Investigate only, do
not change code yet.
```

**2. Check repo conventions**
```text
Check this repo's instruction files (.github/copilot-instructions.md, any
CLAUDE.md/AGENTS.md, .github/instructions/**) and tell me what conventions
apply to the GraphQL/Application/Infrastructure layers.
```

**3. Check git state**
```text
Run git status and git log -5 --oneline.
```

**4. Map the request path**
```text
Trace the full request path for the vehicle(id: ID!) field: the GraphQL
type definition, the resolver, the service it calls, the repository, and
the database query. Show me the files and the call chain.
```
*Simulated response:* `VehicleResolver.GetVehicleAsync` → `VehicleService.GetByInternalIdAsync` → `VehicleRepository.FindByIdAsync` → `SELECT ... WHERE Id = @id`.

**5. Find existing tests**
```text
Find existing tests that cover the vehicle GraphQL query and the
VehicleService/VehicleRepository methods in the call chain you just found.
```

**6. Reproduce the bug**
```text
Reproduce the bug: run the existing GraphQL integration test suite, and
also run a direct query for vehicle(id: "V-1042") against a test/dev
instance if one is available. Show me the actual output.
```
*Simulated response:* existing tests pass (3/3, none cover this input shape); direct query returns `{"data":{"vehicle":null}}`.

**7. Form hypotheses**
```text
Based on the request path and the reproduction, give me 2-3 ranked
root-cause hypotheses, each with the evidence that supports it and any
evidence that would contradict it.
```

**8. Prove root cause**
```text
Prove hypothesis 1. State the root cause as: "Because [X], when [Y], the
system produces [Z]." Show me the exact lines of code.
```
*Check:* approve this as confirmed root cause before any code changes.

**9. Create the implementation plan**
```text
Create an implementation plan: the regression test to add, the smallest
production fix, the commands to verify it, the files that will change, and
any risks. No unrelated refactoring.
```

**10. Add the regression test first**
```text
Add the regression test from the plan. Do not change VehicleResolver.cs
yet. Run it and show me that it fails for the right reason.
```
*Simulated response:* `Vehicle_WithExternalId_ReturnsVehicle` added, run, fails with `Assert.NotNull() Failure — Actual: null`.

**11. Implement the fix**
```text
Implement the fix from the plan: change VehicleResolver.GetVehicleAsync()
to call GetByExternalIdAsync instead of GetByInternalIdAsync. Do not touch
anything else. Preserve the public GraphQL contract.
```

**12. Run the targeted test**
```text
Run the regression test again: dotnet test --filter
FullyQualifiedName~Vehicle_WithExternalId_ReturnsVehicle
```
*Simulated response:* `Passed! 1/1`.

**13. If it still fails (branch — skip if Step 12 passed)**
```text
That test still fails. Show me the exact failure message, and compare it
against our hypothesis before changing anything else.
```

**14. Run the broader test suite**
```text
Run the full test suite using this repo's real test command (check the
README or CI config if you're not sure) and show me the full result.
```
*Simulated response:* `dotnet test VehiclesApi.sln` → `142 passed, 0 failed`.

**15. Verify GraphQL directly**
```text
Run the exact GraphQL query from the ticket against a local/dev instance
and show me the real response.
```

**16. Review the diff**
```text
Show me git status and the full git diff. Do not commit or push anything.
```

**17. Self-review**
```text
Review your own change against this checklist: correctness, GraphQL
contract compatibility, nullability, authorization, edge cases, test
quality, any unnecessary changes, error handling, and N+1/performance
concerns. Report findings only — do not change any code.
```

**18. Independent review (only if this were a bigger/riskier change — skip for ABC-123)**
```text
# Define .github/agents/graphql-reviewer.agent.md once (read-only scope),
# then for a risky change:
/agent graphql-reviewer
Review this diff for authorization and data-exposure issues only. Report
findings, do not change code.
```

**19. Final verification report**
```text
Write the final verification report: root cause, the fix, files changed,
the regression test, the exact commands you ran, their real results, the
GraphQL verification, the diff/status review, remaining risks, and
anything not verified.
```

**20. PR summary**
```text
Prepare a PR summary with Problem / Root Cause / Fix / Testing / Risk,
based only on what we actually verified. Do not commit or open the PR —
I'll do that myself.
```

```bash
git add -A
git commit -m "Fix ABC-123: vehicle GraphQL query uses wrong ID lookup"
git push -u origin fix/ABC-123-vehicle-graphql-null
```

---

## 💬 Part F — Daily Reusable Prompts (copy-paste, any tool)

Use these for day-to-day tickets without re-deriving the 20 steps each time.

**Start any bug ticket**
```text
Investigate ticket <ID>: <one-line expected vs. actual>. Investigate only,
do not change code yet.
```

**Find the root cause**
```text
Trace the full request path for <feature/endpoint/field>: entry point,
each layer it passes through, and the data source. Then give me 2-3 ranked
root-cause hypotheses with supporting and contradicting evidence.
```

**Prove it**
```text
Prove hypothesis <N>. State it as "Because [X], when [Y], the system
produces [Z]." Show me the exact lines of code.
```

**Plan before coding**
```text
Create an implementation plan: regression test, smallest production fix,
verification commands, files that will change, risks. No unrelated
refactoring.
```

**Test-first fix**
```text
Add the regression test first and show me it fails for the right reason.
Then implement the smallest fix from the plan and show me the test pass,
plus the full suite result.
```

**Review before commit**
```text
Show me git status and the full diff. Review your own change against:
correctness, contract compatibility, nullability, authorization, edge
cases, test quality, unnecessary changes, error handling, performance.
Do not commit or push.
```

**Wrap up**
```text
Write the final verification report (root cause, fix, files, test, real
command results, remaining risks) and a PR summary (Problem / Root Cause /
Fix / Testing / Risk). Do not commit or open the PR.
```

---

## 📌 Cheat Sheet

```text
0.  Verify instructions/context are loaded for this tool
1.  Investigate only — no code changes
2.  Check repo conventions/instruction files
3.  git status + git log
4.  Trace the full request path
5.  Find existing tests on that path
6.  Reproduce the bug for real, show real output
7.  Form 2-3 ranked hypotheses with evidence
8.  Prove the root cause — get explicit approval before coding
9.  Write an implementation plan (test + smallest fix + risks)
10. Add the regression test FIRST — confirm it fails correctly
11. Implement the smallest fix only
12. Run the targeted test — confirm it passes
13. If it still fails: re-examine, don't guess-patch
14. Run the full test suite
15. Verify the actual feature/API directly
16. Review git status + diff — nothing unrelated
17. Self-review against a fixed checklist
18. Independent/second review for risky changes
19. Write the final verification report
20. Write the PR summary — you commit/push yourself
```

**The one default prompt**, if you remember nothing else:
```text
Investigate <ticket>, find and prove the root cause with evidence, propose
a plan, write a failing regression test, implement the smallest fix, run
the real tests, show me the diff, and report what you verified and what
you didn't. Don't commit.
```

---

## 📖 Appendix — Reference / Background

This section is condensed background for the concepts used above. Skip it unless you want the "why."

### 🔍 A1. Why this order works

Agents left unconstrained tend to jump straight to editing code. The 20-step order above forces: understand → reproduce → hypothesize → prove → plan → test-first → fix → verify → review → report, so that every fix is backed by evidence instead of a guess. The same ordering works for any AI coding tool because it describes a *process*, not a tool feature.

### 🏗️ A2. Instruction architecture (condensed)

| File | Scope | Used by |
|---|---|---|
| `AGENTS.md` | Repo-wide conventions | Codex, and increasingly others |
| `CLAUDE.md` | Repo-wide conventions | Claude Code |
| `.github/copilot-instructions.md` | Repo-wide conventions | Copilot CLI/Coding Agent |
| `.github/instructions/**/*.instructions.md` (`applyTo`) | Path-scoped rules | Copilot |
| `~/.copilot/copilot-instructions.md`, user-level equivalents | Personal defaults across repos | All tools (varies) |
| `SKILL.md` folders | Reusable, invokable procedures | Codex, Claude Code, Copilot; product-specific paths in Part B1 |
| `.github/agents/*.agent.md` | Custom named agents | Copilot; use the agent picker in VS Code |

Keep these layered, not duplicated: global engineering defaults at the user level, repo conventions at the repo level, path-specific exceptions scoped narrowly. Conflicting instructions should be surfaced by the agent, not silently resolved.

### 🔌 A3. Skills, subagents, MCP — one-line each

- **Skills**: packaged, reusable instructions/scripts the agent can invoke by name for a recurring task (e.g., "run our release checklist").
- **Subagents**: a separate agent context (sometimes with restricted tools/read-only access) used for isolated investigation or independent review, so its context doesn't pollute the main session's.
- **MCP (Model Context Protocol)**: a standard way to plug external tools/data sources (e.g., GitHub, databases, docs) into an agent as callable tools, instead of hand-rolling integrations per tool.

### 🧠 A4. Context engineering — one-line

Agents have finite context. Keep it high-signal: point them at the specific files/tests/layers relevant to the ticket, summarize or compact long investigation threads, and start fresh (sub)sessions for unrelated work so stale context doesn't bias later answers.

### ⚖️ A5. Codex vs. Claude Code vs. Copilot CLI (quick comparison)

| Aspect | Codex | Claude Code | Copilot CLI |
|---|---|---|---|
| Primary instruction file | `AGENTS.md` | `CLAUDE.md` | `.github/copilot-instructions.md` |
| Context inspection | No dedicated command; ask it directly | `/context` | `/instructions` |
| Memory/instruction audit | N/A | `/memory`, `/doctor prompt-audit` | `/instructions`, custom checks |
| Reusable named agents | Native custom agents; see official configuration docs in Part B1 | `.claude/agents/*.md` | `.github/agents/*.agent.md` + `/agent` |
| Built-in read-only helpers | General session tools | General session tools | `explore`, `task`, `code-review` (don't inherit repo instructions by default) |

These differences only affect *mechanics* (which command to run); the 20-step process and the prompt wording are identical across all three, which is why Parts C/D/E reuse the same prompts verbatim.


