# 产品设计 Skills 清单

> 更新时间：2026-05-14  
> 适用对象：产品经理、产品设计师、独立开发者、AI Native 小团队  
> 目标：只整理服务于「产品设计」的 Skills，不覆盖开发实现、增长运营、销售变现、客服支持等后续环节。

## 一句话结论

产品设计类 Skills 的核心不是“把界面画漂亮”，而是帮助团队稳定完成这条链路：

**理解用户与场景 -> 定义问题 -> 组织信息架构 -> 设计交互流程 -> 形成界面规范 -> 做可用性检查 -> 输出可交付设计文档**

建议优先建设 4 个基础 Skill：

| 优先级 | Skill | 建议目录 | 主要用途 |
| --- | --- | --- | --- |
| P0 | `product-discovery-brief` | `skills/product/` | 把模糊想法整理成产品设计简报 |
| P0 | `user-scenario-mapper` | `skills/research/` | 梳理目标用户、使用场景、任务路径与痛点 |
| P0 | `information-architecture-planner` | `skills/design/` | 规划导航、页面层级、内容结构和对象关系 |
| P0 | `interaction-flow-designer` | `skills/design/` | 输出核心流程、状态、异常路径和页面清单 |

---

## 产品设计 Skill 分类

| 分类 | 适合目录 | 解决的问题 | 典型产出 |
| --- | --- | --- | --- |
| 产品定义 | `skills/product/` | 把需求、目标、范围和约束说清楚 | 产品设计简报、功能范围、成功指标 |
| 用户与场景研究 | `skills/research/` | 理解用户是谁、为什么用、在什么情境下用 | 用户画像、JTBD、场景地图、痛点清单 |
| 信息架构 | `skills/design/` | 决定产品内容如何组织、页面如何分层 | 导航结构、站点地图、对象模型 |
| 交互流程 | `skills/design/` | 设计用户完成任务的路径和状态变化 | 用户流程图、页面状态、边界场景 |
| 界面与组件策略 | `skills/design/` | 形成页面布局、组件使用和视觉一致性 | 页面结构、组件规范、设计系统建议 |
| 可用性评审 | `skills/design/` | 检查是否易懂、易用、可访问、可完成任务 | 评审清单、风险列表、修改建议 |
| 设计交付 | `skills/product/` 或 `skills/design/` | 把设计转成研发、评审、协作可用的材料 | PRD 补充、验收标准、Figma 标注建议 |

---

## 推荐 Skills 总表

说明：

- `P0`：产品设计工作流最小闭环必备。
- `P1`：建议尽快补齐，适合多人协作或复杂产品。
- `P2`：按业务复杂度选择建设。
- `建议自建`：适合用本仓库的 `skills/` 目录沉淀为长期资产。
- `平台型能力`：依赖具体 Agent、Figma、浏览器或设计工具能力，不一定要放入通用 Skill。

| 优先级 | Skill 名称 | 类型 | 建议目录 | 触发场景 | 主要产出 |
| --- | --- | --- | --- | --- | --- |
| P0 | `product-discovery-brief` | 建议自建 | `skills/product/` | 用户只有模糊想法、需求片段、竞品启发时 | 目标用户、问题定义、核心场景、范围边界 |
| P0 | `design-requirements-synthesizer` | 建议自建 | `skills/product/` | 需要把 PRD、访谈、会议记录转成设计输入时 | 设计目标、约束、优先级、待确认问题 |
| P0 | `user-scenario-mapper` | 建议自建 | `skills/research/` | 需要明确用户在什么场景下完成什么任务时 | 用户类型、场景、任务路径、痛点与机会 |
| P0 | `jtbd-design-synthesizer` | 建议自建 | `skills/research/` | 从用户访谈、评论、工单中提炼设计机会时 | JTBD、触发因素、成功标准、阻力点 |
| P0 | `information-architecture-planner` | 建议自建 | `skills/design/` | 设计新产品、新模块、复杂导航或多对象系统时 | 页面层级、导航、对象关系、内容分组 |
| P0 | `interaction-flow-designer` | 建议自建 | `skills/design/` | 设计注册、创建、编辑、支付、审核等关键流程时 | 主路径、分支路径、异常状态、页面清单 |
| P0 | `page-state-matrix` | 建议自建 | `skills/design/` | 需要避免漏掉空态、加载、错误、权限、边界状态时 | 页面状态矩阵、触发条件、交互反馈 |
| P0 | `usability-reviewer` | 建议自建 | `skills/design/` | 设计稿、原型或已实现页面需要做 UX 检查时 | 可用性问题、严重度、修改建议 |
| P1 | `persona-and-segmentation-designer` | 建议自建 | `skills/research/` | 面向多类用户、多角色、多权限产品设计时 | 用户分层、角色差异、核心诉求 |
| P1 | `competitive-ux-auditor` | 建议自建 | `skills/research/` | 参考竞品交互、信息架构、转化路径时 | 竞品 UX 对比、可借鉴模式、差异化机会 |
| P1 | `wireframe-planner` | 建议自建 | `skills/design/` | 需要先确定页面布局而不是直接写高保真 UI 时 | 低保真页面结构、内容优先级、组件区块 |
| P1 | `design-system-starter` | 建议自建 | `skills/design/` | 产品需要稳定复用颜色、字体、组件和交互模式时 | 设计 token 建议、组件清单、使用规则 |
| P1 | `form-ux-optimizer` | 建议自建 | `skills/design/` | 表单、配置页、筛选器、设置页复杂时 | 字段分组、校验规则、提示文案、错误处理 |
| P1 | `mobile-experience-adapter` | 建议自建 | `skills/design/` | 桌面端功能需要适配移动端或响应式体验时 | 移动端信息层级、手势、布局和断点建议 |
| P1 | `accessibility-design-checker` | 建议自建 | `skills/design/` | 面向公共产品、B2B 工具、海外产品或合规场景时 | 对比度、键盘可达、语义、屏幕阅读器风险 |
| P1 | `figma-design-handoff` | 平台型能力 | `skills/design/` | 需要把设计规范、标注、变量和组件交付给研发时 | Figma 标注建议、组件命名、交付检查表 |
| P2 | `empty-state-copy-designer` | 建议自建 | `skills/design/` | 需要优化空态、错误页、成功页、引导文案时 | 状态文案、行动按钮、引导策略 |
| P2 | `onboarding-experience-designer` | 建议自建 | `skills/design/` | 新用户激活、首次配置、导入数据流程复杂时 | 新手路径、渐进披露、激活事件设计 |
| P2 | `settings-and-permissions-designer` | 建议自建 | `skills/design/` | 权限、团队、账单、通知、集成配置较复杂时 | 设置结构、权限模型、配置流程 |
| P2 | `design-qa-checklist` | 建议自建 | `skills/design/` | 设计上线前需要逐项检查体验质量时 | 设计 QA 清单、验收项、风险项 |

