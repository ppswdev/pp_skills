#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$PROJECT_ROOT/skills"
DOCS_DIR="$PROJECT_ROOT/docs"
CATALOG_DIR="$DOCS_DIR/02_skill-catalog"
USAGE_DIR="$DOCS_DIR/03_skill-usage"
ROLE_GUIDES_DIR="$DOCS_DIR/04_role-guides"
ROLE_MAP="$CATALOG_DIR/role-map.yml"

mkdir -p "$CATALOG_DIR" "$USAGE_DIR" "$ROLE_GUIDES_DIR"

if [ ! -d "$SKILLS_DIR" ]; then
  echo "错误：skills 源目录不存在: $SKILLS_DIR"
  exit 1
fi

if [ ! -f "$ROLE_MAP" ]; then
  echo "错误：角色映射文件不存在: $ROLE_MAP"
  exit 1
fi

collect_leaf_skills() {
  find "$SKILLS_DIR" -type f -name "SKILL.md" | while read -r skill_file; do
    dirname "$skill_file"
  done | sort
}

extract_frontmatter_field() {
  local file="$1"
  local key="$2"
  awk -v key="$key" '
    BEGIN { in_fm = 0; collecting = 0; value = "" }
    NR == 1 && $0 == "---" { in_fm = 1; next }
    in_fm && $0 == "---" {
      if (collecting) {
        gsub(/[[:space:]]+/, " ", value)
        gsub(/^ /, "", value)
        gsub(/ $/, "", value)
        print value
      }
      exit
    }
    in_fm && collecting {
      if ($0 ~ /^[A-Za-z0-9_-]+:/) {
        gsub(/[[:space:]]+/, " ", value)
        gsub(/^ /, "", value)
        gsub(/ $/, "", value)
        print value
        exit
      }
      line = $0
      gsub(/^[[:space:]]+/, "", line)
      value = value " " line
      next
    }
    in_fm && $0 ~ "^" key ":" {
      line = $0
      sub("^" key ":[[:space:]]*", "", line)
      gsub(/^["'\'' ]+/, "", line)
      gsub(/["'\'' ]+$/, "", line)
      if (line == "") {
        collecting = 1
        next
      }
      print line
      exit
    }
  ' "$file"
}

role_map_roles() {
  local skill="$1"
  awk -v skill="$skill" '
    $0 == skill ":" { found = 1; next }
    found && /^[^[:space:]][^:]+:/ { exit }
    found && /roles:/ {
      line = $0
      sub(/.*roles:[[:space:]]*\[/, "", line)
      sub(/\].*/, "", line)
      gsub(/,[[:space:]]*/, "、", line)
      print line
      exit
    }
  ' "$ROLE_MAP"
}

role_map_domain() {
  local skill="$1"
  awk -v skill="$skill" '
    $0 == skill ":" { found = 1; next }
    found && /^[^[:space:]][^:]+:/ { exit }
    found && /domain:/ {
      line = $0
      sub(/.*domain:[[:space:]]*/, "", line)
      print line
      exit
    }
  ' "$ROLE_MAP"
}

domain_label() {
  case "$1" in
    00_base) echo "基础能力" ;;
    01_opportunity) echo "机会发现" ;;
    02_strategy) echo "策略规划" ;;
    03_product) echo "产品管理" ;;
    04_research) echo "用户研究" ;;
    05_design) echo "设计体验" ;;
    06_engineering) echo "工程开发" ;;
    07_data) echo "数据分析" ;;
    08_growth) echo "增长营销" ;;
    09_sales) echo "销售转化" ;;
    10_monetization) echo "商业变现" ;;
    11_operations) echo "运营管理" ;;
    12_support) echo "用户支持" ;;
    13_finance-legal) echo "财务法务" ;;
    14_localization) echo "本地化" ;;
    *) echo "$1" ;;
  esac
}

