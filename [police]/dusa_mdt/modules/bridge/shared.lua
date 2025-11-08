core = nil
bridge = {}
lib.callback.register("dusa_mdt:hasItem", function(source, item, amount)
    return bridge.hasItem(source, item, amount)
end)

function bridge.getNearby()
    if not cache.ped then cache.ped = PlayerPedId() end
    local pedCoords = GetEntityCoords(cache.ped)
    local nearby = lib.getNearbyPlayers(pedCoords, 10) or getNearby(pedCoords, 10)
    return nearby
end