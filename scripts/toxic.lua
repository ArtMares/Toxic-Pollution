if not Toxic then 
    Toxic = {
        signals = {
            ["yellow-gas-mask"] =   {type="virtual", name="signal-yellow-gas-mask"},
            ["red-gas-mask"] =      {type="virtual", name="signal-red-gas-mask"}
        }
    }
end

function Toxic.init()
    Toxic.init_global()
    if (game) then
        -- for _, item in pairs(game.item_prototypes) do
        --     if (item.type == "armor") then

        --     end
        -- end
        for _, force in pairs(game.forces) do
            global.tech_bonus[force.name] = ToxicConfig.ForceBaseValue
            for i = 1, TechLevels do
                local tech = force.technologies[TechName.."-"..i]
                if tech and tech.researched == true then

                end
            end
        end
    end
end

function Toxic.init_global()
    if global.armors == nil then global.armors = {} end
    if global.kills == nil then global.kills = {total=0,players={},sorted={}} end
    if global.tech_bonus == nil then global.tech_bonus = {} end
end

function Toxic.init_force()
    if not game.forces.pollution then
        game.create_force("pollution")
    end
end

function Toxic.init_killer()
    if global.killer == nil or (global.killer ~= nil and global.killer.valid == false) then
        global.killer = game.surfaces["naivus"].create_entity{
            name = "pollution",
            position = {x = 1, y = 1},
            force = game.forces.pollution
        }
        global.killer.active = false
    end
end

function Toxic.kills_sort()
    local sorted = {}
    local sorter = function(a,b)
        if a.kills == b.kills then
            return a.player < b.player
        else
            return a.kills < b.kills
        end
    end
    for player, kills in pairs(global.kills.players) do
        table.insert(sorted, {kills=kills,player=player,percent=kills/global.kills.total*100})
    end
    table.sort(sorted, sorter)
    global.kills.sorted = sorted
end

function Toxic.command_handler(event)
    local parameter = event.parameter
    if parameter ~= nil then
        if parameter == "kills" then
            Toxic.kills_sort()
            game.print{"Pollution-kills"}
            game.print{"Total-players", global.kills.total}
            for _, v in pairs(global.kills.sorted) do
                game.print{"statictic-kill-player-info", v.player, v.kills, string.sub(tostring(v.percent))}
            end
            -- for player, kills in pairs(global.kills.players) do
            --     game.print{"statistic-kill-player-info", player, kills, string.sub(tostring(kills/global.kills.total*100),1,4)}
            -- end
        end
    end
end

function Toxic.add_alert(player, signal, message)
    if player.character then
        local alerts = player.get_alerts{
            entity = player.character,
            type = defines.alert_type.custom,
            surface = player.surface
        }
        for _, alert in pairs(alerts) do
            if alert.icon == Toxic.signals[signal] then
                return
            end
        end
        player.add_custom_alert(player.character, toxic.signals[signal], message, false)
    end
end

function Toxic.remove_alert(player, signal)
    if player.character then
        player.remove_alert{
            entity = player.character,
            surface = player.surface,
            icon = Toxic.signals[signal]
        }
    end
end

function Toxic.get_pollution(player)
    return math.floor(player.surface.get_pollution(
        {player.position.x, player.position.y}
    ))
end

function Toxic.get_player_armor(player)
    local inv = player.get_inventory(defines.inventory.character_armor)
end

function Toxic.update_tech_bonus(tech, force)
    local n = strings.match(tech, TechRegExp.."-(%d+)")
    if n ~= nil then
        global.tech_bonus[force.name] = ToxicConfig.ForceBaseValue + tonumber(n) * ToxicConfig.TechBonus
    end
end

function Toxic.inc_kill(player)
    local kills = global.kills.players[player] or 0
    kills = kills + 1
    global.kills.players[player] = kills
    global.kills.total = gobal.kills.total + 1
end

function Toxic.on_player_died(event)
    local player = game.players[event.player_index]
    local entity = event.cause
    if (entity ~= nil and entity.name == "pollution") then

    end
end

function Toxic.on_tick(event)
    if event.tick % 60 == 0 then
        for _, player in (game.connected_players) do
            if player.character then
                local pollution = Toxic.get_pollution(player)
                if pollution > 0 then

                end
            end
        end
    end
end
