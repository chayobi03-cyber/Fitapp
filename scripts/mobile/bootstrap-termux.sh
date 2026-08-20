#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# Fitapp Mobile-First bootstrap.
# Native Termux sdkmanager execution is intentionally avoided because Google
# Linux command-line tools expect a normal Linux userspace; on Android/Termux
# sdkmanager can abort during native registration (e.g. PerfettoTrace).
# PRoot-Distro v5 uses Docker/OCI image references rather than a static distro
# registry, so do not infer availability from `proot-distro list`.

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: Mobile-first path currently targets ARM64 (aarch64)."
  exit 2
fi

pkg update -y
pkg install -y git proot-distro

DISTRO_IMAGE="${FITAPP_LINUX_IMAGE:-ubuntu:24.04}"
DISTRO_NAME="${FITAPP_LINUX_NAME:-ubuntu}"

if ! proot-distro login "$DISTRO_NAME" -- true >/dev/null 2>&1; then
  echo "Installing Linux userspace: $DISTRO_IMAGE"
  proot-distro install "$DISTRO_IMAGE" --name "$DISTRO_NAME"
fi

cat <<EOF

Mobile-first host bootstrap prepared.

Linux userspace image: $DISTRO_IMAGE
Container name: $DISTRO_NAME

Next command:
  proot-distro login $DISTRO_NAME --shared-tmp

Then inside the Linux userspace run:
  apt update
  apt install -y git curl wget unzip zip openjdk-21-jdk-headless ca-certificates

Then continue with the Android SDK / Gradle setup documented in:
  docs/research/MOBILE_FIRST_DEVELOPMENT.md

Important:
- Do NOT run the Google Linux sdkmanager directly from native Termux.
- Keep the Android build toolchain inside the Linux userspace.
- The Samsung Health Data SDK AAR remains a separate proprietary download.
EOF
