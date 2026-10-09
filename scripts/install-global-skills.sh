#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_SKILLS_DIR="$PROJECT_ROOT/skills"
BASELINE_SKILLS=("skill-creator")

TARGETS=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.trae-cn/skills"
)

fail() {
  echo "错误：$1" >&2
  exit 1
}

find_skill_dir() {
  local skill_name="$1"
  find "$LOCAL_SKILLS_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
    skill_dir="$(dirname "$skill_file")"
    if [ "$(basename "$skill_dir")" = "$skill_name" ]; then
      echo "$skill_dir"
      return
    fi
  done
}

install_to_target() {
  local target_dir="$1"
  local skill_name
  local skill_dir

  mkdir -p "$target_dir"
  find "$target_dir" -mindepth 1 -maxdepth 1 ! -name ".system" -exec rm -rf {} +

  echo "目标目录: $target_dir"
  for skill_name in "${BASELINE_SKILLS[@]}"; do
    skill_dir="$(find_skill_dir "$skill_name")"
    [ -n "$skill_dir" ] || fail "找不到全局基础技能：$skill_name"
    echo "  正在安装基础技能: $skill_name"
    cp -R "$skill_dir" "$target_dir/$skill_name"
    echo "    ✓ 已安装"
  done
  echo ""
}

[ -d "$LOCAL_SKILLS_DIR" ] || fail "本地技能目录不存在: $LOCAL_SKILLS_DIR"

echo "======================================"
echo "全局基础 Skills 安装脚本"
echo "======================================"
echo ""
echo "源目录: $LOCAL_SKILLS_DIR"
echo "全局仅安装: ${BASELINE_SKILLS[*]}"
echo ""

for target_dir in "${TARGETS[@]}"; do
  install_to_target "$target_dir"
done

echo "======================================"
echo "安装完成"
echo "======================================"
echo "全局目录只保留基础技能。具体项目请使用 scripts/sync-skills.sh --role <角色名> 启用项目级 skills。"
