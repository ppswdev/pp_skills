---
name: "pp-ads-check"
description: "pp-ads-check 是 AdMob / AdSense 广告接入合规审查技能，覆盖配置检查、调用链机制审查、广告政策合规审查和机型/无效流量检测分析。当用户出现以下任一情况时，必须立即调用此技能：审查 AdMob 接入是否合规；检查 Google Mobile Ads SDK 配置（Info.plist、AndroidManifest、pubspec、App ID、广告位 ID、测试设备）；审查广告调用链（初始化、UMP 同意征询、加载、展示、奖励发放、销毁）；插屏/激励/开屏(App Open)/Banner/原生(Native)广告上线前检查；GDPR、UMP、ATT、IDFA、COPPA、tagForChildDirectedTreatment、CCPA、儿童受众、隐私政策、Data safety 合规；app-ads.txt/ads.txt 检查；无效流量(invalid traffic)、误点击、封号/限投风险排查；广告被拒、政策中心警告、广告投放限制申诉前自查；提到 pp-ads-check、广告合规、广告检查、admob 审查、adsense 政策、上架广告检查。支持 iOS(Swift/Objective-C)、Android(Kotlin/Java)、Flutter(google_mobile_ads)，Web AdSense 提供对照清单。"
---

# pp-ads-check - AdMob / AdSense 广告接入合规审查

`pp-ads-check` 是针对 Google AdMob 移动端广告接入的只读审查技能，也覆盖 Web AdSense 的政策对照。它把一次完整的广告审查拆成 **配置检查 → 调用链分析 → 政策合规 → 机型与无效流量分析 → 出报告** 五个阶段，并提供确定性静态扫描脚本和分主题参考文档。

## 目录结构

```
pp-ads-check/
├── SKILL.md
├── README.md
├── CONFIG.md
├── 使用指南.md
├── scripts/
│   └── ads_audit.sh            # 只读静态扫描，快速定位配置与调用链事实
└── references/
    ├── platform-config-baseline.md  # iOS/Android/Flutter/Web 配置基线
    ├── ad-call-chain.md             # 各广告格式调用链与生命周期
    ├── admob-policy-checklist.md    # AdMob/AdSense 政策合规清单
    └── invalid-traffic-device.md    # 无效流量、机型与测试设备检测分析
```

## 适用范围

- **平台**：iOS（Swift / Objective-C）、Android（Kotlin / Java）、Flutter（`google_mobile_ads`）；Web 站点 AdSense 仅做政策对照。
- **广告格式**：Banner（含自适应 Banner）、Interstitial 插屏、Rewarded 激励、Rewarded Interstitial、App Open 开屏、Native 原生。
- **审查对象**：接入代码、平台配置文件、隐私同意流程（UMP/ATT）、商店披露信息、app-ads.txt、中介（Mediation）对接配置。
- **不适用**：Meta、Unity Ads、AppLovin 等第三方广告网络自有的政策细节；中介场景只审查适配器版本与对接配置是否满足 Google 侧要求。

## 触发场景（必须立即调用）

1. 用户说："审查 AdMob 接入"、"广告合规检查"、"上线前查一下广告"、"pp-ads-check"。
2. 新增/修改了广告代码：初始化、插屏、激励视频、开屏广告、Banner、原生广告。
3. 提到 UMP、GDPR、同意征询、ATT、IDFA、COPPA、儿童定向、CCPA、隐私政策、Data safety / App 隐私标签。
4. 检查 App ID / 广告位 ID、Info.plist（`GADApplicationIdentifier`）、AndroidManifest、`google_mobile_ads` 配置。
5. 排查无效流量、误点击、广告点击率异常、账号被限投/封停、政策中心警告、商店审核被拒。
6. 检查 app-ads.txt / ads.txt、测试设备、demo 广告位 ID 是否泄漏到发布版本。
7. 用户要求"结合 Google AdMob / AdSense 政策做机型检测分析"。

## 审查原则

1. **只读审查**：不修改用户代码，所有结论给出证据（`文件路径#行号`）和修复建议。
2. **事实与推断分离**：每条发现标注证据类型——`代码可证`、`需后台确认`（AdMob 控制台、Play Console、App Store Connect）、`需运行时验证`。
3. **政策时效优先**：Google 政策和 SDK API 更新频繁。涉及版本号、强制要求时间点、具体 API 名称时，先读取参考文档，再用 WebSearch/WebFetch 核对 developers.google.com 和 support.google.com 的最新官方表述，不得凭记忆下"违规"定论。
4. **先脚本后人审**：确定性事实用 `scripts/ads_audit.sh` 扫描，人工聚焦时序、展示场景、市场范围等脚本无法判断的部分。
5. **零误报导向**：区分"演示 ID 出现在 debug 代码"（正常）与"演示 ID 进入 release 构建"（P0），不输出无证据的恐吓性结论。

## 标准审查流程

### Step 0：项目识别

先确认以下事实，再决定检查范围：

- 平台与技术栈（iOS / Android / Flutter / Web，语言与构建方式）。
- SDK 与版本：CocoaPods/SPM 的 `Google-Mobile-Ads-SDK`、Gradle 的 `play-services-ads` 与 `user-messaging-platform`、pubspec 的 `google_mobile_ads`。
- 使用了哪些广告格式、哪些广告位 ID，是否接入中介（Mediation）及适配器。
- 目标市场：是否面向 EEA/英国/瑞士（UMP 强制）、美国加州（CCPA）、儿童受众（COPPA / Families）。
- 发布渠道：App Store / Google Play / 仅内部分发。

### Step 1：配置检查（确定性扫描）

```bash
bash scripts/ads_audit.sh <项目根目录>
```

