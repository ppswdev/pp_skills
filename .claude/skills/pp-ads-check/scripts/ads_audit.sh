#!/bin/bash
#
# pp-ads-check / ads_audit.sh
#
# AdMob 接入只读静态扫描：快速收集平台配置、调用链与合规标记的事实证据。
# 本脚本只读取文件，不修改任何内容；输出供 agent 按 SKILL.md 流程继续人工审查。
#
# 用法:
#   bash ads_audit.sh <项目根目录>
#
# 退出码:
#   0  扫描正常完成（发现问题不影响退出码，结论由审查报告给出）
#   2  参数或目录错误

set -u

TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  echo "用法: bash ads_audit.sh <项目根目录>" >&2
  exit 2
fi
if [ ! -d "$TARGET" ]; then
  echo "错误：目录不存在: $TARGET" >&2
  exit 2
fi
TARGET="$(cd "$TARGET" && pwd)"

SRC_FILES="$(mktemp "${TMPDIR:-/tmp}/ads_audit.XXXXXX")"
trap 'rm -f "$SRC_FILES"' EXIT

# 收集源码与配置文件，排除依赖和构建产物，降低噪声。
find "$TARGET" -type f \
  \( -name '*.swift' -o -name '*.m' -o -name '*.mm' -o -name '*.h' \
     -o -name '*.kt' -o -name '*.java' \
     -o -name '*.dart' \
     -o -name '*.xml' -o -name '*.plist' \
     -o -name '*.gradle' -o -name '*.gradle.kts' \
     -o -name '*.yaml' -o -name '*.yml' \
     -o -name '*.html' -o -name '*.js' -o -name '*.ts' \
     -o -name 'Podfile' -o -name 'pubspec.yaml' -o -name 'pubspec.lock' \
     -o -name 'app-ads.txt' -o -name 'ads.txt' \) \
  ! -path '*/build/*' \
  ! -path '*/.dart_tool/*' \
  ! -path '*/Pods/*' \
  ! -path '*/.gradle/*' \
  ! -path '*/node_modules/*' \
  ! -path '*/DerivedData/*' \
  ! -path '*/.git/*' \
  2>/dev/null | sort > "$SRC_FILES"

if [ ! -s "$SRC_FILES" ]; then
  echo "未在 $TARGET 下发现可扫描的源码/配置文件。" >&2
  exit 2
fi

PASS_COUNT=0
WARN_COUNT=0
INFO_COUNT=0

section() {
  echo ""
  echo "==================================================================="
  echo "$1"
  echo "==================================================================="
}

# hit <扩展正则>  —— 在收集到的文件中查找，输出 文件:行号:内容
hit() {
  xargs grep -nE "$1" 2>/dev/null < "$SRC_FILES" || true
}

# has <扩展正则>  —— 仅判断是否存在
has() {
  xargs grep -lE "$1" 2>/dev/null < "$SRC_FILES" | head -n 1
}

ok()   { echo "  [PASS] $1"; PASS_COUNT=$((PASS_COUNT + 1)); }
warn() { echo "  [WARN] $1"; WARN_COUNT=$((WARN_COUNT + 1)); }
info() { echo "  [INFO] $1"; INFO_COUNT=$((INFO_COUNT + 1)); }

echo "==================================================================="
echo " pp-ads-check 静态扫描"
echo " 目标目录: $TARGET"
echo " 扫描文件数: $(wc -l < "$SRC_FILES" | tr -d ' ')"
echo " 说明: 本结果是事实收集，不等于最终合规结论；请按 SKILL.md 继续审查"
echo "==================================================================="

# ---------------------------------------------------------------------------
section "0. 项目类型识别"

IS_FLUTTER=0; IS_IOS=0; IS_ANDROID=0; IS_WEB=0

if find "$TARGET" -maxdepth 3 -name pubspec.yaml -print -quit 2>/dev/null | grep -q .; then
  IS_FLUTTER=1
  echo "  - 检测到 Flutter 项目（pubspec.yaml）"
