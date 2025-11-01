local bridge = {}

function bridge.notify(info)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(info.title)
    EndTextCommandThefeedPostTicker(0, 1)
end

return bridge
