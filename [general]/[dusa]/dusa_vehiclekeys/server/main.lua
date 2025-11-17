if not rawget(_G, "lib") then include('ox_lib', 'init') end
-----------------------
----   Variables   ----
-----------------------
local VehicleList = {}
local AllVehicles = {}

-----------------------
----   Functions   ----
-----------------------
local function trimAndLowerPlate(plate)
    return string.lower(Framework.Trim(plate))
end

-----------------------
----   Threads     ----
-----------------------

-----------------------
---- Server Events ----
-----------------------

-- Event to give keys. receiver can either be a single id, or a table of ids.
-- Must already have keys to the vehicle, trigger the event from the server, or pass forcegive paramter as true.
RegisterNetEvent('dusa_vehiclekeys:server:GiveVehicleKeys', function(receiver, plate)
    local giver = source
    local givePlate = trimAndLowerPlate(plate)
    if HasKeys(giver, givePlate) then
        Framework.Notify(giver, Config.Language['notify']['vgkeys'], 'success')
        if type(receiver) == 'table' then
            for _, r in ipairs(receiver) do
                GiveKeys(receiver[r], givePlate)
            end
        else
            GiveKeys(receiver, givePlate)
        end
    else
        Framework.Notify(giver, Config.Language['notify']['ydhk'], 'error')
    end
end)

RegisterNetEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', function(plate)
    local taker = source
    local acquirePlate = trimAndLowerPlate(plate)
    GiveKeys(taker, acquirePlate)
end)

RegisterNetEvent('dusa_vehiclekeys:server:setVehLockState', function(vehNetId, state)
    local source = source
    local vehicle = NetworkGetEntityFromNetworkId(vehNetId)
    if not DoesEntityExist(vehicle) then return end
    
    -- Get vehicle plate and check if player has keys
    local plate = GetVehicleNumberPlateText(vehicle)
    if plate and plate ~= '' then
        local searchPlate = trimAndLowerPlate(plate)
        -- Only allow lock state change if player has keys or vehicle is not player-owned
        local playerOwned = VehicleList[searchPlate] ~= nil
        if playerOwned and not HasKeys(source, searchPlate) then
            return -- Reject unauthorized lock state changes
        end
    end
    
    SetVehicleDoorsLocked(vehicle, state)
end)

local storeState = nil
RegisterNetEvent('dusa-vehiclekeys:server:setVehLockState', function(vehNetId, state)
    local vehicleEntity = NetworkGetEntityFromNetworkId(vehNetId)
    if not DoesEntityExist(vehicleEntity) then return end
    state = (state == nil and not Entity(vehicleEntity).state['vehiclelockstate']) or state

    Entity(vehicleEntity).state:set('vehiclelockstate', state, true)
    -- storeState = Entity(vehicleEntity).state['vehiclelockstate']
    storeState = Entity(vehicleEntity).state['vehiclelockstate']

    SetVehicleDoorsLocked(NetworkGetEntityFromNetworkId(vehNetId), state)
end)

lib.callback.register('dusa_vehiclekeys:server:getVehLockState', function(vehNetId)
    local vehicleEntity = NetworkGetEntityFromNetworkId(vehNetId)
    return storeState
end)

