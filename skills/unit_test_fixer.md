# AI Skill: `unit_test_fixer`

## Purpose

Fix failing unit tests correctly and permanently by resolving root causes only. Use this skill when a user asks to fix unit tests, stabilize flaky unit tests, or investigate recurring unit-test failures.

This skill prevents shallow fixes such as:
- Disabling or skipping tests
- Weakening assertions
- Adding retries or sleeps
- Patching code just to make tests pass

Passing tests are not the goal.
Correct, meaningful, stable tests are the goal.

---

## Core Rules (Non-Negotiable)

1. Never disable or skip tests
- No `@Disabled`, no removing tests from the suite.
- If a test is invalid, replace it with an equivalent valid test.

2. Never weaken assertions
- Do not replace strong assertions with weaker ones.
- Do not assert only `notNull`, `true`, or empty checks unless explicitly justified by the contract.

3. Retries are not fixes
- Adding retries is forbidden unless:
- A root cause is identified.
- A real fix is implemented.
- The retry is explicitly temporary and documented.

4. No "green at all costs" behavior
- If the correct fix is unclear, stop and ask targeted questions.

Violating any rule requires explicit justification and user approval.

---

## Mandatory Workflow

### Step 1 - Reproduce the Failure

- Run the smallest possible scope:
- Single test method, then test class, then module/package if needed.
- Capture:
- Exact failure message
- Stack trace
- Line numbers

### Step 2 - State Test Intent

Before changing anything, explicitly answer:

> This test exists to guarantee that _____.

If intent is unclear, infer and verify from:
- Test name
- Assertions
- Production-code contract
- Javadoc/comments

### Step 3 - Classify the Failure

Choose one:
- Product bug: Production code is wrong.
- Test bug: Test expectation is wrong.
- Nondeterminism: Time, randomness, concurrency, or global/shared state.

If uncertain, use the Question Gate and ask before editing.

### Step 4 - Root Cause Analysis

- Point to exact line(s) causing failure.
- Explain why failure occurs.
- Explain why proposed fix is correct.

Do not change code until root cause is clear.

### Step 5 - Apply the Correct Fix (Strict Order)

1. Fix production code if behavior is incorrect.
2. Fix test only if expectation is incorrect.
3. Eliminate nondeterminism:
- Fake/controlled clocks
- Seeded randomness
- Deterministic ordering
- Isolated state and cleanup

Forbidden fixes:
- Commenting out assertions
- Catching and ignoring exceptions
- Adding sleeps
- Increasing retries

### Step 6 - Strengthen the Test

Add at least one assertion that fails if regression returns.

Prefer:
- Exact values over broad checks
- Behavioral verification over existence checks

### Step 7 - Verify

Run:
- Fixed test(s)
- Related package/module tests

Confirm no new flakiness is introduced.

---

## Question Gate (Required When Ambiguous)

Ask targeted questions instead of guessing:
- What is the intended contract for this method?
- Is this behavior documented anywhere?
- Should this dependency be mocked or real?
- Is this edge case valid or undefined behavior?

Do not assume undocumented behavior.

---

## Required Fix Report (Always Output)

After fixing, output:
- Failure classification
- Root cause
- Why the fix is correct
- What prevents regression
- Commands run and results

---

## Success Criteria

- Tests validate real behavior.
- No flaky behavior is introduced.
- No shortcuts are taken.
- Future regressions are caught early.
