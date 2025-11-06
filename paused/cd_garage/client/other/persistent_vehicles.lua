if Config.PersistentVehicles.ENABLE then

    RegisterNetEvent('cd_garage:PersistentVehicles_GetVehicleProperties')
    AddEventHandler('cd_garage:PersistentVehicles_GetVehicleProperties', function(plate, netid)
        TriggerServerEvent('cd_garage:PersistentVehicles_GetVehicleProperties', plate, GetVehicleProperties(NetworkGetEntityFromNetworkId(netid)))
    end)

    local RespawnWaitngList = 0
    RegisterNetEvent('cd_garage:PersistentVehicles_SpawnVehicle')
    AddEventHandler('cd_garage:PersistentVehicles_SpawnVehicle', function(data)
        while RespawnWaitngList > 0 do Wait(100) end
        RespawnWaitngList = RespawnWaitngList + 1
        ExitLocation = {x = data.coords.x, y = data.coords.y, z = data.coords.z, h = data.heading}
        -- Prevent persistent spawn if parked at Patreon-only and vehicle not in tier
        local allowed = true
        if Config.PatreonTiers and Config.PatreonTiers.ENABLE then
            local appearsInAny = false
            local minTier = nil
            for t, tierData in pairs(Config.PatreonTiers.tiers or {}) do
                local list = (tierData and tierData.vehicles) or {}
                for i = 1, #list do
                    if tostring(list[i]):upper() == tostring(data.props and data.props.model or ''):upper() then
                        appearsInAny = true
                        minTier = (minTier and math.min(minTier, t)) or t
                    end
                end
            end
            if appearsInAny then
                local p = QBCore and QBCore.Functions.GetPlayerData() or nil
                local md = p and p.metadata or {}
                local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                local tier = md and md[key]
                local tierNum = 0
                if type(tier) == 'number' then tierNum = tier elseif type(tier) == 'string' then tierNum = tonumber(tier) or 0 end
                allowed = (Config.PatreonTiers.inherit ~= false) and (tierNum >= (minTier or 1)) or (tierNum == (minTier or 1))
            end
        end
        if not allowed then RespawnWaitngList = RespawnWaitngList - 1 return end
        local vehicle = SpawnVehicle({plate = data.plate, vehicle = data.props}, false, false, false)
        RespawnWaitngList = RespawnWaitngList - 1
        if RespawnWaitngList < 0 then RespawnWaitngList = 0 end
        if (data.lock_state ~= nil and data.lock_state > 0) then
            SetVehicleDoorsLocked(vehicle, 2)
            SetVehicleDoorsLockedForAllPlayers(vehicle, true)
        end
    end)

end