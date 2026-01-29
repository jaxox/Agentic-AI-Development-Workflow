---
name: analyze-task
description: "Analyze the input task and produce a `brief.md` artifact that defines scope, risks, and acceptance definition."
---

# Skill: analyze_task

## Purpose
Analyze the input task and produce a `brief.md` artifact that defines scope, risks, and acceptance definition.

## Inputs
- `context/task.md`
- Any linked files referenced by the task entry

## Output
- `artifacts/brief.md` (use `templates/brief.md`)

## Responsibilities
- Extract goals, non-goals, constraints, risks, open questions, acceptance definition.
- Ask questions before generating output if required inputs are missing.
- Set `Status.State` to NEEDS INPUT, BLOCKED, or DONE as appropriate.

## Forbidden
- Making assumptions not grounded in inputs.
- Advancing the workflow if open questions remain.

## Checklist
- [ ] Read `context/task.md`
- [ ] Identify missing inputs and ask questions if needed
- [ ] Populate `artifacts/brief.md` using the template
- [ ] Set `Status.State`
- [ ] Summarize actions and blockers
