if not ToxicConfig then
    ToxicConfig = {
        ForceBaseValue = 1.0,
        TechBonus = 0.2
    }
end

function ToxicConfig.MinPollution()
    return settings.startup["min-pollution-to-damage"].value
end

function ToxicConfig.IsEquipRespiratorWhenRespawn(player)
    return settings.get_player_settings(player)["equip-respirator-when-respawn"].value
end