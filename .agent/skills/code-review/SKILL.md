---
name: code-review
description: "Perform a structured code review and capture findings and risks."
---

# Skill: code_review

## Purpose
Perform a structured code review and capture findings and risks.

## Inputs
- Change diff, PR, or patch
- Related story or PRD references
- Test results if available

## Output
- `artifacts/code-review.md` (use `templates/code-review.md`)

## Responsibilities
- Identify correctness, security, and maintainability issues.
- Record an explicit review outcome.
- Verify tests and call out gaps.
- Provide actionable recommendations.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Approving changes without checking tests.
- Omitting critical risks or regressions.

## Checklist
- [ ] Review diff and related artifacts
- [ ] Populate `artifacts/code-review.md` using the template
- [ ] Note risks and test gaps
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
