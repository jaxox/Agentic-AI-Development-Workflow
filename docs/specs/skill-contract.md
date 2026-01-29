# Skill Contract Specification

This contract defines the required behavior, inputs, outputs, and failure modes for all skills in the workflow. It is derived from the project doc and is mandatory for every skill.

## Scope
Applies to all skills (e.g., `analyze_task`, `define_requirements`, `design_system`, `implement_code`, `verify_and_test`, `run_workflow`).

## Core principles
- Artifact-first: a skill is only considered successful if it produces the required artifacts.
- Explicit inputs only: no assumptions and no hidden dependencies.
- Deterministic structure: outputs must match the defined templates/sections.
- Truthfulness: never claim tests passed without logs.

## Inputs (required)
Each skill MUST explicitly receive or load:
- Source input(s): ticket text, problem statement, or referenced files.
- Links/refs: only those provided by the user or prior artifacts.
- Constraints: provided in `brief.md` or `prd.md` (if applicable).

If any required input is missing, the skill MUST respond with `NEEDS INPUT` or `BLOCKED` and list the exact missing items.

## Output requirements (global)
Every skill MUST:
- Produce a named artifact file in the correct location.
- Include a `Status` section with `State` (NEEDS INPUT | BLOCKED | DONE), `Owner`, `Last updated`.
- Include a short “Open questions” section when uncertainty exists.
- Avoid free-form output outside the artifact file (except to summarize actions taken).

## Forbidden behavior
- Claiming tests passed without attached logs.
- Creating mock data in UI/services.
- Changing architecture or tech stack without explicit approval.
- Inventing new visual styles/themes when an existing system exists.
- Collapsing multiple responsibilities into one skill.

## Status semantics
- **NEEDS INPUT**: Required information is missing; list missing items explicitly.
- **BLOCKED**: A dependency or gate failed (e.g., unanswered questions, missing logs).
- **DONE**: All required outputs exist and checks pass.

## Gate enforcement
- If `brief.md` contains open questions, the workflow MUST not advance.
- If `verify_and_test` has missing/unreadable logs, the workflow MUST fail.
- If `implement_code` output does not map changes to PRD IDs, it MUST be treated as incomplete.

## Skill-specific output contracts

### `analyze_task`
- Output: `artifacts/brief.md` (from `templates/brief.md`).
- Must include: goals, non-goals, constraints, risks, open questions, acceptance definition.

### `define_requirements`
- Output: `artifacts/prd.md` (from `templates/prd.md`).
- Must include: FR/NFR list, user stories, MVP scope, explicit exclusions.

### `design_system`
- Output: `artifacts/architecture.md` (from `templates/architecture.md`).
- Must include: component boundaries, data flow, tech stack decisions, no-code zones, diagrams.

### `implement_code`
- Output: code + tests + git diff.
- Must include: mapping to PRD IDs in commit messages or change notes.
- Must NOT include UI/service mock data unless behind an explicit API boundary.

### `verify_and_test`
- Output: test logs + failed tests list + coverage/gaps + rollback readiness.
- Must comply with `docs/specs/test-logging.md`.

### `run_workflow`
- Output: `artifacts/status.md` (from `templates/status.md`).
- Must include: completed steps, blockers, confidence level, next action.

## Artifact locations
Default output locations:
- `artifacts/brief.md`
- `artifacts/prd.md`
- `artifacts/architecture.md`
- `artifacts/status.md`
- `artifacts/test-logs/` (per `docs/specs/test-logging.md`)

If a skill writes elsewhere, it MUST document the reason in the artifact and update the workflow status.
