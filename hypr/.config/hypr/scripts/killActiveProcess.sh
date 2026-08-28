#!/usr/bin/env bash
set -euo pipefail

active_pid=$(hyprctl activewindow | grep -o 'pid: [0-9]*' | cut -d' ' -f2)

if [[ -z "$active_pid" || ! "$active_pid" =~ ^[0-9]+$ ]]; then
  notify-send -u low " 󰀪 Kill Window" "No active window PID"
  exit 1
fi

kill "$active_pid"
notify-send -u low " 󰀪 Killed" "PID $active_pid"
