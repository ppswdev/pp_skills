# PP Skills

面向 Claude Code、Codex、Trae 中国版的统一 Skills 仓库。

## 项目简介

本仓库把可复用的 agent skills 统一维护在 `skills/` 源目录中，再同步到不同工具可识别的扁平入口目录，减少重复维护成本。

## 核心规则

- `skills/` 是唯一源目录，可以按编号分类嵌套。
- `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/` 是工具入口镜像，保持扁平结构。
- 分类目录只出现在 `skills/` 中，不出现在工具入口中。
- `skills/**/<skill-name>/` 的 `skill-name` 必须全局唯一，避免同步后覆盖。

## 目录结构

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
├── .claude/skills/         # Claude Code 项目技能入口，扁平镜像
├── .codex/skills/          # Codex 项目技能入口，扁平镜像
├── .trae-cn/skills/        # Trae 中国版技能入口，扁平镜像
├── docs/                   # 使用指南和方案文档
└── scripts/                # 同步与安装脚本
```

## 推荐工作流

### 1. 编辑统一源目录

新增或修改 skill 时，只改 `skills/<编号_分类>/<skill-name>/`。

### 2. 生成文档索引和用法说明

```bash
./scripts/generate-docs-index.sh
```

脚本会生成技能目录、角色索引，以及 `docs/03_skill-usage/<skill-name>.md` 具体用法页。

### 3. 同步到项目入口

```bash
./scripts/sync-skills.sh
```

脚本会扫描 `skills/**/SKILL.md`，并同步为：

- `.claude/skills/<skill-name>/`
- `.codex/skills/<skill-name>/`
- `.trae-cn/skills/<skill-name>/`

### 4. 验证一致性

```bash
./scripts/validate-skills.sh
```

### 5. 安装到本机全局目录

```bash
./scripts/install-global-skills.sh
```

默认会安装到：

- `~/.claude/skills`
- `~/.codex/skills`
- `~/.trae-cn/skills`

## 分类说明

- `00_base/`：基础元技能、通用工具、文档处理、API 辅助、构建器
- `01_opportunity/`：机会发现、需求信号、选题和市场切入
- `02_strategy/`：定位、商业模式、路线图、优先级和策略判断
- `03_product/`：PRD、功能规划、用户故事、产品规格
- `04_research/`：用户研究、竞品研究、JTBD、反馈归因
- `05_design/`：视觉设计、品牌、主题、画布、UI/UX
- `06_engineering/`：前端、工程实践、测试、部署、开发工作流
- `07_data/`：指标、埋点、分析、看板、实验
- `08_growth/`：SEO、内容、社媒、邮件、增长实验
- `09_sales/`：销售文案、外联、落地页、转化材料
- `10_monetization/`：定价、套餐、支付页、续费与变现
- `11_operations/`：发布、活动、运营 SOP、复盘
- `12_support/`：客服、知识库、工单洞察、口碑管理
- `13_finance-legal/`：报价、合同、发票、条款、合规辅助
- `14_localization/`：翻译、本地化、多地区市场适配

## 文档

- [Docs 文档索引](docs/README.md)
- [Skills 使用教程](docs/00_getting-started/skills-tutorial.md)
- [Trae 中国版 Skills 全局配置指南](docs/00_getting-started/skills-use-traecn.md)
- [技能具体用法说明](docs/03_skill-usage/README.md)
- [Skills 创建提示词模板与多领域示例](docs/05_skill-authoring/Skills创建提示词模板与多领域示例.md)
- [多工具统一 Skills 仓库方案](docs/01_repository/多工具统一Skills仓库方案.md)

## 许可证

MIT License
