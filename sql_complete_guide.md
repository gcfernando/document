<div align="center">

# 🗄️ The Complete SQL Guide — MSSQL & MySQL

### *From "what is a table?" to "I can design, tune, secure, and scale a real database."*

**_By Gehan Fernando_**

![Level](https://img.shields.io/badge/Level-Absolute%20Beginner%20%E2%86%92%20Expert-blue?style=for-the-badge)
![MSSQL](https://img.shields.io/badge/Microsoft%20SQL%20Server-2019%2B-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.4%20LTS-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Chapters](https://img.shields.io/badge/Chapters-66-orange?style=for-the-badge)
![Examples](https://img.shields.io/badge/Every%20example-Real%20World-success?style=for-the-badge)
![Verified](https://img.shields.io/badge/MSSQL%20scripts-Re--verified%20on%20SQL%20Server%202025-brightgreen?style=for-the-badge)

**[🚀 Start here](#-start-here--your-first-hour)** &nbsp;·&nbsp; **[📚 Contents](#-table-of-contents)** &nbsp;·&nbsp; **[🎨 Box legend](#-how-to-read-the-colored-boxes-your-legend)** &nbsp;·&nbsp; **[📖 Glossary](#667--glossary)**

</div>

---

> ### 📖 What this guide is
>
> A **complete, self-contained course in SQL**, written twice for every single topic:
> once for **Microsoft SQL Server** (its version of SQL is called **T-SQL**) and once for **MySQL**.
>
> Every concept is explained as if to someone who has **never seen a database before**,
> and then demonstrated with **code from a real online store** you can run today.
>
> Nothing is assumed. Nothing is skipped. Nothing is left as *"you'll figure it out."*

---

## 🎯 Who this guide is for

| You are... | What this guide gives you |
|---|---|
| 🌱 **A complete beginner** | Plain-English explanations with zero jargon. Start at Chapter 1 and never feel lost. |
| 🎓 **A student** | Every exam and interview topic, with practice exercises and a capstone project. |
| 👨‍💻 **A developer** | The queries, joins, window functions, and anti-patterns you use daily in both engines. |
| 🏗️ **A senior engineer** | Execution plans, indexing strategy, isolation levels, partitioning, and design trade-offs. |
| 🛡️ **A DBA** (database administrator) | Security, backup/restore, replication, monitoring, and maintenance for both platforms. |
| 📊 **An analyst** | Aggregations, pivots, ranking, cohort and running-total recipes that answer business questions. |

> [!NOTE]
> - **🧰 What you need:** SQL Server 2019 or newer (the free **Developer** or **Express** edition is fine) and/or **MySQL 8.4 LTS**. You can start with just one of them.
> - **✅ Verification:** see [What was verified, and what was not](#-what-was-verified-and-what-was-not) below — it states precisely which scripts were executed, on which engine, and which were not.
> - **🎯 Goal:** take you from *"I don't know what a row is"* to *"I can design, query, speed up, secure, and run a real database."*
> - **⏱️ How long:** about 35 focused days if you follow the plan in [Chapter 66](#666--your-35-day-learning-plan).
> - **📌 MySQL version note:** MySQL 8.0 reached end of life in April 2026. Install **8.4 LTS**. Scripts here generally work on 8.0.31+, but new installs should not start on an unsupported release.

---

## 🚀 Start here — your first hour

New to databases? Do these four steps **in this order**. Each one takes about 15 minutes.

| Step | What to do | Why | What you should see at the end |
|:---:|---|---|---|
| **1** | Read [Chapter 1](#1-what-a-database-really-is) and [Chapter 2](#2-what-sql-is-and-the-two-engines-we-use) | Learn the handful of words everything else uses | You can explain what a *table*, a *row*, and a *query* are |
| **2** | Install one database and one tool — [Chapter 3](#3-installing-and-connecting) | You need somewhere to run SQL | A window where you can type SQL, connected to your own database server |
| **3** | Build the practice shop database — [Chapter 4](#4-the-sample-database-shopdb) | Every example in this guide uses it | The row counts in section 4.6 match the guide exactly |
| **4** | Run your first real questions — [Chapter 13](#13-select-the-heart-of-sql) | This is the moment SQL starts to make sense | Real customers and products from the shop appear on your screen |

> [!TIP]
> **You only need one engine to begin.** Choose **SQL Server** if you use Windows or work with Microsoft products. Choose **MySQL** if you build websites or use a Mac or Linux. Every lesson shows both, so you can add the other one later.

---

## 🧭 The learning path

```text
        🌱 BEGINNER                    🚀 INTERMEDIATE                  🏆 EXPERT
   ┌──────────────────────┐      ┌──────────────────────┐     ┌──────────────────────┐
   │  1  Foundations      │      │  6  Combining tables │     │ 10  Performance      │
   │  2  Building blocks  │ ───► │  7  Analytics        │ ──► │ 11  Design           │
   │  3  CRUD             │      │  8  Database objects │     │ 12  Admin & security │
   │  4  Functions        │      │  9  Transactions     │     │ 13  Modern & expert  │
   │  5  Grouping         │      │                      │     │ 14  Engineering      │
   └──────────────────────┘      └──────────────────────┘     └──────────────────────┘
      Ch 1–27  · ~12 days           Ch 28–45  · ~10 days         Ch 46–66  · ~10 days

        you can now                    you can now                   you can now
      query one table              answer real business          make it fast, safe,
      and build a schema           questions across tables        and production-ready
```

| Part | Chapters | Level | What you unlock |
|:---:|:---:|:---:|---|
| 1 · Foundations | 1–5 | 🟢 | Understand what a database *is* and how a query runs |
| 2 · Building blocks | 6–11 | 🟢 | Design and create tables that protect their own data |
| 3 · CRUD (create, read, update, delete) | 12–19 | 🟢 | Read and change data safely |
| 4 · Functions | 20–24 | 🟢 | Turn raw data into readable output |
| 5 · Grouping | 25–27 | 🟢🟡 | Summarize millions of rows into answers |
| 6 · Combining tables | 28–32 | 🟡 | **Joins** — the skill that separates beginners from users |
| 7 · Analytics | 33–35 | 🟡 | **Window functions** — ranking, running totals, trends |
| 8 · Database objects | 36–41 | 🟡 | Views, procedures, functions, triggers |
| 9 · Transactions | 42–45 | 🟡🔴 | Correctness under concurrency |
| 10 · Performance | 46–50 | 🔴 | Indexes, plans, and making slow things fast |
| 11 · Design | 51–53 | 🔴 | Normalization, star schemas, modelling |
| 12 · Admin & security | 54–57 | 🔴 | Permissions, injection, backups, monitoring |
| 13 · Modern & expert | 58–62 | 🔴 | JSON, dynamic SQL, collation, time zones, row history |
| 14 · Engineering practice | 63–65 | 🔴 | Concurrency patterns, migrations and CI, calling SQL from code |
| 15 · Putting it together | 66 | 🔴 | Anti-patterns, cheat sheets, exercises, the capstone |

> 🙋 **Seeing words you do not know yet** — *concurrency*, *normalization*, *JSON*, *collation*, *CI*? That is completely normal. Every one is explained in plain English in its own chapter, and all of them are in the [Glossary](#667--glossary). You do not need to understand this table to start.

> 🚦 **In a hurry?** Five honest shortcuts:
> - **"I just need to write queries this week."** → Chapters 4, 13, 14, 16, 25, 26, **28** — then stop. That is 80% of daily SQL.
> - **"I have an interview on Friday."** → Chapters 5, 15, 19, 26, 28, 30, 33, 42, 46, 51 + the question bank in 66.3.
> - **"Something is slow in production right now."** → Go straight to Chapters 46, 47, 48. Start with 48.1.
> - **"I write application code that talks to a database."** → Chapters 55, 63, 65 — parameterization, concurrency, and the calling patterns that cause most outages.
> - **"We change our schema by hand and it scares me."** → Chapter 64, then 56.

---

## 🔍 What was verified, and what was not

A guide that says "everything is tested" without saying *how* is asking for trust it has not earned.
Here is the precise position.

### ✅ Executed and confirmed

| What | How |
|---|---|
| **The ShopDB build script** ([§4.3](#43--build-shopdb--mssql-version)) and all seed data ([§4.5](#45--seed-the-data-identical-in-both-engines)) | Run start-to-finish on a clean instance |
| **The row counts in [§4.6](#46--verify-your-build)** | Every one of the eight counts reproduced exactly |
| **The MSSQL/T-SQL query blocks** | Extracted and executed against the freshly built ShopDB; blocks that change data ran inside a transaction that was rolled back |
| **Sampled published result tables** | Compared cell-by-cell against live output |
| **Error messages quoted in the text** | Confirmed, including `Msg 8114` in [§23.3](#233-️-implicit-conversion--the-silent-performance-killer) |

**Engine used for that pass:** Microsoft SQL Server **2025 (RTM-CU3), Express Edition**, 17.0.4025.3,
on Windows 11.

### ⚠️ Not executed — and you should know which

| What | Why not | What that means for you |
|---|---|---|
| **Every MySQL block** | No MySQL instance was available for this verification pass | The MySQL scripts were reviewed by reading against the MySQL 8.4 reference manual, not run. Treat them as carefully checked, not machine-confirmed |
| **Administrative scripts** — `BACKUP`, `RESTORE`, `CREATE LOGIN`, `DBCC`, replication, `sp_configure` | Running them would alter or damage a real server | Read them; run them only on an instance you own and can rebuild |
| **Partitioning, Full-Text, and columnstore examples** ([Ch 50](#50-partitioning-and-very-large-tables), [Ch 58](#58-json-xml-and-semi-structured-data)) | Require features or editions not present on Express | Syntax reviewed; behaviour not observed |
| **Anything requiring Enterprise edition** — for example `WITH (ONLINE = ON)` index rebuilds | Express edition refuses them (`Msg 1712`) | The syntax is correct; the feature needs the right edition |
| **Timing and "this is faster" statements** | No benchmark was run for this guide | Every such claim is explained by **mechanism** and stated with **conditions**. None is a measured figure. **Measure on your own data before acting on any of them** |

### 📌 Version sensitivity

SQL Server 2025 accepted every T-SQL block, but the guide targets **2019+**. Where a feature needs a
newer release the text says so inline — for example `STRING_AGG` (2017+), `AT TIME ZONE` (2016+),
`GENERATE_SERIES` (2022+), and `TRIM` with characters (2022+). If a script fails on your server, check
the version note beside it first.

---

## 🧾 How to read the code blocks

Every SQL block in this guide carries an engine marker as its **first comment line**. That marker is
the most important thing on the block — SQL Server and MySQL disagree about syntax far more often
than beginners expect.

| Marker | Meaning |
|---|---|
| `-- ✅ Works in BOTH` | Standard SQL. Paste into either engine unchanged |
| `-- 🟥 MSSQL` or `-- ✅ MSSQL` | **SQL Server only.** Will not run on MySQL |
| `-- 🟦 MySQL` or `-- ✅ MySQL` | **MySQL only.** Will not run on SQL Server |
| `-- ❌ ...FAILS...` | **Deliberately broken**, to show you the error. The expected message is given with it |

> [!WARNING]
> ⚠️ **Some blocks show both engines in one box**, with a `-- 🟥 MSSQL` section followed by a
> `-- 🟦 MySQL` section. **Do not paste the whole box into one query window** — run only the half for
> the engine you are using. The other half will raise a syntax error, and it is not a mistake in the
> script.

### 🔁 Blocks that build on earlier ones

Most chapters are cumulative: a query in §11.4 may drop a column that §11.1 added. If a script
complains that an object *does not exist* or *already exists*, you have almost certainly run the
chapter out of order.

**The reset is always the same, and it is cheap:**

```text
1. Re-run the build script for your engine  — §4.3 (MSSQL) or §4.4 (MySQL)
2. Re-run the seed data                      — §4.5
3. Re-run the verification query             — §4.6, and check the eight counts
```

That takes a few seconds and puts ShopDB back exactly as this guide assumes. **Do this whenever a
result stops matching the guide** — it is faster than working out which experiment left something
behind, and the chapters from 8 onwards deliberately create, alter, and drop objects.

> [!TIP]
> 💡 **Keep the three scripts from Chapter 4 in a file called `rebuild_shopdb.sql`.** You will use it
> more than any other script in this guide, and being able to destroy your practice data without
> worrying is what lets you experiment properly.

---

## 🗺️ How to read this guide (please read this first!)

> [!IMPORTANT]
> **Do not read this like a novel. Use it like a lab manual.** 🔬
> SQL is learned with your **fingers**, not your eyes. A query you only read is a query you do not know.

For **every** topic, follow this 7-step loop:

| Step | Action | Why it matters |
|:---:|---|---|
| 1️⃣ | **Read** the plain-English explanation | Understand *what problem* it solves |
| 2️⃣ | **Type** the example by hand | Muscle memory beats copy-paste |
| 3️⃣ | **Run** it against the sample database | See real rows come back |
| 4️⃣ | **Break** it on purpose | Errors are your best teacher |
| 5️⃣ | **Fix** it | Learn how SQL fails and recovers |
| 6️⃣ | **Change** it into your own question | Make the idea yours |
| 7️⃣ | **Check the plan** with `EXPLAIN` — the database shows *how* it ran your query | Learn *why* it was fast or slow (skip this step until you reach Chapter 47) |

---

## 🎨 How to read the colored boxes (your legend)

The guide uses the same colored boxes everywhere, so you always know what kind of information you are looking at:

> [!NOTE]
> 📌 **In plain words** — the idea explained with zero jargon. If you read nothing else, read these.

> [!TIP]
> 💡 **Pro tip** — a shortcut or a good habit that experienced people use.

> [!IMPORTANT]
> 🎯 **When to use it** — the situations where this feature is the right choice.

> [!WARNING]
> ⚠️ **Watch out** — a trap that catches people, and how to avoid it.

> [!CAUTION]
> 🐛 **Common mistake** — an error you will very likely hit, and how to fix it.

> 🌍 **Analogy** — an everyday comparison that makes the idea stick (shown in a plain grey box).

**Other icons you will meet:**

| Icon | Meaning |
|:---:|---|
| 🔀 | **MSSQL vs MySQL** — where the two engines behave differently |
| 🧪 | **Try it yourself** — hands-on exercises at the end of every chapter |
| 🔎 | **Go deeper** — a link to the chapter that covers this properly |
| 🟢 🟡 🔴 | **Level** — beginner, intermediate, expert |

**Every code block is labelled on its first line**, so you always know where to run it:

| First line of the block | What it means |
|---|---|
| `-- 🟥 MSSQL` or `-- ✅ MSSQL` | Run it in **SQL Server** only |
| `-- 🟦 MySQL` or `-- ✅ MySQL` | Run it in **MySQL** only |
| `-- ✅ Works in BOTH` | Runs unchanged in **both** engines |
| `-- ❌ …` | **This example is meant to fail.** Run it anyway and read the error message — the error *is* the lesson |

> [!TIP]
> 💡 **How to run a code block:** copy it into a new query window in your tool, then run it — **F5** in SSMS, **Ctrl + Shift + Enter** in MySQL Workbench, **Ctrl + Shift + E** in VS Code, **Alt + X** in DBeaver. The results appear in a grid under your query.

```sql
-- ✅ MSSQL (T-SQL)
SELECT TOP 5 * FROM customers;
```

```sql
-- ✅ MySQL
SELECT * FROM customers LIMIT 5;
```

---

## 📚 Table of contents

<details>
<summary><b>📂 Click to expand the full 66-chapter map</b></summary>

### 🌱 Part 1 — Foundations (start here if you know nothing)

1. [What a database really is](#1-what-a-database-really-is)
2. [What SQL is, and the two engines we use](#2-what-sql-is-and-the-two-engines-we-use)
3. [Installing and connecting](#3-installing-and-connecting)
4. [The sample database: ShopDB](#4-the-sample-database-shopdb)
5. [How a query actually runs](#5-how-a-query-actually-runs)

### 🧱 Part 2 — Building blocks

6. [Data types](#6-data-types)
7. [Creating databases and schemas](#7-creating-databases-and-schemas)
8. [Creating tables](#8-creating-tables)
9. [Constraints, the rules that protect your data](#9-constraints-the-rules-that-protect-your-data)
10. [Auto-numbering: IDENTITY vs AUTO_INCREMENT](#10-auto-numbering-identity-vs-auto_increment)
11. [ALTER and DROP](#11-alter-and-drop)

### 📥 Part 3 — Working with data (CRUD)

12. [INSERT, putting data in](#12-insert-putting-data-in)
13. [SELECT, the heart of SQL](#13-select-the-heart-of-sql)
14. [WHERE, asking precise questions](#14-where-asking-precise-questions)
15. [NULL, the value that is not there](#15-null-the-value-that-is-not-there)
16. [ORDER BY, sorting results](#16-order-by-sorting-results)
17. [Paging: TOP, LIMIT, OFFSET, FETCH](#17-paging-top-limit-offset-fetch)
18. [UPDATE, changing data](#18-update-changing-data)
19. [DELETE, TRUNCATE, DROP](#19-delete-truncate-drop)

### 🧮 Part 4 — Functions

20. [String functions](#20-string-functions)
21. [Numeric and math functions](#21-numeric-and-math-functions)
22. [Date and time functions](#22-date-and-time-functions)
23. [Conversion and casting](#23-conversion-and-casting)
24. [Conditional logic: CASE, IIF, IF](#24-conditional-logic-case-iif-if)

### 📊 Part 5 — Grouping and aggregation

25. [Aggregate functions](#25-aggregate-functions)
26. [GROUP BY and HAVING](#26-group-by-and-having)
27. [ROLLUP, CUBE, and GROUPING SETS](#27-rollup-cube-and-grouping-sets)

### 🔗 Part 6 — Combining tables

28. [JOINs, the complete picture](#28-joins-the-complete-picture)
29. [Set operators: UNION, INTERSECT, EXCEPT](#29-set-operators-union-intersect-except)
30. [Subqueries and EXISTS](#30-subqueries-and-exists)
31. [CTEs and recursive queries](#31-ctes-and-recursive-queries)
32. [APPLY and LATERAL](#32-apply-and-lateral)

### 📈 Part 7 — Analytics

33. [Window functions](#33-window-functions)
34. [Ranking, running totals, and moving averages](#34-ranking-running-totals-and-moving-averages)
35. [PIVOT and UNPIVOT](#35-pivot-and-unpivot)

### 🏗️ Part 8 — Database objects

36. [Views](#36-views)
37. [Stored procedures](#37-stored-procedures)
38. [User-defined functions](#38-user-defined-functions)
39. [Triggers](#39-triggers)
40. [Temporary tables and table variables](#40-temporary-tables-and-table-variables)
41. [Sequences and generated columns](#41-sequences-and-generated-columns)

### 🔐 Part 9 — Transactions and integrity

42. [Transactions and ACID](#42-transactions-and-acid)
43. [Isolation levels, locking, and deadlocks](#43-isolation-levels-locking-and-deadlocks)
44. [MERGE and UPSERT](#44-merge-and-upsert)
45. [Error handling](#45-error-handling)

### ⚡ Part 10 — Performance

46. [Indexes, the complete guide](#46-indexes-the-complete-guide)
47. [Execution plans](#47-execution-plans)
48. [Query optimization and SARGability](#48-query-optimization-and-sargability)
49. [Statistics and the optimizer](#49-statistics-and-the-optimizer)
50. [Partitioning and very large tables](#50-partitioning-and-very-large-tables)

### 📐 Part 11 — Design

51. [Normalization, 1NF to BCNF](#51-normalization-1nf-to-bcnf)
52. [Denormalization and when to break the rules](#52-denormalization-and-when-to-break-the-rules)
53. [Data modeling and the star schema](#53-data-modeling-and-the-star-schema)

### 🛡️ Part 12 — Administration and security

54. [Security: users, roles, and permissions](#54-security-users-roles-and-permissions)
55. [SQL injection and how to stop it](#55-sql-injection-and-how-to-stop-it)
56. [Backup, restore, and disaster recovery](#56-backup-restore-and-disaster-recovery)
57. [Monitoring and maintenance](#57-monitoring-and-maintenance)

### 🚀 Part 13 — Modern and expert topics

58. [JSON, XML, and semi-structured data](#58-json-xml-and-semi-structured-data)
59. [Dynamic SQL, cursors, and set-based thinking](#59-dynamic-sql-cursors-and-set-based-thinking)
60. [Collation, character sets, and Unicode](#60-collation-character-sets-and-unicode)
61. [Time zones and global data](#61-time-zones-and-global-data)
62. [Temporal tables, history, and change tracking](#62-temporal-tables-history-and-change-tracking)

### 🧰 Part 14 — Engineering practice

63. [Concurrency patterns for real applications](#63-concurrency-patterns-for-real-applications)
64. [Database DevOps: migrations, standards, and testing](#64-database-devops-migrations-standards-and-testing)
65. [SQL from the application layer](#65-sql-from-the-application-layer)

### 🏁 Part 15 — Putting it all together

66. [Anti-patterns, cheat sheets, exercises, and the capstone](#66-anti-patterns-cheat-sheets-exercises-and-the-capstone)

</details>

---

# 🌱 PART 1 — FOUNDATIONS

---

# 1. What a database really is

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 10 min | Explain what a database, table, row, and column are · Say why a database is safer than a spreadsheet |

> [!NOTE]
> 📌 **In plain words:** A database is an organized place to keep information so that you can **find it again quickly**, **trust that it is correct**, and **let many people use it at the same time without chaos**.

## 1.1 🌍 Start with something you already know: a spreadsheet

Imagine a spreadsheet for a small shop:

| customer_id | full_name | email | city |
|---|---|---|---|
| 1 | Amara Silva | amara@example.com | Colombo |
| 2 | John Baker | john@example.com | London |
| 3 | Mei Chen | mei@example.com | Singapore |

That is already a database in miniature. Look at the vocabulary:

| Spreadsheet word | Database word | What it means |
|---|---|---|
| File | **Database** | The whole collection |
| Sheet / tab | **Table** | One kind of thing (customers, orders, products) |
| Row | **Row** (or *record*) | One single thing (one customer) |
| Column | **Column** (or *field*) | One fact about that thing (their email) |
| Column header | **Column name + data type** | The name *and* the kind of value allowed |
| The "ID" column | **Primary key** | The value that uniquely identifies a row |

> 🌍 **Analogy:** A table is a **filing cabinet drawer**. Each folder in the drawer is a row. Each folder has the same labelled pockets (columns): name, email, city. The primary key is the number written on the folder tab so you can find it instantly.

## 1.2 ❓ So why not just use a spreadsheet?

A spreadsheet breaks the moment your shop becomes real. Here is exactly where it fails and what a database does instead:

| Problem with a spreadsheet | What a real database does |
|---|---|
| Two people edit at once, one change is lost | **Transactions and locking** keep every change safe |
| Someone types "Colomb0" in the city column | **Constraints** reject invalid data at the door |
| 5 million rows makes it unusable | **Indexes** find a row in milliseconds among billions |
| The customer name is retyped in 900 order rows | **Relationships** store the name once and link to it |
| Power cut halfway through a sale | **Durability**: once a change is saved (*committed*), a crash cannot lose it |
| Anyone who opens the file sees salaries | **Permissions** control who sees what, column by column |
| "Delete the last 3 months" was a mistake | **Backups** — and *point-in-time restore*, which rewinds the data to an exact moment — undo it |

> [!NOTE]
> 📌 **In plain words:** A spreadsheet stores data. A database **protects** data.

## 1.3 🧩 The vocabulary you need for the rest of this guide

| Term | Simple explanation | Example from our shop |
|---|---|---|
| **Database** | The whole container | `ShopDB` |
| **Table** | One list of one kind of thing | `customers` |
| **Row** | One item in that list | Customer #7, Amara Silva |
| **Column** | One fact about the item | `email` |
| **Data type** | What kind of value is allowed | `DECIMAL(10,2)` for money |
| **Primary key (PK)** | The unique ID of a row | `customer_id` |
| **Foreign key (FK)** | A pointer to a row in another table | `orders.customer_id` points at `customers` |
| **Index** | A sorted lookup list that makes searching fast | index on `customers.email` |
| **Query** | A question you ask the database | "Who bought a laptop last month?" |
| **Schema** | The blueprint: which tables and columns exist | The design of `ShopDB` |
| **Transaction** | A group of changes that all succeed or all fail | Take money **and** ship the item |
| **RDBMS** | *Relational database management system* — the software that runs all of this | SQL Server, MySQL |

> 🌍 **Analogy for a foreign key:** In a school, the class register does not repeat every student's home address. It writes the **student number**, and the address lives once in the student file. If the family moves, you update **one** place. That student number in the register is a foreign key.

## 1.4 🏛️ What "relational" means

The **R** in RDBMS means *relational*. It simply means: **split your data into small, focused tables and connect them by keys**, instead of one giant table that repeats itself.

**❌ The bad, repeating way (one giant table):**

| order_id | customer_name | customer_email | customer_city | product | price |
|---|---|---|---|---|---|
| 1001 | Amara Silva | amara@example.com | Colombo | Laptop | 1200.00 |
| 1002 | Amara Silva | amara@example.com | Colombo | Mouse | 25.00 |
| 1003 | Amara Silva | amara@exampel.com | Colombo | Keyboard | 45.00 |

Look at row 1003. The email has a typo. Now Amara exists **twice** in your system with two different emails, and nobody can tell which one is real. This is called an **update anomaly**, and it is why relational design exists.

**✅ The relational way (two tables joined by a key):**

`customers`

| customer_id | full_name | email | city |
|---|---|---|---|
| 7 | Amara Silva | amara@example.com | Colombo |

`orders`

| order_id | **customer_id** | order_date |
|---|---|---|
| 1001 | 7 | 2026-03-01 |
| 1002 | 7 | 2026-03-04 |
| 1003 | 7 | 2026-03-09 |

Now the email exists **once**. Fix it once, and all three orders are correct. That is the entire point of a relational database, and everything in [Chapter 51](#51-normalization-1nf-to-bcnf) is this same idea, explained step by step.

## 1.5 🗂️ Types of databases (so you know what you are *not* learning)

| Type | What it is | Examples | Best for |
|---|---|---|---|
| **Relational (SQL)** | Tables with fixed columns and relationships | **SQL Server, MySQL**, PostgreSQL, Oracle | Business data, money, anything needing correctness |
| **Document (NoSQL)** | Each record is a flexible text document (JSON) instead of a fixed row | MongoDB, CouchDB | Data whose shape keeps changing, such as website content |
| **Key-value** | A giant dictionary | Redis, DynamoDB | Very fast, short-lived data such as website logins and caches |
| **Column-family** | Very wide tables spread across many servers | Cassandra, HBase | Enormous streams of incoming data, such as sensor readings |
| **Graph** | Things (nodes) and the links between them | Neo4j | Social networks, fraud rings, recommendations |
| **Search** | Word indexes, like the index at the back of a book | Elasticsearch | Full-text search, log analytics |

> [!IMPORTANT]
> 🎯 **This guide is 100% about relational databases**, specifically **Microsoft SQL Server** and **MySQL** — the two most common engines in enterprise and web development respectively.

> [!TIP]
> 💡 **Pro tip:** Do not let anyone tell you SQL is old-fashioned. Every "modern" data stack — Snowflake, BigQuery, Databricks, Spark, DuckDB — speaks SQL. Learning SQL properly once pays you back for your whole career.

---

# 2. What SQL is, and the two engines we use

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 15 min | Describe what SQL is · Name the five groups of SQL commands · Know how SQL Server and MySQL differ |

> [!NOTE]
> 📌 **In plain words:** **SQL** (Structured Query Language) is the language you use to *talk* to a relational database. You describe **what you want**, and the database figures out **how to get it**.

## 2.1 🗣️ SQL is a language of intent, not instructions

In most programming languages you say *how*: loop over this, check that, add to a list. In SQL you say *what*:

```sql
-- "Give me the names of customers in Colombo, alphabetically."
SELECT full_name
FROM customers
WHERE city = 'Colombo'
ORDER BY full_name;
```

You never wrote a loop. You never said which order to read the disk in. The database's **query optimizer** decided all of that.

> 🌍 **Analogy:** SQL is ordering in a restaurant. You say *"a medium-rare steak with no onions."* You do not walk into the kitchen and explain how to light the grill. The kitchen (the optimizer) chooses the fastest way to make exactly what you asked for.

> [!TIP]
> 💡 **Pro tip:** This is the single biggest mindset shift for programmers learning SQL. If you find yourself writing loops (or *cursors*, SQL's row-by-row loops) to process rows one at a time, you are fighting the language. See [Chapter 59](#59-dynamic-sql-cursors-and-set-based-thinking).

## 2.2 🧬 The five families of SQL commands

Every SQL statement you will ever write belongs to one of these five groups. Memorize this table — it is asked in almost every interview.

| Family | Full name | What it does | Commands |
|:---:|---|---|---|
| **DDL** | Data **Definition** Language | Builds and changes the *structure* | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` |
| **DML** | Data **Manipulation** Language | Changes the *data* inside | `INSERT`, `UPDATE`, `DELETE`, `MERGE` |
| **DQL** | Data **Query** Language | Reads the data | `SELECT` |
| **DCL** | Data **Control** Language | Controls *who is allowed* to do things | `GRANT`, `REVOKE`, `DENY` |
| **TCL** | **Transaction** Control Language | Groups changes into all-or-nothing units | `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `BEGIN TRAN` |

> 🌍 **Analogy:** Building a house. **DDL** builds the rooms. **DML** moves the furniture in and out. **DQL** looks around and describes what is there. **DCL** hands out the door keys. **TCL** makes sure that "move the sofa in and take the old one out" either fully happens or does not happen at all.

## 2.3 🔀 MSSQL vs MySQL — the honest comparison

| Topic | 🟥 Microsoft SQL Server (MSSQL) | 🟦 MySQL |
|---|---|---|
| **Made by** | Microsoft | Oracle (open source, community + enterprise) |
| **Dialect name** | **T-SQL** (Transact-SQL) | MySQL SQL |
| **Cost** | Free Developer/Express; paid Standard/Enterprise | Free Community edition |
| **Runs on** | Windows, Linux, Docker, Azure | Linux, Windows, macOS, Docker, everywhere |
| **Typical home** | Large companies, Microsoft .NET applications, banks, business systems | Websites and web apps (WordPress, the classic Linux + PHP stack), startups |
| **Main tool** (the program you type SQL into) | SQL Server Management Studio (SSMS), VS Code with the MSSQL extension | MySQL Workbench, DBeaver, phpMyAdmin |
| **Storage engine** (the part that writes data to disk) | One built-in engine | **InnoDB** (always use this); the older MyISAM and MEMORY also exist |
| **Limit rows** | `SELECT TOP 10` / `OFFSET … FETCH` | `LIMIT 10` |
| **Joining text together** | `+` or `CONCAT()` | `CONCAT()` (the `+` adds numbers!) |
| **Quoting a name** (e.g. a column called `order date`) | `[square brackets]` | `` `backticks` `` |
| **Auto number** | `IDENTITY(1,1)` | `AUTO_INCREMENT` |
| **Current time** | `GETDATE()`, `SYSDATETIME()` | `NOW()`, `CURRENT_TIMESTAMP` |
| **Variables** | `DECLARE @x INT` | `SET @x = 1`, or `DECLARE x INT` inside stored procedures |
| **Stored procedure body** (a saved SQL program — Chapter 37) | `AS BEGIN … END` | `BEGIN … END` with `DELIMITER` change |
| **Error handling** | `TRY … CATCH` | `DECLARE … HANDLER` |
| **Default isolation** (how two users' work is kept apart — Chapter 43) | READ COMMITTED, using locks | REPEATABLE READ, using snapshots (MVCC) |
| **Case sensitivity** | `'abc' = 'ABC'` is usually true (case-**insensitive**) | Table names are case-sensitive on Linux |
| **Top strength** | Excellent tools, a very smart query planner, features for big companies | Simple, fast, and available on almost every web host |

> [!TIP]
> 💡 **Pro tip:** Roughly **85% of everyday SQL is identical** in both engines. `SELECT`, `WHERE`, `JOIN`, `GROUP BY`, and window functions are the same. The differences are mostly at the edges: showing results page by page, built-in functions, and procedural code (SQL with variables, `IF`, and loops). This guide flags every difference with a 🔀 box.

## 2.4 ⚙️ What the database is actually doing when you press Execute

```text
   You type SQL
        │
        ▼
 ┌───────────────┐   Is the syntax valid? Do these tables exist?
 │  1. PARSER    │   Do you have permission?
 └───────┬───────┘
         ▼
 ┌───────────────┐   Rewrites your query into an internal form.
 │ 2. ALGEBRIZER │   Works out exactly which tables and columns you mean.
 └───────┬───────┘
         ▼
 ┌───────────────┐   Considers MANY ways to run it, estimates the
 │ 3. OPTIMIZER  │   cost of each using STATISTICS (a summary of your data), picks the cheapest.
 └───────┬───────┘   ← this is where indexes matter
         ▼
 ┌───────────────┐   Runs the chosen plan: reads pages from the
 │ 4. EXECUTION  │   buffer pool (memory) or disk, applies filters,
 └───────┬───────┘   joins, sorts, and streams rows back.
         ▼
    Your result (the rows you see)
```

> [!NOTE]
> 📌 **In plain words:** You ask a question. The database *plans* the cheapest way to answer it, then runs that plan. When a query is slow, it is almost always because the plan was bad — usually because an index was missing, or the database's summary of your data (its *statistics*) was out of date. That is the whole story of [Part 10](#46-indexes-the-complete-guide).

## 2.5 📝 SQL syntax rules you must know from minute one

```sql
-- 1. Statements end with a semicolon. (Optional in MSSQL, required in MySQL scripts.)
SELECT 1;

-- 2. SQL keywords are case-insensitive. These three are identical:
select * from customers;
SELECT * FROM customers;
SeLeCt * FrOm customers;

-- 3. Convention: KEYWORDS IN UPPERCASE, table and column names in lowercase. Do this.
SELECT full_name FROM customers;

-- 4. Single quotes for text. Double quotes are NOT for text.
SELECT * FROM customers WHERE city = 'Colombo';   -- ✅ correct
-- SELECT * FROM customers WHERE city = "Colombo"; -- ⚠️ works in MySQL, fails in MSSQL

-- 5. Two dashes make a line comment.
/* And this is a
   block comment. */

-- 6. Whitespace and line breaks do not matter. Use them to stay readable.
```

> [!CAUTION]
> 🐛 **Common mistake:** Using double quotes for a string in MSSQL. In standard SQL, `"customers"` means *the thing named* customers (a table or a column), not the *text* `customers`. **Always use single quotes for text values in both engines.**

> [!TIP]
> 💡 **Pro tip — the formatting style used in this guide:** one clause per line, keywords uppercase, joins indented. Six months from now, you will be the person reading your own query.

```sql
SELECT
    c.full_name,
    o.order_id,
    o.order_date
FROM customers AS c
INNER JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.order_date >= '2026-01-01'
ORDER BY o.order_date DESC;
```

---

# 3. Installing and connecting

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 15–30 min | Install SQL Server or MySQL · Connect a query tool · Run your first query |

> [!NOTE]
> 📌 **In plain words:** Before you can practise, you need a database running on your own machine and a tool to type queries into. This chapter gets you there in under 15 minutes.

> 🌍 **Analogy:** You are setting up a **kitchen**. The **server** is the cooker — it does the actual work, and it runs quietly in the background whether or not you are looking at it. The **client tool** (SSMS, Workbench, DBeaver) is your **worktop**: where you stand, write, and see what comes out. They are two separate things, and beginners often install one and wonder why nothing happens. **You need both.**

## 3.1 🟥 Installing SQL Server (free)

| Option | Best for | How |
|---|---|---|
| **Developer Edition** ⭐ | Learning on Windows. Every feature included, free for learning and testing (not for a live business). | Download *SQL Server Developer* from Microsoft's website and choose the **Basic** installation. |
| **Express Edition** | Small real applications (each database is limited to 10 GB). | The same download page — choose **Express**. |
| **Docker** | Mac, Linux, or a throwaway practice copy. | One command — see below. |
| **Azure SQL Database (free offer)** | Practising in the cloud without installing anything. | Create a free Azure SQL Database with a Microsoft account. |

**🐳 Docker (works on Windows, Mac, and Linux):** Docker runs a ready-made copy of SQL Server inside an isolated "container", so nothing is installed into your system itself. Install and start **Docker Desktop** first. `ACCEPT_EULA=Y` accepts Microsoft's licence; replace the password with your own strong one. If you have never used Docker, the normal installer above is simpler.

```bash
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong!Passw0rd" \
   -p 1433:1433 --name mssql-learn -d mcr.microsoft.com/mssql/server:2022-latest
```

**Then install a client tool** (the program you type SQL into):

- **SSMS (SQL Server Management Studio)** — free, Windows only, the most complete tool. ⭐ Best choice on Windows.
- **VS Code with the MSSQL extension** — free, works on Windows, Mac, and Linux. (Microsoft retired *Azure Data Studio* in 2026; this is its replacement.)

**Connect with:** Server `localhost` (it means "this computer"), Authentication **SQL Server Authentication**, Login `sa` (the built-in *system administrator*), and the password you chose.

> [!WARNING]
> ⚠️ **If the connection fails with "The certificate chain was issued by an authority that is not trusted":** tick **Trust server certificate** in the connection window and connect again. Newer tools refuse a server's self-made security certificate by default; for a database on your own computer, trusting it is safe and normal.

## 3.2 🟦 Installing MySQL (free)

| Option | Best for | How |
|---|---|---|
| **Windows installer (.msi)** ⭐ | Windows learners | Download **MySQL Community Server 8.4 LTS** from dev.mysql.com. The setup wizard asks you to choose a `root` password — write it down. Install **MySQL Workbench** from the same site. |
| **Homebrew** | macOS | `brew install mysql@8.4` then `brew services start mysql@8.4` |
| **apt** | Linux (Ubuntu, Debian) | `sudo apt install mysql-server` (installs your Linux version's MySQL) |
| **Docker** | A practice copy on any computer | One command — see below. |

> [!WARNING]
> ⚠️ **Avoid XAMPP and MAMP for this guide.** They install **MariaDB**, a close cousin of MySQL — not MySQL itself. Several examples here, including the ShopDB build script in Chapter 4, use MySQL-only features and will fail on MariaDB.

**🐳 Docker:**

```bash
docker run --name mysql-learn -e MYSQL_ROOT_PASSWORD=YourStrong!Passw0rd \
   -p 3306:3306 -d mysql:8.4
```

**Then install a client tool:**

- **MySQL Workbench** — official, free, includes an ER diagram designer.
- **DBeaver** — free, connects to *both* MySQL and SQL Server (handy for this guide).
- **phpMyAdmin** — browser-based, common on shared hosting.

**Connect with:** Host `127.0.0.1` (it means "this computer"), Port `3306`, User `root` (the built-in administrator), and the password you chose.

## 3.3 ⌨️ Connecting from the command line

These commands let you type SQL in a terminal window instead of a graphical tool. **Beginners can skip this section** and use SSMS, Workbench, or DBeaver. (`ShopDB` is created in Chapter 4 — until then, leave `-d ShopDB` and `ShopDB` off the end.)

```bash
# 🟥 MSSQL
sqlcmd -S localhost -U sa -P "YourStrong!Passw0rd" -d ShopDB -C     # -C trusts the local server's certificate

# 🟦 MySQL
mysql -h 127.0.0.1 -u root -p ShopDB
```

> [!TIP]
> 💡 **Pro tip:** Install **DBeaver** if you plan to follow both dialects in this guide. One window, two connections, side-by-side tabs. It is the fastest way to *feel* the differences between the engines.

> [!WARNING]
> ⚠️ **Security note:** The `sa` and `root` accounts are the all-powerful administrators. Use them to set up your learning environment, then create a normal user for daily work — exactly as you would on a real, live (*production*) server. [Chapter 54](#54-security-users-roles-and-permissions) shows how.

## 3.4 🧪 Your very first query

Run this in each engine to confirm everything works:

```sql
-- ✅ MSSQL
SELECT @@VERSION AS engine_version, GETDATE() AS server_time;
```

```sql
-- ✅ MySQL
SELECT VERSION() AS engine_version, NOW() AS server_time;
```

**What you should see:** one row with two columns — a long version description (for example *Microsoft SQL Server 2022 … Developer Edition* or *8.4.x*) and the current date and time. If you see that, **you are ready**. 🎉

**If it did not work:**

| What you see | What it means | What to do |
|---|---|---|
| *Cannot connect* / *server was not found* | The database server is not running | Start the service (or `docker start` the container) and try again |
| *Login failed* / *Access denied* | Wrong user name or password | Check the password you chose when installing |
| *Certificate … not trusted* | Your tool does not trust the local server | Tick **Trust server certificate** (SSMS / VS Code) or add `-C` (sqlcmd) |

---
# 4. The sample database: ShopDB

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Build the ShopDB practice database · Load its sample data · Check that your copy matches the guide |

> [!NOTE]
> 📌 **In plain words:** Every example in this guide uses **one** realistic database — a small online electronics store. Build it once now, and every query in all 66 chapters will run on your machine.

## 4.1 🏪 The business we are modelling

**ShopDB** runs an online electronics store. In real life the business needs to answer questions like:

- *Which products are about to run out of stock?*
- *Who are our top 10 customers by lifetime spend?*
- *What is our revenue per month, per category?*
- *Which orders were paid but never shipped?*
- *Which sales rep closed the most revenue this quarter?*

Every one of those questions becomes a query later in this guide.

## 4.2 🗺️ The schema at a glance

```text
   ┌───────────────┐          ┌──────────────┐
   │  categories   │          │  suppliers   │
   │  category_id ◄├───┐  ┌───┤ supplier_id  │
   └───────────────┘   │  │   └──────────────┘
                       │  │
                  ┌────┴──┴────────┐
                  │    products    │
                  │   product_id ◄─┼──────────┐
                  └────────────────┘          │
                                              │
  ┌────────────┐      ┌──────────────┐   ┌────┴─────────┐
  │ customers  │      │   orders     │   │ order_items  │
  │customer_id◄├──────┤ customer_id  │   │  order_id    │
  └────────────┘      │  order_id   ◄├───┤  product_id  │
                      │ employee_id  │   └──────────────┘
  ┌────────────┐      └──────┬───────┘
  │ employees  │             │            ┌──────────────┐
  │employee_id◄├─────────────┘            │   payments   │
  │ manager_id │ ◄── self-reference       │  order_id ───┼──► orders
  └────────────┘                          └──────────────┘
```

**Reading the diagram:** an arrow means *"points to"*. `orders.customer_id` points at `customers.customer_id`. One customer has **many** orders — that is a **one-to-many** relationship, the most common kind in any database.

| Relationship | Type | Meaning in business terms |
|---|---|---|
| `categories` → `products` | One-to-many | One category holds many products |
| `suppliers` → `products` | One-to-many | One supplier provides many products |
| `customers` → `orders` | One-to-many | One customer places many orders |
| `employees` → `orders` | One-to-many | One sales rep handles many orders |
| `employees` → `employees` | Self-referencing | An employee has a manager, who is an employee |
| `orders` ↔ `products` | **Many-to-many** | Solved with a middle table, `order_items` (a *bridge table*) |
| `orders` → `payments` | One-to-many | An order can be paid in instalments or refunded |

> 🌍 **Analogy for the bridge table:** An order can contain many products, and a product can appear on many orders. You cannot express that with a single column on either side — so you create a middle table (`order_items`) where each row says *"this order, this product, this quantity, this price."* Every many-to-many relationship in every database you will ever build is solved this exact way.

## 4.3 🟥 Build ShopDB — MSSQL version

**What to do:** in SSMS click **New Query** (in VS Code, open a new SQL file and connect), paste the whole script below, and run it with **F5**.

**What it does:** creates an empty database called `ShopDB` with eight empty tables. You do not need to understand every line yet — each piece is explained in Chapters 6 to 10.

**What you should see:** the message *Commands completed successfully.* Then go on to 4.5 to fill the tables with data.

> [!WARNING]
> ⚠️ **This script starts from scratch.** If a database called `ShopDB` already exists, the first lines **delete it**. That is exactly what you want when you break your practice data — but never run it on a real server that has a database with this name.

```sql
-- ✅ MSSQL: create the database
IF DB_ID('ShopDB') IS NOT NULL
BEGIN
    ALTER DATABASE ShopDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ShopDB;
END;
GO

CREATE DATABASE ShopDB;
GO

USE ShopDB;
GO

-- ─────────────────────────────────────────────
-- Lookup tables
-- ─────────────────────────────────────────────
CREATE TABLE categories (
    category_id     INT IDENTITY(1,1) PRIMARY KEY,
    category_name   NVARCHAR(50)  NOT NULL UNIQUE,
    description     NVARCHAR(255) NULL
);

CREATE TABLE suppliers (
    supplier_id     INT IDENTITY(1,1) PRIMARY KEY,
    company_name    NVARCHAR(100) NOT NULL,
    contact_name    NVARCHAR(100) NULL,
    country         NVARCHAR(50)  NOT NULL,
    phone           NVARCHAR(30)  NULL
);

-- ─────────────────────────────────────────────
-- People
-- ─────────────────────────────────────────────
CREATE TABLE employees (
    employee_id     INT IDENTITY(1,1) PRIMARY KEY,
    first_name      NVARCHAR(50)  NOT NULL,
    last_name       NVARCHAR(50)  NOT NULL,
    title           NVARCHAR(60)  NOT NULL,
    department      NVARCHAR(40)  NOT NULL,
    manager_id      INT           NULL,
    hire_date       DATE          NOT NULL,
    salary          DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_employees_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    CONSTRAINT ck_employees_salary CHECK (salary > 0)
);

CREATE TABLE customers (
    customer_id     INT IDENTITY(1,1) PRIMARY KEY,
    full_name       NVARCHAR(100) NOT NULL,
    email           NVARCHAR(150) NOT NULL UNIQUE,
    phone           NVARCHAR(30)  NULL,
    city            NVARCHAR(60)  NULL,
    country         NVARCHAR(60)  NOT NULL,
    signup_date     DATE          NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
    loyalty_tier    VARCHAR(10)   NOT NULL DEFAULT 'Bronze',
    CONSTRAINT ck_customers_tier
        CHECK (loyalty_tier IN ('Bronze','Silver','Gold','Platinum'))
);

-- ─────────────────────────────────────────────
-- Catalogue
-- ─────────────────────────────────────────────
CREATE TABLE products (
    product_id      INT IDENTITY(1,1) PRIMARY KEY,
    product_name    NVARCHAR(120) NOT NULL,
    category_id     INT           NOT NULL,
    supplier_id     INT           NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    units_in_stock  INT           NOT NULL DEFAULT 0,
    reorder_level   INT           NOT NULL DEFAULT 10,
    discontinued    BIT           NOT NULL DEFAULT 0,
    created_at      DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT ck_products_price CHECK (unit_price >= 0),
    CONSTRAINT ck_products_stock CHECK (units_in_stock >= 0)
);

-- ─────────────────────────────────────────────
-- Sales
-- ─────────────────────────────────────────────
CREATE TABLE orders (
    order_id        INT IDENTITY(1000,1) PRIMARY KEY,
    customer_id     INT          NOT NULL,
    employee_id     INT          NULL,
    order_date      DATE         NOT NULL,
    ship_date       DATE         NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'Pending',
    shipping_city   NVARCHAR(60) NULL,
    shipping_country NVARCHAR(60) NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT ck_orders_status
        CHECK (status IN ('Pending','Paid','Shipped','Delivered','Cancelled','Refunded'))
);

CREATE TABLE order_items (
    order_id        INT           NOT NULL,
    product_id      INT           NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    quantity        INT           NOT NULL,
    discount        DECIMAL(4,3)  NOT NULL DEFAULT 0,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT ck_items_qty CHECK (quantity > 0),
    CONSTRAINT ck_items_discount CHECK (discount >= 0 AND discount <= 0.9)
);

CREATE TABLE payments (
    payment_id      INT IDENTITY(1,1) PRIMARY KEY,
    order_id        INT           NOT NULL,
    payment_date    DATETIME2(0)  NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    method          VARCHAR(20)   NOT NULL,
    status          VARCHAR(20)   NOT NULL DEFAULT 'Captured',
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT ck_payments_method
        CHECK (method IN ('Card','PayPal','BankTransfer','CashOnDelivery')),
    CONSTRAINT ck_payments_status
        CHECK (status IN ('Captured','Pending','Failed','Refunded'))
);
GO
```

## 4.4 🟦 Build ShopDB — MySQL version

**What to do:** in MySQL Workbench open a new SQL tab (**File → New Query Tab**), paste the whole script below, and run all of it with **Ctrl + Shift + Enter** (the plain ⚡ lightning-bolt button).

**What it does:** creates an empty database called `ShopDB` with eight empty tables. You do not need to understand every line yet — each piece is explained in Chapters 6 to 10.

**What you should see:** a green tick for every statement in the *Action Output* panel. Click the refresh icon in the *Schemas* panel and `ShopDB` appears. Then go on to 4.5.

> [!WARNING]
> ⚠️ **This script starts from scratch.** The first line **deletes** any existing database called `ShopDB`. Never run it on a real server that has a database with this name.

```sql
-- ✅ MySQL: create the database
DROP DATABASE IF EXISTS ShopDB;
CREATE DATABASE ShopDB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE ShopDB;

-- ─────────────────────────────────────────────
-- Lookup tables
-- ─────────────────────────────────────────────
CREATE TABLE categories (
    category_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_name   VARCHAR(50)  NOT NULL UNIQUE,
    description     VARCHAR(255) NULL
) ENGINE=InnoDB;

CREATE TABLE suppliers (
    supplier_id     INT AUTO_INCREMENT PRIMARY KEY,
    company_name    VARCHAR(100) NOT NULL,
    contact_name    VARCHAR(100) NULL,
    country         VARCHAR(50)  NOT NULL,
    phone           VARCHAR(30)  NULL
) ENGINE=InnoDB;

-- ─────────────────────────────────────────────
-- People
-- ─────────────────────────────────────────────
CREATE TABLE employees (
    employee_id     INT AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    title           VARCHAR(60)  NOT NULL,
    department      VARCHAR(40)  NOT NULL,
    manager_id      INT          NULL,
    hire_date       DATE         NOT NULL,
    salary          DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_employees_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    CONSTRAINT ck_employees_salary CHECK (salary > 0)
) ENGINE=InnoDB;

CREATE TABLE customers (
    customer_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    phone           VARCHAR(30)  NULL,
    city            VARCHAR(60)  NULL,
    country         VARCHAR(60)  NOT NULL,
    signup_date     DATE         NOT NULL DEFAULT (CURRENT_DATE),
    loyalty_tier    VARCHAR(10)  NOT NULL DEFAULT 'Bronze',
    CONSTRAINT ck_customers_tier
        CHECK (loyalty_tier IN ('Bronze','Silver','Gold','Platinum'))
) ENGINE=InnoDB;

-- ─────────────────────────────────────────────
-- Catalogue
-- ─────────────────────────────────────────────
CREATE TABLE products (
    product_id      INT AUTO_INCREMENT PRIMARY KEY,
    product_name    VARCHAR(120) NOT NULL,
    category_id     INT          NOT NULL,
    supplier_id     INT          NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    units_in_stock  INT          NOT NULL DEFAULT 0,
    reorder_level   INT          NOT NULL DEFAULT 10,
    discontinued    BOOLEAN      NOT NULL DEFAULT 0,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT ck_products_price CHECK (unit_price >= 0),
    CONSTRAINT ck_products_stock CHECK (units_in_stock >= 0)
) ENGINE=InnoDB;

-- ─────────────────────────────────────────────
-- Sales
-- ─────────────────────────────────────────────
CREATE TABLE orders (
    order_id        INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT         NOT NULL,
    employee_id     INT         NULL,
    order_date      DATE        NOT NULL,
    ship_date       DATE        NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'Pending',
    shipping_city   VARCHAR(60) NULL,
    shipping_country VARCHAR(60) NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT ck_orders_status
        CHECK (status IN ('Pending','Paid','Shipped','Delivered','Cancelled','Refunded'))
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE order_items (
    order_id        INT           NOT NULL,
    product_id      INT           NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    quantity        INT           NOT NULL,
    discount        DECIMAL(4,3)  NOT NULL DEFAULT 0,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT ck_items_qty CHECK (quantity > 0),
    CONSTRAINT ck_items_discount CHECK (discount >= 0 AND discount <= 0.9)
) ENGINE=InnoDB;

CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT           NOT NULL,
    payment_date    DATETIME      NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    method          VARCHAR(20)   NOT NULL,
    status          VARCHAR(20)   NOT NULL DEFAULT 'Captured',
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT ck_payments_method
        CHECK (method IN ('Card','PayPal','BankTransfer','CashOnDelivery')),
    CONSTRAINT ck_payments_status
        CHECK (status IN ('Captured','Pending','Failed','Refunded'))
) ENGINE=InnoDB;
```

> 🔀 **MSSQL vs MySQL — spot the differences in the scripts above:**
>
> | | 🟥 MSSQL | 🟦 MySQL |
> |---|---|---|
> | Text in any language (Unicode) | `NVARCHAR` | `VARCHAR` with `utf8mb4` |
> | Auto number | `IDENTITY(1,1)` | `AUTO_INCREMENT` |
> | Starting value | `IDENTITY(1000,1)` | `AUTO_INCREMENT=1000` on the table |
> | Boolean | `BIT` | `BOOLEAN` (stored as `TINYINT(1)`) |
> | Timestamp type | `DATETIME2(0)` | `DATETIME` |
> | "Now" | `SYSDATETIME()` | `CURRENT_TIMESTAMP` |
> | Storage engine | n/a | `ENGINE=InnoDB` |
> | Batch separator (splits a script into parts sent one after another) | `GO` | not needed |

## 4.5 🌱 Seed the data (identical in both engines)

This script runs unchanged in **both** MSSQL and MySQL. It fills the lookup tables, the people, and the products.

> [!WARNING]
> ⚠️ **Run it inside `ShopDB`.** The easiest way: paste it into the **same query window** you used for the build script, which has already switched to `ShopDB`. In a new window, first choose `ShopDB` in the database drop-down (SSMS) or double-click `ShopDB` in the Schemas panel so it turns bold (Workbench). Otherwise you will see *Invalid object name 'categories'* (MSSQL) or *No database selected* (MySQL).

```sql
-- ✅ Works in BOTH MSSQL and MySQL

INSERT INTO categories (category_name, description) VALUES
('Laptops',      'Portable computers'),
('Smartphones',  'Mobile phones and accessories'),
('Audio',        'Headphones, speakers, microphones'),
('Peripherals',  'Keyboards, mice, webcams'),
('Monitors',     'Displays and screens'),
('Storage',      'SSDs, hard drives, memory cards');

INSERT INTO suppliers (company_name, contact_name, country, phone) VALUES
('NovaTech Industries', 'Li Wei',        'China',       '+86-21-5555-0100'),
('Baltic Components',   'Anna Kalnina',  'Latvia',      '+371-2555-0111'),
('Pacific Devices',     'Hiro Tanaka',   'Japan',       '+81-3-5555-0122'),
('Lanka Distributors',  'Nimal Perera',  'Sri Lanka',   '+94-11-555-0133'),
('EuroSound GmbH',      'Klaus Meyer',   'Germany',     '+49-30-5555-0144');

INSERT INTO employees (first_name, last_name, title, department, manager_id, hire_date, salary) VALUES
('Sarah',  'Mitchell', 'Chief Executive Officer', 'Executive', NULL, '2018-01-15', 185000.00),
('David',  'Okafor',   'Sales Director',          'Sales',     1,    '2019-03-01', 120000.00),
('Priya',  'Raman',    'Senior Sales Executive',  'Sales',     2,    '2020-06-10',  78000.00),
('Tom',    'Becker',   'Sales Executive',         'Sales',     2,    '2021-09-20',  62000.00),
('Yuki',   'Sato',     'Sales Executive',         'Sales',     2,    '2022-02-14',  59000.00),
('Amara',  'Nwosu',    'Support Lead',            'Support',   1,    '2020-11-05',  71000.00),
('Marco',  'Rossi',    'Support Agent',           'Support',   6,    '2023-04-18',  46000.00),
('Elena',  'Petrova',  'Warehouse Manager',       'Logistics', 1,    '2019-08-22',  68000.00);

INSERT INTO customers (full_name, email, phone, city, country, signup_date, loyalty_tier) VALUES
('Amara Silva',     'amara.silva@example.com',  '+94-77-555-0101', 'Colombo',   'Sri Lanka', '2024-02-11', 'Gold'),
('John Baker',      'john.baker@example.com',   '+44-20-555-0102', 'London',    'UK',        '2024-03-05', 'Silver'),
('Mei Chen',        'mei.chen@example.com',     '+65-8555-0103',   'Singapore', 'Singapore', '2024-05-19', 'Platinum'),
('Carlos Mendez',   'carlos.mendez@example.com','+34-91-555-0104', 'Madrid',    'Spain',     '2024-07-02', 'Bronze'),
('Fatima Al-Sayed', 'fatima.alsayed@example.com','+971-4-555-0105','Dubai',     'UAE',       '2024-09-14', 'Gold'),
('Peter Novak',     'peter.novak@example.com',  '+420-2-555-0106', 'Prague',    'Czechia',   '2025-01-08', 'Bronze'),
('Grace Adeyemi',   'grace.adeyemi@example.com','+234-1-555-0107', 'Lagos',     'Nigeria',   '2025-02-23', 'Silver'),
('Hannah Weiss',    'hannah.weiss@example.com', '+49-89-555-0108', 'Munich',    'Germany',   '2025-04-30', 'Bronze'),
('Raj Patel',       'raj.patel@example.com',    '+91-22-555-0109', 'Mumbai',    'India',     '2025-06-17', 'Silver'),
('Sofia Rossi',     'sofia.rossi@example.com',  '+39-06-555-0110', 'Rome',      'Italy',     '2025-08-09', 'Bronze'),
('Kenji Watanabe',  'kenji.watanabe@example.com','+81-3-555-0111', 'Tokyo',     'Japan',     '2025-10-21', 'Gold'),
('Laura Jensen',    'laura.jensen@example.com', '+45-33-555-0112', 'Copenhagen','Denmark',   '2026-01-12', 'Bronze');

INSERT INTO products (product_name, category_id, supplier_id, unit_price, units_in_stock, reorder_level, discontinued) VALUES
('UltraBook Pro 14',        1, 1, 1499.00, 25,  10, 0),
('UltraBook Air 13',        1, 1,  999.00, 40,  15, 0),
('WorkStation X17',         1, 3, 2450.00,  6,   5, 0),
('Legacy Netbook 10',       1, 2,  299.00,  0,   5, 1),
('Zenith Phone 12',         2, 3,  899.00, 60,  20, 0),
('Zenith Phone 12 Mini',    2, 3,  749.00, 35,  20, 0),
('Budget Phone A3',         2, 4,  199.00, 120, 40, 0),
('StudioBuds Wireless',     3, 5,  179.00, 85,  30, 0),
('Concert Over-Ear',        3, 5,  349.00, 18,  10, 0),
('PodMic USB',              3, 5,   99.00, 52,  20, 0),
('MechKey RGB Keyboard',    4, 2,  129.00, 45,  15, 0),
('Silent Mouse Pro',        4, 2,   45.00, 200, 50, 0),
('Stream Cam 4K',           4, 1,  159.00,  9,  10, 0),
('VisionPanel 27 QHD',      5, 1,  399.00, 22,  10, 0),
('VisionPanel 32 4K',       5, 1,  749.00, 11,   8, 0),
('NanoSSD 1TB',             6, 4,  109.00, 150, 40, 0),
('NanoSSD 2TB',             6, 4,  189.00, 75,  30, 0),
('ArchiveDrive 8TB',        6, 2,  199.00,  4,  10, 0);
```

**Orders, items, and payments.** SQL Server normally invents order numbers by itself. So that your orders get exactly the same numbers as the guide (1000, 1001, …), the first small block temporarily lets us supply our own numbers, and the third block switches that off again. MySQL needs no switch.

> [!WARNING]
> ⚠️ **SQL Server:** run the next three blocks **in the same query window, in order**. The `IDENTITY_INSERT` switch only lasts for the window (the *session*) it was run in.

```sql
-- ✅ MSSQL only: allow explicit order_id values
SET IDENTITY_INSERT orders ON;
```

```sql
-- ✅ Works in BOTH (run the SET IDENTITY_INSERT line above first on MSSQL)

INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_date, status, shipping_city, shipping_country) VALUES
(1000,  1, 3, '2026-01-05', '2026-01-07', 'Delivered', 'Colombo',   'Sri Lanka'),
(1001,  2, 4, '2026-01-11', '2026-01-14', 'Delivered', 'London',    'UK'),
(1002,  3, 3, '2026-01-18', '2026-01-19', 'Delivered', 'Singapore', 'Singapore'),
(1003,  1, 5, '2026-02-02', '2026-02-05', 'Delivered', 'Colombo',   'Sri Lanka'),
(1004,  4, 4, '2026-02-09', NULL,         'Cancelled', 'Madrid',    'Spain'),
(1005,  5, 3, '2026-02-15', '2026-02-17', 'Delivered', 'Dubai',     'UAE'),
(1006,  3, 3, '2026-02-27', '2026-03-01', 'Delivered', 'Singapore', 'Singapore'),
(1007,  6, 5, '2026-03-03', '2026-03-08', 'Delivered', 'Prague',    'Czechia'),
(1008,  7, 4, '2026-03-12', '2026-03-15', 'Shipped',   'Lagos',     'Nigeria'),
(1009,  2, 4, '2026-03-21', NULL,         'Paid',      'London',    'UK'),
(1010,  8, 5, '2026-04-02', '2026-04-06', 'Delivered', 'Munich',    'Germany'),
(1011,  9, 3, '2026-04-14', '2026-04-16', 'Delivered', 'Mumbai',    'India'),
(1012,  3, 3, '2026-04-25', '2026-04-26', 'Delivered', 'Singapore', 'Singapore'),
(1013, 10, 4, '2026-05-06', NULL,         'Pending',   'Rome',      'Italy'),
(1014,  5, 5, '2026-05-13', '2026-05-16', 'Delivered', 'Dubai',     'UAE'),
(1015, 11, 3, '2026-05-22', '2026-05-24', 'Delivered', 'Tokyo',     'Japan'),
(1016,  1, 3, '2026-06-04', '2026-06-06', 'Delivered', 'Colombo',   'Sri Lanka'),
(1017,  7, 4, '2026-06-15', NULL,         'Refunded',  'Lagos',     'Nigeria'),
(1018, 12, 5, '2026-06-28', '2026-07-01', 'Delivered', 'Copenhagen','Denmark'),
(1019,  3, 3, '2026-07-09', '2026-07-10', 'Shipped',   'Singapore', 'Singapore'),
(1020,  9, 4, '2026-07-19', NULL,         'Paid',      'Mumbai',    'India'),
(1021, 11, 3, '2026-08-01', '2026-08-04', 'Delivered', 'Tokyo',     'Japan'),
(1022,  2, 5, '2026-08-14', NULL,         'Pending',   'London',    'UK');
```

```sql
-- ✅ MSSQL only: turn it back off
SET IDENTITY_INSERT orders OFF;
```

```sql
-- ✅ Works in BOTH

INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount) VALUES
(1000,  1, 1499.00, 1, 0.000), (1000, 12,   45.00, 2, 0.000),
(1001,  5,  899.00, 1, 0.050), (1001,  8,  179.00, 1, 0.000),
(1002,  3, 2450.00, 1, 0.100), (1002, 15,  749.00, 2, 0.050), (1002, 11, 129.00, 1, 0.000),
(1003, 16,  109.00, 3, 0.000),
(1004,  7,  199.00, 1, 0.000),
(1005,  2,  999.00, 1, 0.000), (1005, 14,  399.00, 1, 0.000), (1005, 12,  45.00, 1, 0.000),
(1006,  9,  349.00, 2, 0.100),
(1007, 11,  129.00, 1, 0.000), (1007, 12,   45.00, 1, 0.000), (1007, 10,  99.00, 1, 0.000),
(1008,  6,  749.00, 1, 0.000), (1008, 17,  189.00, 1, 0.000),
(1009,  1, 1499.00, 2, 0.050),
(1010, 13,  159.00, 1, 0.000), (1010, 10,   99.00, 2, 0.000),
(1011,  7,  199.00, 4, 0.100), (1011, 12,   45.00, 4, 0.000),
(1012,  5,  899.00, 1, 0.000), (1012,  8,  179.00, 2, 0.050),
(1013, 14,  399.00, 1, 0.000),
(1014,  2,  999.00, 2, 0.100), (1014, 16,  109.00, 2, 0.000),
(1015, 15,  749.00, 1, 0.000), (1015,  9,  349.00, 1, 0.050),
(1016, 17,  189.00, 2, 0.000), (1016, 11,  129.00, 1, 0.000),
(1017,  3, 2450.00, 1, 0.000),
(1018, 18,  199.00, 1, 0.000), (1018, 12,   45.00, 3, 0.000),
(1019,  1, 1499.00, 1, 0.050), (1019, 15,  749.00, 1, 0.000), (1019, 8, 179.00, 1, 0.000),
(1020,  6,  749.00, 1, 0.000),
(1021,  5,  899.00, 2, 0.050), (1021, 10,   99.00, 1, 0.000),
(1022, 13,  159.00, 1, 0.000);

INSERT INTO payments (order_id, payment_date, amount, method, status) VALUES
(1000, '2026-01-05 10:12:00', 1589.00, 'Card',           'Captured'),
(1001, '2026-01-11 14:31:00', 1033.05, 'PayPal',         'Captured'),
(1002, '2026-01-18 09:05:00', 3757.10, 'BankTransfer',   'Captured'),
(1003, '2026-02-02 16:44:00',  327.00, 'Card',           'Captured'),
(1004, '2026-02-09 11:20:00',  199.00, 'Card',           'Refunded'),
(1005, '2026-02-15 08:59:00', 1443.00, 'Card',           'Captured'),
(1006, '2026-02-27 19:23:00',  628.20, 'PayPal',         'Captured'),
(1007, '2026-03-03 12:00:00',  273.00, 'Card',           'Captured'),
(1008, '2026-03-12 15:47:00',  938.00, 'BankTransfer',   'Captured'),
(1009, '2026-03-21 10:02:00', 2848.10, 'Card',           'Captured'),
(1010, '2026-04-02 13:15:00',  357.00, 'PayPal',         'Captured'),
(1011, '2026-04-14 17:38:00',  896.40, 'Card',           'Captured'),
(1012, '2026-04-25 09:44:00', 1239.10, 'Card',           'Captured'),
(1014, '2026-05-13 11:11:00', 2016.20, 'Card',           'Captured'),
(1015, '2026-05-22 14:06:00', 1080.55, 'BankTransfer',   'Captured'),
(1016, '2026-06-04 08:22:00',  507.00, 'Card',           'Captured'),
(1017, '2026-06-15 16:50:00', 2450.00, 'Card',           'Refunded'),
(1018, '2026-06-28 10:35:00',  334.00, 'PayPal',         'Captured'),
(1019, '2026-07-09 12:41:00', 2352.05, 'Card',           'Captured'),
(1020, '2026-07-19 18:09:00',  749.00, 'Card',           'Captured'),
(1021, '2026-08-01 09:57:00', 1807.10, 'Card',           'Captured'),
(1022, '2026-08-14 20:30:00',  159.00, 'CashOnDelivery', 'Pending');
```

## 4.6 ✅ Verify your build

Run this check. It counts the rows in every table, so you can compare your copy with the guide's.

```sql
-- ✅ Works in BOTH
SELECT 'categories'  AS table_name, COUNT(*) AS row_count FROM categories
UNION ALL SELECT 'suppliers',   COUNT(*) FROM suppliers
UNION ALL SELECT 'employees',   COUNT(*) FROM employees
UNION ALL SELECT 'customers',   COUNT(*) FROM customers
UNION ALL SELECT 'products',    COUNT(*) FROM products
UNION ALL SELECT 'orders',      COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'payments',    COUNT(*) FROM payments;
```

**Expected result:**

| table_name | row_count |
|---|---|
| categories | 6 |
| suppliers | 5 |
| employees | 8 |
| customers | 12 |
| products | 18 |
| orders | 23 |
| order_items | 42 |
| payments | 22 |

> 🎉 **If your numbers match, you are ready for every example in this guide.** Keep this script — you can rebuild ShopDB in seconds whenever you break it (and you *should* break it, that is how you learn).

> [!WARNING]
> ⚠️ **A number is different?** A script was skipped or run twice. Simply start again: run the build script (4.3 or 4.4) — it deletes and recreates ShopDB — then the data scripts in 4.5, then this check.

> [!TIP]
> 💡 **Pro tip:** Notice `order_items.unit_price` duplicates `products.unit_price`. That is **deliberate, not a mistake**. Product prices change over time; an order must remember the price *at the moment of sale*. This is a real-world design decision you will meet in every e-commerce system. See [Chapter 52](#52-denormalization-and-when-to-break-the-rules).

---

# 5. How a query actually runs

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 15 min | Know the real order a query runs in · Fix the most common beginner error · Tell `WHERE` and `HAVING` apart |

> [!NOTE]
> 📌 **In plain words:** SQL is not executed in the order you write it. Learning the **real** order explains 90% of the confusing errors beginners hit.

## 5.1 ✍️ The order you WRITE a query

```text
SELECT      ...    <- 1st written
FROM        ...    <- 2nd
WHERE       ...    <- 3rd
GROUP BY    ...    <- 4th
HAVING      ...    <- 5th
ORDER BY    ...    <- 6th
LIMIT/TOP   ...    <- 7th
```

## 5.2 🧠 The order the DATABASE runs it (logical query processing)

Behind the scenes, the database reads your query in a completely different order. You have not met every keyword below yet — that is fine. Come back to this list whenever a query does something surprising.

```text
 1. FROM      →  get the tables, do the joins        🧱 "Which rows exist at all?"
 2. WHERE     →  throw away rows that fail the test   🔍 "Which rows do I care about?"
 3. GROUP BY  →  squash rows into groups              📦 "Bundle them into buckets"
 4. HAVING    →  throw away whole groups              🗑️ "Which buckets do I care about?"
 5. SELECT    →  compute the output columns           🎨 "What do I want to see?"
 6. DISTINCT  →  remove duplicate output rows         ♻️ "No repeats"
 7. ORDER BY  →  sort the final rows                  🔤 "In what order?"
 8. LIMIT/TOP →  keep only the first N                ✂️ "Just the top few"
```

> 🌍 **Analogy — a fruit market:** You **go to the market** (FROM). You **pick only ripe fruit** (WHERE). You **sort it into baskets by type** (GROUP BY). You **discard baskets with fewer than 3 pieces** (HAVING). You **write a label for each remaining basket** (SELECT). You **remove duplicate labels** (DISTINCT). You **line the baskets up by weight** (ORDER BY). You **take the heaviest 5 home** (LIMIT).

## 5.3 💥 Three mysteries this instantly solves

### Mystery 1 — Why can I not use a column alias in WHERE?

An **alias** is a temporary name you give a result column with `AS`. Below, `price_with_tax` is an alias for `unit_price * 1.15`.

```sql
-- ❌ FAILS in both engines
SELECT unit_price * 1.15 AS price_with_tax
FROM products
WHERE price_with_tax > 1000;
```

**Why:** `WHERE` (step 2) runs **before** `SELECT` (step 5). When `WHERE` is evaluated, the alias `price_with_tax` does not exist yet.

```sql
-- ✅ FIX 1: repeat the expression
SELECT unit_price * 1.15 AS price_with_tax
FROM products
WHERE unit_price * 1.15 > 1000;

-- ✅ FIX 2 (cleaner): compute it in a subquery or CTE first
SELECT price_with_tax
FROM (
    SELECT unit_price * 1.15 AS price_with_tax
    FROM products
) AS t
WHERE price_with_tax > 1000;
```

> 🔀 **MySQL exception:** MySQL *does* allow aliases in `GROUP BY`, `HAVING`, and `ORDER BY`, and MSSQL allows them in `ORDER BY`. **Neither** allows them in `WHERE`.

### Mystery 2 — Why does ORDER BY accept an alias?

```sql
-- ✅ WORKS in both
SELECT unit_price * 1.15 AS price_with_tax
FROM products
ORDER BY price_with_tax DESC;
```

**Why:** `ORDER BY` (step 7) runs **after** `SELECT` (step 5), so the alias already exists.

### Mystery 3 — What is the real difference between WHERE and HAVING?

`GROUP BY` collects rows into groups (below: one group per category), and `HAVING` then filters those groups. Chapter 26 covers both in detail.

```sql
-- ✅ Works in BOTH
SELECT
    category_id,
    COUNT(*)        AS product_count,
    AVG(unit_price) AS avg_price
FROM products
WHERE discontinued = 0          -- 🔍 filters individual PRODUCTS (before grouping)
GROUP BY category_id
HAVING COUNT(*) >= 3            -- 🗑️ filters whole CATEGORIES (after grouping)
ORDER BY avg_price DESC;
```

| Clause | Filters | Can use aggregates (`COUNT`, `SUM`, `AVG` …)? | Runs |
|---|---|---|---|
| `WHERE` | Individual **rows** | ❌ No | Before grouping |
| `HAVING` | Whole **groups** | ✅ Yes | After grouping |

> [!TIP]
> 💡 **Pro tip:** If a filter does not need an aggregate function, put it in `WHERE`, not `HAVING`. `WHERE` removes rows *before* the expensive grouping work, so it is faster. Putting non-aggregate filters in `HAVING` is a classic performance mistake.

## 5.4 🧪 Try it yourself

1. Write a query that returns each product's name and its price in a second currency (multiply by 3.6), sorted from most expensive.
2. Now try to filter that computed column in `WHERE`. Watch it fail. Read the error carefully.
3. Fix it two different ways: by repeating the expression, and with a subquery (a query inside another query — like FIX 2 above).
4. Write a query listing every category that has **more than 2** products with a price above 150.

---
# 🧱 PART 2 — BUILDING BLOCKS

---

# 6. Data types

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 25 min | Pick the right type for numbers, text, and dates · Store money safely · Avoid the phone-number and Unicode traps |

> [!NOTE]
> 📌 **In plain words:** A data type is a **promise about what can go in a column**. Choosing `INT` for an age means "only whole numbers live here." The database enforces that promise for you, forever.

> 🌍 **Analogy:** Data types are the **shaped holes in a toddler's shape-sorter toy**. The star hole only accepts the star block. You cannot force a triangle in. That sounds restrictive — it is actually what keeps your data clean for the next ten years.

## 6.1 🔢 Numeric types

| Purpose | 🟥 MSSQL | 🟦 MySQL | Range / notes |
|---|---|---|---|
| Tiny whole number | `TINYINT` (0 to 255) | `TINYINT` (-128 to 127) | ⚠️ **Different!** MySQL's version allows negative numbers by default |
| Small whole number | `SMALLINT` | `SMALLINT` | ±32,767 |
| Normal whole number | `INT` | `INT` / `INTEGER` | ±2.1 billion — **your default choice** |
| Huge whole number | `BIGINT` | `BIGINT` | ±9.2 quintillion |
| **Money / exact decimals** | `DECIMAL(p,s)` / `NUMERIC(p,s)` | `DECIMAL(p,s)` | **Exact.** Use for all money |
| Approximate decimals | `FLOAT`, `REAL` | `FLOAT`, `DOUBLE` | Fast but **inexact** |
| Currency shortcut | `MONEY`, `SMALLMONEY` | *(none)* | ⚠️ Avoid: it can round in surprising ways |
| Boolean | `BIT` (0/1) | `BOOLEAN` = alias for `TINYINT(1)` | Write `BOOLEAN`: MySQL 8.4 warns that the `(1)` display width is deprecated |

**Understanding `DECIMAL(p, s)`:**

```text
DECIMAL(10, 2)
         │   └── scale:     digits AFTER the decimal point
         └────── precision: TOTAL digits (before + after)

So DECIMAL(10,2) holds up to 99,999,999.99
```

> [!WARNING]
> ⚠️ **The single most important rule about money:** **NEVER store money in `FLOAT` or `DOUBLE`.**

```sql
-- ✅ Works in BOTH — see the danger for yourself
SELECT
    CAST(0.1 AS FLOAT) + CAST(0.2 AS FLOAT)       AS float_math,
    CAST(0.1 AS DECIMAL(10,2)) + CAST(0.2 AS DECIMAL(10,2)) AS decimal_math;
```

`FLOAT` gives you `0.30000000000000004`. Multiply that error across a million transactions and your accountant will find you. `DECIMAL` gives you exactly `0.30`.

> [!IMPORTANT]
> 🎯 **When to use what:**
> - **`INT`** — IDs, counts, quantities. Your default for whole numbers.
> - **`BIGINT`** — very large tables (website logs, sensor readings) that may pass 2 billion rows.
> - **`DECIMAL(10,2)`** — prices, salaries, totals, anything with a currency symbol.
> - **`DECIMAL(5,4)`** — rates and percentages that must be exact (interest, tax).
> - **`FLOAT`/`DOUBLE`** — scientific measurements, coordinates, sensor data, where tiny error is acceptable.

## 6.2 🔤 String types

| Purpose | 🟥 MSSQL | 🟦 MySQL | Notes |
|---|---|---|---|
| Fixed length | `CHAR(n)` | `CHAR(n)` | Padded with spaces. Only for truly fixed values |
| Variable length | `VARCHAR(n)` | `VARCHAR(n)` | **Your default choice** |
| Unicode fixed | `NCHAR(n)` | `CHAR` + utf8mb4 | |
| Unicode variable | **`NVARCHAR(n)`** | `VARCHAR` + utf8mb4 | 🔀 MSSQL needs the `N` prefix |
| Very long text | `VARCHAR(MAX)`, `NVARCHAR(MAX)` | `TEXT`, `MEDIUMTEXT`, `LONGTEXT` | Up to 2 GB / 4 GB |
| Binary | `VARBINARY(MAX)` | `BLOB`, `LONGBLOB` | Files, images |

**🔀 The Unicode difference, demonstrated.** *Unicode* means text in any language — Sinhala, Japanese, Arabic, even emoji. A column that is not Unicode knows only one alphabet, and silently turns everything else into `?`:

```sql
-- 🟥 MSSQL: without N, non-Latin characters become question marks
CREATE TABLE demo_ascii (t VARCHAR(50));
INSERT INTO demo_ascii VALUES ('日本語');       -- becomes ???
INSERT INTO demo_ascii VALUES (N'日本語');      -- still ??? — the COLUMN is the problem

CREATE TABLE demo_unicode (t NVARCHAR(50));
INSERT INTO demo_unicode VALUES (N'日本語');    -- ✅ stored correctly
```

```sql
-- 🟦 MySQL: use utf8mb4 and plain VARCHAR works for everything, including emoji
CREATE TABLE demo_unicode (t VARCHAR(50)) CHARACTER SET utf8mb4;
INSERT INTO demo_unicode VALUES ('日本語 🎉');   -- ✅ stored correctly
```

> [!WARNING]
> ⚠️ **MySQL trap:** The old charset named `utf8` in MySQL is **not real UTF-8** — it uses at most 3 bytes per character, so it cannot store emoji or some Chinese, Japanese, and Korean characters. **Always use `utf8mb4`.** The `mb4` means "maximum 4 bytes".

> 🔎 **The full story is [Chapter 60](#60-collation-character-sets-and-unicode)** — character sets, collations, the silent `??` data loss, and the collation conflict error that stops migrations dead.

> [!IMPORTANT]
> 🎯 **CHAR vs VARCHAR — when to use each:**
>
> | Use `CHAR(n)` when | Use `VARCHAR(n)` when |
> |---|---|
> | The value is **always** exactly n characters | Length varies (almost always) |
> | Country codes `CHAR(2)`, currency `CHAR(3)` | Names, emails, addresses, descriptions |
> | Fixed-format codes, hashes `CHAR(64)` | Anything a human types freely |

> [!TIP]
> 💡 **Pro tip on sizing:** `VARCHAR(50)` and `VARCHAR(255)` use the *same* storage for the word "Tom" — you only pay for the characters actually stored. But the declared size still matters: it documents your intent, blocks junk data, and **decides how much memory the database reserves when it sorts that column**. Do not lazily declare everything `VARCHAR(4000)` — every sort on that column would reserve far more memory than it needs.

## 6.3 📅 Date and time types

| Purpose | 🟥 MSSQL | 🟦 MySQL | Example value |
|---|---|---|---|
| Date only | `DATE` | `DATE` | `2026-06-15` |
| Time only | `TIME` | `TIME` | `14:30:00` |
| Date + time | **`DATETIME2(n)`** | `DATETIME(n)` | `2026-06-15 14:30:00.000` |
| Older date + time | `DATETIME` ⚠️ | `TIMESTAMP` | |
| With time zone | `DATETIMEOFFSET` | *(store UTC — world standard time — plus the offset)* | `2026-06-15 14:30 +05:30` |
| Auto-updating stamp | *(use a DEFAULT plus a trigger — code that runs on every change, Chapter 39)* | `TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` | |
| Year only | *(use `SMALLINT`)* | `YEAR` | `2026` |

> [!WARNING]
> ⚠️ **MSSQL:** Avoid the old `DATETIME` type. It rounds to 3.33 ms increments (`:59.997`) and has a minimum year of 1753. **Use `DATETIME2` for new work.**

> [!WARNING]
> ⚠️ **MySQL:** `TIMESTAMP` is stored as UTC and converted to the time zone of your connection (your *session*) when you read it, and it **ends in the year 2038**. `DATETIME` stores exactly what you give it with no conversion. Pick deliberately: `TIMESTAMP` for "when did this actually happen globally", `DATETIME` for "the local wall-clock time of an appointment".

```sql
-- ✅ MySQL: an audit column that maintains itself
CREATE TABLE audit_demo (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    note        VARCHAR(100),
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                                   ON UPDATE CURRENT_TIMESTAMP
);
```

```sql
-- ✅ MSSQL: same idea; updated_at needs a trigger (see Chapter 39)
CREATE TABLE audit_demo (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    note        VARCHAR(100),
    created_at  DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    updated_at  DATETIME2(0) NOT NULL DEFAULT SYSDATETIME()
);
```

> [!TIP]
> 💡 **The golden rule of time zones:** Store **UTC** in the database. Convert it to the user's local time only when you show it on screen, inside your application (the website or app). A database full of mixed local times is unrecoverable — you can never know afterwards which zone each row meant.

> 🔎 **[Chapter 61](#61-time-zones-and-global-data) covers this properly** — `AT TIME ZONE`, `CONVERT_TZ`, DST (daylight saving time), and how to write a local-day filter that still uses an index.

## 6.4 🎁 Special and modern types

| Type | 🟥 MSSQL | 🟦 MySQL | Use for |
|---|---|---|---|
| Globally unique ID | `UNIQUEIDENTIFIER` | `CHAR(36)` or `BINARY(16)` | IDs created on many computers at once; IDs shown in web addresses |
| JSON | `NVARCHAR(MAX)` + `ISJSON()` | **`JSON`** (native) | Flexible attributes, data exchanged with other programs |
| XML | **`XML`** (native) | `TEXT` | Exchanging data with older systems |
| Spatial | `GEOGRAPHY`, `GEOMETRY` | `GEOMETRY`, `POINT` | Maps, distances, areas |
| Enumerated list | *(use `CHECK` constraint)* | `ENUM('a','b','c')` | Small fixed lists |
| Set of values | *(use a bridge table)* | `SET('a','b','c')` | ⚠️ Rarely a good idea |
| Row versioning | `ROWVERSION` / `TIMESTAMP` | *(manual version column)* | Detecting that someone else changed a row (Chapter 63) |

> [!NOTE]
> 📌 **In plain words:** a **GUID / UUID** is a long random ID (such as `3f2504e0-4f89-11d3-9a0c-0305e82c3301`) that is unique across every computer in the world. **JSON** and **XML** are text formats for structured data — JSON looks like `{"name": "Amara", "city": "Colombo"}`. **Spatial** types store positions and shapes on a map.

> [!WARNING]
> ⚠️ **Avoid MySQL `ENUM` in serious designs.** Adding a value requires an `ALTER TABLE` on the whole table, the ordering rules surprise people, and other database engines do not have it. Use a small lookup table with a foreign key, or a `CHECK` constraint. Our `ShopDB` uses `CHECK` for exactly this reason.

## 6.5 🧭 The decision table: which type do I pick?

| I need to store... | Use this |
|---|---|
| A person's name | `VARCHAR(100)` / `NVARCHAR(100)` |
| An email address | `VARCHAR(150)` + `UNIQUE` |
| A phone number | `VARCHAR(30)` — **never a number type!** |
| A price or salary | `DECIMAL(10,2)` |
| A tax rate like 0.0825 | `DECIMAL(6,4)` |
| A quantity | `INT` |
| Yes / no | `BIT` (MSSQL) / `BOOLEAN` (MySQL) |
| A birthday | `DATE` |
| When a row was created | `DATETIME2(0)` / `DATETIME` (in UTC) |
| A country code | `CHAR(2)` |
| A blog post body | `NVARCHAR(MAX)` / `TEXT` |
| A product image | Store the **file path or URL**, not the file |
| A status like Pending/Paid | `VARCHAR(20)` + `CHECK`, or a lookup table |

> [!CAUTION]
> 🐛 **Common mistake:** Storing a phone number as `BIGINT`. You immediately lose the leading `+`, the leading zeros, spaces, dashes, and extensions. Phone numbers are **identifiers, not quantities** — you never do arithmetic on them. The same applies to postal codes, invoice numbers with letters, and national ID numbers.

## 6.6 🧪 Try it yourself

1. Create a table `type_lab` with one column of every numeric type. Insert `12345.678` into each and observe how each one stores it.
2. Try inserting `'abc'` into an `INT` column. Read the exact error message — you will see it again.
3. In MySQL, create one table with `CHARACTER SET utf8` and one with `utf8mb4`. Insert `'Café 🎉'` into both. Compare.
4. Create a `DECIMAL(5,2)` column and try to insert `1234.56`. Explain the error in your own words.

---

# 7. Creating databases and schemas

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 15 min | Create, list, and delete databases · Organize tables into schemas |

> [!NOTE]
> 📌 **In plain words:** A **database** is the outer container. A **schema** is a folder *inside* it that groups related tables so a large system stays organized.

## 7.1 🏗️ Creating a database

```sql
-- ✅ MSSQL
-- (ShopDB already exists from Chapter 4, so these examples use practice names)
CREATE DATABASE DemoDB;
GO

-- With explicit file locations and sizes (the way real servers are set up)
-- ⚠️ The folders must already exist on the server, or the CREATE fails
CREATE DATABASE DemoDB_Files
ON PRIMARY (
    NAME = DemoDB_Files_data,
    FILENAME = 'C:\SQLData\DemoDB_Files.mdf',
    SIZE = 500MB,
    FILEGROWTH = 100MB
)
LOG ON (
    NAME = DemoDB_Files_log,
    FILENAME = 'C:\SQLLogs\DemoDB_Files.ldf',
    SIZE = 100MB,
    FILEGROWTH = 50MB
);
GO
```

```sql
-- ✅ MySQL
-- (ShopDB already exists from Chapter 4, so these examples use practice names)
CREATE DATABASE DemoDB;

-- Recommended: always state the character set explicitly
CREATE DATABASE DemoDB_Utf8
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;
```

> [!NOTE]
> 📌 **In plain words:** SQL Server keeps every database in (at least) two files: an `.mdf` file holding the data, and an `.ldf` file holding the *transaction log* — a diary of every change, used to recover after a crash.

**Safe versions that do not error if it already exists:**

```sql
-- ✅ MSSQL
IF DB_ID('ShopDB') IS NULL
    CREATE DATABASE ShopDB;
```

```sql
-- ✅ MySQL
CREATE DATABASE IF NOT EXISTS ShopDB;
```

**Switching to a database:**

```sql
-- ✅ MSSQL
USE ShopDB;
GO
```

```sql
-- ✅ MySQL
USE ShopDB;
```

**Listing and dropping:**

```sql
-- ✅ MSSQL
SELECT name, create_date, state_desc FROM sys.databases;
DROP DATABASE DemoDB;        -- fails while any connection (session) is still using it
```

```sql
-- ✅ MySQL
SHOW DATABASES;
DROP DATABASE IF EXISTS DemoDB;
```

> [!WARNING]
> ⚠️ **`DROP DATABASE` is instant and permanent.** There is no recycle bin, no confirmation, no undo. On a real, live (*production*) server, ordinary accounts should not even be allowed to run it. See [Chapter 56](#56-backup-restore-and-disaster-recovery) before you ever type it on a real server.

## 7.2 📁 Schemas — the folder system

> 🌍 **Analogy:** A database is a **filing cabinet**. Schemas are the **labelled drawers**: Sales, HR, Finance. Without drawers, 400 tables sit in one pile.

```sql
-- ✅ MSSQL: schemas are real, named containers
CREATE SCHEMA sales;
GO
CREATE SCHEMA hr;
GO

CREATE TABLE sales.orders (order_id INT PRIMARY KEY);
CREATE TABLE hr.employees  (employee_id INT PRIMARY KEY);

-- Always reference with schema.table
SELECT * FROM sales.orders;
```

> 🔀 **The big structural difference:**
>
> - In **MSSQL**, a *database* contains *schemas*, and schemas contain tables. The default schema is `dbo` (database owner). `dbo.customers` and `customers` mean the same thing for most users.
> - In **MySQL**, **schema and database are the same thing**. `CREATE SCHEMA` is literally a synonym for `CREATE DATABASE`. To group things, you either use separate databases or a naming convention like `sales_orders`.

```sql
-- 🟦 MySQL: these two statements are identical
CREATE SCHEMA   IF NOT EXISTS shop_analytics;
CREATE DATABASE IF NOT EXISTS shop_analytics;   -- does nothing: the schema above IS this database

-- Cross-database queries work naturally
CREATE TABLE IF NOT EXISTS shop_analytics.customer_scores (
    customer_id INT PRIMARY KEY,
    score       INT NOT NULL
);

SELECT * FROM ShopDB.customers c
JOIN shop_analytics.customer_scores s ON s.customer_id = c.customer_id;
```

> [!IMPORTANT]
> 🎯 **When to use schemas (MSSQL):**
> - Grouping by business area: `sales`, `inventory`, `hr`, `reporting`
> - Applying permissions in bulk: *"the reporting team can read everything in the `reporting` schema"* — one `GRANT` instead of 200
> - Keeping raw imported data (a *staging* area) apart from clean data: `staging.raw_orders` → `dbo.orders`

> [!TIP]
> 💡 **Pro tip (MSSQL):** Always write `dbo.customers`, never bare `customers`. Leaving the schema out makes SQL Server look the name up every time the query runs, can fill its memory with duplicate query plans, and breaks as soon as two schemas contain a table with the same name.

## 7.3 🧪 Try it yourself

1. Create a database called `PracticeDB` with `utf8mb4` (MySQL) or default settings (MSSQL).
2. In MSSQL, create schemas `sales` and `archive`, and put one table in each.
3. List all databases on your server. Find the system databases (`master`, `mysql`, `information_schema`) and read one sentence about what each does.

---

# 8. Creating tables

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Write a `CREATE TABLE` statement · Decide which columns are required · Give columns sensible default values · Copy a table |

> [!NOTE]
> 📌 **In plain words:** `CREATE TABLE` is where you draw the blueprint: the columns, their types, and the rules that keep bad data out.

> 🌍 **Analogy:** Designing a paper form before you print a thousand copies. You decide which boxes exist, what may be written in each (a date, a number, a name), and which boxes are compulsory. Every row is one filled-in copy of that form.

## 8.1 🧱 The anatomy of CREATE TABLE

```text
CREATE TABLE table_name (
    column_name   DATA_TYPE   [NULL | NOT NULL]   [DEFAULT value]   [constraints],
    ...
    [table-level constraints]
);
```

Anything in `[square brackets]` is optional.

**A fully annotated real example:**

```sql
-- ✅ MSSQL
CREATE TABLE product_reviews (
    review_id     INT IDENTITY(1,1),                       -- auto-numbered
    product_id    INT            NOT NULL,                 -- required
    customer_id   INT            NOT NULL,                 -- required
    rating        TINYINT        NOT NULL,                 -- 1 to 5
    title         NVARCHAR(120)  NULL,                     -- optional
    body          NVARCHAR(MAX)  NULL,                     -- optional, long
    is_verified   BIT            NOT NULL DEFAULT 0,       -- default value
    created_at    DATETIME2(0)   NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT pk_product_reviews PRIMARY KEY (review_id),
    CONSTRAINT fk_reviews_product  FOREIGN KEY (product_id)  REFERENCES products(product_id),
    CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT ck_reviews_rating   CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uq_reviews_one_per_customer UNIQUE (product_id, customer_id)
);
```

```sql
-- ✅ MySQL
CREATE TABLE product_reviews (
    review_id     INT AUTO_INCREMENT,
    product_id    INT          NOT NULL,
    customer_id   INT          NOT NULL,
    rating        TINYINT      NOT NULL,
    title         VARCHAR(120) NULL,
    body          TEXT         NULL,
    is_verified   BOOLEAN      NOT NULL DEFAULT 0,
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_product_reviews PRIMARY KEY (review_id),
    CONSTRAINT fk_reviews_product  FOREIGN KEY (product_id)  REFERENCES products(product_id),
    CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT ck_reviews_rating   CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uq_reviews_one_per_customer UNIQUE (product_id, customer_id)
) ENGINE=InnoDB;
```

The `CONSTRAINT` lines at the bottom are the table's **rules**: the `PRIMARY KEY` is the row's unique ID, each `FOREIGN KEY` must point at a real product or customer, the `CHECK` keeps the rating between 1 and 5, and `UNIQUE` blocks duplicates. [Chapter 9](#9-constraints-the-rules-that-protect-your-data) explains each one.

> [!NOTE]
> 📌 **Read that last constraint again.** `UNIQUE (product_id, customer_id)` encodes a *business rule* in the database itself: **one review per customer per product**. No amount of buggy application code can ever violate it. This is the superpower of a relational database — rules that cannot be bypassed.

## 8.2 🕳️ NULL vs NOT NULL — decide for every column

`NULL` means **"no value — unknown or not applicable"**. It is not zero, and it is not empty text.

| | `NOT NULL` | `NULL` (the default) |
|---|---|---|
| Meaning | "This fact is **required**" | "This fact may be **unknown or not applicable**" |
| Example | `customers.email` | `orders.ship_date` (not shipped yet) |
| Effect | Insert fails without a value | Missing value is allowed |

> [!TIP]
> 💡 **Pro tip:** Make every column `NOT NULL` unless you have a real reason to allow empty values. Columns that allow `NULL` make every query that touches them harder to get right (see [Chapter 15](#15-null-the-value-that-is-not-there)). Ask: *"Can this genuinely be unknown in the real world?"* A ship date genuinely can be. An email address on a signup form cannot.

## 8.3 🎁 DEFAULT values

```sql
-- ✅ MSSQL
CREATE TABLE support_tickets (
    ticket_id    INT IDENTITY(1,1) PRIMARY KEY,
    subject      NVARCHAR(200) NOT NULL,
    priority     VARCHAR(10)   NOT NULL DEFAULT 'Normal',
    status       VARCHAR(20)   NOT NULL DEFAULT 'Open',
    opened_at    DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME(),
    opened_by    NVARCHAR(100) NOT NULL DEFAULT SUSER_SNAME()   -- the login name of whoever added the row
);
```

```sql
-- ✅ MySQL
CREATE TABLE support_tickets (
    ticket_id    INT AUTO_INCREMENT PRIMARY KEY,
    subject      VARCHAR(200) NOT NULL,
    priority     VARCHAR(10)  NOT NULL DEFAULT 'Normal',
    status       VARCHAR(20)  NOT NULL DEFAULT 'Open',
    opened_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    opened_by    VARCHAR(100) NOT NULL DEFAULT (CURRENT_USER())
);
```

Now this insert works even though we supplied only one column:

```sql
INSERT INTO support_tickets (subject) VALUES ('Laptop will not power on');
```

> [!IMPORTANT]
> 🎯 **When to use DEFAULT:** status columns, created-at timestamps, counters starting at 0, yes/no flags, and "created by" columns that record who did what. Anywhere the sensible value is obvious and you do not want every insert statement to repeat it.

## 8.4 📄 Creating a table from a query

Extremely useful for backups before a risky change, and for building report tables.

```sql
-- ✅ MSSQL: SELECT ... INTO creates the table and copies rows
SELECT *
INTO products_backup_2026_09
FROM products;

-- Structure only, zero rows (a false condition copies nothing)
SELECT *
INTO products_empty_copy
FROM products
WHERE 1 = 0;
```

```sql
-- ✅ MySQL: CREATE TABLE ... AS SELECT (often called CTAS)
CREATE TABLE products_backup_2026_09 AS
SELECT * FROM products;

-- Structure only, zero rows
CREATE TABLE products_empty_copy AS
SELECT * FROM products WHERE 1 = 0;

-- Exact structural clone INCLUDING indexes and constraints
CREATE TABLE products_clone LIKE products;
```

> [!WARNING]
> ⚠️ **Important limitation:** `SELECT INTO` and `CREATE TABLE AS SELECT` copy the **data and column types only**. They do **not** copy primary keys, foreign keys, indexes, defaults, or check constraints. The copy is a bag of rows, not a properly protected table. Use MySQL's `CREATE TABLE ... LIKE` when you need a true structural clone.

> [!TIP]
> 💡 **Pro tip — the 30-second safety net.** Before any risky `UPDATE` or `DELETE` on production, take a copy first:
> ```sql
> -- 🟥 MSSQL (MySQL: CREATE TABLE orders_before_fix AS SELECT * FROM orders WHERE ...)
> SELECT * INTO orders_before_fix FROM orders WHERE order_date >= '2026-01-01';
> ```
> It costs seconds. It has saved thousands of careers.

## 8.5 🧪 Try it yourself

1. Create a `wishlists` table linking `customers` and `products`, with a `created_at` default and a unique constraint preventing the same product twice per customer.
2. Create it with the composite primary key `(customer_id, product_id)` instead of a surrogate ID (a made-up ID number — explained in 9.2). Which do you prefer, and why?
3. Make a backup copy of `products`, then confirm with the constraint-listing query from 9.6 that the copy has **no** primary key.

---

# 9. Constraints, the rules that protect your data

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 30 min | Use the six kinds of rules (constraints) · Link tables with foreign keys · Choose what happens when a linked row is deleted |

> [!NOTE]
> 📌 **In plain words:** Constraints are **rules the database refuses to break**. They are your last line of defence — the one that still works when the app has a bug, when someone runs SQL by hand, or when a new developer joins.

> 🌍 **Analogy:** Constraints are the **bouncers at the club door**. The app might be careless about who it invites, but the bouncer checks every single person, every single time, with no exceptions and no bad days.

## 9.1 🗂️ The six constraint types

| Constraint | Guarantees | Real-world meaning in ShopDB |
|---|---|---|
| `NOT NULL` | A value must be present | Every customer must have an email |
| `UNIQUE` | No two rows share the value | No two customers share an email |
| `PRIMARY KEY` | Unique **and** not null | Each customer has exactly one ID |
| `FOREIGN KEY` | The value exists in another table | An order cannot reference customer #999 if there is no #999 |
| `CHECK` | The value passes a test you write | A rating is between 1 and 5 |
| `DEFAULT` | A value is supplied when omitted | New orders start as 'Pending' |

## 9.2 🔑 PRIMARY KEY

```sql
-- Single-column, inline
CREATE TABLE brands (
    brand_id   INT PRIMARY KEY,
    brand_name VARCHAR(80) NOT NULL
);

-- Named constraint (preferred: you can drop and reference it later)
CREATE TABLE brands2 (
    brand_id   INT NOT NULL,
    brand_name VARCHAR(80) NOT NULL,
    CONSTRAINT pk_brands2 PRIMARY KEY (brand_id)
);

-- Composite key: two columns TOGETHER form the ID; uniqueness comes from the COMBINATION
CREATE TABLE order_items_demo (
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    CONSTRAINT pk_order_items_demo PRIMARY KEY (order_id, product_id)
);
```

**The rules of a primary key:**

1. It is **unique** — no duplicates, ever.
2. It is **never NULL**.
3. There is **exactly one** per table.
4. It should be **stable** — never updated after insert.
5. It automatically gets an index (a *clustered* one by default in MSSQL and in MySQL's InnoDB engine — explained just below).

> 🔀 **A hidden but important difference:** In **MSSQL**, the primary key becomes a **clustered index** by default — the rows are physically stored in primary-key order, like words in a dictionary. In **MySQL/InnoDB** this is always true, *and* every other index on the table also stores a copy of the primary key. So a long primary key (such as a 200-character email) makes every index on that table bigger and slower in MySQL.

**🆔 Natural key vs surrogate key — a decision you will make on every table.** A *natural key* is real-world data that is already unique, such as an email address or an ISBN. A *surrogate key* is a number the database invents purely to be the ID:

| | **Natural key** (real data) | **Surrogate key** (meaningless ID) |
|---|---|---|
| Example | `email`, `isbn`, `country_code` | `customer_id INT IDENTITY` |
| ✅ Pros | No extra column, meaningful, no join needed for the value | Small, fast, never changes, private |
| ❌ Cons | Can change (people change email!), often wide, exposes data | Extra column, needs a `UNIQUE` on the natural key too |
| 🎯 Verdict | Fine for tiny fixed lookups (`country_code CHAR(2)`) | **Default choice for almost every business table** |

> [!TIP]
> 💡 **Pro tip:** Use a surrogate key as the primary key **and** put a `UNIQUE` constraint on the natural key. You get fast stable joins *and* the real-world uniqueness rule. `ShopDB.customers` does exactly this: `customer_id` is the PK, `email` is `UNIQUE`.

## 9.3 🔗 FOREIGN KEY and referential integrity

A **foreign key** links a row to a row in another table. **Referential integrity** means every link points at something that really exists — an order can never belong to a customer who does not exist.

```sql
-- ✅ Works in BOTH
CREATE TABLE order_notes (
    note_id    INT NOT NULL,
    order_id   INT NOT NULL,
    note_text  VARCHAR(500) NOT NULL,
    CONSTRAINT pk_order_notes PRIMARY KEY (note_id),
    CONSTRAINT fk_notes_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);
```

**Watch it protect you:**

```sql
-- ❌ This FAILS: customer 9999 does not exist
INSERT INTO orders (customer_id, order_date) VALUES (9999, '2026-09-01');
-- MSSQL: The INSERT statement conflicted with the FOREIGN KEY constraint...
-- MySQL: Cannot add or update a child row: a foreign key constraint fails...
```

**What happens to linked rows when a row is deleted?** The row being pointed at is the *parent* (an order); the rows pointing at it are its *children* (that order's notes). You choose the behaviour:

| Action | What it does | 🎯 Use when |
|---|---|---|
| `NO ACTION` / `RESTRICT` | **Blocks** the delete (the default) | The child rows are important records. Safest default. |
| `CASCADE` | Deletes the children too | Children are meaningless alone: order items, cart lines, note attachments |
| `SET NULL` | Sets the child's FK to NULL (column must be nullable) | The link is optional: an order keeps existing when its sales rep leaves |
| `SET DEFAULT` | Sets the child's FK to its default | Rare; a "Unassigned" placeholder row exists |

```sql
-- ✅ Works in BOTH. Shown as ALTER statements so each one runs on its own;
--    inside CREATE TABLE you would write the same CONSTRAINT ... line.

-- 🎯 CASCADE: deleting an order should delete its attachments
--    (a new child table, because order_items already cascades from orders and
--     MSSQL refuses a second cascade path to the same table — see the note below)
CREATE TABLE order_attachments (
    attachment_id INT PRIMARY KEY,
    order_id      INT NOT NULL,
    file_name     VARCHAR(200) NOT NULL
);
ALTER TABLE order_attachments
    ADD CONSTRAINT fk_attachments_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id) ON DELETE CASCADE;

-- 🎯 SET NULL: an employee leaving must NOT delete their orders
ALTER TABLE orders
    ADD CONSTRAINT fk_orders_employee_demo FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id) ON DELETE SET NULL;

-- 🎯 RESTRICT: never delete a product that has been sold
ALTER TABLE order_items
    ADD CONSTRAINT fk_items_product_demo FOREIGN KEY (product_id)
        REFERENCES products(product_id) ON DELETE NO ACTION;
```

> [!WARNING]
> ⚠️ **`ON DELETE CASCADE` is a loaded gun.** Deleting one customer can silently erase their orders, those orders' items, and those orders' payments — thousands of rows, no warning. Use it only where the child truly cannot exist alone. For customers, prefer a **soft delete** — marking the row as inactive (`is_active = 0`) instead of really deleting it ([Chapter 19](#19-delete-truncate-drop)). That is what real online shops do.

> 🔀 **MSSQL restriction:** MSSQL refuses any set-up where one delete could cascade into the same table along two different routes (the error says *"may cause cycles or multiple cascade paths"*). MySQL allows more, but has its own limit on how deep a chain of cascades can go. If you meet this error, the fix is usually to handle the delete in a stored procedure (a saved SQL program, Chapter 37) or a trigger (Chapter 39) instead.

> [!CAUTION]
> 🐛 **Common mistake (MySQL):** Foreign keys are **silently ignored** by the `MyISAM` storage engine. If your FKs seem to do nothing, run `SHOW CREATE TABLE your_table;` and confirm it says `ENGINE=InnoDB`.

## 9.4 ✔️ UNIQUE

```sql
-- (customers.email already got its UNIQUE in Chapter 4; a second identical
--  constraint would only build a redundant index — so these use new rules)

-- Single column: no two suppliers with the same company name
ALTER TABLE suppliers ADD CONSTRAINT uq_suppliers_company UNIQUE (company_name);

-- Composite: the COMBINATION must be unique
ALTER TABLE employees
    ADD CONSTRAINT uq_employees_full_name UNIQUE (first_name, last_name);
```

| | `PRIMARY KEY` | `UNIQUE` |
|---|---|---|
| How many per table | Exactly 1 | As many as you like |
| Allows NULL | ❌ Never | ✅ Yes |
| NULL behaviour | n/a | 🔀 **MSSQL: only ONE NULL allowed.** MySQL: **many NULLs allowed** |
| Creates an index | ✅ Clustered by default | ✅ Non-clustered |

> 🔀 **That NULL difference matters in practice.** A nullable `tax_id UNIQUE` column: MySQL happily stores 500 customers with no tax ID; MSSQL rejects the second one. The MSSQL fix is a **filtered unique index** — a uniqueness rule that only covers the rows you choose:
> ```sql
> -- 🟥 MSSQL: unique only among rows that actually have a value
> ALTER TABLE customers ADD tax_id VARCHAR(30) NULL;
> GO
> CREATE UNIQUE INDEX uq_customers_taxid
>     ON customers(tax_id) WHERE tax_id IS NOT NULL;
> ```

## 9.5 🛂 CHECK constraints

> ℹ️ **Note:** `ShopDB` already created `ck_products_price`, `ck_items_discount`, and the tier check in [Chapter 4](#4-the-sample-database-shopdb). Re-adding a constraint name that already exists fails with *"There is already an object named 'ck_products_price' in the database"* — so the examples below use `_demo` suffixes to stay runnable on your existing database.

```sql
-- ✅ Works in BOTH (MySQL enforces CHECK from version 8.0.16 onward)
ALTER TABLE products
    ADD CONSTRAINT ck_products_price_demo CHECK (unit_price >= 0);

ALTER TABLE order_items
    ADD CONSTRAINT ck_items_discount_demo CHECK (discount >= 0 AND discount <= 0.9);

ALTER TABLE orders
    ADD CONSTRAINT ck_orders_dates CHECK (ship_date IS NULL OR ship_date >= order_date);

ALTER TABLE customers
    ADD CONSTRAINT ck_customers_email_shape CHECK (email LIKE '%_@_%._%');
```

> [!NOTE]
> 📌 **Read `ck_orders_dates` carefully.** It says: *"either the order has not shipped, or it shipped on or after the order date."* You have just made time travel impossible in your database. No application bug can ever create an order shipped before it was placed.

> [!WARNING]
> ⚠️ **MySQL versions before 8.0.16 parsed `CHECK` and then silently ignored it.** If you are on an older MySQL, your check constraints are decoration, not enforcement. Verify with `SELECT VERSION();`.

> [!TIP]
> 💡 **Pro tip:** A `CHECK` constraint can reference multiple columns in the same row, but **not other tables** and **not subqueries**. For cross-table rules, use a trigger ([Chapter 39](#39-triggers)) or handle it in a stored procedure.

## 9.6 🧭 Adding, dropping, and inspecting constraints

```sql
-- ✅ Works in BOTH: add
ALTER TABLE products ADD CONSTRAINT ck_products_reorder CHECK (reorder_level >= 0);

-- ✅ Works in BOTH: drop
ALTER TABLE products DROP CONSTRAINT ck_products_reorder;
```

```sql
-- 🟦 MySQL also has type-specific drop syntax
ALTER TABLE products  DROP FOREIGN KEY fk_products_supplier;
ALTER TABLE suppliers DROP INDEX uq_suppliers_company;  -- the UNIQUE added in 9.4
ALTER TABLE brands2   DROP PRIMARY KEY;                -- from 9.2 (allowed because brands2 has no AUTO_INCREMENT column)
```

**Inspecting what constraints exist:**

```sql
-- 🟥 MSSQL
SELECT
    t.name       AS table_name,
    c.name       AS constraint_name,
    c.type_desc  AS constraint_type
FROM sys.objects c
JOIN sys.tables  t ON t.object_id = c.parent_object_id
WHERE c.type IN ('PK','UQ','F','C','D')
ORDER BY t.name, c.type_desc;
```

```sql
-- 🟦 MySQL
SELECT table_name, constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'ShopDB'
ORDER BY table_name, constraint_type;
```

> [!TIP]
> 💡 **Pro tip — name every constraint.** An automatically generated name like `CK__products__unit___3B75D760` is impossible to use in a change script, and it is different on every server. Adopt a convention and never break it:
>
> | Prefix | Meaning | Example |
> |---|---|---|
> | `pk_` | Primary key | `pk_orders` |
> | `fk_` | Foreign key | `fk_orders_customer` |
> | `uq_` | Unique | `uq_customers_email` |
> | `ck_` | Check | `ck_products_price` |
> | `df_` | Default | `df_orders_status` |
> | `ix_` | Index | `ix_orders_order_date` |

## 9.7 🧪 Try it yourself

1. Try to insert a customer with a duplicate email. Read the error. Now try a `loyalty_tier` of `'Diamond'`. Read that error too.
2. Try to delete customer #1 (who has orders). Which constraint stops you, and what exactly does the message say?
3. Add a `CHECK` to `employees` ensuring `hire_date` is not in the future. Test it.
4. Delete order 1000 and observe what happens to its rows in `order_items` and `payments`. Explain why.

---
# 10. Auto-numbering: IDENTITY vs AUTO_INCREMENT

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Let the database number rows for you · Get the ID of the row you just added · Know when a GUID is the better ID |

> [!NOTE]
> 📌 **In plain words:** You should not have to invent a new ID number for every row you insert. Auto-numbering lets the database hand out `1, 2, 3, 4…` automatically and guarantees no two rows get the same one.

> 🌍 **Analogy:** The **ticket dispenser at a bakery counter**. You do not choose your number; you pull the next one. Two customers can never get the same ticket, even if they pull at the same instant.

## 10.1 🟥 MSSQL: IDENTITY

```sql
CREATE TABLE invoices (
    invoice_id  INT IDENTITY(1,1) PRIMARY KEY,   -- start at 1, step by 1
    amount      DECIMAL(10,2) NOT NULL
);

-- IDENTITY(seed, increment): seed = the first number, increment = the step
-- IDENTITY(1000, 1)   → 1000, 1001, 1002 ...
-- IDENTITY(1, 10)     → 1, 11, 21, 31 ...
```

```sql
-- Insert WITHOUT the identity column — the engine fills it
INSERT INTO invoices (amount) VALUES (250.00);

-- Get the ID that was just generated (3 ways, use SCOPE_IDENTITY)
SELECT SCOPE_IDENTITY()  AS best_choice;   -- ✅ the ID from YOUR last insert, in THIS piece of code
SELECT @@IDENTITY        AS risky;         -- ⚠️ can return an ID created by a TRIGGER instead!
SELECT IDENT_CURRENT('invoices') AS also_risky;  -- ⚠️ the latest ID from ANYONE's insert
```

> [!WARNING]
> ⚠️ **Use `SCOPE_IDENTITY()`, not `@@IDENTITY`.** If a trigger on `invoices` inserts a row into an audit table, `@@IDENTITY` returns the **audit table's** ID, silently corrupting your logic. This is a genuine production bug that has cost companies real money.

**The modern, best way — `OUTPUT`.** It hands the new rows straight back to you as a result grid, including their new IDs:

```sql
-- ✅ MSSQL: works correctly even for multi-row inserts
INSERT INTO invoices (amount)
OUTPUT inserted.invoice_id, inserted.amount
VALUES (100.00), (200.00), (300.00);
```

**Inserting your own ID number.** Normally SQL Server refuses to let you choose the ID. `IDENTITY_INSERT` switches that protection off for one table, for a moment:

```sql
SET IDENTITY_INSERT invoices ON;
INSERT INTO invoices (invoice_id, amount) VALUES (5000, 999.00);
SET IDENTITY_INSERT invoices OFF;   -- always turn it back off!
```

**Resetting the counter** (`DBCC` = SQL Server's *Database Console Commands*, its maintenance toolbox):

```sql
DBCC CHECKIDENT ('invoices', RESEED, 6000);   -- next insert gets 6001
DBCC CHECKIDENT ('invoices', NORESEED);        -- just report the current value
-- ⚠️ Never reseed BELOW the highest existing value: the next insert collides with a key that already exists
```

## 10.2 🟦 MySQL: AUTO_INCREMENT

```sql
CREATE TABLE invoices (
    invoice_id  INT AUTO_INCREMENT PRIMARY KEY,
    amount      DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1000;   -- optional starting value
```

```sql
INSERT INTO invoices (amount) VALUES (250.00);

-- Get the generated ID
SELECT LAST_INSERT_ID();   -- ✅ per-connection, safe from other users
```

> [!TIP]
> 💡 **`LAST_INSERT_ID()` belongs to your connection only.** Another user inserting at the same moment cannot change your value. For a **multi-row** insert it returns the ID of the **first** row generated, and the rest follow consecutively.

**Inserting explicit values and resetting:**

```sql
-- No special switch needed; just supply the value
INSERT INTO invoices (invoice_id, amount) VALUES (5000, 999.00);

-- Reset the counter. Ask for a number lower than an existing ID and MySQL quietly uses (highest ID + 1)
ALTER TABLE invoices AUTO_INCREMENT = 1;
```

## 10.3 🔀 Side-by-side comparison

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Declare | `INT IDENTITY(1,1)` | `INT AUTO_INCREMENT` |
| Custom start | `IDENTITY(1000,1)` | `AUTO_INCREMENT=1000` on the table |
| Custom step | `IDENTITY(1,10)` | Server variable `auto_increment_increment` |
| Get last ID | `SCOPE_IDENTITY()` | `LAST_INSERT_ID()` |
| Insert explicit value | `SET IDENTITY_INSERT t ON` | Just insert it |
| Reset | `DBCC CHECKIDENT(...)` | `ALTER TABLE t AUTO_INCREMENT = n` |
| Per table limit | One identity column | One auto_increment column (**must be indexed**) |
| Gaps after rollback | ✅ Yes, gaps happen | ✅ Yes, gaps happen |

## 10.4 🕳️ Gaps are normal — stop trying to fix them

```sql
-- 🟥 MSSQL
BEGIN TRANSACTION;
INSERT INTO invoices (amount) VALUES (10.00);   -- takes ID 7
ROLLBACK;                                        -- row is gone... but 7 is used up

INSERT INTO invoices (amount) VALUES (20.00);   -- gets ID 8, not 7
```

```sql
-- 🟦 MySQL: identical, except a transaction starts with START TRANSACTION
START TRANSACTION;
INSERT INTO invoices (amount) VALUES (10.00);
ROLLBACK;

INSERT INTO invoices (amount) VALUES (20.00);   -- the rolled-back ID is skipped
```

> [!NOTE]
> 📌 **In plain words:** Auto-numbers promise that **no two rows share a number** — they do **not** promise that the numbers have no gaps. A cancelled (rolled-back) insert, a failed insert, or a deleted row leaves a permanent hole. This is deliberate: to avoid holes, every user would have to wait in one single queue to insert, and a busy database would crawl.

> [!WARNING]
> ⚠️ **Never use an auto-number as an invoice number, receipt number, or anything legally sequential.** Auditors require numbers with no gaps. Generate those yourself in a small counter table (slower, but gap-free), or use a numbering scheme with a date prefix.

## 10.5 🆔 The alternative: GUIDs / UUIDs

> [!NOTE]
> 📌 **In plain words:** a **GUID** (Microsoft's name) or **UUID** (everyone else's name) is a 36-character random ID such as `3f2504e0-4f89-11d3-9a0c-0305e82c3301`. It is so random that thousands of computers can create IDs at the same moment without ever producing the same one.

```sql
-- 🟥 MSSQL
CREATE TABLE sessions (
    session_id  UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() PRIMARY KEY,
    user_id     INT NOT NULL
);
-- NEWSEQUENTIALID() generates GUIDs that always increase, which keeps the index tidy
```

```sql
-- 🟦 MySQL
CREATE TABLE sessions (
    session_id  CHAR(36) NOT NULL DEFAULT (UUID()) PRIMARY KEY,
    user_id     INT NOT NULL
);
-- Better for storage/indexing: BINARY(16) with UUID_TO_BIN(UUID(), 1)
```

| | Auto-number (INT) | GUID / UUID |
|---|---|---|
| Size | 4 bytes | 16 bytes (36 as text!) |
| Index performance | ✅ Excellent — new rows always go at the end | ⚠️ Random values scatter new rows all over the index, slowing inserts |
| Guessable by outsiders | ⚠️ Yes (`/orders/1001` → try `1002`) | ✅ No |
| Generated by the app before insert | ❌ No | ✅ Yes — useful for apps that work offline or run on many servers |
| Merging data from multiple servers | ❌ Collisions | ✅ No collisions |

> [!TIP]
> 💡 **The professional compromise used by many real systems:** keep an `INT IDENTITY` as the internal primary key (fast joins, small indexes) **and** add a `UNIQUE` GUID column as the ID shown to the outside world (in web addresses and apps). Best of both.

## 10.6 🎯 When to use which key strategy

| Your situation | Use |
|---|---|
| A normal business table (customers, orders, products) | `INT IDENTITY` / `AUTO_INCREMENT` |
| More than ~2 billion rows expected (events, logs, sensor data) | `BIGINT` auto-number |
| IDs must not be guessable in a public URL | `INT` internally **+ a `UNIQUE` GUID** for the outside world |
| Rows are created offline, or merged from several servers | GUID / UUID |
| The application needs the ID *before* inserting | A **sequence** ([Ch 41](#41-sequences-and-generated-columns)) or a GUID |
| Legally gapless numbering (invoices, receipts) | ❌ **Not an auto-number** — a controlled counter table |
| A pure link/bridge table (`order_items`) | ❌ No surrogate at all — use the composite key |

> [!CAUTION]
> 🐛 **Common mistake:** adding an `id INT IDENTITY` primary key to a bridge table that already has a perfectly good natural key of `(order_id, product_id)`. It adds a column, adds an index, and — worst of all — **stops the database preventing duplicates**, because now two rows with the same order and product are "different" rows.

## 10.7 🧪 Try it yourself

1. Insert a product without specifying `product_id`. Retrieve the generated ID immediately, using the correct function for your engine.
2. Start a transaction, insert a row, roll it back, then insert again. Prove to yourself the gap is permanent.
3. Insert three rows in one statement and capture all three generated IDs (`OUTPUT` in MSSQL; `LAST_INSERT_ID()` plus arithmetic in MySQL).

---

# 11. ALTER and DROP

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Add, change, rename, and remove columns · Tell `DELETE`, `TRUNCATE`, and `DROP` apart · Change live tables safely |

> [!NOTE]
> 📌 **In plain words:** `ALTER` changes an existing table's design without losing its data. `DROP` destroys objects completely. One is a renovation; the other is a demolition.

> 🌍 **Analogy:** `ALTER` is adding a new room to a house while the family still lives in it. `DROP` is knocking the whole house down — and everything inside goes with it.

## 11.1 ➕ Adding columns

```sql
-- ✅ Works in BOTH
ALTER TABLE customers ADD date_of_birth DATE NULL;

-- 🟥 MSSQL: multiple columns in one statement
ALTER TABLE customers ADD
    marketing_opt_in BIT NOT NULL CONSTRAINT df_customers_marketing_opt_in DEFAULT 0,
    referral_code    VARCHAR(20) NULL;
```

```sql
-- 🟦 MySQL: needs ADD COLUMN for each, and supports positioning
ALTER TABLE customers
    ADD COLUMN marketing_opt_in BOOLEAN NOT NULL DEFAULT 0,
    ADD COLUMN referral_code    VARCHAR(20) NULL AFTER email;
```

> [!WARNING]
> ⚠️ **Adding a `NOT NULL` column to a table that already has rows** requires a `DEFAULT`, otherwise the existing rows would have no value and the statement fails. On very large tables, adding a `NOT NULL` column with a default can rewrite the entire table — check your engine version and plan it for a quiet, pre-announced time (a *maintenance window*).

## 11.2 ✏️ Changing a column

> 🔀 **This is one of the biggest syntax differences between the two engines.**

```sql
-- 🟥 MSSQL: ALTER COLUMN, and you restate only the type/nullability
ALTER TABLE customers ALTER COLUMN phone VARCHAR(40);
ALTER TABLE customers ALTER COLUMN city NVARCHAR(60) NOT NULL;
```

```sql
-- 🟦 MySQL: MODIFY changes the definition; CHANGE also renames
ALTER TABLE customers MODIFY COLUMN phone VARCHAR(40);
ALTER TABLE customers MODIFY COLUMN city VARCHAR(60) NOT NULL;

-- CHANGE = rename + redefine (you must restate the full definition)
ALTER TABLE customers CHANGE COLUMN phone phone_number VARCHAR(40) NULL;
ALTER TABLE customers CHANGE COLUMN phone_number phone VARCHAR(40) NULL;   -- and back again
```

> [!WARNING]
> ⚠️ **MySQL `MODIFY` replaces the ENTIRE definition.** If the column was `NOT NULL DEFAULT 'x'` and you write `MODIFY COLUMN phone VARCHAR(40)`, you have just silently dropped both the `NOT NULL` and the `DEFAULT`. Always restate everything you want to keep.

**Safe type changes vs dangerous ones:**

| Change | Risk |
|---|---|
| `VARCHAR(50)` → `VARCHAR(100)` | ✅ Safe, widening |
| `INT` → `BIGINT` | ✅ Safe, widening |
| `VARCHAR(100)` → `VARCHAR(50)` | ⚠️ Fails, or cuts off (truncates) any longer text |
| `VARCHAR` → `INT` | ⚠️ Fails on any non-numeric row |
| `NULL` → `NOT NULL` | ⚠️ Fails if any row is NULL — clean the data first |
| `DECIMAL(10,2)` → `DECIMAL(10,4)` | ✅ Safe |
| `DECIMAL(10,4)` → `DECIMAL(10,2)` | ⚠️ Silent rounding, data loss |

> [!TIP]
> 💡 **Pro tip — always check before you shrink:**
> ```sql
> -- 🟥 MSSQL
> SELECT MAX(LEN(phone)) FROM customers;
> ```
> ```sql
> -- 🟦 MySQL
> SELECT MAX(CHAR_LENGTH(phone)) FROM customers;
> ```

## 11.3 🏷️ Renaming

```sql
-- 🟥 MSSQL: a built-in stored procedure (a saved program), not a normal SQL statement
EXEC sp_rename 'customers.phone', 'phone_number', 'COLUMN';
EXEC sp_rename 'customers', 'clients';

-- Put both names back, so the rest of this guide still works
EXEC sp_rename 'clients', 'customers';
EXEC sp_rename 'customers.phone_number', 'phone', 'COLUMN';
```

```sql
-- 🟦 MySQL
ALTER TABLE customers RENAME COLUMN phone TO phone_number;  -- MySQL 8.0+
ALTER TABLE customers RENAME TO clients;
RENAME TABLE clients TO customers;                          -- alternative syntax (and puts the name back)
ALTER TABLE customers RENAME COLUMN phone_number TO phone;  -- restore the column name too
```

> [!WARNING]
> ⚠️ **Renaming does not update anything that references the old name.** Views, stored procedures, functions, and application code all break silently. In MSSQL, `sp_rename` even prints a warning about this. Search all of your code before renaming anything on a live server.

## 11.4 ➖ Dropping columns

```sql
-- ✅ Works in BOTH
ALTER TABLE customers DROP COLUMN date_of_birth;
```

```sql
-- ✅ MySQL: several at once
ALTER TABLE customers DROP COLUMN referral_code, DROP COLUMN marketing_opt_in;
```

```sql
-- ✅ MSSQL: several at once (comma-separated column list, one DROP COLUMN)
-- A column with a DEFAULT cannot be dropped until its default constraint is dropped
ALTER TABLE customers DROP CONSTRAINT df_customers_marketing_opt_in;
ALTER TABLE customers DROP COLUMN referral_code, marketing_opt_in;
```

> [!WARNING]
> ⚠️ You usually cannot drop a column that is part of a primary key, referenced by a foreign key, used by an index, or referenced by a check constraint or computed column. **Drop the dependent object first.**

## 11.5 💣 DROP vs TRUNCATE vs DELETE

This is one of the most common interview questions in existence. Learn this table cold.

| | `DELETE` | `TRUNCATE` | `DROP` |
|---|---|---|---|
| **What it removes** | Chosen rows | **All** rows | Rows **and the table itself** |
| **Command family** | DML | DDL | DDL |
| **`WHERE` clause** | ✅ Yes | ❌ No | ❌ No |
| **Speed on big tables** | 🐢 Slow (row by row) | 🚀 Very fast (frees whole blocks of storage at once) | 🚀 Very fast |
| **Recorded in the log** | Every row | Very little | Very little |
| **Fires triggers** | ✅ Yes | ❌ No | ❌ No |
| **Resets auto-number** | ❌ No | ✅ Yes | n/a |
| **Can be undone (rolled back)** | ✅ Yes | ✅ MSSQL yes (inside a transaction). ⚠️ MySQL **no** — it saves automatically | ⚠️ MSSQL yes. MySQL **no** |
| **Blocked by a foreign key** | Yes, if children exist | Yes, always if any FK points at it | Yes, until the FK is dropped |
| **Table structure survives** | ✅ Yes | ✅ Yes | ❌ No |

```sql
-- ✅ Works in BOTH
-- A throwaway table to demonstrate on (Chapter 12 builds the real staging tables)
CREATE TABLE staging_orders (order_id INT, status VARCHAR(20));
INSERT INTO staging_orders VALUES (1, 'Pending'), (2, 'Paid');

-- DELETE: surgical
DELETE FROM order_items WHERE order_id = 1004;

-- TRUNCATE: empty the table, keep the structure
TRUNCATE TABLE staging_orders;

-- DROP: the table is gone
DROP TABLE staging_orders;
```

> [!TIP]
> 💡 **How to remember it:** `DELETE` erases *some words*. `TRUNCATE` erases *the whole page*. `DROP` throws away *the whole notebook*.

## 11.6 🛡️ Safe DDL habits for production

```sql
-- ✅ Works in BOTH: guard against "does not exist" errors
DROP TABLE IF EXISTS staging_orders;
```

```sql
-- 🟥 MSSQL: check before you act
IF OBJECT_ID('dbo.staging_orders', 'U') IS NOT NULL
    DROP TABLE dbo.staging_orders;

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.customers') AND name = 'referral_code')
    ALTER TABLE dbo.customers ADD referral_code VARCHAR(20) NULL;
```

> [!TIP]
> 💡 **The five rules of production DDL:**
>
> 1. **Back up first.** Always. `SELECT * INTO table_backup FROM table;` takes seconds.
> 2. **Run it on a copy first.** A development copy, then a test (*staging*) copy, then the real server. Never the reverse.
> 3. **Wrap it in a transaction** where the engine supports it, and verify before committing.
> 4. **Know how long it will block users.** `ALTER TABLE` on a 200-million-row table can lock everyone out of it for hours. Check whether your version can make the change *online* (without blocking).
> 5. **Write the script that undoes the change before you run the change.** If you cannot describe how to undo it, you are not ready to run it.

```sql
-- 🟦 MySQL 8.0: control how the ALTER is performed
ALTER TABLE customers ADD COLUMN nickname VARCHAR(50), ALGORITHM=INSTANT;
-- ALGORITHM = INSTANT (fastest: changes only the table's description, not its rows) | INPLACE | COPY
-- LOCK      = NONE (reads and writes continue) | SHARED | EXCLUSIVE
```

> 🔎 **Doing this repeatedly, on many servers, without a human at a keyboard is [Chapter 64](#64-database-devops-migrations-standards-and-testing)** — versioned migrations, idempotent scripts (safe to run twice), and the expand–contract pattern for changes that cannot break a running application.

## 11.7 🧪 Try it yourself

1. Add a `notes VARCHAR(500)` column to `orders`, populate it for one row, then drop it.
2. Try to change `customers.email` to `VARCHAR(10)`. Read the error and explain it.
3. Create a copy of `products`, `TRUNCATE` it, and check whether the auto-number restarted at 1.
4. Try to `DROP TABLE customers`. Which constraint blocks you? What would you have to drop first?

---

# 📥 PART 3 — WORKING WITH DATA (CRUD)

> **CRUD** = **C**reate (`INSERT`), **R**ead (`SELECT`), **U**pdate (`UPDATE`), **D**elete (`DELETE`). These four verbs are 95% of the SQL written in the world.

---

# 12. INSERT, putting data in

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Add one row or many · Copy rows from another table · Avoid inserting duplicates · Load data from a file |

> [!NOTE]
> 📌 **In plain words:** `INSERT` adds new rows to a table. That is the whole idea — but there are five useful variations worth knowing.

> 🌍 **Analogy:** Adding new cards to a card index box. You can add one card, a whole stack at once, or photocopy cards from another box.

## 12.1 ✍️ The basic INSERT

```sql
-- ✅ Works in BOTH: always list your columns explicitly
INSERT INTO categories (category_name, description)
VALUES ('Gaming', 'Consoles, controllers, and gaming accessories');
```

```sql
-- ⚠️ 🟥 MSSQL: works (the IDENTITY column is skipped), but NEVER do this in real code
INSERT INTO categories VALUES ('Wearables', 'Smartwatches and fitness bands');
```

```sql
-- ⚠️ 🟦 MySQL: every column must be supplied, even the AUTO_INCREMENT one (NULL = generate it)
INSERT INTO categories VALUES (NULL, 'Wearables', 'Smartwatches and fitness bands');
```

> [!WARNING]
> ⚠️ **Why leaving out the column list is dangerous:** it depends on column *order*. The day someone adds a column in the middle, every one of these statements silently writes data into the wrong column, or fails at 3 a.m. **Always name your columns.** It costs 10 seconds and prevents a whole family of failures on live systems.

## 12.2 📦 Inserting multiple rows at once

> 💡 **Why one multi-row `INSERT` beats three single-row ones:** each separate statement is its own
> round trip to the server and, under autocommit, its own transaction — with its own log flush. One
> statement means one round trip and one commit. The gap is negligible for three rows and large for
> thousands; it grows with network latency and with how durable your commit settings are.

```sql
-- ✅ Works in BOTH — and it is one round trip instead of three
INSERT INTO categories (category_name, description) VALUES
('Cameras',     'Action cameras and camcorders'),
('Networking',  'Routers, switches, cables'),
('Accessories', 'Bags, stands, adapters');
```

> [!TIP]
> 💡 **Pro tip:** A single multi-row insert is one round trip (one message to the server and one reply) and one transaction. A thousand separate inserts are a thousand round trips. On a remote server, the difference is often **50x**. When loading data, batch your inserts in groups of 500 to 1000 rows.

## 12.3 📋 INSERT ... SELECT — copying data between tables

This is where `INSERT` becomes genuinely powerful.

```sql
-- ✅ Works in BOTH
-- Real-world task: archive every delivered order from before July 2026
CREATE TABLE orders_archive (
    order_id     INT PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    status       VARCHAR(20) NOT NULL
);

INSERT INTO orders_archive (order_id, customer_id, order_date, status)
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE status = 'Delivered'
  AND order_date < '2026-07-01';
```

The next example uses `JOIN`, `SUM`, and `GROUP BY`, which you will meet in Chapters 25–28. For now, just notice the shape: the `SELECT` produces rows, and `INSERT` saves them into the new table.

```sql
-- Real-world task: create a VIP list from an aggregate query
CREATE TABLE vip_customers (
    customer_id  INT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    lifetime_spend DECIMAL(12,2) NOT NULL
);

INSERT INTO vip_customers (customer_id, full_name, lifetime_spend)
SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount))
FROM customers c
JOIN orders      o  ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.customer_id, c.full_name
HAVING SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) > 2000;
```

## 12.4 🚫 Inserting only rows that do not already exist

`WHERE NOT EXISTS (…)` means *"only if no such row is found"* ([Chapter 30](#30-subqueries-and-exists) explains it fully):

```sql
-- ✅ Works in BOTH: the NOT EXISTS guard
INSERT INTO categories (category_name, description)
SELECT 'Gaming', 'Consoles and accessories'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE category_name = 'Gaming'
);
```

```sql
-- 🟦 MySQL shortcuts
INSERT IGNORE INTO categories (category_name, description)
VALUES ('Gaming', 'Consoles and accessories');
-- Silently skips rows that would violate a unique key

INSERT INTO categories (category_name, description)
VALUES ('Gaming', 'Consoles and accessories') AS new
ON DUPLICATE KEY UPDATE description = new.description;
-- Insert, or update if it already exists (a true UPSERT — see Chapter 44)
```

> [!WARNING]
> ⚠️ **Be careful with `INSERT IGNORE`.** It hides *every* error it can, not just duplicates — including text being cut short to fit. A row can end up saved with silently damaged values. Prefer `ON DUPLICATE KEY UPDATE` or an explicit `NOT EXISTS` guard.

## 12.5 🎯 Capturing what was inserted

```sql
-- 🟥 MSSQL: OUTPUT gives you the inserted rows back, even for many rows
INSERT INTO customers (full_name, email, country)
OUTPUT inserted.customer_id, inserted.full_name, inserted.signup_date
VALUES ('New Person', 'new.person@example.com', 'Canada');

-- Or capture them into a table for further processing
DECLARE @new_rows TABLE (customer_id INT, email NVARCHAR(150));

INSERT INTO customers (full_name, email, country)
OUTPUT inserted.customer_id, inserted.email INTO @new_rows
VALUES ('A', 'a@example.com', 'UK'), ('B', 'b@example.com', 'UK');

SELECT * FROM @new_rows;
```

```sql
-- 🟦 MySQL: LAST_INSERT_ID()
INSERT INTO customers (full_name, email, country)
VALUES ('New Person', 'new.person@example.com', 'Canada');

SELECT LAST_INSERT_ID() AS new_customer_id;
```

## 12.6 🚚 Bulk loading large files

> [!NOTE]
> 📌 **What a staging table is:** a plain table shaped like your incoming file, with **no rules at all**. You load the raw file into it, clean the data *there*, and only then move it into the real table. Several later chapters use these, so create them once now:

```sql
-- ✅ Works in BOTH: the staging tables used in Chapters 12, 19, 23 and 44
-- Deliberately NO constraints, NO indexes, NO foreign keys — staging must
-- accept messy data so you can inspect and fix it before it reaches production.

CREATE TABLE staging_products (
    product_name    VARCHAR(120),
    category_id     INT,
    supplier_id     INT,
    unit_price      DECIMAL(10,2),
    units_in_stock  INT
);

CREATE TABLE staging_orders (
    order_id     INT,
    customer_id  INT,
    order_date   DATE,
    status       VARCHAR(20)
);

CREATE TABLE staging_customers (
    customer_code  VARCHAR(50),      -- may contain junk like 'ABC123'
    full_name      VARCHAR(100),
    email          VARCHAR(150)
);
```

> [!TIP]
> 💡 **Why no constraints on a staging table?** Because a constraint would reject the bad rows *and abort your load*, leaving you with no idea how many were wrong or why. Load everything, then run checking queries (`TRY_CAST`, `LIKE`, `COUNT(*) … GROUP BY`) to find the problems, set the bad rows aside, and copy only the clean rows into the real table.

**Loading a file.** The next two examples load a **CSV file** — a spreadsheet saved as plain text, with commas between the values (in Excel: *File → Save As → CSV*).

> [!WARNING]
> ⚠️ **Before you run them:** create the file first, with a header row and these five columns in this order: `product_name,category_id,supplier_id,unit_price,units_in_stock`. The path is a path on the **database server's** computer — for a Docker or remote server, the file must be copied there. Without the file you will simply get *"file does not exist"*.

```sql
-- 🟥 MSSQL
BULK INSERT staging_products
FROM 'C:\data\products.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,              -- skip the header
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK                    -- locks the table while loading: much faster
);
```

```sql
-- 🟦 MySQL
LOAD DATA INFILE '/var/lib/mysql-files/products.csv'
INTO TABLE staging_products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_name, category_id, supplier_id, unit_price, units_in_stock);
```

> [!TIP]
> 💡 **Pro tip for loading millions of rows:** load into a **staging table with no indexes and no constraints**, clean the data there, then insert into the real table. Indexes make inserts slower; adding them once *after* the load is far faster than maintaining them during it.

> [!WARNING]
> ⚠️ **MySQL `LOAD DATA INFILE` and the `secure_file_priv` setting:** by default MySQL only reads files from one specific directory. Check it with `SHOW VARIABLES LIKE 'secure_file_priv';`. Use `LOAD DATA LOCAL INFILE` to read from the client machine instead, if the server permits it.

## 12.7 🐛 The four INSERT errors you will definitely hit

| Error | Cause | Fix |
|---|---|---|
| *Cannot insert NULL into column X* | A `NOT NULL` column got no value | Supply a value or add a `DEFAULT` |
| *Violation of UNIQUE KEY constraint* | The value already exists | Check first, or use an upsert (insert-or-update, Chapter 44) |
| *FOREIGN KEY constraint conflict* | The row it points to (the *parent*) does not exist | Insert the parent row first |
| *String or binary data would be truncated* | The text is longer than the column | Widen the column or shorten the data |

> [!TIP]
> 💡 **MSSQL 2019+ gives a much better truncation message** naming the exact table, column, and value. If you are on an older version, find the culprit yourself:
> ```sql
> -- 🟥 MSSQL
> SELECT * FROM staging_products WHERE LEN(product_name) > 120;
> ```

## 12.8 🧪 Try it yourself

1. Add three new products to the `Gaming` category in a single statement.
2. Copy every `Cancelled` order into a new `cancelled_orders_log` table using `INSERT ... SELECT`.
3. Deliberately trigger each of the four errors above and read the messages carefully.
4. Write an insert that only adds the category `'Audio'` if it does not already exist. Run it twice; confirm nothing changes the second time.

---

# 13. SELECT, the heart of SQL

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Read chosen columns and rows · Rename result columns · Calculate new values · Remove duplicate rows |

> [!NOTE]
> 📌 **In plain words:** `SELECT` asks the database a question and gets a table of rows back. You will write more `SELECT` statements in your career than every other command combined.

> 🌍 **Analogy:** Asking a librarian: *"Bring me the title and author of every book about cooking."* You say which details you want (the columns) and from where (the table); the librarian brings back a neat list. Nothing on the shelves changes.

## 13.1 🌱 The simplest possible queries

```sql
-- ✅ Works in BOTH

-- Every column, every row
SELECT * FROM customers;

-- Only the columns you need
SELECT full_name, email, city FROM customers;

-- SELECT does not even need a table
SELECT 1 + 1 AS answer;
SELECT 'Hello, SQL' AS greeting;
```

> [!WARNING]
> ⚠️ **`SELECT *` is fine while exploring, and a bad habit in real code.** Here is why:
>
> 1. It moves columns you do not need across the network — sometimes megabytes of `TEXT`.
> 2. It stops the database using some of its fastest shortcuts (*covering indexes*, Chapter 46), so it reads far more data than it needs.
> 3. Your app breaks in a new way when someone adds or reorders a column.
> 4. It hides your actual intent from the next reader.
>
> **In real applications, name your columns.**

> [!IMPORTANT]
> 🎯 **When `SELECT *` IS acceptable:**
> - Exploring a table you have never seen, interactively
> - `EXISTS (SELECT * FROM ...)` — the column list is ignored entirely
> - `INSERT INTO archive SELECT * FROM source` where the two tables are deliberately identical
> - Quick one-off checks you will never save
>
> Everywhere else — application code, views, stored procedures, reports — **name the columns**.

## 13.2 🏷️ Aliases — renaming columns and tables

```sql
-- ✅ Works in BOTH: column aliases with AS (AS is optional but clearer)
SELECT
    full_name    AS customer_name,
    email        AS contact_email,
    signup_date  AS joined_on
FROM customers;

-- Aliases with spaces or special characters
SELECT full_name AS "Customer Name" FROM customers;   -- ✅ both engines
```

```sql
-- 🟥 MSSQL also allows square brackets, and an alternative = form
SELECT full_name AS [Customer Name] FROM customers;
SELECT [Customer Name] = full_name FROM customers;
```

```sql
-- ✅ Works in BOTH: table aliases keep long queries readable
SELECT
    c.full_name,
    o.order_id,
    o.order_date
FROM customers AS c
JOIN orders    AS o ON o.customer_id = c.customer_id;
```

> [!TIP]
> 💡 **Pro tip:** Use short, meaningful table aliases (`c` for customers, `oi` for order_items), and use them the same way in all of your code. Never use `a`, `b`, `c` — after three joins nobody, including you, knows what `b` was.

## 13.3 🧮 Computed columns and expressions

An **expression** is a calculation, such as `unit_price * quantity`. The database works it out separately for every row and shows the answer as a new column.

```sql
-- ✅ Works in BOTH
-- Real-world task: show the true line total after discount
SELECT
    order_id,
    product_id,
    unit_price,
    quantity,
    discount,
    unit_price * quantity                       AS gross_amount,
    unit_price * quantity * (1 - discount)      AS net_amount,
    unit_price * quantity * discount            AS discount_amount
FROM order_items
WHERE order_id = 1002;
```

**String building differs between engines:**

```sql
-- 🟥 MSSQL: + concatenates strings
SELECT full_name + ' <' + email + '>' AS contact FROM customers;
```

```sql
-- 🟦 MySQL: + is ARITHMETIC. 'abc' + 'def' = 0 !
SELECT CONCAT(full_name, ' <', email, '>') AS contact FROM customers;
```

```sql
-- ✅ CONCAT works in BOTH — use it and forget the difference
SELECT CONCAT(full_name, ' <', email, '>') AS contact FROM customers;
```

> [!CAUTION]
> 🐛 **Common mistake:** A developer moving from MSSQL to MySQL writes `first_name + ' ' + last_name` and gets `0` for every row. MySQL converted the strings to numbers and added them. **`CONCAT()` is the answer that works in both engines.**

## 13.4 ♻️ DISTINCT — removing duplicates

```sql
-- ✅ Works in BOTH

-- Which countries do our customers come from?
SELECT DISTINCT country FROM customers ORDER BY country;

-- DISTINCT applies to the WHOLE row, not one column
SELECT DISTINCT country, city FROM customers ORDER BY country, city;

-- Count how many distinct countries
SELECT COUNT(DISTINCT country) AS country_count FROM customers;
```

> [!WARNING]
> ⚠️ **`DISTINCT` is often a symptom, not a solution.** If you added `DISTINCT` because your join suddenly produced duplicate rows, the real problem is the join (Chapter 28) — usually a missing condition, or one row matching many rows in the other table. `DISTINCT` hides the problem and makes the database do an expensive sort. Fix the join instead. See [Chapter 28](#28-joins-the-complete-picture).

## 13.5 🎩 Useful SELECT tricks

```sql
-- ✅ Works in BOTH

-- A fixed text column — handy for labelling rows when you combine two results (Chapter 29)
SELECT full_name, 'customer' AS record_type FROM customers;

-- Check structure quickly without reading data
SELECT * FROM orders WHERE 1 = 0;    -- returns column headers, zero rows

-- 🟦 MySQL: test an expression with no table at all
SELECT CONCAT('Total: ', CAST(1499.00 * 2 AS CHAR)) AS demo;

-- 🟥 MSSQL: the same test (MySQL has no VARCHAR target for CAST)
SELECT CONCAT('Total: ', CAST(1499.00 * 2 AS VARCHAR(20))) AS demo;
```

## 13.6 🧪 Try it yourself

1. List every product with its name, price, and the price including 15% tax, aliased clearly.
2. Produce a single column `label` reading `UltraBook Pro 14 — $1499.00` for every product.
3. Find how many distinct cities your customers live in.
4. List the distinct combinations of `status` and `shipping_country` from `orders`.

---
# 14. WHERE, asking precise questions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 25 min | Filter rows with conditions · Combine `AND` and `OR` safely · Filter date ranges correctly · Search text with patterns |

> [!NOTE]
> 📌 **In plain words:** `WHERE` is the filter. It looks at every candidate row and asks a yes/no question. Only the rows that answer **yes** survive.

> 🌍 **Analogy:** `WHERE` is the **bouncer with a guest list**. Every row walks up; the bouncer checks the condition; the row gets in or is turned away.

## 14.1 ⚖️ Comparison operators

| Operator | Meaning | Example |
|:---:|---|---|
| `=` | Equal to | `WHERE country = 'UK'` |
| `<>` or `!=` | Not equal to | `WHERE status <> 'Cancelled'` |
| `>` `<` | Greater / less than | `WHERE unit_price > 500` |
| `>=` `<=` | Greater/less than or equal | `WHERE units_in_stock <= 10` |
| `BETWEEN a AND b` | Between two values, including both ends | `WHERE unit_price BETWEEN 100 AND 500` |
| `IN (…)` | Matches any value in a list | `WHERE country IN ('UK','Germany','Italy')` |
| `LIKE` | Matches a text pattern | `WHERE email LIKE '%@example.com'` |
| `IS NULL` | Has no value | `WHERE ship_date IS NULL` |
| `EXISTS (…)` | Another query finds at least one row | See [Chapter 30](#30-subqueries-and-exists) |

```sql
-- ✅ Works in BOTH — real business questions

-- Which products are expensive?
SELECT product_name, unit_price
FROM products
WHERE unit_price > 500;

-- Which orders have not shipped yet?
SELECT order_id, order_date, status
FROM orders
WHERE ship_date IS NULL;

-- Which products are low on stock and still being sold?
SELECT product_name, units_in_stock, reorder_level
FROM products
WHERE units_in_stock <= reorder_level      -- comparing two COLUMNS
  AND discontinued = 0;
```

> [!TIP]
> 💡 **Note that last one.** `WHERE` conditions can compare two columns of the same row, not just a column against a constant. `units_in_stock <= reorder_level` is a genuine business rule — *"time to reorder"* — expressed in one line.

## 14.2 🔗 AND, OR, NOT, and the parentheses trap

```sql
-- ✅ Works in BOTH
SELECT product_name, unit_price, category_id
FROM products
WHERE category_id = 1
  AND unit_price > 1000
  AND discontinued = 0;
```

> [!WARNING]
> ⚠️ **The single most common WHERE bug in the world:** SQL works out `AND` **before** `OR` — just as maths works out × before +. Without parentheses, this happens:

```sql
-- ❌ WRONG: reads as "category 1" OR "(category 2 AND price > 1000)"
SELECT * FROM products
WHERE category_id = 1 OR category_id = 2 AND unit_price > 1000;
-- Returns ALL of category 1, at any price. Not what anyone meant.

-- ✅ RIGHT
SELECT * FROM products
WHERE (category_id = 1 OR category_id = 2)
  AND unit_price > 1000;
```

> [!TIP]
> 💡 **Pro tip:** When a `WHERE` clause mixes `AND` and `OR`, **always use parentheses**, even when you are sure they are unnecessary. They cost nothing and they document your intent to the next reader.

## 14.3 📏 BETWEEN — and its date trap

```sql
-- ✅ Works in BOTH: BETWEEN is INCLUSIVE on both ends
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 100 AND 200;      -- includes exactly 100 and exactly 200

-- Identical to:
SELECT product_name, unit_price FROM products
WHERE unit_price >= 100 AND unit_price <= 200;

-- Exclude a range
SELECT product_name, unit_price FROM products
WHERE unit_price NOT BETWEEN 100 AND 200;
```

> [!WARNING]
> ⚠️ **The date-range trap that silently loses data.** If a column is `DATETIME`, this query misses almost the entire last day:

```sql
-- ❌ WRONG for DATETIME columns:
--    '2026-01-31' means '2026-01-31 00:00:00', so a payment at
--    09:15 on the 31st is EXCLUDED.
SELECT payment_id, payment_date, amount FROM payments
WHERE payment_date BETWEEN '2026-01-01' AND '2026-01-31';
```

```sql
-- ✅ RIGHT: the half-open range. Works for DATE and DATETIME alike.
SELECT payment_id, payment_date, amount FROM payments
WHERE payment_date >= '2026-01-01'
  AND payment_date <  '2026-02-01';
```

> [!TIP]
> 💡 **Learn the half-open pattern `>= start AND < next_start` (the start is included, the end is not) and use it for every date range for the rest of your life.** It is correct regardless of the column's precision, it never needs adjusting for leap years or month lengths, and — crucially — it is **SARGable**, meaning an index on the date column can still be used. See [Chapter 48](#48-query-optimization-and-sargability).

## 14.4 📋 IN and NOT IN

```sql
-- ✅ Works in BOTH
SELECT full_name, country
FROM customers
WHERE country IN ('UK', 'Germany', 'Italy', 'Spain');

-- Identical to, but far more readable than:
SELECT full_name, country FROM customers
WHERE country = 'UK' OR country = 'Germany' OR country = 'Italy' OR country = 'Spain';

-- IN with a subquery: customers who have actually ordered something
SELECT full_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);
```

> [!WARNING]
> ⚠️ **`NOT IN` breaks silently when the list contains NULL.** This is one of SQL's genuinely surprising behaviours:

```sql
-- ❌ Returns ZERO rows if ANY order has a NULL employee_id
SELECT first_name FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM orders);
```

**Why:** `x NOT IN (1, 2, NULL)` expands to `x <> 1 AND x <> 2 AND x <> NULL`. That last comparison is `UNKNOWN` (see [Chapter 15](#15-null-the-value-that-is-not-there)), never `TRUE`, so the whole condition can never be true. Silence, no error, no rows.

```sql
-- ✅ FIX 1: exclude the NULLs
SELECT first_name FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM orders WHERE employee_id IS NOT NULL);

-- ✅ FIX 2 (better): use NOT EXISTS, which is immune to this problem
SELECT e.first_name
FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.employee_id = e.employee_id);
```

> [!TIP]
> 💡 **Professional habit: prefer `NOT EXISTS` over `NOT IN` for subqueries, always.** It is NULL-safe and usually produces a better execution plan (the step-by-step route the database takes to answer — Chapter 47).

## 14.5 🔍 LIKE and pattern matching

| Wildcard | Meaning | Example | Matches |
|:---:|---|---|---|
| `%` | Any number of characters (including none) | `'A%'` | Amara, Anna, A |
| `_` | Exactly one character | `'_ohn'` | John, Bohn |
| `[abc]` 🟥 | One character from the set (MSSQL only) | `'[JM]%'` | John, Mei |
| `[a-f]` 🟥 | One character from the range (MSSQL only) | `'[A-C]%'` | Amara, Bob, Carlos |
| `[^abc]` 🟥 | One character NOT in the set (MSSQL only) | `'[^A]%'` | anything not starting with A |

```sql
-- ✅ Works in BOTH
SELECT full_name FROM customers WHERE full_name LIKE 'A%';        -- starts with A
SELECT full_name FROM customers WHERE full_name LIKE '%Silva';    -- ends with Silva
SELECT full_name FROM customers WHERE full_name LIKE '%ei%';      -- contains "ei"
SELECT email     FROM customers WHERE email LIKE '%@example.com'; -- domain match
SELECT phone     FROM customers WHERE phone LIKE '+94%';          -- Sri Lankan numbers
```

```sql
-- 🟥 MSSQL only: character classes
SELECT full_name FROM customers WHERE full_name LIKE '[A-C]%';
SELECT full_name FROM customers WHERE full_name LIKE '[^AJ]%';
```

```sql
-- 🟦 MySQL only: regular expressions (a powerful pattern language)
SELECT full_name FROM customers WHERE full_name REGEXP '^[A-C]';
SELECT email     FROM customers WHERE email REGEXP '^[a-z]+\\.[a-z]+@';
```

**Searching for a literal `%` or `_`:**

```sql
-- ✅ Works in BOTH: define an escape character
SELECT * FROM products WHERE product_name LIKE '%50!%%' ESCAPE '!';
-- finds names containing the literal text "50%"
```

> [!WARNING]
> ⚠️ **Performance warning: a leading wildcard kills your index.** `LIKE 'Ultra%'` can use an index on `product_name` — the engine jumps straight to the "Ultra" section, like finding a word in a dictionary. `LIKE '%Book%'` **cannot** — the engine must read every single row. On a million-row table that is the difference between 2 milliseconds and 4 seconds.
>
> If you genuinely need "contains" search on a large table, use **full-text search** instead ([Chapter 58](#58-json-xml-and-semi-structured-data)).

> 🔀 **Case sensitivity differs by default:**
> - **MSSQL**'s default *collation* (its rules for comparing text — Chapter 60) is case-**insensitive**: `LIKE 'a%'` matches "Amara".
> - **MySQL** with a `_ci` collation is also case-insensitive; with `_bin` or `_cs` it is **case-sensitive**.
> - To force case-sensitivity: MSSQL `COLLATE Latin1_General_CS_AS`, MySQL `LIKE BINARY 'a%'`.

## 14.6 🧪 Try it yourself

1. Find every product priced between 100 and 400 that is not discontinued.
2. Find all customers whose email is at `example.com` **and** who live outside the UK.
3. Find every order placed in March 2026, using the half-open date pattern.
4. Find the products whose name contains the word "Pro". Then check whether an index could help — why not?
5. Deliberately write a `WHERE` mixing `AND` and `OR` without parentheses and count how the row count changes when you add them.

---

# 15. NULL, the value that is not there

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Explain what `NULL` really means · Test for `NULL` correctly · Replace missing values · Avoid the `NOT IN` trap |

> [!NOTE]
> 📌 **In plain words:** `NULL` does **not** mean zero. It does **not** mean an empty string. It means **"we do not know"** or **"this does not apply."** And unknown values behave in ways that surprise everyone the first time.

> 🌍 **Analogy:** You have two sealed boxes. Are their contents equal? You cannot say yes. You cannot say no. The honest answer is **"unknown."** That is exactly what `NULL = NULL` returns.

## 15.1 💥 The three golden rules of NULL

```sql
-- RULE 1: NULL is never equal to anything, not even to itself.
SELECT * FROM orders WHERE ship_date = NULL;      -- ❌ returns ZERO rows, always
SELECT * FROM orders WHERE ship_date IS NULL;     -- ✅ this is the correct way

-- RULE 2: Any arithmetic with NULL produces NULL.
SELECT 100 + NULL;        -- NULL, not 100
SELECT NULL * 5;          -- NULL
SELECT CONCAT('a', NULL); -- 🟦 MySQL: NULL   🟥 MSSQL CONCAT(): 'a' (it ignores NULLs)

-- RULE 3: Comparisons with NULL are UNKNOWN, which is not TRUE.
SELECT * FROM products WHERE unit_price > NULL;   -- zero rows
SELECT * FROM products WHERE unit_price <> NULL;  -- zero rows
```

**SQL uses three-valued logic — TRUE, FALSE, and UNKNOWN:**

| A | B | `A AND B` | `A OR B` |
|---|---|---|---|
| TRUE | UNKNOWN | UNKNOWN | **TRUE** |
| FALSE | UNKNOWN | **FALSE** | UNKNOWN |
| UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN |

> [!CAUTION]
> 🐛 **The classic bug this causes:** you want *"all orders except cancelled ones."*
> ```sql
> SELECT * FROM orders WHERE status <> 'Cancelled';
> ```
> If `status` allowed `NULL`, every row with a `NULL` status disappears from the result — silently. The user reports "some orders are missing" and you spend a day hunting.
> ```sql
> -- ✅ The NULL-safe version
> SELECT * FROM orders WHERE status <> 'Cancelled' OR status IS NULL;
> ```

## 15.2 🧰 The NULL-handling toolkit

| Function | 🟥 MSSQL | 🟦 MySQL | What it does |
|---|---|---|---|
| Replace NULL with a value | `ISNULL(x, 0)` | `IFNULL(x, 0)` | Two arguments only |
| First non-NULL of many | `COALESCE(a,b,c)` | `COALESCE(a,b,c)` | ✅ **Standard, works in both** |
| NULL if two values match | `NULLIF(a, b)` | `NULLIF(a, b)` | ✅ Works in both |
| Equality that treats two NULLs as equal | *(use `IS NULL` logic)* | `a <=> b` | MySQL only |

```sql
-- ✅ COALESCE works in BOTH — prefer it over ISNULL/IFNULL so your SQL runs in either engine

-- Real-world: show a friendly status for unshipped orders
SELECT
    order_id,
    order_date,
    COALESCE(CAST(ship_date AS CHAR(10)), 'Not shipped yet') AS ship_status
FROM orders;

-- Real-world: fall back through several contact options
SELECT
    full_name,
    COALESCE(phone, email, 'No contact on file') AS best_contact
FROM customers;

-- Real-world: prevent division by zero using NULLIF
SELECT
    product_name,
    units_in_stock,
    reorder_level,
    units_in_stock / NULLIF(reorder_level, 0) AS stock_ratio   -- NULL instead of an error
FROM products;
```

> [!TIP]
> 💡 **The `NULLIF` divide-by-zero trick is worth memorizing.** `x / NULLIF(y, 0)` turns a hard error into a `NULL`, which you can then handle with `COALESCE`. Combined: `COALESCE(x / NULLIF(y,0), 0)`.

> 🔀 **A subtle MSSQL difference:** `ISNULL` returns the data type of its **first** argument, so `ISNULL(CAST(x AS VARCHAR(5)), 'Not available')` silently truncates to `'Not a'`. `COALESCE` picks a type big enough for all of its values, so it does not do this. **Another reason to prefer `COALESCE`.**

## 15.3 📊 How NULL behaves in aggregates, sorting, and grouping

```sql
-- ✅ Works in BOTH: aggregates IGNORE NULLs. This surprises everyone once.
-- 5 employees, 2 with NULL commission:
CREATE TABLE employees_demo (
    employee_id INT PRIMARY KEY,
    commission  DECIMAL(10,2) NULL
);
INSERT INTO employees_demo VALUES (1, 100.00), (2, 200.00), (3, 300.00), (4, NULL), (5, NULL);

SELECT
    COUNT(*)              AS all_rows,          -- 5
    COUNT(commission)     AS non_null_values,   -- 3
    AVG(commission)       AS avg_of_3_not_5,    -- divides by 3, NOT 5!
    SUM(commission)       AS sum_ignores_nulls
FROM employees_demo;
```

> [!WARNING]
> ⚠️ **`AVG` divides by the count of non-NULL values.** If you want NULL to count as zero, say so explicitly: `AVG(COALESCE(commission, 0))`. These two give different answers and only you know which is correct for the business question.

```sql
-- GROUP BY treats all NULLs as ONE group (unlike =, which never matches)
SELECT city, COUNT(*) FROM customers GROUP BY city;
-- Produces one row where city IS NULL

-- DISTINCT also treats NULLs as one value
SELECT DISTINCT city FROM customers;   -- at most one NULL row
```

> 🔀 **Sort order of NULLs differs:**
> - **MSSQL:** `NULL` sorts **first** in `ASC`.
> - **MySQL:** `NULL` sorts **first** in `ASC` too, and last in `DESC`.
> - To control it explicitly, sort by a flag first:
> ```sql
> -- ✅ Works in BOTH: force NULLs to the end regardless of engine
> SELECT order_id, ship_date FROM orders
> ORDER BY CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END, ship_date;
> ```

## 15.4 🕳️ NULL vs empty string vs zero

```sql
-- These are three completely different things
INSERT INTO customers (full_name, email, country, phone) VALUES
('Test A', 'a@x.com', 'UK', NULL),   -- phone unknown / not provided
('Test B', 'b@x.com', 'UK', ''),     -- phone is an empty string (they gave nothing?)
('Test C', 'c@x.com', 'UK', '0');    -- phone is literally "0"

SELECT full_name, phone FROM customers WHERE phone IS NULL;   -- finds A only
SELECT full_name, phone FROM customers WHERE phone = '';      -- finds B only
```

> [!TIP]
> 💡 **Pick one convention and enforce it.** Most teams choose: **use `NULL` for "no value", never the empty string.** Then add a `CHECK (phone <> '')` constraint so the empty string can never sneak in. Mixed conventions mean every query needs `WHERE phone IS NULL OR phone = ''`, forever.

> 🔀 **Oracle-style trap for people arriving from Oracle:** Oracle treats `''` **as** `NULL`. MSSQL and MySQL do not. They are genuinely different values.

## 15.5 🎯 When to allow NULL, and which tool to reach for

| Question | Answer |
|---|---|
| Should this column allow NULL? | Only if "unknown" or "not applicable" is a **real business state**. `ship_date` yes; `email` no. |
| I need "0 if missing" | `COALESCE(x, 0)` |
| I need "first thing that has a value" | `COALESCE(a, b, c, 'fallback')` |
| I need to avoid divide-by-zero | `x / NULLIF(y, 0)` |
| I need "is this empty?" | `IS NULL` — **never** `= NULL` |
| I need "everything except X", and the column allows NULL | `WHERE col <> 'X' OR col IS NULL` |
| I need NULLs sorted last | `ORDER BY CASE WHEN col IS NULL THEN 1 ELSE 0 END, col` |
| Should the average treat missing as zero? | Decide explicitly: `AVG(col)` skips them, `AVG(COALESCE(col,0))` counts them |

> [!CAUTION]
> 🐛 **Common mistake:** using `NOT NULL DEFAULT ''` or `DEFAULT 0` to "avoid the NULL problem". You have not removed the ambiguity, you have hidden it — now you cannot tell "we asked and they have no phone" from "we never asked". **A NULL that means something is better than a fake value that means nothing.**

## 15.6 🧪 Try it yourself

1. Count how many orders have no `ship_date`. Then try it with `= NULL` and confirm you get zero.
2. Write a query showing every order with a shipping status of either the date, or the text `'In progress'`.
3. Compute the average `discount` in `order_items` two ways: ignoring zeros and treating them as zero. Explain the difference.
4. Sort `orders` so that unshipped orders appear **last**, and shipped ones by date descending.

---

# 16. ORDER BY, sorting results

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 15 min | Sort by one or several columns · Build a custom sort order · Know why unsorted results are unpredictable |

> [!NOTE]
> 📌 **In plain words:** Without `ORDER BY`, the database returns rows in **whatever order is cheapest** — which can change between runs, versions, and even from one execution to the next. If order matters, you must say so.

## 16.1 🔤 The basics

```sql
-- ✅ Works in BOTH
SELECT product_name, unit_price FROM products ORDER BY unit_price;        -- ASC is the default
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC;   -- highest first

-- Multiple sort keys: sort by the first, break ties with the second
SELECT category_id, product_name, unit_price
FROM products
ORDER BY category_id ASC, unit_price DESC;
```

> 🌍 **Analogy for multi-column sort:** a phone book. Sort by surname first; when two people share a surname, sort those by first name. The second column only matters *within* a tie of the first.

## 16.2 🎯 Sorting by expressions, aliases, and positions

```sql
-- ✅ Works in BOTH: by an alias (legal because ORDER BY runs after SELECT)
SELECT product_name, unit_price * 1.15 AS price_with_tax
FROM products
ORDER BY price_with_tax DESC;

-- ⚠️ Works in BOTH: by column POSITION — works, but avoid it
SELECT product_name, unit_price FROM products ORDER BY 2 DESC;

-- ✅ 🟥 MSSQL: by an expression not even in the SELECT list (MSSQL uses LEN)
SELECT product_name FROM products ORDER BY LEN(product_name) DESC;
```

```sql
-- ✅ MySQL: same idea, but the length function is CHAR_LENGTH
SELECT product_name FROM products ORDER BY CHAR_LENGTH(product_name) DESC;
```

> [!WARNING]
> ⚠️ **Never use `ORDER BY 2` in real code.** The day someone adds a column to the `SELECT` list, your sort silently changes to a different column. It is a time bomb.

## 16.3 🎨 Custom sort order with CASE

A genuinely useful real-world technique: sorting by business priority rather than alphabetically.

```sql
-- ✅ Works in BOTH
-- Task: show orders with the most urgent statuses first
SELECT order_id, status, order_date
FROM orders
ORDER BY
    CASE status
        WHEN 'Pending'   THEN 1
        WHEN 'Paid'      THEN 2
        WHEN 'Shipped'   THEN 3
        WHEN 'Delivered' THEN 4
        WHEN 'Refunded'  THEN 5
        WHEN 'Cancelled' THEN 6
        ELSE 99
    END,
    order_date DESC;
```

```sql
-- 🟦 MySQL has a shortcut for exactly this
SELECT order_id, status
FROM orders
ORDER BY FIELD(status, 'Pending','Paid','Shipped','Delivered','Refunded','Cancelled');
```

```sql
-- Put your own country at the top, then everyone else alphabetically
SELECT full_name, country
FROM customers
ORDER BY
    CASE WHEN country = 'Sri Lanka' THEN 0 ELSE 1 END,
    country,
    full_name;
```

## 16.4 ⚠️ The unordered-result trap

```sql
-- ❌ NEVER assume this returns rows in insertion order
SELECT * FROM customers;
```

> [!NOTE]
> 📌 **In plain words:** A table is a **bag** of rows, not a list. Rows have no inherent order. What looks like "the order the rows were added" today is just luck — the order the database happened to read its storage in. Add an index, upgrade the server, or load more data, and the order can change without warning.
>
> **If you need order, write `ORDER BY`. Every time. No exceptions.**

> [!WARNING]
> ⚠️ **A view (a saved query, Chapter 36) or a subquery with `ORDER BY` guarantees nothing.** In MSSQL, `ORDER BY` inside a view is only legal alongside `TOP`/`OFFSET`, and even then the outer query may reorder the rows. Sorting belongs in the **final, outermost** query.

## 16.5 ⚡ Sorting and performance

Sorting a million rows costs memory and processor time, and when memory runs out the database has to use slow disk space. An index in the right order removes that cost entirely.

```sql
-- Without an index, this must read and sort every row
SELECT order_id, order_date FROM orders ORDER BY order_date DESC;

-- With this index, the engine reads the index backwards — no sort at all
CREATE INDEX ix_orders_order_date ON orders(order_date);
```

> [!TIP]
> 💡 **Pro tip:** An index can satisfy an `ORDER BY` only if the sort direction pattern matches. `ORDER BY a ASC, b DESC` needs an index defined as `(a ASC, b DESC)`. Both engines support per-column direction in an index definition (MySQL genuinely honours `DESC` in indexes from 8.0 onward; earlier versions parsed and ignored it).

## 16.6 🎯 When to sort — and when not to

| Situation | Sort? |
|---|---|
| Final result shown to a human | ✅ Always `ORDER BY` |
| Paging (`OFFSET`/`LIMIT`) | ✅ **Mandatory** — and it must give the same order every time |
| Inside a subquery or CTE (a named subquery, Chapter 31) feeding an outer query | ❌ Wasted work; the outer query decides order |
| Inside a view | ❌ Not guaranteed, and usually illegal without `TOP` |
| Before an `INSERT ... SELECT` | ❌ Pointless — tables have no order |
| A window function's `OVER (ORDER BY …)` (Chapter 33) | ✅ Different thing entirely — required for ranking/running totals |

> [!TIP]
> 💡 **Make every sort that users see *deterministic* (the same order every time).** `ORDER BY order_date DESC` on data with duplicate dates returns rows in an arbitrary order that can change between runs. Add a unique tiebreaker: `ORDER BY order_date DESC, order_id DESC`. Without it, paging silently repeats and skips rows.

## 16.7 🧪 Try it yourself

1. List all products from most to least expensive, with category as a tiebreaker.
2. Sort customers so that Gold and Platinum tiers appear first, then alphabetically by name.
3. Sort orders by status priority (Pending → Delivered) and then by newest first.
4. Sort products by the **length** of their name, longest first.

---

# 17. Paging: TOP, LIMIT, OFFSET, FETCH

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Show the top N rows · Show results page by page · Use fast "Load more" paging on big tables |

> [!NOTE]
> 📌 **In plain words:** You rarely want all 4 million rows. You want the top 10, or page 7 of the search results. This is where the two engines differ most visibly.

> 🌍 **Analogy:** A search engine never shows you all 4 million results at once. It shows page 1 with 10 results, and a "Next" button. Paging is how you build that "Next" button.

## 17.1 🔝 Getting the first N rows

```sql
-- 🟥 MSSQL
SELECT TOP 5 product_name, unit_price
FROM products
ORDER BY unit_price DESC;

SELECT TOP 10 PERCENT product_name FROM products ORDER BY unit_price DESC;

-- WITH TIES: also include rows tied with the last one
SELECT TOP 3 WITH TIES product_name, unit_price
FROM products
ORDER BY unit_price DESC;
```

```sql
-- 🟦 MySQL
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 5;
```

## 17.2 📄 Paging through results

```sql
-- 🟥 MSSQL (2012+): the official SQL-standard syntax. ORDER BY is REQUIRED.
SELECT product_name, unit_price
FROM products
ORDER BY product_id
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;     -- page 3, if the page size is 10
```

```sql
-- 🟦 MySQL
SELECT product_name, unit_price
FROM products
ORDER BY product_id
LIMIT 10 OFFSET 20;

-- Older shorthand: LIMIT offset, count  (note the reversed order!)
SELECT product_name FROM products ORDER BY product_id LIMIT 20, 10;
```

**The page-number formula both engines share:**

```text
OFFSET = (page_number - 1) × page_size

Page 1, size 10 → OFFSET 0
Page 2, size 10 → OFFSET 10
Page 5, size 25 → OFFSET 100
```

> [!WARNING]
> ⚠️ **Paging without `ORDER BY` is meaningless and buggy.** With no defined order, a row can appear on page 1 *and* page 3, while another never appears at all. MSSQL refuses to run `OFFSET` without `ORDER BY`; MySQL allows it and gives you nonsense. **Always order by something unique** — add the primary key as the final tiebreaker.

```sql
-- ✅ 🟥 MSSQL — the professional pattern: a deterministic sort
--    (MySQL: the same ORDER BY, then LIMIT 10 OFFSET 0)
SELECT order_id, order_date, status
FROM orders
ORDER BY order_date DESC, order_id DESC       -- order_id breaks every tie
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
```

## 17.3 🐌 Why OFFSET gets slow, and what professionals use instead

```sql
-- 🟦 MySQL · 😱 To return rows 1,000,001 to 1,000,010, the engine reads and discards
--    the first million rows. Every single time.
SELECT * FROM orders ORDER BY order_id LIMIT 10 OFFSET 1000000;
```

**The fix: keyset pagination (also called "seek" or "cursor" pagination).** Instead of counting rows, remember where you stopped.

```sql
-- 🟦 MySQL shown (MSSQL: SELECT TOP 10 ... instead of LIMIT 10). Page 1:
SELECT order_id, order_date, customer_id
FROM orders
ORDER BY order_id
LIMIT 10;

-- The last row you showed had order_id = 1009. The next page:
SELECT order_id, order_date, customer_id
FROM orders
WHERE order_id > 1009        -- ⚡ jumps straight there using the index
ORDER BY order_id
LIMIT 10;
```

| | `OFFSET` paging | Keyset paging |
|---|---|---|
| Page 1 speed | ⚡ Fast | ⚡ Fast |
| Page 100,000 speed | 🐌 Terrible | ⚡ Still fast |
| Jump to an arbitrary page number | ✅ Easy | ❌ Not possible |
| Rows shift if data changes mid-paging | ⚠️ Yes — duplicates and skips | ✅ Stable |
| Used by | Admin tables with page numbers | Infinite scroll, APIs, Twitter/Facebook feeds |

> [!TIP]
> 💡 **This is why modern apps use "Load more" instead of numbered pages.** Keyset pagination is the reason your social media feed stays fast at post 10,000.

**Keyset paging when you sort by two columns:**

```sql
-- 🟦 MySQL (MSSQL: TOP 10 instead of LIMIT) — sorting by date then id, so "after" must check both columns
SELECT order_id, order_date
FROM orders
WHERE (order_date > '2026-05-06')
   OR (order_date = '2026-05-06' AND order_id > 1013)
ORDER BY order_date, order_id
LIMIT 10;
```

```sql
-- 🟦 MySQL supports the compact row-comparison form
SELECT order_id, order_date
FROM orders
WHERE (order_date, order_id) > ('2026-05-06', 1013)
ORDER BY order_date, order_id
LIMIT 10;
```

## 17.4 🔢 Getting the total row count for a pager

`COUNT(*) OVER ()` is a *window function* ([Chapter 33](#33-window-functions)): it counts **all** the matching rows and repeats that total on every row returned — even though you only fetch 10 of them.

```sql
-- 🟥 MSSQL: COUNT(*) OVER() gives the total alongside the page
SELECT
    order_id,
    order_date,
    COUNT(*) OVER () AS total_matching_rows
FROM orders
WHERE status = 'Delivered'
ORDER BY order_date DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
```

```sql
-- 🟦 MySQL 8.0: the same window function works
SELECT
    order_id,
    order_date,
    COUNT(*) OVER () AS total_matching_rows
FROM orders
WHERE status = 'Delivered'
ORDER BY order_date DESC
LIMIT 10;
```

> [!TIP]
> 💡 **Pro tip:** For very large tables, an exact total count is expensive and usually pointless — nobody clicks to page 40,000. Real systems either cache the count, show an approximation ("about 12,000 results"), or drop the count entirely in favour of "Load more".

## 17.5 🎯 When to use which paging strategy

| Your screen | Use | Why |
|---|---|---|
| "Page 1 2 3 … 47" numbered pager, small table | `OFFSET`/`LIMIT` | Simple, and jumping to page 30 works |
| Infinite scroll / "Load more" | **Keyset** | Stays fast forever, no duplicates when data changes |
| An app or API that asks for "the next batch" | **Keyset** | Stable and cheap |
| Top 10 / leaderboard | `TOP` / `LIMIT` alone | No paging needed |
| Export everything | Neither — read it in one continuous stream, or in ID ranges | |
| A table over ~100k rows where users jump to far-away pages | **Keyset** | `OFFSET 500000` reads and throws away half a million rows |

> [!CAUTION]
> 🐛 **Common mistake:** paging a result whose sort is not unique. The database is free to return tied rows in a different order each query, so the same row appears on page 2 *and* page 3 while another never appears at all. Users report "records go missing" and it is almost impossible to reproduce. **Always end `ORDER BY` with a unique column.**

## 17.6 🧪 Try it yourself

1. Get the 5 most expensive products in both dialects.
2. Return page 2 of customers, 5 per page, sorted by signup date.
3. Rewrite that as keyset pagination and explain why it scales better.
4. Use `TOP 3 WITH TIES` (MSSQL) on `unit_price` and explain what makes it different from plain `TOP 3`.

---

# 18. UPDATE, changing data

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 25 min | Change data safely · Follow the check → transaction → commit routine · Update from another table · Update huge tables in batches |

> [!NOTE]
> 📌 **In plain words:** `UPDATE` changes values in rows that already exist. It is the most dangerous everyday command in SQL, because forgetting one clause changes **every row in the table**.

> 🌍 **Analogy:** Correcting entries in an address book with a pen. The `WHERE` clause says *which* entries to correct. Forget it, and you have just written the same new phone number into every single entry in the book.

## 18.1 ✍️ Basic UPDATE

```sql
-- ✅ Works in BOTH
UPDATE products
SET unit_price = 1399.00
WHERE product_id = 1;

-- Several columns at once
UPDATE customers
SET city = 'Kandy',
    phone = '+94-81-555-0199',
    loyalty_tier = 'Platinum'
WHERE customer_id = 1;

-- Using the existing value: a 10% price rise for one category
UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 3;
```

## 18.2 🚨 The most expensive mistake in SQL

```sql
-- 💀 THIS UPDATES EVERY ROW IN THE TABLE
UPDATE products SET unit_price = 0;
```

> [!WARNING]
> ⚠️ **There is no undo.** Unless you started a *transaction* first (an "undo point" — Step 3 below and [Chapter 42](#42-transactions-and-acid)), those 18 products (or 18 million) are now zero, and the only way back is a restore from backup.

**The professional safety ritual — follow it every time:**

```sql
-- ✅ Works in BOTH
-- STEP 1: Write it as a SELECT first and look at the rows.
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 3;

-- STEP 2: Confirm the count is what you expect.
SELECT COUNT(*) FROM products WHERE category_id = 3;   -- expecting 3
```

**Step 3 uses a transaction.** `BEGIN TRANSACTION` (MySQL: `START TRANSACTION`) sets an undo point. `COMMIT` makes the change permanent. `ROLLBACK` cancels everything since the undo point, as if it never happened.

```sql
-- 🟥 MSSQL — STEP 3: Wrap it in a transaction, run, verify, THEN commit.
BEGIN TRANSACTION;

    UPDATE products
    SET unit_price = unit_price * 1.10
    WHERE category_id = 3;

    -- Did it touch the number of rows you expected?
    SELECT product_id, unit_price FROM products WHERE category_id = 3;

COMMIT;      -- or ROLLBACK; if it looks wrong
```

```sql
-- 🟦 MySQL — STEP 3: the same, but MySQL starts a transaction with START TRANSACTION
START TRANSACTION;

    UPDATE products
    SET unit_price = unit_price * 1.10
    WHERE category_id = 3;

    SELECT product_id, unit_price FROM products WHERE category_id = 3;

COMMIT;      -- or ROLLBACK; if it looks wrong
```

> [!TIP]
> 💡 **Turn on "safe update mode" in MySQL and leave it on:**
> ```sql
> -- 🟦 MySQL
> SET SQL_SAFE_UPDATES = 1;
> ```
> MySQL will then **refuse** any `UPDATE` or `DELETE` whose `WHERE` clause does not use a key column (such as the ID). MySQL Workbench enables this by default — do not turn it off. It exists because this mistake is so common.

> [!TIP]
> 💡 **In SSMS**, tick *Tools → Options → Query Execution → SQL Server → ANSI → SET IMPLICIT_TRANSACTIONS* — then every change waits until you type `COMMIT`. Or simply build the habit of typing `BEGIN TRAN` before every hand-typed `UPDATE` on a live server.

## 18.3 🔗 UPDATE with a JOIN

Extremely common in real work: update one table based on data in another.

> 🔀 **The syntax is completely different in the two engines.** This is one of the biggest dialect gaps.

```sql
-- 🟥 MSSQL: UPDATE the alias, then FROM ... JOIN
UPDATE o
SET o.shipping_city    = c.city,
    o.shipping_country = c.country
FROM orders AS o
INNER JOIN customers AS c ON c.customer_id = o.customer_id
WHERE o.shipping_city IS NULL;
```

```sql
-- 🟦 MySQL: joins go BEFORE the SET
UPDATE orders AS o
INNER JOIN customers AS c ON c.customer_id = o.customer_id
SET o.shipping_city    = c.city,
    o.shipping_country = c.country
WHERE o.shipping_city IS NULL;
```

```sql
-- ✅ Works in BOTH: a subquery that looks up each order's customer (a correlated subquery, Chapter 30)
UPDATE orders
SET shipping_city = (
        SELECT c.city FROM customers c
        WHERE c.customer_id = orders.customer_id
    )
WHERE shipping_city IS NULL;
```

**A real-world example — recalculate loyalty tiers from actual spend.** It works out each customer's total with `SUM … GROUP BY` (Chapters 25–26) inside the update, so skim it now and come back later:

```sql
-- 🟥 MSSQL
UPDATE c
SET c.loyalty_tier =
    CASE
        WHEN s.total_spend >= 5000 THEN 'Platinum'
        WHEN s.total_spend >= 2000 THEN 'Gold'
        WHEN s.total_spend >=  500 THEN 'Silver'
        ELSE 'Bronze'
    END
FROM customers AS c
INNER JOIN (
    SELECT o.customer_id,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total_spend
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY o.customer_id
) AS s ON s.customer_id = c.customer_id;
```

```sql
-- 🟦 MySQL
UPDATE customers AS c
INNER JOIN (
    SELECT o.customer_id,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total_spend
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY o.customer_id
) AS s ON s.customer_id = c.customer_id
SET c.loyalty_tier =
    CASE
        WHEN s.total_spend >= 5000 THEN 'Platinum'
        WHEN s.total_spend >= 2000 THEN 'Gold'
        WHEN s.total_spend >=  500 THEN 'Silver'
        ELSE 'Bronze'
    END;
```

## 18.4 📸 Seeing what changed

```sql
-- 🟥 MSSQL: OUTPUT shows the before AND after values
UPDATE products
SET unit_price = unit_price * 1.10
OUTPUT
    inserted.product_id,
    deleted.unit_price  AS old_price,
    inserted.unit_price AS new_price
WHERE category_id = 3;
```

> [!TIP]
> 💡 **`OUTPUT` with `deleted.` and `inserted.` is one of MSSQL's best features.** `deleted.` holds each row's old values and `inserted.` its new ones, so the same statement hands you a free record of exactly what changed. MySQL has no equivalent — you must first copy the old values into a temporary table (Chapter 40), or use a trigger (Chapter 39).

```sql
-- ✅ MSSQL: how many rows did I just change?
SELECT @@ROWCOUNT AS rows_affected;
```

```sql
-- ✅ MySQL: how many rows did I just change?
SELECT ROW_COUNT() AS rows_affected;
```

> [!WARNING]
> ⚠️ **Read it immediately.** `@@ROWCOUNT` is reset by the *next* statement — even by a `PRINT` or an `IF`. Capture it into a variable on the very next line if you need it later: `DECLARE @n INT = @@ROWCOUNT;`

## 18.5 🔀 Conditional and bulk updates

```sql
-- ✅ Works in BOTH: different new values per row, one pass
UPDATE products
SET unit_price = CASE
        WHEN units_in_stock = 0            THEN unit_price          -- unchanged
        WHEN units_in_stock < reorder_level THEN unit_price * 1.05  -- scarce: raise
        WHEN units_in_stock > 100          THEN unit_price * 0.90   -- overstocked: cut
        ELSE unit_price
    END
WHERE discontinued = 0;
```

> [!WARNING]
> ⚠️ **Note the `ELSE unit_price`.** Without it, every row that matches no branch would be set to `NULL`, because `CASE` with no `ELSE` returns `NULL`. This single omission has corrupted many tables. **Always write an explicit `ELSE`.**

> [!TIP]
> 💡 **Pro tip for updating millions of rows:** do it in batches. One giant `UPDATE` locks other users out of those rows for a long time, makes the transaction log grow huge, and can freeze your whole application.

```sql
-- 🟥 MSSQL: batched update loop
WHILE 1 = 1
BEGIN
    UPDATE TOP (5000) orders
    SET status = 'Cancelled'                  -- auto-cancel stale unpaid orders
    WHERE order_date < '2024-01-01' AND status = 'Pending';

    IF @@ROWCOUNT = 0 BREAK;
END;
```

```sql
-- 🟦 MySQL: same idea with LIMIT
UPDATE orders
SET status = 'Cancelled'
WHERE order_date < '2024-01-01' AND status = 'Pending'
LIMIT 5000;
-- repeat until ROW_COUNT() = 0
```

## 18.6 🧪 Try it yourself

1. Give every product in the `Audio` category a 5% price cut — inside a transaction, and roll it back.
2. Set `shipping_city` from the customer's city for every order where it is NULL, in both dialects.
3. Recalculate all loyalty tiers using the query above, then check how many customers changed.
4. Write an update with no `WHERE` inside a transaction, look at the damage with a `SELECT`, then `ROLLBACK`. Feel the fear. Learn the habit.

---

# 19. DELETE, TRUNCATE, DROP

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Delete chosen rows · Empty a table fast · Use soft deletes · Follow the pre-delete checklist |

> [!NOTE]
> 📌 **In plain words:** Three ways to remove things, and each one destroys a very different amount. Choosing wrongly is how people lose data permanently.

> 🌍 **Analogy:** A notebook. `DELETE` rubs out chosen lines. `TRUNCATE` tears out every page but keeps the empty notebook. `DROP` throws the whole notebook in the bin.

## 19.1 🎯 DELETE — remove selected rows

```sql
-- ✅ Works in BOTH
DELETE FROM order_items WHERE order_id = 1004;

DELETE FROM orders
WHERE status = 'Cancelled'
  AND order_date < '2026-01-01';

-- 💀 Deletes EVERY row — same danger as UPDATE with no WHERE
DELETE FROM order_items;
```

**DELETE with a JOIN or subquery:**

```sql
-- 🟥 MSSQL
DELETE oi
FROM order_items AS oi
INNER JOIN orders AS o ON o.order_id = oi.order_id
WHERE o.status = 'Cancelled';
```

```sql
-- 🟦 MySQL: name the table(s) to delete from BEFORE the FROM
DELETE oi
FROM order_items AS oi
INNER JOIN orders AS o ON o.order_id = oi.order_id
WHERE o.status = 'Cancelled';

-- MySQL can delete from BOTH tables in one statement
DELETE oi, o
FROM order_items AS oi
INNER JOIN orders AS o ON o.order_id = oi.order_id
WHERE o.status = 'Cancelled';
```

```sql
-- ✅ Portable version with a subquery (works in BOTH)
DELETE FROM order_items
WHERE order_id IN (SELECT order_id FROM orders WHERE status = 'Cancelled');
```

> [!CAUTION]
> 🐛 **MySQL error 1093: "You can't specify target table for update in FROM clause."** MySQL will not let you read the same table you are deleting from in a plain subquery. The workaround is to wrap the subquery one level deeper, which makes MySQL build a temporary copy of the list first:
> ```sql
> DELETE FROM orders
> WHERE order_id IN (
>     SELECT order_id FROM (
>         SELECT order_id FROM orders WHERE status = 'Cancelled'
>     ) AS tmp
> );
> ```

## 19.2 🧹 TRUNCATE — empty the table fast

```sql
-- ✅ Works in BOTH
TRUNCATE TABLE staging_products;
```

**Why it is so much faster than `DELETE`:** `DELETE` is row-by-row. It writes every removed row into
the transaction log so each one can be rolled back, fires any `DELETE` triggers, and updates every
index. `TRUNCATE` instead deallocates the table's storage pages and logs only the deallocations — a
tiny, fixed amount of work regardless of how many rows were in the table.

That difference in **mechanism** is why `TRUNCATE` scales differently: `DELETE` cost grows with the
row count, `TRUNCATE` cost does not. On a large table the practical gap is commonly several orders of
magnitude — but the exact numbers depend on row size, index count, trigger count, recovery model, and
your storage. **Measure on your own data rather than trusting any figure quoted in a guide**, this one
included.

> [!WARNING]
> ⚠️ **Three things that will bite you:**
> 1. **You cannot `TRUNCATE` a table referenced by a foreign key**, even if there are no child rows. Remove the foreign key, truncate, then add the foreign key back — or just use `DELETE`.
> 2. **Triggers do not fire.** If you rely on a delete trigger to record deletions, `TRUNCATE` skips it completely.
> 3. **In MySQL, `TRUNCATE` is saved the moment it runs (an *implicit commit*), so it cannot be rolled back.** In MSSQL it can be rolled back inside an explicit transaction. Do not carry the habit across engines.

## 19.3 🗑️ Soft delete — what production systems actually do

Real applications very rarely delete anything. They mark it as gone.

```sql
-- ✅ MSSQL
ALTER TABLE customers ADD is_deleted BIT NOT NULL DEFAULT 0;
ALTER TABLE customers ADD deleted_at DATETIME2(0) NULL;
GO

-- "Deleting" a customer
UPDATE customers
SET is_deleted = 1, deleted_at = SYSDATETIME()
WHERE customer_id = 4;

-- Every normal query then filters them out
SELECT * FROM customers WHERE is_deleted = 0;
```

```sql
-- ✅ MySQL
ALTER TABLE customers ADD COLUMN is_deleted BOOLEAN NOT NULL DEFAULT 0;
ALTER TABLE customers ADD COLUMN deleted_at DATETIME NULL;

UPDATE customers
SET is_deleted = 1, deleted_at = CURRENT_TIMESTAMP
WHERE customer_id = 4;

SELECT * FROM customers WHERE is_deleted = 0;
```

| | Hard delete (`DELETE`) | Soft delete (`is_deleted` flag) |
|---|---|---|
| Data recoverable | ❌ Only from backup | ✅ Instantly |
| Foreign keys stay valid | ⚠️ Cascades or blocks | ✅ Nothing breaks |
| Historical reports still work | ❌ Orders lose their customer | ✅ Everything still joins |
| Table size | ✅ Shrinks | ⚠️ Grows forever |
| Query complexity | ✅ Simple | ⚠️ Every query needs the filter |
| Legal "right to be forgotten" (privacy laws such as GDPR) | ✅ Compliant | ⚠️ Needs a real purge process too |

> [!TIP]
> 💡 **The professional pattern:** soft delete for everyday operations, plus a scheduled job that permanently deletes or anonymizes rows once they are older than the period you must keep them. Wrap the filter in a view so nobody forgets it:
> ```sql
> CREATE VIEW v_active_customers AS
> SELECT * FROM customers WHERE is_deleted = 0;
> ```

## 19.4 🛟 The pre-delete checklist

```sql
-- 🟥 MSSQL
-- 1. SELECT first. Always. Look at the actual rows.
SELECT * FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';

-- 2. Count them. Does the number match your expectation?
SELECT COUNT(*) FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';

-- 3. Back them up.  (🟥 MSSQL form — see the MySQL form below)
SELECT * INTO orders_deleted_backup
FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';

-- 4. Delete inside a transaction and verify before committing.
BEGIN TRANSACTION;
    DELETE FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';
    SELECT @@ROWCOUNT AS rows_deleted;
-- COMMIT;  -- only after you are satisfied
ROLLBACK;
```

```sql
-- ✅ MySQL: same four steps
SELECT * FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';
SELECT COUNT(*) FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';

CREATE TABLE orders_deleted_backup AS
SELECT * FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';

START TRANSACTION;
    DELETE FROM orders WHERE status = 'Cancelled' AND order_date < '2026-01-01';
    SELECT ROW_COUNT() AS rows_deleted;
-- COMMIT;
ROLLBACK;
```

> [!TIP]
> 💡 **Batch large deletes** for the same reason you batch large updates — so other users are not locked out and the transaction log does not balloon:
> ```sql
> -- 🟥 MSSQL
> WHILE 1 = 1
> BEGIN
>     DELETE TOP (5000) FROM payments WHERE payment_date < '2024-01-01';
>     IF @@ROWCOUNT = 0 BREAK;
> END;
>
> -- 🟦 MySQL
> DELETE FROM payments WHERE payment_date < '2024-01-01' LIMIT 5000;  -- repeat
> ```

## 19.5 🧪 Try it yourself

1. Delete all `order_items` belonging to cancelled orders — first as a `SELECT`, then for real inside a transaction, then roll back.
2. Add a soft-delete column to `products` and write the view that hides discontinued and deleted items.
3. Try to `TRUNCATE TABLE orders`. Read the exact error and explain which constraint caused it.
4. Delete order 1000 and check what happened to its `order_items` and `payments`. Which referential action was responsible?

---
# 🧮 PART 4 — FUNCTIONS

> [!NOTE]
> 📌 **In plain words:** A function takes a value in and gives a transformed value back. `UPPER('tom')` gives `'TOM'`. Functions are how raw stored data becomes a readable report.

---

# 20. String functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 25 min | Clean and reshape text · Split and join text · Build codes like `INV-00042` · Combine many rows into one list |

> [!NOTE]
> 📌 **In plain words:** String functions reshape text. They cut pieces out of it, glue pieces together, change its case, strip the junk off the ends, and find things inside it. Real data arrives messy — `"  aMARA  "`, `"AMARA.SILVA@EXAMPLE.COM "`, `"+94 77 555 0101"` — and these are the tools that make it usable.

> 🌍 **Analogy:** String functions are your **text workshop**: scissors to cut, glue to join, a magnifying glass to search, and sandpaper to clean up messy edges.

> [!IMPORTANT]
> 🎯 **When you will reach for them:** cleaning imported data, building display labels and full names, extracting the domain from an email, generating reference codes like `INV-00042`, and tidying values (for example, making every email lower-case) before you compare them.

## 20.1 📏 Length, case, and trimming

When a table cell says *(2017+)* or *(2022+)*, that function needs SQL Server 2017 or 2022 or newer.

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Length in characters | `LEN(s)` ⚠️ ignores trailing spaces | `CHAR_LENGTH(s)` |
| Length in bytes (storage size) | `DATALENGTH(s)` | `LENGTH(s)` |
| Uppercase | `UPPER(s)` | `UPPER(s)` |
| Lowercase | `LOWER(s)` | `LOWER(s)` |
| Trim both ends | `TRIM(s)` (2017+) | `TRIM(s)` |
| Trim left / right | `LTRIM(s)` / `RTRIM(s)` | `LTRIM(s)` / `RTRIM(s)` |
| Trim a specific character | `TRIM('x' FROM s)` (2022+) | `TRIM('x' FROM s)` |
| Repeat | `REPLICATE(s, n)` | `REPEAT(s, n)` |
| Reverse | `REVERSE(s)` | `REVERSE(s)` |
| Pad left / right | `RIGHT(REPLICATE('0',5)+s,5)` | `LPAD(s,5,'0')` / `RPAD(s,5,'0')` |
| Space characters | `SPACE(n)` | `SPACE(n)` |

```sql
-- ✅ Works in BOTH: clean up messy imported data
SELECT
    TRIM(full_name)                AS trimmed,
    UPPER(country)                 AS country_code,
    LOWER(email)                   AS normalized_email
FROM customers;
```

> [!WARNING]
> ⚠️ **MSSQL `LEN` vs `DATALENGTH`:** `LEN('abc   ')` returns **3** — it ignores trailing spaces. `DATALENGTH` returns the true byte count (6 for `VARCHAR`, 12 for `NVARCHAR`). If you are checking whether data will fit a column, you want `DATALENGTH`.

```sql
-- 🟦 MySQL: LPAD for invoice numbers like INV-00042
SELECT CONCAT('INV-', LPAD(order_id, 8, '0')) AS invoice_no FROM orders;
```

```sql
-- 🟥 MSSQL: the same result
SELECT 'INV-' + RIGHT(REPLICATE('0', 8) + CAST(order_id AS VARCHAR(10)), 8) AS invoice_no
FROM orders;

-- MSSQL 2012+ has FORMAT, which is prettier but SLOW on large sets
SELECT 'INV-' + FORMAT(order_id, '00000000') AS invoice_no FROM orders;
```

> [!WARNING]
> ⚠️ **Avoid `FORMAT()` in MSSQL on large result sets.** It runs extra Microsoft .NET code for every single row and is often **40x slower** than plain text functions. It is fine for a 50-row report, terrible for a million-row export.

## 20.2 ✂️ Extracting parts of a string

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| First n characters | `LEFT(s, n)` | `LEFT(s, n)` |
| Last n characters | `RIGHT(s, n)` | `RIGHT(s, n)` |
| Middle | `SUBSTRING(s, start, len)` | `SUBSTRING(s, start, len)` |
| Find a position | `CHARINDEX(what_to_find, text)` | `LOCATE(what_to_find, text)` or `INSTR(text, what_to_find)` |
| Split at a separator | `STRING_SPLIT(s, ',')` (2016+) | `SUBSTRING_INDEX(s, ',', n)` |

> [!TIP]
> 💡 **Both use 1-based positions**, not 0-based like most programming languages. `SUBSTRING('Hello', 1, 3)` is `'Hel'`.

```sql
-- ✅ Real-world: split an email into the user part and the domain

-- 🟥 MSSQL
SELECT
    email,
    LEFT(email, CHARINDEX('@', email) - 1)              AS user_part,
    SUBSTRING(email, CHARINDEX('@', email) + 1, 200)    AS domain_part
FROM customers;
```

```sql
-- 🟦 MySQL
SELECT
    email,
    SUBSTRING_INDEX(email, '@', 1)   AS user_part,
    SUBSTRING_INDEX(email, '@', -1)  AS domain_part
FROM customers;
```

```sql
-- ✅ Real-world: split "Amara Silva" into first and last name

-- 🟥 MSSQL
SELECT
    full_name,
    LEFT(full_name, CHARINDEX(' ', full_name + ' ') - 1)      AS first_name,
    LTRIM(SUBSTRING(full_name, CHARINDEX(' ', full_name + ' '), 100)) AS last_name
FROM customers;
```

```sql
-- 🟦 MySQL
SELECT
    full_name,
    SUBSTRING_INDEX(full_name, ' ', 1)   AS first_name,
    SUBSTRING_INDEX(full_name, ' ', -1)  AS last_name
FROM customers;
```

> [!TIP]
> 💡 **Note the `full_name + ' '` trick in the MSSQL version.** `CHARINDEX(' ', 'Madonna')` returns 0, and `LEFT(s, -1)` errors. Appending a space guarantees a match and makes the expression safe for single-word names. Small defensive touches like this are what separates code that works on your test data from code that works on real data.

## 20.3 🔗 Joining and replacing

```sql
-- ✅ CONCAT works in BOTH and treats NULL as an empty string
SELECT CONCAT(full_name, ' (', country, ')') AS label FROM customers;

-- ✅ CONCAT_WS: "with separator" — joins and skips NULLs cleanly
SELECT CONCAT_WS(', ', city, country) AS location FROM customers;
-- If city is NULL you get "Sri Lanka", not ", Sri Lanka"

-- ✅ REPLACE works in BOTH
SELECT REPLACE(phone, '-', '') AS digits_only FROM customers;
SELECT REPLACE(REPLACE(REPLACE(phone,'-',''),' ',''),'+','') AS clean_phone FROM customers;
```

```sql
-- 🟥 MSSQL: STRING_AGG joins ROWS into one string (2017+)
SELECT
    o.order_id,
    STRING_AGG(p.product_name, ', ') WITHIN GROUP (ORDER BY p.product_name) AS items
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id;
```

```sql
-- 🟦 MySQL: GROUP_CONCAT does the same
SELECT
    o.order_id,
    GROUP_CONCAT(p.product_name ORDER BY p.product_name SEPARATOR ', ') AS items
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id;
```

**Result:**

| order_id | items |
|---|---|
| 1002 | MechKey RGB Keyboard, VisionPanel 32 4K, WorkStation X17 |

> [!WARNING]
> ⚠️ **MySQL `GROUP_CONCAT` silently truncates at 1024 characters by default.** Your report looks fine in testing and loses data in production. Raise it:
> ```sql
> -- 🟦 MySQL
> SET SESSION group_concat_max_len = 100000;
> ```

## 20.4 🧼 A real-world data cleaning pipeline

```sql
-- ✅ Works in BOTH: normalize a messy imported customer file
SELECT
    customer_id,
    -- Fix casing: "aMARA silva" → "Amara silva"
    CONCAT(UPPER(LEFT(TRIM(full_name), 1)), LOWER(SUBSTRING(TRIM(full_name), 2, 200))) AS clean_name,
    -- Normalize the email
    LOWER(TRIM(email)) AS clean_email,
    -- Strip everything but digits from the phone
    REPLACE(REPLACE(REPLACE(COALESCE(phone,''), '-', ''), ' ', ''), '+', '') AS clean_phone,
    -- Flag rows that still look wrong
    CASE
        WHEN email NOT LIKE '%_@_%._%'      THEN 'Invalid email'
        WHEN TRIM(COALESCE(phone,'')) = ''  THEN 'Missing phone'
        ELSE 'OK'
    END AS data_quality
FROM customers;
```

> [!TIP]
> 💡 **Pro tip:** Do heavy text cleaning **once**, on the way in (in a staging table), not on every read. Cleaning in a `SELECT` means the CPU work repeats for every user, every query, forever — and it stops indexes from being used (see [Chapter 48](#48-query-optimization-and-sargability)).

## 20.5 🧪 Try it yourself

1. Produce a column reading `SILVA, Amara` for every customer.
2. Extract the email domain and count customers per domain.
3. Build a padded product code like `PRD-0007` from `product_id`.
4. For each order, produce one row listing all its product names, comma-separated.

---

# 21. Numeric and math functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Round numbers correctly · Avoid the integer-division trap · Calculate percentages · Pick random rows |

> [!NOTE]
> 📌 **In plain words:** These are the everyday calculator buttons of SQL — rounding money to two decimals, working out a percentage, splitting a total into whole units. You will use four of them constantly and the rest almost never.

> 🌍 **Real-world analogy:** A **till at a shop counter**. It adds, it applies tax, and — crucially — it decides how to round the awkward half-cent. Get the rounding rule wrong and every receipt is a penny out; do it a million times and someone notices.

## 21.1 🔢 The essential list

| Task | 🟥 MSSQL | 🟦 MySQL | Example |
|---|---|---|---|
| Round to n places | `ROUND(x, n)` | `ROUND(x, n)` | `ROUND(3.567, 2)` → 3.57 |
| Round up | `CEILING(x)` | `CEIL(x)` / `CEILING(x)` | `CEILING(3.1)` → 4 |
| Round down | `FLOOR(x)` | `FLOOR(x)` | `FLOOR(3.9)` → 3 |
| Chop off decimals | `ROUND(x, 0, 1)` | `TRUNCATE(x, 0)` | `TRUNCATE(3.99, 0)` → 3 |
| Absolute value | `ABS(x)` | `ABS(x)` | `ABS(-15)` → 15 |
| Remainder | `x % y` | `MOD(x, y)` or `x % y` | `10 % 3` → 1 |
| Power | `POWER(x, y)` | `POW(x, y)` | `POWER(2, 10)` → 1024 |
| Square root | `SQRT(x)` | `SQRT(x)` | |
| Sign | `SIGN(x)` | `SIGN(x)` | -1, 0, or 1 |
| Random 0–1 | `RAND()` | `RAND()` | |
| Greatest / least | `GREATEST`/`LEAST` (2022+) | `GREATEST`/`LEAST` | |
| Logarithms | `LOG(x)`, `LOG10(x)`, `EXP(x)` | same | |

```sql
-- ✅ Works in BOTH: a realistic pricing report
SELECT
    product_name,
    unit_price,
    ROUND(unit_price * 0.15, 2)        AS tax_amount,
    ROUND(unit_price * 1.15, 2)        AS price_with_tax,
    CEILING(unit_price)                AS rounded_up_display_price,
    ROUND(unit_price * 0.85, 2)        AS sale_price_15_off
FROM products
ORDER BY unit_price DESC;
```

## 21.2 ⚠️ The integer division trap

```sql
-- ⚠️ Works in BOTH, but the engines DISAGREE on integer ÷ integer
SELECT 10 / 4;   -- 🟥 MSSQL: 2, not 2.5 — the decimals are DISCARDED
                 -- 🟦 MySQL: 2.5000 (MySQL promotes to decimal, friendlier here)
```

```sql
-- 🟦 MySQL: explicit integer division, when that is what you want
SELECT 10 DIV 4;                -- 2
```

> 🔀 **This really matters when you move code between engines.** MSSQL does whole-number division; MySQL switches to decimal maths. Code that computes percentages correctly in MySQL can return all zeros in MSSQL.

```sql
-- ✅ The portable fix: force a decimal into the expression
SELECT
    category_id,
    COUNT(*) AS product_count,
    -- ❌ WRONG in MSSQL: gives 0
    COUNT(*) / (SELECT COUNT(*) FROM products) AS bad_share,
    -- ✅ RIGHT in both: multiply by 100.0 (a number written with a decimal point)
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM products), 2) AS pct_of_catalog
FROM products
GROUP BY category_id;
```

> [!TIP]
> 💡 **Memorize this habit: `100.0 * a / b`, never `100 * a / b`.** The `.0` turns the whole calculation into decimal maths. It is the single most common cause of "why is my percentage zero?"

## 21.3 🎲 Random rows and rounding modes

```sql
-- ✅ MSSQL: a random sample of 5 products
SELECT TOP 5 * FROM products ORDER BY NEWID();
```

```sql
-- ✅ MySQL: a random sample of 5 products
SELECT * FROM products ORDER BY RAND() LIMIT 5;
```

> [!WARNING]
> ⚠️ `ORDER BY RAND()` sorts the **entire table** before taking 5 rows. Fine for 18 products, catastrophic for 18 million. For large tables, pick random ID numbers instead.

Some systems round `2.5` to `2` (*banker's rounding*: to the nearest even number); others round it to `3` (*half-up*). Check what your engine does:

```sql
-- Banker's rounding vs half-up: know which your engine does
SELECT ROUND(2.5, 0), ROUND(3.5, 0);
-- Both MSSQL and MySQL round half AWAY FROM ZERO here: 3 and 4.
-- But floating-point inputs can behave differently — another reason to use DECIMAL for money.
```

## 21.4 🎯 When to use which rounding function

This is the decision people get wrong most often, so here it is as a table:

| You want to... | Use | `12.7` becomes | `-12.7` becomes |
|---|---|---|---|
| Round to the nearest value (normal maths) | `ROUND(x, 0)` | 13 | -13 |
| Round money to 2 decimals for display | `ROUND(x, 2)` then `CAST(... AS DECIMAL(12,2))` | — | — |
| Always round **up** (order enough boxes) | `CEILING(x)` | 13 | **-12** |
| Always round **down** (how many fit in a pallet) | `FLOOR(x)` | 12 | **-13** |
| Chop the decimals off, keep the sign | `ROUND(x,0,1)` 🟥 / `TRUNCATE(x,0)` 🟦 | 12 | **-12** |

> [!WARNING]
> ⚠️ **Note the negative-number column.** `CEILING(-12.7)` is `-12`, not `-13` — "up" means *towards bigger numbers*, and −12 is bigger than −13. `FLOOR` and `TRUNCATE` disagree on negatives too. If your data can go negative (refunds, adjustments, temperature), pick deliberately and write a test.

**Real-world uses, in the language of the business:**

```sql
-- ✅ Works in BOTH

-- 📦 "How many 12-packs must we order to cover demand?"  → always round UP
SELECT product_name, units_in_stock, reorder_level,
       CEILING((reorder_level * 2.0 - units_in_stock) / 12.0) AS packs_to_order
FROM products
WHERE units_in_stock < reorder_level;

-- 💰 "Split an order total evenly across 3 instalments, to the cent"
SELECT
    order_id,
    CAST(SUM(unit_price*quantity*(1-discount)) AS DECIMAL(12,2))     AS total,
    CAST(SUM(unit_price*quantity*(1-discount))/3 AS DECIMAL(12,2))   AS per_instalment
FROM order_items GROUP BY order_id;

-- 🔢 "Give me every 3rd product" → the remainder operator %
SELECT product_id, product_name FROM products WHERE product_id % 3 = 0;

-- 📊 "What percentage of stock is this product?" → the 100.0 trick (SUM(...) OVER () = the grand total, Chapter 33)
SELECT product_name,
       ROUND(100.0 * units_in_stock / SUM(units_in_stock) OVER (), 2) AS pct_of_stock
FROM products;
```

> [!CAUTION]
> 🐛 **Common mistake:** rounding at the wrong moment. Round **once, at the end**, for display. If you round each line of an order to 2 decimals and *then* add them up, your total can differ from the true total by several cents — and an invoice whose lines do not add up to its total is an invoice the finance team rejects. **Do the maths at full precision; round only the final number you show.**

> [!TIP]
> 💡 **Pro tip:** `ROUND()` changes the value but not the number of decimal places the result is shown with, so it can still *display* as `129.00000`. When the number is going straight onto a report, finish with `CAST(x AS DECIMAL(12,2))`. See [Chapter 28](#28-joins-the-complete-picture) for a worked example.

## 21.5 🧪 Try it yourself

1. Show each product's price, price with 8.25% tax, and the tax rounded to 2 places.
2. Compute each category's share of the total catalogue as a percentage — and confirm it is not zero in MSSQL.
3. Find products whose `product_id` is even (`MOD` / `%`).
4. Calculate the average order value, rounded to 2 decimal places.

---

# 22. Date and time functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 30 min | Get today's date and time · Add and subtract dates · Measure the time between dates · Build monthly reports safely |

> [!NOTE]
> 📌 **In plain words:** Dates are the most error-prone data type in SQL. Time zones, month lengths, leap years, and date formats all work against you. This chapter is your defence.

> 🌍 **Analogy:** Is `03/04/2026` the 3rd of April or the 4th of March? A British person and an American person will give you different answers — and so will two databases. Date functions are how you stop guessing.

## 22.1 🕐 Getting the current date and time

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Now (date + time) | `GETDATE()`, `SYSDATETIME()` | `NOW()`, `CURRENT_TIMESTAMP` |
| Now in UTC | `GETUTCDATE()`, `SYSUTCDATETIME()` | `UTC_TIMESTAMP()` |
| Today only | `CAST(GETDATE() AS DATE)` | `CURDATE()`, `CURRENT_DATE` |
| Time only | `CAST(GETDATE() AS TIME)` | `CURTIME()` |

```sql
-- 🟥 MSSQL
SELECT GETDATE()          AS now_local,
       SYSDATETIME()      AS now_high_precision,
       SYSUTCDATETIME()   AS now_utc,
       CAST(GETDATE() AS DATE) AS today;
```

```sql
-- 🟦 MySQL
SELECT NOW()              AS now_local,
       UTC_TIMESTAMP()    AS now_utc,
       CURDATE()          AS today,
       CURTIME()          AS time_now;
```

> [!TIP]
> 💡 **`SYSDATETIME()` is more precise than `GETDATE()`** (100 nanoseconds vs 3.33 milliseconds). Prefer it for new MSSQL code.

## 22.2 🧩 Extracting parts of a date

| Part | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Year | `YEAR(d)` or `DATEPART(YEAR, d)` | `YEAR(d)` |
| Month number | `MONTH(d)` | `MONTH(d)` |
| Day of month | `DAY(d)` | `DAY(d)` |
| Hour / minute / second | `DATEPART(HOUR, d)` | `HOUR(d)`, `MINUTE(d)`, `SECOND(d)` |
| Day of week | `DATEPART(WEEKDAY, d)` ⚠️ depends on the server's language settings | `DAYOFWEEK(d)` (1=Sun), `WEEKDAY(d)` (0=Mon) |
| Day of year | `DATEPART(DAYOFYEAR, d)` | `DAYOFYEAR(d)` |
| Week number | `DATEPART(ISO_WEEK, d)` | `WEEK(d, 3)` for the ISO (international standard) week |
| Quarter | `DATEPART(QUARTER, d)` | `QUARTER(d)` |
| Month name | `DATENAME(MONTH, d)` | `MONTHNAME(d)` |
| Day name | `DATENAME(WEEKDAY, d)` | `DAYNAME(d)` |
| Last day of month | `EOMONTH(d)` | `LAST_DAY(d)` |

```sql
-- 🟥 MSSQL — real-world: break orders down by time period
SELECT
    order_id,
    order_date,
    YEAR(order_date)                    AS order_year,
    MONTH(order_date)                   AS order_month,
    DATENAME(MONTH, order_date)         AS month_name,     -- 🟥 MSSQL
    DATEPART(QUARTER, order_date)       AS quarter         -- 🟥 MSSQL
FROM orders;
```

```sql
-- 🟦 MySQL equivalent
SELECT
    order_id,
    order_date,
    YEAR(order_date)     AS order_year,
    MONTH(order_date)    AS order_month,
    MONTHNAME(order_date) AS month_name,
    QUARTER(order_date)  AS quarter
FROM orders;
```

## 22.3 ➕ Date arithmetic

```sql
-- 🟥 MSSQL: DATEADD(part, number, date)
SELECT
    GETDATE()                              AS today,
    DATEADD(DAY,   7, GETDATE())           AS next_week,
    DATEADD(MONTH, 1, GETDATE())           AS next_month,
    DATEADD(YEAR, -1, GETDATE())           AS last_year,
    DATEADD(HOUR, -2, GETDATE())           AS two_hours_ago;
```

```sql
-- 🟦 MySQL: DATE_ADD / DATE_SUB, or the INTERVAL shorthand
SELECT
    NOW()                                  AS today,
    DATE_ADD(NOW(), INTERVAL 7 DAY)        AS next_week,
    NOW() + INTERVAL 1 MONTH               AS next_month,
    NOW() - INTERVAL 1 YEAR                AS last_year,
    DATE_SUB(NOW(), INTERVAL 2 HOUR)       AS two_hours_ago;
```

**Difference between two dates:**

```sql
-- 🟥 MSSQL: DATEDIFF(part, start, end)
SELECT
    order_id,
    order_date,
    ship_date,
    DATEDIFF(DAY, order_date, ship_date) AS days_to_ship
FROM orders
WHERE ship_date IS NOT NULL;
```

```sql
-- 🟦 MySQL: DATEDIFF gives DAYS only; TIMESTAMPDIFF takes a unit
SELECT
    order_id,
    DATEDIFF(ship_date, order_date)                        AS days_to_ship,
    TIMESTAMPDIFF(HOUR, order_date, ship_date)             AS hours_to_ship,
    TIMESTAMPDIFF(MONTH, order_date, CURDATE())            AS months_ago
FROM orders
WHERE ship_date IS NOT NULL;
```

> [!WARNING]
> ⚠️ **Argument order is reversed!** MSSQL is `DATEDIFF(part, earlier, later)`. MySQL is `DATEDIFF(later, earlier)`. Get it backwards and every duration in your report is negative.

> [!WARNING]
> ⚠️ **`DATEDIFF` counts calendar boundaries crossed (such as New Year), not the time that really passed.** In MSSQL, `DATEDIFF(YEAR, '2025-12-31', '2026-01-01')` is **1**, despite being one day apart. Calculating someone's age with `DATEDIFF(YEAR, date_of_birth, GETDATE())` is therefore wrong for anyone whose birthday has not happened yet this year.

```sql
-- ✅ MSSQL: correct age calculation (adjust for a birthday not yet reached)
SELECT DATEDIFF(YEAR, '1990-11-20', GETDATE())
       - CASE WHEN (MONTH(GETDATE()) < 11)
                OR (MONTH(GETDATE()) = 11 AND DAY(GETDATE()) < 20)
              THEN 1 ELSE 0 END AS age;
```

```sql
-- ✅ MySQL has a built-in for exactly this
SELECT TIMESTAMPDIFF(YEAR, '1990-11-20', CURDATE()) AS age;
```

## 22.4 📅 Truncating to period boundaries — the reporting workhorse

Reports often need to turn every date into "the first day of its month", so that all of March's orders fall into one group. That is called *truncating* a date.

```sql
-- ✅ MSSQL 2012+ : works on every supported version
-- First day of the month
SELECT DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_start FROM orders;

-- The classic trick that works everywhere
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, order_date), 0) AS month_start FROM orders;

-- Last day of the month
SELECT EOMONTH(order_date) AS month_end FROM orders;
```

```sql
-- ✅ MSSQL 2022+ ONLY: DATETRUNC is cleaner, but it does not exist before 2022.
-- On SQL Server 2019 or older this fails with:
--   'DATETRUNC' is not a recognized built-in function name.
SELECT DATETRUNC(MONTH, order_date) AS month_start FROM orders;
```

```sql
-- 🟦 MySQL
SELECT DATE_FORMAT(order_date, '%Y-%m-01') AS month_start FROM orders;
SELECT LAST_DAY(order_date)                AS month_end   FROM orders;
```

```sql
-- ✅ Real-world: monthly revenue report (the query every business asks for)

-- 🟥 MSSQL
SELECT
    DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS month_start,
    COUNT(DISTINCT o.order_id)                                AS order_count,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount))      AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1)
ORDER BY month_start;
```

```sql
-- 🟦 MySQL
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m')                   AS month_key,
    COUNT(DISTINCT o.order_id)                           AS order_count,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month_key;
```

## 22.5 🎨 Formatting dates for display

```sql
-- 🟥 MSSQL
SELECT
    FORMAT(GETDATE(), 'yyyy-MM-dd')            AS iso_date,
    FORMAT(GETDATE(), 'dd MMM yyyy')           AS friendly,
    FORMAT(GETDATE(), 'dddd, dd MMMM yyyy')    AS long_form,
    CONVERT(VARCHAR(10), GETDATE(), 120)       AS fast_iso;   -- style 120 = ISO
```

```sql
-- 🟦 MySQL
SELECT
    DATE_FORMAT(NOW(), '%Y-%m-%d')             AS iso_date,
    DATE_FORMAT(NOW(), '%d %b %Y')             AS friendly,
    DATE_FORMAT(NOW(), '%W, %d %M %Y')         AS long_form;
```

**Common MySQL `DATE_FORMAT` codes:**

| Code | Meaning | Example |
|---|---|---|
| `%Y` / `%y` | 4- / 2-digit year | 2026 / 26 |
| `%m` / `%c` | Month with / without leading zero | 09 / 9 |
| `%M` / `%b` | Month name / abbreviated | September / Sep |
| `%d` / `%e` | Day with / without leading zero | 09 / 9 |
| `%W` / `%a` | Weekday name / abbreviated | Wednesday / Wed |
| `%H:%i:%s` | 24-hour time | 14:30:00 |
| `%h:%i %p` | 12-hour time | 02:30 PM |

> [!TIP]
> 💡 **Pro tip — format in the application, not in SQL.** Return plain `DATE`/`DATETIME` values and let your app display them in each user's own style (for example `03/12/2026` in the US and `12/03/2026` in Europe). Formatting in SQL makes results bigger, breaks sorting (`'01/02/2026'` sorts as text), and is slow. The exception is a CSV export (a plain text file of rows that Excel can open) or a report where SQL is genuinely the last stop.

## 22.6 ⚠️ Date literals, formats, and the biggest trap

```sql
-- ✅ SAFE in BOTH: ISO 8601 (year-month-day), understood the same way everywhere
SELECT order_id FROM orders WHERE order_date >= '2026-03-01';

-- ✅ Also safe in MSSQL: no separators at all
SELECT order_id FROM orders WHERE order_date >= '20260301';

-- ❌ DANGEROUS: interpreted differently by region/language settings
--    Is this 1 March or 3 January? In MSSQL it depends on the session's language;
--    MySQL (strict mode, the default) rejects it outright: ERROR 1525 Incorrect DATE value.
SELECT order_id FROM orders WHERE order_date >= '03/01/2026';
```

> [!WARNING]
> ⚠️ **`'2026-03-01'` is safe in both engines today, but MSSQL's older `DATETIME` type could read `YYYY-MM-DD` differently depending on a language setting called `DATEFORMAT`.** The bulletproof MSSQL literal is `'20260301'` (no separators) or `CAST('2026-03-01' AS DATE)`. **Always write dates in ISO order and never in `DD/MM` or `MM/DD` form.**

> [!WARNING]
> ⚠️ **The performance trap — never wrap the column in a function:**
> ```sql
> -- ❌ SLOW: the index on order_date cannot be used
> SELECT order_id FROM orders WHERE YEAR(order_date) = 2026;
>
> -- ✅ FAST: the index works perfectly
> SELECT order_id FROM orders WHERE order_date >= '2026-01-01' AND order_date < '2027-01-01';
> ```
> This applies to `MONTH()`, `CAST()`, `CONVERT()`, `DATE_FORMAT()` — any function applied to the column. See [Chapter 48](#48-query-optimization-and-sargability).

## 22.7 🎯 When to use which date tool

| You want to... | Use | ⚠️ Watch out |
|---|---|---|
| Filter a month / year / range | `>= start AND < next_start` | **Never** `YEAR(col) = 2026` — the index can no longer be used |
| Group a report by month | `DATEFROMPARTS(...)` 🟥 / `DATE_FORMAT(d,'%Y-%m')` 🟦 | Grouping by a function is fine; *filtering* by one is not |
| Measure a duration | `DATEDIFF` 🟥 / `TIMESTAMPDIFF` 🟦 | Argument order is **reversed** between engines |
| Someone's age | `TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())` 🟦 / `DATEDIFF` + a birthday check 🟥 | `DATEDIFF(YEAR,…)` counts New Years crossed, not full years |
| Show a date to a user | Format in the **application** | Formatting in SQL breaks sorting and is slow |
| Store when something happened | `DATETIME2` / `DATETIME` in **UTC** | Mixed local times are unrecoverable |
| Store a wall-clock appointment | `DATETIME` (no zone conversion) | `TIMESTAMP` in MySQL converts, and dies in 2038 |
| The last day of the month | `EOMONTH` 🟥 / `LAST_DAY` 🟦 | Do not hand-code 30/31 — February exists |

> [!CAUTION]
> 🐛 **Common mistake:** `BETWEEN '2026-01-01' AND '2026-01-31'` on a `DATETIME` column. It silently drops everything after midnight on the 31st — roughly one day of data per month, forever. Use the half-open range.

## 22.8 🧪 Try it yourself

1. Show every order with the number of days it took to ship.
2. List orders placed in April–June 2026 (Q2) using the index-friendly half-open date range from 14.3.
3. Produce a monthly revenue report in both dialects.
4. Find the last day of the month for every order date.
5. Calculate how many days each unshipped order has been waiting.

---

# 23. Conversion and casting

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 20 min | Convert between text, numbers, and dates · Convert safely without errors · Spot slow hidden conversions |

> [!NOTE]
> 📌 **In plain words:** Converting turns one data type into another — text into a number, a date into text. Do it deliberately, because otherwise the database will do it *implicitly* (silently, on its own), and those silent conversions are a leading cause of slow queries.

> 🌍 **Analogy:** Currency exchange. You can swap your money at the bank at a clear rate (an explicit conversion), or let a shop quietly convert it at the till for you (an implicit one). Both work — but only one of them lets you see what just happened.

## 23.1 🔁 CAST and CONVERT

```sql
-- 🟥 MSSQL: CAST is standard SQL — but the target type NAMES differ by engine
SELECT CAST('123' AS INT)              AS text_to_number;
SELECT CAST(123.99 AS INT)             AS decimal_to_int;      -- 123, truncated
SELECT CAST('2026-06-15' AS DATE)      AS text_to_date;
SELECT CAST(unit_price AS VARCHAR(20)) AS price_as_text FROM products;
```

```sql
-- 🟦 MySQL: there is no INT or VARCHAR target — use SIGNED / UNSIGNED / DECIMAL / CHAR
SELECT CAST('123' AS SIGNED)           AS text_to_number;
SELECT CAST(123.99 AS SIGNED)          AS decimal_to_int;      -- 124: MySQL ROUNDS
SELECT CAST('2026-06-15' AS DATE)      AS text_to_date;
SELECT CAST(unit_price AS CHAR)        AS price_as_text FROM products;
```

```sql
-- 🟥 MSSQL: CONVERT adds style codes, mainly useful for dates
SELECT CONVERT(VARCHAR(10), GETDATE(), 120) AS iso;         -- 2026-09-09
SELECT CONVERT(VARCHAR(10), GETDATE(), 103) AS british;     -- 09/09/2026
SELECT CONVERT(VARCHAR(10), GETDATE(), 101) AS american;    -- 09/09/2026
```

```sql
-- 🟦 MySQL: CONVERT exists with different syntax, mostly for character sets
SELECT CONVERT('123', UNSIGNED) AS n;
SELECT CONVERT(full_name USING utf8mb4) AS s FROM customers;
```

## 23.2 🛡️ Safe conversion that does not blow up

```sql
-- ✅ Works in BOTH: put a few messy rows into the staging table from Chapter 12
INSERT INTO staging_customers (customer_code, full_name, email) VALUES
('1001',   'Clean Row',  'clean@example.com'),
('1002',   'Also Clean', 'also@example.com'),
('ABC123', 'Junk Code',  'junk@example.com');
```

```sql
-- ❌ 🟥 MSSQL: one bad row kills the entire query
SELECT CAST(customer_code AS INT) FROM staging_customers;
-- "Conversion failed when converting the varchar value 'ABC123' to data type int."
```

```sql
-- 🟥 MSSQL 2012+: TRY_CAST / TRY_CONVERT return NULL instead of erroring
SELECT
    customer_code,
    TRY_CAST(customer_code AS INT) AS numeric_code
FROM staging_customers;

-- Find exactly which rows are bad
SELECT * FROM staging_customers WHERE TRY_CAST(customer_code AS INT) IS NULL;
```

```sql
-- 🟦 MySQL: no TRY_CAST. Keep only the rows that really look like numbers first.
SELECT customer_code
FROM staging_customers
WHERE customer_code REGEXP '^[0-9]+$';       -- only genuinely numeric rows
```

> [!TIP]
> 💡 **`TRY_CAST` is a data-cleaning superpower in MSSQL.** After loading a CSV file, you can find every badly formatted value in one query, instead of discovering them one error at a time.

## 23.3 ⚠️ Implicit conversion — the silent performance killer

```sql
-- The column holds text (VARCHAR), but the value typed here is a number
SELECT * FROM customers WHERE phone = 94775550101;
```

> [!WARNING]
> ⚠️ **What just happened:** SQL cannot compare text with a number, so it converts one of them. SQL ranks data types, and **numbers rank above text**, so the engine converts the **column** — every row of it — into numbers. Converting the column means **the index on `phone` cannot be used**, and every row must be read and converted.
>
> There are then **two possible outcomes**, and you should know both:
>
> | If every value in the column converts cleanly | If any value does not |
> |---|---|
> | The query works, but silently reads the whole table. A 5-millisecond index lookup (a *seek*) becomes a 5-second read of every row (a *scan*). | The query **fails outright** partway through. |
>
> Run the query above against ShopDB and you get the second outcome, because the phone numbers contain `+` and `-`:
>
> ```text
> Msg 8114: Error converting data type nvarchar to numeric.
> ```
>
> The error is actually the *lucky* case — it is loud. The dangerous case is a numeric-looking column where everything converts, the query keeps working, and it just quietly gets 1000x slower as the table grows.

```sql
-- ✅ Match the types: quote the literal
SELECT * FROM customers WHERE phone = '+94-77-555-0101';
```

**How to spot it** (execution plans are explained in [Chapter 47](#47-execution-plans)): in an MSSQL execution plan, look for a `CONVERT_IMPLICIT` warning on a scan operator. In MySQL, `EXPLAIN` shows a full table scan where you expected a `ref` lookup.

> [!TIP]
> 💡 **The rule: always compare a column with a value of the same data type.** Numbers without quotes, text in quotes, dates as `'YYYY-MM-DD'`. This one habit prevents a whole family of slowdowns on live systems.

## 23.4 🧮 Numeric conversion precision

```sql
-- ✅ Works in BOTH
SELECT
    CAST(10 AS DECIMAL(10,2)) / CAST(3 AS DECIMAL(10,2)) AS careful;  -- 3.333333
SELECT 10 / 3;   -- 🟥 MSSQL: 3 (integer!)   🟦 MySQL: 3.3333
```

```sql
-- ✅ MSSQL: FORMAT takes a PATTERN such as 'N2', not a number of decimal places
SELECT
    product_name,
    unit_price,
    CAST(unit_price AS VARCHAR(20))          AS as_text,
    CONCAT('$', FORMAT(unit_price, 'N2'))    AS formatted     -- $1,499.00
FROM products;
```

```sql
-- ✅ MySQL: FORMAT takes the NUMBER OF DECIMAL PLACES
SELECT
    product_name,
    unit_price,
    CAST(unit_price AS CHAR)                 AS as_text,
    CONCAT('$', FORMAT(unit_price, 2))       AS formatted     -- $1,499.00
FROM products;
```

> 🔀 **Same function name, completely different second argument.** MySQL's `FORMAT(x, 2)` means "two decimal places". MSSQL's `FORMAT(x, 'N2')` takes a .NET format string. Passing MySQL's integer to SQL Server gives you:
>
> ```text
> Msg 8116: Argument data type int is invalid for argument 2 of format function.
> ```
>
> Useful MSSQL format strings: `'N2'` (1,499.00), `'C'` (currency, in the server's local style), `'P1'` (percent), `'0.00'` (no thousands separator). And remember the warning from [Chapter 20](#20-string-functions): `FORMAT()` in MSSQL is slow — fine for a report, bad for a million rows.

## 23.5 🧪 Try it yourself

1. Convert every product price to a string prefixed with `USD `.
2. In MSSQL, use `TRY_CAST` to find which values in a text column are not valid integers.
3. Write a query that triggers an implicit conversion, then check the execution plan for the warning.
4. Convert `order_date` to three different display formats.

---

# 24. Conditional logic: CASE, IIF, IF

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Write if/then logic with `CASE` · Label and group values · Count many different things in one query |

> [!NOTE]
> 📌 **In plain words:** `CASE` is SQL's "if this, then that". It lets one query return different values depending on the data — for example, labelling each product as *Cheap*, *Mid-range*, or *Premium*.

> 🌍 **Analogy:** Sorting post at a post office: *if* the envelope says London, put it in bag A; *if* it says Paris, bag B; *otherwise*, bag C. `CASE` does exactly this for every row.

## 24.1 🔀 The two forms of CASE

A **searched** `CASE` tests any condition you like. A **simple** `CASE` compares one column with a list of values.

```sql
-- ✅ SEARCHED CASE (most flexible) — works in BOTH
SELECT
    product_name,
    unit_price,
    CASE
        WHEN unit_price >= 1000 THEN 'Premium'
        WHEN unit_price >=  500 THEN 'Mid-range'
        WHEN unit_price >=  100 THEN 'Budget'
        ELSE 'Entry level'
    END AS price_band
FROM products
ORDER BY unit_price DESC;
```

```sql
-- ✅ SIMPLE CASE (equality only) — works in BOTH
SELECT
    order_id,
    status,
    CASE status
        WHEN 'Pending'   THEN 'Awaiting payment'
        WHEN 'Paid'      THEN 'Ready to pack'
        WHEN 'Shipped'   THEN 'On the way'
        WHEN 'Delivered' THEN 'Complete'
        ELSE 'Needs attention'
    END AS friendly_status
FROM orders;
```

> [!WARNING]
> ⚠️ **`CASE` stops at the first matching `WHEN`** — order matters. If you put `WHEN unit_price >= 100` first, everything above 100 becomes "Budget" and the premium branch is unreachable. **Put the strictest condition first.**

> [!WARNING]
> ⚠️ **Always write `ELSE`.** With no `ELSE`, unmatched rows silently become `NULL`. In a `SELECT` that is confusing; in an `UPDATE` it is data loss.

## 24.2 ⚡ Shorthand forms

```sql
-- 🟥 MSSQL: IIF is a compact two-branch CASE
SELECT product_name,
       IIF(units_in_stock = 0, 'Out of stock', 'Available') AS availability
FROM products;

-- CHOOSE picks the nth item from a list
SELECT CHOOSE(3, 'Bronze', 'Silver', 'Gold', 'Platinum') AS tier;  -- 'Gold'
```

```sql
-- 🟦 MySQL: IF(condition, true_value, false_value)
SELECT product_name,
       IF(units_in_stock = 0, 'Out of stock', 'Available') AS availability
FROM products;

-- ELT picks the nth item
SELECT ELT(3, 'Bronze', 'Silver', 'Gold', 'Platinum') AS tier;     -- 'Gold'
```

> [!TIP]
> 💡 **Use `CASE` in code you intend to keep.** `IIF` and `IF` only work in one engine each; `CASE` works in every SQL database on earth. Save the shorthand for quick one-off queries.

## 24.3 🎯 The five patterns you will actually use

Some of these examples also use `JOIN` and `GROUP BY` (Chapters 26 and 28). Focus on the `CASE` part for now.

**① Bucketing values into categories**

```sql
-- ✅ Works in BOTH: customer segmentation by recency
SELECT
    c.full_name,
    MAX(o.order_date) AS last_order,
    CASE
        WHEN MAX(o.order_date) IS NULL                      THEN 'Never ordered'
        WHEN MAX(o.order_date) >= '2026-07-01'              THEN 'Active'
        WHEN MAX(o.order_date) >= '2026-04-01'              THEN 'Cooling off'
        ELSE 'Dormant'
    END AS segment
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name;
```

**② Conditional aggregation — counting things that match a condition**

This is one of the most valuable techniques in all of SQL.

```sql
-- ✅ Works in BOTH: one pass over the table, many different counts
SELECT
    COUNT(*)                                                      AS total_orders,
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END)         AS delivered,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)         AS cancelled,
    SUM(CASE WHEN ship_date IS NULL    THEN 1 ELSE 0 END)         AS not_shipped,
    ROUND(100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)
          / COUNT(*), 2)                                          AS cancel_rate_pct
FROM orders;
```

> [!TIP]
> 💡 **Why this beats running four separate queries:** the table is read **once**. Four `SELECT COUNT(*) … WHERE` statements read it four times. On a large table this is a 4x difference, and the results are guaranteed consistent with each other.

**③ Pivoting rows into columns**

```sql
-- ✅ Works in BOTH: units sold per month, as columns
SELECT
    p.product_name,
    SUM(CASE WHEN MONTH(o.order_date) = 1 THEN oi.quantity ELSE 0 END) AS jan_units,
    SUM(CASE WHEN MONTH(o.order_date) = 2 THEN oi.quantity ELSE 0 END) AS feb_units,
    SUM(CASE WHEN MONTH(o.order_date) = 3 THEN oi.quantity ELSE 0 END) AS mar_units
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o       ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = 2026
GROUP BY p.product_name
ORDER BY p.product_name;
```

**④ Custom sort order** — covered in [Chapter 16](#16-order-by-sorting-results).

**⑤ Safe division**

```sql
SELECT
    product_name,
    CASE WHEN reorder_level = 0 THEN NULL
         ELSE ROUND(1.0 * units_in_stock / reorder_level, 2)
    END AS stock_ratio
FROM products;
```

## 24.4 🧠 CASE in every clause

```sql
-- In SELECT   ✅ (shown above)
-- In WHERE
SELECT * FROM products
WHERE CASE WHEN discontinued = 1 THEN 0 ELSE units_in_stock END < 10;

-- In ORDER BY
SELECT order_id, status, order_date
FROM orders
ORDER BY CASE WHEN status = 'Pending' THEN 0 ELSE 1 END, order_date;

-- In GROUP BY
SELECT
    CASE WHEN unit_price >= 500 THEN 'Expensive' ELSE 'Affordable' END AS band,
    COUNT(*) AS product_count
FROM products
GROUP BY CASE WHEN unit_price >= 500 THEN 'Expensive' ELSE 'Affordable' END;

-- In UPDATE   ✅ (shown in Chapter 18)
-- In HAVING, in JOIN conditions, in CHECK constraints — CASE goes everywhere.
```

> 🔀 **MySQL convenience:** MySQL lets you `GROUP BY` the alias (`GROUP BY band`), so you do not have to repeat the expression. MSSQL does not — repeat it, or wrap the query in a CTE ([Chapter 31](#31-ctes-and-recursive-queries)).

## 24.5 🎯 When to use CASE

| You need to... | Use |
|---|---|
| Turn values into human labels | `CASE` in `SELECT` |
| Bucket numbers into bands (Premium / Mid / Budget) | Searched `CASE` |
| Count several different things in **one pass** | `SUM(CASE WHEN … THEN 1 ELSE 0 END)` |
| Turn rows into columns | `SUM(CASE WHEN month = n …)` |
| Sort by business priority, not alphabetically | `CASE` in `ORDER BY` |
| Set different values per row in one `UPDATE` | `CASE` in `SET` |
| Avoid divide-by-zero | `CASE WHEN d = 0 THEN NULL ELSE n/d END` or `NULLIF` |
| Just pick between two values | `IIF` 🟥 / `IF` 🟦 for quick work — `CASE` for code you keep |

> [!CAUTION]
> 🐛 **Common mistake:** omitting `ELSE`. A `CASE` with no matching branch returns `NULL`. In a `SELECT` that is merely confusing; in an `UPDATE ... SET col = CASE ...` it **wipes the column to NULL** for every unmatched row. Always write an explicit `ELSE`, even if it is `ELSE col` meaning "leave it alone".

## 24.6 🧪 Try it yourself

1. Classify every customer as `Domestic` or `International` based on country.
2. In one query, count orders by status **and** show each status as a percentage of the total.
3. Build a table showing units sold per quarter as four columns.
4. Categorise products into stock levels: `Out`, `Critical` (below reorder), `Low` (below 2× reorder), `Healthy`.

---
# 📊 PART 5 — GROUPING AND AGGREGATION

---

# 25. Aggregate functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢 Beginner | 20 min | Count, total, and average your data · Know how `NULL` affects totals · Avoid the double-counting trap |

> [!NOTE]
> 📌 **In plain words:** An aggregate function takes **many rows** and squeezes them into **one answer**. "How many customers?" "What is the total revenue?" "What is the average order value?"

> 🌍 **Analogy:** A **juicer**. You put in 20 oranges (rows) and get out one glass of juice (a single value). You cannot get the oranges back — which is exactly why you cannot mix aggregated and non-aggregated columns without a `GROUP BY`.

## 25.1 🧰 The core five

| Function | What it does | NULL handling |
|---|---|---|
| `COUNT(*)` | Counts **rows** | Counts every row, NULLs included |
| `COUNT(col)` | Counts **non-NULL values** in that column | ⚠️ Skips NULLs |
| `COUNT(DISTINCT col)` | Counts unique non-NULL values | Skips NULLs |
| `SUM(col)` | Adds the values | Skips NULLs |
| `AVG(col)` | The average (mean) | ⚠️ Divides by the **non-NULL** count |
| `MIN(col)` / `MAX(col)` | Smallest / largest | Skips NULLs; works on text and dates too |

```sql
-- ✅ Works in BOTH: the shape of your data in one query
SELECT
    COUNT(*)                    AS total_products,
    COUNT(supplier_id)          AS products_with_supplier,
    COUNT(DISTINCT category_id) AS categories_used,
    SUM(units_in_stock)         AS total_units,
    AVG(unit_price)             AS avg_price,
    MIN(unit_price)             AS cheapest,
    MAX(unit_price)             AS most_expensive
FROM products;
```

> [!WARNING]
> ⚠️ **`COUNT(*)` vs `COUNT(column)` — the difference that catches everyone.** Imagine 3 of the 18 products had no supplier (`NULL`): `COUNT(*)` would return 18, but `COUNT(supplier_id)` only 15. (In ShopDB every product has a supplier, so the query above shows 18 for both.) Use `COUNT(*)` when you mean "how many rows". Use `COUNT(column)` deliberately, when you mean "how many rows actually have this value".

> [!TIP]
> 💡 **`COUNT(1)` is not faster than `COUNT(*)`.** Both engines optimize them identically. Use `COUNT(*)` — it says what you mean.

## 25.2 📐 Statistical aggregates

*Standard deviation* and *variance* measure how spread out values are: a small number means the prices in a group are similar; a big number means they vary a lot.

| Function | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Sample standard deviation | `STDEV(x)` | `STDDEV_SAMP(x)` |
| Population standard deviation | `STDEVP(x)` | `STDDEV_POP(x)` / `STD(x)` |
| Sample variance | `VAR(x)` | `VAR_SAMP(x)` |
| Population variance | `VARP(x)` | `VAR_POP(x)` |
| Concatenate values | `STRING_AGG(x, ',')` | `GROUP_CONCAT(x)` |
| Bitwise | *(via aggregation tricks)* | `BIT_AND`, `BIT_OR`, `BIT_XOR` |

```sql
-- ✅ MSSQL: how consistent are our product prices within each category?
SELECT category_id, AVG(unit_price) AS avg_price, STDEV(unit_price) AS price_spread
FROM products GROUP BY category_id;
```

```sql
-- ✅ MySQL: same question
SELECT category_id, AVG(unit_price) AS avg_price, STDDEV_SAMP(unit_price) AS price_spread
FROM products GROUP BY category_id;
```

## 25.3 💰 Real business questions answered with aggregates

```sql
-- ✅ Works in BOTH

-- Total revenue from completed orders
SELECT
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped');

-- Average order value
SELECT
    COUNT(DISTINCT o.order_id)                                AS orders,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount))      AS revenue,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount))
        / COUNT(DISTINCT o.order_id)                          AS avg_order_value
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped');

-- Inventory value sitting on the shelves
SELECT SUM(unit_price * units_in_stock) AS inventory_value FROM products;

-- Date range of our business
SELECT MIN(order_date) AS first_order, MAX(order_date) AS latest_order FROM orders;
```

> [!WARNING]
> ⚠️ **The `COUNT(DISTINCT o.order_id)` in that second query is essential.** Because we joined to `order_items`, an order with 3 line items appears 3 times. A plain `COUNT(*)` would count 36 "orders" instead of 17. **Whenever you join one-to-many and then count the "one" side, you need `DISTINCT`.**

## 25.4 🚫 The rule you cannot break

```sql
-- ❌ FAILS in MSSQL. Silently WRONG in MySQL without ONLY_FULL_GROUP_BY.
SELECT product_name, AVG(unit_price) FROM products;
```

> [!NOTE]
> 📌 **Why:** `AVG(unit_price)` produces **one** value for the whole table. `product_name` has **18** values. SQL cannot put 18 names next to 1 average. Every column in the `SELECT` must either be **aggregated** or **listed in `GROUP BY`**.

> [!WARNING]
> ⚠️ **Old MySQL versions allowed this and returned a random product name** — a nasty trap. Since MySQL 5.7, `ONLY_FULL_GROUP_BY` is enabled by default and it errors correctly, like every other database. **Never disable that setting.** Check yours:
> ```sql
> -- 🟦 MySQL
> SELECT @@sql_mode;
> ```

## 25.5 🎯 When to use which aggregate

| Question in plain English | Function | ⚠️ |
|---|---|---|
| "How many rows?" | `COUNT(*)` | Counts NULLs too — usually what you want |
| "How many actually have a value?" | `COUNT(column)` | Silently skips NULLs |
| "How many different ones?" | `COUNT(DISTINCT column)` | Expensive on big tables |
| "How many orders?" — after joining to items | `COUNT(DISTINCT o.order_id)` | Plain `COUNT(*)` counts **line items**, not orders |
| "What is the total?" | `SUM(column)` | Returns `NULL`, not 0, if no rows match |
| "What is the typical value?" | `AVG(column)` | Divides by the **non-NULL** count |
| "Biggest / smallest / earliest / latest" | `MAX` / `MIN` | Works on text and dates, not just numbers |
| "List them all in one cell" | `STRING_AGG` 🟥 / `GROUP_CONCAT` 🟦 | MySQL truncates at 1024 chars by default |
| "Does at least one exist?" | `EXISTS` — **not** `COUNT(*) > 0` | `EXISTS` stops at the first hit |

> [!CAUTION]
> 🐛 **Common mistake:** `SUM()` over zero matching rows returns `NULL`, not `0`. A dashboard tile then shows blank instead of "0". Wrap it: `COALESCE(SUM(amount), 0)`.

## 25.6 🧪 Try it yourself

1. Find the total, average, highest, and lowest product price in one query.
2. Count how many customers have a phone number vs how many rows exist. Explain the gap.
3. Calculate total revenue, order count, and average order value for 2026.
4. Find the value of all stock currently held, and the value of stock below its reorder level.

---

# 26. GROUP BY and HAVING

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 25 min | Summarize data per group · Filter groups with `HAVING` · Find duplicates · Avoid the three classic grouping mistakes |

> [!NOTE]
> 📌 **In plain words:** `GROUP BY` splits your rows into buckets, then runs the aggregate function **once per bucket** instead of once for the whole table.

> 🌍 **Analogy:** You have a pile of 500 receipts. `GROUP BY store_name` sorts them into piles, one per store. `SUM(amount)` then totals each pile separately. `HAVING SUM(amount) > 1000` throws away the small piles.

Several examples in this chapter use `JOIN … ON` to look up matching rows in another table (for example, each product's category name). Joins are explained fully in [Chapter 28](#28-joins-the-complete-picture) — for now, read `JOIN` as *"look up the matching row"*.

## 26.1 🪣 Basic grouping

```sql
-- ✅ Works in BOTH: how many products per category?
SELECT
    category_id,
    COUNT(*)        AS product_count,
    AVG(unit_price) AS avg_price,
    MIN(unit_price) AS cheapest,
    MAX(unit_price) AS priciest
FROM products
GROUP BY category_id
ORDER BY product_count DESC;
```

**Adding a readable name via a join:**

```sql
-- ✅ Works in BOTH
SELECT
    c.category_name,
    COUNT(*)                   AS product_count,
    ROUND(AVG(p.unit_price),2) AS avg_price
FROM products AS p
JOIN categories AS c ON c.category_id = p.category_id
GROUP BY c.category_name          -- 🟥 MSSQL: also add c.category_id if you select it
ORDER BY product_count DESC;
```

## 26.2 🧩 Grouping by multiple columns

```sql
-- ✅ Works in BOTH: one bucket per unique COMBINATION
SELECT
    country,
    loyalty_tier,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country, loyalty_tier
ORDER BY country, loyalty_tier;
```

> [!NOTE]
> 📌 **In plain words:** grouping by two columns means "one row per unique pair". `('UK','Silver')` and `('UK','Bronze')` are different buckets.

## 26.3 🗑️ HAVING — filtering the groups

```sql
-- ✅ Works in BOTH
SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 3          -- only repeat customers
ORDER BY order_count DESC;
```

**`WHERE` and `HAVING` together — each doing its own job:**

```sql
-- ✅ Works in BOTH
SELECT
    c.category_name,
    COUNT(*)                    AS product_count,
    ROUND(AVG(p.unit_price), 2) AS avg_price
FROM products p
JOIN categories c ON c.category_id = p.category_id
WHERE p.discontinued = 0         -- 🔍 filters ROWS first (cheap)
GROUP BY c.category_name
HAVING AVG(p.unit_price) > 200   -- 🗑️ then filters GROUPS
ORDER BY avg_price DESC;
```

| | `WHERE` | `HAVING` |
|---|---|---|
| Filters | Individual rows | Whole groups |
| Runs | **Before** `GROUP BY` | **After** `GROUP BY` |
| Can use aggregates | ❌ No | ✅ Yes |
| Can use `SELECT` aliases | ❌ No | 🔀 MySQL yes, MSSQL no |
| Performance | ✅ Cheap, reduces work early | More expensive |

> [!TIP]
> 💡 **Pro tip:** If a condition does not need an aggregate function, it belongs in `WHERE`. Putting `WHERE p.discontinued = 0` into `HAVING` would still give the right answer but force the engine to group rows it was going to throw away. On large tables this is a serious waste.

## 26.4 💼 Real-world grouping recipes

```sql
-- 🏆 Top 5 customers by lifetime spend
-- 🟥 MSSQL
SELECT TOP 5
    c.full_name,
    c.country,
    COUNT(DISTINCT o.order_id)                                AS orders,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS lifetime_spend
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.customer_id, c.full_name, c.country
ORDER BY lifetime_spend DESC;
```

```sql
-- 🟦 MySQL: identical, with LIMIT
SELECT
    c.full_name,
    c.country,
    COUNT(DISTINCT o.order_id)                                AS orders,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS lifetime_spend
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.customer_id, c.full_name, c.country
ORDER BY lifetime_spend DESC
LIMIT 5;
```

```sql
-- 📦 Best-selling products by units and revenue
SELECT
    p.product_name,
    SUM(oi.quantity)                                          AS units_sold,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS revenue,
    COUNT(DISTINCT oi.order_id)                               AS appeared_in_orders
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o       ON o.order_id = oi.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;
```

```sql
-- 👔 Sales performance per employee
SELECT
    CONCAT(e.first_name, ' ', e.last_name)                    AS sales_rep,
    COUNT(DISTINCT o.order_id)                                AS orders_handled,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS revenue,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount))
          / COUNT(DISTINCT o.order_id), 2)                    AS avg_order_value
FROM employees e
JOIN orders o       ON o.employee_id = e.employee_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY revenue DESC;
```

```sql
-- 🌍 Revenue by country, only countries worth reporting on
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id)                             AS customers,
    COUNT(DISTINCT o.order_id)                                AS orders,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS revenue
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.country
HAVING SUM(oi.unit_price*oi.quantity*(1-oi.discount)) > 500
ORDER BY revenue DESC;
```

```sql
-- 🔁 Find duplicate emails (the classic data-quality query)
SELECT email, COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
```

> [!TIP]
> 💡 **That last query is worth memorizing.** `GROUP BY x HAVING COUNT(*) > 1` is how you find duplicates of anything, in any table, in any database. You will use it hundreds of times.

> [!IMPORTANT]
> 🎯 **`GROUP BY` or a window function?** They answer different questions, and picking wrong is the most common source of over-complicated SQL:
>
> | You want... | Use |
> |---|---|
> | **One row per group** — "revenue per category" | `GROUP BY` |
> | **Every row, plus its group's figure** — "each product and its category average" | Window function ([Ch 33](#33-window-functions)) |
> | A filter on the group total | `GROUP BY … HAVING` |
> | A rank, running total, or previous-row comparison | Window function |
> | To collapse 1,000,000 rows into 12 | `GROUP BY` |
>
> If you find yourself joining a `GROUP BY` result back to the original table just to see the detail rows again, **you wanted a window function.**

## 26.5 🐛 The three GROUP BY mistakes

**① Forgetting a column in `GROUP BY`**

```sql
-- ❌ MSSQL: "Column 'customers.country' is invalid in the select list..."
SELECT full_name, country, COUNT(*) FROM customers GROUP BY full_name;

-- ✅ Every non-aggregated SELECT column must appear in GROUP BY
SELECT full_name, country, COUNT(*) FROM customers GROUP BY full_name, country;
```

**② Counting the wrong thing after a join**

```sql
-- ❌ Counts LINE ITEMS, not orders
SELECT c.full_name, COUNT(*) AS orders
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.full_name;

-- ✅ Counts orders
SELECT c.full_name, COUNT(DISTINCT o.order_id) AS orders
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.full_name;
```

**③ Losing rows with zero matches**

```sql
-- ❌ Customers who never ordered vanish entirely (INNER JOIN)
SELECT c.full_name, COUNT(o.order_id) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;

-- ✅ LEFT JOIN keeps them, showing 0
SELECT c.full_name, COUNT(o.order_id) AS orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name
ORDER BY orders;
```

> [!WARNING]
> ⚠️ **Note it must be `COUNT(o.order_id)`, not `COUNT(*)`, in that last query.** With a `LEFT JOIN`, a customer with no orders still produces one row (with NULLs), so `COUNT(*)` would return **1** instead of **0**. `COUNT(o.order_id)` skips the NULL and correctly returns 0. This is one of the most valuable details in this entire chapter.

## 26.6 🧪 Try it yourself

1. Count orders per status, sorted by count.
2. Find every category whose average product price exceeds 300.
3. List customers with more than 2 orders, showing their total spend.
4. Find any duplicate `product_name` values.
5. Show every customer including those with zero orders, correctly displaying 0.

---

# 27. ROLLUP, CUBE, and GROUPING SETS

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 20 min | Add subtotals and grand totals · Build cross-tab summaries · Tell a subtotal row from real data |

> [!NOTE]
> 📌 **In plain words:** These give you **subtotals and grand totals for free**, in the same query — the thing every manager asks for and every beginner does with three separate queries stitched together.

> 🌍 **Analogy:** A shop receipt. You get a line per item, a subtotal per department, and a grand total at the bottom. `ROLLUP` produces exactly that shape.

## 27.1 📊 ROLLUP — hierarchical subtotals

```sql
-- ✅ Works in BOTH (syntax differs slightly)

-- 🟥 MSSQL
SELECT
    c.country,
    c.loyalty_tier,
    COUNT(*) AS customer_count
FROM customers c
GROUP BY ROLLUP (c.country, c.loyalty_tier)
ORDER BY c.country, c.loyalty_tier;
```

```sql
-- 🟦 MySQL
SELECT
    country,
    loyalty_tier,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country, loyalty_tier WITH ROLLUP;
```

**What comes back:**

| country | loyalty_tier | customer_count | meaning |
|---|---|---|---|
| *NULL* | *NULL* | 12 | **grand total** |
| Czechia | *NULL* | 1 | **subtotal for Czechia** |
| Czechia | Bronze | 1 | detail row |
| Denmark | *NULL* | 1 | **subtotal for Denmark** |
| Denmark | Bronze | 1 | detail row |
| Germany | *NULL* | 1 | **subtotal for Germany** |
| Germany | Bronze | 1 | detail row |
| … | … | … | |
| UK | Silver | 1 | detail row |

> [!NOTE]
> 📌 **`ROLLUP` works from right to left.** It starts with the full detail `(country, tier)`, then drops the last column to make a subtotal per country `(country)`, then drops everything for one grand total `()`.

> [!WARNING]
> ⚠️ **Notice where the totals land.** Because the subtotal rows carry `NULL`, and **`NULL` sorts first in an ascending sort** ([Chapter 15](#15-null-the-value-that-is-not-there)), the grand total appears at the **top** and each country's subtotal appears **above** its detail rows — not underneath, the way a spreadsheet would show it. To get the familiar receipt layout, sort by `GROUPING()` — it returns 1 on a total row (see 27.4):
>
> ```sql
> -- 🟥 MSSQL: detail rows first, then subtotals, then the grand total
> SELECT c.country, c.loyalty_tier, COUNT(*) AS customer_count
> FROM customers c
> GROUP BY ROLLUP (c.country, c.loyalty_tier)
> ORDER BY GROUPING(c.country), c.country, GROUPING(c.loyalty_tier), c.loyalty_tier;
> ```

## 27.2 🎲 CUBE — every possible combination

```sql
-- 🟥 MSSQL only (MySQL has no CUBE)
SELECT
    c.country,
    c.loyalty_tier,
    COUNT(*) AS customer_count
FROM customers c
GROUP BY CUBE (c.country, c.loyalty_tier)
ORDER BY c.country, c.loyalty_tier;
```

`CUBE` gives you: per country+tier, **per country**, **per tier**, and the grand total. With *n* columns you get 2ⁿ combinations.

| | `ROLLUP` | `CUBE` |
|---|---|---|
| Combinations for (a, b) | `(a,b)`, `(a)`, `()` | `(a,b)`, `(a)`, `(b)`, `()` |
| Use for | Things that nest: country → city; year → month | Summaries where every combination of columns matters |
| MySQL support | ✅ `WITH ROLLUP` | ❌ Not supported |

## 27.3 🎛️ GROUPING SETS — exactly the totals you want

```sql
-- 🟥 MSSQL only
SELECT
    c.country,
    c.loyalty_tier,
    COUNT(*) AS customer_count
FROM customers c
GROUP BY GROUPING SETS (
    (c.country, c.loyalty_tier),   -- detail
    (c.country),                   -- per country
    ()                             -- grand total
)
ORDER BY c.country, c.loyalty_tier;
```

> [!TIP]
> 💡 **`GROUPING SETS` is the most precise of the three.** `ROLLUP` and `CUBE` are just shorthand for particular grouping sets. Use it when you want, say, totals by country and totals by tier but *not* the combination.

## 27.4 🏷️ Telling a subtotal NULL from a real NULL

A genuine problem: if `city` can be NULL in your data, how do you know whether a NULL in the result is a real NULL or a `ROLLUP` subtotal marker?

```sql
-- 🟥 MSSQL: GROUPING() returns 1 for a subtotal row
SELECT
    CASE WHEN GROUPING(c.country) = 1 THEN 'ALL COUNTRIES' ELSE c.country END      AS country,
    CASE WHEN GROUPING(c.loyalty_tier) = 1 THEN 'All tiers' ELSE c.loyalty_tier END AS tier,
    COUNT(*) AS customer_count
FROM customers c
GROUP BY ROLLUP (c.country, c.loyalty_tier);
```

```sql
-- 🟦 MySQL: GROUPING() exists from 8.0
SELECT
    IF(GROUPING(country) = 1, 'ALL COUNTRIES', country) AS country_label,   -- not "AS country": that makes GROUP BY country ambiguous
    IF(GROUPING(loyalty_tier) = 1, 'All tiers', loyalty_tier) AS tier_label,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country, loyalty_tier WITH ROLLUP;
```

## 27.5 💼 A real management report

```sql
-- ✅ Monthly revenue with a yearly total — the classic finance request
-- 🟥 MSSQL
SELECT
    CASE WHEN GROUPING(YEAR(o.order_date))  = 1 THEN 'ALL YEARS'
         ELSE CAST(YEAR(o.order_date) AS VARCHAR(4)) END      AS yr,
    CASE WHEN GROUPING(MONTH(o.order_date)) = 1 THEN 'Full year'
         ELSE CAST(MONTH(o.order_date) AS VARCHAR(2)) END     AS mth,
    COUNT(DISTINCT o.order_id)                                AS orders,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2)  AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY ROLLUP (YEAR(o.order_date), MONTH(o.order_date))
ORDER BY yr, mth;
```

> [!WARNING]
> ⚠️ **`WITH ROLLUP` in MySQL cannot be combined with `ORDER BY` in older versions**, and the subtotal rows always sort with their NULLs. If ordering matters, wrap the whole query in a subquery inside `FROM` (a *derived table*, Chapter 30) and sort outside it.

## 27.6 🧪 Try it yourself

1. Produce a customer count by country with a grand total.
2. In MSSQL, use `CUBE` on `(country, loyalty_tier)` and count how many rows come back. Explain the number.
3. Build a revenue report grouped by category with a grand total, labelling the total row clearly.
4. Use `GROUPING SETS` (MSSQL) to get totals by country **and** by tier, but not the combination.

---
# 🔗 PART 6 — COMBINING TABLES

---

# 28. JOINs, the complete picture

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 40 min | Combine tables with inner, left, full, cross, and self joins · Find rows with no match · Avoid the traps that silently break reports |

> [!NOTE]
> 📌 **In plain words:** A `JOIN` sticks two tables together side by side, matching rows using a shared value. It is the single most important skill in SQL, and the one most people half-learn.

> 🌍 **Analogy:** You have a **guest list** (customers) and a **stack of RSVP cards** (orders). Joining them means laying each RSVP card next to the matching guest's name. What you do with guests who never RSVP'd — and RSVPs from people not on the list — is exactly what distinguishes the join types.

## 28.1 🎨 The join types at a glance

```text
   customers          orders
   ┌───────┐        ┌───────┐
   │   A   │        │       │
   │  ┌────┼────────┼───┐   │
   │  │  B (matches) │   │   │
   │  └────┼────────┼───┘   │
   │       │        │   C   │
   └───────┘        └───────┘

 INNER JOIN  → B only            (customers WITH orders)
 LEFT JOIN   → A + B             (ALL customers, orders where they exist)
 RIGHT JOIN  → B + C             (ALL orders, customers where they exist)
 FULL JOIN   → A + B + C         (everything from both sides)
 CROSS JOIN  → every A × every C (all combinations, no condition)
```

| Join | Keeps | Real-world question it answers |
|---|---|---|
| `INNER JOIN` | Only matching rows from both | "Show orders with their customer details" |
| `LEFT JOIN` | All left rows + matches | "Show all customers, including those who never ordered" |
| `RIGHT JOIN` | All right rows + matches | Same as LEFT, tables swapped (rarely used) |
| `FULL OUTER JOIN` | Everything from both sides | "Compare two lists and show what is missing from each" |
| `CROSS JOIN` | Every combination | "Generate a date × product grid for a report" |
| `SELF JOIN` | A table joined to itself | "Show each employee with their manager" |

## 28.2 🎯 INNER JOIN — the workhorse

```sql
-- ✅ Works in BOTH
SELECT
    o.order_id,
    o.order_date,
    c.full_name,
    c.country
FROM orders AS o
INNER JOIN customers AS c ON c.customer_id = o.customer_id
ORDER BY o.order_date;
```

> [!NOTE]
> 📌 **Reading it out loud:** *"Take orders. For each one, find the customer whose `customer_id` matches. If there is no match, drop the order."*

**The keyword `INNER` is optional** — `JOIN` alone means `INNER JOIN`. Write `INNER` anyway; explicit is better.

**Joining three or more tables** — just keep chaining:

```sql
-- ✅ Works in BOTH: the full picture of one order
SELECT
    o.order_id,
    o.order_date,
    c.full_name       AS customer,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    CAST(oi.unit_price * oi.quantity * (1 - oi.discount) AS DECIMAL(12,2)) AS line_total
FROM orders AS o
INNER JOIN customers   AS c  ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON oi.order_id   = o.order_id
INNER JOIN products    AS p  ON p.product_id  = oi.product_id
WHERE o.order_id = 1002
ORDER BY p.product_name;
```

**Result:**

| order_id | order_date | customer | product_name | quantity | unit_price | line_total |
|---|---|---|---|---|---|---|
| 1002 | 2026-01-18 | Mei Chen | MechKey RGB Keyboard | 1 | 129.00 | 129.00 |
| 1002 | 2026-01-18 | Mei Chen | VisionPanel 32 4K | 2 | 749.00 | 1423.10 |
| 1002 | 2026-01-18 | Mei Chen | WorkStation X17 | 1 | 2450.00 | 2205.00 |

> [!WARNING]
> ⚠️ **Why `CAST` rather than `ROUND` here?** `ROUND` changes the *value*, but not how many decimal places the result is shown with. Multiplying `DECIMAL(10,2) × INT × DECIMAL(4,3)` gives a result with many decimal places, so `ROUND(..., 2)` can still display `129.00000`. `CAST(... AS DECIMAL(12,2))` also fixes the display to exactly 2 places. Use `ROUND` for maths, `CAST` for what people see.

> [!TIP]
> 💡 **Pro tip on join direction:** Write the `ON` condition consistently — `ON child.parent_id = parent.parent_id`. Pick a direction and never vary it. Consistency makes complex joins scannable at a glance.

## 28.3 ⬅️ LEFT JOIN — keeping everything on the left

```sql
-- ✅ Works in BOTH: EVERY customer, whether or not they ordered
SELECT
    c.full_name,
    c.country,
    o.order_id,
    o.order_date
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
ORDER BY c.full_name;
```

Customers with no orders still appear — with `NULL` in every `orders` column.

**The most valuable use of `LEFT JOIN`: finding what is missing.**

```sql
-- ✅ Works in BOTH: the "anti-join" pattern
-- Which customers have NEVER placed an order?
SELECT c.customer_id, c.full_name, c.email, c.signup_date
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;           -- 🔑 the magic line
```

> [!NOTE]
> 📌 **Why `WHERE o.order_id IS NULL` works:** the `LEFT JOIN` gives every customer a row. Customers *with* orders get real values; customers *without* get NULLs. Filtering for NULL keeps exactly the non-matching ones. This is called an **anti-join**, and it answers a huge family of business questions:
>
> - Products never sold
> - Orders with no payment recorded
> - Employees with no assigned orders
> - Users who signed up but never activated

```sql
-- Products that have never been ordered
SELECT p.product_id, p.product_name, p.unit_price
FROM products AS p
LEFT JOIN order_items AS oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

-- Orders with no payment on file — a genuine finance red flag
SELECT o.order_id, o.order_date, o.status
FROM orders AS o
LEFT JOIN payments AS pay ON pay.order_id = o.order_id
WHERE pay.payment_id IS NULL;
```

## 28.4 🚨 The LEFT JOIN trap that silently breaks reports

```sql
-- ❌ This is secretly an INNER JOIN!
SELECT c.full_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered';
```

> [!WARNING]
> ⚠️ **What went wrong:** the `LEFT JOIN` correctly gives non-ordering customers a row full of NULLs. Then `WHERE o.status = 'Delivered'` evaluates `NULL = 'Delivered'`, which is `UNKNOWN`, and the row is discarded. **Your `LEFT JOIN` has been silently downgraded to an `INNER JOIN`.**

```sql
-- ✅ FIX: put the condition in the ON clause instead
SELECT c.full_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
   AND o.status = 'Delivered';        -- filters WHICH rows match, not which survive
```

> [!TIP]
> 💡 **The rule:** In a `LEFT JOIN`, conditions on the **right-hand table** belong in `ON`. Conditions on the **left-hand table** belong in `WHERE`. Get this backwards and your report quietly loses rows — the worst kind of bug, because it produces plausible wrong numbers instead of an error.

## 28.5 ➡️ RIGHT and FULL OUTER JOIN

```sql
-- RIGHT JOIN: all orders, plus customer info where it exists
SELECT c.full_name, o.order_id
FROM customers AS c
RIGHT JOIN orders AS o ON o.customer_id = c.customer_id;

-- Identical result, and far easier to read:
SELECT c.full_name, o.order_id
FROM orders AS o
LEFT JOIN customers AS c ON c.customer_id = o.customer_id;
```

> [!TIP]
> 💡 **Professional convention: never use `RIGHT JOIN`.** Every `RIGHT JOIN` can be rewritten as a `LEFT JOIN` by swapping the tables, and reading a query is much easier when all the joins flow the same direction. Many style guides ban it outright.

```sql
-- 🟥 MSSQL: FULL OUTER JOIN is supported
SELECT
    c.customer_id,
    c.full_name,
    o.order_id
FROM customers AS c
FULL OUTER JOIN orders AS o ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL OR o.order_id IS NULL;   -- show only the mismatches
```

```sql
-- 🟦 MySQL has NO FULL OUTER JOIN. Build it from two joins glued together with UNION (Chapter 29):
SELECT c.customer_id, c.full_name, o.order_id
FROM customers c LEFT JOIN orders o ON o.customer_id = c.customer_id
UNION
SELECT c.customer_id, c.full_name, o.order_id
FROM customers c RIGHT JOIN orders o ON o.customer_id = c.customer_id;
```

> [!IMPORTANT]
> 🎯 **When you actually need `FULL OUTER JOIN`:** comparing two lists that should match. "Show me every product in our catalogue and every product in the supplier feed, flagging the ones that appear in only one of them."

## 28.6 ✖️ CROSS JOIN — every combination

```sql
-- ✅ Works in BOTH: 6 categories × 5 suppliers = 30 rows
SELECT c.category_name, s.company_name
FROM categories AS c
CROSS JOIN suppliers AS s;
```

> [!WARNING]
> ⚠️ **A `CROSS JOIN` on two million-row tables produces a trillion rows** and will take your server down. It is almost always an accident — see the next section.

> [!IMPORTANT]
> 🎯 **When it is genuinely useful:** building a complete grid so your report has no gaps.

```sql
-- ✅ Real-world: a sales matrix with a row for EVERY category in EVERY month,
--    showing 0 where there were no sales (instead of missing rows)
SELECT
    c.category_name,
    m.month_num,
    COALESCE(SUM(oi.quantity), 0) AS units_sold
FROM categories AS c
CROSS JOIN (
    SELECT 1 AS month_num UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
) AS m
LEFT JOIN products    AS p  ON p.category_id = c.category_id
LEFT JOIN order_items AS oi ON oi.product_id = p.product_id
LEFT JOIN orders      AS o  ON o.order_id = oi.order_id
                           AND MONTH(o.order_date) = m.month_num
                           AND YEAR(o.order_date) = 2026
GROUP BY c.category_name, m.month_num
ORDER BY c.category_name, m.month_num;
```

> [!TIP]
> 💡 **This "cross join to fill the gaps" pattern is essential for charts.** Without it, a month with no sales simply does not appear, and your line chart draws a straight line across the gap instead of dropping to zero.

## 28.7 🪞 SELF JOIN — a table joined to itself

```sql
-- ✅ Works in BOTH: every employee with their manager's name
SELECT
    CONCAT(e.first_name, ' ', e.last_name)   AS employee,
    e.title,
    CONCAT(m.first_name, ' ', m.last_name)   AS manager,
    m.title                                  AS manager_title
FROM employees AS e
LEFT JOIN employees AS m ON m.employee_id = e.manager_id
ORDER BY manager, employee;
```

> [!NOTE]
> 📌 **The `LEFT JOIN` matters here.** Sarah Mitchell (the CEO) has `manager_id = NULL`. With an `INNER JOIN` she would vanish from the organization chart entirely.

```sql
-- ✅ Find pairs: customers in the same city
SELECT
    a.full_name AS customer_a,
    b.full_name AS customer_b,
    a.city
FROM customers AS a
INNER JOIN customers AS b
    ON b.city = a.city
   AND b.customer_id > a.customer_id     -- 🔑 avoids self-pairs AND mirror duplicates
ORDER BY a.city;
```

> [!TIP]
> 💡 **The `b.customer_id > a.customer_id` trick.** Without it you get every customer paired with themselves, plus both (A,B) and (B,A). The greater-than comparison gives you each unordered pair exactly once. Memorize this; it appears in every "find pairs" problem.

```sql
-- ✅ Real-world: find products priced within 5% of each other (possible duplicates)
SELECT
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    p1.unit_price, p2.unit_price
FROM products p1
JOIN products p2
    ON p2.product_id > p1.product_id
   AND p2.category_id = p1.category_id
   AND ABS(p1.unit_price - p2.unit_price) / p1.unit_price < 0.05;
```

## 28.8 💥 The accidental CROSS JOIN and row multiplication

**Mistake 1 — forgetting the `ON` clause:**

```sql
-- ❌ 12 customers × 23 orders = 276 nonsense rows
SELECT c.full_name, o.order_id FROM customers c, orders o;

-- ✅ Always use explicit JOIN syntax, which forces you to write ON
SELECT c.full_name, o.order_id
FROM customers c
INNER JOIN orders o ON o.customer_id = c.customer_id;
```

> [!TIP]
> 💡 **This is why the old comma-join syntax (`FROM a, b WHERE ...`) is banned in modern style guides.** Explicit `JOIN ... ON` makes the missing condition a syntax error instead of a silent disaster.

**Mistake 2 — *fan-out*: rows multiplying when you join two "many" tables at once:**

```sql
-- ❌ WRONG: revenue is multiplied by the number of payments per order
SELECT
    o.order_id,
    SUM(oi.unit_price * oi.quantity) AS revenue,   -- inflated!
    SUM(pay.amount)                  AS paid       -- also inflated!
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN payments   pay ON pay.order_id = o.order_id
GROUP BY o.order_id;
```

> [!WARNING]
> ⚠️ **What happened:** order 1002 has 3 items and 1 payment → 3 rows. If it had 3 items and 2 payments → **6 rows**. Every item is counted twice and every payment three times. Your revenue report is now wrong, and it looks plausible.

```sql
-- ✅ FIX: aggregate each side separately, then join the results
SELECT
    o.order_id,
    items.revenue,
    pays.paid
FROM orders o
LEFT JOIN (
    SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS revenue
    FROM order_items GROUP BY order_id
) AS items ON items.order_id = o.order_id
LEFT JOIN (
    SELECT order_id, SUM(amount) AS paid
    FROM payments WHERE status = 'Captured' GROUP BY order_id
) AS pays ON pays.order_id = o.order_id;
```

> [!TIP]
> 💡 **The rule: never join two separate one-to-many children in the same query and aggregate.** First total up each "many" table to one row per order, then join those totals. This single insight prevents more wrong reports than any other in this guide.

## 28.9 ⚙️ How joins are executed (and why it matters)

Behind the scenes, the database chooses one of three ways to match rows. You never write these yourself — but the names appear when a join is slow (Chapter 47):

| Method | How it works | Best when | Warning sign |
|---|---|---|---|
| **Nested Loops** | For each row on the left, look up its matches on the right | One side is small, and the join column has an index | Slow if both sides are large |
| **Hash Join** | Build a quick lookup list from the smaller table, then check every row of the larger one against it | Both sides are large and there is no useful index | Uses lots of memory; may overflow onto slow disk |
| **Merge Join** | Walk through both tables side by side, already in the same sorted order | Both sides are already sorted (indexed) | Needs an extra sort if they are not |

> [!TIP]
> 💡 **What you control:** you cannot choose the algorithm (and should not try), but you strongly influence it by **indexing your join columns**. A foreign key column with no index is the number-one cause of slow joins in real systems. MySQL creates an index on FK columns automatically; **MSSQL does not** — you must create it yourself.

```sql
-- ✅ 🟥 MSSQL: index every foreign key column. Do this on day one.
--    (MySQL/InnoDB created these indexes for you automatically.)
CREATE INDEX ix_orders_customer_id   ON orders(customer_id);
CREATE INDEX ix_orders_employee_id   ON orders(employee_id);
CREATE INDEX ix_order_items_product  ON order_items(product_id);
CREATE INDEX ix_products_category_id ON products(category_id);
CREATE INDEX ix_payments_order_id    ON payments(order_id);
```

## 28.10 🧪 Try it yourself

1. List every order with its customer name, sales rep name, and item count.
2. Find every product that has never been sold.
3. Find every customer who has ordered but never had a captured payment.
4. Build the org chart: every employee with their manager, including the CEO.
5. Deliberately write the `LEFT JOIN` + `WHERE` trap, observe the row count drop, then fix it by moving the condition into `ON`.
6. Write the fan-out mistake from 28.8 and prove the revenue is inflated by comparing against the correct version.

---

# 29. Set operators: UNION, INTERSECT, EXCEPT

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 15 min | Stack results with `UNION` · Find rows in both lists, or in only one · Compare two tables for differences |

> [!NOTE]
> 📌 **In plain words:** Joins glue tables together **side by side** (more columns). Set operators stack result sets **on top of each other** (more rows).

> 🌍 **Analogy:** A join is **taping two sheets of paper edge to edge** to make a wider page. A union is **stacking two sheets in the same pile**.

## 29.1 📚 The rules every set operator obeys

1. Every query must have the **same number of columns**.
2. Matching columns must have **compatible data types** (numbers with numbers, text with text).
3. The **first query's column names** become the result's column names.
4. `ORDER BY` appears **only once, at the very end**.

## 29.2 ➕ UNION and UNION ALL

```sql
-- ✅ Works in BOTH: UNION removes duplicates
SELECT city FROM customers
UNION
SELECT shipping_city FROM orders
ORDER BY city;

-- ✅ UNION ALL keeps everything, including duplicates
SELECT city FROM customers
UNION ALL
SELECT shipping_city FROM orders;
```

| | `UNION` | `UNION ALL` |
|---|---|---|
| Removes duplicates | ✅ Yes | ❌ No |
| Speed | 🐢 Slower (it must find and remove duplicates) | 🚀 Fast |
| Use when | You genuinely need distinct rows | You know there are no duplicates, or you want them |

> [!TIP]
> 💡 **Default to `UNION ALL`.** Most of the time you know the two sets cannot overlap — for example, combining this year's orders table with last year's archive. Using plain `UNION` forces an expensive hunt for duplicates for no benefit. Only reach for `UNION` when duplicates are genuinely possible and unwanted.

**A real-world use: combining live and archived data.**

```sql
-- ✅ Works in BOTH (orders_archive is the table created in Chapter 12.3)
SELECT order_id, customer_id, order_date, status, 'live' AS source
FROM orders
WHERE order_date >= '2026-01-01'

UNION ALL

SELECT order_id, customer_id, order_date, status, 'archive' AS source
FROM orders_archive
WHERE order_date < '2026-01-01'

ORDER BY order_date DESC;
```

> [!TIP]
> 💡 **Note the literal `'live'` / `'archive'` column.** Tagging each branch tells you which source a row came from — invaluable when debugging a union that returns unexpected rows.

**Another real use: building a unified contact list.**

```sql
SELECT full_name AS name, email, 'Customer' AS person_type FROM customers
UNION ALL
SELECT CONCAT(first_name,' ',last_name),
       CONCAT(LOWER(first_name),'.',LOWER(last_name),'@shopdb.com'),
       'Employee'
FROM employees
ORDER BY person_type, name;
```

## 29.3 ∩ INTERSECT — rows in both

```sql
-- 🟥 MSSQL: supported natively
SELECT city FROM customers
INTERSECT
SELECT shipping_city FROM orders;
```

```sql
-- 🟦 MySQL 8.0.31+: INTERSECT is supported
-- Older MySQL: imitate it with an inner join or IN
SELECT DISTINCT c.city
FROM customers c
WHERE c.city IN (SELECT shipping_city FROM orders);
```

## 29.4 ➖ EXCEPT / MINUS — rows in the first but not the second

```sql
-- 🟥 MSSQL: EXCEPT
-- Which customer cities have never been used as a shipping city?
SELECT city FROM customers
EXCEPT
SELECT shipping_city FROM orders;
```

```sql
-- 🟦 MySQL 8.0.31+: EXCEPT is supported
-- Older MySQL: imitate it with NOT EXISTS
SELECT DISTINCT c.city
FROM customers c
WHERE c.city IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM orders o WHERE o.shipping_city = c.city);
```

> [!TIP]
> 💡 **`EXCEPT` is a fantastic data-comparison tool.** To check whether two tables hold identical data, run `EXCEPT` in both directions. If both return zero rows, the tables match exactly:
> ```sql
> -- ✅ Works in BOTH (MySQL 8.0.31+) — products_backup_2026_09 is the copy made in Chapter 8.4
> SELECT * FROM products EXCEPT SELECT * FROM products_backup_2026_09;   -- in A not B
> SELECT * FROM products_backup_2026_09 EXCEPT SELECT * FROM products;   -- in B not A
> ```
> This is how experienced engineers check, in 10 seconds, that data was copied correctly.

## 29.5 🔀 Support and precedence

| Operator | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| `UNION` | ✅ | ✅ |
| `UNION ALL` | ✅ | ✅ |
| `INTERSECT` | ✅ | ✅ 8.0.31+ |
| `EXCEPT` | ✅ | ✅ 8.0.31+ (called `EXCEPT`, not `MINUS`) |

> [!WARNING]
> ⚠️ **Order of evaluation:** SQL works out `INTERSECT` before `UNION` and `EXCEPT`. When mixing them, use parentheses to make your intent explicit and unambiguous.

> [!WARNING]
> ⚠️ **`ORDER BY` goes at the very end and applies to the whole result**, not to an individual branch. If you need to limit one branch, wrap that branch in a subquery inside `FROM` (a *derived table*, Chapter 30).

```sql
-- 🟥 MSSQL: limiting inside a branch
SELECT * FROM (
    SELECT TOP 5 product_name, unit_price FROM products ORDER BY unit_price DESC
) AS expensive
UNION ALL
SELECT * FROM (
    SELECT TOP 5 product_name, unit_price FROM products ORDER BY unit_price ASC
) AS cheap;
```

```sql
-- 🟦 MySQL: the same, with LIMIT inside each branch
SELECT * FROM (
    SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 5
) AS expensive
UNION ALL
SELECT * FROM (
    SELECT product_name, unit_price FROM products ORDER BY unit_price ASC LIMIT 5
) AS cheap;
```

## 29.6 🧪 Try it yourself

1. Build one list of every city that appears either as a customer city or a shipping city.
2. Find the cities that appear in both.
3. Find customer cities that have never been shipped to.
4. Create a unified "people" list of customers and employees with a type column.
5. Verify that `products` and a backup copy contain identical data using `EXCEPT` both ways.

---
# 30. Subqueries and EXISTS

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 30 min | Put a query inside a query · Check whether related rows exist · Build step-by-step calculations inside `FROM` |

> [!NOTE]
> 📌 **In plain words:** A subquery is a query **inside** another query. The inner one runs first (conceptually) and its result feeds the outer one.

> 🌍 **Analogy:** *"Give me every product that costs more than the average."* You cannot answer that in one step — you must first work out the average (inner query), then compare (outer query). A subquery is that two-step thought written as one statement.

## 30.1 🔢 Scalar subqueries — returning one single value

```sql
-- ✅ Works in BOTH: products priced above the overall average
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;
```

```sql
-- A scalar subquery in the SELECT list
SELECT
    product_name,
    unit_price,
    (SELECT AVG(unit_price) FROM products)                       AS catalog_avg,
    ROUND(unit_price - (SELECT AVG(unit_price) FROM products), 2) AS diff_from_avg
FROM products
ORDER BY diff_from_avg DESC;
```

> [!WARNING]
> ⚠️ **A scalar subquery must return exactly one row and one column.** If it returns more, you get *"Subquery returned more than 1 value"* (MSSQL) or *"Subquery returns more than 1 row"* (MySQL).

## 30.2 📋 Multi-row subqueries: IN, ANY, ALL

```sql
-- ✅ Works in BOTH

-- Customers who have placed at least one order
SELECT full_name FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Products more expensive than EVERY product in category 4
SELECT product_name, unit_price FROM products
WHERE unit_price > ALL (SELECT unit_price FROM products WHERE category_id = 4);

-- Products more expensive than AT LEAST ONE product in category 1
SELECT product_name, unit_price FROM products
WHERE unit_price > ANY (SELECT unit_price FROM products WHERE category_id = 1);
```

| Operator | Meaning |
|---|---|
| `IN (…)` | Matches any value in the set |
| `> ALL (…)` | Greater than the **maximum** of the set |
| `< ALL (…)` | Less than the **minimum** of the set |
| `> ANY (…)` | Greater than the **minimum** (i.e. at least one) |
| `= ANY (…)` | Identical to `IN` |

> [!WARNING]
> ⚠️ **Remember the `NOT IN` + NULL trap from [Chapter 14](#14-where-asking-precise-questions).** `NOT IN` with a subquery that can return NULL silently returns zero rows. Use `NOT EXISTS`.

## 30.3 🔗 Correlated subqueries — the inner query depends on the outer

```sql
-- ✅ Works in BOTH: each product compared to ITS OWN category's average
SELECT
    p.product_name,
    p.unit_price,
    p.category_id,
    (SELECT AVG(p2.unit_price)
     FROM products p2
     WHERE p2.category_id = p.category_id) AS category_avg      -- 🔑 references p
FROM products AS p
WHERE p.unit_price > (
    SELECT AVG(p2.unit_price)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY p.category_id;
```

> [!NOTE]
> 📌 **The difference:** a plain subquery runs **once**. A correlated subquery references a column from the outer query (`p.category_id`), so conceptually it runs **once per outer row**. That makes it powerful and potentially slow.

```sql
-- ✅ Real-world: each customer with their most recent order date
SELECT
    c.full_name,
    (SELECT MAX(o.order_date) FROM orders o WHERE o.customer_id = c.customer_id) AS last_order,
    (SELECT COUNT(*)          FROM orders o WHERE o.customer_id = c.customer_id) AS order_count
FROM customers AS c
ORDER BY last_order DESC;
```

> [!TIP]
> 💡 **When there are several correlated subqueries against the same table, rewrite as a `LEFT JOIN` with `GROUP BY`.** The version above scans `orders` twice per customer; the join version scans it once, total:
> ```sql
> SELECT c.full_name, MAX(o.order_date) AS last_order, COUNT(o.order_id) AS order_count
> FROM customers c
> LEFT JOIN orders o ON o.customer_id = c.customer_id
> GROUP BY c.customer_id, c.full_name;
> ```

## 30.4 ✅ EXISTS and NOT EXISTS — the professional's choice

```sql
-- ✅ Works in BOTH: customers who HAVE ordered
SELECT c.full_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

-- Customers who have NEVER ordered
SELECT c.full_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);
```

> [!NOTE]
> 📌 **`EXISTS` asks a yes/no question:** *"Does at least one matching row exist?"* It stops looking the instant it finds one — it does not count, collect, or return anything. That early stop is why it is usually the fastest option.

> [!TIP]
> 💡 **`SELECT 1` inside `EXISTS` is convention, not requirement.** The engine ignores the select list entirely; `SELECT *`, `SELECT 1`, and `SELECT customer_id` all produce identical plans. `SELECT 1` simply signals your intent to the reader.

**The three ways to ask "does a related row exist", compared:**

| Approach | NULL-safe | Typical speed | Readability |
|---|---|---|---|
| `EXISTS` / `NOT EXISTS` | ✅ Always | ⚡ Usually best | ✅ Clear intent |
| `IN` / `NOT IN` | ⚠️ `NOT IN` breaks on NULL | Good for small lists | ✅ Very readable |
| `LEFT JOIN ... IS NULL` | ✅ Safe | Good, but can multiply rows | ⚠️ Needs a comment |

```sql
-- Real-world: which products have sold in the last 3 months?
SELECT p.product_name, p.unit_price
FROM products AS p
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    WHERE oi.product_id = p.product_id
      AND o.order_date >= '2026-06-01'
);
```

## 30.5 🪆 Derived tables — a subquery in the FROM clause

```sql
-- ✅ Works in BOTH
SELECT
    band.price_band,
    COUNT(*) AS product_count
FROM (
    SELECT
        product_id,
        CASE
            WHEN unit_price >= 1000 THEN 'Premium'
            WHEN unit_price >=  300 THEN 'Mid'
            ELSE 'Budget'
        END AS price_band
    FROM products
) AS band
GROUP BY band.price_band;
```

> [!WARNING]
> ⚠️ **A derived table must have an alias** (`AS band`). MySQL and MSSQL both refuse it otherwise — MySQL says *"Every derived table must have its own alias."*

```sql
-- ✅ Real-world: customers who spend above the company-wide average
SELECT
    spend.full_name,
    spend.total_spend
FROM (
    SELECT
        c.customer_id,
        c.full_name,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total_spend
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY c.customer_id, c.full_name
) AS spend
WHERE spend.total_spend > (
    SELECT AVG(t.total)
    FROM (
        SELECT o.customer_id, SUM(oi.unit_price*oi.quantity*(1-oi.discount)) AS total
        FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
        WHERE o.status IN ('Delivered','Shipped')
        GROUP BY o.customer_id
    ) AS t
)
ORDER BY spend.total_spend DESC;
```

> [!TIP]
> 💡 **That query is correct but hard to read** — the same calculation appears twice. This is precisely the problem CTEs solve. See the next chapter.

## 30.6 ⚡ Subquery performance

| Pattern | Guidance |
|---|---|
| Scalar subquery in `SELECT` that does not use the outer row | ✅ Fine — runs once |
| Scalar subquery in `SELECT` that uses the outer row (correlated) | ⚠️ Runs once per row; consider a join |
| `IN` with a small constant list | ✅ Fine |
| `IN` with a large subquery | ⚠️ Consider `EXISTS` or a join |
| `NOT IN` on a column that can be NULL | 🚫 Use `NOT EXISTS` instead |
| `EXISTS` | ✅ Generally the best choice for existence checks |
| Derived table used twice | ⚠️ Use a CTE or a temporary table so it is worked out once |

> [!TIP]
> 💡 **Modern optimizers often rewrite subqueries into joins automatically**, so the difference is smaller than people often claim. But "often" is not "always" — check the execution plan rather than trusting a rule of thumb. See [Chapter 47](#47-execution-plans).

## 30.7 🧪 Try it yourself

1. Find products priced above their own category's average.
2. Find customers who have ordered from more than one category.
3. Rewrite "customers who never ordered" three ways: `NOT EXISTS`, `NOT IN`, and `LEFT JOIN ... IS NULL`. Compare the plans.
4. Find the single most expensive product in each category using a correlated subquery.

---

# 31. CTEs and recursive queries

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 30 min | Write readable step-by-step queries with `WITH` · Walk hierarchies like an org chart · Generate a list of dates for reports |

> [!NOTE]
> 📌 **In plain words:** A **CTE** (Common Table Expression) is a named temporary result you define at the top of your query with `WITH`, then use like a table. It turns an unreadable nest of subqueries into a readable sequence of steps.

> 🌍 **Analogy:** A recipe. Instead of one impossible sentence — *"combine the thing you get from beating eggs with the thing you get from sifting flour mixed with the thing from melting butter"* — you write numbered steps, each with a name. CTEs are those named steps.

## 31.1 ✍️ Basic CTE syntax

```sql
-- ✅ Works in BOTH (MySQL 8.0+)
WITH customer_spend AS (
    SELECT
        c.customer_id,
        c.full_name,
        c.country,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total_spend
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY c.customer_id, c.full_name, c.country
)
SELECT *
FROM customer_spend
WHERE total_spend > (SELECT AVG(total_spend) FROM customer_spend)
ORDER BY total_spend DESC;
```

> [!NOTE]
> 📌 **Compare that to the double-nested version at the end of [Chapter 30](#30-subqueries-and-exists).** Same result, but the aggregation is written **once** and given a meaningful name. That is the whole value of a CTE.

## 31.2 🔗 Multiple CTEs — a readable pipeline

```sql
-- ✅ Works in BOTH: a genuine business report built in clear stages
WITH order_totals AS (
    -- Step 1: what is each order worth?
    SELECT
        oi.order_id,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS order_value
    FROM order_items oi
    GROUP BY oi.order_id
),
customer_stats AS (
    -- Step 2: roll those up per customer
    SELECT
        c.customer_id,
        c.full_name,
        c.country,
        c.loyalty_tier,
        COUNT(o.order_id)      AS order_count,
        SUM(ot.order_value)    AS lifetime_value,
        AVG(ot.order_value)    AS avg_order_value,
        MAX(o.order_date)      AS last_order_date
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_totals ot ON ot.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY c.customer_id, c.full_name, c.country, c.loyalty_tier
),
ranked AS (
    -- Step 3: classify them
    SELECT
        cs.*,
        CASE
            WHEN cs.lifetime_value >= 3000 THEN 'VIP'
            WHEN cs.lifetime_value >= 1000 THEN 'Valued'
            ELSE 'Standard'
        END AS segment
    FROM customer_stats cs
)
-- Step 4: the final answer
SELECT
    segment,
    COUNT(*)                    AS customers,
    ROUND(AVG(lifetime_value),2) AS avg_ltv,       -- ltv = lifetime value
    ROUND(SUM(lifetime_value),2) AS segment_revenue
FROM ranked
GROUP BY segment
ORDER BY segment_revenue DESC;
```

> [!TIP]
> 💡 **Read that query top to bottom and it explains itself.** Written as nested subqueries it would be roughly 40 lines of parentheses that nobody could safely modify. **CTEs are mainly a way to make SQL easier to read and to change** — and readable SQL is SQL that gets fixed correctly at 2 a.m.

## 31.3 🔁 Recursive CTEs — querying hierarchies

This is the feature that makes CTEs genuinely irreplaceable. A **recursive** query uses its own results to find the next level, step by step, until nothing new turns up. That lets it walk any tree of parent–child links: an organization chart, categories inside categories, folders inside folders, parts inside products.

```sql
-- ✅ Works in BOTH (MySQL 8.0+ needs the RECURSIVE keyword)

-- 🟥 MSSQL
WITH org_chart AS (
    -- ⚓ ANCHOR: the starting point (the CEO, who has no manager)
    SELECT
        employee_id,
        first_name,
        last_name,
        title,
        manager_id,
        0 AS level,
        CAST(first_name + ' ' + last_name AS VARCHAR(500)) AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- 🔁 RECURSIVE MEMBER: everyone who reports to someone already found
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.title,
        e.manager_id,
        oc.level + 1,
        CAST(oc.path + ' > ' + e.first_name + ' ' + e.last_name AS VARCHAR(500))
    FROM employees e
    INNER JOIN org_chart oc ON oc.employee_id = e.manager_id
)
SELECT
    REPLICATE('    ', level) + first_name + ' ' + last_name AS org_tree,
    title,
    level,
    path
FROM org_chart
ORDER BY path;
```

```sql
-- 🟦 MySQL 8.0+
WITH RECURSIVE org_chart AS (
    SELECT
        employee_id, first_name, last_name, title, manager_id,
        0 AS level,
        CAST(CONCAT(first_name, ' ', last_name) AS CHAR(500)) AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id, e.first_name, e.last_name, e.title, e.manager_id,
        oc.level + 1,
        CAST(CONCAT(oc.path, ' > ', e.first_name, ' ', e.last_name) AS CHAR(500))
    FROM employees e
    INNER JOIN org_chart oc ON oc.employee_id = e.manager_id
)
SELECT
    CONCAT(REPEAT('    ', level), first_name, ' ', last_name) AS org_tree,
    title, level, path
FROM org_chart
ORDER BY path;
```

**Result:**

| org_tree | title | level |
|---|---|---|
| Sarah Mitchell | Chief Executive Officer | 0 |
| &nbsp;&nbsp;&nbsp;&nbsp;Amara Nwosu | Support Lead | 1 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marco Rossi | Support Agent | 2 |
| &nbsp;&nbsp;&nbsp;&nbsp;David Okafor | Sales Director | 1 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Priya Raman | Senior Sales Executive | 2 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tom Becker | Sales Executive | 2 |
| … | | |

**The anatomy of every recursive CTE:**

```text
WITH [RECURSIVE] cte_name AS (
    ⚓ ANCHOR QUERY          ← where to start. Runs ONCE. Does not refer to itself.
    UNION ALL
    🔁 RECURSIVE QUERY       ← joins back to cte_name. Runs repeatedly
                                until it returns zero new rows.
)
SELECT ... FROM cte_name;
```

## 31.4 🔢 Generating sequences with recursion

```sql
-- ✅ Generate every date in a range — essential for gap-free reports

-- 🟥 MSSQL
WITH date_series AS (
    SELECT CAST('2026-01-01' AS DATE) AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d) FROM date_series WHERE d < '2026-12-31'
)
SELECT d FROM date_series
OPTION (MAXRECURSION 400);        -- default limit is 100!
```

```sql
-- 🟦 MySQL 8.0+
WITH RECURSIVE date_series AS (
    SELECT DATE('2026-01-01') AS d
    UNION ALL
    SELECT d + INTERVAL 1 DAY FROM date_series WHERE d < '2026-12-31'
)
SELECT d FROM date_series;
-- Adjust cte_max_recursion_depth if you exceed 1000
```

```sql
-- 🟦 MySQL — real-world use: daily sales with ZERO for days that had none
WITH RECURSIVE date_series AS (
    SELECT DATE('2026-01-01') AS d
    UNION ALL
    SELECT d + INTERVAL 1 DAY FROM date_series WHERE d < '2026-08-31'
)
SELECT
    ds.d AS sales_date,
    COALESCE(SUM(oi.unit_price * oi.quantity * (1 - oi.discount)), 0) AS revenue
FROM date_series ds
LEFT JOIN orders o       ON o.order_date = ds.d AND o.status IN ('Delivered','Shipped')
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY ds.d
ORDER BY ds.d;
```

> [!TIP]
> 💡 **Without the date series, days with no sales simply do not appear** and your chart draws a misleading straight line between two distant points. This pattern is used in virtually every real dashboard.

## 31.5 ⚠️ Recursion safety

> [!WARNING]
> ⚠️ **An infinite loop is easy to write.** If your data has a cycle (employee A manages B, B manages A), the recursion never stops.

| Protection | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Default depth limit | 100 | 1000 |
| Change it | `OPTION (MAXRECURSION 500)` | `SET SESSION cte_max_recursion_depth = 5000;` |
| Unlimited (dangerous) | `OPTION (MAXRECURSION 0)` | set a very high value |

```sql
-- ✅ 🟥 MSSQL — defensive: add an explicit depth guard to the recursive member,
--    so a cycle in the data cannot loop forever (in MySQL, write WITH RECURSIVE)
WITH org_chart AS (
    SELECT employee_id, first_name, manager_id, 0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.first_name, e.manager_id, oc.level + 1
    FROM employees e
    INNER JOIN org_chart oc ON oc.employee_id = e.manager_id
    WHERE oc.level < 20                 -- 🔑 the guard
)
SELECT employee_id, first_name, level FROM org_chart ORDER BY level;
```

## 31.6 🔀 CTE vs derived table vs temp table

| | CTE | Derived table | Temp table |
|---|---|---|---|
| Readability | ✅ Best | ⚠️ Nests badly | ✅ Good |
| Reusable in the same query | ✅ Yes, by name | ❌ No | ✅ Yes |
| Persists across statements | ❌ No | ❌ No | ✅ Yes |
| Can be indexed | ❌ No | ❌ No | ✅ Yes |
| Has statistics (data summaries the optimizer uses) | ❌ No | ❌ No | ✅ Yes |
| Recursion | ✅ Yes | ❌ No | ❌ No |
| Worked out only once (*materialized*) | ⚠️ Usually **not** — may re-run each time it is used | ⚠️ Usually not | ✅ Always |

> [!WARNING]
> ⚠️ **The biggest CTE misconception:** a CTE is **not** a temporary table. In MSSQL the CTE's text is simply pasted into the query wherever you use it, so using the same CTE three times can run it three times. If a CTE is expensive **and** used several times, use a `#temp` table instead. MySQL 8.0 may store a CTE's result once, but do not rely on either behaviour — check the execution plan.

## 31.7 🎯 When to reach for a CTE

| Situation | Use |
|---|---|
| A subquery is used **once** and is short | Just write it in place — a CTE adds typing for no gain |
| The same derived result is needed **twice** in one query | ✅ CTE (named once, read twice) |
| Your query is nesting 3+ levels of parentheses | ✅ CTE — split it into named steps |
| A multi-step report: totals → per customer → classify → summarize | ✅ Chained CTEs |
| Walking a hierarchy or generating a sequence | ✅ **Recursive CTE** — nothing else does this |
| The intermediate result is large **and** used several times | ⚠️ A `#temp` table — a CTE may re-run per reference |
| You need an index on the intermediate result | ❌ Not a CTE — use a temp table |
| You need it across several statements | ❌ Not a CTE — a CTE only lasts until the end of its statement |

> [!CAUTION]
> 🐛 **Common mistake:** assuming a CTE is stored like a temporary table. In SQL Server its text is pasted in wherever it is used, so a CTE used three times can be **run three times**. If it is expensive, that is a 3x cost you cannot see in the query text. Check the plan; if it is repeated, switch to a temp table.

## 31.8 🧪 Try it yourself

1. Rewrite the "customers above the average spend" query from Chapter 30 using a CTE. Count how many lines you saved.
2. Build the full org chart with indentation and levels.
3. Generate every date in June 2026 and left-join daily order counts, showing 0 for quiet days.
4. Write a recursive CTE that produces the numbers 1 to 100.
5. Add a deliberate cycle to `employees` (A manages B, B manages A) and watch the recursion limit protect you.

---

# 32. APPLY and LATERAL

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 20 min | Get the top N rows for every group · Run a small query for each row · Split comma-separated text into rows |

> [!NOTE]
> 📌 **In plain words:** `APPLY` (MSSQL) and `LATERAL` (MySQL) let a subquery in the `FROM` clause **look at columns from the row currently being processed**. A normal derived table cannot do that.

> 🌍 **Analogy:** A normal join says *"here are two finished lists, match them up."* `APPLY` says *"for each row on the left, go and run this query specially for it."* It behaves like a "for each row" loop, but the database still runs it efficiently as one statement.

## 32.1 🎯 The problem they solve: top-N per group

**"Show me the 2 most expensive products in each category."** This is genuinely awkward without `APPLY`.

```sql
-- 🟥 MSSQL: CROSS APPLY
SELECT
    c.category_name,
    top_p.product_name,
    top_p.unit_price
FROM categories AS c
CROSS APPLY (
    SELECT TOP 2 p.product_name, p.unit_price
    FROM products p
    WHERE p.category_id = c.category_id      -- 🔑 references the OUTER row
    ORDER BY p.unit_price DESC
) AS top_p
ORDER BY c.category_name, top_p.unit_price DESC;
```

```sql
-- 🟦 MySQL 8.0.14+: LATERAL
SELECT
    c.category_name,
    top_p.product_name,
    top_p.unit_price
FROM categories AS c
JOIN LATERAL (
    SELECT p.product_name, p.unit_price
    FROM products p
    WHERE p.category_id = c.category_id
    ORDER BY p.unit_price DESC
    LIMIT 2
) AS top_p ON TRUE
ORDER BY c.category_name, top_p.unit_price DESC;
```

> [!TIP]
> 💡 **`ON TRUE` is required syntax in MySQL's `LATERAL`** — the matching already happens inside the subquery, so the join condition is just a formality.

## 32.2 🔀 CROSS APPLY vs OUTER APPLY

| | `CROSS APPLY` | `OUTER APPLY` |
|---|---|---|
| Left row with no matches | ❌ Dropped | ✅ Kept, with NULLs |
| Equivalent to | `INNER JOIN` | `LEFT JOIN` |

```sql
-- 🟥 MSSQL: every customer plus their most recent order — including customers with none
SELECT
    c.full_name,
    last_order.order_id,
    last_order.order_date,
    last_order.status
FROM customers AS c
OUTER APPLY (
    SELECT TOP 1 o.order_id, o.order_date, o.status
    FROM orders o
    WHERE o.customer_id = c.customer_id
    ORDER BY o.order_date DESC
) AS last_order
ORDER BY last_order.order_date DESC;
```

```sql
-- 🟦 MySQL: LEFT JOIN LATERAL
SELECT
    c.full_name,
    last_order.order_id,
    last_order.order_date,
    last_order.status
FROM customers AS c
LEFT JOIN LATERAL (
    SELECT o.order_id, o.order_date, o.status
    FROM orders o
    WHERE o.customer_id = c.customer_id
    ORDER BY o.order_date DESC
    LIMIT 1
) AS last_order ON TRUE
ORDER BY last_order.order_date DESC;
```

## 32.3 🧰 Other things APPLY is great at

```sql
-- 🟥 MSSQL: reuse a calculation without repeating it everywhere
SELECT
    oi.order_id,
    oi.product_id,
    calc.line_total,
    calc.line_total * 0.15 AS tax,
    calc.line_total * 1.15 AS total_with_tax
FROM order_items AS oi
CROSS APPLY (
    SELECT oi.unit_price * oi.quantity * (1 - oi.discount) AS line_total
) AS calc;
```

> [!TIP]
> 💡 **That is a lovely trick.** Without `APPLY` you would repeat the `unit_price * quantity * (1 - discount)` expression three times. With it, you name the calculation once and reuse it. MySQL has no direct equivalent — use a derived table or CTE.

```sql
-- 🟥 MSSQL: splitting comma-separated text into rows (SQL Server 2016+)
-- ShopDB has no comma-separated column, so add one to try this:
ALTER TABLE customers ADD tags NVARCHAR(200) NULL;
GO      -- 🔑 the new column only exists after this batch has run

UPDATE customers SET tags = 'vip,newsletter,early-access' WHERE customer_id = 1;
UPDATE customers SET tags = 'newsletter'                  WHERE customer_id = 2;
GO

SELECT
    c.customer_id,
    c.full_name,
    TRIM(s.value) AS tag
FROM customers AS c
CROSS APPLY STRING_SPLIT(c.tags, ',') AS s
WHERE c.tags IS NOT NULL;
```

**Result:**

| customer_id | full_name | tag |
|---|---|---|
| 1 | Amara Silva | vip |
| 1 | Amara Silva | newsletter |
| 1 | Amara Silva | early-access |
| 2 | John Baker | newsletter |

> [!TIP]
> 💡 **Note that `CROSS APPLY` drops customers whose `tags` is NULL** — `STRING_SPLIT(NULL, ',')` returns no rows. Swap in `OUTER APPLY` if you want to keep them. And remember: a comma-separated column breaks the **first rule of good table design** (*1NF*, [Chapter 51](#51-normalization-1nf-to-bcnf)) — this technique is for cleaning up data you inherited, not for data you design.

## 32.4 ⚖️ APPLY vs window functions for top-N

Both solve "top N per group". Which to use?

```sql
-- ✅ The window function alternative (works in BOTH) — see Chapter 33
WITH ranked AS (
    SELECT
        p.product_name,
        p.unit_price,
        c.category_name,
        ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.unit_price DESC) AS rn
    FROM products p
    JOIN categories c ON c.category_id = p.category_id
)
SELECT category_name, product_name, unit_price
FROM ranked
WHERE rn <= 2
ORDER BY category_name, unit_price DESC;
```

| | `APPLY` / `LATERAL` | Window function |
|---|---|---|
| Works in | ⚠️ MSSQL / MySQL 8.0.14+ | ✅ Every modern database |
| Speed for small N per group | ⚡ Often faster (uses the index, stops early) | Must rank **every** row first |
| Speed when the outer table is huge | ⚠️ Runs per outer row | ✅ One pass |
| Readability | ✅ Very direct | ✅ Clean once you know it |

> [!TIP]
> 💡 **Rule of thumb:** for "top 1 or 2 per group" with a good index, `APPLY`/`LATERAL` usually wins. For anything needing ranks, ties, or running totals, use window functions. When in doubt, test both and compare their execution plans (Chapter 47).

## 32.5 🧪 Try it yourself

1. Show the 3 best-selling products in each category.
2. Show every customer with their most recent order, including customers who have none.
3. For each employee, show the single largest order they handled.
4. Solve the same problem with `ROW_NUMBER()` and compare execution plans.

---
# 📈 PART 7 — ANALYTICS

---

# 33. Window functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 40 min | Add group totals and ranks without losing rows · Compare each row with the previous one · Control exactly which rows a calculation sees |

> [!NOTE]
> 📌 **In plain words:** A window function performs a calculation across a set of related rows, **without collapsing them into one row**. `GROUP BY` gives you 6 rows from 18. A window function gives you 18 rows, each carrying its group's answer alongside it.

> 🌍 **Analogy:** In a classroom, `GROUP BY` gives the teacher one sheet with the class average. A window function gives **each student their own report card** showing their mark, the class average, and their rank — every student keeps their own row.

## 33.1 🪟 The anatomy of a window function

The word **window** means *the set of rows the function is allowed to look at* while it works on each row.

```text
FUNCTION_NAME(...) OVER (
    [PARTITION BY column]     <- split rows into windows (like GROUP BY, but keeps rows)
    [ORDER BY column]         <- order rows within each window
    [ROWS/RANGE frame]        <- which rows within the window to include
)
```

**See the difference immediately:**

```sql
-- GROUP BY: 6 rows out
SELECT category_id, AVG(unit_price) AS avg_price
FROM products GROUP BY category_id;

-- Window function: all 18 rows out, each with its category average attached
SELECT
    product_name,
    category_id,
    unit_price,
    AVG(unit_price) OVER (PARTITION BY category_id)            AS category_avg,
    ROUND(unit_price - AVG(unit_price) OVER (PARTITION BY category_id), 2) AS diff_from_avg
FROM products
ORDER BY category_id, unit_price DESC;
```

**Result:**

| product_name | category_id | unit_price | category_avg | diff_from_avg |
|---|---|---|---|---|
| WorkStation X17 | 1 | 2450.00 | 1311.75 | 1138.25 |
| UltraBook Pro 14 | 1 | 1499.00 | 1311.75 | 187.25 |
| UltraBook Air 13 | 1 | 999.00 | 1311.75 | -312.75 |
| Legacy Netbook 10 | 1 | 299.00 | 1311.75 | -1012.75 |

> [!NOTE]
> 📌 **That is the magic.** Every product keeps its own row *and* knows its category's average. Doing this without window functions requires a self-join or a correlated subquery — more code, slower, harder to read.

> 🔀 **Window functions require MySQL 8.0+.** In MySQL 5.7 and earlier they do not exist at all; you must imitate them with complicated workarounds. This alone is a strong reason to upgrade.

## 33.2 🏅 Ranking functions

| Function | Behaviour with ties | Example: 100, 90, 90, 80 |
|---|---|---|
| `ROW_NUMBER()` | Always unique; tied rows get different numbers in no guaranteed order | 1, 2, 3, 4 |
| `RANK()` | Ties share a rank, then it **skips** | 1, 2, 2, **4** |
| `DENSE_RANK()` | Ties share a rank, **no skip** | 1, 2, 2, **3** |
| `NTILE(n)` | Splits rows into n roughly equal buckets | 4 buckets = quartiles |
| `PERCENT_RANK()` | Relative rank as 0 to 1 | 0, 0.33, 0.33, 1 |
| `CUME_DIST()` | Share of rows at or below this one | 0.25, 0.75, 0.75, 1 |

```sql
-- ✅ Works in BOTH: see all four side by side
SELECT
    product_name,
    category_id,
    unit_price,
    ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS row_num,
    RANK()       OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS dense_rnk,
    NTILE(4)     OVER (ORDER BY unit_price DESC)                          AS price_quartile
FROM products
ORDER BY category_id, unit_price DESC;
```

> [!TIP]
> 💡 **Which one do I want?**
> - **"Give me exactly one row per group"** → `ROW_NUMBER()`
> - **"Olympic medals — two golds means no silver"** → `RANK()`
> - **"Price tiers where ties belong together"** → `DENSE_RANK()`
> - **"Split my customers into 4 equal spending groups"** → `NTILE(4)`

## 33.3 🥇 The top-N-per-group pattern

The most-used window function pattern in the world. Learn it once, use it forever.

```sql
-- ✅ Works in BOTH: the single most expensive product in each category
WITH ranked AS (
    SELECT
        p.product_name,
        p.unit_price,
        c.category_name,
        ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.unit_price DESC) AS rn
    FROM products p
    JOIN categories c ON c.category_id = p.category_id
)
SELECT category_name, product_name, unit_price
FROM ranked
WHERE rn = 1
ORDER BY unit_price DESC;
```

> [!WARNING]
> ⚠️ **You cannot filter a window function in `WHERE`.** Window functions are computed *after* `WHERE` (they run at roughly the same stage as `SELECT`), so `WHERE ROW_NUMBER() OVER (...) = 1` is a syntax error in both engines. **You must wrap it in a CTE or derived table and filter outside.** This catches everyone once.

```sql
-- ✅ Real-world: each customer's most recent order
WITH ranked_orders AS (
    SELECT
        o.*,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC, o.order_id DESC) AS rn
    FROM orders o
)
SELECT c.full_name, r.order_id, r.order_date, r.status
FROM ranked_orders r
JOIN customers c ON c.customer_id = r.customer_id
WHERE r.rn = 1
ORDER BY r.order_date DESC;
```

> [!TIP]
> 💡 **Note the tiebreaker `, o.order_id DESC`.** If a customer placed two orders on the same date, without a tiebreaker the result is unpredictable — you can get a different answer on different runs. **Always make your `ORDER BY` inside `ROW_NUMBER()` fully deterministic.**

## 33.4 ↔️ LAG and LEAD — looking at neighbouring rows

```sql
-- ✅ Works in BOTH: month-over-month revenue change
WITH monthly AS (
    SELECT
        YEAR(o.order_date)  AS yr,
        MONTH(o.order_date) AS mth,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
)
SELECT
    yr, mth,
    ROUND(revenue, 2)                                          AS revenue,
    ROUND(LAG(revenue) OVER (ORDER BY yr, mth), 2)             AS prev_month,
    ROUND(revenue - LAG(revenue) OVER (ORDER BY yr, mth), 2)   AS change_amount,
    ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY yr, mth))
          / NULLIF(LAG(revenue) OVER (ORDER BY yr, mth), 0), 1) AS change_pct
FROM monthly
ORDER BY yr, mth;
```

> [!NOTE]
> 📌 **`LAG(x)` gives you the value of `x` from the previous row. `LEAD(x)` gives you the next row's value.** Both take optional arguments: `LAG(revenue, 3, 0)` means "3 rows back, and use 0 if there is no such row."

```sql
-- 🟥 MSSQL — real-world: how many days between each customer's consecutive orders?
SELECT
    c.full_name,
    o.order_id,
    o.order_date,
    LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_order_date,
    DATEDIFF(DAY,
        LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date),
        o.order_date) AS days_since_last_order         -- 🟥 MSSQL
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY c.full_name, o.order_date;
```

```sql
-- 🟦 MySQL version: DATEDIFF(later, earlier), with no unit argument
SELECT
    c.full_name,
    o.order_id,
    o.order_date,
    LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_order_date,
    DATEDIFF(o.order_date,
             LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date))
        AS days_since_last_order
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY c.full_name, o.order_date;
```

> [!IMPORTANT]
> 🎯 **`LAG`/`LEAD` real-world uses:** month-over-month growth, time between events, detecting gaps in sequences, finding price changes, and spotting customers who have stopped buying (*churn*).

## 33.5 🎬 FIRST_VALUE, LAST_VALUE, NTH_VALUE

```sql
-- ✅ Works in BOTH
SELECT
    c.full_name,
    o.order_id,
    o.order_date,
    FIRST_VALUE(o.order_date) OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
    ) AS first_ever_order,
    LAST_VALUE(o.order_date) OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING   -- 🔑 essential!
    ) AS most_recent_order
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY c.full_name, o.order_date;
```

> [!WARNING]
> ⚠️ **The `LAST_VALUE` gotcha that trips up everyone.** With `ORDER BY` present, the default *frame* (explained in 33.6, just below) is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` — so "last value" means "last value **so far**", which is just the current row. You must explicitly widen the frame to `UNBOUNDED FOLLOWING` to get the true last value. `FIRST_VALUE` works as expected because the frame already starts at the beginning.

## 33.6 📏 Window frames explained

The frame decides **which rows inside the window** the function actually sees.

```text
ROWS BETWEEN <start> AND <end>

Options:
  UNBOUNDED PRECEDING   ← the first row of the partition
  n PRECEDING           ← n rows before the current row
  CURRENT ROW
  n FOLLOWING           ← n rows after the current row
  UNBOUNDED FOLLOWING   ← the last row of the partition
```

| Frame | Meaning | Use for |
|---|---|---|
| `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Everything up to here | **Running total** |
| `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` | This row and the 2 before | **3-period moving average** |
| `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING` | Neighbours on both sides | Smoothing |
| `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` | The whole partition | Partition totals |
| *(no frame, no ORDER BY)* | The whole partition | `AVG() OVER (PARTITION BY x)` |
| *(no frame, with ORDER BY)* | ⚠️ Defaults to `RANGE … CURRENT ROW` | Silently makes it a running calculation |

> [!WARNING]
> ⚠️ **`ROWS` vs `RANGE`.** `ROWS` counts physical rows. `RANGE` groups rows with **equal ORDER BY values** together. If two rows share the same date, `RANGE` includes both in the frame while `ROWS` does not. `ROWS` is what people usually mean — **prefer `ROWS` unless you specifically want rows with equal values treated as one group.**

## 33.7 🧪 Try it yourself

1. Show every product with its category's average, minimum, and maximum price alongside.
2. Rank customers by lifetime spend using all three ranking functions and explain the differences you see.
3. Find each customer's most recent order using `ROW_NUMBER()`.
4. Show month-over-month revenue change with a percentage.
5. Try filtering `ROW_NUMBER()` in `WHERE`, read the error, then fix it with a CTE.

---

# 34. Ranking, running totals, and moving averages

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 40 min | Build running totals and moving averages · Work out percentages of a total · Find streaks and gaps · Measure medians and percentiles |

> [!NOTE]
> 📌 **In plain words:** This chapter is a cookbook. Every recipe here is a question a real business asks, with the query that answers it.

> 🌍 **Analogy:** A running total is a bank statement's *balance* column: each line shows the new amount **and** everything so far. A moving average is judging your weight by the last seven days instead of by today alone.

## 34.1 📈 Running totals (cumulative sums)

```sql
-- ✅ Works in BOTH: revenue accumulating through the year
WITH daily AS (
    SELECT
        o.order_date,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS day_revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY o.order_date
)
SELECT
    order_date,
    ROUND(day_revenue, 2) AS day_revenue,
    ROUND(SUM(day_revenue) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS running_total,
    ROUND(AVG(day_revenue) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS running_average
FROM daily
ORDER BY order_date;
```

```sql
-- ✅ Running total PER CUSTOMER — each customer's own accumulating spend
SELECT
    c.full_name,
    o.order_date,
    ROUND(ot.order_value, 2) AS order_value,
    ROUND(SUM(ot.order_value) OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date, o.order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS lifetime_to_date
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN (
    SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS order_value
    FROM order_items GROUP BY order_id
) ot ON ot.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
ORDER BY c.full_name, o.order_date;
```

## 34.2 📉 Moving averages

```sql
-- ✅ Works in BOTH: a 3-period moving average smooths out noise
WITH monthly AS (
    SELECT
        YEAR(o.order_date) * 100 + MONTH(o.order_date) AS ym,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY YEAR(o.order_date) * 100 + MONTH(o.order_date)
)
SELECT
    ym,
    ROUND(revenue, 2) AS revenue,
    ROUND(AVG(revenue) OVER (
        ORDER BY ym ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3,
    ROUND(AVG(revenue) OVER (
        ORDER BY ym ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_6
FROM monthly
ORDER BY ym;
```

> [!IMPORTANT]
> 🎯 **When to use a moving average:** any time raw daily or monthly numbers are too noisy to see the trend. Stock prices, website traffic, sales, server load — smoothing reveals the direction.

## 34.3 🥧 Percentage of total

```sql
-- ✅ Works in BOTH: each category's share of revenue
WITH category_revenue AS (
    SELECT
        c.category_name,
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
    FROM categories c
    JOIN products p     ON p.category_id = c.category_id
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders o       ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered','Shipped')
    GROUP BY c.category_name
)
SELECT
    category_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(100.0 * revenue / SUM(revenue) OVER (), 2) AS pct_of_total,
    ROUND(SUM(revenue) OVER (ORDER BY revenue DESC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS cumulative_revenue,
    ROUND(100.0 * SUM(revenue) OVER (ORDER BY revenue DESC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
          / SUM(revenue) OVER (), 2) AS cumulative_pct
FROM category_revenue
ORDER BY revenue DESC;
```

> [!TIP]
> 💡 **`SUM(revenue) OVER ()` — an empty `OVER()` means "the whole result set".** That gives you the grand total on every row, so you can compute percentages without a second query or a self-join. This is one of the most useful three characters in SQL.

> [!IMPORTANT]
> 🎯 **The `cumulative_pct` column is a *Pareto analysis* (also called ABC analysis)** — "which 20% of categories produce 80% of revenue?" Retailers, warehouses, and finance teams ask for exactly this.

## 34.4 🔍 Finding gaps and islands

A classic problem. An **island** is an unbroken run of consecutive values — for example, orders on three days in a row. A **gap** is a hole in a sequence — for example, order numbers that were skipped.

```sql
-- ✅ Works in BOTH: find gaps in the order_id sequence
WITH ordered AS (
    SELECT
        order_id,
        LEAD(order_id) OVER (ORDER BY order_id) AS next_id
    FROM orders
)
SELECT
    order_id + 1 AS gap_starts,
    next_id  - 1 AS gap_ends,
    next_id - order_id - 1 AS missing_count
FROM ordered
WHERE next_id - order_id > 1;
```

```sql
-- 🟥 MSSQL: find runs of consecutive daily activity ("islands")
WITH active_days AS (
    SELECT DISTINCT order_date FROM orders
),
grouped AS (
    SELECT
        order_date,
        DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY order_date), order_date) AS grp  -- 🟥 MSSQL
    FROM active_days
)
SELECT
    MIN(order_date) AS streak_start,
    MAX(order_date) AS streak_end,
    COUNT(*)        AS consecutive_days
FROM grouped
GROUP BY grp
HAVING COUNT(*) > 1
ORDER BY streak_start;
```

```sql
-- 🟦 MySQL: the same trick, with DATE_SUB
WITH active_days AS (
    SELECT DISTINCT order_date FROM orders
),
grouped AS (
    SELECT
        order_date,
        DATE_SUB(order_date, INTERVAL ROW_NUMBER() OVER (ORDER BY order_date) DAY) AS grp
    FROM active_days
)
SELECT
    MIN(order_date) AS streak_start,
    MAX(order_date) AS streak_end,
    COUNT(*)        AS consecutive_days
FROM grouped
GROUP BY grp
HAVING COUNT(*) > 1
ORDER BY streak_start;
```

> [!NOTE]
> 📌 **The trick:** subtract the row number from the date. For consecutive dates, that difference is **constant**, so grouping by it isolates each run. It looks like magic the first time; work through three rows by hand and it becomes obvious. The same pattern finds attendance streaks, periods when a system stayed online, consecutive login days, and shift schedules.

## 34.5 📊 Cohort and retention analysis

A **cohort** is a group of customers who started in the same month. **Retention** asks: how many of them are still buying one, two, three months later?

```sql
-- ✅ Works in BOTH: group customers by the month of their FIRST order, then track their activity
WITH first_order AS (
    SELECT
        customer_id,
        MIN(order_date) AS cohort_date
    FROM orders
    GROUP BY customer_id
),
activity AS (
    SELECT
        f.customer_id,
        YEAR(f.cohort_date) * 100 + MONTH(f.cohort_date) AS cohort_month,
        YEAR(o.order_date)  * 100 + MONTH(o.order_date)  AS activity_month
    FROM first_order f
    JOIN orders o ON o.customer_id = f.customer_id
)
SELECT
    cohort_month,
    activity_month,
    COUNT(DISTINCT customer_id) AS active_customers
FROM activity
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;
```

## 34.6 🎯 Deduplication with ROW_NUMBER

```sql
-- ✅ Works in BOTH: find (and delete) duplicate customers by email

-- Step 1: LOOK at what you would delete
WITH dupes AS (
    SELECT
        customer_id,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY customer_id) AS rn
    FROM customers
)
SELECT * FROM dupes WHERE rn > 1;

-- Step 2: delete all but the first of each group
WITH dupes AS (
    SELECT
        customer_id,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY customer_id) AS rn
    FROM customers
)
DELETE FROM customers
WHERE customer_id IN (SELECT customer_id FROM dupes WHERE rn > 1);
```

```sql
-- 🟥 MSSQL can DELETE directly from the CTE — very neat
WITH dupes AS (
    SELECT ROW_NUMBER() OVER (PARTITION BY email ORDER BY customer_id) AS rn
    FROM customers
)
DELETE FROM dupes WHERE rn > 1;
```

> [!WARNING]
> ⚠️ **Always run the `SELECT` version first.** Deduplication deletes real customer records. `ORDER BY customer_id` decides which copy survives — think about whether you want the oldest, the newest, or the most complete row.

## 34.7 📐 Percentiles, medians, and distribution

> [!NOTE]
> 📌 **In plain words:** An average can mislead when a few values are extreme. One €50,000 order pulls the average far above what a typical customer actually spends. The **median** (the middle value) and **percentiles** (P90 = the value that 90% of orders are below) describe your data much more honestly.

```sql
-- 🟥 MSSQL: median and P90 of order values
WITH order_totals AS (
    SELECT o.order_id,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    GROUP BY o.order_id
)
SELECT DISTINCT
    CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY order_value) OVER () AS DECIMAL(10,2)) AS median_interpolated,
    CAST(PERCENTILE_DISC(0.50) WITHIN GROUP (ORDER BY order_value) OVER () AS DECIMAL(10,2)) AS median_real_row,
    CAST(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY order_value) OVER () AS DECIMAL(10,2)) AS p90
FROM order_totals;
```

**Result:**

| median_interpolated | median_real_row | p90 |
|---|---|---|
| 938.00 | 938.00 | 2430.41 |

| Function | Returns | Use when |
|---|---|---|
| `PERCENTILE_CONT(p)` | Works out a value **between** the two nearest rows (it *interpolates*) | A statistical median. May be a value nobody actually paid |
| `PERCENTILE_DISC(p)` | The first **real row** at or past that percentile | You need an actual observed value |

> [!WARNING]
> ⚠️ **Three traps with `PERCENTILE_CONT`.** It is a *window* function, not an aggregate — there is no `GROUP BY` form, so it repeats the answer on every row and you need `DISTINCT` (or a subquery) to collapse it. It returns `FLOAT`, so cast to `DECIMAL` before displaying money. And `WITHIN GROUP (ORDER BY …)` is mandatory — that is what it takes the percentile *of*.

```sql
-- 🟥 Median per group: partition the window
SELECT DISTINCT
    c.category_name,
    CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY p.unit_price)
         OVER (PARTITION BY c.category_id) AS DECIMAL(10,2)) AS median_price
FROM products p
JOIN categories c ON c.category_id = p.category_id
ORDER BY c.category_name;
```

> 🔀 **MySQL has no `PERCENTILE_CONT`.** Compute the median with `ROW_NUMBER` and `COUNT` instead — the portable technique that also works on any older MSSQL version:

```sql
-- ✅ Works in BOTH: median without PERCENTILE_CONT
WITH ranked AS (
    SELECT unit_price,
           ROW_NUMBER() OVER (ORDER BY unit_price) AS rn,
           COUNT(*)     OVER ()                    AS total
    FROM products
)
SELECT AVG(unit_price) AS median_price
FROM ranked
WHERE rn IN (FLOOR((total + 1) / 2.0), FLOOR((total + 2) / 2.0));   -- handles odd and even counts
-- 249.00 — the same answer PERCENTILE_CONT(0.5) gives for products.unit_price
```

> [!TIP]
> 💡 **Why `FLOOR((total+1)/2.0)` and `FLOOR((total+2)/2.0)`?** An odd count makes both expressions the same row (so `AVG` returns it unchanged), and an even count makes them the two middle rows (so `AVG` averages them). One expression, both cases, no `CASE`. The `FLOOR(… / 2.0)` is not decoration: MSSQL's `/` truncates integers, but MySQL's `/` returns a decimal — plain `(total + 1) / 2` is `9.5` there, matches no row number, and MySQL silently returns `299.00` instead of the correct `249.00`.

**Where each row sits in the distribution:**

```sql
-- ✅ Works in BOTH (MySQL 8.0+)
SELECT
    product_name,
    unit_price,
    CAST(PERCENT_RANK() OVER (ORDER BY unit_price) AS DECIMAL(5,3)) AS pct_rank,
    CAST(CUME_DIST()    OVER (ORDER BY unit_price) AS DECIMAL(5,3)) AS cumulative_dist,
    NTILE(4)            OVER (ORDER BY unit_price)                  AS price_quartile
FROM products
ORDER BY unit_price DESC;
```

> [!TIP]
> 💡 **Cast, do not `ROUND`.** `PERCENT_RANK` and `CUME_DIST` return `FLOAT`, and `ROUND` on a float still prints as `0.94099999999999995` in some clients. Casting to `DECIMAL` fixes the display for good.

**Result (top rows):**

| product_name | unit_price | pct_rank | cumulative_dist | price_quartile |
|---|---|---|---|---|
| WorkStation X17 | 2450.00 | 1.000 | 1.000 | 4 |
| UltraBook Pro 14 | 1499.00 | 0.941 | 0.944 | 4 |
| UltraBook Air 13 | 999.00 | 0.882 | 0.889 | 4 |
| Zenith Phone 12 | 899.00 | 0.824 | 0.833 | 4 |
| VisionPanel 32 4K | 749.00 | 0.706 | 0.778 | 3 |

| Function | Answers |
|---|---|
| `PERCENT_RANK()` | "What fraction of rows are strictly **below** this one?" — always starts at 0 |
| `CUME_DIST()` | "What fraction of rows are at **or below** this one?" — always ends at 1 |
| `NTILE(n)` | "Which of *n* equal-sized buckets does this row fall in?" |

> [!TIP]
> 💡 **`NTILE` divides by *row count*, not by *value*.** Four quartiles of 18 products give buckets of 5, 5, 4, 4 rows — regardless of whether the prices cluster. If you need buckets by value range (€0–500, €500–1000 …), that is a `CASE` expression, not `NTILE`.

> [!IMPORTANT]
> 🎯 **Report the median and P90, not just the average.** "Average response time 200 ms" hides that one user in ten waits two seconds. P90 and P99 are what your users actually experience, which is why every SLA (a *service-level agreement* — a promised speed or uptime) is written in percentiles.

## 34.8 🪟 Naming a window you reuse

Repeating a long `OVER (…)` clause three times is noise, and it is a place for a typo to hide.

```sql
-- 🟥 MSSQL 2022+ · 🟦 MySQL 8.0+: define the window once
SELECT
    product_name,
    unit_price,
    RANK()      OVER w AS price_rank,
    CUME_DIST() OVER w AS cumulative_dist,          -- not "cume_dist": a reserved word in MySQL
    LEAD(unit_price) OVER w AS next_cheapest        -- LEAD: the window is sorted most-expensive first
FROM products
WINDOW w AS (ORDER BY unit_price DESC)
ORDER BY unit_price DESC;
```

> [!WARNING]
> ⚠️ **The `WINDOW` clause sits between `HAVING` and `ORDER BY`**, and it arrived in SQL Server only in **2022**. On earlier versions, repeat the `OVER (…)` clause — or move it into a CTE. MySQL has had it since 8.0.

## 34.9 🧪 Try it yourself

1. Build a running total of revenue by month for 2026.
2. Add a 3-month moving average and compare the two lines.
3. Compute each product's share of its category's revenue.
4. Do a Pareto analysis: which products make up the first 80% of revenue?
5. Find any gaps in the `order_id` sequence.
6. Find each customer's longest streak of consecutive months with an order.

---

# 35. PIVOT and UNPIVOT

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 20 min | Turn rows into columns for spreadsheet-style reports · Turn columns back into rows · Know when to pivot outside SQL |

> [!NOTE]
> 📌 **In plain words:** Pivoting turns **rows into columns**. Instead of 12 rows (one per month), you get 1 row with 12 month columns — the shape every spreadsheet report wants.

> 🌍 **Analogy:** A tall thin list of "month, amount" pairs versus a wide table with a column per month. Same data, rotated 90 degrees.

## 35.1 🔄 The portable way: CASE (works everywhere)

```sql
-- ✅ Works in BOTH — and this is the version you should usually write
SELECT
    c.category_name,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 1 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS jan,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 2 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS feb,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 3 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS mar,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 4 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS apr,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 5 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS may,
    ROUND(SUM(CASE WHEN MONTH(o.order_date) = 6 THEN oi.unit_price*oi.quantity*(1-oi.discount) ELSE 0 END), 2) AS jun,
    ROUND(SUM(oi.unit_price*oi.quantity*(1-oi.discount)), 2) AS total
FROM categories c
JOIN products p     ON p.category_id = c.category_id
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o       ON o.order_id = oi.order_id
WHERE o.status IN ('Delivered','Shipped') AND YEAR(o.order_date) = 2026
GROUP BY c.category_name
ORDER BY total DESC;
```

> [!TIP]
> 💡 **This `SUM(CASE …)` approach (called *conditional aggregation*) is readable and works in every SQL database on earth.** MSSQL's own `PIVOT` syntax is shorter, but it only works in SQL Server and becomes harder to read as soon as you need two totals.

## 35.2 🟥 MSSQL PIVOT syntax

```sql
-- 🟥 MSSQL only
SELECT category_name, [1] AS jan, [2] AS feb, [3] AS mar, [4] AS apr, [5] AS may, [6] AS jun
FROM (
    SELECT
        c.category_name,
        MONTH(o.order_date) AS order_month,
        oi.unit_price * oi.quantity * (1 - oi.discount) AS line_total
    FROM categories c
    JOIN products p     ON p.category_id = c.category_id
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders o       ON o.order_id = oi.order_id
    WHERE o.status IN ('Delivered','Shipped') AND YEAR(o.order_date) = 2026
) AS src
PIVOT (
    SUM(line_total)
    FOR order_month IN ([1],[2],[3],[4],[5],[6])
) AS pvt
ORDER BY category_name;
```

> [!WARNING]
> ⚠️ **`PIVOT` has three real limitations:** you must list the column values **explicitly** (you cannot pivot an unknown set of values without dynamic SQL), it supports **one aggregate only**, and every column the pivot does not mention is silently used for grouping — so one stray column in the source query produces confusing extra rows. **Always build the source as a subquery in `FROM` that contains only the three columns you need.**

## 35.3 🔃 UNPIVOT — columns back into rows

```sql
-- 🟥 MSSQL
SELECT product_name, metric_name, metric_value
FROM (
    SELECT
        product_name,
        -- 🔑 every unpivoted column MUST share one data type
        CAST(unit_price     AS DECIMAL(12,2)) AS unit_price,
        CAST(units_in_stock AS DECIMAL(12,2)) AS units_in_stock,
        CAST(reorder_level  AS DECIMAL(12,2)) AS reorder_level
    FROM products
) AS src
UNPIVOT (
    metric_value FOR metric_name IN (unit_price, units_in_stock, reorder_level)
) AS unpvt
ORDER BY product_name, metric_name;
```

> [!WARNING]
> ⚠️ **The `CAST` is not optional, and this is the error everyone hits first.** `UNPIVOT` collapses several columns into **one** output column, so they must all have the **same data type**. In `products`, `unit_price` is `DECIMAL(10,2)` while `units_in_stock` and `reorder_level` are `INT`. Without the casts you get:
>
> ```text
> Msg 8167: The type of column "units_in_stock" conflicts with the type
>           of other columns specified in the UNPIVOT list.
> ```
>
> Cast every column to the **widest** type in the set — here `DECIMAL(12,2)`, which holds both the prices and the counts without losing anything.

```sql
-- ✅ Works in BOTH: the portable UNPIVOT with UNION ALL
SELECT product_name, 'unit_price'     AS metric, unit_price     AS value FROM products
UNION ALL
SELECT product_name, 'units_in_stock',           units_in_stock         FROM products
UNION ALL
SELECT product_name, 'reorder_level',            reorder_level          FROM products
ORDER BY product_name, metric;
```

> [!IMPORTANT]
> 🎯 **When you need `UNPIVOT`:** normalizing a badly designed table that has `jan_sales, feb_sales, mar_sales…` columns into a proper `(month, sales)` structure. Wide tables like that are a sign of poor table design — see [Chapter 51](#51-normalization-1nf-to-bcnf).

## 35.4 🔀 Dynamic pivoting — when the columns are not known in advance

When you do not know the column names in advance, you must build the query's text while the code runs, then execute that text. This is called **dynamic SQL**.

```sql
-- 🟥 MSSQL: build the column list at runtime, then execute
DECLARE @cols   NVARCHAR(MAX);
DECLARE @sql    NVARCHAR(MAX);

SELECT @cols = STRING_AGG(QUOTENAME(category_name), ',')
FROM (SELECT DISTINCT category_name FROM categories) AS c;

SET @sql = N'
SELECT order_month, ' + @cols + N'
FROM (
    SELECT MONTH(o.order_date) AS order_month,
           c.category_name,
           oi.unit_price * oi.quantity * (1 - oi.discount) AS line_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    JOIN categories c   ON c.category_id = p.category_id
    WHERE o.status IN (''Delivered'',''Shipped'')
) AS src
PIVOT (SUM(line_total) FOR category_name IN (' + @cols + N')) AS pvt
ORDER BY order_month;';

EXEC sp_executesql @sql;
```

> [!WARNING]
> ⚠️ **`QUOTENAME()` is doing security work here.** It safely wraps each identifier in brackets so a category named `x]; DROP TABLE orders;--` cannot break out. Never build dynamic SQL by concatenating raw values — see [Chapter 55](#55-sql-injection-and-how-to-stop-it).

> [!TIP]
> 💡 **Honestly: pivot in your reporting tool when you can.** Excel, Power BI, Tableau, pandas, and every BI tool pivot natively, handle unknown column sets effortlessly, and do not require dynamic SQL. Pivot in SQL when SQL is the last stop — a CSV export, a stored procedure feeding a fixed report.

## 35.5 🧪 Try it yourself

1. Build a table of units sold per product per quarter, quarters as columns.
2. Produce a customer-count-by-country-and-tier cross-tab.
3. Unpivot the `products` price/stock/reorder columns into rows.
4. Write the monthly revenue pivot with `CASE` and, in MSSQL, with `PIVOT`. Which would you rather maintain?

---
# 🏗️ PART 8 — DATABASE OBJECTS

---

# 36. Views

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 25 min | Save a query as a view · Hide columns people must not see · Use views that stay up to date · Avoid the view traps |

> [!NOTE]
> 📌 **In plain words:** A view is a **saved query that behaves like a table**. It stores no data of its own — every time you query it, the underlying query runs.

> 🌍 **Analogy:** A view is a **window** in a wall. You are not moving the furniture; you are creating a fixed frame through which people see a particular part of the room. Change the furniture and the window shows the new arrangement automatically.

## 36.1 ✍️ Creating and using views

```sql
-- ✅ Works in BOTH
CREATE VIEW v_order_summary AS
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.full_name        AS customer_name,
    c.country,
    COUNT(oi.product_id)                                     AS item_count,
    SUM(oi.quantity)                                         AS total_units,
    ROUND(SUM(oi.unit_price * oi.quantity * (1-oi.discount)), 2) AS order_value
FROM orders o
JOIN customers   c  ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.order_date, o.status, c.full_name, c.country;
```

Now anyone can ask complex questions with simple SQL:

```sql
SELECT * FROM v_order_summary WHERE country = 'Singapore' ORDER BY order_value DESC;
SELECT status, COUNT(*), SUM(order_value) FROM v_order_summary GROUP BY status;
```

**Modifying and dropping:**

```sql
-- 🟥 MSSQL
CREATE OR ALTER VIEW v_order_summary AS      -- 2016 SP1+: creates or replaces
SELECT order_id, order_date, status FROM orders;
GO

DROP VIEW IF EXISTS v_order_summary;
```

```sql
-- 🟦 MySQL
CREATE OR REPLACE VIEW v_order_summary AS SELECT order_id, order_date, status FROM orders;
DROP VIEW IF EXISTS v_order_summary;
```

## 36.2 🎯 The five real reasons to use a view

**① Hide complexity.** A 60-line join becomes `SELECT * FROM v_order_summary`. Analysts who do not know how your tables fit together can still answer questions.

**② Enforce security.** Grant access to the view, not the table. Users see only the columns and rows you allow.

```sql
-- ✅ Works in BOTH: staff can see customers WITHOUT contact details
CREATE VIEW v_customers_public AS
SELECT customer_id, full_name, city, country, loyalty_tier, signup_date
FROM customers;
-- email and phone are simply not exposed
```

```sql
-- 🟥 MSSQL: grant the view — and NO permission on the customers table itself
-- (run this as its own batch: CREATE VIEW must be alone in its batch, so put GO after the view)
CREATE ROLE support_role;
GRANT SELECT ON v_customers_public TO support_role;
```

```sql
-- 🟦 MySQL: the same grant
CREATE ROLE 'support_role';
GRANT SELECT ON ShopDB.v_customers_public TO 'support_role';
```

**③ Row-level security — each user sees only their own rows.**

```sql
-- 🟥 MSSQL: each sales rep sees only their own orders
CREATE VIEW v_my_orders AS
SELECT o.*
FROM orders o
JOIN employees e ON e.employee_id = o.employee_id
WHERE e.first_name + ' ' + e.last_name = SUSER_SNAME();   -- 🟥 MSSQL
```

> [!WARNING]
> ⚠️ **A view is a *convenience*, not a security boundary.** If the user also has `SELECT` on `orders`, they simply query the table directly and see everything. This only works if you grant access to the **view alone** and revoke it on the base table. For a guarantee the engine enforces no matter how the table is queried, use **Row-Level Security** ([Chapter 54.6](#546--row-level-security--filtering-rows-per-user-automatically)).

**④ A stable name while the tables underneath change.** If you rename a column, update the view and every application keeps working.

**⑤ Consistent business logic.** Define "revenue" once, in a view, and every report computes it identically. Nothing is worse than two dashboards disagreeing because one forgot the discount.

```sql
-- ✅ Works in BOTH: the single source of truth for "active customers"
CREATE VIEW v_active_customers AS
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE order_date >= '2026-01-01'
);
```

## 36.3 ✏️ Updatable views

Some views accept `INSERT`, `UPDATE`, and `DELETE`, which pass through to the base table.

```sql
-- ✅ Works in BOTH — this view IS updatable: simple, one table, no aggregation
CREATE VIEW v_uk_customers AS
SELECT customer_id, full_name, email, city, country
FROM customers
WHERE country = 'UK';
```

```sql
-- ✅ Works in BOTH (🔑 in MSSQL run it as a separate batch: CREATE VIEW must be alone in its batch)
UPDATE v_uk_customers SET city = 'Manchester' WHERE customer_id = 2;   -- ✅ works
```

**A view is NOT updatable if it contains any of:**

| ❌ Blocker | Why |
|---|---|
| `GROUP BY` or aggregates | One view row maps to many table rows |
| `DISTINCT` | Same reason |
| `UNION` | Which branch would you update? |
| A join (usually) | Ambiguous which table to modify |
| Window functions | Computed across rows |
| `TOP` / `LIMIT` (usually) | Ambiguous |

> [!WARNING]
> ⚠️ **The disappearing row problem.** Update a row through a filtered view so it no longer matches the filter, and it vanishes from the view:
> ```sql
> UPDATE v_uk_customers SET country = 'France' WHERE customer_id = 2;
> -- The row still exists in customers, but has left the view.
> ```
> **The fix — `WITH CHECK OPTION`**, which refuses updates that would push a row out of the view:
> ```sql
> -- ✅ Works in BOTH
> CREATE VIEW v_uk_customers_checked AS
> SELECT customer_id, full_name, email, city, country
> FROM customers WHERE country = 'UK'
> WITH CHECK OPTION;
> -- Through this view, that UPDATE fails with an error instead of silently hiding the row.
> ```

## 36.4 ⚡ Materialized views — views that store data

A normal view runs its query every time. A materialized view **stores the result** and refreshes it periodically. This trades freshness for speed.

```sql
-- 🟥 MSSQL: "indexed views". Add a unique clustered index to a view and
-- SQL Server physically stores and auto-maintains the results.
CREATE VIEW v_category_sales
WITH SCHEMABINDING            -- 🔑 required
AS
SELECT
    p.category_id,
    COUNT_BIG(*)          AS line_count,      -- 🔑 COUNT_BIG, not COUNT
    SUM(oi.quantity)      AS total_units
FROM dbo.order_items AS oi
JOIN dbo.products    AS p ON p.product_id = oi.product_id
GROUP BY p.category_id;
GO

CREATE UNIQUE CLUSTERED INDEX ix_v_category_sales ON v_category_sales(category_id);
```

> [!WARNING]
> ⚠️ **MSSQL indexed views have strict rules:** `WITH SCHEMABINDING`, two-part names (`dbo.table`), `COUNT_BIG(*)` instead of `COUNT(*)`, no outer joins, no subqueries, no `DISTINCT`. In exchange, the engine maintains them **automatically on every write** — always fresh, but every insert into the base table now costs more.

```sql
-- 🟦 MySQL has NO materialized views. Imitate one with a real table + a scheduled refresh.
CREATE TABLE mv_category_sales (
    category_id  INT PRIMARY KEY,
    line_count   INT NOT NULL,
    total_units  INT NOT NULL,
    refreshed_at DATETIME NOT NULL
);

-- Refresh procedure, called by a scheduled EVENT (see Chapter 57)
DELIMITER $$
CREATE PROCEDURE refresh_mv_category_sales()
BEGIN
    TRUNCATE TABLE mv_category_sales;
    INSERT INTO mv_category_sales (category_id, line_count, total_units, refreshed_at)
    SELECT p.category_id, COUNT(*), SUM(oi.quantity), NOW()
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY p.category_id;
END$$
DELIMITER ;
```

| | Normal view | Materialized view |
|---|---|---|
| Storage | None | Stores the result |
| Freshness | ✅ Always current | ⚠️ As of the last refresh |
| Read speed | Same as the underlying query | ⚡ Very fast |
| Write cost | None | ⚠️ Slows down base-table writes, or needs a refresh job |
| Best for | Simplification, security | Expensive aggregates read far more often than written |

## 36.5 ⚠️ View pitfalls

> [!WARNING]
> ⚠️ **`SELECT *` in a view definition does not auto-update.** In MSSQL, columns added to the base table afterwards **do not appear** in the view until you refresh it with `sp_refreshview`. Worse, dropping a column can make the view return wrong data under the old column names. **Always list columns explicitly in a view.**

> [!TIP]
> 💡 **Naming convention:** prefix views with `v_` or `vw_`. Six months later, `v_order_summary` immediately tells the reader "this is a view, do not expect an index on it."

## 36.6 🎯 When to create a view (and when not to)

| Use a view when... | Do **not** use a view when... |
|---|---|
| A complex join is written repeatedly | You only need it once |
| Analysts need simple access to a hard schema | You need parameters — use an **inline TVF** (a function that returns a table, Chapter 38) or a procedure |
| You must hide columns (salaries, emails) from a role | You are relying on it as a *security boundary* without revoking table access |
| A business definition ("revenue") must be identical everywhere | The logic changes per caller |
| You want a stable name while the schema underneath changes | You would be building a view on a view on a view |
| A rollup is read constantly and written rarely | You actually need it fast — use an **indexed view** or summary table |

> [!CAUTION]
> 🐛 **Common mistake:** nesting views. `v_report` selects from `v_sales`, which selects from `v_orders`. Each level looks tidy, but the database must unpick the whole stack into one giant query, speed drops sharply, and nobody can trace which table a column came from. **Keep views one level deep.**

## 36.7 🧪 Try it yourself

1. Create `v_product_catalog` joining products, categories, and suppliers with friendly names.
2. Create `v_low_stock` showing products at or below their reorder level, and query it.
3. Create a filtered, updatable view with `WITH CHECK OPTION` and prove it blocks a bad update.
4. Try to update through a view containing `GROUP BY`. Read the error.

---

# 37. Stored procedures

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 40 min | Save multi-step tasks in the database · Pass values in and out · Use `IF` and loops · Write a safe, complete order procedure |

> [!NOTE]
> 📌 **In plain words:** A stored procedure is a **named, saved program** inside the database. You call it by name, pass it parameters, and it runs a whole sequence of SQL statements.

> 🌍 **Analogy:** A view is a saved *question*. A stored procedure is a saved *task* — it can ask several questions, make decisions, change data, handle errors, and report back.

## 37.1 🟥 MSSQL stored procedures

```sql
CREATE OR ALTER PROCEDURE usp_get_customer_orders
    @customer_id INT,
    @from_date   DATE = NULL,          -- optional, with a default
    @status      VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;                    -- 💡 hides the "(n rows affected)" messages

    SELECT
        o.order_id,
        o.order_date,
        o.status,
        ROUND(SUM(oi.unit_price * oi.quantity * (1 - oi.discount)), 2) AS order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.customer_id = @customer_id
      AND (@from_date IS NULL OR o.order_date >= @from_date)
      AND (@status    IS NULL OR o.status = @status)
    GROUP BY o.order_id, o.order_date, o.status
    ORDER BY o.order_date DESC;
END;
GO

-- Calling it
EXEC usp_get_customer_orders @customer_id = 1;
EXEC usp_get_customer_orders @customer_id = 3, @from_date = '2026-04-01';
EXEC usp_get_customer_orders @customer_id = 3, @status = 'Delivered';
```

**Output parameters and return values:**

```sql
CREATE OR ALTER PROCEDURE usp_place_order
    @customer_id  INT,
    @employee_id  INT,
    @new_order_id INT OUTPUT               -- 🔑 sends a value back
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO orders (customer_id, employee_id, order_date, status)
    VALUES (@customer_id, @employee_id, CAST(GETDATE() AS DATE), 'Pending');

    SET @new_order_id = SCOPE_IDENTITY();

    RETURN 0;                              -- 0 = success, by convention
END;
GO

DECLARE @order_id INT;
EXEC usp_place_order @customer_id = 1, @employee_id = 3, @new_order_id = @order_id OUTPUT;
SELECT @order_id AS created_order_id;
```

## 37.2 🟦 MySQL stored procedures

```sql
DELIMITER $$

CREATE PROCEDURE usp_get_customer_orders(
    IN p_customer_id INT,
    IN p_from_date   DATE,
    IN p_status      VARCHAR(20)
)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        o.status,
        ROUND(SUM(oi.unit_price * oi.quantity * (1 - oi.discount)), 2) AS order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.customer_id = p_customer_id
      AND (p_from_date IS NULL OR o.order_date >= p_from_date)
      AND (p_status    IS NULL OR o.status = p_status)
    GROUP BY o.order_id, o.order_date, o.status
    ORDER BY o.order_date DESC;
END$$

DELIMITER ;

-- Calling it
CALL usp_get_customer_orders(1, NULL, NULL);
CALL usp_get_customer_orders(3, '2026-04-01', NULL);
```

> [!WARNING]
> ⚠️ **What is `DELIMITER $$`?** MySQL normally treats `;` as "end of statement". A procedure body is full of semicolons, so MySQL would try to execute it halfway through. `DELIMITER $$` temporarily changes the terminator to `$$`, letting you define the whole body, then you change it back. **Every MySQL procedure needs this**, and forgetting it is the number-one MySQL procedure error.

> [!WARNING]
> ⚠️ **Keep emoji out of MySQL routine bodies — even in comments.** MySQL stores a routine's definition as `utf8mb3`, so a four-byte character such as 🔒 inside `BEGIN … END` makes `CREATE PROCEDURE` fail with *ERROR 4089: Definition of stored routine … contains an invalid utf8mb3 character string*.

**MySQL parameter modes:**

| Mode | Meaning |
|---|---|
| `IN` (default) | Value passed in, read-only |
| `OUT` | Value passed back to the caller |
| `INOUT` | Both |

```sql
DELIMITER $$
CREATE PROCEDURE usp_place_order(
    IN  p_customer_id  INT,
    IN  p_employee_id  INT,
    OUT p_new_order_id INT
)
BEGIN
    INSERT INTO orders (customer_id, employee_id, order_date, status)
    VALUES (p_customer_id, p_employee_id, CURDATE(), 'Pending');

    SET p_new_order_id = LAST_INSERT_ID();
END$$
DELIMITER ;

CALL usp_place_order(1, 3, @new_id);
SELECT @new_id;
```

## 37.3 🧠 Variables, control flow, and loops

```sql
-- 🟥 MSSQL
CREATE OR ALTER PROCEDURE usp_apply_loyalty_discount
    @order_id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @tier VARCHAR(10);
    DECLARE @discount DECIMAL(4,3);

    SELECT @tier = c.loyalty_tier
    FROM orders o JOIN customers c ON c.customer_id = o.customer_id
    WHERE o.order_id = @order_id;

    IF @tier IS NULL
    BEGIN
        RAISERROR('Order %d not found.', 16, 1, @order_id);
        RETURN;
    END;

    SET @discount =
        CASE @tier
            WHEN 'Platinum' THEN 0.15
            WHEN 'Gold'     THEN 0.10
            WHEN 'Silver'   THEN 0.05
            ELSE 0.00
        END;

    UPDATE order_items SET discount = @discount WHERE order_id = @order_id;

    SELECT @order_id AS order_id, @tier AS tier, @discount AS applied_discount;
END;
GO
```

```sql
-- 🟦 MySQL
DELIMITER $$
CREATE PROCEDURE usp_apply_loyalty_discount(IN p_order_id INT)
BEGIN
    DECLARE v_tier     VARCHAR(10);
    DECLARE v_discount DECIMAL(4,3);

    SELECT c.loyalty_tier INTO v_tier
    FROM orders o JOIN customers c ON c.customer_id = o.customer_id
    WHERE o.order_id = p_order_id;

    IF v_tier IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Order not found.';
    END IF;

    SET v_discount = CASE v_tier
        WHEN 'Platinum' THEN 0.15
        WHEN 'Gold'     THEN 0.10
        WHEN 'Silver'   THEN 0.05
        ELSE 0.00 END;

    UPDATE order_items SET discount = v_discount WHERE order_id = p_order_id;

    SELECT p_order_id AS order_id, v_tier AS tier, v_discount AS applied_discount;
END$$
DELIMITER ;
```

**Control flow reference:**

| Construct | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Declare | `DECLARE @x INT;` | `DECLARE x INT;` (top of block only) |
| Assign | `SET @x = 1;` / `SELECT @x = col ...` | `SET x = 1;` / `SELECT col INTO x ...` |
| If | `IF ... BEGIN ... END ELSE BEGIN ... END` | `IF ... THEN ... ELSEIF ... ELSE ... END IF;` |
| Loop | `WHILE ... BEGIN ... END` | `WHILE ... DO ... END WHILE;` |
| Other loops | *(none)* | `REPEAT ... UNTIL ... END REPEAT;`, `LOOP ... END LOOP;` |
| Exit a loop | `BREAK` / `CONTINUE` | `LEAVE label` / `ITERATE label` |
| Raise an error | `THROW` / `RAISERROR` | `SIGNAL SQLSTATE '45000'` |

## 37.4 💼 A complete real-world procedure

This one does real work: it checks the customer, checks and locks the stock, creates the order, reduces the stock, and handles errors — all as one all-or-nothing unit.

```sql
-- 🟥 MSSQL
CREATE OR ALTER PROCEDURE usp_create_order
    @customer_id  INT,
    @employee_id  INT,
    @product_id   INT,
    @quantity     INT,
    @new_order_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;          -- 💡 auto-rollback on any runtime error

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Validate the customer
        IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = @customer_id)
            THROW 50001, 'Customer does not exist.', 1;

        -- 2. Check stock, locking the row so nobody else takes it
        DECLARE @stock INT, @price DECIMAL(10,2);
        SELECT @stock = units_in_stock, @price = unit_price
        FROM products WITH (UPDLOCK, ROWLOCK)
        WHERE product_id = @product_id;

        IF @stock IS NULL
            THROW 50002, 'Product does not exist.', 1;
        IF @stock < @quantity
            THROW 50003, 'Insufficient stock.', 1;

        -- 3. Create the order header
        INSERT INTO orders (customer_id, employee_id, order_date, status)
        VALUES (@customer_id, @employee_id, CAST(GETDATE() AS DATE), 'Pending');

        SET @new_order_id = SCOPE_IDENTITY();

        -- 4. Add the line item
        INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount)
        VALUES (@new_order_id, @product_id, @price, @quantity, 0);

        -- 5. Reduce stock
        UPDATE products
        SET units_in_stock = units_in_stock - @quantity
        WHERE product_id = @product_id;

        COMMIT TRANSACTION;

        SELECT @new_order_id AS order_id, 'Created' AS result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        DECLARE @msg NVARCHAR(2048) = ERROR_MESSAGE();
        DECLARE @sev INT = ERROR_SEVERITY();
        RAISERROR(@msg, @sev, 1);
    END CATCH;
END;
GO
```

```sql
-- 🟦 MySQL
DELIMITER $$
CREATE PROCEDURE usp_create_order(
    IN  p_customer_id INT,
    IN  p_employee_id INT,
    IN  p_product_id  INT,
    IN  p_quantity    INT,
    OUT p_new_order_id INT
)
BEGIN
    DECLARE v_stock INT DEFAULT NULL;
    DECLARE v_price DECIMAL(10,2);

    -- Any SQL exception rolls everything back and re-raises
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist.';
    END IF;

    SELECT units_in_stock, unit_price INTO v_stock, v_price
    FROM products WHERE product_id = p_product_id FOR UPDATE;   -- row lock

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product does not exist.';
    END IF;
    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock.';
    END IF;

    INSERT INTO orders (customer_id, employee_id, order_date, status)
    VALUES (p_customer_id, p_employee_id, CURDATE(), 'Pending');

    SET p_new_order_id = LAST_INSERT_ID();

    INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount)
    VALUES (p_new_order_id, p_product_id, v_price, p_quantity, 0);

    UPDATE products SET units_in_stock = units_in_stock - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;
END$$
DELIMITER ;
```

> [!TIP]
> 💡 **Study that procedure.** It contains everything professional database code needs: input validation, explicit locking to prevent two customers buying the last item, a transaction so partial work cannot survive, and error handling that leaves no mess behind. This is what "production quality" looks like.

## 37.5 📦 Table-valued parameters — passing a LIST into a procedure

> [!NOTE]
> 📌 **In plain words:** How do you pass *"these 12 product IDs"* into a stored procedure? Beginners send a comma-separated string and split it. The proper answer in SQL Server is a **table-valued parameter**: a parameter that *is* a table.

> 🌍 **Analogy:** Instead of sliding a handwritten list under the door and hoping it is read correctly, you hand over a **proper filled-in form** with one item per line. Nothing to split apart, nothing to misread, no risk of SQL injection.

```sql
-- 🟥 MSSQL: STEP 1 — define the table TYPE once
CREATE TYPE dbo.ProductIdList AS TABLE (
    product_id INT PRIMARY KEY
);
GO

-- STEP 2 — a procedure that accepts it (READONLY is mandatory)
CREATE OR ALTER PROCEDURE usp_products_by_ids
    @ids dbo.ProductIdList READONLY
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.product_id, p.product_name, p.unit_price
    FROM products AS p
    JOIN @ids     AS i ON i.product_id = p.product_id
    ORDER BY p.product_name;
END;
GO

-- STEP 3 — call it
DECLARE @list dbo.ProductIdList;
INSERT INTO @list (product_id) VALUES (1), (5), (15);

EXEC usp_products_by_ids @ids = @list;
```

**Result:**

| product_id | product_name | unit_price |
|---|---|---|
| 1 | UltraBook Pro 14 | 1499.00 |
| 15 | VisionPanel 32 4K | 749.00 |
| 5 | Zenith Phone 12 | 899.00 |

> [!IMPORTANT]
> 🎯 **When to use a TVP:**
> - Passing a variable-length list of IDs from an application (a multi-select filter, a basket, a batch of updates)
> - Inserting a few hundred rows in **one** trip to the server instead of 300 separate `INSERT` calls
> - Anywhere you were tempted to build a comma-separated string

> [!WARNING]
> ⚠️ **The three rules that trip people up:**
> 1. The parameter **must** be declared `READONLY` — you cannot `INSERT`/`UPDATE`/`DELETE` inside the procedure.
> 2. You cannot `ALTER` a table type. To change it you must drop every procedure that uses it, drop the type, recreate both.
> 3. The optimizer has **no statistics** for a TVP and estimates a fixed row count, so plans can be poor for very large lists. For tens of thousands of rows, load into a `#temp` table instead.

> [!CAUTION]
> 🐛 **Common mistake — the comma-string anti-pattern.** Do not do this:
> ```sql
> -- ❌ 🟥 MSSQL: string splitting — slow, injection-prone, and the plan is always bad
> EXEC usp_products_by_ids @ids = '1,5,15';   -- fails: a string is not a ProductIdList
> ```
> A TVP is type-safe, parameterized, and needs no parsing. If you are on SQL Server 2016+ and genuinely cannot use a TVP, `STRING_SPLIT()` is the least-bad fallback — never string concatenation.

> 🔀 **MySQL has no table-valued parameters.** The usual workarounds are a JSON parameter unpacked into rows with `JSON_TABLE()` ([Chapter 58](#58-json-xml-and-semi-structured-data)), or writing the list into a temporary table before calling the procedure.

## 37.6 ⚖️ Should you use stored procedures?

| ✅ Arguments for | ❌ Arguments against |
|---|---|
| Logic lives next to the data — far fewer network round trips | Business logic split between app and database |
| The server remembers the execution plan and reuses it | Harder to test automatically than application code |
| Security: grant `EXECUTE` without table access | Harder to version-control and code-review |
| Applications cannot bypass your rules | Two dialects to maintain if you support both engines |
| Batch operations are dramatically faster | Debugging tools are weaker than a modern IDE |
| Applications keep calling the same name even when tables change | More users means a bigger database server — the most expensive part to grow |

> [!TIP]
> 💡 **The pragmatic middle ground most teams land on:** use stored procedures for **data-intensive** operations (bulk updates, complex reports, multi-step transactions, ETL — extracting, cleaning, and loading data between systems) where moving the logic to the data saves enormous time. Keep **business rules** in the application, where they can be tested, versioned, and reviewed properly.

## 37.7 🧭 Inspecting procedures

```sql
-- 🟥 MSSQL
SELECT name, create_date, modify_date FROM sys.procedures ORDER BY name;
EXEC sp_helptext 'usp_get_customer_orders';
SELECT OBJECT_DEFINITION(OBJECT_ID('usp_get_customer_orders'));
```

```sql
-- 🟦 MySQL
SHOW PROCEDURE STATUS WHERE Db = 'ShopDB';
SHOW CREATE PROCEDURE usp_get_customer_orders;
SELECT routine_name, routine_type FROM information_schema.routines
WHERE routine_schema = 'ShopDB';
```

## 37.8 🧪 Try it yourself

1. Write `usp_top_customers(@limit INT)` returning the top N customers by spend.
2. Write a procedure that cancels an order: sets the status, restores stock, and marks the payment refunded — atomically.
3. Write a procedure with an `OUTPUT`/`OUT` parameter returning a customer's lifetime value.
4. Add error handling that raises a clear message when the customer does not exist. Test it.

---

# 38. User-defined functions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 25 min | Create your own reusable calculations · Return a single value or a whole table · Avoid the classic function slowdown |

> [!NOTE]
> 📌 **In plain words:** A function takes inputs and **returns a value** (or a table). Unlike a procedure, you can use a function **inside a query** — in `SELECT`, `WHERE`, or `JOIN`.

> 🌍 **Analogy:** A calculator button you invent yourself. Press "add VAT" with 100, get 115 back — and you can use that button inside any sum you write.

| | Stored procedure | Function |
|---|---|---|
| Called with | `EXEC` / `CALL` | Inside a query expression |
| Returns | Result sets, output params | A single value or a table |
| Can modify data | ✅ Yes | ❌ No (it may only read) |
| Can be used in `SELECT`/`WHERE` | ❌ No | ✅ Yes |
| Can manage transactions | ✅ Yes | ❌ No |

## 38.1 🔢 Scalar functions

```sql
-- 🟥 MSSQL
CREATE OR ALTER FUNCTION fn_order_total (@order_id INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @total DECIMAL(12,2);

    SELECT @total = SUM(unit_price * quantity * (1 - discount))
    FROM order_items
    WHERE order_id = @order_id;

    RETURN ISNULL(@total, 0);
END;
GO

-- Use it anywhere a value is allowed
SELECT order_id, order_date, dbo.fn_order_total(order_id) AS order_value
FROM orders
WHERE dbo.fn_order_total(order_id) > 1000;
```

> [!WARNING]
> ⚠️ **MSSQL requires the schema prefix (`dbo.`) when calling a scalar function.** Omit it and you get *"'fn_order_total' is not a recognized built-in function name."*

```sql
-- 🟦 MySQL
DELIMITER $$
CREATE FUNCTION fn_order_total(p_order_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(12,2);

    SELECT SUM(unit_price * quantity * (1 - discount)) INTO v_total
    FROM order_items WHERE order_id = p_order_id;

    RETURN IFNULL(v_total, 0);
END$$
DELIMITER ;

SELECT order_id, fn_order_total(order_id) AS order_value FROM orders;
```

> [!WARNING]
> ⚠️ **MySQL requires you to say what kind of function it is** — whether it is *deterministic* (the same input always gives the same output) and whether it reads or changes data (`DETERMINISTIC`, `NOT DETERMINISTIC`, `READS SQL DATA`, `NO SQL`, or `MODIFIES SQL DATA`) when binary logging is on. Without it you get *"You do not have the SUPER privilege and binary logging is enabled."*

## 38.2 🐌 The scalar function performance disaster

> [!WARNING]
> ⚠️ **This is one of the most important performance lessons in this entire guide.**

```sql
-- ❌ 🟥 MSSQL: on a 1-million-row table, this calls the function ONE MILLION times.
--    Each call is a separate mini-query. The plan hides the cost entirely.
SELECT order_id, dbo.fn_order_total(order_id) FROM orders;
```

In MSSQL before 2019, a scalar UDF (user-defined function) also **forced the entire query onto a single CPU core**, so it could not split the work. A query that should take 2 seconds takes 4 minutes.

```sql
-- ✅ 🟥 MSSQL — FIX 1: rewrite as an inline table-valued function
CREATE OR ALTER FUNCTION fn_order_total_itvf (@order_id INT)
RETURNS TABLE
AS
RETURN (
    SELECT SUM(unit_price * quantity * (1 - discount)) AS order_total
    FROM order_items
    WHERE order_id = @order_id
);
GO

SELECT o.order_id, t.order_total
FROM orders o
CROSS APPLY dbo.fn_order_total_itvf(o.order_id) AS t;
```

```sql
-- ✅ FIX 2 (usually best): just write the join. No function at all.
SELECT o.order_id, SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS order_total
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id;
```

> [!TIP]
> 💡 **MSSQL 2019 introduced "scalar UDF inlining"** which automatically rewrites many scalar functions into the query. It helps enormously, but only for functions that meet its requirements. **The safe rule remains: prefer inline table-valued functions or plain joins.**

## 38.3 📊 Table-valued functions (MSSQL)

**Inline TVF (table-valued function) — the good kind.** A single `RETURN (SELECT …)`; the database merges it into your query, just like a view that accepts parameters.

```sql
-- 🟥 MSSQL
CREATE OR ALTER FUNCTION fn_customer_orders (@customer_id INT, @since DATE)
RETURNS TABLE
AS
RETURN (
    SELECT o.order_id, o.order_date, o.status
    FROM orders o
    WHERE o.customer_id = @customer_id
      AND o.order_date >= @since
);
GO

SELECT * FROM dbo.fn_customer_orders(3, '2026-01-01');

-- Use it per-row with CROSS APPLY
SELECT c.full_name, f.order_id, f.order_date
FROM customers c
CROSS APPLY dbo.fn_customer_orders(c.customer_id, '2026-01-01') AS f;
```

**Multi-statement TVF — usually the bad kind.** It fills a table variable step by step; the optimizer cannot know how many rows will come back and historically guessed **1 row**, producing terrible plans.

```sql
-- ⚠️ 🟥 MSSQL: works, but prefer an inline TVF whenever the logic allows it
CREATE OR ALTER FUNCTION fn_customer_summary (@customer_id INT)
RETURNS @result TABLE (
    order_count  INT,
    total_spend  DECIMAL(12,2),
    last_order   DATE
)
AS
BEGIN
    INSERT INTO @result
    SELECT COUNT(DISTINCT o.order_id),
           SUM(oi.unit_price * oi.quantity * (1-oi.discount)),
           MAX(o.order_date)
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.customer_id = @customer_id;

    RETURN;
END;
GO
```

> 🔀 **MySQL has no table-valued functions at all.** Use a view (for fixed logic), a stored procedure returning a result set, or a derived table.

## 38.4 🎯 Good uses for functions

```sql
-- ✅ MSSQL: pure calculation, no table access — cheap and safe
CREATE OR ALTER FUNCTION fn_add_vat (@amount DECIMAL(10,2), @rate DECIMAL(5,4))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN ROUND(@amount * (1 + @rate), 2);
END;
GO

SELECT dbo.fn_add_vat(100.00, 0.1500) AS with_vat;   -- 115.00
```

```sql
-- ✅ MySQL: the same function
DELIMITER $$
CREATE FUNCTION fn_add_vat(p_amount DECIMAL(10,2), p_rate DECIMAL(5,4))
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL
BEGIN
    RETURN ROUND(p_amount * (1 + p_rate), 2);
END$$
DELIMITER ;

SELECT fn_add_vat(100.00, 0.1500) AS with_vat;       -- 115.00
```

> [!IMPORTANT]
> 🎯 **Use a function when:** the logic is a pure calculation, it is used in many places, and centralizing it prevents inconsistency. **Avoid a function when:** it queries tables and will be called once per row of a large result — write the join instead.

## 38.5 🧪 Try it yourself

1. Write `fn_days_to_ship(order_id)` returning the shipping duration, or NULL if unshipped.
2. Write a function that returns a customer's loyalty discount rate.
3. In MSSQL, write both a scalar and an inline TVF version of "order total", then compare execution plans on all 23 orders.
4. Explain in one sentence why the scalar version scales worse.

---
# 39. Triggers

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 30 min | Run code automatically when data changes · Build an audit trail · Handle many rows at once · Decide when NOT to use a trigger |

> [!NOTE]
> 📌 **In plain words:** A trigger is code that the database runs **automatically** when someone inserts, updates, or deletes a row. Nobody calls it. It just fires.

> 🌍 **Analogy:** A **motion-sensor light**. You do not flip a switch; walking into the room *is* the switch. Triggers are powerful for the same reason they are dangerous — things happen that are not visible in the code you are reading.

## 39.1 ✍️ Creating triggers

```sql
-- 🟥 MSSQL: fires ONCE per statement and sees two built-in tables: inserted (new values) and deleted (old values)
CREATE OR ALTER TRIGGER trg_products_audit
ON products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO product_price_history (product_id, old_price, new_price, changed_at, changed_by)
    SELECT
        i.product_id,
        d.unit_price,
        i.unit_price,
        SYSDATETIME(),
        SUSER_SNAME()
    FROM inserted AS i
    JOIN deleted  AS d ON d.product_id = i.product_id
    WHERE i.unit_price <> d.unit_price;      -- only log actual price changes
END;
GO
```

```sql
-- 🟦 MySQL: triggers are ROW-level and use OLD / NEW
DELIMITER $$
CREATE TRIGGER trg_products_audit
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.unit_price <> NEW.unit_price THEN
        INSERT INTO product_price_history (product_id, old_price, new_price, changed_at, changed_by)
        VALUES (NEW.product_id, OLD.unit_price, NEW.unit_price, NOW(), CURRENT_USER());
    END IF;
END$$
DELIMITER ;
```

**The supporting table:**

```sql
-- ✅ MSSQL
CREATE TABLE product_price_history (
    history_id  INT IDENTITY(1,1) PRIMARY KEY,
    product_id  INT NOT NULL,
    old_price   DECIMAL(10,2),
    new_price   DECIMAL(10,2),
    changed_at  DATETIME2(0) NOT NULL,
    changed_by  VARCHAR(128) NOT NULL
);
```

```sql
-- ✅ MySQL
CREATE TABLE product_price_history (
    history_id  INT AUTO_INCREMENT PRIMARY KEY,
    product_id  INT NOT NULL,
    old_price   DECIMAL(10,2),
    new_price   DECIMAL(10,2),
    changed_at  DATETIME NOT NULL,
    changed_by  VARCHAR(128) NOT NULL
) ENGINE=InnoDB;
```

## 39.2 🔀 The critical difference: statement-level vs row-level

> [!WARNING]
> ⚠️ **This is the single most important thing to understand about triggers across the two engines.**

| | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Fires | **Once per statement** | **Once per row** |
| Access to data | `inserted` and `deleted` **tables** | `NEW.col` and `OLD.col` **values** |
| Updating 1000 rows | Trigger runs **1 time**, sees 1000 rows | Trigger runs **1000 times** |

```sql
-- 🟥 MSSQL: THIS IS A BUG — it only handles ONE row correctly
CREATE TRIGGER trg_bad ON products AFTER UPDATE AS
BEGIN
    DECLARE @id INT;
    SELECT @id = product_id FROM inserted;    -- ❌ if 50 rows changed, @id gets ONE arbitrary one
    UPDATE something SET x = 1 WHERE id = @id;
END;
GO

DROP TRIGGER trg_bad;   -- demonstration only: never leave this trigger behind
```

> [!TIP]
> 💡 **The MSSQL rule: always write triggers that handle all rows at once (*set-based*).** Assume `inserted` and `deleted` contain many rows. Never use a variable to hold "the" row, and never use a cursor. Write `INSERT ... SELECT ... FROM inserted` instead.

## 39.3 ⏱️ Trigger timing

| Timing | 🟥 MSSQL | 🟦 MySQL | What it can do |
|---|---|---|---|
| Before the change | `INSTEAD OF` | `BEFORE INSERT/UPDATE/DELETE` | Validate, modify values, cancel |
| After the change | `AFTER` (= `FOR`) | `AFTER INSERT/UPDATE/DELETE` | Audit, cascade, notify |

```sql
-- 🟦 MySQL BEFORE trigger: modify the value on its way in
DELIMITER $$
CREATE TRIGGER trg_customers_normalize
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(TRIM(NEW.email));
    SET NEW.full_name = TRIM(NEW.full_name);
    IF NEW.signup_date IS NULL THEN
        SET NEW.signup_date = CURDATE();
    END IF;
END$$
DELIMITER ;
```

> 🔀 **MSSQL has no `BEFORE` trigger.** Its `INSTEAD OF` trigger replaces the operation entirely — you must perform the insert yourself inside the trigger. It is most useful for making a non-updatable view updatable.

```sql
-- 🟥 MSSQL INSTEAD OF: give a view a custom insert behaviour

-- ⚠️ The trigger can only read columns the VIEW exposes. `inserted` has the
--    view's shape, not the table's — so the view must contain every column
--    the trigger needs. This view deliberately includes email.
CREATE OR ALTER VIEW v_customer_signup AS
SELECT customer_id, full_name, email, city, country
FROM customers;
GO

CREATE OR ALTER TRIGGER trg_v_customer_signup_insert
ON v_customer_signup
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO customers (full_name, email, city, country)
    SELECT
        LTRIM(RTRIM(i.full_name)),
        LOWER(LTRIM(RTRIM(i.email))),      -- normalized on the way in
        i.city,
        i.country
    FROM inserted AS i;
END;
GO

-- The insert names the view; the trigger rewrites it against the base table
INSERT INTO v_customer_signup (full_name, email, city, country)
VALUES ('  Nadia Haddad ', '  NADIA.HADDAD@Example.COM ', 'Beirut', 'Lebanon');

SELECT full_name, email FROM customers WHERE country = 'Lebanon';
-- → 'Nadia Haddad' | 'nadia.haddad@example.com'
```

> [!CAUTION]
> 🐛 **Common mistake:** writing an `INSTEAD OF` trigger that reads a column the view does not select. `inserted` and `deleted` take the shape of the **view**, not the underlying table, so referencing `email` on a view that hides `email` fails with *"Invalid column name 'email'"*. If the base table has a `NOT NULL` column the view hides, an insert through that view can never succeed — either expose the column or give it a default.

## 39.4 💼 Real-world trigger uses

**① Audit trail — who changed what, and when**

```sql
-- 🟥 MSSQL: capture every change to orders
CREATE TABLE orders_audit (
    audit_id    INT IDENTITY(1,1) PRIMARY KEY,
    order_id    INT           NOT NULL,
    action      VARCHAR(10)   NOT NULL,
    old_status  VARCHAR(20)   NULL,
    new_status  VARCHAR(20)   NULL,
    changed_at  DATETIME2(0)  NOT NULL,
    changed_by  NVARCHAR(128) NOT NULL
);
GO

CREATE OR ALTER TRIGGER trg_orders_audit
ON orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT: rows in inserted, none in deleted
    INSERT INTO orders_audit (order_id, action, old_status, new_status, changed_at, changed_by)
    SELECT i.order_id, 'INSERT', NULL, i.status, SYSDATETIME(), SUSER_SNAME()
    FROM inserted i
    WHERE NOT EXISTS (SELECT 1 FROM deleted d WHERE d.order_id = i.order_id);

    -- UPDATE: rows in both
    INSERT INTO orders_audit (order_id, action, old_status, new_status, changed_at, changed_by)
    SELECT i.order_id, 'UPDATE', d.status, i.status, SYSDATETIME(), SUSER_SNAME()
    FROM inserted i
    JOIN deleted  d ON d.order_id = i.order_id
    WHERE i.status <> d.status;

    -- DELETE: rows in deleted, none in inserted
    INSERT INTO orders_audit (order_id, action, old_status, new_status, changed_at, changed_by)
    SELECT d.order_id, 'DELETE', d.status, NULL, SYSDATETIME(), SUSER_SNAME()
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.order_id = d.order_id);
END;
GO
```

> [!TIP]
> 💡 **How to tell which operation fired the trigger in MSSQL:**
> - Rows in `inserted` only → `INSERT`
> - Rows in both → `UPDATE`
> - Rows in `deleted` only → `DELETE`

**② Keeping a calculated value up to date**

```sql
-- 🟦 MySQL: keep stock in sync when order items change
DELIMITER $$
CREATE TRIGGER trg_order_items_stock_out
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET units_in_stock = units_in_stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$

CREATE TRIGGER trg_order_items_stock_return
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET units_in_stock = units_in_stock + OLD.quantity
    WHERE product_id = OLD.product_id;
END$$
DELIMITER ;
```

**③ Enforcing a rule a `CHECK` constraint cannot express**

```sql
-- 🟦 MySQL: block orders from customers with unpaid old orders
DELIMITER $$
CREATE TRIGGER trg_orders_credit_check
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE v_unpaid INT;

    SELECT COUNT(*) INTO v_unpaid
    FROM orders o
    LEFT JOIN payments p ON p.order_id = o.order_id AND p.status = 'Captured'
    WHERE o.customer_id = NEW.customer_id
      AND o.order_date < DATE_SUB(CURDATE(), INTERVAL 60 DAY)
      AND p.payment_id IS NULL;

    IF v_unpaid > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Customer has unpaid orders older than 60 days.';
    END IF;
END$$
DELIMITER ;
```

## 39.5 ⚠️ Why experienced engineers are cautious with triggers

| Problem | Why it hurts |
|---|---|
| **Invisible** | A simple `UPDATE` fires code nobody reading the statement can see |
| **Hard to debug** | You cannot step through them; failures surface far from the cause |
| **Performance** | Every write pays the trigger cost, forever |
| **Cascading chains** | Trigger A updates a table, firing trigger B, firing trigger C… |
| **Recursion** | A trigger on `products` that updates `products` can loop |
| **Bulk operations** | `TRUNCATE` and bulk loads bypass triggers entirely — your audit silently has holes |
| **Transaction scope** | An error inside a trigger rolls back the *whole* outer transaction |

> [!WARNING]
> ⚠️ **The bulk-load hole is a real problem on live systems.** If a legally required audit depends on a trigger, and someone loads data with `BULK INSERT` or `LOAD DATA INFILE`, those rows are never audited. Verify how data enters your system before relying on triggers for compliance.

> [!TIP]
> 💡 **Modern alternatives to consider first:**
> - **Auditing:** MSSQL **temporal tables** (`SYSTEM_VERSIONING`, which keep every old version of each row automatically), Change Data Capture, or tools that read MySQL's binary log — all more reliable than hand-written triggers.
> - **Derived values:** computed/generated columns ([Chapter 41](#41-sequences-and-generated-columns)) or a scheduled recalculation.
> - **Validation:** `CHECK` constraints and foreign keys, which the optimizer understands and cannot be bypassed.
> - **Business rules:** the application or a stored procedure, where they are testable and visible.

## 39.6 🧭 Managing triggers

```sql
-- 🟥 MSSQL
SELECT t.name AS trigger_name, OBJECT_NAME(t.parent_id) AS table_name, t.is_disabled
FROM sys.triggers t WHERE t.parent_class = 1;

DISABLE TRIGGER trg_products_audit ON products;
ENABLE  TRIGGER trg_products_audit ON products;
DROP TRIGGER IF EXISTS trg_products_audit;
```

```sql
-- 🟦 MySQL
SHOW TRIGGERS FROM ShopDB;
SELECT trigger_name, event_manipulation, event_object_table, action_timing
FROM information_schema.triggers WHERE trigger_schema = 'ShopDB';

DROP TRIGGER IF EXISTS trg_products_audit;
-- MySQL has no DISABLE; you must drop and recreate
```

## 39.7 🎯 When a trigger is the right answer

| Requirement | Trigger? | Better option |
|---|---|---|
| Audit every change to a table | ⚠️ Works | **Temporal tables** 🟥 / CDC / binlog — cannot be bypassed by bulk loads |
| Keep a derived column in sync | ❌ No | A **computed/generated column** ([Ch 41](#41-sequences-and-generated-columns)) |
| Enforce "price must be ≥ 0" | ❌ No | A `CHECK` constraint — the optimizer understands it |
| Enforce "child must exist" | ❌ No | A **foreign key** |
| Enforce a rule spanning **other tables** | ✅ Yes | (a `CHECK` cannot see other tables) |
| Normalize input (lowercase an email) | ✅ `BEFORE` trigger 🟦 | Or do it in the application |
| Make a joined view updatable | ✅ `INSTEAD OF` trigger 🟥 | |
| Send an email / call an API | ❌ **Never** | Write to a queue table; process it outside |

## 39.8 🧪 Try it yourself

1. Build the `product_price_history` table and its trigger, then change a price and check the log.
2. In MSSQL, update **5 products at once** and verify your trigger logged all 5, not 1.
3. Write a `BEFORE INSERT` trigger (MySQL) that lowercases emails. Test it.
4. Write a trigger that prevents deleting a product that has ever been ordered.
5. Explain in one sentence why a `TRUNCATE` would defeat your audit trigger.

---

# 40. Temporary tables and table variables

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 20 min | Store in-between results · Choose between `#temp`, `@table`, and a CTE · Break a huge query into simple steps |

> [!NOTE]
> 📌 **In plain words:** Sometimes a query is too complex for one statement. Temporary tables let you store in-between results, work with them, and throw them away when your connection ends.

> 🌍 **Analogy:** Scrap paper while doing a long sum. You write the half-way answers down, use them for the next step, and throw the paper away when you are finished.

## 40.1 🟥 MSSQL temporary tables

```sql
-- LOCAL temp table: visible only to YOUR session, dropped when it ends
CREATE TABLE #customer_spend (
    customer_id  INT PRIMARY KEY,
    full_name    NVARCHAR(100),
    total_spend  DECIMAL(12,2),
    order_count  INT
);

INSERT INTO #customer_spend (customer_id, full_name, total_spend, order_count)
SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount)),
    COUNT(DISTINCT o.order_id)
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.customer_id, c.full_name;

-- 💡 You can index a temp table — a big advantage over CTEs
CREATE INDEX ix_temp_spend ON #customer_spend(total_spend DESC);

-- Use it repeatedly, cheaply
SELECT TOP 5 * FROM #customer_spend ORDER BY total_spend DESC;
SELECT AVG(total_spend) FROM #customer_spend;
SELECT * FROM #customer_spend WHERE order_count >= 3;

DROP TABLE #customer_spend;
```

```sql
-- Shortcut: SELECT INTO creates the temp table for you
SELECT c.customer_id, c.full_name, SUM(oi.quantity) AS units
INTO #quick_temp
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.full_name;
```

| Object | Who can see it | How long it lives |
|---|---|---|
| `#table` | Your session only | Until the session ends or you drop it |
| `##table` | **All** sessions (global) | Until the creating session ends |
| `@table` (table variable) | The current batch only | Ends with the batch |

## 40.2 🟥 MSSQL table variables

```sql
DECLARE @top_products TABLE (
    product_id   INT PRIMARY KEY,
    product_name NVARCHAR(120),
    units_sold   INT
);

INSERT INTO @top_products
SELECT TOP 5 p.product_id, p.product_name, SUM(oi.quantity)
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY SUM(oi.quantity) DESC;

SELECT * FROM @top_products;
```

| | `#temp` table | `@table` variable |
|---|---|---|
| Statistics | ✅ Yes — good plans | ❌ No — historically estimated as **1 row** |
| Indexes | ✅ Can add any index | ⚠️ Only constraints declared inline |
| Transactions | ✅ Participates, rolls back | ❌ Survives a rollback |
| Re-planning (recompiles) | Can trigger it | Less often |
| Best for | **More than ~100 rows** | **Small sets** (under ~100 rows) |

> [!TIP]
> 💡 **The practical rule:** small result → table variable; large or joined-heavily → `#temp` table with an index. The old advice that "table variables live in memory" is a **myth** — both live in `tempdb` (SQL Server's shared scratch database). The real difference is statistics.

## 40.3 🟦 MySQL temporary tables

```sql
-- Session-scoped, auto-dropped at disconnect
CREATE TEMPORARY TABLE tmp_customer_spend (
    customer_id  INT PRIMARY KEY,
    full_name    VARCHAR(100),
    total_spend  DECIMAL(12,2),
    order_count  INT
) ENGINE=InnoDB;

INSERT INTO tmp_customer_spend
SELECT
    c.customer_id, c.full_name,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount)),
    COUNT(DISTINCT o.order_id)
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered','Shipped')
GROUP BY c.customer_id, c.full_name;

CREATE INDEX ix_tmp_spend ON tmp_customer_spend(total_spend);

SELECT * FROM tmp_customer_spend ORDER BY total_spend DESC LIMIT 5;

DROP TEMPORARY TABLE IF EXISTS tmp_customer_spend;
```

```sql
-- Or create it directly from a query
CREATE TEMPORARY TABLE tmp_quick AS
SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id;
```

> [!WARNING]
> ⚠️ **The MySQL temporary-table limitation that surprises everyone:** you **cannot reference the same temporary table twice in one query**. This fails:
> ```sql
> -- 🟦 MySQL
> CREATE TEMPORARY TABLE tmp_a (x INT);
> SELECT * FROM tmp_a WHERE x IN (SELECT x FROM tmp_a);   -- ERROR 1137
> ```
> The workaround is to create a second temporary table with the same content, or use a CTE.

> [!WARNING]
> ⚠️ **A MySQL temporary table can hide a real table with the same name.** If you have a real `orders` table and create `TEMPORARY TABLE orders`, every subsequent query in that session silently hits the temporary one. **Always prefix temp tables with `tmp_`.**

## 40.4 🧭 Choosing the right tool

```text
Do you need the result more than once in the SAME query?
  └─ No  → just use a derived table or subquery
  └─ Yes ↓

Is the intermediate result small (under ~100 rows)?
  └─ Yes → CTE (readable) or table variable (MSSQL)
  └─ No  ↓

Do you need an index or statistics on it?
  └─ Yes → temp table (#temp / CREATE TEMPORARY TABLE)
  └─ No  → CTE is fine

Do you need it across multiple statements or procedures?
  └─ Yes → temp table
```

> [!TIP]
> 💡 **A frequently overlooked win:** breaking one monstrous 200-line query into three steps with `#temp` tables often runs **faster** than the single query, because the optimizer knows the real row count at each step, instead of piling guess upon guess across ten joins.

## 40.5 🧪 Try it yourself

1. Build a temp table of customer lifetime values, index it, and query it three different ways.
2. In MSSQL, compare `#temp` vs `@table` for the same 1000-row dataset and inspect both plans.
3. In MySQL, try referencing a temporary table twice in one query and read the error.
4. Split a complex 4-join report into two temp-table steps and compare the timings.

---

# 41. Sequences and generated columns

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 20 min | Hand out numbers from a shared counter · Let the database calculate columns for you · Make an expression searchable with an index |

> [!NOTE]
> 📌 **In plain words:** Two ways to let the database fill in values for you. A **sequence** hands out the next number in a series. A **generated column** calculates its own value from other columns in the same row.

> 🌍 **Analogy:** A sequence is the ticket machine at a deli counter — every customer pulls the next number. A generated column is the "total" box on a form that fills itself in as soon as you enter the price and quantity.

## 41.1 🔢 Sequences — shared, independent counters

> [!NOTE]
> 📌 **In plain words:** A sequence is a number generator that lives **outside** any table. Several tables can draw from the same sequence, and you can get a number *before* inserting a row.

```sql
-- 🟥 MSSQL (2012+)
CREATE SEQUENCE seq_invoice_number
    AS BIGINT
    START WITH 100000
    INCREMENT BY 1
    MINVALUE 100000
    MAXVALUE 999999999
    NO CYCLE
    CACHE 50;                  -- keep 50 numbers ready in memory, for speed (a crash may skip some)

GO

-- Get the next value
SELECT NEXT VALUE FOR seq_invoice_number AS invoice_no;
GO

-- ⚠️ This is a DIFFERENT table from the `invoices` used in Chapter 10 —
--    that one demonstrated IDENTITY. A sequence-driven table needs its own DDL.
CREATE TABLE sales_invoices (
    invoice_no  BIGINT        NOT NULL PRIMARY KEY,
    order_id    INT           NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    issued_at   DATETIME2(0)  NOT NULL DEFAULT SYSDATETIME()
);
GO

-- Use the sequence explicitly in an INSERT
INSERT INTO sales_invoices (invoice_no, order_id, amount)
VALUES (NEXT VALUE FOR seq_invoice_number, 1002, 3757.10);

-- Or wire it up as the column default, so you never mention it again
ALTER TABLE sales_invoices
    ADD CONSTRAINT df_invoice_no
    DEFAULT (NEXT VALUE FOR seq_invoice_number) FOR invoice_no;
GO

INSERT INTO sales_invoices (order_id, amount) VALUES (1019, 2352.05);
SELECT invoice_no, order_id, amount FROM sales_invoices ORDER BY invoice_no;
GO

-- Manage it
ALTER SEQUENCE seq_invoice_number RESTART WITH 200000;
-- DROP SEQUENCE seq_invoice_number;   -- fails while the default still references it
```

**Result:**

| invoice_no | order_id | amount |
|---|---|---|
| 100001 | 1002 | 3757.10 |
| 100002 | 1019 | 2352.05 |

> [!WARNING]
> ⚠️ **You cannot drop a sequence that a `DEFAULT` constraint still references.** Drop the constraint first (`ALTER TABLE sales_invoices DROP CONSTRAINT df_invoice_no;`), then the sequence.

> 🔀 **MySQL has no `CREATE SEQUENCE`.** Imitate it with a small counter table:

```sql
-- 🟦 MySQL: a table that imitates a sequence
CREATE TABLE sequences (
    seq_name   VARCHAR(64) PRIMARY KEY,
    seq_value  BIGINT NOT NULL
) ENGINE=InnoDB;

INSERT INTO sequences VALUES ('invoice_number', 100000);

-- A procedure, not a function: with binary logging on (the MySQL 8 default), a function
-- that modifies data is rejected with ERROR 1418 unless an administrator enables
-- log_bin_trust_function_creators. A procedure has no such restriction.
DELIMITER $$
CREATE PROCEDURE next_sequence_value(IN p_name VARCHAR(64), OUT p_value BIGINT)
BEGIN
    UPDATE sequences SET seq_value = LAST_INSERT_ID(seq_value + 1)
    WHERE seq_name = p_name;
    SET p_value = LAST_INSERT_ID();
END$$
DELIMITER ;

CALL next_sequence_value('invoice_number', @next);
SELECT @next AS invoice_no;       -- 100001
```

> [!TIP]
> 💡 **The `LAST_INSERT_ID(expr)` trick.** Passing a value to `LAST_INSERT_ID()` stores it for **your connection only**, in the same step as the update. Two users calling at the same moment can never receive the same number. It is the standard MySQL way to build a sequence.

| | `IDENTITY` / `AUTO_INCREMENT` | Sequence |
|---|---|---|
| Belongs to | One table, one column | The database — shared by many tables |
| Get a value before inserting | ❌ No | ✅ Yes |
| Reuse the same series across tables | ❌ No | ✅ Yes |
| MySQL support | ✅ Built in | ⚠️ Imitated with a table |

> [!IMPORTANT]
> 🎯 **When a sequence genuinely helps:** a single document-number series shared by invoices, credit notes, and receipts; or when the application needs the ID *before* the insert (to build a file name, a URL, or child rows).

## 41.2 🧮 Computed and generated columns

> [!NOTE]
> 📌 **In plain words:** A column whose value is **calculated from other columns** instead of being stored by you. You never insert into it; the database keeps it correct forever.

```sql
-- 🟥 MSSQL: computed columns
CREATE TABLE order_lines_demo (
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    quantity    INT NOT NULL,
    discount    DECIMAL(4,3) NOT NULL DEFAULT 0,

    -- VIRTUAL: computed on every read, no storage used
    gross_total AS (unit_price * quantity),

    -- PERSISTED: physically stored, so reading it costs nothing extra
    net_total   AS (unit_price * quantity * (1 - discount)) PERSISTED,

    CONSTRAINT pk_old PRIMARY KEY (order_id, product_id)
);

-- Computed columns can be indexed (see the rules in the warning below):
CREATE INDEX ix_old_net_total ON order_lines_demo(net_total);
```

```sql
-- 🟦 MySQL 5.7+: generated columns
CREATE TABLE order_lines_demo (
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    quantity    INT NOT NULL,
    discount    DECIMAL(4,3) NOT NULL DEFAULT 0,

    gross_total DECIMAL(12,2) AS (unit_price * quantity) VIRTUAL,
    net_total   DECIMAL(12,2) AS (unit_price * quantity * (1 - discount)) STORED,

    PRIMARY KEY (order_id, product_id)
) ENGINE=InnoDB;

CREATE INDEX ix_old_net_total ON order_lines_demo(net_total);
```

| | `VIRTUAL` | `PERSISTED` / `STORED` |
|---|---|---|
| Storage used | None | Yes |
| Computed | On every read | On write |
| Can be indexed | ✅ Yes, if the calculation is deterministic (MSSQL: and not `FLOAT`-based) | ✅ Yes |
| Write cost | None | Small |
| Best for | Cheap expressions read rarely | Expensive expressions, or ones you filter and sort on |

**A genuinely powerful use — indexing a case-insensitive search key:**

```sql
-- 🟦 MySQL: make LOWER(email) searchable via an index
ALTER TABLE customers
    ADD COLUMN email_lower VARCHAR(150)
        AS (LOWER(email)) STORED,
    ADD INDEX ix_customers_email_lower (email_lower);

-- Now this search can use the index instead of reading the whole table:
SELECT * FROM customers WHERE email_lower = 'amara.silva@example.com';
```

```sql
-- 🟥 MSSQL: the same idea
ALTER TABLE customers ADD email_lower AS (LOWER(email)) PERSISTED;
CREATE INDEX ix_customers_email_lower ON customers(email_lower);
```

> [!TIP]
> 💡 **This is the standard cure for the "a function on a column stops the index being used" problem** from [Chapter 48](#48-query-optimization-and-sargability). You cannot index `LOWER(email)` directly, but you *can* store it as a computed column and index that.

> [!WARNING]
> ⚠️ **Computed columns must be deterministic** — the same inputs must always give the same output. `GETDATE()` or `RAND()` are not allowed. In MSSQL, a computed column can be `PERSISTED` only if it is deterministic, and indexed only if it is deterministic **and** either precise (no `FLOAT`) or `PERSISTED`.

## 41.3 🧪 Try it yourself

1. Add a persisted/stored `line_total` column to `order_items` and index it.
2. Create a sequence (MSSQL) or sequence table (MySQL) for invoice numbers and draw five values.
3. Add a `full_name_upper` computed column to `customers` and index it. Verify with `EXPLAIN` that a search on it seeks rather than scans.
4. Try to create a computed column using `GETDATE()`. Read the error and explain it.

---
# 🔐 PART 9 — TRANSACTIONS AND INTEGRITY

---

# 42. Transactions and ACID

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 30 min | Group changes into all-or-nothing units · Use savepoints · Explain ACID in plain words · Know which statements cannot be undone |

> [!NOTE]
> 📌 **In plain words:** A transaction is a group of changes that **all succeed together or all fail together**. There is no halfway.

> 🌍 **Analogy:** A **bank transfer**. Money leaves account A and arrives in account B. If the power fails between those two steps, you must not end up in a world where the money left A but never reached B. A transaction guarantees that world cannot exist.

## 42.1 💸 The classic example

```sql
-- ✅ Works in BOTH: a two-account table to try this on
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    balance    DECIMAL(12,2) NOT NULL
);
INSERT INTO accounts (account_id, balance) VALUES (1, 1000.00), (2, 250.00);
```

```sql
-- 🟥 MSSQL
BEGIN TRANSACTION;

    UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
    UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

COMMIT;                     -- both changes become permanent
-- ROLLBACK;                -- OR both changes are undone
```

```sql
-- 🟦 MySQL: identical, except the transaction starts with START TRANSACTION
START TRANSACTION;

    UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
    UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

COMMIT;
```

Without a transaction, a crash between those two statements destroys 500 units of money. With one, either both happen or neither does.

```sql
-- ✅ 🟥 MSSQL — a real ShopDB transaction: place an order and take stock, all or nothing
BEGIN TRANSACTION;

    INSERT INTO orders (customer_id, employee_id, order_date, status)
    VALUES (1, 3, '2026-09-09', 'Paid');

    INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount)
    VALUES (SCOPE_IDENTITY(), 5, 899.00, 1, 0);       -- the order_id just generated

    UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = 5;

COMMIT;
```

```sql
-- ✅ 🟦 MySQL — the same transaction
START TRANSACTION;

    INSERT INTO orders (customer_id, employee_id, order_date, status)
    VALUES (1, 3, '2026-09-09', 'Paid');

    INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount)
    VALUES (LAST_INSERT_ID(), 5, 899.00, 1, 0);       -- the order_id just generated

    UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = 5;

COMMIT;
```

> [!NOTE]
> 📌 **Why this must be one transaction:** if the stock update failed after the order was created, you would have sold an item you do not have. If the order insert succeeded but the item insert failed, you would have an empty order. Only all-or-nothing is correct.

## 42.2 🏛️ ACID — the four guarantees

| Letter | Property | Plain-English meaning | What breaks without it |
|:---:|---|---|---|
| **A** | **Atomicity** | All the steps happen, or none do | Money leaves one account and vanishes |
| **C** | **Consistency** | The data follows all your rules (constraints) before and after every change | Orders reference customers who do not exist |
| **I** | **Isolation** | Transactions running at the same time do not mess up each other's work | Two people buy the last item |
| **D** | **Durability** | Once committed, it survives a crash | A confirmed payment disappears after a reboot |

> 🌍 **Analogies:**
> - **Atomicity** — a light switch. On or off. Never "half on."
> - **Consistency** — chess rules. Every move leaves a legal board position.
> - **Isolation** — restaurant tables. Diners at one table do not eat from another table's plates.
> - **Durability** — writing in permanent ink. Once written, it stays written.

> [!IMPORTANT]
> 🎯 **When do I actually need to write `BEGIN TRANSACTION`?** Every single statement is *already* atomic on its own, so you only need an explicit transaction when **two or more statements must succeed or fail together**:
>
> | Situation | Transaction needed? |
> |---|---|
> | One `UPDATE`, one `INSERT`, one `DELETE` | ❌ No — already atomic |
> | Insert an order **and** its line items | ✅ Yes |
> | Move money / stock from one row to another | ✅ Yes |
> | Insert a parent then its children | ✅ Yes |
> | Any `UPDATE`/`DELETE` you type by hand on a live (*production*) server | ✅ **Yes** — as an undo button |
> | A read-only `SELECT` | ❌ No (unless several queries must see exactly the same data) |
> | A long report | ❌ No — and never inside a write transaction |
>
> 🐛 **Common mistake:** wrapping a single `UPDATE` in a transaction "to be safe" in application code and then forgetting to commit. The locks stay held, other users pile up behind it, and the app appears frozen. One statement needs no transaction — the engine already gives you one.

## 42.3 ⚙️ Transaction syntax

```sql
-- 🟥 MSSQL
BEGIN TRANSACTION;              -- or BEGIN TRAN
    -- statements
COMMIT TRANSACTION;             -- or COMMIT
    -- or ROLLBACK TRANSACTION;

-- Named transactions and savepoints (a savepoint = a bookmark you can roll back to)
BEGIN TRANSACTION order_creation;
    SAVE TRANSACTION before_items;
    -- ...
    ROLLBACK TRANSACTION before_items;      -- undo back to the savepoint only
COMMIT TRANSACTION order_creation;

SELECT @@TRANCOUNT AS open_transactions;    -- how deeply nested am I?
```

```sql
-- 🟦 MySQL
START TRANSACTION;              -- or BEGIN
    -- statements
COMMIT;
    -- or ROLLBACK;

-- Savepoints
START TRANSACTION;
    INSERT INTO orders (customer_id, order_date) VALUES (1, CURDATE());
    SAVEPOINT after_order;

    INSERT INTO order_items (order_id, product_id, unit_price, quantity)
    VALUES (LAST_INSERT_ID(), 999, 10.00, 1);      -- fails: no product 999

    ROLLBACK TO SAVEPOINT after_order;             -- keep the order, drop the item
    RELEASE SAVEPOINT after_order;                 -- optional: COMMIT releases it anyway
COMMIT;
```

## 42.4 🔄 Autocommit — the default nobody notices

```sql
-- By default, BOTH engines run in autocommit mode (each statement is saved the moment it finishes):
UPDATE products SET unit_price = 1399 WHERE product_id = 1;
-- ⚡ Already committed. No undo. This was its own transaction.
```

```sql
-- 🟦 MySQL: turn autocommit off for a session
SET autocommit = 0;
    UPDATE products SET unit_price = 1399 WHERE product_id = 1;
    -- nothing is permanent yet
COMMIT;    -- or ROLLBACK
SET autocommit = 1;
```

```sql
-- 🟥 MSSQL: implicit transactions
SET IMPLICIT_TRANSACTIONS ON;
    UPDATE products SET unit_price = 1399 WHERE product_id = 1;
COMMIT;
```

> [!WARNING]
> ⚠️ **The habit that saves careers:** on production, type `BEGIN TRANSACTION` **before** you type the `UPDATE` or `DELETE`. Run it, check the affected row count and a verification `SELECT`, and only then `COMMIT`. It costs three seconds and buys you an undo button.

> [!WARNING]
> ⚠️ **But do not leave a transaction open while you go to lunch.** An uncommitted transaction holds locks. Other users wait behind it, the application runs out of free connections, and it appears to hang. Open, verify, commit — within seconds.

## 42.5 💥 DDL and implicit commits

> [!WARNING]
> ⚠️ **A crucial difference between the engines.** *DDL* (Data Definition Language) means the statements that change structure: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.

```sql
-- 🟦 MySQL: DDL causes an IMPLICIT COMMIT. This cannot be rolled back:
START TRANSACTION;
    INSERT INTO categories (category_name) VALUES ('Test');
    CREATE TABLE oops (id INT);      -- 💥 implicitly commits the INSERT above!
ROLLBACK;                            -- too late — 'Test' is permanent
```

```sql
-- 🟥 MSSQL: DDL IS transactional. This works as you would hope:
BEGIN TRANSACTION;
    CREATE TABLE oops (id INT);
    INSERT INTO oops VALUES (1);
ROLLBACK;    -- ✅ the table never existed
```

> [!TIP]
> 💡 **This is one of MSSQL's genuinely nicer features** — you can test a schema migration inside a transaction and roll it back if anything looks wrong. In MySQL you must be far more careful, because `CREATE`, `ALTER`, `DROP`, and `TRUNCATE` all commit implicitly.

## 42.6 📓 How durability actually works

Both engines use **write-ahead logging (WAL)** — every change is written to a log file **before** the main data files are updated:

```text
1. You COMMIT
2. The change is written to the TRANSACTION LOG on disk  ← durability point
3. The client is told "committed"
4. Later, a background process writes the data pages to the data files

If the server crashes between 3 and 4:
   → on restart, the engine REPLAYS the log and reapplies your change.
   → nothing is lost.
```

| | 🟥 MSSQL | 🟦 MySQL / InnoDB |
|---|---|---|
| Log name | Transaction log (`.ldf`) | Redo log (`ib_logfile`) + binary log |
| Durability setting | Delayed durability (optional) | `innodb_flush_log_at_trx_commit` |
| Full durability | Default | `= 1` (default) |

> [!WARNING]
> ⚠️ **`innodb_flush_log_at_trx_commit = 2` or `0` makes MySQL much faster and gives up the D in ACID.** It is a legitimate choice for a cache or an analytics replica (a read-only copy of the database on another server); it is **never** acceptable for financial data. Know which one your server is set to.

## 42.7 🎯 Best practices

| ✅ Do | ❌ Do not |
|---|---|
| Keep transactions **short** | Hold one open across user interaction |
| Touch tables in a **consistent order** everywhere | Vary the order (this creates deadlocks) |
| Handle errors and roll back explicitly | Assume an error auto-rolls back (it often does not) |
| Read only what you need inside the transaction | Run a 10-minute report inside a write transaction |
| Set an appropriate isolation level | Use `SERIALIZABLE` "to be safe" everywhere |
| Test the rollback path | Only test the happy path |

```sql
-- ✅ 🟥 MSSQL — the safe pattern, worth memorizing
SET XACT_ABORT ON;      -- any runtime error aborts and rolls back the transaction

BEGIN TRY
    BEGIN TRANSACTION;
        -- your work here
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;              -- re-raise so the caller knows it failed
END CATCH;
```

> [!WARNING]
> ⚠️ **Without `SET XACT_ABORT ON`, some MSSQL errors leave the transaction open and "doomed"** — you cannot commit it, and if the client disconnects without rolling back, locks are held until the connection is cleaned up. **Always turn it on in procedures that write data.**

## 42.8 🧪 Try it yourself

1. Start a transaction, delete all of `order_items`, run a `SELECT COUNT(*)`, then roll back and count again.
2. Use savepoints to insert an order, insert a bad item, roll back to the savepoint, and still commit the order.
3. In MySQL, prove that a `CREATE TABLE` inside a transaction commits your earlier insert.
4. Open a transaction in one session and try to read the changed row from a second session. What happens, and why?

---

# 43. Isolation levels, locking, and deadlocks

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 40 min | Name the four problems caused by users working at once · Pick an isolation level · Prevent and handle deadlocks · Find who is blocking whom |

> [!NOTE]
> 📌 **In plain words:** When many people use the database at once, their transactions can interfere. Isolation levels let you choose **how much interference you will tolerate** in exchange for **how much speed**.

> 🌍 **Analogy:** Two people editing the same shared document. Either one waits until the other has finished (safe, but slow), or both type at once and hope they do not overwrite each other (fast, but risky). Isolation levels are the settings between those two extremes.

## 43.1 👻 The four concurrency problems

**① Dirty read** — you read data another transaction has changed but not committed. If they roll back, you acted on data that never existed.

```text
Session A: UPDATE products SET unit_price = 1 WHERE product_id = 5;  (not committed)
Session B: SELECT unit_price FROM products WHERE product_id = 5;  → reads 1 😱
Session A: ROLLBACK;
Session B now believes the price is 1. It never was.
```

**② Non-repeatable read** — you read the same row twice in one transaction and get different values, because someone committed a change in between.

```text
Session A: SELECT unit_price FROM products WHERE product_id = 5;  → 899
Session B: UPDATE products SET unit_price = 799 WHERE product_id = 5; COMMIT;
Session A: SELECT unit_price FROM products WHERE product_id = 5;  → 799 😱
```

**③ Phantom read** — you run the same query twice and new **rows** have appeared.

```text
Session A: SELECT COUNT(*) FROM orders WHERE status = 'Pending';  → 3
Session B: INSERT INTO orders (... status 'Pending' ...); COMMIT;
Session A: SELECT COUNT(*) FROM orders WHERE status = 'Pending';  → 4 😱
```

**④ Lost update** — two transactions read the same value, both modify it, and the second overwrites the first.

```text
Session A: reads stock = 10
Session B: reads stock = 10
Session A: sets stock = 10 - 3 = 7. COMMIT.
Session B: sets stock = 10 - 5 = 5. COMMIT.
8 units were sold; the table says 5 were taken. One update was lost. 😱
```

## 43.2 🎚️ The four isolation levels

| Level | Dirty read | Non-repeatable read | Phantom read | Speed |
|---|:---:|:---:|:---:|---|
| `READ UNCOMMITTED` | ⚠️ Possible | ⚠️ Possible | ⚠️ Possible | 🚀 Fastest |
| `READ COMMITTED` | ✅ Prevented | ⚠️ Possible | ⚠️ Possible | ⚡ Fast |
| `REPEATABLE READ` | ✅ Prevented | ✅ Prevented | ⚠️ Possible* | 🐢 Slower |
| `SERIALIZABLE` | ✅ Prevented | ✅ Prevented | ✅ Prevented | 🐌 Slowest |

\* *InnoDB's `REPEATABLE READ` also prevents phantoms in most cases, thanks to *gap locking* — it also locks the empty space between rows, so new rows cannot slip in.*

```sql
-- 🟥 MSSQL
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;   -- stays in force for the rest of the session
BEGIN TRANSACTION;
    -- ...
COMMIT;
```

```sql
-- 🟦 MySQL
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;   -- applies to the NEXT transaction only
START TRANSACTION;
    -- ...
COMMIT;
```

> 🔀 **The defaults differ, and it matters:**
> - **MSSQL:** `READ COMMITTED` using **locks** — readers block writers and writers block readers.
> - **MySQL/InnoDB:** `REPEATABLE READ` using **MVCC** (*multi-version concurrency control*: each reader sees a snapshot of the data, like a photo taken when it started) — readers never block writers, and writers never block readers.
>
> This is why the same application can behave very differently on the two engines. MSSQL's `READ_COMMITTED_SNAPSHOT` database option switches it to MVCC behaviour and is one of the highest-value settings to enable on a busy OLTP system (lots of small, quick transactions — like an online shop):
> ```sql
> -- 🟥 MSSQL
> ALTER DATABASE ShopDB SET READ_COMMITTED_SNAPSHOT ON;
> ```

> [!WARNING]
> ⚠️ **`READ UNCOMMITTED` and the `WITH (NOLOCK)` hint are not "go faster" switches.** They allow dirty reads, and in MSSQL they can also return **missing or duplicated rows** if data moves around inside the table while it is being read. Never use `NOLOCK` on data anyone will act on. It is acceptable only for rough approximations — "roughly how many rows are in this log table."

## 43.3 🔒 Locking

| Lock type | Also called | Behaviour |
|---|---|---|
| **Shared (S)** | Read lock | Many readers can hold it together; blocks writers |
| **Exclusive (X)** | Write lock | Only one holder; blocks everyone |
| **Update (U)** | MSSQL | Held while deciding whether to update; prevents a common deadlock (two sessions stuck waiting for each other — 43.4) |
| **Intent (IS/IX)** | | A marker at table level saying "I hold row locks below" |

**Lock size:** a lock can cover one row, a *page* (a block of rows), or a whole table. Swapping many small locks for one big lock (*lock escalation*) is cheaper for the server to track, but blocks more people. MSSQL escalates to a table lock at roughly 5000 locks on one object — a common cause of sudden blocking during large updates. Batching your updates ([Chapter 18](#18-update-changing-data)) avoids it.

**Explicit locking when you read a value and then change it:**

```sql
-- 🟥 MSSQL: take the update lock at read time
BEGIN TRANSACTION;
    SELECT units_in_stock
    FROM products WITH (UPDLOCK, ROWLOCK)
    WHERE product_id = 5;

    UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = 5;
COMMIT;
```

```sql
-- 🟦 MySQL: SELECT ... FOR UPDATE
START TRANSACTION;
    SELECT units_in_stock FROM products WHERE product_id = 5 FOR UPDATE;

    UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = 5;
COMMIT;
```

> [!TIP]
> 💡 **Or avoid the problem entirely by making the update atomic:**
> ```sql
> UPDATE products
> SET units_in_stock = units_in_stock - 1
> WHERE product_id = 5 AND units_in_stock >= 1;
> -- Then check the affected row count: 0 means there was no stock.
> ```
> This is a single atomic statement — no read-then-write gap exists, so no lost update is possible. **When you can express the change as one statement, do.**

## 43.4 💀 Deadlocks

> [!NOTE]
> 📌 **In plain words:** Two transactions each hold something the other needs. Neither can proceed. The database detects this and **kills one of them** so the other can finish.

```text
Session A                          Session B
─────────────────────────          ─────────────────────────
UPDATE products  (locks row 5)
                                   UPDATE customers (locks row 1)
UPDATE customers (waits for B) ←──┐
                                  └──→ UPDATE products (waits for A)
                        💀 DEADLOCK — the engine kills one transaction
```

**The cure — and it is genuinely this simple: always access tables in the same order.**

```sql
-- ✅ EVERY procedure in your system touches: customers → orders → order_items → products
-- If all code follows one order, this class of deadlock cannot occur.
```

| Prevention technique | How it helps |
|---|---|
| Consistent object access order | Removes the circular wait entirely |
| Short transactions | Less time holding locks = smaller collision window |
| Correct indexes | Row locks instead of table scans locking everything |
| Lower isolation where safe | Fewer and shorter locks |
| MVCC (`READ_COMMITTED_SNAPSHOT`, InnoDB) | Readers stop blocking writers |
| Retry logic in the application | Deadlocks are normal; simply retry the cancelled transaction |

```sql
-- 🟥 MSSQL: find recent deadlocks
SELECT XEventData.XEvent.value('(data/value)[1]', 'varchar(max)') AS deadlock_graph
FROM (
    SELECT CAST(target_data AS XML) AS TargetData
    FROM sys.dm_xe_session_targets st
    JOIN sys.dm_xe_sessions s ON s.address = st.event_session_address
    WHERE s.name = 'system_health' AND st.target_name = 'ring_buffer'
) AS Data
CROSS APPLY TargetData.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]')
    AS XEventData(XEvent);
```

```sql
-- 🟦 MySQL: the most recent deadlock is always in the engine status
SHOW ENGINE INNODB STATUS;
-- Look for the "LATEST DETECTED DEADLOCK" section

-- Who is blocking whom, right now
SELECT * FROM performance_schema.data_locks;
SELECT * FROM sys.innodb_lock_waits;
```

> [!TIP]
> 💡 **Deadlocks are not bugs to be eliminated at all cost — they are a normal fact of concurrent systems.** Every production application should catch the deadlock error (MSSQL 1205, MySQL 1213) and **retry the transaction**, typically 3 times with a short, slightly random pause between tries. Systems without retry logic show users random failures under load.

## 43.5 🔍 Diagnosing blocking right now

```sql
-- 🟥 MSSQL: who is blocking whom
SELECT
    r.session_id,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time,
    r.status,
    t.text AS running_sql
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0;

-- Kill a runaway session (last resort, know what it is doing first)
-- KILL 57;
```

```sql
-- 🟦 MySQL
SELECT * FROM performance_schema.processlist;   -- SHOW PROCESSLIST still works, but reads a deprecated source
SELECT * FROM sys.session WHERE command <> 'Sleep';
SELECT * FROM sys.innodb_lock_waits;

-- KILL 1234;
```

> 🔎 **This chapter covered what the *engine* does. [Chapter 63](#63-concurrency-patterns-for-real-applications) covers what *you* must do** — the lost update that no isolation level prevents, optimistic vs pessimistic concurrency, idempotency keys, and the queue pattern.

## 43.6 🧪 Try it yourself

1. Open two sessions. In session 1, start a transaction and update a product without committing. In session 2, try to read that row. Observe the block in MSSQL and the non-block in MySQL.
2. Reproduce a lost update by hand using two sessions and the read-then-write pattern.
3. Fix it with `FOR UPDATE` / `UPDLOCK`.
4. Deliberately create a deadlock with two sessions updating two tables in opposite order. Read the error message.
5. Rewrite the stock decrement as a single atomic `UPDATE` and explain why it needs no lock hint.

---

# 44. MERGE and UPSERT

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 25 min | Insert new rows and update existing ones in one go · Sync a table from a data feed · Avoid the dangerous `REPLACE` |

> [!NOTE]
> 📌 **In plain words:** "Insert it if it is new, update it if it already exists." This is called an **upsert**, and it is one of the most common real-world requirements — syncing data, importing files, keeping a summary table up to date.

> 🌍 **Analogy:** Updating your phone's contacts from a list. If the person is already in your phone, you update their number; if not, you add them as a new contact.

## 44.1 🟥 MSSQL: MERGE

The examples in this chapter read a two-row supplier feed. Load it into the `staging_products` table from [Chapter 12](#12-insert-putting-data-in):

```sql
-- ✅ Works in BOTH
DELETE FROM staging_products;
INSERT INTO staging_products (product_name, category_id, supplier_id, unit_price, units_in_stock) VALUES
('UltraBook Pro 14', 1, 1, 1449.00, 30),     -- already in products: price and stock changed
('Brand New Gadget', 4, 2,   59.00, 100);    -- not in products yet
```

```sql
MERGE INTO products AS target
USING staging_products AS source
    ON target.product_name = source.product_name

WHEN MATCHED AND (
        target.unit_price     <> source.unit_price
     OR target.units_in_stock <> source.units_in_stock
     ) THEN
    UPDATE SET
        target.unit_price     = source.unit_price,
        target.units_in_stock = source.units_in_stock

WHEN NOT MATCHED BY TARGET THEN
    INSERT (product_name, category_id, supplier_id, unit_price, units_in_stock)
    VALUES (source.product_name, source.category_id, source.supplier_id,
            source.unit_price, source.units_in_stock)

WHEN NOT MATCHED BY SOURCE THEN
    UPDATE SET target.discontinued = 1        -- no longer in the feed: retire it

OUTPUT $action, inserted.product_id, inserted.product_name;   -- 💡 report what happened
```

**Result on ShopDB** (with the two-row feed above — one changed product, one new one):

| $action | product_id | product_name |
|---|---|---|
| INSERT | 19 | Brand New Gadget |
| UPDATE | 1 | UltraBook Pro 14 |
| UPDATE | 2 | UltraBook Air 13 |
| … | … | *16 more `UPDATE` rows, products 3–18* |

> [!WARNING]
> ⚠️ **Read those extra rows carefully.** Every product that is *not* in the feed matched `WHEN NOT MATCHED BY SOURCE` and was retired with `discontinued = 1` — 17 of the 18 existing products. That is exactly right when the feed is the complete catalogue, and exactly wrong when it is a partial update. Only include `WHEN NOT MATCHED BY SOURCE` when the source really is the whole truth.

> [!WARNING]
> ⚠️ **A bare `OUTPUT` clause fails the moment the target table has a trigger.** If `products` carries the audit trigger from [Chapter 39](#39-triggers), the statement above dies with:
>
> ```text
> Msg 334: The target table 'target' of the DML statement cannot have any
>          enabled triggers if the statement contains an OUTPUT clause
>          without INTO clause.
> ```
>
> **The fix is to send the output somewhere** — a table variable or temp table:
>
> ```sql
> DECLARE @changes TABLE (action_taken NVARCHAR(10), product_id INT, product_name NVARCHAR(120));
>
> MERGE INTO products WITH (HOLDLOCK) AS target
> USING staging_products AS source ON target.product_name = source.product_name
> WHEN MATCHED AND target.unit_price <> source.unit_price THEN
>     UPDATE SET target.unit_price = source.unit_price
> WHEN NOT MATCHED BY TARGET THEN
>     INSERT (product_name, category_id, supplier_id, unit_price, units_in_stock)
>     VALUES (source.product_name, source.category_id, source.supplier_id,
>             source.unit_price, source.units_in_stock)
> OUTPUT $action, inserted.product_id, inserted.product_name INTO @changes;   -- ✅ INTO
>
> SELECT * FROM @changes;
> ```
>
> This applies to `OUTPUT` on plain `INSERT`, `UPDATE`, and `DELETE` too — it is not a `MERGE` quirk. Any table with a trigger requires `OUTPUT ... INTO`.

**The three match clauses:**

| Clause | Meaning |
|---|---|
| `WHEN MATCHED` | The row exists in both → usually `UPDATE` |
| `WHEN NOT MATCHED [BY TARGET]` | In the source only → `INSERT` |
| `WHEN NOT MATCHED BY SOURCE` | In the target only → `UPDATE` or `DELETE` |

> [!WARNING]
> ⚠️ **`MERGE` has a long history of bugs and gotchas in SQL Server** — incorrect results with certain index/trigger combinations, unexpected deadlocks, and constraint violations under concurrency. Many senior SQL Server professionals deliberately avoid it. If you use it, always add `WITH (HOLDLOCK)` on the target so it stays correct when many users run it at once:
> ```sql
> -- 🟥 MSSQL: the hint goes on the target, right before its alias
> -- MERGE INTO products WITH (HOLDLOCK) AS target ...   (the full statement is shown above)
> ```

## 44.2 🟦 MySQL: INSERT ... ON DUPLICATE KEY UPDATE

```sql
-- ✅ MySQL: requires a UNIQUE or PRIMARY KEY on the matching column
-- ShopDB has no unique key on product_name yet, so add one first — without it,
-- every "upsert" below silently inserts a duplicate instead of updating
ALTER TABLE products ADD CONSTRAINT uq_products_name UNIQUE (product_name);

INSERT INTO products (product_name, category_id, supplier_id, unit_price, units_in_stock)
VALUES ('Zenith Phone 13', 2, 3, 999.00, 50) AS new
ON DUPLICATE KEY UPDATE
    unit_price     = new.unit_price,        -- older code writes VALUES(unit_price): deprecated since 8.0.20
    units_in_stock = new.units_in_stock;
```

```sql
-- Run it a second time: the row now exists, so this UPDATES it (the column list may differ)
INSERT INTO products (product_name, category_id, unit_price, units_in_stock)
VALUES ('Zenith Phone 13', 2, 999.00, 50) AS new
ON DUPLICATE KEY UPDATE
    unit_price     = new.unit_price,
    units_in_stock = new.units_in_stock;
```

```sql
-- Bulk upsert from a staging table (8.0.20+ form: alias the SELECT as a derived table)
INSERT INTO products (product_name, category_id, supplier_id, unit_price, units_in_stock)
SELECT * FROM (
    SELECT product_name, category_id, supplier_id, unit_price, units_in_stock
    FROM staging_products
) AS new
ON DUPLICATE KEY UPDATE
    unit_price     = new.unit_price,
    units_in_stock = new.units_in_stock;
```

**Other MySQL variants:**

```sql
-- REPLACE: DELETE the old row then INSERT a new one
-- (product 4 has never been ordered — try product 5 and the FOREIGN KEY from order_items blocks the DELETE half)
REPLACE INTO products (product_id, product_name, category_id, unit_price)
VALUES (4, 'Legacy Netbook 10', 1, 249.00);
```

> [!WARNING]
> ⚠️ **`REPLACE` is genuinely dangerous.** It **deletes** the existing row (firing delete triggers and cascading foreign keys!) and inserts a brand new one with a new auto-increment value. Columns you did not supply revert to their defaults. Child rows can be cascade-deleted. **Prefer `ON DUPLICATE KEY UPDATE` in almost every case.**

## 44.3 ✅ The portable upsert (works everywhere)

```sql
-- ✅ Works in BOTH: update first, insert what did not exist
-- Run the two statements inside one transaction —
--   in MSSQL: BEGIN TRANSACTION; … COMMIT;     in MySQL: START TRANSACTION; … COMMIT;

UPDATE products
SET unit_price     = (SELECT s.unit_price     FROM staging_products s
                      WHERE s.product_name = products.product_name),
    units_in_stock = (SELECT s.units_in_stock FROM staging_products s
                      WHERE s.product_name = products.product_name)
WHERE EXISTS (SELECT 1 FROM staging_products s
              WHERE s.product_name = products.product_name);

INSERT INTO products (product_name, category_id, supplier_id, unit_price, units_in_stock)
SELECT s.product_name, s.category_id, s.supplier_id, s.unit_price, s.units_in_stock
FROM staging_products s
WHERE NOT EXISTS (
    SELECT 1 FROM products p WHERE p.product_name = s.product_name
);
```

> [!TIP]
> 💡 **Order matters: `UPDATE` first, then `INSERT`.** If you insert first, the newly inserted rows then match the update and get pointlessly updated. Updating first touches only the pre-existing rows.

## 44.4 🎯 Real-world upsert scenarios

**① Daily inventory feed from a supplier** — the bulk upsert shown above.

**② A page-view counter that must not lose counts:**

```sql
-- ✅ MySQL
CREATE TABLE page_views (
    page_url  VARCHAR(200) NOT NULL,
    view_date DATE         NOT NULL,
    views     INT          NOT NULL,
    PRIMARY KEY (page_url, view_date)        -- 🔑 the key the upsert matches on
);

INSERT INTO page_views (page_url, view_date, views)
VALUES ('/products/5', CURDATE(), 1)
ON DUPLICATE KEY UPDATE views = views + 1;
```

```sql
-- ✅ MSSQL: update first, insert only if nothing was updated
CREATE TABLE page_views (
    page_url  VARCHAR(200) NOT NULL,
    view_date DATE         NOT NULL,
    views     INT          NOT NULL,
    CONSTRAINT pk_page_views PRIMARY KEY (page_url, view_date)
);
GO

UPDATE page_views SET views = views + 1
WHERE page_url = '/products/5' AND view_date = CAST(GETDATE() AS DATE);

IF @@ROWCOUNT = 0
    INSERT INTO page_views (page_url, view_date, views)
    VALUES ('/products/5', CAST(GETDATE() AS DATE), 1);
```

**③ Maintaining a summary/cache table after each order:**

```sql
-- ✅ MSSQL
CREATE TABLE customer_summary (
    customer_id  INT  NOT NULL PRIMARY KEY,
    order_count  INT  NOT NULL,
    last_order   DATE NOT NULL
);
GO

MERGE INTO customer_summary WITH (HOLDLOCK) AS t
USING (
    SELECT customer_id, COUNT(*) AS order_count, MAX(order_date) AS last_order
    FROM orders GROUP BY customer_id
) AS s ON s.customer_id = t.customer_id
WHEN MATCHED THEN UPDATE SET t.order_count = s.order_count, t.last_order = s.last_order
WHEN NOT MATCHED THEN INSERT (customer_id, order_count, last_order)
                      VALUES (s.customer_id, s.order_count, s.last_order);
```

## 44.5 🎯 When to use which upsert

| Situation | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| One row, might exist | `MERGE`, or `IF EXISTS … ELSE …` | `INSERT … ON DUPLICATE KEY UPDATE` |
| Bulk load from a staging table | `MERGE WITH (HOLDLOCK)` | `INSERT … SELECT … ON DUPLICATE KEY UPDATE` |
| A counter that must never lose a hit | `UPDATE … ; IF @@ROWCOUNT = 0 INSERT` | `ON DUPLICATE KEY UPDATE n = n + 1` |
| You must also retire rows missing from the feed | `MERGE` + `WHEN NOT MATCHED BY SOURCE` | Two statements |
| You want portable code | Two statements: `UPDATE` then `INSERT … WHERE NOT EXISTS` | same |
| High concurrency, correctness critical | ⚠️ `MERGE` needs `HOLDLOCK`; many teams avoid it | `ON DUPLICATE KEY UPDATE` is atomic |

## 44.6 🧪 Try it yourself

1. Create a `staging_products` table with 3 existing and 2 new products. Upsert it in both dialects.
2. In MySQL, compare `REPLACE INTO` and `ON DUPLICATE KEY UPDATE` on a row that has child records. Note what happens to the children.
3. Write the portable two-statement upsert inside a transaction.
4. Build a `page_views` counter table and increment the same URL 5 times.

---

# 45. Error handling

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 25 min | Catch errors and clean up · Raise your own clear error messages · Log errors that survive a rollback · Retry after a deadlock |

> [!NOTE]
> 📌 **In plain words:** Things go wrong: constraint violations, deadlocks, division by zero, missing rows. Error handling lets your code notice, clean up, and report clearly instead of leaving a half-finished mess.

> 🌍 **Analogy:** A smoke alarm and a fire exit plan. You hope you never need them, but when something goes wrong, they decide whether you get a small, controlled problem or a disaster.

## 45.1 🟥 MSSQL: TRY ... CATCH

```sql
BEGIN TRY
    BEGIN TRANSACTION;

        INSERT INTO orders (customer_id, order_date, status)
        VALUES (9999, '2026-09-09', 'Pending');       -- ❌ no such customer

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER()    AS error_number,
        ERROR_SEVERITY()  AS severity,
        ERROR_STATE()     AS state,
        ERROR_PROCEDURE() AS procedure_name,
        ERROR_LINE()      AS line_number,
        ERROR_MESSAGE()   AS message;
END CATCH;
```

**The error functions:**

| Function | Returns |
|---|---|
| `ERROR_NUMBER()` | The numeric error code (547 = FK violation, 2627 = PK violation, 1205 = deadlock) |
| `ERROR_MESSAGE()` | The human-readable text |
| `ERROR_SEVERITY()` | 0–25; 16 is a normal user error |
| `ERROR_LINE()` | Which line inside the procedure failed |
| `ERROR_PROCEDURE()` | Which procedure it happened in |

**Raising your own errors:**

```sql
-- ✅ Preferred (2012+): THROW
THROW 50001, 'Customer credit limit exceeded.', 1;
GO

-- Re-throw the current error from inside a CATCH block
BEGIN TRY
    THROW 50002, 'Something went wrong.', 1;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;                          -- preserves the original number and message
END CATCH;
GO

-- Older: RAISERROR, which supports printf-style message formatting
DECLARE @cust INT = 9999;
RAISERROR('Customer %d was not found.', 16, 1, @cust);
```

> [!TIP]
> 💡 **Prefer `THROW` over `RAISERROR` in new code.** `THROW` preserves the original error number, always uses severity 16, and re-raises cleanly. `RAISERROR` is only needed for fill-in-the-blank messages such as `'Customer %d was not found.'`.

**Logging errors properly:**

```sql
CREATE TABLE error_log (
    error_id     INT IDENTITY(1,1) PRIMARY KEY,
    error_number INT,
    error_message NVARCHAR(2048),
    procedure_name NVARCHAR(128),
    line_number  INT,
    occurred_at  DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    occurred_by  NVARCHAR(128) NOT NULL DEFAULT SUSER_SNAME()
);
GO

CREATE OR ALTER PROCEDURE usp_safe_operation
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
            -- work here
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        -- ✅ Log AFTER the rollback, or the log row rolls back too!
        INSERT INTO error_log (error_number, error_message, procedure_name, line_number)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE());

        THROW;
    END CATCH;
END;
GO
```

> [!WARNING]
> ⚠️ **Log after the rollback, never before.** If you insert the log row inside the failed transaction and then roll back, the log entry disappears along with everything else — and you are left debugging an error that left no trace.

## 45.2 🟦 MySQL: DECLARE ... HANDLER

```sql
-- The MySQL version of the error_log table from 45.1
CREATE TABLE error_log (
    error_id       INT AUTO_INCREMENT PRIMARY KEY,
    error_number   INT,
    error_message  VARCHAR(2048),
    procedure_name VARCHAR(128),
    line_number    INT,
    occurred_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    occurred_by    VARCHAR(128) NOT NULL DEFAULT (CURRENT_USER())
) ENGINE=InnoDB;

DELIMITER $$
CREATE PROCEDURE usp_safe_operation()
BEGIN
    DECLARE v_errno INT;
    DECLARE v_msg   VARCHAR(512);

    -- EXIT = stop the procedure. CONTINUE = keep going after handling.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_errno = MYSQL_ERRNO,
            v_msg   = MESSAGE_TEXT;

        ROLLBACK;

        INSERT INTO error_log (error_number, error_message, procedure_name)
        VALUES (v_errno, v_msg, 'usp_safe_operation');

        RESIGNAL;                    -- re-raise to the caller
    END;

    START TRANSACTION;
        -- work here
    COMMIT;
END$$
DELIMITER ;
```

**Handler types** (*SQLSTATE* is a standard five-character error code; the plain numbers are MySQL's own error codes):

| Declaration | Catches |
|---|---|
| `FOR SQLEXCEPTION` | Any error (SQLSTATE not starting 00, 01, or 02) |
| `FOR SQLWARNING` | Warnings (SQLSTATE 01xxx) |
| `FOR NOT FOUND` | No more rows (SQLSTATE 02xxx) — used with cursors |
| `FOR SQLSTATE '23000'` | A specific SQLSTATE (23000 = integrity violation) |
| `FOR 1062` | A specific MySQL error number (1062 = duplicate key) |

```sql
-- Handling a specific error gracefully
DELIMITER $$
CREATE PROCEDURE usp_add_category(IN p_name VARCHAR(50))
BEGIN
    DECLARE CONTINUE HANDLER FOR 1062       -- duplicate key
    BEGIN
        SELECT CONCAT('Category "', p_name, '" already exists.') AS message;
    END;

    INSERT INTO categories (category_name) VALUES (p_name);
END$$
DELIMITER ;
```

**Raising your own errors:**

```sql
SIGNAL SQLSTATE '45000'                 -- 45000 = "unhandled user-defined exception"
    SET MESSAGE_TEXT = 'Customer credit limit exceeded.',
        MYSQL_ERRNO = 1644;

-- Re-raise the current error. RESIGNAL is only valid INSIDE a DECLARE ... HANDLER
-- block, exactly as usp_safe_operation uses it above:
--     RESIGNAL;
```

## 45.3 🔢 The error codes you will meet

| Situation | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Duplicate key | 2627 / 2601 | 1062 |
| Foreign key violation | 547 | 1452 (insert) / 1451 (delete) |
| NULL in a NOT NULL column | 515 | 1048 |
| String truncation | 8152 / 2628 | 1406 |
| Deadlock victim | **1205** | **1213** |
| Lock wait timeout | 1222 | 1205 |
| Divide by zero | 8134 | 1365 |
| Conversion failed | 245 | 1292 |

> [!TIP]
> 💡 **Note the confusing overlap: 1205 means "deadlock" in MSSQL and "lock wait timeout" in MySQL.** If you write retry logic for both engines, be precise about which code you are matching.

## 45.4 🔁 Retry logic for deadlocks

```sql
-- 🟥 MSSQL: retry a deadlocked transaction up to 3 times
DECLARE @retry INT = 3;

WHILE @retry > 0
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
            -- the work that might deadlock
            UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = 5;
            UPDATE orders   SET status = 'Paid' WHERE order_id = 1022;
        COMMIT TRANSACTION;

        SET @retry = 0;                    -- success, stop looping
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        IF ERROR_NUMBER() = 1205 AND @retry > 1     -- deadlock victim: try again
        BEGIN
            SET @retry = @retry - 1;
            WAITFOR DELAY '00:00:00.100';           -- short backoff
        END
        ELSE
        BEGIN
            THROW;                                   -- a real error: give up
        END
    END CATCH;
END;
```

> [!TIP]
> 💡 **In production, retry logic usually belongs in the application layer**, where you can add growing, slightly random waits between retries, automatic pausing when a system keeps failing, and proper logging. But knowing how to do it in T-SQL is valuable for batch jobs and ETL that run entirely inside the database.

## 45.5 🎯 When to handle an error — and when to let it fly

| Situation | Handle it? |
|---|---|
| A deadlock (1205 🟥 / 1213 🟦) | ✅ Catch and **retry** — it is expected under load |
| A duplicate key on an "insert if new" path | ✅ Catch and turn it into an update, or use an upsert |
| A business rule violation you can explain to the user | ✅ Catch, then `THROW`/`SIGNAL` a clear message |
| A foreign key violation from bad input | ✅ Catch, log, return a friendly message |
| A genuine bug (invalid column, syntax) | ❌ Let it fail loudly — hiding it costs you days later |
| Anything you cannot actually fix | ❌ Log it and re-raise (`THROW` / `RESIGNAL`) |

> [!TIP]
> 💡 **The rule: catch what you can act on, log everything, and never swallow an error silently.** An empty `CATCH` block is the most expensive four lines in any codebase — it converts a loud failure into silent data corruption.

## 45.6 🧪 Try it yourself

1. Write a procedure that inserts an order for a non-existent customer, catches the FK error, and logs it.
2. In MySQL, write a handler that catches duplicate-key errors and returns a friendly message.
3. Raise a custom error with your own message in both dialects.
4. Prove that logging *inside* the failed transaction loses the log row, then fix it.

---
# ⚡ PART 10 — PERFORMANCE

---

# 46. Indexes, the complete guide

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 45 min | Explain how an index speeds up searches · Design multi-column and covering indexes · Choose what to index · Find missing and unused indexes |

> [!NOTE]
> 📌 **In plain words:** An index is a **sorted lookup structure** that lets the database find rows without reading the whole table. It is the single biggest performance lever you have.

> 🌍 **Analogy:** A **textbook index**. To find every mention of "photosynthesis" you could read all 900 pages (a table scan), or flip to the index at the back, find the word in alphabetical order, and jump straight to pages 145 and 302 (an index seek). The index costs a few extra pages and some effort to keep current — exactly like a database index.

## 46.1 🌳 How an index actually works

Data is stored in fixed-size blocks called **pages** (8 KB in SQL Server, 16 KB in MySQL). Both engines organize an index as a **B-tree** (balanced tree) of pages:

```text
                    ┌─────────────┐
                    │   Root: M   │              ← 1 page read
                    └──┬───────┬──┘
              ┌────────┘       └────────┐
        ┌─────▼─────┐             ┌─────▼─────┐  ← 1 page read
        │  D    H   │             │  R    W   │
        └──┬──┬──┬──┘             └──┬──┬──┬──┘
     ┌─────┘  │  └─────┐              ...
  ┌──▼──┐ ┌───▼──┐ ┌───▼──┐                      ← 1 page read
  │A..C │ │ D..G │ │ H..L │  ← LEAF pages hold the keys (and pointers to rows)
  └─────┘ └──────┘ └──────┘
```

**Why this is fast:** with 3 levels you can locate any row among **millions** in 3 or 4 page reads. A table scan of the same data might be 100,000 page reads. That is the difference between 1 millisecond and 4 seconds.

> [!NOTE]
> 📌 **The cost side of the bargain:** every `INSERT`, `UPDATE`, and `DELETE` must also update every index on that table. Ten indexes means ten extra structures to maintain on every write. **Indexes make reads fast and writes slower.** That trade-off is the whole art of indexing.

## 46.2 🗂️ Clustered vs non-clustered

| | **Clustered index** | **Non-clustered index** |
|---|---|---|
| What it is | The **table itself**, physically sorted by the key | A **separate structure** pointing back to the table |
| How many per table | **One** (the data can only be sorted one way) | Many (up to 999 in MSSQL, 64 in MySQL) |
| Leaf level contains | The **entire row** | The key + a pointer to the row |
| 🟥 MSSQL default | Created automatically on the `PRIMARY KEY` | Created by `CREATE INDEX` |
| 🟦 MySQL/InnoDB | The `PRIMARY KEY` **is** the clustered index, always | Secondary indexes store the PK as the pointer |

> 🌍 **Analogy:** A **dictionary** is clustered — the words are physically in alphabetical order, and the definition is right there. A **book index** is non-clustered — it lists the term and a page number; you then have to turn to that page.

> [!WARNING]
> ⚠️ **A critical InnoDB consequence:** because every secondary index stores the primary key as its row pointer, a **wide primary key is duplicated inside every other index**. A `VARCHAR(200)` primary key on a table with 6 indexes wastes an enormous amount of space and memory. **Keep your primary key narrow — an `INT` or `BIGINT`.**

```sql
-- 🟥 MSSQL: control the clustered index explicitly
CREATE TABLE events (
    event_id   BIGINT      NOT NULL,
    event_time DATETIME2(0) NOT NULL,
    payload    NVARCHAR(500),
    CONSTRAINT pk_events PRIMARY KEY NONCLUSTERED (event_id)   -- PK, but not clustered
);
CREATE CLUSTERED INDEX ix_events_time ON events(event_time);   -- cluster by time instead
```

> [!TIP]
> 💡 **Why you might do that:** in a log table you almost always query *by time range*. Clustering by `event_time` means a month's events are physically adjacent on disk — one sequential read instead of thousands of random ones.

## 46.3 🛠️ Creating indexes

```sql
-- ✅ Works in BOTH

-- Single column
CREATE INDEX ix_orders_order_date ON orders(order_date);

-- Composite (multi-column) — column ORDER IS CRITICAL, see below
CREATE INDEX ix_orders_customer_date ON orders(customer_id, order_date);

-- Unique index (also enforces a rule)
CREATE UNIQUE INDEX uq_suppliers_company_name ON suppliers(company_name);

-- Descending
CREATE INDEX ix_orders_date_desc ON orders(order_date DESC);

-- Drop — identical syntax in both engines
DROP INDEX ix_orders_order_date ON orders;
```

```sql
-- 🟦 MySQL also accepts the ALTER TABLE form
ALTER TABLE orders DROP INDEX ix_orders_date_desc;
```

## 46.4 🔑 Composite indexes and the left-prefix rule

> [!WARNING]
> ⚠️ **This is the most important indexing concept, and the one most people get wrong.**

```sql
CREATE INDEX ix_orders_cust_date_status ON orders(customer_id, order_date, status);
```

> 🌍 **Analogy — a phone book sorted by (last name, first name).** You can find "all the Silvas" instantly. You can find "Silva, Amara" instantly. But you **cannot** find "everyone called Amara" without reading the whole book, because first names are only sorted *within* each last name.

**Which queries can use that index?**

| Query filter | Uses the index? | Why |
|---|:---:|---|
| `WHERE customer_id = 1` | ✅ Fully | Left-most column |
| `WHERE customer_id = 1 AND order_date >= '2026-01-01'` | ✅ Fully | Left two columns |
| `WHERE customer_id = 1 AND order_date = X AND status = 'Paid'` | ✅ Fully | All three |
| `WHERE customer_id = 1 AND status = 'Paid'` | ⚠️ Partly | Jumps to `customer_id` via the index, then checks `status` row by row |
| `WHERE order_date >= '2026-01-01'` | ❌ No | Skips the left-most column |
| `WHERE status = 'Paid'` | ❌ No | Skips the first two |

> [!TIP]
> 💡 **The rule for ordering columns in a composite index:**
> 1. **Columns tested with `=` first** — start with the one that narrows the rows down the most
> 2. **Range columns next** (`>`, `<`, `BETWEEN`)
> 3. **Columns only used for `ORDER BY`** after that
> 4. **`INCLUDE`d columns** (MSSQL) last — see below
>
> A range predicate (a `>`, `<`, or `BETWEEN` condition) "stops" the usefulness of everything after it, so a range column should be the last one that matters for seeking.

## 46.5 🎯 Covering indexes — the biggest single win

> [!NOTE]
> 📌 **In plain words:** If an index contains **every column the query needs**, the engine never touches the table at all. This is called a **covering index**, and it is often a 10x improvement.

```sql
-- The query
SELECT customer_id, order_date, status
FROM orders
WHERE customer_id = 3 AND order_date >= '2026-01-01';
```

```sql
-- 🟥 MSSQL: INCLUDE stores extra columns in the index WITHOUT sorting by them
CREATE INDEX ix_orders_covering
    ON orders(customer_id, order_date)      -- key columns: used for seeking
    INCLUDE (status, employee_id);          -- payload: available without a lookup
```

```sql
-- 🟦 MySQL has no INCLUDE — add the columns to the key instead
CREATE INDEX ix_orders_covering
    ON orders(customer_id, order_date, status, employee_id);
```

> [!TIP]
> 💡 **Why `INCLUDE` is better than adding key columns (MSSQL):** included columns are stored only in the bottom level of the tree, not in the pages above it. The index is smaller, the tree is shallower, and there is no sort-order overhead for those columns. Put columns you **filter or sort on** in the key; put columns you only **select** in `INCLUDE`.

**How to spot the win:** in an MSSQL plan, a "Key Lookup" (or "RID Lookup") operator means the index found the rows but had to go back to the table for extra columns. Adding those columns to `INCLUDE` removes it. In MySQL `EXPLAIN`, `Extra: Using index` means the query was covered.

## 46.6 🎚️ Filtered and partial indexes

```sql
-- 🟥 MSSQL: index only the rows you actually query
CREATE INDEX ix_orders_pending
    ON orders(order_date)
    WHERE status = 'Pending';
```

> [!IMPORTANT]
> 🎯 **When this is brilliant:** 5 million orders, of which 200 are pending. A full index has 5 million entries; the filtered index has 200. It is tiny, it stays in memory, and it is updated far less often.
>
> Other great uses: `WHERE is_deleted = 0` (soft-delete tables), `WHERE tax_id IS NOT NULL` (with a `UNIQUE` index: every real value must be unique, while many rows can still be NULL).

> 🔀 **MySQL has no filtered indexes.** The closest approach is a generated column plus an index on it, or simply accepting the full index.

## 46.7 📚 Other index types

| Type | 🟥 MSSQL | 🟦 MySQL | Use for |
|---|---|---|---|
| B-tree | ✅ Default | ✅ Default | Almost everything |
| Full-text | ✅ `CREATE FULLTEXT INDEX` | ✅ `FULLTEXT` index | Word/phrase search in long text |
| Spatial | ✅ Spatial index | ✅ `SPATIAL` index | Maps, distances |
| Columnstore | ✅ Clustered/nonclustered columnstore | ❌ | Reports over tables with many millions of rows |
| Hash | ✅ Memory-optimized tables | ✅ MEMORY engine only | Exact-match lookups |
| Functional/expression | ⚠️ via computed column | ✅ 8.0.13+ `((LOWER(email)))` | Indexing an expression |
| Descending | ✅ | ✅ 8.0+ (honoured) | Matching `ORDER BY … DESC` |

```sql
-- 🟥 MSSQL: full-text search
CREATE FULLTEXT CATALOG ft_catalog AS DEFAULT;
GO

-- ⚠️ KEY INDEX must name a UNIQUE, single-column, NOT NULL index that
--    actually exists. ShopDB's primary keys were declared inline, so
--    SQL Server auto-generated names like PK__products__47027DF5E820107F.
--    Look yours up first:
SELECT name, is_unique, is_primary_key
FROM sys.indexes
WHERE object_id = OBJECT_ID('products') AND is_unique = 1;
GO

-- Simplest: create your own named unique index and point at that
CREATE UNIQUE INDEX ux_products_ftkey ON products(product_id);
GO

CREATE FULLTEXT INDEX ON products(product_name)
    KEY INDEX ux_products_ftkey ON ft_catalog;
GO

SELECT * FROM products WHERE CONTAINS(product_name, 'Ultra OR Vision');
```

> [!WARNING]
> ⚠️ **Two things that stop this working.** First, `KEY INDEX` must name a real unique, single-column, non-nullable index — passing a name that does not exist gives *"'pk_products' is not a valid index to enforce a full-text search key."* Second, **Full-Text Search is a separate installable component**. If it was not selected during setup you get *"Full-Text Search is not installed, or a full-text component cannot be loaded"* (error 7609), and you must add the feature before any of this works. Check with:
> ```sql
> -- 🟥 MSSQL
> SELECT SERVERPROPERTY('IsFullTextInstalled') AS fulltext_installed;   -- 1 = yes
> ```

```sql
-- 🟦 MySQL: full-text search
ALTER TABLE products ADD FULLTEXT INDEX ft_product_name (product_name);

SELECT * FROM products
WHERE MATCH(product_name) AGAINST('Ultra Vision' IN NATURAL LANGUAGE MODE);
```

> [!TIP]
> 💡 **Full-text search is the correct answer to `LIKE '%word%'` on a big table.** `LIKE` with a leading wildcard cannot use a B-tree index at all; a full-text index is built for exactly this, and adds relevance ranking (best matches first) and skips common filler words (*stop words*) for free.

## 46.8 🧭 What to index — the practical checklist

| ✅ Index these | ❌ Do not index these |
|---|---|
| Primary keys (automatic) | Columns with very few distinct values (a `gender` or `is_active` flag alone) |
| **Every foreign key column** | Columns you never filter, join, or sort on |
| Columns in `WHERE` that narrow the results down to few rows | Very wide columns (long `VARCHAR`) |
| Columns in `JOIN ... ON` | Tables that are tiny (under a few hundred rows) |
| Columns in `ORDER BY` / `GROUP BY` | Tables that are written far more than read |
| Columns in `UNIQUE` business rules | Every column "just in case" |

> [!WARNING]
> ⚠️ **MSSQL does NOT automatically index foreign key columns. MySQL does.** This means the same schema can perform completely differently on the two engines. On SQL Server, indexing your FK columns is often the single highest-value tuning action available — it speeds up joins *and* prevents table scans when a parent row is deleted.

```sql
-- ✅ 🟥 MSSQL: do this on day one of any project (MySQL indexes foreign keys automatically)
CREATE INDEX ix_orders_customer_id   ON orders(customer_id);
CREATE INDEX ix_orders_employee_id   ON orders(employee_id);
CREATE INDEX ix_order_items_product  ON order_items(product_id);
CREATE INDEX ix_products_category_id ON products(category_id);
CREATE INDEX ix_products_supplier_id ON products(supplier_id);
CREATE INDEX ix_payments_order_id    ON payments(order_id);
CREATE INDEX ix_employees_manager_id ON employees(manager_id);
```

## 46.9 🔍 Finding missing and unused indexes

```sql
-- 🟥 MSSQL: what the optimizer wished it had (treat as a HINT, not an order)
SELECT
    ROUND(s.avg_total_user_cost * s.avg_user_impact * (s.user_seeks + s.user_scans), 0) AS improvement_score,
    d.statement AS table_name,
    d.equality_columns,
    d.inequality_columns,
    d.included_columns,
    s.user_seeks, s.user_scans
FROM sys.dm_db_missing_index_group_stats s
JOIN sys.dm_db_missing_index_groups   g ON g.index_group_handle = s.group_handle
JOIN sys.dm_db_missing_index_details  d ON d.index_handle = g.index_handle
ORDER BY improvement_score DESC;
```

> [!WARNING]
> ⚠️ **Never blindly create every "missing index" the DMV (a built-in system view that reports what the server has seen) suggests.** It reports each query in isolation, so you can end up with 15 overlapping indexes on one table, each slowing down every write. **Consolidate them:** if it wants `(a, b)` and `(a, b, c)`, create only `(a, b, c)`.

```sql
-- 🟥 MSSQL: indexes nobody is using (candidates for deletion)
SELECT
    OBJECT_NAME(i.object_id) AS table_name,
    i.name AS index_name,
    s.user_seeks, s.user_scans, s.user_lookups,
    s.user_updates                      -- ← maintenance cost with no read benefit
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats s
       ON s.object_id = i.object_id AND s.index_id = i.index_id
       AND s.database_id = DB_ID()
WHERE i.type_desc = 'NONCLUSTERED'
  AND OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1
  AND ISNULL(s.user_seeks,0) + ISNULL(s.user_scans,0) + ISNULL(s.user_lookups,0) = 0
ORDER BY s.user_updates DESC;
```

```sql
-- 🟦 MySQL: index usage and redundancy (sys schema)
SELECT * FROM sys.schema_unused_indexes;
SELECT * FROM sys.schema_redundant_indexes;
SELECT * FROM sys.schema_index_statistics WHERE table_schema = 'ShopDB';

SHOW INDEX FROM orders;
```

> [!TIP]
> 💡 **An unused index is pure cost:** disk space, server memory, backup size, and slower writes — with zero read benefit. Auditing for them is one of the easiest wins available to a DBA. Just be sure your usage stats cover a **full business cycle** (including month-end reports) before you drop anything.

## 46.10 🧹 Index maintenance

Over time, indexes become **fragmented**: as rows are added and removed, pages end up half-empty and out of order, so reading them takes more work.

```sql
-- 🟥 MSSQL: check fragmentation
SELECT
    OBJECT_NAME(ips.object_id) AS table_name,
    i.name AS index_name,
    ips.avg_fragmentation_in_percent,
    ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON i.object_id = ips.object_id AND i.index_id = ips.index_id
WHERE ips.page_count > 1000
ORDER BY ips.avg_fragmentation_in_percent DESC;

-- The standard rule of thumb
ALTER INDEX ix_orders_customer_date ON orders REORGANIZE;     -- 5% to 30% fragmented
ALTER INDEX ix_orders_customer_date ON orders REBUILD;        -- over 30%
ALTER INDEX ALL ON orders REBUILD WITH (ONLINE = ON);         -- Enterprise and Developer editions only
```

```sql
-- 🟦 MySQL
ANALYZE TABLE orders;         -- refresh statistics
OPTIMIZE TABLE orders;        -- rebuild and defragment (locks the table on InnoDB)
```

> [!WARNING]
> ⚠️ **`OPTIMIZE TABLE` on a large InnoDB table copies the whole table and blocks writes.** Schedule it in a maintenance window, or use `pt-online-schema-change` / `gh-ost` (free tools that rebuild a table while it stays usable) on busy systems.

> [!TIP]
> 💡 **Modern advice:** fragmentation matters far less on SSDs than it did on spinning disks. Chasing 5% fragmentation nightly is usually wasted effort — **updating statistics is more valuable than rebuilding indexes** in most systems today.

## 46.11 🧪 Try it yourself

1. Run a query filtering `orders` by `customer_id` and look at the plan. Add an index. Look again.
2. Create a covering index for a three-column query and confirm the Key Lookup disappears (MSSQL) or `Using index` appears (MySQL).
3. Create a composite index on `(customer_id, order_date)`, then query filtering only on `order_date`. Explain why it is not used.
4. Find all unused indexes in your database.
5. Add 8 indexes to `order_items`, time a bulk insert, drop them, and time it again.

---

# 47. Execution plans

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 40 min | Show how the database ran your query · Spot the warning signs of a slow query · Fix a slow query step by step · Use Query Store to catch plans that got worse |

> [!NOTE]
> 📌 **In plain words:** An execution plan is the database showing you **exactly how it ran your query**. Learning to read one turns performance tuning from guesswork into diagnosis.

> 🌍 **Analogy:** A **route map from a satnav**. You asked to get to the airport; the plan shows which roads it chose, how long each leg took, and where the traffic jam was.

## 47.1 🟥 Getting a plan in MSSQL

```sql
-- Estimated plan (does not run the query): Ctrl+L in SSMS
-- ⚠️ SET SHOWPLAN_ALL must be the ONLY statement in its batch, hence the GOs.
SET SHOWPLAN_ALL ON;
GO
    SELECT * FROM orders WHERE customer_id = 3;
GO
SET SHOWPLAN_ALL OFF;
GO

-- Actual plan (runs it and reports real row counts): Ctrl+M in SSMS
-- ✅ This is the one you want — estimates can be wrong, actuals never lie.

-- The numbers that matter most
SET STATISTICS IO ON;      -- how many pages were read
SET STATISTICS TIME ON;    -- CPU and elapsed time

SELECT c.full_name, COUNT(*) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
```

**Reading `STATISTICS IO` output:**

```text
Table 'orders'. Scan count 1, logical reads 145, physical reads 0, read-ahead reads 0.
                    │                  │                  │
                    │                  │                  └─ reads that hit DISK (slow)
                    │                  └─ pages read from MEMORY (the number to reduce)
                    └─ how many times the table was accessed
```

> [!TIP]
> 💡 **"Logical reads" is the best single number to tune.** Unlike elapsed time, it does not change with server load or caching. **Tune to reduce logical reads.** If you halve them, you have genuinely halved the work.

## 47.2 🟦 Getting a plan in MySQL

```sql
-- Basic plan
EXPLAIN
SELECT c.full_name, COUNT(*) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;

-- Richer output
EXPLAIN FORMAT=JSON
SELECT c.full_name, COUNT(*) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;

-- 🌟 The best one (MySQL 8.0.18+): actually runs it and shows real timings
EXPLAIN ANALYZE
SELECT c.full_name, COUNT(*) AS orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;
```

**The `EXPLAIN` columns that matter:**

| Column | What it tells you |
|---|---|
| `type` | **The most important column.** How rows are accessed — see the table below |
| `key` | Which index was actually used (`NULL` = none!) |
| `rows` | Estimated rows examined |
| `filtered` | Percentage of those rows that survive the `WHERE` |
| `Extra` | Warnings and extras — see below |

**`type`, from best to worst:**

| `type` | Meaning | Verdict |
|---|---|---|
| `system` / `const` | One row, via a primary key | 🟢 Perfect |
| `eq_ref` | One row per join, via a unique index | 🟢 Excellent |
| `ref` | Several rows via a non-unique index | 🟢 Good |
| `range` | Index range scan (`BETWEEN`, `>`, `IN`) | 🟡 Fine |
| `index` | Full **index** scan | 🟠 Reads everything, but only the index |
| `ALL` | **Full table scan** | 🔴 Investigate — usually a missing index |

**`Extra` values worth knowing:**

| Value | Meaning |
|---|---|
| `Using index` | 🟢 Covering index — the table was never touched |
| `Using where` | Rows were filtered after reading. Normal |
| `Using filesort` | 🟠 A sort was needed. An index could remove it |
| `Using temporary` | 🟠 A temp table was built (common with `GROUP BY`) |
| `Using join buffer` | 🔴 Joining without an index. Add one |
| `Impossible WHERE` | The condition can never be true |

## 47.3 🔍 The operators to recognize (MSSQL)

| Operator | What it means | Good or bad? |
|---|---|---|
| **Clustered/Index Seek** | Jumped directly to the rows via the tree | 🟢 What you want |
| **Index Scan** | Read the whole index | 🟡 OK on small tables, bad on large |
| **Table Scan** | Read every row of a heap (a table with no clustered index) | 🔴 Usually a missing index |
| **Key Lookup / RID Lookup** | Found rows in an index, went back to the table for more columns | 🟠 Fix with `INCLUDE` |
| **Nested Loops** | For each outer row, probe the inner | 🟢 Good when the outer set is small |
| **Hash Match** | Built a temporary lookup table in memory | 🟡 Fine for large joins; bad if it overflows to disk |
| **Merge Join** | Both inputs sorted, merged | 🟢 Efficient when inputs are already ordered |
| **Sort** | An explicit sort | 🟠 Expensive; an index may remove it |
| **Spool** | Saved an in-between result to reuse | 🟠 Often a sign the query can be rewritten |
| **Parallelism** | Split across CPU threads | 🟡 Good for big queries, overhead for small ones |

> [!TIP]
> 💡 **Read a graphical plan RIGHT TO LEFT, TOP TO BOTTOM** — that is the direction data actually flows. The thickness of the arrows shows the row count; a thin arrow suddenly becoming very thick is where your query went wrong.

## 47.4 🚩 The five warning signs

**① A huge gap between estimated and actual rows**

```text
Estimated: 1 row      Actual: 2,400,000 rows
```
The optimizer built a plan for one row (row-by-row lookups, very little memory) and then processed millions. **Cause:** out-of-date statistics, a condition that cannot use an index (*non-SARGable*, Chapter 48), a table variable, or a multi-statement TVF. **Fix:** update statistics; see [Chapter 49](#49-statistics-and-the-optimizer).

**② A scan where you expected a seek**

Missing index, or the query is not SARGable. See [Chapter 48](#48-query-optimization-and-sargability).

**③ Key Lookups running millions of times**

The index found the rows but not all the columns. Add the missing columns to `INCLUDE`.

**④ A warning triangle on an operator**

MSSQL flags implicit conversions, missing statistics, and memory-grant spills right on the operator. **Hover over it and read what it says** — it usually names the exact problem.

**⑤ Sort or Hash spilling to tempdb**

The engine asked for too little memory and had to use disk. Caused by bad estimates; fixed by fixing the estimates.

## 47.5 🧪 A worked tuning example

```sql
-- 😱 THE SLOW VERSION
SELECT
    c.full_name,
    o.order_id,
    o.order_date
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE YEAR(o.order_date) = 2026
  AND c.country = 'Singapore'
ORDER BY o.order_date DESC;
```

**What the plan shows:** a table scan on `orders` (145 logical reads on our tiny table — imagine 5 million rows), plus a Sort operator.

**Diagnosis:**
1. `YEAR(o.order_date)` wraps the column in a function → **not SARGable** → no index can be used.
2. There is no index on `orders.customer_id` (in MSSQL) → the join scans.
3. `ORDER BY o.order_date` requires an explicit sort.

```sql
-- ✅ 🟥 MSSQL — THE FIXED VERSION (MySQL has no INCLUDE: put those columns in the index key)
CREATE INDEX ix_orders_date_customer
    ON orders(order_date DESC, customer_id)
    INCLUDE (order_id);                       -- 🟥 MSSQL; MySQL: add to the key
CREATE INDEX ix_customers_country ON customers(country) INCLUDE (full_name);

SELECT
    c.full_name,
    o.order_id,
    o.order_date
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_date >= '2026-01-01'            -- ✅ SARGable range
  AND o.order_date <  '2027-01-01'
  AND c.country = 'Singapore'
ORDER BY o.order_date DESC;                   -- ✅ satisfied by the index order
```

**Result:** index seek instead of scan, no Sort operator, no Key Lookup. On a real table this is routinely a 100x improvement.

## 47.6 🧰 Plan caching and parameter sniffing

> [!NOTE]
> 📌 **In plain words:** The engine caches the plan it built so the next execution does not have to re-plan. Usually good. Occasionally disastrous.

**Parameter sniffing:** the plan is built for the *first* parameter value it sees. If that value was unusual, every later execution reuses a plan tuned for the wrong shape of data.

```sql
-- First call: @country = 'Vatican City' → 1 customer → nested loops plan cached
-- Later call: @country = 'USA'          → 2 million customers → still nested loops 😱
```

**Fixes (MSSQL):**

```sql
-- 🟥 MSSQL
DECLARE @country NVARCHAR(60) = 'Singapore';

-- Recompile this statement every time (small cost, always the right plan)
SELECT customer_id, full_name FROM customers WHERE country = @country
OPTION (RECOMPILE);

-- Optimize for a typical value
SELECT customer_id, full_name FROM customers WHERE country = @country
OPTION (OPTIMIZE FOR (@country = 'UK'));

-- Optimize for the average, ignoring the sniffed value
SELECT customer_id, full_name FROM customers WHERE country = @country
OPTION (OPTIMIZE FOR UNKNOWN);
GO

-- Clear one cached plan (or all — do NOT do this on a busy production server)
-- DBCC FREEPROCCACHE;
```

```sql
-- 🟦 MySQL: much less prone to this, but you can inspect the cache
SELECT * FROM performance_schema.events_statements_summary_by_digest
ORDER BY sum_timer_wait DESC LIMIT 10;
```

## 47.7 🐢 Finding your slowest queries

```sql
-- 🟥 MSSQL: the top 20 by total time
SELECT TOP 20
    qs.execution_count,
    qs.total_worker_time / 1000 AS total_cpu_ms,
    qs.total_elapsed_time / qs.execution_count / 1000 AS avg_elapsed_ms,
    qs.total_logical_reads,
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text)
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2)+1) AS query_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY qs.total_elapsed_time DESC;
```

```sql
-- 🟦 MySQL: enable and read the slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;               -- log anything over 1 second

-- Or use performance_schema / sys
SELECT * FROM sys.statements_with_runtimes_in_95th_percentile LIMIT 20;
SELECT * FROM sys.statements_with_full_table_scans LIMIT 20;
SELECT * FROM sys.statements_with_temp_tables LIMIT 20;
```

> [!TIP]
> 💡 **`sys.statements_with_full_table_scans` is the fastest way to find missing indexes in MySQL.** It goes straight to the queries reading whole tables.

## 47.8 📼 Query Store — the flight recorder

> [!NOTE]
> 📌 **In plain words:** The DMVs in 47.7 only know what is in the plan cache **right now**. Restart the server, or let a plan age out, and the evidence is gone. Query Store writes every query, every plan, and every runtime statistic to disk, inside the database — so you can answer *"what changed at 4 a.m. on Tuesday?"* on Wednesday morning.

> 🌍 **Analogy:** An aircraft's black box. You do not read it while flying. You read it after something went wrong, and it tells you exactly what the plane was doing at the moment it did.

```sql
-- 🟥 MSSQL 2016+ (all editions, including Express): turn it on
ALTER DATABASE ShopDB SET QUERY_STORE = ON
    (OPERATION_MODE             = READ_WRITE,
     DATA_FLUSH_INTERVAL_SECONDS = 60,
     INTERVAL_LENGTH_MINUTES     = 5,       -- how finely runtime stats are bucketed
     MAX_STORAGE_SIZE_MB         = 1024,
     QUERY_CAPTURE_MODE          = AUTO,    -- AUTO skips trivial queries; ALL captures everything
     SIZE_BASED_CLEANUP_MODE     = AUTO);

-- Confirm it is actually recording
SELECT actual_state_desc, readonly_reason,
       current_storage_size_mb, max_storage_size_mb
FROM sys.database_query_store_options;
```

**Result:**

| actual_state_desc | readonly_reason | current_storage_size_mb | max_storage_size_mb |
|---|---|---|---|
| READ_WRITE | 0 | 0 | 1024 |

> [!WARNING]
> ⚠️ **Check `actual_state_desc`, not just that the `ALTER` succeeded.** If Query Store fills its quota it silently flips to `READ_ONLY` and stops recording — exactly when you need it most. A non-zero `readonly_reason` tells you why. Monitor it like any other disk.

```sql
-- 🟥 The slowest queries, with real history behind them
SELECT TOP 10
    LEFT(qt.query_sql_text, 80)                     AS query_text,
    rs.count_executions,
    CAST(rs.avg_duration / 1000.0 AS DECIMAL(10,2)) AS avg_ms,
    CAST(rs.avg_logical_io_reads AS INT)            AS avg_reads
FROM sys.query_store_query_text        qt
JOIN sys.query_store_query             q  ON q.query_text_id = qt.query_text_id
JOIN sys.query_store_plan              p  ON p.query_id      = q.query_id
JOIN sys.query_store_runtime_stats     rs ON rs.plan_id      = p.plan_id
ORDER BY rs.avg_duration DESC;
```

**Result:**

| query_text | count_executions | avg_ms | avg_reads |
|---|---|---|---|
| SELECT c.country, COUNT(*) AS orders FROM orders o JOIN cust… | 1 | 0.24 | 27 |

> [!WARNING]
> ⚠️ **Two reasons a freshly enabled Query Store looks empty.** First, `QUERY_CAPTURE_MODE = AUTO` deliberately ignores cheap, rarely-run queries — set it to `ALL` while testing. Second, runtime statistics are written asynchronously; call `EXEC sys.sp_query_store_flush_db;` to force a flush instead of waiting for `DATA_FLUSH_INTERVAL_SECONDS`.

**The reason Query Store exists — catching a plan regression:**

```sql
-- 🟥 Queries that have more than one plan are your regression candidates
SELECT q.query_id, COUNT(DISTINCT p.plan_id) AS plan_count
FROM sys.query_store_query q
JOIN sys.query_store_plan  p ON p.query_id = q.query_id
GROUP BY q.query_id
HAVING COUNT(DISTINCT p.plan_id) > 1;
```

```sql
-- 🟥 Pin the plan that was good, and release it again
-- (in real life, use the query_id / plan_id pair you picked from the regression query above)
DECLARE @query_id BIGINT, @plan_id BIGINT;
SELECT TOP (1) @query_id = query_id, @plan_id = plan_id
FROM sys.query_store_plan
ORDER BY plan_id;

IF @plan_id IS NOT NULL
BEGIN
    EXEC sys.sp_query_store_force_plan   @query_id = @query_id, @plan_id = @plan_id;

    SELECT plan_id, is_forced_plan FROM sys.query_store_plan WHERE plan_id = @plan_id;   -- 1 = forced

    EXEC sys.sp_query_store_unforce_plan @query_id = @query_id, @plan_id = @plan_id;
END;
```

> [!IMPORTANT]
> 🎯 **This is the cure for parameter sniffing (47.6) that does not require touching the query.** A query that was fast for six months and is suddenly slow usually has a new, worse plan. Query Store lets you see both plans side by side, compare their runtime statistics, and force the good one — in seconds, in production, with no deployment.

> [!WARNING]
> ⚠️ **Forcing a plan is a tourniquet, not a cure.** It stops the bleeding, and it also stops the optimizer ever improving that query — including after you add the index that would have fixed it properly. Record every forced plan, and review the list regularly. A forced plan can also silently stop being usable (if an index it depends on is dropped), so check `sys.query_store_plan.force_failure_count`.

| Query Store gives you | The DMVs in 47.7 give you |
|---|---|
| History that survives restarts and cache eviction | Only what is cached right now |
| Multiple plans per query, with statistics for each | One current plan |
| Plan forcing | Hints and plan guides, which are harder to manage |
| Per-database, per-interval buckets you can graph | A single running total since restart |
| A small write overhead | None |

> 🔀 **MySQL has no direct equivalent.** The closest combination is the `performance_schema` digest tables plus the `sys` schema views from 47.7 — persisted by scraping them into your own history table on a schedule, or by a monitoring tool (Percona PMM, MySQL Enterprise Monitor). The `slow_query_log` gives you the raw material but no plan history.

## 47.9 🎯 When to look at an execution plan

| Trigger | Do this |
|---|---|
| A query "feels slow" | Get the **actual** plan, and `SET STATISTICS IO ON` |
| A query was fast yesterday, slow today | Compare plans; suspect stale statistics or parameter sniffing |
| Before deploying any new query touching a big table | Read the plan once — it takes 30 seconds |
| Adding an index | Check the plan **before and after** to prove it was used |
| Estimated rows ≠ actual rows by 10x or more | Fix the estimate before anything else |
| Everything is slow, not one query | ❌ Not a plan problem — check waits, memory, disk ([Ch 57](#57-monitoring-and-maintenance)) |

> [!TIP]
> 💡 **What to look at, in order:** ① Is there a scan where a seek was possible? ② Is estimated vs actual wildly different? ③ Is there a Key Lookup running thousands of times? ④ Is there a Sort that an index could remove? ⑤ Are there warning triangles? That order finds the problem roughly 90% of the time.

> [!CAUTION]
> 🐛 **Common mistake:** tuning by stopwatch. Elapsed time changes with server load and caching, so you "fix" things that were never broken. **Tune to reduce logical reads** — that number stays the same from run to run and directly reflects the work done.

## 47.10 🧪 Try it yourself

1. Run a `SELECT *` on `orders` with `STATISTICS IO ON` (or `EXPLAIN`) and note the reads.
2. Add a `WHERE customer_id = 3` and compare, before and after adding an index.
3. Write a non-SARGable query with `YEAR()`, look at the plan, rewrite it as a range, and compare.
4. Build a query that produces a Key Lookup, then eliminate it with `INCLUDE`.
5. Find the top 5 slowest queries currently running on your server.

---
# 48. Query optimization and SARGability

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 35 min | Write conditions that can use an index · Spot and fix the seven slow patterns · Rewrite a slow query step by step |

> [!NOTE]
> 📌 **In plain words:** **SARGable** means "Search ARGument able" — a condition the engine can answer by **seeking** (jumping straight to the matching rows through an index) instead of **scanning** (reading every row). Writing SARGable conditions is the most valuable habit in SQL performance.

> 🌍 **Analogy:** You are looking for "Silva" in a phone book. **SARGable:** flip straight to S. **Non-SARGable:** *"find everyone whose surname UPPERCASED equals SILVA"* — now you must read and transform every single name, because the book is not sorted by uppercased names.

## 48.1 🚫 The seven non-SARGable patterns (and their fixes)

In the examples below, **❌ SCAN** marks the slow version and **✅ SEEK** the fast one. On ShopDB's tiny tables both run instantly — the difference shows up on tables with millions of rows.

**① A function wrapped around the column**

```sql
-- ❌ SCAN — the function hides the column from the index
SELECT order_id, order_date FROM orders
WHERE YEAR(order_date) = 2026;

-- ✅ SEEK — the column is bare on the left
SELECT order_id, order_date FROM orders
WHERE order_date >= '2026-01-01' AND order_date < '2027-01-01';

-- ❌ SCAN
SELECT customer_id, email FROM customers
WHERE UPPER(email) = 'AMARA.SILVA@EXAMPLE.COM';

-- ✅ SEEK (both engines are case-insensitive under the default collation)
SELECT customer_id, email FROM customers
WHERE email = 'amara.silva@example.com';
-- ✅ Case-sensitive collation? Add an indexed computed column (Chapter 41)

-- ❌ SCAN
SELECT customer_id FROM customers
WHERE CAST(customer_id AS CHAR(10)) = '3';

-- ✅ SEEK
SELECT customer_id FROM customers
WHERE customer_id = 3;
```

**② Arithmetic on the column**

```sql
-- ❌ SCAN
SELECT product_name, unit_price FROM products
WHERE unit_price * 1.15 > 1000;

-- ✅ SEEK — move the maths to the fixed-value side
SELECT product_name, unit_price FROM products
WHERE unit_price > 1000 / 1.15;

-- ❌ SCAN
SELECT product_name FROM products
WHERE units_in_stock - 10 > 0;

-- ✅ SEEK
SELECT product_name FROM products
WHERE units_in_stock > 10;
```

**③ A leading wildcard in `LIKE`**

```sql
-- ❌ SCAN — a leading wildcard defeats the index entirely
SELECT product_name FROM products
WHERE product_name LIKE '%Book%';

-- ✅ SEEK — the engine jumps straight to the "Ultra" range
SELECT product_name FROM products
WHERE product_name LIKE 'Ultra%';

-- ✅ For genuine "contains" search on a big table: FULLTEXT index (Chapter 46)
```

**④ Implicit type conversion**

```sql
-- ❌ phone is VARCHAR, so the COLUMN gets converted (scan — or an outright error)
SELECT customer_id, phone FROM customers
WHERE phone = 94775550101;

-- ✅ SEEK — literal typed to match the column
SELECT customer_id, phone FROM customers
WHERE phone = '+94-77-555-0101';
```

**⑤ `OR` across different columns**

```sql
-- ❌ Often scans — one index cannot serve both sides of the OR
SELECT order_id, customer_id, employee_id FROM orders
WHERE customer_id = 3 OR employee_id = 5;

-- ✅ Two seeks, combined
SELECT order_id, customer_id, employee_id FROM orders WHERE customer_id = 3
UNION
SELECT order_id, customer_id, employee_id FROM orders WHERE employee_id = 5;
```

**⑥ `NOT`, `<>`, and `NOT IN`**

```sql
-- ❌ "Everything except X" usually means reading everything anyway
SELECT order_id, status FROM orders
WHERE status <> 'Delivered';

-- ✅ If the alternatives are few, list them positively
SELECT order_id, status FROM orders
WHERE status IN ('Pending','Paid','Shipped','Cancelled','Refunded');
```

**⑦ Comparing two columns of the same table**

```sql
-- ⚠️ Works in BOTH: comparing two columns of the same row is inherently a scan
SELECT product_name, units_in_stock, reorder_level FROM products
WHERE units_in_stock <= reorder_level;
```

```sql
-- ✅ 🟥 MSSQL: if you run this constantly, store the answer in a column and index it
ALTER TABLE products
    ADD needs_reorder AS (CASE WHEN units_in_stock <= reorder_level THEN 1 ELSE 0 END) PERSISTED;
GO
CREATE INDEX ix_products_needs_reorder ON products(needs_reorder);
GO

-- Now this is an index seek
SELECT product_name FROM products WHERE needs_reorder = 1;
```

```sql
-- ✅ 🟦 MySQL: the same idea with a STORED generated column
ALTER TABLE products
    ADD COLUMN needs_reorder TINYINT
        AS (CASE WHEN units_in_stock <= reorder_level THEN 1 ELSE 0 END) STORED,
    ADD INDEX ix_products_needs_reorder (needs_reorder);

SELECT product_name FROM products WHERE needs_reorder = 1;
```

> [!TIP]
> 💡 **The universal principle: keep the indexed column bare (untouched) on one side of the comparison.** Any calculation you can move onto the fixed value instead of the column, move it.

## 48.2 🎯 Ten more optimization rules

**① Select only the columns you need**

```sql
-- ❌ Stops covering indexes working, and sends data nobody reads
SELECT * FROM orders WHERE customer_id = 3;
-- ✅
SELECT order_id, order_date, status FROM orders WHERE customer_id = 3;
```

**② Filter as early and as much as possible**

Push conditions into `WHERE`, not `HAVING`. Filter inside subqueries and CTEs, not after them.

**③ Use `EXISTS` instead of `COUNT(*) > 0`**

```sql
-- 🟥 MSSQL
-- ❌ Counts every matching row before deciding
IF (SELECT COUNT(*) FROM orders WHERE customer_id = 3) > 0
    PRINT 'customer 3 has orders';

-- ✅ Stops at the very first match
IF EXISTS (SELECT 1 FROM orders WHERE customer_id = 3)
    PRINT 'customer 3 has orders';
```

**④ Use `UNION ALL` unless you truly need deduplication** (see [Chapter 29](#29-set-operators-union-intersect-except)).

**⑤ Avoid `DISTINCT` as a bandage for a bad join** — fix the join instead.

**⑥ Do not join two "many" tables to the same parent without totalling them first** — the fan-out problem from [Chapter 28](#28-joins-the-complete-picture).

**⑦ Batch large writes** — 5000 rows at a time, not 5 million ([Chapter 18](#18-update-changing-data)).

**⑧ Avoid scalar UDFs in `SELECT` and `WHERE`** ([Chapter 38](#38-user-defined-functions)).

**⑨ Beware `OFFSET` on deep pages** — use keyset pagination ([Chapter 17](#17-paging-top-limit-offset-fetch)).

**⑩ Do not sort what you do not need sorted.** An `ORDER BY` in a subquery or view is usually wasted work.

## 48.3 🔬 Before and after: a real rewrite

```sql
-- 😱 BEFORE: 4 problems in 12 lines
SELECT DISTINCT *
FROM orders o, customers c, order_items oi
WHERE o.customer_id = c.customer_id
  AND oi.order_id = o.order_id
  AND YEAR(o.order_date) = 2026
  AND UPPER(c.country) = 'SINGAPORE'
  AND (SELECT COUNT(*) FROM payments p WHERE p.order_id = o.order_id) > 0
ORDER BY o.order_date;
```

**Problems:** old comma joins; `SELECT DISTINCT *`; `YEAR()` and `UPPER()` on indexed columns; a correlated `COUNT(*)` that should be `EXISTS`.

```sql
-- ✅ AFTER
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.full_name,
    SUM(oi.quantity) AS total_units
FROM orders AS o
INNER JOIN customers   AS c  ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON oi.order_id = o.order_id
WHERE o.order_date >= '2026-01-01'
  AND o.order_date <  '2027-01-01'
  AND c.country = 'Singapore'
  AND EXISTS (SELECT 1 FROM payments p WHERE p.order_id = o.order_id)
GROUP BY o.order_id, o.order_date, o.status, c.full_name
ORDER BY o.order_date;
```

Every condition is now SARGable, the joins are written out clearly, `DISTINCT` is replaced by a proper `GROUP BY`, and the payment check stops at the first payment it finds.

## 48.4 🎛️ Query hints — the last resort

```sql
-- 🟥 MSSQL (ix_orders_customer_id is the foreign-key index from Chapter 46.8)
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'ix_orders_customer_id' AND object_id = OBJECT_ID('orders'))
    CREATE INDEX ix_orders_customer_id ON orders(customer_id);
GO

SELECT * FROM orders WITH (INDEX(ix_orders_customer_id)) WHERE customer_id = 3;

SELECT order_id FROM orders WHERE customer_id = 3 OPTION (RECOMPILE);
SELECT order_id FROM orders WHERE customer_id = 3 OPTION (MAXDOP 1);       -- use one CPU core only
SELECT o.order_id
FROM orders o JOIN customers c ON c.customer_id = o.customer_id
OPTION (FORCE ORDER);                                                      -- join as written
```

```sql
-- 🟦 MySQL (InnoDB already indexed the foreign key, under the constraint's name)
SELECT * FROM orders USE INDEX (fk_orders_customer) WHERE customer_id = 3;
SELECT * FROM orders FORCE INDEX (fk_orders_customer) WHERE customer_id = 3;
SELECT * FROM orders IGNORE INDEX (fk_orders_customer) WHERE customer_id = 3;
SELECT /*+ MAX_EXECUTION_TIME(1000) */ * FROM orders;    -- 8.0 optimizer hint: stop after 1000 ms
```

> [!WARNING]
> ⚠️ **Hints freeze a decision that should stay flexible.** The plan you force today becomes wrong when the data grows, the statistics change, or you upgrade the engine — and nobody remembers the hint is there. **Fix the root cause instead: the index, the condition, or the statistics.** Use hints only as a temporary bridge, with a comment explaining why and a date to revisit.

## 48.5 🧪 Try it yourself

1. Take each of the seven non-SARGable patterns, run both versions on `ShopDB`, and compare the plans.
2. Rewrite the "before" query in 48.3 yourself before reading the "after".
3. Find a query in your own work that uses a function on a column and fix it.
4. Force a bad index with a hint and observe the damage in the plan.

---

# 49. Statistics and the optimizer

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 25 min | Explain how the database guesses row counts · Keep statistics up to date · Recognize the symptoms of bad statistics |

> [!NOTE]
> 📌 **In plain words:** The optimizer does not look at your data before planning — it looks at **statistics**, a small summary of how values are distributed. Good statistics mean good plans. Stale statistics mean bad plans, and the query that ran in 2 seconds yesterday takes 4 minutes today.

> 🌍 **Analogy:** A delivery driver planning a route uses a **traffic forecast**, not live cameras on every street. If the forecast says "the bridge is clear" but the bridge has been closed for a month, the route will be terrible — through no fault of the driver's logic.

## 49.1 📊 What statistics contain

A statistics object holds:

- **Row count** for the table
- **Density** — how many distinct values a column has
- **A histogram** — a bar-chart-style summary of which values are common and which are rare, in up to 200 buckets (MSSQL)

```sql
-- 🟥 MSSQL: look at real statistics
SELECT
    s.name AS stats_name,
    sp.last_updated,
    sp.rows,
    sp.rows_sampled,
    sp.modification_counter          -- ← how many changes since the last update
FROM sys.stats s
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) sp
WHERE s.object_id = OBJECT_ID('orders');

-- See the actual histogram (of the index from Chapter 46 — created here if it is missing)
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = 'ix_orders_order_date' AND object_id = OBJECT_ID('orders'))
    CREATE INDEX ix_orders_order_date ON orders(order_date);
GO
DBCC SHOW_STATISTICS('orders', 'ix_orders_order_date');
```

```sql
-- 🟦 MySQL
SELECT table_name, table_rows, avg_row_length, data_length, index_length
FROM information_schema.tables
WHERE table_schema = 'ShopDB';

SELECT * FROM information_schema.statistics WHERE table_schema = 'ShopDB';

-- Histograms (MySQL 8.0+) — must be created explicitly
ANALYZE TABLE orders UPDATE HISTOGRAM ON status, order_date WITH 100 BUCKETS;
SELECT * FROM information_schema.column_statistics WHERE schema_name = 'ShopDB';
```

## 49.2 🔄 Keeping statistics current

```sql
-- 🟥 MSSQL
UPDATE STATISTICS orders;                            -- all stats on the table
UPDATE STATISTICS orders ix_orders_order_date;       -- one specific index
UPDATE STATISTICS orders WITH FULLSCAN;              -- read every row (accurate, slow)
EXEC sp_updatestats;                                 -- the whole database

-- Check the auto-update settings (both should be ON)
SELECT name, is_auto_create_stats_on, is_auto_update_stats_on
FROM sys.databases WHERE name = 'ShopDB';
```

```sql
-- 🟦 MySQL
ANALYZE TABLE orders;
ANALYZE TABLE orders, order_items, products;
```

> [!WARNING]
> ⚠️ **The auto-update threshold used to be a real problem in MSSQL.** Before 2016 (or without trace flag 2371, a special server switch), statistics only auto-updated after roughly **20% of the rows changed**. On a 100-million-row table that meant 20 million changes before the optimizer noticed. Modern versions use a much better sliding formula that reacts sooner on big tables, but **on a large, actively-loaded table you should still update statistics on a schedule.**

> [!TIP]
> 💡 **Rebuilding an index updates its statistics with a full scan, for free.** So `ALTER INDEX ... REBUILD` gives you fresh stats as a side effect — but `REORGANIZE` does **not**. If you reorganize, update statistics separately.

## 49.3 🎯 Symptoms of bad statistics

| Symptom | Likely cause |
|---|---|
| Estimated 1 row, actual 2 million | Stale stats, or a non-SARGable predicate the optimizer cannot estimate |
| A query suddenly got slow with no code change | Stats went stale after a bulk load |
| Nested loops chosen for two huge tables | Underestimated row counts |
| Hash/Sort spilling to disk | Too little memory was reserved for the query |
| Plan varies wildly between runs | Parameter sniffing (47.6) plus unevenly spread data |

```sql
-- 🟥 MSSQL: find tables whose stats are stale
SELECT
    OBJECT_NAME(s.object_id) AS table_name,
    s.name AS stat_name,
    sp.last_updated,
    sp.rows,
    sp.modification_counter,
    CAST(100.0 * sp.modification_counter / NULLIF(sp.rows,0) AS DECIMAL(5,2)) AS pct_changed
FROM sys.stats s
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) sp
WHERE sp.rows > 1000
  AND sp.modification_counter > sp.rows * 0.10
ORDER BY pct_changed DESC;
```

## 49.4 🧮 How the optimizer chooses a plan

```text
1. Check the query's grammar, and look up every table and column name
2. Generate candidate plans (join orders, join algorithms, index choices)
3. For each candidate, ESTIMATE the cost using STATISTICS:
       cost ≈ (estimated rows) × (CPU cost) + (estimated pages) × (I/O cost)
4. Pick the cheapest candidate found within its time budget
5. Cache it for reuse
```

> [!NOTE]
> 📌 **Two things follow from this that every professional should remember:**
>
> 1. **The optimizer makes an educated guess; it is not a mind reader.** It cannot try every plan — on a 10-table join there are millions. It uses rules of thumb and stops when it finds something "good enough".
> 2. **Every input it uses comes from statistics.** Garbage in, garbage out. Most "the optimizer chose a stupid plan" complaints are really "the optimizer was given stale or missing statistics."

## 49.5 🧪 Try it yourself

1. Look at the statistics on `orders` and note when they were last updated.
2. Insert 1000 rows, then check `modification_counter`.
3. Run `UPDATE STATISTICS` / `ANALYZE TABLE` and compare a query plan before and after.
4. In MSSQL, use `DBCC SHOW_STATISTICS` and read the histogram. Find the most common value.

---

# 50. Partitioning and very large tables

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 30 min | Split a huge table into manageable pieces · Delete a year of data in milliseconds · Decide honestly whether you need partitioning |

> [!NOTE]
> 📌 **In plain words:** Partitioning splits one enormous table into physically separate pieces, while it still **looks and behaves like a single table** to your queries.

> 🌍 **Analogy:** A **filing cabinet with one drawer per year**. It is still "the archive", and you still ask for a document the same way — but when you need something from 2024, you open one drawer instead of tipping the entire cabinet onto the floor.

## 50.1 🎯 When partitioning genuinely helps

| ✅ Good reasons | ❌ Bad reasons |
|---|---|
| **Archiving:** drop last year's data instantly by switching out a partition | "It will make all my queries faster" (it will not) |
| **Maintenance:** rebuild indexes one partition at a time | The table is only 5 million rows (just index it properly) |
| **Partition elimination** (skipping pieces that cannot match): queries with a date filter skip 90% of the data | You do not filter on the partition key |
| **Fast loading:** load into a staging table, then switch it in instantly | You hope it replaces good index design |

> [!WARNING]
> ⚠️ **Partitioning is a manageability feature first, a performance feature second.** A well-indexed 100-million-row table usually beats a badly-indexed partitioned one. Partition when your problem is *managing* the data — loading, archiving, purging — or when partition elimination genuinely removes most of the work.

## 50.2 🟥 MSSQL table partitioning

```sql
-- STEP 1: a partition FUNCTION defines the boundaries
CREATE PARTITION FUNCTION pf_order_date (DATE)
AS RANGE RIGHT FOR VALUES
    ('2024-01-01', '2025-01-01', '2026-01-01', '2027-01-01');
-- Creates 5 partitions: <2024, 2024, 2025, 2026, >=2027

-- STEP 2: a partition SCHEME says where each partition is stored (a filegroup = a named set of data files)
CREATE PARTITION SCHEME ps_order_date
AS PARTITION pf_order_date
ALL TO ([PRIMARY]);          -- or spread across separate filegroups/disks

-- STEP 3: create the table ON the scheme
CREATE TABLE orders_partitioned (
    order_id    INT NOT NULL,
    customer_id INT NOT NULL,
    order_date  DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,
    CONSTRAINT pk_orders_part PRIMARY KEY (order_id, order_date)   -- 🔑 PK must include the partition key
) ON ps_order_date(order_date);
```

**Partition elimination in action:**

```sql
-- ✅ Reads ONE partition. The plan shows "Actual Partition Count: 1".
SELECT * FROM orders_partitioned
WHERE order_date >= '2026-01-01' AND order_date < '2027-01-01';

-- ❌ Reads ALL partitions — the filter is not on the partition key
SELECT * FROM orders_partitioned WHERE customer_id = 3;
```

**The killer feature — instant archiving with `SWITCH`:**

```sql
-- Move an entire partition into another table in MILLISECONDS.
-- It only changes the table's bookkeeping (metadata): no rows are copied.
CREATE TABLE orders_archive_2024 (
    order_id    INT NOT NULL,
    customer_id INT NOT NULL,
    order_date  DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,
    CONSTRAINT pk_orders_arch PRIMARY KEY (order_id, order_date)
) ON ps_order_date(order_date);

ALTER TABLE orders_partitioned SWITCH PARTITION 2
    TO orders_archive_2024 PARTITION 2;

-- Then simply drop the archive table. Millions of rows gone, instantly, no log growth.
```

> [!TIP]
> 💡 **Compare that to `DELETE FROM orders WHERE order_date < '2025-01-01'` on 50 million rows:** hours of runtime, an enormous transaction log, table locks, and blocked users. `SWITCH` does it in milliseconds. **This alone justifies partitioning for large time-series tables.**

```sql
-- Inspect the partitions
SELECT
    p.partition_number,
    p.rows,
    prv.value AS boundary_value
FROM sys.partitions p
JOIN sys.indexes i ON i.object_id = p.object_id AND i.index_id = p.index_id
LEFT JOIN sys.partition_schemes ps ON ps.data_space_id = i.data_space_id
LEFT JOIN sys.partition_range_values prv
       ON prv.function_id = ps.function_id AND prv.boundary_id = p.partition_number
WHERE p.object_id = OBJECT_ID('orders_partitioned') AND i.index_id <= 1;
```

## 50.3 🟦 MySQL partitioning

```sql
-- RANGE partitioning by year
CREATE TABLE orders_partitioned (
    order_id    INT NOT NULL,
    customer_id INT NOT NULL,
    order_date  DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,
    PRIMARY KEY (order_id, order_date)          -- 🔑 must include the partition key
) ENGINE=InnoDB
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);
```

```sql
-- ✅ MySQL: the other partition types
CREATE TABLE orders_by_hash (
    order_id    INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (order_id, customer_id)
) PARTITION BY HASH(customer_id) PARTITIONS 8;                  -- even spread

CREATE TABLE orders_by_key (
    order_id    INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (order_id, customer_id)
) PARTITION BY KEY(customer_id) PARTITIONS 8;                   -- MySQL's own hash

CREATE TABLE customers_by_region (
    customer_id INT NOT NULL,
    region_id   INT NOT NULL,
    PRIMARY KEY (customer_id, region_id)
) PARTITION BY LIST (region_id) (                               -- explicit value lists
    PARTITION p_asia   VALUES IN (1,2,3),
    PARTITION p_europe VALUES IN (4,5,6)
);
```

```sql
-- Managing partitions
ALTER TABLE orders_partitioned DROP PARTITION p2023;             -- instant purge

-- ADD PARTITION only works while there is no MAXVALUE catch-all partition.
-- With pmax in place (as here), split pmax instead:
ALTER TABLE orders_partitioned REORGANIZE PARTITION pmax INTO (
    PARTITION p2027 VALUES LESS THAN (2028),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);

-- Query one partition explicitly
SELECT * FROM orders_partitioned PARTITION (p2026);

-- Check elimination
EXPLAIN SELECT * FROM orders_partitioned WHERE order_date >= '2026-01-01';
-- Look at the "partitions" column in the output
```

> [!WARNING]
> ⚠️ **The MySQL partitioning rule that surprises everyone:** **every unique key (including the primary key) must contain all columns of the partitioning expression.** This is why `PRIMARY KEY (order_id, order_date)` above is not optional. It also means you cannot have a simple `UNIQUE (email)` on a table partitioned by `signup_date`. This constraint rules partitioning out for many designs.

## 50.4 🧱 Other big-table strategies

| Strategy | What it is | When |
|---|---|---|
| **Archiving** | Move old rows to a separate table or database | Almost always the first thing to try |
| **Sharding** | Split across separate *servers* by key | When one machine cannot hold the data |
| **Columnstore** (MSSQL) | Stores data column by column, heavily compressed | Reports over tables with 10M+ rows |
| **Compression** | `ROW`/`PAGE` compression (MSSQL), `COMPRESSED` row format (MySQL) | Large tables where reading from disk is the slow part |
| **Summary tables** | Pre-aggregated rollups refreshed nightly | Dashboards over huge history |
| **Read replicas** | Send reports to a read-only copy on another server | Reports slowing down everyday work |

```sql
-- 🟥 MSSQL: compression can cut a large table's size by 60-70%
ALTER TABLE orders REBUILD WITH (DATA_COMPRESSION = PAGE);

-- Estimate the savings first
EXEC sp_estimate_data_compression_savings 'dbo', 'orders', NULL, NULL, 'PAGE';
```

```sql
-- 🟥 MSSQL: columnstore for analytics
CREATE TABLE sales_fact (
    sale_id     BIGINT        NOT NULL,
    sale_date   DATE          NOT NULL,
    product_id  INT           NOT NULL,
    quantity    INT           NOT NULL,
    net_amount  DECIMAL(12,2) NOT NULL
);
CREATE CLUSTERED COLUMNSTORE INDEX cci_sales_fact ON sales_fact;
-- Typically 10x compression and 10-100x faster aggregate scans
```

> [!TIP]
> 💡 **Compression is an underused win.** Less data on disk means fewer pages read, which means more of your table fits in memory. On systems limited by disk speed, page compression frequently makes queries **faster** despite the CPU cost of decompression.

## 50.5 🎯 When to partition — the honest decision tree

```text
Is the table causing you actual pain?
  └─ No  → 🛑 Do not partition. It is not a performance feature.
  └─ Yes ↓

Is the pain "queries are slow"?
  └─ Yes → 🎯 Fix INDEXES first (Ch 46). This solves it ~80% of the time.
  └─ No  ↓

Is the pain "purging/archiving old data takes hours and blocks users"?
  └─ Yes → ✅ PARTITION. This is what it is for. (SWITCH / DROP PARTITION)
  └─ No  ↓

Is the pain "maintenance windows are too long"?
  └─ Yes → ✅ PARTITION — rebuild one partition at a time.
  └─ No  ↓

Do nearly all queries filter on ONE obvious column (usually a date)?
  └─ Yes → ✅ Partition on it; you get elimination as a bonus.
  └─ No  → 🛑 You will get all the cost and none of the benefit.
```

> [!CAUTION]
> 🐛 **Common mistake:** partitioning on a column the queries do not filter on. You get zero partition elimination, every query still touches every partition, and you have added real complexity to your backups, indexes, and constraints. **Partition on the column in your `WHERE` clause, or do not partition.**

## 50.6 🧪 Try it yourself

1. Create a partitioned copy of `orders` by year in your engine.
2. Run a date-filtered query and confirm partition elimination in the plan.
3. Run a `customer_id` query and confirm it reads all partitions. Explain why.
4. In MSSQL, `SWITCH` a partition out to an archive table and time it.
5. In MySQL, `DROP PARTITION` for an old year and time it against an equivalent `DELETE`.

---
# 📐 PART 11 — DESIGN

---

# 51. Normalization, 1NF to BCNF

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 35 min | Spot badly designed tables · Apply 1NF, 2NF, and 3NF step by step · Design tables where every fact lives in one place |

> [!NOTE]
> 📌 **In plain words:** Normalization is the process of organizing your tables so that **every fact is stored in exactly one place**. Do it well and updates are simple and safe. Do it badly and your data contradicts itself.

> 🌍 **Analogy:** Writing your home address on 50 different forms. Move house, and you must find and correct all 50 — and you will miss some. Normalization means writing it **once**, and everything else pointing at that one copy.

## 51.1 💥 The three anomalies normalization prevents

Start with an unnormalized table:

| order_id | customer_name | customer_email | customer_city | products | total |
|---|---|---|---|---|---|
| 1001 | Amara Silva | amara@ex.com | Colombo | Laptop, Mouse | 1544.00 |
| 1002 | Amara Silva | amara@ex.com | Colombo | Keyboard | 129.00 |
| 1003 | John Baker | john@ex.com | London | Phone, Buds | 1078.00 |

| Anomaly | What goes wrong | Example |
|---|---|---|
| **Update anomaly** | The same fact stored many times; fix one and miss the rest | Amara changes email → must update every one of her order rows |
| **Insert anomaly** | You cannot record one fact without inventing another | You cannot add a new customer until they place an order |
| **Delete anomaly** | Deleting one fact destroys an unrelated one | Delete order 1003 and John Baker vanishes from the system entirely |

Plus the `products` column holding `'Laptop, Mouse'` makes it impossible to answer *"how many laptops did we sell?"* without string parsing.

## 51.2 1️⃣ First Normal Form (1NF)

> **Rule:** every cell holds a **single value** that cannot be split further (*atomic*), and there are no repeating groups of columns.

**❌ Violates 1NF — multiple values in one cell:**

| order_id | products |
|---|---|
| 1001 | Laptop, Mouse, Keyboard |

**❌ Also violates 1NF — repeating groups as columns:**

| order_id | product_1 | product_2 | product_3 |
|---|---|---|---|
| 1001 | Laptop | Mouse | Keyboard |

*(What happens on the day someone orders four items?)*

**✅ 1NF — one row per value:**

| order_id | product_id | quantity |
|---|---|---|
| 1001 | 1 | 1 |
| 1001 | 12 | 2 |
| 1001 | 11 | 1 |

> [!TIP]
> 💡 **How to spot a 1NF violation in the wild:** a column containing commas, a column named `phone1`, `phone2`, `phone3`, or a query that needs `SUBSTRING` to find a value. Any of those means the model is fighting you.

## 51.3 2️⃣ Second Normal Form (2NF)

> **Rule:** be in 1NF, **and** every non-key column must depend on the **whole** primary key — not just part of it.
>
> *(This only ever matters when the primary key is made of more than one column — a *composite* key.)*

**❌ Violates 2NF:**

| order_id (PK) | product_id (PK) | quantity | **product_name** | **product_price** |
|---|---|---|---|---|
| 1001 | 5 | 2 | Zenith Phone 12 | 899.00 |
| 1002 | 5 | 1 | Zenith Phone 12 | 899.00 |

`product_name` depends only on `product_id`, not on the full key `(order_id, product_id)`. So it is repeated for every order containing that product — and if the name changes, you must update it everywhere.

**✅ 2NF — split it out:**

```text
order_items(order_id, product_id, quantity, unit_price)   -- unit_price = the price PAID
products(product_id, product_name, unit_price)             -- unit_price = the price TODAY
```

> [!TIP]
> 💡 **Note `unit_price` stays in `order_items`.** That is not a violation — it is the price **at the time of sale**, which genuinely depends on the specific order line. `products.unit_price` is the current price. Two different facts, correctly stored separately.

## 51.4 3️⃣ Third Normal Form (3NF)

> **Rule:** be in 2NF, **and** no non-key column may depend on another non-key column (no *transitive* dependency — a chain where the key decides A, and A decides B).

**❌ Violates 3NF:**

| customer_id (PK) | full_name | city | **country** | **country_dial_code** |
|---|---|---|---|---|
| 1 | Amara Silva | Colombo | Sri Lanka | +94 |
| 2 | John Baker | London | UK | +44 |

`country_dial_code` depends on `country`, which is not the key. Every Sri Lankan customer repeats `+94`. If the code changed, you would update thousands of rows.

**✅ 3NF:**

```text
customers(customer_id, full_name, city, country_code)
countries(country_code, country_name, dial_code)
```

> [!TIP]
> 💡 **The classic mnemonic for 3NF:**
> *"Every non-key column must depend on **the key** (1NF), **the whole key** (2NF), and **nothing but the key** (3NF) — so help me Codd."* (Edgar F. Codd invented the relational database model.)

## 51.5 🔒 BCNF and beyond

**BCNF (Boyce-Codd Normal Form)** is a stricter 3NF: any column that decides another column's value (a *determinant*) must on its own be able to identify a row uniquely (a *candidate key*). It only matters in the unusual case where a table has several overlapping candidate keys.

**4NF** removes independent multi-valued facts stored together. If an employee has many skills *and* many languages, storing both in one table forces you to pair every skill with every language, which means nothing. Split into `employee_skills` and `employee_languages`.

**5NF** deals with join dependencies. You will almost never meet it in practice.

> [!IMPORTANT]
> 🎯 **In real-world practice: 3NF is the target.** Reaching 3NF eliminates virtually every anomaly that causes real pain. BCNF and above are worth knowing for interviews and for the rare edge case, but a well-designed 3NF design is what real systems run on.

## 51.6 🏗️ Normalizing ShopDB — a worked example

**❌ The flat, unnormalized version:**

```sql
CREATE TABLE orders_flat (
    order_id        INT,
    customer_name   VARCHAR(100),
    customer_email  VARCHAR(150),
    customer_city   VARCHAR(60),
    customer_country VARCHAR(60),
    order_date      DATE,
    product_names   VARCHAR(500),      -- ❌ 1NF: comma-separated
    quantities      VARCHAR(100),      -- ❌ 1NF: comma-separated
    total           DECIMAL(10,2)      -- ❌ derivable; can drift out of sync
);
```

**✅ Normalized to 3NF — which is exactly the ShopDB you built in [Chapter 4](#4-the-sample-database-shopdb):**

```text
customers   (customer_id PK, full_name, email, city, country, ...)
             └── one row per customer, email stored ONCE

categories  (category_id PK, category_name, description)
suppliers   (supplier_id PK, company_name, country, ...)

products    (product_id PK, product_name, category_id FK, supplier_id FK, unit_price, ...)
             └── product name stored ONCE

orders      (order_id PK, customer_id FK, employee_id FK, order_date, status, ...)
             └── one row per order; no customer details duplicated

order_items (order_id FK, product_id FK, unit_price, quantity, discount)
             └── PK (order_id, product_id) — one row per line, fully atomic

payments    (payment_id PK, order_id FK, amount, method, status)
```

**Notice what disappeared:** the `total` column. It is **derivable** from `order_items`, so storing it risks the stored total disagreeing with the sum of the lines. Compute it when you need it:

```sql
SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS total
FROM order_items GROUP BY order_id;
```

## 51.7 🧭 The practical normalization checklist

Ask these questions of every table you design:

1. ☑️ Does any cell contain a list, or a comma?
2. ☑️ Do I have columns like `x1`, `x2`, `x3`?
3. ☑️ Is the same text repeated across many rows?
4. ☑️ If I updated one fact, would I have to change more than one row?
5. ☑️ Can I add a new "thing" without inventing a fake related record?
6. ☑️ If I deleted a row, would I lose an unrelated fact forever?
7. ☑️ Does any non-key column depend on another non-key column?
8. ☑️ Am I storing something I could always calculate?

> [!TIP]
> 💡 **A "yes" to any of 1–7 means you have more normalizing to do. A "yes" to 8 means you should either remove it or read the next chapter deliberately.**

## 51.8 🧪 Try it yourself

1. Take the `orders_flat` table above and normalize it to 3NF on paper, then in SQL.
2. Find the 3NF violation in this table and fix it: `employees(employee_id, name, department_id, department_name, department_budget)`.
3. Design a schema for a school: students, courses, enrolments, teachers, grades. Get it to 3NF.
4. Explain in one sentence why `order_items.unit_price` is *not* a normalization violation.

---

# 52. Denormalization and when to break the rules

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 20 min | Know when storing data twice is worth it · Use the five safe patterns · Keep duplicated data honest |

> [!NOTE]
> 📌 **In plain words:** Denormalization is **deliberately storing something twice** to make reads faster. It is not a mistake — it is a trade, and you must know exactly what you are trading.

> 🌍 **Analogy:** Keeping a spare key at your neighbour's house. Strictly, there should be one key. But retrieving it is so much faster than calling a locksmith that the duplication is worth it — **as long as you remember to update both when you change the lock.**

## 52.1 ⚖️ The trade

| You gain | You pay |
|---|---|
| ⚡ Faster reads (fewer joins) | ⚠️ More storage |
| 📊 Simpler report queries | ⚠️ Slower writes (multiple places to update) |
| 🛡️ Fewer locks on busy tables | 🐛 **Risk of the copies disagreeing** |

> [!WARNING]
> ⚠️ **The last one is the real cost.** Every denormalized copy is a promise you have to keep, forever, in every code path. If a single `UPDATE` somewhere forgets to maintain it, your data starts lying and nobody notices for months.

## 52.2 🎯 The five legitimate denormalization patterns

**① Historical snapshot values** — *the one everybody needs*

```sql
-- ✅ order_items.unit_price duplicates products.unit_price ON PURPOSE
-- The order must remember what the customer ACTUALLY paid, forever.
-- If the product price rises tomorrow, last year's invoices must not change.
```

> [!TIP]
> 💡 **This is not really denormalization at all** — it is recognizing that "the price now" and "the price paid on 3 March" are **two different facts**. Any e-commerce, invoicing, or accounting system must store both. Also applies to: shipping addresses on orders, tax rates on invoices, product names on receipts.

**② Pre-computed aggregates**

```sql
-- ✅ Store a running count that would otherwise need a COUNT(*) on millions of rows
ALTER TABLE customers ADD order_count INT NOT NULL DEFAULT 0;
ALTER TABLE customers ADD lifetime_value DECIMAL(12,2) NOT NULL DEFAULT 0;

-- Maintained by a trigger, a stored procedure, or a nightly job
```

> [!IMPORTANT]
> 🎯 **When it is worth it:** a leaderboard, a "posts: 4,281" counter, a dashboard read thousands of times per minute where the underlying `COUNT` scans a huge table. **When it is not:** anything you can compute in under 50 ms on demand.

**③ Redundant columns to avoid a join**

```sql
-- ✅ Copy the customer's country onto the order so reports skip a join
ALTER TABLE orders ADD customer_country VARCHAR(60);
```

> [!WARNING]
> ⚠️ **But this one is also a snapshot decision in disguise.** If the customer moves to a new country, should last year's orders change country? Almost certainly **not** — so this copy is actually correct history, not stale data. Think it through explicitly.

**④ Summary and reporting tables**

```sql
-- ✅ 🟥 MSSQL (in MySQL, make refreshed_at a DATETIME) — rebuild nightly; dashboards read this instead of hammering the live tables
CREATE TABLE daily_sales_summary (
    sales_date      DATE PRIMARY KEY,
    order_count     INT NOT NULL,
    total_revenue   DECIMAL(14,2) NOT NULL,
    unique_customers INT NOT NULL,
    refreshed_at    DATETIME2(0) NOT NULL
);
```

> [!TIP]
> 💡 **This is the safest denormalization**, because the summary table is **derived and disposable**. If it drifts, you rebuild it from the source of truth. No data is ever lost. Prefer this pattern over adding redundant columns to your live tables.

**⑤ Star schemas for analytics** — see the next chapter.

## 52.3 🛡️ Keeping denormalized data honest

Whatever you denormalize, you need **all three** of these:

```sql
-- 🟥 MSSQL
-- 1️⃣ MAINTAIN it — a trigger, procedure, or job that keeps it current
CREATE OR ALTER TRIGGER trg_update_customer_stats
ON orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.order_count = x.n
    FROM customers c
    JOIN (SELECT customer_id, COUNT(*) AS n FROM orders GROUP BY customer_id) x
      ON x.customer_id = c.customer_id
    WHERE c.customer_id IN (SELECT customer_id FROM inserted
                            UNION SELECT customer_id FROM deleted);
END;
GO

-- 2️⃣ VERIFY it — a reconciliation query you run on a schedule
SELECT
    c.customer_id,
    c.order_count       AS stored_count,
    COUNT(o.order_id)   AS actual_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.order_count
HAVING c.order_count <> COUNT(o.order_id);      -- should return ZERO rows

-- 3️⃣ REBUILD it — a script that recomputes everything from the source of truth
UPDATE c SET order_count = s.n
FROM customers c
JOIN (SELECT customer_id, COUNT(*) AS n FROM orders GROUP BY customer_id) s
  ON s.customer_id = c.customer_id;
```

> [!TIP]
> 💡 **If you cannot write the verification query, you are not ready to denormalize.** Put that reconciliation query in a scheduled job and alert on any rows it returns. Silent data drift is the entire danger, and this is how you make it loud.

## 52.4 📏 The decision rule

```text
Is the query genuinely too slow?
  └─ No  → 🛑 STOP. Do not denormalize. You are optimizing a non-problem.
  └─ Yes ↓

Have you added the right indexes?
  └─ No  → 🎯 Do that first. It solves this 80% of the time.
  └─ Yes ↓

Can a materialized view / summary table solve it? (derived, disposable, safe)
  └─ Yes → ✅ Do that.
  └─ No  ↓

Is this genuinely a HISTORICAL SNAPSHOT rather than duplication?
  └─ Yes → ✅ Store it. It is a separate fact, not a copy.
  └─ No  ↓

Can you write the maintenance, verification, AND rebuild scripts?
  └─ No  → 🛑 STOP.
  └─ Yes → ✅ Denormalize, and document exactly why in a comment.
```

> [!TIP]
> 💡 **"Normalize until it hurts, denormalize until it works."** Start normalized. Measure. Denormalize only where the numbers prove you must, and never without the three safeguards above.

## 52.5 🧪 Try it yourself

1. Add an `order_count` column to `customers`, populate it, and write the verification query.
2. Deliberately insert an order without updating the counter, then run your verification query and see it catch the drift.
3. Build a `daily_sales_summary` table and a refresh script.
4. List three columns in ShopDB that *look* denormalized but are actually correct historical snapshots.

---

# 53. Data modeling and the star schema

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 30 min | Plan tables before writing SQL · Model one-to-many and many-to-many links · Build a star schema for reports · Keep history when data changes |

> [!NOTE]
> 📌 **In plain words:** Data modeling is designing the tables **before** you write any SQL. Get it right and everything that comes after is easy; get it wrong and you fight it for years.

> 🌍 **Analogy:** An architect's drawing of a house. Moving a wall on paper costs an eraser. Moving it after the house is built costs a fortune.

## 53.1 🧭 The three levels of a data model

| Level | Audience | Contains |
|---|---|---|
| **Conceptual** | Business people | The main things (*entities*) and how they relate. No columns, no types. *"Customers place Orders for Products."* |
| **Logical** | Analysts and architects | Every column, key, and relationship, normalized. Not tied to any database product. |
| **Physical** | Developers and DBAs (database administrators) | Actual `CREATE TABLE` statements: types, indexes, partitions, engine-specific details. |

## 53.2 🔗 Modelling relationships correctly

**One-to-many** — the most common. Put the foreign key on the **many** side.

```text
One customer → many orders. The FK lives on orders:
    orders.customer_id  ──►  customers.customer_id
```

**Many-to-many** — always needs a **bridge (junction) table**.

```sql
-- One order has many products; one product is on many orders.
-- (Named _demo so it does not clash with the real ShopDB order_items table.)
CREATE TABLE order_items_demo (
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);
```

> [!TIP]
> 💡 **A bridge table is often more than plumbing.** `order_items` carries `quantity`, `unit_price`, and `discount` — real facts that belong to the *relationship*, not to either side. When you find yourself asking "where do I put the quantity?", the bridge table is the answer.

**One-to-one** — rarer. Use it to split off optional or sensitive columns.

```sql
-- Keep sensitive data in a separate table with tighter permissions
CREATE TABLE customer_private (
    customer_id   INT PRIMARY KEY,
    national_id   VARCHAR(50),
    date_of_birth DATE,
    CONSTRAINT fk_cp_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

**Self-referencing** — hierarchies.

```text
employees.manager_id           ──►  employees.employee_id
categories.parent_category_id  ──►  categories.category_id
```

## 53.3 ⭐ The star schema — modelling for analytics

> [!NOTE]
> 📌 **In plain words:** Normalized designs (3NF) are built for **writing** — one fact in one place. Reporting needs fast **reading** — millions of rows summarized quickly. The **star schema** is the standard design for reporting: one big **fact** table of events (each sale) in the middle, surrounded by small **dimension** tables that describe them (when, who, what).

```text
                  ┌──────────────┐
                  │  dim_date    │
                  │ date_key PK  │
                  │ year, month  │
                  │ quarter, day │
                  └──────┬───────┘
                         │
  ┌────────────┐   ┌─────▼──────────────┐   ┌──────────────┐
  │dim_customer│   │   FACT_SALES       │   │ dim_product  │
  │customer_key├──►│ date_key      FK   │◄──┤ product_key  │
  │ name, city │   │ customer_key  FK   │   │ name, category│
  │ country    │   │ product_key   FK   │   │ supplier      │
  └────────────┘   │ employee_key  FK   │   └──────────────┘
                   │ ─────────────────  │
  ┌────────────┐   │ quantity   MEASURE │
  │dim_employee├──►│ unit_price MEASURE │
  │employee_key│   │ discount   MEASURE │
  │ name, dept │   │ net_amount MEASURE │
  └────────────┘   └────────────────────┘
```

| | **Fact table** | **Dimension table** |
|---|---|---|
| Contains | Measurements and foreign keys | Descriptive attributes |
| Size | Huge (millions to billions of rows) | Small (hundreds to millions) |
| Grows | Constantly, by insert | Slowly |
| Example columns | `quantity`, `net_amount` | `product_name`, `country`, `month_name` |
| Normalized? | Yes, by nature | **Deliberately denormalized (flat)** |

```sql
-- ✅ Works in BOTH: a star schema for ShopDB analytics
CREATE TABLE dim_date (
    date_key     INT PRIMARY KEY,          -- 20260615
    full_date    DATE NOT NULL,
    day_of_month INT NOT NULL,
    month_num    INT NOT NULL,
    month_name   VARCHAR(20) NOT NULL,
    quarter      INT NOT NULL,
    year_num     INT NOT NULL,
    day_name     VARCHAR(20) NOT NULL,
    is_weekend   TINYINT NOT NULL
);

CREATE TABLE dim_customer (
    customer_key  INT PRIMARY KEY,
    customer_id   INT NOT NULL,            -- the original operational key
    full_name     VARCHAR(100) NOT NULL,
    city          VARCHAR(60),
    country       VARCHAR(60) NOT NULL,
    loyalty_tier  VARCHAR(10) NOT NULL
);

CREATE TABLE dim_product (
    product_key   INT PRIMARY KEY,
    product_id    INT NOT NULL,
    product_name  VARCHAR(120) NOT NULL,
    category_name VARCHAR(50) NOT NULL,    -- 🔑 flattened: no join to categories
    supplier_name VARCHAR(100),            -- 🔑 flattened: no join to suppliers
    unit_price    DECIMAL(10,2) NOT NULL
);

CREATE TABLE fact_sales (
    sales_key     BIGINT PRIMARY KEY,
    date_key      INT NOT NULL,
    customer_key  INT NOT NULL,
    product_key   INT NOT NULL,
    employee_key  INT NULL,
    order_id      INT NOT NULL,
    quantity      INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    discount      DECIMAL(4,3) NOT NULL,
    net_amount    DECIMAL(12,2) NOT NULL   -- pre-computed for speed
);
```

**Why analysts love this:**

```sql
-- Every business question is the same simple shape: fact JOIN dims, GROUP BY
SELECT
    d.year_num,
    d.quarter,
    p.category_name,
    c.country,
    SUM(f.net_amount) AS revenue,
    SUM(f.quantity)   AS units
FROM fact_sales f
JOIN dim_date     d ON d.date_key = f.date_key
JOIN dim_product  p ON p.product_key = f.product_key
JOIN dim_customer c ON c.customer_key = f.customer_key
GROUP BY d.year_num, d.quarter, p.category_name, c.country
ORDER BY revenue DESC;
```

> [!TIP]
> 💡 **No nested joins, no chains through three lookup tables** — every dimension is exactly one join from the fact. That predictable shape is why BI (business intelligence) tools such as Power BI, Tableau, and Looker all expect a star schema.

> 🔀 **Star vs snowflake:** a **snowflake** schema normalizes the dimensions (so `dim_product` would join to a separate `dim_category`). It saves a little space and costs extra joins on every query. **Prefer the star.** Dimension tables are small; the storage saving is not worth the complexity.

## 53.4 🕰️ Slowly Changing Dimensions (SCD)

> [!NOTE]
> 📌 **The question:** a customer moves from Colombo to Kandy. Should last year's sales report now say Kandy? A *slowly changing dimension* is a descriptive table whose values change now and then, and the "type" is how you handle that change.

| Type | Behaviour | Use when |
|---|---|---|
| **Type 0** | Never changes | Date of birth, original signup date |
| **Type 1** | Overwrite; history is lost | Fixing a typo in a name |
| **Type 2** | Add a new row with validity dates; full history kept | **The important one.** Customer moves, changes tier, changes segment |
| **Type 3** | Keep a `previous_value` column | You only ever need the prior value |

```sql
-- ✅ Type 2: the standard implementation
CREATE TABLE dim_customer_scd2 (
    customer_key   INT PRIMARY KEY,        -- surrogate key, NEW for each version
    customer_id    INT NOT NULL,           -- stable business key
    full_name      VARCHAR(100) NOT NULL,
    city           VARCHAR(60),
    country        VARCHAR(60) NOT NULL,
    loyalty_tier   VARCHAR(10) NOT NULL,
    valid_from     DATE NOT NULL,
    valid_to       DATE NULL,              -- NULL = this is the current version
    is_current     TINYINT NOT NULL DEFAULT 1
);
```

| customer_key | customer_id | city | valid_from | valid_to | is_current |
|---|---|---|---|---|---|
| 101 | 1 | Colombo | 2024-02-11 | 2026-06-30 | 0 |
| 205 | 1 | Kandy | 2026-07-01 | *NULL* | 1 |

Because `fact_sales` stores the **`customer_key`** (not `customer_id`), every historical sale stays attached to the version of the customer that was true at the time. A 2025 report still says Colombo. **That is the whole point.**

> 🔀 **MSSQL has this built in as temporal tables:**
> ```sql
> -- 🟥 MSSQL
> CREATE TABLE customers_temporal (
>     customer_id INT PRIMARY KEY,
>     full_name   NVARCHAR(100) NOT NULL,
>     city        NVARCHAR(60),
>     valid_from  DATETIME2 GENERATED ALWAYS AS ROW START,
>     valid_to    DATETIME2 GENERATED ALWAYS AS ROW END,
>     PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
> ) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.customers_history));
>
> -- Then query any point in time:
> SELECT * FROM customers_temporal FOR SYSTEM_TIME AS OF '2026-03-01';
> ```
> This is one of SQL Server's genuinely excellent features. MySQL has no equivalent — you implement SCD Type 2 by hand.

> 🔎 **[Chapter 62](#62-temporal-tables-history-and-change-tracking) is the full treatment** — creating and querying temporal tables, retention, Change Tracking for ETL, and the MySQL trigger-based equivalent.

## 53.5 ✅ The design review checklist

| ☑️ | Check |
|---|---|
| ☐ | Every table has a primary key |
| ☐ | Primary keys are narrow and stable (`INT`/`BIGINT`, never updated) |
| ☐ | Every relationship has a foreign key constraint |
| ☐ | Every foreign key column is indexed (**especially in MSSQL**) |
| ☐ | Column names are consistent (`customer_id` everywhere, never `custID` here and `cust_id` there) |
| ☐ | `NOT NULL` is the default; every nullable column is justified |
| ☐ | Money is `DECIMAL`, never `FLOAT` |
| ☐ | Date-times are stored in UTC (world standard time, with no time-zone shifts) |
| ☐ | No comma-separated lists in any column |
| ☐ | No `column1`, `column2`, `column3` patterns |
| ☐ | Business rules are enforced by constraints, not only by the app |
| ☐ | Every denormalized value has a maintenance and verification plan |
| ☐ | Audit columns (`created_at`, `updated_at`) exist where they matter |
| ☐ | Soft-delete strategy decided consistently across the schema |
| ☐ | Naming convention documented and followed everywhere |

## 53.6 🧪 Try it yourself

1. Draw the conceptual model for a library: members, books, copies, loans, reservations, fines.
2. Turn it into a 3NF logical model, then a physical one with real `CREATE TABLE` statements.
3. Build a star schema for ShopDB sales and load it from the operational tables.
4. Implement SCD Type 2 for `dim_customer` and simulate a customer moving city.
5. Run the design review checklist against your library schema.

---
# 🛡️ PART 12 — ADMINISTRATION AND SECURITY

---

# 54. Security: users, roles, and permissions

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 40 min | Create logins, users, and roles · Grant only the access each account needs · Show each user only their own rows · Protect sensitive data |

> [!NOTE]
> 📌 **In plain words:** Security answers three questions: **who are you** (authentication), **what are you allowed to do** (authorization), and **what did you actually do** (auditing).

> 🌍 **Analogy:** An office building. Your **ID badge** proves who you are. The **door access list** decides which floors you can enter. The **entry log** records where you went. A database needs all three.

## 54.1 🔑 The security hierarchy

```text
🟥 MSSQL                              🟦 MySQL
─────────────────────────             ─────────────────────────
LOGIN     (server level)              USER 'name'@'host'
   │                                     │
   ▼                                     ▼
USER      (database level)            (users are server-wide)
   │                                     │
   ▼                                     ▼
ROLE      (group of permissions)      ROLE (MySQL 8.0+)
   │                                     │
   ▼                                     ▼
PERMISSION on objects                 PRIVILEGE on objects
```

> 🔀 **The key structural difference:** MSSQL separates the **login** (connects to the server) from the **user** (exists inside one database) — so one login can map to users in several databases with different rights. MySQL identifies a user by **name plus host** (`'app'@'10.0.0.%'`), which is itself a security control: the same username from a different machine is a different account.

## 54.2 👤 Creating users

```sql
-- 🟥 MSSQL
-- Step 1: a server-level login
CREATE LOGIN app_user WITH PASSWORD = 'Str0ng!Passw0rd#2026';

-- Step 2: a database-level user mapped to it
USE ShopDB;
CREATE USER app_user FOR LOGIN app_user;

-- Windows authentication (preferred on a company Windows network — no password to leak; not available on Linux/Docker)
CREATE LOGIN [DOMAIN\SalesTeam] FROM WINDOWS;
CREATE USER [DOMAIN\SalesTeam] FOR LOGIN [DOMAIN\SalesTeam];

-- Maintenance (on a throwaway login, so app_user survives for the rest of this chapter)
CREATE LOGIN old_login WITH PASSWORD = 'Old!Passw0rd#2026';
CREATE USER old_login FOR LOGIN old_login;
ALTER LOGIN old_login WITH PASSWORD = 'NewStr0ng!Passw0rd';
ALTER LOGIN old_login DISABLE;
DROP USER old_login;
DROP LOGIN old_login;
```

```sql
-- 🟦 MySQL
CREATE USER 'app_user'@'localhost'  IDENTIFIED BY 'Str0ng!Passw0rd#2026';
CREATE USER 'app_user'@'10.0.0.%'   IDENTIFIED BY 'Str0ng!Passw0rd#2026';  -- a subnet
CREATE USER 'report_user'@'%'       IDENTIFIED BY 'An0ther!Passw0rd';      -- ⚠️ any host

-- Password policy (a separate account, so app_user survives for the rest of this chapter)
CREATE USER 'policy_user'@'localhost'
    IDENTIFIED BY 'Str0ng!Pass'
    PASSWORD EXPIRE INTERVAL 90 DAY
    FAILED_LOGIN_ATTEMPTS 5 PASSWORD_LOCK_TIME 1;

ALTER USER 'policy_user'@'localhost' IDENTIFIED BY 'NewPassw0rd!';
ALTER USER 'policy_user'@'localhost' ACCOUNT LOCK;
DROP USER 'policy_user'@'localhost';
```

> [!WARNING]
> ⚠️ **`'user'@'%'` allows connection from anywhere on the network.** Restrict the host wherever you can — it turns a leaked password into a much smaller incident.

## 54.3 🎫 Granting and revoking permissions

```sql
-- ✅ MSSQL

-- The other accounts used below (database users WITHOUT LOGIN are fine for practice)
CREATE USER support_user WITHOUT LOGIN;
CREATE USER report_user  WITHOUT LOGIN;
CREATE USER temp_user    WITHOUT LOGIN;

-- Read-only on one table
GRANT SELECT ON customers TO app_user;

-- Read/write
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO app_user;

-- Column-level: email and phone are NOT granted
GRANT SELECT (customer_id, full_name, city, country) ON customers TO support_user;

-- Execute a procedure without any table rights at all (the procedure from Chapter 37)
GRANT EXECUTE ON usp_get_customer_orders TO app_user;

-- Everything in a schema
GRANT SELECT ON SCHEMA::dbo TO report_user;

-- Take it back
REVOKE INSERT ON orders FROM app_user;

-- DENY beats every GRANT, even ones inherited through a role (MSSQL only)
DENY SELECT ON customers TO temp_user;
```

```sql
-- ✅ MySQL

-- The other account used below
CREATE USER 'support_user'@'localhost' IDENTIFIED BY 'Supp0rt!Passw0rd';

-- Read-only on one table
GRANT SELECT ON ShopDB.customers TO 'app_user'@'localhost';

-- Read/write
GRANT SELECT, INSERT, UPDATE, DELETE ON ShopDB.orders TO 'app_user'@'localhost';

-- Column-level: email and phone are NOT granted
GRANT SELECT (customer_id, full_name, city, country) ON ShopDB.customers TO 'support_user'@'localhost';

-- Execute a procedure without any table rights at all (the procedure from Chapter 37)
GRANT EXECUTE ON PROCEDURE ShopDB.usp_get_customer_orders TO 'app_user'@'localhost';

-- Everything in a database
GRANT SELECT ON ShopDB.* TO 'report_user'@'%';

-- Take it back
REVOKE INSERT ON ShopDB.orders FROM 'app_user'@'localhost';

FLUSH PRIVILEGES;   -- only needed after editing the grant tables directly; harmless after GRANT/REVOKE
```

> [!TIP]
> 💡 **MSSQL's three-state model: `GRANT`, `REVOKE`, `DENY`.** `REVOKE` removes a permission you granted. `DENY` actively blocks it and **overrides any grant**, including ones inherited from a role. MySQL has only grant and revoke — there is no deny.

## 54.4 👥 Roles — how permissions are actually managed

> [!NOTE]
> 📌 **Never grant permissions directly to people.** Grant to roles; put people in roles. When someone changes job, you change one membership instead of auditing 40 individual grants.

```sql
-- 🟥 MSSQL
CREATE ROLE sales_readonly;
CREATE ROLE sales_readwrite;
CREATE ROLE reporting;

GRANT SELECT ON SCHEMA::dbo TO sales_readonly;

GRANT SELECT, INSERT, UPDATE ON orders      TO sales_readwrite;
GRANT SELECT, INSERT, UPDATE ON order_items TO sales_readwrite;
GRANT SELECT                  ON products   TO sales_readwrite;

ALTER ROLE sales_readonly  ADD MEMBER report_user;
ALTER ROLE sales_readwrite ADD MEMBER app_user;

CREATE USER old_user WITHOUT LOGIN;                 -- someone about to change job
ALTER ROLE sales_readwrite ADD MEMBER old_user;
ALTER ROLE sales_readwrite DROP MEMBER old_user;

-- Built-in database roles (practice users without logins)
CREATE USER analyst_user WITHOUT LOGIN;
CREATE USER etl_user     WITHOUT LOGIN;
CREATE USER admin_user   WITHOUT LOGIN;
ALTER ROLE db_datareader ADD MEMBER analyst_user;   -- read everything
ALTER ROLE db_datawriter ADD MEMBER etl_user;       -- write everything
ALTER ROLE db_owner      ADD MEMBER admin_user;     -- ⚠️ everything
```

```sql
-- 🟦 MySQL 8.0+
CREATE ROLE 'sales_readonly', 'sales_readwrite', 'reporting';

GRANT SELECT ON ShopDB.* TO 'sales_readonly';
GRANT SELECT, INSERT, UPDATE ON ShopDB.orders      TO 'sales_readwrite';
GRANT SELECT, INSERT, UPDATE ON ShopDB.order_items TO 'sales_readwrite';

GRANT 'sales_readwrite' TO 'app_user'@'localhost';

-- ⚠️ MySQL roles are NOT active until set as default
SET DEFAULT ROLE ALL TO 'app_user'@'localhost';

REVOKE 'sales_readwrite' FROM 'app_user'@'localhost';
```

> [!WARNING]
> ⚠️ **The MySQL gotcha that wastes hours:** you grant a role, the user connects, and they still have no permissions. MySQL roles must be **activated** — either with `SET DEFAULT ROLE` (once, by an admin) or `SET ROLE` (per session). Always run `SET DEFAULT ROLE ALL` after granting.

## 54.5 🔒 The principle of least privilege

> [!NOTE]
> 📌 **Give every account the minimum permissions it needs to do its job — and nothing more.**

| Account | Should have | Should NOT have |
|---|---|---|
| **Web application** | `SELECT/INSERT/UPDATE` on business tables, or just `EXECUTE` on procedures | `DROP`, `ALTER`, `DELETE` on audit tables, access to other databases |
| **Reporting/BI** | `SELECT` only, ideally on views, ideally on a replica | Any write permission at all |
| **ETL/import job** | Write access to staging tables, `EXECUTE` on load procedures | Access to production tables outside its scope |
| **Developer (on the live server)** | `SELECT` on non-sensitive data; nothing else without a change request | `sa` / `root`. Ever. |
| **DBA** | Administrative rights, used from a named personal account | A shared account nobody can attribute |

```sql
-- ✅ A realistic least-privilege setup for the ShopDB web app

-- 🟥 MSSQL
CREATE LOGIN shop_app WITH PASSWORD = 'Str0ng!Passw0rd#2026';
USE ShopDB;
CREATE USER shop_app FOR LOGIN shop_app;

CREATE ROLE app_role;
GRANT SELECT ON dbo.products   TO app_role;
GRANT SELECT ON dbo.categories TO app_role;
GRANT SELECT, INSERT, UPDATE ON dbo.orders      TO app_role;
GRANT SELECT, INSERT          ON dbo.order_items TO app_role;
GRANT SELECT, INSERT          ON dbo.payments    TO app_role;
GRANT SELECT, INSERT, UPDATE  ON dbo.customers   TO app_role;
DENY  DELETE ON dbo.orders   TO app_role;      -- the app soft-deletes only
DENY  SELECT ON dbo.employees TO app_role;     -- salaries are none of its business

ALTER ROLE app_role ADD MEMBER shop_app;
```

> [!TIP]
> 💡 **The single most valuable security pattern: grant `EXECUTE` on stored procedures and nothing else.** The application cannot run arbitrary SQL, cannot read tables it was not meant to, and cannot be exploited into a `DROP TABLE` — because it has no table permissions at all. It works through **ownership chaining**: when a procedure and the tables it touches have the same owner, SQL Server checks permission on the procedure only. That is why many large companies require procedure-only access.

## 54.6 🛡️ Row-Level Security — filtering rows per user, automatically

> [!NOTE]
> 📌 **In plain words:** Permissions normally work on whole tables and columns. **Row-Level Security (RLS)** goes one level deeper: each user sees only *their own rows* of the same table — and the filter is applied by the engine, so no query can escape it.

> 🌍 **Analogy:** A **shared office inbox where the mail is pre-sorted**. Everyone opens the same cabinet, but each person physically only finds their own letters. They cannot look at a colleague's post even by accident, because it is not in the drawer they opened.

The naive approach is a view with a `WHERE` clause — but anyone with table access can simply query the table directly and bypass it. RLS cannot be bypassed.

```sql
-- 🟥 MSSQL: STEP 1 — a predicate function that returns a row when access is allowed
CREATE SCHEMA rls;
GO

CREATE OR ALTER FUNCTION rls.fn_orders_by_rep(@employee_id INT)
RETURNS TABLE
WITH SCHEMABINDING                        -- 🔑 required
AS
RETURN
    SELECT 1 AS is_visible
    WHERE @employee_id = CAST(SESSION_CONTEXT(N'employee_id') AS INT)
       OR SESSION_CONTEXT(N'employee_id') IS NULL;   -- no context set = admin/full view
GO

-- STEP 2 — bind it to the table as a security policy
CREATE SECURITY POLICY rls.orders_filter
ADD FILTER PREDICATE rls.fn_orders_by_rep(employee_id) ON dbo.orders
WITH (STATE = ON);
GO
```

**Now watch the same query return different rows for different reps:**

```sql
-- 🟥 MSSQL
SELECT COUNT(*) AS visible FROM orders;                  -- 23  (no context = full view)

EXEC sp_set_session_context @key = N'employee_id', @value = 3;
SELECT COUNT(*) AS visible FROM orders;                  -- 10  (Priya Raman's orders)

EXEC sp_set_session_context @key = N'employee_id', @value = 4;
SELECT COUNT(*) AS visible FROM orders;                  --  7  (Tom Becker's orders)
```

**Verified output on ShopDB:**

| session context | rows visible in `orders` |
|---|---|
| *(none set)* | 23 |
| `employee_id = 3` | 10 |
| `employee_id = 4` | 7 |

> [!NOTE]
> 📌 **The important part: the query never changed.** `SELECT COUNT(*) FROM orders` is the same text every time. The engine silently adds your filter condition to every query touching that table — `SELECT`, and with a **block predicate**, `INSERT`/`UPDATE`/`DELETE` too.

| Predicate type | What it does |
|---|---|
| `FILTER PREDICATE` | Silently hides rows from reads (no error, they simply are not there) |
| `BLOCK PREDICATE` | Raises an error if a write would create or modify a row the user should not own |

> [!IMPORTANT]
> 🎯 **When to use RLS:** one application shared by many client companies (*multi-tenant* — each company sees only its own rows), sales teams where reps must not see each other's deals, hospital records restricted by ward, any regulated data where "the app filters it" is not a good enough answer for an auditor.

> [!WARNING]
> ⚠️ **Three cautions:**
> 1. **The predicate runs on every query against that table** — keep it trivially cheap and make sure the column it filters on is **indexed**, or you will slow down the entire application.
> 2. **`sp_set_session_context` must be set by trusted code**, normally right after the connection is opened. If the application can be tricked into setting someone else's ID, RLS has bought you nothing. Also note that this demo shows **every** row when no ID is set — handy for learning, but in a real system a missing ID should show **nothing**.
> 3. **RLS applies to everyone, including `db_owner` and `sysadmin` members.** If administrators must see all rows, build that rule into the predicate function yourself — and always test with a real, low-privilege user before you trust it.

```sql
-- 🟥 MSSQL: inspect and disable
SELECT name, is_enabled FROM sys.security_policies;
ALTER SECURITY POLICY rls.orders_filter WITH (STATE = OFF);
DROP SECURITY POLICY rls.orders_filter;
```

> 🔀 **MySQL has no built-in row-level security.** The standard substitute is a **view that runs with its creator's rights**: create the view with `WITH CHECK OPTION` and `SQL SECURITY DEFINER`, grant users access to the *view only*, and revoke all access to the base table. It is weaker than RLS — it depends on you never granting table access — but it is the closest equivalent.

## 54.7 🔐 Encryption

| Protection | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| **In transit** | Force TLS (encryption of the network connection) | `REQUIRE SSL` on the user |
| **At rest (whole DB)** | Transparent Data Encryption (TDE) | InnoDB tablespace encryption |
| **Column level** | Always Encrypted, `ENCRYPTBYKEY` | `AES_ENCRYPT()` / `AES_DECRYPT()` |
| **Passwords** | Never encrypt — **hash** with bcrypt/Argon2 in the app | Same |
| **Data masking** | Dynamic Data Masking | Views with masking expressions |

```sql
-- 🟦 MySQL: require an encrypted connection
ALTER USER 'app_user'@'10.0.0.%' REQUIRE SSL;     -- the remote account from 54.2
```

```sql
-- 🟥 MSSQL: dynamic data masking — support sees only part of the value
ALTER TABLE customers
    ALTER COLUMN email ADD MASKED WITH (FUNCTION = 'email()');
ALTER TABLE customers
    ALTER COLUMN phone ADD MASKED WITH (FUNCTION = 'partial(0,"XXX-XXX-",4)');

CREATE USER senior_support WITHOUT LOGIN;   -- (a practice user)
GRANT UNMASK TO senior_support;             -- specific people can see the real values
```

> [!WARNING]
> ⚠️ **Never, ever encrypt passwords — hash them.** Encryption is reversible; that is the whole problem. Store a **salted hash** — a one-way scramble with random extra data mixed in, made with bcrypt, scrypt, or Argon2 — computed **in the application**, never in SQL. `MD5()` and `SHA1()` are broken for this purpose and must not be used for passwords.

> [!WARNING]
> ⚠️ **Dynamic Data Masking is a display convenience, not a security boundary.** A determined user with `SELECT` rights can work out masked values by guessing with `WHERE` clauses such as `WHERE email LIKE 'a%'`. Use real permissions for real secrets.

## 54.8 🕵️ Auditing

```sql
-- 🟥 MSSQL: who has what permission?
SELECT
    dp.name AS principal_name,
    dp.type_desc,
    p.permission_name,
    p.state_desc,
    OBJECT_NAME(p.major_id) AS object_name
FROM sys.database_permissions p
JOIN sys.database_principals dp ON dp.principal_id = p.grantee_principal_id
WHERE dp.name NOT IN ('public','dbo')
ORDER BY dp.name, object_name;

-- Role membership
SELECT r.name AS role_name, m.name AS member_name
FROM sys.database_role_members rm
JOIN sys.database_principals r ON r.principal_id = rm.role_principal_id
JOIN sys.database_principals m ON m.principal_id = rm.member_principal_id;
```

```sql
-- 🟦 MySQL
SHOW GRANTS FOR 'app_user'@'localhost';
SELECT * FROM mysql.user;
SELECT * FROM information_schema.user_privileges;
SELECT * FROM information_schema.schema_privileges WHERE table_schema = 'ShopDB';
```

## 54.9 ✅ The security checklist

| ☑️ | Item |
|---|---|
| ☐ | No application uses `sa` or `root` |
| ☐ | Every account follows least privilege |
| ☐ | Permissions granted to roles, never to individuals |
| ☐ | Strong password policy, rotation, and lockout enabled |
| ☐ | Connections encrypted with TLS |
| ☐ | Sensitive data encrypted at rest |
| ☐ | Passwords hashed in the app, never stored or encrypted in the DB |
| ☐ | All queries parameterized ([Chapter 55](#55-sql-injection-and-how-to-stop-it)) |
| ☐ | Default and sample accounts removed |
| ☐ | Database server not reachable from the public internet |
| ☐ | Auditing enabled for privileged actions |
| ☐ | Backups encrypted, and restore tested |
| ☐ | Permissions reviewed on a schedule, and whenever someone leaves |

## 54.10 🧪 Try it yourself

1. Create a read-only reporting user and verify it cannot insert.
2. Create a role granting access to `products` and `categories` only; add a user and test the boundary.
3. Grant column-level `SELECT` that excludes `email`, then try to select it.
4. List every permission currently granted in ShopDB.
5. In MySQL, grant a role, connect as that user *without* `SET DEFAULT ROLE`, and observe the failure.

---

# 55. SQL injection and how to stop it

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡 Beginner–Intermediate | 20 min | Explain how SQL injection works · Stop it with parameters · Write safe dynamic SQL · Recognize "defences" that do not work |

> [!NOTE]
> 📌 **In plain words:** SQL injection is when user input is treated as **SQL code** instead of **data**. It is the oldest, most common, and most damaging database vulnerability — and it is completely preventable.

> 🌍 **Analogy:** A form letter with a blank: *"Dear \_\_\_\_\_, your order has shipped."* If someone writes their name as *"Bob. PS: Also send everyone a refund."* and you photocopy the letter without thinking, you have just executed their instruction. Parameterization is the equivalent of putting the name in a **separate field on the envelope** that can never be read as part of the letter.

## 55.1 💀 How the attack works

```text
// ❌ VULNERABLE application code (any language)
query = "SELECT * FROM customers WHERE email = '" + userInput + "'";
```

**Normal input:** `amara.silva@example.com`

```sql
SELECT * FROM customers WHERE email = 'amara.silva@example.com';   -- ✅ fine
```

**Malicious input:** `' OR '1'='1`

```sql
SELECT * FROM customers WHERE email = '' OR '1'='1';
-- 💀 Returns EVERY customer. The login check just passed for everyone.
```

**Worse input:** `'; DROP TABLE customers; --`

```sql
SELECT * FROM customers WHERE email = ''; DROP TABLE customers; --';
-- 💀 The table is gone. The -- comments out the rest of the statement.
```

**Data theft with `UNION`:**

```sql
-- Input: ' UNION SELECT employee_id, first_name, last_name, title, department,
--          CAST(salary AS CHAR), '', '' FROM employees --
-- 💀 Salaries returned through the customer search box.
```

> [!WARNING]
> ⚠️ **Injection is not only about `SELECT`.** Attackers use it to read any table, modify data, escalate privileges, read files from the server, and in some configurations execute operating system commands. Every major data breach list is full of injection.

## 55.2 ✅ The one real fix: parameterized queries

> [!NOTE]
> 📌 **Parameters keep code and data in separate channels.** The database receives the SQL *structure* and the *values* independently, so a value can never become a command — no matter what it contains.

```csharp
// ✅ C# / .NET — SQL Server
using var cmd = new SqlCommand(
    "SELECT * FROM customers WHERE email = @email AND country = @country", conn);
cmd.Parameters.AddWithValue("@email", userInput);      // ← always just a value
cmd.Parameters.AddWithValue("@country", country);
```

```python
# ✅ Python — MySQL
cursor.execute(
    "SELECT * FROM customers WHERE email = %s AND country = %s",
    (user_input, country)                               # ← a tuple of values
)

# ✅ Python — SQL Server (pyodbc)
cursor.execute(
    "SELECT * FROM customers WHERE email = ? AND country = ?",
    (user_input, country)
)
```

```java
// ✅ Java — JDBC (works for both engines)
PreparedStatement ps = conn.prepareStatement(
    "SELECT * FROM customers WHERE email = ? AND country = ?");
ps.setString(1, userInput);
ps.setString(2, country);
```

```php
// ✅ PHP — PDO
$stmt = $pdo->prepare("SELECT * FROM customers WHERE email = :email");
$stmt->execute(['email' => $userInput]);
```

```javascript
// ✅ Node.js — mysql2
connection.execute(
    'SELECT * FROM customers WHERE email = ? AND country = ?',
    [userInput, country]
);
```

> [!TIP]
> 💡 **Now `' OR '1'='1` is simply searched for as a literal email address.** No customer has that email, so zero rows come back. The attack does not fail loudly — it becomes meaningless, which is exactly what you want.

## 55.3 🧯 Safe dynamic SQL, when you genuinely need it

Sometimes the *structure* must be dynamic (a sortable column, a variable table name). Parameters can only stand in for values, not for column or table names — so you must check names against an **allow-list** (a fixed list of permitted names).

```sql
-- 🟥 MSSQL: sp_executesql parameterizes VALUES; QUOTENAME protects IDENTIFIERS
CREATE OR ALTER PROCEDURE usp_search_customers
    @country   NVARCHAR(60)  = NULL,
    @city      NVARCHAR(60)  = NULL,
    @sort_col  SYSNAME       = 'full_name'
AS
BEGIN
    SET NOCOUNT ON;

    -- ✅ ALLOW-LIST the column name. Never paste it in raw.
    IF @sort_col NOT IN ('full_name','city','country','signup_date')
        SET @sort_col = 'full_name';

    DECLARE @sql NVARCHAR(MAX) = N'
        SELECT customer_id, full_name, city, country, signup_date
        FROM customers
        WHERE 1 = 1
          AND (@p_country IS NULL OR country = @p_country)
          AND (@p_city    IS NULL OR city    = @p_city)
        ORDER BY ' + QUOTENAME(@sort_col) + N';';

    -- ✅ Values passed as real parameters, never concatenated
    EXEC sp_executesql @sql,
         N'@p_country NVARCHAR(60), @p_city NVARCHAR(60)',
         @p_country = @country, @p_city = @city;
END;
GO
```

```sql
-- 🟦 MySQL: PREPARE / EXECUTE with USING
DELIMITER $$
CREATE PROCEDURE usp_search_customers(IN p_country VARCHAR(60), IN p_sort VARCHAR(30))
BEGIN
    DECLARE v_sort VARCHAR(30);

    -- ✅ ALLOW-LIST
    SET v_sort = CASE p_sort
        WHEN 'city'        THEN 'city'
        WHEN 'country'     THEN 'country'
        WHEN 'signup_date' THEN 'signup_date'
        ELSE 'full_name'
    END;

    SET @sql = CONCAT(
        'SELECT customer_id, full_name, city, country FROM customers ',
        'WHERE (? IS NULL OR country = ?) ORDER BY ', v_sort);

    SET @c = p_country;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @c, @c;      -- ✅ values bound, not concatenated
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;
```

> [!TIP]
> 💡 **The rule: parameterize values, allow-list names.** There is no third option. If you find yourself gluing a user-supplied string into SQL, stop and build the allow-list.

## 55.4 🚫 Defences that do NOT work

| ❌ "Defence" | Why it fails |
|---|---|
| **Escaping quotes yourself** | Misses look-alike Unicode quotes, attacks saved now and triggered later (*second-order injection*), and numbers (`WHERE id = 1 OR 1=1` needs no quotes at all) |
| **Blocking words like `DROP`** | Easily dodged: `DrOp`, `DR/**/OP`, encoded text, building the word letter by letter |
| **Hiding error messages** | *Blind* injection pulls data out by asking yes/no questions and timing the answers, without any error |
| **Client-side validation** | The attacker does not use your form; they send HTTP directly |
| **Stored procedures alone** | A procedure that concatenates strings internally is **just as vulnerable** |

```sql
-- ❌ 🟥 MSSQL: a stored procedure is NOT automatically safe
CREATE PROCEDURE usp_bad_search @email NVARCHAR(150)
AS
BEGIN
    EXEC('SELECT * FROM customers WHERE email = ''' + @email + '''');  -- 💀 injectable
END;
```

## 55.5 🛡️ Defence in depth

Even with parameterization everywhere, layer your defences:

1. ✅ **Parameterize every query.** Non-negotiable.
2. ✅ **Least privilege.** If the app account cannot `DROP`, an injection cannot drop.
3. ✅ **Validate input** by type and range (an ID should be an integer; reject anything else early).
4. ✅ **Generic error messages** to users; detailed ones to your logs only.
5. ✅ **A web application firewall** as an extra net, never as the primary control.
6. ✅ **Code review and automated code scanners** flagging text glued into SQL.
7. ✅ **Penetration testing** before release.
8. ✅ **Monitor** for unusual query patterns and error spikes.

> 🔎 **The rest of the application-side story is [Chapter 65](#65-sql-from-the-application-layer)** — why parameters are also a *performance* feature, connection pooling, timeouts, and safe retries.

## 55.6 🧪 Try it yourself

> [!WARNING]
> ⚠️ **On your own local ShopDB only.** Never test injection against a system you do not own.

1. Build a tiny script that concatenates user input into a query. Break it with `' OR '1'='1`.
2. Rewrite it with parameters and confirm the same input now returns nothing.
3. Write a safe dynamic-sort procedure with a whitelist, then try to inject through the sort parameter.
4. Create a least-privilege user with no `DELETE` rights and confirm an injected `DELETE` fails even if the injection succeeds syntactically.

---

# 56. Backup, restore, and disaster recovery

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 40 min | Choose how much data you can afford to lose · Take full, differential, and log backups · Restore to an exact moment · Test that backups really work |

> [!NOTE]
> 📌 **In plain words:** Everything else in this guide is about making the database useful. This chapter is about making sure it still **exists** tomorrow. It is the most important day-to-day topic there is.

> 🌍 **Analogy:** Backing up the photos on your phone. You only discover whether you did it properly on the day the phone is lost — and by then it is too late to start.

> [!WARNING]
> ⚠️ **The rule that matters more than any other in this guide: a backup you have never restored is not a backup. It is a hope.**

## 56.1 🎯 RPO and RTO — decide these first

| Term | Question it answers | Example |
|---|---|---|
| **RPO** (Recovery Point Objective) | How much **data** can we afford to lose? | "At most 15 minutes of transactions" |
| **RTO** (Recovery Time Objective) | How long can we be **down**? | "Back online within 1 hour" |

> [!TIP]
> 💡 **These are business decisions, not technical ones.** An RPO of 15 minutes means transaction log backups every 15 minutes. An RPO of zero means a second server updated at the very same instant (*synchronous replication*) and a much larger budget. **Ask the business, then design the backup strategy to meet the number** — not the other way round.

## 56.2 🟥 MSSQL backup

**Recovery models — choose deliberately:**

| Model | Log backups | Point-in-time restore | Use for |
|---|---|---|---|
| `SIMPLE` | ❌ Not possible | ❌ No | Dev, test, data warehouses reloadable from source |
| `FULL` | ✅ Required | ✅ Yes | **Production. Almost always this one.** |
| `BULK_LOGGED` | ✅ Yes | ⚠️ Limited during bulk ops | Temporarily, during a large bulk load |

```sql
ALTER DATABASE ShopDB SET RECOVERY FULL;
```

```sql
-- FULL backup: everything
BACKUP DATABASE ShopDB
TO DISK = 'D:\Backups\ShopDB_Full_20260909.bak'
WITH COMPRESSION, CHECKSUM, INIT,
     NAME = 'ShopDB Full Backup';

-- DIFFERENTIAL: only what changed since the last FULL (small and fast)
BACKUP DATABASE ShopDB
TO DISK = 'D:\Backups\ShopDB_Diff_20260909_1200.bak'
WITH DIFFERENTIAL, COMPRESSION, CHECKSUM;

-- TRANSACTION LOG: every committed transaction since the last log backup
BACKUP LOG ShopDB
TO DISK = 'D:\Backups\ShopDB_Log_20260909_1215.trn'
WITH COMPRESSION, CHECKSUM;
```

> [!TIP]
> 💡 **`WITH CHECKSUM` verifies pages as they are backed up**, catching corruption at backup time rather than at 3 a.m. during a restore. `WITH COMPRESSION` typically shrinks the file by 70–80% and, because less is written, often makes the backup **faster**. Use both, always.

**A typical schedule for a live system:**

```text
Sunday 01:00   FULL backup
Mon–Sat 01:00  DIFFERENTIAL backup
Every 15 min   TRANSACTION LOG backup

→ Worst-case data loss (RPO): 15 minutes
→ Restore path: last FULL + last DIFF + all LOGs since that DIFF
```

**Restoring:**

```sql
-- Restore the chain in order. NORECOVERY = "more files are coming, do not open the database yet".
USE master;          -- 🔑 you cannot restore the database your session is using
RESTORE DATABASE ShopDB
FROM DISK = 'D:\Backups\ShopDB_Full_20260909.bak'
WITH NORECOVERY, REPLACE;

RESTORE DATABASE ShopDB
FROM DISK = 'D:\Backups\ShopDB_Diff_20260909_1200.bak'
WITH NORECOVERY;

RESTORE LOG ShopDB
FROM DISK = 'D:\Backups\ShopDB_Log_20260909_1215.trn'
WITH RECOVERY;                       -- 🔑 the LAST file uses RECOVERY
```

```sql
-- ⭐ Point-in-time restore: recover to the moment BEFORE the bad UPDATE.
--    An alternative to the chain above: the same FULL and DIFF, then the log only up to STOPAT.
USE master;
RESTORE DATABASE ShopDB
FROM DISK = 'D:\Backups\ShopDB_Full_20260909.bak'
WITH NORECOVERY, REPLACE;

RESTORE DATABASE ShopDB
FROM DISK = 'D:\Backups\ShopDB_Diff_20260909_1200.bak'
WITH NORECOVERY;

RESTORE LOG ShopDB
FROM DISK = 'D:\Backups\ShopDB_Log_20260909_1215.trn'
WITH STOPAT = '2026-09-09 12:07:00', RECOVERY;
```

> [!TIP]
> 💡 **`STOPAT` is the feature that saves you from a bad `DELETE`.** Someone deletes 400,000 rows at 12:07. You restore to a copy of the database as it was at 12:06:59, then copy the missing rows back into the live database. Practise this **before** you need it.

```sql
-- Verify a backup file is readable and complete
RESTORE VERIFYONLY FROM DISK = 'D:\Backups\ShopDB_Full_20260909.bak';
RESTORE HEADERONLY FROM DISK = 'D:\Backups\ShopDB_Full_20260909.bak';

-- Backup history
SELECT database_name, backup_start_date, backup_finish_date, type, backup_size
FROM msdb.dbo.backupset
WHERE database_name = 'ShopDB'
ORDER BY backup_start_date DESC;
```

## 56.3 🟦 MySQL backup

**Logical backup — `mysqldump` writes out the SQL statements that rebuild your data (portable, human-readable, slower):**

```bash
# One database, consistent, with the binary-log position recorded
mysqldump -u root -p \
  --single-transaction \
  --routines --triggers --events \
  --source-data=2 \
  ShopDB > ShopDB_20260909.sql

# All databases
mysqldump -u root -p --all-databases --single-transaction > all_20260909.sql

# Compressed
mysqldump -u root -p ShopDB | gzip > ShopDB_20260909.sql.gz
```

> [!TIP]
> 💡 **`--single-transaction` is essential for InnoDB.** It takes the dump inside a consistent snapshot **without locking the tables**, so your application keeps running. Without it, `mysqldump` locks tables and your site stalls for the duration.

```bash
# Restore
mysql -u root -p ShopDB < ShopDB_20260909.sql
gunzip < ShopDB_20260909.sql.gz | mysql -u root -p ShopDB
```

**Physical backup — Percona XtraBackup copies the raw data files (fast, does not block users, for large databases):**

```bash
xtrabackup --backup --target-dir=/backups/full --user=root --password=***
xtrabackup --prepare --target-dir=/backups/full
xtrabackup --copy-back --target-dir=/backups/full
```

**Point-in-time recovery using the binary log:**

```sql
-- Enable binary logging (in my.cnf)
-- log_bin = /var/log/mysql/mysql-bin.log
-- binlog_format = ROW
-- binlog_expire_logs_seconds = 1209600      (14 days; the old expire_logs_days was removed in MySQL 8.4)

SHOW BINARY LOGS;
SHOW BINLOG EVENTS LIMIT 20;       -- the first log; add IN 'mysql-bin.000042' for a specific file from the list
```

```bash
# 1. Restore the last full dump
mysql -u root -p ShopDB < ShopDB_20260909.sql

# 2. Replay the binlog up to just before the disaster
mysqlbinlog --start-datetime="2026-09-09 01:00:00" \
            --stop-datetime="2026-09-09 12:06:59" \
            /var/log/mysql/mysql-bin.000042 | mysql -u root -p
```

> [!WARNING]
> ⚠️ **Without `log_bin` enabled, point-in-time recovery is impossible.** Your only option is restoring last night's dump and losing everything since. **Check that binary logging is on** with `SHOW VARIABLES LIKE 'log_bin';` — it is the MySQL equivalent of the transaction log. It has been on by default since MySQL 8.0, but it is often switched off to save disk space.

## 56.4 🌐 High availability

| Technology | 🟥 MSSQL | 🟦 MySQL | Protects against |
|---|---|---|---|
| Replication | Transactional/merge replication | Asynchronous / semi-synchronous replication | Spreading read and report traffic across servers |
| Sync replicas | Always On Availability Groups | Group Replication / InnoDB Cluster | Server failure with zero data loss |
| Clustering | Failover Cluster Instances | InnoDB Cluster + MySQL Router | Hardware failure |
| Log shipping | Log shipping | Delayed replica | A standby copy kept a little behind the live server |
| Cloud managed | Azure SQL, Amazon RDS | Amazon RDS, Aurora, Google Cloud SQL | Most of the above, run for you |

> [!TIP]
> 💡 **A replica is not a backup.** Replication faithfully copies your mistakes: `DROP TABLE customers` replicates in milliseconds. A **delayed replica** (MySQL `SOURCE_DELAY = 3600`) gives you a one-hour window to catch a disaster before it reaches the copy — a genuinely useful safety net alongside real backups.

## 56.5 🚨 The disaster recovery plan

> [!NOTE]
> 📌 **A backup strategy is not a DR (disaster recovery) plan.** A DR plan is a written document that a tired person can follow at 3 a.m.

| ☑️ | Element |
|---|---|
| ☐ | RPO and RTO agreed **with the business**, in writing |
| ☐ | Backups automated and monitored (**alert on failure AND on silence**) |
| ☐ | Backups stored **off the database server** |
| ☐ | Backups stored **off-site** (3-2-1 rule: 3 copies, 2 media types, 1 off-site) |
| ☐ | Backups encrypted |
| ☐ | **Restores tested on a schedule** — monthly at minimum |
| ☐ | Restore duration measured and known to meet the RTO |
| ☐ | Step-by-step instructions (a *runbook*) written, with commands ready to paste |
| ☐ | Contact list and escalation path documented |
| ☐ | Someone other than the author has successfully followed the runbook |

> [!WARNING]
> ⚠️ **The three ways backup strategies fail in the real world:**
> 1. **The backup job silently stopped weeks ago.** Nobody monitored it. Alert on the *absence* of a successful backup, not just on errors.
> 2. **The backups were on the same server that died.** Or the same shared storage system (SAN). Or the same datacentre.
> 3. **Nobody ever tried a restore.** The files were corrupt, or incomplete, or the restore took 14 hours against a 1-hour RTO.

## 56.6 🧪 Try it yourself

1. Take a full backup of ShopDB and restore it as `ShopDB_Restored`. Time it.
2. In MSSQL, set `FULL` recovery, take a full backup, delete some rows, take a log backup, and restore to a point in time just before the delete.
3. In MySQL, take a `mysqldump` with `--single-transaction`, drop a table, and restore.
4. Write a one-page restore runbook for ShopDB, then hand it to someone else and watch them follow it.

---

# 57. Monitoring and maintenance

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 30 min | Know what to watch on a live database · Find what the server is waiting on · Schedule routine care jobs · Explore your database with catalog queries |

> [!NOTE]
> 📌 **In plain words:** A database is not "done" when it goes live. It needs watching, tuning, and routine care — like a car needs servicing.

> 🌍 **Analogy:** The dashboard of that car. Warning lights (monitoring) tell you something is wrong *before* the engine fails, and the service schedule (maintenance) stops most of those lights coming on at all.

## 57.1 📊 What to monitor

| Category | Metric | Alert when |
|---|---|---|
| **Availability** | Can we connect? | Any failure |
| **Space** | Free disk, data/log file growth | Under 20% free |
| **Performance** | Slow queries, wait statistics, CPU, memory cache hit rate | Well above your normal levels, for more than a few minutes |
| **Blocking** | Longest blocking chain, deadlock count | Blocking over 30 s; deadlocks rising |
| **Backups** | Last successful backup time | No success in the expected window |
| **Replication** | Replica lag | Lag over your RPO |
| **Errors** | Serious errors in the error log (severity 17 or higher) | Immediately |
| **Corruption** | Consistency check results | Any error at all |

## 57.2 🔍 Essential monitoring queries

```sql
-- 🟥 MSSQL: what is running right now
SELECT
    r.session_id, r.status, r.command, r.wait_type, r.blocking_session_id,
    r.cpu_time, r.total_elapsed_time, r.reads, r.writes,
    SUBSTRING(t.text, (r.statement_start_offset/2)+1, 2000) AS query_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id <> @@SPID
ORDER BY r.total_elapsed_time DESC;

-- Where is the server spending its wait time? (the #1 health check)
SELECT TOP 15
    wait_type,
    wait_time_ms / 1000.0 AS wait_seconds,
    waiting_tasks_count,
    wait_time_ms / NULLIF(waiting_tasks_count,0) AS avg_ms_per_wait
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('CLR_SEMAPHORE','SLEEP_TASK','BROKER_TASK_STOP',
    'XE_TIMER_EVENT','LAZYWRITER_SLEEP','SQLTRACE_BUFFER_FLUSH','WAITFOR',
    'REQUEST_FOR_DEADLOCK_SEARCH','CHECKPOINT_QUEUE','DIRTY_PAGE_POLL',
    'HADR_FILESTREAM_IOMGR_IOCOMPLETION','SP_SERVER_DIAGNOSTICS_SLEEP')
ORDER BY wait_time_ms DESC;

-- Database and file sizes
SELECT
    DB_NAME(database_id) AS db_name,
    name AS file_name, type_desc,
    CAST(size AS BIGINT) * 8 / 1024 AS size_mb,
    CASE WHEN max_size = -1 THEN 'Unlimited'
         ELSE CAST(CAST(max_size AS BIGINT) * 8 / 1024 AS VARCHAR(20)) END AS max_mb   -- BIGINT: a 2 TB log limit overflows INT
FROM sys.master_files ORDER BY db_name, type_desc;
```

**Common MSSQL wait types and what they mean:**

| Wait type | Meaning | Usually means |
|---|---|---|
| `PAGEIOLATCH_*` | Waiting to read a page from disk | Slow storage or not enough memory |
| `CXPACKET`/`CXCONSUMER` | Parts of a query running on several CPU cores wait for each other | Often harmless; check the MAXDOP setting (max CPU cores per query) |
| `LCK_M_*` | Waiting for a lock | Blocking — find the session at the front of the queue |
| `WRITELOG` | Waiting to write the transaction log | Slow log disk; move the log to faster storage |
| `SOS_SCHEDULER_YIELD` | CPU pressure | Not enough CPU, or bad plans burning it |
| `RESOURCE_SEMAPHORE` | Waiting for memory to be reserved for the query | Bad estimates asking for too much memory |

```sql
-- 🟦 MySQL: essential health checks
SELECT * FROM performance_schema.processlist;
SHOW ENGINE INNODB STATUS;
SHOW GLOBAL STATUS LIKE 'Threads_connected';
SHOW GLOBAL STATUS LIKE 'Slow_queries';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read%';

-- Buffer pool hit ratio (how often the data was already in memory) — should be well above 99%
SELECT
    ROUND(100 * (1 - (
        (SELECT VARIABLE_VALUE FROM performance_schema.global_status
         WHERE VARIABLE_NAME = 'Innodb_buffer_pool_reads') /
        (SELECT VARIABLE_VALUE FROM performance_schema.global_status
         WHERE VARIABLE_NAME = 'Innodb_buffer_pool_read_requests')
    )), 2) AS buffer_pool_hit_pct;

-- The sys schema is a goldmine
SELECT * FROM sys.statements_with_runtimes_in_95th_percentile LIMIT 10;
SELECT * FROM sys.statements_with_full_table_scans LIMIT 10;
SELECT * FROM sys.schema_unused_indexes;
SELECT * FROM sys.io_global_by_file_by_bytes LIMIT 10;
SELECT * FROM sys.host_summary;

-- Table sizes
SELECT
    table_name,
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS total_mb,
    ROUND(data_length / 1024 / 1024, 2)  AS data_mb,
    ROUND(index_length / 1024 / 1024, 2) AS index_mb,
    table_rows
FROM information_schema.tables
WHERE table_schema = 'ShopDB'
ORDER BY (data_length + index_length) DESC;
```

## 57.3 🧰 Routine maintenance tasks

| Task | Frequency | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|---|
| Full backup | Daily/weekly | `BACKUP DATABASE` | `mysqldump` / XtraBackup |
| Log backup | Every 5–30 min | `BACKUP LOG` | Binary log retention |
| **Consistency check** | Weekly | `DBCC CHECKDB` | `CHECK TABLE` |
| Update statistics | Weekly, or after bulk loads | `UPDATE STATISTICS` | `ANALYZE TABLE` |
| Index maintenance | Weekly/monthly | `ALTER INDEX REORGANIZE/REBUILD` | `OPTIMIZE TABLE` |
| Purge old data | Monthly | Partition switch or batched delete | `DROP PARTITION` |
| Review slow queries | Weekly | Query Store / DMVs | Slow query log / sys schema |
| Review permissions | Quarterly, and whenever someone leaves | Catalog views | `SHOW GRANTS` |
| **Test a restore** | Monthly | Restore to a test server | Restore to a test server |

```sql
-- 🟥 MSSQL: the corruption check you must not skip
DBCC CHECKDB('ShopDB') WITH NO_INFOMSGS, ALL_ERRORMSGS;
```

> [!WARNING]
> ⚠️ **`DBCC CHECKDB` is the single most important maintenance task in SQL Server.** Storage corruption is silent — it sits in a rarely-read page for months, then surfaces during a restore, at which point every backup you hold may already contain it. **Run it weekly, and alert on any error.**

## 57.4 ⏰ Scheduling jobs

```sql
-- 🟥 MSSQL: SQL Server Agent
EXEC msdb.dbo.sp_add_job @job_name = N'ShopDB Nightly Maintenance';

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'ShopDB Nightly Maintenance',
    @step_name = N'Update Statistics',
    @subsystem = N'TSQL',
    @database_name = N'ShopDB',
    @command = N'EXEC sp_updatestats;';

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'Nightly 2am',
    @freq_type = 4, @freq_interval = 1,
    @active_start_time = 20000;

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'ShopDB Nightly Maintenance', @schedule_name = N'Nightly 2am';

EXEC msdb.dbo.sp_add_jobserver @job_name = N'ShopDB Nightly Maintenance';
```

```sql
-- 🟦 MySQL: the Event Scheduler
SET GLOBAL event_scheduler = ON;

CREATE EVENT ev_nightly_analyze
ON SCHEDULE EVERY 1 DAY STARTS '2026-09-10 02:00:00'
DO
    ANALYZE TABLE ShopDB.orders, ShopDB.order_items, ShopDB.products;

CREATE EVENT ev_purge_old_logs
ON SCHEDULE EVERY 1 DAY STARTS '2026-09-10 03:00:00'
DO
    DELETE FROM ShopDB.audit_log WHERE logged_at < UTC_TIMESTAMP() - INTERVAL 90 DAY LIMIT 50000;   -- audit_log: see 65.5

SHOW EVENTS FROM ShopDB;
```

> [!TIP]
> 💡 **On Linux, many teams prefer `cron` (Linux's built-in task scheduler) over the MySQL Event Scheduler** — it is easier to monitor, log, and alert on, and it survives a database restart cleanly.

## 57.5 🗂️ The system catalogs — knowing your own database

The **system catalog** is a set of built-in views that describe the database itself — its tables, columns, indexes, and keys. You query it with ordinary `SELECT` statements.

```sql
-- ✅ INFORMATION_SCHEMA works in BOTH (ANSI standard)
SELECT table_name, table_type FROM information_schema.tables WHERE table_schema = 'ShopDB';

SELECT table_name, column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'ShopDB' AND table_name = 'orders'
ORDER BY ordinal_position;

SELECT table_name, constraint_name, constraint_type
FROM information_schema.table_constraints WHERE table_schema = 'ShopDB';
```

**Finding every foreign key relationship** — this one is *not* portable, because MySQL adds non-standard columns to `key_column_usage` that SQL Server does not have:

```sql
-- ✅ MySQL only: referenced_* columns are a MySQL extension
SELECT
    kcu.table_name             AS child_table,
    kcu.column_name            AS child_column,
    kcu.referenced_table_name  AS parent_table,
    kcu.referenced_column_name AS parent_column
FROM information_schema.key_column_usage kcu
WHERE kcu.table_schema = 'ShopDB' AND kcu.referenced_table_name IS NOT NULL;
```

```sql
-- ✅ MSSQL: use the sys.* catalog views instead
SELECT
    OBJECT_NAME(fk.parent_object_id)                             AS child_table,
    COL_NAME(fkc.parent_object_id,     fkc.parent_column_id)     AS child_column,
    OBJECT_NAME(fk.referenced_object_id)                         AS parent_table,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS parent_column,
    fk.name                                                      AS constraint_name
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
ORDER BY child_table, child_column;
```

**Result on ShopDB (8 foreign keys):**

| child_table | child_column | parent_table | parent_column |
|---|---|---|---|
| employees | manager_id | employees | employee_id |
| order_items | order_id | orders | order_id |
| order_items | product_id | products | product_id |
| orders | customer_id | customers | customer_id |
| orders | employee_id | employees | employee_id |
| payments | order_id | orders | order_id |
| products | category_id | categories | category_id |
| products | supplier_id | suppliers | supplier_id |

> [!CAUTION]
> 🐛 **Common mistake:** assuming `INFORMATION_SCHEMA` is fully portable because it is "the ANSI standard". The *core* columns are, but every vendor extends it. `referenced_table_name` exists only in MySQL — in SQL Server the same query fails with *"Invalid column name 'referenced_table_name'"*. For foreign keys specifically, use `INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS` for portable code, or the native catalog views for anything detailed.

```sql
-- 🟥 MSSQL: the richer sys.* catalog views
SELECT * FROM sys.tables;
SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('orders');
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('orders');
SELECT * FROM sys.foreign_keys;

-- Find a column anywhere in the database
SELECT OBJECT_NAME(object_id) AS table_name, name AS column_name
FROM sys.columns WHERE name LIKE '%email%';
```

```sql
-- 🟦 MySQL: SHOW commands
SHOW TABLES;
SHOW CREATE TABLE orders;
SHOW COLUMNS FROM orders;
SHOW INDEX FROM orders;
SHOW TABLE STATUS FROM ShopDB;
SHOW VARIABLES LIKE 'innodb%';
```

> [!TIP]
> 💡 **Learn to query the catalog.** "Which tables have a column called `customer_id`?", "Which tables have no primary key?", "Which foreign keys have no index?" — all answerable in one query, and all far faster than clicking through a graphical tool.

```sql
-- ✅ Genuinely useful: find tables with no primary key
-- 🟦 MySQL
SELECT t.table_name
FROM information_schema.tables t
LEFT JOIN information_schema.table_constraints tc
       ON tc.table_schema = t.table_schema
      AND tc.table_name = t.table_name
      AND tc.constraint_type = 'PRIMARY KEY'
WHERE t.table_schema = 'ShopDB'
  AND t.table_type = 'BASE TABLE'
  AND tc.constraint_name IS NULL;
```

## 57.6 🧪 Try it yourself

1. Find the top 5 wait types on your server and look up what each one means.
2. List every table in ShopDB with its size, largest first.
3. Find any table without a primary key.
4. Find every foreign key column that has no index (a genuine performance audit).
5. Schedule a nightly statistics update job in your engine.

---
# 🚀 PART 13 — MODERN AND EXPERT TOPICS

---

# 58. JSON, XML, and semi-structured data

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡 Intermediate | 30 min | Store flexible details as JSON · Read, filter, and change JSON values · Index JSON for speed · Decide when JSON is the wrong choice |

> [!NOTE]
> 📌 **In plain words:** Sometimes data does not fit neat columns — a laptop has a CPU and RAM, a phone has a camera and colours, and a form has custom fields someone added last week. Both engines can store this flexible data as **JSON** (a simple text format) and still search it.

> 🌍 **Analogy:** A normal table is a printed form with fixed boxes. JSON is a blank notes page stapled to that form: you can write whatever details a particular item needs.

## 58.1 🟦 MySQL JSON — a native type

```sql
CREATE TABLE product_attributes (
    product_id  INT PRIMARY KEY,
    attributes  JSON NOT NULL,
    CONSTRAINT fk_pa_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

INSERT INTO product_attributes (product_id, attributes) VALUES
(1, '{"cpu":"Intel i7","ram_gb":16,"storage_gb":512,"screen":14.0,
      "ports":["USB-C","HDMI","USB-A"],"warranty":{"years":2,"onsite":true}}'),
(5, '{"os":"Android 15","ram_gb":8,"storage_gb":256,"camera_mp":50,
      "colors":["Black","Blue"],"warranty":{"years":1,"onsite":false}}');
```

```sql
-- Reading values
SELECT
    product_id,
    attributes->>'$.cpu'                     AS cpu,          -- ->> returns plain text
    attributes->'$.ram_gb'                   AS ram_quoted,   -- ->  keeps JSON quoting
    JSON_EXTRACT(attributes, '$.storage_gb') AS storage,
    attributes->>'$.warranty.years'          AS warranty_years,
    attributes->>'$.ports[0]'                AS first_port,
    JSON_LENGTH(attributes->'$.ports')       AS port_count
FROM product_attributes;

-- Filtering
SELECT product_id FROM product_attributes
WHERE CAST(attributes->>'$.ram_gb' AS UNSIGNED) >= 16;

SELECT product_id FROM product_attributes
WHERE JSON_CONTAINS(attributes->'$.ports', '"HDMI"');

SELECT product_id FROM product_attributes
WHERE JSON_UNQUOTE(attributes->'$.warranty.onsite') = 'true';
```

```sql
-- ✅ MySQL: modifying JSON in place
UPDATE product_attributes
SET attributes = JSON_SET(attributes, '$.ram_gb', 32)
WHERE product_id = 1;

UPDATE product_attributes
SET attributes = JSON_INSERT(attributes, '$.color', 'Silver')   -- only if absent
WHERE product_id = 1;

UPDATE product_attributes
SET attributes = JSON_REMOVE(attributes, '$.warranty.onsite')
WHERE product_id = 1;

UPDATE product_attributes
SET attributes = JSON_ARRAY_APPEND(attributes, '$.ports', 'Ethernet')
WHERE product_id = 1;
```

```sql
-- ⭐ JSON_TABLE: turn a JSON array into rows (MySQL 8.0+) — extremely useful
SELECT pa.product_id, p.port
FROM product_attributes pa,
     JSON_TABLE(pa.attributes, '$.ports[*]' COLUMNS (port VARCHAR(30) PATH '$')) AS p;
```

**Indexing JSON in MySQL:**

```sql
-- ✅ Extract to a generated column and index THAT
ALTER TABLE product_attributes
    ADD COLUMN ram_gb INT AS (CAST(attributes->>'$.ram_gb' AS UNSIGNED)) STORED,
    ADD INDEX ix_pa_ram (ram_gb);

-- Now this search uses the index instead of reading every row:
SELECT * FROM product_attributes WHERE ram_gb >= 16;

-- Multi-valued index: one index entry per array element (MySQL 8.0.17+)
ALTER TABLE product_attributes
    ADD INDEX ix_pa_ports ((CAST(attributes->'$.ports' AS CHAR(30) ARRAY)));
```

## 58.2 🟥 MSSQL JSON — functions over NVARCHAR

```sql
CREATE TABLE product_attributes (
    product_id INT PRIMARY KEY,
    attributes NVARCHAR(MAX) NOT NULL,
    CONSTRAINT ck_pa_json CHECK (ISJSON(attributes) = 1),      -- 🔑 validity guard
    CONSTRAINT fk_pa_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO product_attributes (product_id, attributes) VALUES
(1, N'{"cpu":"Intel i7","ram_gb":16,"storage_gb":512,"screen":14.0,
      "ports":["USB-C","HDMI","USB-A"],"warranty":{"years":2,"onsite":true}}'),
(5, N'{"os":"Android 15","ram_gb":8,"storage_gb":256,"camera_mp":50,
      "colors":["Black","Blue"],"warranty":{"years":1,"onsite":false}}');
```

```sql
-- Reading values
SELECT
    product_id,
    JSON_VALUE(attributes, '$.cpu')            AS cpu,          -- scalar
    JSON_VALUE(attributes, '$.ram_gb')         AS ram_gb,
    JSON_VALUE(attributes, '$.warranty.years') AS warranty_years,
    JSON_QUERY(attributes, '$.ports')          AS ports_array   -- object or array
FROM product_attributes;

-- Filtering
SELECT product_id FROM product_attributes
WHERE CAST(JSON_VALUE(attributes, '$.ram_gb') AS INT) >= 16;

-- ⭐ OPENJSON: turn JSON into rows and columns
SELECT pa.product_id, p.value AS port
FROM product_attributes pa
CROSS APPLY OPENJSON(pa.attributes, '$.ports') AS p;

SELECT *
FROM OPENJSON(
    (SELECT attributes FROM product_attributes WHERE product_id = 1))
WITH (
    cpu             NVARCHAR(50) '$.cpu',
    ram_gb          INT          '$.ram_gb',
    warranty_years  INT          '$.warranty.years',
    ports           NVARCHAR(MAX) '$.ports' AS JSON
);
```

```sql
-- Modifying
UPDATE product_attributes
SET attributes = JSON_MODIFY(attributes, '$.ram_gb', 32)
WHERE product_id = 1;

UPDATE product_attributes
SET attributes = JSON_MODIFY(attributes, 'append $.ports', 'Ethernet')
WHERE product_id = 1;
```

**Indexing JSON in MSSQL:**

```sql
-- ✅ Same idea: a persisted computed column, then an index
ALTER TABLE product_attributes
    ADD ram_gb AS CAST(JSON_VALUE(attributes, '$.ram_gb') AS INT) PERSISTED;
CREATE INDEX ix_pa_ram ON product_attributes(ram_gb);
```

## 58.3 📤 Producing JSON from query results

```sql
-- 🟥 MSSQL: FOR JSON — build the JSON an app or website expects, directly in SQL
SELECT
    o.order_id,
    o.order_date,
    c.full_name AS [customer.name],
    c.country   AS [customer.country],
    (SELECT p.product_name AS name, oi.quantity AS qty, oi.unit_price AS price
     FROM order_items oi
     JOIN products p ON p.product_id = oi.product_id
     WHERE oi.order_id = o.order_id
     FOR JSON PATH) AS items
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_id = 1002
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
```

```sql
-- 🟦 MySQL: JSON_OBJECT / JSON_ARRAYAGG
SELECT JSON_OBJECT(
    'order_id',  o.order_id,
    'order_date', o.order_date,
    'customer',  JSON_OBJECT('name', c.full_name, 'country', c.country),
    'items', (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT('name', p.product_name, 'qty', oi.quantity, 'price', oi.unit_price))
        FROM order_items oi
        JOIN products p ON p.product_id = oi.product_id
        WHERE oi.order_id = o.order_id
    )
) AS order_json
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_id = 1002;
```

## 58.4 ⚖️ When to use JSON — and when not to

| ✅ Good use of JSON | ❌ Bad use of JSON |
|---|---|
| Genuinely variable attributes per row (product specs across categories) | Data every row has (`email`, `order_date`) |
| Storing an API request/response payload for audit | Anything you filter or join on constantly |
| User preferences, feature flags, form definitions | Relationships between entities |
| Sparse optional fields (500 possible, 5 used per row) | Anything requiring a foreign key |
| Rapid prototyping before the schema settles | Financial or transactional values |

> [!WARNING]
> ⚠️ **The three real costs of JSON columns:**
> 1. **No constraints.** The database cannot enforce that `ram_gb` is a positive integer, or that `cpu` exists at all. Every JSON column is a place your data-quality rules cannot reach.
> 2. **No foreign keys.** A product ID inside JSON can point at nothing.
> 3. **Slower filtering.** Every filter must read through the JSON text unless you add a generated column and index — at which point you have re-invented a column, badly.

> [!TIP]
> 💡 **The practical rule: use real columns for what you query, and JSON for the many rarely used details.** Put `price`, `stock`, and `category_id` in columns; put the 40 category-specific spec fields in JSON. That is how mature systems actually do it.

## 58.5 📄 XML (MSSQL)

```sql
-- 🟥 MSSQL has a full built-in XML type, queried with XQuery (the query language for XML)
CREATE TABLE order_xml (
    order_id INT PRIMARY KEY,
    payload  XML NOT NULL
);

INSERT INTO order_xml VALUES (1002,
'<order id="1002">
    <customer>Mei Chen</customer>
    <items>
        <item sku="3" qty="1" price="2450.00"/>
        <item sku="15" qty="2" price="749.00"/>
    </items>
</order>');

SELECT
    payload.value('(/order/customer)[1]', 'VARCHAR(100)') AS customer,
    payload.value('count(/order/items/item)', 'INT')      AS item_count
FROM order_xml;

-- Shred into rows
SELECT
    x.item.value('@sku', 'INT')            AS sku,
    x.item.value('@qty', 'INT')            AS qty,
    x.item.value('@price', 'DECIMAL(10,2)') AS price
FROM order_xml
CROSS APPLY payload.nodes('/order/items/item') AS x(item);

-- Produce XML
SELECT order_id, order_date, status FROM orders WHERE order_id = 1002
FOR XML PATH('order'), ROOT('orders');
```

> 🔀 **MySQL has only basic XML support** (`ExtractValue`, `UpdateXML`) and no XML data type. If you work with XML, MSSQL is dramatically better equipped. For new work, **prefer JSON** — it is simpler, better supported on both sides, and universally understood by APIs.

## 58.6 🧪 Try it yourself

1. Create `product_attributes` in your engine and add JSON specs for 5 products.
2. Query all products with 16 GB or more RAM.
3. Shred the `ports` array into one row per port.
4. Add an indexed generated/computed column for `ram_gb` and confirm the plan improves.
5. Produce a nested JSON document for one full order, items included.

---

# 59. Dynamic SQL, cursors, and set-based thinking

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 30 min | Replace slow row-by-row loops with one statement · Know the rare times a cursor is right · Build dynamic SQL safely |

> [!NOTE]
> 📌 **In plain words:** This chapter is about *how you think* when you write SQL. Handle a whole group of rows in one statement (**set-based**) instead of one row at a time (**cursors**), and learn to build SQL safely when the exact query is only known while the program runs (**dynamic SQL**).

> 🌍 **Analogy:** Painting a fence. Row-by-row is painting each plank with a separate trip to the paint shop for every plank. Set-based is taking a wide roller and covering the whole fence in one pass.

## 59.1 🔄 Set-based thinking — the mindset that separates levels

> [!NOTE]
> 📌 **In plain words:** SQL is a language for describing **sets of rows**. Programmers arriving from Java, C#, or Python instinctively write loops. In SQL, the loop is almost always the wrong answer.

```sql
-- ❌ 🟥 MSSQL — ROW-BY-ROW (procedural thinking): ~20 seconds on 100,000 rows
DECLARE @id INT, @price DECIMAL(10,2);
DECLARE c CURSOR FOR SELECT product_id, unit_price FROM products;
OPEN c;
FETCH NEXT FROM c INTO @id, @price;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE products SET unit_price = @price * 1.10 WHERE product_id = @id;
    FETCH NEXT FROM c INTO @id, @price;
END;
CLOSE c; DEALLOCATE c;
```

```sql
-- ✅ SET-BASED: ~0.2 seconds on the same data. One statement.
UPDATE products SET unit_price = unit_price * 1.10;
```

> [!TIP]
> 💡 **Cursors are often called "Row By Agonizing Row" (RBAR) for a reason.** Every iteration is a separate statement with its own overhead. A 100x difference is typical, and it grows with the row count.

**How to convert loop thinking into set thinking:**

| Procedural idea | Set-based equivalent |
|---|---|
| "For each row, update it" | One `UPDATE` with a `WHERE` |
| "For each row, look something up" | A `JOIN` |
| "If X then A else B" | `CASE` |
| "Accumulate a running total" | `SUM() OVER (ORDER BY ...)` |
| "Compare a row to the previous one" | `LAG()` / `LEAD()` |
| "Find the best row per group" | `ROW_NUMBER()` or `APPLY` |
| "Build a list of things" | `STRING_AGG` / `GROUP_CONCAT` |
| "Insert if missing, else update" | `MERGE` / `ON DUPLICATE KEY UPDATE` |
| "Loop until done" | A recursive CTE |

## 59.2 🔁 Cursors — and the rare times they are right

```sql
-- 🟥 MSSQL cursor syntax
-- (a stand-in for a real "send an email" procedure, so the loop has something to call)
CREATE OR ALTER PROCEDURE usp_send_reminder @order_id INT, @name NVARCHAR(100)
AS
    PRINT CONCAT('Reminder queued for order ', @order_id, ' (', @name, ')');
GO

DECLARE @order_id INT, @customer_name NVARCHAR(100);

DECLARE order_cursor CURSOR
    LOCAL FAST_FORWARD                    -- 💡 fastest options: forward-only, read-only
FOR
    SELECT o.order_id, c.full_name
    FROM orders o JOIN customers c ON c.customer_id = o.customer_id
    WHERE o.status = 'Pending';

OPEN order_cursor;
FETCH NEXT FROM order_cursor INTO @order_id, @customer_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Genuine per-row work, e.g. calling a procedure that sends an email
    EXEC usp_send_reminder @order_id = @order_id, @name = @customer_name;

    FETCH NEXT FROM order_cursor INTO @order_id, @customer_name;
END;

CLOSE order_cursor;
DEALLOCATE order_cursor;
```

```sql
-- 🟦 MySQL cursor syntax (only inside a stored routine)
DELIMITER $$
-- A stand-in for a real "send an email" procedure, so the loop has something to call
CREATE PROCEDURE usp_send_reminder(IN p_order_id INT, IN p_name VARCHAR(100))
BEGIN
    SELECT CONCAT('Reminder queued for order ', p_order_id, ' (', p_name, ')') AS reminder;
END$$

CREATE PROCEDURE usp_process_pending()
BEGIN
    DECLARE v_done      INT DEFAULT 0;
    DECLARE v_order_id  INT;
    DECLARE v_name      VARCHAR(100);

    DECLARE cur CURSOR FOR
        SELECT o.order_id, c.full_name
        FROM orders o JOIN customers c ON c.customer_id = o.customer_id
        WHERE o.status = 'Pending';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;   -- the loop terminator

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_order_id, v_name;
        IF v_done = 1 THEN LEAVE read_loop; END IF;

        CALL usp_send_reminder(v_order_id, v_name);
    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;

CALL usp_process_pending();
```

> [!IMPORTANT]
> 🎯 **The legitimate uses of a cursor:**
> - Calling an external procedure or API **once per row** (sending emails, queueing jobs)
> - Administrative scripts iterating over databases, tables, or indexes
> - Complex sequential logic where each row genuinely depends on the outcome of the previous one
> - Deliberately processing in small batches to avoid long locks
>
> **Everything else should be set-based.** If you are writing a cursor to transform data, stop and find the `UPDATE ... JOIN`, the window function, or the `MERGE`.

> [!TIP]
> 💡 **A `WHILE` loop over batches is not the same as a cursor, and it is often correct.** Deleting 50 million rows in 5000-row batches is a loop, but each iteration is a set-based statement. That is good practice, not RBAR.

## 59.3 ⚙️ Dynamic SQL

> [!NOTE]
> 📌 **In plain words:** SQL that builds SQL as a string and then executes it. Necessary when the *structure* — table names, column names, the set of filters — is not known until runtime.

```sql
-- 🟥 MSSQL: sp_executesql is the safe way (it passes values as parameters AND reuses plans)
DECLARE @sql NVARCHAR(MAX);
DECLARE @country NVARCHAR(60) = 'Singapore';

SET @sql = N'SELECT customer_id, full_name, city FROM customers WHERE country = @p_country;';

EXEC sp_executesql @sql, N'@p_country NVARCHAR(60)', @p_country = @country;
```

```sql
-- 🟥 MSSQL: a real optional-filter search procedure
CREATE OR ALTER PROCEDURE usp_search_orders
    @customer_id INT          = NULL,
    @status      VARCHAR(20)  = NULL,
    @from_date   DATE         = NULL,
    @to_date     DATE         = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'
        SELECT order_id, customer_id, order_date, status
        FROM orders
        WHERE 1 = 1';

    IF @customer_id IS NOT NULL SET @sql += N' AND customer_id = @p_customer_id';
    IF @status      IS NOT NULL SET @sql += N' AND status      = @p_status';
    IF @from_date   IS NOT NULL SET @sql += N' AND order_date >= @p_from_date';
    IF @to_date     IS NOT NULL SET @sql += N' AND order_date <  @p_to_date';

    SET @sql += N' ORDER BY order_date DESC;';

    EXEC sp_executesql @sql,
        N'@p_customer_id INT, @p_status VARCHAR(20), @p_from_date DATE, @p_to_date DATE',
        @p_customer_id = @customer_id, @p_status = @status,
        @p_from_date = @from_date, @p_to_date = @to_date;
END;
GO
```

> [!TIP]
> 💡 **Why build the string instead of writing `(@status IS NULL OR status = @status)`?** Because the "catch-all" form produces **one plan for all parameter combinations**, which is usually terrible for most of them. Dynamic SQL generates a tight plan per combination, each cached separately. The alternative is `OPTION (RECOMPILE)` on the static version — simpler, but it re-plans every execution.

```sql
-- 🟦 MySQL: PREPARE / EXECUTE / DEALLOCATE
SET @sql = 'SELECT customer_id, full_name FROM customers WHERE country = ?';
SET @country = 'Singapore';

PREPARE stmt FROM @sql;
EXECUTE stmt USING @country;
DEALLOCATE PREPARE stmt;
```

**A genuinely useful admin script:**

```sql
-- 🟥 MSSQL: generate and run an index rebuild for every fragmented index
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += N'ALTER INDEX ' + QUOTENAME(i.name)
             + N' ON ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + N'.' + QUOTENAME(t.name)
             + N' REBUILD;' + CHAR(13)
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON i.object_id = ips.object_id AND i.index_id = ips.index_id
JOIN sys.tables  t ON t.object_id = i.object_id
WHERE ips.avg_fragmentation_in_percent > 30 AND ips.page_count > 1000 AND i.name IS NOT NULL;

PRINT @sql;         -- ✅ ALWAYS look at it before you run it
-- EXEC sp_executesql @sql;
```

> [!WARNING]
> ⚠️ **Every dynamic SQL statement is a potential injection point.** Re-read [Chapter 55](#55-sql-injection-and-how-to-stop-it): **parameterize values, `QUOTENAME`/allow-list names, never glue raw user input into SQL.**

> [!TIP]
> 💡 **And always `PRINT` before you `EXEC`.** Dynamic SQL that generates 400 `ALTER` statements deserves a human read-through before it touches anything.

## 59.4 🧪 Try it yourself

1. Write a cursor that raises every price by 10%, then replace it with one `UPDATE`. Time both.
2. Convert this to set-based: "for each customer, count their orders and write it to a column."
3. Write a safe dynamic search procedure with three optional filters.
4. Write a dynamic script that generates `SELECT COUNT(*)` for every table in ShopDB, and print it.
5. Name two situations where a cursor is genuinely the right tool.


---

# 60. Collation, character sets, and Unicode

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 35 min | Store any language without losing characters · Read a collation name · Fix the "collation conflict" error · Choose the right collation before the first row |

> [!NOTE]
> 📌 **In plain words:** A **character set** decides *which characters can be stored*. A **collation** decides *how they sort and compare* — whether `'amara' = 'AMARA'`, whether `'café' = 'cafe'`, and whether `'Zoe'` sorts before or after `'ábaco'`.

> 🌍 **Analogy:** A character set is the **alphabet** your language uses. A collation is the **dictionary rulebook** that says how to alphabetise it. Two people can share an alphabet and still disagree on the order — Swedish files `Ö` at the very end, German files it under `O`. The database has to be told which rulebook to follow.

> [!WARNING]
> This is the chapter people skip, and then spend a week debugging. Collation causes three classic production failures: **data silently destroyed** on insert, **joins that refuse to run**, and **indexes that stop being used**. All three appear below.

## 60.1 🔤 Character sets: what can actually be stored

| Engine | Non-Unicode type | Unicode type | Recommended today |
|---|---|---|---|
| 🟥 MSSQL | `VARCHAR` / `CHAR` — 1 byte per character, limited to one *code page* (a small character set for one group of languages) | `NVARCHAR` / `NCHAR` — UTF-16, 2–4 bytes | `NVARCHAR`, **or** `VARCHAR` with a `_UTF8` collation (2019+) |
| 🟦 MySQL | `latin1` charset | `utf8mb4` charset | **`utf8mb4`, always** |

Here is what actually happens when you store Japanese text in each strategy:

```sql
-- 🟥 MSSQL: three columns, three character-handling strategies
CREATE TABLE dbo.collation_demo (
    legacy    VARCHAR(50)  COLLATE SQL_Latin1_General_CP1_CI_AS      NOT NULL,  -- code page 1252
    utf8_col  VARCHAR(50)  COLLATE Latin1_General_100_CI_AS_SC_UTF8  NOT NULL,  -- UTF-8 (2019+)
    unicode   NVARCHAR(50)                                           NOT NULL   -- UTF-16
);

-- NCHAR(26085) + NCHAR(26412) is 日本 ("Japan")
DECLARE @jp NVARCHAR(10) = NCHAR(26085) + NCHAR(26412);
INSERT INTO dbo.collation_demo (legacy, utf8_col, unicode) VALUES (@jp, @jp, @jp);

SELECT legacy, utf8_col, unicode,
       DATALENGTH(legacy)   AS bytes_legacy,
       DATALENGTH(utf8_col) AS bytes_utf8,
       DATALENGTH(unicode)  AS bytes_nvarchar,
       LEN(legacy)          AS chars_legacy,
       LEN(utf8_col)        AS chars_utf8,
       LEN(unicode)         AS chars_nvarchar
FROM dbo.collation_demo;
```

**Result:**

| legacy | utf8_col | unicode | bytes_legacy | bytes_utf8 | bytes_nvarchar | chars_legacy | chars_utf8 | chars_nvarchar |
|---|---|---|---|---|---|---|---|---|
| `??` | 日本 | 日本 | 2 | 6 | 4 | 2 | 2 | 2 |

> [!WARNING]
> ⚠️ **Look at the first column. The data is gone.** SQL Server did not raise an error, did not warn, and did not roll back. It replaced every character the code page could not represent with a literal `?` — and there is no way to recover it. This is the most damaging collation mistake there is, and it happens silently in production every day.

> [!TIP]
> 💡 **`DATALENGTH` vs `LEN`.** `LEN` counts **characters**; `DATALENGTH` counts **bytes**. They agree only for single-byte data. When you size a column or estimate storage, `DATALENGTH` is the one that matters. Notice the UTF-8 column needed **6 bytes** for the same two characters UTF-16 stored in **4** — UTF-8 is smaller for Latin text and *larger* for Chinese, Japanese, and Korean (CJK) text. Pick by what your users actually type.

> 🔀 **MySQL has exactly the same trap under a different name.** The old `utf8` charset in MySQL is **not real UTF-8** — it is a three-byte subset that cannot store emoji or some CJK characters. The real one is `utf8mb4`.

```sql
-- 🟦 MySQL: always utf8mb4, never utf8  (exactly how ShopDB was created in Chapter 4)
CREATE DATABASE IF NOT EXISTS ShopDB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

-- Check what you actually have
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = 'ShopDB';

-- Any column still on an older charset is a bug waiting to happen
SELECT TABLE_NAME, COLUMN_NAME, CHARACTER_SET_NAME, COLLATION_NAME
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'ShopDB'
  AND CHARACTER_SET_NAME IS NOT NULL
  AND CHARACTER_SET_NAME <> 'utf8mb4';
```

> [!TIP]
> **The rule, in one line:** 🟥 MSSQL — use `NVARCHAR`, or `VARCHAR` with a `_UTF8` collation. 🟦 MySQL — use `utf8mb4` for every database, table, column **and the client connection**. Getting the server right and the connection wrong produces exactly the same `?` corruption.

## 60.2 📖 Reading a collation name

Collation names look like noise until you realise they are just a list of flags. (In the MySQL name, `0900` means version 9.0 of the *Unicode Collation Algorithm* — UCA — the official sorting rules.)

```text
🟥 MSSQL     Latin1_General_100_CI_AS_SC_UTF8
             └──────┬──────┘ └┬┘ └┬┘└┬┘ └┬┘└─┬─┘
             language/culture  │   │  │   │  encoding
                        version┘   │  │   └── supplementary characters (emoji)
                         case ─────┘  └────── accent

🟦 MySQL     utf8mb4_0900_ai_ci
             └──┬──┘ └─┬┘ └┬┘└┬┘
             charset   │   │  └── case-insensitive
                  UCA version└──── accent-insensitive
```

| Flag | Means | Effect |
|---|---|---|
| `CI` / `_ci` | Case **I**nsensitive | `'amara' = 'AMARA'` |
| `CS` / `_cs` | Case **S**ensitive | `'amara' <> 'AMARA'` |
| `AS` / `_as` | Accent **S**ensitive | `'café' <> 'cafe'` |
| `AI` / `_ai` | Accent **I**nsensitive | `'café' = 'cafe'` |
| `SC` 🟥 | Supplementary characters | Emoji and rare CJK handled correctly by `LEN`, `SUBSTRING` |
| `BIN2` / `_bin` | Binary | Compares the raw character numbers. Fastest, and completely literal (`'a'` ≠ `'A'`) |

```sql
-- 🟥 MSSQL: watch the flags actually take effect
SELECT
    CASE WHEN 'Amara' = 'AMARA' THEN 'equal' ELSE 'different' END                        AS default_ci,
    CASE WHEN 'Amara' COLLATE Latin1_General_CS_AS = 'AMARA' COLLATE Latin1_General_CS_AS
         THEN 'equal' ELSE 'different' END                                               AS case_sensitive,
    CASE WHEN N'cafe' = N'caf' + NCHAR(233) THEN 'equal' ELSE 'different' END            AS accent_sensitive,
    CASE WHEN N'cafe' COLLATE Latin1_General_CI_AI = (N'caf' + NCHAR(233)) COLLATE Latin1_General_CI_AI
         THEN 'equal' ELSE 'different' END                                               AS accent_insensitive;
```

**Result:**

| default_ci | case_sensitive | accent_sensitive | accent_insensitive |
|---|---|---|---|
| equal | different | different | equal |

> [!TIP]
> 💡 **Accent-insensitive collations are how you build a forgiving search box.** A customer who types `jose` should find *José*. `Latin1_General_CI_AI` does that for you with no `REPLACE` gymnastics.

> [!WARNING]
> ⚠️ **Collations contain linguistic surprises.** Under `Latin1_General_CI_AS`, `N'straße' = N'strasse'` returns **equal** — German `ß` expands to `ss` under the Unicode rules. That is correct behaviour, and it will still astonish you the first time a "duplicate" appears that does not look like one.

## 60.3 🧭 Finding out what you actually have

```sql
-- 🟥 MSSQL: the four levels — server, database, column, expression
SELECT SERVERPROPERTY('Collation')              AS server_collation,
       DATABASEPROPERTYEX('ShopDB','Collation') AS database_collation;

SELECT c.name AS column_name, c.collation_name
FROM sys.columns c
WHERE c.object_id = OBJECT_ID('dbo.customers')
  AND c.collation_name IS NOT NULL;

-- Every collation this server knows about
SELECT name FROM sys.fn_helpcollations()
WHERE name LIKE 'Latin1_General_100_CI_AS%UTF8';
```

**Result (a default install):**

| server_collation | database_collation |
|---|---|
| SQL_Latin1_General_CP1_CI_AS | SQL_Latin1_General_CP1_CI_AS |

| column_name | collation_name |
|---|---|
| full_name | SQL_Latin1_General_CP1_CI_AS |
| email | SQL_Latin1_General_CP1_CI_AS |
| … | … |

> [!TIP]
> 💡 **Collation is inherited downward:** server → database → column → expression, and each level may override the one above. A column with no explicit `COLLATE` takes the database default; a database created with no `COLLATE` takes the server default, which was fixed at install time. This is why *"our test server sorts differently from production"* is such a common bug report — and why the collation belongs in your build script, not in the installer wizard's memory.

```sql
-- 🟦 MySQL: the same four levels
SELECT @@character_set_server,   @@collation_server;
SELECT @@character_set_database, @@collation_database;
SHOW FULL COLUMNS FROM customers;          -- the Collation column
SHOW COLLATION WHERE Charset = 'utf8mb4';
```

## 60.4 💥 The collation conflict error

This is the one that stops a migration dead, usually the moment you join a new table to a legacy one.

```sql
-- 🟥 MSSQL: a legacy table carrying a different collation
CREATE TABLE dbo.legacy_customers (
    legacy_id INT PRIMARY KEY,
    email     NVARCHAR(150) COLLATE Latin1_General_CS_AS NOT NULL
);
INSERT INTO dbo.legacy_customers VALUES (1, N'amara.silva@example.com');

-- ❌ This fails
SELECT c.customer_id
FROM customers c
JOIN dbo.legacy_customers l ON l.email = c.email;
```

```text
Msg 468, Level 16, State 9
Cannot resolve the collation conflict between "SQL_Latin1_General_CP1_CI_AS"
and "Latin1_General_CS_AS" in the equal to operation.
```

```sql
-- ✅ 🟥 MSSQL — fix 1 (quick): force one side into the other's collation
SELECT c.customer_id, l.legacy_id
FROM customers c
JOIN dbo.legacy_customers l
  ON l.email = c.email COLLATE Latin1_General_CS_AS;

-- ✅ Fix 2 (quick, and still works when deployed to another database): use the database default
SELECT c.customer_id, l.legacy_id
FROM customers c
JOIN dbo.legacy_customers l
  ON l.email = c.email COLLATE DATABASE_DEFAULT;

-- ✅ Fix 3 (the real fix): make the column match, permanently
ALTER TABLE dbo.legacy_customers
    ALTER COLUMN email NVARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL;
```

> 🔀 **MySQL raises the equivalent error** — `ERROR 1267: Illegal mix of collations` — and takes the same three fixes: a `COLLATE` on one side of the comparison, or `ALTER TABLE … CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci` to settle it for good.

> [!WARNING]
> ⚠️ **`ALTER COLUMN` with a new collation rewrites the column, and it fails outright if an index, constraint, or computed column depends on it.** Drop those first, alter, then recreate them. On a large table this is a maintenance-window operation, not a Tuesday-afternoon one.

## 60.5 🐌 The performance trap: `COLLATE` kills your index

This is the quiet one. The query works, returns the right answer, and is a hundred times slower than it should be.

```sql
-- 🟥 MSSQL: compare the two plans
SET SHOWPLAN_TEXT ON;
GO
SELECT customer_id FROM customers WHERE email = N'amara.silva@example.com';
GO
SELECT customer_id FROM customers
WHERE email COLLATE Latin1_General_CS_AS = N'amara.silva@example.com';
GO
SET SHOWPLAN_TEXT OFF;
GO
```

**The plans:**

```text
✅ Index Seek(OBJECT:(customers.UQ__customer__…), SEEK:(customers.email=[@1]) ORDERED FORWARD)

❌ Index Scan(OBJECT:(customers.UQ__customer__…),
     WHERE:(CONVERT(nvarchar(150),customers.email,0)=CONVERT_IMPLICIT(nvarchar(4000),[@1],0)))
```

> [!WARNING]
> 💥 **`COLLATE` on the column side is a function on the column.** The index is physically sorted in *its own* collation, so the moment you demand a different one the stored order is the wrong order and the index can no longer jump straight to the row. It is precisely the same failure as `WHERE UPPER(email) = …` from [Chapter 48](#48-query-optimization-and-sargability), and it has the same three cures:
>
> - Put the `COLLATE` on the **literal or parameter** side, never the column side, where you can.
> - Fix the column's collation permanently so no `COLLATE` is needed at all.
> - If you genuinely need both orderings, add a **persisted computed column** in the other collation and index that ([Chapter 41](#41-sequences-and-generated-columns)).

## 60.6 🎯 Choosing a collation — the decision table

| Situation | Choose |
|---|---|
| A brand-new application, any language | 🟥 `Latin1_General_100_CI_AS_SC_UTF8` (or `NVARCHAR` with `Latin1_General_100_CI_AS_SC`) · 🟦 `utf8mb4_0900_ai_ci` |
| Names, emails, search boxes — humans typing | Case-**insensitive** (`CI`). Users do not capitalise consistently |
| Passwords, hashes, tokens, API keys, file paths | **Binary** (`_BIN2` / `_bin`). Never fold case on a secret |
| Codes: SKU, ISO country, currency | Case-insensitive is fine, but have the application save them in one consistent case |
| Forgiving customer search (`jose` finds *José*) | Accent-**insensitive** (`AI`) on that column, or an indexed computed column |
| A specific locale must sort correctly (Swedish, Turkish, Vietnamese) | The matching language collation — `Finnish_Swedish_CI_AS`, `Turkish_CI_AS`, `Vietnamese_CI_AS` |
| Joining to a system you do not control | Match **their** collation, or normalise once at the boundary |

> [!WARNING]
> ⚠️ **The Turkish-I problem.** In Turkish, the uppercase of `i` is `İ`, not `I`. Under `Turkish_CI_AS`, `'ID' = 'id'` is **false**. If your schema does case-insensitive lookups on machine identifiers and someone deploys into a Turkish locale, things break in ways that look like magic. This is exactly why binary collations are the correct choice for machine identifiers.

> [!IMPORTANT]
> **Decide the collation before the first row goes in.** Changing it later means rebuilding every string column, every index that touches one, and re-testing every comparison in the application. It is one of the few database decisions that is genuinely expensive to reverse.

## 60.7 🧪 Try it yourself

1. Insert a non-Latin string (use `NCHAR(26085) + NCHAR(26412)`) into a `VARCHAR` column with a `CP1` collation. Confirm you get `??` back, and that **no error was raised**.
2. Compare `DATALENGTH` and `LEN` for the same emoji stored under an `_SC` collation and a non-`_SC` one.
3. Reproduce `Msg 468`, then fix it all three ways.
4. Prove with `SET SHOWPLAN_TEXT ON` that `COLLATE` on an indexed column turns a seek into a scan.
5. 🟦 MySQL: create a table with the old `utf8` charset, insert an emoji, and read the error. Convert it to `utf8mb4` and try again.

---

# 61. Time zones and global data

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 35 min | Store time in UTC · Convert between time zones · Filter by a customer's local day without slowing the query · Survive daylight saving changes |

> [!NOTE]
> 📌 **In plain words:** A timestamp with no time zone attached is only half a fact. `2026-06-15 14:30` is meaningless until someone says *where*. This chapter is how you store the "where" without poisoning your data.

> 🌍 **Analogy:** A photograph with no location tag. You can see what happened, but you cannot place it. And unlike a photo, a mis-tagged timestamp is **unrecoverable** — once you have a table full of mixed local times, no query on earth can tell you which zone each row meant.

> [!IMPORTANT]
> **The single rule that makes all of this manageable: store UTC.** Convert to local time at the edge — at display time, in a report, in the application. Every rule below is a consequence of this one.

## 61.1 🧭 The four ways people store time, ranked

| Approach | Storage | Verdict |
|---|---|---|
| Local wall-clock time, zone not recorded | `DATETIME2` / `DATETIME` | ❌ **Broken.** Ambiguous twice a year, unsortable across regions, unfixable later |
| **UTC in a plain datetime column** | 🟥 `DATETIME2(0)` · 🟦 `DATETIME` | ✅ **The default choice.** Simple, compact, indexes well, sorts correctly worldwide |
| UTC **plus a zone name column** | `DATETIME2` + a text column for the zone name | ✅ Use when you must later reconstruct *the user's local reading* of the event |
| Offset-aware type | 🟥 `DATETIMEOFFSET` · 🟦 `TIMESTAMP` | ⚠️ Useful, with caveats — see 61.4 |

> [!WARNING]
> ⚠️ **An offset is not a time zone.** `+01:00` tells you the offset *at that instant*; it does not tell you that the user was in London, and it cannot tell you what the offset will be next July. If you need to answer *"what will 9 a.m. local look like for this user in six months?"*, you must store the **zone name** (`'GMT Standard Time'`), not the offset.

## 61.2 🕐 Getting the current time, correctly

```sql
-- 🟥 MSSQL
SELECT SYSDATETIME()        AS server_local,   -- the server's local clock — avoid
       SYSUTCDATETIME()     AS utc_now,        -- ✅ what you should be storing
       SYSDATETIMEOFFSET()  AS with_offset;    -- local + the server's current offset
```

**Result:**

| server_local | utc_now | with_offset |
|---|---|---|
| 2026-09-09 21:46:42.0836051 | 2026-09-09 19:46:42.0836051 | 2026-09-09 21:46:42.0836051 +02:00 |

```sql
-- 🟦 MySQL
SELECT NOW()        AS session_local,   -- honours @@session.time_zone
       UTC_TIMESTAMP() AS utc_now,      -- ✅ what you should be storing
       @@global.time_zone  AS global_tz,
       @@session.time_zone AS session_tz;
```

> [!WARNING]
> ⚠️ **`GETDATE()` and `NOW()` return the *server's* idea of local time.** That is a machine setting a server administrator can change, and it jumps twice a year for daylight saving time (DST). `SYSUTCDATETIME()` / `UTC_TIMESTAMP()` never move. Default every audit column to UTC:

```sql
-- 🟥 MSSQL
CREATE TABLE dbo.audit_utc_demo (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
);

-- 🟦 MySQL
CREATE TABLE audit_utc_demo (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
);
```

## 61.3 🔄 Converting between zones

🟥 **MSSQL uses `AT TIME ZONE`** (2016+). It takes the Windows zone names listed in `sys.time_zone_info` and it handles DST for you.

```sql
-- 🟥 MSSQL: one UTC instant, seen from four places
DECLARE @utc DATETIME2(0) = '2026-06-15 14:30:00';

SELECT
    @utc                                                                              AS stored_utc,
    @utc AT TIME ZONE 'UTC'                                                           AS tagged_utc,
    @utc AT TIME ZONE 'UTC' AT TIME ZONE 'India Standard Time'                        AS ist,
    @utc AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time'                          AS london,
    CAST(@utc AT TIME ZONE 'UTC' AT TIME ZONE 'Tokyo Standard Time' AS DATETIME2(0))  AS tokyo_local;
```

**Result:**

| stored_utc | tagged_utc | ist | london | tokyo_local |
|---|---|---|---|---|
| 2026-06-15 14:30:00 | 2026-06-15 14:30:00 +00:00 | 2026-06-15 20:00:00 +05:30 | 2026-06-15 15:30:00 **+01:00** | 2026-06-15 23:30:00 |

> [!TIP]
> 💡 **Read that as two steps, because it is two steps.** The first `AT TIME ZONE 'UTC'` **labels** a plain `DATETIME2` (one with no zone attached) as being UTC — it changes no digits, it only attaches an offset. The second `AT TIME ZONE` **converts** that offset-aware value into another zone. Skipping the first step is the number-one `AT TIME ZONE` bug: without it, SQL Server assumes the value is already in the *server's* local zone.

```sql
-- 🟥 The same instant six months earlier — DST is handled for you
DECLARE @winter DATETIME2(0) = '2026-01-15 14:30:00';
SELECT @winter AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS london_winter;
```

**Result:**

| london_winter |
|---|
| 2026-01-15 14:30:00 **+00:00** |

> [!IMPORTANT]
> 🎯 **That is the whole point.** London is `+01:00` in June and `+00:00` in January, and you did not have to know that. Hard-coding `DATEADD(HOUR, 1, …)` would have been wrong for half the year.

```sql
-- 🟥 What zones does this server know?
SELECT name, current_utc_offset, is_currently_dst
FROM sys.time_zone_info
ORDER BY name;
```

| name | current_utc_offset | is_currently_dst |
|---|---|---|
| Afghanistan Standard Time | +04:30 | 0 |
| Alaskan Standard Time | -08:00 | 1 |
| Arab Standard Time | +03:00 | 0 |
| … | … | … |

```sql
-- 🟥 Two more offset tools
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+05:30')                                AS shifted,
       TODATETIMEOFFSET(CAST('2026-06-15 14:30:00' AS DATETIME2(0)), '+05:30')    AS tagged;
```

| Function | What it does |
|---|---|
| `TODATETIMEOFFSET(dt, offset)` | **Labels** a plain datetime with an offset. Digits unchanged |
| `SWITCHOFFSET(dto, offset)` | **Converts** an offset-aware value to a different offset. Same instant, different digits |

> 🔀 **MySQL uses `CONVERT_TZ`.** It takes the standard IANA zone names used by Linux and most apps (`'Asia/Kolkata'`), and it returns `NULL` — silently — if the zone tables have not been loaded.

```sql
-- 🟦 MySQL
SELECT CONVERT_TZ('2026-06-15 14:30:00', 'UTC', 'Asia/Kolkata') AS ist,
       CONVERT_TZ('2026-06-15 14:30:00', 'UTC', 'Europe/London') AS london;

-- ⚠️ Returns NULL? The named zone tables are not loaded. Check first:
SELECT COUNT(*) AS zones_loaded FROM mysql.time_zone_name;
```

> [!WARNING]
> ⚠️ **The MySQL time-zone tables are not populated by default on many builds.** Load them once, as an administrator, or `CONVERT_TZ` will hand you `NULL` for every named zone while still working for numeric offsets like `'+05:30'`:
> ```bash
> # Linux/macOS, run once per server
> mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql
> ```
> On Windows, download the pre-built time-zone SQL bundle from the MySQL site and load it the same way.

## 61.4 📐 `DATETIMEOFFSET` and `TIMESTAMP` — the caveats

```sql
-- 🟥 MSSQL: DATETIMEOFFSET stores the instant AND the offset it was captured at
CREATE TABLE dbo.events_dto (
    event_id     INT IDENTITY(1,1) PRIMARY KEY,
    occurred_at  DATETIMEOFFSET(0) NOT NULL     -- 8 bytes vs 6 for DATETIME2(0)
);

-- Measure it rather than guessing
DECLARE @a DATETIME2(0)     = SYSUTCDATETIME(),
        @b DATETIMEOFFSET(0) = SYSDATETIMEOFFSET(),
        @c DATETIMEOFFSET(7) = SYSDATETIMEOFFSET();
SELECT DATALENGTH(@a) AS datetime2_0, DATALENGTH(@b) AS dto_0, DATALENGTH(@c) AS dto_7;
-- 6 | 8 | 10
```

| | Pro | Con |
|---|---|---|
| 🟥 `DATETIMEOFFSET` | Never ambiguous; the capture offset is preserved | 8–10 bytes vs 6; comparisons normalise to UTC anyway; still does not tell you the **zone** |
| 🟦 `TIMESTAMP` | Auto-converts to the session zone on read | **Cannot store dates after January 2038**; conversion depends on a session variable, so the same row reads differently for different connections |
| 🟦 `DATETIME` | Stores exactly what you gave it, forever | No conversion at all — *you* must guarantee it is UTC |

> [!WARNING]
> ⚠️ **🟦 MySQL `TIMESTAMP` is a trap in disguise.** It looks like the "correct" type because it converts automatically — but the conversion depends on `@@session.time_zone`, which differs per connection. A report run from a cron job on the server and the same report run from a developer's laptop can legitimately disagree. And the 2038 limit is real. **Use `DATETIME` holding UTC.**

## 61.5 🚀 The SARGability trap (the one that costs you a night)

Converting the **column** to local time in a `WHERE` clause is a function on a column — it stops the index being used, exactly as in [Chapter 48](#48-query-optimization-and-sargability).

The examples in this section and the next use a small events table: the UTC instant, plus the zone the user was in.

```sql
-- 🟥 MSSQL
CREATE TABLE dbo.events_utc (
    event_id     INT IDENTITY(1,1) PRIMARY KEY,
    event_name   NVARCHAR(60) NOT NULL,
    occurred_utc DATETIME2(0) NOT NULL,      -- always UTC
    tz_name      SYSNAME      NOT NULL       -- the zone the user was in
);

INSERT INTO dbo.events_utc (event_name, occurred_utc, tz_name) VALUES
 (N'Checkout', '2026-06-15 23:30:00', 'India Standard Time'),
 (N'Checkout', '2026-06-15 18:45:00', 'Tokyo Standard Time'),
 (N'Checkout', '2026-01-15 23:30:00', 'GMT Standard Time');
```

```sql
-- ❌ 🟥 MSSQL: converts every row in the table before it can filter
SELECT * FROM dbo.events_utc
WHERE CAST(occurred_utc AT TIME ZONE 'UTC' AT TIME ZONE 'India Standard Time' AS DATE) = '2026-06-16';
```

Convert the **boundaries** instead, once, and compare the raw column:

```sql
-- ✅ MSSQL: "one local day in Mumbai", as a SARGable UTC range
DECLARE @tz        SYSNAME = 'India Standard Time';
DECLARE @local_day DATE    = '2026-06-16';

DECLARE @from DATETIME2(0) =
    CAST(CAST(@local_day AS DATETIME2(0))                  AT TIME ZONE @tz AT TIME ZONE 'UTC' AS DATETIME2(0));
DECLARE @to   DATETIME2(0) =
    CAST(CAST(DATEADD(DAY, 1, @local_day) AS DATETIME2(0)) AT TIME ZONE @tz AT TIME ZONE 'UTC' AS DATETIME2(0));

SELECT @from AS utc_from, @to AS utc_to;

SELECT event_id, occurred_utc
FROM dbo.events_utc
WHERE occurred_utc >= @from
  AND occurred_utc <  @to;         -- half-open, as always
```

**Result:**

| utc_from | utc_to |
|---|---|
| 2026-06-15 18:30:00 | 2026-06-16 18:30:00 |

> [!TIP]
> 💡 **This is the half-open range pattern from [Chapter 14](#14-where-asking-precise-questions), plus a zone conversion on the endpoints.** Two conversions instead of ten million, and the index still seeks. Every "show me today's orders in the customer's local time" report should be written this way.

## 61.6 🌍 Storing the user's zone, and reporting in it

When the *user's local reading* of an event matters — invoices, opening hours, scheduled jobs, legal deadlines — store the zone name alongside the UTC instant.

```sql
-- 🟥 MSSQL: each event in the user's own zone (dbo.events_utc, created in 61.5)
SELECT event_id,
       occurred_utc,
       CAST(occurred_utc AT TIME ZONE 'UTC' AT TIME ZONE tz_name AS DATETIME2(0)) AS local_time,
       CAST(occurred_utc AT TIME ZONE 'UTC' AT TIME ZONE tz_name AS DATE)         AS local_date,
       tz_name
FROM dbo.events_utc
ORDER BY event_id;
```

**Result:**

| event_id | occurred_utc | local_time | local_date | tz_name |
|---|---|---|---|---|
| 1 | 2026-06-15 23:30:00 | 2026-06-16 05:00:00 | 2026-06-16 | India Standard Time |
| 2 | 2026-06-15 18:45:00 | 2026-06-16 03:45:00 | 2026-06-16 | Tokyo Standard Time |
| 3 | 2026-01-15 23:30:00 | 2026-01-15 23:30:00 | 2026-01-15 | GMT Standard Time |

> [!IMPORTANT]
> 🎯 **Notice rows 1 and 2.** Both happened on 15 June UTC, and both are "16 June" to the customer. A daily sales report grouped on `occurred_utc` would put them in the wrong bucket for every customer east of Greenwich. Grouping on `local_date` is what the business actually asked for.

> [!TIP]
> 💡 **`AT TIME ZONE` accepts a column, not just a literal** — that is what makes the per-user zone pattern possible in a single query. It is *not* free, though: it is a row-by-row conversion, so keep it in the `SELECT` list and out of the `WHERE` clause (61.5).

## 61.7 🕳️ Daylight saving: the two hours that do not behave

Twice a year, local clock time misbehaves.

| Problem | What happens | What to do |
|---|---|---|
| **The gap** (spring forward) | 02:30 local simply does not exist on that date | Never schedule at 02:00–03:00 local. `AT TIME ZONE` maps gap times forward |
| **The overlap** (autumn back) | 01:30 local happens **twice**, with two different offsets | Only UTC can distinguish them. This is why UTC storage is not negotiable |
| **Rules change** | Governments move DST dates, sometimes with weeks of notice | Keep the OS/zone tables patched. Never hard-code an offset |

> [!WARNING]
> ⚠️ **A stored offset does not survive a rule change; a stored zone name does.** If you save "this recurring meeting is at `+01:00`", and the country abolishes DST, every future occurrence is now wrong. If you save "`Europe/London`, 09:00 local", it stays correct — because the conversion is done fresh, from current rules, every time you read it.

> [!TIP]
> **Recurring events are the exception to "store UTC".** For something that repeats — a 09:00 daily standup, a monthly billing run — store the **local wall-clock time plus the zone name**, and compute the UTC instant at read time. Storing UTC for a recurring event bakes today's DST rules into every future occurrence.

## 61.8 🎯 The time-zone checklist

- ☐ Every timestamp column stores **UTC**, and the column name says so (`created_utc`, `occurred_utc`)
- ☐ Defaults use `SYSUTCDATETIME()` 🟥 / `UTC_TIMESTAMP()` 🟦, never `GETDATE()` / `NOW()`
- ☐ Application connections do not rely on the server's local zone for anything
- ☐ Where the user's local reading matters, the **zone name** is stored, not an offset
- ☐ Recurring schedules store local time + zone name, not a UTC instant
- ☐ Date-range filters convert the **boundaries**, never the column
- ☐ 🟦 MySQL: `mysql.time_zone_name` is populated, and it is checked after every server rebuild
- ☐ OS and database time-zone data are patched like any other dependency

## 61.9 🧪 Try it yourself

1. Take one UTC instant and render it in five zones with `AT TIME ZONE`. Repeat with a January date and explain every offset that changed.
2. Write a "yesterday, in the customer's local time" report over `orders`, with the filter fully SARGable.
3. Add a `tz_name` column to `customers`, populate it, and produce a daily order count grouped by each customer's **local** date.
4. Prove the DST overlap problem: find the UTC instants that both map to 01:30 local on the autumn changeover in `Europe/London`.
5. 🟦 MySQL: run `CONVERT_TZ` with a named zone. If it returns `NULL`, load the zone tables and try again.

---

# 62. Temporal tables, history, and change tracking

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 35 min | Keep every past version of a row automatically · Query a table as it looked at any moment · Find what changed since the last sync |

> [!NOTE]
> 📌 **In plain words:** A normal table only knows the **present**. These features let the database remember **every past version of every row**, and let you query the table as it looked at any moment — without writing a single trigger.

> 🌍 **Analogy:** Version history in a document editor. The document still shows today's text, but "restore an earlier version" is one click away, and nobody had to remember to save a copy.

> [!TIP]
> 💡 **You already met the manual version of this** in [Chapter 39](#39-triggers) (audit triggers) and [Chapter 53](#53-data-modeling-and-the-star-schema) (Slowly Changing Dimensions). This chapter is the engine doing it for you, correctly, at no maintenance cost.

## 62.1 🕰️ MSSQL temporal tables — history for free

```sql
-- 🟥 MSSQL 2016+: a system-versioned temporal table
CREATE TABLE dbo.product_prices (
    product_id   INT           NOT NULL PRIMARY KEY,
    unit_price   DECIMAL(10,2) NOT NULL,
    updated_by   NVARCHAR(60)  NOT NULL DEFAULT SYSTEM_USER,

    valid_from   DATETIME2(2) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    valid_to     DATETIME2(2) GENERATED ALWAYS AS ROW END   HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.product_prices_history));
```

That is the whole setup. Now change some data:

```sql
-- 🟥 MSSQL
INSERT INTO dbo.product_prices (product_id, unit_price) VALUES (1, 1899.00), (2, 1099.00);

UPDATE dbo.product_prices SET unit_price = 1749.00 WHERE product_id = 1;
GO
WAITFOR DELAY '00:00:01';          -- see the warning below on why this is here
UPDATE dbo.product_prices SET unit_price = 1699.00 WHERE product_id = 1;
GO
```

```sql
-- 🟥 Every version that has ever existed
SELECT product_id, unit_price, valid_from, valid_to
FROM dbo.product_prices FOR SYSTEM_TIME ALL
ORDER BY product_id, valid_from;
```

**Result:**

| product_id | unit_price | valid_from | valid_to |
|---|---|---|---|
| 1 | 1899.00 | 2026-09-09 19:46:57.49 | 2026-09-09 19:46:58.50 |
| 1 | 1749.00 | 2026-09-09 19:46:58.50 | 2026-09-09 19:46:59.52 |
| 1 | **1699.00** | 2026-09-09 19:46:59.52 | **9999-12-31 23:59:59.99** |
| 2 | 1099.00 | 2026-09-09 19:46:57.49 | 9999-12-31 23:59:59.99 |

> [!TIP]
> 💡 **`9999-12-31` means "still current".** Rows in the history table have a real `valid_to`; the live row's `valid_to` is the end of time. The periods are **half-open** — `valid_to` of one version is exactly `valid_from` of the next, so no instant is counted twice. Same discipline as date ranges in [Chapter 14](#14-where-asking-precise-questions).

> [!WARNING]
> ⚠️ **The period columns are in UTC**, always, regardless of the server's local zone. That is deliberate and correct — see [Chapter 61](#61-time-zones-and-global-data).

> [!TIP]
> 💡 **`HIDDEN` means "excluded from `SELECT *`"** — not "invisible". `SELECT * FROM dbo.product_prices` returns only your three business columns, so adding versioning to an existing table does not break application code that used `SELECT *`. Name them explicitly and they appear.

> [!WARNING]
> ⚠️ **Two updates can collapse into one version, and both reasons surprise people.**
>
> 1. **Precision.** The period columns above are `DATETIME2(2)` — a 10 ms tick. Two updates inside the same tick produce a zero-duration history row, which the engine discards. Run the three statements back to back with no delay and you get **no history at all**. `DATETIME2(7)` records all three. Choose the precision to match how fast the table actually changes.
> 2. **Transactions.** Every row version written inside one transaction gets the **transaction's** start time. Two updates in one explicit transaction therefore produce **one** history row, and the intermediate value never existed as far as the history is concerned:
>
> ```sql
> -- 🟥 MSSQL
> BEGIN TRANSACTION;
>     UPDATE dbo.product_prices SET unit_price = 1650.00 WHERE product_id = 1;   -- never recorded
>     UPDATE dbo.product_prices SET unit_price = 1600.00 WHERE product_id = 1;
> COMMIT;
> -- history gains exactly one row: the value as it was BEFORE the transaction
> ```
>
> That is the correct behaviour — history records **committed states**, not keystrokes — but it means temporal tables are not a substitute for an application log of every change someone attempted.

## 62.2 🔎 Querying the past

```sql
-- 🟥 What was the price at a specific moment?
DECLARE @t DATETIME2(2) = DATEADD(SECOND, -2, SYSUTCDATETIME());

SELECT product_id, unit_price
FROM dbo.product_prices FOR SYSTEM_TIME AS OF @t
ORDER BY product_id;
```

| Clause | Returns |
|---|---|
| `FOR SYSTEM_TIME AS OF @t` | The table exactly as it looked at instant `@t` — one row per key |
| `FOR SYSTEM_TIME FROM @a TO @b` | Versions active in the range; **excludes** ones that started exactly at `@b` |
| `FOR SYSTEM_TIME BETWEEN @a AND @b` | Same, but **includes** versions that started exactly at `@b` |
| `FOR SYSTEM_TIME CONTAINED IN (@a, @b)` | Only versions that both opened *and* closed inside the range |
| `FOR SYSTEM_TIME ALL` | Everything, current and historical |

```sql
-- 🟥 A range query
DECLARE @from DATETIME2(2) = DATEADD(MINUTE, -5, SYSUTCDATETIME());
DECLARE @to   DATETIME2(2) = SYSUTCDATETIME();

SELECT product_id, unit_price, valid_from, valid_to
FROM dbo.product_prices
FOR SYSTEM_TIME BETWEEN @from AND @to
ORDER BY product_id, valid_from;
```

> [!WARNING]
> ⚠️ **`FOR SYSTEM_TIME` will not accept a function call inline.** Writing `BETWEEN DATEADD(MINUTE,-5,SYSUTCDATETIME()) AND SYSUTCDATETIME()` fails with *"Incorrect syntax near 'DATEADD'"*. Assign to variables (or use literals) first, exactly as above. It catches everybody once.

> [!IMPORTANT]
> 🎯 **`AS OF` is how you answer questions nobody planned for:** *"What price did this customer actually see?"*, *"Reproduce the 3 a.m. report."*, *"Who changed this, and what was it before?"* — with a `WHERE` clause instead of a restore from backup.

## 62.3 🧭 Managing a temporal table

```sql
-- 🟥 Which tables are versioned?
SELECT t.name, t.temporal_type_desc, h.name AS history_table
FROM sys.tables t
LEFT JOIN sys.tables h ON h.object_id = t.history_table_id
WHERE t.temporal_type <> 0;
```

| name | temporal_type_desc | history_table |
|---|---|---|
| product_prices | SYSTEM_VERSIONED_TEMPORAL_TABLE | product_prices_history |

```sql
-- 🟥 Add versioning to an EXISTING table
ALTER TABLE dbo.suppliers
    ADD valid_from DATETIME2(2) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL
            CONSTRAINT df_suppliers_valid_from
            DEFAULT CONVERT(DATETIME2(2), '1900-01-01 00:00:00.00'),
        valid_to   DATETIME2(2) GENERATED ALWAYS AS ROW END   HIDDEN NOT NULL
            CONSTRAINT df_suppliers_valid_to
            DEFAULT CONVERT(DATETIME2(2), '9999-12-31 23:59:59.99'),
        PERIOD FOR SYSTEM_TIME (valid_from, valid_to);

ALTER TABLE dbo.suppliers
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.suppliers_history));

-- 🟥 Keep only two years of history (2017+)
ALTER TABLE dbo.suppliers
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.suppliers_history,
                                 HISTORY_RETENTION_PERIOD = 2 YEARS));
ALTER DATABASE ShopDB SET TEMPORAL_HISTORY_RETENTION ON;

-- Confirm it took
SELECT name, temporal_type_desc, history_retention_period, history_retention_period_unit_desc
FROM sys.tables WHERE name = 'suppliers';
-- suppliers | SYSTEM_VERSIONED_TEMPORAL_TABLE | 2 | YEAR

-- 🟥 Turning it off, and dropping cleanly
ALTER TABLE dbo.product_prices SET (SYSTEM_VERSIONING = OFF);   -- history becomes a normal table
DROP TABLE dbo.product_prices;
DROP TABLE dbo.product_prices_history;
```

> [!WARNING]
> ⚠️ **Use a constant in the past for `valid_from`, not `SYSUTCDATETIME()`.** Defaulting the start of period to "now" on a table that already has rows fails with *"Msg 13542 … there are open records with start of period set to a value in the future."* The existing rows have to be treated as having existed since before the versioning started, so `'1900-01-01'` (or any safely past constant) is the correct default.

> [!WARNING]
> ⚠️ **You cannot `DROP` a table while system versioning is on**, and `SYSTEM_VERSIONING = OFF` leaves the history table behind as an ordinary table. Any teardown script must do all three steps in order, which is why the demo scripts in this guide guard with `IF EXISTS (… temporal_type = 2) ALTER TABLE … SET (SYSTEM_VERSIONING = OFF)` before dropping.

| What temporal tables give you | What they do **not** give you |
|---|---|
| Every version of every row, automatically | **Who** changed it — add your own `updated_by` column with a `SYSTEM_USER` default |
| Correct behaviour under bulk loads and `MERGE` | **Why** it changed — add a reason column if the business needs one |
| Point-in-time reads with normal SQL | A record of who *read* data — only changes are recorded |
| History you can index (it is a real table) | Free storage — a frequently changed table can generate a lot of history |

> [!TIP]
> 💡 **Index the history table.** It is a normal table and it grows fastest of anything in your schema. A clustered index on `(key_column, valid_to)` is the usual starting point, and 🟥 MSSQL supports a **clustered columnstore index** on it — often a 10× space saving for history you rarely read row-by-row.

## 62.4 📡 Change Tracking — "what changed since I last looked?"

Temporal tables answer *"what did it look like then?"*. Change Tracking answers a different question: *"which rows do I need to sync?"* — the question every cache, search index, and ETL job actually asks.

```sql
-- 🟥 MSSQL: enable at database level, then per table
ALTER DATABASE ShopDB SET CHANGE_TRACKING = ON
    (CHANGE_RETENTION = 3 DAYS, AUTO_CLEANUP = ON);

ALTER TABLE dbo.products ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON);
GO

UPDATE dbo.products SET unit_price = unit_price + 0 WHERE product_id = 1;
GO

-- The version number your consumer stores between runs
SELECT CHANGE_TRACKING_CURRENT_VERSION() AS current_version;

-- Everything that changed since version 0
SELECT ct.product_id, ct.SYS_CHANGE_OPERATION, ct.SYS_CHANGE_VERSION
FROM CHANGETABLE(CHANGES dbo.products, 0) AS ct;
```

**Result:**

| current_version | | product_id | SYS_CHANGE_OPERATION | SYS_CHANGE_VERSION |
|---|---|---|---|---|
| 1 | | 1 | U | 1 |

> [!TIP]
> 💡 **The consumer pattern:** store the `CHANGE_TRACKING_CURRENT_VERSION()` you last processed, and on the next run pass it to `CHANGETABLE(CHANGES tbl, @last_version)`. You get only the keys that changed, plus `I` / `U` / `D` for insert, update, delete. Join back to the base table for the current values.

> [!WARNING]
> ⚠️ **`CHANGETABLE` is checked when the batch is compiled, before anything runs.** Enabling change tracking and querying `CHANGETABLE` in the *same batch* fails with *"Change tracking is not enabled on table…"*. Separate them with `GO` (or into two commands from the application).

> [!WARNING]
> ⚠️ **Retention is a hard deadline, not a suggestion.** If a consumer is offline longer than `CHANGE_RETENTION`, its stored version expires, `CHANGETABLE` returns an error, and the consumer must reload all the data from scratch (a **full reseed**). Set retention comfortably longer than your worst realistic outage.

## 62.5 ⚖️ Which history mechanism should you use?

| Need | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Full row history, point-in-time reads | **Temporal tables** | Trigger-written history table, or an SCD Type 2 design |
| "What changed since version N" for sync/ETL | **Change Tracking** (keys only, lightweight) | Tools that read the binary log (Debezium, Maxwell) |
| Full before/after values streamed to a pipeline | **Change Data Capture (CDC)** | **Binlog** with `binlog_format = ROW` |
| Who did what, for compliance | **SQL Server Audit** | Enterprise Audit plugin, or the general query log |
| A handful of columns on one table | A simple `updated_at` / `updated_by` pair | Same |

> [!WARNING]
> ⚠️ **Check your edition before designing around CDC.** Change Data Capture requires SQL Server Agent and is **not available on Express**. Change Tracking *is* available on every edition including Express, which is one reason it is the more portable choice.

> 🔀 **MySQL has no built-in system versioning.** The three realistic options are: a history table maintained by `AFTER INSERT/UPDATE/DELETE` triggers ([Chapter 39](#39-triggers)); an SCD Type 2 design where the application closes the old row and inserts a new one ([Chapter 53](#53-data-modeling-and-the-star-schema)); or a tool that reads changes from the binary log. The trigger route is the easiest to get running and the easiest to get subtly wrong — a bulk load that bypasses triggers leaves gaps in history that nobody notices for months.

```sql
-- 🟦 MySQL: the trigger-maintained history pattern, done properly
CREATE TABLE product_prices (
    product_id   INT            NOT NULL PRIMARY KEY,
    unit_price   DECIMAL(10,2)  NOT NULL,
    updated_at   DATETIME(6)    NOT NULL DEFAULT (UTC_TIMESTAMP(6))   -- when this version began
) ENGINE=InnoDB;

CREATE TABLE product_prices_history (
    history_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id   INT            NOT NULL,
    unit_price   DECIMAL(10,2)  NOT NULL,
    valid_from   DATETIME(6)    NOT NULL,
    valid_to     DATETIME(6)    NOT NULL,
    changed_by   VARCHAR(100)   NOT NULL,
    operation    CHAR(1)        NOT NULL,     -- I / U / D
    INDEX ix_hist_key (product_id, valid_from)
) ENGINE=InnoDB;

DELIMITER $$
-- Stamp the start of every new version
CREATE TRIGGER trg_prices_stamp_upd
BEFORE UPDATE ON product_prices
FOR EACH ROW
BEGIN
    SET NEW.updated_at = UTC_TIMESTAMP(6);
END$$

-- Close off the OLD version into history, ending exactly where the new one begins
CREATE TRIGGER trg_prices_history_upd
AFTER UPDATE ON product_prices
FOR EACH ROW
BEGIN
    INSERT INTO product_prices_history
        (product_id, unit_price, valid_from, valid_to, changed_by, operation)
    VALUES (OLD.product_id, OLD.unit_price, OLD.updated_at, NEW.updated_at, CURRENT_USER(), 'U');
END$$
DELIMITER ;
```

> [!TIP]
> 💡 **Note what the trigger writes: the OLD row, closed off at "now".** The current row stays in the base table. That keeps the base table small and every "as of" query becomes a `UNION ALL` of the base table and the history — which is precisely what MSSQL's temporal tables do internally.

## 62.6 🎯 When to use which

| Situation | Reach for |
|---|---|
| "Prove what the price was on 3 March" | 🟥 Temporal table · 🟦 SCD Type 2 / trigger history |
| Keep a search index or cache in sync | 🟥 Change Tracking · 🟦 binlog reader |
| Feed a data warehouse with before/after values | 🟥 CDC · 🟦 binlog reader |
| Regulatory audit of *who* read or wrote data | SQL Server Audit / MySQL Enterprise Audit — **not** triggers |
| You just want `updated_at` on a row | A column with a default. Do not over-engineer |

> [!CAUTION]
> **Do not hand-roll history with triggers if a built-in exists.** Hand-written audit triggers miss `TRUNCATE`, miss bulk inserts, miss `MERGE` branches, handle only one row when a statement changes many if written carelessly ([Chapter 39](#39-triggers)), and silently stop working when someone disables them for a data load. Temporal tables and change tracking cannot be bypassed that way.

## 62.7 🧪 Try it yourself

1. Make `products` a temporal table. Change a price three times, then reconstruct the price at each intermediate moment with `AS OF`.
2. Write a query that lists every product whose price changed in the last 7 days, with the old and new values side by side (hint: `LAG` over `FOR SYSTEM_TIME ALL`).
3. Try to `DROP` a system-versioned table without turning versioning off. Read the error, then do it properly.
4. Enable Change Tracking on `orders`, make three changes, and write the consumer query that a nightly ETL job would run.
5. Deliberately let a `CHANGETABLE` version expire past retention and observe what the consumer sees.
6. 🟦 MySQL: build the trigger-based history table above, then bulk-load rows in a way that bypasses it and explain what is now wrong with your history.

---

# 🧰 PART 14 — ENGINEERING PRACTICE

---

# 63. Concurrency patterns for real applications

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 35 min | Prevent the "lost update" when two users save at once · Use optimistic and pessimistic locking · Make retries safe · Build a job queue |

> [!NOTE]
> 📌 **In plain words:** [Chapter 43](#43-isolation-levels-locking-and-deadlocks) explained what the database does when two people collide. This chapter is what **you** must do about it — because the most common concurrency bug in production is not a deadlock. It is two users both clicking Save, and one of them silently winning.

> 🌍 **Analogy:** Two people editing the same paper form. Both photocopy it, both write on their copy, both hand it back. The second one filed overwrites the first, and nobody ever finds out. Databases will happily do this for you at any isolation level, because as far as the engine is concerned, both writes were perfectly legal.

## 63.1 💥 The lost update — the bug isolation levels do not fix

```text
10:00:00  User A reads the stock row.   qty_on_hand = 100
10:00:03  User B reads the same row.    qty_on_hand = 100
10:00:07  User B saves 90  (sold 10)
10:00:11  User A saves 95  (sold 5)     ← A never saw B's change

Final value: 95.   Actual sales: 15.   Truth: 85.
```

> [!WARNING]
> ⚠️ **Nothing here is a transaction failure.** No deadlock, no error, no rollback. Both statements were valid. The data is simply wrong, and it will stay wrong until someone counts the shelf.

There are three correct answers. Pick deliberately.

## 63.2 ✅ Answer 1: don't read-then-write at all

The best fix is to not have the race. If the new value can be expressed **as a function of the old one**, let the database compute it in a single statement — a single `UPDATE` takes its own locks and is atomic.

```sql
-- ✅ 🟥 MSSQL (in MySQL, read ROW_COUNT() instead of @@ROWCOUNT)
-- A one-row stock table to practise on (63.3 rebuilds it with a version column)
CREATE TABLE dbo.stock_items (
    product_id  INT PRIMARY KEY,
    qty_on_hand INT NOT NULL
);
INSERT INTO dbo.stock_items (product_id, qty_on_hand) VALUES (1, 100);

-- Atomic, no read, no race, no retry logic
UPDATE dbo.stock_items
SET qty_on_hand = qty_on_hand - 5
WHERE product_id = 1
  AND qty_on_hand >= 5;         -- and it cannot go negative

-- 0 rows changed = not enough stock. That is your business answer.
SELECT @@ROWCOUNT AS rows_changed;
```

> [!IMPORTANT]
> 🎯 **`@@ROWCOUNT` (🟦 MySQL: `ROW_COUNT()`) is the whole concurrency check.** If the guard in the `WHERE` clause did not hold, zero rows change and you know immediately — no `SELECT` first, no lock hint, no retry. This single pattern removes most concurrency bugs people write elaborate machinery to solve.

> [!TIP]
> 💡 **This is [set-based thinking](#59-dynamic-sql-cursors-and-set-based-thinking) applied to concurrency.** "Read it, change it in the application, write it back" is the row-by-row mindset. "Describe the change and let the engine apply it" is the set-based one, and it happens to be race-free.

## 63.3 🏷️ Answer 2: optimistic concurrency (the default for web apps)

When a human edits a form over 30 seconds, you cannot hold a lock that long. Instead, **detect** the conflict at save time: remember what version you read, and refuse to write if it has moved.

🟥 MSSQL gives you `ROWVERSION` — an 8-byte value the engine increases on every update, automatically, with no clock involved.

```sql
-- 🟥 MSSQL
DROP TABLE IF EXISTS dbo.stock_items;      -- replaces the simple version from 63.2
CREATE TABLE dbo.stock_items (
    product_id  INT PRIMARY KEY,
    qty_on_hand INT NOT NULL,
    row_ver     ROWVERSION NOT NULL     -- maintained by the engine; you never write it
);
INSERT INTO dbo.stock_items (product_id, qty_on_hand) VALUES (1, 100);
```

```sql
-- 🟥 The full optimistic cycle, with a competing writer in the middle
DECLARE @seen_version BINARY(8);

-- 1. User A reads (this is your SELECT that fills the edit form)
SELECT @seen_version = row_ver FROM dbo.stock_items WHERE product_id = 1;

-- 2. User B changes the row while A is thinking
UPDATE dbo.stock_items SET qty_on_hand = 90 WHERE product_id = 1;

-- 3. User A saves, guarding on the version it read
UPDATE dbo.stock_items
SET qty_on_hand = 95
WHERE product_id = 1
  AND row_ver = @seen_version;          -- 🔑 the whole mechanism

IF @@ROWCOUNT = 0
    SELECT 'CONFLICT - row changed since you read it' AS outcome;
ELSE
    SELECT 'OK - saved' AS outcome;
```

**Result:**

| outcome |
|---|
| CONFLICT - row changed since you read it |

```sql
-- 🟥 MSSQL
SELECT product_id, qty_on_hand FROM dbo.stock_items;
```

| product_id | qty_on_hand |
|---|---|
| 1 | **90** |

> [!IMPORTANT]
> 🎯 **The lost update is now impossible.** User B's change survived, and User A was told. What the application does next is a product decision — reload and show the new values, merge the two edits, or ask the user — but it can no longer silently destroy data.

> 🔀 **MySQL has no `ROWVERSION`.** Use an explicit integer version column and increase it yourself in the same statement:

```sql
-- 🟦 MySQL: the portable equivalent
CREATE TABLE stock_items (
    product_id  INT PRIMARY KEY,
    qty_on_hand INT NOT NULL,
    row_version INT NOT NULL DEFAULT 1
) ENGINE=InnoDB;

INSERT INTO stock_items (product_id, qty_on_hand) VALUES (1, 100);   -- row_version starts at 1

-- Save, guarding on the version read
UPDATE stock_items
SET qty_on_hand = 95,
    row_version = row_version + 1
WHERE product_id = 1
  AND row_version = 1;               -- the version the form was rendered from

SELECT ROW_COUNT();                  -- 0 = conflict
```

> [!WARNING]
> ⚠️ **Do not use `updated_at` as the version token.** Two updates inside the same clock tick get the same timestamp, and the conflict goes undetected — which is the exact bug you were trying to fix. Use `ROWVERSION` 🟥 or an integer that only ever goes up 🟦. Both are exact.

> [!TIP]
> 💡 **Every mainstream ORM (a code library that writes SQL for your application, such as Entity Framework or Hibernate) already implements this.** Entity Framework maps a `ROWVERSION` column marked `[Timestamp]` and throws `DbUpdateConcurrencyException`; Hibernate/JPA uses `@Version`; Django uses `select_for_update` or manual version fields. You are not building something exotic — you are turning on a feature.

## 63.4 🔒 Answer 3: pessimistic locking (short, server-side work only)

When the read and the write happen microseconds apart inside one transaction — a stored procedure, a job — you can simply reserve the row while you work.

```sql
-- 🟥 MSSQL: take the update lock at read time, not at write time
BEGIN TRANSACTION;

    DECLARE @q INT;
    SELECT @q = qty_on_hand
    FROM dbo.stock_items WITH (UPDLOCK, ROWLOCK)      -- 🔑
    WHERE product_id = 1;

    -- ... business logic that genuinely cannot be expressed as one UPDATE ...

    UPDATE dbo.stock_items SET qty_on_hand = @q - 5 WHERE product_id = 1;

COMMIT;
```

```sql
-- 🟦 MySQL: the same idea
START TRANSACTION;
    SELECT qty_on_hand FROM stock_items WHERE product_id = 1 FOR UPDATE;
    -- ...
    UPDATE stock_items SET qty_on_hand = qty_on_hand - 5 WHERE product_id = 1;
COMMIT;
```

| Hint | Meaning |
|---|---|
| 🟥 `WITH (UPDLOCK)` · 🟦 `FOR UPDATE` | "I intend to update this row" — blocks other writers immediately, at read time |
| 🟥 `WITH (UPDLOCK, HOLDLOCK)` · 🟦 `FOR UPDATE` under `SERIALIZABLE` | Also blocks *inserts* into the range — needed for check-then-insert |
| 🟦 `FOR SHARE` (8.0+) | "Others may read, nobody may change" |
| `READPAST` / `SKIP LOCKED` | "Skip rows someone else has locked" — the queue pattern, 63.6 |

> [!WARNING]
> ⚠️ **`UPDLOCK` without `HOLDLOCK` does not stop an insert.** The classic "check if it exists, insert if not" race needs both, because you are locking a *range* that has no rows in it yet. Better still: put a `UNIQUE` constraint on the key and let the database refuse the duplicate ([Chapter 9](#9-constraints-the-rules-that-protect-your-data)). A constraint has no race condition at all.

> [!CAUTION]
> **Never hold a pessimistic lock across a network round trip, a user's think time, an HTTP call, or a file write.** Locks held for seconds turn into blocking chains, an application that runs out of connections, and a system that looks hung. If a human is involved, you want 63.3, not this.

## 63.5 🔁 Idempotency — surviving the retry

An operation is **idempotent** when doing it twice has exactly the same effect as doing it once. That matters because networks time out *after* the database committed. The client cannot tell "it failed" from "it worked and the reply was lost", so it retries — and you get two payments.

```sql
-- 🟥 MSSQL: a unique idempotency key makes the retry harmless
CREATE TABLE payment_attempts (
    idempotency_key  CHAR(36)      NOT NULL PRIMARY KEY,   -- generated by the CLIENT
    order_id         INT           NOT NULL,
    amount           DECIMAL(10,2) NOT NULL,
    created_utc      DATETIME2(0)  NOT NULL DEFAULT SYSUTCDATETIME()
);

-- 🟦 MySQL: the same table
CREATE TABLE payment_attempts (
    idempotency_key  CHAR(36)      NOT NULL PRIMARY KEY,
    order_id         INT           NOT NULL,
    amount           DECIMAL(10,2) NOT NULL,
    created_utc      DATETIME      NOT NULL DEFAULT (UTC_TIMESTAMP())
);
```

```sql
-- 🟥 MSSQL: the second attempt with the same key does nothing, and says so
INSERT INTO payment_attempts (idempotency_key, order_id, amount)
SELECT '5f1c0a2e-0e1e-4d3a-9b7f-2a1c8e4d6b90', 1002, 250.00
WHERE NOT EXISTS (
    SELECT 1 FROM payment_attempts WITH (UPDLOCK, HOLDLOCK)
    WHERE idempotency_key = '5f1c0a2e-0e1e-4d3a-9b7f-2a1c8e4d6b90'
);

SELECT @@ROWCOUNT AS rows_inserted;   -- 1 = first time, 0 = a retry, already done
```

```sql
-- 🟦 MySQL: same guarantee, engine-native
INSERT IGNORE INTO payment_attempts (idempotency_key, order_id, amount)
VALUES ('5f1c0a2e-0e1e-4d3a-9b7f-2a1c8e4d6b90', 1002, 250.00);
SELECT ROW_COUNT();                   -- 1 = inserted, 0 = already there
```

> [!TIP]
> 💡 **The `PRIMARY KEY` is doing the real work.** Even if the `WHERE NOT EXISTS` loses the race, the unique constraint rejects the duplicate — so the worst case is a caught error, never a double charge. **Belt and braces is the correct engineering here**, because the cost of being wrong is a customer charged twice.

> [!IMPORTANT]
> 🎯 **Rule of thumb: any operation a client can retry needs a client-supplied key.** Server-generated IDs cannot help — the client never received the first one.

## 63.6 📬 The queue pattern: many workers, one table

Turning a table into a work queue is a classic, and doing it the simple way means every worker fights for the same rows.

```sql
-- 🟥 MSSQL: a work-queue table
CREATE TABLE dbo.job_queue (
    job_id      INT IDENTITY(1,1) PRIMARY KEY,
    payload     NVARCHAR(400) NOT NULL,
    status      VARCHAR(20)   NOT NULL DEFAULT 'Pending',
    claimed_by  INT           NULL,
    claimed_utc DATETIME2(0)  NULL
);
INSERT INTO dbo.job_queue (payload) VALUES (N'email:1002'), (N'email:1013'), (N'email:1022');
GO

-- Claim a batch of jobs, skipping anything already claimed
UPDATE TOP (10) j
SET    status     = 'Processing',
       claimed_by = @@SPID,
       claimed_utc = SYSUTCDATETIME()
OUTPUT inserted.job_id, inserted.payload
FROM dbo.job_queue AS j WITH (READPAST, UPDLOCK, ROWLOCK)
WHERE j.status = 'Pending';
```

```sql
-- 🟦 MySQL 8.0+: the same idea
CREATE TABLE job_queue (
    job_id      INT AUTO_INCREMENT PRIMARY KEY,
    payload     VARCHAR(400) NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'Pending',
    claimed_by  BIGINT       NULL,
    claimed_utc DATETIME     NULL
);
INSERT INTO job_queue (payload) VALUES ('email:1002'), ('email:1013'), ('email:1022');

START TRANSACTION;
    SELECT job_id, payload FROM job_queue
    WHERE status = 'Pending'
    ORDER BY job_id
    LIMIT 10
    FOR UPDATE SKIP LOCKED;
    -- UPDATE those rows to 'Processing'
COMMIT;
```

> [!TIP]
> 💡 **`READPAST` 🟥 / `SKIP LOCKED` 🟦 is the whole trick.** Instead of *waiting* for a row another worker has locked, the query steps over it. Ten workers pull ten separate batches and none of them block. Without it, all ten queue up behind worker one and your throughput (jobs finished per second) is that of a single worker.

> [!TIP]
> 💡 **`OUTPUT` 🟥 claims and reads in one statement** ([Chapter 12](#12-insert-putting-data-in)) — there is no window between "I claimed it" and "I read it" for a crash to fall into. 🟦 MySQL has no `OUTPUT` or `RETURNING`, which is why its version selects the rows `FOR UPDATE SKIP LOCKED` inside a transaction and then updates them.

> [!WARNING]
> ⚠️ **Always store `claimed_utc` and reset stale claims.** A worker that dies mid-job leaves rows stuck in `Processing` forever. A scheduled job that resets anything claimed more than *N* minutes ago is not optional — it is the difference between a queue and a leak.

## 63.7 🚦 One-at-a-time work: application locks

Sometimes the thing that must run one at a time is not a row — it is a *job*. Two servers both firing the nightly rollup is a data-corruption event, not a performance problem.

```sql
-- 🟥 MSSQL: only one session can hold this named lock
BEGIN TRANSACTION;

DECLARE @rc INT;
EXEC @rc = sp_getapplock @Resource   = 'nightly_rollup',
                         @LockMode   = 'Exclusive',
                         @LockTimeout = 0;         -- do not wait; fail fast

SELECT @rc AS applock_result;    -- 0 = granted, -1 = someone else has it

IF @rc >= 0
BEGIN
    -- ... do the work ...
    EXEC sp_releaseapplock @Resource = 'nightly_rollup';
END;

COMMIT;
```

```sql
-- 🟦 MySQL: the equivalent
SELECT GET_LOCK('nightly_rollup', 0) AS got_lock;    -- 1 = granted, 0 = timeout
-- ... do the work ...
SELECT RELEASE_LOCK('nightly_rollup');
```

> [!TIP]
> 💡 **This is a lock shared by all your servers (a *distributed mutex*) that you already own.** No extra infrastructure, no Redis, no ZooKeeper — and it releases automatically if the session dies, which is exactly the failure mode a home-made "is_running" flag column gets wrong.

## 63.8 ⏱️ Fail fast: timeouts every application should set

```sql
-- 🟥 MSSQL: session guards worth setting on every connection
SET NOCOUNT ON;             -- skip the "(n rows affected)" messages
SET XACT_ABORT ON;          -- 🔑 any error aborts the whole transaction, not just the statement
SET LOCK_TIMEOUT 5000;      -- give up waiting for a lock after 5 seconds

SELECT @@LOCK_TIMEOUT AS lock_timeout_ms;   -- 5000
SET LOCK_TIMEOUT -1;                        -- back to "wait forever" (the default)
```

```sql
-- 🟦 MySQL
SET SESSION innodb_lock_wait_timeout = 5;
SET SESSION max_execution_time = 10000;     -- ms, SELECT statements
```

> [!WARNING]
> ⚠️ **`SET XACT_ABORT ON` is the setting most T-SQL is missing.** Without it, some errors abort only the *statement*, leaving the transaction open and holding locks while the application moves on believing it failed cleanly. Combined with `TRY … CATCH` ([Chapter 45](#45-error-handling)) it is what makes a stored procedure genuinely safe.

> [!TIP]
> 💡 **Waiting forever is not "safer" than failing.** A query blocked indefinitely holds a connection, and a pool of blocked connections takes down the whole application, not just one request. A 5-second lock timeout turns a total outage into one failed request the client can retry.

## 63.9 🎯 Choosing the right tool

| Situation | Use |
|---|---|
| New value derives from the old (counters, stock, balances) | **A single `UPDATE`** with a guard in `WHERE` (63.2) |
| A human edits a form over seconds or minutes | **Optimistic** — `ROWVERSION` 🟥 / version column 🟦 (63.3) |
| Read and write are microseconds apart, inside one procedure | **Pessimistic** — `UPDLOCK` 🟥 / `FOR UPDATE` 🟦 (63.4) |
| "Insert it if it does not exist" | A **`UNIQUE` constraint**, plus upsert ([Chapter 44](#44-merge-and-upsert)) |
| The client may retry a request | **Idempotency key** with a unique constraint (63.5) |
| Many workers, one work table | **`READPAST` 🟥 / `SKIP LOCKED` 🟦** (63.6) |
| Only one server may run this job | **`sp_getapplock` 🟥 / `GET_LOCK` 🟦** (63.7) |
| Deadlocks under load, all patterns already correct | **Retry after a short pause** ([Chapter 45](#45-error-handling)), and check table access order |

## 63.10 🧪 Try it yourself

1. Reproduce the lost update in two connections, step by step, and confirm no error is raised at any point.
2. Add a `ROWVERSION` column and fix it. Prove the second writer now gets `@@ROWCOUNT = 0`.
3. Rewrite the same logic as a single guarded `UPDATE` and explain why it needs neither a version column nor a lock hint.
4. Build a two-row `job_queue` and pull from it in two sessions — first without `READPAST` / `SKIP LOCKED`, then with. Time both.
5. Take `sp_getapplock` in one session and try to take it in another. Confirm you get `-1`, not a hang.
6. Set `LOCK_TIMEOUT 2000`, block a row from a second session, and read the error number you get. Decide what your application should do with it.

---

# 64. Database DevOps: migrations, standards, and testing

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🔴 Expert | 40 min | Keep every schema change in Git · Write safe, re-runnable migrations · Change a live schema without downtime · Test your database automatically |

> [!NOTE]
> 📌 **In plain words:** Application code lives in Git (a system that records every change to code), gets reviewed, gets tested, and gets deployed automatically. For most teams, the database does not — it lives in someone's SSMS window and gets changed by hand at 11 p.m. This chapter closes that gap.

> 🌍 **Analogy:** You would never ship application code by remote-desktopping into production and editing a file. That is exactly what "just run this ALTER on prod" is.

> [!IMPORTANT]
> **The one rule that makes everything else possible:** the database schema is **source code**, and the only way it ever changes is by running a versioned script that is in Git. No exceptions, not even for a "tiny" index.

## 64.1 🔀 State-based vs migration-based — pick one and commit

| | **State-based** | **Migration-based** |
|---|---|---|
| What is in Git | The *desired* final schema | An ordered list of *change scripts* |
| How deployment works | A tool compares Git with the target database and generates the change | Runs the scripts that have not run yet |
| Tools | SSDT / DACPAC 🟥, MySQL Workbench sync 🟦 | Flyway, Liquibase, EF Core Migrations, dbmate, Alembic |
| Strength | The schema is easy to read and review as a whole | Every change is explicit, ordered, and reviewable |
| Weakness | **Data migrations are guesswork.** A rename looks like drop + add | Nobody can see the current shape without replaying history |
| Best for | Schema-only changes, brand-new projects, or teams already using the tool | **Almost everything else** |

> [!IMPORTANT]
> 🎯 **Default to migration-based.** Its weakness (no single view of the schema) is solved by generating a schema snapshot into the repo on every build. Its strength — being explicit about *data* — is not something a diff tool can fake. A column rename is the classic example: a diff sees `DROP name; ADD full_name` and silently deletes every value.

## 64.2 📜 Anatomy of a migration

```text
db/migrations/
    V0001__create_core_tables.sql
    V0002__add_order_status_check.sql
    V0003__index_orders_customer_date.sql
    V0004__backfill_loyalty_tier.sql
    V0005__add_customers_marketing_opt_in.sql
```

Four rules make a migration safe:

| Rule | Why |
|---|---|
| **Immutable once merged** | Someone has already run it. Editing it means environments silently diverge |
| **Forward-only, small, one concern each** | A 400-line migration that fails halfway is unreviewable and unrecoverable |
| **Idempotent** | Deploys get retried. Running it twice must be harmless |
| **Transactional where the engine allows** | 🟥 MSSQL wraps DDL in transactions. 🟦 MySQL 8.0 has atomic DDL per statement, but **not** across statements |

Here is a migration runner you can build yourself in an afternoon — and the tracking table every tool listed above creates for you:

```sql
-- 🟥 MSSQL: the ledger of what has been applied
IF OBJECT_ID('dbo.schema_migrations') IS NULL
CREATE TABLE dbo.schema_migrations (
    version      VARCHAR(20)   NOT NULL PRIMARY KEY,
    description  NVARCHAR(200) NOT NULL,
    checksum     CHAR(64)      NOT NULL,     -- detects an edited migration
    applied_at   DATETIME2(0)  NOT NULL DEFAULT SYSUTCDATETIME(),
    applied_by   NVARCHAR(128) NOT NULL DEFAULT SYSTEM_USER,
    duration_ms  INT           NOT NULL
);
GO
```

```sql
-- 🟥 A migration script: guarded so re-running it is harmless
IF NOT EXISTS (SELECT 1 FROM dbo.schema_migrations WHERE version = '0007')
BEGIN
    DECLARE @t0 DATETIME2(3) = SYSUTCDATETIME();
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM sys.columns
                       WHERE object_id = OBJECT_ID('dbo.customers')
                         AND name = 'marketing_opt_in')
            ALTER TABLE dbo.customers ADD marketing_opt_in BIT NOT NULL DEFAULT 0;

        INSERT INTO dbo.schema_migrations (version, description, checksum, duration_ms)
        VALUES ('0007', 'Add customers.marketing_opt_in',
                CONVERT(CHAR(64), HASHBYTES('SHA2_256', 'V0007__add_opt_in.sql'), 2),
                DATEDIFF(MILLISECOND, @t0, SYSUTCDATETIME()));

        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK;
        THROW;
    END CATCH;
END;
GO

SELECT version, description, applied_by, duration_ms FROM dbo.schema_migrations;
```

**Result — and running the exact same script a second time changes nothing:**

| version | description | applied_by | duration_ms |
|---|---|---|---|
| 0007 | Add customers.marketing_opt_in | sa | 5 |

> [!TIP]
> 💡 **Two layers of idempotency, deliberately.** The outer guard checks the ledger; the inner `IF NOT EXISTS (SELECT … FROM sys.columns …)` checks reality. The second one saves you when someone applied the change by hand before the migration ever ran — which, on a real team, they did.

> [!TIP]
> 💡 **The `checksum` column earns its place the day someone edits a merged migration.** The runner compares the file's hash against the stored one and refuses to continue, instead of quietly leaving production a schema version behind.

```sql
-- 🟦 MySQL: the equivalent guards
CREATE TABLE IF NOT EXISTS schema_migrations (
    version      VARCHAR(20)  NOT NULL PRIMARY KEY,
    description  VARCHAR(200) NOT NULL,
    checksum     CHAR(64)     NOT NULL,
    applied_at   DATETIME     NOT NULL DEFAULT (UTC_TIMESTAMP()),
    applied_by   VARCHAR(100) NOT NULL,
    duration_ms  INT          NOT NULL
) ENGINE=InnoDB;

-- ⚠️ MySQL has NO "ADD COLUMN IF NOT EXISTS" and NO "CREATE INDEX IF NOT EXISTS"
--    (that is MariaDB syntax). Check information_schema, then run the DDL only if needed:
SET @ddl = IF(
    (SELECT COUNT(*) FROM information_schema.columns
     WHERE table_schema = DATABASE() AND table_name = 'customers'
       AND column_name = 'marketing_opt_in') = 0,
    'ALTER TABLE customers ADD COLUMN marketing_opt_in BOOLEAN NOT NULL DEFAULT 0',
    'DO 0');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @ddl = IF(
    (SELECT COUNT(*) FROM information_schema.statistics
     WHERE table_schema = DATABASE() AND table_name = 'orders'
       AND index_name = 'ix_orders_customer_date') = 0,
    'CREATE INDEX ix_orders_customer_date ON orders (customer_id, order_date)',
    'DO 0');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;
```

> [!WARNING]
> ⚠️ **🟦 MySQL DDL is not transactional across statements.** MySQL 8.0 made individual DDL statements atomic, but a migration containing three `ALTER`s that fails on the third leaves the first two applied. Either keep each migration to one DDL statement, or write an explicit rollback script and test it.

## 64.3 🛡️ Zero-downtime schema changes: the expand–contract pattern

The moment you have more than one application server, old and new code run **at the same time** during a deploy. Any migration the old code cannot survive is an outage.

```text
❌ The one-step rename — guaranteed errors during the rollout
   EXEC sp_rename 'customers.full_name', 'customer_name', 'COLUMN';
   Old servers still SELECT full_name → "Invalid column name"
```

**Expand–contract** splits every breaking change into three deploys:

| Phase | Deploy | Schema state |
|---|---|---|
| 1️⃣ **Expand** | Add the new column. Backfill it. Write to **both**. | Both columns exist; old code still works |
| 2️⃣ **Migrate** | New code reads the new column only. Verify nothing reads the old one | Both exist; only new is read |
| 3️⃣ **Contract** | Drop the old column | Only new exists |

```sql
-- 🟥 MSSQL
-- 1️⃣ EXPAND: additive only, safe with old code running
ALTER TABLE dbo.customers ADD customer_name NVARCHAR(100) NULL;
GO
UPDATE dbo.customers SET customer_name = full_name WHERE customer_name IS NULL;
GO
-- (application now writes both columns)

-- 3️⃣ CONTRACT: days later, once nothing reads it
-- ⚠️ Left commented out here, because every other chapter of this guide still reads full_name:
-- ALTER TABLE dbo.customers DROP COLUMN full_name;
```

| Change | Safe in one step? | If not, do this |
|---|---|---|
| Add a nullable column | ✅ Yes | — |
| Add `NOT NULL` **with** a default | ✅ 🟥 instant on Enterprise/Developer edition (2012+) · ✅ 🟦 instant with `ALGORITHM=INSTANT` (8.0.12+) | 🟥 Standard edition rewrites every row — test the timing on a copy first |
| Add `NOT NULL` **without** a default | ❌ No | Add nullable → backfill → add the `NOT NULL` constraint |
| Rename a column or table | ❌ Never | Expand–contract |
| Widen a column (`VARCHAR(50)` → `(100)`) | ✅ Usually | Verify; narrowing is never safe |
| Narrow a type, or change its type | ❌ No | Expand–contract with a new column |
| Add an index | ⚠️ Locks by default | 🟥 `WITH (ONLINE = ON)` (Enterprise) · 🟦 `ALGORITHM=INPLACE, LOCK=NONE` |
| Add a foreign key | ⚠️ Scans and locks | 🟥 `WITH NOCHECK`, validate later ([Chapter 9](#9-constraints-the-rules-that-protect-your-data)) |
| Drop anything | ❌ Not until nothing references it | Contract phase only, after a full deploy cycle |

> [!WARNING]
> ⚠️ **A backfill is not a migration — it is a batch job.** `UPDATE customers SET customer_name = full_name` on ten million rows takes one enormous lock and makes the transaction log balloon. Batch it, exactly as in [Chapter 18](#18-update-changing-data) and 65.5, and run it *outside* the deploy transaction.

> [!TIP]
> 💡 **The rollback plan for expand–contract is "do nothing".** Every phase is independently deployable and every phase leaves the previous version of the code working. That is what makes it safe, far more than any `DOWN` script.

## 64.4 ✍️ The house style guide

Consistency is not aesthetics. A schema where half the tables are `Customer` and half are `tbl_customers` costs every developer a lookup, every single time.

**Naming**

| Object | Convention | Example |
|---|---|---|
| Table | `snake_case`, **plural**, no prefix | `order_items` |
| Column | `snake_case`, singular | `unit_price` |
| Primary key column | `<singular_table>_id` | `customer_id` |
| Foreign key column | Same name as the key it points at | `orders.customer_id` |
| Boolean | A positive statement, no negatives | `is_active`, ❌ `not_disabled` |
| UTC timestamp | Say so in the name | `created_utc`, `shipped_utc` |
| Money | Include the unit if more than one is possible | `amount_usd` |
| Primary key constraint | `pk_<table>` | `pk_order_items` |
| Foreign key constraint | `fk_<table>_<referenced>` | `fk_orders_customer` |
| Unique constraint | `uq_<table>_<columns>` | `uq_customers_email` |
| Check constraint | `ck_<table>_<rule>` | `ck_orders_status` |
| Index | `ix_<table>_<columns>` | `ix_orders_customer_date` |
| View | `v_<subject>` | `v_order_summary` |
| Stored procedure | `<verb>_<subject>` | `place_order`, `get_customer_orders` |

> [!WARNING]
> ⚠️ **Never let the engine name a constraint for you.** `UQ__customer__AB6E61648F1FC932` is different on every environment, so any script that drops it by name works on your laptop and fails in production. Name every constraint explicitly at creation ([Chapter 9](#9-constraints-the-rules-that-protect-your-data)).

> [!TIP]
> 💡 **Reserved words and pluralisation are not worth arguing about — pick one and write it down.** What *is* worth being firm on: no spaces, no `[Bracketed Names]`, no mixed case in a case-sensitive collation, and no type prefixes (`tbl_`, `sp_`). `sp_` in particular is actively harmful in 🟥 MSSQL: the engine checks `master` first for anything starting with `sp_`, so you pay a lookup penalty on every call. (This guide's examples use `usp_`, which is also fine — the harmful one is `sp_`.)

**Formatting**

```sql
-- ✅ House style: one clause per line, keywords upper, columns listed
SELECT  c.customer_id,
        c.full_name,
        COUNT(o.order_id)  AS order_count,
        SUM(p.amount)      AS lifetime_value
FROM        customers  AS c
LEFT JOIN   orders     AS o  ON o.customer_id = c.customer_id
LEFT JOIN   payments   AS p  ON p.order_id    = o.order_id
                            AND p.status      = 'Captured'
WHERE   c.country = 'Sri Lanka'
  AND   c.signup_date >= '2026-01-01'
GROUP BY c.customer_id, c.full_name
HAVING  COUNT(o.order_id) > 0
ORDER BY lifetime_value DESC;
```

- Keywords upper-case, identifiers lower-case
- One column per line in `SELECT` once there are more than two
- Every table gets a **meaningful** alias — `c`, `o`, `p`, not `a`, `b`, `t1`
- `ON` conditions immediately under their `JOIN`, continuation lines aligned
- Leading commas or trailing commas — pick one, apply it everywhere
- **Never `SELECT *`** outside a quick one-off query window ([Chapter 13](#13-select-the-heart-of-sql))

> [!TIP]
> 💡 **Enforce it with a tool, not with code review.** `sqlfluff` (both engines, and it has a linter as well as a formatter), Poor Man's T-SQL Formatter, or your editor's formatter, wired into a pre-commit hook (a check that runs automatically before every Git commit). Humans arguing about comma placement in a pull request is the single lowest-value activity in software.

## 64.5 🧪 Testing a database

"It ran without an error" is not a test. These are, in ascending order of value:

| Level | What it proves | How |
|---|---|---|
| **Migration test** | The migration applies to a copy of production and is reversible | Restore a prod backup, run all migrations, time it |
| **Constraint test** | Bad data is *actually rejected* | Insert a violating row, assert it fails |
| **Unit test** | A procedure or function returns the right answer | tSQLt 🟥, MyTAP / plain assertions 🟦 |
| **Regression test** | A query still returns the same rows after a rewrite | `EXCEPT` in both directions |
| **Performance test** | The plan did not change under real volume | Capture the plan and row counts before and after |

```sql
-- ✅ Works in BOTH (MySQL 8.0.31+): prove a rewritten query returns exactly the same rows
-- If BOTH counts are 0, the two queries return identical sets.
SELECT COUNT(*) AS rows_only_in_old FROM (
    SELECT customer_id, COUNT(*) AS order_count          -- the original query
    FROM orders
    GROUP BY customer_id
    EXCEPT
    SELECT c.customer_id, COUNT(o.order_id)              -- its rewrite
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id
) AS d;

SELECT COUNT(*) AS rows_only_in_new FROM (
    SELECT c.customer_id, COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id
    EXCEPT
    SELECT customer_id, COUNT(*)
    FROM orders
    GROUP BY customer_id
) AS d;
```

> [!TIP]
> 💡 **`EXCEPT` in both directions is the single most useful database test there is.** Before you rewrite any query for performance, capture its output; after the rewrite, prove set equality. This catches the "faster but wrong" rewrite, which is the only kind that actually hurts you. 🟦 MySQL 8.0.31+ supports `EXCEPT`; on older versions use `LEFT JOIN … WHERE right IS NULL` ([Chapter 29](#29-set-operators-union-intersect-except)).

```sql
-- ✅ 🟥 MSSQL — constraint test: assert that the database refuses bad data
BEGIN TRY
    INSERT INTO orders (customer_id, order_date, status)
    VALUES (1, '2026-01-01', 'Teleported');       -- violates ck_orders_status
    SELECT 'FAIL - the constraint did not fire' AS result;
END TRY
BEGIN CATCH
    SELECT 'PASS - rejected: ' + ERROR_MESSAGE() AS result;
END CATCH;
```

> [!IMPORTANT]
> 🎯 **Test your constraints, not just your queries.** A `CHECK` constraint that was accidentally created `WITH NOCHECK`, or a foreign key someone disabled for a data load and never re-enabled, is invisible until the day bad data arrives. One test per business rule, run in CI (the automatic build-and-test pipeline), and you find out in 30 seconds instead of 30 months.

## 64.6 🚀 The pipeline

```text
  git push
     │
     ├─▶ 1. Lint          sqlfluff / formatter check
     │
     ├─▶ 2. Build         spin up a throwaway database container
     │                    run every migration from empty
     │
     ├─▶ 3. Test          constraint tests, unit tests, regression tests
     │
     ├─▶ 4. Verify        run migrations against a RESTORED PROD COPY
     │                    ← this step catches what step 2 cannot: real data
     │
     ├─▶ 5. Review        a human reads the migration. Always.
     │
     └─▶ 6. Deploy        same runner, same scripts, production
              └─ backup taken immediately before
```

> [!CAUTION]
> **Step 4 is the one teams skip, and it is the one that catches real failures.** An empty database applies any migration in milliseconds. The same migration against 40 million real rows may take four hours, fill the transaction log, or fail on data that violates the constraint you are adding. Run it on a restored copy, and **time it**, before it ever meets production.

> [!TIP]
> 💡 **Every production deployment starts with a backup and ends with a verified restore path** ([Chapter 56](#56-backup-restore-and-disaster-recovery)). "We can roll back the code" is not a plan when the migration dropped a column.

## 64.7 ✅ The database DevOps checklist

- ☐ Every schema change is a script in Git — no exceptions, not even indexes
- ☐ Migrations are immutable once merged, and checksummed
- ☐ Every migration is idempotent and guarded
- ☐ Breaking changes go through expand–contract, never one step
- ☐ Backfills are batched and run outside the deploy transaction
- ☐ Naming and formatting conventions are documented and linted automatically
- ☐ Every constraint has an explicit name
- ☐ Migrations are tested against a **restored production copy**, and timed
- ☐ Constraint and regression tests run in CI
- ☐ Production deploys are automated, backed up first, and reviewed by a human
- ☐ Nobody — nobody — has a production SSMS window open for routine work

## 64.8 🧪 Try it yourself

1. Build the `schema_migrations` table and a two-script runner. Run it twice and prove the second run is a no-op.
2. Take a column rename and write it out as three separate expand–contract deploys.
3. Write a constraint test for every `CHECK` in ShopDB. Break one deliberately and confirm the test fails.
4. Rewrite one of the [Chapter 26](#26-group-by-and-having) reporting queries and prove set equality with `EXCEPT` in both directions.
5. Install `sqlfluff`, point it at your scripts, and fix everything it complains about. Then wire it into a pre-commit hook.

---

# 65. SQL from the application layer

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟡🔴 Intermediate–Expert | 35 min | Use connection pools correctly · Spot and fix the N+1 problem · Batch writes · Set timeouts and retry safely |

> [!NOTE]
> 📌 **In plain words:** Every query in this guide so far ran in a query window. In production they run from application code — and that changes what "fast" and "correct" mean. Most database outages are not caused by a bad query. They are caused by a *fine* query, called badly.

> 🌍 **Analogy:** A perfectly efficient checkout till is useless if the shop only lets one customer through the door at a time, or if each customer walks back to the car park between items. The till was never the bottleneck.

## 65.1 🔌 Connections are expensive — pool them

Opening a database connection costs a network handshake, a login check, and memory on the server. A **connection pool** keeps a set of connections open and lends them out, so the app does not pay that cost on every request. Doing that per request is the most common self-inflicted performance wound there is.

| | Without pooling | With pooling |
|---|---|---|
| Cost per query | 20–100 ms of setup | ~0 |
| Server memory | One session per in-flight request | One session per **pooled** connection |
| Behaviour under load | Collapses — connection storms | Degrades gracefully — requests queue |

```csharp
// ✅ C# / ADO.NET — the pool is on by default. `using` RETURNS the connection, it does not close the socket.
var csb = new SqlConnectionStringBuilder
{
    DataSource = "prod-sql-01",
    InitialCatalog = "ShopDB",
    MinPoolSize = 5,
    MaxPoolSize = 100,          // must be < the server's worker limit, across ALL app servers
    ConnectTimeout = 5,         // fail fast on a dead server
    CommandTimeout = 30,        // ⚠️ separate setting — see 65.6
    Encrypt = true
};

using var conn = new SqlConnection(csb.ConnectionString);
await conn.OpenAsync();
```

```python
# ✅ Python — a pool, not a connection per call
from sqlalchemy import create_engine
engine = create_engine(
    "mysql+mysqlconnector://app_user:***@db-host/ShopDB",
    pool_size=10, max_overflow=20, pool_pre_ping=True, pool_recycle=1800
)
```

> [!WARNING]
> ⚠️ **Size the pool for the *database*, not the application.** Total connections across every app server, worker, and cron job must stay under what the server can handle. Ten services each configured `MaxPoolSize = 100` is a thousand connections, and the server will fall over long before it runs a thousand queries at once. A pool much bigger than the number of CPU cores the database has mostly adds waiting, not speed.

> [!TIP]
> 💡 **`pool_pre_ping` / `pool_recycle` exist because firewalls silently kill idle TCP connections.** Without them, the first query after a quiet period fails with a broken pipe. This is the classic "it only breaks at 3 a.m." bug.

```sql
-- 🟥 MSSQL: who is connected right now, and what are they doing?
SELECT s.session_id, s.login_name, s.host_name, s.program_name,
       s.status, s.last_request_end_time,
       DB_NAME(s.database_id) AS db
FROM sys.dm_exec_sessions s
WHERE s.is_user_process = 1
ORDER BY s.last_request_end_time DESC;
```

```sql
-- 🟦 MySQL
SHOW STATUS LIKE 'Threads_connected';
SELECT @@max_connections;
SELECT * FROM performance_schema.threads WHERE type = 'FOREGROUND';
```

## 65.2 💣 The N+1 problem

This one is silent in development, where the table has 20 rows, and fatal in production, where it has 200,000.

```csharp
// ❌ N+1: one query for the list, then one MORE per row. 501 round trips.
var customers = await db.Customers.Where(c => c.Country == "Sri Lanka").ToListAsync();
foreach (var c in customers)
    c.Orders = await db.Orders.Where(o => o.CustomerId == c.CustomerId).ToListAsync();
```

```csharp
// ✅ One query. The database was built for this.
var customers = await db.Customers
    .Where(c => c.Country == "Sri Lanka")
    .Include(c => c.Orders)
    .ToListAsync();
```

> [!WARNING]
> 💥 **500 queries at 2 ms each is a full second of pure latency (waiting)**, and a second of a connection held. The equivalent join runs in 3 ms. Nothing about the SQL was slow — the *shape of the calling code* was.

> [!TIP]
> 💡 **How to catch it:** log the query count per request and alert when it exceeds a threshold. Every ORM can do this — EF Core `LogTo`, Hibernate statistics, Django Debug Toolbar, `ActiveRecord` query logs. An endpoint that fires 300 queries is an N+1, always, and no plan tuning will save it.

> [!WARNING]
> ⚠️ **The opposite mistake exists too.** `Include` on five collections at once produces a row explosion — the same customer row repeated 40 times because they have 5 orders and 8 addresses. Split it into two queries, or project to exactly the columns you need. The cure for N+1 is *fewer round trips*, not *one enormous join*.

## 65.3 🔐 Parameters are not optional (and they are also faster)

[Chapter 55](#55-sql-injection-and-how-to-stop-it) covered this as a security rule. It is also a performance rule.

```csharp
// ❌ Every distinct value compiles a NEW plan and fills the plan cache with garbage
cmd.CommandText = $"SELECT * FROM customers WHERE country = '{country}'";

// ✅ One plan, reused for every value — and injection-proof
cmd.CommandText = "SELECT customer_id, full_name FROM customers WHERE country = @country";
cmd.Parameters.Add("@country", SqlDbType.NVarChar, 60).Value = country;
```

> [!WARNING]
> ⚠️ **Declare the parameter's type *and length*.** Letting the driver infer `NVARCHAR(4000)` from a 6-character string causes an implicit conversion against an `NVARCHAR(60)` column, and that can turn a seek into a scan — the exact failure from [Chapter 23](#23-conversion-and-casting). This is one of the most common "fast in SSMS, slow from the app" causes there is.

```sql
-- 🟥 Confirm you are getting plan reuse, not plan-cache pollution
SELECT TOP 10
    cp.usecounts,
    cp.objtype,
    LEFT(st.text, 80) AS query_text
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
WHERE cp.cacheobjtype = 'Compiled Plan'
ORDER BY cp.usecounts DESC;
```

> [!TIP]
> 💡 **A cache full of `objtype = 'Adhoc'` entries with `usecounts = 1` is the signature of unparameterized SQL.** Every one of those cost a compilation. `Prepared` and `Proc` entries with high `usecounts` are what healthy looks like.

## 65.4 📦 Round trips: batch, don't loop

```csharp
// ❌ 10,000 round trips
foreach (var item in items)
    await conn.ExecuteAsync("INSERT INTO order_items VALUES (@a,@b,@c)", item);
```

| Rows | Reach for |
|---|---|
| 1–10 | A single multi-row `INSERT … VALUES (…),(…),(…)` ([Chapter 12](#12-insert-putting-data-in)) |
| 10–1,000 | 🟥 A **table-valued parameter** ([Chapter 37](#37-stored-procedures)) · 🟦 a multi-row insert built with parameters |
| 1,000–1,000,000 | 🟥 `SqlBulkCopy` · 🟦 `LOAD DATA INFILE` / the C API's bulk mode |
| Over a million | 🟥 `BULK INSERT` / `bcp` · 🟦 `LOAD DATA INFILE` ([Chapter 12](#12-insert-putting-data-in)) |

```csharp
// ✅ 🟥 MSSQL: hundreds of thousands of rows, one round trip
using var bulk = new SqlBulkCopy(conn)
{
    DestinationTableName = "dbo.order_items",
    BatchSize = 5000,
    BulkCopyTimeout = 600
};
await bulk.WriteToServerAsync(dataTable);
```

> [!TIP]
> 💡 **The same rule applies to reads.** Fetching 500 rows by primary key in a loop is an N+1 in disguise. Send one query with `WHERE product_id IN (…)` — as a table-valued parameter 🟥 or a properly parameterized list 🟦 — and get them in one trip.

## 65.5 🪓 Big writes: batch inside the database too

A single `DELETE` of ten million rows takes one enormous lock, generates gigabytes of log, and blocks everything until it finishes or times out. Chop it up.

```sql
-- ✅ 🟥 MSSQL: delete in small, committed batches
-- (a log table to practise on)
CREATE TABLE dbo.audit_log (
    log_id    BIGINT IDENTITY(1,1) PRIMARY KEY,
    logged_at DATETIME2(0)  NOT NULL,
    message   NVARCHAR(200) NOT NULL
);
CREATE INDEX ix_audit_log_logged_at ON dbo.audit_log (logged_at);   -- see the warning below
INSERT INTO dbo.audit_log (logged_at, message) VALUES
('2024-03-01', N'old entry'), ('2025-01-15', N'old entry'), (SYSUTCDATETIME(), N'recent entry');
GO

DECLARE @deleted INT = 1, @total INT = 0;

WHILE @deleted > 0
BEGIN
    DELETE TOP (5000) FROM dbo.audit_log
    WHERE logged_at < DATEADD(DAY, -365, CAST(SYSUTCDATETIME() AS DATE));

    SET @deleted = @@ROWCOUNT;
    SET @total  += @deleted;
    -- optional: WAITFOR DELAY '00:00:00.100';   -- let other work breathe
END;

SELECT @total AS rows_deleted;
```

```sql
-- ✅ 🟦 MySQL: the same shape
CREATE TABLE audit_log (
    log_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    logged_at DATETIME     NOT NULL,
    message   VARCHAR(200) NOT NULL,
    INDEX ix_audit_log_logged_at (logged_at)
);
INSERT INTO audit_log (logged_at, message) VALUES
('2024-03-01', 'old entry'), ('2025-01-15', 'old entry'), (UTC_TIMESTAMP(), 'recent entry');

DELETE FROM audit_log
WHERE logged_at < DATE_SUB(UTC_DATE(), INTERVAL 365 DAY)
LIMIT 5000;
-- repeat while ROW_COUNT() > 0
```

> [!TIP]
> 💡 **Each batch is its own transaction, so each one releases its locks and its log space.** The total work is the same; the *blocking* is a hundredth of what it was. This is the pattern behind every safe archival job, backfill, and bulk correction.

> [!WARNING]
> ⚠️ **Make sure the `WHERE` clause is indexed.** A batched delete that scans the whole table to find each 5,000 rows is worse than the single delete — you now do the full scan a thousand times. Check the plan first.

## 65.6 ⏱️ Timeouts, retries, and failing gracefully

| Setting | Where | What it protects |
|---|---|---|
| Connect timeout | Connection string | A dead or unreachable server |
| **Command timeout** | Per command — **not** the connection string in ADO.NET | One runaway query holding a connection |
| Lock timeout | `SET LOCK_TIMEOUT` 🟥 / `innodb_lock_wait_timeout` 🟦 | Blocking chains ([Chapter 63](#63-concurrency-patterns-for-real-applications)) |
| Statement timeout | `max_execution_time` 🟦 | Runaway `SELECT`s, server-side |

> [!WARNING]
> ⚠️ **`CommandTimeout` and `ConnectTimeout` are different things, and the default `CommandTimeout` of 30 seconds applies per command, not per request.** A page that runs six queries can legally take three minutes before anything complains. Set both explicitly, and set them *shorter* than your HTTP timeout so the database is not still working on a request the user abandoned.

```csharp
// ✅ Retry only what is genuinely transient — deadlocks, timeouts, failovers
static readonly int[] Transient = { 1205, 1222, -2, 4060, 40197, 40501, 49918 };

for (var attempt = 1; attempt <= 3; attempt++)
{
    try { return await ExecuteAsync(); }
    catch (SqlException ex) when (Transient.Contains(ex.Number) && attempt < 3)
    {
        await Task.Delay(TimeSpan.FromMilliseconds(100 * Math.Pow(2, attempt)
                                                   + Random.Shared.Next(0, 50)));  // growing wait + a little randomness (jitter)
    }
}
```

| Error | Engine | Retry? |
|---|---|---|
| `1205` deadlock victim | 🟥 | ✅ Yes — retry is the *designed* response ([Chapter 45](#45-error-handling)) |
| `1222` lock request timeout | 🟥 | ✅ Yes, with backoff |
| `-2` command timeout | 🟥 | ⚠️ Once, then investigate — usually a real problem |
| `1213` deadlock | 🟦 | ✅ Yes |
| `1205` lock wait timeout | 🟦 | ✅ Yes |
| `2627` / `2601` unique violation | 🟥 | ❌ **Never** — retrying inserts a duplicate. This is a business outcome |
| `547` constraint violation | 🟥 | ❌ Never — the data is wrong |

> [!TIP]
> 💡 **Jitter (a little randomness in the wait) is not decoration.** Without it, every client that lost the same deadlock retries at exactly the same moment and deadlocks again. Randomising the backoff is what breaks the synchronisation.

> [!WARNING]
> ⚠️ **A retry is only safe if the operation is idempotent.** Retrying a payment after a timeout is how customers get charged twice — see 63.5.

## 65.7 🌊 Streaming, paging, and not fetching everything

```csharp
// ❌ Loads 2 million rows into application memory, then throws most away
var all = await db.Orders.ToListAsync();
var recent = all.Where(o => o.OrderDate > cutoff).Take(50);

// ✅ The database filters, sorts, and pages. 50 rows cross the network.
var recent = await db.Orders
    .Where(o => o.OrderDate > cutoff)
    .OrderByDescending(o => o.OrderDate)
    .Take(50)
    .ToListAsync();
```

> [!IMPORTANT]
> 🎯 **Filter, sort, aggregate, and page in the database — always.** It has the indexes, the statistics, and the memory. The application has none of those, and every row it does not need costs network traffic, memory clean-up, and waiting time.

> [!TIP]
> 💡 **For genuinely large result sets — an export, a report — stream them.** `SqlDataReader` / a server-side cursor in MySQL yields rows as they arrive instead of buffering the whole set. And for deep paging, use **keyset pagination**, not `OFFSET` ([Chapter 17](#17-paging-top-limit-offset-fetch)) — `OFFSET 900000` makes the server read and discard 900,000 rows on every page.

## 65.8 🧭 Where should the logic live?

| Logic | Put it in the database when… | Put it in the application when… |
|---|---|---|
| Data integrity rules | **Always.** Constraints do not have bad days ([Chapter 9](#9-constraints-the-rules-that-protect-your-data)) | Never rely on the app alone |
| Set operations over many rows | Always — that is what SQL is for | Never loop rows in the app to do a join |
| Business workflow, orchestration | Rarely | Usually — it is easier to test, version, and debug |
| Calls to other systems | **Never** ([Chapter 39](#39-triggers)) | Always |
| Formatting and localisation | Never | Always — the database should return raw values |
| Authorization *rules* | Enforce at the row level where the data model allows ([Chapter 54](#54-security-users-roles-and-permissions)) | Decide the policy here |

> [!TIP]
> 💡 **The honest test: if you moved this logic, what would break?** Integrity rules moved into the app break the moment anyone connects with a different client — a script, a migration, an admin. Workflow logic moved into the database becomes untestable, unversioned, and invisible to your debugger. Put each where it can actually be enforced.

## 65.9 ✅ The application-layer checklist

- ☐ Connection pooling is on, and the **total** pool across all services fits the server
- ☐ `pool_pre_ping` / connection validation is enabled
- ☐ Query count per request is logged, with an alert on N+1 explosions
- ☐ Every query is parameterized, with **explicit types and lengths**
- ☐ Plan cache is dominated by `Prepared`/`Proc`, not single-use `Adhoc`
- ☐ Bulk work uses bulk APIs, not loops
- ☐ Large writes are batched inside the database too
- ☐ Connect, command, and lock timeouts are all set explicitly, and shorter than the HTTP timeout
- ☐ Retries cover only temporary errors, with a growing **and slightly random** wait between tries
- ☐ Retried operations are idempotent
- ☐ Filtering, sorting, and paging happen in the database
- ☐ Deep paging uses keyset, not `OFFSET`
- ☐ Credentials come from a secret store, and the app user is not `sa` / `root`

## 65.10 🧪 Try it yourself

1. Write the N+1 version and the joined version of "customers with their orders". Time both against 10,000 customers.
2. Run the plan-cache query. Count how many single-use `Adhoc` plans your application has created, then fix one call site and watch the number drop.
3. Insert 100,000 rows three ways — a loop, a table-valued parameter, and `SqlBulkCopy`. Record all three timings.
4. Batch-delete a million rows and watch blocking in a second session with `sys.dm_exec_requests` ([Chapter 43](#43-isolation-levels-locking-and-deadlocks)).
5. Force a deadlock from two connections and implement the retry with backoff and jitter. Verify the retry actually succeeds.
6. Set `CommandTimeout = 1`, run `WAITFOR DELAY '00:00:05'`, and confirm which error your driver raises.

---

# 🏁 PART 15 — PUTTING IT ALL TOGETHER

---
# 66. Anti-patterns, cheat sheets, exercises, and the capstone

| 🎚️ Level | ⏱️ Time | 🎯 After this chapter you can… |
|:---:|:---:|---|
| 🟢🟡🔴 All levels | Keep as a reference | Spot the 32 classic mistakes · Translate any task between MSSQL and MySQL · Practise with 40 exercises · Build a complete project · Look up any term |

> [!NOTE]
> 📌 **In plain words:** The finish line. This chapter gathers everything into things you can keep beside you: the mistakes to avoid, a one-page MSSQL-vs-MySQL cheat sheet, interview questions, practice exercises, a full project to build, a 35-day plan, and a glossary of every term in the guide.

---

## 66.1 🚫 The 32 SQL anti-patterns

> [!NOTE]
> 📌 Each one below is a mistake you will meet in real codebases — often in your own. Learn to spot them on sight.

### 🔴 Design anti-patterns

| # | Anti-pattern | Why it hurts | Do this instead |
|---|---|---|---|
| 1 | **Comma-separated values in a column** (`'1,5,12'`) | Cannot join, index, or constrain it | A bridge table (Chapter 53) |
| 2 | **`column1, column2, column3`** repeating groups | Breaks the day someone needs a fourth | One row per value |
| 3 | **No primary key** | No reliable way to identify or update a row | Always define one |
| 4 | **A wide or changing primary key** (email as PK) | Duplicated in every index; breaks when it changes | Surrogate `INT` PK + `UNIQUE` on the natural key |
| 5 | **`FLOAT` for money** | Silent rounding errors that compound | `DECIMAL(10,2)` |
| 6 | **EAV (entity-attribute-value)** for everything | Every query becomes a self-join nightmare | Real columns; JSON for rarely used details |
| 7 | **No foreign keys** ("the app handles it") | The app always has a bug eventually | Declare the constraints |
| 8 | **Storing computable values without a plan** | They drift out of sync silently | Compute on read, or denormalize *with* verification (Chapter 52) |
| 9 | **Mixed date formats / local times** | Unrecoverable ambiguity | Store UTC, ISO format |
| 10 | **Inconsistent naming** (`custID`, `customer_id`, `CustomerId`) | Every query needs a lookup | One convention, documented |

### 🔴 Query anti-patterns

| # | Anti-pattern | Why it hurts | Do this instead |
|---|---|---|---|
| 11 | **`SELECT *` in production code** | Breaks covering indexes, moves useless data, breaks on schema change | Name your columns |
| 12 | **Functions on indexed columns** (`YEAR(date) = 2026`) | Stops the index being used | SARGable ranges (Chapter 48) |
| 13 | **Leading wildcard** `LIKE '%x%'` | Always a full scan | Full-text index, or restructure |
| 14 | **`NOT IN` with a nullable subquery** | Silently returns zero rows | `NOT EXISTS` |
| 15 | **`DISTINCT` to hide a bad join** | Masks the bug and adds a sort | Fix the join |
| 16 | **Implicit type conversion** (`WHERE phone = 947755501`) | Converts the whole column, no index | Match the types |
| 17 | **Old comma joins** (`FROM a, b WHERE ...`) | One forgotten condition = every row paired with every row (a cartesian product) | Explicit `JOIN ... ON` |
| 18 | **Filtering a `LEFT JOIN` in `WHERE`** | Silently becomes an `INNER JOIN` | Put the condition in `ON` |
| 19 | **Aggregating two one-to-many joins together** | Fan-out multiplies your totals | Total each side first, then join |
| 20 | **Cursors for data transformation** | 100x slower than a set-based statement | Think in sets (Chapter 59) |

### 🔴 Operational anti-patterns

| # | Anti-pattern | Why it hurts | Do this instead |
|---|---|---|---|
| 21 | **`UPDATE`/`DELETE` with no `WHERE`** | Instant, irreversible mass damage | `SELECT` first; transaction; safe-update mode |
| 22 | **String concatenation into SQL** | SQL injection | Parameterize (Chapter 55) |
| 23 | **The app connects as `sa`/`root`** | One bug becomes total compromise | Least privilege |
| 24 | **Backups never tested** | You discover they are broken during the disaster | Monthly restore drills |
| 25 | **Indexing everything "just in case"** | Every write pays for every index | Index for measured queries; audit for unused ones |
| 26 | **Read-modify-write from the application** | Silent lost updates; no error is ever raised | One guarded `UPDATE`, or a version column (Chapter 63) |
| 27 | **Retrying a non-idempotent operation** | Double charges, duplicate orders | A client-supplied idempotency key + `UNIQUE` (Chapter 63) |
| 28 | **N+1 queries from an ORM** | 500 round trips where one join would do | Eager-load, or project what you need (Chapter 65) |
| 29 | **Schema changed by hand in production** | Environments diverge; nothing is reviewable or repeatable | Versioned migrations in Git (Chapter 64) |
| 30 | **A breaking migration deployed in one step** | Old app servers error during every rollout | Expand–contract (Chapter 64) |
| 31 | **`VARCHAR` + a legacy code page for user text** | Non-Latin characters become `??`, silently and permanently | `NVARCHAR` / `_UTF8` 🟥 · `utf8mb4` 🟦 (Chapter 60) |
| 32 | **A local timestamp with no zone recorded** | Ambiguous twice a year and unfixable afterwards | Store UTC; convert at the edge (Chapter 61) |

---

## 66.2 📋 MSSQL vs MySQL — the complete cheat sheet

### Basics

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Limit rows | `SELECT TOP 10 ...` | `... LIMIT 10` |
| Page results | `OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY` | `LIMIT 10 OFFSET 20` |
| String concat | `'a' + 'b'` or `CONCAT()` | `CONCAT()` only |
| Quote identifiers | `[table name]` | `` `table name` `` |
| Current date/time | `GETDATE()`, `SYSDATETIME()` | `NOW()`, `CURRENT_TIMESTAMP` |
| Today's date | `CAST(GETDATE() AS DATE)` | `CURDATE()` |
| Auto number | `IDENTITY(1,1)` | `AUTO_INCREMENT` |
| Last inserted ID | `SCOPE_IDENTITY()` | `LAST_INSERT_ID()` |
| Rows affected | `@@ROWCOUNT` | `ROW_COUNT()` |
| NULL replacement | `ISNULL(x, y)` | `IFNULL(x, y)` |
| Portable NULL replacement | `COALESCE(x, y)` | `COALESCE(x, y)` |
| Conditional shorthand | `IIF(c, a, b)` | `IF(c, a, b)` |
| String length | `LEN(s)` | `CHAR_LENGTH(s)` |
| Substring position | `CHARINDEX(find, text)` | `LOCATE(find, text)` |
| Left pad | `RIGHT(REPLICATE('0',n)+s, n)` | `LPAD(s, n, '0')` |
| Aggregate strings | `STRING_AGG(x, ',')` | `GROUP_CONCAT(x)` |
| Split a string | `STRING_SPLIT(s, ',')` | `SUBSTRING_INDEX(s, ',', n)` |
| Random order | `ORDER BY NEWID()` | `ORDER BY RAND()` |
| Cast | `CAST(x AS VARCHAR(10))` | `CAST(x AS CHAR)` |
| Safe cast | `TRY_CAST(x AS INT)` | *(none — filter with REGEXP)* |
| Format a date | `FORMAT(d, 'yyyy-MM-dd')` | `DATE_FORMAT(d, '%Y-%m-%d')` |
| Add days | `DATEADD(DAY, 7, d)` | `d + INTERVAL 7 DAY` |
| Date difference | `DATEDIFF(DAY, start, end)` | `DATEDIFF(end, start)` |
| Last day of month | `EOMONTH(d)` | `LAST_DAY(d)` |
| Current UTC time | `SYSUTCDATETIME()` | `UTC_TIMESTAMP()` |
| Convert time zone | `dt AT TIME ZONE 'UTC' AT TIME ZONE 'tz'` | `CONVERT_TZ(dt,'UTC','tz')` |
| Force a collation | `col COLLATE Latin1_General_CS_AS` | `col COLLATE utf8mb4_0900_as_cs` |
| Unicode text | `NVARCHAR`, or `VARCHAR` + a `_UTF8` collation | `VARCHAR` under `utf8mb4` |
| Median | `PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY x) OVER ()` | *(none — use `ROW_NUMBER`)* |
| Named window | `WINDOW w AS (...)` (2022+) | `WINDOW w AS (...)` (8.0+) |

### Structure and objects

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Show databases | `SELECT name FROM sys.databases` | `SHOW DATABASES` |
| Show tables | `SELECT * FROM sys.tables` | `SHOW TABLES` |
| Describe a table | `sp_help 'orders'` | `DESCRIBE orders` |
| Show the DDL | `sp_helptext` / script it in SSMS | `SHOW CREATE TABLE orders` |
| Show indexes | `SELECT * FROM sys.indexes` | `SHOW INDEX FROM orders` |
| Modify a column | `ALTER TABLE t ALTER COLUMN c TYPE` | `ALTER TABLE t MODIFY COLUMN c TYPE` |
| Rename a column | `EXEC sp_rename 't.c', 'new', 'COLUMN'` | `ALTER TABLE t RENAME COLUMN c TO new` |
| Create or replace a view | `CREATE OR ALTER VIEW` | `CREATE OR REPLACE VIEW` |
| Temp table | `CREATE TABLE #t (...)` | `CREATE TEMPORARY TABLE t (...)` |
| Table variable | `DECLARE @t TABLE (...)` | *(none)* |
| Sequence | `CREATE SEQUENCE` | *(imitate with a table)* |
| Computed column | `AS (expr) PERSISTED` | `AS (expr) STORED` |
| Materialized view | Indexed view (`SCHEMABINDING`) | *(none — use a table + job)* |
| Full outer join | `FULL OUTER JOIN` | *(imitate with `UNION`)* |
| Top-N per group | `CROSS APPLY` | `JOIN LATERAL ... ON TRUE` |
| Pivot | `PIVOT` operator | *(use `CASE`)* |
| Upsert | `MERGE` | `INSERT ... ON DUPLICATE KEY UPDATE` |
| Row history | Temporal tables (`SYSTEM_VERSIONING = ON`) | *(triggers, or SCD Type 2)* |
| Row version token | `ROWVERSION` column | *(an `INT` version column)* |
| Idempotent DDL | `IF NOT EXISTS (SELECT 1 FROM sys.columns ...)` | Check `information_schema`, then `PREPARE` the DDL (there is no `ADD COLUMN IF NOT EXISTS`) |

### Procedural code

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Delimiter change | Not needed (`GO` separates batches) | `DELIMITER $$ ... $$ DELIMITER ;` |
| Declare a variable | `DECLARE @x INT;` | `DECLARE x INT;` (routines only) |
| Session variable | `DECLARE @x INT; SET @x = 1;` | `SET @x = 1;` |
| Assign from a query | `SELECT @x = col FROM t` | `SELECT col INTO x FROM t` |
| If | `IF ... BEGIN ... END` | `IF ... THEN ... END IF;` |
| While | `WHILE ... BEGIN ... END` | `WHILE ... DO ... END WHILE;` |
| Call a procedure | `EXEC usp_name @p = 1` | `CALL usp_name(1)` |
| Raise an error | `THROW 50001, 'msg', 1` | `SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='msg'` |
| Catch errors | `BEGIN TRY ... BEGIN CATCH` | `DECLARE EXIT HANDLER FOR SQLEXCEPTION` |
| Dynamic SQL | `EXEC sp_executesql @sql, @params, ...` | `PREPARE stmt FROM @sql; EXECUTE stmt USING @p;` |

### Administration

| Task | 🟥 MSSQL | 🟦 MySQL |
|---|---|---|
| Execution plan | `SET SHOWPLAN_ALL ON` / Ctrl+M | `EXPLAIN` / `EXPLAIN ANALYZE` |
| I/O statistics | `SET STATISTICS IO ON` | `EXPLAIN ANALYZE` / performance_schema |
| Update statistics | `UPDATE STATISTICS t` | `ANALYZE TABLE t` |
| Rebuild an index | `ALTER INDEX ... REBUILD` | `OPTIMIZE TABLE t` |
| Consistency check | `DBCC CHECKDB` | `CHECK TABLE t` |
| Running sessions | `sys.dm_exec_requests` | `performance_schema.processlist` |
| Kill a session | `KILL 57` | `KILL 57` |
| Backup | `BACKUP DATABASE ... TO DISK` | `mysqldump` / XtraBackup |
| Restore | `RESTORE DATABASE ... FROM DISK` | `mysql < dump.sql` |
| Create a user | `CREATE LOGIN` + `CREATE USER` | `CREATE USER 'u'@'host'` |
| Grant | `GRANT SELECT ON t TO u` | `GRANT SELECT ON db.t TO 'u'@'h'` |
| Show permissions | `sys.database_permissions` | `SHOW GRANTS FOR 'u'@'h'` |
| Schedule a job | SQL Server Agent | Event Scheduler / cron |
| Query history / plan regression | **Query Store** | `performance_schema` + `sys` views |
| Lock a row for update | `WITH (UPDLOCK)` | `FOR UPDATE` |
| Skip locked rows | `WITH (READPAST)` | `SKIP LOCKED` (8.0+) |
| Named application lock | `sp_getapplock` | `GET_LOCK()` |
| Lock wait timeout | `SET LOCK_TIMEOUT 5000` | `innodb_lock_wait_timeout = 5` |
| Change feed for ETL | Change Tracking / CDC | binlog (`ROW` format) |

---

## 66.3 🧠 The interview question bank

<details>
<summary><b>🌱 Beginner — click to expand</b></summary>

1. What is the difference between `WHERE` and `HAVING`?
2. Explain `INNER JOIN` vs `LEFT JOIN` with an example.
3. What is a primary key? How does it differ from a unique constraint?
4. What does `NULL` mean, and why does `= NULL` never work?
5. `DELETE` vs `TRUNCATE` vs `DROP` — give the full comparison.
6. What is a foreign key and what does it protect against?
7. Explain `GROUP BY`. What must appear in the `SELECT` list?
8. What is the difference between `UNION` and `UNION ALL`?
9. Why should you avoid `SELECT *` in application code?
10. What does `DISTINCT` do, and why is it often a warning sign?
11. Write a query to find the second-highest price in a table.
12. Write a query to find duplicate emails.
13. What is an index, in one sentence? What does it cost?
14. What are the five families of SQL commands (DDL, DML, DQL, DCL, TCL)?
15. Explain `CHAR` vs `VARCHAR`.

</details>

<details>
<summary><b>🚀 Intermediate — click to expand</b></summary>

16. Explain the logical order of query execution and one bug it explains.
17. What is a CTE? How does it differ from a temp table?
18. Explain window functions. How do they differ from `GROUP BY`?
19. `ROW_NUMBER` vs `RANK` vs `DENSE_RANK` — with tied values.
20. How do you get the top N rows per group? Give two methods.
21. What is a correlated subquery? When is it slow?
22. Explain `EXISTS` vs `IN` vs a `JOIN` for existence checks.
23. What is a self join? Give a real use case.
24. What are the ACID properties? Explain each in one sentence.
25. What is a deadlock and how do you prevent one?
26. Explain the four isolation levels and what each prevents.
27. What is normalization? Explain 1NF, 2NF, 3NF.
28. When would you deliberately denormalize?
29. What is a covering index?
30. Explain clustered vs non-clustered indexes.
31. Why does `WHERE YEAR(date) = 2026` perform badly?
32. What is a stored procedure? When would you use one?
33. What is a trigger, and why are experienced engineers cautious about them?
34. What is a view? Can you always update through one?
35. How do you implement an upsert in each engine?

</details>

<details>
<summary><b>🏆 Advanced — click to expand</b></summary>

36. What is SARGability? Give three non-SARGable patterns and their fixes.
37. Explain parameter sniffing and three ways to address it.
38. How does the optimizer choose a plan? What role do statistics play?
39. Explain the three physical join algorithms and when each is chosen.
40. What is the fan-out problem when joining two one-to-many children?
41. When would you partition a table, and when would you not?
42. Explain SCD Type 2 and why the fact table stores a surrogate key.
43. Explain MVCC and how MySQL's default isolation differs from MSSQL's.
44. What does `READ_COMMITTED_SNAPSHOT` change, and why does it matter?
45. Why are MSSQL scalar UDFs a performance risk? What is the fix?
46. Design a keyset pagination scheme and explain why it beats `OFFSET`.
47. How would you find and safely delete duplicate rows in a 500M-row table?
48. What is the difference between a logical and a physical backup?
49. Explain RPO and RTO and how they drive a backup schedule.
50. You are told "the database is slow." Walk through your diagnostic process.
51. What is a lost update, and why does raising the isolation level not fix it?
52. Compare optimistic and pessimistic concurrency. When is each correct?
53. What makes an operation idempotent, and why does every retryable API need it?
54. Explain the N+1 problem and two ways to detect it in a running system.
55. What is a collation? Give one bug caused by getting it wrong.
56. Why is 🟦 MySQL's `utf8` charset a trap? What should you use?
57. How do you store a timestamp so it is still unambiguous in ten years?
58. Write a "one local day" filter that stays SARGable against a UTC column.
59. What are temporal tables, and what do they *not* record?
60. Explain expand–contract and why a one-step column rename causes an outage.
61. What is Query Store for, and when would you force a plan?
62. How would you delete 50 million rows from a live table?

</details>

> [!TIP]
> 💡 **For question 50, the expected answer:** check whether it is *all* queries or one; look at wait statistics to find the resource under pressure; find the top queries by total elapsed time; get the plan for the worst one; look for scans, bad estimates, and lookups; check whether statistics are current and indexes exist; verify it is not blocking or a hardware limit. **Measure, then change one thing, then measure again.**

---

## 66.4 🏋️ 40 practice exercises on ShopDB

<details>
<summary><b>Level 1 — Basics (1-10)</b></summary>

1. List all products, most expensive first.
2. Find all customers in the UK or Germany.
3. Show orders placed in March 2026 (use a SARGable range).
4. Find products below their reorder level.
5. List every distinct country customers come from.
6. Show the 5 cheapest non-discontinued products.
7. Find customers whose email is at `example.com`.
8. Show orders that have not shipped.
9. List products priced between 100 and 500.
10. Count customers per loyalty tier.

</details>

<details>
<summary><b>Level 2 — Joins and aggregation (11-20)</b></summary>

11. Show every order with its customer name and sales rep name.
12. List each product with its category and supplier names.
13. Find total revenue per category.
14. Show the top 5 customers by lifetime spend.
15. Find products that have never been ordered.
16. Show every customer including those with zero orders (correctly displaying 0).
17. Find orders with no captured payment.
18. Show each employee with their manager's name (include the CEO).
19. Count orders per status, with each as a percentage of the total.
20. Find categories with more than 3 products and an average price above 200.

</details>

<details>
<summary><b>Level 3 — Subqueries, CTEs, windows (21-30)</b></summary>

21. Find products priced above their own category's average.
22. Show each customer's most recent order.
23. Find the top 2 best-selling products in each category.
24. Build a running total of revenue by month.
25. Show month-over-month revenue change as an amount and a percentage.
26. Rank customers by spend within their country.
27. Build the full org chart with indentation levels.
28. Find gaps in the `order_id` sequence.
29. Calculate each category's share of total revenue, plus a cumulative percentage (Pareto).
30. Find customers whose spend is above the overall customer average.

</details>

<details>
<summary><b>Level 4 — Advanced (31-40)</b></summary>

31. Build a monthly revenue pivot with categories as columns.
32. Generate every date in the first half of 2026 and show daily revenue with zeros for quiet days.
33. Find the average number of days between each customer's consecutive orders.
34. Write a stored procedure that places an order atomically, checking stock.
35. Write a trigger that logs every price change.
36. Create an indexed view / summary table of category sales.
37. Find every foreign key column in ShopDB that lacks an index.
38. Write a safe dynamic search procedure with four optional filters.
39. Implement SCD Type 2 on a customer dimension and simulate a city change.
40. Identify the three slowest queries you have written in this guide and tune them.

</details>

---

## 66.4b 🔑 Solutions to exercises 1–30

> ⚠️ **Try each one first.** A solution you read produces a feeling of competence; a solution you
> wrote produces the real thing. If you are stuck, read only the 💡 hint line before the query.

**How these were checked:** every query below was executed against a freshly built ShopDB on
**SQL Server 2025 Express (17.0.4025.3)**, and the row counts and values shown are the real output.
The MySQL variants are given where the syntax differs, but were **not executed** — see
[What was verified, and what was not](#-what-was-verified-and-what-was-not).

**Before you start:** rebuild ShopDB (§4.3 → §4.5 → §4.6) so your data matches these answers. Earlier
chapters add and drop columns, and a leftover change will shift the numbers.

<details>
<summary><b>Level 1 — Basics (1–10)</b></summary>

**1. List all products, most expensive first.**

```sql
-- ✅ Works in BOTH
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;
```

18 rows, starting `WorkStation X17 | 2450.00`, `UltraBook Pro 14 | 1499.00`, `UltraBook Air 13 | 999.00`.

💡 Note that `Zenith Phone 12 Mini` and `VisionPanel 32 4K` both cost `749.00`. Their relative order
is **not defined** — add a tie-breaker (`ORDER BY unit_price DESC, product_name`) whenever you need a
stable, repeatable order. This matters far more than beginners expect; see [§16](#16-order-by-sorting-results).

---

**2. Find all customers in the UK or Germany.**

```sql
-- ✅ Works in BOTH
SELECT full_name, country
FROM customers
WHERE country IN ('UK', 'Germany')
ORDER BY country, full_name;
```

| full_name | country |
|---|---|
| Hannah Weiss | Germany |
| John Baker | UK |

💡 `IN` is shorthand for `country = 'UK' OR country = 'Germany'`. Only two rows — that is correct for
this data, not a mistake in your query.

---

**3. Show orders placed in March 2026 (SARGable).**

```sql
-- ✅ Works in BOTH
SELECT order_id, order_date
FROM orders
WHERE order_date >= '2026-03-01'
  AND order_date <  '2026-04-01'
ORDER BY order_date;
```

| order_id | order_date |
|---|---|
| 1007 | 2026-03-03 |
| 1008 | 2026-03-12 |
| 1009 | 2026-03-21 |

💡 **This is the point of the exercise.** `WHERE MONTH(order_date) = 3` returns the same rows and
**cannot use an index**, because wrapping the column in a function makes the predicate
non-SARGable ([§48](#48-query-optimization-and-sargability)). The half-open range `>= start AND < next_start`
is the SARGable form, and using `<` for the upper bound means you never have to think about whether
the month has 28, 30, or 31 days — or about time components hiding at `23:59:59.997`.

---

**4. Find products below their reorder level.**

```sql
-- ✅ Works in BOTH
SELECT product_name, units_in_stock, reorder_level
FROM products
WHERE units_in_stock < reorder_level
ORDER BY product_name;
```

| product_name | units_in_stock | reorder_level |
|---|---|---|
| ArchiveDrive 8TB | 4 | 10 |
| Legacy Netbook 10 | 0 | 5 |
| Stream Cam 4K | 9 | 10 |

💡 You can compare two **columns**, not just a column with a literal. That is what makes this a
business rule rather than a hard-coded threshold.

---

**5. List every distinct country customers come from.**

```sql
-- ✅ Works in BOTH
SELECT DISTINCT country FROM customers ORDER BY country;
```

12 rows: Czechia, Denmark, Germany, India, Italy, Japan, Nigeria, Singapore, Spain, Sri Lanka, UAE, UK.

💡 Twelve customers, twelve countries — one each. Keep that in mind for exercise 26, where it makes
every customer rank 1 in their own country.

---

**6. Show the 5 cheapest non-discontinued products.**

```sql
-- 🟥 MSSQL
SELECT TOP (5) product_name, unit_price
FROM products
WHERE discontinued = 0
ORDER BY unit_price ASC, product_name;
```

```sql
-- 🟦 MySQL
SELECT product_name, unit_price
FROM products
WHERE discontinued = 0
ORDER BY unit_price ASC, product_name
LIMIT 5;
```

| product_name | unit_price |
|---|---|
| Silent Mouse Pro | 45.00 |
| PodMic USB | 99.00 |
| NanoSSD 1TB | 109.00 |
| MechKey RGB Keyboard | 129.00 |
| Stream Cam 4K | 159.00 |

💡 `TOP`/`LIMIT` without `ORDER BY` returns an **arbitrary** five rows — the engine is free to give you
any five. "Cheapest" only means something once you have said how to sort.

---

**7. Find customers whose email is at `example.com`.**

```sql
-- ✅ Works in BOTH
SELECT full_name, email
FROM customers
WHERE email LIKE '%@example.com'
ORDER BY full_name;
```

All 12 customers — every seeded address uses that domain.

⚠️ **A leading `%` makes this non-SARGable**: the engine cannot seek, so it scans every row. Fine on 12
rows, and a real problem on 12 million. If you genuinely need to search by domain at scale, store the
domain in its own column and index it. See [§48](#48-query-optimization-and-sargability).

---

**8. Show orders that have not shipped.**

```sql
-- ✅ Works in BOTH
SELECT order_id, order_date, status
FROM orders
WHERE ship_date IS NULL
ORDER BY order_id;
```

| order_id | order_date | status |
|---|---|---|
| 1004 | 2026-02-09 | Cancelled |
| 1009 | 2026-03-21 | Paid |
| 1013 | 2026-05-06 | Pending |
| 1017 | 2026-06-15 | Refunded |
| 1020 | 2026-07-19 | Paid |
| 1022 | 2026-08-14 | Pending |

⚠️ **`IS NULL`, never `= NULL`.** `ship_date = NULL` returns **zero rows** and no error, because
comparing anything to `NULL` yields *unknown*, not *true* ([§15](#15-null-the-value-that-is-not-there)).
This is the most common silent bug in beginner SQL.

💡 Note the result mixes genuinely-unshipped orders with `Cancelled` and `Refunded` ones. A business
question is rarely answered by one column — you would usually add `AND status NOT IN ('Cancelled','Refunded')`.

---

**9. List products priced between 100 and 500.**

```sql
-- ✅ Works in BOTH
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 100 AND 500
ORDER BY unit_price;
```

10 rows, from `NanoSSD 1TB | 109.00` to `VisionPanel 27 QHD | 399.00`.

💡 `BETWEEN` is **inclusive at both ends**. That is safe here, and dangerous with dates and times:
`BETWEEN '2026-03-01' AND '2026-03-31'` silently excludes anything at `2026-03-31 00:00:01`. Use the
half-open range from exercise 3 for anything with a time component.

---

**10. Count customers per loyalty tier.**

```sql
-- ✅ Works in BOTH
SELECT loyalty_tier, COUNT(*) AS customers
FROM customers
GROUP BY loyalty_tier
ORDER BY customers DESC, loyalty_tier;
```

| loyalty_tier | customers |
|---|---|
| Bronze | 5 |
| Gold | 3 |
| Silver | 3 |
| Platinum | 1 |

💡 `COUNT(*)` counts rows; `COUNT(column)` counts **non-NULL values** of that column. They differ the
moment nulls appear, and the difference is a common source of wrong totals ([§25](#25-aggregate-functions)).

</details>

<details>
<summary><b>Level 2 — Joins and aggregation (11–20)</b></summary>

**11. Every order with its customer name and sales rep name.**

```sql
-- ✅ Works in BOTH
SELECT o.order_id,
       c.full_name AS customer,
       COALESCE(e.first_name + ' ' + e.last_name, '(none)') AS sales_rep
FROM orders AS o
INNER JOIN customers AS c ON c.customer_id = o.customer_id
LEFT  JOIN employees AS e ON e.employee_id = o.employee_id
ORDER BY o.order_id;
```

23 rows, beginning `1000 | Amara Silva | Priya Raman`.

💡 **Why `INNER` for the customer and `LEFT` for the employee.** `orders.customer_id` is `NOT NULL`,
so every order has a customer — an inner join loses nothing. `orders.employee_id` **is** nullable
(a web order has no sales rep), so an inner join there would silently drop those orders. Match the
join type to the column's nullability, every time.

🟦 **MySQL:** `+` does not concatenate strings. Use `CONCAT_WS(' ', e.first_name, e.last_name)`, and
`IFNULL(...)` in place of `COALESCE(...)` if you prefer (both work in MySQL).

---

**12. Each product with its category and supplier names.**

```sql
-- ✅ Works in BOTH
SELECT p.product_name,
       c.category_name,
       COALESCE(s.company_name, '(none)') AS supplier
FROM products AS p
INNER JOIN categories AS c ON c.category_id = p.category_id
LEFT  JOIN suppliers  AS s ON s.supplier_id = p.supplier_id
ORDER BY p.product_name;
```

| product_name | category_name | supplier |
|---|---|---|
| ArchiveDrive 8TB | Storage | Baltic Components |
| Budget Phone A3 | Smartphones | Lanka Distributors |
| Concert Over-Ear | Audio | EuroSound GmbH |
| … | … | … |

💡 Same rule as exercise 11: `products.category_id` is `NOT NULL` (inner), `products.supplier_id` is
nullable (left).

---

**13. Total revenue per category.**

```sql
-- ✅ Works in BOTH
SELECT c.category_name,
       CAST(SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS DECIMAL(12,2)) AS revenue
FROM order_items AS oi
JOIN products   AS p ON p.product_id  = oi.product_id
JOIN categories AS c ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;
```

| category_name | revenue |
|---|---|
| Laptops | 13223.35 |
| Smartphones | 5874.55 |
| Monitors | 3719.10 |
| Audio | 2053.85 |
| Storage | 1311.00 |
| Peripherals | 1200.00 |

⚠️ **Use `order_items.unit_price`, not `products.unit_price`.** The order line records the price
**at the time of sale**; the product table holds today's price. Joining to `products` for the price
would silently restate history every time someone changes a price. This is exactly the deliberate
duplication explained in [§4.6](#46--verify-your-build) and [§52](#52-denormalization-and-when-to-break-the-rules).

---

**14. Top 5 customers by lifetime spend.**

```sql
-- 🟥 MSSQL (MySQL: drop TOP (5) and add LIMIT 5 at the end)
SELECT TOP (5)
       c.full_name,
       CAST(SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS DECIMAL(12,2)) AS lifetime_spend
FROM customers   AS c
JOIN orders      AS o  ON o.customer_id = c.customer_id
JOIN order_items AS oi ON oi.order_id   = o.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY lifetime_spend DESC;
```

| full_name | lifetime_spend |
|---|---|
| Mei Chen | 7976.45 |
| John Baker | 4040.15 |
| Fatima Al-Sayed | 3459.20 |
| Grace Adeyemi | 3388.00 |
| Kenji Watanabe | 2887.65 |

💡 **Group by `customer_id` as well as `full_name`.** Two customers could share a name; grouping by
the key keeps them separate and tells the engine the name is functionally dependent on it.

---

**15. Products that have never been ordered.**

```sql
-- ✅ Works in BOTH
SELECT p.product_name
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1 FROM order_items AS oi WHERE oi.product_id = p.product_id
)
ORDER BY p.product_name;
```

One row: `Legacy Netbook 10`.

⚠️ **Prefer `NOT EXISTS` over `NOT IN` here.** If the subquery column ever contains a `NULL`,
`NOT IN` returns **no rows at all** — silently, with no error, because `x NOT IN (1, NULL)` evaluates
to *unknown* rather than *true*. `NOT EXISTS` is immune. See [§30](#30-subqueries-and-exists).

💡 The `LEFT JOIN … WHERE oi.product_id IS NULL` anti-join is an equally valid third form.

---

**16. Every customer, including those with zero orders, showing 0 correctly.**

```sql
-- ✅ Works in BOTH
SELECT c.full_name, COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY order_count DESC, c.full_name;
```

12 rows, from `Mei Chen | 4` down to several with `1`. In this data every customer has ordered at
least once, so no zero appears — **but the query is still the correct one**, and here is how to prove
it to yourself:

```sql
-- ✅ Works in BOTH: add a customer with no orders, then re-run exercise 16
INSERT INTO customers (full_name, email, city, country, signup_date, loyalty_tier)
VALUES ('Test Nobody', 'nobody@example.com', 'Nowhere', 'UK', '2026-09-01', 'Bronze');
```

Re-run the query and `Test Nobody | 0` appears at the bottom. Then remove it, or rebuild from §4.3–4.5.

⚠️ **`COUNT(o.order_id)`, never `COUNT(*)`.** With a `LEFT JOIN`, an unmatched customer still produces
one row — with all the `orders` columns `NULL`. `COUNT(*)` counts that row and reports **1**;
`COUNT(o.order_id)` skips `NULL`s and correctly reports **0**. This single character is the whole
exercise.

---

**17. Orders with no captured payment.**

```sql
-- ✅ Works in BOTH
SELECT o.order_id, o.status
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1 FROM payments AS pay
    WHERE pay.order_id = o.order_id
      AND pay.status   = 'Captured'
)
ORDER BY o.order_id;
```

| order_id | status |
|---|---|
| 1004 | Cancelled |
| 1013 | Pending |
| 1017 | Refunded |
| 1022 | Pending |

💡 The `AND pay.status = 'Captured'` belongs **inside** the subquery. Move it outside and you change
the question from "has no captured payment" to something that also matches orders whose payment rows
exist but failed — a different, and usually wrong, answer.

---

**18. Every employee with their manager's name, including the CEO.**

```sql
-- ✅ Works in BOTH
SELECT e.first_name + ' ' + e.last_name AS employee,
       COALESCE(m.first_name + ' ' + m.last_name, '(no manager)') AS manager
FROM employees AS e
LEFT JOIN employees AS m ON m.employee_id = e.manager_id
ORDER BY e.employee_id;
```

| employee | manager |
|---|---|
| Sarah Mitchell | (no manager) |
| David Okafor | Sarah Mitchell |
| Priya Raman | David Okafor |
| … | … |

💡 This is a **self join**: one table joined to itself under two aliases. The aliases are not optional
styling — without them the engine cannot tell which `first_name` you mean. "Including the CEO" is the
hint that it must be a `LEFT` join, since `Sarah Mitchell.manager_id` is `NULL`.

---

**19. Orders per status, with each as a percentage of the total.**

```sql
-- ✅ Works in BOTH (window functions: MSSQL 2012+, MySQL 8.0+)
SELECT status,
       COUNT(*) AS n,
       CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,1)) AS pct
FROM orders
GROUP BY status
ORDER BY n DESC, status;
```

| status | n | pct |
|---|---|---|
| Delivered | 15 | 65.2 |
| Paid | 2 | 8.7 |
| Pending | 2 | 8.7 |
| Shipped | 2 | 8.7 |
| Cancelled | 1 | 4.3 |
| Refunded | 1 | 4.3 |

💡 **`SUM(COUNT(*)) OVER ()` looks impossible and is not.** Aggregation runs first, producing one row
per status; the window function then runs *over those grouped rows*, summing the six counts to 23.
Understanding that ordering is what makes window functions click ([§33](#33-window-functions)).

⚠️ **`100.0`, not `100`.** With integer `100`, `100 * 15 / 23` is integer division in SQL Server and
yields `65` with the fraction discarded before the cast. One decimal point changes the whole
expression to decimal arithmetic.

---

**20. Categories with more than 3 products and an average price above 200.**

```sql
-- ✅ Works in BOTH
SELECT c.category_name,
       COUNT(*) AS product_count,
       CAST(AVG(p.unit_price) AS DECIMAL(10,2)) AS avg_price
FROM products   AS p
JOIN categories AS c ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(*) > 3 AND AVG(p.unit_price) > 200
ORDER BY avg_price DESC;
```

| category_name | product_count | avg_price |
|---|---|---|
| Laptops | 4 | 1311.75 |

💡 **`HAVING`, not `WHERE`.** `WHERE` filters individual rows *before* grouping; `HAVING` filters the
groups *after*. A condition on `COUNT(*)` or `AVG(...)` can only go in `HAVING`, because those values
do not exist until the grouping has happened ([§26](#26-group-by-and-having)).

</details>

<details>
<summary><b>Level 3 — Subqueries, CTEs, window functions (21–30)</b></summary>

**21. Products priced above their own category's average.**

```sql
-- ✅ Works in BOTH
SELECT p.product_name, p.unit_price, c.category_name
FROM products   AS p
JOIN categories AS c ON c.category_id = p.category_id
WHERE p.unit_price > (
    SELECT AVG(p2.unit_price)
    FROM products AS p2
    WHERE p2.category_id = p.category_id     -- correlated to the outer row
)
ORDER BY c.category_name, p.unit_price DESC;
```

10 rows, including `WorkStation X17 | 2450.00 | Laptops` and `Concert Over-Ear | 349.00 | Audio`.

💡 This is a **correlated subquery**: it references `p.category_id` from the outer query, so it is
conceptually re-evaluated per row. The window-function form is usually clearer and lets the engine do
one pass:

```sql
-- ✅ Works in BOTH — same answer, one pass
WITH priced AS (
    SELECT p.product_name, p.unit_price, c.category_name,
           AVG(p.unit_price) OVER (PARTITION BY p.category_id) AS cat_avg
    FROM products AS p
    JOIN categories AS c ON c.category_id = p.category_id
)
SELECT product_name, unit_price, category_name
FROM priced
WHERE unit_price > cat_avg
ORDER BY category_name, unit_price DESC;
```

Note the `WHERE` must live **outside** the CTE — you cannot filter on a window function in the same
`SELECT` that computes it, because window functions are evaluated after `WHERE`.

---

**22. Each customer's most recent order.**

```sql
-- ✅ Works in BOTH
WITH ranked AS (
    SELECT o.customer_id, o.order_id, o.order_date,
           ROW_NUMBER() OVER (PARTITION BY o.customer_id
                              ORDER BY o.order_date DESC, o.order_id DESC) AS rn
    FROM orders AS o
)
SELECT c.full_name, r.order_id, r.order_date
FROM ranked AS r
JOIN customers AS c ON c.customer_id = r.customer_id
WHERE r.rn = 1
ORDER BY c.full_name;
```

12 rows — one per customer — beginning `Amara Silva | 1016 | 2026-06-04`.

💡 **The `, o.order_id DESC` tie-breaker matters.** Two orders on the same date would otherwise make
the "most recent" arbitrary and the result non-repeatable.

💡 **`ROW_NUMBER` versus `RANK`:** `ROW_NUMBER` always gives exactly one row per partition;
`RANK` gives *all* tied rows the same number, so `rn = 1` could return two orders. Choose by whether
ties should produce one row or several.

---

**23. Top 2 best-selling products in each category.**

```sql
-- ✅ Works in BOTH
WITH sales AS (
    SELECT p.category_id, p.product_name, SUM(oi.quantity) AS units
    FROM order_items AS oi
    JOIN products AS p ON p.product_id = oi.product_id
    GROUP BY p.category_id, p.product_name
),
ranked AS (
    SELECT s.*,
           ROW_NUMBER() OVER (PARTITION BY s.category_id
                              ORDER BY s.units DESC, s.product_name) AS rn
    FROM sales AS s
)
SELECT c.category_name, r.product_name, r.units
FROM ranked AS r
JOIN categories AS c ON c.category_id = r.category_id
WHERE r.rn <= 2
ORDER BY c.category_name, r.rn;
```

| category_name | product_name | units |
|---|---|---|
| Audio | PodMic USB | 4 |
| Audio | StudioBuds Wireless | 4 |
| Laptops | UltraBook Pro 14 | 4 |
| Laptops | UltraBook Air 13 | 3 |
| … | … | … |

💡 **Two stacked CTEs**: aggregate first, then rank the aggregates. Trying to do both in one step
fails, because you cannot rank a `SUM` in the same `SELECT` that computes it.

💡 Audio has a genuine tie at 4 units, broken alphabetically by the `, s.product_name` clause. Use
`RANK()` instead if you would rather return **both** tied products and sometimes get three rows.

---

**24. Running total of revenue by month.**

```sql
-- 🟥 MSSQL
WITH monthly AS (
    SELECT DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS month_start,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount))      AS revenue
    FROM orders AS o
    JOIN order_items AS oi ON oi.order_id = o.order_id
    GROUP BY DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1)
)
SELECT month_start,
       CAST(revenue AS DECIMAL(12,2)) AS revenue,
       CAST(SUM(revenue) OVER (ORDER BY month_start
                               ROWS UNBOUNDED PRECEDING) AS DECIMAL(12,2)) AS running_total
FROM monthly
ORDER BY month_start;
```

🟦 **MySQL:** replace `DATEFROMPARTS(YEAR(x), MONTH(x), 1)` with `DATE_FORMAT(o.order_date, '%Y-%m-01')`.

| month_start | revenue | running_total |
|---|---|---|
| 2026-01-01 | 6379.15 | 6379.15 |
| 2026-02-01 | 2597.20 | 8976.35 |
| 2026-03-01 | 4059.10 | 13035.45 |
| 2026-04-01 | 2492.50 | 15527.95 |
| 2026-05-01 | 3495.75 | 19023.70 |
| 2026-06-01 | 3291.00 | 22314.70 |
| 2026-07-01 | 3101.05 | 25415.75 |
| 2026-08-01 | 1966.10 | 27381.85 |

⚠️ **Write `ROWS UNBOUNDED PRECEDING` explicitly.** The default frame when you supply `ORDER BY` is
`RANGE UNBOUNDED PRECEDING`, which groups **all rows with an equal sort value** into the same frame.
Month starts are unique here so both give the same answer — but on a column with duplicates, `RANGE`
silently produces a different running total. Making the frame explicit is a habit worth forming
([§34](#34-ranking-running-totals-and-moving-averages)).

💡 Grouping by the **first day of the month** rather than by a `'2026-01'` string keeps the values
sortable as real dates and avoids a text sort that would put `2026-10` before `2026-2`.

---

**25. Month-over-month revenue change, amount and percentage.**

```sql
-- 🟥 MSSQL (MySQL: as in exercise 24, swap DATEFROMPARTS for DATE_FORMAT)
WITH monthly AS (
    SELECT DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS month_start,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount))      AS revenue
    FROM orders AS o
    JOIN order_items AS oi ON oi.order_id = o.order_id
    GROUP BY DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1)
)
SELECT month_start,
       CAST(revenue AS DECIMAL(12,2)) AS revenue,
       CAST(revenue - LAG(revenue) OVER (ORDER BY month_start) AS DECIMAL(12,2)) AS change_amount,
       CAST(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month_start))
            / NULLIF(LAG(revenue) OVER (ORDER BY month_start), 0) AS DECIMAL(6,1)) AS change_pct
FROM monthly
ORDER BY month_start;
```

| month_start | revenue | change_amount | change_pct |
|---|---|---|---|
| 2026-01-01 | 6379.15 | NULL | NULL |
| 2026-02-01 | 2597.20 | -3781.95 | -59.3 |
| 2026-03-01 | 4059.10 | 1461.90 | 56.3 |
| 2026-04-01 | 2492.50 | -1566.60 | -38.6 |
| 2026-05-01 | 3495.75 | 1003.25 | 40.3 |
| 2026-06-01 | 3291.00 | -204.75 | -5.9 |
| 2026-07-01 | 3101.05 | -189.95 | -5.8 |
| 2026-08-01 | 1966.10 | -1134.95 | -36.6 |

💡 **The first row is `NULL`, and that is right.** January has no previous month, so `LAG` returns
`NULL` and the arithmetic propagates it. Do not "fix" this with `COALESCE(..., 0)` — a 0% change is a
claim that revenue was flat, which is false. `NULL` correctly says *"unknown"*.

⚠️ **`NULLIF(prev, 0)` prevents a divide-by-zero.** If a month ever had zero revenue, the percentage
would otherwise raise `Msg 8134`. `NULLIF` turns the 0 into `NULL`, and `NULL` division yields `NULL`
instead of an error.

---

**26. Rank customers by spend within their country.**

```sql
-- ✅ Works in BOTH
WITH spend AS (
    SELECT c.customer_id, c.full_name, c.country,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total
    FROM customers   AS c
    JOIN orders      AS o  ON o.customer_id = c.customer_id
    JOIN order_items AS oi ON oi.order_id   = o.order_id
    GROUP BY c.customer_id, c.full_name, c.country
)
SELECT country, full_name,
       CAST(total AS DECIMAL(12,2)) AS total,
       RANK() OVER (PARTITION BY country ORDER BY total DESC) AS rank_in_country
FROM spend
ORDER BY country, rank_in_country;
```

12 rows — and **every one has `rank_in_country = 1`**, because ShopDB happens to hold exactly one
customer per country (exercise 5). The query is correct; the data simply gives it nothing to rank.

💡 **Prove it works** by adding a second UK customer with an order, or test the logic by partitioning
on something with repeats instead — `PARTITION BY c.loyalty_tier` produces genuine rankings of 1, 2,
3 with this data. Verifying a query against data that cannot exercise it is a habit worth breaking
early.

---

**27. The full org chart with indentation levels.**

```sql
-- 🟥 MSSQL (MySQL 8.0+: identical, but write WITH RECURSIVE org AS ...)
WITH org AS (
    -- Anchor: everyone with no manager
    SELECT employee_id, first_name, last_name, manager_id, 0 AS lvl
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive step: everyone who reports to someone already found
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, o.lvl + 1
    FROM employees AS e
    JOIN org AS o ON o.employee_id = e.manager_id
)
SELECT lvl,
       REPLICATE('    ', lvl) + first_name + ' ' + last_name AS org_chart
FROM org
ORDER BY lvl, org_chart;
```

| lvl | org_chart |
|---|---|
| 0 | Sarah Mitchell |
| 1 | &nbsp;&nbsp;&nbsp;&nbsp;Amara Nwosu |
| 1 | &nbsp;&nbsp;&nbsp;&nbsp;David Okafor |
| 1 | &nbsp;&nbsp;&nbsp;&nbsp;Elena Petrova |
| 2 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marco Rossi |
| 2 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Priya Raman |
| 2 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tom Becker |
| 2 | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yuki Sato |

💡 **A recursive CTE always has exactly two parts** joined by `UNION ALL`: an *anchor* that does not
reference the CTE, and a *recursive member* that does. Get the anchor wrong and you get no rows; get
the join direction wrong and you walk the tree upward instead of downward.

🟦 **MySQL:** `REPLICATE` is `REPEAT`, and `+` concatenation is `CONCAT`. MySQL also requires the
`RECURSIVE` keyword, and caps depth at `cte_max_recursion_depth` (default 1000).

⚠️ **A cycle in the data — A manages B, B manages A — loops forever.** SQL Server stops at 100 levels
by default (`OPTION (MAXRECURSION n)` changes it); MySQL uses the setting above. If your hierarchy
comes from user input, assume a cycle will eventually appear.

---

**28. Find gaps in the `order_id` sequence.**

```sql
-- 🟥 MSSQL 2022+ (GENERATE_SERIES)
WITH bounds AS (SELECT MIN(order_id) AS lo, MAX(order_id) AS hi FROM orders)
SELECT n.value AS missing_order_id
FROM bounds AS b
CROSS APPLY GENERATE_SERIES(b.lo, b.hi) AS n
WHERE NOT EXISTS (SELECT 1 FROM orders AS o WHERE o.order_id = n.value)
ORDER BY n.value;
```

**Result on a freshly built ShopDB: no rows.** Order IDs run 1000–1022 with no gaps — so the honest
answer to this exercise is *"there are none"*, and a query returning nothing is the correct result,
not a failure.

**Prove the query actually works** by creating a gap and removing it again:

```sql
-- 🟥 MSSQL: make a gap, look for it, then undo everything
BEGIN TRANSACTION;

DELETE FROM payments    WHERE order_id = 1005;
DELETE FROM order_items WHERE order_id = 1005;   -- children first: FK order matters
DELETE FROM orders      WHERE order_id = 1005;

WITH bounds AS (SELECT MIN(order_id) AS lo, MAX(order_id) AS hi FROM orders)
SELECT n.value AS missing_order_id
FROM bounds AS b
CROSS APPLY GENERATE_SERIES(b.lo, b.hi) AS n
WHERE NOT EXISTS (SELECT 1 FROM orders AS o WHERE o.order_id = n.value);
-- returns: 1005

ROLLBACK TRANSACTION;    -- 🔑 puts all three tables back
```

The `ROLLBACK` is what makes this safe to run on your practice database — see
[§42](#42-transactions-and-acid).

**On SQL Server 2019/2022 without `GENERATE_SERIES`**, generate the numbers from a system catalog:

```sql
-- 🟥 MSSQL 2016+ : no GENERATE_SERIES needed
WITH nums AS (
    SELECT TOP (100)
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1
           + (SELECT MIN(order_id) FROM orders) AS n
    FROM sys.all_objects
)
SELECT n AS missing_order_id
FROM nums
WHERE n <= (SELECT MAX(order_id) FROM orders)
  AND NOT EXISTS (SELECT 1 FROM orders AS o WHERE o.order_id = n)
ORDER BY n;
```

💡 **A different, often better approach** needs no number series at all — compare each row with the
next using `LEAD`:

```sql
-- ✅ Works in BOTH (MSSQL 2012+, MySQL 8.0+)
WITH seq AS (
    SELECT order_id, LEAD(order_id) OVER (ORDER BY order_id) AS next_id
    FROM orders
)
SELECT order_id + 1 AS gap_starts, next_id - 1 AS gap_ends
FROM seq
WHERE next_id > order_id + 1
ORDER BY order_id;
```

This reads only the table itself and scales to any range, where the numbers approach must materialise
every value between the bounds.

⚠️ **Gaps in an `IDENTITY`/`AUTO_INCREMENT` column are normal and expected.** A rolled-back transaction
consumes its number permanently. Never treat such a column as a gapless counter — if you need one, see
[§41](#41-sequences-and-generated-columns).

---

**29. Each category's share of revenue, plus a cumulative percentage (Pareto).**

```sql
-- ✅ Works in BOTH
WITH cat AS (
    SELECT c.category_name,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
    FROM order_items AS oi
    JOIN products    AS p ON p.product_id  = oi.product_id
    JOIN categories  AS c ON c.category_id = p.category_id
    GROUP BY c.category_name
)
SELECT category_name,
       CAST(revenue AS DECIMAL(12,2))                              AS revenue,
       CAST(100.0 * revenue / SUM(revenue) OVER () AS DECIMAL(5,1)) AS pct_of_total,
       CAST(100.0 * SUM(revenue) OVER (ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING)
            / SUM(revenue) OVER () AS DECIMAL(5,1))                 AS cumulative_pct
FROM cat
ORDER BY revenue DESC;
```

| category_name | revenue | pct_of_total | cumulative_pct |
|---|---|---|---|
| Laptops | 13223.35 | 48.3 | 48.3 |
| Smartphones | 5874.55 | 21.5 | 69.7 |
| Monitors | 3719.10 | 13.6 | 83.3 |
| Audio | 2053.85 | 7.5 | 90.8 |
| Storage | 1311.00 | 4.8 | 95.6 |
| Peripherals | 1200.00 | 4.4 | 100.0 |

💡 **Two different windows in one `SELECT`.** `SUM(revenue) OVER ()` — no `ORDER BY`, no frame — is the
grand total on every row. `SUM(revenue) OVER (ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING)` is the
running total. Being able to read the difference between those two `OVER` clauses is the single most
useful window-function skill.

💡 This is a **Pareto chart**: the top two categories account for 69.7% of revenue. That is the
question a business actually asks, and it is one query away.

---

**30. Customers whose spend is above the overall customer average.**

```sql
-- ✅ Works in BOTH
WITH spend AS (
    SELECT c.customer_id, c.full_name,
           SUM(oi.unit_price * oi.quantity * (1 - oi.discount)) AS total
    FROM customers   AS c
    JOIN orders      AS o  ON o.customer_id = c.customer_id
    JOIN order_items AS oi ON oi.order_id   = o.order_id
    GROUP BY c.customer_id, c.full_name
)
SELECT full_name, CAST(total AS DECIMAL(12,2)) AS total
FROM spend
WHERE total > (SELECT AVG(total) FROM spend)
ORDER BY total DESC;
```

| full_name | total |
|---|---|
| Mei Chen | 7976.45 |
| John Baker | 4040.15 |
| Fatima Al-Sayed | 3459.20 |
| Grace Adeyemi | 3388.00 |
| Kenji Watanabe | 2887.65 |
| Amara Silva | 2423.00 |

⚠️ **"Average customer spend" is not `AVG(oi.unit_price * …)`.** You must aggregate **per customer
first**, then average those totals. Averaging the line items directly gives the average *line value*,
a completely different number. Naming the CTE `spend` and reusing it twice makes the intent
unmistakable.

💡 **A CTE can be referenced more than once in the same statement** — here in the `FROM` and again in
the subquery. Whether the engine evaluates it once or twice is its choice; if the cost matters,
check the execution plan ([§47](#47-execution-plans)).

</details>

<details>
<summary><b>Level 4 — Advanced (31–40)</b></summary>

These ten are **build exercises** rather than single queries: each asks you to design a procedure, a
trigger, an index, or a dimension table, and there are several defensible answers to every one. Rather
than a single "right" solution, use the chapter that covers each and the checklist in
[§66.9](#669--the-professional-checklist) to grade your own work.

| # | Task | Read first | The thing to get right |
|:---:|---|---|---|
| 31 | Monthly revenue pivot, categories as columns | [§35](#35-pivot-and-unpivot) | MSSQL `PIVOT` needs a fixed column list; a dynamic one needs [§59](#59-dynamic-sql) |
| 32 | Every date in H1 2026 with zeros for quiet days | [§31](#31-ctes-and-recursive-queries) | A calendar table `LEFT JOIN`ed to sales — the zeros come from the join, not from the data |
| 33 | Average days between each customer's orders | [§34](#34-ranking-running-totals-and-moving-averages) | `LAG(order_date)` per customer, then average the differences; customers with one order yield `NULL` |
| 34 | Stored procedure placing an order atomically | [§37](#37-stored-procedures), [§42](#42-transactions-and-acid) | One transaction, stock checked **and** decremented inside it, `TRY…CATCH` with `ROLLBACK` |
| 35 | Trigger logging every price change | [§39](#39-triggers) | Triggers fire **per statement, not per row** — use `inserted`/`deleted`, never a scalar variable |
| 36 | Indexed view / summary table of category sales | [§36](#36-views), [§46](#46-indexes-the-complete-guide) | MSSQL indexed views need `SCHEMABINDING` and `COUNT_BIG(*)`; MySQL has no equivalent — use a summary table |
| 37 | Foreign key columns lacking an index | [§46](#46-indexes-the-complete-guide) | Query the system catalog; an unindexed FK makes parent deletes scan the child table |
| 38 | Safe dynamic search with four optional filters | [§59](#59-dynamic-sql), [§55](#55-sql-injection-and-how-to-stop-it) | **Parameterise every value.** `sp_executesql` with parameters, never string concatenation |
| 39 | SCD Type 2 on a customer dimension | [§53](#53-data-modeling-and-the-star-schema) | `valid_from` / `valid_to` / `is_current`; a change **closes** the old row and inserts a new one |
| 40 | Tune your three slowest queries | [§47](#47-execution-plans), [§48](#48-query-optimization-and-sargability) | Measure **before** and **after**; a change you did not measure is not a tuning |

> 🎓 **The honest standard for Level 4:** your answer is good if it survives being run twice, handles
> the empty case, and does not corrupt data when a concurrent session runs it at the same moment.
> That last one is what separates exercise SQL from production SQL.

</details>

---

## 66.5 🎓 The capstone project: build a complete system

> [!IMPORTANT]
> 🎯 **Goal:** design, build, populate, query, secure, and tune a full database from scratch. This is the exercise that turns knowledge into skill.

### 📚 The brief: a Library Management System

A city library needs a database. The requirements:

- The library holds **titles** (a book, identified by ISBN) and multiple physical **copies** of each.
- **Members** join, have a membership tier, and can be suspended.
- A member **borrows** a copy for 14 days and may renew twice.
- Overdue items accrue a **fine** of 0.50 per day, capped at the item's replacement cost.
- Members can **reserve** a title that is fully out on loan, joining a queue.
- Books have **authors** (a book may have several; an author writes several books) and belong to **genres**.
- **Staff** process loans and returns; each has a role and a branch.
- The library has multiple **branches**; copies belong to a branch and can be transferred.
- Management needs reports: most-borrowed titles, overdue lists, member activity, branch comparison, fine revenue.

### 📋 Your deliverables

| Phase | Deliverable |
|---|---|
| **1. Design** | An ER (entity-relationship) diagram; a 3NF logical model; every relationship identified (note the many-to-many ones) |
| **2. Build** | `CREATE TABLE` scripts for both MSSQL and MySQL, with all constraints named by convention |
| **3. Populate** | Seed data: 6 branches, 20 staff, 200 members, 300 titles, 800 copies, 2000 loans spanning 2 years |
| **4. Query** | The 10 reports listed below |
| **5. Objects** | 3 views, 3 stored procedures, 1 trigger, 2 functions |
| **6. Integrity** | Transactions for borrow/return; correct handling of the reservation queue |
| **7. Performance** | Index strategy with justification; plans before and after for 3 slow queries |
| **8. Security** | Roles for member-facing app, librarian, manager, and reporting; least privilege applied |
| **9. Operations** | Backup strategy meeting a 15-minute RPO; a written restore runbook |
| **10. Analytics** | A star schema for loan analysis, loaded from the operational tables |

### 📊 The 10 required reports

1. Titles currently on loan, with borrower and due date.
2. Overdue loans with the fine accrued to date.
3. Top 20 most-borrowed titles in the last 12 months.
4. Members who have never borrowed anything.
5. Branch comparison: loans, unique members, average loan duration.
6. Monthly loan volume with a 3-month moving average.
7. The reservation queue per title, in position order.
8. Members with outstanding fines above 10.00.
9. Author popularity: total loans across all their titles.
10. Copies not borrowed in over 2 years (candidates for withdrawal).

### 🎯 The self-assessment

> **You have genuinely completed this project when you can:**
>
> - ☑️ Explain every design decision, including the ones you rejected
> - ☑️ Show that no business rule can be broken by raw SQL, not just by the app
> - ☑️ Point at each index and name the query it serves
> - ☑️ Restore the database to a point in time from your own runbook
> - ☑️ Hand the schema to another developer who can use it without asking you questions

---

## 66.6 📅 Your 35-day learning plan

| Days | Focus | Chapters | Daily goal |
|:---:|---|---|---|
| **1** | Setup and orientation | 1–4 | Both engines installed; ShopDB built and verified |
| **2–3** | Query fundamentals | 5, 13, 14 | Write 20 `SELECT`s from memory |
| **4** | NULL and sorting | 15, 16, 17 | Understand three-valued logic (TRUE, FALSE, UNKNOWN) completely |
| **5–6** | Data types and tables | 6, 7, 8 | Design and build a 5-table schema of your own |
| **7** | Constraints | 9, 10, 11 | Every constraint type used and deliberately broken |
| **8–9** | Writing data | 12, 18, 19 | Insert, update, delete safely inside transactions |
| **10–11** | Functions | 20, 21, 22, 23 | Build a data-cleaning query and a date report |
| **12** | Conditional logic | 24 | Master conditional aggregation |
| **13–14** | Aggregation | 25, 26, 27 | Answer 10 real business questions |
| **15–17** | 🔥 **Joins** | 28, 29 | All join types; deliberately hit and fix every trap |
| **18–19** | Subqueries and CTEs | 30, 31, 32 | Write a recursive org chart from scratch |
| **20–22** | 🔥 **Window functions** | 33, 34, 35 | Top-N per group, running totals, LAG/LEAD, pivots |
| **23** | Views and procedures | 36, 37 | Build a view layer and 3 procedures |
| **24** | Functions and triggers | 38, 39, 40, 41 | Build an audit trail |
| **25** | Transactions | 42, 43, 44, 45 | Reproduce a deadlock; write retry logic |
| **26–27** | 🔥 **Performance** | 46, 47, 48, 49, 50 | Read 10 execution plans; tune 5 queries |
| **28** | Design | 51, 52, 53 | Normalize a messy schema to 3NF; build a star schema |
| **29** | Security and operations | 54, 55, 56, 57 | Set up roles; take and restore a backup |
| **30** | Modern data | 58, 59 | JSON queries; rewrite a cursor as a set operation |
| **31** | Text and time | 60, 61 | Break a column with the wrong collation; build a per-user local-time report |
| **32** | History and change | 62 | Make a table temporal; reconstruct it as of last Tuesday |
| **33** | Concurrency | 63 | Reproduce a lost update, then fix it three different ways |
| **34** | Engineering practice | 64, 65 | Build a migration runner; find and fix an N+1 |
| **35** | Review | 66 | Anti-patterns, the question bank, start the capstone |

> [!TIP]
> 💡 **How to actually make this work:**
> - **Type every example by hand.** Copy-paste teaches your clipboard, not you.
> - **Break things deliberately.** Then read the error message properly. Errors are the fastest teacher in SQL.
> - **Keep a personal snippets file.** Every time you solve something, save the query with a one-line comment.
> - **The 🔥 days are the ones that matter most.** Joins, window functions, and performance are what separate someone who "knows SQL" from someone who is genuinely good at it. Spend extra time there without guilt.

---

## 66.7 📖 Glossary

| Term | Meaning |
|---|---|
| **ACID** | Atomicity, Consistency, Isolation, Durability — the four transaction guarantees |
| **Aggregate** | A function collapsing many rows into one value (`SUM`, `COUNT`, `AVG`) |
| **Allow-list** | A fixed list of permitted values (such as column names) that user input is checked against |
| **Anti-join** | Finding rows with *no* match (`LEFT JOIN ... IS NULL` or `NOT EXISTS`) |
| **API** | *Application programming interface* — the agreed way one program asks another for data or actions |
| **Backfill** | Populating a newly added column for existing rows — a batch job, not a migration |
| **Batch** | A group of SQL statements sent to the server together; in MSSQL, `GO` separates batches |
| **B-tree** | The balanced tree structure behind almost every index |
| **Cardinality** | The number of distinct values in a column; also the estimated row count |
| **Cartesian product** | Every row of A paired with every row of B — usually an accident |
| **Change Tracking / CDC** | Engine features that record which rows changed (and, for CDC, their old and new values) |
| **CI** | *Continuous integration* — automatically testing every change as soon as it is saved |
| **Clustered index** | The table itself, physically ordered by the index key |
| **Collation** | The rules deciding how text sorts and compares — case, accents, and language order |
| **Column** | One fact stored for every row, such as `email` |
| **Connection pool** | A set of open database connections an application reuses, instead of opening a new one per request |
| **Covering index** | An index containing every column a query needs, so the table is never read |
| **CRUD** | Create, Read, Update, Delete |
| **CSV** | A plain text file with one row per line and commas between values — opens in Excel |
| **CTE** | Common Table Expression — a named subquery defined with `WITH` |
| **Database** | The whole organized container of tables — `ShopDB` in this guide |
| **DBA** | Database administrator — the person who keeps databases running, safe, and fast |
| **DDL / DML / DQL / DCL / TCL** | The five command families (Chapter 2) |
| **Deadlock** | Two transactions each blocking the other; the engine kills one |
| **Denormalization** | Deliberately duplicating data to speed up reads |
| **Dirty read** | Reading uncommitted data that may be rolled back |
| **DMV** | *Dynamic management view* — a built-in MSSQL system view that reports what the server is doing |
| **DST** | Daylight saving time — clocks moving forward or back one hour each year |
| **Engine** | The database software itself — here, SQL Server or MySQL |
| **ETL** | Extract, transform, load — copying data out of one system, cleaning it, and loading it into another |
| **Execution plan** | The engine's chosen strategy for running a query |
| **Expand–contract** | Splitting a breaking schema change into additive, migrate, and remove phases |
| **Fact / dimension table** | The measurement table and its descriptive lookups in a star schema |
| **Fan-out** | Row multiplication caused by joining two one-to-many children |
| **Foreign key** | A column referencing a key in another table |
| **GUID / UUID** | A long random ID that is unique across every computer, e.g. `3f2504e0-4f89-11d3-9a0c-0305e82c3301` |
| **Heap** | A table with no clustered index |
| **Idempotent** | Safe to run more than once — the second run changes nothing |
| **Index** | A sorted lookup structure that finds rows fast, like the index at the back of a book |
| **Index seek / scan** | Jumping to specific rows vs reading everything |
| **InnoDB** | MySQL's default storage engine — the part that actually stores the data. Always use it |
| **Isolation level** | How much concurrent interference a transaction tolerates |
| **JSON** | A text format for structured data, e.g. `{"name": "Amara", "city": "Colombo"}` |
| **Key lookup** | Going back to the table because the index lacked a needed column |
| **Latency** | Waiting time — how long one request takes |
| **Lost update** | Two writers both save, and one silently overwrites the other. No error is raised |
| **Migration** | A versioned script, kept in Git, that changes the database structure (Chapter 64) |
| **MVCC** | Multi-Version Concurrency Control — readers see a snapshot, so they never block writers |
| **N+1** | One query for a list, plus one more per row returned — an application-side performance bug |
| **Normalization** | Structuring tables so each fact is stored exactly once |
| **NULL** | "No value / unknown" — not zero and not an empty string (Chapter 15) |
| **OLTP / OLAP** | Transaction processing (many small writes) vs analytical processing (large reads) |
| **Optimistic concurrency** | Detecting a conflict at write time with a version token, instead of locking |
| **ORM** | A code library that writes SQL for your application, e.g. Entity Framework or Hibernate |
| **Page** | The fixed-size block that data is stored in — 8 KB in SQL Server, 16 KB in MySQL |
| **Parameter sniffing** | Reusing a cached plan built for an unrepresentative parameter value |
| **Partitioning** | Splitting one table into physical pieces by a key |
| **Percentile** | The value below which a given fraction of rows fall — P50 is the median |
| **Pessimistic concurrency** | Locking a row at read time so nobody else can change it |
| **Phantom read** | New rows appearing between two identical queries in one transaction |
| **Predicate** | A condition that is true or false for each row, e.g. `country = 'UK'` in a `WHERE` |
| **Primary key** | The unique, non-null identifier of a row |
| **Query** | A question (or instruction) you send to the database, written in SQL |
| **Query Store** | 🟥 On-disk history of queries, plans, and runtime statistics, surviving restarts |
| **RBAR** | "Row By Agonizing Row" — the anti-pattern of looping instead of set operations |
| **Referential integrity** | The guarantee that every foreign key points at a row that exists |
| **Replica** | A copy of a database, kept up to date, on another server |
| **Row** | One single item in a table, such as one customer |
| **ROWVERSION** | 🟥 An 8-byte value the engine increases on every update — the standard optimistic-concurrency token |
| **RPO / RTO** | How much data you can lose / how long you can be down |
| **SARGable** | A condition that can use an index to jump straight to the matching rows |
| **Savepoint** | A bookmark inside a transaction that you can roll back to without undoing everything |
| **SCD** | Slowly Changing Dimension — how a data warehouse handles changing attributes |
| **Schema** | The structure of a database; in MSSQL, also a named container for objects |
| **Session** | Your connection to the database — settings and temporary tables belong to it |
| **Set-based** | Operating on whole sets of rows at once, the way SQL is designed to work |
| **Sharding** | Splitting data across separate servers |
| **SQL** | *Structured Query Language* — the language used to talk to relational databases |
| **Star schema** | A central fact table surrounded by flat dimension tables |
| **Statistics** | Summary data about value distribution, used by the optimizer |
| **Stored procedure** | A saved, named SQL program that you run by name (Chapter 37) |
| **Subquery** | A query written inside another query |
| **Surrogate key** | A meaningless generated identifier (an `IDENTITY` / `AUTO_INCREMENT` ID) |
| **T-SQL** | *Transact-SQL* — Microsoft SQL Server's version of SQL |
| **Table** | One list of one kind of thing, in rows and columns — like a spreadsheet tab |
| **Temporal table** | 🟥 A table where the engine keeps every past version of every row automatically |
| **Throughput** | How much work gets done per second |
| **TLS** | Encryption for network connections — the padlock you see in a web browser |
| **Transaction** | A group of changes that all succeed or all fail |
| **Trigger** | Code that runs automatically on insert, update, or delete |
| **UDF / TVF** | User-defined function / table-valued function — your own function that returns one value, or a whole table (Chapter 38) |
| **Upsert** | Insert if new, update if existing |
| **UTC** | Coordinated Universal Time — the only sane thing to store in a timestamp column |
| **utf8mb4** | 🟦 MySQL's real UTF-8 charset. The one named `utf8` is a broken three-byte subset |
| **View** | A saved query that behaves like a table |
| **Window function** | A calculation across related rows that does not collapse them |
| **Write-ahead log** | Changes written to a log before the data files, guaranteeing durability |

---

## 66.8 🔗 Where to go next

### Official documentation

| Resource | What it is |
|---|---|
| **Microsoft Learn — SQL Server documentation** | The authoritative SQL Server reference (`learn.microsoft.com/sql`) |
| **MySQL Reference Manual** | The authoritative MySQL reference (`dev.mysql.com/doc`) |
| **Microsoft Learn — T-SQL reference** | Every function and statement, with examples |
| **MySQL Performance Blog (Percona)** | Deep, practical MySQL tuning |

### Tools worth learning

| Tool | Why |
|---|---|
| **SSMS / VS Code with the MSSQL extension** | The MSSQL workhorses (Azure Data Studio was retired in February 2026) |
| **MySQL Workbench** | Official MySQL GUI with an ER modeller |
| **DBeaver** | One client for both engines — ideal for this guide |
| **Percona Toolkit** | `pt-online-schema-change`, `pt-query-digest` — essential MySQL ops tooling |
| **Ola Hallengren's Maintenance Solution** | The community-standard MSSQL backup/index/check scripts |
| **Brent Ozar's First Responder Kit** | `sp_Blitz`, `sp_BlitzCache` — instant MSSQL health diagnosis |
| **Flyway / Liquibase** | Version-controlled database migrations ([Chapter 64](#64-database-devops-migrations-standards-and-testing)) |
| **sqlfluff** | A SQL linter and formatter for both engines — wire it into a pre-commit hook |
| **tSQLt** | The unit-testing framework for T-SQL |
| **gh-ost / pt-online-schema-change** | Online schema changes on large MySQL tables without locking |

### Topics beyond this guide

- **Columnstore indexes and data warehousing** for large-scale reporting
- **In-Memory OLTP** (MSSQL) for extremely fast writes
- **Replication and high availability** — Always On availability groups, MySQL group replication
- **PostgreSQL** — the third engine every SQL professional should meet
- **Cloud databases** — Azure SQL, Amazon RDS/Aurora, Google Cloud SQL
- **Data engineering** — dbt, Airflow, Snowflake, BigQuery (all SQL-first)
- **Change-data streaming** — Debezium, Kafka Connect, and event-driven architectures

---

## 66.9 ✅ The professional checklist

**Print this. Run through it before any schema goes to production.**

<details>
<summary><b>📐 Design</b></summary>

- ☐ Every table has a primary key
- ☐ Primary keys are narrow, stable, and never updated
- ☐ Every relationship has a foreign key constraint
- ☐ Every foreign key column is indexed (**especially MSSQL**)
- ☐ Naming convention documented and applied consistently
- ☐ `NOT NULL` by default; every nullable column justified
- ☐ Money is `DECIMAL`; dates are UTC; phones are strings
- ☐ No comma-separated lists, no `col1`/`col2`/`col3`
- ☐ Business rules enforced by constraints, not only in the app
- ☐ Denormalized values have maintenance **and** verification scripts
- ☐ Soft-delete strategy decided and applied consistently
- ☐ Collation and character set chosen deliberately, before the first row
- ☐ Every timestamp column stores UTC, and its name says so

</details>

<details>
<summary><b>✍️ Queries</b></summary>

- ☐ No `SELECT *` in application code
- ☐ All conditions SARGable (index-friendly)
- ☐ Explicit `JOIN ... ON`, never comma joins
- ☐ `LEFT JOIN` conditions in the right clause
- ☐ No `DISTINCT` masking a join problem
- ☐ `NOT EXISTS` instead of `NOT IN` on subqueries
- ☐ Date ranges use the half-open pattern
- ☐ `ORDER BY` present wherever order matters
- ☐ Deep paging uses keyset, not `OFFSET`
- ☐ Large writes are batched
- ☐ No `COLLATE` or time-zone conversion applied to an indexed column in `WHERE`
- ☐ Concurrent writes use a guarded `UPDATE` or a version token, never read-then-write

</details>

<details>
<summary><b>⚡ Performance</b></summary>

- ☐ Slow queries identified from real measurements, not guesswork
- ☐ Execution plans reviewed for the top 10 queries
- ☐ No unused indexes; no redundant duplicates
- ☐ Statistics updated on a schedule
- ☐ Estimated vs actual row counts checked on critical queries
- ☐ A performance baseline captured, so you can tell what "slow" means
- ☐ 🟥 Query Store enabled, and confirmed still `READ_WRITE`
- ☐ Every forced plan recorded, with a reason and a review date
- ☐ Query count per application request logged, with an N+1 alert

</details>

<details>
<summary><b>🛡️ Security and operations</b></summary>

- ☐ Every query parameterized
- ☐ Least privilege applied; no app uses `sa`/`root`
- ☐ Permissions granted through roles
- ☐ Connections encrypted; sensitive data encrypted at rest
- ☐ Passwords hashed in the application
- ☐ Backups automated, monitored, off-site, and encrypted
- ☐ **A restore has actually been performed and timed**
- ☐ RPO and RTO agreed with the business
- ☐ Consistency checks (`DBCC CHECKDB` / `CHECK TABLE`) scheduled
- ☐ Monitoring and alerting configured for space, blocking, and backup failure
- ☐ Connection pool sized for the **server**, counting every service together
- ☐ Connect, command, and lock timeouts all set explicitly
- ☐ Retries cover only transient errors, with backoff and jitter
- ☐ Anything a client can retry has an idempotency key

</details>

<details>
<summary><b>🚚 Delivery</b></summary>

- ☐ Every schema change is a versioned script in Git
- ☐ Migrations are immutable once merged, idempotent, and checksummed
- ☐ Breaking changes go through expand–contract, never one step
- ☐ Migrations tested against a **restored production copy**, and timed
- ☐ Constraint and regression tests run in CI
- ☐ Naming and formatting conventions documented and linted automatically
- ☐ Nobody does routine work in a production query window

</details>

---

<div align="center">

## 🎓 You made it

</div>

You started this guide not knowing what a row was. You now know how to **design** a schema that protects itself, **query** it in ways most developers never learn, **tune** it when it slows down, **secure** it against the attacks that break real companies, and **restore** it when the worst happens.

> ### The five things worth remembering above all else
>
> 1. 🧠 **Think in sets, not loops.** This is the mindset shift that changes everything.
> 2. 🛡️ **Let the database protect your data.** Constraints do not have bad days; application code does.
> 3. 📏 **Measure before you optimize.** Read the plan. Guessing wastes days.
> 4. 🔒 **Parameterize everything, always.** There is no acceptable exception.
> 5. 💾 **A backup you have not restored is not a backup.**

A beginner asks: *"How do I write this query?"*

A professional asks: *"What question is the business really asking? What must always be true about this data? How will this behave at a thousand times the volume? What happens when two people do this at once? And how do I get it back if it goes wrong?"*

That shift — from **syntax** to **responsibility** — is the whole journey. This guide exists to make it as short as possible.

Now close the guide, open a query window, and go build something. 🚀

---

<div align="center">

**The Complete SQL Guide — MSSQL & MySQL**
*By Gehan Fernando*

*Read it once. Use it forever. Break things on purpose.*

</div>
