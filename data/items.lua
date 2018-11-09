data:extend({
    {
        type = "armor",
        name = "respirator",
        icon = "__toxinPollution__/graphics/respirator.png",
        icon_size = 64,
        flags = {"goes-to-main-inventory"},
        resistances = {
            {type = "physical",     decrease = 0, percent = 0},
            {type = "acid",         decrease = 0, percent = 0},
            {type = "explosion",    decrease = 0, percent = 0},
            {type = "fire",         decrease = 0, percent = 0},
            {type = "toxin",        decrease = 0, percent = 5}
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
    }
})
