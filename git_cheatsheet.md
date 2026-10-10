# 🌿 Git Command Cheat Sheet

[![Git](https://img.shields.io/badge/Git-Version%20control-F05032?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/docs)
[![Safety](https://img.shields.io/badge/Safety-Recover%20before%20resetting-F59E0B?style=for-the-badge)](#-safety)
[![Reference](https://img.shields.io/badge/Reference-Command%20catalog-0EA5E9?style=for-the-badge)](#-everyday-command-cards)

> Official command reference: [git-scm.com/docs](https://git-scm.com/docs). Git has a working tree, staging area (index), commits, refs, and remotes. Prefer `git switch`/`git restore` over legacy `git checkout` for everyday branch/file operations.

> [!TIP]
> **🎨 Visual legend:** 🟢 everyday command · 🟡 collaboration practice · 🔴 expert/recovery operation · 💻 copyable command · 🔍 option behavior · 💡 safer habit · ⚠️ history- or file-destructive action.

## 📚 Contents
- [🚀 Essential command cards](#-essential-command-cards)
- [🧩 Everyday command cards](#-everyday-command-cards)
- [🌳 Collaboration and recovery](#-collaboration-and-recovery)
- [🏷️ Releases and tags](#️-releases-and-tags)
- [🛠️ Advanced workflows](#️-advanced-workflows)

## 🚀 Essential command cards

The complete command catalog follows; every displayed command includes its use and copyable syntax.

| Command | 📖 Purpose / 🎯 when | 💻 Example | 🔍 Note |
|---|---|---|---|
| `git status` | Show staged/unstaged/untracked state. | `git status` | Run before every risky action. |
| `git add` | Stage selected changes. | `git add src/app.cs` | Use `-p` to review hunks. |
| `git commit` | Record staged snapshot. | `git commit -m "Add health endpoint"` | Write imperative messages. |
| `git log` | Inspect history. | `git log --oneline --graph --all` | Great branch visualizer. |
| `git diff` | Compare changes. | `git diff --staged` | Default is unstaged only. |
| `git switch -c` | Create/switch branch. | `git switch -c feature/search` | Modern branch workflow. |
| `git fetch` | Download remote refs without changing current branch. | `git fetch origin` | Safe first sync step. |
| `git pull` | Fetch then integrate upstream. | `git pull --ff-only` | `--ff-only` avoids surprise merge commits. |
| `git push -u` | Publish/set upstream. | `git push -u origin feature/search` | Future `git push` can omit names. |
| `git merge` | Integrate a branch. | `git merge feature/search` | Resolve conflicts then commit. |
| `git rebase` | Replay commits on another base. | `git rebase origin/main` | Do not rewrite shared commits. |
| `git restore` | Discard/unstage selected changes. | `git restore --staged app.cs` | Preserve edits while unstaging. |
| `git revert` | Safely undo a published commit. | `git revert abc1234` | Creates a new inverse commit. |
| `git stash` | Temporarily shelve work. | `git stash push -u -m "WIP"` | Include untracked with `-u`. |
| `git tag` | Mark a release point. | `git tag -a v1.0.0 -m "Release v1.0.0"` | Prefer annotated release tags. |
| `git reflog` | Find previous ref positions. | `git reflog` | Recovery tool after reset/rebase. |
| `git worktree` | Use another checkout of same repo. | `git worktree add ../fix bugfix` | Enables parallel branches. |
| `git blame` | Attribute lines to commits. | `git blame src/app.cs` | Investigate context, not blame people. |
| `git bisect` | Binary-search a regression. | `git bisect start` | Mark known good/bad commits. |
| `git clean` | **⚠️** Remove untracked files. | `git clean -nd` | Dry-run first, always. |

## 🧩 Everyday command cards

> [!IMPORTANT]
> **🧭 Safe Git rhythm:** `status` → `diff` → selective `add` → `commit` → `fetch` → integrate → `push`. Read before rewriting history.

| Command | 📖 Description / 🎯 when | 💻 Example | 🔍 Flags and advice |
|---|---|---|---|
| `git config` | Reads/writes configuration; use once per machine/repo. | `git config --global user.name "Your Name"` | Also set `user.email`; `--list --show-origin` audits source. |
| `git init/clone` | Creates a repository or copies an existing one. | `git clone --recurse-submodules URL app` | `--recurse-submodules` initializes dependencies. |
| `git status/add/commit` | Inspects, stages, and commits work. | `git add -p; git commit -m "Fix validation"` | `add -p` avoids unrelated commits. |
| `git diff/show/log` | Compares work, displays an object, or searches history. | `git log --oneline --decorate --graph --all` | `git show TAG` inspects a release/tag. |
| `git switch/branch` | Switches/creates/lists/renames/deletes branches. | `git switch -c feature/api` | `git branch -d NAME` is safe; `-D` is **⚠️** force deletion. |
| `git remote` | Manages remote names/URLs. | `git remote add origin https://example.com/org/repo.git` | `git remote -v` verifies fetch/push URLs. |
| `git fetch/pull/push` | Downloads refs, integrates upstream, publishes refs. | `git pull --ff-only origin main` | `fetch` **does not update your current branch**. |
| `git merge` | Combines another branch into current. | `git merge --no-ff feature/api` | Fix conflict markers, `git add`, then `git commit`. |
| `git rebase` | Replays commits on a new base. | `git rebase -i HEAD~3` | Use `--continue`, `--skip`, or `--abort`; never rebase published shared work. |
| `git cherry-pick` | Applies selected commit(s). | `git cherry-pick abc1234` | Resolve then `--continue`; `--abort` restores pre-pick state. |
| `git restore/reset/revert` | Discards working/index changes, moves refs, or makes a reversal commit. | `git revert abc1234` | **⚠️** `reset --hard` discards work; use `revert` for shared history. |
| `git stash` | Stores/restores temporary changes. | `git stash push -u -m "WIP login"` | `list`, `show -p`, `pop`, `apply`, and `drop` manage entries. |
| `git grep/blame/bisect` | Searches tracked text, attributes lines, or finds a bad commit. | `git grep "TODO"` | `bisect reset` ends a bisect session. |
| `git clean` | **⚠️** Deletes untracked paths. | `git clean -nd` | Use dry-run `-n`; `-fd` removes directories too. |
| `git archive/bundle` | Creates source archive or portable repository bundle. | `git archive --format=zip -o app.zip v1.0.0` | `bundle create repo.bundle --all` supports offline transfer. |
| `git format-patch/am` | Exports/applies email-style commits. | `git format-patch -1 HEAD` | Apply with `git am 0001-*.patch`; use `--abort` if needed. |
| `git worktree` | Creates/removes parallel work directories. | `git worktree add ../hotfix hotfix/login` | `remove` deletes the worktree directory—confirm first. |
| `git submodule` | Manages nested repositories. | `git submodule update --init --recursive` | Commit `.gitmodules` and gitlink changes together. |
| `git sparse-checkout` | Checks out only selected paths. | `git sparse-checkout init --cone; git sparse-checkout set src docs` | Useful for monorepos; disable with `sparse-checkout disable`. |

## 🌳 Collaboration and recovery

> [!WARNING]
> **🧯 Recovery principle:** prefer `git revert` for published commits. Before `reset --hard`, preserve recoverable work with a commit, branch, patch, or stash.

| Scenario | Safe workflow |
|---|---|
| Start feature | `git switch main` (base), `git pull --ff-only` (sync), `git switch -c feature/name` (branch), then stage/commit/push. |
| Resolve merge conflict | `git status` (files), edit markers, `git add FILE` (mark resolved), `git commit` (complete merge); use `git merge --abort` to cancel. |
| Update own branch | `git fetch origin` (download), `git rebase origin/main` (replay local commits), resolve/`git rebase --continue`, then `git push --force-with-lease` only for your branch. |
| Undo published commit | `git show HASH` (inspect), `git revert HASH` (inverse commit), `git push` (share). |
| Recover after reset | `git reflog` (find previous HEAD), `git switch -c recovery HASH` (preserve it), then inspect/merge/cherry-pick. |
| Find regression | `git bisect start`, `git bisect bad`, `git bisect good TAG`, test each checkout and mark `good`/`bad`, then `git bisect reset`. |
| Review before cleanup | `git clean -nd` (preview), then only if correct `git clean -fd`; never run blindly. |
| Sign commits/tags | Configure `user.signingkey`, use `git commit -S` or `git tag -s`; verify with `git verify-commit`/`git verify-tag`. |
| GitHub Flow | Branch from `main`, small commits, push, open PR, review/CI, merge, delete branch, sync local `main`. |
| Trunk-based delivery | Keep short-lived branches, integrate frequently, protect `main`, use feature flags for incomplete work. |

## 🏷️ Releases and tags

> [!TIP]
> **🚀 Release habit:** tag a reviewed, synchronized commit; inspect the tag locally; then publish one explicit tag—not every local tag by accident.

### 🏷️ Create Annotated Release Tag

```bash
git tag -a v1.0.6 -m "Release v1.0.6"
```

**📖 Description:** Creates an annotated Git tag named `v1.0.6` on the current commit with the message `Release v1.0.6`.

**🎯 When to Use:** Mark a reviewed commit as an official application release.

**🔍 Explanation:** `tag` manages tags; `-a` creates an annotated tag; `v1.0.6` is the release version; `-m` supplies the annotation message.

### 🚀 Push Release Tag to Remote

```bash
git push origin v1.0.6
```

**📖 Description:** Publishes the local `v1.0.6` tag to the remote repository named `origin`.

**🎯 When to Use:** Publish a release version for other developers and CI/CD pipelines.

**🔍 Explanation:** `push` publishes refs; `origin` is the remote name; `v1.0.6` is the tag reference.

### 🔥 Complete Git Release Workflow

```bash
# Check the working tree and current branch
git status

# Fetch latest remote information
git fetch origin

# Inspect the commit to be tagged
git log -1 --oneline

# Create the annotated release tag
git tag -a v1.0.6 -m "Release v1.0.6"

# Inspect the tag
git show v1.0.6

# Push the tag to origin
git push origin v1.0.6

# Verify published remote tags
git ls-remote --tags origin
```

`git fetch origin` downloads remote information but does **not** automatically update the current branch. Review and synchronize the intended release commit before tagging it.

| Command | 📖 Description / 🎯 when | 💻 Example | 🔍 Note |
|---|---|---|---|
| `git tag` | Lists local tags; use to inspect releases. | `git tag --sort=-version:refname` | Sort newest semantic-looking versions first. |
| `git tag NAME` | Creates a lightweight pointer; use for temporary/local markers. | `git tag test-2026-10-10` | Prefer annotated tags for releases. |
| `git show TAG` | Inspects tag object and target commit. | `git show v1.0.6` | Confirm target before publishing. |
| `git push origin TAG` | Publishes one tag. | `git push origin v1.0.6` | Safer than indiscriminate tag pushes. |
| `git push origin --tags` | Publishes all local tags. | `git push origin --tags` | Review tags first; this can publish unintended tags. |
| `git fetch --tags` | Downloads tags from remote. | `git fetch origin --tags` | Does not change current branch files. |
| `git tag -d TAG` / `git push origin :refs/tags/TAG` | Deletes local / remote tag. | `git tag -d v1.0.6` | **⚠️** Coordinate before deleting published release tags. |
| `git tag -s` / `git verify-tag` | Creates/verifies signed tag. | `git verify-tag v1.0.6` | Requires configured signing key/trust. |

## 🛠️ Advanced workflows

> [!NOTE]
> **🔬 Advanced commands are powerful inspection tools.** Use them to understand repository state, not as shortcuts around review, backups, or team process.

- **Aliases:** `git config --global alias.lg "log --oneline --graph --decorate --all"` creates `git lg`; use aliases for inspection, not to hide dangerous operations.
- **Internal inspection:** `git cat-file -t HASH` identifies object type; `git cat-file -p HASH` prints it. Use for forensic learning, not ordinary workflow.
- **Reference maintenance:** `git fsck` verifies object connectivity; `git gc` optimizes local storage. Avoid running maintenance blindly on shared/network filesystems.
- **Authentication:** use SSH keys or credential managers; never commit tokens. Audit accidental exposure immediately, rotate the secret, then follow approved history-remediation procedures.

## 🔗 Official documentation

- [Git documentation](https://git-scm.com/docs)
- [Git command categories](https://git-scm.com/docs/git#_git_commands_by_category)
- [Git tags](https://git-scm.com/docs/git-tag)
- [Git worktree](https://git-scm.com/docs/git-worktree)
- [Git submodule](https://git-scm.com/docs/git-submodule)

## ➕ Additional Git command cards

| Command | 📖 Description / 🎯 when | 💻 Usage example | 🔍 Notes |
|---|---|---|---|
| `git ls-files` | Lists index-tracked paths; use to verify whether Git tracks a file. | `git ls-files src` | `--others --exclude-standard` lists untracked, non-ignored files. |
| `git ls-tree` | Lists a commit/tree's paths; use to inspect a historical snapshot without checkout. | `git ls-tree -r --name-only HEAD` | `HEAD:path` addresses a specific historical path. |
| `git show-ref` | Lists local refs and object IDs; use for ref troubleshooting. | `git show-ref --heads --tags` | Read-only inspection command. |
| `git rev-parse` | Resolves revision/path information; use in scripts. | `git rev-parse --show-toplevel` | Confirms the repository root. |
| `git shortlog` | Groups commits by author; use for release acknowledgements. | `git shortlog -sne v1.0.0..HEAD` | Range controls the release window. |
| `git describe` | Names a commit relative to reachable tags; use for build version strings. | `git describe --tags --always` | Annotated tags are normally preferred. |
| `git ls-remote` | Lists remote refs without cloning/fetching; use to verify published tags/branches. | `git ls-remote --tags origin` | Reads remote metadata only. |
| `git remote set-url` | Changes a remote URL; use after repository migration. | `git remote set-url origin NEW_URL` | Verify with `git remote -v`. |
| `git remote prune` | Removes stale remote-tracking refs; use after remote branch cleanup. | `git remote prune origin` | Review `git remote show origin` first. |
| `git merge-base` | Finds a best common ancestor; use in advanced comparisons/scripts. | `git merge-base main feature/api` | Helpful for three-dot diff reasoning. |
| `git range-diff` | Compares two patch series; use after rebasing a review branch. | `git range-diff origin/main...HEAD@{1} origin/main...HEAD` | Advanced review aid; verify revisions carefully. |
| `git notes add` | Adds non-commit metadata; use for local/review annotations. | `git notes add -m "Reviewed" HEAD` | Notes are separate refs and must be pushed explicitly. |
| `git replace` | Locally substitutes object ancestry; use for advanced history experiments. | `git replace OLD NEW` | **⚠️** Expert-only; replacements affect local history views. |
| `git maintenance run` | Performs configured repository maintenance; use for large active repos. | `git maintenance run --auto` | Modern alternative to manually scheduling common maintenance. |
