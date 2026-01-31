---
name: create-epics-and-stories
description: "Break requirements into epics and stories for delivery planning."
---

# Skill: create_epics_and_stories

## Purpose
Break requirements into epics and stories for delivery planning.

## Inputs
- `artifacts/prd.md`
- `artifacts/architecture.md` and `artifacts/ux-spec.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any delivery constraints or milestones

## Output
- `artifacts/epics/epic-<slug>.md` (use `templates/epic.md`)
- `artifacts/epics-and-stories.md` (use `templates/epics-and-stories.md`)

## Responsibilities
- Create one epic file per epic with scoped stories and acceptance intent.
- Capture dependencies and prioritization rationale.
- Flag risks and open questions.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Creating stories without acceptance criteria intent.
- Ignoring dependencies that affect sequencing.

## Checklist
- [ ] Review PRD and architecture inputs
- [ ] Populate epic files and index using templates
- [ ] Note dependencies and risks
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
