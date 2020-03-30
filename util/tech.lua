TechName = "armor-absorb"
TechRegExp = "armor%-absorb%"
TechLevels = 25

if not TechHelper then TechHelper = {} end

function TechHelper.add_tech(level)
    local base = {
        type = "technology",
        name = TechName .. "-" .. level,
        icon = "__toxicPollution__/graphics/gas-time-research.png",
        icon_size = 128,
        effects = {
            {type = "nothing", effect_description={"Inc-absorb-armor"}}
        },
        unit = {
            count = level*10,
            ingredients = TechHelper.calc_ingredients(level),
            time = level*5
        },
        upgrade = true,
        order = "c-k-f-e"
    }
    if level > 1 then
        base.prerequisites = {"armor-absorb-"..(level - 1)}
    end
    data:extend({base})
end

function TechHelper.calc_ingredients(level)
    local res = {}
    local c = math.floor(level / 5)
    table.insert(res, {"automation-science-pack", 1})
    if (c > 0) then
        table.insert(res, {"logistic-science-pack", 1})
    end
    if (c > 1) then
        table.insert(res, {"military-science-pack", 1})
    end
    if (c > 2) then
        table.insert(res, {"chemical-science-pack", 1})
    end
    if (c > 3) then
        table.insert(res, {"production-science-pack", 1})
    end
    if (c > 4) then
        table.insert(res, {"utility-science-pack", 1})
    end
    return res
end