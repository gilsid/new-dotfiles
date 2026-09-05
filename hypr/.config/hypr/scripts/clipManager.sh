#!/usr/bin/env bash
set -euo pipefail
# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

rofi_theme="$HOME/.config/rofi/config-clipboard.rasi"
msg='👀 **note**  CTRL DEL = cliphist del (entry)   or   ALT DEL - cliphist wipe (all)'
# Actions:
# CTRL Del to delete an entry
# ALT Del to wipe clipboard contents

command -v rofi >/dev/null 2>&1 || { echo "clipManager: missing rofi" >&2; exit 1; }
command -v cliphist >/dev/null 2>&1 || { echo "clipManager: missing cliphist" >&2; exit 1; }
command -v wl-copy >/dev/null 2>&1 || { echo "clipManager: missing wl-copy" >&2; exit 1; }

if pidof rofi > /dev/null 2>&1; then
  pkill rofi
fi

# NOTE: jangan pakai `cliphist list | grep -q .` di sini — dengan pipefail,
# grep -q menutup pipe lebih awal, cliphist kena SIGPIPE (141) dan guard
# salah mengira history kosong. $() tidak kena masalah itu.
if [ -z "$(cliphist list 2>/dev/null || true)" ]; then
  exit 0
fi

while true; do
    result=""
    rofi_status=0
    result=$(
        rofi -i -dmenu \
            -kb-custom-1 "Control-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -config "$rofi_theme" < <(cliphist list) \
			-mesg "$msg"
    ) || rofi_status=$?

    case "$rofi_status" in
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    exit 0
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done

