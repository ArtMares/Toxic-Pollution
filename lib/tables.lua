if not tp_util then tp_util = {} end

tp_util.tables = {}

local insert = table.insert

function tp_util.tables.find(tbl, func, ...)
    for k, v in pairs(tbl) do
        if func(v, k, ...) then
            return v, k
        end
    end
    return nil
end


function tp_util.tables.filter(tbl, func, ...)
    local newtbl = {}
    local add = #tbl > 0
    for k, v in pairs(tbl) do
        if func(v, k, ...) then
            if add then
                insert(newtbl, v)
            else
                newtbl[k] = v
            end
        end
    end
    return newtbl
end