fi
if find "$TARGET" -maxdepth 4 \( -name '*.xcodeproj' -o -name 'Podfile' \) -print -quit 2>/dev/null | grep -q .; then
  IS_IOS=1
  echo "  - 检测到 iOS 工程（xcodeproj / Podfile）"
fi
if find "$TARGET" -maxdepth 5 -name 'AndroidManifest.xml' -print -quit 2>/dev/null | grep -q .; then
  IS_ANDROID=1
  echo "  - 检测到 Android 工程（AndroidManifest.xml）"
fi
if [ "$(find "$TARGET" -maxdepth 3 -name '*.html' -print -quit 2>/dev/null)" ]; then
  IS_WEB=1
  echo "  - 检测到 Web 文件（*.html）"
fi
if [ "$IS_FLUTTER" -eq 0 ] && [ "$IS_IOS" -eq 0 ] && [ "$IS_ANDROID" -eq 0 ] && [ "$IS_WEB" -eq 0 ]; then
  warn "未能识别项目类型，请人工确认目录是否为项目根目录"
fi

# ---------------------------------------------------------------------------
section "1. SDK 依赖与版本（需对照官方最新版本）"

hit 'google_mobile_ads[[:space:]]*:' | sed 's/^/  /' || true
hit "pod[[:space:]]+['\"]Google-Mobile-Ads-SDK" | sed 's/^/  /' || true
hit 'GoogleMobileAds|GoogleUserMessagingPlatform' \
  | grep -E 'Podfile|\.podspec|project.pbxproj' | sed 's/^/  /' || true
hit 'com\.google\.android\.gms:google-services|play-services-ads|user-messaging-platform' \
  | sed 's/^/  /' || true
hit 'adsbygoogle' | sed 's/^/  /' || true
info "SDK 是否为受支持版本无法由脚本判定，请联网核对官方当前最低版本要求"

# ---------------------------------------------------------------------------
section "2. 平台配置项"

# ---- iOS ----
if [ "$IS_IOS" -eq 1 ] || [ "$IS_FLUTTER" -eq 1 ]; then
  echo "[iOS] GADApplicationIdentifier（App ID 必须配置在 Info.plist）"
  if hit 'GADApplicationIdentifier' | grep -q .; then
    hit 'GADApplicationIdentifier' | sed 's/^/  /'
    ok "存在 GADApplicationIdentifier 配置"
  else
    warn "未发现 GADApplicationIdentifier，iOS 侧启动会崩溃或无法拉取广告"
  fi

  echo "[iOS] SKAdNetworkItems（iOS 广告归因推荐配置）"
  if hit 'SKAdNetworkItems|SKAdNetworkIdentifier' | grep -q .; then
    ok "存在 SKAdNetwork 配置"
  else
    info "未发现 SKAdNetworkItems，建议按官方清单配置以保证归因与填充"
  fi

  echo "[iOS] NSUserTrackingUsageDescription（仅当代码实际请求 ATT 时必需）"
  if hit 'NSUserTrackingUsageDescription' | grep -q .; then
    ok "存在 ATT 用途描述"
  else
    if hit 'ATTrackingManager|requestTrackingAuthorization' | grep -q .; then
      warn "代码请求了 ATT 但缺少 NSUserTrackingUsageDescription，会崩溃或被拒"
    else
      info "未使用 ATT（不请求 IDFA 时无需配置）"
    fi
  fi
fi

# ---- Android ----
if [ "$IS_ANDROID" -eq 1 ] || [ "$IS_FLUTTER" -eq 1 ]; then
  echo "[Android] APPLICATION_ID meta-data（必须配置在 AndroidManifest.xml）"
  if hit 'com\.google\.android\.gms\.ads\.APPLICATION_ID' | grep -q .; then
    hit 'com\.google\.android\.gms\.ads\.APPLICATION_ID' | sed 's/^/  /'
    ok "存在 com.google.android.gms.ads.APPLICATION_ID 配置"
  else
    warn "未发现 APPLICATION_ID meta-data，Android 侧初始化会崩溃"
  fi
