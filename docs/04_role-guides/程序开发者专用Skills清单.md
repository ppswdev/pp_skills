# 程序开发者专用 Skills 清单

> 更新时间：2026-05-14  
> 适用对象：前端、后端、全栈、移动端、AI 应用、DevOps、测试与数据工程开发者  
> 范围边界：只收录能直接提升软件开发、交付、测试、调试、部署、维护效率的 Skills；不包含增长、销售、运营、市场、财务法务等非开发角色 Skills。

## 一句话结论

程序开发者不需要先装一大堆泛用 Skills。更推荐先搭一套覆盖「理解需求 -> 设计方案 -> 编码实现 -> 测试验证 -> 调试修复 -> 部署发布 -> 文档维护」的工程闭环。

最小可用组合建议从这 6 类开始：

| 优先级 | Skill 类型 | 主要价值 |
| --- | --- | --- |
| P0 | 需求与任务拆解 | 把一句需求拆成可实现、可验收的开发任务 |
| P0 | 代码实现与重构 | 按项目技术栈生成、修改、重构代码 |
| P0 | 测试生成与验证 | 补齐单元测试、集成测试、E2E 流程验证 |
| P0 | 调试排障 | 从报错、日志、复现步骤定位根因 |
| P1 | 代码审查与规范 | 检查可维护性、安全性、性能和团队规范 |
| P1 | 部署与工程化 | 生成 CI/CD、Docker、云平台、环境变量和发布流程 |

---

## 推荐分类

建议把程序开发者专用 Skills 按下面这些目录组织：

| 分类目录 | 作用 | 典型 Skill |
| --- | --- | --- |
| `engineering/requirements/` | 需求澄清、任务拆解、验收标准 | `dev-task-planner`、`acceptance-criteria-writer` |
| `engineering/architecture/` | 架构设计、技术选型、模块边界 | `architecture-reviewer`、`api-design-planner` |
| `engineering/frontend/` | Web 前端、组件、交互、状态管理 | `react-best-practices`、`frontend-component-builder` |
| `engineering/backend/` | API、服务端、认证、权限、任务队列 | `rest-api-builder`、`auth-flow-implementer` |
| `engineering/mobile/` | iOS、Android、React Native、Flutter | `mobile-ui-implementer`、`app-release-checklist` |
| `engineering/ai/` | AI 应用、Agent、RAG、工具调用 | `ai-feature-builder`、`rag-pipeline-reviewer` |
| `engineering/database/` | Schema、迁移、索引、查询优化 | `database-schema-designer`、`sql-query-optimizer` |
| `engineering/testing/` | 单测、集成测试、E2E、测试策略 | `test-case-generator`、`e2e-flow-verifier` |
| `engineering/debugging/` | 报错分析、日志排查、性能定位 | `systematic-debugging`、`incident-investigator` |
| `engineering/review/` | PR 审查、代码质量、安全扫描 | `code-reviewer`、`security-reviewer` |
| `engineering/devops/` | CI/CD、容器、部署、监控、回滚 | `github-actions-builder`、`dockerfile-reviewer` |
| `engineering/docs/` | README、API 文档、ADR、变更日志 | `technical-doc-writer`、`release-notes-generator` |
| `engineering/localization/` | i18n 文案、语言包、增量翻译 | `pp-tran` |
| `engineering/skill-building/` | 自建团队专属开发 Skills | `skill-creator` |

---

## 必备 Skills 总表

说明：

- `现成可装`：社区或平台已有成熟 Skill，适合直接安装。
- `建议自建`：强依赖团队技术栈、目录结构、代码规范，最好基于 `skill-creator` 自建。
- `平台型能力`：依赖具体工具平台，例如 Codex、Claude Code、Trae、VS Code、GitHub、Vercel、Cloudflare 等。

