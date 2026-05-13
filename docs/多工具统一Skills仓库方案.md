# 多工具统一 Skills 仓库方案

本文档说明本仓库如何同时支持 Trae、Codex、Claude Code 和 VS Code。

## 目标

- 用一份 `skills/` 作为统一源目录
- 为不同工具生成各自可识别的项目目录
- 减少重复维护成本

## 当前目录规划

```text
pp_skills/
├── skills/                 # 统一源目录根
│   ├── opportunity/
│   ├── strategy/
│   ├── product/
│   ├── research/
│   ├── design/
│   ├── engineering/
│   ├── data/
│   ├── growth/
│   ├── sales/
│   ├── monetization/
│   ├── operations/
│   ├── support/
│   ├── finance-legal/
│   └── localization/
├── .claude/skills/         # Claude Code 项目技能入口
├── .codex/skills/          # Codex 项目技能入口
├── .github/skills/         # VS Code / Copilot 技能入口
├── .trae/skills/           # Trae 项目技能入口
├── AGENTS.md               # 通用工作区说明
├── CLAUDE.md               # Claude Code 工作区说明
├── .github/copilot-instructions.md
└── scripts/sync-skills.sh  # 同步脚本
```

## 使用方式

### 1. 编辑统一源目录

所有通用 Skill 都优先维护在领域目录中，例如：

```text
skills/localization/pp-translator/SKILL.md
skills/engineering/skill-creator/SKILL.md
```

### 2. 同步到各工具目录

运行：

```bash
./scripts/sync-skills.sh
```

脚本会递归扫描 `skills/` 下所有叶子 Skill，并同步到：

- `.claude/skills/`
- `.codex/skills/`
- `.github/skills/`
- `.trae/skills/`

### 3. 安装到全局目录

如果你希望本机工具都复用这份仓库中的 Skill，可以运行：

```bash
./scripts/install-global-skills.sh
```

脚本会把 `skills/` 安装到常见的全局目录：

- `~/.claude/skills`
- `~/.codex/skills`
- `~/.copilot/skills`
- `~/.trae/skills`
- `~/.trae-cn/skills`

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
skills/opportunity/sku-selection-analyst/
skills/strategy/pricing-strategy-planner/
skills/product/product-requirements-discovery/
skills/research/jtbd-interview-synthesizer/
skills/design/product-design-planner/
skills/engineering/skill-creator/
skills/data/analytics-copilot/
skills/growth/content-engine/
skills/sales/landing-page-writer/
skills/monetization/checkout-copy-optimizer/
skills/operations/product-operations-planner/
skills/support/support-insight-miner/
skills/finance-legal/invoice-contract-assistant/
skills/localization/pp-translator/
```
