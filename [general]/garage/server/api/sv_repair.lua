-- Dusa Garage Management System - Car Repair & Refuel Service (Server API)
-- Version: 1.0.0
-- Server-side repair and fuel endpoints
if not rawget(_G, "lib") then include('ox_lib', 'init') end
local RepairAPI = {}

local resourceName = GetCurrentResourceName()

-- Load garage manager module
-- local GarageManagerModule = LoadResourceFile(resourceName, 'server/core/garage.lua')
-- if not GarageManagerModule then
--     error(("[%s] ERROR: Could not load garage manager module"):format(resourceName))
-- end
-- local GarageManager = load(GarageManagerModule)()

-- ================================
-- HELPER FUNCTIONS
-- ================================

local function GetPlayerMoney(source, accountType)
    local Player = Framework.GetPlayer(source)
    if not Player then return 0 end

    if accountType == "bank" then
        return Player.GetMoney('bank') or 0
    elseif accountType == "cash" then
        return Player.GetMoney('cash') or 0
    end

    return 0
end

local function RemovePlayerMoney(source, amount, accountType, reason)
    local Player = Framework.GetPlayer(source)
    if not Player then return false end

    if accountType == "bank" then
        if Player.RemoveMoney("bank", amount, reason) then
            return true
        end
    elseif accountType == "cash" then
        if Player.RemoveMoney("cash", amount, reason) then
            return true
        end
    end

    return false
end

local function CalculateRepairCost(vehicleData)
    if not Config.Prices.repair.enabled then return 0 end

    local totalCost = 0
    local pricingMethod = Config.Prices.repair.pricingMethod

    for partId, partConfig in pairs(Config.Prices.repair.parts) do
        local health = 1000 -- Default full health

        if partId == "engine" and vehicleData.engine then
            health = vehicleData.engine
        elseif partId == "body" and vehicleData.body then
            health = vehicleData.body
        elseif partId == "tires" then
            health = vehicleData.tires or 1000 -- Use tire health from vehicle data
        end

        -- Only calculate cost if the part is damaged
        if health < 1000 then
            if pricingMethod == "percentage" then
                local damagePercent = (1000 - health) / 1000
                totalCost = totalCost + (partConfig.cost * damagePercent)
            else
                -- Fixed pricing - only charge for damaged parts
                totalCost = totalCost + partConfig.cost
            end
        end
    end

    -- Apply full repair discount if configured
    if Config.Prices.repair.fullRepairDiscount > 0 then
        totalCost = totalCost * (1 - Config.Prices.repair.fullRepairDiscount)
    end

    return math.floor(totalCost)
end

local function CalculateFuelCost(currentFuel)
    if not Config.Prices.fuel.enabled then return 0 end

    local fuelNeeded = 100 - currentFuel
    local cost = fuelNeeded * Config.Prices.fuel.pricePerLiter

    return math.floor(cost)
end

-- ================================
-- VEHICLE DATA RETRIEVAL
-- ================================

