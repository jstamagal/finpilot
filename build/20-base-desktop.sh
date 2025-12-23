#!/usr/bin/env bash
set -euo pipefail

source /ctx/build/copr-helpers.sh

dnf5 install -y \
  mesa-dri-drivers mesa-vulkan-drivers \
  libwayland-client libwayland-egl xorg-x11-server-Xwayland \
  libinput \
  pipewire pipewire-pulseaudio wireplumber \
  xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gnome \
  accountsservice polkit \
  google-noto-sans-fonts google-noto-emoji-fonts \
  alacritty fastfetch htop git curl wget \
  bash zsh fish

copr_install_isolated "che/nerd-fonts" nerd-fonts
