lists = {}

function lists.length(list)
    local count = 0
    for _ in pairs(list) do
        count = count + 1
    end
    return count
end

function lists.filter(list, filterFunction)
    if (list == nil) then
        return {}
    end

    if (filterFunction == nil) then
        return list
    end

    local newList = {}
    for _, item in pairs(list) do
        if (filterFunction(item)) then
            table.insert(newList, item)
        end
    end
    return newList
end

function lists.find(list, findFunction)
    if (list == nil) then
        return nil
    end

    if (findFunction == nil) then
        return nil
    end

    for _, item in pairs(list) do
        if (findFunction(item)) then
            return item
        end
    end

    return nil
end

function lists.contains(list, valueToFind)
    local findResult = lists.find(
            list,
            function(item)
                return item == valueToFind
            end
    )
    return findResult ~= nil
end

function lists.toString(list)
    if (list == nil) then
        return "nil"
    end

    local asString = "["
    for _, item in pairs(list) do
        asString = asString .. item .. ","
    end
    return asString .. "]"
end

import "Lists-Test"