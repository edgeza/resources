-- Stitch Weapon Mods Server
-- Enhanced weapon modification system with real-time control

local QBCore = exports['qb-core']:GetCoreObject()

-- Weapon modifier cache
local weaponModifiers = {}

-- Initialize weapon modifiers from config
local function initializeWeaponModifiers()
    for weapon, config in pairs(Config.Weapons) do
        weaponModifiers[weapon] = {
            damage = config.damageModifier,
            recoil = config.recoilModifier or 1.0,
            accuracy = config.accuracyModifier or 1.0,
            range = config.rangeModifier or 1.0,
            fireRate = config.fireRateModifier or 1.0,
            reload = config.reloadModifier or 1.0,
            mobility = config.mobilityModifier or 1.0,
            stability = config.stabilityModifier or 1.0,
            disableCritical = config.disableCritical or false
        }
    end
    print("^2[Stitch Weapon Mods]^7 Initialized weapon modifiers for " .. #Config.Weapons .. " weapons")
end

-- Get weapon modifiers for a specific weapon
local function getWeaponModifiers(weapon)
    return weaponModifiers[weapon] or {
        damage = 1.0,
        recoil = 1.0,
        accuracy = 1.0,
        range = 1.0,
        fireRate = 1.0,
        reload = 1.0,
        mobility = 1.0,
        stability = 1.0,
        disableCritical = false
    }
end

-- Update weapon modifier
local function updateWeaponModifier(weapon, property, value)
    if weaponModifiers[weapon] and weaponModifiers[weapon][property] then
        weaponModifiers[weapon][property] = value
        
        -- Notify all clients of the change
        TriggerClientEvent('weaponmods:updateWeaponModifier', -1, weapon, property, value)
        
        if Config.Debug then
            print("^3[Stitch Weapon Mods]^7 Updated " .. weapon .. " " .. property .. " to " .. value)
        end
    end
end

-- Commands for real-time weapon modification
RegisterCommand('setweaponmod', function(source, args)
    local src = source
    local weapon = args[1]
    local property = args[2]
    local value = tonumber(args[3])
    
    if not weapon or not property or not value then
        TriggerClientEvent('QBCore:Notify', src, 'Usage: /setweaponmod [weapon] [property] [value]', 'error')
        return
    end
    
    if not weaponModifiers[weapon] then
        TriggerClientEvent('QBCore:Notify', src, 'Weapon not found: ' .. weapon, 'error')
        return
    end
    
    local validProperties = {'damage', 'recoil', 'accuracy', 'range', 'fireRate', 'reload', 'mobility', 'stability'}
    if not table.contains(validProperties, property) then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid property. Valid: ' .. table.concat(validProperties, ', '), 'error')
        return
    end
    
    updateWeaponModifier(weapon, property, value)
    TriggerClientEvent('QBCore:Notify', src, 'Updated ' .. weapon .. ' ' .. property .. ' to ' .. value, 'success')
end, true) -- Ace permission required

-- Command to get weapon info
RegisterCommand('weaponinfo', function(source, args)
    local src = source
    local weapon = args[1]
    
    if not weapon then
        TriggerClientEvent('QBCore:Notify', src, 'Usage: /weaponinfo [weapon]', 'error')
        return
    end
    
    local modifiers = getWeaponModifiers(weapon)
    local info = string.format(
        "^3%s^7 - Damage: %.1f | Recoil: %.1f | Accuracy: %.1f | Range: %.1f | Fire Rate: %.1f | Reload: %.1f | Mobility: %.1f | Stability: %.1f",
        weapon, modifiers.damage, modifiers.recoil, modifiers.accuracy, modifiers.range, 
        modifiers.fireRate, modifiers.reload, modifiers.mobility, modifiers.stability
    )
    
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 255, 255},
        multiline = true,
        args = {"Weapon Info", info}
    })
end)

-- Command to reset weapon to defaults
RegisterCommand('resetweapon', function(source, args)
    local src = source
    local weapon = args[1]
    
    if not weapon then
        TriggerClientEvent('QBCore:Notify', src, 'Usage: /resetweapon [weapon]', 'error')
        return
    end
    
    if not weaponModifiers[weapon] then
        TriggerClientEvent('QBCore:Notify', src, 'Weapon not found: ' .. weapon, 'error')
        return
    end
    
    -- Reset to config defaults
    local config = Config.Weapons[weapon]
    if config then
        weaponModifiers[weapon] = {
            damage = config.damageModifier,
            recoil = config.recoilModifier or 1.0,
            accuracy = config.accuracyModifier or 1.0,
            range = config.rangeModifier or 1.0,
            fireRate = config.fireRateModifier or 1.0,
            reload = config.reloadModifier or 1.0,
            mobility = config.mobilityModifier or 1.0,
            stability = config.stabilityModifier or 1.0,
            disableCritical = config.disableCritical or false
        }
        
        -- Notify all clients
        TriggerClientEvent('weaponmods:resetWeapon', -1, weapon, weaponModifiers[weapon])
        TriggerClientEvent('QBCore:Notify', src, 'Reset ' .. weapon .. ' to defaults', 'success')
    end
end, true)

-- Command to list all weapons
RegisterCommand('listweapons', function(source, args)
    local src = source
    local weaponType = args[1] or 'all'
    
    local weapons = {}
    for weapon, _ in pairs(weaponModifiers) do
        if weaponType == 'all' or string.find(weapon, weaponType) then
            table.insert(weapons, weapon)
        end
    end
    
    table.sort(weapons)
    
    local message = "Available weapons: " .. table.concat(weapons, ', ')
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 255, 255},
        multiline = true,
        args = {"Weapon List", message}
    })
end)

-- Event to get weapon modifiers (called by client)
RegisterNetEvent('weaponmods:getWeaponModifiers', function(weapon)
    local src = source
    local modifiers = getWeaponModifiers(weapon)
    TriggerClientEvent('weaponmods:receiveWeaponModifiers', src, weapon, modifiers)
end)

-- Event to apply weapon damage modifier
RegisterNetEvent('weaponmods:applyDamageModifier', function(weapon, targetId)
    local src = source
    local modifiers = getWeaponModifiers(weapon)
    
    if modifiers.damage ~= 1.0 then
        TriggerClientEvent('weaponmods:applyDamage', targetId, weapon, modifiers.damage)
    end
end)

-- Initialize on resource start
CreateThread(function()
    Wait(1000) -- Wait for other resources to load
    initializeWeaponModifiers()
end)

-- Export functions for other resources
exports('getWeaponModifiers', getWeaponModifiers)
exports('updateWeaponModifier', updateWeaponModifier)
exports('getWeaponDamageModifier', function(weapon)
    local modifiers = getWeaponModifiers(weapon)
    return modifiers.damage
end)
exports('getWeaponRecoilModifier', function(weapon)
    local modifiers = getWeaponModifiers(weapon)
    return modifiers.recoil
end)
exports('getWeaponAccuracyModifier', function(weapon)
    local modifiers = getWeaponModifiers(weapon)
    return modifiers.accuracy
end)
