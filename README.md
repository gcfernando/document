<div align="center">

# 📚 Knowledge Base

### *Four long-form, beginner-first guides to programming and databases*

**_By Gehan Fernando_**

</div>

---

> [!NOTE]
> **👥 Who this is for:** anyone starting from zero, plus students, junior developers, and professionals who want a single reliable reference.
> **🎯 The promise:** every guide explains each idea in plain English *before* showing code, and every idea comes with a runnable example.
> **📏 How to use it:** these are lab manuals, not novels. Read a section, type the example, run it, break it, fix it.

---

## 📖 What is in this collection

| Guide | Subject | Size | Start here if… |
|---|---|:---:|---|
| **[The Complete SQL Guide — MSSQL & MySQL](sql_complete_guide.md)** | Databases and SQL, taught twice: once for SQL Server, once for MySQL | 66 chapters | You want to store, find, and protect data |
| **[Complete OOP with Python](python_oop_guide.md)** | Object-oriented programming using modern Python | 39 sections | You want to learn software design, and prefer Python |
| **[Complete OOP with C# and .NET](csharp_dotnet_oop_guide.md)** | The same design ideas in C#, plus the .NET type system | 50 chapters | You want to learn software design, and prefer C# |
| **[The Complete Bible of Python Dunder Methods](python_dunder.md)** | Python's special methods — how `+`, `len()`, `with`, and `for` actually work on your own objects | 145 entries | You already write Python classes and want to go deeper |

---

## 🧭 Which one should I read first?

**You have never programmed before.**
Start with **[Complete OOP with Python](python_oop_guide.md)**. Python puts the least syntax between you and the idea. Read Sections 1–12 and stop; that is a complete, useful skill on its own.

**You have never used a database, but you can already program a little.**
Start with **[The Complete SQL Guide](sql_complete_guide.md)**. It assumes nothing — Chapter 1 begins with a spreadsheet. Chapters 1–5 take about an hour and give you the vocabulary everything else uses.

**You work on a .NET team, or you are studying C#.**
Start with **[Complete OOP with C# and .NET](csharp_dotnet_oop_guide.md)**. It teaches OOP and C# together, so you do not need the Python guide first.

**You already write Python classes comfortably.**
Go to **[The Complete Bible of Python Dunder Methods](python_dunder.md)**. Its intended prerequisite is Sections 1–6 of the Python OOP guide.

```text
      ┌──────────────────────────┐
      │   New to programming?    │
      └────────────┬─────────────┘
                   │
      ┌────────────┴─────────────┐
      │                          │
  Python path                 C# path
      │                          │
  python_oop_guide.md    csharp_dotnet_oop_guide.md
      │                          │
      │   (both lead to)         │
      └────────────┬─────────────┘
                   │
         sql_complete_guide.md   ← every real application stores data
                   │
         python_dunder.md        ← Python only, and only after OOP
```

---

## 🔗 How the guides relate to each other

- **The two OOP guides teach the same ideas in two languages.** Encapsulation, inheritance, polymorphism, SOLID, dependency injection, and domain modelling appear in both. If you know one, the other is largely a translation exercise — and reading the second one is a good way to check that you understood the *idea* rather than the *syntax*.

- **The dunder guide is the deep companion to the Python OOP guide.** Where the Python OOP guide says "Python has special methods that hook into built-in syntax" ([Section 25](python_oop_guide.md#25-special-methods-operators-nested-classes-and-code-organization)), the dunder guide covers every one of them in detail.

- **The SQL guide is independent of the other three.** It needs no programming background at all. It connects back to them in [Chapter 65](sql_complete_guide.md#65-sql-from-the-application-layer), which covers calling SQL from application code — including the Repository and Unit of Work patterns the OOP guides describe.

**Where the same idea appears twice:**

| Idea | Python OOP | C# / .NET | SQL |
|---|---|---|---|
| The four pillars of OOP | [§3](python_oop_guide.md#3-the-four-pillars-of-oop) | [Ch 4](csharp_dotnet_oop_guide.md#4--the-four-pillars-of-oop) | — |
| Interfaces / contracts | [§13 Protocols](python_oop_guide.md#13-protocols-and-interfaces) | [Ch 17 Interfaces](csharp_dotnet_oop_guide.md#17--interfaces) | — |
| SOLID principles | [§27](python_oop_guide.md#27-solid-principles) | [Ch 37](csharp_dotnet_oop_guide.md#37--solid-principles) | — |
| Dependency injection | [§28](python_oop_guide.md#28-dependency-injection) | [Ch 39](csharp_dotnet_oop_guide.md#39--dependency-injection) | — |
| Repository pattern | [§29.3](python_oop_guide.md#293--repository) | [Ch 40](csharp_dotnet_oop_guide.md#40--design-patterns-for-c-oop) | [Ch 65](sql_complete_guide.md#65-sql-from-the-application-layer) |
| Transactions / all-or-nothing | [§29.4 Unit of Work](python_oop_guide.md#294--unit-of-work) | [Ch 40](csharp_dotnet_oop_guide.md#40--design-patterns-for-c-oop) | [Ch 42 ACID](sql_complete_guide.md#42-transactions-and-acid) |
| Special methods / operators | [§25](python_oop_guide.md#25-special-methods-operators-nested-classes-and-code-organization) + [all of the dunder guide](python_dunder.md) | [Ch 32](csharp_dotnet_oop_guide.md#32--indexers-operators-tuples-and-everyday-essentials) | — |

---

## 🧰 What you need installed

Each guide has its own setup chapter; nothing here is required before you start reading.

| Guide | You will install | Setup chapter |
|---|---|---|
| Python OOP | Python 3.11+, and optionally `pytest`, `mypy`, `ruff` | [Section 1](python_oop_guide.md#1-prerequisites-and-setup) |
| Python dunder | Python 3.12+ (a few entries need 3.12 features) | [How These Examples Were Checked](python_dunder.md#-how-these-examples-were-checked) |
| C# / .NET | The .NET SDK (10 or later), plus an editor | [Chapter 2](csharp_dotnet_oop_guide.md#2--prerequisites-and-setup) |
| SQL | SQL Server 2019+ **or** MySQL 8.4 LTS — you only need one to begin | [Chapter 3](sql_complete_guide.md#3-installing-and-connecting) |

---

## 💻 How to run the code in these guides

All example code lives **inside** the Markdown files. There are no separate source files to download. Each guide marks its code blocks so you can tell at a glance what you are looking at:

| Marker | What it means | What to do |
|---|---|---|
| *(no marker)* | A complete program | Copy it into one file and run it |
| **▶️ Continues from §X** | Needs code from an earlier block | Paste it below that earlier block, in the same file |
| **📄 Fragment** | One file of a multi-file project, or a method shown without its class | Read it in place — it is not meant to run alone |
| **❌ Fails on purpose** | Deliberately broken, to show you the error | Read the error shown beside it |

Where output matters, an **Expected output** block follows the code.

---

## ✅ About the verification records

Each guide contains a section stating **what was verified and what was not**. This is deliberate, and it is worth understanding before you trust any technical document:

- A guide that says *"all code tested"* without saying **how**, **on what version**, and **which blocks** is asking for trust it has not earned.
- Each guide here states plainly which material was only reviewed by reading rather than executed — including administrative scripts, anything needing a paid edition, and every performance claim.

Find them here: [Python OOP](python_oop_guide.md#-how-to-run-the-examples-and-how-they-were-checked) · [Python dunder](python_dunder.md#-how-these-examples-were-checked) · [C#](csharp_dotnet_oop_guide.md#-what-was-actually-verified-and-how) · [SQL](sql_complete_guide.md#-what-was-verified-and-what-was-not).

> [!IMPORTANT]
> Passing examples prove the code runs and prints what is claimed **on one machine, on one version**. They do not prove the surrounding explanation is complete, nor that the design advice fits your situation. Run things yourself.

---

## 🎓 How to use the exercises, checkpoints, and quizzes

Every guide uses the same three devices, and they do different jobs:

| Device | Looks like | What it is for |
|---|---|---|
| **Hands-on exercises** | 🧪 *Try it yourself* / *Hands-on exercise* | Building the skill. Do these with your fingers, not your eyes. |
| **Checkpoints** | ✅ *Checkpoint* at the end of each part | Checking you can **explain** what you just read, not just recognise it |
| **Question banks and practice sets** | Interview questions, numbered exercise sets | Rehearsing recall under pressure |

> [!TIP]
> **The checkpoint is the honest test.** If you can answer *"What is this? Why does it matter? How does it work? Can I give an example?"* in your own words — not the guide's words — you have learned it. If you cannot, re-read that part. Recognising a good explanation is not the same as being able to produce one.

Answers sit in collapsible `<details>` blocks. Attempt first: the feeling of understanding you get from reading a solution is not the understanding you get from producing one.

---

<div align="center">

*Read them once. Use them forever. Break things on purpose.*

</div>
