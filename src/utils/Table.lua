-- Taken from https://gist.github.com/qizhihere/cb2a14432d9bf65693ad?permalink_comment_id=4104319#gistcomment-4104319
function table.merge(table1, table2)
    if (table1 == nil) then
        return table2
    end
    if (table2 == nil) then
        return table1
    end

    for key, value in pairs(table2) do
        table1[key] = value
    end
    return table1
end

-- Taken from https://stackoverflow.com/a/27028488
local function toString(table)
    if (table == nil) then
        return "nil"
    end

    if type(table) == 'table' then
        local asString = '{ '
        for key, value in pairs(table) do
            if type(key) ~= 'number' then
                key = '"' .. key .. '"'
            end
            asString = asString .. '[' .. key .. '] = ' .. toString(value) .. ','
        end
        return asString .. '} '
    end

    return tostring(table)
end

function table.toString(table)
    return toString(table)
end