lib.callback.register('dusa_vehiclekeys:server:GetVehicleKeys', function(source)
    local Player = Framework.GetPlayer(source)
    if not Player then return end
    local citizenid = Player.Identifier
    local keysList = {}
    for plate, citizenids in pairs(VehicleList) do
        if citizenids[citizenid] then
            keysList[plate] = true
            AllVehicles[#AllVehicles + 1] = AllVehicles[plate]
        end
    end
    return keysList, AllVehicles
end)

lib.callback.register('dusa_vehiclekeys:server:checkPlayerOwned', function(_, plate)
    local playerOwned = false
    local searchPlate = trimAndLowerPlate(plate)

    if VehicleList[searchPlate] then
        playerOwned = true
    end
    return playerOwned
end)

lib.callback.register('dusa_vehiclekeys:server:getAllVeh', function(_)
    return AllVehicles
end)

-----------------------
----   Functions   ----
-----------------------

function GiveKeys(id, plate)
    local citizenid = Framework.GetPlayer(id).Identifier

    local givePlate = trimAndLowerPlate(plate)

    if not VehicleList[givePlate] then VehicleList[givePlate] = {} end
    VehicleList[givePlate][citizenid] = true

    Framework.Notify(id, Config.Language['notify']['vgetkeys'], 'success')
    TriggerClientEvent('dusa_vehiclekeys:client:AddKeys', id, givePlate)
    return true
end
RegisterNetEvent('dusa_vehiclekeys:server:GiveKeys', GiveKeys)
exports('GiveKeys', GiveKeys)

function RemoveKeys(id, plate)
    local citizenid = Framework.GetPlayer(id).Identifier

    local removePlate = trimAndLowerPlate(plate)

    if VehicleList[removePlate] and VehicleList[removePlate][citizenid] then
        VehicleList[removePlate][citizenid] = nil
    end
    Framework.Notify(id, Config.Language['notify']['removedkey'], 'success')
    TriggerClientEvent('dusa_vehiclekeys:client:RemoveKeys', id, removePlate)
    return true
end
RegisterNetEvent('dusa_vehiclekeys:server:RemoveKeys', RemoveKeys)
exports('RemoveKeys', RemoveKeys)

function HasKeys(id, plate)
    local player = Framework.GetPlayer(id)
    local citizenid = player.Identifier

    local searchPlate = trimAndLowerPlate(plate)

    -- search for upper or lower?
    -- local plt = string.upper(QBCore.Shared.Trim(plate))
    if VehicleList[searchPlate] and VehicleList[searchPlate][citizenid] then
        return true
    end
    return false
end
lib.callback.register('dusa_vehiclekeys:server:HasKeys', function (source, plate)
    return HasKeys(source, plate)
end)
exports('HasKeys', HasKeys)

-- Server Events for the new API
RegisterNetEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', function(plate)
    local taker = source
    local acquirePlate = trimAndLowerPlate(plate)
    GiveKeys(taker, acquirePlate)
end)

RegisterNetEvent('dusa_vehiclekeys:server:GiveKeys', function(plate)
    local giver = source
    local givePlate = trimAndLowerPlate(plate)
    GiveKeys(giver, givePlate)
end)

RegisterNetEvent('dusa_vehiclekeys:server:RemoveKeys', function(plate)
    local remover = source
    local removePlate = trimAndLowerPlate(plate)
    RemoveKeys(remover, removePlate)
end)

RegisterNetEvent('dusa_vehiclekeys:server:errorreport', function(errcode, func)
    -- err codes = 1 and 2
    if errcode == 1 then
        print("^4[dusa_vehiclekeys] ^8ERROR! ^0Specified plate when integrating is not valid, Error Code - " .. errcode)
        print("^4[dusa_vehiclekeys] ^0The function causing this error - ^8" .. func .. "^0")
    elseif errcode == 2 then
        print(
            "^4[dusa_vehiclekeys] ^8ERROR! ^0Couldn't integrate vehicle key dynamically. It seems vehicle is not valid. Error Code - ",
            errcode)
        print("^4[dusa_vehiclekeys] ^0The function causing this error - ^8" .. func .. "^0")
    end
end)

RegisterServerEvent('dusa_vehiclekeys:sv:syncPlate', function(plate, status)
    local source = source
    if plate then
        local searchPlate = trimAndLowerPlate(plate)
        
        -- Check if player has keys to this vehicle before allowing lock state change
        if not HasKeys(source, searchPlate) then
            return -- Silently reject unauthorized lock state changes
        end

        if not AllVehicles[searchPlate] then AllVehicles[searchPlate] = {} end
        AllVehicles[searchPlate]['locked'] = status
    end
    GlobalState['vehiclekeys.allvehicles'] = AllVehicles
end)

local function dropExploiter()
    local player = Framework.GetPlayer(source)
    local name = player.Firstname .. ' ' .. player.Lastname
    local id = player.Identifier
    DropPlayer(source, 'Vehiclekeys exploit attempt')
    print('^3 VehicleKeys: ^1Exploiter detected, dropping connection: ^0' .. name .. ' (' .. id .. ')')
end
RegisterServerEvent('vehiclekeys:server:dropExploiter', dropExploiter)
