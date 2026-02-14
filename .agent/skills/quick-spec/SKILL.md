---
name: quick-spec
description: "Create a lightweight technical spec to enable fast implementation decisions."
metadata:
  short-description: "Create a lightweight technical spec to enable fast implementation decisions."
---

# Skill: quick_spec

## Purpose
Create a lightweight technical spec to enable fast implementation decisions.

## Inputs
- User request or problem statement
- `artifacts/brief.md` or `artifacts/product-brief.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Constraints, links, or related tickets

## Output
- `artifacts/tech-spec.md` (use `templates/tech-spec.md`)

## Responsibilities
- Capture problem, solution, detected stack, and implementation patterns.
- Identify tests, file paths, and potential story outputs.
- Document alternatives when material.
- Ask for missing inputs before finalizing if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Skipping risks or rollback considerations.
- Introducing assumptions without noting them.

## Checklist
- [ ] Confirm scope and constraints
- [ ] Populate `artifacts/tech-spec.md` using the template
- [ ] Record risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
