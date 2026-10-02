# Practical Guide: Fixing a GraphQL Bug with Codex, Claude Code, and Copilot CLI

This is a hands-on, do-this-then-this guide. One realistic ticket, solved three times — once per tool — with the exact commands and prompts to run, in order. Background/theory is kept to a short reference appendix at the end; everything above it is practical.

> All commands/prompts below are real and copy-pasteable. All "agent responses" and command *output* shown are **simulated examples** (no such repository exists on disk here) — they show you what to expect, not a real session transcript. Replace file names/paths with your own repo's actual ones.

---

## Part A — The Ticket (ABC-123)

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

## Part B — Setup (same for every tool)

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

## Part C — Codex: Full Walkthrough

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

## Part D — Claude Code: Full Walkthrough

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

## Part E — GitHub Copilot CLI: Full Walkthrough

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

## Part F — Daily Reusable Prompts (copy-paste, any tool)

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

## Cheat Sheet

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

## Appendix — Reference / Background

This section is condensed background for the concepts used above. Skip it unless you want the "why."

### A1. Why this order works

Agents left unconstrained tend to jump straight to editing code. The 20-step order above forces: understand → reproduce → hypothesize → prove → plan → test-first → fix → verify → review → report, so that every fix is backed by evidence instead of a guess. The same ordering works for any AI coding tool because it describes a *process*, not a tool feature.

### A2. Instruction architecture (condensed)

| File | Scope | Used by |
|---|---|---|
| `AGENTS.md` | Repo-wide conventions | Codex, and increasingly others |
| `CLAUDE.md` | Repo-wide conventions | Claude Code |
| `.github/copilot-instructions.md` | Repo-wide conventions | Copilot CLI/Coding Agent |
| `.github/instructions/**/*.instructions.md` (`applyTo`) | Path-scoped rules | Copilot |
| `~/.copilot/copilot-instructions.md`, user-level equivalents | Personal defaults across repos | All tools (varies) |
| `SKILL.md` folders | Reusable, invokable procedures | Claude Code, Copilot CLI |
| `.github/agents/*.agent.md` | Custom named subagents | Copilot CLI |

Keep these layered, not duplicated: global engineering defaults at the user level, repo conventions at the repo level, path-specific exceptions scoped narrowly. Conflicting instructions should be surfaced by the agent, not silently resolved.

### A3. Skills, subagents, MCP — one-line each

- **Skills**: packaged, reusable instructions/scripts the agent can invoke by name for a recurring task (e.g., "run our release checklist").
- **Subagents**: a separate agent context (sometimes with restricted tools/read-only access) used for isolated investigation or independent review, so its context doesn't pollute the main session's.
- **MCP (Model Context Protocol)**: a standard way to plug external tools/data sources (e.g., GitHub, databases, docs) into an agent as callable tools, instead of hand-rolling integrations per tool.

### A4. Context engineering — one-line

Agents have finite context. Keep it high-signal: point them at the specific files/tests/layers relevant to the ticket, summarize or compact long investigation threads, and start fresh (sub)sessions for unrelated work so stale context doesn't bias later answers.

### A5. Codex vs. Claude Code vs. Copilot CLI (quick comparison)

| Aspect | Codex | Claude Code | Copilot CLI |
|---|---|---|---|
| Primary instruction file | `AGENTS.md` | `CLAUDE.md` | `.github/copilot-instructions.md` |
| Context inspection | No dedicated command; ask it directly | `/context` | `/instructions` |
| Memory/instruction audit | N/A | `/memory`, `/doctor prompt-audit` | `/instructions`, custom checks |
| Reusable named agents | N/A (session-based) | Subagents via config | `.github/agents/*.agent.md` + `/agent` |
| Built-in read-only helpers | General session tools | General session tools | `explore`, `task`, `code-review` (don't inherit repo instructions by default) |

These differences only affect *mechanics* (which command to run); the 20-step process and the prompt wording are identical across all three, which is why Parts C/D/E reuse the same prompts verbatim.


