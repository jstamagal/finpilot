#!/usr/bin/env bash
set -euo pipefail

# Repo bootstrap: third-party and COPR prerequisites

# Ensure dnf5 is available and has COPR support
dnf5 install -y 'dnf5-command(copr)'

# Enable ublue-os packages COPR
dnf5 copr enable -y ublue-os/packages

# Ensure config-manager is available
command -v dnf5 >/dev/null

# Terra repository
DNF5_CMD=(dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release)
"${DNF5_CMD[@]}"

# Tailscale repository
curl -fsSL https://pkgs.tailscale.com/stable/fedora/tailscale.repo -o /etc/yum.repos.d/tailscale.repo

# VSCode repository
cat >/etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Docker CE repository
cat >/etc/yum.repos.d/docker-ce.repo <<'EOF'
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/fedora/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF

# COPR helper sourced later by scripts; no COPR enables here
