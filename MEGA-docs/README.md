# 🌈 PRISM OS v3.0 MEGA

The ultimate Arch-based distro with everything you need.

## ✨ What's Included

- **55+ Packages** - Steam, Discord, Spotify, VS Code, Blender, GIMP, OBS
- **5 GLSL Shaders** - Animated wallpapers (wave, matrix, aurora, particles, neon)
- **Glass UI** - i3 + Polybar + Picom + transparency
- **Auto-Install** - Graphical installer with drive detection
- **RTX 4060 Optimized** - NVIDIA drivers + performance tweaks

## 🚀 Quick Start

```bash
# Boot from USB, then:
install-prism    # Graphical installer
prism-setup      # First-time setup
prism-shader     # Change wallpaper shader
```

## 🎮 Included Apps

| Gaming | Creative | Dev | Media | Social |
|--------|----------|-----|-------|--------|
| Steam | Blender | VS Code | Spotify | Discord |
| Lutris | GIMP | Neovim | VLC | Telegram |
| Wine | Krita | Git | MPV | Signal |
| Gamemode | OBS | Docker | Strawberry | Element |

## 🌊 GLSL Wallpapers

- `wave.glsl` - Calm flowing waves
- `matrix.glsl` - Green code rain
- `aurora.glsl` - Northern lights
- `particles.glsl` - Floating lights
- `neon-grid.glsl` - Cyberpunk grid

## 📦 Build Your Own

```bash
git clone https://github.com/zapgaming/PRISM
cd PRISM
makepkg -si  # or use GitHub Actions
```

## 🛠️ System Specs

- **Base**: Arch Linux
- **WM**: i3-gaps
- **Compositor**: Picom (glx backend)
- **Bar**: Polybar
- **Launcher**: Rofi
- **Terminal**: Kitty
- **Shell**: Zsh with Oh-My-Zsh

## 🔥 Keybinds

| Key | Action |
|-----|--------|
| Super+Enter | Terminal |
| Super+D | App Launcher |
| Super+Shift+Q | Close Window |
| Super+1-9 | Switch Workspace |
| Super+Shift+R | Restart i3 |
| Super+F | Fullscreen |

## 💾 System Requirements

- 4GB RAM (8GB recommended)
- 20GB disk space
- NVIDIA/AMD/Intel GPU
- USB 2.0 port

## 🐛 Troubleshooting

| Issue | Fix |
|-------|-----|
| Black screen | Try `nomodeset` boot option |
| No WiFi | Check `iwlwifi` or `mt7921` drivers |
| Audio issues | `alsamixer` to unmute |
| High GPU usage | Switch to `picom --backend xrender` |

Made with 💜 by PRISM Team
