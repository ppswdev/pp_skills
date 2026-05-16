# 产品运营 Skills 清单

> 更新时间：2026-05-14  
> 适用对象：产品运营、增长运营、用户运营、内容运营、商业化运营、独立开发者运营负责人  
> 目标：整理一套只服务产品运营工作的 Skills 规划清单，帮助后续按优先级创建、安装和维护

## 一句话结论

产品运营类 Skills 不应该追求“全能”，而应该围绕一个核心闭环：

**看清用户与数据 -> 设计运营动作 -> 推动用户激活与留存 -> 提升转化与收入 -> 复盘沉淀 SOP**

这份清单只覆盖产品上线后的运营增长、用户经营、内容分发、活动、商业化和复盘协作，不包含工程开发、UI 设计、代码审查、部署、财务法务等非产品运营技能。

---

## 产品运营 Skill 边界

### 包含

- 用户反馈、评论、工单、访谈的整理和归因
- 用户分层、生命周期运营、激活、留存、召回
- 内容选题、SEO、社媒分发、社区运营
- 活动策划、发布运营、版本说明、运营 SOP
- 定价包装、付费转化、促销、续费、退款原因分析
- 指标体系、看板口径、A/B 实验、复盘报告

### 不包含

- 前端、后端、移动端开发
- UI 视觉设计和设计系统生产
- 代码质量审查、测试、CI/CD、部署
- 合同、税务、融资、公司治理
- 通用办公自动化，除非它直接服务产品运营闭环

---

## 推荐目录归属

产品运营不是单一目录，而是横跨多个业务域。建议在本仓库中按下面目录拆分：

| 目录 | 产品运营职责 | 典型 Skill |
| --- | --- | --- |
| `skills/operations/` | 发布、活动、运营 SOP、版本公告、复盘 | `product-ops-planner`、`release-ops-writer` |
| `skills/growth/` | 获客、内容、SEO、社媒、增长实验 | `growth-campaign-planner`、`seo-content-ops` |
| `skills/data/` | 指标、看板、实验、漏斗分析 | `product-metrics-analyst`、`ab-test-reviewer` |
| `skills/product/` | 反馈转需求、版本优先级、运营视角需求 | `feedback-to-roadmap` |
| `skills/support/` | 客服洞察、用户问题归因、知识库运营 | `support-insight-miner` |
| `skills/monetization/` | 付费转化、套餐包装、续费、促销 | `pricing-conversion-ops` |
| `skills/localization/` | 多语言运营、本地化活动、地区文案 | `market-localization-ops`、`pp-translator` |

---

## P0 必备 Skills

P0 是产品运营最先应该沉淀的技能，适合所有已上线或准备上线的产品。

| Skill 名称 | 建议目录 | 主要用途 | 输入 | 输出 |
| --- | --- | --- | --- | --- |
| `product-ops-planner` | `skills/operations/` | 把一个产品目标拆成运营策略、动作节奏、资源需求和复盘口径 | 产品目标、用户阶段、周期、约束 | 运营计划、排期、风险、验收指标 |
| `feedback-insight-miner` | `skills/product/` | 从用户反馈中提炼问题、机会、需求优先级 | 工单、评论、访谈、客服记录 | 问题聚类、证据摘录、需求建议 |
| `product-metrics-analyst` | `skills/data/` | 建立产品运营指标体系和漏斗分析口径 | 埋点、订单、访问、用户行为数据 | KPI 树、漏斗诊断、异常原因假设 |
| `activation-ops-designer` | `skills/operations/` | 设计新用户激活路径和首日/首周运营动作 | 用户旅程、注册流程、核心功能 | 激活方案、触达节点、实验建议 |
| `retention-lifecycle-ops` | `skills/operations/` | 设计留存、召回、续用的生命周期运营 | 用户分层、活跃数据、功能使用情况 | 分层策略、触达内容、节奏表 |
| `release-ops-writer` | `skills/operations/` | 生成版本发布运营材料 | 更新内容、修复项、目标用户 | 更新日志、站内公告、社媒文案、邮件 |
| `content-ops-engine` | `skills/growth/` | 把产品卖点转成内容选题和分发计划 | 产品功能、用户痛点、关键词 | 内容日历、标题、渠道改写 |
| `seo-content-ops` | `skills/growth/` | 挖掘搜索意图并规划 SEO 内容页 | 关键词、竞品页面、产品场景 | 关键词分组、页面结构、内容 brief |
| `pricing-conversion-ops` | `skills/monetization/` | 优化套餐包装、支付页和付费转化 | 套餐、价格、转化数据、用户异议 | 付费页文案、权益对比、实验方案 |
| `ops-review-generator` | `skills/operations/` | 产出周期性运营复盘 | 目标、动作、数据、问题记录 | 周报/月报、结论、下阶段动作 |

---

## P1 进阶 Skills

P1 适合产品已经有一定用户量，开始需要系统化增长、分层和商业化优化的阶段。

