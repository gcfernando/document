---
name: dotnet-test-debugger
description: Diagnoses failing dotnet test runs by parsing the test-run output, correlating each failure to its source file, and proposing a fix-verify loop. Use when a user reports failing C#/.NET unit tests, pastes `dotnet test` output, or asks to debug a test failure.
license: MIT (same terms as the repository this skill ships in)
compatibility: Requires the .NET SDK (`dotnet` on PATH) and a test project using xUnit, NUnit, or MSTest.
metadata:
  repo: KnowledgeBase
  category: dotnet-testing
allowed-tools: Read Grep
---

# .NET Test Debugger

Use this skill whenever a `dotnet test` run has failures and you need a disciplined, repeatable way to
get from "red" to "green" without guessing.

## When to use this skill

- The user pastes raw `dotnet test` console output that contains `Failed!` or `[FAIL]` lines.
- The user says something like "my tests are failing", "why is this test red", or "help me debug this unit test".
- A CI log needs to be triaged before a PR can merge.

## Procedure

1. **Capture the full test output.** If you only have a summary, re-run with more detail:
   ```powershell
   dotnet test --logger "console;verbosity=detailed"
   ```
2. **Extract failures mechanically, don't eyeball a huge log.** Use the helper script in this skill:
   ```powershell
   scripts\parse-failures.ps1 -LogPath .\test-output.txt
   ```
   This prints one line per failing test: `TestName | ShortErrorMessage`.
3. **Triage using `checklist.md`** in this skill folder — go through it top to bottom before writing any fix. Most "flaky" test reports are actually one of the first three checklist items, not a real production bug.
4. **Locate the source.** For each failing test name, find the test file (`grep` the test method name) and the production code it exercises.
5. **Form one hypothesis per failure.** Do not change code for multiple failures at once — isolate, fix, re-run, confirm, then move to the next.
6. **Re-run only the failing tests** to verify the fix before running the full suite:
   ```powershell
   dotnet test --filter "FullyQualifiedName~TestClassName.TestMethodName"
   ```
7. **Re-run the full suite** once every targeted test is green, to catch regressions the narrow re-run couldn't see.
8. **Report** what changed and why — one sentence per failure, referencing the actual root cause (not "fixed the test").

## Supporting files

- `checklist.md` — the triage checklist referenced in step 3.
- `scripts/parse-failures.ps1` — trivial PowerShell helper that extracts failing test names and short error messages from a `dotnet test` log file. ⚠️ Needs runtime verification against your exact test framework's console output format — the regex patterns were written for common xUnit/NUnit/MSTest output shapes but not executed against a live failing project in this session.

## Security note

This skill's frontmatter deliberately pre-approves only `Read` and `Grep` in `allowed-tools` — read-only
investigation tools. It does **not** pre-approve `Bash`/shell execution, even though the procedure above
shows PowerShell commands: those are meant to be reviewed and run by you (or confirmed per-call by the
agent), not auto-executed, because this is a teaching template that may be copied into untrusted contexts.
If you copy this skill into your own project and want the agent to run `dotnet test` unattended, add that
permission deliberately and only after reviewing this file yourself — do not pre-approve `shell`/`bash`
tools in a skill folder you did not author or fully audit.
