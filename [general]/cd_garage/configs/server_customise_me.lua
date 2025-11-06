-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            FRAMEWORK                             │
-- └──────────────────────────────────────────────────────────────────┘


ESX, QBCore = nil, nil

if Config.Framework == 'esx' then
    pcall(function() ESX = exports[Config.FrameworkTriggers.resource_name]:getSharedObject() end)
    if ESX == nil then
        TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
    end

elseif Config.Framework == 'qbcore' then
    TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
    end
end

function GetIdentifier(source)
    if not source then return end
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.identifier

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.PlayerData.citizenid

    elseif Config.Framework == 'other' then
        return GetPlayerIdentifiers(source)[1] --return your identifier here (string).

    end
end

function GetJob(source)
    if not source then return end
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.job.name

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.PlayerData.job.name

    elseif Config.Framework == 'other' then
        return 'unemployed' --return the players job name (string).

    end
end

function CheckMoney(source, amount, payment_type) --payment_type = What this payment is for. [ 'garage_space' / 'return_vehicle' / 'civ_unimpound' / 'transfer_garage' ] 
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getAccount('bank').money >= amount then
            xPlayer.removeAccountMoney('bank', amount)
            return true
        else
            return false
        end

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.PlayerData.money['bank'] >= amount then
            xPlayer.Functions.RemoveMoney('bank', amount, payment_type)
            return true
        else
            return false
        end

    elseif Config.Framework == 'other' then
        return false --check the players bank balance (boolean).
    end
end

function RemoveMoney(source, amount, payment_type) --payment_type = What this payment is for. [ 'garage_tax' ] 
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney('bank', amount)

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveMoney('bank', amount, 'Garage Payment')

    elseif Config.Framework == 'other' then
        --remove money from a player.
    end
end

function CheckPerms(source, action)
    if Config.StaffPerms[action].perms == nil then return false end
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local perms = xPlayer.getGroup()
        for c, d in pairs(Config.StaffPerms[action].perms[Config.Framework]) do
            if perms == d then
                return true
            end
        end

    elseif Config.Framework == 'qbcore' then
        local perms = QBCore.Functions.GetPermission(source)
        for c, d in pairs(Config.StaffPerms[action].perms[Config.Framework]) do
            if type(perms) == 'string' then
                if perms == d then
                    return true
                end
            elseif type(perms) == 'table' then
                if perms[d] then
                    return true
                end
            end
        end

    elseif Config.Framework == 'other' then
        return 'change_me' --return the players permissions (string).
    end
    return false
end

function GetCharacterName(source)
    if CharacterNames[source] then
        return CharacterNames[source]
    end

    local char_name = L('unknown')
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        char_name = xPlayer.getName(source)

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            if xPlayer.PlayerData.charinfo.firstname and xPlayer.PlayerData.charinfo.lastname then
                char_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
            end
        end

    elseif Config.Framework == 'other' then
        --get the players permissions (string).

    end
    CharacterNames[source] = char_name
    return char_name
end

function GetSourceFromIdentifier(identifier)
    if Config.Framework == 'esx' then
        local AllPlayers = ESX.GetPlayers()
        for cd = 1, #AllPlayers do
            local xPlayer = ESX.GetPlayerFromId(AllPlayers[cd])
            local xPlayer_identifier = GetIdentifier(xPlayer.source)
             if xPlayer_identifier and xPlayer_identifier == identifier then
                return xPlayer.source
            end
        end
    
    elseif Config.Framework == 'qbcore' then
        local AllPlayers = QBCore.Functions.GetPlayers()
        for cd = 1, #AllPlayers do
            local xPlayer = QBCore.Functions.GetPlayer(AllPlayers[cd])
            local xPlayer_identifier = GetIdentifier(xPlayer.PlayerData.source)
            if xPlayer_identifier and xPlayer_identifier == identifier then
                return xPlayer.PlayerData.source
            end
        end
    
    elseif Config.Framework == 'other' then
        --add your own code here.
    
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            CALLBACKS                             │
-- └──────────────────────────────────────────────────────────────────┘


RegisterServerEvent('cd_garage:Callback')
AddEventHandler('cd_garage:Callback', function(id, action, ...)
    local _source = source
    if action == 'mileage' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GetAdvStats(...))

    elseif action == 'onstreetscheck' then
        TriggerClientEvent('cd_garage:Callback', _source, id, OnStreetsCheck(...))

    elseif action == 'getallplayers' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GetAllPlayers(_source))

    elseif action == 'getimpounddata' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GetImpoundData(source, ...))

    elseif action == 'getallimpounddata' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GetAllImpoundData(...))

    elseif action == 'cancivretrivevehicle' then
        TriggerClientEvent('cd_garage:Callback', _source, id, CanCivRetriveVehicle(source, ...))

    elseif action == 'generate_new_plate' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GenerateRandomPlate())

    elseif action == 'search_vehicle_in_garage' then
        TriggerClientEvent('cd_garage:Callback', _source, id, SearchVehicleInGarage(...))

    elseif action == 'get_vehicle_info' then
        TriggerClientEvent('cd_garage:Callback', _source, id, GetVehicleInfo(...))

    elseif action == 'has_vehicle_already_spawned' then
        TriggerClientEvent('cd_garage:Callback', _source, id, HasVehicleAlreadySpawned(...))
    end