fi

# ---- Web AdSense ----
if [ "$IS_WEB" -eq 1 ]; then
  echo "[Web] AdSense 代码"
  hit 'adsbygoogle|data-ad-client' | sed 's/^/  /' || info "未发现 AdSense 代码"
fi

# ---------------------------------------------------------------------------
section "3. 初始化调用链（全局应只初始化一次）"

INIT_HITS="$(hit 'GADMobileAds\.sharedInstance\(\)\.start|MobileAds\.initialize|MobileAds\.instance\.initialize|MobileAds\.initialize\(')"
if [ -n "$INIT_HITS" ]; then
  echo "$INIT_HITS" | sed 's/^/  /'
  INIT_FILES="$(echo "$INIT_HITS" | cut -d: -f1 | sort -u | wc -l | tr -d ' ')"
  if [ "$INIT_FILES" -gt 1 ]; then
    warn "初始化出现在 $INIT_FILES 个文件中，请确认是否重复初始化（应全局一次）"
  else
    ok "初始化调用集中在单一文件"
  fi
else
  warn "未发现 Mobile Ads SDK 初始化调用"
fi

# ---------------------------------------------------------------------------
section "4. 隐私与同意（UMP / ATT / COPPA / TFUA / CCPA）"

check_presence() {
  local pattern="$1" label_ok="$2" label_miss="$3"
  local result
  result="$(hit "$pattern")"
  if [ -n "$result" ]; then
    echo "$result" | sed 's/^/  /'
    ok "$label_ok"
  else
    info "$label_miss"
  fi
}

echo "[UMP 欧盟用户意见征求（EEA/英国/瑞士市场必需）]"
check_presence \
  'UserMessagingPlatform|requestConsentInfoUpdate|ConsentInformation|loadAndShowConsentFormIfRequired|requestConsentInfoUpdate\(' \
  "检测到 UMP 同意征询相关代码" \
  "未检测到 UMP 代码；若上架 EEA/英国/瑞士市场，这是 P0 级缺失"

echo "[UMP 同意撤回入口（GDPR 要求可随时撤回）]"
check_presence \
  'privacyOptionsRequirementStatus|presentPrivacyOptionsForm|showPrivacyOptionsForm|UMPPrivacyOptions|privacy_options' \
  "检测到隐私选项/撤回同意入口" \
  "未检测到同意撤回入口，面向欧盟市场需要补充"

echo "[iOS ATT 请求]"
check_presence \
  'ATTrackingManager|requestTrackingAuthorization' \
  "检测到 ATT 请求" \
  "未检测到 ATT 请求（不使用 IDFA 时可接受）"

echo "[COPPA 儿童定向标记 tagForChildDirectedTreatment]"
check_presence \
  'tagForChildDirectedTreatment|TagForChildDirectedTreatment|setTagForChildDirectedTreatment|tag_for_child_directed_treatment' \
  "检测到儿童定向标记" \
  "未检测到儿童定向标记；若受众包含儿童或列入 Families 计划则为 P0"

echo "[TFUA 未达同意年龄标记]"
check_presence \
  'tagForUnderAgeOfConsent|TagForUnderAgeOfConsent|setTagForUnderAgeOfConsent|tag_for_under_age_of_consent|ageRestrictedTreatment' \
  "检测到 TFUA / ageRestrictedTreatment 相关代码" \
  "未检测到 TFUA；混合受众 App 需按已知用户年龄设置"

echo "[CCPA 受限数据处理 RDP（加州用户）]"
check_presence \
  'addRdpSignature|putRdp|setRdp|"rdp"|rdp_signals|RdpSignal' \
  "检测到 RDP 相关代码" \
  "未检测到 RDP 标记；面向加州用户需提供退出机制"

