#!/usr/bin/env bash
set -euo pipefail
# Script is used by volume.sh and screenShot.sh

theme="freedesktop"
mute=false
directSoundDir="$HOME/.config/hypr/sounds"

muteScreenshots=false
muteVolume=false

if [[ "$mute" = true ]]; then
    exit 0
fi

if [[ "${1:-}" == "--screenshot" ]]; then
    if [[ "$muteScreenshots" = true ]]; then
        exit 0
    fi
    directSound="$directSoundDir/screenshot.ogg"
    soundoption="screen-capture.*"
elif [[ "${1:-}" == "--volume" ]]; then
    if [[ "$muteVolume" = true ]]; then
        exit 0
    fi
    directSound="$directSoundDir/volume.ogg"
    soundoption="audio-volume-change.*"
elif [[ "${1:-}" == "--error" ]]; then
    if [[ "$muteScreenshots" = true ]]; then
        exit 0
    fi
    directSound="$directSoundDir/error.ogg"
    soundoption="dialog-error.*"
else
    echo -e "Available sounds: --screenshot, --volume, --error"
    exit 0
fi

if [ -d "/run/current-system/sw/share/sounds" ]; then
    systemDIR="/run/current-system/sw/share/sounds" # NixOS
else
    systemDIR="/usr/share/sounds"
fi
userDIR="$HOME/.local/share/sounds"
defaultTheme="freedesktop"

# Prefer the user's theme, but use the system's if it doesn't exist.
sDIR="$systemDIR/$defaultTheme"
if [ -d "$userDIR/$theme" ]; then
    sDIR="$userDIR/$theme"
elif [ -d "$systemDIR/$theme" ]; then
    sDIR="$systemDIR/$theme"
fi

iTheme=""
if [ -f "$sDIR/index.theme" ]; then
  # grep exit 1 saat tidak ada baris Inherits + pipefail = assignment gagal,
  # jadi harus ditahan || agar tidak abort via set -e.
  iTheme=$(grep -i "inherits" "$sDIR/index.theme" | cut -d "=" -f 2) || iTheme=""
fi
iTheme="${iTheme:-$defaultTheme}"
iDIR="$sDIR/../$iTheme"

# Helper to play in the background (fast return).
play_sound() {
    if command -v paplay >/dev/null 2>&1; then
        paplay "${1:-}" >/dev/null 2>&1 &
        exit 0
    fi
    if command -v pw-play >/dev/null 2>&1; then
        pw-play "${1:-}" >/dev/null 2>&1 &
        exit 0
    fi
    if command -v aplay >/dev/null 2>&1; then
        aplay "${1:-}" >/dev/null 2>&1 &
        exit 0
    fi
    echo "Error: No suitable audio player found. Install paplay (pulseaudio-utils) or PipeWire/ALSA tools."
    exit 1
}

# If a direct sound file exists, play it immediately to avoid lookup delay.
if [[ -n "$directSound" && -f "$directSound" ]]; then
    play_sound "$directSound"
fi

sound_file=$(find -L "$sDIR/stereo" -name "$soundoption" -print -quit 2>/dev/null) || sound_file=""
if ! test -f "$sound_file"; then
    sound_file=$(find -L "$iDIR/stereo" -name "$soundoption" -print -quit 2>/dev/null) || sound_file=""
    if ! test -f "$sound_file"; then
        sound_file=$(find -L "$userDIR/$defaultTheme/stereo" -name "$soundoption" -print -quit 2>/dev/null) || sound_file=""
        if ! test -f "$sound_file"; then
            sound_file=$(find -L "$systemDIR/$defaultTheme/stereo" -name "$soundoption" -print -quit 2>/dev/null) || sound_file=""
            if ! test -f "$sound_file"; then
                echo "Error: Sound file not found."
                exit 1
            fi
        fi
    fi
fi
play_sound "$sound_file"
