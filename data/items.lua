data:extend({
    {
        type = "armor",
        name = "respirator",
        icon = "__deadlyPollution__/graphics/respirator.png",
        icon_size = 64,
        flags = {"goes-to-main-inventory"},
        resistances = {
            {type = "physical",     decrease = 0, percent = 0},
            {type = "acid",         decrease = 0, percent = 0},
            {type = "explosion",    decrease = 0, percent = 0},
            {type = "fire",         decrease = 0, percent = 0},
            {type = "toxic",        decrease = 10, percent = 0}
        },
        durability = 500,
        subgroup = "armor",
        order = "f[hazard]",
        stack_size = 10
    },
    {
        type = "recipe",
        name = "respirator",
        enabled = true,
        ingredients = {
            {"iron-plate", 2},
            {"wood", 1},
            {"coal", 2}},
        result = "respirator"
    },
    -- For upgrade technology
    {
        type = "item",
        name = "clock-dummy",
        icon = "__deadlyPollution__/graphics/clock.png",
        icon_size = 64,
        flags = { "goes-to-main-inventory" },
        subgroup = "raw-material",
        order = "g[plastic-bar]-h[unused-air-filter]",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "clock-dummy",
        enabled = false,
        ingredients = {},
        result = "clock-dummy",
        energy_required = 0.2,
        hide = true
    },
})
