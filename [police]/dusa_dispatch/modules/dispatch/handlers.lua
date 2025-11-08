---handlers---
if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end

local config = config or require('config')

local Functions = Functions or {}

local timer = {}

---@param name string
---@param action function
---@vararg any
local function WaitTimer(name, action, ...)
    if not config.DefaultAlerts[name] then return end

    if not timer[name] then
        timer[name] = true
        action(...)
        Wait(config.DefaultAlertsDelay * 1000)
        timer[name] = false
    end
end

local function isPedAWitness(witnesses, ped)
    for _, v in pairs(witnesses) do
        if v == ped then return true end
    end
    return false
end

local function BlacklistedWeapon(ped)
    for i = 1, #config.WeaponWhitelist do
        if GetSelectedPedWeapon(ped) == joaat(config.WeaponWhitelist[i]) then
            return true
        end
    end
    return false
end

-- Gunshot Event
AddEventHandler('CEventGunShot', function(witnesses, ped)
    if IsPedCurrentWeaponSilenced(ped) then return end
    if inNoDispatchZone then return end
    if BlacklistedWeapon(ped) then return end
    WaitTimer('Shooting', function()
        if PlayerPedId() ~= ped then return end

        local coords = GetEntityCoords(ped)
        if inHuntingZone then
            exports['dusa_dispatch']:Hunting(coords)
            return
        end

        local job = Framework.Player.Job.Name
        local isPolice = Functions.IsPolice(job)
        
        -- Check if police should send alert based on config
        if isPolice and not config.IncludePolice then return end

        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle and vehicle > 0 then
            exports['dusa_dispatch']:VehicleShooting(coords)
        else
            exports['dusa_dispatch']:Shooting(coords)
        end
    end)
end)

--  Melee Event
AddEventHandler('CEventShockingSeenMeleeAction', function(witnesses, ped)
    WaitTimer('Melee', function()
        if PlayerPedId() ~= ped then return end
        if witnesses and not isPedAWitness(witnesses, ped) then return end
        if not IsPedInMeleeCombat(ped) then return end

        exports['dusa_dispatch']:Fight(GetEntityCoords(ped))
    end)
end)

--  Car Jacking
AddEventHandler('CEventPedJackingMyVehicle', function(_, ped)
    WaitTimer('Autotheft', function()
        if PlayerPedId() ~= ped then return end
        local vehicle = GetVehiclePedIsUsing(ped, true)
        exports['dusa_dispatch']:CarJacking(vehicle, GetEntityCoords(ped))
    end)
end)

-- Car Alarm Theft
AddEventHandler('CEventShockingCarAlarm', function(_, ped)
    WaitTimer('Autotheft', function()
        if PlayerPedId() ~= ped then return end
        local vehicle = GetVehiclePedIsUsing(ped, true)
        exports['dusa_dispatch']:VehicleTheft(vehicle, GetEntityCoords(ped))
    end)
end)

--  Explosion Event
AddEventHandler('CEventExplosionHeard', function(witnesses, ped)
    if witnesses and not isPedAWitness(witnesses, ped) then return end
    WaitTimer('Explosion', function()
        exports['dusa_dispatch']:Explosion(GetEntityCoords(ped))
    end)
end)

-- Player Downed Event
AddEventHandler('gameEventTriggered', function(name, args)
    if name ~= 'CEventNetworkEntityDamage' then return end
    local victim = args[1]
    local isDead = args[6] == 1
    WaitTimer('PlayerDowned', function()
        if not victim or victim ~= PlayerPedId() then return end
        if not isDead then return end

        local coords = GetEntityCoords(PlayerPedId())
        local job = Framework.Player.Job.Name

        if Functions.IsPolice(job) then
            exports['dusa_dispatch']:OfficerDown(coords)
        elseif Functions.IsEMS(job) then
            exports['dusa_dispatch']:EmsDown(coords)
        else
            exports['dusa_dispatch']:InjuriedPerson(coords)
        end
    end)
end)

-- Speeding Events
local SpeedingEvents = {
    'CEventShockingCarChase',
    'CEventShockingDrivingOnPavement',
    'CEventShockingBicycleOnPavement',
    'CEventShockingMadDriverBicycle',
    'CEventShockingMadDriverExtreme',
    'CEventShockingEngineRevved',
    'CEventShockingInDangerousVehicle'
}

local SpeedTrigger = 0
for _, event in ipairs(SpeedingEvents) do
    AddEventHandler(event, function(_, ped)
        WaitTimer('Speeding', function()
            local currentTime = GetGameTimer()
            if currentTime - SpeedTrigger < 10000 then return end
            if PlayerPedId() ~= ped then return end

            local vehicle = GetVehiclePedIsIn(ped, false)
            local isLeo = Functions.IsPolice(Framework.Player.Job.Name)
            if isLeo and not config.debug then return end
            if GetEntitySpeed(vehicle) * 3.6 < (80 + math.random(0, 20)) then return end
            if ped ~= GetPedInVehicleSeat(vehicle, -1) then return end

            exports['dusa_dispatch']:SpeedingVehicle(GetEntityCoords(ped))
            SpeedTrigger = GetGameTimer()
        end)
    end)
end
