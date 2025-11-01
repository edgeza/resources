-- Stitch Weapon Mods Client
-- Enhanced weapon modification system with real-time control

local QBCore = exports['qb-core']:GetCoreObject()

-- Local variables
local currentWeapon = nil
local weaponModifiers = {}
local isWeaponEquipped = false

-- Apply weapon modifiers
local function applyWeaponModifiers(weapon)
    local modifiers = weaponModifiers[weapon]
    if not modifiers then return end
    
    local ped = PlayerPedId()
    
    -- Apply damage modifier
    if modifiers.damage ~= 1.0 then
        SetWeaponDamageModifier(weapon, modifiers.damage)
    end
    
    -- Apply recoil modifier
    if modifiers.recoil ~= 1.0 then
        SetWeaponRecoilModifier(ped, modifiers.recoil)
    end
    
    -- Apply accuracy modifier
    if modifiers.accuracy ~= 1.0 then
        SetWeaponAccuracyModifier(ped, modifiers.accuracy)
    end
    
    -- Apply range modifier
    if modifiers.range ~= 1.0 then
        SetWeaponRangeModifier(ped, modifiers.range)
    end
    
    -- Apply fire rate modifier
    if modifiers.fireRate ~= 1.0 then
        SetWeaponFireRateModifier(ped, modifiers.fireRate)
    end
    
    -- Apply mobility modifier
    if modifiers.mobility ~= 1.0 then
        SetWeaponMobilityModifier(ped, modifiers.mobility)
    end
    
    -- Apply stability modifier
    if modifiers.stability ~= 1.0 then
        SetWeaponStabilityModifier(ped, modifiers.stability)
    end
    
    if Config.Debug then
        print("^3[Stitch Weapon Mods]^7 Applied modifiers for " .. weapon)
    end
end

-- Remove weapon modifiers
local function removeWeaponModifiers()
    local ped = PlayerPedId()
    
    -- Reset all modifiers to default
    SetWeaponRecoilModifier(ped, 1.0)
    SetWeaponAccuracyModifier(ped, 1.0)
    SetWeaponRangeModifier(ped, 1.0)
    SetWeaponFireRateModifier(ped, 1.0)
    SetWeaponMobilityModifier(ped, 1.0)
    SetWeaponStabilityModifier(ped, 1.0)
    
    if Config.Debug then
        print("^3[Stitch Weapon Mods]^7 Removed weapon modifiers")
    end
end

-- Check if player has a weapon equipped
local function checkWeaponEquipped()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    
    if weapon ~= `WEAPON_UNARMED` then
        local weaponName = GetWeaponNameFromHash(weapon)
        if weaponName and weaponName ~= currentWeapon then
            currentWeapon = weaponName
            isWeaponEquipped = true
            
            -- Request weapon modifiers from server
            TriggerServerEvent('weaponmods:getWeaponModifiers', weaponName)
        end
    else
        if isWeaponEquipped then
            removeWeaponModifiers()
            currentWeapon = nil
            isWeaponEquipped = false
        end
    end
end

-- Main weapon monitoring loop
CreateThread(function()
    while true do
        if Config.Enabled then
            checkWeaponEquipped()
            
            if isWeaponEquipped and currentWeapon and weaponModifiers[currentWeapon] then
                applyWeaponModifiers(currentWeapon)
            end
        end
        
        Wait(Config.UpdateFrequency)
    end
end)

-- Event handlers
RegisterNetEvent('weaponmods:receiveWeaponModifiers', function(weapon, modifiers)
    weaponModifiers[weapon] = modifiers
    
    if currentWeapon == weapon then
        applyWeaponModifiers(weapon)
    end
end)

RegisterNetEvent('weaponmods:updateWeaponModifier', function(weapon, property, value)
    if weaponModifiers[weapon] then
        weaponModifiers[weapon][property] = value
        
        if currentWeapon == weapon then
            applyWeaponModifiers(weapon)
        end
        
        if Config.Debug then
            print("^3[Stitch Weapon Mods]^7 Updated " .. weapon .. " " .. property .. " to " .. value)
        end
    end
end)

RegisterNetEvent('weaponmods:resetWeapon', function(weapon, modifiers)
    weaponModifiers[weapon] = modifiers
    
    if currentWeapon == weapon then
        applyWeaponModifiers(weapon)
    end
    
    if Config.Debug then
        print("^3[Stitch Weapon Mods]^7 Reset " .. weapon .. " to defaults")
    end
end)

RegisterNetEvent('weaponmods:applyDamage', function(weapon, damageModifier)
    local ped = PlayerPedId()
    SetWeaponDamageModifier(weapon, damageModifier)
    
    if Config.Debug then
        print("^3[Stitch Weapon Mods]^7 Applied damage modifier " .. damageModifier .. " to " .. weapon)
    end
end)

-- Weapon switching detection
RegisterNetEvent('weapons:client:SetCurrentWeapon', function(weaponData, shootbool)
    if weaponData then
        currentWeapon = weaponData.name
        isWeaponEquipped = true
        
        -- Request modifiers for this weapon
        TriggerServerEvent('weaponmods:getWeaponModifiers', weaponData.name)
    else
        removeWeaponModifiers()
        currentWeapon = nil
        isWeaponEquipped = false
    end
end)

-- Player spawn event
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- Reset weapon state
    currentWeapon = nil
    isWeaponEquipped = false
    weaponModifiers = {}
end)

-- Player logout event
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    -- Clean up
    removeWeaponModifiers()
    currentWeapon = nil
    isWeaponEquipped = false
    weaponModifiers = {}
end)

-- Debug command for testing
RegisterCommand('testweaponmods', function()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    
    if weapon ~= `WEAPON_UNARMED` then
        local weaponName = GetWeaponNameFromHash(weapon)
        local modifiers = weaponModifiers[weaponName]
        
        if modifiers then
            local info = string.format(
                "^3%s^7 - Damage: %.1f | Recoil: %.1f | Accuracy: %.1f | Range: %.1f | Fire Rate: %.1f | Reload: %.1f | Mobility: %.1f | Stability: %.1f",
                weaponName, modifiers.damage, modifiers.recoil, modifiers.accuracy, modifiers.range, 
                modifiers.fireRate, modifiers.reload, modifiers.mobility, modifiers.stability
            )
            
            TriggerEvent('chat:addMessage', {
                color = {255, 255, 255},
                multiline = true,
                args = {"Current Weapon Modifiers", info}
            })
        else
            TriggerEvent('QBCore:Notify', 'No modifiers found for current weapon', 'error')
        end
    else
        TriggerEvent('QBCore:Notify', 'No weapon equipped', 'error')
    end
end)

-- Initialize on resource start
CreateThread(function()
    Wait(1000) -- Wait for other resources to load
    print("^2[Stitch Weapon Mods]^7 Client initialized with enhanced weapon modification system")
end)