usage_prompts() {
  local skill="$1"
  case "$skill" in
    pp-translator) printf '%s\n' '- “同步翻译多语言，按简体中文为基准。”' '- “只翻译我刚加的这几个 key 到日文和韩文。”' '- “检查这些 arb 文件，把缺失语言补齐。”' ;;
    skill-creator) printf '%s\n' '- “帮我创建一个用于代码评审的 skill。”' '- “优化这个 SKILL.md 的触发描述。”' '- “给这个 skill 设计几个测试用例。”' ;;
    ui-ux-pro-max) printf '%s\n' '- “帮我设计一个 SaaS dashboard 页面。”' '- “检查这个页面的 UI/UX 问题并给修改建议。”' '- “把这个移动端界面优化得更专业。”' ;;
    deploy-to-vercel) printf '%s\n' '- “把这个项目部署到 Vercel 预览环境。”' '- “部署并给我一个可访问链接。”' '- “检查 Vercel 部署失败的原因。”' ;;
    webapp-testing) printf '%s\n' '- “打开本地页面跑一遍核心流程测试。”' '- “用 Playwright 截图检查这个页面。”' '- “帮我复现这个前端交互 bug。”' ;;
    claude-api) printf '%s\n' '- “帮我接入 Anthropic SDK。”' '- “检查 Claude API 调用里的 prompt caching。”' '- “把这个 Claude 模型版本迁移到新版。”' ;;
    mcp-builder) printf '%s\n' '- “帮我设计一个连接 Notion API 的 MCP server。”' '- “检查这个 MCP tool schema 是否合理。”' '- “用 TypeScript 写一个 MCP 服务骨架。”' ;;
    docx) printf '%s\n' '- “把这份内容生成 Word 文档。”' '- “修改这个 docx 里的标题和表格。”' '- “给这份 Word 文档添加目录和页码。”' ;;
    pdf) printf '%s\n' '- “提取这个 PDF 里的表格。”' '- “合并这几个 PDF。”' '- “给这个 PDF 加水印。”' ;;
    pptx) printf '%s\n' '- “根据这份提纲生成 PPT。”' '- “读取这个 pptx 并总结内容。”' '- “修改这套 slides 的版式和标题。”' ;;
    xlsx) printf '%s\n' '- “清洗这个 Excel 表并生成统计表。”' '- “给 xlsx 增加公式和图表。”' '- “把 CSV 转成格式化的 Excel 文件。”' ;;
    frontend-design) printf '%s\n' '- “做一个高质量 landing page。”' '- “把这个 React 页面视觉升级。”' '- “实现一个更有设计感的组件。”' ;;
    react-best-practices) printf '%s\n' '- “检查这个 Next.js 页面性能问题。”' '- “重构这个 React 组件，减少不必要渲染。”' '- “review 这些 hooks 写法是否合理。”' ;;
    react-native-skills) printf '%s\n' '- “优化这个 React Native 列表性能。”' '- “检查 Expo 项目的动画实现。”' '- “帮我设计一个移动端原生交互组件。”' ;;
    react-view-transitions) printf '%s\n' '- “给这个页面切换加 View Transition 动画。”' '- “实现列表重排动画。”' '- “让 Next.js 路由切换更自然。”' ;;
    composition-patterns) printf '%s\n' '- “把这些 boolean props 重构成组合式组件。”' '- “设计一个可扩展的 React 组件 API。”' '- “检查这个组件库的 composition pattern。”' ;;
    web-design-guidelines) printf '%s\n' '- “审查这个页面是否符合 Web UI 最佳实践。”' '- “检查可访问性和交互问题。”' '- “给这个站点做一次设计 QA。”' ;;
    algorithmic-art) printf '%s\n' '- “用 p5.js 创作一个流场生成艺术。”' '- “做一个带随机种子的粒子系统艺术。”' '- “生成一个可交互的算法艺术页面。”' ;;
    canvas-design) printf '%s\n' '- “设计一张活动海报。”' '- “生成一张静态视觉艺术图。”' '- “把这个主题表达成 PNG/PDF 视觉作品。”' ;;
    theme-factory) printf '%s\n' '- “给这份报告套一个专业主题。”' '- “生成一个适合科技产品的主题。”' '- “统一这些页面的颜色和字体。”' ;;
    brand-guidelines) printf '%s\n' '- “按 Anthropic 品牌风格美化这个 artifact。”' '- “把这份材料调成品牌一致的视觉。”' '- “应用品牌颜色和字体规范。”' ;;
    web-artifacts-builder) printf '%s\n' '- “创建一个复杂的交互式 HTML artifact。”' '- “用 React 和 shadcn/ui 做一个可交互工具。”' '- “把这个 artifact 打包成单文件 HTML。”' ;;
    doc-coauthoring) printf '%s\n' '- “和我一起写一份技术方案。”' '- “帮我起草 PRD，并边写边追问缺失信息。”' '- “把这些上下文整理成 RFC。”' ;;
    internal-comms) printf '%s\n' '- “写一份项目进展更新。”' '- “生成一份领导层周报。”' '- “把事故复盘整理成内部 FAQ。”' ;;
    slack-gif-creator) printf '%s\n' '- “做一个适合 Slack 表情的 GIF。”' '- “生成一个 128x128 的循环动画。”' '- “检查这个 GIF 是否适合 Slack 使用。”' ;;
    brainstorming) printf '%s\n' '- “先和我一起梳理这个功能想法，暂时不要写代码。”' '- “帮我把这个产品点子拆成清晰需求和设计方案。”' '- “我想做一个新工具，先问我问题再给方案。”' ;;
    dispatching-parallel-agents) printf '%s\n' '- “这些失败看起来相互独立，请并行分派 agent 调查。”' '- “把这几个模块的问题拆给多个 agent 同时分析。”' '- “并行检查测试、文档和实现是否都有问题。”' ;;
    executing-plans) printf '%s\n' '- “按照这份计划执行，并在完成后汇报结果。”' '- “读取这个 implementation plan，然后逐项落地。”' '- “根据计划完成修改、测试和文档更新。”' ;;
    finishing-a-development-branch) printf '%s\n' '- “实现完成了，帮我检查并准备收尾。”' '- “测试都过了，指导我下一步是合并、PR 还是清理分支。”' '- “帮我整理当前开发分支的完成状态和集成选项。”' ;;
    receiving-code-review) printf '%s\n' '- “这条 code review 意见合理吗？先帮我分析。”' '- “评审说这里要改，先确认风险和正确做法。”' '- “帮我逐条理解这些 review comments，再决定怎么处理。”' ;;
    requesting-code-review) printf '%s\n' '- “这个功能做完了，请帮我做一次 code review。”' '- “合并前检查这次改动是否满足需求。”' '- “请从规格符合度和代码质量两方面 review。”' ;;
    subagent-driven-development) printf '%s\n' '- “这是一份实施计划，请用 subagent 驱动的方式执行。”' '- “把计划里的独立任务分派出去，并在每项后做 review。”' '- “按这份 plan 并行推进实现、验证和质量检查。”' ;;
    systematic-debugging) printf '%s\n' '- “这个测试失败了，先找根因，不要直接猜修复。”' '- “帮我系统排查这个线上 bug。”' '- “这个行为异常，先建立假设并验证根因。”' ;;
    test-driven-development) printf '%s\n' '- “这个 bug 先写一个失败测试，再修复。”' '- “实现这个功能时按 TDD 流程来。”' '- “先设计能证明问题存在的测试用例。”' ;;
    using-git-worktrees) printf '%s\n' '- “开始这个功能前，帮我准备隔离工作区。”' '- “这个改动比较大，先用 worktree 隔离。”' '- “检查当前是否在独立工作区，不是的话创建一个。”' ;;
    using-superpowers) printf '%s\n' '- “开始前先检查哪些 superpowers skill 适用。”' '- “按 superpowers 的规则选择并使用技能。”' '- “先加载合适的工作流技能，再处理这个任务。”' ;;
    verification-before-completion) printf '%s\n' '- “在说完成前，请跑验证并给我证据。”' '- “确认这次修复真的通过测试，不要只看代码。”' '- “完成前检查 diff、测试和生成文件是否一致。”' ;;
    writing-plans) printf '%s\n' '- “根据这个需求写一份可执行实施计划。”' '- “先不要改代码，帮我把任务拆成详细 plan。”' '- “生成一个新工程师也能执行的 implementation plan。”' ;;
    writing-skills) printf '%s\n' '- “帮我用 superpowers 的方法写一个新 skill。”' '- “验证这个 skill 是否真的改变 agent 行为。”' '- “把这个重复流程沉淀成可测试的 SKILL.md。”' ;;
    *) printf '%s\n' "- “请用 ${skill} 帮我处理这个任务。”" "- “检查这个任务是否适合 ${skill}。”" "- “按 ${skill} 的流程给我一个结果。”" ;;
  esac
}

