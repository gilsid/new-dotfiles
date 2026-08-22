#!/usr/bin/env bash
set -euo pipefail

uptime="$(uptime -p | sed -e 's/up //g')"

lock=''
suspend=''
logout=''
reboot=''
shutdown=''

choice=$(printf "%s\n%s\n%s\n%s\n%s\n" "$lock" "$suspend" "$logout" "$reboot" "$shutdown" |
rofi -dmenu -i -p "Uptime: $uptime" -theme "$HOME/.config/rofi/powermenu.rasi")

case "$choice" in
"$lock")
    hyprlock
    ;;
"$shutdown")
    systemctl poweroff
    ;;
"$reboot")
    systemctl reboot
    ;;
"$suspend")
    systemctl suspend
    ;;
"$logout")
    hyprctl dispatch 'hl.dsp.exit()'
    ;;
esac
