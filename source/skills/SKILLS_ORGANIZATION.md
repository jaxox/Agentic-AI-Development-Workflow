# Skills Organization

Source of truth: `source/skills/` in this repository.

## Layout
Each skill is a folder with a `SKILL.md` file:
```
source/skills/<skill-name>/SKILL.md
```

## Sync Targets

Skills are distributed via symlinks (real folders + symlinked SKILL.md):

| Target | Path |
|---|---|
| Codex global | `~/.codex/skills/<name>/SKILL.md` |
| Antigravity global | `~/.gemini/antigravity/skills/<name>/SKILL.md` |
| Copilot global | `~/.copilot/skills/<name>/SKILL.md` |
| Claude global | `~/.claude/skills/<name>/SKILL.md` |
| AG global workflows | `~/.gemini/antigravity/global_workflows/<category>/<name>.md` |
| Per-project workflows | `<project>/.agent/workflows/<name>.md` |

## Sync & Validate

```bash
scripts/sync-skills.sh       # Distribute to all targets
scripts/validate-skills.sh   # Verify sync is correct
```

Target projects: `scripts/projects.conf`
