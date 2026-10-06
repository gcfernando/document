# 🚀 MCP in Practice: Connecting AI Tools to Real Data and Actions

> Configure, inspect, and call a Model Context Protocol (MCP) server from a real AI tool in under 20 minutes.

**🏷️ Difficulty:** 🟡 Intermediate (🔴 for the stretch "build your own server" step)

> 🗓️ Last verified: 2026-10-06
> 📚 Official documentation:
> - MCP specification & architecture: https://modelcontextprotocol.io/docs/2026-07-28/learn/architecture
> - MCP SDKs & quickstarts: https://modelcontextprotocol.io/docs/2026-07-28/develop/build-server
> - VS Code MCP servers: https://code.visualstudio.com/docs/agent-customization/mcp-servers
> - MCP security best practices: https://modelcontextprotocol.io/docs/2026-07-28/tutorials/security/security_best_practices
>
> MCP is young and its spec/doc URLs are versioned by date (`2026-07-28` at time of writing). If a link 404s, start from `https://modelcontextprotocol.io/llms.txt` (the project's own documentation index) and re-verify before trusting any config shape below.

## 🎯 What You Will Build

By the end of this lab you will have:
1. Inspected the tools exposed by an already-configured MCP server (the GitHub MCP server running inside this very Copilot CLI session, plus a public filesystem server).
2. Written a real, verified `mcp.json` / `mcp-config.json` entry to add a new MCP server to VS Code or GitHub Copilot CLI.
3. Called an MCP tool from a chat/agent session and read back the structured result.
4. (Stretch, 🔴) Understood what it takes to write your own minimal MCP server, with an honest call on whether to show untested code.

## 🧠 What Is This?

**The one-sentence problem MCP solves:** MCP is a standard way for AI applications to connect to external data sources and tools, so integrations are built once against a common protocol instead of every vendor writing a bespoke connector per tool per AI app (official framing: "like a USB-C port for AI applications" — [source](https://modelcontextprotocol.io/docs/2026-07-28/getting-started/intro)).

### Core vocabulary (verified against the current spec)

| Term | Definition (per current MCP architecture docs) |
|---|---|
| **MCP Host** | The AI application that coordinates one or more MCP clients, e.g. VS Code, Claude Code, Claude Desktop. |
| **MCP Client** | A component inside the host that maintains one dedicated connection to one MCP server. |
| **MCP Server** | A program that exposes context (tools/resources/prompts) to clients. Can run locally (stdio transport) or remotely (Streamable HTTP transport). |
| **Tools** | Executable functions the AI can invoke to perform actions (file ops, API calls, DB queries). |
| **Resources** | Read-only data sources that provide context (file contents, DB records, API responses) — attached to a prompt, not "called" like a tool. |
| **Prompts** | Reusable interaction templates (system prompts, few-shot examples) the server can supply to the client. |

Two layers make this work: a **data layer** (JSON-RPC 2.0 messages: discovery, tools, resources, prompts, notifications) and a **transport layer** (stdio for local processes, Streamable HTTP for remote servers, with OAuth recommended for auth). You rarely touch these directly — the SDK and host app handle them — but it explains why an MCP server config only needs a *command* (stdio) or a *URL* (HTTP), nothing lower-level.

> 🧪 **Preview/experimental note:** The architecture docs flag **sampling** (a client-exposed primitive) as *deprecated* as of protocol version `2026-07-28`, and **elicitation** (servers asking the user for more input) as a newer client-side primitive. Both are less universally supported than tools/resources/prompts — verify before relying on either in production.

## 📚 Prerequisites

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md) — understand what a "tool call" is before layering MCP on top.
- [deep-research-report.md](deep-research-report.md) — this repo's existing handbook on configuring AI coding agents (Copilot CLI, Codex, Claude Code); MCP is one more thing you configure in those same tools.
- Familiarity with JSON and running commands in PowerShell.
- A supported MCP host already installed: VS Code with GitHub Copilot Chat, GitHub Copilot CLI (this session is one), or Claude Code/Claude Desktop.

## 🛠️ Setup

Nothing to install for the inspection labs below — you will use an MCP server that is **already running**: the built-in GitHub MCP server inside this Copilot CLI session. For the "add a new server" lab you'll add a small, well-known public server (the official filesystem server).

## 🚀 Step 1 — Inspect an already-configured MCP server's tools

This Copilot CLI session already has the GitHub MCP server configured and connected (you can see this because tool names like `github-mcp-server-list_issues`, `github-mcp-server-search_pull_requests`, and `github-mcp-server-get_file_contents` are directly usable). That naming pattern — `<server-name>-<tool-name>` — is exactly what the MCP *data layer* means by "tools": the server advertised these via a `tools/list`-style discovery call, and the host (Copilot CLI) surfaced them with a namespaced prefix so two servers can both expose a `search` tool without colliding.

To see this for yourself in a running session:

```text
/mcp
```

This opens Copilot CLI's MCP server management UI, where you can see configured servers and the tools each one exposes. You can also run:

```text
/env
```

which lists loaded MCP servers alongside instructions, skills, agents, hooks, and plugins — useful to confirm *what* is actually active before you ask the agent to use it.

**What to look for:** a tool's input schema (parameters), not just its name. MCP tools are self-describing — the client reads each tool's JSON schema to know what arguments to pass, the same way a REST API's OpenAPI spec describes endpoints.

## 🚀 Step 2 — Configure a new MCP server (verified current config shape)

VS Code and GitHub Copilot CLI both read a `servers`/`mcpServers` JSON object. Two real, verified formats exist depending on the tool:

**VS Code workspace format** (`.vscode/mcp.json`, top-level key `servers`):

```jsonc
{
  "servers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp"
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "D:\\KnowledgeBase"]
    }
  }
}
```

**Portable format** (`.mcp.json` at a project root, or `~/.copilot/mcp-config.json` / `$COPILOT_HOME/mcp-config.json` for GitHub Copilot tools — top-level key `mcpServers`):

```jsonc
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "D:\\KnowledgeBase"]
    }
  }
}
```

Both shapes are documented directly on VS Code's current MCP servers page ([source](https://code.visualstudio.com/docs/agent-customization/mcp-servers)), which explicitly lists `~/.copilot/mcp-config.json` as the portable, cross-Copilot-tool location — the exact file this CLI session itself reads MCP config from (`/mcp add` or `copilot mcp add` write to it).

⚠️ **Caution, directly from VS Code's docs:** "Local MCP servers can run arbitrary code on your machine. Only add servers from trusted sources, and review the publisher and server configuration before starting it."

To add a server interactively instead of hand-editing JSON:

```text
/mcp add
```

or, from a regular shell (not inside the CLI session):

```powershell
copilot mcp add
```

Both follow a guided flow that writes to `~/.copilot/mcp-config.json`.

## 🚀 Step 3 — Call an MCP tool and observe the result

Once a server is configured and the host trusts it, you invoke it the same way you'd invoke any built-in tool — by asking in natural language and letting the agent pick the right tool, or by referencing it explicitly. Example, using the filesystem server you configured in Step 2:

```text
List the files in D:\KnowledgeBase using the filesystem MCP server.
```

**What actually happens under the hood** (per the architecture spec):
1. The host's MCP client sends a `tools/list` request to discover the filesystem server's tools (already cached after the first connection).
2. The agent selects a matching tool (e.g. a `list_directory` tool) and sends a `tools/call` request with the required arguments.
3. The server executes the action locally and returns a structured JSON-RPC result.
4. The host renders that result back into the conversation — in Copilot CLI and VS Code, you're typically asked to **confirm** the call first, since MCP tools can have side effects.

## 💻 Complete Example

A minimal, verified `.mcp.json` combining a remote (GitHub) and a local (filesystem) server, usable by both VS Code and GitHub Copilot CLI:

```jsonc
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp"
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "D:\\KnowledgeBase"]
    }
  }
}
```

Save this as `.mcp.json` at a project root. ⚠️ Needs runtime verification: the exact behavior of `npx`-launched servers on Windows PowerShell (quoting of the Windows path argument) was reasoned through but not executed in this session — test it yourself before relying on it.

## ▶️ Run It

```powershell
# Open the MCP management UI inside an active Copilot CLI session
/mcp

# Or add a server via guided flow from a normal PowerShell prompt
copilot mcp add
```

## 👀 Expected Result

- `/mcp` (or `/env`) lists at least the server(s) you configured, each with its discovered tool names.
- Asking the agent to use a filesystem/GitHub tool triggers a confirmation prompt (unless you've pre-approved it), then returns real data (a file listing, an issue list, etc.) rather than a hallucinated answer.

## 🐛 Troubleshooting

- **Server doesn't appear:** confirm the JSON file location matches your tool's documented path exactly — Copilot CLI and VS Code both support several locations, but only the portable `mcpServers` files are read by *all* of them.
- **"untrusted server" prompt loops:** the host is working as designed — MCP explicitly requires you to trust a server before it runs; this is not a bug.
- **Tool call silently does nothing:** check `/env` to confirm the server actually connected (a misconfigured `command`/`args` fails silently in some hosts); re-run with the command directly in a terminal to see its own error output.

## 🏋️ Exercise

1. 🟢 Add the official filesystem MCP server scoped to this repo (`D:\KnowledgeBase`) and list its tools.
2. 🟡 Configure a **remote** MCP server (HTTP transport) and compare its discovery flow to the local stdio one — note what's different (auth headers vs. none).
3. 🔴 (Stretch) **Building your own server:** the official SDKs (Python `mcp`, TypeScript `@modelcontextprotocol/sdk`) ship minimal "echo"/"calculator" style quickstarts. We deliberately do **not** reproduce one inline here: a minimal server's exact decorator/import names shift between SDK versions, and shipping untested code in a teaching repo risks teaching a broken pattern. Instead, follow the official, currently-maintained quickstart directly: https://modelcontextprotocol.io/docs/2026-07-28/develop/build-server — run it, then come back and describe in your own words what each of `tools/list` and `tools/call` returned for your server.

## ✅ Checkpoint

You can explain, without looking back: what an MCP host/client/server each do, what the three server-side primitives are, where to put a new server's config for VS Code vs. Copilot CLI, and why you must explicitly trust a server before it runs.

## 🔒 Security Considerations

- **Local MCP servers run arbitrary code on your machine** — only add servers whose source you've reviewed or that come from a vetted registry (VS Code's own docs state this explicitly for `npx`/`uvx`-launched servers).
- **Tool permissions are coarse by default** — a server that exposes one "do everything" tool gives the AI (and anyone who can steer its prompts) the same blast radius as that tool's broadest capability; prefer servers with narrowly-scoped tools.
- **Data exfiltration risk via tool chaining** — an agent with both a "read local files" tool and a "call external HTTP endpoint" tool can be prompt-injected into reading a secret and sending it somewhere; this is a known class of risk across the whole MCP ecosystem, not specific to one server.
- **Remote (HTTP) servers add a network trust boundary** — verify the server's TLS identity and prefer OAuth-based auth (as MCP recommends) over long-lived bearer tokens pasted into config files.
- **Don't hardcode secrets in `mcp.json`** — VS Code's docs explicitly warn against this and point to `${input:...}` variables instead; treat any MCP config file the same way you'd treat a `.env` file.

## 🔗 Related Topics

- [agents_and_subagents_lab.md](agents_and_subagents_lab.md) — the tool-calling loop MCP plugs into.
- [deep-research-report.md](deep-research-report.md) — configuring Copilot CLI/Codex/Claude Code more broadly.
- [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) — how instruction files differ from MCP server config (instructions shape *behavior*, MCP servers add *capabilities*).
- [agent_skills_practical_guide.md](agent_skills_practical_guide.md) — skills are a different extensibility mechanism (prompt + scripts) that can itself call MCP tools.

## ➡️ Next

Read [ai_instructions_scopes_guide.md](ai_instructions_scopes_guide.md) to understand how the *same* AI tools you just gave new capabilities to can also be given persistent behavioral instructions at different scopes.
