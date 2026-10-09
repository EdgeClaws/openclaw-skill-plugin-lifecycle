#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"
workspace_dir="$(cd "$skill_dir/../.." && pwd)"
skill_file="$skill_dir/SKILL.md"
failures=0

check() {
  local label="$1"
  shift
  if "$@"; then
    printf 'PASS: %s\n' "$label"
  else
    printf 'FAIL: %s\n' "$label"
    failures=$((failures + 1))
  fi
}

check "SKILL.md exists" test -s "$skill_file"
check "required lifecycle name" grep -q '^name: openclaw-skill-plugin-lifecycle$' "$skill_file"
check "description makes loading mandatory" grep -q '^description: Required before any OpenClaw skill' "$skill_file"
check "governance reference exists" test -s "$skill_dir/references/authoring-governance.md"
check "git provenance reference exists" test -s "$skill_dir/references/git-provenance.md"
check "AGENTS routes directly to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/AGENTS.md"
check "legacy procedure points to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/knowledge/procedures/skill-and-plugin-proposals.md"
check "OpenClaw plugin creator points to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/skills/plugin-creator/SKILL.md"

exit "$failures"
