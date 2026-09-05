#!/usr/bin/env bash
set -euo pipefail
# NOTE: bash disengaja — pakai printf \x00 (protokol ikon rofi) + process substitution,
# yang tidak portable di dash/POSIX sh.

SCRIPTSDIR="$HOME/.config/hypr/scripts"
# shellcheck source=/dev/null
. "$SCRIPTSDIR/wallpaperCmd.sh"

WALLDIR="$HOME/Pictures/wallpapers"

command -v rofi >/dev/null 2>&1 || { echo "wallpaperPicker: missing rofi" >&2; exit 1; }
command -v "$WWW_CMD" >/dev/null 2>&1 || { echo "wallpaperPicker: missing $WWW_CMD" >&2; exit 1; }

[ -d "$WALLDIR" ] || { echo "wallpaperPicker: $WALLDIR not found" >&2; exit 1; }

choice=""
# NOTE: input via < <(...) (bukan pipe) supaya status $? = status rofi saja.
# Kalau pakai `find | while read ... | rofi` + pipefail, `read` yang kena EOF
# selalu exit 1 dan meracuni status pipeline walau rofi sukses.
choice=$(rofi -dmenu -show-icons -p "Wallpaper" < <(
find "$WALLDIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.png" -o \
    -iname "*.jpeg" -o \
    -iname "*.webp" \) |
while IFS= read -r img; do
    printf "%s\x00icon\x1f%s\n" \
        "$(basename "$img")" \
        "$img"
done
)) || exit 0

[ -z "$choice" ] && exit 0

# Resolve basename -> full path dengan perbandingan literal (aman dari glob injection,
# benar saat dua subfolder punya nama file sama: ambil yang pertama).
wall=""
while IFS= read -r img; do
  if [ "$(basename "$img")" = "$choice" ]; then
    wall="$img"
    break
  fi
done < <(find "$WALLDIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.png" -o \
    -iname "*.jpeg" -o \
    -iname "*.webp" \))

[ -n "$wall" ] || { echo "wallpaperPicker: '$choice' not found" >&2; exit 1; }

pos=$(hyprctl cursorpos 2>/dev/null | tr -d ' ' || true)
[ -z "$pos" ] && pos="center"

if [ "$WWW_CMD" = "awww" ]; then
  awww img "$wall" \
    --transition-type grow \
    --transition-duration 0.8 \
    --transition-fps 60 \
    --transition-bezier .43,1.19,1,.4 \
    --transition-pos "$pos" \
    --invert-y
else
  # swww tidak punya --invert-y (itu flag awww), jadi cabangnya tanpa itu.
  "$WWW_CMD" img --transition-type grow \
    --transition-duration 0.8 \
    --transition-fps 60 \
    --transition-bezier .43,1.19,1,.4 \
    --transition-pos "$pos" \
    "$wall"
fi

WALLSTATE="$HOME/.config/hypr/wallpaper_effects"
mkdir -p "$WALLSTATE"

# Update current wallpaper symlink (global + per-monitor)
ln -sf "$wall" "$WALLSTATE/.wallpaper_current"
if command -v jq >/dev/null 2>&1; then
  mon_list=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' 2>/dev/null) || mon_list=""
else
  mon_list=$(hyprctl monitors 2>/dev/null | awk '/^Monitor/{print $2}') || mon_list=""
fi
for mon in $mon_list; do
  [ -n "$mon" ] || continue
  ln -sf "$wall" "$WALLSTATE/.wallpaper_current_${mon}"
done

# Update border colors from wallpaper
if command -v matugen >/dev/null 2>&1; then
  matugen image "$wall" --mode dark &
fi
