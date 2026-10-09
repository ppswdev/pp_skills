# 多工具统一 Skills 仓库方案

本文档说明本仓库如何同时支持 TraeCN、Codex、Claude Code，并采用“源目录统一、安装按角色分发”的策略。

## 目标

- 用一份 `skills/` 作为唯一源目录
- 按角色生成项目级 skills，减少无关技能误触发
- 全局目录只保留极少数基础技能，默认只安装 `skill-creator`
- 为不同工具生成各自可识别的项目入口目录

## 当前目录规划

```text
pp_skills/
├── skills/                 # 统一源目录根
│   ├── 00_base/
│   ├── 05_design/
│   ├── 06_engineering/
│   └── 99_ppskills/
├── .claude/skills/         # Claude Code 项目技能入口，按角色生成
├── .codex/skills/          # Codex 项目技能入口，按角色生成
├── .trae-cn/skills/        # TraeCN 项目技能入口，按角色生成
├── docs/02_skill-catalog/role-map.yml
└── scripts/sync-skills.sh
```

## 使用方式

### 1. 编辑统一源目录

所有通用 Skill 都优先维护在领域目录中，例如：

```text
skills/99_ppskills/pp-tran/SKILL.md
skills/00_base/skill-creator/SKILL.md
```

### 2. 按角色同步到项目入口

日常使用不要全量同步。根据当前项目角色运行：

```bash
scripts/sync-skills.sh --role 程序开发者
scripts/sync-skills.sh --role 本地化
scripts/sync-skills.sh --role 程序开发者 --role 本地化
```

脚本会根据 `docs/02_skill-catalog/role-map.yml` 选择角色对应的 skills，并同步到：

- `.claude/skills/`
- `.codex/skills/`
- `.trae-cn/skills/`

### 3. 全量同步仅用于维护或调试

```bash
scripts/sync-skills.sh --all
```

`--all` 会把所有源目录 skills 同步到项目入口。它会扩大触发面，不推荐日常项目使用。

### 4. 生成文档索引和用法说明

新增或移动 Skill 后，运行：

```bash
scripts/generate-docs-index.sh
```

脚本会根据 `skills/**/SKILL.md` 和 `docs/02_skill-catalog/role-map.yml` 生成：

- `docs/02_skill-catalog/技能总览.md`
- `docs/02_skill-catalog/按技能分类.md`
- `docs/02_skill-catalog/按使用角色.md`
- `docs/03_skill-usage/<skill-name>.md`

### 5. 全局只安装基础技能

```bash
scripts/install-global-skills.sh
```

脚本只会安装 `skill-creator` 到：

- `~/.claude/skills`
- `~/.codex/skills`
- `~/.trae-cn/skills`

具体业务技能通过项目级 `scripts/sync-skills.sh --role <角色名>` 启用。

### 6. 验证仓库一致性

```bash
scripts/validate-skills.sh
scripts/validate-skills.sh --role 程序开发者
scripts/validate-skills.sh --role 程序开发者 --role 本地化
scripts/validate-skills.sh --all
```

验证内容包括：frontmatter、skill-name 唯一性、角色映射、用法页、镜像目录是否扁平，以及项目镜像是否符合当前角色选择。

## 维护建议

### 适合放入统一源目录的内容

- 通用方法论
- 可复用工作流
- 结构化输出规范
- 行业分析框架
- 可被角色映射明确归类的业务技能

### 不建议全局启用的内容

- 触发描述很强、容易在任意项目误触发的技能
- 强依赖某一角色或某一业务上下文的技能
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
