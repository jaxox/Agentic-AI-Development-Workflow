---
name: create-ux-design
description: "Define UX journeys, interaction guidance, and design system alignment for the PRD."
metadata:
  short-description: "Define UX journeys, interaction guidance, and design system alignment for the PRD."
---

# Skill: create_ux_design

## Purpose
Define UX journeys, interaction guidance, and design system alignment for the PRD.

## Inputs
- `artifacts/prd.md`
- `artifacts/product-brief.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Any existing design system references

## Output
- `artifacts/ux-spec.md` (use `templates/ux-spec.md`)

## Responsibilities
- Translate requirements into journeys, flows, and IA.
- Document interaction specs, design system alignment, and accessibility.
- Capture UX epics if needed.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Inventing UI that conflicts with provided design systems.
- Skipping accessibility considerations when relevant.

## Checklist
- [ ] Review PRD and product context
- [ ] Populate `artifacts/ux-spec.md` using the template
- [ ] Note open questions and dependencies
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
