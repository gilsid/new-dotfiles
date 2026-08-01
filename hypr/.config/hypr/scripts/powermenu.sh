#!/usr/bin/env sh

choice=$(printf "󰌾 Lock\n󰐥 Shutdown\n󰑐 Reboot\n󰤄 Suspend\n󰍃 Logout" |
rofi -dmenu -i -p "Power")

case "$choice" in
"󰌾 Lock")
hyprlock
;;
"󰐥 Shutdown")
systemctl poweroff
;;
"󰑐 Reboot")
systemctl reboot
;;
"󰤄 Suspend")
hyprlock && systemctl suspend
;;
"󰍃 Logout")
hyprctl dispatch exit
;;
esac