when_text() {
  local skill="$1"
  local fallback="$2"
  case "$skill" in
    claude-api) echo "当你需要构建、调试或优化 Claude API / Anthropic SDK 应用时使用，例如接入 SDK、迁移模型版本、优化 prompt caching、处理 tool use、files、batch、citations 等能力。" ;;
    doc-coauthoring) echo "当你要和 AI 协作撰写文档、方案、PRD、RFC、技术规格或决策文档时使用，适合把零散上下文逐步整理成可读文档。" ;;
    docx) echo "当输入或输出涉及 Word / .docx 文件时使用，包括创建、读取、编辑、排版、替换内容、插图、评论、修订和生成专业文档。" ;;
    internal-comms) echo "当你需要写内部沟通材料时使用，例如周报、领导层更新、项目进展、FAQ、事故说明、3P 更新或公司 newsletter。" ;;
    mcp-builder) echo "当你要创建或评审 MCP server 时使用，适合把外部 API 或服务封装成高质量工具，供 LLM 稳定调用。" ;;
    pdf) echo "当任务涉及 PDF 文件时使用，包括读取、提取文字或表格、合并、拆分、旋转、水印、表单填写、OCR 和生成 PDF。" ;;
    pptx) echo "当输入或输出涉及 PPT / .pptx / slides / deck 时使用，包括创建演示文稿、读取内容、修改页面、套模板和处理 speaker notes。" ;;
    skill-creator) echo "当你要创建新 skill、修改已有 skill、优化触发描述、设计测试提示词或评估 skill 效果时使用。" ;;
    slack-gif-creator) echo "当你要制作适合 Slack 使用的动画 GIF 时使用，尤其是 Slack emoji、短循环动画和需要控制尺寸/帧率/文件大小的场景。" ;;
    brainstorming) echo "当你要做任何创造性或产品/功能设计工作之前使用，适合先澄清意图、需求、约束和设计方向，再进入实现。" ;;
    dispatching-parallel-agents) echo "当任务里有两个以上相互独立的问题、测试失败、模块检查或调研方向时使用，适合并行分派 agent 节省时间。" ;;
    executing-plans) echo "当你已有一份明确 implementation plan，并希望在当前会话中逐项执行、验证和汇报时使用。" ;;
    finishing-a-development-branch) echo "当功能实现完成且验证通过后使用，适合决定下一步是合并、开 PR、清理分支还是保留工作区。" ;;
    receiving-code-review) echo "当你收到 code review 反馈后使用，适合先理解、验证和判断意见是否正确，再决定是否修改。" ;;
    requesting-code-review) echo "当完成一个任务、较大功能或准备合并前使用，适合请独立视角检查规格符合度、代码质量和遗漏风险。" ;;
    subagent-driven-development) echo "当你已有实施计划且任务可以拆成相对独立的工作项时使用，适合用多个 subagent 执行并在每项后做双阶段 review。" ;;
    systematic-debugging) echo "当遇到 bug、测试失败或异常行为时使用，适合先找根因、建立假设、验证证据，再做修复。" ;;
    test-driven-development) echo "当你要实现新功能或修 bug 时使用，适合先写失败测试，再写最小实现，并通过重构完成闭环。" ;;
    using-git-worktrees) echo "当开始较大功能、风险改动或执行实施计划前使用，适合确认或创建隔离工作区，避免污染当前工作树。" ;;
    using-superpowers) echo "当开始一个任务并需要按 Superpowers 方法选择合适技能时使用，适合建立“先选技能、再行动”的工作流纪律。" ;;
    verification-before-completion) echo "当准备声明任务完成、修复成功或测试通过前使用，适合用新鲜验证证据支撑结论。" ;;
    writing-plans) echo "当你有规格、需求或复杂任务但还不该直接改代码时使用，适合生成可执行、可交接、可验证的实施计划。" ;;
    writing-skills) echo "当你要创建、修改或验证 skill 时使用，适合用类似 TDD 的方式验证 skill 是否真正改变 agent 行为。" ;;
    web-artifacts-builder) echo "当你要创建复杂的 claude.ai HTML artifact 时使用，适合需要 React、Tailwind、shadcn/ui、状态管理或打包成单文件的交互式作品。" ;;
    xlsx) echo "当输入或输出主要是 Excel、CSV、TSV 等表格文件时使用，包括清洗数据、创建表格、添加公式、格式化、生成图表和转换格式。" ;;
    algorithmic-art) echo "当你要用代码创作生成艺术时使用，例如 p5.js、随机种子、粒子系统、流场、噪声场或交互式算法视觉。" ;;
    brand-guidelines) echo "当你需要把设计材料套用 Anthropic 品牌视觉时使用，包括品牌色、字体、视觉识别和 artifact 后处理。" ;;
    canvas-design) echo "当你要生成静态视觉作品时使用，例如海报、艺术图、PNG/PDF 画布、视觉主题表达和设计哲学探索。" ;;
    theme-factory) echo "当你要为报告、网页、slides、docs 或 artifact 套用统一主题时使用，包括配色、字体和视觉风格系统。" ;;
    ui-ux-pro-max) echo "当你要设计、实现、评审或优化 Web / Mobile UI/UX 时使用，适合 landing page、dashboard、SaaS、后台、移动端、组件、表单、图表和设计系统。" ;;
    composition-patterns) echo "当你要重构 React 组件 API、减少 boolean props、设计复合组件、render props、context provider 或可扩展组件库时使用。" ;;
    deploy-to-vercel) echo "当你要把应用或网站部署到 Vercel 时使用，默认适合预览部署、获取可访问链接、排查部署状态和建立长期 git-push 部署流程。" ;;
    frontend-design) echo "当你要构建有明显设计质量的前端页面、组件、网站、dashboard、landing page 或 HTML/CSS/React 界面时使用。" ;;
    react-best-practices) echo "当你要编写、评审或重构 React / Next.js 代码，并关注性能、数据获取、bundle、渲染和 hooks 质量时使用。" ;;
    react-native-skills) echo "当你要构建或优化 React Native / Expo 应用时使用，适合移动端组件、列表性能、动画、原生能力和平台差异处理。" ;;
    react-view-transitions) echo "当你要用 View Transition API 实现页面切换、共享元素、列表重排、组件进出场或 Next.js 路由动画时使用。" ;;
    web-design-guidelines) echo "当你要审查 Web UI 是否符合设计、交互、可访问性和界面最佳实践时使用，适合 UI review、UX audit 和设计 QA。" ;;
    webapp-testing) echo "当你要用 Playwright 测试本地 Web 应用时使用，适合验证前端流程、截图、调试交互、查看浏览器日志和复现 UI bug。" ;;
    pp-translator) echo "当你要做 App / Web 项目的国际化翻译时使用，适合按中文或英文基准增量翻译 ARB、strings、JSON、YAML 等语言文件。" ;;
    *) echo "$fallback" ;;
  esac
}

