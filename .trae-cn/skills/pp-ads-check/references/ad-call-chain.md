# 广告调用链与生命周期审查

本文件是 pp-ads-check Step 2（调用链分析）的对照基线。目标是为**每个广告位**还原完整时序，找出"时序错误、状态丢失、奖励可绕过、内存泄漏"四类问题。

官方各格式指南：iOS/Android/Flutter 文档下的 `banner`、`interstitial`、`rewarded`、`app-open`、`native` 页面。

## 1. 总调用链（App 级）

```
冷启动
  ├─ Mobile Ads SDK 初始化（全局一次）
  ├─ UMP：requestConsentInfoUpdate → loadAndShowConsentFormIfRequired
  │     （EEA/英国/瑞士；需在用户能看到广告/个性化数据被使用前完成）
  ├─ iOS：必要时请求 ATT（IDFA），弹窗语境与用途描述合规
  ├─ RequestConfiguration：测试设备(仅debug) / COPPA / TFUA / 内容分级 / RDP
  └─ 按场景预加载广告
          ↓
  展示前：广告对象存在 + canPresent/就绪检查
          ↓
  在"自然场景断点"展示（不是启动、加载中、无预兆弹出）
          ↓
  回调处理：点击 / 完整展示 / 奖励获得 / 关闭 / 展示失败 / 加载失败
          ↓
  关闭后：置空引用 + destroy/dispose + 预加载下一条（带退避）
```

### 1.1 初始化与 UMP 的时序关系

- UMP 征询状态更新应在 App 启动早期发起，确保欧盟用户在看到个性化广告前完成选择。
- Google 官方允许初始化 GMA SDK 与征询并行，但**不得在缺少必要同意时依赖个性化广告能力**；如果项目选择"征询完成后再初始化/再加载"，同样合规。
- 违规写法：完全跳过 UMP 直接面向欧盟用户加载广告；收到"不同意"后仍每次启动重复弹窗（应以用户选择为准，并提供设置页撤回入口）。
- TFUA 标记只设在 UMP 请求上**不够**：官方明确 UMP 的 TFUA 不会自动转发给广告请求，必须在广告请求/RequestConfiguration 上再设置儿童受限标记（新 SDK 中为 `ageRestrictedTreatment`，legacy 中为 `tagForUnderAgeOfConsent`，以项目 SDK 版本对应文档为准）。

### 1.2 失败处理链

- 加载失败（NO_FILL、网络错误、INVALID_REQUEST）：允许重试，但必须有**指数退避 + 上限**，不得 while/定时器无限重试（耗电、产生无效请求）。
- 展示失败（广告已过期、当前 VC 不适宜）：丢弃该对象、重新加载，不要强行 present。
- 错误码要打点上报，便于在后台定位是配置错误（code 1/INVALID_REQUEST）还是填充问题。

## 2. 插屏 Interstitial

**正确时序**：

```
预加载(load) → 持有对象 → 到达自然断点 → canPresent(fromRootVC) 检查
  → present → fullScreenContentDelegate 回调
  → 用户关闭后：ad = nil（防重用/野指针）→ dispose → 加载下一条
```

**必查问题**：

| 问题 | 判定方式 | 级别 |
| --- | --- | --- |
| App 启动/闪屏/页面刚加载就弹插屏 | 展示调用挂在启动链、首屏 viewDidLoad/initState 无用户行为间隔 | P0 |
| 在核心操作进行中弹窗（游戏对局、支付、表单提交） | 展示点位于连续交互流程中 | P0 |
| 退出 App 时弹窗或伪装系统对话框 | 展示点绑定退出按钮/后台切换 | P0 |
| 未做 canPresent/就绪检查直接 present | 代码中无 isReady/canPresent 判断 | P1 |
| 展示后未置空、关闭后未重载或重复展示同一对象 | 代理回调中无置空/重载 | P1 |
| 两个插屏/开屏叠放 | 开屏与插屏共享展示窗口或回调中立刻再弹 | P1 |
| 展示频次过密 | 无频次控制（后台频次上限 + 客户端最小间隔都建议有） | P1 |

合规要点：插屏只能在**内容或流程的自然停顿点**出现；用户应能明显区分广告与 App 内容；不得诱导误点。

## 3. 激励广告 Rewarded / Rewarded Interstitial

**正确时序**：

```
用户主动点击"看广告领取奖励"入口 → 加载（可提前预载）→ canPresent
  → present → onUserEarnedReward 回调（携带 reward amount/type）
  → 服务端验证 SSV（高价值奖励必须）→ 发放奖励 → 关闭后销毁重载
```

**必查问题**：

| 问题 | 判定方式 | 级别 |
| --- | --- | --- |
| 奖励发放不经过获得回调（点击入口/广告关闭即发奖） | 发奖逻辑在展示前或关闭回调中且不校验 earned | P0 |
| 可被抓包/本地篡改直接领取 | 无 SSV、奖励直接本地入库（高价值货币/道具场景） | P1 |
| 用户无预期被强制看广告 | 入口未明确说明奖励内容与"观看广告"动作 | P1 |
| 跳过/未看完也发奖 | 只监听关闭事件就发奖，未判断 earned 回调 | P0 |
| 用激励广告换取广告点击或要求点击广告 | 文案/代码存在 click-for-reward | P0 |
| 广告不可关闭/无关闭入口 | 遮挡 SDK 默认关闭控件 | P0 |

SSV 要点：在 AdMob 后台配置回调 URL，服务端校验 Google 签名、`user_id`、`custom_data`、reward 参数与交易 ID 幂等。客户端 SSV 回调数据只能用于 UI 提示，不能作为发奖凭据。

