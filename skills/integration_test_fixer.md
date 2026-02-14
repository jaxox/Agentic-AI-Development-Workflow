# AI Skill: `integration_test_fixer`

## Purpose

Fix failing integration tests with production-grade, root-cause fixes so tests are deterministic, environment-independent, and representative of real user/system behavior.
- Ensure fixes improve production quality and contract correctness, not just CI pass rate.
- Ensure remediations are maintainable and safe for long-term operation.
- Ensure tests remain trustworthy signals for deployment decisions.

This skill enforces that integration tests are:
- Deterministic
- Environment-independent
- Representative of real user/system behavior
- Backed by production-grade fixes in production code and test infrastructure
- Fully remediated across the suite, including pre-existing and unrelated failures

Integration tests may be slower, but they must not be flaky.
The goal is production quality, not prototype-quality "green test" patches.

---

## Core Rules (Non-Negotiable)

1. No skipping or quarantining without cause
- Tests cannot be disabled as a fix.
- Quarantine requires root-cause tracking.

2. No blind retries or sleeps
- `sleep()` is forbidden.
- Retries without fixing root cause are forbidden.

3. No reliance on external real services
- Tests must not depend on live APIs or shared environments.

4. Tests must assert real contracts
- API responses
- DB state
- Events/messages emitted
- Not internal implementation details

5. Fixes must be production-grade
- Resolve root causes in production code, integration boundaries, or deterministic test setup.
- Do not apply prototype shortcuts, temporary hacks, or test-only patches that hide product defects.
- Any temporary mitigation must be explicitly documented with owner and follow-up plan.

6. No scope exemption for failing tests
- Fix all failing tests discovered during verification, even if pre-existing or not introduced by the current change.
- Do not leave unrelated failures unresolved when claiming completion.

---

## Mandatory Workflow

### Step 1 - Classify the Failure

Choose one:
- Infrastructure/environment issue
- Product bug
- Test data issue
- Timing/race condition
- Ordering/shared-state issue

State whether the root cause lives in production code, integration boundary, or test harness.
Default to fixing production behavior when user/system contract is violated.

### Step 2 - Stabilize the Environment

Replace real dependencies with:
- Testcontainers
- Local emulators
- Mock servers

Eliminate machine-specific assumptions.

### Step 3 - Make Test Data Deterministic

Use:
- Explicit IDs
- Fixed timestamps
- Known ordering
- Guaranteed cleanup/reset

No shared or leaked state allowed.

### Step 4 - Fix Time and Async Issues

Replace sleeps with:
- Condition-based waits
- Poll-until-success with timeouts

Use fake or controllable clocks where possible.

### Step 5 - Validate Test Meaning

Explicitly state:

> This integration test proves that _____ from a user/system perspective.

If it does not prove meaningful behavior, rewrite it.

### Step 6 - Apply Production-Grade Fix

- Fix production code when behavior violates contract.
- Fix integration wiring/configuration when boundaries are incorrect.
- Fix test harness only when product behavior is correct and test setup is wrong.
- Keep fixes reviewable, minimal, and maintainable for long-term support.

### Step 7 - Verify Isolation

Run the test:
- Alone
- As part of the full suite

Ensure ordering does not affect results.

### Step 8 - Drive Full Suite to Green

- Run the complete relevant integration suite (and broader suite when required by repository policy).
- Triage every failing test, including pre-existing and unrelated failures.
- Apply root-cause fixes until all tests pass consistently.

---

## Forbidden Fixes

- `Thread.sleep`
- Increasing retry counts
- Disabling tests
- Catch-and-ignore patterns
- Making assertions vague or optional
- Prototype-only patches intended only to make CI green
- Test-only behavior flags that diverge from production contract

---

## Required Fix Report (Always Output)

- Failure classification
- Root cause
- Where the fix was applied (production code, integration boundary, or test harness) and why
- Determinism strategy
- Why this fix is stable
- Full-suite status, including pre-existing/unrelated failures that were fixed
- Commands run and results

---

## Success Criteria

- Test passes consistently
- No dependency on timing luck
- Clear contract validation
- High confidence in CI results
- Production behavior and quality are improved, not bypassed
- All failing tests found during verification are resolved, regardless of original scope
