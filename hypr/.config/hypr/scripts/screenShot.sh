#!/usr/bin/env bash
set -euo pipefail

time=$(date "+%d-%b_%H-%M-%S")
PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
dir="$PICTURES_DIR/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

sDIR="$HOME/.config/hypr/scripts"

active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
active_window_file="Screenshot_${time}_${active_window_class}.png"
active_window_path="${dir}/${active_window_file}"

# Nerd icons: 󰹑 screenshot, 󰔟 timer, 󰀪 error
# No click actions — plain notify, no Open/Delete

notify_view() {
    if [[ "${1:-}" == "active" ]]; then
        if [[ -e "${active_window_path}" ]]; then
			"${sDIR}/sounds.sh" --screenshot >/dev/null 2>&1 &
            notify-send -t 5000 -h string:x-canonical-private-synchronous:shot-notify " 󰹑 Screenshot" " ${active_window_class} saved → ${active_window_path}"
        else
            notify-send -u low " 󰀪 Screenshot" " ${active_window_class} NOT saved"
            "${sDIR}/sounds.sh" --error >/dev/null 2>&1 &
        fi

    elif [[ "${1:-}" == "swappy" ]]; then
		"${sDIR}/sounds.sh" --screenshot >/dev/null 2>&1 &
		notify-send -t 5000 -h string:x-canonical-private-synchronous:shot-notify " 󰹑 Screenshot" "Captured — copied to clipboard"
		# optional: auto open swappy if wanted
		# swappy -f - <"$tmpfile" &

    else
        local check_file="${dir}/${file}"
        if [[ -e "$check_file" ]]; then
            "${sDIR}/sounds.sh" --screenshot >/dev/null 2>&1 &
            notify-send -t 5000 -h string:x-canonical-private-synchronous:shot-notify " 󰹑 Screenshot" "Saved → ${check_file}"
        else
            notify-send -u low " 󰀪 Screenshot" "NOT saved"
            "${sDIR}/sounds.sh" --error >/dev/null 2>&1 &
        fi
    fi
}

countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 " 󰔟 Taking shot" "in $sec secs"
		sleep 1
	done
}

shotnow() {
	cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shot5() {
	countdown '5'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shot10() {
	countdown '10'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shotwin() {
	w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
	w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
	cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
	notify_view
}

shotarea() {
	tmpfile=$(mktemp)
	grim -g "$(slurp)" - >"$tmpfile"

  # Copy with saving
	if [[ -s "$tmpfile" ]]; then
		wl-copy <"$tmpfile"
		mv "$tmpfile" "$dir/$file"
	fi
	notify_view
}

shotactive() {
    active_window_class=$(hyprctl -j activewindow | jq -r '(.class)')
    active_window_file="Screenshot_${time}_${active_window_class}.png"
    active_window_path="${dir}/${active_window_file}"

    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "${active_window_path}"
    notify_view "active"
}

shotswappy() {
	tmpfile=$(mktemp)
	grim -g "$(slurp)" - >"$tmpfile" 

  # Copy without saving
  if [[ -s "$tmpfile" ]]; then
		wl-copy <"$tmpfile"
    notify_view "swappy"
  fi
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

if [[ "${1:-}" == "--now" ]]; then
	shotnow
elif [[ "${1:-}" == "--in5" ]]; then
	shot5
elif [[ "${1:-}" == "--in10" ]]; then
	shot10
elif [[ "${1:-}" == "--win" ]]; then
	shotwin
elif [[ "${1:-}" == "--area" ]]; then
	shotarea
elif [[ "${1:-}" == "--active" ]]; then
	shotactive
elif [[ "${1:-}" == "--swappy" || "${1:-}" == "--swapp" || "${1:-}" == "--swap" ]]; then
	shotswappy
else
	echo -e "Available Options : --now --in5 --in10 --win --area --active --swappy (--swapp/--swap)"
fi

exit 0
