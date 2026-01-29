# Repository Structure

This repository is organized to keep skills, templates, artifacts, and workflow docs separate and easy to scan.

## Tree (top level)

```
context/
.agent/
.codex/
docs/
skills/
templates/
artifacts/
examples/
scripts/
README.md
```

## Purpose

- `context/` — Entry point inputs for a workflow run (e.g., `context/task.md`).
- `.agent/` — Antigravity workspace config (skills in `.agent/skills/`, rules in `.agent/rules/`).
- `.codex/` — Codex team config and Codex skills (`.codex/config.toml`, `.codex/skills/`).
- `docs/` — Specifications, checklists, integration notes, and project docs.
- `skills/` — Skill definitions (one responsibility per skill).
- `templates/` — Canonical artifact templates for each workflow step.
- `artifacts/` — Generated outputs from running the workflow.
- `examples/` — End-to-end examples and sample inputs/outputs.
- `scripts/` — Orchestration helpers and validation tools.

## Docs subfolders

- `docs/specs/` — Formal specs (skill contract, logging, metrics).
- `docs/integrations/` — Notes and adapters for target IDE tools.
- `docs/checklists/` — Review and runbook checklists.
- `docs/project/` — Project framing, plans, and task lists.
