local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side events for towing system
RegisterNetEvent('olrp_towing:server:getTowRope', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        -- Log the action
        print(string.format('[OLRP Towing] Player %s (%s) got a tow rope', Player.PlayerData.name, Player.PlayerData.citizenid))
    end
end)

RegisterNetEvent('olrp_towing:server:attachTowRope', function(targetVehicle)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        -- Log the action
        print(string.format('[OLRP Towing] Player %s (%s) attached tow rope to vehicle %s', 
            Player.PlayerData.name, Player.PlayerData.citizenid, targetVehicle))
    end
end)

RegisterNetEvent('olrp_towing:server:detachTowRope', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        -- Log the action
        print(string.format('[OLRP Towing] Player %s (%s) detached tow rope', 
            Player.PlayerData.name, Player.PlayerData.citizenid))
    end
end)

-- Admin command to reset towing state
QBCore.Commands.Add('resettow', 'Reset towing state (Admin Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player and Player.PlayerData.job.name == 'admin' then
        TriggerClientEvent('olrp_towing:client:resetState', src)
        TriggerClientEvent('QBCore:Notify', src, 'Towing state reset!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to use this command!', 'error')
    end
end, 'admin')

-- Clean up on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('[OLRP Towing] Resource stopped - cleaning up...')
    end
end)
