#!/usr/bin/env bash
set -euo pipefail

source /ctx/build/copr-helpers.sh

copr_install_isolated "ublue-os/packages" ublue-brew

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$('/home/linuxbrew/.linuxbrew/bin/brew' shellenv)"
fi

if [ -f /usr/share/ublue-os/homebrew/bling.Brewfile ] && command -v brew >/dev/null; then
  brew bundle --file=/usr/share/ublue-os/homebrew/bling.Brewfile || true
fi
