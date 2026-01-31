#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src_dir="$root_dir/skills"
codex_root="$root_dir/.codex/skills"
agent_root="$root_dir/.agent/skills"
global_root="${HOME}/.gemini/antigravity/global_skills"

sync_codex=1
sync_agent=0
sync_global=1

usage() {
  cat <<'USAGE'
Usage: sync-skills.sh [--codex] [--agent] [--global] [--help]

By default, syncs Codex and global Antigravity skills.
  --codex  Sync only Codex skills (.codex/skills)
  --agent  Sync only project Antigravity skills (.agent/skills)
  --global Sync only global Antigravity skills (~/.gemini/antigravity/global_skills)
  --help   Show this help
USAGE
}

if [ $# -gt 0 ]; then
  sync_codex=0
  sync_agent=0
  sync_global=0
  for arg in "$@"; do
    case "$arg" in
      --codex) sync_codex=1 ;;
      --agent) sync_agent=1 ;;
      --global) sync_global=1 ;;
      --help) usage; exit 0 ;;
      *) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
    esac
  done
  if [ "$sync_codex" -eq 0 ] && [ "$sync_agent" -eq 0 ] && [ "$sync_global" -eq 0 ]; then
    echo "No targets selected." >&2
    usage
    exit 1
  fi
fi

if [ ! -d "$src_dir" ]; then
  echo "Missing skills directory: $src_dir" >&2
  exit 1
fi

if [ "$sync_codex" -eq 1 ]; then
  mkdir -p "$codex_root"
fi
if [ "$sync_agent" -eq 1 ]; then
  mkdir -p "$agent_root"
fi
if [ "$sync_global" -eq 1 ]; then
  mkdir -p "$global_root"
fi

for src in "$src_dir"/*.md; do
  [ -e "$src" ] || continue

  base="$(basename "$src" .md)"
  name="${base//_/-}"
  codex_dir="$codex_root/$name"
  codex_file="$codex_dir/SKILL.md"
  agent_dir="$agent_root/$name"
  agent_file="$agent_dir/SKILL.md"
  global_dir="$global_root/$name"
  global_file="$global_dir/SKILL.md"

  if [ "$sync_codex" -eq 1 ]; then
    mkdir -p "$codex_dir"
  fi
  if [ "$sync_agent" -eq 1 ]; then
    mkdir -p "$agent_dir"
  fi
  if [ "$sync_global" -eq 1 ]; then
    mkdir -p "$global_dir"
  fi

  desc_raw="$(awk 'BEGIN{found=0} /^##[[:space:]]+Purpose/{found=1;next} found{if($0 ~ /^[[:space:]]*$/) next; print; exit}' "$src")"
  if [ -z "$desc_raw" ]; then
    desc_raw="Skill $name"
  fi
  desc_escaped="$(printf '%s' "$desc_raw" | sed 's/"/\\"/g')"

  if [ "$sync_codex" -eq 1 ]; then
    {
      echo "---"
      echo "name: $name"
      echo "description: \"$desc_escaped\""
      echo "metadata:"
      echo "  short-description: \"$desc_escaped\""
      echo "---"
      echo
      cat "$src"
    } > "$codex_file"
    echo "Wrote $codex_file"
  fi

  if [ "$sync_agent" -eq 1 ]; then
    {
      echo "---"
      echo "name: $name"
      echo "description: \"$desc_escaped\""
      echo "---"
      echo
      cat "$src"
    } > "$agent_file"
    echo "Wrote $agent_file"
  fi

  if [ "$sync_global" -eq 1 ]; then
    {
      echo "---"
      echo "name: $name"
      echo "description: \"$desc_escaped\""
      echo "---"
      echo
      cat "$src"
    } > "$global_file"
    echo "Wrote $global_file"
  fi
done
