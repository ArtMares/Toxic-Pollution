if not tp_util then tp_util = {} end

local neutral_flags = {"not-repairable", "not-blueprintable", "not-deconstructable", "placeable-off-grid", "not-on-map", "placeable-neutral"}

local function sticker_add_modifier(sticker, modifier)
    if modifier and type(modifier) == "table" then
        if modifier.target_movement then
            cast_modifier(sticker, "target_movement", modifier.target)
        end
        if modifier.vehicle_friction then
            cast_modifier(sticker, "vehicle_friction", modifier.vehicle_friction)
        end
        if modifier.vehicle_speed then
            cast_modifier(sticker, "vehicle_speed", modifier.vehicle_speed)
        end
    end
end

local function cast_modifier(entity, name, data)
    name = name .. "_modifier"
    if type(data) == "number" then
        entity[name] = data
        return
    end
    if type(data) == "table" then
        if data.value then
            entity[name] = data.value
        end
        if data.from then
            entity[name.."_from"] = data.from
        end
        if data.to then
            entity[name.."_to"] = data.to
        end
    end
end

tp_util.entity = {}

function tp_util.entity.add(name, tbl)
    if name == "" then
        error("Can't add entity. Name is empty")
        return
    end
    if tbl.type == "" then
        error("Can't add entity. Invalid type")
        return
    end
    tbl.name = name
    data:extend({tbl})
end

function tp_util.entity.set_resist(entity, name, decrease, percent)
    if entity.resistances then
        local resist = tp_util.tables.filter(entity.resistances, function(v)
            return v.type == name
        end)
        if resist ~= nil then
            resist.decrease = decrease
            resist.percent = percent
        else
            insert(entity.resistances, {type = name, decrease = decrease, percent = percent})
        end
    end
end

function tp_util.entity.add_sticker(name, tbl)
    if not tbl.duration or tbl.duration == 0 then
        error("Sticker \""..name.."\" duration must be > 0")
        return
    end
    local entity = {
        type = "sticker",
        flags = tbl.flags or neutral_flags,
        animation = tbl.animation,
        duration_in_ticks = tbl.duration
    }
    if tbl.fire then
        if tbl.fire.cooldown then
            entity.fire_spread_cooldown = tbl.fire.cooldown
        end
        if tbl.fire.radius then
            entity.fire_spread_radius = tbl.fire.radius
        end
        if tbl.fire.entity then
            entity.spread_fire_entity = tbl.fire.entity
        end
    end
    if tbl.force then
        if type(tbl.force) == "table" then
            tbl.force = tbl.force.name
        end
        entity.force_visibility = tbl.force
    end
    if tbl.modifier and type(tbl.modifier) == "table" then
        sticker_add_modifier(entity, tbl.modifier)
    end
    if tbl.stickers_per_square_meter then
        entity.stickers_per_square_meter = tbl.stickers_per_square_meter
    end
    if tbl.damage then
        entity.damage_per_tick = tbl.damage
    end
    if tbl.animation then
        entity.animation = tbl.animation
    end
    if tbl.single then
        entity.single_particle = tbl.single
    end
    return entity
end

function tp_util.entity.create_animation(data)
    if type(data) ~= "table" then
        error("Can't create entity animation. Need data table")
        return nil
    end
    if not data.frame or type(data.frame) ~= "table" then
        error("Can't create entity animation. Invalid frame data")
        return nil
    end
    local a = {
        filename = tp_entities_graphic_path..data.filename,
        frame_count = data.frame.count,
        width = data.frame.width,
        height = data.frame.height,
        line_length = data.frame.length,

    }
end