data:extend(
{
    {
        type = "int-setting",
        name = "armor-absorb-multiplier",
        setting_type = "startup",
        default_value = 5000,
        maximum_value = 100000,
        minimum_value = 100
    },
    {
        type = "double-setting",
        name = "min-pollution-to-damage",
        setting_type = "startup",
        default_value = 200,
        maximum_value = 1000,
        minimum_value = 100
    },
    {
        type = "bool-setting",
        name = "auto-equip-armor",
        setting_type = "startup",
        default_value = true
    }
}
)