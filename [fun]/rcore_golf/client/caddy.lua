AddTextEntry("RGOLF_CADDY_SPAWNED", Texts.caddySpawned)

function GetSuitableCaddySpawnLocation(locations)
    for _, caddyCoords in pairs(locations) do
        if IsPositionOccupied(caddyCoords.x, caddyCoords.y, caddyCoords.z, 3.0, false, true, false, false, false, 0, false) then
            return caddyCoords
        end
    end
    return locations[math.random(1, #locations)]
end

function SetCaddyBlipData(caddy, playerNum)
    caddyBlip = AddBlipForEntity(caddy)
    SetBlipSprite(caddyBlip, 225)
    SetBlipScale(caddyBlip, 0.6)
    SetBlipColour(caddyBlip, GetBallBlipColour(playerNum))
end

RegisterNetEvent("rcore_golf:spawnCaddy", function(playerNum, splitLocations, locationName)
    local vehicleHash = GetHashKey(Config.CaddyVehicleName)
    RequestModelAsync(vehicleHash)
    local vehicleCoords = GetSuitableCaddySpawnLocation(splitLocations)
    vehicleCaddy = CreateVehicle(vehicleHash, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleCoords.w, true, true)
    CaddyCreated = true
    ShowTimedHelpText("RGOLF_CADDY_SPAWNED", 7500)
    Citizen.SetTimeout(7500, function()
        CaddyCreated = false
    end)
    SetCaddyBlipData(vehicleCaddy, playerNum)
    vehicleCaddyNetId = NetworkGetNetworkIdFromEntity(vehicleCaddy)
    TriggerServerEvent("rcore_golf:setCaddyLocks", vehicleCaddyNetId, locationName)
end)