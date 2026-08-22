hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_rate  = 35,
        repeat_delay = 200,

        follow_mouse = 1,
        sensitivity = 0,
        numlock_by_default = true,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            disable_while_typing = true,
        },

        touchdevice = {
            enabled = true,
        },
    },
})

hl.config({
    cursor = {
        -- software cursors render correctly while zoomed,
        -- hardware ones flicker / stay unscaled
        no_hardware_cursors = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
