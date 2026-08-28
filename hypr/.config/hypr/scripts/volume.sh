#!/usr/bin/env bash
set -euo pipefail

sDIR="$HOME/.config/hypr/scripts"

# Nerd Font icons (JetBrainsMono Nerd Font) — no png needed, match waybar
# sink: 󰕿 low 󰖀 mid 󰕾 high 󰝟 mute
# mic : 󰍬 on  󰍭 muted

get_volume() {
    if [[ "$(pamixer --get-mute)" == "true" ]]; then
        echo "Muted"
        return
    fi

    local volume
    volume=$(pamixer --get-volume)
    if [[ "$volume" -eq 0 ]]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

get_icon() {
    if [[ "$(pamixer --get-mute)" == "true" ]]; then
        echo "󰝟"
        return
    fi

    current=$(pamixer --get-volume)
    if [[ "$current" -le 30 ]]; then
        echo "󰕿"
    elif [[ "$current" -le 60 ]]; then
        echo "󰖀"
    else
        echo "󰕾"
    fi
}

notify_user() {
    local muted="$(pamixer --get-mute)"
    local level="$(pamixer --get-volume)"
    local icon
    icon="$(get_icon)"

    if [[ "$muted" == "true" || "$level" -eq 0 ]]; then
        notify-send -e -h string:x-canonical-private-synchronous:volume_notif \
            -u low " $icon Muted"
    else
        notify-send -e -h int:value:"$level" -h string:x-canonical-private-synchronous:volume_notif \
            -u low " $icon Volume" " ${level}%"
        "$sDIR/sounds.sh" --volume 2>/dev/null &
    fi
}

inc_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        toggle_mute
    else
        pamixer -i "${1:-}" --allow-boost --set-limit 150 && notify_user
    fi
}

dec_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        toggle_mute
    else
        pamixer -d "${1:-}" && notify_user
    fi
}

toggle_mute() {
    if [ "$(pamixer --get-mute)" == "false" ]; then
        pamixer -m && notify-send -e -u low " 󰝟 Mute"
    elif [ "$(pamixer --get-mute)" == "true" ]; then
        pamixer -u && notify-send -e -u low " $(get_icon) Volume" "Unmuted"
    fi
}

toggle_mic() {
    if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
        pamixer --default-source -m && notify-send -e -u low " 󰍭 Microphone" "Muted"
    elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        pamixer --default-source -u && notify-send -e -u low " 󰍬 Microphone" "Unmuted"
    fi
}

get_mic_icon() {
    local muted="$(pamixer --default-source --get-mute)"
    local current="$(pamixer --default-source --get-volume)"
    if [[ "$muted" == "true" || "$current" -eq "0" ]]; then
        echo "󰍭"
    else
        echo "󰍬"
    fi
}

get_mic_volume() {
    if [[ "$(pamixer --default-source --get-mute)" == "true" ]]; then
        echo "Muted"
        return
    fi

    local volume
    volume=$(pamixer --default-source --get-volume)
    if [[ "$volume" -eq 0 ]]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

notify_mic_user() {
    local muted="$(pamixer --default-source --get-mute)"
    local level="$(pamixer --default-source --get-volume)"
    local icon

    if [[ "$muted" == "true" || "$level" -eq 0 ]]; then
        icon="󰍭"
        notify-send -e -h "string:x-canonical-private-synchronous:volume_notif" \
            -u low " $icon Mic" "Muted"
    else
        icon="󰍬"
        notify-send -e -h int:value:"$level" -h "string:x-canonical-private-synchronous:volume_notif" \
            -u low " $icon Mic" " ${level}%"
    fi
}

inc_mic_volume() {
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        toggle_mic
    else
        pamixer --default-source -i 5 && notify_mic_user
    fi
}

dec_mic_volume() {
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        toggle_mic
    else
        pamixer --default-source -d 5 && notify_mic_user
    fi
}

case "${1:-}" in
"--get")
  get_volume
  ;;
"--inc")
  inc_volume 5
  ;;
"--inc-precise")
  inc_volume 1
  ;;
"--dec")
  dec_volume 5
  ;;
"--dec-precise")
  dec_volume 1
  ;;
"--toggle")
  toggle_mute
  ;;
"--toggle-mic")
  toggle_mic
  ;;
"--get-icon")
  get_icon
  ;;
"--get-mic-icon")
  get_mic_icon
  ;;
"--mic-inc")
  inc_mic_volume
  ;;
"--mic-dec")
  dec_mic_volume
  ;;
*)
  get_volume
  ;;
esac
