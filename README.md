# Agentic AI Development Workflow

A repeatable, testable, agent-based workflow that turns a ticket or problem statement into validated outputs inside IDE tools (Codex, Antigravity, Copilot, Claude).

## Repository structure

```
source/
  skills/              ← Source of truth for all skills
    <skill-name>/
      SKILL.md
  rules/               ← Agent rules (coding standards, etc.)
scripts/
  sync-skills.sh       ← Distribute skills to global targets + workflow wrappers
  validate-skills.sh   ← Validate sync is correct
  projects.conf        ← Target projects for workflow wrapper sync
docs/                  ← Project documentation
```

## Skills architecture

### Why this exists

This repo is the **single source of truth** for agent skills. It distributes skills via symlinks to all supported tools, so skills stay in sync across platforms.

### Global discovery paths

| Platform | Global Path |
|---|---|
| **Antigravity** | `~/.gemini/antigravity/skills/<name>/` |
| **Codex** | `~/.codex/skills/<name>/` |
| **Copilot** | `~/.copilot/skills/<name>/SKILL.md` |
| **Claude** | `~/.claude/skills/<name>/SKILL.md` |

### How sync works

`source/skills/` is the single source of truth. The sync script supports two link strategies:

```
--link-mode hybrid (default)
  - Codex / Antigravity / Agent: symlink the whole skill directory
  - Copilot / Claude: symlink only SKILL.md

--link-mode dir
  - symlink the whole skill directory for all targets

--link-mode file
  - create real folders and symlink only SKILL.md for all targets
```

Default (`hybrid`) keeps centralized syncing while avoiding the Codex "SKILL.md symlink only" discovery issue.

```
source/skills/<name>/            (SOURCE — this repo)
     │
     ├──→ ~/.codex/skills/<name>                        (dir symlink)
     ├──→ ~/.gemini/antigravity/skills/<name>           (dir symlink)
     ├──→ ~/.copilot/skills/<name>/SKILL.md             (file symlink)
     ├──→ ~/.claude/skills/<name>/SKILL.md              (file symlink)
     │
     └──→ Workflow wrappers (Antigravity slash commands):
          ├──→ ~/.gemini/antigravity/global_workflows/<category>/<name>.md
          └──→ <project>/.agent/workflows/<name>.md
```

### Workflow wrappers

Antigravity uses `/` slash commands to invoke workflows, not skills. The sync script auto-generates thin wrapper workflows that point to the global skill path, so you can type `/java-pre-commit-review` from any project.

### Commands

```bash
scripts/sync-skills.sh              # Sync everything (default)
scripts/sync-skills.sh --skills     # Skills only
scripts/sync-skills.sh --workflows  # Workflow wrappers only
scripts/sync-skills.sh --link-mode dir
scripts/sync-skills.sh --link-mode file
scripts/sync-skills.sh --dry-run    # Preview changes

scripts/validate-skills.sh          # Validate everything
scripts/validate-skills.sh --link-mode dir
scripts/validate-skills.sh --link-mode file
```

### Adding a skill

1. Create `source/skills/<skill-name>/SKILL.md` with YAML frontmatter (`name`, `description`)
2. Run `scripts/sync-skills.sh`
3. Run `scripts/validate-skills.sh`

### Adding a target project

Add the project's absolute path to `scripts/projects.conf`, then re-run sync.
