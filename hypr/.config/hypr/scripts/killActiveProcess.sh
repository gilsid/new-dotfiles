#!/usr/bin/env bash
set -euo pipefail

active_pid=""
if command -v jq >/dev/null 2>&1; then
  active_pid=$(hyprctl -j activewindow 2>/dev/null | jq -r '.pid // empty' 2>/dev/null) || active_pid=""
else
  active_pid=$(hyprctl activewindow 2>/dev/null | grep -o 'pid: [0-9]*' | cut -d' ' -f2) || active_pid=""
fi

if [[ -z "$active_pid" || ! "$active_pid" =~ ^[0-9]+$ ]]; then
  notify-send -u low " 󰀪 Kill Window" "No active window PID"
  exit 0
fi

if kill "$active_pid"; then
  notify-send -u low " 󰀪 Killed" "PID $active_pid"
else
  notify-send -u low " 󰀪 Kill Window" "Failed to kill PID $active_pid"
  exit 1
fi
