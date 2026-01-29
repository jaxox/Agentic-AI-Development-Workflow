# Tasks: Agentic AI Development Workflow

This task list is derived from `docs/project/Agentic-AI-Development-Workflow.md`. It is ordered by dependency and priority.

## P0 — Foundation (must-have to start)
- [x] Create repository structure for skills and workflow outputs
  - Acceptance: folders exist for `skills/`, `templates/`, `artifacts/`, `examples/`, `scripts/`, `context/`, `docs/specs/`, `docs/integrations/`, `docs/checklists/`
- [x] Document folder structure conventions
  - Acceptance: `docs/project/structure.md` exists with a tree and one-line purpose for each top-level folder
- [x] Define the Skill Contract spec (inputs, outputs, forbidden actions, status conventions)
  - Acceptance: `docs/specs/skill-contract.md` exists and matches sections 4 + 5 of the doc
- [x] Create standardized artifact templates for each step
  - Acceptance: `templates/brief.md`, `templates/prd.md`, `templates/architecture.md`, `templates/status.md` exist and include required headings
- [x] Create `/context/task.md` entry template and example
  - Acceptance: `templates/task.md` and `examples/context/task.md` exist

## P1 — Skills (one responsibility each)
- [x] `analyze_task` skill definition
  - Acceptance: prompt/spec exists; produces `brief.md` with goals, non-goals, constraints, risks, questions, acceptance definition
- [x] `define_requirements` skill definition
  - Acceptance: prompt/spec exists; produces `prd.md` with FR/NFR, user stories, MVP scope, exclusions
- [x] `design_system` skill definition
  - Acceptance: prompt/spec exists; produces `architecture.md` + diagram placeholder (Mermaid/PlantUML)
- [x] `implement_code` skill definition
  - Acceptance: prompt/spec exists; rules include mapping to PRD IDs and no mock UI; outputs code + tests + git diff
- [x] `verify_and_test` skill definition
  - Acceptance: prompt/spec exists; outputs test logs, failed tests list, coverage/gaps, rollback readiness
- [x] `run_workflow` skill definition
  - Acceptance: prompt/spec exists; outputs `status.md` with completed steps, blockers, confidence, next action

## P1 — Workflow harness
- [x] Build a simple orchestrator script or manual checklist
  - Acceptance: `scripts/run-workflow.sh` or `docs/checklists/run-workflow.md` exists and references each step
- [x] Gate enforcement rules
  - Acceptance: workflow defines “BLOCKED” when open questions exist or tests are missing

## P2 — Instrumentation and truth
- [x] Define test/verification logging format
  - Acceptance: `docs/specs/test-logging.md` specifies JUnit XML as the canonical format plus raw stdout/stderr log capture, and is referenced by `verify_and_test`
- [x] Define diff/metrics capture format
  - Acceptance: `docs/specs/metrics.md` exists; includes diff path and required metadata

## P2 — Integration targets (Codex / Anti-Gravity)
- [x] Create adapter notes for each IDE tool
  - Acceptance: `docs/integrations/codex.md`, `docs/integrations/anti-gravity.md` exist

## P3 — Examples and validation
- [x] End-to-end example workflow with dummy Jira ticket
  - Acceptance: example produces all artifacts in `examples/`
- [x] Review checklist and QA rubric
  - Acceptance: `docs/checklists/review.md` exists

## P3 — README expansion
- [x] Expand README with overview, quickstart, structure, and example walkthrough
  - Acceptance: `README.md` links to docs and shows how to run a workflow
