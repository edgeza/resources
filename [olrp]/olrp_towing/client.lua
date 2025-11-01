local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local hasTowRope = false
local ropeSegments = {}
local ropeEntity = nil
local attachedVehicle = nil
local towingVehicle = nil
local towRopeVehicle = nil
local ropeAttachedToPlayer = false

-- Initialize
CreateThread(function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- Check if vehicle is allowed for towing
local function IsVehicleAllowed(vehicle)
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel):lower()
    
    for _, allowedVehicle in pairs(Config.AllowedVehicles) do
        if vehicleName == allowedVehicle then
            return true
        end
    end
    return false
end

-- Create rope between vehicles
local ropeEntity = nil
local function CreateRope()
    if not DoesEntityExist(towingVehicle) or not DoesEntityExist(attachedVehicle) then
        return
    end
    
    -- Clear existing rope
    if ropeEntity and DoesEntityExist(ropeEntity) then
        DeleteRope(ropeEntity)
    end
    ropeEntity = nil
    
    -- Get attachment points (back of towing vehicle, front of attached vehicle)
    local towingBack = GetOffsetFromEntityInWorldCoords(towingVehicle, 0.0, -2.5, 0.0)
    local attachedFront = GetOffsetFromEntityInWorldCoords(attachedVehicle, 0.0, 2.5, 0.0)
    
    local distance = #(towingBack - attachedFront)
    local ropeLength = math.max(distance * 1.2, 5.0) -- 20% extra length for slack, minimum 5m
    
    -- Create rope at towing vehicle's back
    ropeEntity = AddRope(towingBack.x, towingBack.y, towingBack.z, 0.0, 0.0, 0.0, ropeLength, 1, ropeLength, 1.0, false, false, false, 1.0, false)
    
    if ropeEntity then
        -- Attach rope to towing vehicle (back) - use relative offset
        AttachRopeToEntity(ropeEntity, towingVehicle, 0.0, -2.5, 0.0, true)
        
        -- Attach rope to attached vehicle (front) - use relative offset
        AttachRopeToEntity(ropeEntity, attachedVehicle, 0.0, 2.5, 0.0, true)
        
        -- Enable rope physics
        ActivatePhysics(ropeEntity)
        
        print("^2[OLRP Towing]^7 Rope created and attached between vehicles")
    end
end

-- Get tow rope from vehicle back
local function GetTowRope(vehicle)
    if not IsVehicleAllowed(vehicle) then
        QBCore.Functions.Notify(Config.Messages.notAllowedVehicle, 'error')
        return
    end
    
    if hasTowRope then
        QBCore.Functions.Notify(Config.Messages.alreadyHasRope, 'error')
        return
    end
    
    hasTowRope = true
    ropeAttachedToPlayer = true
    towRopeVehicle = vehicle
    towingVehicle = vehicle
    QBCore.Functions.Notify(Config.Messages.getTowRope, 'success')
    
    print("^2[OLRP Towing]^7 Tow rope in hand")
    TriggerServerEvent('olrp_towing:server:getTowRope')
end

-- Attach tow rope to target vehicle
local function AttachTowRope(vehicle)
    if not hasTowRope then
        QBCore.Functions.Notify(Config.Messages.noTowRope, 'error')
        return
    end
    
    if attachedVehicle then
        QBCore.Functions.Notify('Tow rope is already attached!', 'error')
        return
    end
    
    if vehicle == towRopeVehicle then
        QBCore.Functions.Notify('Cannot attach to the towing vehicle!', 'error')
        return
    end
    
    attachedVehicle = vehicle
    ropeAttachedToPlayer = false
    QBCore.Functions.Notify(Config.Messages.ropeAttached, 'success')
    
    -- Create physical rope between vehicles
    CreateRope()
    
    print("^2[OLRP Towing]^7 Rope attached")
    print("^2[OLRP Towing]^7 Towing Vehicle: " .. towingVehicle)
    print("^2[OLRP Towing]^7 Attached Vehicle: " .. attachedVehicle)
    
    TriggerServerEvent('olrp_towing:server:attachTowRope', NetworkGetNetworkIdFromEntity(vehicle))
    
    -- Monitor rope and apply towing physics
    CreateThread(function()
        while attachedVehicle and DoesEntityExist(attachedVehicle) and towingVehicle and DoesEntityExist(towingVehicle) do
            if not hasTowRope then
                break
            end
            
            local towingCoords = GetEntityCoords(towingVehicle)
            local attachedCoords = GetEntityCoords(attachedVehicle)
            local distance = #(towingCoords - attachedCoords)
            
            -- Break if too far
            if distance > 50.0 then
                QBCore.Functions.Notify('Tow rope broke due to distance!', 'error')
                print("^1[OLRP Towing]^7 Rope broke - distance: " .. distance)
                DetachTowRope()
                break
            end
            
            -- Update rope attachment points as vehicles move
            if ropeEntity and DoesEntityExist(ropeEntity) then
                local towingBack = GetOffsetFromEntityInWorldCoords(towingVehicle, 0.0, -2.5, 0.0)
                local attachedFront = GetOffsetFromEntityInWorldCoords(attachedVehicle, 0.0, 2.5, 0.0)
                
                -- Update rope length dynamically
                local ropeLength = math.max(distance * 1.2, 5.0)
                SetRopeLength(ropeEntity, ropeLength)
                
                -- Apply towing force when rope is taut (stretched beyond slack)
                if distance > 15.0 then
                    local direction = (towingCoords - attachedCoords) / distance
                    local stretch = distance - 15.0
                    local force = direction * (stretch * 0.5)
                    
                    -- Apply force to attached vehicle to follow towing vehicle
                    ApplyForceToEntityCenterOfMass(attachedVehicle, 1, force.x, force.y, force.z * 0.3, false, true, true, true)
                end
            else
                -- Recreate rope if it was deleted
                CreateRope()
            end
            
            Wait(100) -- Update frequently for smooth towing
        end
        
        print("^3[OLRP Towing]^7 Towing ended")
    end)
