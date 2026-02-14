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

---

## Scope & Inputs

### Allowed Inputs

* `git status`
* `git diff --staged`
* `git diff`

### Explicitly Disallowed

* Reviewing committed history
* Reviewing untouched files
* Repo-wide refactors
* Formatting-only feedback
* Speculative or "nice to have" redesigns

If required context is missing, the skill may ask **at most one clarifying question** and must specify the exact file/lines needed.

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
     * a concrete fix (code snippet or patch)

5. **No hallucinations**

   * Do not invent files, APIs, configs, or tests.

6. **Assume production impact**

   * Review as if this code can ship to prod today.

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

### Testing

* Missing tests for new logic
* Tests that no longer cover behavior
* Flaky or brittle test patterns

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
* **Impact:** what can break
* **Fix:** concrete code change

### 3. P1 Issues

(same format as P0)

### 4. P2 Issues

(same format as P0)

### 5. Tests to Add or Update

* Exact test cases
* Files to modify
* Commands to run (if applicable)

### 6. Risk & Rollout Notes

* Behavior changes
* Migration or backfill needs
* Rollout considerations

### 7. Merge Readiness Verdict

One of:

* ✅ **Ready to merge**
* ⚠️ **Merge with follow-ups**
* ❌ **Do not merge**

---

## Behavioral Constraints

* Be direct and honest.
* No praise padding.
* No "looks good overall" unless there are truly no issues.
* If no issues are found, explicitly state:

  > "No P0–P2 issues found in the reviewed diff."

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
