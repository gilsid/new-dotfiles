#!/usr/bin/env sh
set -eu
# Toggle hypridle freeze/thaw. Eye icon: crossed = idle active, normal = idle off.
# Off = kill -STOP (timer paused). On = restart hypridle (timers reset to 0).

pid=$(pgrep -x hypridle | head -n1)

idle_frozen() {
  [ -n "$pid" ] && [ "$(ps -o stat= -p "$pid" 2>/dev/null | cut -c1)" = "T" ]
}

state() {
  if idle_frozen; then
    printf '{"text":"","class":"off","tooltip":"Idle: disabled \\n Screen stays on"}\n'
  else
    printf '{"text":"","class":"on","tooltip":"Idle: active \\n Lock 5m / screen off 5.5m / suspend 15m"}\n'
  fi
}

case "${1:-}" in
  toggle)
    if idle_frozen; then
      # thaw → restart fresh so idle timers reset to 0
      pkill -CONT -x hypridle
      pkill -TERM -x hypridle
      sleep 0.3
      pgrep -x hypridle >/dev/null || hypridle >/dev/null 2>&1 &
    else
      pkill -STOP -x hypridle
    fi
    pkill -RTMIN+10 waybar
    ;;
  *) state ;;
esac
