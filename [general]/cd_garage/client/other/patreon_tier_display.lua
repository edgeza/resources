-- Patreon Tier Display System for cd_garage
-- This file handles displaying tier indicators (Tier 1, Tier 2, Tier 3) next to Patreon vehicles in the garage UI

if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then return end

local function GetVehicleTier(vehicleModel)
    if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
        return nil
    end
    
    local spawncode = tostring(vehicleModel):upper()
    local minTier = nil
    
    for t, tierData in pairs(Config.PatreonTiers.tiers or {}) do
        -- Check cars
        for i = 1, #(tierData.cars or {}) do
            if tostring(tierData.cars[i]):upper() == spawncode then
                minTier = (minTier and math.min(minTier, t)) or t
            end
        end
        
        -- Check boats
        for i = 1, #(tierData.boats or {}) do
            if tostring(tierData.boats[i]):upper() == spawncode then
                minTier = (minTier and math.min(minTier, t)) or t
            end
        end
        
        -- Check air vehicles
        for i = 1, #(tierData.air or {}) do
            if tostring(tierData.air[i]):upper() == spawncode then
                minTier = (minTier and math.min(minTier, t)) or t
            end
        end
    end
    
    return minTier
end

local function GetTierDisplayName(tier)
    if tier == 1 then
        return "Tier 1"
    elseif tier == 2 then
        return "Tier 2"
    elseif tier == 3 then
        return "Tier 3"
    elseif tier == 4 then
        return "Tier 4"
    end
    return nil
end

local function GetTierBadgeClass(tier)
    if tier == 1 then
        return "badge badge-primary" -- Blue
    elseif tier == 2 then
        return "badge badge-success" -- Green
    elseif tier == 3 then
        return "badge badge-warning" -- Orange/Yellow
    elseif tier == 4 then
        return "badge badge-danger" -- Red
    end
    return "badge badge-secondary"
end

-- Function to send patreon tier data to NUI
local function SendPatreonTierData()
    if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
        return
    end
    
    SendNUIMessage({
        action = 'cd_garage:addTierIndicators',
        patreonTiers = Config.PatreonTiers
    })
end

-- Function to clear patreon tier indicators
local function ClearPatreonTierIndicators()
    SendNUIMessage({
        action = 'cd_garage:clearTierIndicators'
    })
end

-- Event handlers for garage events
RegisterNetEvent('cd_garage:Enter')
AddEventHandler('cd_garage:Enter', function(garage_id)
    -- Tag UI as Patreon when entering Patreon garages
    local isPatreon = (garage_id == 'Patreon Hub' or garage_id == 'Patreon Harbor' or garage_id == 'Patreon Airfield')
    SendNUIMessage({ action = 'cd_garage:setTheme', patreon = isPatreon })
    
    -- Send patreon tier data when entering garage
    SendPatreonTierData()
end)

RegisterNetEvent('cd_garage:Exit')
AddEventHandler('cd_garage:Exit', function()
    SendNUIMessage({ action = 'cd_garage:setTheme', patreon = false })
    
    -- Clear patreon tier indicators when exiting garage
    ClearPatreonTierIndicators()
end)

RegisterNetEvent('cd_garage:ToggleNUIFocus')
AddEventHandler('cd_garage:ToggleNUIFocus', function()
    -- Send patreon tier data when NUI focus is toggled
    SendPatreonTierData()
end)

-- Listen for the actual garage entry events that are used in the system
RegisterNetEvent('cd_garage:EnterGarage_Outside')
AddEventHandler('cd_garage:EnterGarage_Outside', function(garage_data)
    -- Send patreon tier data when entering garage from outside
    SendPatreonTierData()
end)

RegisterNetEvent('cd_garage:EnterGarage_Inside')
AddEventHandler('cd_garage:EnterGarage_Inside', function(garage_data)
    -- Send patreon tier data when entering garage from inside
    SendPatreonTierData()
end)

-- Listen for when the garage UI is actually shown
RegisterNetEvent('cd_garage:ShowGarage')
AddEventHandler('cd_garage:ShowGarage', function()
    -- Send patreon tier data when garage UI is shown
    SendPatreonTierData()
end)

-- Listen for when the garage list is populated
RegisterNetEvent('cd_garage:GarageListUpdated')
AddEventHandler('cd_garage:GarageListUpdated', function()
    -- Send patreon tier data when garage list is updated
    SendPatreonTierData()
end)

-- Export functions for potential external use
exports('GetVehicleTier', GetVehicleTier)
exports('SendPatreonTierData', SendPatreonTierData)
exports('ClearPatreonTierIndicators', ClearPatreonTierIndicators)

