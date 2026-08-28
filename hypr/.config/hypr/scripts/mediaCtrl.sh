#!/usr/bin/env bash
set -euo pipefail

# Nerd icons: 󰎆 music, 󰐊 play, 󰏤 pause, 󰓛 stop

play_next() {
  playerctl next
  show_music_notification
}

play_previous() {
  playerctl previous
  show_music_notification
}

toggle_play_pause() {
  playerctl play-pause
  sleep 0.1
  show_music_notification
}

stop_playback() {
  playerctl stop
  notify-send -e -u low " 󰓛 Playback" "Stopped"
}

show_music_notification() {
  status=$(playerctl status 2>/dev/null || echo "Stopped")
  if [[ "$status" == "Playing" ]]; then
    song_title=$(playerctl metadata title 2>/dev/null || echo "Unknown")
    song_artist=$(playerctl metadata artist 2>/dev/null || echo "Unknown")
    notify-send -e -u low " 󰎆 Now Playing" "$song_title — $song_artist"
  elif [[ "$status" == "Paused" ]]; then
    notify-send -e -u low " 󰏤 Playback" "Paused"
  fi
}

case "${1:-}" in
"--nxt")
  play_next
  ;;
"--prv")
  play_previous
  ;;
"--pause")
  toggle_play_pause
  ;;
"--stop")
  stop_playback
  ;;
*)
  echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
  exit 1
  ;;
esac