prep_text() {
  case "$1" in
    docx|pdf|pptx|xlsx) echo "准备好对应文件路径、期望修改内容、输出格式和任何模板或样式要求。" ;;
    deploy-to-vercel) echo "准备好项目目录、登录状态、部署目标，以及是否需要预览或生产环境。" ;;
    webapp-testing) echo "准备好本地启动方式、目标 URL、要验证的用户流程和预期结果。" ;;
    pp-translator) echo "准备好基准语言文件、目标语言范围，以及需要全量还是增量翻译。" ;;
    *) echo "准备好任务目标、输入材料、约束条件和你希望得到的输出形式。" ;;
  esac
}

output_text() {
  case "$1" in
    docx) echo "生成或修改后的 Word 文档，以及必要的变更说明。" ;;
    pdf) echo "处理后的 PDF、提取结果或 PDF 分析说明。" ;;
    pptx) echo "生成或修改后的演示文稿，以及关键页面说明。" ;;
    xlsx) echo "处理后的电子表格、图表、公式或清洗后的数据文件。" ;;
    pp-translator) echo "更新后的多语言文件、翻译差异和必要的本地化说明。" ;;
    webapp-testing) echo "测试结论、复现步骤、截图或控制台/网络问题摘要。" ;;
    *) echo "符合该 skill 工作流的文档、代码、设计、检查报告或操作建议。" ;;
  esac
}

