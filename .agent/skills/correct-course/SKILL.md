---
name: correct-course
description: "Re-scope or re-plan work when current execution is off track."
---

# Skill: correct_course

## Purpose
Re-scope or re-plan work when current execution is off track.

## Inputs
- Current status, risks, and blockers
- `artifacts/epic-retrospective.md` or other reviews if available
- Stakeholder priorities or new constraints

## Output
- `artifacts/correct-course.md` (use `templates/correct-course.md`)

## Responsibilities
- Identify root causes and propose adjustments.
- Document impact, tradeoffs, and decisions needed.
- Ask for missing inputs before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Changing scope without explicit decision points.
- Ignoring previously agreed constraints.

## Checklist
- [ ] Review current status and constraints
- [ ] Populate `artifacts/correct-course.md` using the template
- [ ] Identify impacts and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
