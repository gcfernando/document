---
name: documentation-validator
description: Checks a Markdown repository for broken internal links and broken heading anchors, using GitHub's actual slug rules (emoji-prefixed headings keep a leading hyphen). Use when a user asks to validate docs, check for broken links, or audit Markdown cross-references before publishing.
compatibility: Requires Python 3 on PATH for the optional helper script; otherwise can be done by reasoning alone on small repos.
metadata:
  category: documentation-qa
---

# Documentation Validator

A small, honest skill: most "link checkers" get GitHub's heading-slug rule subtly wrong. This skill exists
to get it right.

## When to use this skill

- Before publishing or merging a large Markdown-only repository (like this one).
- When a user reports "that link doesn't work" in a `.md` file.
- As a pre-flight check after renaming headings or files.

## The rule that most link checkers get wrong

GitHub's heading-to-anchor slug algorithm is:
1. Lowercase the heading text.
2. Strip every character that is not a letter, digit, underscore, hyphen, or space.
3. Replace spaces with hyphens.

Step 2 does **not** trim the string afterward. An emoji-prefixed heading like `## 🚀 Setup` becomes, after
stripping the emoji, `" Setup"` (leading space preserved) — lowercased to `" setup"` — then
space-to-hyphen gives `-setup`, **not** `setup`. The real anchor is `#-setup` with a leading hyphen. This
single detail is the most common source of false "broken anchor" reports in emoji-heavy documentation.

## Procedure

1. Collect every Markdown link in the repo: `[text](target)`, including same-file anchors (`#heading`)
   and cross-file anchors (`other-file.md#heading`).
2. For each file, derive every heading's real anchor using the rule above — do not trim leading hyphens.
3. For each link, verify:
   - If the target has a file part, that file exists.
   - If the target has an anchor part, that anchor exists in the target file's derived anchor set (or
     matches an explicit `<a id="...">` in that file, which always takes precedence over a derived slug).
4. Report only genuine mismatches. Common false positives to rule out before reporting a break:
   - Content inside fenced code blocks that merely *looks like* a Markdown link (e.g. `Box[int](100)` in a
     Python snippet) — these are not links at all.
   - Headings that already carry an explicit `<a id="...">` anchor, which overrides the derived slug.
5. Summarize: total links checked, total headings indexed, and a short list of real issues (file + line).

## Security note

This skill is read-only by design — it inspects files and reports findings, and should not need shell
execution beyond a simple text/regex pass. If you add an automated script step, keep it read-only (no
file writes, no network access) and still don't pre-approve `shell`/`bash` tools for this skill unless you
trust its source and have read the script yourself.
