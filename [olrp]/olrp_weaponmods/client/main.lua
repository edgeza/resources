-- Stitch Weapon Mods - Client Script
-- Optimized for high player count with minimal performance impact

local currentWeapon = nil
local lastWeapon = nil
local isInitialized = false
local serverWeaponModifiers = {}
local lastWeaponChangeTime = 0
local WEAPON_CHANGE_THROTTLE = 500 -- Throttle weapon change events to prevent spam

-- Initialize the weapon damage system
local function InitializeWeaponSystem()
    if not Config.Enabled then
        if Config.Debug then
            print("^3[Stitch Weapon Mods]^7 System disabled in config")
        end
        return
    end
    
    isInitialized = true
    if Config.Debug then
        print("^2[Stitch Weapon Mods]^7 System initialized successfully")
    end
end

-- Apply weapon damage modifier
local function ApplyWeaponModifier(weaponHash, weaponConfig)
    if not weaponConfig then return end
    
    -- Apply damage modifier
    N_0x4757f00bc6323cfe(weaponHash, weaponConfig.modifier)
    
    -- Handle critical hits
    if weaponConfig.disableCritical then
        SetPedSuffersCriticalHits(GetPlayerPed(), false)
    end
    
    -- Debug logging
    if Config.Debug then
        local weaponName = GetWeaponDisplayNameFromHash(weaponHash) or "Unknown"
        print(string.format("^2[Stitch Weapon Mods]^7 Applied modifier %.2f to %s", weaponConfig.modifier, weaponName))
    end
end

-- Notify server of weapon change (throttled to prevent spam)
local function NotifyServerWeaponChange(weaponHash)
    local currentTime = GetGameTimer()
    if currentTime - lastWeaponChangeTime < WEAPON_CHANGE_THROTTLE then
        return -- Throttle weapon change events
    end
    lastWeaponChangeTime = currentTime
    
    TriggerServerEvent('stitch_weaponmods:weaponChanged', weaponHash)
end

-- Main weapon monitoring loop
CreateThread(function()
    InitializeWeaponSystem()
    
    while true do
        if not isInitialized or not Config.Enabled then
            Wait(1000)
            goto continue
        end
        
        local playerPed = GetPlayerPed(-1)
        
        -- Check if player exists and is valid
        if not playerPed or playerPed == 0 then
            Wait(100)
            goto continue
        end
        
        -- Get current weapon
        currentWeapon = GetSelectedPedWeapon(playerPed)
        
        -- Only process if weapon changed or first time
        if currentWeapon ~= lastWeapon then
            lastWeapon = currentWeapon
            
            -- Notify server of weapon change
            NotifyServerWeaponChange(currentWeapon)
            
            -- Get weapon configuration (prefer server data, fallback to client config)
            local weaponConfig = serverWeaponModifiers[currentWeapon] or Config.Weapons[currentWeapon]
            
            if weaponConfig then
                ApplyWeaponModifier(currentWeapon, weaponConfig)
            else
                -- Reset to default if weapon not in config
                if Config.Debug then
                    print(string.format("^3[Stitch Weapon Mods]^7 Weapon %s not found in config, using default", currentWeapon))
                end
            end
        end
        
        -- Use configurable update frequency for better performance (default 200ms for high player count)
        Wait(Config.UpdateFrequency or 200)
        
        ::continue::
    end
end)

-- Handle resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Debug then
            print("^1[Stitch Weapon Mods]^7 Resource stopped, cleaning up...")
        end
        isInitialized = false
    end
end)

-- Handle resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Debug then
            print("^2[Stitch Weapon Mods]^7 Resource started")
        end
        InitializeWeaponSystem()
    end
end)

-- Server event handlers
RegisterNetEvent('stitch_weaponmods:initializeWeapons')
AddEventHandler('stitch_weaponmods:initializeWeapons', function(weaponModifiers)
    serverWeaponModifiers = weaponModifiers
    if Config.Debug then
        print("^2[Stitch Weapon Mods]^7 Received weapon modifiers from server")
    end
end)

RegisterNetEvent('stitch_weaponmods:applyModifier')
AddEventHandler('stitch_weaponmods:applyModifier', function(weaponHash, weaponData)
    ApplyWeaponModifier(weaponHash, weaponData)
end)
