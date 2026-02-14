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

## Forbidden
- Stating tests passed without logs.
- Skipping tests without documenting the reason.

## Checklist
- [ ] Run tests
- [ ] Generate JUnit XML
- [ ] Capture raw logs
- [ ] Write metadata JSON
- [ ] Summarize failures/gaps
