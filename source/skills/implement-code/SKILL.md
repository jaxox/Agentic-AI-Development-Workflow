---
name: implement-code
description: "Implement code changes based on an approved PRD, architecture, or task checklist, producing a verifiable diff, tests, self-audit, and task evidence. Use for plan-locked implementation where each pass should handle one task ID at a time and avoid unrelated batching."
metadata:
  short-description: "Implement code changes based on the PRD and architecture, producing a verifiable diff and tests."
---

# Skill: implement_code

## Purpose
Implement code changes based on the PRD, architecture, and approved task checklist, producing a verifiable diff, tests, self-audit, and task evidence.

## Inputs
- `artifacts/prd.md`
- `artifacts/architecture.md`
- Approved task checklist or `artifacts/execution/<feature-or-fix-slug>/task-ledger.md`
- Repo source code

## Output
- Code changes
- Tests
- Git diff
- Task evidence: task ID, files changed, acceptance criteria satisfied, tests run, UI proof when applicable, known gaps

## Responsibilities
- Implement exactly one task ID per pass.
- Restate the task ID, acceptance criteria, allowed scope, excluded scope, and required evidence before editing.
- Map each change to PRD IDs, story IDs, or task IDs in commit messages or change notes.
- Avoid mock data in UI/services unless explicitly behind an API boundary.
- Preserve approved mockup locks and do not reinterpret UI without user-approved design changes.
- Run relevant tests where possible and capture outputs.
- Self-audit against the approved plan, contracts, mockups, and source-of-truth rules before asking for review.
- Update the execution ledger whenever one exists; do not leave task evidence only in chat, a report, or commit notes.

## Forbidden
- Introducing new architecture without approval.
- Claiming tests passed without logs.
- Batching unrelated tasks.
- Marking work complete while blocking Plan Enforcer findings remain open.

## Plan-Locked Implementation Loop

1. Select the next `TODO` task from the approved checklist or ledger.
2. Restate task ID, acceptance criteria, scope, non-goals, and evidence requirements.
3. Implement only that task.
4. Run relevant tests and capture results.
5. Self-audit for plan drift, mockup drift, fake state, shortcuts, weak tests, and unrelated changes.
6. Fix self-audit gaps.
7. Run Plan Enforcer review.
8. Fix blocking findings.
9. Update the execution ledger with files changed, tests, UI proof when applicable, known gaps, and reviewer closure.
10. Mark the task DONE only after closure exists in the ledger when a ledger exists; otherwise use the implementation report.

## Checklist
- [ ] Read `artifacts/prd.md` and `artifacts/architecture.md`
- [ ] Read the approved task checklist or execution ledger
- [ ] Restate the current task ID and acceptance criteria
- [ ] Implement only the current task
- [ ] Add/update tests
- [ ] Run relevant tests and capture outputs
- [ ] Self-audit against approved plan and mockups
- [ ] Close or document Plan Enforcer findings
- [ ] Update execution ledger when present
- [ ] Capture git diff
- [ ] Summarize actions and blockers
