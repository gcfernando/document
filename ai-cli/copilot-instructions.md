# GitHub Copilot CLI Global Instructions

@ENGINEERING.md

## GitHub Copilot CLI-specific guidance

- This file is intended for the user-level location `$HOME/.copilot/copilot-instructions.md`, unless `COPILOT_HOME` changes the Copilot configuration directory.
- `@ENGINEERING.md` is intentionally a relative import. Deploy a byte-identical copy of the canonical `~/.ai/ENGINEERING.md` into the same Copilot custom-instructions directory as `ENGINEERING.md`.
- Treat the imported engineering file as global defaults.
- Copilot CLI can combine user-level, repository-wide, agent, and path-specific instruction files; it does not define a general precedence order among these file types. Avoid contradictory instructions.
- User-level modular instructions can also live under `$HOME/.copilot/instructions/**/*.instructions.md`.
- Repository-wide instructions can live in `.github/copilot-instructions.md`; path-specific instructions can live in `.github/instructions/**/*.instructions.md` and use `applyTo`.
- `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` can also be discovered as agent instruction files in supported repository locations.
- In custom instruction files that support imports, prefer a relative `@path` that stays inside the repository or local custom-instructions directory; this is the safest documented portable pattern.
- Use `/instructions` or `copilot instruction list` to inspect instruction sources discovered for the current session.
- Changes to custom instruction files are not immediately applied to an already-running CLI session; start a new session or resume/reload the session when validating edits.
- Do not assume every Copilot subagent receives repository instructions. The session agent and `general-purpose` subagent do; built-in `explore`, `task`, and `code-review` subagents do not by default.
- A custom subagent receives repository custom instructions only when `include-custom-instructions: true` is configured. Even then, do not assume it inherits extra personal instruction directories loaded only for the parent session.
- If the session is started with `--no-custom-instructions`, repository custom instructions are disabled for agents regardless of subagent settings.
- Copilot CLI ships a built-in GitHub MCP server; add other MCP servers via `/mcp add` or `copilot mcp add`, configured in `~/.copilot/mcp-config.json` (or a per-repo equivalent). Changes apply without a restart.
- Custom agents are `.agent.md` files in `.github/agents/` (project) or `~/.copilot/agents/` (personal); invoke with `/agent` or `copilot --agent <id>`. Restart the CLI after adding or editing one.
- Skills are folders containing `SKILL.md` under `.github/skills/`, `.claude/skills/`, `.agents/skills/` (project) or `~/.copilot/skills/`, `~/.agents/skills/` (personal). Avoid pre-approving `shell`/`bash` in a skill's `allowed-tools` unless you trust its source.
- Lifecycle hooks live in `.github/hooks/*.json` (`sessionStart`, `sessionEnd`, `userPromptSubmitted`, `preToolUse`, `postToolUse`, `errorOccurred`) and are not a substitute for real permission/sandbox enforcement.
- Keep project-specific architecture, commands, framework conventions, and deployment procedures in project-level instructions rather than this user-level file.
- Treat Markdown instructions as behavioral guidance, not technical enforcement. Use Copilot permissions, sandboxing, hooks, enterprise controls, operating-system controls, CI, branch protection, and credential boundaries when enforcement is required.
