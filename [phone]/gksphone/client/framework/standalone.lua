if Config.Framework ~= "standalone" then
    return
end

--- Displays a framework notification.
--- @param text string The text to display in the notification.
--- @param notifType string The type of notification (e.g., "success", "error", "primary").
--- @param length number The length of time the notification should be displayed (in milliseconds).
function FreamworkNotification(text, notifType, length)
    notifType = notifType or "success"
    length = length or 5000
    Debugprint(text, notifType, length)
end

--- Gets the player's job information.
--- @return table
function GetInventory()
    return {}
end

function GetClosestPlayer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closestPlayers = GetPlayersInArea(coords)
    local closestDistance = -1
    local closestPlayer = -1
    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() and closestPlayers[i] ~= -1 then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))
        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end

function GetVehiclesInArea(pos, maxRadius)
    return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, pos, maxRadius)
end

function GetClosestVehicle(coords)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

function GetPlayersInArea(coords, distance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    distance = distance or 5
    local closePlayers = {}
    for _, player in ipairs(players) do
        local targetCoords = GetEntityCoords(GetPlayerPed(player))
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

function GetPlayerBankBalance()
    local money = 0
    return money

    -- Returns the player's bank balance.
    -- Uses a promise to handle the asynchronous callback from the server.
    --[[
        local p = promise.new()

        Config.Core.Functions.TriggerCallback('gksphone:server:getPlayerBankBalance', function(balance)
            local money = 0
            if balance then
                money = math.floor(balance * 100) / 100
            end
            p:resolve(money)
        end)
    
        return Citizen.Await(p)
    --]]
end

function VehicleCreate(model, coords, vehicleData)
    local createCar = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)
    SetVehicleOnGroundProperly(createCar)
    SetFuel(createCar, vehicleData?.fuel or 100)
    GiveKeyCar(createCar)
    SetModelAsNoLongerNeeded(model)
    return createCar
end