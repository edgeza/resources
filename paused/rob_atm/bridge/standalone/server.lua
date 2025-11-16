local bridge = {}

function bridge.registerItem(item, cb)
    RegisterCommand("use-"..item, function(src)
        cb(src)
    end, false)
end

return bridge
