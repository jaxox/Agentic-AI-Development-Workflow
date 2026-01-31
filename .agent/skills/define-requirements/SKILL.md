---
name: define-requirements
description: "Convert the brief into a product requirements document (PRD)."
---

# Skill: define_requirements

## Purpose
Convert the brief into a product requirements document (PRD).

## Inputs
- `artifacts/brief.md` or `artifacts/product-brief.md`
- `artifacts/research.md` if available
- Any linked files or constraints

## Output
- `artifacts/prd.md` (use `templates/prd.md`)

## Responsibilities
- Define functional and non-functional requirements.
- Include personas, success metrics, risks, and assumptions.
- Provide acceptance criteria and scope boundaries.
- Ask questions before generating output if required inputs are missing.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Making assumptions not grounded in inputs.
- Advancing the workflow if open questions remain.

## Checklist
- [ ] Read the brief and research inputs
- [ ] Identify missing inputs and ask questions if needed
- [ ] Populate `artifacts/prd.md` using the template
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
