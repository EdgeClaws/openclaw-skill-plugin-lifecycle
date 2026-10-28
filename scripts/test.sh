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
check "ownership reference exists" test -s "$skill_dir/references/ownership-and-identity.md"
check "ownership registry exists" test -s "$skill_dir/references/authoring-ownership.json"
check "repository registry exists" test -s "$skill_dir/references/repository-publication.json"
check "Workshop hook setup exists" test -s "$skill_dir/references/workshop-autonomous-governance.md"
check "registries validate" node "$skill_dir/scripts/validate-registries.mjs"
check "RJ can maintain TestRail" grep -q '"artifact": "skills/testrail"' "$skill_dir/references/authoring-ownership.json"
check "ownership uses no channel IDs" sh -c "! grep -Eq 'telegram|slack|channelId|channel_id' \"\$1\"" _ "$skill_dir/references/authoring-ownership.json"
check "lifecycle publication is registered" grep -q 'EdgeClaws/openclaw-skill-plugin-lifecycle' "$skill_dir/references/repository-publication.json"
check "skill preserves practical authoring preferences" grep -q 'Do not overengineer routine authoring' "$skill_file"
check "skill routes to SOUL preferences" grep -q 'SOUL.md' "$skill_file"
check "skill routes to USER preferences" grep -q 'USER.md' "$skill_file"
check "skill routes to IDENTITY preferences" grep -q 'IDENTITY.md' "$skill_file"
check "owner-requested new skills default to workspace skills" grep -q "owner-requested durable skill" "$skill_file"
check "Workshop requires explicit owner routing or existing ownership" grep -q 'Use `workshop-skills/` only when they explicitly ask' "$skill_file"
check "teammate new skills default to Workshop" grep -q "requester's Workshop collection by default" "$skill_file"
check "Workshop proposal history avoids duplicate Git" grep -q 'duplicate Git requirement' "$skill_file"

if test -f "$workspace_dir/AGENTS.md"; then
  check "AGENTS routes directly to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/AGENTS.md"
  check "AGENTS explicitly covers Workshop self-creation" grep -q 'Workshop self-creation is permitted and encouraged' "$workspace_dir/AGENTS.md"
  check "legacy procedure points to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/knowledge/procedures/skill-and-plugin-proposals.md"
  check "OpenClaw plugin creator points to lifecycle skill" grep -q 'skills/openclaw-skill-plugin-lifecycle/SKILL.md' "$workspace_dir/skills/plugin-creator/SKILL.md"
else
  printf 'SKIP: workspace integration checks (standalone checkout)\n'
fi

exit "$failures"