not_for_text() {
  case "$1" in
    claude-api) echo "不适合 OpenAI 或其他非 Anthropic SDK 的中立实现，除非明确要迁移到 Claude。" ;;
    docx) echo "不适合 PDF、表格或纯代码任务。" ;;
    pdf) echo "不适合需要输出 Word、PPT 或 Excel 的任务。" ;;
    pptx) echo "不适合非演示文稿类交付物。" ;;
    xlsx) echo "不适合最终交付不是表格文件的任务。" ;;
    deploy-to-vercel) echo "不适合不需要部署或目标平台不是 Vercel 的任务。" ;;
    pp-translator) echo "不适合普通文案润色或非国际化文件的翻译任务。" ;;
    *) echo "不适合与该 skill 触发描述无关、目标不明确或缺少必要输入的任务。" ;;
  esac
}

role_file_name() {
  case "$1" in
    独立开发者) echo "独立开发者使用指南.md" ;;
    产品经理) echo "产品经理使用指南.md" ;;
    产品设计) echo "产品设计使用指南.md" ;;
    程序开发者) echo "程序开发者使用指南.md" ;;
    运营增长) echo "运营增长使用指南.md" ;;
    本地化) echo "本地化使用指南.md" ;;
    技能创建者) echo "技能创建者使用指南.md" ;;
    *) echo "$1使用指南.md" ;;
  esac
}

role_intro() {
  case "$1" in
    独立开发者) echo "适合一个人或小团队从想法、设计、开发、上线、运营到本地化的完整闭环。重点不是一次用完所有技能，而是按当前阶段调用最能推进结果的技能。" ;;
    产品经理) echo "适合把需求、方案、沟通材料和数据表整理清楚。当前仓库里的产品经理技能更偏文档协作、汇报材料和结构化办公，需求挖掘类专属 skill 可后续补齐。" ;;
    产品设计) echo "适合做 UI/UX 方案、视觉方向、主题风格、设计检查和前端设计协作。可以从设计构思一路用到实现质量评审。" ;;
    程序开发者) echo "适合开发、重构、测试、部署、AI/API 集成和工程质量检查。建议把技能串成“实现 -> 检查 -> 测试 -> 部署 -> 文档”的工作流。" ;;
    运营增长) echo "适合做运营文档、内部沟通、表格分析、物料制作、品牌主题和本地化内容支持。偏增长运营的专属 skill 可后续补齐。" ;;
    本地化) echo "适合维护多语言文件、本地化翻译和国际化策略。当前核心技能是 pp-translator，配合参考文档可处理不同国家地区表达习惯。" ;;
    技能创建者) echo "适合创建、优化、评估和维护 skill。重点是把重复工作沉淀成可触发、可验证、可复用的 SKILL.md。" ;;
    *) echo "本指南根据 role-map.yml 自动生成，帮助该角色快速理解可以使用哪些技能以及如何组合调用。" ;;
  esac
}

