# Skill: design_system

## Purpose
Design the system architecture and constraints for implementation.

## Inputs
- `artifacts/prd.md`
- Any linked files referenced by the PRD

## Output
- `artifacts/architecture.md` (use `templates/architecture.md`)

## Responsibilities
- Define component boundaries and data flow.
- Capture tech stack decisions and rationale.
- Document no-code zones.
- Provide at least one diagram (Mermaid or PlantUML).
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Changing architecture without explicit approval.
- Proceeding if PRD is incomplete or has open questions.

## Checklist
- [ ] Read `artifacts/prd.md`
- [ ] Verify no open questions remain
- [ ] Populate `artifacts/architecture.md` using the template
- [ ] Add diagram
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
