# Claude Code Global Instructions

@~/.ai/ENGINEERING.md

## Claude Code application

- Apply the imported universal policy to every permitted user task; apply domain-specific methods only when relevant. Do not treat Claude Code's coding focus as a restriction on the subject of a request.
- For repository tasks, follow applicable project, directory, and local guidance. Keep project architecture, tool commands, and deployment instructions in project-level files or scoped rules/skills rather than here.
- Use only tools and permissions actually available in this session. Treat instructions as guidance, not as a replacement for permissions, sandboxing, or hooks.
- When debugging instruction loading, inspect `/context` and verify the imported file is present. User-level imports outside the working directory may not load in Claude Code desktop Cowork sessions.