role_workflow() {
  case "$1" in
    独立开发者)
      printf '%s\n' \
        "1. **想法澄清**：用 \`brainstorming\` 先问清问题，再用 \`writing-plans\` 写成可执行计划。" \
        "2. **材料整理**：用 \`doc-coauthoring\` 写产品想法、方案或说明。" \
        "3. **界面和体验设计**：用 \`ui-ux-pro-max\`、\`canvas-design\` 或 \`algorithmic-art\` 生成视觉方向。" \
        "4. **开发执行**：用 \`executing-plans\` 或 \`subagent-driven-development\` 执行计划，遇到问题用 \`systematic-debugging\`。" \
        "5. **验证和部署**：用 \`verification-before-completion\` 收尾验证，再用 \`deploy-to-vercel\` 上线预览。" \
        "6. **运营和本地化**：用 \`pptx\`、\`docx\`、\`xlsx\`、\`pdf\` 处理交付物，用 \`pp-translator\` 同步多语言文件。"
      ;;
    产品经理)
      printf '%s\n' \
        "1. **澄清需求**：用 \`brainstorming\` 把模糊想法问清楚，再确认范围和约束。" \
        "2. **梳理方案**：用 \`doc-coauthoring\` 共同起草 PRD、RFC、方案说明。" \
        "3. **拆执行计划**：用 \`writing-plans\` 把需求拆成工程可执行任务。" \
        "4. **整理汇报材料**：用 \`pptx\` 生成或修改演示文稿，用 \`xlsx\` 清理需求表、优先级表或反馈列表。" \
        "5. **输出正式文档和沟通**：用 \`docx\` 生成评审文档，用 \`internal-comms\` 生成项目更新、FAQ 或进展说明。"
      ;;
    产品设计)
      printf '%s\n' \
        "1. **定方向**：用 \`brainstorming\` 澄清目标用户、场景和约束，再用 \`ui-ux-pro-max\` 规划页面结构、风格、组件和交互。" \
        "2. **定视觉语言**：用 \`theme-factory\`、\`brand-guidelines\` 统一颜色、字体和品牌感。" \
        "3. **做视觉资产**：用 \`canvas-design\` 或 \`algorithmic-art\` 生成海报、视觉图或生成艺术。" \
        "4. **协作实现**：用 \`frontend-design\` 辅助前端落地高质量界面。" \
        "5. **上线前检查**：用 \`web-design-guidelines\` 和 \`verification-before-completion\` 做 UX、可访问性和设计 QA。"
      ;;
    程序开发者)
      printf '%s\n' \
        "1. **计划和隔离**：用 \`writing-plans\` 写实施计划，必要时用 \`using-git-worktrees\` 准备隔离工作区。" \
        "2. **实现和调试**：用 \`test-driven-development\`、\`systematic-debugging\`、\`executing-plans\` 或 \`subagent-driven-development\` 推进开发。" \
        "3. **构建 AI/API 能力**：用 \`claude-api\`、\`mcp-builder\` 处理 Claude API 和 MCP 服务。" \
        "4. **实现前端和移动端**：用 \`frontend-design\`、\`react-best-practices\`、\`react-native-skills\`、\`composition-patterns\`、\`react-view-transitions\`。" \
        "5. **评审和验证**：用 \`requesting-code-review\`、\`receiving-code-review\`、\`webapp-testing\`、\`verification-before-completion\` 做质量闭环。" \
        "6. **部署和国际化**：用 \`deploy-to-vercel\` 发布预览环境，用 \`pp-translator\` 同步语言文件。"
      ;;
    运营增长)
      printf '%s\n' \
        "1. **写运营材料**：用 \`doc-coauthoring\`、\`internal-comms\` 写公告、周报、FAQ、项目更新。" \
        "2. **处理数据和表格**：用 \`xlsx\` 清理运营数据、内容计划和活动排期。" \
        "3. **制作汇报和文档**：用 \`pptx\`、\`docx\`、\`pdf\` 处理运营交付物。" \
        "4. **统一视觉表达**：用 \`brand-guidelines\`、\`theme-factory\` 统一活动和品牌素材风格。" \
        "5. **多语言运营**：用 \`pp-translator\` 处理多语言文案和语言文件。"
      ;;
    本地化)
      printf '%s\n' \
        "1. **确定基准语言**：先明确使用中文还是英文作为翻译基准。" \
        "2. **增量同步语言文件**：用 \`pp-translator\` 只翻译新增或选中的 key。" \
        "3. **检查目标地区表达**：参考 \`国际化各个国家地区策略指南\` 调整语气和用词。" \
        "4. **回写项目文件**：确认 ARB、strings、JSON、YAML 等文件格式保持正确。"
      ;;
    技能创建者)
      printf '%s\n' \
        "1. **创建新技能**：用 \`skill-creator\` 或 \`writing-skills\` 梳理触发场景、流程和 SKILL.md。" \
        "2. **验证技能行为**：用 \`test-driven-development\` 和 \`verification-before-completion\` 把示例提示、失败基线和通过证据补齐。" \
        "3. **构建工具能力**：用 \`mcp-builder\` 把外部服务沉淀成 MCP 工具。" \
        "4. **优化 API 型技能**：用 \`claude-api\` 处理 Claude SDK、模型迁移和 prompt caching。" \
        "5. **补文档**：用 \`doc-coauthoring\` 写使用说明、评估标准和维护流程。"
      ;;
    *)
      printf '%s\n' "1. 从下方推荐技能中选择最贴近当前任务的一个。" "2. 打开对应用法页，复制示例说法并补充你的实际输入。" "3. 若任务跨阶段，按用法页逐个串联技能。"
      ;;
  esac
}

role_example_prompts() {
  case "$1" in
    独立开发者)
      printf '%s\n' \
        "- “先用 brainstorming 和 writing-plans，把这个 SaaS 想法整理成 MVP 开发计划。”" \
        "- “帮我设计一个适合海外用户的 landing page，并给出组件结构。”" \
        "- “实现完成前，用 verification-before-completion 检查测试和文档是否都同步了。”"
      ;;
    产品经理)
      printf '%s\n' \
        "- “先用 brainstorming 追问我，把这段需求背景整理清楚。”" \
        "- “把这些用户反馈整理成优先级表格。”" \
        "- “用 writing-plans 把这个 PRD 拆成工程可执行任务。”"
      ;;
    产品设计)
      printf '%s\n' \
        "- “帮我设计一个 B2B SaaS 后台首页的信息架构和视觉方向。”" \
        "- “检查这个页面的 UX、可访问性和设计一致性。”" \
        "- “给这套页面生成一个统一主题和字体配色方案。”"
      ;;
    程序开发者)
      printf '%s\n' \
        "- “这个 bug 先用 systematic-debugging 找根因，再按 TDD 修复。”" \
        "- “这份计划请用 subagent-driven-development 执行，并在每项后 review。”" \
        "- “完成前用 verification-before-completion 跑验证并给出证据。”"
      ;;
    运营增长)
      printf '%s\n' \
        "- “写一份新功能发布公告和用户 FAQ。”" \
        "- “把这份运营数据整理成 Excel 并生成图表。”" \
        "- “把活动文案翻译成日文、韩文和英文。”"
      ;;
    本地化)
      printf '%s\n' \
        "- “只翻译我选中的这几个 key 到其他语言。”" \
        "- “按英文为基准补齐这些 arb 文件缺失的语言。”" \
        "- “检查日文和韩文翻译是否符合当地 App 表达习惯。”"
      ;;
    技能创建者)
      printf '%s\n' \
        "- “用 writing-skills 帮我创建一个用于 PRD 评审的 skill。”" \
        "- “优化这个 SKILL.md 的 description，让触发更准确。”" \
        "- “给这个 skill 设计 5 条真实测试提示词，并说明如何验证。”"
      ;;
    *) printf '%s\n' "- “我现在是$1，帮我选择适合当前任务的技能。”" ;;
  esac
}

