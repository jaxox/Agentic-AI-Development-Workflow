#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src_dir="$root_dir/skills"
codex_root="$root_dir/.codex/skills"
agent_root="$root_dir/.agent/skills"

if [ ! -d "$src_dir" ]; then
  echo "Missing skills directory: $src_dir" >&2
  exit 1
fi

fail=0

require_frontmatter() {
  local file="$1"
  if ! awk 'NR==1{if($0!="---") exit 2} $0=="---"{c++; if(c==2){exit 0}} END{if(c<2) exit 2}' "$file"; then
    echo "ERROR: Missing YAML frontmatter in $file" >&2
    return 1
  fi
}

extract_frontmatter() {
  local file="$1"
  awk 'NR==1{next} $0=="---"{exit} {print}' "$file"
}

extract_body() {
  local file="$1"
  awk 'BEGIN{c=0} $0=="---"{c++; next} c>=2{print}' "$file" | sed '1{/^$/d;}'
}

get_field() {
  local field="$1"
  awk -v f="$field" -F: '$1==f {sub(/^ /, "", $2); print $2; exit}'
}

trim_quotes() {
  sed -e 's/^"//' -e 's/"$//'
}

check_skill_file() {
  local file="$1"
  local expected_name="$2"
  local require_metadata="$3"

  require_frontmatter "$file" || return 1

  local frontmatter
  frontmatter="$(extract_frontmatter "$file")"

  local name_val desc_val short_val
  name_val="$(printf '%s\n' "$frontmatter" | get_field name | trim_quotes)"
  desc_val="$(printf '%s\n' "$frontmatter" | get_field description | trim_quotes)"
  short_val="$(printf '%s\n' "$frontmatter" | awk -F: '$1 ~ /^[[:space:]]*short-description$/ {sub(/^ /, "", $2); print $2; exit}' | trim_quotes)"

  if [ -z "$name_val" ]; then
    echo "ERROR: Missing name in $file" >&2
    return 1
  fi
  if [ "$name_val" != "$expected_name" ]; then
    echo "ERROR: Name mismatch in $file (expected $expected_name, got $name_val)" >&2
    return 1
  fi
  if [ -z "$desc_val" ]; then
    echo "ERROR: Missing description in $file" >&2
    return 1
  fi
  if [ "$require_metadata" = "yes" ] && [ -z "$short_val" ]; then
    echo "ERROR: Missing metadata.short-description in $file" >&2
    return 1
  fi
}

compare_body() {
  local file="$1"
  local src="$2"
  local tmp
  tmp="$(mktemp)"
  extract_body "$file" > "$tmp"
  if ! cmp -s "$tmp" "$src"; then
    echo "ERROR: Body mismatch in $file (does not match $src)" >&2
    rm -f "$tmp"
    return 1
  fi
  rm -f "$tmp"
}

for src in "$src_dir"/*.md; do
  [ -e "$src" ] || continue

  base="$(basename "$src" .md)"
  name="${base//_/-}"

  codex_file="$codex_root/$name/SKILL.md"
  agent_file="$agent_root/$name/SKILL.md"

  if [ ! -f "$codex_file" ]; then
    echo "ERROR: Missing Codex skill $codex_file" >&2
    fail=1
  else
    if ! check_skill_file "$codex_file" "$name" "yes"; then
      fail=1
    fi
    if ! compare_body "$codex_file" "$src"; then
      fail=1
    fi
  fi

  if [ ! -f "$agent_file" ]; then
    echo "ERROR: Missing Antigravity skill $agent_file" >&2
    fail=1
  else
    if ! check_skill_file "$agent_file" "$name" "no"; then
      fail=1
    fi
    if ! compare_body "$agent_file" "$src"; then
      fail=1
    fi
  fi

done

if [ "$fail" -ne 0 ]; then
  echo "Skill validation failed." >&2
  exit 1
fi

echo "Skill validation passed."
