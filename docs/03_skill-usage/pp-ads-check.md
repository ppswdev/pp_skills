# pp-ads-check 用法说明

<!-- AUTO-GENERATED:START -->

## 技能名称

- 文件夹名：`pp-ads-check`
- Frontmatter name：`pp-ads-check`

## 所属分类

- `99_ppskills`（PP 专属技能）

## 适合谁用

- 程序开发者、独立开发者

## 什么时候用

当你要审查移动 App 的 Google AdMob 广告接入时使用，适合上线前做配置检查、广告调用链分析、UMP/ATT/COPPA 隐私合规审查、机型误触与无效流量风险排查，以及收到 AdMob/AdSense 政策警告后的自查。

## 你可以怎么说

- “用 pp-ads-check 审查这个项目的 AdMob 接入是否合规。”
- “上线前帮我检查插屏、激励和开屏广告的调用链。”
- “AdMob 政策中心发警告了，帮我排查无效流量风险并给出整改清单。”

## 使用前准备

准备好项目根目录、接入的广告格式与目标市场（是否含 EEA/英国/瑞士、加州、儿童受众），以及 AdMob 后台广告位配置和政策中心状态。

## 典型输出

P0/P1/P2 分级广告审查报告，包含代码证据（文件#行号）、政策依据链接、修复建议，以及需后台确认和运行时验证的清单。

## 不适合的场景

不适合 Meta、Unity Ads、AppLovin 等非 Google 广告网络自有政策的审查，也不替代在 AdMob 后台提交申诉本身。

## 源文件

- `skills/99_ppskills/pp-ads-check/SKILL.md`

<!-- AUTO-GENERATED:END -->

## 人工补充

<!-- 可在这里补充团队内部示例、项目约定或注意事项。生成脚本不会覆盖本区块。 -->