write_role_usage_guide() {
  local role="$1"
  local role_file="$ROLE_GUIDES_DIR/$(role_file_name "$role")"
  local before_file after_file tmp_file
  before_file="$(mktemp)"
  after_file="$(mktemp)"
  tmp_file="$(mktemp)"

  if [ -f "$role_file" ] && grep -q '<!-- AUTO-GENERATED:START -->' "$role_file"; then
    awk '/<!-- AUTO-GENERATED:START -->/ { exit } { print }' "$role_file" > "$before_file"
    awk 'seen { print } /<!-- AUTO-GENERATED:END -->/ { seen = 1; next }' "$role_file" > "$after_file"
  else
    {
      echo "# $role 使用指南"
      echo ""
    } > "$before_file"
    {
      echo ""
      echo "## 人工补充"
      echo ""
      echo "<!-- 可在这里补充该角色的团队内部流程、真实案例或项目约定。生成脚本不会覆盖本区块。 -->"
    } > "$after_file"
  fi

  cat "$before_file" > "$tmp_file"
  {
    echo "<!-- AUTO-GENERATED:START -->"
    echo ""
    echo "## 适用说明"
    echo ""
    echo "$(role_intro "$role")"
    echo ""
    echo "## 推荐使用流程"
    echo ""
    role_workflow "$role"
    echo ""
    echo "## 推荐技能"
    echo ""
    echo "| Skill | 分类 | 怎么用 |"
    echo "| --- | --- | --- |"
    awk -F'|' -v role="$role" 'index($3, role) { print "| [" $2 "](../03_skill-usage/" $2 ".md) | `" $1 "` | [查看用法](../03_skill-usage/" $2 ".md) |" }' "$role_tmp"
    echo ""
    echo "## 你可以直接这样说"
    echo ""
    role_example_prompts "$role"
    echo ""
    echo "## 相关索引"
    echo ""
    echo "- [按使用角色](../02_skill-catalog/按使用角色.md)"
    echo "- [技能具体用法说明](../03_skill-usage/README.md)"
    echo ""
    echo "<!-- AUTO-GENERATED:END -->"
  } >> "$tmp_file"
  cat "$after_file" >> "$tmp_file"
  mv "$tmp_file" "$role_file"
  rm -f "$before_file" "$after_file"
}

write_usage_page() {
  local skill_dir="$1"
  local skill_slug="$2"
  local skill_name="$3"
  local description="$4"
  local domain="$5"
  local roles="$6"
  local source_path="${skill_dir#$PROJECT_ROOT/}"
  local usage_file="$USAGE_DIR/$skill_slug.md"
  local before_file after_file tmp_file

  before_file="$(mktemp)"
  after_file="$(mktemp)"
  tmp_file="$(mktemp)"

  if [ -f "$usage_file" ] && grep -q '<!-- AUTO-GENERATED:START -->' "$usage_file"; then
    awk '/<!-- AUTO-GENERATED:START -->/ { exit } { print }' "$usage_file" > "$before_file"
    awk 'seen { print } /<!-- AUTO-GENERATED:END -->/ { seen = 1; next }' "$usage_file" > "$after_file"
  else
    {
      echo "# $skill_slug 用法说明"
      echo ""
    } > "$before_file"
    {
      echo ""
      echo "## 人工补充"
      echo ""
      echo "<!-- 可在这里补充团队内部示例、项目约定或注意事项。生成脚本不会覆盖本区块。 -->"
    } > "$after_file"
  fi

  cat "$before_file" > "$tmp_file"
  {
    echo "<!-- AUTO-GENERATED:START -->"
    echo ""
    echo "## 技能名称"
    echo ""
    echo "- 文件夹名：\`$skill_slug\`"
    echo "- Frontmatter name：\`${skill_name:-$skill_slug}\`"
    echo ""
    echo "## 所属分类"
    echo ""
    echo "- \`$domain\`（$(domain_label "$domain")）"
    echo ""
    echo "## 适合谁用"
    echo ""
    echo "- ${roles:-未配置，请补充 docs/02_skill-catalog/role-map.yml}"
    echo ""
    echo "## 什么时候用"
    echo ""
    echo "$(when_text "$skill_slug" "$description")"
    echo ""
    echo "## 你可以怎么说"
    echo ""
    usage_prompts "$skill_slug"
    echo ""
    echo "## 使用前准备"
    echo ""
    echo "$(prep_text "$skill_slug")"
    echo ""
    echo "## 典型输出"
    echo ""
    echo "$(output_text "$skill_slug")"
    echo ""
    echo "## 不适合的场景"
    echo ""
    echo "$(not_for_text "$skill_slug")"
    echo ""
    echo "## 源文件"
    echo ""
    echo "- \`$source_path/SKILL.md\`"
    echo ""
    echo "<!-- AUTO-GENERATED:END -->"
  } >> "$tmp_file"
  cat "$after_file" >> "$tmp_file"
  mv "$tmp_file" "$usage_file"
  rm -f "$before_file" "$after_file"
}

