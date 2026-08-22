------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Primary laptop panel (1366x768). Fallback generic bawah handle ganti laptop / external monitor.
hl.monitor({
    output   = "eDP-1",
    mode     = "1366x768@59.97300",
    position = "0x0",
    scale    = "1",
})

-- Fallback: monitor apapun yang tidak match di atas pakai preferred auto
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

-- Workspaces
-- 1-5 persistent (selalu tampil di bar); 6-10 muncul hanya saat dipakai
-- NOTE: ikat ke eDP-1 jika ada, fallback generic akan handle monitor baru tanpa edit
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
