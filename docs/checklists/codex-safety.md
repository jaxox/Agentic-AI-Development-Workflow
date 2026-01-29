# Codex Safety Checklist

Use this checklist before running Codex on real tasks.

## Approvals
- [ ] Require approval for any shell command execution.
- [ ] Require approval for file writes outside `artifacts/`.
- [ ] Review diffs before allowing write actions.

## Scope control
- [ ] Run from the repo root to avoid unintended paths.
- [ ] Keep changes within the project directory.
- [ ] Avoid running Codex with escalated permissions unless needed.

## Execution hygiene
- [ ] Prefer a dedicated branch for experiments.
- [ ] Ensure test commands are explicit and logged.
- [ ] Capture JUnit XML + raw logs per `docs/specs/test-logging.md`.

## Post-run review
- [ ] Verify artifacts are complete and status is DONE.
- [ ] Confirm no unexpected file deletions or large refactors.
- [ ] Update `artifacts/status.md` with blockers/next action.