echo "[广告内容分级 maxAdContentRating]"
check_presence \
  'maxAdContentRating|MaxAdContentRating|max_ad_content_rating' \
  "检测到内容分级配置" \
  "未配置 maxAdContentRating（儿童/全家桶 App 建议设置）"

# ---------------------------------------------------------------------------
section "5. 测试设备与 demo 广告位 ID（发布版本红线）"

echo "[测试设备注册（开发期点击真实广告必须注册）]"
TESTDEV_HITS="$(hit 'testDeviceIdentifiers|setTestDeviceIds|testDeviceIds|kGADSimulatorID')"
if [ -n "$TESTDEV_HITS" ]; then
  echo "$TESTDEV_HITS" | sed 's/^/  /'
  ok "检测到测试设备配置"
else
  info "未检测到测试设备配置；若团队使用真机+正式广告位联调，存在无效流量风险"
fi

echo "[Google 官方 demo 广告位 ID（仅允许出现在 debug/测试代码）]"
DEMO_HITS="$(hit '3940256099942544/(6300978111|1033173712|2934735716|4365212315|2275389235|2247696110|9257395921|5224370425|1751052312|3945546436|5593931366|5354046379|9214589741)|3940256099942544~(3347511713|1458002511)')"
if [ -n "$DEMO_HITS" ]; then
  echo "$DEMO_HITS" | sed 's/^/  /'
  echo "$DEMO_HITS" | grep -qiE 'debug|test|mock|preview|dev' \
    && info "demo ID 部分位于疑似测试文件，仍需人工确认 release 构建不包含" \
    || warn "demo ID 未出现在明显的 debug/test 路径，重点确认是否会进入发布版本（P0 红线）"
else
  ok "未发现官方 demo 广告位 ID"
fi

echo "[项目中所有 ca-app-pub ID 分布（人工核对 App ID~/ 广告位 ID/、平台与环境）]"
ALLID_HITS="$(hit 'ca-app-pub-[0-9]+[/~][0-9]+')"
if [ -n "$ALLID_HITS" ]; then
  echo "$ALLID_HITS" | sed 's/^/  /'
  echo "$ALLID_HITS" | grep -oE 'ca-app-pub-[0-9]+[/~][0-9]+' | sort | uniq -c | sort -rn \
    | sed 's/^/  出现次数: /'
else
  warn "未发现任何 ca-app-pub ID，可能尚未接入或 ID 来自远端配置"
fi

# ---------------------------------------------------------------------------
section "6. 各广告格式调用链特征"

echo "[插屏 Interstitial：展示前应有 canPresent/就绪检查与关闭后重载]"
hit 'canPresent|canPresentAd|isLoaded|interstitialAd|InterstitialAd|GADInterstitialAd' \
  | grep -iE 'interstitial|插屏' | sed 's/^/  /' || true
if hit 'InterstitialAd\.load|GADInterstitialAd\.load|interstitialAd' | grep -q .; then
  if ! hit 'canPresent' | grep -q .; then
    warn "检测到插屏加载但未发现 canPresent 检查，展示已释放/未就绪广告会失败或违规"
  fi
fi

echo "[激励 Rewarded：奖励只应由用户获得回调或服务端校验(SSV)发放]"
hit 'onUserEarnedReward|userDidEarnReward|setOnUserEarnedRewardListener|serverSideVerification|ServerSideVerification|SSV|rewardedAd|GADRewardedAd|RewardedAd' \
  | sed 's/^/  /' || true
if hit 'RewardedAd\.load|GADRewardedAd\.load' | grep -q .; then
  if ! hit 'onUserEarnedReward|userDidEarnReward|OnUserEarnedReward' | grep -q .; then
    warn "检测到激励广告加载但未发现奖励获得回调，奖励发放可能被绕过"
  fi
  if ! hit 'erverSideVerification|SSV|customRewardData|userId' | grep -q .; then
    info "未配置服务端验证(SSV)，虚拟货币/高价值奖励建议接入以防刷奖励"
  fi
