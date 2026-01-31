# Skill: create_story

## Purpose
Create a delivery-ready story with acceptance criteria and technical notes.

## Inputs
- `artifacts/epics-and-stories.md`
- `artifacts/prd.md` and `artifacts/architecture.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any specific story prompt or ticket

## Output
- `artifacts/stories/story-<slug>.md` (use `templates/story.md`)

## Responsibilities
- Define story objective, context, acceptance criteria, and definition of done.
- Capture technical notes and ADR references when relevant.
- Capture dependencies, risks, and open questions.
- Ask for missing inputs before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Creating a story without acceptance criteria.
- Skipping test considerations.

## Checklist
- [ ] Identify story slug and source
- [ ] Populate `artifacts/stories/story-<slug>.md` using the template
- [ ] Note dependencies and risks
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
