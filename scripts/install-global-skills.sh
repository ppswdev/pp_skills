#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_SKILLS_DIR="$PROJECT_ROOT/skills"

TARGETS=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.trae-cn/skills"
)

echo "======================================"
echo "多工具全局技能安装脚本"
echo "======================================"
echo ""

if [ ! -d "$LOCAL_SKILLS_DIR" ]; then
    echo "错误：本地技能目录不存在: $LOCAL_SKILLS_DIR"
    exit 1
fi

if [ ! "$(ls -A $LOCAL_SKILLS_DIR)" ]; then
    echo "警告：本地技能目录为空: $LOCAL_SKILLS_DIR"
    exit 0
fi

collect_leaf_skills() {
    find "$LOCAL_SKILLS_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
        dirname "$skill_file"
    done | sort
}

install_to_target() {
    local target_dir="$1"
    local skill_dir
    local skill_name

    mkdir -p "$target_dir"
    find "$target_dir" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

    echo "目标目录: $target_dir"
    while read -r skill_dir; do
        [ -z "$skill_dir" ] && continue
        skill_name=$(basename "$skill_dir")
        echo "  正在安装技能: $skill_name"
        cp -R "$skill_dir" "$target_dir/$skill_name"
        echo "    ✓ 已安装"
    done < <(collect_leaf_skills)
    echo ""
}

echo "正在从统一源目录复制技能到全局目录..."
echo "源目录: $LOCAL_SKILLS_DIR"
echo ""

for target_dir in "${TARGETS[@]}"; do
    install_to_target "$target_dir"
done

echo ""
echo "======================================"
echo "安装完成！"
echo "======================================"
echo ""
echo "已同步到以下全局目录:"
for target_dir in "${TARGETS[@]}"; do
    echo "- $target_dir"
done
echo ""
echo "请重启对应工具，以使全局技能生效。"
