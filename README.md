# Agentic AI Development Workflow

A repeatable, testable, agent-based workflow that turns a ticket or problem statement into validated outputs inside IDE tools (Codex, Anti-Gravity).

## Why this exists
AI-assisted development often fails because it:
- Works task-by-task instead of end-to-end
- Loses context and invents results
- Reinvents UI/architecture instead of following existing patterns
- Skips tests or claims they ran without logs

This repo enforces **artifact-first**, **role-scoped skills**, and **truthful validation**.

## Quickstart

1) Create the input entry:
- Copy `templates/task.md` to `context/task.md`
- Fill in the ticket/problem statement and links

2) Run the workflow steps (manual checklist):
- Follow `docs/checklists/run-workflow.md`

3) Validate outputs:
- Ensure artifacts exist under `artifacts/`
- Ensure test logs and diff metrics are captured

## Repository structure
See `docs/project/structure.md` for the canonical layout.

## Skills integration
- Codex skills live in `.codex/skills/` and are loaded by Codex based on its skills search paths.
- Antigravity skills live in `.agent/skills/` and are loaded per workspace.
- Source of truth remains `skills/`; use the sync script to regenerate platform-specific skills.

Sync script:
```
scripts/sync-skills.sh        # both Codex + Antigravity
scripts/sync-skills.sh --codex
scripts/sync-skills.sh --agent
```

Validation script:
```
scripts/validate-skills.sh
```

## Core documents
- Project doc: `docs/project/Agentic-AI-Development-Workflow.md`
- Task list: `docs/project/tasks.md`
- Skill contract: `docs/specs/skill-contract.md`
- Test logging: `docs/specs/test-logging.md`
- Metrics/diff: `docs/specs/metrics.md`
- Shared Java standards: `docs/dev-guidelines/java-coding-standards.md`

## Workflow overview
1. Entry: `context/task.md`
2. Analyst: `artifacts/brief.md`
3. PM: `artifacts/prd.md`
4. Architect: `artifacts/architecture.md`
5. Developer: code + tests + diff
6. QA: JUnit XML + raw logs
7. Orchestrator: `artifacts/status.md`

## Integrations
- Codex: `docs/integrations/codex.md`
- Anti-Gravity: `docs/integrations/anti-gravity.md`
- Codex skills: `docs/integrations/codex-skills.md`
- Anti-Gravity skills: `docs/integrations/anti-gravity-skills.md`
- Anti-Gravity rules/workflows: `docs/integrations/anti-gravity-rules-workflows.md`

## Examples
- Example task entry: `examples/context/task.md`
- End-to-end sample workflow: `examples/sample-workflow/`

## Contributing
Use the skill contract and checklist to avoid assumptions and to keep outputs auditable.
