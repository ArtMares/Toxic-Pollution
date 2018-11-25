data:extend({
    {
        type = "armor",
        name = "respirator",
        icon = "__toxicPollution__/graphics/respirator.png",
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
    },
    {
        type = "capsule",
        name = "antitoxin",
        icon = "__toxicPollution__/graphics/icons/antitoxin.png",
        icon_size = 32,
        flags = {"goes-to-quickbar"},
        subgroup = "raw-resource",
        capsule_action =
        {
            type = "use-on-self",
            attack_parameters =
            {
                type = "projectile",
                ammo_category = "capsule",
                cooldown = 30,
                range = 0,
                ammo_type =
                {
                    category = "capsule",
                    target_type = "position",
                    action =
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                type = "damage",
                                damage = {type = "physical", amount = 0}
                            }
                        }
                    }
                }
            }
        },
        order = "h[antitoxin]",
        stack_size = 100
    }
})

local antitoxin = {
    type = "recipe",
    name = "antitoxin",
    category = "chemistry",
    enabled = true,
    ingredients = {},
    result = "antitoxin"
}

if mods["pycoalprocessing"] then
    antitoxin.ingredients = {
        {"fawogae-substrate", 2},
        {"ralesia-seeds", 2},
        {"coke", 1},
        {"flask", 1}
    }
else
    antitoxin.ingredients = {
        {"coal", 2},
        {"copper-plate", 2},
        {"iron-plate", 1}
    }
end

data:extend(
    {
        antitoxin
    }
)
