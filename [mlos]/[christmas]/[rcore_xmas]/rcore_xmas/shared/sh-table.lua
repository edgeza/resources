table.contains = function(list, element)
    for _, value in pairs(list) do
        if value == element then
            return true
        end
    end
    return false
end

table.containsIndexed = function(list, element)
    for index, value in ipairs(list) do
        if value == element then
            return true, index
        end
    end
    return false, nil
end

table.index_of = function(list, element)
    for index, value in pairs(list) do
        if value == element then
            return index
        end
    end
    return nil
end

table.remove_value = function(list, element)
    local index = table.index_of(list, element)
    if index then
        table.remove(list, index)
    end
end

table.merge = function(list1, list2)
    for _, value in pairs(list2) do
        table.insert(list1, value)
    end
end

table.merge_unique = function(list1, list2)
    for _, value in pairs(list2) do
        if not table.contains(list1, value) then
            table.insert(list1, value)
        end
    end
end

table.copy = function(list)
    local copy = {}
    for _, value in pairs(list) do
        table.insert(copy, value)
    end

    return copy
end

table.copyKeyValue = function(list)
    local copy = {}
    for key, value in pairs(list) do
        copy[key] = value
    end

    return copy
end

table.print = function(list)
    print(json.encode(list, { indent = true }))
end

table.size = function(list)
    local size = 0
    for _, _ in pairs(list) do
        size = size + 1
    end
    return size
end

table.empty = function(list)
    if list == nil then return true end
    return next(list) == nil
end

table.excluding = function(list, exclude)
    local excluding = {}
    for key, value in pairs(list) do
        if not table.containsIndexed(exclude, key) then
            excluding[key] = value
        end
    end

    return excluding
end

table.toIndexed = function(list)
    local indexed = {}
    for _, value in pairs(list) do
        table.insert(indexed, value)
    end

    return indexed
end

table.filter = function(list, filter)
    local filtered = {}
    for key, value in pairs(list) do
        if filter(key, value) then
            filtered[tostring(key)] = value
        end
    end

    return filtered
end
