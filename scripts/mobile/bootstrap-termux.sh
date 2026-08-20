#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# Fitapp Mobile-First bootstrap.
# Native Termux sdkmanager execution is intentionally avoided because Google
# Linux command-line tools expect a Linux userspace; on Android/Termux the
# sdkmanager can abort in native registration (e.g. PerfettoTrace).
# We therefore bootstrap a Debian proot and run the Android build toolchain there.

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: Mobile-first path currently targets ARM64 (aarch64)."
  exit 2
fi

pkg update -y
pkg install -y git proot-distro

if ! proot-distro list | grep -q '^debian'; then
  echo "ERROR: Debian proot distribution is not available in this Termux build."
  exit 3
fi

if ! proot-distro login debian -- true >/dev/null 2>&1; then
  echo "Installing Debian proot distribution..."
  proot-distro install debian
fi

cat <<'EOF'

Mobile-first host bootstrap prepared.

Next command:
  proot-distro login debian --shared-tmp

Then inside Debian run:
  apt update
  apt install -y git curl wget unzip zip openjdk-21-jdk-headless ca-certificates

Then continue with the repository/toolchain setup documented in:
  docs/research/MOBILE_FIRST_DEVELOPMENT.md

Important:
- Do NOT run the Google Linux sdkmanager directly from native Termux.
- Keep the build inside Debian proot.
- The Samsung Health Data SDK AAR remains a separate proprietary download.
EOF
