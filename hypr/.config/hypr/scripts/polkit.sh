#!/usr/bin/env bash
set -euo pipefail
# Avoid duplicate agents (common with UWSM/session autostart)
_current_uid="${UID:-$(id -u)}"
if pgrep -u "$_current_uid" -f 'xfce-polkit|polkit-gnome-authentication-agent-1|polkit-kde-authentication-agent-1|polkit-mate-authentication-agent-1|mate-polkit|hyprpolkitagent' >/dev/null 2>&1; then
  echo "Polkit agent already running. Skipping start."
  exit 0
fi

# Ensure Qt apps default to Wayland in a Wayland session
if [ -n "${WAYLAND_DISPLAY:-}" ] && [ -z "${QT_QPA_PLATFORM:-}" ]; then
  export QT_QPA_PLATFORM=wayland
fi

# Avoid KDE polkit agent crashing if Kvantum QML module is missing
if [ -z "${QT_QUICK_CONTROLS_STYLE:-}" ]; then
  export QT_QUICK_CONTROLS_STYLE=Basic
fi

if [[ "${QT_STYLE_OVERRIDE:-}" == "kvantum" ]] || [[ "${QT_STYLE_OVERRIDE:-}" == "kvantum-dark" ]]; then
  if ! find /usr/lib /usr/lib64 /usr/share -type d -path "*/qml/*/kvantum" -print -quit 2>/dev/null | grep -q .; then
    echo "Kvantum QML module not found. Overriding QT_STYLE_OVERRIDE for Polkit to prevent crash."
    export QT_STYLE_OVERRIDE=Fusion
  fi
elif [ -z "${QT_STYLE_OVERRIDE:-}" ]; then
  export QT_STYLE_OVERRIDE=Fusion
fi

polkit=(
  "/usr/libexec/hyprpolkitagent"
  "/usr/lib/hyprpolkitagent"
  "/usr/lib/hyprpolkitagent/hyprpolkitagent"
  "/usr/bin/xfce-polkit"
  "/usr/lib/xfce4/polkit-agent/xfce-polkit"
  "/usr/libexec/xfce-polkit"
  "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
  "/usr/lib/polkit-gnome-authentication-agent-1"
  "/usr/libexec/polkit-gnome-authentication-agent-1"
  "/usr/libexec/polkit-mate-authentication-agent-1"
  "/usr/lib/polkit-mate/polkit-mate-authentication-agent-1"
  "/usr/bin/polkit-mate-authentication-agent-1"
  "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
  "/usr/lib/polkit-kde-authentication-agent-1"
  "/usr/libexec/polkit-kde-authentication-agent-1"
)

executed=false

# NixOS / PATH fallback dulu: kalau agent ada di PATH (nix store, /usr/local),
# pakai itu tanpa tergantung path FHS.
for agent in hyprpolkitagent xfce-polkit polkit-gnome-authentication-agent-1 polkit-mate-authentication-agent-1; do
  if command -v "$agent" >/dev/null 2>&1; then
    echo "Found: $agent ($(command -v "$agent")) — executing..."
    exec "$agent"
  fi
done

for file in "${polkit[@]}"; do
  if [ -e "$file" ] && [ ! -d "$file" ]; then
    echo "Found: $file — executing..."
    exec "$file"
  fi
done

if [ "$executed" = false ]; then
  echo "No valid Polkit agent found. Please install one."
fi
