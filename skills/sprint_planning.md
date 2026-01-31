# Skill: sprint_planning

## Purpose
Plan sprint scope and status based on epics, stories, and capacity.

## Inputs
- `artifacts/epics-and-stories.md`
- Delivery constraints and capacity assumptions
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`

## Output
- `artifacts/sprint-status.yaml` (use `templates/sprint-status.yaml`)

## Responsibilities
- Select stories aligned to goals and capacity.
- Use statuses: TODO, IN PROGRESS, READY FOR REVIEW, DONE.
- Capture ownership, estimates, and risks.
- Call out open questions and dependencies.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Committing to scope without capacity assumptions.
- Omitting dependencies that block execution.

## Checklist
- [ ] Review epics/stories and capacity
- [ ] Populate `artifacts/sprint-status.yaml` using the template
- [ ] Note risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
