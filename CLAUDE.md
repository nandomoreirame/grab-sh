# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**grab** is a single Bash script for Wayland/Hyprland screenshot capture. Screenshots are copied directly to the clipboard without saving any files to disk.

## Script

`grab.sh` accepts a subcommand (`full` or `area`) and pipes `grim` output to `wl-copy --type image/png` using stdout (`-` flag) to avoid writing files. Area selection uses `slurp` for crosshair picking.

```bash
grab full       # full screen -> clipboard
grab area       # crosshair select -> clipboard
grab --help     # usage info
```

## Dependencies

System packages (Arch Linux): `grim`, `slurp`, `wl-clipboard`

```bash
sudo pacman -S grim slurp wl-clipboard
```

## Installation

Script goes into `~/.local/bin/` (or anywhere in `$PATH`) as `grab` with `+x` permission. Hyprland keybindings are configured in `~/.config/hypr/hyprland.conf`.

## Shell Standards

- Shebang: `#!/usr/bin/env bash`
- Error handling: `set -euo pipefail`
- Validate with `shellcheck` before committing
