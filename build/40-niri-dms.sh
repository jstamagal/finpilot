#!/usr/bin/env bash
set -euo pipefail

source /ctx/build/copr-helpers.sh

copr_install_isolated "avengemedia/danklinux" \
  quickshell-git \
  breakpad \
  matugen \
  danksearch \
  dgop \
  material-symbols-fonts \
  cliphist \
  dms-greeter

copr_install_isolated "yalter/niri-git" \
  niri
copr_install_isolated "avengemedia/dms-git" \
    dms dgop dsearch matugen dms-greeter

dnf5 install -y cliphist wl-clipboard cava qt6-qtmultimedia

dnf5 install -y greetd tailscale docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable greetd tailscaled docker.socket

systemctl set-default graphical.target

cat >/usr/lib/sysusers.d/10-docker-extra.conf <<'EOF'
g docker -
EOF
