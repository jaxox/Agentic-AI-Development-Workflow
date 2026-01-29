# Antigravity Rules & Workflows Mapping

This doc summarizes the Antigravity “Rules / Workflows” documentation and maps it to this repo.

## Rules (official summary)
- Rules are manually defined constraints that guide the agent.
- A rule is a Markdown file and is limited to 12,000 characters.
- Global rules live at `~/.gemini/GEMINI.md` and apply across all workspaces.
- Workspace rules live in `.agent/rules/` at the workspace or git root.
- Rule activation modes:
  - Manual: activated via @ mention in the agent input.
  - Always On: always applied.
  - Model Decision: model decides based on the rule’s description.
  - Glob: applied based on file glob patterns (e.g., `*.js`, `src/**/`, `*.ts`).
- Rules can reference other files with `@filename`:
  - Relative paths resolve from the rules file location.
  - Absolute paths are resolved as absolute; if missing, they fall back to workspace-relative.

## Workflows (official summary)
- Workflows are Markdown files that define a series of steps for the agent.
- Created via the Workflows panel in the editor’s Customizations menu.
- Each workflow includes a title, description, and step list.
- Workflows are limited to 12,000 characters.
- Invoked with `/workflow-name` and can call other workflows (e.g., “Call /workflow-2”).
- Agents can generate workflows from existing conversations.

## Mapping to this repo
- Workspace rules location: `.agent/rules/`
- Suggested workflow name: `/bmad-workflow` (local to your workspace)

## Recommended rule set (starter)
Create rules that enforce this repo’s contract:
- No assumptions; ask questions before producing outputs.
- Artifacts must follow templates in `templates/`.
- Tests must include JUnit XML + raw logs (see `docs/specs/test-logging.md`).
- No mock UI/service data unless behind an API boundary.

## References
- `docs/specs/skill-contract.md`
- `docs/checklists/run-workflow.md`
- `docs/integrations/workflow-wiring.md`
