#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$PROJECT_ROOT/skills"
ROLE_MAP="$PROJECT_ROOT/docs/02_skill-catalog/role-map.yml"

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
  scripts/sync-skills.sh --role <角色名> [--role <角色名> ...]
  scripts/sync-skills.sh --all

示例:
  scripts/sync-skills.sh --role 程序开发者
  scripts/sync-skills.sh --role 程序开发者 --role 本地化

说明:
  默认按角色同步项目级 skills。--all 仅用于维护或调试，不推荐日常使用。
EOF
}

fail() {
  echo "错误：$1" >&2
  echo "" >&2
  usage >&2
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

[ -d "$SOURCE_DIR" ] || fail "统一 skills 源目录不存在: $SOURCE_DIR"
[ -f "$ROLE_MAP" ] || fail "角色映射文件不存在: $ROLE_MAP"

if [ "$ALL_MODE" -eq 1 ] && [ "${#ROLES[@]}" -gt 0 ]; then
  fail "--all 不能和 --role 同时使用"
fi

if [ "$ALL_MODE" -eq 0 ] && [ "${#ROLES[@]}" -eq 0 ]; then
  fail "必须指定至少一个 --role，或显式使用 --all"
fi

collect_leaf_skills() {
  find "$SOURCE_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
    dirname "$skill_file"
  done | sort
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

selected_skill_dirs() {
  if [ "$ALL_MODE" -eq 1 ]; then
    collect_leaf_skills
    return
  fi

  collect_leaf_skills | while read -r skill_dir; do
    [ -z "$skill_dir" ] && continue
    local_skill="$(basename "$skill_dir")"
    for role in "${ROLES[@]}"; do
      if skill_has_role "$local_skill" "$role"; then
        echo "$skill_dir"
        break
      fi
    done
  done | sort -u
}

sync_one() {
  local target_dir="$1"
  local skill_dir
  local skill_name

  mkdir -p "$target_dir"
  find "$target_dir" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  while read -r skill_dir; do
    [ -z "$skill_dir" ] && continue
    skill_name="$(basename "$skill_dir")"
    cp -R "$skill_dir" "$target_dir/$skill_name"
  done < <(selected_skill_dirs)
}

selected_count="$(selected_skill_dirs | wc -l | tr -d ' ')"
[ "$selected_count" -gt 0 ] || fail "没有匹配到任何 skill，请检查角色名是否存在于 role-map.yml"

echo "======================================"
echo "项目级 Skills 同步脚本"
echo "======================================"
echo "源目录: $SOURCE_DIR"
if [ "$ALL_MODE" -eq 1 ]; then
  echo "模式: 全量同步（仅维护/调试建议使用）"
else
  echo "角色: ${ROLES[*]}"
fi
echo "技能数量: $selected_count"
echo ""

for target in "${TARGETS[@]}"; do
  echo "同步到: $target"
  sync_one "$target"
  echo "  ✓ 完成"
done

echo ""
echo "已同步的技能:"
selected_skill_dirs | while read -r skill_dir; do
  basename "$skill_dir"
done
