ToxicPollution = {
    internal_name = "toxicPollution",
    title = "Toxic Pollution"
}
ToxicPollution.version = mods[ToxicPollution.internal_name]

function ToxicPollution.ModPath()
    return "__" .. ToxicPollution.internal_name .. "__/"
end

function ToxicPollution.LoadData(...)
    local args = {...}
    for _, prototype_type in ipairs(args) do
        require(prototype_type .. "init-data")
    end
end

function ToxicPollution.LoadDataUpdates(...)
    local args = {...}
    for _, prototype_type in ipairs(args) do
        require(prototype_type .. "init-data-update")
    end
end

function ToxicPollution.LoadDataFinal(...)
    local args = {...}
    for _, prototype_type in ipairs(args) do
        require(prototype_type .. "init-data-final")
    end
end

require(ToxicPollution.ModPath() .. "lib/paths")

color = require(tp_path .. "lib/color")

ToxicPollution.LoadData(
    tp_damages_path,
    tp_entities_path,
    tp_technologies_path
)

--require("util.table")
--
--require("prototypes.damage")
--require("prototypes.signals")
--require("prototypes.items")
--require("prototypes.tech")
--require("prototypes.pollution")
--require("prototypes.entity")