local function GetVehicleFromDatabase(plate)
    -- Get framework-specific vehicle table and columns
    local vehicleTable = "owned_vehicles"
    local ownerColumn = "owner"
    local stateColumn = "stored"
    local propsColumn = "vehicle"
    
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        ownerColumn = "citizenid"
        stateColumn = "state"
        propsColumn = "mods"
    end

    -- Build query with framework-specific tables and columns
    local query = ([[
        SELECT 
            v.*,
            vm.health_props,
            vm.custom_name
        FROM %s v
        LEFT JOIN dusa_vehicle_metadata vm ON v.plate = vm.plate
        WHERE v.plate = ?
        LIMIT 1
    ]]):format(vehicleTable)

    local result = MySQL.single.await(query, { plate })

    if not result then
        LogDebug(("Vehicle not found in database: %s"):format(plate), "repair-system")
        return nil
    end

    -- Parse vehicle properties based on framework
    local vehicleProps = {}
    local propsData = result[propsColumn]
    if propsData then
        if type(propsData) == "string" then
            local success, decoded = pcall(json.decode, propsData)
            if success and decoded and type(decoded) == "table" then
                vehicleProps = decoded
            end
        elseif type(propsData) == "table" then
            vehicleProps = propsData
        end
    end

    -- Parse health properties from metadata
    local healthProps = {
        engine = 1000,
        body = 1000,
        fuel = 100
    }
    
    if result.health_props then
        if type(result.health_props) == "string" then
            local success, decoded = pcall(json.decode, result.health_props)
            if success and decoded and type(decoded) == "table" then
                healthProps = decoded
            end
        elseif type(result.health_props) == "table" then
            healthProps = result.health_props
        end
    end

    -- Get owner identifier
    local ownerIdentifier = result[ownerColumn]
    if not ownerIdentifier then
        LogDebug(("No owner identifier found for vehicle %s"):format(plate), "repair-system")
        return nil
    end

    -- Get owner name from Framework
    local ownerName = "Unknown"
    local ownerPlayer = Framework.GetPlayerByIdentifier(ownerIdentifier)
    if not ownerPlayer then
        ownerPlayer = Framework.GetOfflinePlayerByIdentifier(ownerIdentifier)
    end
    
    if ownerPlayer then
        local firstName = ownerPlayer.Firstname or ""
        local lastName = ownerPlayer.Lastname or ""
        if firstName ~= "" or lastName ~= "" then
            ownerName = ("%s %s"):format(firstName, lastName):gsub("^%s*(.-)%s*$", "%1")
        elseif ownerPlayer.Name then
            ownerName = ownerPlayer.Name
        end
    end

    -- Determine stored status based on framework
    local isStored = false
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        isStored = (result.state == 1)
    else
        isStored = (result.stored == 1)
    end

    -- Get model name
    local modelName = result.vehicle
    if vehicleProps and vehicleProps.model then
        modelName = vehicleProps.model
    end

    return {
        plate = result.plate,
        model = modelName,
        displayName = vehicleProps.model or modelName or "Unknown",
        engine = healthProps.engine or 1000,
        body = healthProps.body or 1000,
        fuel = healthProps.fuel or 100,
        tires = healthProps.tires or 1000,
        ownerName = ownerName,
        citizenid = ownerIdentifier, -- Keep for compatibility
        stored = isStored
    }
end

-- ================================
-- REPAIR ENDPOINT
-- ================================

lib.callback.register('dusa-garage:server:repairVehicle', function(source, plate)
    local src = source
    LogDebug(("Repair request from player %d for vehicle: %s"):format(src, plate), "repair-system")

    -- Check if repair feature is enabled
    if not Config.Prices.repair.enabled then
        LogDebug("Repair feature is disabled in config", "repair-system")
        return {
            success = false,
            message = "Repair service is currently unavailable"
        }
    end

    -- Get vehicle data from database
    local vehicleData = GetVehicleFromDatabase(plate)
    if not vehicleData then
        return {
            success = false,
            message = "Vehicle not found"
        }
    end

    -- Verify ownership
    local Player = Framework.GetPlayer(src)
    if not Player or not Player.Identifier or Player.Identifier ~= vehicleData.citizenid then
        LogDebug(("Player %d does not own vehicle %s"):format(src, plate), "repair-system")
        return {
            success = false,
            message = "You don't own this vehicle"
        }
    end

    -- Calculate repair cost
    local repairCost = CalculateRepairCost(vehicleData)

    -- Check if vehicle needs repair (including tires)
    if vehicleData.engine >= 1000 and vehicleData.body >= 1000 and (vehicleData.tires or 1000) >= 1000 then
        return {
            success = false,
            message = "Vehicle doesn't need repairs"
        }
    end

    -- Check if player has enough money
    local accountType = Config.Prices.repair.accountType
    local playerMoney = GetPlayerMoney(src, accountType)

    if playerMoney < repairCost then
        LogDebug(("Player %d has insufficient funds for repair: %d/%d"):format(src, playerMoney, repairCost), "repair-system")
        return {
            success = false,
            message = ("Insufficient funds. Need $%d in %s"):format(repairCost, accountType)
        }
    end

    -- Remove money
    local moneyRemoved = RemovePlayerMoney(src, repairCost, accountType, "vehicle-repair")
    if not moneyRemoved then
        LogDebug(("Failed to remove money from player %d"):format(src), "repair-system")
        return {
            success = false,
            message = "Payment processing failed"
        }
    end

    -- Get framework-specific vehicle table and columns
    local vehicleTable = "owned_vehicles"
    local propsColumn = "vehicle"
    
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        propsColumn = "mods"
    end

    -- Update health_props in dusa_vehicle_metadata (universal)
    local updatedHealthProps = {
        engine = 1000,
        body = 1000,
        fuel = vehicleData.fuel or 100, -- Preserve fuel level
        tires = 1000 -- Full tire health after repair
    }

    MySQL.update.await([[
        INSERT INTO dusa_vehicle_metadata (plate, health_props, updated_at)
        VALUES (?, ?, NOW())
        ON DUPLICATE KEY UPDATE
        health_props = VALUES(health_props),
        updated_at = VALUES(updated_at)
    ]], {plate, json.encode(updatedHealthProps)})

    -- For QBCore/QBox: Also update mods JSON and engine/body columns if they exist
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        -- Update mods JSON to preserve properties and update health
        local modsQuery = ('SELECT %s FROM %s WHERE plate = ?'):format(propsColumn, vehicleTable)
        local modsResult = MySQL.single.await(modsQuery, { plate })

        if modsResult and modsResult[propsColumn] then
            local mods = {}
            if type(modsResult[propsColumn]) == "string" then
                local success, decoded = pcall(json.decode, modsResult[propsColumn])
                if success and decoded and type(decoded) == "table" then
                    mods = decoded
                end
            elseif type(modsResult[propsColumn]) == "table" then
                mods = modsResult[propsColumn]
            end

            mods.engineHealth = 1000
            mods.bodyHealth = 1000

            local updateModsQuery = ('UPDATE %s SET %s = ? WHERE plate = ?'):format(vehicleTable, propsColumn)
            MySQL.update.await(updateModsQuery, { json.encode(mods), plate })
        end

        -- Update engine and body columns if they exist (QBCore/QBox)
        local updateColumnsQuery = ('UPDATE %s SET engine = ?, body = ? WHERE plate = ?'):format(vehicleTable)
        MySQL.update.await(updateColumnsQuery, { 1000, 1000, plate })
    end

    LogDebug(("Vehicle %s repaired successfully for player %d. Cost: $%d"):format(plate, src, repairCost), "repair-system")

    -- Send notification
    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Repair Service',
        description = ("Vehicle repaired for $%d"):format(repairCost),
        type = 'success'
    })

    return {
        success = true,
        message = "Vehicle repaired successfully",
        cost = repairCost
    }
