# .NET Test Failure Triage Checklist

Work through these **in order**. Stop and fix as soon as one applies — don't skip ahead.

1. **Did the build even succeed?** A compile error can masquerade as a wall of test failures. Check for
   `error CS####` lines before trusting any "failed" count.
2. **Is it one test or many?** Many unrelated tests failing at once usually means a shared fixture,
   `DbContext`, or static state broke — not that you have many independent bugs.
3. **Did a dependency/package version change recently?** Check `git diff` on `*.csproj` and
   `packages.lock.json`/`*.lock.json` before assuming your code change is the cause.
4. **Is the failure test-order-dependent?** Re-run the single failing test in isolation
   (`dotnet test --filter "FullyQualifiedName~X"`). If it passes alone but fails in the full suite,
   you have shared/static state leaking between tests, not a logic bug.
5. **Is it a timing/async issue?** Look for `Task.Delay`, unobserved exceptions in `async void`, or a
   missing `await` before concluding the assertion itself is wrong.
6. **Is the assertion itself out of date?** Sometimes the test encodes an old requirement — confirm the
   expected value against current product requirements, not just against the code.
7. **Only after 1–6 are ruled out:** treat this as a genuine logic bug in the production code and fix it.

## Output format

For each failing test, report:
```
Test: <FullyQualifiedName>
Checklist item that applied: <number>
Root cause: <one sentence>
Fix: <one sentence, or "none needed — pre-existing flaky test">
```
