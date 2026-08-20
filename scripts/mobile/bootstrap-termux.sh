#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# Fitapp Mobile-First bootstrap for Termux.
# Design target: ARM64 Android phone, Termux, JDK 17+ (21 preferred), Android SDK, Gradle 8.13.
# Samsung Health SDK AAR is intentionally NOT downloaded automatically; it is proprietary.

SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/android-sdk}"
GRADLE_VERSION="8.13"
CMDLINE_TOOLS_VERSION="13114758"
CMDLINE_TOOLS_ZIP="commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip"
CMDLINE_TOOLS_URL="${CMDLINE_TOOLS_URL_OVERRIDE:-https://dl.google.com/android/repository/${CMDLINE_TOOLS_ZIP}}"

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: Mobile-first path currently targets ARM64 (aarch64)."
  exit 2
fi

pkg update -y
pkg install -y git wget unzip zip openjdk-21

export JAVA_HOME="$PREFIX/lib/jvm/java-21-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

java -version

# Fail closed if Java is unavailable or unexpectedly old.
JAVA_MAJOR="$(java -version 2>&1 | awk -F'[\".]' '/version/ {print $2; exit}')"
if [[ -z "$JAVA_MAJOR" || "$JAVA_MAJOR" -lt 17 ]]; then
  echo "ERROR: JDK 17+ is required; detected major version: ${JAVA_MAJOR:-unknown}"
  exit 3
fi

mkdir -p "$SDK_ROOT/cmdline-tools"
if [[ ! -x "$SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" ]]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  wget -O "$tmp/$CMDLINE_TOOLS_ZIP" "$CMDLINE_TOOLS_URL"
  unzip -q "$tmp/$CMDLINE_TOOLS_ZIP" -d "$tmp/tools"
  rm -rf "$SDK_ROOT/cmdline-tools/latest"
  mkdir -p "$SDK_ROOT/cmdline-tools/latest"
  cp -a "$tmp/tools/cmdline-tools/." "$SDK_ROOT/cmdline-tools/latest/"
fi

export ANDROID_SDK_ROOT="$SDK_ROOT"
export ANDROID_HOME="$SDK_ROOT"
export PATH="$SDK_ROOT/cmdline-tools/latest/bin:$SDK_ROOT/platform-tools:$SDK_ROOT/build-tools/35.0.0:$PATH"

yes | sdkmanager --licenses >/dev/null || true
sdkmanager "platform-tools" "platforms;android-36" "build-tools;35.0.0"

GRADLE_HOME="$HOME/gradle-$GRADLE_VERSION"
if [[ ! -x "$GRADLE_HOME/bin/gradle" ]]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  wget -O "$tmp/gradle.zip" "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
  rm -rf "$GRADLE_HOME"
  unzip -q "$tmp/gradle.zip" -d "$HOME"
fi
export PATH="$GRADLE_HOME/bin:$PATH"

gradle --version
sdkmanager --list_installed | sed -n '1,80p'

echo
echo "Mobile build environment ready."
echo "JAVA_HOME=$JAVA_HOME"
echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
echo "GRADLE_HOME=$GRADLE_HOME"
echo
echo "Next: download Samsung Health Data SDK v1.1.0, copy samsung-health-data-api.aar to poc/android/app/libs/, then run:"
echo "  cd <Fitapp>/poc/android"
echo "  gradle :app:assembleDebug"
