---
name: uncommitted-code-review
description: "Perform a **strict, deterministic code review** of **uncommitted Git changes only** (staged and unstaged)."
metadata:
  short-description: "Perform a **strict, deterministic code review** of **uncommitted Git changes only** (staged and unstaged)."
---

# Skill: `uncommitted_code_review`

## Purpose

Perform a **strict, deterministic code review** of **uncommitted Git changes only** (staged and unstaged).
The skill acts like a senior engineer blocking a release: it focuses on correctness, safety, performance, and test coverage — not style bikeshedding or speculative refactors.
It must prioritize **root-cause, flow-level fixes** over band-aid patches.

---

## Scope & Inputs

### Allowed Inputs

* `git status`
* `git diff --staged`
* `git diff`
* **Reading existing (committed) files** to resolve questions about whether referenced code exists, whether interfaces match, or whether contract gaps are real. The diff is the review scope, but the existing codebase is valid investigation context.

### Explicitly Disallowed

* Reviewing committed history
* Reviewing untouched files
* Repo-wide refactors
* Formatting-only feedback
* Speculative or "nice to have" redesigns
* "Quick patch" guidance that does not address root cause

If required context is missing, the skill **must investigate** using existing codebase files before reporting. Never ask the user to confirm or verify something the agent can check itself.

---

## Hard Rules (Non-Negotiable)

1. **Review ONLY changed lines**

   * Do not comment on code that is not part of the diff unless directly impacted.

2. **No behavior changes without explicit callout**

   * Any behavior change must be flagged clearly and explained.

3. **No large refactors**

   * Suggest minimal, targeted fixes only.

4. **No vague feedback**

   * Every issue must include:

     * file path
     * line range
     * why it matters
     * **root cause** — how the issue was introduced (e.g., refactor leftover, missing guard, wrong API)
     * **concrete fix** — actionable code snippet, patch, or step-by-step remediation
     * If the fix is non-trivial, show a before/after diff block

5. **No hallucinations**

   * Do not invent files, APIs, configs, or tests.

6. **Assume production impact**

   * Review as if this code can ship to prod today.

7. **Follow repo guardrails first (AGENTS.md / project rules)**

   * Before finalizing findings, check applicable repo guardrails.
   * If a diff violates those guardrails, this must be called out explicitly and prioritized.

8. **No band-aid recommendations**

   * Do not suggest UI-only or local-state-only patches when the root cause is in API contract, backend logic, persistence, or auth flow.
   * Fixes must target the authoritative layer and include why that layer is the source of truth.

9. **Trace the end-to-end flow before proposing fixes**

   * For auth/legal/RSVP/security flows, validate request path, API contract, state propagation, routing, and persistence impacts.
   * If an issue appears repeatedly, include a systemic fix that prevents recurrence (not just line edits).

10. **Use invariant-first review for recurring issue families**

    * For repeated findings in the same domain (auth/legal/RSVP/session/redirect), define explicit invariants the diff must satisfy.
    * Evaluate whether each changed path satisfies the same invariant, not just the path that triggered the review.

11. **Require sibling-path closure for P0/P1**

    * For each P0/P1 finding, list all sibling entrypoints likely sharing the defect pattern.
    * If closure cannot be proven from diff + tests, keep issue open at P1.

12. **Report process gaps when loops recur**

    * If the same class of issue recurs across multiple review cycles, include one process-level recommendation (guardrail check, invariant test, or workflow gate) to break the loop.

13. **Emit stable finding IDs**

    * Assign deterministic IDs per issue (for example `P1-1`, `P1-2`, `P2-1`).
    * Reuse the same ID for the same unresolved issue across follow-up reviews when possible.
    * This ID set is the closure contract for `root-cause-fix-enforcer`.

14. **Verify closure against prior IDs when provided**

    * If prior finding IDs are available in context, explicitly mark each as `closed` or `open`.
    * Do not silently replace old findings with new wording.

15. **Enforce AGENTS.md guarded-scope rules as review findings**

    * If repo guardrails require backend sync/proof for a changed scope (for example RSVP/profile/auth persistence), missing backend evidence is a review issue, not an optional note.
    * Mark such violations at least `P1` and keep merge verdict non-ready until resolved.

16. **No partial-close merge optimism**

    * If any `P0/P1` finding ID is still `open`, do not provide optimistic wording that implies near-merge readiness.
    * Keep root-cause/entrypoint closure language explicit: which path is still unclosed and why.

