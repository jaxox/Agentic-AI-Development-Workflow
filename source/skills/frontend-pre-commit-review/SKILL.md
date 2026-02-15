---
name: frontend-pre-commit-review
description: Enforce frontend coding standards on uncommitted changes, run type-check + lint + E2E tests, summarize diffs, generate commit message, then stage+commit only after explicit approval. Use when the user says things like "review my frontend changes", "frontend pre-commit", "check my React code before commit", or "commit my frontend changes".
---

# Frontend Pre-Commit Review

## Overview
Review uncommitted frontend changes against project coding standards and UI rules, run automated quality gates (TypeScript, lint, unit tests, E2E), summarize the diff, propose a commit message, and stage+commit only after explicit user approval.

## Non-negotiable Constraints
- **Do NOT modify any code**. This is review + commit only.
- **Evaluate ONLY uncommitted changes** (git diff).
- **Standards files are authoritative**. If conflicts exist, follow the standards files.
- If any standards violations OR automated gate failures are found → **STOP** and output "FAIL" with exact details.
- **Never run `git add` or `git commit`** unless user replies with exactly: `PROCEED_TO_COMMIT`
- If the diff is empty → STOP (nothing to commit).

## Workflow (mandatory)

### Phase 0 — Collect Evidence
Run these commands and capture outputs:

1. `git status --porcelain`
2. `git diff --name-only`
3. `git diff`
4. `git diff --staged`
5. Read all applicable standards files from the repo (see default guess order below)

#### Standards file discovery (default guess order)
1) `.agent/rules/ag-rules.md` (project rules)
2) `.agent/rules/ag-ui-rules.md` (UI/design system rules)
3) `CODING_STANDARDS.md`
4) `CONTRIBUTING.md`

#### Guardrails
- If `git status --porcelain` is empty → output: "No uncommitted changes."
- If `git diff --staged` is non-empty → output a warning:
  "You already have staged changes; this workflow expects clean staging.
   Either unstage or confirm you want to include them."
  Then STOP unless user says they want to include staged changes.

### Phase 1 — Standards Compliance Gate (Blocking)

Compare the **changed lines** in `git diff` against:
1) AG Project Rules (`.agent/rules/ag-rules.md`)
2) AG UI Rules (`.agent/rules/ag-ui-rules.md`)
3) Global user rules (from memory/system prompt)

#### 1.1 — Data Integrity (from ag-rules.md)
- ❌ No hardcoded mock data in `services/`, `components/`, or `hooks/`
- ❌ No client-side filtering/search (must query backend)
- ✅ All data flows through API adapter / `server/`

#### 1.2 — UI/Design System (from ag-ui-rules.md)
- ❌ No `styled-components` or inline `style={{ }}` objects
- ❌ No raw CSS files for single components
- ❌ No arbitrary hex codes or custom colors
- ✅ Reuses shared components (`FloatingInput`, `CustomSelect`, `ModalShell`, `ActionDock`, etc.)
- ✅ Uses design tokens: Tailwind classes or CSS variables from Theme.css
- ✅ Spacing uses `universal-gap` / `var(--field-gap)` / `page-shell`

#### 1.3 — TypeScript Quality
- ❌ No `any` types (except where explicitly justified, e.g. API boundaries)
- ❌ No `@ts-ignore` or `@ts-expect-error` without a comment explaining why
- ❌ No unused imports or variables
- ✅ Proper null-safety (optional chaining, nullish coalescing)
- ✅ Interfaces/types defined for all component props

#### 1.4 — React Best Practices
- ❌ No `console.log` / `console.error` in production code (use logger)
- ❌ No missing `key` props in lists
- ❌ No direct DOM manipulation
- ✅ Hooks follow rules of hooks (no conditional hooks)
- ✅ Effects have proper dependency arrays
- ✅ Event handlers don't create new closures on every render (where performance-critical)

#### 1.5 — Security
- ❌ No secrets, API keys, or tokens hardcoded in source files
- ❌ No `dangerouslySetInnerHTML` without sanitization
- ✅ User input is validated before submission