---

## 最小产品设计 Skill 组合

如果只想先搭一套最小可用的产品设计能力，建议按下面顺序建设：

| 顺序 | Skill | 为什么先做 |
| --- | --- | --- |
| 1 | `product-discovery-brief` | 先把产品目标、用户、场景、范围讲清楚 |
| 2 | `user-scenario-mapper` | 防止设计只围绕功能列表，而不是围绕用户任务 |
| 3 | `information-architecture-planner` | 先解决结构，再解决页面细节 |
| 4 | `interaction-flow-designer` | 把关键任务路径、状态和异常流程补完整 |
| 5 | `page-state-matrix` | 避免开发后才发现空态、错误、权限、加载状态缺失 |
| 6 | `usability-reviewer` | 在交付前做一次系统化设计质量检查 |

---

## 推荐目录落位

产品设计相关 Skills 可以横跨 `product/`、`research/`、`design/` 三个目录，但不要混入开发、增长、销售类目录。

```text
skills/
  product/
    product-discovery-brief/
    design-requirements-synthesizer/
  research/
    user-scenario-mapper/
    jtbd-design-synthesizer/
    persona-and-segmentation-designer/
    competitive-ux-auditor/
  design/
    information-architecture-planner/
    interaction-flow-designer/
    page-state-matrix/
    wireframe-planner/
    design-system-starter/
    form-ux-optimizer/
    mobile-experience-adapter/
    accessibility-design-checker/
    usability-reviewer/
    design-qa-checklist/
```

---

## 每个 Skill 建议包含的内容

为了便于 Codex、Claude Code、VS Code、Trae 复用，每个产品设计 Skill 的 `SKILL.md` 建议保持轻量、任务导向，并包含：

| 模块 | 内容建议 |
| --- | --- |
| `name` | 使用英文短横线命名，例如 `interaction-flow-designer` |
| `description` | 写清楚触发时机，例如“当用户要设计关键产品流程、页面状态或任务路径时使用” |
| 使用场景 | 说明适合输入 PRD、访谈记录、竞品链接、草图、已有页面等 |
| 工作步骤 | 以 4-7 步为宜，覆盖输入澄清、分析、产出和检查 |
| 输出格式 | 固定输出表格、清单、流程图、页面状态矩阵等 |
| 质量标准 | 明确什么算好设计，例如任务闭环、状态完整、信息层级清楚 |
| 示例调用 | 给 2-3 个真实用户说法，方便 agent 自动触发 |

大型设计原则、行业案例、组件规范、可访问性规则，建议放入 Skill 内部的 `references/`，不要塞满 `SKILL.md`。

---

## 不纳入本清单的 Skills

以下能力虽然和产品成功有关，但不属于“只针对产品设计”的范围，建议放到其他清单：

| 不纳入类型 | 建议目录 |
| --- | --- |
| 前端组件开发、代码生成、工程审查 | `skills/engineering/` |
| SEO、内容营销、社媒分发、获客 | `skills/growth/` |
| 定价、支付页、套餐实验、收入优化 | `skills/monetization/` |
| 客服、工单、用户反馈运营 | `skills/support/` |
| 发布计划、版本说明、运营 SOP | `skills/operations/` |
| 合同、发票、隐私政策、合规 | `skills/finance-legal/` |

---

## 建设建议

1. 先建设 `P0`，确保产品设计从需求到交付能闭环。
2. 每个 Skill 只解决一个设计问题，不要把“需求分析 + 原型 + UI + 评审”写成一个巨型 Skill。
3. 产品设计 Skill 的输出要可被复制到 PRD、Figma、Linear、Notion 或开发 issue 中。
4. 对高频重复的设计检查，例如页面状态矩阵、表单校验、可用性评审，可以沉淀成固定表格模板。
5. 当某个 Skill 需要大量案例、行业规范或组件知识时，把这些材料放进 `references/`，保持主文件短小。

