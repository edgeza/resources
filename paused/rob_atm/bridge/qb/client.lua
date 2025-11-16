local bridge = {}
local QBCore = exports["qb-core"]:GetCoreObject()

function bridge.notify(info)
    if info.type == "inform" then
        info.type = "info"
    end

    QBCore.Functions.Notify({
        text = info.description,
        caption = info.title
    }, info.type, info.duration)
end

return bridge
