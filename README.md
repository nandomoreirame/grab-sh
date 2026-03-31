# grab-sh

Minimalist screenshot-to-clipboard script for Wayland/Hyprland.
Copies directly to clipboard, no files saved to disk.

---

## Dependencies

```bash
sudo pacman -S grim slurp wl-clipboard
```

---

## Installation

```bash
git clone https://github.com/nandomoreirame/grab-sh.git
cd grab-sh
./install.sh
```

This will:

1. Install dependencies (`grim`, `slurp`, `wl-clipboard`) via pacman
2. Create `~/.local/bin/` if needed
3. Symlink `grab.sh` to `~/.local/bin/grab`

---

## Usage

```bash
grab full       # Capture full screen to clipboard
grab area       # Select area with crosshair, copy to clipboard
grab --help     # Show help
```

---

## Hyprland Configuration

Add to your `~/.config/hypr/hyprland.conf`:

```ini
# Screenshots -> clipboard (no files saved)
bind = CTRL ALT, 3, exec, grab full
bind = CTRL ALT, 4, exec, grab area
```

Then reload the config:

```bash
hyprctl reload
```

---

## How It Works

| Shortcut     | Action                                            |
|--------------|---------------------------------------------------|
| CTRL+ALT+3   | Capture full screen -> clipboard                  |
| CTRL+ALT+4   | Open crosshair -> select area -> clipboard        |

- **No images are saved** to disk
- After capturing, just CTRL+V in any app
- The clipboard is overwritten on each new screenshot

---

## slurp Behavior (Area Selection)

- Click and drag to select the area
- `ESC` cancels without capturing
- Works across multiple monitors
