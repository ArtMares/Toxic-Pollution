local math3d = require "math3d"

data:extend(
    {
        {
            type = "sticker",
            name = "toxin-damage-effect",
            flags = {"not-on-map"},
            animation = {
                filename = tp_entities_graphic_path .. "toxic-damage-effect.png",
                line_length = 8,
                width = 60,
                height = 118,
                frame_count = 25,
                axially_symmetrical = false,
                direction_count = 1,
                blend_mode = "normal",
                animation_speed = 2,
                scale = 0.4,
                tint = {r = 0.161, g = 0.158, b = 0.005, a = 0.5},
                shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1)
            },
            duration_in_ticks = 61,
        }
    }
)