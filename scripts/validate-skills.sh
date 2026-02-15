#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# validate-skills.sh — Validate skills are properly synced to all targets
#
# Source of truth: source/skills/<name>/SKILL.md
#
# Validates:
#   - SKILL.md has valid YAML frontmatter (name, description)
#   - Symlinks exist and point to source at all global targets
#   - Workflow wrappers exist globally and in per-project locations
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

validate_skills=1
validate_workflows=1
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
Usage: validate-skills.sh [OPTIONS]

Validate that skills are properly synced to all targets.

Options:
  --skills       Validate skill symlinks only
  --workflows    Validate workflow wrappers only
  --link-mode    Link strategy: hybrid (default), dir, or file
  --help         Show this help

By default, validates everything.
USAGE
}

if [ $# -gt 0 ]; then
  validate_skills=0
  validate_workflows=0
  while [ $# -gt 0 ]; do
    case "$1" in
      --skills) validate_skills=1 ;;
      --workflows) validate_workflows=1 ;;
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

echo "Skill link mode: $link_mode"

fail=0
checked=0
passed=0

# ==============================================================================
# Helpers
# ==============================================================================

extract_field() {
  local file="$1" field="$2"
  awk -v f="$field" '
    NR==1 && $0!="---" { exit }
    NR>1 && $0=="---" { exit }
    $0 ~ "^"f":" {
      sub("^"f":[[:space:]]*\"?", "")
      sub("\"[[:space:]]*$", "")
      print
      exit
    }
  ' "$file"
}

# ==============================================================================
# Validate each skill
# ==============================================================================

for skill_dir in "$src_dir"/*/; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  name="$(basename "$skill_dir")"
  abs_skill_dir="$(cd "$skill_dir" && pwd)"
  src_file="$skill_dir/SKILL.md"
  abs_src_file="$(cd "$skill_dir" && pwd)/SKILL.md"
  checked=$((checked + 1))
  skill_ok=1

  # Validate source frontmatter
  name_val="$(extract_field "$src_file" "name")"
  desc_val="$(extract_field "$src_file" "description")"

  if [ -z "$name_val" ]; then
    echo "FAIL: [$name] Missing name in SKILL.md" >&2
    skill_ok=0; fail=1
  elif [ "$name_val" != "$name" ]; then
    echo "FAIL: [$name] Name mismatch (got '$name_val')" >&2
    skill_ok=0; fail=1
  fi

  if [ -z "$desc_val" ]; then
    echo "FAIL: [$name] Missing description in SKILL.md" >&2
    skill_ok=0; fail=1
  fi

  # Validate global skill symlinks
  if [ "$validate_skills" -eq 1 ]; then
    for i in "${!GLOBAL_TARGETS[@]}"; do
      label="${GLOBAL_TARGET_NAMES[$i]}"
      target_root="${GLOBAL_TARGETS[$i]}"
      target_mode="$(resolve_target_link_mode "$i")"
      target_dir="$target_root/$name"
      target_file="$target_dir/SKILL.md"

      if [ "$target_mode" = "dir" ]; then
        if [ ! -e "$target_dir" ]; then
          echo "FAIL: [$name] Missing $label dir symlink: $target_dir" >&2
          skill_ok=0; fail=1
        elif [ ! -L "$target_dir" ]; then
          echo "FAIL: [$name] $label target is not a symlinked directory: $target_dir" >&2
          skill_ok=0; fail=1
        else
          link_target="$(readlink "$target_dir")"
          if [ "$link_target" != "$abs_skill_dir" ]; then
            echo "FAIL: [$name] $label dir symlink points to wrong source" >&2
            echo "       Expected: $abs_skill_dir" >&2
            echo "       Got:      $link_target" >&2
            skill_ok=0; fail=1
          fi
        fi
      else
        if [ ! -e "$target_file" ]; then
          echo "FAIL: [$name] Missing $label file symlink: $target_file" >&2
          skill_ok=0; fail=1
        elif [ ! -L "$target_file" ]; then
          echo "WARN: [$name] $label SKILL.md is a regular file, not a symlink: $target_file" >&2
        else
          link_target="$(readlink "$target_file")"
          if [ "$link_target" != "$abs_src_file" ]; then
            echo "FAIL: [$name] $label file symlink points to wrong source" >&2
            echo "       Expected: $abs_src_file" >&2
            echo "       Got:      $link_target" >&2
            skill_ok=0; fail=1
          fi
        fi
      fi
    done
  fi

  # Validate workflow wrapper exists globally
  if [ "$validate_workflows" -eq 1 ]; then
    wrapper_found=0
    for wrapper in "$ag_global_workflows"/*/"$name.md"; do
      if [ -f "$wrapper" ]; then
        wrapper_found=1
        break
      fi
    done
    if [ "$wrapper_found" -eq 0 ]; then
      echo "FAIL: [$name] Missing global workflow wrapper" >&2
      skill_ok=0; fail=1
    fi
  fi

  if [ "$skill_ok" -eq 1 ]; then
    passed=$((passed + 1))
  fi
done

# ==============================================================================
# Validate per-project workflow wrappers
# ==============================================================================

if [ "$validate_workflows" -eq 1 ] && [ -f "$projects_conf" ]; then
  echo ""
  echo "Per-project workflow wrappers:"

  while IFS= read -r project_path || [ -n "$project_path" ]; do
    [[ "$project_path" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$project_path" ]] && continue
    project_path="${project_path%%#*}"
    project_path="$(echo "$project_path" | xargs)"

    if [ ! -d "$project_path" ]; then
      echo "  WARN: Project not found: $project_path" >&2
      continue
    fi

    project_workflows="$project_path/.agent/workflows"
    if [ ! -d "$project_workflows" ]; then
      echo "  FAIL: Missing workflows dir: $project_workflows" >&2
      fail=1
      continue
    fi

    wrapper_count="$(find "$project_workflows" -name '*.md' -type f | wc -l | xargs)"
    echo "  $project_path: $wrapper_count wrappers"
  done < "$projects_conf"
fi

# ==============================================================================
# Summary
# ==============================================================================

echo ""
echo "Validated $checked skills: $passed passed, $((checked - passed)) failed."

if [ "$fail" -ne 0 ]; then
  echo "Validation FAILED." >&2
  exit 1
fi

echo "Validation PASSED."
