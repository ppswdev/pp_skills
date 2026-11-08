#!/usr/bin/env bash
set -euo pipefail

repo="https://github.com/ppswdev/pp_skills.git"
scope="project"
agent=""
force=0

usage() {
  printf '%s\n' '用法: bash install-ppskills.sh [--agent codex|claude|trae-cn|all] [--global] [--force]' \
    '默认安装到当前项目。同名技能默认跳过；--force 覆盖同名技能。'
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent) [ "$#" -ge 2 ] || { usage >&2; exit 1; }; agent="$2"; shift 2 ;;
    --global) scope="global"; shift ;;
    --force) force=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "未知参数: $1" >&2; usage >&2; exit 1 ;;
  esac
done

if [ -z "$agent" ]; then
  if ! [ -r /dev/tty ] || ! { : </dev/tty; } 2>/dev/null; then
    echo '无法交互选择工具，请使用 --agent codex|claude|trae-cn|all。' >&2
    exit 1
  fi
  printf '选择安装工具 [1 Codex, 2 Claude Code, 3 Trae 中国版, 4 全部]: ' > /dev/tty
  IFS= read -r choice < /dev/tty
  case "$choice" in
    1) agent=codex ;;
    2) agent=claude ;;
    3) agent=trae-cn ;;
    4) agent=all ;;
    *) echo '无效的选择。' >&2; exit 1 ;;
  esac
fi
case "$agent" in codex|claude|trae-cn|all) ;; *) echo "无效的工具: $agent" >&2; exit 1 ;; esac

command -v git >/dev/null 2>&1 || { echo '需要安装 Git。' >&2; exit 1; }
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
echo '正在从 GitHub 下载技能仓库...'
git clone --quiet --depth 1 "$repo" "$tmp_dir/repo"
source_dir="$tmp_dir/repo/skills/99_ppskills"
[ -d "$source_dir" ] || { echo '仓库中没有 skills/99_ppskills。' >&2; exit 1; }

if [ "$scope" = global ]; then target_root="$HOME"; else target_root="$PWD"; fi
for tool in codex claude trae-cn; do
  [ "$agent" = all ] || [ "$agent" = "$tool" ] || continue
  target_dir="$target_root/.$tool/skills"
  mkdir -p "$target_dir"
  for skill_dir in "$source_dir"/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    name="$(basename "$skill_dir")"
    target="$target_dir/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      if [ "$force" -ne 1 ]; then
        echo "跳过已存在的技能: $target"
        continue
      fi
      rm -rf "$target"
    fi
    cp -R "$skill_dir" "$target"
    echo "已安装: $target"
  done
done
