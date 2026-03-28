#!/bin/bash
# Download PRISM wallpapers from URLs

WALLPAPER_DIR="$HOME/.config/prism/wallpapers"
mkdir -p "$WALLPAPER_DIR"

echo "Downloading PRISM wallpapers..."

# Wallhaven images (public domain)
URLS=(
    "https://w.wallhaven.cc/full/x6/wallhaven-x6w1p2.png"  # Cyberpunk prisms
    "https://w.wallhaven.cc/full/vm/wallhaven-vm2p5p.jpg"  # Glass neon
    "https://w.wallhaven.cc/full/p9/wallhaven-p9w1x9.jpg"  # Crystal shards
)

for url in "${URLS[@]}"; do
    filename=$(basename "$url")
    echo "  → $filename"
    curl -L -s "$url" -o "$WALLPAPER_DIR/$filename" 2>/dev/null || true
done

echo "Done! Set wallpaper with: feh --bg-scale ~/.config/prism/wallpapers/FILE"
