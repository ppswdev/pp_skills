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

ROLES=()
ALL_MODE=0

usage() {
  cat <<'EOF'
用法:
  scripts/validate-skills.sh [--role <角色名> ...]
  scripts/validate-skills.sh --all

说明:
  不传参数时，验证源目录、文档和当前项目镜像的一致性。
  传 --role 时，额外要求项目镜像精确匹配这些角色的 skill 并集。
  传 --all 时，额外要求项目镜像精确匹配源目录全部 skills。
EOF
}

fail() {
  echo "错误：$1" >&2
  exit 1
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --role)
      [ "${2:-}" ] || fail "--role 需要一个角色名"
      ROLES+=("$2")
      shift 2
      ;;
    --all)
      ALL_MODE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "未知参数：$1"
      ;;
  esac
done

if [ "$ALL_MODE" -eq 1 ] && [ "${#ROLES[@]}" -gt 0 ]; then
  fail "--all 不能和 --role 同时使用"
fi

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

skill_has_role() {
  local skill="$1"
  local role="$2"
  awk -v skill="$skill" -v role="$role" '
    $0 == skill ":" { found = 1; next }
    found && /^[^[:space:]][^:]+:/ { exit }
    found && /roles:/ {
      if (index($0, role) > 0) {
        found_role = 1
      }
      exit
    }
    END { exit found_role ? 0 : 1 }
  ' "$ROLE_MAP"
}

all_skill_names() {
  collect_leaf_skills | while read -r skill_dir; do
    basename "$skill_dir"
  done | sort
}

expected_skill_names() {
  if [ "$ALL_MODE" -eq 1 ]; then
    all_skill_names
    return
  fi

  if [ "${#ROLES[@]}" -eq 0 ]; then
    return
  fi

  collect_leaf_skills | while read -r skill_dir; do
    [ -z "$skill_dir" ] && continue
    skill="$(basename "$skill_dir")"
    for role in "${ROLES[@]}"; do
      if skill_has_role "$skill" "$role"; then
        echo "$skill"
        break
      fi
    done
  done | sort -u
}

target_skill_names() {
  local target="$1"
  find "$target" -mindepth 1 -maxdepth 1 -type d | while read -r skill_dir; do
    basename "$skill_dir"
  done | sort
}

assert_same_list() {
  local label="$1"
  local expected_file="$2"
  local actual_file="$3"

  if ! diff -u "$expected_file" "$actual_file" >/tmp/validate-skills.diff; then
    echo "错误：$label 不匹配" >&2
    cat /tmp/validate-skills.diff >&2
    exit 1
  fi
}

[ -d "$SKILLS_DIR" ] || fail "skills 源目录不存在"
[ -f "$ROLE_MAP" ] || fail "缺少 docs/02_skill-catalog/role-map.yml"
[ -d "$USAGE_DIR" ] || fail "缺少 docs/03_skill-usage，请先运行 scripts/generate-docs-index.sh"

source_count="$(find "$SKILLS_DIR" -type f -name "SKILL.md" | wc -l | tr -d ' ')"
[ "$source_count" -gt 0 ] || fail "没有发现任何 SKILL.md"

duplicates="$(all_skill_names | uniq -d)"
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

expected_file="$(mktemp)"
trap 'rm -f "$expected_file" "$first_target_file" "$current_target_file"' EXIT
expected_skill_names > "$expected_file"

if [ "$ALL_MODE" -eq 0 ] && [ "${#ROLES[@]}" -gt 0 ] && [ ! -s "$expected_file" ]; then
  fail "没有匹配到任何角色 skill，请检查 --role 参数"
fi

first_target_file="$(mktemp)"
current_target_file="$(mktemp)"
first_target=""
all_source_file="$(mktemp)"
all_skill_names > "$all_source_file"
trap 'rm -f "$expected_file" "$first_target_file" "$current_target_file" "$all_source_file"' EXIT

for target in "${TARGETS[@]}"; do
  [ -d "$target" ] || fail "缺少镜像目录：$target"

  bad_top_level="$(find "$target" -mindepth 1 -maxdepth 1 -type d \( -name '0[0-9]_*' -o -name '1[0-4]_*' -o -name '99_*' \) -print)"
  [ -z "$bad_top_level" ] || fail "$target 中存在分类目录，镜像目录必须扁平：$bad_top_level"

  target_skill_names "$target" > "$current_target_file"

  unknown="$(comm -23 "$current_target_file" "$all_source_file")"
  [ -z "$unknown" ] || fail "$target 中存在源目录没有的 skill：$unknown"

  if [ "$ALL_MODE" -eq 1 ] || [ "${#ROLES[@]}" -gt 0 ]; then
    assert_same_list "$target 的角色同步结果" "$expected_file" "$current_target_file"
  fi

  if [ -z "$first_target" ]; then
    cp "$current_target_file" "$first_target_file"
    first_target="$target"
  else
    assert_same_list "$target 与 $first_target 的镜像内容" "$first_target_file" "$current_target_file"
  fi
done

[ ! -d "$PROJECT_ROOT/.github/skills" ] || fail "不应存在 .github/skills"
[ ! -d "$PROJECT_ROOT/.trae/skills" ] || fail "不应存在 .trae/skills"

if [ "$ALL_MODE" -eq 1 ]; then
  echo "验证通过：源目录、用法页、角色映射和全量项目镜像一致。"
elif [ "${#ROLES[@]}" -gt 0 ]; then
  echo "验证通过：源目录、用法页、角色映射和角色项目镜像一致。角色：${ROLES[*]}"
else
  echo "验证通过：源目录、用法页、角色映射和当前项目镜像一致。"
fi
