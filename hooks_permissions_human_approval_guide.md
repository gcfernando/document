# 🛡️ Hooks, Permissions & Human Approval: Governing What an Agent Can Actually Do

> Learn the real, separately-documented mechanisms two different coding-agent tools use to intercept, approve, and audit actions — and the permission/sandboxing concepts that generalize beyond either one.

## 🎯 What You Will Build

A conceptual-but-concrete understanding of three governance layers — **hooks** (intercept and validate/block at specific lifecycle points), **permissions** (what categories of action are even reachable), and **human approval gates** (a person must say yes) — each illustrated with small examples, plus a risk table and a pre-flight checklist you can apply to any agent you build or operate.

## 📚 Prerequisites

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md#agent-lab5) — **required** for Lab 5's single risky-tool approval gate; this guide extends that idea to allowlist/denylist design rather than re-deriving the approval code.
- [parallel_agents_and_fleets_guide.md](parallel_agents_and_fleets_guide.md) — useful context: once agents can run concurrently, approval gates and permission boundaries matter even more, since no single person is necessarily watching every in-flight action.

## 🏷️ Difficulty: 🟡 Intermediate → 🔴 Advanced (sandboxing section)

## 🛠️ Setup

No new project needed — this guide is primarily conceptual, with small illustrative snippets. Where an example is a real, verifiable mechanism from a specific tool's own documentation, it is labeled accordingly; where it's a pattern you'd implement yourself, it's labeled 🧩 Illustrative.

> [!NOTE]
> **What I verified:** this CLI session's own documented lifecycle hooks (`.github/hooks/*.json`, supporting `sessionStart`, `sessionEnd`, `userPromptSubmitted`, `preToolUse`, `postToolUse`, `errorOccurred`) are described in this very session's custom-instruction material as a real GitHub Copilot CLI mechanism. I additionally fetched Anthropic's current Claude Code hooks reference (`code.claude.com/docs/en/hooks`) directly. **The two are not the same mechanism** — different event names, different configuration format, different scope — and this guide describes each vendor's real mechanism separately rather than assuming they match.

---

## 🚀 Step 1 — What a hook is for

A hook is code (or a configured check) that runs automatically at a specific point in an agent's lifecycle — before a tool runs, after a tool runs, when a session starts, etc. — and can inspect, log, or block what's about to happen.

### How GitHub Copilot CLI documents its own hooks (verified)

Per this session's own instruction material, Copilot CLI hooks live in `.github/hooks/*.json` and fire on these events: `sessionStart`, `sessionEnd`, `userPromptSubmitted`, `preToolUse`, `postToolUse`, `errorOccurred`. This is a real, verifiable mechanism of GitHub Copilot CLI specifically.

### How Claude Code documents its own hooks (verified, separately)

Per a direct fetch of Anthropic's current Claude Code hooks reference, Claude Code fires a much larger, differently-named set of lifecycle events, including (not exhaustive): `SessionStart`, `SessionEnd`, `UserPromptSubmit`, `PreToolUse`, `PermissionRequest`, `PermissionDenied`, `PostToolUse`, `PostToolUseFailure`, `PostToolBatch`, `SubagentStart`, `SubagentStop`, `Stop`, `StopFailure`, `PreCompact`, `PostCompact`, `WorktreeCreate`, `WorktreeRemove`, and more. Hook handlers can be shell commands, HTTP endpoints, MCP tool calls, LLM prompts, or subagents, and are configured per-project (e.g., under `.claude/hooks/`), matched to specific tools via a `matcher` field. Claude Code's own docs show a concrete worked example: a `PreToolUse` hook matched to the `Bash` tool, further narrowed with an `if: "Bash(rm *)"` condition, that spawns a script to block destructive `rm` commands before they execute.

**Do not assume these two vendors' hook systems are interchangeable** — the event names, matching syntax, and handler types are each product's own design. If you work with both tools, read each one's current docs rather than porting configuration directly between them.

### Three concrete examples

**1. 🧩 Illustrative — Pre-tool validation/blocking**

A `preToolUse` (or `PreToolUse`) hook that inspects a proposed shell command and refuses to let it run if it matches a destructive pattern:

