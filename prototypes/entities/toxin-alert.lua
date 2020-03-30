data:extend(
    {
        {
            type = "sticker",
            name = "toxic-alert",
            flags = {"not-on-map"},
            animation = {
                filename = tp_entities_graphic_path.."toxic-alert.png",
                line_length = 8,
                width = 64,
                height = 64,
                frame_count = 12,
                axially_symmetrical = false,
                direction_count = 1,
                blend_mode = "normal",
                animation_speed = 0.2,
                scale = 0.4,
                run_mode = "forward",
                shift = {0, -1.5}
            },
            single_particle = true,
            duration_in_ticks = 61,
        },
    }
)