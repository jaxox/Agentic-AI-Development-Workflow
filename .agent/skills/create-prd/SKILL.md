---
name: create-prd
description: "Convert the brief into a product requirements document (PRD)."
---

# Skill: create_prd

## Purpose
Convert the brief into a product requirements document (PRD).

## Inputs
- `artifacts/brief.md` or `artifacts/product-brief.md`
- `artifacts/research.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any linked files or constraints

## Output
- `artifacts/prd.md` (use `templates/prd.md`)

## Responsibilities
- Define functional and non-functional requirements.
- Include personas, success metrics, risks, assumptions, and dependencies.
- Provide acceptance criteria and scope boundaries.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Advancing with open questions unresolved.
- Adding requirements without sources or rationale.

## Checklist
- [ ] Review the brief and research inputs
- [ ] Populate `artifacts/prd.md` using the template
- [ ] Capture dependencies and exclusions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
