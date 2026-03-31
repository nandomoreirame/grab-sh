#!/usr/bin/env bash
#
# grab.sh
# Screenshot to clipboard for Wayland/Hyprland (no file saved)
#
# Dependencies: grim, slurp, wl-clipboard, jq, hyprctl
#
# Usage:
#   grab full   - pick a window and capture it
#   grab area   - select area with crosshair
#   grab --help - show usage

set -euo pipefail

usage() {
  cat <<EOF
Usage: grab <command>

Commands:
  full    Pick a window and capture it to clipboard
  area    Select area with crosshair, copy to clipboard

Options:
  -h, --help    Show this help message

Dependencies: grim, slurp, wl-clipboard, jq

Suggested Hyprland binds:
  bind = CTRL ALT, 3, exec, grab full
  bind = CTRL ALT, 4, exec, grab area
EOF
}

case "${1:-}" in
  full)
    ACTIVE_WS="$(hyprctl activeworkspace -j | jq -r '.id')"
    WINDOWS="$(hyprctl clients -j | jq -r --argjson ws "${ACTIVE_WS}" '.[] | select(.mapped and .workspace.id == $ws) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
    grim -g "$(echo "${WINDOWS}" | slurp)" - | wl-copy --type image/png
    ;;
  area)
    grim -g "$(slurp)" - | wl-copy --type image/png
    ;;
  -h|--help)
    usage
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac
