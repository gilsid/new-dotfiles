#!/usr/bin/env bash
set -euo pipefail

uptime="$(uptime -p 2>/dev/null | sed -e 's/up //g')" || uptime=""
uptime="${uptime:-unknown}"

lock=''
suspend=''
logout=''
reboot=''
shutdown=''

choice=""
choice=$(printf "%s\n%s\n%s\n%s\n%s\n" "$lock" "$suspend" "$logout" "$reboot" "$shutdown" |
rofi -dmenu -i -p "Uptime: $uptime" -theme "$HOME/.config/rofi/powermenu.rasi") || exit 0

[ -z "$choice" ] && exit 0

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
    if ! hyprctl dispatch 'hl.dsp.exit()' 2>/dev/null; then
      hyprctl dispatch exit
    fi
    ;;
esac
