# 来源与本仓库用法

- 上游仓库：https://github.com/Leonxlnx/taste-skill
- 上游目录：`skills/taste-skill/`
- 上游提交：`f624f37a8c650b9cc550253104925efe4c8de246`
- 导入日期：2026-10-15
- 技能名称：`design-taste-frontend`（Taste Skill 核心技能）
- 许可证：MIT，见本目录 `LICENSE`。

导入时逐文件核对了上游快照，保留原始 `SKILL.md`、脚本、设计库、参考资料和评估示例。本仓库额外添加 `LICENSE` 与本说明。

## 调用示例

- “用 design-taste-frontend 给我的咖啡品牌做一个有辨识度的官网，使用现有品牌色和真实产品照片。”
- “用 Taste Skill 设计我的个人作品集，先确定视觉方向，再实现响应式页面。”
- “用 design-taste-frontend 改进这个产品落地页的排版、配色和布局，并检查桌面和手机效果。”

## 适用范围与运行要求

适合官网、营销页、作品集、产品展示页和 Hero 设计；本次只导入核心技能，不包含上游的其他独立技能。后台和应用屏幕请继续使用 `ui-ux-pro-max` 等技能。

- 完整流程：Node.js 22+，以及已安装的 Chrome、Edge 或 Chromium。
- `draw.mjs`、`lint.mjs` 和 `assets.mjs`：Node.js 18+，无需安装 npm 依赖。
- 素材检索需要联网，下载素材时保留来源、许可证和署名。
- 从目标网站项目根目录运行脚本；`<skill>` 替换为当前工具加载的技能目录。

## 维护

仅在 `skills/05_design/design-taste-frontend/` 维护源内容，再运行文档生成、镜像同步和验证脚本。更新上游时保留本说明与许可证，并重新记录和核对上游提交。
