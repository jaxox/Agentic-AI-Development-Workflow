#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# sync-skills.sh — Distribute skills from source/skills/ to global targets
#
# Source of truth: source/skills/<name>/SKILL.md (in this repo)
#
# Targets (configurable symlink strategy):
#   - directory symlink: ~/.codex/skills/<name> -> source/skills/<name>
#   - file symlink:      ~/.codex/skills/<name>/SKILL.md -> source/skills/<name>/SKILL.md
#
# Workflow wrappers (for Antigravity / slash commands):
#   ~/.gemini/antigravity/global_workflows/<category>/<name>.md
#   <project>/.agent/workflows/<name>.md  (per project from projects.conf)
# ==============================================================================

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src_dir="$root_dir/source/skills"
projects_conf="$root_dir/scripts/projects.conf"

# All global skill targets
declare -a GLOBAL_TARGET_NAMES=(
  "Codex"
  "Antigravity"
  "Copilot"
  "Claude"
  "Agent"
)

declare -a GLOBAL_TARGETS=(
  "${HOME}/.codex/skills"
  "${HOME}/.gemini/antigravity/skills"
  "${HOME}/.copilot/skills"
  "${HOME}/.claude/skills"
  "${HOME}/.agent/skills"
)

# Default link mode per target. "hybrid" uses this table.
declare -a GLOBAL_DEFAULT_LINK_MODES=(
  "dir"  # Codex
  "dir"  # Antigravity
  "file" # Copilot
  "file" # Claude
  "dir"  # Agent
)

ag_global_workflows="${HOME}/.gemini/antigravity/global_workflows"

sync_skills=1
sync_workflows=1
dry_run=0
link_mode="hybrid"

resolve_target_link_mode() {
  local index="$1"
  case "$link_mode" in
    hybrid) echo "${GLOBAL_DEFAULT_LINK_MODES[$index]}" ;;
    dir|file) echo "$link_mode" ;;
    *) echo "ERROR: Invalid link mode '$link_mode'. Use: hybrid, dir, or file." >&2; exit 1 ;;
  esac
}

usage() {
  cat <<'USAGE'
Usage: sync-skills.sh [OPTIONS]

Distribute skills from source/skills/ to global targets via symlinks.

Options:
  --skills       Sync skills only (no workflow wrappers)
  --workflows    Sync workflow wrappers only (no skills)
  --link-mode    Link strategy: hybrid (default), dir, or file
  --dry-run      Show what would be done without making changes
  --help         Show this help

By default, both skills and workflows are synced.
USAGE
}

if [ $# -gt 0 ]; then
  sync_skills=0
  sync_workflows=0
  while [ $# -gt 0 ]; do
    case "$1" in
      --skills) sync_skills=1 ;;
      --workflows) sync_workflows=1 ;;
      --dry-run) dry_run=1; sync_skills=1; sync_workflows=1 ;;
      --link-mode)
        shift
        if [ $# -eq 0 ]; then
          echo "ERROR: --link-mode requires a value: hybrid, dir, or file" >&2
          usage
          exit 1
        fi
        link_mode="$1"
        ;;
      --help) usage; exit 0 ;;
      *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
    esac
    shift
  done
fi

if [ ! -d "$src_dir" ]; then
  echo "ERROR: Missing source skills directory: $src_dir" >&2
  exit 1
fi

# Count skills
skill_count=0
for skill_dir in "$src_dir"/*/; do
  [ -f "$skill_dir/SKILL.md" ] && skill_count=$((skill_count + 1))
done
echo "Found $skill_count skills in $src_dir"
echo "Skill link mode: $link_mode"

# ==============================================================================
# Sync skills to global targets
# ==============================================================================

if [ "$sync_skills" -eq 1 ]; then
  echo ""
  echo "Syncing skills to global targets..."

  for skill_dir in "$src_dir"/*/; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    name="$(basename "$skill_dir")"
    abs_skill_dir="$(cd "$skill_dir" && pwd)"
    abs_src_file="$(cd "$skill_dir" && pwd)/SKILL.md"

    for i in "${!GLOBAL_TARGETS[@]}"; do
      target_root="${GLOBAL_TARGETS[$i]}"
      target_label="${GLOBAL_TARGET_NAMES[$i]}"
      target_mode="$(resolve_target_link_mode "$i")"
      target_dir="$target_root/$name"
      target_file="$target_dir/SKILL.md"

      if [ "$dry_run" -eq 1 ]; then
        if [ "$target_mode" = "dir" ]; then
          echo "  [dry-run][$target_label][dir] $target_dir → $abs_skill_dir"
        else
          echo "  [dry-run][$target_label][file] $target_file → $abs_src_file"
        fi
        continue
      fi

      mkdir -p "$target_root"
      if [ "$target_mode" = "dir" ]; then
        if [ -L "$target_dir" ]; then
          rm -f "$target_dir"
        elif [ -e "$target_dir" ]; then
          rm -rf "$target_dir"
        fi
        ln -s "$abs_skill_dir" "$target_dir"
      else
        if [ -L "$target_dir" ] || [ -f "$target_dir" ]; then
          rm -f "$target_dir"
        fi
        mkdir -p "$target_dir"
        rm -f "$target_file"
        ln -s "$abs_src_file" "$target_file"
      fi
    done
  done

  if [ "$dry_run" -eq 0 ]; then
    echo "  Synced $skill_count skills to ${#GLOBAL_TARGETS[@]} global targets"
  fi
