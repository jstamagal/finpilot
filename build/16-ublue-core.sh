#!/usr/bin/env bash
set -euo pipefail

# Install core Universal Blue packages for system integration
dnf5 install -y \
    ublue-os-just \
    ublue-os-udev-rules \
    ublue-os-signing \
    ublue-polkit-rules \
    ublue-os-update-services \
    ublue-motd \
    ublue-fastfetch
