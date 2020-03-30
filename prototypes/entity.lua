local neutral_flags = {"not-repairable", "not-blueprintable", "not-deconstructable", "placeable-off-grid", "not-on-map", "placeable-neutral"}

local math3d = require "math3d"

data:extend(
        {
            {
                type = "sticker",
                name = "toxic-alert",
                flags = neutral_flags,
                animation =
                {
                    filename = "__draw__/graphics/entity/toxic-alert-sticker.png",
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
            {
                type = "sticker",
                name = "toxic-sticker",
                flags = neutral_flags,
                animation =
                {
                    filename = "__draw__/graphics/entity/toxic-sticker.png",
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