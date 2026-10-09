# 平台配置基线（AdMob / AdSense）

本文件是 pp-ads-check Step 1（配置检查）的对照基线。API 名称、依赖版本号会随 SDK 更新，审查时如发现项目版本较新或较旧，请联网核对官方快速入门：

- iOS：https://developers.google.com/admob/ios/quick-start
- Android：https://developers.google.com/admob/android/quick-start
- Flutter：https://developers.google.com/admob/flutter/quick-start
- 测试广告：https://developers.google.com/admob/ios/test-ads、`/android/test-ads`、`/flutter/test-ads`

## 0. 通用红线（所有平台）

| 检查项 | 基线要求 | 级别 |
| --- | --- | --- |
| App ID vs 广告位 ID | App ID 形如 `ca-app-pub-XXXXXXXX~YYYYYYYY`（`~`），广告位 ID 形如 `ca-app-pub-XXXXXXXX/YYYYYYYY`（`/`），不得互换 | P0 |
| 平台串用 | iOS 广告位 ID 只能用于 iOS 包，Android ID 只能用于 Android 包，Flutter 两端各自配置 | P0 |
| 初始化次数 | Mobile Ads SDK 全局只初始化一次（重复初始化不致命但会引发行为异常，属于 P2） | P2 |
| demo ID 发布 | 发布版本禁止使用 Google 官方 demo 广告位 ID；正式包中 demo ID 视为 P0 | P0 |
| 测试广告 | 开发期要么使用 demo 广告位，要么把真机注册为测试设备；禁止直接点击正式广告测试 | P0 |
| 隐私同意 | 面向 EEA/英国/瑞士必须接入 UMP 并配置欧盟法规消息（GDPR + IAB TCF） | P0 |
| app-ads.txt | 部署在开发者域名根路径，含 `google.com, pub-XXXX, DIRECT, f08c47fec0942fa0`，开发者域名已在商店后台填写 | P1 |
| 隐私政策 | 商店 listing 与 App 内可访问的隐私政策 URL，内容覆盖广告数据收集 | P1 |
| 商店数据披露 | Google Play Data safety、App Store App 隐私标签与实际采集一致（IDFA/GAID、使用数据） | P1 |

## 1. iOS（Swift / Objective-C）

### 1.1 依赖

- CocoaPods：`pod 'Google-Mobile-Ads-SDK'`，执行 `pod install` 后使用 `.xcworkspace`。
- 也支持 Swift Package Manager。
- UMP API 位于 `UserMessagingPlatform` 模块（类名以 `UMP` 开头）。若 `import UserMessagingPlatform` 失败，按当前官方 UMP 文档确认是否需要额外依赖。
- 审查时确认 Podfile.lock / Package.resolved 中版本在官方支持范围内。

### 1.2 Info.plist

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyy</string>
<key>SKAdNetworkItems</key>
<array>
  <dict><key>SKAdNetworkIdentifier</key><string>cstr6suwn9.skadnetwork</string></dict>
  <!-- 其余条目按官方 SKAdNetwork ID 清单补全 -->
</array>
```

- `GADApplicationIdentifier` 缺失会导致 SDK 初始化失败/崩溃。
- `SKAdNetworkItems`：按 Google 官方提供的完整 SKAdNetwork ID 列表配置（列表较长，以官方文档为准），影响归因与广告填充。
- 仅当代码调用 ATT 时才需要 `NSUserTrackingUsageDescription`，文案必须说明用途；不请求 IDFA 则不要添加无意义的授权弹窗。

### 1.3 初始化与全局配置（Swift 示例）

```swift
import GoogleMobileAds

// App 启动后尽早初始化，全局一次
GADMobileAds.sharedInstance().start(completionHandler: nil)

// 开发期测试设备（上线前移除/仅在 DEBUG 下生效）
GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [
    GADSimulatorID, "xxxxxxxx-xxxxxxxxxxxxxxxx"
]

// 儿童受众 / 内容分级（按业务需要）
GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: true)
GADMobileAds.sharedInstance().requestConfiguration.maxAdContentRating = GADMaxAdContentRatingGeneral
```

### 1.4 审查要点

- `start` 是否只调用一次（AppDelegate / App 入口），是否在 UMP 流程之外还存在第二处初始化。
- 测试设备 ID 是否用 `#if DEBUG` 等方式隔离，正式包不携带真机 ID 并不影响（测试设备 ID 泄漏不是政策问题，但应检查环境隔离机制）。
- ATT（`ATTrackingManager.requestTrackingAuthorization`）弹窗是否在用户理解语境时出现（通常在同意征询之后），是否存在启动即弹、被拒后反复弹。

## 2. Android（Kotlin / Java）

### 2.1 依赖

```kotlin
implementation("com.google.android.gms:play-services-ads:23.x")       // 以官方最新受支持版本为准
implementation("com.google.android.ump:user-messaging-platform:2.x")  // UMP
```

