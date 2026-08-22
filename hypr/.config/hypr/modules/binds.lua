local term    = USER_CONFIG.terminal
local files   = USER_CONFIG.file_manager
local menu    = USER_CONFIG.launcher
local browser = USER_CONFIG.browser_cmd
local sDir    = os.getenv("HOME") .. "/.config/hypr/scripts"
local mainMod = "SUPER"

-- Wrap exec_cmd: hl.dsp.exec_cmd broken for complex cmds in 0.56.1
local function run(cmd)
    return function() hl.exec_cmd(cmd) end
end

-------------------------
--- WINDOW / SESSION ----
-------------------------
hl.bind(mainMod .. " + Return", run(term))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", run(sDir .. "/killActiveProcess.sh"))
hl.bind(mainMod .. " + B", run(browser))
hl.bind(mainMod .. " + A", run(menu))
hl.bind(mainMod .. " + E", run(files))
hl.bind(mainMod .. " + V", run(sDir .. "/clipManager.sh"))
hl.bind(mainMod .. " + SHIFT + E", run(sDir .. "/emojiPicker.sh"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + SPACE", run("systemctl suspend"))

-- Applications
hl.bind(mainMod .. " + T", run("Telegram"))
hl.bind(mainMod .. " + D", run('emacsclient -c -a ""'))

-- Group
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Tab", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.prev())

-- Toggle split (dwindle)
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))

-------------------------
--- MEDIA / HARDWARE ----
-------------------------
hl.bind("XF86AudioRaiseVolume", run(sDir .. "/volume.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", run(sDir .. "/volume.sh --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", run(sDir .. "/volume.sh --toggle"), { locked = true })
hl.bind("XF86AudioMicMute", run(sDir .. "/volume.sh --toggle-mic"), { locked = true })
hl.bind("XF86AudioPlay", run(sDir .. "/mediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPause", run(sDir .. "/mediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext", run(sDir .. "/mediaCtrl.sh --nxt"), { locked = true })
hl.bind("XF86AudioPrev", run(sDir .. "/mediaCtrl.sh --prv"), { locked = true })
hl.bind("XF86MonBrightnessUp", run("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", run("brightnessctl set 5%-"), { locked = true, repeating = true })

-------------------------
--- FOCUS / MOVE / RESIZE
-------------------------
hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + H",     hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + L",     hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + K",     hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. " + CTRL + J",     hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + ALT + H",     hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + L",     hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + K",     hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + J",     hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }))

-------------------------
--- WORKSPACES ---
-------------------------
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-------------------------
--- SCREEN ZOOM ---
-------------------------
hl.bind(mainMod .. " + SHIFT + mouse_up",   run(sDir .. "/zoom.sh --inc"))
hl.bind(mainMod .. " + SHIFT + mouse_down", run(sDir .. "/zoom.sh --dec"))
hl.bind(mainMod .. " + SHIFT + Z",          run(sDir .. "/zoom.sh --reset"))

-------------------------
--- SCREENSHOT ---
-------------------------
hl.bind("Print",         run(sDir .. "/screenShot.sh --now"), { locked = true })
hl.bind("SHIFT + Print", run(sDir .. "/screenShot.sh --area"), { locked = true })
hl.bind(mainMod .. " + Print",     run(sDir .. "/screenShot.sh --now"))
hl.bind(mainMod .. " + SHIFT + Print", run(sDir .. "/screenShot.sh --area"))

-------------------------
--- SYSTEM ---
-------------------------
hl.bind(mainMod .. " + P", run(sDir .. "/powerMenu.sh"))
hl.bind("CTRL + ALT + L", run(sDir .. "/lockScreen.sh"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + W", run(sDir .. "/wallpaperPicker.sh"))
