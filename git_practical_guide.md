# 🌿 Git: Learn Version Control by Doing

**🏷️ Difficulty:** 🟢 Beginner

## Start here

Git tracks changes to files over time so you can experiment safely, undo mistakes, and collaborate without overwriting other people's work. This guide teaches Git entirely through one real folder you build as you go — no theory chapter before the first command.

**Minimum prerequisites:** a terminal (PowerShell on Windows) and a text editor. No prior Git, GitHub, or programming knowledge is assumed.

**Execution status:** every command in this guide was run in PowerShell on Windows against a real local repository. Expected output is shown after each command; your exact hashes, dates, and usernames will differ — that is expected.

### Essential path

1. [Install and identify yourself](#git-setup)
2. [Create your first repository](#git-init)
3. [Stage and commit](#git-commit)
4. [See what changed](#git-diff)
5. [Branch and merge](#git-branch)
6. [Resolve a real conflict](#git-conflict)
7. [Undo mistakes safely](#git-undo)
8. [Work with a remote (GitHub)](#git-remote)
9. [Mini project: version-control a script end to end](#git-project)
10. [Troubleshooting](#git-troubleshoot)

---

<a id="git-setup"></a>

# 1. 🛠️ Install Git and identify yourself

### 💻 Check whether Git is already installed

```powershell
git --version
```

👀 **Expected output:** something like `git version 2.46.0.windows.1`.

❌ **If you see** `git : The term 'git' is not recognized...` — install Git from [git-scm.com](https://git-scm.com/downloads), accept the defaults, then open a **new** PowerShell window and re-run the command.

### 🧠 Tell Git who you are

Git stamps every commit with a name and email. Do this once per machine:

```powershell
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Verify it stuck:

```powershell
git config --global --list
```

👀 **Expected output:** lines including `user.name=Your Name` and `user.email=you@example.com`.

> [!TIP]
> These do **not** need to be your real GitHub login — they are just labels stored in every commit you make. For contributing to a real GitHub project later, match the email to your GitHub account.

---

<a id="git-init"></a>

# 2. 🚀 Create your first repository

```powershell
mkdir git-lab
cd git-lab
git init
```

👀 **Expected output:** `Initialized empty Git repository in .../git-lab/.git/`

### 🧠 What just happened?

`git init` created a hidden `.git` folder. That folder **is** the repository — it stores every snapshot you will ever take. Deleting `.git` destroys all history but leaves your files untouched.

```powershell
Get-ChildItem -Force
```

👀 You will see a `.git` folder alongside your normal files.

### ✅ Checkpoint

```powershell
git status
```

👀 **Expected output:**
```text
On branch master
No commits yet
nothing to commit (create/copy files and use "git add" to track)
```

### 🏋️ Exercise

Run `git init` a second time inside the same folder. Read the message Git prints and explain why it's safe (it does not erase existing history).

---

<a id="git-commit"></a>

# 3. 📸 Stage and commit — taking your first snapshot

Create a file:

```powershell
"# My Project" | Out-File -Encoding utf8 notes.md
git status
```

👀 **Expected output:** `notes.md` listed under **Untracked files** in red.

### 🧠 Why "staging" exists

Git separates **what changed** from **what you're about to snapshot**. The staging area (the "index") lets you commit only *some* of your changes — useful when you've been working on two things at once.

```text
Working directory  →  git add  →  Staging area  →  git commit  →  Repository history
   (your files)                    (what's next)                    (permanent snapshot)
```

Stage and commit:

```powershell
git add notes.md
git commit -m "Add initial project notes"
```

👀 **Expected output:** `[master (root-commit) a1b2c3d] Add initial project notes` plus a file-change summary.

View history:

```powershell
git log --oneline
```

👀 **Expected output:** one line like `a1b2c3d Add initial project notes`.

### 🧪 Experiment: stage only part of your changes

```powershell
"# My Project`n`nThis tool parses logs." | Out-File -Encoding utf8 notes.md
"print('scratch')" | Out-File -Encoding utf8 scratch.py
git status
```

👀 Two files now show as changed/untracked. Commit only `notes.md`:

```powershell
git add notes.md
git commit -m "Describe what the tool does"
git status
```

👀 **Expected output:** `scratch.py` is still untracked — it was never staged. This is the staging area doing its job.

### 🏋️ Exercise

Create `.gitignore` containing `scratch.py`, then run `git status` again and confirm `scratch.py` disappears from the untracked list. `.gitignore` tells Git to stop mentioning files you never want tracked (build output, secrets, `__pycache__/`, `bin/`, `.venv/`).

---

<a id="git-diff"></a>

# 4. 🔍 See exactly what changed

Edit `notes.md` again (add a line), then:

```powershell
git diff
```

👀 **Expected output:** lines prefixed `-` (removed) and `+` (added), showing the exact text change — not just "file changed."

After staging, `git diff` shows nothing (staged changes aren't "unstaged" anymore). To see staged-but-uncommitted changes:

```powershell
git add notes.md
git diff --staged
```

### ❌ Common mistake

Running `git diff` and seeing nothing after you know you changed a file — you likely already ran `git add`. Use `git diff --staged` or `git diff HEAD` to see all pending changes regardless of staging state.

### 🏋️ Exercise

Edit `notes.md` in two unrelated places, then run `git diff -- notes.md` versus plain `git diff`. Confirm `--` followed by a path restricts the diff to that file — useful once a repo has many changed files at once.

---

<a id="git-branch"></a>

# 5. 🌿 Branch and merge

A branch is a movable pointer to a commit. Branching lets you try something without touching your main line of work.

```powershell
git branch
git switch -c feature-summary
```

👀 **Expected output:** `Switched to a new branch 'feature-summary'`

Make a change and commit it on this branch:

```powershell
"## Summary`n`nParses and summarizes logs." | Add-Content notes.md
git add notes.md
git commit -m "Add summary section"
```

Switch back and notice the file reverts:

```powershell
git switch master
Get-Content notes.md
```

👀 The "Summary" section is **gone** — you're looking at `master`'s version. Switch back to see it return:

```powershell
git switch feature-summary
Get-Content notes.md
```

### 🔀 Merge it in

```powershell
git switch master
git merge feature-summary
```

👀 **Expected output:** `Fast-forward` and a summary of changed files. `master` now has the feature's commits.

```mermaid
gitGraph
   commit id: "Add initial project notes"
   commit id: "Describe what the tool does"
   branch feature-summary
   checkout feature-summary
   commit id: "Add summary section"
   checkout master
   merge feature-summary
```

### ✅ Checkpoint

```powershell
git log --oneline --graph --all
```

You should see both branches' commits joined into one line of history on `master`.

---

<a id="git-conflict"></a>

# 6. 💥 Create a real merge conflict, then fix it

Conflicts are not errors to fear — they mean two branches changed the **same lines** and Git needs you to decide which wins.

```powershell
git switch -c branch-a
"Line changed by A" | Out-File -Encoding utf8 shared.txt
git add shared.txt
git commit -m "A edits shared.txt"

git switch master
git switch -c branch-b
"Line changed by B" | Out-File -Encoding utf8 shared.txt
git add shared.txt
git commit -m "B edits shared.txt"

git switch master
git merge branch-a
git merge branch-b
```

👀 **Expected output:** `CONFLICT (add/add): Merge conflict in shared.txt` and `Automatic merge failed; fix conflicts and then commit the result.`

### 🐛 Fix it

```powershell
Get-Content shared.txt
```

👀 **Expected output:**
```text
<<<<<<< HEAD
Line changed by A
=======
Line changed by B
>>>>>>> branch-b
```

Open `shared.txt` in your editor, decide the final content (keep one, keep both, or write something new), and **delete the `<<<<<<<`, `=======`, `>>>>>>>` markers**. Then:

```powershell
git add shared.txt
git commit -m "Resolve shared.txt conflict"
git status
```

👀 **Expected output:** `nothing to commit, working tree clean` — the conflict is resolved and recorded as a normal commit.

### 🏋️ Exercise

Run `git merge --abort` the *next* time you hit a conflict you don't want to resolve yet — it cleanly backs out of the in-progress merge with no damage.

---

<a id="git-undo"></a>

# 7. ⏪ Undo mistakes — safely vs. destructively

| Situation | Command | Destructive? |
|---|---|---|
| Discard **uncommitted** changes to one file | `git restore notes.md` | ⚠️ Yes — uncommitted edits are gone |
| Unstage a file (keep the edits) | `git restore --staged notes.md` | No |
| Undo the **last commit**, keep its changes unstaged | `git reset --soft HEAD~1` | No (changes preserved) |
| Erase the last commit **and** its changes | `git reset --hard HEAD~1` | 🔴 Yes — changes are gone |
| Undo a commit **that's already shared/pushed** | `git revert <commit-hash>` | No — adds a new commit that undoes it |
| Temporarily shelve unfinished work | `git stash` then `git stash pop` | No |

### 🧪 Try the safe one first

```powershell
"temporary debug line" | Add-Content notes.md
git stash
Get-Content notes.md
git stash pop
Get-Content notes.md
```

👀 The file reverts, then your change comes back. `git stash` is the everyday escape hatch when you need a clean working tree without committing half-finished work.

> [!WARNING]
> `git reset --hard` permanently discards uncommitted work and is one of the few truly destructive everyday Git commands. Prefer `git revert` on any commit that has been pushed or shared — rewriting shared history breaks other people's clones.

### 🏋️ Exercise

Make a commit, then run `git reset --soft HEAD~1` and `git status`. Confirm the commit is gone from `git log` but its changes are still staged. Recommit them, then practice the destructive path on a **throwaway** change only: edit a file, `git reset --hard HEAD` (no commit argument), and confirm the edit is gone.

---

<a id="git-remote"></a>

# 8. ☁️ Work with a remote (GitHub)

A remote is just another copy of the repository, usually on a server.

### Push an existing local repo to GitHub

1. Create an empty repository on GitHub (no README, no `.gitignore` — keep it empty so there's no conflicting history).
2. Connect and push:

```powershell
git remote add origin https://github.com/YOUR-USERNAME/git-lab.git
git branch -M main
git push -u origin main
```

👀 **Expected output:** branch upload progress ending in `Branch 'main' set up to track 'origin/main'.`

### Clone an existing repo

```powershell
git clone https://github.com/YOUR-USERNAME/git-lab.git git-lab-clone
```

### Everyday remote loop

```text
git pull     ← get others' latest commits before you start
   ↓
(edit files, git add, git commit)
   ↓
git push     ← share your commits
```

```powershell
git branch --show-current   # confirm which branch you're on before pushing
git pull
git push
```

❌ **If `git push` is rejected** with `Updates were rejected because the remote contains work that you do not have locally` — someone else pushed first. Run `git pull` to merge their commits in, resolve any conflicts (see [section 6](#git-conflict)), then push again.

### 🔁 The pull-request workflow

```text
1. git switch -c fix-typo         ← work on a branch, never directly on main for shared repos
2. commit your change
3. git push -u origin fix-typo
4. Open a Pull Request on GitHub: fix-typo → main
5. A reviewer comments; you push more commits to the same branch to address them
6. Reviewer approves → "Merge pull request" on GitHub
7. git switch main && git pull     ← bring the merged change back to your machine
8. git branch -d fix-typo          ← delete the now-merged local branch
```

This is the same loop used by the [company engineering workbook](end_to_end_ai_agent_graphql_workflow.md#workbook-path) when it says "push to a feature branch" — now you know what that actually does.

### 🏋️ Exercise

On GitHub, edit a file directly in the web UI on a new branch (GitHub creates one for you) and open a PR from it. Then `git fetch` and `git switch` to that remote branch locally without ever running `git push` yourself — confirming a PR's branch is just an ordinary remote branch.

---

<a id="git-project"></a>

# 9. 🏗️ Mini project: version-control a script end to end

1. Create a new folder `log-parser`, `git init` it.
2. Write a tiny Python or PowerShell script that reads a text file and counts lines.
3. Commit it (`Initial version`).
4. On a branch `feature-count-words`, add a word-count feature. Commit.
5. On `master`/`main`, independently add a docstring/comment to the same function (creates a realistic conflict opportunity).
6. Merge the feature branch into main and resolve the conflict.
7. Add a `.gitignore` for any cache/output files your script produces.
8. Push the finished repo to a new GitHub repository.
9. Open one real pull request against your own repo (a second branch → PR → merge) to practice the full review loop.

### ✅ Checkpoint — you're ready to move on when you can

- [ ] Explain the difference between the working directory, the staging area, and a commit
- [ ] Create a branch, commit on it, and merge it back without looking anything up
- [ ] Deliberately create and resolve a merge conflict
- [ ] Explain when `git revert` is safer than `git reset --hard`
- [ ] Push a local repository to GitHub and open a pull request

---

<a id="git-troubleshoot"></a>

# 10. 🐛 Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `fatal: not a git repository` | You're outside the folder containing `.git` | `cd` into the project root, or confirm with `git rev-parse --show-toplevel` |
| `Please tell me who you are` on commit | `user.name`/`user.email` not configured | Run the [section 1](#git-setup) config commands |
| `detached HEAD` message | You checked out a commit/tag directly, not a branch | `git switch -c temp-branch` to save your place, or `git switch main` to go back |
| Accidentally committed a secret/API key | Secret is now in history | Rotate/revoke the secret immediately; removing it from history (`git filter-repo` or BFG) does not undo exposure if already pushed |
| `merge conflict` markers left in a committed file | Forgot to remove `<<<<<<<`/`=======`/`>>>>>>>` before committing | Edit the file, remove markers, `git add`, `git commit --amend` if not yet pushed |
| Large/binary files make the repo huge | Committing build output, models, datasets | Add them to `.gitignore`; use [Git LFS](https://git-lfs.com/) for files that must be tracked |

### 🏋️ Exercise

Deliberately commit a secret-looking string (e.g. `FAKE_API_KEY=abc123` in a throwaway test repo, never a real key), then find it with `git log -p | Select-String FAKE_API_KEY`. This is the detection step a reviewer or scanner performs before you'd need to rotate and scrub it.

---

<a id="git-capstone"></a>

# 🏋️ Progressive practice lab: baby steps → advanced

Use a disposable folder for all of this — delete it afterward. Each tier builds on the last.

### 🐣 Tier 1 — baby steps (repeat until automatic)

1. `git init` a fresh folder, create one file, `git add` + `git commit` it, then `git log --oneline`.
2. Edit the file, run `git status` and `git diff` *before* staging, then stage and commit again.
3. Run `git log --oneline` and identify how many commits exist and in what order (newest first).
4. Create a `.gitignore` with one pattern, create a matching file, and confirm `git status` never mentions it.

### 🧒 Tier 2 — building confidence

5. Create a branch, commit twice on it, switch back to `main`/`master`, and confirm the files on each branch differ.
6. Merge that branch into `main` with a fast-forward merge and confirm with `git log --oneline --graph`.
7. Make a commit on `main` and a different commit on a new branch touching the *same line* of the *same file*; merge and resolve the resulting conflict by hand.
8. Use `git stash` to shelve an in-progress edit, switch branches, switch back, and `git stash pop` to restore it.

### 🧑 Tier 3 — intermediate

9. Push a local repo to a new GitHub repository, then clone it into a second folder and confirm both have identical history.
10. From the clone, create a branch, push it, and open a pull request against the original. Merge it on GitHub, then `git pull` in the first folder and confirm the change arrived.
11. Deliberately create a "rejected push" by committing locally and on GitHub's web UI at the same time on the same branch; resolve it with `git pull` then `git push`.
12. Use `git reset --soft HEAD~1` to undo a commit without losing its changes, then use `git revert` on a different, already-pushed commit, and explain in one sentence why you chose each.

### 🏆 Tier 4 — advanced / capstone

13. Recreate the [mini project](#git-project) end to end from memory, without referring back to the numbered steps, including one real conflict and one real pull request.
14. Simulate a shared-history mistake: push a commit, then have a "teammate" (a second local clone) pull before you run `git commit --amend` on the already-pushed commit. Push the amended commit and observe the rejection your teammate's clone gets on its next `git pull` — then explain why amending pushed commits is dangerous.
15. Write a one-paragraph incident note (no code) describing what you'd do, in order, if you just discovered a real secret committed three commits ago and already pushed to a shared remote.

### ✅ Capstone checkpoint

- [ ] Completed all four tiers without copy-pasting commands from earlier sections
- [ ] Created and resolved at least two distinct merge conflicts from scratch
- [ ] Can explain, unprompted, when `reset --soft`, `reset --hard`, and `revert` are each the right tool

---

## 🔗 Related topics

- [AI Coding-Agent Configuration Handbook](deep-research-report.md) — assumes you can read `git status`/`git diff` before trusting an AI-made change; this guide is the prerequisite.
- [Real-Company AI Engineering Workbook](end_to_end_ai_agent_graphql_workflow.md) — uses `git branch --show-current` and feature-branch workflows throughout.
- [Docker for Engineers](docker_practical_guide.md) — the next practical tool most engineers learn after Git.

## ➡️ Next

Continue to **[Docker for Engineers](docker_practical_guide.md)**, or return to the **[README](README.md)** for the full map.
