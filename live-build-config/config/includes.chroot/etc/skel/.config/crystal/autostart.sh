#!/bin/bash
# Crystal Linux Autostart Script

export PATH="$HOME/.local/bin:$PATH"

killall -q polybar picom dunst 2>/dev/null
sleep 0.3

# Glass compositor & animations
picom --config ~/.config/picom/picom.conf --experimental-backends &

# Notifications
dunst &

# Wallpaper
feh --no-fehbg --bg-scale ~/.config/crystal/wallpaper.png &

# Polybar
polybar --reload main &

# Extras
parcellite &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &