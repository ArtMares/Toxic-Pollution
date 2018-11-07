local function getIngridients(num)
	local res = {}
	local c = math.floor(num / 5)
	table.insert(res, {"science-pack-1", 1})
	if (c > 0) then
		table.insert(res, {"science-pack-2", 1})
	end
	if (c > 1) then
		table.insert(res, {"military-science-pack", 1})
	end
	if (c > 2) then
		table.insert(res, {"science-pack-3", 1})
	end
	if (c > 3) then
		table.insert(res, {"high-tech-science-pack", 1})
	end
	return res
end

data:extend({
	{
		type = "technology",
		name = "respiration-lifeTime-1",
		icon = "__deadlyPollution__/graphics/gas-time-research.png",
		icon_size = 128,
		effects = {
			{type = "unlock-recipe", recipe = "clock-dummy"}
		},
		unit = {
			count = 10,
			ingredients = getIngridients(1),
			time = 5
		},
		upgrade = true,
		order = "c-k-f-e"
	}
})

for i = 2, 25 do
	data:extend({
		{
			type = "technology",
			name = "respiration-lifeTime-"..i,
			icon = "__deadlyPollution__/graphics/gas-time-research.png",
			icon_size = 128,
			effects = {
				{type = "unlock-recipe", recipe = "clock-dummy"}
			},
			prerequisites = {"respiration-lifeTime-"..(i - 1)},
			unit = {
				count = i*10,
				ingredients = getIngridients(i),
				time = i*5
			},
			upgrade = true,
			order = "c-k-f-e"
		}
	})
end

-- 
--[[
data:extend({
	{
		type = "technology",
		name = "respiration-lifeTime-"..i,
		icon = "__deadlyPollution__/graphics/gas-time-research.png",
		icon_size = 128,
		effects = {
			{type = "unlock-recipe", recipe = "clock-dummy"}
		},
		unit = {
			count = i*10,
			ingredients = getIngridients(i),
			time = i*5
		},
		upgrade = true,
		order = "c-k-f-e"
	}
})
]]