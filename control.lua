local minPollutionToDamage = settings.startup["min-pollution-to-damage"].value
local armorAbsorbMultiplicator = settings.startup["armor-absorb-multiplicator"].value
local stat = 7200

local floor = math.floor
local forceBaseValue = 1
local techBonus = 0.2

local SignalID = {
	["yellow-gas-mask"] = {type="virtual", name="signal-yellow-gas-mask"},
	["red-gas-mask"] = {type="virtual", name="signal-red-gas-mask"},
	["red-armor"] = {type="virtual", name="signal-red-armor"}
}

local function addAlert(player, signal, message)
	alerts = player.get_alerts{entity = player.character, type = defines.alert_type.custom, surface = player.surface}
	for _, alert in pairs(alerts) do
		if (alert.icon == SignalID[signal]) then
			return
		end
	end
	player.add_custom_alert(player.character, SignalID[signal], message, false)
end

local function removeAlert(player, signal)
	player.remove_alert{entity = player.character, surface = player.surface, icon = SignalID[signal]}
end

local function getPollution(player)
	return floor(player.surface.get_pollution({player.position.x, player.position.y}))
end

local function getEquipArmorCount(player)
	return player.get_inventory(defines.inventory.player_armor).get_item_count()
end

local function getEquipArmor(player)
	return player.get_inventory(defines.inventory.player_armor)[1]
end

local function equipArmor(inventory, armor)
	local isChanged = false
	local durability = global.armorMaxDurability
	local index = 0

	if (inventory ~= nil) then
		for i = 1, #inventory do
			local item = inventory[i]
			if (item.is_armor) then
				if (item.durability < durability) then
					durability = item.durability
					index = i
				end
			end
		end
	end
	if (index > 0) then
		armor.transfer_stack(inventory[index])
		isChanged = true
	end
	return isChanged
end

local function equipArmorFromInventory(player, armor)
	local checkInventory = {defines.inventory.player_main, defines.inventory.player_quickbar, defines.inventory.player_trash}
    if(armor.is_armor == false) then
		for _, inventoryType in pairs(checkInventory) do
			local res = equipArmor(player.get_inventory(inventoryType), armor)
			if (res) then
				break
			end
		end
		if (armor.is_armor) then
			player.print({"Destroyed-armor-replaced"})
		else
			player.print({"Armor-destroyed"})
		end
	end
end

local function initArmorAbsorbs()
	if (global.armorMaxDurability == nil) then
		global.armorMaxDurability = 0
	end
	if (global.armorsAbsorb == nil) then
		global.armorsAbsorb = {}
	end
	if (game) then
		for i, item in pairs(game.item_prototypes) do
			if (item.type == "armor") then
				if (global.armorMaxDurability < item.durability) then
					global.armorMaxDurability = item.durability
				end
				if (item.resistances and item.resistances.fire) then
					global.armorsAbsorb[item.name] = armorAbsorbMultiplicator*math.min(tonumber(string.format("%.2f", item.resistances.fire.percent)), 0.9)
				else
					global.armorsAbsorb[item.name] = 0
				end
			end
		end
	end
end

local function initTechAbsorbs()
	if (global.techAbsorb == nil) then
		global.techAbsorb = {}
	end
	if (game) then
		for _, force in pairs(game.forces) do
			global.techAbsorb[force.name] = forceBaseValue
			for _, tech in pairs(force.technologies) do
				n = string.match(tech.name, "respiration?-lifeTime?-(%d)")
				if n ~= nil then
					if (tech.researched == true) then
						local bonus = forceBaseValue + tonumber(n) * techBonus
						global.techAbsorb[force.name] = bonus
					end
				end
			end
		end
	end
end

script.on_init(function()
	initArmorAbsorbs()
	initTechAbsorbs()
end)

script.on_configuration_changed(function()
	initArmorAbsorbs()
	initTechAbsorbs()
end)

script.on_event({defines.events.on_player_joined_game}, function()
	initArmorAbsorbs()
	initTechAbsorbs()
end)

script.on_event(defines.events.on_tick, function(event)
	if (game.tick % 60 == 0) then
		
		for i, player in pairs(game.players) do
			if (player.connected == true and player.character ~= nil) then
				local armor = nil
				local alert = 0
				local pollution = getPollution(player)
				if (pollution > 0) then
					local absorb = minPollutionToDamage
					local armorCount = getEquipArmorCount(player)
					if (armorCount > 0) then
						armor = getEquipArmor(player)
						if (global.armorsAbsorb[armor.name] ~= nil) then
							absorb = absorb + global.armorsAbsorb[armor.name]
						end
					end
					if (pollution > absorb) then
						local damage = math.max(pollution - absorb, 0)/stat/global.techAbsorb[player.force.name]
						if (damage > 1) then
							alert = 2
						else
							alert = 1
						end
						if (armor) then
							if (armor.durability / game.item_prototypes[armor.name].durability < 0.1 and armorCount == 1) then
								alert = 3
							end
							armor.drain_durability(damage)
							equipArmorFromInventory(player, armor)
						else
							player.character.damage(damage, game.forces.neutral, "fire")
						end
					end
				end
				if (alert == 1) then
					addAlert(player, "yellow-gas-mask", {"High-pollution"})
				elseif (alert == 2) then
					addAlert(player, "red-gas-mask", {"Very-high-pollution"})
				elseif (alert == 3) then
					addAlert(player, "red-armor", {"Armor-worn-out"})
				else
					removeAlert(player, "yellow-gas-mask")
					removeAlert(player, "red-gas-mask")
					removeAlert(player, "red-armor")
				end
			end
		end
	end
end)

script.on_event(defines.events.on_research_finished, function(event)
	tech = event.research
	n = string.match(tech.name, "respiration?-lifeTime?-(%d+)")
	if n ~= nil then
		local bonus = forceBaseValue + tonumber(n) * techBonus
		global.techAbsorb[tech.force.name] = bonus
		tech.force.recipes["clock-dummy"].enabled = false
	end
end)

-- script.on_event(defines.events.on_force_created, function(event)
-- 	forceVars[event.force.name] = forceBaseVars
-- end)