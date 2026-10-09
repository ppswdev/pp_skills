# 全球独立开发者必装 Skills 全栈清单

> 更新时间：2026-05-12  
> 适用对象：面向海外市场的独立开发者、出海团队、AI Native 小团队  
> 目标：覆盖产品需求分析挖掘、产品设计、产品开发、产品运营增长、变现与全球化支持

## 一句话结论

如果你是做全球市场的独立开发者，**不是装越多 Skills 越好**，而是先搭一套能贯穿「发现需求 -> 设计产品 -> 开发上线 -> 获取流量 -> 持续变现」的最小闭环。

最推荐先装这 4 类公开能力，再基于 `skill-creator` 补齐你自己的业务专属 Skills：

| 类型 | 推荐安装 | 用途 |
| --- | --- | --- |
| 基础母库 | [anthropics/skills](https://github.com/anthropics/skills) | 自定义 Skill、通用工作流、文档化能力的基础模板 |
| 开发与审查 | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | React/Next.js 最佳实践、UI 审查、部署类工作流 |
| 产品设计 | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | UI/UX 设计系统、风格策略、界面落地 |
| 技能发现 | [agent-skills-hub/agent-skills-hub](https://github.com/agent-skills-hub/agent-skills-hub) | 搜索更多现成 Skills，补充长尾场景 |

---

## 建议采用的完整分类

如果你的目标不是“做几个 demo”，而是长期经营独立开发业务，建议技能仓库按下面 14 类组织：

| 分类目录 | 作用 | 典型 Skill |
| --- | --- | --- |
| `opportunity/` | 找机会、找需求、找赛道 | `sku-selection-analyst`、`opportunity-miner` |
| `strategy/` | 做定位、定价、商业模式与路线图 | `pricing-strategy-planner`、`positioning-copilot` |
| `product/` | 产出 PRD、用户故事、需求拆解 | `product-requirements-discovery` |
| `research/` | 用户研究、竞品、反馈归因、JTBD | `jtbd-interview-synthesizer`、`competitor-scan` |
| `design/` | 信息架构、交互、视觉、设计评审 | `product-design-planner`、`ui-ux-pro-max-skill` |
| `engineering/` | 开发、测试、调试、重构、部署 | `skill-creator`、`react-best-practices` |
| `data/` | 埋点、看板、指标体系、实验分析 | `analytics-copilot` |
| `growth/` | SEO、内容、社媒、邮件增长 | `content-engine`、`seo-opportunity-miner` |
| `sales/` | 落地页、销售文案、客户外联、转化材料 | `landing-page-writer` |
| `monetization/` | 套餐、支付页、续费、促销、价格实验 | `checkout-copy-optimizer`、`pricing-experiment-planner` |
| `operations/` | 发布、活动、运营 SOP、版本说明、复盘 | `product-operations-planner`、`release-notes-generator` |
| `support/` | 客服、知识库、工单洞察、口碑维护 | `support-insight-miner` |
| `finance-legal/` | 报价、发票、合同、条款、基础合规辅助 | `invoice-contract-assistant` |
| `localization/` | 翻译、本地化、区域市场适配 | `pp-tran`、`market-localization-playbook` |

这套分类比“产品 / 设计 / 开发 / 运营”更完整，因为它覆盖了独立开发者最容易忽略、但最直接决定收入的几段：

- 机会判断
- 增长获客
- 销售转化
- 变现设计
- 客服与留存
- 财务法务

---

## 核心原则

全球独立开发者真正必备的，不是“会写代码”的 Skills，而是下面 3 类：

1. **能帮你找到真实需求的 Skills**
2. **能把产品做出来并快速验证的 Skills**
3. **能把流量、留存和付费跑起来的 Skills**

其中第 3 类在公开社区里最缺，所以要接受一个现实：  
**运营与变现类 Skills，很多都需要你基于自己的产品阶段自建。**

---

## 公开必装仓库与工具表

| 名称 | 类型 | 适合阶段 | 亮点 | 推荐指数 |
| --- | --- | --- | --- | --- |
| [anthropics/skills](https://github.com/anthropics/skills) | 基础 Skill 仓库 | 全阶段 | 官方示例库，适合拿来二次改造、自建业务 Skill | 必装 |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | 开发类 Skill 集合 | 开发、审查、部署 | `react-best-practices`、`web-design-guidelines` 很实用 | 必装 |
| [ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 设计类 Skill | 设计、前端实现 | 设计风格库、配色、字体、设计系统建议很强 | 必装 |
| [agent-skills-hub](https://github.com/agent-skills-hub/agent-skills-hub) | Skills 目录/注册表 | 补充长尾需求 | 方便发现冷门但高价值的垂直 Skill | 推荐 |
| [skills.sh](https://skills.sh/) | Skills 搜索平台 | 补充长尾需求 | 搜索、发现、安装更多跨平台 Skills | 推荐 |

---

## 全栈必备 Skills 总表

说明：

- `现成可装`：社区已有公开仓库或成熟集合，建议直接装。
- `建议自建`：最好基于 `skill-creator` 做成你自己的长期资产。
- `优先级`：`P0` 表示最先装，`P1` 表示第二梯队，`P2` 表示按业务阶段补齐。

| 业务环节 | 推荐 Skill | 类型 | 主要解决问题 | 推荐来源 / 实现方式 | 优先级 |
| --- | --- | --- | --- | --- | --- |
| 产品需求分析 | `request-analyzer` | 建议自建 | 把零散想法整理成 PRD、用户故事、验收标准 | 基于 `anthropics/skills` 的 `skill-creator` 自建 | P0 |
| 用户访谈与痛点提炼 | `jtbd-interview-synthesizer` | 建议自建 | 汇总访谈记录，提炼 JTBD、购买动机、阻力点 | 用 `skill-creator` 封装你的访谈分析模板 | P0 |
| 用户反馈归因 | `feedback-clustering` | 建议自建 | 把评论、邮件、聊天记录聚类成需求主题 | 用你自己的标签体系和分群规则封装 | P0 |
| 竞品调研 | `competitor-scan` | 建议自建 | 自动抽取竞品定位、功能、定价、渠道与差异点 | 配合网页抓取/浏览器能力自建 | P0 |
| 关键词与市场机会挖掘 | `seo-opportunity-miner` | 建议自建 | 找 SEO 机会词、用户搜索意图、长尾入口 | 结合搜索数据与内容模板自建 | P0 |
| 产品设计系统 | `ui-ux-pro-max-skill` | 现成可装 | 提供设计方向、字体、配色、组件风格和视觉语言 | `nextlevelbuilder/ui-ux-pro-max-skill` | P0 |
| 设计评审与可用性检查 | `web-design-guidelines` | 现成可装 | 检查可访问性、交互、排版、表单、动效与 UX 细节 | `vercel-labs/agent-skills` | P0 |
| Figma 协作与设计落地 | `figma-use` / `figma-implement-design` | 平台型能力 | 把设计稿与代码衔接起来，减少设计还原损耗 | 适合支持 Figma 插件/Skill 的平台 | P1 |
| React / Next.js 工程质量 | `react-best-practices` | 现成可装 | 组件结构、性能、数据获取、渲染与可维护性 | `vercel-labs/agent-skills` | P0 |
| 文档与 SOP 生产 | `documentation-writer` | 建议自建 | PRD、上线说明、FAQ、客服话术、内部 SOP 标准化 | 以 `anthropics/skills` 为母库二次封装 | P1 |
| 调试排障 | `investigation-mode` | 平台型能力 | 当页面、接口、流程异常时快速定位问题 | 适合带验证/浏览器能力的平台 | P1 |
| 浏览器验证 | `browser-use` / `verification` | 平台型能力 | 自动走通关键路径，验证登录、支付、表单、转化流程 | 适合带 Browser 插件或浏览器自动化的平台 | P1 |
| PDF / 文档处理 | `pdf` / `documents` | 平台型能力 | 生成方案、导出报价单、阅读 PDF、批注文档 | 适合支持文档技能的平台 | P2 |
| 表格 / 数据分析 | `spreadsheets` | 平台型能力 | 分析收入、渠道 ROI、关键词数据、内容投放结果 | 适合支持表格技能的平台 | P1 |
| 国际化翻译 | `pp-tran` | 现成可装 | 多语言文案翻译、增量翻译、国际化支持 | 本仓库已有 `pp-tran` | P0 |
| 地区化策略 | `market-localization-playbook` | 建议自建 | 针对美国、欧洲、日本、中东等市场输出本地化策略 | 把你的市场经验写进 Skill | P1 |
| 内容营销 | `content-engine` | 建议自建 | 把产品卖点批量改写为博客、X、LinkedIn、Reddit、邮件内容 | 封装你的内容模板与语气规范 | P0 |
| SEO 落地页生产 | `landing-page-writer` | 建议自建 | 为每个关键词或场景生成高转化落地页结构 | 结合产品卖点、FAQ、社证模板自建 | P0 |
| 社媒分发 | `social-repurposer` | 建议自建 | 一篇内容改成短帖、长帖、短视频脚本、论坛发帖文案 | 适合持续内容增长 | P1 |
| 邮件增长 | `email-lifecycle-copilot` | 建议自建 | 欢迎信、激活信、召回信、续费提醒、促销活动编排 | 用你的用户分层和事件节点封装 | P1 |
| 定价策略 | `pricing-experiment-planner` | 建议自建 | 设计试用、付费墙、套餐结构、价格实验方案 | 结合你的 ARPU、留存与客单价目标封装 | P0 |
| 支付页与转化文案 | `checkout-copy-optimizer` | 建议自建 | 优化支付页标题、权益对比、FAQ、担保文案 | 适合 SaaS、工具类产品 | P0 |
| 数据看板与 KPI 树 | `analytics-copilot` | 建议自建 | 沉淀核心指标：流量、激活、留存、转化、ARPU、LTV | 用你的指标口径做成长期 Skill | P0 |
| 客服与口碑运营 | `support-insight-miner` | 建议自建 | 把工单、邮件、评论提炼成 bug、需求、流失原因与证据 | 适合复盘与迭代 | P1 |
| 发布与版本说明 | `release-notes-generator` | 建议自建 | 自动产出更新日志、站内公告、社媒更新说明 | 从 Git 记录与 issue 模板抽取 | P2 |

---

## 最小必装组合

如果你现在还没有完整 Skill 体系，建议先按下面顺序装：

| 顺序 | 先装什么 | 理由 |
| --- | --- | --- |
| 1 | `anthropics/skills` | 这是你后续自建所有业务 Skill 的基础母库 |
| 2 | `vercel-labs/agent-skills` | 先把开发质量、UI 检查、前端工程能力补齐 |
| 3 | `ui-ux-pro-max-skill` | 解决独立开发最容易短板的“设计不专业”问题 |
| 4 | `pp-tran` | 直接解决出海产品多语言问题 |
| 5 | 自建 `request-analyzer` | 没有需求发现能力，后面都是低效开发 |
| 6 | 自建 `content-engine` | 没有内容分发能力，产品容易做完没人来 |
| 7 | 自建 `pricing-experiment-planner` | 没有变现实验，增长很难转成收入 |
| 8 | 自建 `analytics-copilot` | 没有指标体系，就无法稳定迭代 |

---

## 不同阶段的装法

### 1. 0 到 1 验证期

优先安装：

- `request-analyzer`
- `jtbd-interview-synthesizer`
- `competitor-scan`
- `ui-ux-pro-max-skill`
- `react-best-practices`
- `pp-tran`

核心目标：

- 快速找到真实需求
- 快速做出 MVP
- 快速面向全球上线

### 2. 已上线但流量少

优先安装：

- `seo-opportunity-miner`
- `landing-page-writer`
- `content-engine`
- `social-repurposer`
- `analytics-copilot`

核心目标：

- 建立内容流量入口
- 提升获客效率
- 明确哪个渠道最赚钱

### 3. 有流量但付费差

优先安装：

- `pricing-experiment-planner`
- `checkout-copy-optimizer`
- `email-lifecycle-copilot`
- `support-insight-miner`

核心目标：

- 提升试用转付费
- 提升付费页转化率
- 降低流失和退款

---

## 安装建议

### 通用公开仓库

```bash
npx skills add anthropics/skills
npx skills add vercel-labs/agent-skills
```

### 安装 UI/UX Pro Max

```bash
npm install -g uipro-cli
uipro init --ai trae
```

如果你使用的不是 Trae，可以按仓库说明把 `trae` 替换成对应 agent 名称。

### 本项目内已有技能

项目内已经包含：

- `.trae-cn/skills/pp-tran`
- `.trae-cn/skills/skill-creator`

如果你想在当前项目启用独立开发者相关技能，可参考：

```bash
scripts/sync-skills.sh --role 独立开发者
```

---

## 最值得你自己做成长期资产的 8 个 Skill

公开 Skills 能解决 60 分到 80 分的问题，但真正拉开差距的是下面这些“只属于你”的 Skill：

| Skill 名称 | 为什么值得自建 |
| --- | --- |
| `request-analyzer` | 决定你是否总能从模糊想法里挖到值得做的需求 |
| `jtbd-interview-synthesizer` | 决定你能不能读懂用户为什么买、为什么不买 |
| `competitor-scan` | 决定你能不能快速看清市场空位和差异化角度 |
| `content-engine` | 决定你是否能稳定产出营销内容，而不是临时写文案 |
| `landing-page-writer` | 决定你是否能规模化做 SEO 与转化落地页 |
| `pricing-experiment-planner` | 决定你是否能系统化做价格与套餐实验 |
| `analytics-copilot` | 决定你能不能真正按指标迭代，而不是靠感觉 |
| `support-insight-miner` | 决定你是否能把用户反馈持续转成增长和留存动作 |

---

## 推荐落地路径

建议按下面路径搭建你的 Skill 体系：

1. 先安装公开仓库：`anthropics/skills`、`vercel-labs/agent-skills`、`ui-ux-pro-max-skill`
2. 直接复用本仓库的 `pp-tran` 和 `skill-creator`
3. 用 `skill-creator` 先做 3 个自有 Skills：`request-analyzer`、`content-engine`、`analytics-copilot`
4. 等有稳定用户后，再补 `pricing-experiment-planner` 和 `support-insight-miner`

这样搭出来的，不是一堆零散 Skills，而是一套真正服务独立开发业务闭环的 AI 技能系统。
