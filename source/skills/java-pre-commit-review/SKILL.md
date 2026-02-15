---
name: java-pre-commit-review
description: Enforce Java coding standards on uncommitted changes, summarize diffs, generate commit message, then stage+commit only after explicit approval. Use when the user says things like "review my Java changes", "pre-commit review", "check my code before commit", or "commit my Java changes".
---

# Java Pre-Commit Review

## Overview
Review uncommitted Java changes against the project's coding standards, summarize the diff, propose a commit message, and stage+commit only after explicit user approval.

## Non-negotiable Constraints
- **Do NOT modify any code**. This is review + commit only.
- **Evaluate ONLY uncommitted changes** (git diff).
- **Standards file is authoritative**. If conflicts exist, follow the standards file.
- If any standards violations are found → **STOP** and output "FAIL" with exact violations.
- **Never run `git add` or `git commit`** unless user replies with exactly: `PROCEED_TO_COMMIT`
- If the diff is empty → STOP (nothing to commit).

## Workflow (mandatory)

### Phase 0 — Collect Evidence
Run these commands and capture outputs:

1. `git status --porcelain`
2. `git diff --name-only`
3. `git diff`
4. `git diff --staged`
5. Read the standards file content from the repo (see default guess order below)

#### Standards file discovery (default guess order)
1) `docs/dev-guidelines/java-coding-standards.md`
2) `CODING_STANDARDS.md`
3) `docs/CODING_STANDARDS.md`
4) `CONTRIBUTING.md`
5) `styleguide.md`

#### Guardrails
- If `git status --porcelain` is empty → output: "No uncommitted changes."
- If `git diff --staged` is non-empty → output a warning:
  "You already have staged changes; this workflow expects clean staging.
   Either unstage or confirm you want to include them."
  Then STOP unless user says they want to include staged changes.

### Phase 1 — Standards Compliance Gate (Blocking)

Compare the **changed lines** in `git diff` against the Java Coding Standards file.

#### Output format (strict)
- Overall status: PASS | FAIL
- If FAIL:
  - For each violation:
    - File:
    - Approx line(s) / hunk identifier:
    - Rule violated: (quote the exact rule line from standards file)
    - Why it violates:
    - Minimal fix suggestion (do NOT apply)

#### Gate behavior
- If FAIL → STOP after listing violations.
- If PASS → continue.

### Phase 2 — Summarize Uncommitted Changes

Create a concise summary from the diff.

#### Output format
**Summary (max 5 bullets)**
- Intent:
- Key changes:
- Behavior changes (explicit):
- Affected modules/components:

**Risk**
- Level: LOW | MEDIUM | HIGH
- Why:
- Suggested quick verification (1–3 checks/tests):

### Phase 3 — Propose Commit Message

Generate a commit title + body using the summary.

#### Rules
- Title ≤ 72 chars
- Prefer Conventional Commits if repo uses it (infer from history if available; otherwise use generic).
- Body includes:
  - What changed
  - Why
  - Risk/verification note if relevant

#### Output format
**Proposed commit**
Title: `<...>`
Body:
- `<...>`
- `<...>`

Then ask:
"Reply exactly `PROCEED_TO_COMMIT` to stage and commit, or tell me what to change."

### Phase 4 — Stage + Commit (Only after explicit approval)

#### Preconditions
- User replied exactly: `PROCEED_TO_COMMIT`
- No standards violations
- Diff is not empty

#### Commands
1) `git add -A`
2) `git status --porcelain`
3) `git commit -m "<TITLE>" -m "<BODY>"`

#### Output
- Show commit hash and `git status --porcelain` after commit
- If commit fails, print the error and STOP (do not retry automatically)

## Failure Policy
- If standards file cannot be found → STOP and ask user to provide the path.
- If any command output is truncated/too large → ask to rerun with file-level diffs or provide specific files.
- If uncertain whether a rule applies → mark as "Potential violation" and STOP (do not guess).