| 开发环节 | 推荐 Skill | 类型 | 主要解决问题 | 优先级 |
| --- | --- | --- | --- | --- |
| 需求拆解 | `dev-task-planner` | 建议自建 | 把需求拆成开发任务、边界、验收标准和风险点 | P0 |
| 技术方案 | `architecture-reviewer` | 建议自建 | 评审架构、模块边界、数据流、扩展性和复杂度 | P0 |
| API 设计 | `api-design-planner` | 建议自建 | 设计 REST、GraphQL、RPC、错误码、鉴权和分页规则 | P0 |
| 前端实现 | `react-best-practices` | 现成可装 | 检查 React 组件结构、Hooks、渲染性能和可维护性 | P0 |
| Next.js 开发 | `nextjs` | 平台型能力 | App Router、Server Components、缓存、路由和部署实践 | P0 |
| UI 还原 | `figma-implement-design` | 平台型能力 | 根据 Figma 设计稿实现高一致性的前端页面 | P1 |
| 后端实现 | `rest-api-builder` | 建议自建 | 根据项目框架生成接口、服务层、DTO、错误处理和测试 | P0 |
| 认证权限 | `auth-flow-implementer` | 建议自建 | 实现登录、会话、OAuth、RBAC、权限守卫和安全检查 | P0 |
| 数据库设计 | `database-schema-designer` | 建议自建 | 设计表结构、索引、迁移、约束和查询模型 | P0 |
| SQL 优化 | `sql-query-optimizer` | 建议自建 | 分析慢查询、索引策略、Explain 结果和分页性能 | P1 |
| AI 应用开发 | `ai-feature-builder` | 建议自建 | 设计模型调用、工具调用、结构化输出、错误恢复和成本控制 | P1 |
| RAG 检索 | `rag-pipeline-reviewer` | 建议自建 | 检查切分、嵌入、召回、重排、引用和评测流程 | P1 |
| 测试生成 | `test-case-generator` | 建议自建 | 生成单元测试、边界测试、Mock、测试数据和覆盖策略 | P0 |
| E2E 验证 | `browser-use` / `verification` | 平台型能力 | 自动打开页面、点击流程、检查关键用户路径是否可用 | P0 |
| 系统调试 | `systematic-debugging` | 现成可装 | 按复现、假设、证据、修复、验证的流程定位问题 | P0 |
| 性能分析 | `performance-profiler` | 建议自建 | 分析前端加载、接口耗时、数据库慢查询和资源瓶颈 | P1 |
| 代码审查 | `code-reviewer` | 建议自建 | 检查 bug、回归风险、可维护性、测试缺口和代码风格 | P0 |
| 安全审查 | `security-reviewer` | 建议自建 | 检查注入、鉴权绕过、敏感信息泄露、依赖风险 | P1 |
| CI/CD | `github-actions-builder` | 建议自建 | 生成构建、测试、缓存、部署、回滚和发布流水线 | P1 |
| 容器化 | `dockerfile-reviewer` | 建议自建 | 检查镜像体积、缓存层、安全用户、健康检查和构建速度 | P1 |
| 云平台部署 | `vercel-cli` / `wrangler` | 平台型能力 | 管理 Vercel、Cloudflare Workers、环境变量和发布流程 | P1 |
| 文档生成 | `technical-doc-writer` | 建议自建 | 生成 README、接口文档、架构说明、ADR 和排障手册 | P1 |
| 版本说明 | `release-notes-generator` | 建议自建 | 从 Git、issue、PR 中生成面向开发者和用户的更新说明 | P2 |
| 国际化开发 | `pp-tran` | 现成可装 | 根据中文或英文基准语言增量同步其他语言包 | P1 |
| Skill 自建 | `skill-creator` | 现成可装 | 把团队固定流程沉淀成可复用 Skill | P0 |

---

## 按开发者角色选择

### 前端开发者

优先安装或自建：

- `react-best-practices`
- `nextjs`
- `frontend-component-builder`
- `figma-implement-design`
- `browser-use` / `verification`
- `test-case-generator`
- `pp-tran`

重点覆盖：

- 组件结构
- 状态管理
- 样式和响应式
- 设计稿还原
- 浏览器端 E2E 验证
- 前端性能和可访问性

### 后端开发者

优先安装或自建：

- `api-design-planner`
- `rest-api-builder`
- `auth-flow-implementer`
- `database-schema-designer`
- `sql-query-optimizer`
- `test-case-generator`
- `security-reviewer`

重点覆盖：

- API 契约
- 认证和权限
- 数据库结构
- 并发和事务
- 日志、错误码和可观测性
- 安全边界

### 全栈开发者

优先安装或自建：

- `dev-task-planner`
- `architecture-reviewer`
- `react-best-practices`
- `rest-api-builder`
- `database-schema-designer`
- `browser-use` / `verification`
- `github-actions-builder`

重点覆盖：

- 从需求到上线的端到端闭环
- 前后端接口协作
- 数据模型和 UI 状态一致性
- 自动化测试和发布

### AI 应用开发者

优先安装或自建：

