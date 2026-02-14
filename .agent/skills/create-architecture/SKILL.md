---
name: create-architecture
description: "Design the system architecture and constraints for implementation."
metadata:
  short-description: "Design the system architecture and constraints for implementation."
---

# Skill: create_architecture

## Purpose
Design the system architecture and constraints for implementation.

## Inputs
- `artifacts/prd.md`
- `artifacts/ux-spec.md` if available
- Product context: `context/products/<product>.md` (preferred) or `context/product.md` (fallback); use `templates/product-profile.md`
- Repository docs and existing architecture references

## Output
- `artifacts/architecture.md` (use `templates/architecture.md`)

## Responsibilities
- Define system, data, API, frontend, integration, security, and deployment architecture.
- Capture ADRs, FR/NFR guidance, standards, and conventions.
- Document risks and open questions.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Changing stack without explicit approval.
- Omitting major risks or tradeoffs.

## Checklist
- [ ] Review PRD and UX inputs
- [ ] Populate `artifacts/architecture.md` using the template
- [ ] Note risks and open questions
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
