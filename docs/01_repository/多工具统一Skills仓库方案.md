# 多工具统一 Skills 仓库方案

本文档说明本仓库如何同时支持 TraeCN、Codex、Claude Code。

## 目标

- 用一份 `skills/` 作为统一源目录
- 为不同工具生成各自可识别的项目目录
- 减少重复维护成本

## 当前目录规划

```text
pp_skills/
├── skills/                 # 统一源目录根
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
├── .claude/skills/         # Claude Code 项目技能入口
├── .codex/skills/          # Codex 项目技能入口
├── .trae-cn/skills/        # TraeCN 项目技能入口
├── AGENTS.md               # 通用工作区说明
├── CLAUDE.md               # Claude Code 工作区说明
└── scripts/sync-skills.sh  # 同步脚本
```

## 使用方式

### 1. 编辑统一源目录

所有通用 Skill 都优先维护在领域目录中，例如：

```text
skills/99_ppskills/pp-tran/SKILL.md
skills/00_base/skill-creator/SKILL.md
```

### 2. 同步到各工具目录

运行：

```bash
./scripts/sync-skills.sh
```

脚本会递归扫描 `skills/` 下所有叶子 Skill，并同步到：

- `.claude/skills/`
- `.codex/skills/`
- `.trae-cn/skills/`

### 3. 生成文档索引和用法说明

新增或移动 Skill 后，运行：

```bash
./scripts/generate-docs-index.sh
```

脚本会根据 `skills/**/SKILL.md` 和 `docs/02_skill-catalog/role-map.yml` 生成：

- `docs/02_skill-catalog/技能总览.md`
- `docs/02_skill-catalog/按技能分类.md`
- `docs/02_skill-catalog/按使用角色.md`
- `docs/03_skill-usage/<skill-name>.md`

### 4. 安装到全局目录

如果你希望本机工具都复用这份仓库中的 Skill，可以运行：

```bash
./scripts/install-global-skills.sh
```

脚本会把 `skills/` 安装到常见的全局目录：

- `~/.claude/skills`
- `~/.codex/skills`
- `~/.trae-cn/skills`

### 5. 验证仓库一致性

提交前运行：

```bash
./scripts/validate-skills.sh
```

验证内容包括：frontmatter、skill-name 唯一性、角色映射、用法页、镜像目录数量和废弃入口目录。

## 维护建议

### 适合放入统一源目录的内容

- 通用方法论
- 可复用工作流
- 结构化输出规范
- 行业分析框架

### 不建议强耦合共享的内容

- 仅某一工具支持的特殊元数据
- 强依赖某一工具内部能力的说明
- 与某个项目环境深度耦合的脚本

## 推荐分类方式

建议长期按独立开发者全链路保持以下分层：

```text
skills/01_opportunity/sku-selection-analyst/
skills/02_strategy/pricing-strategy-planner/
skills/03_product/product-requirements-discovery/
skills/04_research/jtbd-interview-synthesizer/
skills/05_design/product-design-planner/
skills/06_engineering/skill-creator/
skills/07_data/analytics-copilot/
skills/08_growth/content-engine/
skills/09_sales/landing-page-writer/
skills/10_monetization/checkout-copy-optimizer/
skills/11_operations/product-operations-planner/
skills/12_support/support-insight-miner/
skills/13_finance-legal/invoice-contract-assistant/
skills/99_ppskills/pp-tran/
```