- `ai-feature-builder`
- `rag-pipeline-reviewer`
- `tool-calling-reviewer`
- `eval-case-generator`
- `prompt-regression-tester`
- `cost-and-latency-reviewer`

重点覆盖：

- 模型选择和调用边界
- 结构化输出
- 工具调用
- RAG 质量评估
- Prompt 回归测试
- 成本、延迟和降级策略

### DevOps / 平台工程师

优先安装或自建：

- `github-actions-builder`
- `dockerfile-reviewer`
- `kubernetes-manifest-reviewer`
- `env-vars-auditor`
- `observability-planner`
- `incident-investigator`

重点覆盖：

- CI/CD
- 容器和镜像
- 环境变量管理
- 部署、回滚和灰度
- 日志、监控、告警
- 事故复盘

### 测试开发者

优先安装或自建：

- `test-case-generator`
- `e2e-flow-verifier`
- `api-contract-tester`
- `mock-data-builder`
- `coverage-gap-analyzer`
- `regression-test-planner`

重点覆盖：

- 测试用例设计
- 边界条件
- Mock 和夹具数据
- API 契约测试
- 浏览器流程测试
- 回归测试策略

---

## 最小安装顺序

如果从零开始搭建程序开发者 Skills，建议按下面顺序：

| 顺序 | 先装或先建 | 理由 |
| --- | --- | --- |
| 1 | `skill-creator` | 后续团队专属开发流程都要靠它沉淀 |
| 2 | `dev-task-planner` | 先把需求拆清楚，减少返工 |
| 3 | `systematic-debugging` | 调试是高频刚需，越早规范越省时间 |
| 4 | `test-case-generator` | 让每次修改都有验证闭环 |
| 5 | `code-reviewer` | 在提交前发现 bug、回归和测试缺口 |
| 6 | 技术栈专属 Skill | React、Next.js、Python、Go、Java、Rust、移动端等按需选择 |
| 7 | `browser-use` / `verification` | 对前端和全栈项目做端到端验证 |
| 8 | `github-actions-builder` | 把本地验证固化到 CI/CD |

---

## 哪些不放进这份清单

这份清单刻意不包含下面类型：

- 增长获客：SEO、内容营销、社媒分发、广告投放
- 销售转化：销售话术、报价、客户外联、CRM
- 运营支持：活动策划、社群运营、客服话术
- 财务法务：发票、合同、条款、税务
- 宽泛个人效率：日程管理、会议纪要、通用写作

这些 Skills 对独立开发者或团队当然有价值，但它们不是“程序开发者专用”能力，建议放到 `growth/`、`sales/`、`operations/`、`finance-legal/` 等目录单独管理。

---

## 自建 Skill 的推荐模板

程序开发者自建 Skill 时，建议每个 `SKILL.md` 至少回答 6 个问题：

```markdown
---
name: your-skill-name
description: 什么时候触发这个 Skill，它解决什么开发问题，适合哪些技术栈或场景。
---

# Your Skill Name

## 适用场景

- 用户提出什么请求时使用
- 哪些项目或技术栈适用

## 输入信息

- 需要读取哪些文件
- 需要用户提供哪些上下文
- 哪些信息可以从仓库自动推断

## 工作流程

1. 先确认现有项目结构和约定
2. 再定位相关代码、测试和配置
3. 按最小范围修改
4. 运行对应验证命令
5. 输出变更摘要和风险提示

## 输出格式

- 修改了哪些文件
- 运行了哪些验证
- 还有哪些已知限制

## 质量标准

- 遵循项目现有风格
- 不引入无关重构
- 有测试或明确说明无法测试的原因

## 示例调用

用户：帮我为这个接口补齐单元测试。  
用户：检查这个 PR 有没有安全问题。  
用户：根据现有代码风格实现一个订单列表接口。
```

---

## 本仓库已有可用 Skills

当前仓库已经包含：

| Skill | 路径 | 适合程序开发者的用途 |
| --- | --- | --- |
| `pp-tran` | `skills/99_ppskills/pp-tran/` | 多语言应用的 i18n 文案增量翻译 |
| `skill-creator` | `skills/00_base/skill-creator/` | 创建和优化团队专属开发 Skills |

修改 `skills/` 后，按仓库规则运行：

```bash
scripts/sync-skills.sh
```

这会刷新 `.claude/skills/`、`.codex/skills/`、`.trae-cn/skills/` 三个技能入口。