17. **Investigate, don't ask**

    * When a potential issue is identified in the diff (e.g., a new method call, a missing service wrapper, a contract mismatch), the reviewer **must** read the relevant existing files to determine whether the issue is real before reporting it.
    * **Forbidden**: Findings that say "Verify X exists", "Confirm Y is present", or "If Z was added, this is fine" — the agent has access to the codebase and must look it up.
    * Every finding must state the **definitive status**: either "X is missing and must be added" or "X already exists at [file:line] — no issue".
    * If the agent cannot determine the status after reading existing files, it must state exactly what it checked, what it found, and why the determination is ambiguous — not punt the investigation to the user.

---

## Review Checklist

The skill MUST evaluate all applicable items below:

### Correctness & Safety

* Null / undefined handling
* Edge cases
* Input assumptions
* Error propagation
* Default values

### Async / Concurrency (if applicable)

* Ordering guarantees
* Timeouts
* Retries
* Resource leaks
* Backpressure

### Performance

* Hot paths
* Blocking calls
* Accidental N² work
* Unbounded loops or collections

### Security & Privacy

* Secrets or credentials
* Logging sensitive data
* Injection vectors
* AuthZ / AuthN assumptions

### Observability

* Missing logs/metrics
* Noisy or misleading logs
* Missing error context

### API / Contract Stability

* Public API changes
* Wire format changes
* Backward compatibility
* Error code parsing consistency (`errorCode` vs `error` or equivalent)

### Testing

* Missing tests for new logic
* Tests that no longer cover behavior
* Flaky or brittle test patterns
* Invariant-level tests missing for recurring issue families
* Guardrail checks (when defined by repo rules) are missing from CI/local validation path

---

## Severity Levels

* **P0 – Blocker**

  * Will cause prod incidents, data corruption, crashes, or security issues

* **P1 – High**

  * Incorrect behavior in edge cases, performance regressions, missing error handling

* **P2 – Medium**

  * Maintainability, clarity, minor inefficiencies

---

## Required Output Format

The response MUST follow this structure exactly:

### 1. Summary

* 3–6 bullet points describing what changed and overall risk

### 2. P0 Issues (Blockers)

For each issue:

* **File:** `path/to/file`
* **Lines:** `start–end`
* **Problem:** concise explanation
* **Root cause:** how this was introduced
* **Impact:** what can break
* **Fix:** concrete code change (before/after diff when non-trivial)

### 3. P1 Issues

(same format as P0)

### 4. P2 Issues

(same format as P0)

### 5. Tests to Add or Update

* Exact test cases
* Files to modify
* Commands to run (if applicable)

### 5.5 Findings Ledger

* Table of finding IDs with status:
  * `open` (still present)
  * `closed` (verified fixed)
* Include one-line closure evidence for each `closed` ID.

### 6. Root-Cause Fix Plan

* For each P0/P1 issue, include:
  * authoritative layer to fix (backend/API/client/router/persistence)
  * why quick patches are insufficient
  * minimal durable remediation sequence

### 7. Invariant Closure Table

For each P0/P1 issue family, include:

* invariant statement
* in-scope sibling entrypoints
* closure status per entrypoint (`closed` / `open`)
* validation artifact (test/check/manual evidence)

### 8. Recurrence Prevention

* One concrete anti-loop action per recurring issue family:
  * guardrail/static check to add
  * invariant regression test to add
  * workflow gate to enforce before merge

### 9. Risk & Rollout Notes

* Behavior changes
* Migration or backfill needs
* Rollout considerations
* Guardrail/contract enforcement risks (for example backend-sync proof drift)

### 9.5 Q&A — Answers to User Questions

* If the user asked any questions in review comments, inline annotations, or chat during the review, list each question and provide a clear, direct answer.
* Format as: **Q:** (quoted question) → **A:** (answer)
* If a question was already addressed by a fix, reference the fix ID (e.g., "Addressed by P2-1").
* If a question requires investigation (e.g., "are we using Spring Boot 3?"), perform the investigation and state the factual answer.
* This section is MANDATORY when user questions exist. Omit only if no questions were asked.

### 10. Merge Readiness Verdict

One of:

* ✅ **Ready to merge**
* ⚠️ **Merge with follow-ups**
* ❌ **Do not merge**

---

## Behavioral Constraints

* Be direct and honest.
* No praise padding.
* No "looks good overall" unless there are truly no issues.
* Never recommend "just patch this line" when there is an unresolved flow-level root cause.
* If no issues are found, explicitly state:

  > "No P0–P2 issues found in the reviewed diff."
* If issues are found but invariant closure cannot be proven, do not return "Ready to merge."
* If prior finding IDs were provided, include explicit closure state for every ID before verdict.

---

## Example Invocation

```text
Run skill: uncommitted_code_review
Input: current working tree
```

---

## Success Criteria

This skill is successful if:

* Feedback is repeatable across runs
* Scope never exceeds the uncommitted diff
* Output can be copy-pasted into a PR review or Jira ticket with no edits