## 4. 开屏广告 App Open

**正确时序**：

```
冷启动：进入加载页时发起加载（短超时，如 ≤ 数秒）
  → 加载成功且首屏内容就绪 → present（根 VC）
回前台：AppLifecycleReactor 检测 didBecomeActive
  → 仅当已有预载广告且当前没有其他全屏广告时展示
  → 展示/失败后重新预载
```

**必查问题**：

| 问题 | 判定方式 | 级别 |
| --- | --- | --- |
| 遮挡其他全屏广告（插屏之上叠开屏） | 无"当前是否在展示广告"的状态判断 | P0 |
| 无加载超时、长时间停在闪屏/白屏等待广告 | 加载与启动流程互相阻塞 | P1 |
| 每次回前台无差别强制展示（包括刚看完广告回来） | 无冷却时间/无来源判断 | P1 |
| 广告关闭按钮不可见、误触进入商店 | 自定义加载页遮挡 SDK 控件或倒计时 | P0 |
| 内容页已开始交互后才补弹 | 异步加载迟到后无视当前场景仍 present | P1 |

## 5. Banner / 自适应 Banner

```
确定宽度（屏幕宽或容器宽，安全区内）→ adaptive 高度 → load → 加入视图层级
  → SDK 控制刷新 → 页面销毁时 dispose
```

- 刷新只能使用 SDK/后台的刷新间隔设置，**禁止**自建 Timer 定时重新 load（P0）。
- Banner 不得紧贴可点击控件（按钮、底部导航、输入框）、不得悬浮遮挡内容；要留出足够防误触边距。
- 隐藏广告时不要保留零尺寸占位反复刷新；页面不可见（后台、PageView 离屏）时按官方建议处理，不制造不可见展示。
- 自适应 Banner 要按机型宽度实时计算，横竖屏/折叠屏/分屏切换后重新取尺寸。
- Flutter `BannerAd` 必须在 dispose 中 `dispose()`；iOS 注意不要每次 cell 复用重复 load。

## 6. 原生广告 Native

```
AdLoader/NativeAdLoader 配置（数量、媒体比例、视频选项）→ load
  → 布局中必须包含：广告标识（"广告/Ad/Sponsored"）+ AdChoices 图标
  → register 点击资产（不得整屏可点）→ 列表复用正确映射 → 不可用时销毁
```

- 不得伪装成内容/消息/列表条目；广告与正文的字体、配色、图标不能刻意混淆。
- `AdChoices` 图标必须可见且不被遮挡；媒体视图、标题、正文、CTA 按官方资产规范展示。
- 点击区域只能是广告资产本身，不能把整行 cell/整个卡片作为点击热区。
- 视频原生广告遵守静音自动播放等媒体策略。

## 7. 中介（Mediation）调用链

- 初始化完成回调中的 adapter statuses 可判断各网络是否初始化成功；无填充时按网络拆解定位。
- 适配器 SDK/适配器版本必须与 GMA SDK 版本兼容（官方兼容矩阵），Flutter 插件 + 原生中介共存时两端都要配。
- GDPR/CCPA 同意信号需传递到中介网络：UMP 收集的 TCF 字符串通过标准机制下发，但部分网络有额外配置（后台广告合作伙伴名单必须包含中介伙伴）。
- 激励奖励通过中介瀑布时，SSV 仍以 Google SSV 或按各网络文档分别校验，不能假设统一。

## 8. iOS / Android / Flutter API 对照速查

| 环节 | iOS | Android | Flutter |
| --- | --- | --- | --- |
| 初始化 | `GADMobileAds.sharedInstance().start` | `MobileAds.initialize(context)` | `MobileAds.instance.initialize()` |
| 全局配置 | `requestConfiguration.testDeviceIdentifiers` 等 | `MobileAds.setRequestConfiguration(...)` | `updateRequestConfiguration(...)` |
| 插屏加载 | `GADInterstitialAd.load(...)` | `InterstitialAd.load(...)` | `InterstitialAd.load(...)` |
| 就绪/展示 | `canPresent(from:)` / `present(from:)` | `interstitialAd.show(activity)` | `interstitialAd.show()` |
| 激励回调 | `present(from:userDidEarn:)` | `setOnUserEarnedRewardListener` | `show(onUserEarnedReward:)` |
| 全屏代理 | `fullScreenContentDelegate` | `FullScreenContentCallback` | `FullScreenContentCallback` |
| 开屏 | `GADAppOpenAd.load/present` | `AppOpenAd.load/show` | `AppOpenAd.load/show` |
| UMP | `UMPConsentInformation` / `UMPConsentForm` | `UserMessagingPlatform` | `ConsentInformation` / `ConsentForm` |
| 销毁 | 释放对象、delegate 置 nil | `ad.fullScreenContent...`/`destroy()` | `ad.dispose()` |

> API 名称随版本演进（如 Android Next-Gen SDK 使用新 API 面）。审查时以项目锁定版本对应的官方文档为准，不凭记忆判定"API 错误"。

## 9. 调用链审查输出要求

对每个广告位记录一行结论：

```
广告位名 | 格式 | ID | 加载点(file#L) | 展示点(file#L) | 就绪检查 | 关闭/销毁点 | 奖励凭据 | 发现问题与级别
```

任何"展示点"都必须能回答三个问题：**用户当时在做什么（是否自然断点）？屏幕上是否已有其他广告？广告对象是否确认就绪？**
