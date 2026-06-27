---
name: dev-story
description: "Implement exactly one approved story or task ID in code with tests, self-audit, reviewer closure, and a concise implementation report. Use for plan-locked sequential implementation where each task must map to acceptance criteria and evidence before it can be marked done."
metadata:
  short-description: "Implement a story in code with tests and a concise implementation report."
---

# Skill: dev_story

## Purpose
Implement exactly one approved story or task ID in code with tests, self-audit, reviewer closure, and a concise implementation report.

## Inputs
- `artifacts/stories/story-<slug>.md`
- Approved `TASK-###` entry or equivalent task ID from an execution checklist
- `artifacts/execution/<feature-or-fix-slug>/task-ledger.md` when present
- Repository codebase and architecture references
- `artifacts/prd.md` and `artifacts/architecture.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`

## Output
- Code changes and tests
- `artifacts/dev-story-report.md` (use `templates/dev-story-report.md`)

## Responsibilities
- Restate the task ID, acceptance criteria, allowed scope, explicit non-goals, and required evidence before editing.
- Implement only the assigned task. Do not batch unrelated UI, backend, data, test, or refactor work.
- Implement the story or task per acceptance criteria, mockup locks, and ADR guidance.
- For UI tasks, inspect and reuse existing components, surfaces, interaction patterns, tests, tokens, labels, validation behavior, and accessibility behavior before adding new UI; explain any new component.
- Add or update tests and capture test logs per `docs/specs/test-logging.md`.
- Self-audit the diff against the approved plan, task checklist, mockup locks, contracts, and source-of-truth rules.
- Run or request Plan Enforcer review before marking the task complete.
- Update the execution ledger whenever one exists; do not leave task evidence only in chat, a report, or commit notes.
- Update sprint status to READY FOR REVIEW when applicable.
- Document changes, tests, and risks in the report.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Shipping without tests or without explaining test gaps.
- Introducing mock data in UI/services without an explicit boundary.
- Duplicating existing UI behavior or components when reuse, composition, extension, or parameterization is feasible.
- Marking a task DONE without code evidence, test evidence, self-audit, and reviewer closure.
- Moving to another task while the current task has open blocking Plan Enforcer findings.

## Plan-Locked Task Protocol

For each task:

1. Restate the task ID and acceptance criteria.
2. Confirm implementation scope, excluded scope, and relevant approved mockup lock if UI is involved.
3. For UI tasks, identify the closest shared component, route, form, modal, hook, utility, token, and test to reuse.
4. Implement only that task.
5. Run the smallest relevant tests that prove the task behavior.
6. Self-audit against the approved plan, mockups, API/contracts, persistence authority, and known non-goals.
7. Fix self-audit gaps.
8. Send the diff to Plan Enforcer review.
9. Fix blocking reviewer findings.
10. Update the execution ledger with files changed, tests, UI proof when applicable, known gaps, and reviewer closure.
11. Mark DONE only after evidence is present in the execution ledger when a ledger exists; otherwise use the implementation report.

If the task is too large to satisfy this protocol cleanly, split it before implementation.

## Checklist
- [ ] Review story and architecture inputs
- [ ] Restate task ID, acceptance criteria, scope, non-goals, and evidence requirements
- [ ] For UI tasks, reuse existing components/patterns or document why reuse was insufficient
- [ ] Implement code changes and tests
- [ ] Run relevant tests and capture results
- [ ] Self-audit against approved plan and mockups
- [ ] Close Plan Enforcer findings or document accepted non-blockers
- [ ] Update execution ledger when present
- [ ] Populate `artifacts/dev-story-report.md` using the template
- [ ] Attach test logs per spec
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
