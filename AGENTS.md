# Agent Workspace Rules

本仓库是可复用 agent skills 的统一源仓库。

## 仓库目标

- 维护一份共享 `skills/` 源目录
- 复用同一套 skill 内容到 Codex、Claude Code、Trae 中国版
- 工具专属入口保持扁平、轻量、可重新生成

## 目录结构

- `skills/`: canonical reusable skills root，允许分类嵌套
- `skills/00_base/`
- `skills/01_opportunity/`
- `skills/02_strategy/`
- `skills/03_product/`
- `skills/04_research/`
- `skills/05_design/`
- `skills/06_engineering/`
- `skills/07_data/`
- `skills/08_growth/`
- `skills/09_sales/`
- `skills/10_monetization/`
- `skills/11_operations/`
- `skills/12_support/`
- `skills/13_finance-legal/`
- `skills/14_localization/`
- `.claude/skills/`: Claude Code 项目入口，扁平镜像
- `.codex/skills/`: Codex 项目入口，扁平镜像
- `.trae-cn/skills/`: Trae 中国版技能入口，扁平镜像
- `docs/`: 使用指南、清单、方案文档
- `scripts/`: 同步和安装脚本

## 工作规则

1. 新增或修改 reusable skill 时，只编辑 `skills/<编号_分类>/<skill-name>/`。
2. 分类嵌套只放在 `skills/`；工具入口目录必须保持 `.tool/skills/<skill-name>/` 的扁平结构。
3. 把 `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/` 视为生成镜像，除非工具需要 local-only 文件，否则不要直接维护。
4. `skills/**/<skill-name>/` 的 `skill-name` 必须全局唯一，避免同步到扁平镜像时互相覆盖。
5. frontmatter 保持可移植：
   - required: `name`, `description`
   - 避免工具专属 metadata，除非清晰隔离
6. 大块领域知识放入 `references/`，不要塞满 `SKILL.md`。
7. 确定性或重复性逻辑放入 skill 内的 `scripts/`。

## Skill 编写建议

- `SKILL.md` 保持简洁、任务导向
- 触发描述要明确
- 添加真实用户调用示例
- 优先兼容多工具，不追求工具专属技巧

## 同步策略

修改 `skills/` 后运行：

```bash
scripts/generate-docs-index.sh
scripts/sync-skills.sh
scripts/validate-skills.sh
```

`generate-docs-index.sh` 会刷新技能目录和具体用法说明；`sync-skills.sh` 会把每个叶子 skill 同步为三个工具入口中的扁平目录；`validate-skills.sh` 会检查源目录、角色映射、用法页和镜像目录是否一致。
