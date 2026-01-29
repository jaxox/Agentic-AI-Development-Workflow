# Metrics & Diff Capture Specification

## Goals
- Ensure code changes are traceable to requirements.
- Provide minimal, consistent metadata for change review.
- Capture diffs and execution metadata without requiring a specific VCS provider.

## Required artifacts (per workflow run)
Store metrics under `artifacts/metrics/` using the same `<run-id>` scheme as test logs.

- Change metadata: `artifacts/metrics/meta/<run-id>.json`
- Diff bundle: `artifacts/metrics/diff/<run-id>.patch`
- File list: `artifacts/metrics/files/<run-id>.txt`

## Run ID format
Reuse the test logging format:
`<suite>__<yyyy-mm-ddThh-mm-ssZ>__<short-sha>`

## Metadata schema (minimum)
`meta/<run-id>.json` MUST include:
- `run_id` (string)
- `timestamp_utc` (ISO 8601)
- `git_sha` (string, if available)
- `branch` (string, if available)
- `author` (string, if available)
- `command` (string) — e.g., script or tool used
- `diff_path` (string)
- `files_path` (string)
- `requirements_map` (object) — map of PRD IDs to files/commits

## Diff capture
- Use a unified diff patch format.
- If git is present, preferred command:
  - `git diff --patch --stat > artifacts/metrics/diff/<run-id>.patch`
- If git is unavailable, provide a tool-specific diff or note the limitation in metadata.

## File list
- If git is present, preferred command:
  - `git diff --name-only > artifacts/metrics/files/<run-id>.txt`

## Requirements mapping
- Each change MUST map to a PRD ID (FR/NFR), stored in `requirements_map`.
- If a mapping is missing, the workflow is incomplete and must be marked BLOCKED.

## Consumer expectations
- `run_workflow` MUST check that diff + file list + metadata exist.
- `implement_code` MUST update `requirements_map`.

## References
- `docs/specs/skill-contract.md`
- `docs/specs/test-logging.md`
