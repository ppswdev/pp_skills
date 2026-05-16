# Claude Code 工作区说明

## 仓库定位

本仓库是 Claude Code、Codex、Trae 中国版共用的 Skills 源仓库。

`skills/` 是唯一长期维护的源目录；各工具入口目录只作为同步生成的镜像，尽量保持轻薄、可重建。

## 目录结构

```text
pp_skills/
├── skills/                 # 统一源目录根，允许按分类嵌套
│   ├── 00_base/
│   ├── 01_opportunity/
│   ├── 02_strategy/
│   ├── 03_product/
│   ├── 04_research/
│   ├── 05_design/
│   ├── 06_engineering/
│   ├── 07_data/
│   ├── 08_growth/
│   ├── 09_sales/
│   ├── 10_monetization/
│   ├── 11_operations/
│   ├── 12_support/
│   ├── 13_finance-legal/
│   └── 14_localization/
├── .claude/skills/         # Claude Code 项目技能入口，扁平镜像
├── .codex/skills/          # Codex 项目技能入口，扁平镜像
├── .trae-cn/skills/        # Trae 中国版技能入口，扁平镜像
├── AGENTS.md               # 通用工作区说明
├── CLAUDE.md               # Claude Code 工作区说明
├── .github/copilot-instructions.md
└── scripts/sync-skills.sh  # 同步脚本
```

## 核心规则

- 分类嵌套只放在 `skills/` 里，例如 `skills/05_design/ui-ux-pro-max/`。
- 工具入口目录必须保持扁平，例如 `.claude/skills/ui-ux-pro-max/`、`.trae-cn/skills/ui-ux-pro-max/`。
- 不要在 `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/` 中再建立 `design/`、`frontend/`、`tools/` 这类分类目录。
- `skills/**/<skill-name>/` 的 `skill-name` 必须全局唯一，因为同步后会落到扁平镜像目录。
- `.claude/skills/` 是 Claude Code 的项目入口，不是源目录；除非文件确实只服务 Claude Code，否则不要直接维护这里的 skill 内容。

## 编辑规则

1. 新增或修改可复用 skill 时，只编辑 `skills/<编号_分类>/<skill-name>/`。
2. 导入外部 skill 时，先放入最合适的 `skills/` 编号分类，再运行同步脚本。
3. 修改 `skills/` 后运行 `scripts/sync-skills.sh`，刷新 `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/`。
4. 不要手写三个工具入口中的重复逻辑；这些目录应该可以随时由 `skills/` 重新生成。
5. 调整分类时，优先移动源目录，再同步镜像目录。

## Skill 编写规则

- 每个 skill 必须包含 `SKILL.md`。
- `SKILL.md` frontmatter 至少包含 `name` 和 `description`。
- `SKILL.md` 保持简洁、任务导向、触发条件明确。
- 大块领域知识放到 `references/`。
- 可重复执行的确定性逻辑放到 skill 内的 `scripts/`。
- 模板、字体、示例素材、静态资源放到 `assets/` 或 skill 自己约定的资源目录。
- 优先写跨工具可复用的说明；只有确实必要时才加入工具专属规则。

## 分类说明

- `00_base/`：基础元技能、通用工具、文档处理、API 辅助、构建器。
- `01_opportunity/`：机会发现、需求信号、选题和市场切入。
- `02_strategy/`：定位、商业模式、路线图、优先级和策略判断。
- `03_product/`：PRD、功能规划、用户故事、产品规格。
- `04_research/`：用户研究、竞品研究、JTBD、反馈归因。
- `05_design/`：视觉设计、品牌、主题、画布、UI/UX。
- `06_engineering/`：前端、工程实践、测试、部署、开发工作流。
- `07_data/`：指标、埋点、分析、看板、实验。
- `08_growth/`：SEO、内容、社媒、邮件、增长实验。
- `09_sales/`：销售文案、外联、落地页、转化材料。
- `10_monetization/`：定价、套餐、支付页、续费与变现。
- `11_operations/`：发布、活动、运营 SOP、复盘。
- `12_support/`：客服、知识库、工单洞察、口碑管理。
- `13_finance-legal/`：报价、合同、发票、条款、合规辅助。
- `14_localization/`：翻译、本地化、多地区市场适配。

## 同步规则

`scripts/sync-skills.sh` 会扫描所有 `skills/**/SKILL.md`，然后把每个叶子 skill 同步为扁平目录：

```text
skills/05_design/ui-ux-pro-max/
  -> .claude/skills/ui-ux-pro-max/
  -> .codex/skills/ui-ux-pro-max/
  -> .trae-cn/skills/ui-ux-pro-max/
```

如果发现某个入口目录出现分类嵌套，优先检查是否有人绕过了 `skills/` 源目录直接改镜像。

新增或移动 skill 后，还必须运行：

```bash
scripts/generate-docs-index.sh
scripts/sync-skills.sh
scripts/validate-skills.sh
```

其中 `generate-docs-index.sh` 会更新 `docs/02_skill-catalog/` 和 `docs/03_skill-usage/`，确保安装后的用户知道每个 skill 怎么用。
