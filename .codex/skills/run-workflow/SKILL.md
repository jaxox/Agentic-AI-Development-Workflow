---
name: run-workflow
description: "Orchestrate the full workflow and produce a status summary."
metadata:
  short-description: "Orchestrate the full workflow and produce a status summary."
---

# Skill: run_workflow

## Purpose
Orchestrate the full workflow and produce a status summary.

## Inputs
- `artifacts/brief.md`
- `artifacts/prd.md`
- `artifacts/architecture.md`
- Test logs per `docs/specs/test-logging.md`

## Output
- `artifacts/status.md` (use `templates/status.md`)

## Responsibilities
- Validate that prior artifacts exist and are complete.
- Identify blockers and missing inputs.
- Provide a confidence level and next action.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Marking workflow DONE when any step is incomplete.

## Checklist
- [ ] Verify artifacts exist and states are DONE
- [ ] Check test logs are present and readable
- [ ] Populate `artifacts/status.md` using the template
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