end)

-- ================================
-- FUEL REFILL ENDPOINT
-- ================================

lib.callback.register('dusa-garage:server:refillFuel', function(source, plate, fuelResource)
    local src = source
    LogDebug(("Fuel refill request from player %d for vehicle: %s"):format(src, plate), "repair-system")

    -- Check if fuel feature is enabled
    if not Config.Prices.fuel.enabled then
        LogDebug("Fuel refill feature is disabled in config", "repair-system")
        return {
            success = false,
            message = "Fuel service is currently unavailable"
        }
    end

    -- Check if fuel resource exists
    if not fuelResource then
        return {
            success = false,
            message = "No fuel system available"
        }
    end

    -- Get vehicle data from database
    local vehicleData = GetVehicleFromDatabase(plate)
    if not vehicleData then
        return {
            success = false,
            message = "Vehicle not found"
        }
    end

    -- Verify ownership
    local Player = Framework.GetPlayer(src)
    if not Player or not Player.Identifier or Player.Identifier ~= vehicleData.citizenid then
        LogDebug(("Player %d does not own vehicle %s"):format(src, plate), "repair-system")
        return {
            success = false,
            message = "You don't own this vehicle"
        }
    end

    local currentFuel = vehicleData.fuel or 0

    -- Check if vehicle needs fuel
    if currentFuel >= 99 then
        return {
            success = false,
            message = "Fuel tank is already full"
        }
    end

    -- Calculate fuel cost
    local fuelCost = CalculateFuelCost(currentFuel)

    -- Check if player has enough money
    local accountType = Config.Prices.fuel.accountType
    local playerMoney = GetPlayerMoney(src, accountType)

    if playerMoney < fuelCost then
        LogDebug(("Player %d has insufficient funds for fuel: %d/%d"):format(src, playerMoney, fuelCost), "repair-system")
        return {
            success = false,
            message = ("Insufficient funds. Need $%d in %s"):format(fuelCost, accountType)
        }
    end

    -- Remove money
    local moneyRemoved = RemovePlayerMoney(src, fuelCost, accountType, "fuel-refill")
    if not moneyRemoved then
        LogDebug(("Failed to remove money from player %d"):format(src), "repair-system")
        return {
            success = false,
            message = "Payment processing failed"
        }
    end

    -- Get framework-specific vehicle table
    local vehicleTable = "owned_vehicles"
    
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
    end

    -- Update health_props in dusa_vehicle_metadata (universal)
    local updatedHealthProps = {
        engine = vehicleData.engine or 1000, -- Preserve engine health
        body = vehicleData.body or 1000, -- Preserve body health
        fuel = 100
    }

    MySQL.update.await([[
        INSERT INTO dusa_vehicle_metadata (plate, health_props, updated_at)
        VALUES (?, ?, NOW())
        ON DUPLICATE KEY UPDATE
        health_props = VALUES(health_props),
        updated_at = VALUES(updated_at)
    ]], {plate, json.encode(updatedHealthProps)})

    -- For QBCore/QBox: Also update fuel column if it exists
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        local updateFuelQuery = ('UPDATE %s SET fuel = ? WHERE plate = ?'):format(vehicleTable)
        MySQL.update.await(updateFuelQuery, { 100, plate })
    end

    LogDebug(("Vehicle %s refueled successfully for player %d. Cost: $%d"):format(plate, src, fuelCost), "repair-system")

    -- Send notification
    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Fuel Service',
        description = ("Fuel tank filled for $%d"):format(fuelCost),
        type = 'success'
    })

    return {
        success = true,
        message = "Fuel tank filled successfully",
        cost = fuelCost
    }
