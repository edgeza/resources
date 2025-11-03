if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then
    return print('^3[DUSA HUNTING] ^1 ox_lib is not installed or can\'t reach it, please install it from https://github.com/overextended/ox_lib/releases. If you already have ox_lib, please open ticket ^0')
end

Framework.CreateUseableItem('hunting_license', function(source, item)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local identifier = Player.Identifier
    if hunting[identifier] then
        local coords = GetEntityCoords(GetPlayerPed(source))
        local nearbyPlayers = lib.getNearbyPlayers(coords, 10.0)
        if #nearbyPlayers > 0 then
            for _, player in pairs(nearbyPlayers) do
                TriggerClientEvent('dusa_hunting:showHuntingLicense', player.id, source)
            end
        end
    end
end)

local function placeableObjects(source, item)
    -- Handle item parameter - could be string or table
    local itemName
    if type(item) == 'table' then
        if item.name then
            itemName = item.name
        else
            Framework.Notify(source, 'Item name not found in table', 'error')
            return
        end
    else
        itemName = item
    end
    
    local placed = lib.callback.await('hunting:client:previewObject', source, itemName)
    if not placed then return end

    local Player = Framework.GetPlayer(source)
    if not Player then return end

    Framework.RemoveItem(source, itemName, 1)
end

local placedObjects = {}
local objects = require 'game.modules.placer.objects'

lib.callback.register('hunting:server:checkObjectOwnership', function(source, objectId)
    -- Check if this player owns this object
    return objects.checkOwnership(objectId, source)
end)

lib.callback.register('hunting:server:returnPlacedObject', function(source, item)
    local Player = Framework.GetPlayer(source)
    if not Player then return end
    
    if not item then
        Framework.AddItem(source, 'campfire', 1)
    else
        -- Handle item parameter - could be string or table
        local itemName
        if type(item) == 'table' then
            if item.name then
                itemName = item.name
            else
                Framework.Notify(source, 'Item name not found in table', 'error')
                return
            end
        else
            itemName = item
        end
        
        if placedObjects[source] and placedObjects[source][itemName] then
            Framework.AddItem(source, itemName, 1)
            Framework.AddItem(source, 'campfire', 1)
            placedObjects[source][itemName] = nil
        end
    end
end)

RegisterNetEvent('hunting:server:newPlacedItem', function(data)
    local src = source
    if not placedObjects[src] then placedObjects[src] = {} end
    placedObjects[src][data.item] = true
end)

Framework.CreateUseableItem('campfire', function(source, item)
    placeableObjects(source, item)
end)
Framework.CreateUseableItem('primitive_grill', function(source, item)
    placeableObjects(source, item)
end)
Framework.CreateUseableItem('advanced_grill', function(source, item)
    placeableObjects(source, item)
end)

Framework.CreateUseableItem('binocular', function(source, item)
    TriggerClientEvent('dusa_hunting:client:openBinocular', source)
end)

Framework.CreateUseableItem('hunting_bait', function(source, item)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local result = lib.callback.await('dusa_hunting:client:PlaceBait', source)
    if result then
        Framework.RemoveItem(source, item, 1)
    end
end)

Framework.CreateUseableItem('hunting_trap', function(source, item)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    Framework.RemoveItem(source, item, 1)
    TriggerClientEvent('hunting:client:PlaceTrap', source)
end)

if Shared.EnableDUILaptop then
    Framework.CreateUseableItem('hunting_laptop', function(source, item)
        local Player = Framework.GetPlayer(source)
        if not Player then return end

        TriggerClientEvent('hunting:client:openLaptop', source)
    end)
end
