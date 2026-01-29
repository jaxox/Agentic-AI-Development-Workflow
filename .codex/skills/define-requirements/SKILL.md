---
name: define-requirements
description: "Convert the brief into a product requirements document (PRD)."
metadata:
  short-description: "Convert the brief into a product requirements document (PRD)."
---

# Skill: define_requirements

## Purpose
Convert the brief into a product requirements document (PRD).

## Inputs
- `artifacts/brief.md`
- Any linked files referenced by the brief

## Output
- `artifacts/prd.md` (use `templates/prd.md`)

## Responsibilities
- Define functional requirements (FR-xx) and non-functional requirements (NFR-xx).
- Write user stories in Given/When/Then format.
- Define MVP scope and explicit exclusions.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Adding requirements not grounded in inputs.
- Proceeding if brief contains open questions.

## Checklist
- [ ] Read `artifacts/brief.md`
- [ ] Verify no open questions remain
- [ ] Populate `artifacts/prd.md` using the template
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
