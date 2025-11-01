table.including = function(t, k, v)
    for _, i in ipairs(t) do
        if i[k] == v then
            return true
        end
    end
    return false
end