# Review Checklist (QA Rubric)

Use this checklist to validate workflow outputs before declaring DONE.

## Artifact integrity
- [ ] All required artifacts exist under `artifacts/`.
- [ ] Each artifact uses the correct template structure.
- [ ] Each artifact has `Status.State` set.
- [ ] Open questions are either resolved or the state is NEEDS INPUT.

## Scope and requirements
- [ ] Goals and non-goals are explicit in `brief.md`.
- [ ] PRD includes FR/NFR lists, user stories, MVP scope, and exclusions.
- [ ] Architecture includes component boundaries, data flow, and at least one diagram.
- [ ] No architecture changes were introduced without approval.

## Implementation quality
- [ ] Code changes map to PRD IDs (FR/NFR).
- [ ] No UI/service mock data unless behind an API boundary.
- [ ] Diff and file list exist in `artifacts/metrics/`.

## Verification
- [ ] JUnit XML exists and is readable.
- [ ] Raw stdout/stderr logs are present.
- [ ] Test metadata JSON exists and references log paths.
- [ ] Failed tests (if any) are listed with follow-up actions.

## Workflow gates
- [ ] If any step is NEEDS INPUT or BLOCKED, workflow is not marked DONE.
- [ ] `artifacts/status.md` accurately reflects blockers, confidence, and next action.

## Sign-off
- [ ] Reviewer:
- [ ] Date:
- [ ] Notes:
