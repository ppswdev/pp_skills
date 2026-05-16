# Copilot Instructions

本仓库存放可复用 agent skills，并通过同一份源目录同步到 Claude Code、Codex、Trae 中国版入口。

## Source of Truth

- 共享 skill 只在 `skills/<编号_分类>/<skill-name>/` 下维护。
- `skills/` 可以按编号分类嵌套，例如 `skills/05_design/ui-ux-pro-max/`。
- `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/` 是当前保留的扁平镜像入口。
- `.github/skills/` 不再作为同步目标；Copilot 只使用本文件作为仓库协作说明。

## Editing Rules

1. 修改共享 skill 时，更新 `skills/` 下对应编号分类目录。
2. 不要新增或恢复 `.github/skills/` 镜像目录，除非仓库策略再次调整。
3. 保持 `skill-name` 全局唯一，因为镜像目录会被同步为扁平结构。
4. 修改 `skills/` 后依次运行 `scripts/generate-docs-index.sh`、`scripts/sync-skills.sh`、`scripts/validate-skills.sh`。

## Skill Quality Bar

- `SKILL.md` frontmatter 至少包含 `name` 和 `description`。
- 触发描述清晰。
- 工作流程明确。
- 输出结构可复用。
- 大块参考资料放 `references/`，重复逻辑放 `scripts/`。
