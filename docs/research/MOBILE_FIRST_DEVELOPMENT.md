# Fitapp Mobile-First 개발환경

## 목적

Fitapp은 PC 사용 빈도가 낮은 환경을 고려하여 **Android 스마트폰에서 개발 → 빌드 → 설치 → Galaxy Fit3 검증**까지 가능한 Mobile-First workflow를 우선 검증한다.

PC는 예외적인 작업을 위한 선택사항으로 둔다.

## 현재 판정

`M0-MOBILE-FEASIBILITY = UNVERIFIED`

이 문서는 설계 결정이지 실기기 성공 증거가 아니다. 실제 휴대폰에서 아래 acceptance criteria를 실행한 뒤 판정한다.

## 기준 환경

- Android smartphone: ARM64/aarch64 권장
- Termux: 공식 GitHub/F-Droid 배포판 사용
- JDK: 17
- Android SDK command-line tools
- Android platform: API 36
- Android build-tools: 35.0.0
- Gradle: 8.13
- Samsung Health Data SDK: v1.1.0
- Samsung Health: 6.30.2+

AGP 8.13은 JDK 17과 Gradle 8.13을 요구한다. Android SDK command-line tools는 `sdkmanager`, build-tools 등을 제공하며 Android 앱은 Gradle wrapper/command line으로 빌드할 수 있다.

## Mobile workflow

```text
GitHub
  ↓
Termux
  ↓
JDK 17
  ↓
Android SDK
  ↓
Gradle 8.13
  ↓
Fitapp source
  ↓
Samsung Health Data SDK AAR
  ↓
assembleDebug
  ↓
APK install
  ↓
Samsung Health
  ↓
Galaxy Fit3
  ↓
Evidence
```

## Bootstrap

```bash
cd Fitapp
bash scripts/mobile/bootstrap-termux.sh
```

스크립트는 JDK/SDK/Gradle 환경만 준비한다. Samsung Health Data SDK의 proprietary AAR은 자동 다운로드하거나 Git에 저장하지 않는다.

## POC build

```bash
cd poc/android
```

Samsung Health Data SDK v1.1.0에서 제공되는 `samsung-health-data-api.aar`를 다음 위치에 둔다.

```text
poc/android/app/libs/samsung-health-data-api.aar
```

그 다음:

```bash
gradle :app:assembleDebug
```

APK 출력 위치:

```text
poc/android/app/build/outputs/apk/debug/app-debug.apk
```

## Acceptance Criteria

### AC-MOBILE-01
Given ARM64 Android smartphone and Termux,
When bootstrap script completes,
Then `java -version`, `sdkmanager --list_installed`, and `gradle --version` all succeed.

### AC-MOBILE-02
Given Samsung Health Data SDK AAR is present,
When `gradle :app:assembleDebug` runs,
Then a debug APK is produced.

### AC-MOBILE-03
Given the APK is installed on the same smartphone,
When the POC starts,
Then STEPS read permission can be requested and today's local step aggregation can be queried.

### AC-MOBILE-04
Given Galaxy Fit3 data has synchronized to Samsung Health,
When the POC enumerates `DeviceGroup.BAND`,
Then source device metadata is captured when exposed.

## Failure / fallback

- `SIG9` / process killed: reduce parallelism and memory pressure; investigate Android battery/background restrictions.
- SDK command-line tools incompatibility: use a compatible command-line-tools revision through `CMDLINE_TOOLS_URL_OVERRIDE`.
- Samsung AAR unavailable on phone: temporarily use PC only to acquire the SDK package; do not change product workflow until mobile acquisition is separately evaluated.
- Mobile build cannot compile the Samsung SDK: keep POC source unchanged, capture the exact build error, and perform RCA before changing the toolchain.

## Evidence required

- Git SHA
- phone model / Android version
- Termux version
- JDK version
- Gradle version
- Android SDK package list
- Samsung Health version
- APK SHA-256
- build log
- installation result
- permission result
- Fit3 source-device metadata
- local start/end timestamp
- step result
- Logcat excerpt

## Security / repository rule

- Never commit Samsung Health SDK AAR.
- Never commit personal health data, tokens, credentials, signing keys, or debug logs containing personal data.
- Do not treat a successful build as Fit3 compatibility evidence.