脚本只读扫描：平台配置项（`GADApplicationIdentifier`、`APPLICATION_ID` meta-data、SKAdNetwork、ATT 描述）、初始化位置、UMP/ATT/COPPA/TFUA/CCPA 标记、测试设备配置、所有 `ca-app-pub-*` ID 与 Google demo ID 的分布、app-ads.txt、奖励服务端校验等。

脚本输出后，对照 [references/platform-config-baseline.md](references/platform-config-baseline.md) 逐项确认，重点：

- App ID（`~`）与广告位 ID（`/`）没有互换；iOS/Android ID 没有串平台。
- 初始化全局只发生一次；debug/release 环境的 ID 隔离机制（flavor、xcconfig、dart-define）。
- 发布版本中不存在 Google demo 广告位 ID，真机开发已注册测试设备。

### Step 2：调用链机制分析

阅读广告相关代码，按 [references/ad-call-chain.md](references/ad-call-chain.md) 为每个广告位还原完整时序：

```
启动 → UMP 同意征询（EEA/UK/CH）→ ATT（iOS，仅在需要 IDFA 时）
     → MobileAds 初始化（一次）→ RequestConfiguration（测试设备/儿童标记/内容分级/RDP）
     → 预加载 → 展示前 canPresent 检查 → 在自然场景点展示
     → 点击/奖励/关闭/失败回调 → 奖励发放凭据 → destroy/dispose → 预加载下一条
```

重点确认：插屏不在启动/加载/退出时突然出现；激励奖励只由回调或 SSV 发放；开屏广告不遮挡其他广告且不阻塞内容；广告对象关闭后置空并释放；失败重试有退避、不空转。

### Step 3：政策合规审查

对照 [references/admob-policy-checklist.md](references/admob-policy-checklist.md) 逐条核对：展示位置政策（误点击、诱导点击、自然断点）、各格式专项政策、内容政策、隐私与同意（UMP/ATT/COPPA/CCPA）、商店披露（隐私政策 URL、Play Data safety、App 隐私标签）、app-ads.txt。

每条结论必须能对应到：代码证据 **或** 官方政策条款（附官方链接）。拿不准的政策项列入"需后台确认"，不要臆断。

### Step 4：机型与无效流量检测分析

按 [references/invalid-traffic-device.md](references/invalid-traffic-device.md) 从两端分析：

- **代码侧**：是否存在自动点击/自动曝光、广告不可见时仍加载展示、WebView 内加载 AdSense、自行采集/伪造 IDFA/GAID、定时强制刷新 Banner 等行为；不同机型的布局误触（安全区、手势条、灵动岛、折叠屏、平板、自适应 Banner 宽度）。
- **数据侧**（需后台确认）：CTR/展示量突增、点击在机型/OS 版本/地区/渠道上的集中度、点击-展示间隔异常、新账号广告投放限制（ad serving limit）信号，以及收到政策警告时的应急 SOP。

### Step 5：输出审查报告

报告使用下表，按严重级别排序，并在末尾列出无法从代码确认的事项：

| 级别 | 类别 | 问题描述 | 证据 | 政策依据 | 修复建议 |
| --- | --- | --- | --- | --- | --- |
| P0 | 合规/流量 | 例：release 包使用 demo 广告位 ID | `lib/ads/ads_config.dart#L12` | 官方测试广告指南 | 改为按环境注入正式 ID |

**严重级别定义**：

- **P0**：直接违反政策或会产生无效流量——封停/限投/拒审风险，必须发布前修复。
- **P1**：高风险——大概率审核被拒、收入受限或用户投诉，应发布前修复。
- **P2**：最佳实践——体验、稳定性、可维护性问题，建议排期修复。

报告末尾必须包含：

- **需后台确认清单**：AdMob 后台广告位设置、频次上限、屏蔽控制、政策中心状态；Play/App Store 的隐私标签；app-ads.txt 线上可访问性。
- **需运行时验证清单**：真机上同意表单弹出时机、拒绝同意后广告行为、各机型展示位置、中介填充。
- **本次核对的官方文档链接与日期**。

## 参考文档加载时机

| 文档 | 什么时候读 |
| --- | --- |
| `references/platform-config-baseline.md` | Step 1，核对平台配置、SDK 版本、环境隔离时 |
| `references/ad-call-chain.md` | Step 2，还原各广告格式时序和生命周期时 |
| `references/admob-policy-checklist.md` | Step 3，逐条做政策合规判定时 |
| `references/invalid-traffic-device.md` | Step 4，分析机型适配、无效流量和封号风险时 |

## 调用示例

> **用户**："帮我审查一下这个 Flutter 项目的 AdMob 接入，下周要上架。"
>
> ✅ 运行 `scripts/ads_audit.sh` 扫描 → 按 Step 0-5 完整审查 → 输出分级报告和后台确认清单。

> **用户**："AdMob 政策中心说插屏违规，帮我看看代码哪里有问题。"
>
> ✅ 定位所有插屏加载/展示调用链，重点核对展示时机（启动、加载中、自然断点），输出证据与整改建议；同时给出申诉前自查项。

> **用户**："我们 App 要上欧洲区，UMP 和 ATT 要怎么配才算合规？"
>
> ✅ 读取配置基线和政策清单，核对 UMP 征询、TFUA、撤回入口、ATT 用途描述与调用时序，联网核对最新官方要求后给出结论。

## 核心原则

1. **证据先行**：没有代码行号或官方条款，不下"违规"结论。
2. **范围完整**：配置、调用链、政策、机型流量四条线缺一不可，不因扫描脚本零告警就结束审查。
3. **只读安全**：只报告和建议，不直接改动广告代码与配置文件。
4. **官方为准**：政策解释以 Google 官方文档和政策中心通知为准，并记录核对日期。