```json
{
  "event": "preToolUse",
  "tool": "shell",
  "rule": "reject if command matches /rm\\s+-rf|DROP TABLE|git push --force/i",
  "action": "block",
  "message": "Destructive command blocked by policy hook — requires explicit human approval."
}
```

This is illustrative pseudo-configuration, not copy-pasteable for either product verbatim — the real syntax differs (see the verified Claude Code example above for its actual `matcher`/`if`/`command` shape). The *concept* — inspect before execution, block on match — is the transferable lesson.

**2. 🧩 Illustrative — Post-edit auto-formatting**

A `postToolUse`/`PostToolUse` hook that runs a formatter automatically after any file-write tool call succeeds:

```json
{
  "event": "postToolUse",
  "tool": "edit",
  "action": "run",
  "command": "prettier --write \"${file}\""
}
```

The transferable lesson: hooks aren't only for blocking — they're equally useful for automatically enforcing consistency (formatting, linting) after an action completes, without relying on the agent to remember to do it.

**3. 🧩 Illustrative — Audit logging**

A hook on every tool call (pre- or post-) that appends a structured record to an append-only log, independent of whatever the agent itself reports:

```json
{
  "event": "postToolUse",
  "action": "log",
  "destination": "audit.log",
  "fields": ["timestamp", "tool", "args", "success", "sessionId"]
}
```

This matters because it creates a record that exists **outside the agent's own narrative** — useful for after-the-fact review of what actually happened, especially once multiple agents or sessions are running (see [parallel_agents_and_fleets_guide.md](parallel_agents_and_fleets_guide.md)), and conceptually similar to the trace log built in [agents_and_subagents_lab.md Lab 7](agents_and_subagents_lab.md#agent-lab7), but implemented as an external hook instead of code inside the agent loop — so it keeps working even if the agent's own code has a bug in its tracing.

---

## 🚀 Step 2 — The permissions model: read vs. write vs. execute vs. network

Four broad categories of capability, each with a different blast radius if abused:

| Category | Example actions | Typical risk if unrestricted |
|---|---|---|
| **Read** | View files, query a database (`SELECT`), fetch a URL | Lowest risk alone, but can leak sensitive data if scope is too broad (e.g., reading credential files) |
| **Write** | Edit/create files, `INSERT`/`UPDATE` rows, modify config | Can corrupt or overwrite data; usually recoverable if version-controlled, less so for direct database writes |
| **Execute** | Run arbitrary shell commands, install packages, run scripts | Highest blast radius — can do literally anything the host process can do, including read+write+network combined |
| **Network** | Call external APIs, send emails/webhooks, open sockets | Can exfiltrate data or trigger real-world side effects (sending a message, charging a card) outside the local environment |

### Risky action → why it's risky → mitigation

| Risky action | Why it's risky | Mitigation |
|---|---|---|
| **Arbitrary shell execution** | A single command can read, write, delete, or exfiltrate anything the host process can reach — the broadest possible blast radius | Allowlist specific commands/args instead of free-form shell; run in a sandboxed/least-privilege environment (Step 4); require approval for anything outside the allowlist |
| **Destructive git operations** (force-push, hard reset, branch deletion) | Can permanently discard history or overwrite others' work, often silently and irreversibly on shared branches | Require human approval for any `--force`/`push -f`/destructive reset; prefer reversible operations (new branch, revert commit) by default |
| **Network calls to unknown/unvalidated hosts** | Can exfiltrate data to an attacker-controlled endpoint, or be tricked into fetching malicious content | Allowlist known hosts/domains; block requests to arbitrary or newly-seen hosts without explicit approval |
| **Secret/credential file reads** (`.env`, private keys, cloud credentials) | Exposes long-lived secrets that can be reused far beyond the current session if leaked into logs, model context, or a third party | Exclude credential paths from the agent's readable scope entirely; never pass secrets through model context if avoidable; rotate immediately if exposure is suspected |
| **Mass file deletion / bulk destructive edits** | A single mistaken glob or loop can delete or corrupt far more than intended, with no natural "are you sure" boundary | Require explicit approval above a threshold (e.g., more than N files); prefer soft-delete/move-to-trash over permanent delete when feasible; keep backups/version control current before bulk operations |

