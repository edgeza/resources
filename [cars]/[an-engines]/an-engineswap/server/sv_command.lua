lib.addCommand('createzone', {
    help = 'create a new zone for engine swap',
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent("an-engineswap:client:creteZone", source)
end)

lib.addCommand('carsound', {
    help = 'engineswap',
    restricted = 'group.admin'
}, function(source, args, raw)
    local player = Core.GetOrCreatePlayer and Core.GetOrCreatePlayer(source) or (Core.Player and Core.Player[source])
    if not player then return end
    local job = player:getJob()
    TriggerClientEvent("an-engineswap:server:openengine", source,job)
end)

lib.addCommand('zonelist', {
    help = 'list all engine swap zones',
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent("an-engineswap:client:listCreatedZone", source)
end)

lib.addCommand('addsound', {
    help = 'add new sounds to swap engine list',
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent("an-engineswap:client:addSound", source)
end)

lib.addCommand('soundlist', {
    help = 'list all engine swap zones',
    restricted = 'group.admin'
}, function(source, args, raw)
    TriggerClientEvent("an-engineswap:client:listAllSound", source)
end)
