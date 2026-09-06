------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Primary laptop panel (1366x768).
hl.monitor({
    output   = "eDP-1",
    mode     = "1366x768@59.97300",
    position = "0x0",
    scale    = "1",
})

-- Fallback: any monitor not matched above uses preferred auto
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

-- Workspaces
-- 1-5 persistent (always in the bar); 6-10 show only when used
-- NOTE: pinned to eDP-1; the generic fallback covers new monitors
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
