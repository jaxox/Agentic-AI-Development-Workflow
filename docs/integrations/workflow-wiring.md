# Workflow Wiring Guide (Codex + Anti-Gravity)

This guide maps each skill to its inputs and outputs so IDE agents can run the workflow consistently.

## Inputs
- Entry point: `context/task.md`
- Templates: `templates/`
- Specs: `docs/specs/`

## Skill-to-artifact mapping
- `analyze_task` → `artifacts/brief.md` (from `templates/brief.md`)
- `define_requirements` → `artifacts/prd.md` (from `templates/prd.md`)
- `design_system` → `artifacts/architecture.md` (from `templates/architecture.md`)
- `implement_code` → code + tests + diff (PRD IDs in notes)
- `verify_and_test` → test logs in `artifacts/test-logs/`
- `run_workflow` → `artifacts/status.md` (from `templates/status.md`)

## Execution order
Follow `docs/checklists/run-workflow.md` and enforce gates at each step.

## Output rules
- Write artifacts only to `artifacts/`.
- Use the templates as the canonical structure.
- Mark `Status.State` as NEEDS INPUT, BLOCKED, or DONE.

## Notes for IDE agents
- Always read required inputs before writing outputs.
- If inputs are missing, stop and request them explicitly.
- Do not claim tests passed without logs.
