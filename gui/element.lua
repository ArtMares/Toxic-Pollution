local ElementGui = {
    classname = "ElementGui"
}

function ElementGui.addGuiLabel(parent, key, caption, style, tooltip, single_line)
    local options = {}
    options.type = "label"
    options.name = key
    options.caption = caption
    if style ~= nil then
        options.style = style
    end
    if tooltip ~= nil then
        options.tooltip = tooltip
    end
    local label = parent.add(options)
    if single_line ~= nil then
        label.style.single_line = single_line
    end
    return label
end

function ElementGui.getDisplaySize()
    local resolution = Player.native().display_resolution
    local scale = Player.native().display_scale
    return resolution.width/scale, resolution.height/scale
end