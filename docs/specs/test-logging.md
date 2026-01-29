# Test Logging Specification

## Goals
- Provide a machine-readable, CI-friendly test results format.
- Preserve raw stdout/stderr for debugging.
- Ensure deterministic artifact paths and minimal metadata for traceability.

## Canonical formats
- Primary: JUnit XML (xUnit-style) for test results.
- Secondary: Raw stdout/stderr logs captured as text.

Rationale: JUnit XML is broadly consumed by CI systems (e.g., Jenkins) and is natively emitted by common test frameworks (e.g., pytest). GitHub Actions examples also use JUnit XML outputs, making it a practical cross-tool default. Raw logs provide the full context needed to debug failures.

## Required artifacts (per test run)
Store artifacts under `artifacts/test-logs/` with a stable, run-scoped name.

- JUnit XML: `artifacts/test-logs/junit/<run-id>.xml`
- Raw logs: `artifacts/test-logs/raw/<run-id>.log`
- Metadata: `artifacts/test-logs/meta/<run-id>.json`

`<run-id>` SHOULD be deterministic and unique for the run, e.g.:
`<suite>__<yyyy-mm-ddThh-mm-ssZ>__<short-sha>`

## Metadata schema (minimum)
`meta/<run-id>.json` MUST include:
- `run_id` (string)
- `timestamp_utc` (ISO 8601)
- `duration_ms` (number)
- `command` (string)
- `exit_code` (number)
- `working_dir` (string)
- `git_sha` (string, if available)
- `ci` (object: provider, job, run_url if available)
- `junit_paths` (array of strings)
- `raw_log_path` (string)

## Producer guidance
- Prefer xunit2-compatible JUnit XML when supported by the tool (pytest defaults to xunit2).
- Do not truncate raw logs. If logs are large, split but keep an index file.

### Example: pytest
```
pytest tests/ --junitxml=artifacts/test-logs/junit/<run-id>.xml
```
Capture stdout/stderr to `artifacts/test-logs/raw/<run-id>.log` alongside the JUnit file.

## Consumer expectations
- `verify_and_test` MUST fail if JUnit XML is missing or unreadable.
- `verify_and_test` MUST attach or link raw logs for any failure.

## References
- Jenkins JUnit plugin (consumes JUnit XML): https://plugins.jenkins.io/junit
- pytest `--junitxml` option and `junit_family` defaults: https://docs.pytest.org/en/stable/_modules/_pytest/junitxml.html
- GitHub Actions example using pytest `--junitxml`: https://docs.github.com/en/actions/how-tos/writing-workflows/building-and-testing/building-and-testing-python
