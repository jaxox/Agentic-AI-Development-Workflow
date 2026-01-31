# Skill: design_system

## Purpose
Design the system architecture and constraints for implementation.

## Inputs
- `artifacts/prd.md`
- `artifacts/ux-spec.md` if available
- Any linked files or constraints

## Output
- `artifacts/architecture.md` (use `templates/architecture.md`)

## Responsibilities
- Define system, data, API, frontend, integration, security, and deployment architecture.
- Capture ADRs, FR/NFR guidance, standards, and conventions.
- Ask questions before generating output if required inputs are missing.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Making assumptions not grounded in inputs.
- Advancing the workflow if open questions remain.

## Checklist
- [ ] Read `artifacts/prd.md` and `artifacts/ux-spec.md` if present
- [ ] Identify missing inputs and ask questions if needed
- [ ] Populate `artifacts/architecture.md` using the template
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
