# Integration Implementation Tasks

These tasks cover actual integration steps for Codex and Anti-Gravity.

## P0 — Codex (OpenAI)
- [x] Verify official Codex CLI + MCP configuration details
- [x] Create `.codex/config.toml` with required MCP server(s) for this repo
- [x] Add a Codex setup/run guide with concrete commands
- [x] Add a safety checklist for Codex execution approvals

## P0 — Anti-Gravity
- [x] Verify whether official Antigravity setup/config docs exist
- [x] If official docs exist: add setup steps and config artifacts
- [x] If official docs do not exist: document a safe, manual integration procedure and list open questions

## P0 — Antigravity Skills (official docs)
- [x] Read and summarize `https://antigravity.google/docs/skills`
- [x] Implement required skills folder structure in this repo (per official docs)
- [x] Add Antigravity skills setup steps to `docs/integrations/anti-gravity.md`
- [x] Add a mapping guide from repo `skills/` to Antigravity skills format

## P1 — Workflow wiring
- [x] Add a helper script or guide that maps skill outputs to artifact locations when running in Codex/Anti-Gravity
- [x] Ensure integration docs reference `docs/checklists/run-workflow.md` and artifact templates

## P0 — Antigravity Rules / Workflows (official docs)
- [x] Read and summarize `https://antigravity.google/docs/rules-workflows`
- [x] Add a dedicated doc mapping Antigravity rules/workflows to this repo
- [x] Update `docs/integrations/anti-gravity.md` with required setup steps
