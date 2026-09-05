#!/usr/bin/env bash
set -euo pipefail
# Start wallpaper daemon, preferring awww with swww fallback

SCRIPTSDIR="$HOME/.config/hypr/scripts"
# shellcheck source=/dev/null
. "$SCRIPTSDIR/wallpaperCmd.sh"

if command -v "$WWW_DAEMON" >/dev/null 2>&1 && command -v "$WWW_CMD" >/dev/null 2>&1 && ! pgrep -x "$WWW_DAEMON" >/dev/null 2>&1; then
  "$WWW_DAEMON" "${WWW_DAEMON_ARGS[@]}" &
fi

# Give the daemon a moment to become ready
for _ in {1..50}; do
  "$WWW_CMD" query >/dev/null 2>&1 && break
  sleep 0.1
done

wallpaper_link="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

read_cached_wallpaper() {
  local cache_file="$1"
  [ -f "$cache_file" ] || return 1
  awk 'NF && $0 !~ /^filter/ {print; exit}' "$cache_file"
}

get_monitors() {
  if command -v jq >/dev/null 2>&1; then
    hyprctl monitors -j | jq -r '.[].name'
  else
    hyprctl monitors | awk '/^Monitor/{print $2}'
  fi
}

apply_wallpaper_for_monitor() {
  local monitor="$1"
  local per_monitor_link="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current_${monitor}"
  local wallpaper_path=""

  # Prefer per-monitor symlink target if valid
  if [ -L "$per_monitor_link" ]; then
    local resolved
    resolved="$(readlink -f "$per_monitor_link")"
    if [ -n "$resolved" ] && [ -f "$resolved" ]; then
      wallpaper_path="$resolved"
    fi
  fi

  # Fall back to per-monitor file (non-symlink)
  if [ -z "$wallpaper_path" ] && [ -f "$per_monitor_link" ]; then
    wallpaper_path="$per_monitor_link"
  fi

  # Fall back to global
  if [ -z "$wallpaper_path" ] && [ -L "$wallpaper_link" ]; then
    local resolved_global
    resolved_global="$(readlink -f "$wallpaper_link")"
    if [ -n "$resolved_global" ] && [ -f "$resolved_global" ]; then
      wallpaper_path="$resolved_global"
    fi
  fi
  if [ -z "$wallpaper_path" ] && [ -f "$wallpaper_link" ]; then
    wallpaper_path="$wallpaper_link"
  fi

  # Last resort: use per-monitor cache
  if [ -z "$wallpaper_path" ]; then
    local cache_file="$WWW_CACHE_DIR/$monitor"
    local cache_fallback=""
    if [ "$WWW_CACHE_DIR" = "$HOME/.cache/awww" ]; then
      cache_fallback="$HOME/.cache/swww/$monitor"
    else
      cache_fallback="$HOME/.cache/awww/$monitor"
    fi
    wallpaper_path="$(read_cached_wallpaper "$cache_file")" || wallpaper_path=""
    if [ -z "$wallpaper_path" ] && [ -n "$cache_fallback" ]; then
      wallpaper_path="$(read_cached_wallpaper "$cache_fallback")" || wallpaper_path=""
    fi
  fi

# Set wallpaper per monitor. Flag target beda per backend:
# awww pakai -o, swww pakai --outputs (swww tidak kenal -o).
wallpaper_set_for_monitor() {
  local monitor="$1" resize_mode="$2" wallpaper_path="$3"
  if [ "$WWW_CMD" = "awww" ]; then
    "$WWW_CMD" img -o "$monitor" --resize "$resize_mode" "$wallpaper_path" >/dev/null 2>&1
  else
    "$WWW_CMD" img --outputs "$monitor" --resize "$resize_mode" "$wallpaper_path" >/dev/null 2>&1
  fi
}

  if [ -n "$wallpaper_path" ] && [ -f "$wallpaper_path" ]; then
    local resize_mode
    resize_mode="$(wallpaper_resize_mode "$wallpaper_path" "$monitor")"
    if ! wallpaper_set_for_monitor "$monitor" "$resize_mode" "$wallpaper_path"; then
      sleep 0.3
      wallpaper_set_for_monitor "$monitor" "$resize_mode" "$wallpaper_path" &
    fi
  fi
}

while read -r monitor; do
  [ -n "$monitor" ] || continue
  apply_wallpaper_for_monitor "$monitor" &
done < <(get_monitors)
wait

# Update border colors from current wallpaper
if command -v matugen >/dev/null 2>&1 && [ -L "$wallpaper_link" ]; then
  resolved_wall="$(readlink -f "$wallpaper_link" 2>/dev/null)" || resolved_wall=""
  [ -n "$resolved_wall" ] && [ -f "$resolved_wall" ] && matugen image "$resolved_wall" --mode dark &
fi
