# Run Workflow Checklist

This checklist is the minimal operational path from a ticket/problem statement to validated outputs. Each step MUST produce the required artifact and set a valid `Status` state (NEEDS INPUT | BLOCKED | DONE).

## 0) Entry point
- [ ] Create `context/task.md` from `templates/task.md`.
- [ ] Confirm all source inputs/links are included.
- [ ] If inputs are incomplete, mark `context/task.md` as NEEDS INPUT.

## 1) Analyst — `analyze_task`
- [ ] Generate `artifacts/brief.md` from `templates/brief.md`.
- [ ] Fill goals, non-goals, constraints, risks, open questions, acceptance definition.
- [ ] If open questions exist, set state to NEEDS INPUT and STOP.

## 2) PM — `define_requirements`
- [ ] Generate `artifacts/prd.md` from `templates/prd.md`.
- [ ] Define FR/NFR list, user stories, MVP scope, exclusions.
- [ ] If requirements are incomplete, set state to NEEDS INPUT and STOP.

## 3) Architect — `design_system`
- [ ] Generate `artifacts/architecture.md` from `templates/architecture.md`.
- [ ] Document component boundaries, data flow, tech stack decisions, no-code zones.
- [ ] Add diagram (Mermaid or PlantUML).
- [ ] If architectural questions remain, set state to NEEDS INPUT and STOP.

## 4) Developer — `implement_code`
- [ ] Implement changes mapped to PRD IDs.
- [ ] Avoid mock data in UI/services unless behind an API boundary.
- [ ] Produce code + tests + git diff.

## 5) QA — `verify_and_test`
- [ ] Run tests and produce JUnit XML in `artifacts/test-logs/junit/`.
- [ ] Capture raw stdout/stderr in `artifacts/test-logs/raw/`.
- [ ] Write metadata in `artifacts/test-logs/meta/`.
- [ ] List failed tests and gaps if any; if missing logs, set state to BLOCKED.

## 6) Orchestrator — `run_workflow`
- [ ] Generate `artifacts/status.md` from `templates/status.md`.
- [ ] Mark completed steps, blockers, confidence level, next action.
- [ ] If any prior step is NEEDS INPUT or BLOCKED, reflect that in status.

## 7) Final gate
- [ ] Confirm all artifacts exist and states are DONE.
- [ ] If any step is not DONE, halt and request missing inputs.

## References
- `docs/specs/skill-contract.md`
- `docs/specs/test-logging.md`
