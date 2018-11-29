require("util.class")

Config = class(function(self)
    self.name = "Config"
end)

function Config:MinPollution()
    return settings.startup["min-pollution-to-damage"].value
end

function Config:AbsorbMultiplier()
    return settings.startup["armor-absorb-multiplier"].value
end

function Config:IsAutoEquip()
    return settings.startup["auto-equip-armor"].value
end

function Config:ForceBaseValue()
    return 1.0
end

function Config:TechBonus()
    return 0.2
end

function Config:TickInterval()
    return 60
end