# Antigravity Skills Mapping

This doc maps the repo's skill definitions to the Antigravity skills format and summarizes the official skills doc.

## Skills summary (official docs)
- Skills live in one of two locations:
  - Workspace: `<workspace-root>/.agent/skills/<skill-folder>/`
  - Global: `~/.gemini/antigravity/global_skills/<skill-folder>/`
- Each skill requires a `SKILL.md` file with YAML frontmatter at the top.
- Frontmatter fields:
  - `description` (required): clear description of what the skill does and when to use it.
  - `name` (optional): unique identifier; defaults to the folder name if omitted.
- Optional folders inside a skill:
  - `scripts/`, `examples/`, `resources/`
- Agent uses skills via progressive disclosure:
  - Discovery: sees names + descriptions
  - Activation: reads full `SKILL.md`
  - Execution: follows instructions
- Best practices:
  - Keep skills focused
  - Write clear descriptions
  - Use scripts as black boxes (run `--help` first)
  - Include decision trees for complex skills

## Repo mapping
This repo keeps human-readable skill specs in `skills/` and provides Antigravity-ready skills under `.agent/skills/`.

Mapping:
- `skills/analyze_task.md` → `.agent/skills/analyze-task/SKILL.md`
- `skills/define_requirements.md` → `.agent/skills/define-requirements/SKILL.md`
- `skills/design_system.md` → `.agent/skills/design-system/SKILL.md`
- `skills/implement_code.md` → `.agent/skills/implement-code/SKILL.md`
- `skills/verify_and_test.md` → `.agent/skills/verify-and-test/SKILL.md`
- `skills/run_workflow.md` → `.agent/skills/run-workflow/SKILL.md`

## Update guidance
- Treat `skills/` as the source of truth.
- When a skill changes, update the corresponding `.agent/skills/*/SKILL.md`.
- Keep descriptions concise and aligned with the skill's responsibility.
