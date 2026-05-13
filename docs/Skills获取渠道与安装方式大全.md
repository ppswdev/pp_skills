# Skills 获取渠道与安装方式大全

本文档详细整理了 Trae IDE 中 Skills 的所有获取渠道和安装方法，帮助开发者快速找到并使用所需技能。

---

## 目录

- [一、官方渠道](#一官方渠道)
- [二、GitHub 开源仓库](#二github-开源仓库按热度排序)
- [三、网盘直接下载](#三网盘直接下载)
- [四、第三方技能平台](#四第三方技能平台)
- [五、四种安装方式详解](#五四种安装方式详解)
- [六、开发者必备 Top 6 技能](#六开发者必备-top-6-技能)
- [七、最佳实践](#七最佳实践)
- [八、故障排查](#八故障排查)

---

## 一、官方渠道

### 1.1 Trae 官方中文社区（最推荐）

**链接**：[https://forum.trae.cn/](https://forum.trae.cn/)

**精华帖推荐**：

- [超级 skill，可解决 98% 的问题，自测可用！](https://forum.trae.cn/t/topic/7060)
- [工业级 AI 协作技能库 - TraeSkill](https://forum.trae.cn/t/topic/2142)

**特点**：

- 正规安全的渠道
- 国内用户分享的实战经验
- 有详细的安装教程和使用说明
- 社区答疑支持

### 1.2 Trae IDE 内置 Skills 中心

**位置**：设置 → 规则和技能

**功能**：

- 官方提供的技能模板
- 支持 ZIP 包导入
- 一键创建自定义技能
- 技能管理面板

**导入方式**：

1. 下载 Skill 压缩包
2. 设置 → Skills → 导入
3. 选择 ZIP 文件即可

---

## 二、GitHub 开源仓库（按热度排序）

### 🔥 热门技能仓库一览表

| 排名 | 技能名称                     | GitHub 链接                                                                                         | Star    | 功能描述                                         |
| ---- | ---------------------------- | --------------------------------------------------------------------------------------------------- | ------- | ------------------------------------------------ |
| 🏆 1 | **ui-ux-pro-max-skill**      | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)     | ⭐ 22K+ | 最强 UI/UX 设计技能，57种设计风格 + 95套配色方案 |
| 🥈 2 | **TraeSkill 全栈技能库**     | [boshi-xixixi/TraeSkill](https://github.com/boshi-xixixi/TraeSkill)                                 |         | 工业级全套技能，从 PRD 到上线全覆盖              |
| 🥉 3 | **anthropics/skills**        | [anthropics/skills](https://github.com/anthropics/skills)                                           |         | 官方技能库，含 skill-creator、pdf 处理等         |
| 4    | **vercel-labs/agent-skills** | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)                             |         | Vercel 官方，React 最佳实践等                    |
| 5    | **awesome-claude-skills**    | [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills)             |         | 精选技能集合目录                                 |
| 6    | **superpowers**              | [obra/superpowers](https://github.com/obra/superpowers)                                             |         | 代码质量提升插件，含 find_skills 工具            |
| 7    | **github-skill-forge**       | [YuJunZhiXue/github-skill-forge](https://github.com/YuJunZhiXue/github-skill-forge)                 |         | GitHub 开源项目智能检索                          |
| 8    | **request-analyzer**         | [staruhub/ClaudeSkills](https://github.com/staruhub/ClaudeSkills/tree/main/skills/request-analyzer) |         | PM 需求分析，PRD 自动生成                        |

### 📥 使用 skills 命令一键安装

```bash
# 方法1：使用完整仓库路径
npx skills add vercel-labs/agent-skills

# 方法2：使用完整的 GitHub URL
npx skills add https://github.com/vercel-labs/agent-skills

# 方法3：全局安装后使用（推荐）
npm i skills -g
skills add anthropics/skills
skills add vercel-labs/agent-skills

# 查看已安装的 Skills
npx skills list

# 查找可用的 Skills
npx skills find [query]

# 更新所有 Skills
npx skills update

# 删除指定 Skill
npx skills remove [skill-name]
```

---

## 三、网盘直接下载

### 3.1 UI-UX-PRO-MAX 技能包（全网最火）

> 🔥 GitHub 22K+ Stars，让 AI 生成的界面从"实习生"到"资深设计师"水准

**百度网盘链接**：https://pan.baidu.com/s/1WZOn8-xsw2mw1TAQyam5yg?pwd=6sex

**提取码**：`6sex`

**核心能力**：

- 57 种 UI 设计风格（玻璃拟态、黏土风、极简主义等）
- 95 套行业配色方案（SaaS、电商、医疗、金融等）
- 56 组 Google Fonts 字体组合
- 24 类数据可视化图表推荐
- 98 条 UX 最佳实践规范

### 3.2 网盘安装步骤

1. 下载压缩包
2. 解压到项目技能目录：

   ```bash
   # 项目级安装（仅当前项目）
   cp -r ui-ux-pro-max .trae/skills/

   # 全局安装（所有项目）
   cp -r ui-ux-pro-max ~/.trae-cn/skills/
   ```

3. 重启 Trae IDE

---

## 四、第三方技能平台

### 4.1 Skills Marketplace

**链接**：https://skillsmp.com/

**热门技能**：

- [ui-ux-pro-max-skill](https://skillsmp.com/skills/nextlevelbuilder-ui-ux-pro-max-skill-codex-skills-ui-ux-pro-max-skill-md)
- frontend-design（前端视觉设计）
- web-artifacts-builder（React 项目生成器）

### 4.2 MCP Servers

**链接**：https://mcpservers.org/claude-skills/

**热门技能**：

- [frontend-design](https://mcpservers.org/claude-skills/anthropic/frontend-design) - 社区口碑 TOP1 视觉设计 Skill

### 4.3 skills.sh 全球平台

- 91,583+ 安装量
- 智能搜索匹配你需要的 Skills
- 包含全球开发者贡献的技能

---

## 五、四种安装方式详解

### 5.1 方式一：让 SOLO 帮你安装（最推荐）⭐⭐⭐⭐⭐

**优势**：全自动，无需手动操作，零出错

**操作步骤**：

1. 打开 Trae IDE 的 SOLO 模式
2. 直接输入（复制粘贴即可）：
   ```
   帮我把这个 Skill 安装到当前项目：https://github.com/anthropics/skills
   ```
3. AI 会自动帮你完成：克隆 → 解压 → 放到正确的位置

**示例**：

```
帮我安装 ui-ux-pro-max-skill 到当前项目
```

### 5.2 方式二：手动放置（最稳定）⭐⭐⭐⭐

**适合人群**：喜欢掌控一切的开发者

**操作步骤**：

```bash
# 1. 克隆技能仓库
git clone https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git

# 2. 项目级安装（仅当前项目可用）
mkdir -p .trae/skills
cp -r ui-ux-pro-max-skill .trae/skills/

# 3. 全局安装（所有项目可用，推荐）
mkdir -p ~/.trae-cn/skills
cp -r ui-ux-pro-max-skill ~/.trae-cn/skills/

# 4. 验证安装
ls -la .trae/skills/
# 或
ls -la ~/.trae-cn/skills/
```

**⚠️ 注意事项**：

- 文件夹名必须是 kebab-case（小写+连字符）
- 必须包含 `SKILL.md` 文件在根目录
- `SKILL.md` 文件名区分大小写
- 路径不能错，否则无法识别

### 5.3 方式三：ZIP 导入（最直观）⭐⭐⭐

**操作步骤**：

1. 从 GitHub 或网盘下载 Skill 压缩包（.zip 格式）
2. 打开 Trae IDE 设置
3. 进入「规则和技能」→「技能」
4. 点击「导入」按钮
5. 选择下载的 ZIP 文件
6. 等待导入完成

### 5.4 方式四：使用 openskills 命令

```bash
# 安装指定组织的 Skills
npx openskills install anthropics/skills

# 安装 GitHub Repo
npx openskills install your-org/your-skills

# 安装本地目录中的 Skill
npx openskills install ./local-skills/my-skill

# 全局安装后使用
npm i openskills -g
openskills install vercel-labs/agent-skills

# 同步最新的 Skills
npx openskills sync

# 列出已安装的 Skills
npx openskills list

# 更新 Skills
npx openskills update [name...]
```

---

## 六、开发者必备 Top 6 技能

> 来自 Trae 社区精华帖（71 赞，精华帖）

| #   | 技能名称                 | 核心功能                                                 | 获取来源          |
| --- | ------------------------ | -------------------------------------------------------- | ----------------- |
| 1   | **requirements-analyst** | 需求拆分，像产品经理一样帮你细化需求、写 PRD             | 社区精选          |
| 2   | **frontend-design**      | 规范的 UI 界面设计，风格统一不丑，极简主义无 AI 同质化   | anthropics/skills |
| 3   | **ui-ux-pro-max**        | 高品质 UI/UX，专业配色 + 字体 + 动效，装了就不用管设计了 | nextlevelbuilder  |
| 4   | **fullstack-developer**  | 全栈开发，后端代码质量明显提升，代码规范                 | TraeSkill         |
| 5   | **webapp-testing**       | 开发中自动生成单元测试，bug 大幅减少                     | vercel-labs       |
| 6   | **skill-creator**        | ✨ 元技能！自己造 Skill，一句话创建任何技能，无限扩展    | anthropics/skills |

### 6.1 skill-creator（必须第一个装！）

**为什么它最重要？**
因为它能让你创造无限可能——一句话创建任何你需要的技能。

**示例**：

```
用 skill-creator 帮我创建一个 Excel 数据处理的 Skill
用 skill-creator 帮我创建一个 JPG 转无白边 PDF 的 Skill
```

---

## 七、最佳实践

### 7.1 安装原则

| 技能类型         | 安装位置                  | 适用场景                                              |
| ---------------- | ------------------------- | ----------------------------------------------------- |
| **通用高频技能** | 全局 `~/.trae-cn/skills/` | 所有项目复用，如：skill-creator、代码格式化、文档生成 |
| **项目专属技能** | 项目级 `.trae/skills/`    | 仅当前项目使用，如：部署脚本、团队规范、测试配置      |

**口诀**：通用高频装全局，专属业务放项目

### 7.2 技能管理建议

1. **不要贪多**：全局技能只留 5-10 个高频使用的
2. **定期清理**：每月清理一次长期不用的技能
3. **建立本地资源库**：按场景分类归档你打磨好的技能包
4. **备份原创技能**：一定要备份好自己原创的专属技能
5. **正规渠道下载**：尽量从官方社区、正规开源仓库获取

### 7.3 本地资源库建议

```
My-Skills-Library/
├── 前端开发/
│   ├── ui-ux-pro-max/
│   ├── frontend-design/
│   └── react-best-practices/
├── 后端开发/
│   ├── database-design/
│   └── api-generator/
├── 通用工具/
│   ├── skill-creator/
│   ├── pdf-handler/
│   └── excel-processor/
└── 产品文档/
    ├── prd-generator/
    └── brainstorming/
```

### 7.4 技能选择原则

- ✅ **优先选择官方技能**：稳定性和兼容性更好
- ✅ **选择活跃维护的开源技能**：更新及时，社区支持好
- ✅ **根据项目需求选择**：不要盲目安装过多技能
- ✅ **查看 Skill 的文档和使用说明**：确保它符合你的需求

---

## 八、故障排查

### 8.1 技能未生效？检查清单

1. ✅ 检查目录结构是否正确：

   ```
   .trae/skills/your-skill-name/SKILL.md
   ```

2. ✅ 检查 `SKILL.md` 文件名是否正确（区分大小写）

3. ✅ 检查 `SKILL.md` 是否有正确的 YAML frontmatter：

   ```markdown
   ---
   name: "skill-name"
   description: "技能描述"
   ---
   ```

4. ✅ 完全重启 Trae IDE（关闭所有窗口再打开）

5. ✅ 文件夹名是否为 kebab-case 格式（小写+连字符）

### 8.2 技能冲突

- 项目技能优先级 **高于** 全局技能
- 如有同名冲突，建议调整技能名称避免冲突

### 8.3 验证技能是否生效

在 Trae 中输入：

```
列出你现在可用的所有 Skills
你能使用 ui-ux-pro-max 这个技能吗？
```

---

## 参考资源

- [Skills 使用教程](skills-tutorial.md)
- [全局配置指南](skills-use-traecn.md)
- [开发者必备技能分类](开发者必备的skill必备技能分类.md)
- [Trae 官方社区](https://forum.trae.cn/)

---

## 更新日志

- **2026-02-11**：初始版本，整理了完整的获取渠道和 4 种安装方式
- **2026-02-11**：新增 Top 6 必备技能推荐和故障排查