fi

# ==============================================================================
# Generate and sync workflow wrappers
# ==============================================================================

if [ "$sync_workflows" -eq 1 ]; then
  echo ""
  echo "Generating workflow wrappers..."

  categorize_skill() {
    local name="$1"
    case "$name" in
      java-*|integration-test-*|unit-test-*|regenerate-project-md-backend)
        echo "java" ;;
      frontend-*|refactor-old-js-*|refactor-ts-*|regenerate-project-md-frontend|react-*|shadcn-*|stitch-*)
        echo "frontend" ;;
      *)
        echo "general" ;;
    esac
  }

  extract_description() {
    local file="$1"
    awk '
      BEGIN { in_fm=0; desc="" }
      NR==1 && $0=="---" { in_fm=1; next }
      in_fm && $0=="---" { exit }
      in_fm && /^description:/ {
        sub(/^description:[[:space:]]*"?/, "")
        sub(/"[[:space:]]*$/, "")
        desc=$0
      }
      END { if (desc != "") print desc; else print "Invoke the skill." }
    ' "$file"
  }

  generate_wrapper() {
    local name="$1"
    local description="$2"
    local target_file="$3"

    if [ "$dry_run" -eq 1 ]; then
      echo "  [dry-run] Would generate wrapper: $target_file"
      return
    fi

    mkdir -p "$(dirname "$target_file")"
    cat > "$target_file" <<WRAPPER
---
description: $description
---

# $name

> This is a workflow wrapper. It invokes the **$name** skill.

Run the **$name** skill by reading its SKILL.md and following the instructions exactly.

Skill location: \`~/.gemini/antigravity/skills/$name/SKILL.md\`
WRAPPER
  }

  for skill_dir in "$src_dir"/*/; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    name="$(basename "$skill_dir")"
    src_file="$skill_dir/SKILL.md"
    description="$(extract_description "$src_file")"
    category="$(categorize_skill "$name")"

    # Global workflow wrapper
    generate_wrapper "$name" "$description" "$ag_global_workflows/$category/$name.md"
  done

  if [ "$dry_run" -eq 0 ]; then
    echo "  Generated $skill_count workflow wrappers"
  fi

  # Sync to per-project .agent/workflows/
  if [ -f "$projects_conf" ]; then
    echo ""
    echo "Syncing workflow wrappers to projects..."

    while IFS= read -r project_path || [ -n "$project_path" ]; do
      [[ "$project_path" =~ ^[[:space:]]*# ]] && continue
      [[ -z "$project_path" ]] && continue
      project_path="${project_path%%#*}"
      project_path="$(echo "$project_path" | xargs)"

      if [ ! -d "$project_path" ]; then
        echo "  WARN: Project not found, skipping: $project_path" >&2
        continue
      fi

      project_workflows="$project_path/.agent/workflows"

      if [ "$dry_run" -eq 1 ]; then
        echo "  [dry-run] Would sync wrappers to: $project_workflows"
        continue
      fi

      mkdir -p "$project_workflows"

      for wrapper in "$ag_global_workflows"/*/*.md; do
        [ -f "$wrapper" ] || continue
        wrapper_name="$(basename "$wrapper")"
        cp "$wrapper" "$project_workflows/$wrapper_name"
      done
      echo "  Synced to: $project_workflows"

    done < "$projects_conf"
  else
    echo "  WARN: No projects.conf found; skipping project sync." >&2
  fi
fi

echo ""
echo "Sync complete."
