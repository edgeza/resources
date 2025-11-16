-- Framework Detection
local Framework = nil
local FrameworkReady = false

-- Detect Framework
CreateThread(function()
    while Framework == nil do
        if GetResourceState('qb-core') == 'started' then
            Framework = 'qbcore'
            local QBCore = exports['qb-core']:GetCoreObject()
            FrameworkReady = true
            break
        elseif GetResourceState('es_extended') == 'started' then
            Framework = 'esx'
            ESX = exports['es_extended']:getSharedObject()
            FrameworkReady = true
            break
        elseif GetResourceState('qbx_core') == 'started' or GetResourceState('qbox') == 'started' then
            Framework = 'qbox'
            FrameworkReady = true
            break
        end
        Wait(100)
    end
    
    if Config.Debug then
        print(string.format('[olrp_blips] Framework detected: %s', Framework or 'standalone'))
    end
end)

-- Create Blips Function
local function CreateBlips()
    if not Config.blipsShow then
        if Config.Debug then
            print('[olrp_blips] Blips are disabled in config')
        end
        return
    end

    if not Config.Locations or next(Config.Locations) == nil then
        if Config.Debug then
            print('[olrp_blips] No locations configured')
        end
        return
    end

    CreateThread(function()
        -- Wait for framework to be ready (optional, can work standalone)
        if Config.WaitForFramework then
            while not FrameworkReady do
                Wait(100)
            end
        end

        -- Small delay to ensure everything is loaded
        Wait(Config.LoadDelay or 1000)

        local blipsCreated = 0
        
        for i, location in pairs(Config.Locations) do
            if location.vector and location.text then
                local x, y, z = location.vector.x, location.vector.y, location.vector.z
                if not x or not y or not z then
                    if Config.Debug then
                        print(string.format('[olrp_blips] Warning: Location #%d has invalid coordinates', i))
                    end
                else
                    local blip = AddBlipForCoord(x, y, z)
                    
                    -- Set sprite
                    if location.sprite then
                        SetBlipSprite(blip, location.sprite)
                    else
                        SetBlipSprite(blip, Config.DefaultSprite or 1)
                    end
                    
                    -- Set scale
                    if location.scale then
                        SetBlipScale(blip, location.scale)
                    else
                        SetBlipScale(blip, Config.DefaultScale or 0.8)
                    end
                    
                    -- Set color
                    if location.color then
                        SetBlipColour(blip, location.color)
                    else
                        SetBlipColour(blip, Config.DefaultColor or 1)
                    end
                    
                    -- Set short range
                    if location.shortRange ~= nil then
                        SetBlipAsShortRange(blip, location.shortRange)
                    else
                        SetBlipAsShortRange(blip, Config.DefaultShortRange ~= false)
                    end
                    
                    -- Set category (if specified)
                    if location.category then
                        SetBlipCategory(blip, location.category)
                    end
                    
                    -- Set name
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(location.text)
                    EndTextCommandSetBlipName(blip)
                    
                    -- Store blip ID if needed for removal later
                    if Config.StoreBlipIds then
                        if not Config.BlipIds then
                            Config.BlipIds = {}
                        end
                        Config.BlipIds[i] = blip
                    end
                    
                    blipsCreated = blipsCreated + 1
                    
                    if Config.Debug then
                        print(string.format('[olrp_blips] Created blip: %s at %.2f, %.2f, %.2f', location.text, x, y, z))
                    end
                end
            else
                if Config.Debug then
                    print(string.format('[olrp_blips] Warning: Location #%d is missing vector or text', i))
                end
            end
        end
        
        if Config.Debug then
            print(string.format('[olrp_blips] Successfully created %d blips', blipsCreated))
        end
    end)
end

-- Initialize on resource start
CreateThread(function()
    CreateBlips()
end)

-- Export function to recreate blips if needed
exports('CreateBlips', CreateBlips)
