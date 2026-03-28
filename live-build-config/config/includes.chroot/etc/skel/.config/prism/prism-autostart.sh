#!/bin/bash
# ⚡ PRISM OS 🌈
# Autostart Script - PRISMATIC SESSION
# ====================================

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Kill existing processes
killall -q picom polybar dunst swaync 2>/dev/null

# Wait for cleanup
sleep 0.3

# ═══════════════════════════════════════════════════════
#  STEP 1: LOAD PRISM THEME
# ═══════════════════════════════════════════════════════

# Generate colors from wallpaper
if [ -f ~/.config/prism/wallpaper.png ]; then
    wal -n -q -i ~/.config/prism/wallpaper.png &
fi

# ═══════════════════════════════════════════════════════
#  STEP 2: START COMPOSITOR (Picom - Glass + Animations)
# ═══════════════════════════════════════════════════════
picom --config ~/.config/picom/picom.conf --experimental-backends -b &
sleep 0.5

# ═══════════════════════════════════════════════════════
#  STEP 3: NOTIFICATIONS (swaync for better glass effect)
# ═══════════════════════════════════════════════════════
if command -v swaync &> /dev/null; then
    swaync &
else
    dunst -conf ~/.config/dunst/dunstrc &
fi

# ═══════════════════════════════════════════════════════
#  STEP 4: POLYBAR - THE PRISMATIC BAR
# ═══════════════════════════════════════════════════════
# Launch on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main 2>&1 | logger -t polybar-$m &
done

# ═══════════════════════════════════════════════════════
#  STEP 5: WALLPAPER
# ═══════════════════════════════════════════════════════
nitrogen --set-zoom-fill ~/.config/prism/wallpaper.png 2>/dev/null || \
    feh --bg-scale ~/.config/prism/wallpaper.png

# ═══════════════════════════════════════════════════════
#  STEP 6: EXTRAS
# ═══════════════════════════════════════════════════════

# Polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Clipboard manager
parcellite &

# X settings
xset b off
xset r rate 300 50
xsetroot -cursor_name left_ptr

# Network applet
nm-applet &

# Volume icon
pasystray -t 5 &

# ═══════════════════════════════════════════════════════
#  STEP 7: PRISM-WELCOME (First boot only)
# ═══════════════════════════════════════════════════════
if [ ! -f ~/.prism-welcomed ]; then
    touch ~/.prism-welcomed
    # Show welcome on first boot
    alacritty -e bash -c "
        echo -e '\n\033[1;36m⚡ Welcome to PRISM OS 🌈\033[0m\n' && 
        echo -e '\033[0;37mWelcome, traveler. Your prism awaits...\n\033[0m' &&
        echo 'Run prism-help for all commands' &&
        read -p 'Press Enter to continue...'
    " &
fi

echo "✨ PRISM OS is now glowing..."