| Skill 名称 | 建议目录 | 主要用途 | 典型场景 |
| --- | --- | --- | --- |
| `user-segmentation-planner` | `skills/data/` | 建立用户分层和运营标签体系 | 需要区分新用户、活跃用户、付费用户、流失风险用户 |
| `growth-campaign-planner` | `skills/growth/` | 策划增长活动和渠道实验 | 新功能推广、节日活动、冷启动获客 |
| `email-lifecycle-copilot` | `skills/growth/` | 设计邮件、站内信、push 生命周期触达 | 欢迎信、激活提醒、召回、续费提醒 |
| `community-ops-assistant` | `skills/growth/` | 规划社区内容和用户互动 | Discord、Reddit、微信群、论坛、X 社区 |
| `social-repurposer` | `skills/growth/` | 多平台内容改写与分发 | 一篇文章改写成 X、LinkedIn、Reddit、短视频脚本 |
| `ab-test-planner` | `skills/data/` | 设计运营实验和判断样本、指标、周期 | 标题、付费墙、邮件、落地页、引导流程实验 |
| `churn-risk-miner` | `skills/support/` | 分析流失风险和退款原因 | 低活跃、取消订阅、退款、差评 |
| `support-knowledge-ops` | `skills/support/` | 把高频问题转成知识库和客服话术 | FAQ、帮助中心、客服自动回复 |
| `local-market-ops` | `skills/localization/` | 为不同地区设计本地化运营打法 | 美国、日本、欧洲、中东、东南亚市场运营 |
| `product-led-sales-ops` | `skills/sales/` | 把产品使用信号转成销售或转化动作 | B2B 试用、线索评分、销售跟进材料 |

---

## P2 按阶段补齐 Skills

P2 不一定每个产品都需要，适合团队规模变大、渠道变多或运营流程复杂后再补。

| Skill 名称 | 建议目录 | 主要用途 |
| --- | --- | --- |
| `app-store-ops` | `skills/growth/` | App Store / Google Play 关键词、截图、评论运营 |
| `influencer-collab-ops` | `skills/growth/` | KOL/KOC 合作筛选、brief、报价和效果复盘 |
| `affiliate-program-ops` | `skills/growth/` | 联盟营销、返佣规则、渠道素材和结算口径 |
| `webinar-event-ops` | `skills/operations/` | 线上活动、直播、webinar 的策划和转化跟进 |
| `sales-enablement-ops` | `skills/sales/` | 销售资料、案例、竞品对比、异议处理 |
| `refund-save-ops` | `skills/monetization/` | 退款挽留、降级方案、取消订阅问卷 |
| `nps-voice-of-customer` | `skills/support/` | NPS、满意度、VOC 归因与改进建议 |
| `partner-launch-ops` | `skills/operations/` | 联合发布、合作伙伴活动、渠道共创内容 |
| `ops-sop-builder` | `skills/operations/` | 把重复运营流程沉淀成 SOP |
| `ops-automation-auditor` | `skills/operations/` | 识别哪些运营动作适合脚本化、自动化或模板化 |

---

## 按产品阶段选择

### 1. 上线前后 30 天

优先创建：

- `product-ops-planner`
- `activation-ops-designer`
- `release-ops-writer`
- `product-metrics-analyst`
- `feedback-insight-miner`

目标是把发布、激活、反馈收集和指标口径先跑起来。

### 2. 有用户但增长慢

优先创建：

- `content-ops-engine`
- `seo-content-ops`
- `growth-campaign-planner`
- `social-repurposer`
- `ab-test-planner`

目标是建立稳定获客入口，并用实验找出有效渠道。

### 3. 有流量但留存差

优先创建：

- `user-segmentation-planner`
- `retention-lifecycle-ops`
- `email-lifecycle-copilot`
- `churn-risk-miner`
- `support-knowledge-ops`

目标是找到流失原因，并建立分层触达和帮助体系。

### 4. 有留存但付费差

优先创建：

- `pricing-conversion-ops`
- `product-led-sales-ops`
- `refund-save-ops`
- `ops-review-generator`

目标是优化付费包装、支付页、试用转化和续费留存。

---

## 推荐最小组合

如果只能先做 6 个产品运营 Skills，建议从下面开始：

| 顺序 | Skill | 理由 |
| --- | --- | --- |
| 1 | `product-ops-planner` | 统一运营目标、动作、节奏和复盘口径 |
| 2 | `product-metrics-analyst` | 没有指标口径，运营动作很难判断有效性 |
| 3 | `feedback-insight-miner` | 把用户声音转成可决策的需求和问题 |
| 4 | `activation-ops-designer` | 产品上线后最先影响留存的是激活路径 |
| 5 | `content-ops-engine` | 大多数产品需要持续内容和渠道分发 |
| 6 | `pricing-conversion-ops` | 增长最终要能转成收入或商业结果 |

---

## 每个 Skill 建议包含的内容

产品运营类 Skill 的 `SKILL.md` 建议保持轻量，但要有稳定输出格式：

```markdown
---
name: "skill-name"
description: "当用户需要处理某类产品运营任务时使用，输出结构化运营方案、分析结论或执行清单。"
---

# Skill 标题

## 适用场景

## 输入信息

## 工作流程

## 输出格式

## 指标与验收

## 风险与边界

## 示例触发语句
```

复杂 Skill 可以把模板、指标字典、渠道规则、地区运营策略放到 `references/`，把固定的数据清洗、表格合并、报表生成逻辑放到 `scripts/`。

---

## 示例触发语句

后续创建产品运营 Skills 时，可以用下面这些句子测试触发效果：

- 帮我为这个新功能做一份上线运营计划。
- 把这些用户反馈整理成需求优先级和运营动作。
- 根据这份数据分析新用户激活为什么低。
- 给这个产品做一套 30 天内容运营计划。
- 帮我优化付费页转化文案和套餐权益表达。
- 把这次活动结果整理成复盘报告。
- 根据退款原因设计一套挽留和召回策略。

---

## 后续落地建议

1. 先按 P0 创建 3 到 6 个最常用 Skills，不要一次性铺满。
2. 每个 Skill 至少积累 3 个真实业务样例，再沉淀稳定输出格式。
3. 每季度根据运营流程复盘，淘汰低频 Skill，强化高频 Skill。
4. 修改 `skills/` 后运行 `scripts/sync-skills.sh`，同步刷新各工具适配目录。
