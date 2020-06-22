ToxicPollution = {
    internal_name = "toxicPollution",
    title = "Toxic Pollution"
}
ToxicPollution.version = mods[ToxicPollution.internal_name]

function ToxicPollution.ModPath()
    return "__" .. ToxicPollution.internal_name .. "__/"
end

require(ToxicPollution.ModPath() .. "lib/paths")

color = require(tp_path .. "lib/color")

HFBML.LoadData(
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