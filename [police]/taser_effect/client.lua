local stunnedCache = {}
local stunnedStack = 0

local disableControls = {
    [23] = true,  -- INPUT_ENTER
    [24] = true,  -- INPUT_ATTACK
    [25] = true,  -- INPUT_AIM
    [36] = true,  -- INPUT_DUCK
    [37] = true,  -- INPUT_SELECT_WEAPON
    [44] = true,  -- INPUT_COVER
    [45] = true,  -- INPUT_RELOAD
    [47] = true,  -- INPUT_DETONATE
    [140] = true, -- INPUT_MELEE_ATTACK_LIGHT
    [141] = true, -- INPUT_MELEE_ATTACK_HEAVY
    [142] = true, -- INPUT_MELEE_ATTACK_ALTERNATE
    [143] = true, -- INPUT_MELEE_BLOCK
    [257] = true, -- INPUT_ATTACK2
    [263] = true, -- INPUT_MELEE_ATTACK1
    [264] = true, -- INPUT_MELEE_ATTACK2
}

local function DisableControlActions()
    for control, state in pairs(disableControls) do
        DisableControlAction(0, control, state)
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
		Wait(0)
	end
end

local function IsPlayerDeadOrDying()
    return false
end

local function DoTaserEffect(effectLength)
    print("DoTaserEffect", effectLength)
    stunnedStack = stunnedStack + 1
    SetTimecycleModifierStrength(Config.TimecycleStrength)
    SetTimecycleModifier("dont_tazeme_bro")

    if Config.CameraShake then
        ShakeGameplayCam(Config.CameraShakeName, Config.CameraShakeIntensity)
    end

    Wait(effectLength)
    stunnedStack = stunnedStack - 1
    if stunnedStack == 0 then
        SetTransitionTimecycleModifier('default', Config.TimecycleTransitionDuration)
        if Config.CameraShake then
            StopGameplayCamShaking(false)
        end
    end
end

local function GetVehicleSeatPedIsIn(vehicle, ped)
    for seatIndex = -1, 14 do
        if GetPedInVehicleSeat(vehicle, seatIndex) == ped then
            return seatIndex
        end
    end

    return nil
end

local function PreventPedLeavingVehicle(ped, vehicle, time)
    local gameTimer = GetGameTimer() + time
    local seat = GetVehicleSeatPedIsIn(vehicle, ped)
    if not seat then return end

    LoadAnimDict("stungun@standing")
    TaskPlayAnim(ped, "stungun@standing", "damage", 2.0, 2.0, -1, 17, 0.0, false, false, false)

    CreateThread(function()
        while GetGameTimer() < gameTimer do
            if GetIsTaskActive(ped, 2) then
                SetPedIntoVehicle(ped, vehicle, seat)
            end

            DisableControlActions()

            if not IsEntityPlayingAnim(ped, "stungun@standing", "damage", 3) then
                TaskPlayAnim(ped, "stungun@standing", "damage", 2.0, 2.0, -1, 17, 0.0, false, false, false)
            end

            Wait(0)
        end

        if IsEntityPlayingAnim(ped, "stungun@standing", "damage", 3) then
            ClearPedTasks(ped)
        end

        RemoveAnimDict("stungun@standing")
    end)
end

local function OnLocalPlayerStunned(playerPed, attacker)
    -- Needed as weaponHash does not guarantee that we actually were stunned, and IsPedBeingStunned doesn't return true before a frame after beeing stunned
    SetTimeout(50, function()
        -- This usually won't effect the player ped the first time the get stunned.
        local groundTime = Config.MinGroundTime == Config.MaxGroundTime and Config.MinGroundTime or math.random(Config.MinGroundTime, Config.MaxGroundTime)
        SetPedMinGroundTimeForStungun(playerPed, groundTime)

        local gameTimer = GetGameTimer()
        -- If the player was stunned by the same source less them 2.8 seconds ago then ignore, this is to not spam the event when taking fall damage while beeing stunned
        if stunnedCache[attacker] and stunnedCache[attacker] + 2800 > gameTimer then
            return
        end

        if IsPedBeingStunned(playerPed, 0) then
            stunnedCache[attacker] = gameTimer

            if Config.PlayerStayInVehicle and not IsPlayerDeadOrDying() then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local vehicleClass = GetVehicleClass(vehicle)

                if vehicleClass ~= 8 and vehicleClass ~= 13 then
                    PreventPedLeavingVehicle(playerPed, vehicle, 8000)
                end
            end

            DoTaserEffect(groundTime)
        end
    end)
end

local function OnNPCStunned(args)
    local ped = args[1]

    if Config.DisableNPCWrithe then
        SetPedConfigFlag(ped, 281, true) -- Disable Writhe
    end

    if Config.NPCDropWeapon then
        Wait(400)
        local visible, _currentWeapon = GetCurrentPedWeapon(ped, true)
        if visible then
            SetPedDropsWeapon(ped)
        end
    end
end

-- Use game events to avoid unnecessary threads/loops
AddEventHandler('gameEventTriggered', function(event, args)
    if event == "CEventNetworkEntityDamage" then
        local weaponHash = args[7]
        if not Config.ValidWeapons[weaponHash] then
            return
        end

        local playerPed = PlayerPedId()
        local attacker = args[2]

        if playerPed == args[1] and attacker ~= -1 then
            OnLocalPlayerStunned(playerPed, attacker)
        elseif IsEntityAPed(args[1]) and not IsPedAPlayer(args[1]) and NetworkHasControlOfEntity(args[1]) then
            OnNPCStunned(args)
        end
    end
end)
