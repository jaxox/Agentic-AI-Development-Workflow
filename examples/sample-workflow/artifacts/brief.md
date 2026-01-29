# Brief

## Status
- State: DONE
- Owner: Example
- Last updated: 2026-01-29

## Inputs
- Source ticket or problem statement: Build a repeatable, testable agentic workflow from BMAD principles
- Links: docs/project/Agentic-AI-Development-Workflow.md

## Goals
- Convert BMAD roles into IDE skills with strict boundaries.
- Enforce artifact-first outputs with deterministic templates.
- Require verifiable test logs and diffs.

## Non-goals
- Building a full IDE plugin implementation.
- Replacing existing developer workflows.

## Constraints
- No assumptions; ask questions before generating outputs.
- No claiming tests passed without logs.
- No UI/service mock data unless behind an API boundary.

## Risks
- Skills may drift into overlapping responsibilities.
- Verification may be skipped if logs are not enforced.

## Open questions
- None.

## Acceptance definition
- Each workflow step outputs its required artifact.
- Workflow blocks when open questions exist or logs are missing.
- Codex + Anti-Gravity integrations are documented.

## References
- docs/project/Agentic-AI-Development-Workflow.md
