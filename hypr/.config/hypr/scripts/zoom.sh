#!/usr/bin/env bash
set -euo pipefail

# Screen magnifier built on Hyprland's native cursor zoom.
# Zooms the whole screen around the pointer position,
# no external app needed.

STEP=0.25
MAX=5

case "${1:-}" in
  --inc)    expr="[.float + $STEP, $MAX] | min" ;;
  --dec)    expr="[.float - $STEP, 1] | max" ;;
  --toggle) expr="if .float > 1 then 1 else 3 end" ;;
  *)        expr="1" ;;
esac

command -v hyprctl >/dev/null 2>&1 || { echo "zoom: missing hyprctl" >&2; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "zoom: missing jq" >&2; exit 1; }

new=""
new=$(hyprctl getoption cursor:zoom_factor -j 2>/dev/null | jq -r "$expr" 2>/dev/null) || new=""

if [[ -z "$new" || "$new" == "null" || ! "$new" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
  echo "zoom: failed to compute zoom factor" >&2
  exit 1
fi

# hyprctl keyword is broken for the Lua config parser (0.56+),
# so options are set at runtime through hyprctl eval instead.
hyprctl eval "hl.config({ cursor = { zoom_factor = $new } })" >/dev/null