overview_file="$CATALOG_DIR/技能总览.md"
domain_file="$CATALOG_DIR/按技能分类.md"
role_file="$CATALOG_DIR/按使用角色.md"
usage_index="$USAGE_DIR/README.md"
role_tmp="$(mktemp)"

{
  echo "# 技能总览"
  echo ""
  echo "<!-- AUTO-GENERATED:START -->"
  echo ""
  echo "本文档由 \`scripts/generate-docs-index.sh\` 生成。新增或移动 skill 后请重新运行脚本。"
  echo ""
  echo "| Skill | 分类 | 适合角色 | 用法说明 | 源文件 |"
  echo "| --- | --- | --- | --- | --- |"
} > "$overview_file"

{
  echo "# 按技能分类"
  echo ""
  echo "<!-- AUTO-GENERATED:START -->"
  echo ""
  echo "本文档由 \`scripts/generate-docs-index.sh\` 生成。"
  echo ""
} > "$domain_file"

{
  echo "# 按使用角色"
  echo ""
  echo "<!-- AUTO-GENERATED:START -->"
  echo ""
  echo "本文档由 \`scripts/generate-docs-index.sh\` 根据 \`role-map.yml\` 生成。"
  echo ""
} > "$role_file"

{
  echo "# 技能具体用法说明"
  echo ""
  echo "<!-- AUTO-GENERATED:START -->"
  echo ""
  echo "每个 skill 一页，面向安装后的实际使用者。"
  echo ""
  echo "| Skill | 分类 | 适合角色 | 用法说明 |"
  echo "| --- | --- | --- | --- |"
} > "$usage_index"

current_domain=""
while read -r skill_dir; do
  skill_slug="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"
  rel_skill_file="${skill_file#$PROJECT_ROOT/}"
  path_domain="$(echo "${skill_dir#$SKILLS_DIR/}" | cut -d/ -f1)"
  mapped_domain="$(role_map_domain "$skill_slug")"
  domain="${mapped_domain:-$path_domain}"
  roles="$(role_map_roles "$skill_slug")"
  skill_name="$(extract_frontmatter_field "$skill_file" "name")"
  description="$(extract_frontmatter_field "$skill_file" "description")"
  [ -z "$description" ] && description="请查看源文件中的触发说明。"

  write_usage_page "$skill_dir" "$skill_slug" "$skill_name" "$description" "$domain" "$roles"

  echo "| [$skill_slug](../03_skill-usage/$skill_slug.md) | \`$domain\` | ${roles:-未配置} | [查看](../03_skill-usage/$skill_slug.md) | \`$rel_skill_file\` |" >> "$overview_file"
  echo "| [$skill_slug]($skill_slug.md) | \`$domain\` | ${roles:-未配置} | [查看]($skill_slug.md) |" >> "$usage_index"
  echo "$domain|$skill_slug|$roles" >> "$role_tmp"
done < <(collect_leaf_skills)

while read -r domain; do
  [ -z "$domain" ] && continue
  echo "## \`$domain\` $(domain_label "$domain")" >> "$domain_file"
  echo "" >> "$domain_file"
  echo "| Skill | 适合角色 | 用法说明 |" >> "$domain_file"
  echo "| --- | --- | --- |" >> "$domain_file"
  awk -F'|' -v domain="$domain" '$1 == domain { print "| [" $2 "](../03_skill-usage/" $2 ".md) | " $3 " | [查看](../03_skill-usage/" $2 ".md) |" }' "$role_tmp" >> "$domain_file"
  echo "" >> "$domain_file"
done < <(cut -d'|' -f1 "$role_tmp" | sort -u)

while read -r role; do
  [ -z "$role" ] && continue
  echo "## $role" >> "$role_file"
  echo "" >> "$role_file"
  echo "| Skill | 分类 | 用法说明 |" >> "$role_file"
  echo "| --- | --- | --- |" >> "$role_file"
  awk -F'|' -v role="$role" 'index($3, role) { print "| [" $2 "](../03_skill-usage/" $2 ".md) | `" $1 "` | [查看](../03_skill-usage/" $2 ".md) |" }' "$role_tmp" >> "$role_file"
  echo "" >> "$role_file"
  write_role_usage_guide "$role"
done < <(awk -F'|' '{ n = split($3, roles, "、"); for (i = 1; i <= n; i++) print roles[i] }' "$role_tmp" | sort -u)

{
  echo "<!-- AUTO-GENERATED:END -->"
} >> "$overview_file"

{
  echo "<!-- AUTO-GENERATED:END -->"
} >> "$domain_file"

{
  echo "<!-- AUTO-GENERATED:END -->"
} >> "$role_file"

{
  echo "<!-- AUTO-GENERATED:END -->"
} >> "$usage_index"

rm -f "$role_tmp"

echo "已生成技能目录和用法说明。"
