#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_SKILLS_DIR="$PROJECT_ROOT/.trae/skills"
GLOBAL_SKILLS_DIR="$HOME/.trae-cn/skills"

echo "======================================"
echo "Trae 中国版全局技能安装脚本"
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

mkdir -p "$GLOBAL_SKILLS_DIR"

echo "正在从本地目录复制技能到全局目录..."
echo "源目录: $LOCAL_SKILLS_DIR"
echo "目标目录: $GLOBAL_SKILLS_DIR"
echo ""

for skill_dir in "$LOCAL_SKILLS_DIR"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        echo "正在安装技能: $skill_name"
        cp -rf "$skill_dir" "$GLOBAL_SKILLS_DIR/"
        echo "  ✓ 已安装"
    fi
done

echo ""
echo "======================================"
echo "安装完成！"
echo "======================================"
echo ""
echo "已安装的技能:"
ls -1 "$GLOBAL_SKILLS_DIR"
echo ""
echo "请重启 Trae IDE 以使全局技能生效。"