end)

-- ================================
-- GET VEHICLE DATA FOR REPAIR VIEW
-- ================================

lib.callback.register('dusa-garage:server:getVehicleDataForRepair', function(source, plate)
    local src = source
    LogDebug(("Vehicle data request from player %d for plate: %s"):format(src, plate), "repair-system")

    local vehicleData = GetVehicleFromDatabase(plate)
    if not vehicleData then
        return {
            success = false,
            message = "Vehicle not found"
        }
    end

    -- Verify ownership
    local Player = Framework.GetPlayer(src)
    if not Player or not Player.Identifier or Player.Identifier ~= vehicleData.citizenid then
        return {
            success = false,
            message = "You don't own this vehicle"
        }
    end

    return {
        success = true,
        data = vehicleData
    }
end)

-- ================================
-- SPAWN VEHICLE FOR REPAIR SHOWROOM
-- ================================
lib.callback.register('dusa-garage:server:spawnVehicleForRepair', function(source, plate, spawnCoords, vehicleData)
    local src = source
    LogDebug(("Repair spawn request from player %d for vehicle: %s"):format(src, plate), "repair-system")
    print("^3[REPAIR DEBUG] Spawn request - Player: " .. src .. ", Plate: " .. plate .. "^0")
    print("^3[REPAIR DEBUG] Spawn coords: " .. json.encode(spawnCoords) .. "^0")

    -- Get player identifier through bridge
    local Player = Framework.GetPlayer(src)
    if not Player or not Player.Identifier then
        print("^1[REPAIR DEBUG] Failed to get player data^0")
        return {
            success = false,
            message = "Could not get player data"
        }
    end
    
    print("^3[REPAIR DEBUG] Player identifier: " .. Player.Identifier .. "^0")

    -- Get framework-specific vehicle table
    local vehicleTable = "owned_vehicles"
    local ownerColumn = "owner"
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        ownerColumn = "citizenid"
    end
    
    print("^3[REPAIR DEBUG] Using table: " .. vehicleTable .. ", column: " .. ownerColumn .. "^0")

    -- Verify vehicle ownership
    local query = ('SELECT * FROM %s WHERE plate = ? AND %s = ?'):format(vehicleTable, ownerColumn)
    print("^3[REPAIR DEBUG] Query: " .. query .. "^0")
    print("^3[REPAIR DEBUG] Query params: plate=" .. plate .. ", identifier=" .. Player.Identifier .. "^0")
    
    local vehicleDbData = MySQL.single.await(query, {plate, Player.Identifier})
    if not vehicleDbData then
        print("^1[REPAIR DEBUG] Vehicle not found in database^0")
        return {
            success = false,
            message = "Vehicle not found or not owned by player"
        }
    end
    
    print("^2[REPAIR DEBUG] Vehicle found in database^0")

    -- Get vehicle properties from database
    local propsColumn = nil
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        propsColumn = 'mods'
    else
        propsColumn = 'vehicle'
    end
    
    print("^3[REPAIR DEBUG] Using props column: " .. propsColumn .. "^0")

    local vehicleProps = nil
    local propsData = vehicleDbData[propsColumn]
    if propsData and type(propsData) == "string" then
        local success, props = pcall(json.decode, propsData)
        if success and props and type(props) == "table" then
            vehicleProps = props
        end
    end

    -- Ensure we have vehicleProps table and add plate
    if not vehicleProps then
        vehicleProps = {}
    end
    vehicleProps.plate = plate

    -- Get model hash
    local modelHash
    if vehicleProps and vehicleProps.model then
        modelHash = vehicleProps.model
        print("^3[REPAIR DEBUG] Model from props: " .. tostring(modelHash) .. "^0")
    elseif vehicleDbData.vehicle then
        modelHash = GetHashKey(vehicleDbData.vehicle)
        print("^3[REPAIR DEBUG] Model from vehicle column: " .. tostring(vehicleDbData.vehicle) .. ", hash: " .. tostring(modelHash) .. "^0")
    end

    if not modelHash then
        print("^1[REPAIR DEBUG] Could not determine vehicle model^0")
        return {
            success = false,
            message = "Could not determine vehicle model"
        }
    end

    -- Convert string model to hash if needed
    if type(modelHash) == "string" then
        modelHash = GetHashKey(modelHash)
        print("^3[REPAIR DEBUG] Converted string model to hash: " .. tostring(modelHash) .. "^0")
    end
    
    print("^3[REPAIR DEBUG] Final model hash: " .. tostring(modelHash) .. "^0")

    -- Prepare health props from vehicleData
    local healthProps = {
        engine = vehicleData.engine or 1000,
        body = vehicleData.body or 1000,
        fuel = vehicleData.fuel or 100
    }
    
    print("^3[REPAIR DEBUG] Calling GarageManager.CreateVehicle^0")
    print("^3[REPAIR DEBUG] Coords: " .. json.encode(spawnCoords) .. "^0")

    -- Use GarageManager.CreateVehicle for spawning
    local netId, vehicle, error = GarageManager.CreateVehicle({
        model = modelHash,
        coords = spawnCoords,
        heading = spawnCoords.w or spawnCoords.h or 0.0,
        props = vehicleProps,
        playerSource = src,
        warp = false -- Don't warp player in repair showroom
    })
    
    print("^3[REPAIR DEBUG] CreateVehicle returned - netId: " .. tostring(netId) .. ", vehicle: " .. tostring(vehicle) .. ", error: " .. tostring(error) .. "^0")

    if not vehicle or vehicle == 0 then
        print("^1[REPAIR DEBUG] CreateVehicle failed - error: " .. tostring(error) .. "^0")
        return {
            success = false,
            message = error or "Failed to spawn vehicle"
        }
    end
    
    print("^2[REPAIR DEBUG] Vehicle spawned successfully! NetId: " .. tostring(netId) .. ", Vehicle: " .. tostring(vehicle) .. "^0")

    -- Return vehicle network ID and health props for client
    return {
        success = true,
        netId = netId,
        healthProps = healthProps
    }
end)

-- ================================
-- SET REPAIR ROUTING BUCKET
-- ================================

lib.callback.register('dusa-garage:server:setRepairRoutingBucket', function(source, vehicleNetId, enable)
    local src = source
    
    if enable then
        -- Set unique routing bucket for this player (use source + 1000 to avoid conflicts)
        local routingBucket = src + 1000
        SetPlayerRoutingBucket(src, routingBucket)
        
        -- Set vehicle routing bucket if vehicle exists
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                SetEntityRoutingBucket(vehicle, routingBucket)
                LogDebug(("Set routing bucket %d for player %d and vehicle %d"):format(routingBucket, src, vehicleNetId), "repair-system")
            end
        end
        
        return { success = true, routingBucket = routingBucket }
    else
        -- Reset routing bucket to default (0)
        SetPlayerRoutingBucket(src, 0)
        
        -- Reset vehicle routing bucket if vehicle exists
        if vehicleNetId then
            local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
            if vehicle and vehicle ~= 0 then
                SetEntityRoutingBucket(vehicle, 0)
                LogDebug(("Reset routing bucket for player %d and vehicle %d"):format(src, vehicleNetId), "repair-system")
            end
        end
        
        return { success = true }
    end
end)

-- Export API
return RepairAPI
