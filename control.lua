require("classes.toxic")

local inspect = require("inspect")

local toxic = Toxic()

script.on_init(function()
    toxic:init()
    toxic:initCommands()
end)

script.on_load(function()
    toxic:initCommands()
end)

script.on_configuration_changed(function()
    toxic:init()
    toxic:migrate(game.active_mods["toxicPollution"])
end)

script.on_event(defines.events.on_player_joined_game, function(event)
    toxic:init()
--    for name, version in pairs(game.active_mods) do
--        game.print(name .. " version " ..version)
--    end
    for _, item in pairs(game.item_prototypes) do
        if item.type == "armor" then
            if (item.resistances and item.resistances.toxin) then
                game.print(item.name)
                game.print(item.resistances.toxin.percent)
            end
        end
    end
end)

script.on_nth_tick(conf:TickInterval(), function(event)
    toxic:Run()
end)

script.on_event(defines.events.on_research_finished, function(event)
    local tech = event.research
    toxic:UpdateTech(tech.name, tech.force)
end)

--script.on_event(defines.events.on_player_used_capsule, function(event)
--    toxic:OnUseCapsule(event)
--end)