end

-- Detach tow rope
function DetachTowRope()
    if not attachedVehicle then
        QBCore.Functions.Notify('No tow rope attached!', 'error')
        return
    end
    
    -- Delete rope entity
    if ropeEntity and DoesEntityExist(ropeEntity) then
        DeleteRope(ropeEntity)
        ropeEntity = nil
    end
    
    -- Clear rope segments (legacy cleanup)
    for _, segment in pairs(ropeSegments) do
        if DoesEntityExist(segment) then
            DeleteRope(segment)
        end
    end
    ropeSegments = {}
    
    attachedVehicle = nil
    towingVehicle = nil
    towRopeVehicle = nil
    hasTowRope = false
    ropeAttachedToPlayer = false
    
    QBCore.Functions.Notify(Config.Messages.ropeDetached, 'success')
    TriggerServerEvent('olrp_towing:server:detachTowRope')
end

-- Setup ox_target for allowed vehicles
CreateThread(function()
    -- Add target option for getting tow rope (on allowed vehicles from the back)
    exports.ox_target:addModel(Config.AllowedVehicles, {
        {
            name = 'olrp_towing:getTowRope',
            icon = 'fas fa-link',
            label = Config.Messages.getTowRope,
            canInteract = function(entity, distance, coords, name)
                if not IsVehicleAllowed(entity) then
                    return false
                end
                
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local backCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, -3.0, 0.0)
                local backDistance = #(playerCoords - backCoords)
                
                return not hasTowRope and backDistance <= 2.5
            end,
            onSelect = function(data)
                GetTowRope(data.entity)
            end,
        },
    })
    
    -- Add target option for attaching tow rope (on any vehicle from front or back)
    exports.ox_target:addGlobalVehicle({
        {
            name = 'olrp_towing:attachTowRope',
            icon = 'fas fa-link',
            label = Config.Messages.attachTowRope,
            canInteract = function(entity, distance, coords, name)
                if not hasTowRope or not ropeAttachedToPlayer or attachedVehicle or entity == towRopeVehicle then
                    return false
                end
                
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local frontCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, 2.5, 0.0)
                local backCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, -2.5, 0.0)
                local frontDistance = #(playerCoords - frontCoords)
                local backDistance = #(playerCoords - backCoords)
                
                return frontDistance <= 2.5 or backDistance <= 2.5
            end,
            onSelect = function(data)
                AttachTowRope(data.entity)
            end,
        },
        {
            name = 'olrp_towing:detachTowRope',
            icon = 'fas fa-unlink',
            label = Config.Messages.detachTowRope,
            canInteract = function(entity, distance, coords, name)
                return hasTowRope and attachedVehicle and (entity == attachedVehicle or entity == towRopeVehicle)
            end,
            onSelect = function(data)
                DetachTowRope()
            end,
        },
    })
end)

-- Client events (kept for compatibility, but ox_target uses onSelect callbacks directly)
RegisterNetEvent('olrp_towing:client:getTowRope', function(data)
    if data and data.entity then
        GetTowRope(data.entity)
    end
end)

RegisterNetEvent('olrp_towing:client:attachTowRope', function(data)
    if data and data.entity then
        AttachTowRope(data.entity)
    end
end)

RegisterNetEvent('olrp_towing:client:detachTowRope', function()
    DetachTowRope()
end)

RegisterNetEvent('olrp_towing:client:resetState', function()
    if ropeEntity and DoesEntityExist(ropeEntity) then
        DeleteRope(ropeEntity)
        ropeEntity = nil
    end
    
    for _, segment in pairs(ropeSegments) do
        if DoesEntityExist(segment) then
            DeleteRope(segment)
        end
    end
    ropeSegments = {}
    
    hasTowRope = false
    attachedVehicle = nil
    towingVehicle = nil
    towRopeVehicle = nil
    ropeAttachedToPlayer = false
end)

-- Clean up
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if ropeEntity and DoesEntityExist(ropeEntity) then
            DeleteRope(ropeEntity)
        end
        
        for _, segment in pairs(ropeSegments) do
            if DoesEntityExist(segment) then
                DeleteRope(segment)
            end
        end
    end
end)