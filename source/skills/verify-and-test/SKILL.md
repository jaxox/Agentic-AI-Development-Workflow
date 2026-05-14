---
name: verify-and-test
description: "Verify correctness through test execution and produce auditable test artifacts."
metadata:
  short-description: "Verify correctness through test execution and produce auditable test artifacts."
---

# Skill: verify_and_test

## Purpose
Verify correctness through test execution and produce auditable test artifacts.

## Inputs
- Code changes
- Test suite configuration

## Output
- JUnit XML results
- Raw stdout/stderr logs
- Metadata JSON
- Summary of failures and gaps

## Responsibilities
- Run tests and produce outputs per `docs/specs/test-logging.md`.
- Record failed tests and coverage gaps.
- Set overall status to BLOCKED if logs are missing or unreadable.
- Prefer the smallest test slice that still proves persistence, refetch, and user-visible correctness.
- Call out when a change was only tested in-memory and still lacks reload, reconnect, or multi-user proof.

## Forbidden
- Stating tests passed without logs.
- Skipping tests without documenting the reason.
- Declaring a guarded shared-state change verified if it lacks backend re-read evidence.

## Checklist
- [ ] Run tests
- [ ] Generate JUnit XML
- [ ] Capture raw logs
- [ ] Write metadata JSON
- [ ] Summarize failures/gaps
- [ ] For persisted mutations, verify post-mutation refetch or reload behavior
- [ ] For shared-state flows, verify at least one multi-user or multi-session path when practical
- [ ] For failure-prone flows, verify at least one unhappy path (auth, validation, timeout, conflict, or retry)

## Guarded shared-state addendum
Apply this addendum whenever the change touches shared or persisted state such as RSVP, attendance, chat, unread counts, notifications, or profile persistence.

- Prefer tests that mutate state, then create a new read boundary: page reload, fresh query, reconnect, or second user session.
- If the product promise depends on backend-authoritative state, treat UI-only assertions as insufficient by themselves.
- If a realistic multi-user check is too expensive, document the missing coverage explicitly instead of implying it is safe.

## Verification summary
Summaries should state:
- What was run
- What persistence/refetch behavior was proven
- What multi-user or failure-path coverage exists
- What important risk remains unverified
