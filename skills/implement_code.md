# Skill: implement_code

## Purpose
Implement code changes based on the PRD and architecture, producing a verifiable diff and tests.

## Inputs
- `artifacts/prd.md`
- `artifacts/architecture.md`
- Repo source code

## Output
- Code changes
- Tests
- Git diff

## Responsibilities
- Map each change to PRD IDs (FR/NFR) in commit messages or change notes.
- Avoid mock data in UI/services unless explicitly behind an API boundary.
- Run relevant tests where possible and capture outputs.

## Forbidden
- Introducing new architecture without approval.
- Claiming tests passed without logs.

## Checklist
- [ ] Read `artifacts/prd.md` and `artifacts/architecture.md`
- [ ] Implement changes mapped to PRD IDs
- [ ] Add/update tests
- [ ] Capture git diff
- [ ] Summarize actions and blockers
