# Architecture

## Status
- State: DONE
- Owner: Example
- Last updated: 2026-01-29

## Overview
- A linear workflow of skills that transforms a task entry into validated artifacts.

## Component boundaries
- Inputs: `context/` task entry and linked docs.
- Skills: one file per responsibility in `skills/`.
- Templates: canonical structure in `templates/`.
- Artifacts: generated outputs in `artifacts/`.
- Validation: test logs and metrics in `artifacts/`.

## Data flow
- `context/task.md` → `artifacts/brief.md` → `artifacts/prd.md` → `artifacts/architecture.md` → code/tests → logs/metrics → `artifacts/status.md`

## Tech stack decisions
- Decision: Markdown for all artifacts
- Rationale: Human-readable, diff-friendly, tool-agnostic

## No-code zones
- Do not change existing UI/architecture unless explicitly approved in inputs.

## Diagrams

### Mermaid
```
flowchart LR
  A[context/task.md] --> B[brief.md]
  B --> C[prd.md]
  C --> D[architecture.md]
  D --> E[code + tests]
  E --> F[test logs + metrics]
  F --> G[status.md]
```

### PlantUML
```
@startuml
actor User
User -> Analyst : task.md
Analyst --> PM : brief.md
PM --> Architect : prd.md
Architect --> Developer : architecture.md
Developer --> QA : code + tests
QA --> Orchestrator : logs + metrics
Orchestrator --> User : status.md
@enduml
```

## Risks
- Skipping gates if status is not enforced.

## Open questions
- None.
