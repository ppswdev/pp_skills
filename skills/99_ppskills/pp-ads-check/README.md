# pp-ads-check - AdMob / AdSense 广告接入合规审查技能包

`pp-ads-check` 面向移动 App 上线前的 Google AdMob 接入审查，覆盖配置检查、调用链机制、政策合规和机型/无效流量检测分析；Web AdSense 提供政策对照清单。

## 目录结构

```
pp-ads-check/
├── SKILL.md                        # 主入口：触发场景与五步审查流程
├── README.md
├── CONFIG.md
├── 使用指南.md
├── scripts/
│   └── ads_audit.sh                # 只读静态扫描脚本
└── references/
    ├── platform-config-baseline.md # iOS/Android/Flutter/Web 配置基线
    ├── ad-call-chain.md            # 各广告格式调用链与生命周期
    ├── admob-policy-checklist.md   # AdMob/AdSense 政策合规清单
    └── invalid-traffic-device.md   # 无效流量、机型与测试设备检测分析
```

## 核心能力

- 扫描 `GADApplicationIdentifier`、AndroidManifest App ID、UMP/ATT/COPPA/CCPA 标记、测试设备与 demo ID、`ca-app-pub-*` ID 分布
- 审查初始化 → 同意征询 → 加载 → 展示 → 回调 → 销毁的完整调用链（插屏/激励/开屏/Banner/原生）
- 对照 Google AdMob / AdSense 现行政策输出 P0/P1/P2 分级报告，每条结论附代码证据或官方条款
- 提供机型适配误触检查、无效流量数据下钻方法和违规处置/申诉前自查 SOP

## 支持平台

- iOS（Swift / Objective-C）
- Android（Kotlin / Java）
- Flutter（`google_mobile_ads`）
- Web AdSense（政策对照，不审查 App 内 WebView 场景以外的实现细节）

## 常见触发说法

```text
用 pp-ads-check 帮我审查这个项目的 AdMob 接入
上线前检查一下插屏和激励广告是否合规
AdMob 政策中心发警告了，帮我排查代码
检查 UMP、ATT 和 COPPA 配置，App 要上欧洲区
帮我分析下广告点击率异常会不会被判定无效流量
```

## 参考文档

- `references/platform-config-baseline.md`：配置检查时读取。
- `references/ad-call-chain.md`：分析广告调用链时读取。
- `references/admob-policy-checklist.md`：政策合规判定时读取。
- `references/invalid-traffic-device.md`：机型与无效流量分析时读取。

## 迁移说明

复制整个 `pp-ads-check/` 目录即可迁移技能。`SKILL.md` 是必需文件；`scripts/ads_audit.sh` 为只读脚本，运行时不需要额外依赖（bash、find、grep）。