fi

echo "[开屏 App Open：注意不得遮挡其他广告、不得长时间阻塞内容]"
hit 'AppOpenAd|GADAppOpenAd|appOpenAd|app_open' | sed 's/^/  /' || true

echo "[原生 Native：必须保留广告标识与 AdChoices 图标]"
hit 'NativeAd|GADNativeAd|nativeAd|NativeAdLoader|AdChoices|adChoices' | sed 's/^/  /' || true

echo "[Banner：刷新必须由 SDK 控制，禁止自定义定时刷新]"
if hit 'Timer\.periodic|setInterval|scheduleAtFixedRate' | grep -qiE 'banner|ad'; then
  warn "发现疑似对 Banner 使用自定义定时刷新，属于政策违规，必须使用 SDK 刷新设置"
else
  ok "未发现明显的 Banner 自定义刷新逻辑"
fi

# ---------------------------------------------------------------------------
section "7. 运行环境与 WebView 高风险行为"

echo "[自动加载/展示/点击（无效流量高危模式）]"
AUTO_HITS="$(hit 'performClick|callOnClick|autoClick|auto_click|loadAd\(\).*show\(|\.show\(\).*load\(')"
if [ -n "$AUTO_HITS" ]; then
  echo "$AUTO_HITS" | sed 's/^/  /'
  warn "发现疑似自动点击/加载即展示代码，需人工确认是否构成无效流量（P0）"
else
  ok "未发现明显的自动点击模式"
fi

echo "[WebView 中加载 AdSense/AdMob（应用内 WebView 展示 AdSense 违规）]"
WEBVIEW_HITS="$(hit 'WKWebView|WebView|loadUrl|loadRequest' | grep -iE 'adsense|adsbygoogle|doubleclick|googlesyndication|admob')"
if [ -n "$WEBVIEW_HITS" ]; then
  echo "$WEBVIEW_HITS" | sed 's/^/  /'
  warn "WebView 相关代码出现广告域名/脚本，应用内 WebView 不得承载 AdSense 广告"
else
  ok "未发现 WebView 承载广告的明显证据"
fi

# ---------------------------------------------------------------------------
section "8. app-ads.txt / ads.txt"

APPADS="$(find "$TARGET" -name 'app-ads.txt' -o -name 'ads.txt' 2>/dev/null)"
if [ -n "$APPADS" ]; then
  echo "$APPADS" | sed 's/^/  /'
  echo "$APPADS" | while read -r f; do
    grep -nE 'google\.com,[[:space:]]*pub-[0-9]+,[[:space:]]*DIRECT,[[:space:]]*f08c47fec0942fa0' "$f" 2>/dev/null | sed "s|^|  $f:|" || true
  done
  info "仓库内存在 app-ads.txt/ads.txt，仍需确认部署在开发者域名根路径且发布者 ID 正确（需后台/线上确认）"
else
  info "仓库内未发现 app-ads.txt/ads.txt（通常部署在开发者域名，需线上确认 https://<开发者域名>/app-ads.txt）"
fi

# ---------------------------------------------------------------------------
section "扫描汇总"

echo "  PASS: ${PASS_COUNT}"
echo "  WARN: ${WARN_COUNT}（需逐项人工确认）"
echo "  INFO: ${INFO_COUNT}（提示与待后台确认项）"
echo ""
echo "下一步："
echo "  1. 按 SKILL.md Step 1 对照 references/platform-config-baseline.md 确认配置"
echo "  2. 按 Step 2 还原每个广告位的完整调用链"
echo "  3. 按 Step 3/4 完成政策与机型/无效流量审查，输出 P0/P1/P2 报告"
