#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$PROJECT_ROOT/skills"

TARGETS=(
  "$PROJECT_ROOT/.claude/skills"
  "$PROJECT_ROOT/.codex/skills"
  "$PROJECT_ROOT/.trae-cn/skills"
)

if [ ! -d "$SOURCE_DIR" ]; then
  echo "错误：统一 skills 源目录不存在: $SOURCE_DIR"
  exit 1
fi

collect_leaf_skills() {
  find "$SOURCE_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
    dirname "$skill_file"
  done | sort
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
  done < <(collect_leaf_skills)
}

echo "======================================"
echo "统一 Skills 同步脚本"
echo "======================================"
echo "源目录: $SOURCE_DIR"
echo ""

for target in "${TARGETS[@]}"; do
  echo "同步到: $target"
  sync_one "$target"
  echo "  ✓ 完成"
done

echo ""
echo "已同步的技能:"
collect_leaf_skills | while read -r skill_dir; do
  basename "$skill_dir"
done
