# pp-ads-check Skill Configuration

## Skill Metadata

**Name**: pp-ads-check  
**Alias**: pp ads compliance check  
**Version**: 1.0.0  
**Updated**: 2026-09-26  
**Dependencies**: `bash`、`find`、`grep`（macOS / Linux 自带；脚本只读，无第三方依赖）

## Directory Structure

```
pp-ads-check/
├── SKILL.md                        # Main skill file, required
├── README.md                       # Package overview
├── CONFIG.md                       # Configuration and maintenance notes
├── 使用指南.md                     # Chinese usage guide
├── scripts/
│   └── ads_audit.sh                # Read-only static scanner
└── references/
    ├── platform-config-baseline.md # Per-platform configuration baseline
    ├── ad-call-chain.md            # Ad format call chains and lifecycle
    ├── admob-policy-checklist.md   # AdMob / AdSense policy checklist
    └── invalid-traffic-device.md   # Invalid traffic, device & test-device analysis
```

## Scope

| Target | Supported |
| --- | --- |
| iOS (Swift / Objective-C) | Yes |
| Android (Kotlin / Java) | Yes |
| Flutter (`google_mobile_ads`) | Yes |
| Web AdSense | Policy cross-check only |
| Other ad networks (Meta, Unity Ads, AppLovin, etc.) | Mediation configuration only, not their own policies |

## Default Behavior

| Option | Default |
| --- | --- |
| Review mode | Read-only; never modify user code or config files |
| Scanner | `bash scripts/ads_audit.sh <project-root>`; advisory output, exit code 0 on successful scan |
| Severity levels | P0 (policy violation / ban risk), P1 (high risk / likely rejection), P2 (best practice) |
| Evidence types | Code evidence (`file#L`), backend confirmation required, runtime verification required |
| Policy facts | Must be cross-checked against official Google docs (with date) before final verdicts |

## Activation Cues

The skill should activate when users mention:

- `pp-ads-check`、广告合规、广告检查、AdMob 审查、上架广告检查
- GADApplicationIdentifier、APPLICATION_ID、google_mobile_ads、广告位 ID、demo ID、测试设备
- UMP、GDPR、ATT、IDFA、COPPA、tagForChildDirectedTreatment、CCPA、隐私政策、Data safety
- 插屏/激励/开屏/Banner/原生广告接入、展示时机、奖励发放（SSV）
- app-ads.txt、ads.txt、无效流量、误点击、限投、封停、政策中心、申诉

## Maintenance Notes

- Keep `SKILL.md` task-oriented; long policy/API knowledge lives in `references/`.
- Google SDK APIs and policy enforcement evolve (e.g. Android GMA Next-Gen SDK). Update references after verifying official docs; never hardcode "latest version" claims.
- The demo ad unit ID list inside `scripts/ads_audit.sh` should be reconciled with the official test-ads pages when new formats appear.
- The scanner must stay read-only and dependency-free.
- Do not add provider-specific metadata to frontmatter unless isolated for one platform.
