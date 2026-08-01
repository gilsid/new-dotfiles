hl.config({
    general = {
        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = true,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
    },

    master = {
        new_status = "master",
        mfact = 0.55,
        orientation = "left",
        smart_resizing = true,
        drop_at_cursor = true,
    },

    scrolling = {
        column_width = 0.80,
        fullscreen_on_one_column = true,
        direction = "right",
        follow_focus = true,
    },
})
