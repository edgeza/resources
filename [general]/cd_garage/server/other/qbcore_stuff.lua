if Config.Framework == 'qbcore' then
    
    QBCore.Functions.CreateCallback('qb-garage:server:GetPlayerVehicles', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        local Vehicles = {}

        local Result = DatabaseQuery('SELECT * FROM player_vehicles WHERE citizenid="'..Player.PlayerData.citizenid..'"')
        
        -- Resolve tier inline to avoid any load-order issues
        local playerTier
        local IsVehicleAllowedByTier, IsVehicleInAnyTier
        if Config.PatreonTiers and Config.PatreonTiers.ENABLE then
            IsVehicleAllowedByTier = function(...)
                return exports['cd_garage']:IsVehicleAllowedByTier(...)
            end;
            IsVehicleInAnyTier = function(...)
                return exports['cd_garage']:IsVehicleInAnyTier(...)
            end
        end
        
        do
            if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
                playerTier = Config.PatreonTiers and Config.PatreonTiers.default_tier or 0
            else
                local mode = Config.PatreonTiers.lookup_mode
                if mode == 'metadata' then
                    local md = Player.PlayerData.metadata or {}
                    local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                    local t = md[key]
                    if type(t) == 'number' then playerTier = t elseif type(t) == 'string' then playerTier = tonumber(t) or 0 else playerTier = 0 end
                elseif mode == 'job' then
                    local job = (Player.PlayerData.job or {}).name
                    playerTier = Config.PatreonTiers.job_to_tier[job] or 0
                elseif mode == 'group' then
                    local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
                    if type(perms) == 'string' then
                        playerTier = Config.PatreonTiers.group_to_tier[perms] or 0
                    elseif type(perms) == 'table' then
                        for group,_ in pairs(perms) do playerTier = Config.PatreonTiers.group_to_tier[group] if playerTier then break end end
                        playerTier = playerTier or 0
                    else
                        playerTier = 0
                    end
                else
                    playerTier = 0
                end
            end
        end

        if Result and Result[1] then
            -- Optimize: Check Patreon garage proximity once, not for every vehicle
            local nearPatreon = false
            local ped = GetPlayerPed(source)
            if ped and ped ~= 0 then
                local coords = GetEntityCoords(ped)
                for i = 1, #Config.Locations do
                    local g = Config.Locations[i]
                    if g and g.PatreonTierRequired ~= nil then
                        local dist = #(coords - vector3(g.x_1, g.y_1, g.z_1))
                        if dist <= (g.Dist or 10.0) then
                            nearPatreon = true
                            break
                        end
                    end
                end
            end

            for k, v in pairs(Result) do
                local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
                if VehicleData then
                    -- Patreon tier filtering
                    if Config.PatreonTiers and Config.PatreonTiers.ENABLE then
                        if nearPatreon then
                            -- Only show Patreon vehicles, anchored to Patreon garages, within your tier
                            local isPatreonGarage = (v.garage_id == 'Patreon Hub' or v.garage_id == 'Patreon Harbor' or v.garage_id == 'Patreon Airfield')
                            if not isPatreonGarage then goto continue end
                            if not IsVehicleInAnyTier(v.vehicle) then goto continue end
                            if not IsVehicleAllowedByTier(v.vehicle, playerTier) then goto continue end
                        else
                            -- Outside Patreon: hide all Patreon vehicles and anything in Patreon garages
                            local isPatreonGarage = (v.garage_id == 'Patreon Hub' or v.garage_id == 'Patreon Harbor' or v.garage_id == 'Patreon Airfield')
                            if isPatreonGarage then goto continue end
                            if IsVehicleInAnyTier(v.vehicle) then goto continue end
                        end
                    end
                    
                    if v.impound == 1 then
                        v.state = json.decode(v.impound_data).impound_label
                    else
                        if v.in_garage then
                            v.state = 'Garaged'
                        else
                            v.state = 'Out'
                        end
                    end
                    
                    local fullname 
                    if VehicleData["brand"] ~= nil then
                        fullname = VehicleData["brand"] .. " " .. VehicleData["name"]
                    else
                        fullname = VehicleData["name"]
                    end
                    local props = json.decode(v.mods)
                    Vehicles[#Vehicles+1] = {
                        fullname = fullname,
                        brand = VehicleData["brand"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = v.garage_id,
                        state = v.state,
                        fuel = props.fuelLevel,
                        engine = props.engineHealth,
                        body = props.bodyHealth
                    }
                else
                    print('^1[error_code-1975]')
                    print('Codesign Vehicle Missing: '..v.vehicle)
                end
                ::continue::
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)

    QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner", function(source, cb, plate)
        local src = source
        local pData = QBCore.Functions.GetPlayer(src)
        MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',{plate, pData.PlayerData.citizenid}, function(result)
            if result[1] then
                cb(true, result[1].balance)
            else
                cb(false)
            end
        end)
    end)
    
end