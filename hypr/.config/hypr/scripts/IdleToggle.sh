#!/usr/bin/env sh
# Toggle hypridle freeze/thaw. Eye icon: crossed = idle active, normal = idle off.
# Off = kill -STOP (timer paused, resumes from remaining time on enable).

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
      pkill -CONT -x hypridle
    else
      pkill -STOP -x hypridle
      pgrep -x hypridle >/dev/null || hypridle &
    fi
    pkill -RTMIN+10 waybar
    ;;
  *) state ;;
esac
