#!/usr/bin/env bash
#
# install.sh
# Installs grab and its dependencies on Arch Linux
#
# Usage: ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GRAB_SOURCE="${SCRIPT_DIR}/grab.sh"
GRAB_LINK="${HOME}/.local/bin/grab"

DEPS=(grim slurp wl-clipboard jq)
MISSING=()

for dep in "${DEPS[@]}"; do
  if ! command -v "${dep}" &>/dev/null; then
    MISSING+=("${dep}")
  fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo "==> Installing missing dependencies: ${MISSING[*]}"
  sudo pacman -S --needed --noconfirm "${MISSING[@]}"
else
  echo "==> All dependencies already installed"
fi

if [[ ! -d "${HOME}/.local/bin" ]]; then
  echo "==> Creating ~/.local/bin/"
  mkdir -p "${HOME}/.local/bin"
fi

chmod +x "${GRAB_SOURCE}"

if [[ -L "${GRAB_LINK}" ]] && [[ "$(readlink -f "${GRAB_LINK}")" == "${GRAB_SOURCE}" ]]; then
  echo "==> Symlink already exists: ${GRAB_LINK} -> ${GRAB_SOURCE}"
else
  echo "==> Symlinking ${GRAB_SOURCE} -> ${GRAB_LINK}"
  ln -sf "${GRAB_SOURCE}" "${GRAB_LINK}"
fi

echo "==> Done! Run 'grab --help' to get started."