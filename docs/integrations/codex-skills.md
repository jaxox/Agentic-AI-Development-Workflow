# Codex Skills Mapping

This doc summarizes the Codex skills documentation and maps it to this repo.

## Skills summary (official docs)
- Skills are defined by a `SKILL.md` file inside a skill folder.
- Optional folders inside a skill: `scripts/`, `references/`, `assets/`.
- Codex uses progressive disclosure: first reads name/description, then full instructions when invoked.
- Invocation:
  - Explicit: `/skills` or `$skill-name` in the prompt.
  - Implicit: Codex selects a skill when task matches the description.
- `SKILL.md` must include `name` and `description`; `metadata.short-description` is optional.
- Skills can be disabled via `[[skills.config]]` in `~/.codex/config.toml` (experimental).
- After installing or changing skills, restart Codex.

## Where Codex loads skills (precedence)
From highest to lowest (collisions resolved by higher precedence):
- `$CWD/.codex/skills`
- `$CWD/../.codex/skills`
- `$REPO_ROOT/.codex/skills`
- `$CODEX_HOME/skills` (default: `~/.codex/skills` on macOS/Linux)
- `/etc/codex/skills`
- Bundled system skills

Symlinked skill folders are supported.

## Repo mapping
This repo keeps human-readable specs in `skills/` and provides Codex-ready skills under `.codex/skills/`.

Mapping:
- `skills/analyze_task.md` → `.codex/skills/analyze-task/SKILL.md`
- `skills/define_requirements.md` → `.codex/skills/define-requirements/SKILL.md`
- `skills/design_system.md` → `.codex/skills/design-system/SKILL.md`
- `skills/implement_code.md` → `.codex/skills/implement-code/SKILL.md`
- `skills/verify_and_test.md` → `.codex/skills/verify-and-test/SKILL.md`
- `skills/run_workflow.md` → `.codex/skills/run-workflow/SKILL.md`

## Update guidance
- Treat `skills/` as the source of truth.
- When a skill changes, update the corresponding `.codex/skills/*/SKILL.md`.
- Keep descriptions concise and aligned with the skill's responsibility.
