#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# Fitapp Mobile-First bootstrap.
# Native Termux sdkmanager execution is intentionally avoided because Google
# Linux command-line tools expect a normal Linux userspace; on Android/Termux
# sdkmanager can abort during native registration (e.g. PerfettoTrace).
# Use the first supported Linux userspace exposed by the installed proot-distro.

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: Mobile-first path currently targets ARM64 (aarch64)."
  exit 2
fi

pkg update -y
pkg install -y git proot-distro

# Current Termux proot-distro builds may expose Ubuntu rather than Debian.
# Prefer Ubuntu 24.04; fall back to the generic Ubuntu alias if needed.
DISTRO=""
if proot-distro list | grep -q '^ubuntu:24.04'; then
  DISTRO="ubuntu:24.04"
elif proot-distro list | grep -q '^ubuntu'; then
  DISTRO="ubuntu"
fi

if [[ -z "$DISTRO" ]]; then
  echo "ERROR: No supported Ubuntu proot distribution is available in this Termux build."
  proot-distro list
  exit 3
fi

if ! proot-distro login "$DISTRO" -- true >/dev/null 2>&1; then
  echo "Installing $DISTRO proot distribution..."
  proot-distro install "$DISTRO"
fi

cat <<EOF

Mobile-first host bootstrap prepared.

Detected Linux userspace: $DISTRO

Next command:
  proot-distro login $DISTRO --shared-tmp

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
