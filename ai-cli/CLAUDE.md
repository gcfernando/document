# Claude Code Global Instructions

@~/.ai/ENGINEERING.md

## Claude Code-specific guidance

- This file is intended for the Claude Code user-level location `~/.claude/CLAUDE.md`.
- Treat the imported engineering file as global defaults.
- Claude Code loads user, project, local, nested, and applicable rule files as context; discovered `CLAUDE.md` files are concatenated rather than acting as a strict override stack. Keep applicable instructions consistent.
- Claude Code may also read repository `AGENTS.md` files; if a project uses both `CLAUDE.md` and `AGENTS.md`, keep their overlapping guidance consistent.
- Claude Code also maintains its own **auto memory** (self-written notes from corrections/preferences, per repository, loaded every session). Treat it as a second context source alongside this file, not as something to hand-edit routinely.
- Keep repository-specific architecture, commands, framework conventions, and deployment procedures in project-level instructions rather than this user-level file.
- Use `CLAUDE.local.md` for private project-specific preferences that should not be committed.
- Use `.claude/rules/` for modular or path-specific project guidance; use skills for multi-step or task-specific procedures that do not belong in always-loaded context.
- Use `/context` to inspect loaded memory and instruction files.
- Use `/memory` to inspect memory and instruction configuration.
- Use `/doctor prompt-audit` on supported Claude Code versions to detect stale, conflicting, or invalid instructions.
- Imported files consume context; imports organize instructions but do not reduce context cost. Keep always-loaded guidance concise.
- Claude recommends targeting under roughly 200 lines per `CLAUDE.md` file; move narrowly scoped guidance to rules or skills instead of bloating global context.
- `@path` imports support relative and absolute paths. In normal Claude Code user-scope instructions, `@~/.ai/ENGINEERING.md` is valid.
- Claude Code desktop Cowork sessions have stricter external-import and linked-file rules; when Cowork compatibility is required, use an in-scope deployed copy rather than depending on an external user-scope import.
- Treat `CLAUDE.md` as behavioral context, not technical enforcement. Use permissions, hooks, sandboxing, managed policy, and other actual controls when enforcement is required.
