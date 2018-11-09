--local inspect = require("inspect")

local armorsToxin = {
    -- Base Mod
    {name = "ligth-armor", decrease = 0, percent = 10},
    {name = "heavy-armor", decrease = 0, percent = 30},
    {name = "modular-armor", decrease = 0, percent = 40},
    {name = "power-armor", decrease = 0, percent = 60},
    {name = "power-armor-mk2", decrease = 0, percent = 70},

    -- Power Armor MK3
    {name = "power-armor-mk3", decrease = 0, percent = 90},

    -- Bob Warface
    {name = "heavy-armor-2", decrease = 0, percent = 35},
    {name = "heavy-armor-3", decrease = 0, percent = 43},
    {name = "bob-power-armor-mk3", decrease = 0, percent = 30},
    {name = "bob-power-armor-mk4", decrease = 0, percent = 40},
    {name = "bob-power-armor-mk5", decrease = 0, percent = 50}
}

for _, resist in pairs(armorsToxin) do
    local items = data.raw.armor
    local armor = items[resist.name]
    if armor then
        table.insert(armor.resistances, {type = "toxin", decrease = resist.decrease, percent = resist.percent})
--        log(inspect.inspect(armor))
    end
end