end)

CB = {}
local CB_id = 0

function Callback(source, action, ...)
    CB_id = CB_id + 1
    local id = CB_id

    TriggerClientEvent('cd_garage:Client:Callback', source, id, action, ...)
    Wait(10)

    local timeout = 0
    while CB[id] == nil and timeout <= 100 do
        Wait(0)
        timeout = timeout + 1
    end

    local res = CB[id]
    if res then
        CB[id] = nil
        return res
    else
        print(('Callback timed out: source=%s id=%d action=%s'):format(tostring(source), id, tostring(action)))
        return nil
    end
end

RegisterServerEvent('cd_garage:Client:Callback', function(id, result)
    CB[id] = result
    Wait(5000)
    CB[id] = nil
end)

function OnStreetsCheck(data)
    local result = nil
    local plate = GetCorrectPlateFormat(data.plate)
    for c, d in pairs(GetAllVehicles()) do
        if DoesEntityExist(d) then
            if GetCorrectPlateFormat(GetVehicleNumberPlateText(d)) == plate then
                local coords = GetEntityCoords(d)
                if data.shell_coords and GetVehicleEngineHealth(d) > 0 then
                    local dist = #(vector3(coords.x, coords.y, coords.z)-vector3(data.shell_coords.x, data.shell_coords.y, data.shell_coords.z))
                    if dist > 30 then
                        result = {result = 'onstreets', message = L('vehicle_onstreets'), coords = coords}
                        break
                    end
                elseif GetVehicleEngineHealth(d) > 0 then
                    result = {result = 'onstreets', message = L('vehicle_onstreets'), coords = coords}
                    break
                end
            end
        end
    end
    return result
end

function GetAllPlayers(source)
    local players = {}
    local AllPlayers = GetPlayers()
    for _, src in ipairs(AllPlayers) do
        src = tonumber(src)
        if src ~= source then
            players[#players+1] = {}
            if Config.PlayerListMethod == 'both' or Config.PlayerListMethod == 'charname' then
                players[#players].name = GetCharacterName(src)
            end
            players[#players].source = src
        end
    end
    return players
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              OTHER                               │
-- └──────────────────────────────────────────────────────────────────┘

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        if Config.Mileage.ENABLE then
            TriggerClientEvent('cd_garage:SaveAllMiles', -1)
        end
        if Config.Impound.ENABLE then
            TriggerEvent('cd_garage:SaveImpoundTimers')
        end
        if Config.VehicleKeys.ENABLE then
            TriggerClientEvent('cd_garage:SaveAllVehicleDamage', -1)
        end
        if Config.PersistentVehicles.ENABLE then
            TriggerEvent('cd_garage:SavePersistentVehicles')
        end
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    if Config.Mileage.ENABLE then
        TriggerClientEvent('cd_garage:SaveAllMiles', -1)
    end
    if Config.Impound.ENABLE then
        TriggerEvent('cd_garage:SaveImpoundTimers')
    end
    if Config.VehicleKeys.ENABLE then
        TriggerClientEvent('cd_garage:SaveAllVehicleDamage', -1)
    end
    if Config.PersistentVehicles.ENABLE then
        TriggerEvent('cd_garage:SavePersistentVehicles')
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if Config.Mileage.ENABLE then
        TriggerClientEvent('cd_garage:SaveAllMiles', -1)
    end
    if Config.Impound.ENABLE then
        TriggerEvent('cd_garage:SaveImpoundTimers')
    end
    if Config.VehicleKeys.ENABLE then
        TriggerClientEvent('cd_garage:SaveAllVehicleDamage', -1)
    end
    if Config.PersistentVehicles.ENABLE then
        TriggerEvent('cd_garage:SavePersistentVehicles')
    end
end)

RegisterServerEvent('cd_garage:DeleteVehicleADV')
AddEventHandler('cd_garage:DeleteVehicleADV', function(net)
    TriggerClientEvent('cd_garage:DeleteVehicleADV', source, net)
end)


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               DEBUG                              │
-- └──────────────────────────────────────────────────────────────────┘


RegisterServerEvent('cd_garage:Debug')
AddEventHandler('cd_garage:Debug', function()
    local _source = source
    print('^6-----------------------^0')
    print('^1CODESIGN DEBUG^0')
    print(string.format('^6Source:^0 %s', _source))
    print(string.format('^6Identifier:^0 %s', GetIdentifier(_source)))
    print(string.format('^6Character Name:^0 %s', GetCharacterName(_source)))
    print(string.format('^6Perms [add]:^0 %s', CheckPerms(_source, 'add')))
    print(string.format('^6Perms [delete]:^0 %s', CheckPerms(_source, 'delete')))
    print(string.format('^6Perms [plate]:^0 %s', CheckPerms(_source, 'plate')))
    print(string.format('^6Perms [keys]:^0 %s', CheckPerms(_source, 'keys')))
    print('^6-----------------------^0')
end)
