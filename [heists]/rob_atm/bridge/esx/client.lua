local bridge = {}
local ESX = exports["es_extended"]:getSharedObject()

function bridge.notify(info)
    if info.type == "inform" then
        info.type = "info"
    end

    ESX.ShowNotification(info.description or info.title, info.type, info.duration)
end

return bridge
