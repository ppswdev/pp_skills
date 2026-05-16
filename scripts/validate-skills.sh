#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$PROJECT_ROOT/skills"
ROLE_MAP="$PROJECT_ROOT/docs/02_skill-catalog/role-map.yml"
USAGE_DIR="$PROJECT_ROOT/docs/03_skill-usage"
TARGETS=(
  "$PROJECT_ROOT/.claude/skills"
  "$PROJECT_ROOT/.codex/skills"
  "$PROJECT_ROOT/.trae-cn/skills"
)

fail() {
  echo "错误：$1"
  exit 1
}

collect_leaf_skills() {
  find "$SKILLS_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
    dirname "$skill_file"
  done | sort
}

extract_frontmatter_field() {
  local file="$1"
  local key="$2"
  awk -v key="$key" '
    BEGIN { in_fm = 0; collecting = 0; value = "" }
    NR == 1 && $0 == "---" { in_fm = 1; next }
    in_fm && $0 == "---" {
      if (collecting) {
        gsub(/[[:space:]]+/, " ", value)
        gsub(/^ /, "", value)
        gsub(/ $/, "", value)
        print value
      }
      exit
    }
    in_fm && collecting {
      if ($0 ~ /^[A-Za-z0-9_-]+:/) {
        gsub(/[[:space:]]+/, " ", value)
        gsub(/^ /, "", value)
        gsub(/ $/, "", value)
        print value
        exit
      }
      line = $0
      gsub(/^[[:space:]]+/, "", line)
      value = value " " line
      next
    }
    in_fm && $0 ~ "^" key ":" {
      line = $0
      sub("^" key ":[[:space:]]*", "", line)
      gsub(/^["'\'' ]+/, "", line)
      gsub(/["'\'' ]+$/, "", line)
      if (line == "") {
        collecting = 1
        next
      }
      print line
      exit
    }
  ' "$file"
}

role_map_has_skill() {
  local skill="$1"
  grep -q "^${skill}:" "$ROLE_MAP"
}

[ -d "$SKILLS_DIR" ] || fail "skills 源目录不存在"
[ -f "$ROLE_MAP" ] || fail "缺少 docs/02_skill-catalog/role-map.yml"
[ -d "$USAGE_DIR" ] || fail "缺少 docs/03_skill-usage，请先运行 scripts/generate-docs-index.sh"

source_count="$(find "$SKILLS_DIR" -type f -name "SKILL.md" | wc -l | tr -d ' ')"
[ "$source_count" -gt 0 ] || fail "没有发现任何 SKILL.md"

duplicates="$(collect_leaf_skills | while read -r skill_dir; do basename "$skill_dir"; done | sort | uniq -d)"
[ -z "$duplicates" ] || fail "存在重复 skill-name，会覆盖扁平镜像：$duplicates"

missing_usage=""
missing_role=""
missing_frontmatter=""
while read -r skill_dir; do
  skill="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"
  name="$(extract_frontmatter_field "$skill_file" "name")"
  description="$(extract_frontmatter_field "$skill_file" "description")"

  [ -n "$name" ] || missing_frontmatter="$missing_frontmatter $skill:name"
  [ -n "$description" ] || missing_frontmatter="$missing_frontmatter $skill:description"
  [ -f "$USAGE_DIR/$skill.md" ] || missing_usage="$missing_usage $skill"
  role_map_has_skill "$skill" || missing_role="$missing_role $skill"
done < <(collect_leaf_skills)

[ -z "$missing_frontmatter" ] || fail "frontmatter 缺少字段：$missing_frontmatter"
[ -z "$missing_usage" ] || fail "缺少技能用法页：$missing_usage"
[ -z "$missing_role" ] || fail "role-map.yml 缺少 skill：$missing_role"

for target in "${TARGETS[@]}"; do
  [ -d "$target" ] || fail "缺少镜像目录：$target"
  target_count="$(find "$target" -type f -name "SKILL.md" | wc -l | tr -d ' ')"
  [ "$target_count" = "$source_count" ] || fail "$target 的 SKILL.md 数量为 $target_count，源目录为 $source_count"

  bad_top_level="$(find "$target" -mindepth 1 -maxdepth 1 -type d \( -name '0[0-9]_*' -o -name '1[0-4]_*' \) -print)"
  [ -z "$bad_top_level" ] || fail "$target 中存在分类目录，镜像目录必须扁平：$bad_top_level"
done

[ ! -d "$PROJECT_ROOT/.github/skills" ] || fail "不应存在 .github/skills"
[ ! -d "$PROJECT_ROOT/.trae/skills" ] || fail "不应存在 .trae/skills"

echo "验证通过：$source_count 个 skill、用法页、角色映射和 3 个镜像目录一致。"