注意：Google 已发布下一代 GMA SDK（Next-Gen，beta）。若项目引入的是 Next-Gen 包，API 名称与初始化方式不同，必须按 next-gen 文档审查，不要与 legacy API 混用判定。

### 2.2 AndroidManifest.xml

```xml
<application ...>
    <meta-data
        android:name="com.google.android.gms.ads.APPLICATION_ID"
        android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyy" />
</application>
```

- meta-data 必须位于 `<application>` 内；缺失会在初始化时抛出 `IllegalStateException`。
- `INTERNET` 权限由 SDK manifest 合并引入，确认没有被 tools:node=remove 误删。
- Android 模拟器自动视为测试设备；真机仍需显式注册。

### 2.3 初始化与全局配置（Kotlin 示例）

```kotlin
// Application.onCreate 或首个 Activity，全局一次
MobileAds.initialize(this)

val config = RequestConfiguration.Builder()
    .setTestDeviceIds(listOf("TEST-DEVICE-ID-HASHED")) // 仅 DEBUG
    .setTagForChildDirectedTreatment(
        RequestConfiguration.TAG_FOR_CHILD_DIRECTED_TREATMENT_TRUE
    )
    .setMaxAdContentRating("G")
    .build()
MobileAds.setRequestConfiguration(config)
```

### 2.4 审查要点

- 是否存在多处 `MobileAds.initialize`（多进程 App 注意只在主进程初始化）。
- minSdk / targetSdk 与所用 SDK 版本是否匹配。
- 中介适配器是否在依赖中且版本与官方兼容矩阵匹配；适配器缺失不会报错但无填充。
- CCPA RDP 通过广告请求 extras 标记（`"rdp"` 键），具体写法以官方 California 用户政策文档为准。

## 3. Flutter（google_mobile_ads）

### 3.1 依赖与平台配置

```yaml
dependencies:
  google_mobile_ads: ^x.y.z  # 以 pub.dev 最新稳定版为准
```

- Flutter 插件不替代平台配置：iOS 的 Info.plist 与 Android 的 AndroidManifest 仍然必须分别配置。
- minSdk、Android  Gradle、iOS deployment target 需满足插件当前要求。
- UMP 能力已包含在插件 API 中（`ConsentInformation`、`ConsentForm`、`ConsentRequestParameters`）。

### 3.2 初始化与配置（Dart 示例）

```dart
WidgetsFlutterBinding.ensureInitialized();
await MobileAds.instance.initialize(); // 全局一次

MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
  testDeviceIds: ['TEST-DEVICE-ID'], // 仅 DEBUG
  tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
  maxAdContentRating: MaxAdContentRating.g,
));
```

### 3.3 审查要点

- 两端 App ID 是否分别写在原生配置文件里（dart-define/flavor 只负责广告位 ID 切换）。
- 广告位 ID 是否按 iOS/Android 分别取值，是否有统一的环境配置层（debug→demo ID，release→正式 ID）。
- 广告对象（`BannerAd`/`InterstitialAd`/`RewardedAd`/`AppOpenAd`）是否在 Widget 销毁时调用 `dispose()`。

## 4. 环境隔离的常见做法与检查

| 方案 | 平台 | 检查点 |
| --- | --- | --- |
| Build flavor / BuildConfig | Android | `BuildConfig.DEBUG` 或 flavor 字段注入 ID，确认 release 变体取值 |
| xcconfig / Build Configuration | iOS | Info.plist 用变量引用，确认 Release configuration 指向正式 ID |
| dart-define / flavor 包 | Flutter | 单一 `AdsConfig` 出口，代码中不应散落硬编码 `ca-app-pub` |

典型 P0：为省事全量写死 demo ID 或他人账号 ID；典型 P1：debug/release 用同一个广告位 ID（开发点击污染正式数据）。

## 5. Web AdSense 对照

- 页面引入 `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-...`，且 `data-ad-client` 与账号一致。
- 站点根目录可访问 `https://站点域名/ads.txt`，内容含 Google DIRECT 行。
- 移动端原生 App 内的 WebView **不允许**承载 AdSense 广告；App 内广告必须走 AdMob 原生 SDK。
- 欧盟/英国/瑞士访问者需要 cookie/个性化广告同意机制。
- 单页应用动态插入广告单元需按 AdSense 官方 SPA 指南处理，不得自行制造虚假展示。

## 6. 后台配置项（代码无法验证，列入报告"需后台确认"）

- AdMob 后台 App 是否已通过审核、广告位格式与代码请求格式一致（如代码请求插屏，后台建成 Banner）。
- 频次上限（frequency capping）、eCPM 最低限额、屏蔽控制、审核中心设置。
- 中介：各网络是否在 AdMob 和第三方后台双向配置、适配器与 SDK 版本兼容。
- app-ads.txt 线上 URL 可访问、发布者 ID 正确、无重复/拼写错误。
- 开发者网站地址已在 Play Console / App Store Connect 填写且与 app-ads.txt 部署域名一致。
