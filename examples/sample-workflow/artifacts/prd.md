# PRD

## Status
- State: DONE
- Owner: Example
- Last updated: 2026-01-29

## Functional requirements
- FR-01: Generate a brief artifact with goals, constraints, risks, and acceptance definition.
- FR-02: Generate a PRD artifact with FR/NFR, user stories, MVP scope, exclusions.
- FR-03: Generate an architecture artifact with component boundaries and diagrams.
- FR-04: Enforce test logging with JUnit XML + raw logs.
- FR-05: Produce a workflow status artifact summarizing blockers and next action.

## Non-functional requirements
- NFR-01: Artifacts must be deterministic and follow templates.
- NFR-02: No claims of test success without logs.
- NFR-03: Skills remain single-responsibility.

## User stories
- US-01: Given a problem statement, when I run the workflow, then I receive a complete set of artifacts.
- US-02: Given missing inputs, when the analyst runs, then the workflow stops with NEEDS INPUT.

## MVP scope
- Define skill contracts, templates, and a run checklist.
- Provide integrations for Codex and Anti-Gravity.

## Explicit exclusions
- Building a production IDE plugin.
- Automated project management integrations.

## Dependencies
- docs/specs/skill-contract.md
- docs/specs/test-logging.md

## Open questions
- None.

## Acceptance criteria
- All required artifacts exist under `artifacts/`.
- Test logs and metrics are captured per specs.
