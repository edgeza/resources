-- Stitch Weapon Mods - Server Script
-- Optimized for high player count (100+ players) with minimal server impact

local weaponModifiers = {}
local isInitialized = false
local playerWeaponCache = {} -- Cache player weapons to reduce processing
local lastProcessTime = 0
local PROCESS_INTERVAL = 1000 -- Process weapon changes every 1 second instead of every change

-- Initialize server-side weapon system
local function InitializeServerSystem()
    if not Config.Enabled then
        if Config.Debug then
            print("^3[Stitch Weapon Mods]^7 Server system disabled in config")
        end
        return
    end
    
    -- Load weapon modifiers from config (only once at startup)
    for weaponHash, weaponData in pairs(Config.Weapons) do
        weaponModifiers[weaponHash] = {
            modifier = weaponData.modifier,
            disableCritical = weaponData.disableCritical
        }
    end
    
    isInitialized = true
    if Config.Debug then
        local weaponCount = 0
        for _ in pairs(weaponModifiers) do weaponCount = weaponCount + 1 end
        print("^2[Stitch Weapon Mods]^7 Server system initialized with " .. weaponCount .. " weapons")
    end
end

-- Get weapon modifier for a specific weapon (optimized lookup)
local function GetWeaponModifier(weaponHash)
    return weaponModifiers[weaponHash]
end

-- Batch process weapon changes to reduce server load
local function ProcessWeaponChanges()
    local currentTime = GetGameTimer()
    if currentTime - lastProcessTime < PROCESS_INTERVAL then return end
    lastProcessTime = currentTime
    
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local source = tonumber(playerId)
        if source and playerWeaponCache[source] then
            local weaponHash = playerWeaponCache[source]
            local weaponData = GetWeaponModifier(weaponHash)
            
            if weaponData then
                -- Send weapon modifier to client
                TriggerClientEvent('stitch_weaponmods:applyModifier', source, weaponHash, weaponData)
            end
            
            -- Clear cache after processing
            playerWeaponCache[source] = nil
        end
    end
end

-- Handle player weapon change (optimized - just cache, don't process immediately)
RegisterNetEvent('stitch_weaponmods:weaponChanged')
AddEventHandler('stitch_weaponmods:weaponChanged', function(weaponHash)
    local source = source
    if not source or not isInitialized or not Config.Enabled then return end
    
    -- Just cache the weapon change, don't process immediately
    playerWeaponCache[source] = weaponHash
end)

-- Handle player connection (optimized - send only essential data)
AddEventHandler('playerConnecting', function()
    local source = source
    if not source or not isInitialized then return end
    
    -- Send only weapon modifiers, not full config
    TriggerClientEvent('stitch_weaponmods:initializeWeapons', source, weaponModifiers)
end)

-- Handle player dropped (optimized cleanup)
AddEventHandler('playerDropped', function()
    local source = source
    if not source then return end
    
    -- Clean up player cache immediately
    playerWeaponCache[source] = nil
    
    if Config.Debug then
        local playerName = GetPlayerName(source) or "Unknown"
        print(string.format("^3[Stitch Weapon Mods]^7 Player %s disconnected", playerName))
    end
end)

-- Main processing loop (runs every second to batch process weapon changes)
CreateThread(function()
    while true do
        if isInitialized and Config.Enabled then
            ProcessWeaponChanges()
        end
        Wait(1000) -- Process every second instead of every frame
    end
end)

-- Admin command to reload weapon modifiers
RegisterCommand('reloadweaponmods', function(source, args, rawCommand)
    if source ~= 0 then -- Only allow from console
        return
    end
    
    InitializeServerSystem()
    print("^2[Stitch Weapon Mods]^7 Weapon modifiers reloaded")
end, true)

-- Admin command to get weapon modifier info
RegisterCommand('weaponmodinfo', function(source, args, rawCommand)
    if source == 0 then return end -- Only allow from console
    
    if not args[1] then
        print("^3[Stitch Weapon Mods]^7 Usage: weaponmodinfo <weapon_hash>")
        return
    end
    
    local weaponHash = tonumber(args[1])
    if not weaponHash then
        print("^3[Stitch Weapon Mods]^7 Invalid weapon hash")
        return
    end
    
    local weaponData = GetWeaponModifier(weaponHash)
    if weaponData then
        print(string.format("^2[Stitch Weapon Mods]^7 Weapon %s: modifier=%.2f, disableCritical=%s", 
            weaponHash, weaponData.modifier, tostring(weaponData.disableCritical)))
    else
        print(string.format("^3[Stitch Weapon Mods]^7 Weapon %s not found in config", weaponHash))
    end
end, true)

-- Admin command to list all weapon modifiers
RegisterCommand('listweaponmods', function(source, args, rawCommand)
    if source == 0 then return end -- Only allow from console
    
    print("^2[Stitch Weapon Mods]^7 Current weapon modifiers:")
    for weaponHash, weaponData in pairs(weaponModifiers) do
        print(string.format("  %s: modifier=%.2f, disableCritical=%s", 
            weaponHash, weaponData.modifier, tostring(weaponData.disableCritical)))
    end
end, true)

-- Initialize on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Debug then
            print("^2[Stitch Weapon Mods]^7 Server resource started")
        end
        InitializeServerSystem()
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Debug then
            print("^1[Stitch Weapon Mods]^7 Server resource stopped")
        end
        isInitialized = false
        weaponModifiers = {}
    end
end)

-- Initialize immediately
InitializeServerSystem()
