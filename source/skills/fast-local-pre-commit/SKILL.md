---
name: fast-local-pre-commit
description: Use when the user wants the fastest safe local fix-and-commit loop: run only touched-file tests and touched-domain tests, fix failures one at a time, avoid rerunning broad suites, and defer full-suite verification until pre-push or pre-merge.
metadata:
  short-description: Fast targeted local pre-commit workflow
---

# Skill: fast_local_pre_commit

## Purpose
Use the smallest reliable review and test loop that proves the changed surface is correct without paying for whole-repo verification on every local fix.

## When To Use
- The user explicitly says `fast-local`, `targeted-only`, `only run relevant tests`, `don't rerun broad suites yet`, or similar.
- The task is a local fix/refactor and the user does not want full-suite validation yet.
- The user explicitly opts into a narrow local verification loop before broader pre-push or pre-merge verification.

## Do Not Use
- The user explicitly asks for `pre-push`, `pre-merge`, or full-suite verification.
- The task is security-critical, migration-heavy, or otherwise requires broad validation by policy.

## Core Rules
1. Scope first.
- Identify changed files.
- Identify the touched domain.
- Limit investigation, review, and verification to that scope first.

2. Start with the smallest relevant test set.
- Run tests directly covering changed files.
- Run tests in the touched domain only.
- Do not run full `vitest`, full E2E, or unrelated domains during the initial fix loop.

3. Fix failures one at a time.
- If multiple targeted tests fail, pick one failing test.
- Fix it.
- Rerun only that test until it passes.
- Then move to the next failing test.

4. Triage before parallelizing.
- Start with one agent or one owner doing a quick triage pass across the failing targeted tests.
- Group failures by root cause before assigning fixes.
- Fix shared-root-cause failures serially in one place.
- Only parallelize failures after confirming they are independent, have disjoint write scope, and do not depend on the same unstable environment or shared helper.

5. Recombine only after individual failures are closed.
- When all individually failing targeted tests pass, rerun the small relevant set once.
- That targeted bundle is the local commit gate.

6. Avoid duplicate review workflows.
- Do one diff-scoped review over uncommitted changes.
- Do not stack overlapping review and pre-commit skills unless the user explicitly wants both.

7. Repo-required checks still win.
- `fast-local` defers broad suites, but it does not override repo-mandated checks.
- If the repo requires guardrails, backend-sync proof, security-critical validation, or similar checks for the touched scope, those still must run before commit when applicable.

8. Do not rerun already-passing broad suites.
- If a broader suite already passed and no relevant files changed afterward, do not rerun it.
- If a new edit affects only one file or one domain, rerun only the affected slice.

9. Defer broad verification.
- Full suite belongs to pre-push or pre-merge, not the default local fix loop.
- If unsure, ask whether the user wants `fast-local`, `pre-push`, or `pre-merge`.

## Precedence
- If combined with a stricter pre-commit skill, `fast-local` governs the fix loop only.
- The stricter skill becomes a later optional or pre-push gate unless the user explicitly says to run it now.
- If the user explicitly requests both immediately, follow the stricter skill after the `fast-local` repair loop finishes.

## Workflow
1. Collect evidence.
- `git status --short`
- `git diff --name-only`
- Map changed files to likely tests and domain tests.

2. Build the local test set.
- Include direct unit/integration tests for touched files.
- Include touched-domain E2E/spec tests only.
- Exclude unrelated domains.
- For shared infrastructure changes (`contexts/`, shared hooks, query/cache utilities, adapters, auth, routing, API clients), include:
  - direct tests for the shared module
  - downstream domain tests for each affected call site or screen

3. Run the targeted set.
- If all pass, proceed to diff-scoped review.
- If some fail, isolate and iterate per failure.

4. Triage loop.
- Use one agent or owner to group failures by root cause first.
- Keep shared-root-cause repairs serial.
- Split only independent leftovers into parallel fix tracks.

5. Repair loop.
- Rerun only the failing targeted test.
- Repeat until that test passes.
- Move to the next failing targeted test.

6. Final local gate.
- Rerun the targeted bundle once.
- If green, the change is locally ready pending any repo-required checks that still apply.

7. Pre-push / pre-merge handoff.
- Recommend broad suite only before push, PR, or merge to `main`.

## Output Expectations
- List the changed files.
- List the chosen targeted tests and why they are in scope.
- List failing tests individually and the rerun order.
- State clearly when the targeted local gate is green.
- State clearly which broader suites were intentionally deferred.

## Anti-Patterns
- Re-running full `vitest` after every small patch.
- Re-running full E2E after every small patch.
- Spawning parallel fix agents before checking whether failures share the same root cause.
- Running multiple overlapping review skills over the same diff.
- Expanding from a 5-10 test local bundle into repo-wide validation without a specific reason.

## Mode Language
- `fast-local`: touched tests + touched domain only.
- `pre-push`: broader regression pass before pushing.
- `pre-merge`: full required verification before merge to `main`.
