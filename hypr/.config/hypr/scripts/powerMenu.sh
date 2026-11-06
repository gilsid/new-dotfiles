#!/usr/bin/env bash
set -euo pipefail

# Compact uptime ("3d 4h 12m") so the rofi pill never truncates
uptime=""
read -r secs _ < /proc/uptime 2>/dev/null || true
if [ -n "${secs:-}" ]; then
    secs="${secs%.*}"
    days=$((secs / 86400))
    hours=$((secs % 86400 / 3600))
    mins=$((secs % 3600 / 60))
    uptime="${days:+${days}d }${hours:+${hours}h }${mins}m"
else
    # Fallback: uptime -p (may truncate in the rofi window, better than nothing)
    uptime="$(uptime -p 2>/dev/null | sed -e 's/up //g')" || uptime=""
fi
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