> [!WARNING]
> Mitigations are policy, not physical enforcement, unless backed by a real technical control. A documented allowlist in a config file is guidance the agent's harness is *designed* to respect — it is not equivalent to an OS-level permission boundary. For genuinely untrusted or high-stakes execution, pair policy with sandboxing (Step 4).

---

## 🚀 Step 3 — Approval gates: allowlist vs. denylist, and why "ask every time" doesn't scale

[agents_and_subagents_lab.md Lab 5](agents_and_subagents_lab.md#agent-lab5) already shows the mechanics of a single human-approval gate: one `RISKY_TOOLS` set, one `input()`/`Console.ReadLine()` prompt before executing. That code isn't re-derived here — go there for the working Python/C# example. This section is about the **design decision** of what goes in that set as a system grows past one or two tools.

### Allowlist design: "approved by default is empty; name what's safe"

```text
ALLOWED_WITHOUT_APPROVAL = {"get_order_status", "get_return_policy", "search_docs"}
# Anything NOT in this set requires approval, including every new tool added later.
```

- **Pro:** safe-by-default — a newly-added tool is automatically gated until someone explicitly marks it safe.
- **Con:** more approval prompts during active development, which can tempt developers to over-approve just to move fast.

### Denylist design: "approved by default is everything; name what's risky"

```text
RISKY_TOOLS = {"issue_refund", "cancel_order", "delete_account"}
# Anything NOT in this set runs automatically.
```

- **Pro:** fewer interruptions for the common case; matches [Lab 5](agents_and_subagents_lab.md#agent-lab5)'s existing example directly.
- **Con:** unsafe-by-default — a newly-added tool with real side effects runs automatically unless someone remembers to add it to the denylist. This is the more common real-world failure mode: a team adds a new "send email" tool, forgets to list it as risky, and it fires unsupervised.

**Practical guidance:** use a **denylist for well-understood, slow-growing tool sets** (like Lab 5's handful of order-management tools), but switch to an **allowlist as soon as tools are added by multiple people or automatically** (e.g., from a plugin/MCP server you didn't write) — the cost of one unnecessary approval prompt is far lower than the cost of one unreviewed destructive action slipping through a stale denylist.

### Why "ask every time" doesn't scale

A system that asks for approval on literally every tool call (including read-only, zero-risk ones like `get_order_status`) trains the human approver to click "yes" reflexively without reading the prompt — the exact failure mode approval gates exist to prevent. Reserve approval gates for actions in the risk table above (Step 2); let clearly safe, reversible, read-only actions run without interruption, same as [Lab 5](agents_and_subagents_lab.md#agent-lab5) only gates `issue_refund`, not `get_order_status`.

---

## 🚀 Step 4 — Sandboxing: limiting the blast radius

Sandboxing means running an agent's actions inside an isolated execution environment, so that even if something goes wrong (a bug, a bad model decision, a successful prompt injection), the damage is contained to that environment instead of spreading to the host system or production data.

Real-world mechanisms (conceptual — not a full infra tutorial):

- **Containers** (e.g., Docker) — package the agent's execution environment with its own filesystem view, so file writes/deletes stay inside the container's layer unless a volume is explicitly mounted. See [docker_practical_guide.md](docker_practical_guide.md) for hands-on container fundamentals.
- **VM isolation** — a full virtual machine gives even stronger separation (separate kernel, no shared process table), appropriate when you need to run genuinely untrusted code, not just untrusted *instructions* to a trusted execution engine.
- **Restricted service accounts** — even without containers/VMs, running an agent's execute/write/network actions under a service account with narrowly-scoped permissions (specific folder write access only, no production database credentials, no admin role) limits what any single compromised or misdirected action can reach — the same least-privilege principle used for human service accounts.

The common thread: **assume the agent will eventually do something wrong** (via bug, ambiguous instruction, or malicious input) and design the environment so that "wrong" has a small, recoverable blast radius — rather than relying solely on the agent (or its prompts) behaving correctly every time.

---

## ✅ Pre-flight Checklist

Before letting an agent execute real actions, confirm:

- [ ] Every write/execute/network-capable tool is explicitly categorized as safe-by-default or requires-approval (Step 2's table) — not left ambiguous
- [ ] The allowlist/denylist choice (Step 3) matches how fast and how many people are adding new tools to this system
- [ ] Destructive or hard-to-reverse actions (force-push, bulk delete, refund/payment, account deletion) require human approval, with no silent auto-retry path after a rejection
- [ ] Credential/secret files are excluded from the agent's readable scope, and no secret is ever echoed into model context or logs
- [ ] An audit trail exists independent of the agent's own self-reporting (hook-based logging or equivalent), so you can reconstruct what happened after the fact
- [ ] The execution environment is sandboxed appropriately for the trust level of the input (user-supplied instructions, untrusted documents, third-party plugins/MCP servers) — not running with full host privileges by default
- [ ] Someone has actually tested the rejection path (approval denied) end-to-end, not just the happy path — confirm the agent asks what to do next instead of retrying or failing silently
- [ ] Rate/volume limits exist for any action with a per-call cost or side effect (API calls, emails sent, records modified), especially once multiple agents can act concurrently (see [parallel_agents_and_fleets_guide.md](parallel_agents_and_fleets_guide.md))

## 🧠 What Just Happened?

You now have three distinct, composable governance layers: **hooks** intercept at specific lifecycle points (and differ in exact mechanism between GitHub Copilot CLI and Claude Code — verified separately above, not assumed identical); **permissions** define which categories of action (read/write/execute/network) are even reachable; and **human approval gates** insert a person into the loop for the specific high-risk subset, using the allowlist/denylist tradeoff from Step 3. None of these replace the others — a well-governed agent typically uses all three together.

## 🏋️ Exercise

Take the [Lab 6 orchestrator](agents_and_subagents_lab.md#agent-lab6) (Order Agent + Policy Agent) and write out, in a table of your own, which of its tools belong in a denylist (requires approval) vs. run freely, using the risk table in Step 2 as your reasoning — then add one new tool of your own design that is deliberately risky (e.g., `cancel_subscription`) and show it would correctly land in your denylist on first addition, not be missed.

## 🏋️ Exercise (capstone)

Design (in writing, pseudocode is fine, label 🧩 Illustrative) a `PreToolUse`-style hook for a hypothetical "AI coding agent" that blocks any shell command containing `rm -rf`, `git push --force`, or a reference to a `.env` file path, and logs every blocked attempt with a timestamp and the full proposed command to an append-only audit file — then write one paragraph explaining why this hook-based approach catches cases that a simple in-agent `if` check inside the agent's own code might miss (hint: what happens if the agent's own code has a bug, versus a hook that runs outside the agent's control flow).

## ✅ Checkpoint

- [ ] Can state, without checking this file, the real difference between GitHub Copilot CLI's documented hook events and Claude Code's documented hook events (not assuming they're the same)
- [ ] Can explain when to prefer an allowlist over a denylist for approval gates, with a concrete example of each failing if swapped
- [ ] Completed the risk-table exercise above with at least one newly-added tool correctly landing in the denylist
- [ ] Can name at least two real sandboxing mechanisms and explain, in one sentence each, what blast radius they limit

## 🔗 Related Topics

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md#agent-lab5) — the base single-tool human-approval gate this guide extends.
- [parallel_agents_and_fleets_guide.md](parallel_agents_and_fleets_guide.md) — why approval gates and audit trails matter more, not less, once multiple agents can act concurrently.
- [ai_memory_and_state_guide.md](ai_memory_and_state_guide.md) — the privacy/deletion obligations that apply once an agent's actions include writing persistent memory.
- [deep-research-report.md](deep-research-report.md) — the broader coding-assistant configuration handbook (Copilot/Codex/Claude Code setup), a related but distinct "agent" concept from the application agents built across these three guides.

## ➡️ Next

Return to the **[README](README.md)** for the full map, or revisit [agents_and_subagents_lab.md's "Scaling up" section](agents_and_subagents_lab.md#agent-scale) to see how these governance concepts fit into a production-hardening roadmap.
