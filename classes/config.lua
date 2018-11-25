require("util.class")

Config = class(function(self)
    self.minPollution = settings.startup["min-pollution-to-damage"].value
    self.absorbMultiplicator = settings.startup["armor-absorb-multiplicator"].value
    self.autoEquip = settings.startup["auto-equip-armor"].value
end)

function Config:MinPollution()
    return self.minPollution
end

function Config:AbsorbMultiplicator()
    return self.absorbMultiplicator
end

function Config:IsAutoEquip()
    return self.autoEquip
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