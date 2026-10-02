<div align="center">

# 📚 Knowledge Base

### *Eight practical, long-form engineering guides — from programming fundamentals to cloud infrastructure and modern AI engineering, plus a worked AI-CLI example*

**_By Gehan Fernando_**

</div>

---

> [!NOTE]
> **👥 Who this is for:** self-learners, students, software engineers, senior developers, cloud/platform engineers, and anyone who wants practical references they can keep returning to.
> **🎯 The promise:** concepts are explained in plain language first, then connected to runnable code, hands-on labs, engineering trade-offs, troubleshooting, or authoritative documentation.
> **📏 How to use it:** treat these as **lab manuals and engineering references, not novels**. Read enough to understand the idea, then type, run, build, break, verify, and apply it.

---

## 📖 What is in this collection

| Guide | What it teaches | Scope | Start here if… |
|---|---|:---:|---|
| **[🌈 AI Journey](ai_journey.md)** | Practical AI engineering for .NET/C# + Python developers: LLM basics, prompting, tool calling, MCP, agents, RAG, evals, observability, security, and production engineering | 19 modules | You are already a developer but are new to modern AI and want a structured path from zero to real AI engineering |
| **[🤖 AI CLI Operating Handbook](deep-research-report.md)** | How to actually run Claude Code, OpenAI Codex, and GitHub Copilot CLI day to day: global/project instructions, task briefs, skills, custom agents/subagents, MCP, parallel agents, VS Code workflows, and troubleshooting | 15 parts (0–XV), beginner → expert | You want to use AI coding agents productively as daily tools, not just understand AI concepts |
| **[☁️ Azure Complete Engineering Cheatsheet](azure_cheatsheet.md)** | Azure architecture, identity, networking, compute, data, integration, AI, security, observability, IaC, DevOps, governance, cost, resilience, and production operations | 49 numbered sections + overview | You need the big-picture Azure engineering map: what exists, how it fits together, and how to choose between services |
| **[📦 Azure Resources Cheatsheet](azure_resources_cheatsheet.md)** | Resource-by-resource deep dive: Compute, networking, storage, databases, messaging, identity, monitoring, DevOps, AI — each with CLI, Bicep, and C# examples, comparison tables, and end-to-end deployment scenarios | 14 sections + resource catalog | You already know the Azure big picture and need to create, configure, secure, or troubleshoot one specific resource |
| **[🏛️ Complete OOP with C# and .NET](csharp_dotnet_oop_guide.md)** | Object-oriented programming from first principles through modern C#, SOLID, DI, testing, design patterns, and professional design | 50 chapters | You work with C#/.NET or want a rigorous OOP path in the .NET ecosystem |
| **[🐍 Complete OOP with Python](python_oop_guide.md)** | Python OOP from first class/object concepts through protocols, typing, SOLID, DI, testing, packaging, and professional design | 39 sections | You want to learn software design with Python or translate OOP knowledge into Pythonic practice |
| **[📖 The Complete Bible of Python Dunder Methods](python_dunder.md)** | Python special methods and attributes: object creation, operators, iteration, context managers, descriptors, async, metaclasses, introspection, and more | 145 entries | You already understand Python classes and want to know how Python's object model really works |
| **[🗄️ The Complete SQL Guide — MSSQL & MySQL](sql_complete_guide.md)** | SQL and relational databases from zero through querying, transactions, performance, design, security, administration, and application integration | 66 chapters | You want to learn databases from scratch or deepen production SQL knowledge in SQL Server and MySQL |

> [!TIP]
> **Worked example, not a standalone guide:** **[🧪 End-to-End AI Agent GraphQL Workflow](end_to_end_ai_agent_graphql_workflow.md)** takes one realistic bug ticket and solves it three times — once each with Codex, Claude Code, and Copilot CLI — with copy-paste prompts for every step, plus a condensed cheat sheet and reference appendix. Read it right after the **AI CLI Operating Handbook** to see the handbook's workflow applied to a single concrete scenario. The **[`ai-cli/`](ai-cli/)** folder holds the actual short, machine-loaded instruction files (`ENGINEERING.md`, `CLAUDE.md`, `AGENTS.md`, `copilot-instructions.md`) and sample `configuration/` files the handbook describes — use them as copy-paste starting points for your own projects.

---

## 🧭 Which guide should I read first?

### I am a professional developer and want to learn modern AI
Start with **[AI Journey](ai_journey.md)**.

It is designed specifically for developers who already know software engineering but are beginners in modern AI. The path moves from AI/LLM basics into prompting, C# and Python LLM applications, structured output, tool calling, MCP, agents, RAG, security, evaluation, observability, and production engineering.

### I want to use Claude Code, Codex, or Copilot CLI as a daily tool
Start with the **[AI CLI Operating Handbook](deep-research-report.md)**, then read **[End-to-End AI Agent GraphQL Workflow](end_to_end_ai_agent_graphql_workflow.md)**.

The handbook covers setup, global/project instructions, task briefs, skills, custom agents/subagents, MCP, and parallel-agent patterns for all three tools. The walkthrough then shows the same process applied, prompt by prompt, to one real bug ticket — useful if you only want to copy working prompts without reading the theory first.

### I need Azure for real engineering work
Use **[Azure Complete Engineering Cheatsheet](azure_cheatsheet.md)** first, then **[Azure Resources Cheatsheet](azure_resources_cheatsheet.md)**.

The first is less like a beginner programming course and more like an engineering map of Azure: what the major services are, how they fit together, how to choose between them, what production concerns matter, and where to verify changing platform details. The second goes one level deeper — once you know *which* resource you need, it shows how to actually create, configure, secure, and script that resource with the CLI, Bicep, and C#.

### I work mainly with C#/.NET
Start with **[Complete OOP with C# and .NET](csharp_dotnet_oop_guide.md)**.

It teaches OOP and modern C# together, then moves into professional design, SOLID, dependency injection, testing, patterns, and refactoring.

### I want to learn programming/OOP through Python
Start with **[Complete OOP with Python](python_oop_guide.md)**.

If you have never programmed before, begin with Sections 1–12. They give you a useful foundation without requiring you to finish the entire guide first.

### I already understand Python classes and want to go deeper
Read **[The Complete Bible of Python Dunder Methods](python_dunder.md)** after the early Python OOP material.

Its intended prerequisite is roughly Sections 1–6 of the Python OOP guide. From there it explains how Python connects your objects to syntax such as `+`, `len()`, `for`, `with`, comparisons, attribute access, async operations, and introspection.

### I want to learn databases or improve SQL
Use **[The Complete SQL Guide](sql_complete_guide.md)**.

It starts from first principles and does not require a programming background. You can learn with either SQL Server or MySQL; every major topic is shown for both engines.

---

## 🗺️ Suggested learning paths

### .NET engineer → AI / cloud engineer

```text
C# / .NET OOP
      │
      ├──────────────► SQL
      │                 │
      ├──────────────► Azure
      │                 │
      └──────────────► AI Journey
                        │
                        ├─ LLM apps
                        ├─ tool calling
                        ├─ MCP
                        ├─ agents
                        ├─ RAG
                        └─ production AI
```

A practical order is:

1. **[C# / .NET OOP](csharp_dotnet_oop_guide.md)** — strengthen language and design fundamentals if needed.
2. **[SQL](sql_complete_guide.md)** — understand persistent data, transactions, indexing, and application/database boundaries.
3. **[Azure](azure_cheatsheet.md)** — learn the cloud platform, identity, networking, deployment, observability, security, and operations.
4. **[AI Journey](ai_journey.md)** — build modern AI engineering skills on top of your existing software background.

You do **not** need to finish the first three before starting AI Journey. If your software fundamentals are already strong, go directly to the AI guide and use the others as references.

### Python engineering path

```text
Python OOP
    │
    ├──────────► Python Dunder Methods
    │
    ├──────────► SQL
    │
    └──────────► AI Journey
```

### Database-first path

```text
SQL fundamentals
      │
      ├─ application integration
      ├─ performance and indexing
      ├─ transactions and concurrency
      └─ cloud data services in Azure
```

---

## 🔗 How the guides relate to each other

- **The C# and Python OOP guides teach many of the same design ideas in different languages.** Encapsulation, inheritance, polymorphism, abstraction, interfaces/protocols, SOLID, dependency injection, testing, patterns, and domain modelling appear in both.
- **The Python dunder guide is the deep companion to Python OOP.** The OOP guide introduces special methods as part of normal Python design; the dunder guide explores the object model and Python's protocol hooks in depth.
- **The SQL guide is language-independent.** It connects back to application design through repositories, Unit of Work, transactions, migrations, concurrency, and calling SQL from application code.
- **The Azure guide provides the platform layer.** Its compute, networking, identity, data, messaging, observability, security, IaC, and deployment sections connect directly to real .NET/Python application architecture.
- **The Azure Resources Cheatsheet is the deep companion to the Azure guide.** The Azure guide gives the architecture-level map and decision criteria; the Resources cheatsheet gives the per-resource CLI/Bicep/C# mechanics once you have already decided what to build.
- **AI Journey sits on top of normal software engineering rather than replacing it.** It assumes you are a developer and focuses on using LLMs, tool calling, MCP, agents, RAG, evaluation, safety, observability, and production practices.
- **Azure and AI Journey overlap intentionally around enterprise AI.** Azure covers the platform/service-selection view; AI Journey covers the developer learning path and hands-on AI engineering workflow.
- **The AI CLI Operating Handbook is a different kind of "AI" topic from AI Journey.** AI Journey teaches you to *build* LLM-powered applications and agents; the handbook teaches you to *use* Claude Code, Codex, and Copilot CLI as everyday engineering tools (instructions, skills, subagents, MCP clients) — the two are complementary, not overlapping.
- **The End-to-End AI Agent GraphQL Workflow is the worked example for the handbook.** It takes the handbook's concepts (instructions, context, review) and runs them, prompt by prompt, through one realistic ticket in all three tools.

### Where important ideas cross between guides

| Idea | Python OOP | C# / .NET | SQL | Azure | AI Journey |
|---|---|---|---|---|---|
| Encapsulation / abstraction | [§3](python_oop_guide.md#3-the-four-pillars-of-oop) | [Ch 4](csharp_dotnet_oop_guide.md#4--the-four-pillars-of-oop) | — | Service boundaries and platform abstractions | Agent/tool boundaries and structured contracts |
| Interfaces / contracts | [§13](python_oop_guide.md#13-protocols-and-interfaces) | [Ch 17](csharp_dotnet_oop_guide.md#17--interfaces) | Schema/contracts | APIs, messaging, identity contracts | Structured output, tools, MCP |
| Dependency injection | [§28](python_oop_guide.md#28-dependency-injection) | [Ch 39](csharp_dotnet_oop_guide.md#39--dependency-injection) | — | .NET/Azure application patterns | Provider-neutral abstractions and AI application composition |
| Repository / data access | [§29.3](python_oop_guide.md#293--repository) | [Ch 40](csharp_dotnet_oop_guide.md#40--design-patterns-for-c-oop) | [Ch 65](sql_complete_guide.md#65-sql-from-the-application-layer) | Azure data services | RAG data/retrieval pipelines |
| Transactions / concurrency | [§29.4](python_oop_guide.md#294--unit-of-work) | [Ch 40](csharp_dotnet_oop_guide.md#40--design-patterns-for-c-oop) | [Ch 42](sql_complete_guide.md#42-transactions-and-acid) | Resilience and distributed systems | Reliable tool/workflow execution |
| Special methods / operators | [§25](python_oop_guide.md#25-special-methods-operators-nested-classes-and-code-organization) | [Ch 32](csharp_dotnet_oop_guide.md#32--indexers-operators-tuples-and-everyday-essentials) | — | — | — |
| Security | Validation and safe object design | Type safety, validation, secure design | Permissions, injection, backup | Identity, RBAC, network/security services | Prompt injection, approvals, tool security, supply chain |
| Observability | Testing/logging concepts | Testing and .NET practices | Monitoring and performance | Azure Monitor, App Insights, Log Analytics | Evals, traces, telemetry, AI observability |
| Production engineering | Project structure/testing | Design, testing, refactoring | Performance/admin/CI | Architecture, deployment, governance, resilience | Reliability, cost, rate limits, deployment, long-running work |

---

## 🧰 What you need installed

Each guide contains its own setup or prerequisite section. You do not need every tool below to use the repository.

| Guide | Typical requirements |
|---|---|
| **AI Journey** | .NET, Python, Git, VS Code and/or Visual Studio; provider/API access is introduced where needed |
| **AI CLI Operating Handbook** | Node.js (for `npm install`-based CLIs), Git, a terminal; the `claude`, `codex`, and `copilot` binaries/extensions as you install them per the handbook's Part XIV; API keys/subscriptions for whichever provider(s) you use |
| **Azure** / **Azure Resources Cheatsheet** | No single mandatory local setup for reading; Azure CLI/PowerShell, Bicep/Terraform, SDKs, and cloud access are used in relevant sections |
| **C# / .NET OOP** | .NET SDK and an editor/IDE |
| **Python OOP** | Python 3.11+; optional `pytest`, `mypy`/`pyright`, `ruff`, environments/tooling as introduced |
| **Python dunder** | Python 3.12+ for the full set of examples and version-specific entries |
| **SQL** | SQL Server 2019+ **or** MySQL 8.4 LTS; one engine is enough to begin |

> [!TIP]
> Install only what the guide section you are currently working through requires. A smaller learning environment is easier to troubleshoot. The **End-to-End AI Agent GraphQL Workflow** walkthrough needs no installation at all — every command/prompt is copy-pasteable and all shown output is explicitly labeled as simulated.

---

## 🧪 How the repository teaches

Although the guides cover different subjects, they share the same practical philosophy:

```text
Understand the idea
      ↓
See a concrete example
      ↓
Run / build it yourself
      ↓
Break or vary it
      ↓
Verify what happened
      ↓
Explain when to use it — and when not to
```

The **AI Journey** expresses this explicitly as:

```text
Understand → Open the official docs → Watch → Build → Verify → Troubleshoot
```

The OOP and SQL guides use exercises, checkpoints, examples, deliberate failures, expected output, and larger practical blocks. The Azure guide is more reference-oriented and adds service-selection guidance, architecture patterns, operational checklists, troubleshooting, and links to Microsoft documentation.

---

## 💻 How to use the code examples

Most examples are embedded directly in the Markdown files.

Common conventions in the programming/database guides include:

| Marker | Meaning | What to do |
|---|---|---|
| *(no marker)* | Complete/self-contained example | Put it in the appropriate file or tool and run it |
| **▶️ Continues…** | Depends on an earlier example | Keep the referenced earlier code with it |
| **📄 Fragment** | Part of a larger/multi-file example | Read it in context; it is not intended to run alone |
| **❌ Fails on purpose** | Deliberately invalid example | Study the shown failure and why it happens |

Where output matters, the guides show expected output or describe the expected result.

---

## ✅ Verification and freshness

These documents try to distinguish **tested facts**, **reviewed material**, and **version-sensitive platform information** instead of treating every statement as equally permanent.

- **[C# / .NET OOP](csharp_dotnet_oop_guide.md#-what-was-actually-verified-and-how)** documents the compiler/runtime environment used to check code blocks and explains which fragments were not executed.
- **[Python OOP](python_oop_guide.md#-how-to-run-the-examples-and-how-they-were-checked)** records the Python environment, code execution checks, type-checking scope, and version-dependent features.
- **[Python dunder](python_dunder.md#-how-these-examples-were-checked)** records the CPython version and how runnable examples were executed and compared with expected output.
- **[SQL](sql_complete_guide.md#-what-was-verified-and-what-was-not)** separates executed examples from material that requires environment-specific or administrative validation.
- **[AI Journey](ai_journey.md#-validation-status--30-september-2026)** records a multi-pass review covering beginner usability, .NET/Python engineering, agents/MCP, RAG/production, and current official documentation.
- **[AI CLI Operating Handbook](deep-research-report.md)** labels every command with one of three markers — ✅ Executed, 📚 Official-doc verified, or 🖥️ Platform syntax reviewed — because the `claude`/`codex`/`copilot` binaries were not all separately installable in the validating environment; check the legend near the top of the file before trusting any single command as run-tested.
- **[Azure](azure_cheatsheet.md)** and **[Azure Resources Cheatsheet](azure_resources_cheatsheet.md)** are intentionally explicit that production-critical limits, quotas, pricing, SLA details, regional availability, API versions, preview status, and compliance requirements must be rechecked against current Microsoft documentation.

> [!IMPORTANT]
> A successful example proves only what was actually tested in the stated environment. Cloud services, SDKs, AI products, model names, previews, quotas, pricing, platform limits, and documentation can change. For production decisions, verify current authoritative documentation.

---

## 🎓 Exercises, checkpoints, labs, and learning plans

Different guides use different mechanisms depending on the subject:

| Device | Where you will see it | Purpose |
|---|---|---|
| **🧪 Hands-on exercises / labs** | OOP, SQL, AI | Build the skill instead of only reading about it |
| **✅ Checkpoints / teach-back questions** | OOP, AI, SQL | Confirm you can explain the concept in your own words |
| **Expected result / output** | Programming, SQL, AI labs | Give you something concrete to verify |
| **Troubleshooting sections** | AI, Azure, programming guides | Teach how to recover when the happy path fails |
| **Learning plans** | AI, Azure, C#, Python, SQL | Turn a large reference into a manageable sequence |
| **Official documentation links** | Especially AI and Azure | Keep fast-changing platform details anchored to authoritative sources |

Useful built-in paths include:

- **AI Journey:** a complete **12-week execution plan**.
- **AI CLI Operating Handbook:** Parts 0–XV, from absolute-zero installation through parallel-agent patterns and an expert quick-reference appendix.
- **Azure:** a dedicated **learning roadmap**, troubleshooting playbook, production-readiness checklist, and official documentation directory.
- **Azure Resources Cheatsheet:** a resource-by-resource catalog plus end-to-end deployment scenarios (Docker → ACR → ACI/Container Apps/AKS, lift-and-shift, PaaS web app, serverless, RAG/AI app).
- **C# / .NET OOP:** a **30-day learning plan**.
- **SQL:** a roughly **35-day learning plan**.
- **Python OOP:** a staged five-part path from foundations to professional design and practice.
- **Python dunder:** a course path for the core parts plus a reference structure for later lookup.

---

## 📌 A simple rule for using this repository

Do not try to memorize everything.

Use each guide to answer four questions:

```text
1. What problem does this solve?
2. Can I explain it simply?
3. Can I build or use a small example myself?
4. Do I know when NOT to use it?
```

If you can answer those, move forward. If not, run another example, break something deliberately, or revisit the relevant section.

---

<div align="center">

**Learn the fundamentals. Build real things. Verify your assumptions. Keep the references.**

</div>
