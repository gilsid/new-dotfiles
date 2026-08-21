--------------------------------
---- WINDOW RULES ---------------
--------------------------------

-- Suppress maximize events
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix XWayland drags
hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false },
	no_focus = true,
})

-- Browser tagging
hl.window_rule({
	name = "tag-browser-firefox",
	match = { class = "^([Ff]irefox|org.mozilla.firefox)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-zen",
	match = { class = "^(zen-alpha|zen)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-chrome",
	match = { class = "^([Gg]oogle-chrome(-beta|-dev)?)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-chromium",
	match = { class = "^([Cc]hromium)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-brave",
	match = { class = "^([Bb]rave-browser(-beta|-dev)?)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-edge",
	match = { class = "^([Mm]icrosoft-edge-stable)$" },
	tag = "+browser",
})
hl.window_rule({
	name = "tag-browser-floorp",
	match = { class = "^([Ff]loorp)$" },
	tag = "+browser",
})

-- Code tagg
hl.window_rule({ name = "tag-code", match = { class = "^(antigravity|antigravity-ide|code|t3code|)$" }, tag = "+code" })

-- Terminal tag
hl.window_rule({
	name = "tag-terminal",
	match = { class = "^(Alacritty|kitty|ghostty|com\\.mitchellh\\.ghostty|wezterm)$" },
	tag = "+terminal",
})

-- Terminal opacity
hl.window_rule({
	name = "opacity-terminal",
	match = { class = "^(Alacritty|kitty|ghostty|com\\.mitchellh\\.ghostty|wezterm)$" },
	opacity = 0.8,
})

-- File manager tag
hl.window_rule({ name = "tag-file-manager", match = { class = "^([Tt]hunar)$" }, tag = "+file-manager" })

-- IM tag
hl.window_rule({ name = "tag-im-discord", match = { class = "^([Dd]iscord)$" }, tag = "+im" })
hl.window_rule({ name = "tag-im-telegram", match = { class = "^(org.telegram.desktop)$" }, tag = "+im" })

-- Multimedia tag
hl.window_rule({ name = "tag-multimedia", match = { class = "^([Aa]udacious)$" }, tag = "+multimedia" })

-- Screenshare
hl.window_rule({ name = "tag-screenshare-obs", match = { class = "^(com.obsproject.Studio)$" }, tag = "+screenshare" })

-- Float rules
hl.window_rule({ name = "float-zoom", match = { class = "^([Zz]oom)" }, float = true })
-- hl.window_rule({ name = "float-mpv",            match = { class = "^(mpv)$" },                   float = true })
hl.window_rule({ name = "float-qalculate", match = { class = "^([Qq]alculate-gtk)$" }, float = true })
hl.window_rule({
	name = "float-polkit",
	match = { class = "^(xfce-polkit|mate-polkit)$" },
	float = true,
	center = true,
})
hl.window_rule({
	name = "float-steam-dialogs",
	match = { class = "^([Ss]team)$" },
	float = true,
	center = true,
})
hl.window_rule({
	name = "float-bitwarden",
	match = { class = "^(Bitwarden)$" },
	float = true,
	center = true,
})

-- Picture-in-Picture
hl.window_rule({
	name = "PiP",
	match = { title = "^[Pp]icture%-in%-[Pp]icture$", class = "^([Ff]irefox|zen|org.mozilla.firefox)$" },
	float = true,
	pin = true,
	opacity = 0.95,
})

-- Multimedia: no blur, full opacity
hl.window_rule({ name = "media-no-blur", match = { tag = "multimedia" }, no_blur = true })
hl.window_rule({ name = "media-opacity", match = { tag = "multimedia" }, opacity = 1.0 })

-- Browser opacity
hl.window_rule({ name = "opacity-browser", match = { tag = "browser" }, opacity = 0.99 })

-- Idle inhibit for fullscreen
hl.window_rule({ name = "idle-inhibit", match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- Layer rules
hl.layer_rule({
	name = "notification-animations-swaync",
	match = { namespace = "swaync-control-center" },
	animation = "slide top",
})
hl.layer_rule({
	name = "notification-animations-rofi",
	match = { namespace = "rofi" },
	animation = "slide top",
	blur = true,
	ignore_alpha = 1,
})

-- Swaync notification window
hl.layer_rule({
	match = { namespace = "swaync-notification-window" },
	no_anim = false,
	order = 67,
})

-- [[ Workspace assignments (uncomment as needed) ]]
hl.window_rule({ name = "ws1-browser", match = { tag = "browser" }, workspace = "1" })
hl.window_rule({ name = "ws4-files", match = { tag = "file-manager" }, workspace = "4" })
-- hl.window_rule({ name = "ws6-virt",          match = { class = "virt-manager" },  workspace = "6 silent" })
hl.window_rule({ name = "ws7-im", match = { tag = "im" }, workspace = "7" })
hl.window_rule({ name = "ws8-code", match = { tag = "code" }, workspace = "8" })
hl.window_rule({ name = "ws9-multi", match = { tag = "multimedia" }, workspace = "9" })
hl.window_rule({ name = "ws10-screenshare", match = { tag = "screenshare" }, workspace = "10 silent" })
