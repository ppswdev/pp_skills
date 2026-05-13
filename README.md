# PP Skills

一个面向 Trae、Codex、Claude Code、VS Code 的统一 Skills 仓库。

## 项目简介

本项目将可复用的 agent skill 统一维护在一份源目录中，再同步到不同工具可识别的目录结构，减少重复维护成本。

## 当前能力

- 统一源目录：`skills/`
- 项目适配目录：
  - `.claude/skills/`
  - `.codex/skills/`
  - `.github/skills/`
  - `.trae/skills/`
- 共享规则文件：
  - `AGENTS.md`
  - `CLAUDE.md`
  - `.github/copilot-instructions.md`

## 技能列表

### pp-translator

国际化多语言自动翻译工具，支持简体中文和英文双基准语言的增量翻译。

### skill-creator

用于创建、迭代、评估和优化 Skill 的元技能。

## 推荐工作流

### 1. 编辑统一源目录

所有通用 Skill 优先在 `skills/` 的领域目录中维护。

### 2. 同步到项目适配目录

```bash
./scripts/sync-skills.sh
```

### 3. 安装到本机全局目录

```bash
./scripts/install-global-skills.sh
```

默认会安装到这些目录：

- `~/.claude/skills`
- `~/.codex/skills`
- `~/.copilot/skills`
- `~/.trae/skills`
- `~/.trae-cn/skills`

## 目录结构

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
├── docs/                   # 文档
└── scripts/                # 同步与安装脚本
```

## 文档

- [Skills 使用教程](docs/skills-tutorial.md)
- [全局配置指南](docs/skills-use-traecn.md)
- [Skills 创建提示词模板与多领域示例](docs/Skills创建提示词模板与多领域示例.md)
- [多工具统一 Skills 仓库方案](docs/多工具统一Skills仓库方案.md)

## 后续建议

当前按独立开发者全链路分层：

- `skills/opportunity/`：需求挖掘、选品、市场机会
- `skills/strategy/`：定位、定价、商业模式、路线图
- `skills/product/`：PRD、用户故事、功能规划
- `skills/research/`：用户研究、竞品、JTBD、反馈归因
- `skills/design/`：信息架构、交互、UI、设计系统
- `skills/engineering/`：开发、重构、测试、调试、部署
- `skills/data/`：指标体系、埋点、分析、看板
- `skills/growth/`：SEO、内容、社媒、邮件增长
- `skills/sales/`：落地页、销售文案、外联、转化材料
- `skills/monetization/`：定价、套餐、支付页、续费与变现
- `skills/operations/`：发布、活动、运营 SOP、复盘
- `skills/support/`：客服、知识库、工单洞察、口碑管理
- `skills/finance-legal/`：报价、合同、发票、条款、合规辅助
- `skills/localization/`：翻译、本地化、区域市场适配

## 许可证

MIT License