#### Output format (strict)
- Overall status: PASS | FAIL
- If FAIL:
  - For each violation:
    - File:
    - Approx line(s) / hunk identifier:
    - Rule violated: (quote the exact rule from standards file or category above)
    - Why it violates:
    - Minimal fix suggestion (do NOT apply)

#### Gate behavior
- If FAIL → STOP after listing violations.
- If PASS → continue to Phase 2.

### Phase 2 — Automated Quality Gates (Blocking)

Run the following automated checks sequentially. If any gate FAILS, report it and **STOP**.

#### 2.1 — TypeScript Type Check
// turbo
```bash
npx tsc --noEmit 2>&1 | tail -30
```
- **PASS criteria:** Exit code 0, no type errors.
- **FAIL:** List all type errors with file paths and line numbers.

#### 2.2 — Lint Check (if configured)
// turbo
```bash
npx eslint --no-error-on-unmatched-pattern "src/**/*.{ts,tsx}" 2>&1 | tail -30
```
- **PASS criteria:** Exit code 0, no lint errors (warnings are acceptable).
- **FAIL:** List all lint errors. Warnings should be noted but do not block.
- **SKIP:** If ESLint is not configured, note "ESLint not configured — skipped" and continue.

#### 2.3 — Unit Tests (if they exist)
// turbo
```bash
npx vitest run --reporter=verbose 2>&1 | tail -50
```
- **PASS criteria:** All tests pass.
- **FAIL:** List failing tests with names and error messages.
- **SKIP:** If no test runner is configured, note "No unit test runner — skipped" and continue.

#### 2.4 — E2E Tests (MANDATORY — never skip)

**Pre-flight: ensure dev server + backend are reachable**
1. Check if the frontend dev server is running: `lsof -ti:5173`
   - If **not running**, start it: `nohup npm run dev > /tmp/vite-dev.log 2>&1 &` then `sleep 5` and re-check.
2. Check if the backend API is running: `lsof -ti:8080`
   - If **not running**, start it per the Backend Startup Protocol in `ag-rules.md` Section 9.
3. Both must be reachable before proceeding. If either fails to start, report the error and **STOP** (do not skip).

**Run E2E**

> [!CAUTION]
> **NEVER** use `npx playwright test` directly or pipe through `tail`/`head`.
> Always use the project's npm script. Piping through `tail` buffers ALL output,
> causing `command_status` to return empty and trapping agents in polling loops.

```bash
npm run test:e2e-all
```
- **PASS criteria:** All tests pass (exit code 0).
- **FAIL:** List failing tests with names and error messages. This is a **blocking** gate — do NOT skip or continue.
- **No SKIP option:** E2E tests are mandatory. If Playwright is not installed, report as FAIL and STOP.
- **WAIT STRATEGY:** Use `command_status` with `WaitDurationSeconds=100` (never more than 100s). If still running, check output so far and re-wait — but never exceed 100s per call.

#### Output format
For each gate:
```
Gate: [name]
Status: PASS | FAIL | SKIP
Output: [relevant output or "clean"]
```

#### Gate behavior
- If any gate is FAIL → STOP and list all failures.
- If all gates are PASS or SKIP → continue to Phase 3.

### Phase 3 — Summarize Uncommitted Changes

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

**Quality Gates Summary**
| Gate | Status |
|------|--------|
| TypeScript | PASS/FAIL/SKIP |
| ESLint | PASS/FAIL/SKIP |
| Unit Tests | PASS/FAIL/SKIP |
| E2E Tests | PASS/FAIL/SKIP |

### Phase 4 — Propose Commit Message

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

### Phase 5 — Stage + Commit (Only after explicit approval)

#### Preconditions
- User replied exactly: `PROCEED_TO_COMMIT`
- No standards violations
- No automated gate failures
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
- If a quality gate command is not available (e.g., no eslint config) → mark as SKIP, do not FAIL.
