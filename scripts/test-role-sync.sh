#!/bin/bash

set -euo pipefail

SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

assert_dir_exists() {
  [ -d "$1" ] || fail "expected directory to exist: $1"
}

assert_dir_missing() {
  [ ! -d "$1" ] || fail "expected directory to be missing: $1"
}

assert_count() {
  local expected="$1"
  local dir="$2"
  local actual
  actual="$(find "$dir" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
  [ "$actual" = "$expected" ] || fail "expected $expected skill dirs in $dir, got $actual"
}

assert_user_skill_count() {
  local expected="$1"
  local dir="$2"
  local actual
  actual="$(find "$dir" -mindepth 1 -maxdepth 1 -type d ! -name ".system" | wc -l | tr -d ' ')"
  [ "$actual" = "$expected" ] || fail "expected $expected user skill dirs in $dir, got $actual"
}

write_skill() {
  local dir="$1"
  local name="$2"
  mkdir -p "$dir/$name"
  cat > "$dir/$name/SKILL.md" <<EOF
---
name: "$name"
description: "Test skill $name."
---

# $name
EOF
}

ROOT="$TMP_ROOT/repo"
mkdir -p "$ROOT/scripts" "$ROOT/skills/00_base" "$ROOT/skills/06_engineering" "$ROOT/skills/99_ppskills" "$ROOT/docs/02_skill-catalog" "$ROOT/docs/03_skill-usage"
cp "$SOURCE_ROOT/scripts/sync-skills.sh" "$ROOT/scripts/sync-skills.sh"
cp "$SOURCE_ROOT/scripts/install-global-skills.sh" "$ROOT/scripts/install-global-skills.sh"
cp "$SOURCE_ROOT/scripts/validate-skills.sh" "$ROOT/scripts/validate-skills.sh"
chmod +x "$ROOT/scripts/"*.sh

write_skill "$ROOT/skills/00_base" "skill-creator"
write_skill "$ROOT/skills/06_engineering" "dev-tool"
write_skill "$ROOT/skills/99_ppskills" "localizer"
write_skill "$ROOT/skills/99_ppskills" "shared-tool"

cat > "$ROOT/docs/02_skill-catalog/role-map.yml" <<'EOF'
skill-creator:
  domain: 00_base
  roles: [技能创建者]
dev-tool:
  domain: 06_engineering
  roles: [程序开发者]
localizer:
  domain: 99_ppskills
  roles: [本地化]
shared-tool:
  domain: 99_ppskills
  roles: [程序开发者, 本地化]
EOF

for skill in skill-creator dev-tool localizer shared-tool; do
  touch "$ROOT/docs/03_skill-usage/$skill.md"
done

cd "$ROOT"

if scripts/sync-skills.sh >/tmp/sync-no-role.out 2>&1; then
  fail "sync-skills.sh without --role or --all should fail"
fi

scripts/sync-skills.sh --role 程序开发者 >/tmp/sync-dev.out
assert_count 2 "$ROOT/.codex/skills"
assert_dir_exists "$ROOT/.codex/skills/dev-tool"
assert_dir_exists "$ROOT/.codex/skills/shared-tool"
assert_dir_missing "$ROOT/.codex/skills/localizer"
assert_dir_missing "$ROOT/.codex/skills/skill-creator"

scripts/sync-skills.sh --role 本地化 >/tmp/sync-localization.out
assert_count 2 "$ROOT/.claude/skills"
assert_dir_exists "$ROOT/.claude/skills/localizer"
assert_dir_exists "$ROOT/.claude/skills/shared-tool"
assert_dir_missing "$ROOT/.claude/skills/dev-tool"

scripts/sync-skills.sh --role 程序开发者 --role 本地化 >/tmp/sync-multi.out
assert_count 3 "$ROOT/.trae-cn/skills"
assert_dir_exists "$ROOT/.trae-cn/skills/dev-tool"
assert_dir_exists "$ROOT/.trae-cn/skills/localizer"
assert_dir_exists "$ROOT/.trae-cn/skills/shared-tool"
scripts/validate-skills.sh --role 程序开发者 --role 本地化 >/tmp/validate-role.out

scripts/sync-skills.sh --all >/tmp/sync-all.out
assert_count 4 "$ROOT/.codex/skills"
scripts/validate-skills.sh --all >/tmp/validate-all.out

GLOBAL_HOME="$TMP_ROOT/home"
mkdir -p "$GLOBAL_HOME"
mkdir -p "$GLOBAL_HOME/.codex/skills/.system"
HOME="$GLOBAL_HOME" scripts/install-global-skills.sh >/tmp/install-global.out
assert_user_skill_count 1 "$GLOBAL_HOME/.codex/skills"
assert_dir_exists "$GLOBAL_HOME/.codex/skills/.system"
assert_dir_exists "$GLOBAL_HOME/.codex/skills/skill-creator"
assert_dir_missing "$GLOBAL_HOME/.codex/skills/dev-tool"

echo "role sync tests passed"
