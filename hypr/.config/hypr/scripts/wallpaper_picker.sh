#!/usr/bin/env sh

WALLDIR="$HOME/Pictures/wallpapers"

choice=$(
find "$WALLDIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.png" -o \
    -iname "*.jpeg" -o \
    -iname "*.webp" \) |
while read -r img; do
    printf "%s\x00icon\x1f%s\n" \
        "$(basename "$img")" \
        "$img"
done |
rofi -dmenu -show-icons -p "Wallpaper"
)

[ -z "$choice" ] && exit

wall=$(find "$WALLDIR" -type f -name "$choice" | head -n1)

awww img "$wall"

# Update current wallpaper symlink (global + per-monitor)
ln -sf "$wall" "$HOME/.config/rofi/.current_wallpaper"
for mon in $(hyprctl monitors -j | jq -r '.[].name'); do
  ln -sf "$wall" "$HOME/.config/rofi/.current_wallpaper_${mon}"
done

# Update border colors from wallpaper
matugen image "$wall" --mode dark &
