---
name: create-commit-and-pr
description: Create a Git feature branch, commit the requested changes, push it, and create or update a GitHub pull request. Use only when the user explicitly asks for this commit-and-PR workflow.
metadata:
  short-description: Commit changes and create or update a GitHub PR
---

# Create Commit and PR

Use this skill only when the user has explicitly requested the repository changes be committed, pushed to a remote, and submitted through GitHub as a pull request.

## Workflow

1. Inspect the repository before changing it. Read applicable `AGENTS.md` instructions, then check the current branch, remotes, worktree status, and the diff. Confirm that the repository has a GitHub remote and that the intended changes are identifiable.

   - Do not stage unrelated changes, secrets, credentials, `.env` files, or private machine-specific data. If the worktree mixes in-scope and unrelated changes and they cannot be separated safely, stop and ask the user.
   - If there are no relevant changes to commit, report that and stop.
   - Do not proceed from a detached `HEAD` when the PR base would be ambiguous.

2. Select the feature branch.

   - Record the current branch as the default PR base before switching.
   - Use a user-specified branch name exactly when one is provided. Otherwise choose a concise, descriptive kebab-case name beginning with `feature/`.
   - Never overwrite, delete, or force-recreate an existing branch. If the chosen name exists, use a non-conflicting name or stop for clarification.
   - If the current branch is already the relevant `feature/*` branch with an existing PR, reuse it instead of creating a nested feature branch. Otherwise create the feature branch from the recorded base branch without discarding worktree changes.

3. Review and commit the changes.

   - Inspect both the unstaged and staged diff before staging anything.
   - Use a concise imperative commit message. Follow a repository-specific convention when documented; otherwise use a Conventional Commit-style subject when it fits. Honor an exact message supplied by the user.
   - Stage only the files belonging to this task, using explicit paths. Run relevant documented checks when practical, and let commit hooks run normally.
   - Do not use `git reset --hard`, `git clean`, force pushes, history rewrites, hook bypasses, or branch deletion unless the user explicitly authorizes that exact action.

4. Push the feature branch.

   - Push to the repository's normal remote, usually `origin`, and set the upstream on the first push.
   - If authentication, permissions, network access, or remote selection prevents the push, stop and report the exact blocker without exposing credentials.

5. Create or update the pull request with GitHub CLI (`gh`).

   - Before creating a PR, look for an existing PR whose head branch is the feature branch. If one exists, do not create a duplicate: push the branch first, then update that PR's description (and title only when needed) while preserving its existing base unless the user requests otherwise.
   - If no PR exists, target the recorded base branch unless the user specified another base.
   - If `.github/PULL_REQUEST_TEMPLATE.md` exists in the repository, read it and use its structure for the PR body. Preserve required headings, checklists, and meaningful HTML comments; fill in the sections from the actual change and validation results. Do not invent test results.
   - Use a concise title that reflects the actual changes. Include the PR URL in the final report.

## Completion report

Report the feature branch, base branch, commit hash and message, push result, PR URL and whether the PR was created or updated, template usage, and checks run. If the workflow stops early, state what was completed and the precise next blocker.
