#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src_dir="$root_dir/skills"
codex_root="$root_dir/.codex/skills"
codex_global_root="${HOME}/.codex/skills"
agent_root="$root_dir/.agent/skills"
global_root="${HOME}/.gemini/antigravity/global_skills"
master_root="${HOME}/.agents/skills"

sync_codex=1
sync_codex_global=1
sync_agent=0
sync_global=1

usage() {
  cat <<'USAGE'
Usage: sync-skills.sh [--codex] [--codex-global] [--agent] [--global] [--help]

By default, syncs project and global Codex skills plus global Antigravity skills.
This script generates the canonical skill files in ~/.agents/skills and symlinks them to the targets.

  --codex         Sync only project Codex skills (.codex/skills)
  --codex-global  Sync only global Codex skills (~/.codex/skills)
  --agent         Sync only project Antigravity skills (.agent/skills)
  --global        Sync only global Antigravity skills (~/.gemini/antigravity/global_skills)
  --help          Show this help
USAGE
}

if [ $# -gt 0 ]; then
  sync_codex=0
  sync_codex_global=0
  sync_agent=0
  sync_global=0
  for arg in "$@"; do
    case "$arg" in
      --codex) sync_codex=1 ;;
      --codex-global) sync_codex_global=1 ;;
      --agent) sync_agent=1 ;;
      --global) sync_global=1 ;;
      --help) usage; exit 0 ;;
      *) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
    esac
  done
  if [ "$sync_codex" -eq 0 ] && [ "$sync_codex_global" -eq 0 ] && [ "$sync_agent" -eq 0 ] && [ "$sync_global" -eq 0 ]; then
    echo "No targets selected." >&2
    usage
    exit 1
  fi
fi

if [ ! -d "$src_dir" ]; then
  echo "Missing skills directory: $src_dir" >&2
  exit 1
fi

if [ -d "$agent_root" ]; then
  missing=0
  for agent_dir in "$agent_root"/*; do
    [ -d "$agent_dir" ] || continue
    name="$(basename "$agent_dir")"
    src_candidate="$src_dir/$name.md"
    src_candidate_alt="$src_dir/${name//-/_}.md"
    if [ ! -f "$src_candidate" ] && [ ! -f "$src_candidate_alt" ]; then
      if [ "$missing" -eq 0 ]; then
        echo "Warning: skills found in $agent_root but missing from $src_dir; they will not sync to Codex." >&2
      fi
      echo "  - $name" >&2
      missing=1
    fi
  done
fi

# Ensure master root exists
mkdir -p "$master_root"

for src in "$src_dir"/*.md; do
  [ -e "$src" ] || continue

  base="$(basename "$src" .md)"
  name="${base//_/-}"
  
  # Master file locations
  master_dir="$master_root/$name"
  master_file="$master_dir/SKILL.md"
  
  # Target file locations
  codex_dir="$codex_root/$name"
  codex_file="$codex_dir/SKILL.md"
  codex_global_dir="$codex_global_root/$name"
  codex_global_file="$codex_global_dir/SKILL.md"
  agent_dir="$agent_root/$name"
  agent_file="$agent_dir/SKILL.md"
  global_dir="$global_root/$name"
  global_file="$global_dir/SKILL.md"

  # Always regenerate master file
  mkdir -p "$master_dir"
  
  desc_raw="$(awk 'BEGIN{found=0} /^##[[:space:]]+Purpose/{found=1;next} found{if($0 ~ /^[[:space:]]*$/) next; print; exit}' "$src")"
  if [ -z "$desc_raw" ]; then
    desc_raw="Skill $name"
  fi
  desc_escaped="$(printf '%s' "$desc_raw" | sed 's/"/\\"/g')"

  {
    echo "---"
    echo "name: $name"
    echo "description: \"$desc_escaped\""
    echo "metadata:"
    echo "  short-description: \"$desc_escaped\""
    echo "---"
    echo
    cat "$src"
  } > "$master_file"
  echo "Wrote master: $master_file"

  # Link Logic Helper
  link_skill() {
    local target_dir="$1"
    local target_file="$2"
    
    mkdir -p "$target_dir"
    # Remove existing file or link if it exists
    rm -f "$target_file"
    # Create symlink
    ln -s "$master_file" "$target_file"
    echo "Symlinked $target_file -> $master_file"
  }

  if [ "$sync_codex" -eq 1 ]; then
    link_skill "$codex_dir" "$codex_file"
  fi
  if [ "$sync_codex_global" -eq 1 ]; then
    link_skill "$codex_global_dir" "$codex_global_file"
  fi
  if [ "$sync_agent" -eq 1 ]; then
    link_skill "$agent_dir" "$agent_file"
  fi
  if [ "$sync_global" -eq 1 ]; then
    link_skill "$global_dir" "$global_file"
  fi

done
