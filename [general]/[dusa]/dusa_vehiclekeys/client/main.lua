if not rawget(_G, "lib") then include('ox_lib', 'init') end

-----------------------
----   Variables   ----
-----------------------
local KeysList = {}
local AllKeys = {}
local isTakingKeys = false
local isCarjacking = false
local canCarjack = true
local AlertSend = false
local lastPickedVehicle = nil
local usingAdvanced = false
local IsHotwiring = false
local trunkclose = true
local looped = false
local LoggedIn = false
SYNC = {}

local function trimAndLowerPlate(plate)
    return string.lower(Framework.Trim(plate))
end

Framework.OnPlayerLoaded = function()
    GetKeys()
end

Framework.OnPlayerUnload = function()
    KeysList = {}
    AllKeys = {}
    lib.hideTextUI()
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        LoggedIn = true
        GetKeys()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        KeysList = {}
        AllKeys = {}
        lib.hideTextUI()
    end
end)

-- Sets the remote open decor for the local player to the given state
function SYNC:SetLockOpenState(vehNetId, state)
    SetVehicleDoorsLocked(NetworkGetEntityFromNetworkId(vehNetId), state)
end

local canbreak = false
local function robKeyLoop(seat)
    if looped == false then
        looped = true
        while true do
            local sleep = 1000
            if true then
                sleep = 100
                local ped = cache.ped
                local entering = GetVehiclePedIsTryingToEnter(ped)
                local vehicleEntity = GetVehiclePedIsIn(ped, false)
                local carIsImmune = false
                local plate = GetVehicleNumberPlateText(entering)
                if entering ~= 0 and not isBlacklistedVehicle(entering) then
                    sleep = 2000

                    local driver = GetPedInVehicleSeat(entering, -1)
                    for _, veh in ipairs(Config.ImmuneVehicles) do
                        if GetEntityModel(entering) == joaat(veh) then
                            carIsImmune = true
                        end
                    end
                    -- Driven vehicle logic
                    if driver ~= 0 and not IsPedAPlayer(driver) and not HasKeys(plate) and not carIsImmune and Config.EnableHotwire then
                        if IsEntityDead(driver) then
                            if not isTakingKeys then
                                isTakingKeys = true
                                TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState',
                                    NetworkGetNetworkIdFromEntity(entering), 1)
                                Framework.ProgressBar({
                                    duration = 10000,
                                    label = Config.Language['progress']['takekeys'],
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        car = true,
                                        combat = true,
                                        mouse = false,
                                        movement = false,
                                    },
                                    onFinish = function()
                                        TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plate)
                                        isTakingKeys = false
                                    end,
                                    onCancel = function()
                                        isTakingKeys = false
                                    end
                                })
                            end
                        elseif Config.LockNPCDrivingCars then
                            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState',
                                NetworkGetNetworkIdFromEntity(entering), 2)
                        else
                            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState',
                                NetworkGetNetworkIdFromEntity(entering), 1)
                            TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plate)

                            --Make passengers flee
                            local pedsInVehicle = GetPedsInVehicle(entering)
                            for _, pedInVehicle in pairs(pedsInVehicle) do
                                if pedInVehicle ~= GetPedInVehicleSeat(entering, -1) then
                                    MakePedFlee(pedInVehicle)
                                end
                            end
                        end
                        -- Parked car logic
                    elseif driver == 0 and entering ~= lastPickedVehicle and not HasKeys(plate) and not isTakingKeys and Config.EnableHotwire then
                        if not AllKeys[plate] then
                            local playerOwned = lib.callback.await('dusa_vehiclekeys:server:checkPlayerOwned', false,
                                plate)
                            if not playerOwned then
                                if Config.LockNPCParkedCars then
                                    TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState',
                                        NetworkGetNetworkIdFromEntity(entering), 2)
                                else
                                    TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState',
                                        NetworkGetNetworkIdFromEntity(entering), 1)
                                end
                            end
                        end
                    end
                end

                -- If trying to enter a player vehicle
                if entering ~= 0 and entering ~= lastPickedVehicle and not HasKeys(plate) and not isTakingKeys and Config.EnableHotwire then
                    local searchPlate = trimAndLowerPlate(plate)
                    -- Check if vehicle exists in AllKeys (player-owned)
                    if next(AllKeys) and AllKeys[searchPlate] then
                        -- Player-owned vehicle: always lock and prevent entry if player doesn't have keys
                        SetVehicleDoorsLocked(entering, 2)
                        ClearPedTasks(ped)
                    else
                        -- Check server-side if vehicle is player-owned (for vehicles not yet in AllKeys)
                        local playerOwned = lib.callback.await('dusa_vehiclekeys:server:checkPlayerOwned', false, plate)
                        if playerOwned then
                            -- Player-owned vehicle: lock it and prevent entry
                            SetVehicleDoorsLocked(entering, 2)
                            ClearPedTasks(ped)
                        end
                    end
                end

                -- Hotwiring while in vehicle, also keeps engine off for vehicles you don't own keys to
                if IsPedInAnyVehicle(ped, false) and not IsHotwiring and Config.EnableHotwire then
                    sleep = 1000
                    local vehicle = GetVehiclePedIsIn(ped)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local isDriver = GetPedInVehicleSeat(vehicle, -1) == cache.ped
                    
                    if isDriver and not HasKeys(plate) and not isBlacklistedVehicle(vehicle) and not AreKeysJobShared(vehicle) then
                        sleep = 0
                        
                        local searchPlate = trimAndLowerPlate(plate)
                        -- Check if vehicle is player-owned
                        local playerOwned = false
                        if next(AllKeys) and AllKeys[searchPlate] then
                            playerOwned = true
                        else
                            -- Only check server if not in local cache
                            playerOwned = lib.callback.await('dusa_vehiclekeys:server:checkPlayerOwned', false, plate)
                        end
                        
                        if playerOwned then
                            -- Eject player from driver seat if they don't have keys to player-owned vehicle
                            TaskLeaveVehicle(ped, vehicle, 0)
                            Wait(100)
                            SetVehicleDoorsLocked(vehicle, 2)
                            Framework.Notify(Config.Language['notify']['ydhk'], 'error')
                        else
                            -- Allow hotwiring for non-player-owned vehicles
                            local vehiclePos = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.0, 0.5)
                            lib.showTextUI(Config.Language['info']['skeys'])

                            SetVehicleEngineOn(vehicle, false, false, true)
                            if IsControlJustPressed(0, 74) then
                                -- Hotwire(vehicle, plate)
                                lib.hideTextUI()
                                OpenHotwire(vehicle, plate)
                            end
                        end
                    else
                        -- Hide UI if player has keys or is not in driver seat
                        lib.hideTextUI()
                    end
                else
                    -- Hide UI if not in vehicle or hotwiring is disabled
                    lib.hideTextUI()
                end

                if Config.CarJackEnable and canCarjack and Config.EnableHotwire then
                    local playerid = PlayerId()
                    local aiming, target = GetEntityPlayerIsFreeAimingAt(playerid)
                    if aiming and (target ~= nil and target ~= 0) then
                        if DoesEntityExist(target) and IsPedInAnyVehicle(target, false) and not IsEntityDead(target) and not IsPedAPlayer(target) then
                            local targetveh = GetVehiclePedIsIn(target)
                            for _, veh in ipairs(Config.ImmuneVehicles) do
                                if GetEntityModel(targetveh) == joaat(veh) then
                                    carIsImmune = true
                                end
                            end
                            if GetPedInVehicleSeat(targetveh, -1) == target and not IsBlacklistedWeapon() then
                                local pos = GetEntityCoords(ped, true)
                                local targetpos = GetEntityCoords(target, true)
                                if #(pos - targetpos) < 5.0 and not carIsImmune then
                                    CarjackVehicle(target)
                                end
                            end
                        end
                    end
                end
                if entering == 0 and not IsPedInAnyVehicle(ped, false) and GetSelectedPedWeapon(ped) == `WEAPON_UNARMED` or canbreak then
                    lib.hideTextUI()
                    looped = false
                    canbreak = false
                    break
                end
                
                -- Hide UI when player exits vehicle
                if not IsPedInAnyVehicle(ped, false) then
                    lib.hideTextUI()
                end
            end
            Wait(sleep)
        end
    end
end

function isBlacklistedVehicle(vehicle)
    local isBlacklisted = false
    for _, v in ipairs(Config.NoLockVehicles) do
        if GetHashKey(v) == GetEntityModel(vehicle) then
            isBlacklisted = true
            break;
        end
    end
    if Entity(vehicle).state.ignoreLocks or GetVehicleClass(vehicle) == 13 then isBlacklisted = true end
    return isBlacklisted
end

function addNoLockVehicles(model)
    Config.NoLockVehicles[#Config.NoLockVehicles + 1] = model
end

exports('addNoLockVehicles', addNoLockVehicles)

function removeNoLockVehicles(model)
    for k, v in pairs(Config.NoLockVehicles) do
        if v == model then
            Config.NoLockVehicles[k] = nil
        end
    end
end

exports('removeNoLockVehicles', removeNoLockVehicles)

function isBlacklistedVehicle(vehicle)
    local isBlacklisted = false
    for _, v in ipairs(Config.NoLockVehicles) do
        if GetHashKey(v) == GetEntityModel(vehicle) then
            isBlacklisted = true
            break;
        end
    end
    if Entity(vehicle).state.ignoreLocks or GetVehicleClass(vehicle) == 13 then isBlacklisted = true end
    return isBlacklisted
end

function addNoLockVehicles(model)
    Config.NoLockVehicles[#Config.NoLockVehicles + 1] = model
end

exports('addNoLockVehicles', addNoLockVehicles)

function removeNoLockVehicles(model)
    for k, v in pairs(Config.NoLockVehicles) do
        if v == model then
            Config.NoLockVehicles[k] = nil
        end
    end
end

exports('removeNoLockVehicles', removeNoLockVehicles)

-----------------------
---- Client Events ----
-----------------------
local toggleLockKeybind = lib.addKeybind({
    name = 'togglelock',
    description = Config.Language['info']['tlock'],
    defaultKey = Config.ToggleLockKey,
    onPressed = function(self)
        local ped = cache.ped
        if IsPedInAnyVehicle(ped, false) then
            ToggleVehicleLockswithoutnui(GetVehicle())
        else
            if Config.UseKeyfob then
                openmenu()
            else
                ToggleVehicleLockswithoutnui(GetVehicle())
            end
        end
    end,
})

if Config.EngineKey then
    local toggleEngine = lib.addKeybind({
        name = 'engine',
        description = Config.Language['info']['engine'],
        defaultKey = Config.EngineKey,
        onPressed = function(self)
            local vehicle = GetVehicle()
            if vehicle and IsPedInVehicle(cache.ped, vehicle) then
                ToggleEngine(vehicle)
            end
        end,
    })
end

RegisterNetEvent('dusa_vehiclekeys:client:AddKeys', function(plate)
    local addPlate = trimAndLowerPlate(plate)
    KeysList[addPlate] = true
    local ped = cache.ped
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped)
        local vehicleplate = string.lower(GetVehicleNumberPlateText(vehicle))
        if addPlate == vehicleplate then
            SetVehicleEngineOn(vehicle, false, false, false)
            -- Hide hotwire UI when player gets keys
            lib.hideTextUI()
        end
    end
end)

RegisterNetEvent('dusa_vehiclekeys:client:RemoveKeys', function(plate)
    local removePlate = trimAndLowerPlate(plate)
    KeysList[removePlate] = nil
end)

RegisterNetEvent('dusa_vehiclekeys:client:ToggleEngine', function()
    local vehicle = GetVehiclePedIsIn(cache.ped, true)
    local EngineOn = GetIsVehicleEngineRunning(vehicle)
    local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
    if HasKeys(hasPlate) then
        if EngineOn then
            SetVehicleEngineOn(vehicle, false, false, true)
        else
            SetVehicleEngineOn(vehicle, true, false, true)
        end
    end
end)

RegisterNetEvent('dusa_vehiclekeys:client:GiveKeys', function(id)
    local targetVehicle = GetVehicle()
    if not targetVehicle or targetVehicle == 0 then
        Framework.Notify(Config.Language['notify']['vehclose'], 'error')
        return
    end
    
    local targetPlate = trimAndLowerPlate(GetVehicleNumberPlateText(targetVehicle))
    if not targetPlate or targetPlate == '' then
        Framework.Notify(Config.Language['notify']['vehclose'], 'error')
        return
    end
    
    if HasKeys(targetPlate) then
        if id and type(id) == "number" then -- Give keys to specific ID
            GiveKeys(id, targetPlate)
        else
            if IsPedSittingInVehicle(cache.ped, targetVehicle) then -- Give keys to everyone in vehicle
                local otherOccupants = GetOtherPlayersInVehicle(targetVehicle)
                for p = 1, #otherOccupants do
                    TriggerServerEvent('dusa_vehiclekeys:server:GiveVehicleKeys',
                        GetPlayerServerId(NetworkGetPlayerIndexFromPed(otherOccupants[p])), targetPlate)
                end
            else -- Give keys to closest player
                local coords = GetEntityCoords(cache.ped)
                local closestPlayer = lib.getClosestPlayer(coords, 3.5)
                if closestPlayer then
                    GiveKeys(GetPlayerServerId(closestPlayer), targetPlate)
                else
                    Framework.Notify(Config.Language['notify']['nonear'], 'error')
                end
            end
        end
    else
        Framework.Notify(Config.Language['notify']['ydhk'], 'error')
    end
end)

RegisterNetEvent('QBCore:Client:EnteringVehicle')
AddEventHandler('QBCore:Client:EnteringVehicle', function(player, seat)
    robKeyLoop(seat)
end)

RegisterNetEvent('baseevents:enteringVehicle')
AddEventHandler('baseevents:enteringVehicle', function(player, seat)
    robKeyLoop(seat)
end)

RegisterNetEvent('weapons:client:DrawWeapon', function()
    Wait(2000)
    robKeyLoop()
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    LockpickDoor(isAdvanced)
end)

-- Backwards Compatibility ONLY -- Remove at some point --
RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate, isadmin)
    TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plate)
    if isadmin then
        isTakingKeys = true
        Wait(5000)
        isTakingKeys = false
    end
end)
-- Backwards Compatibility ONLY -- Remove at some point --

-----------------------
----   Functions   ----
-----------------------
function openmenu(type)
    local vehicle = GetVehicle()
    local enginehealth = Framework.Round(GetVehicleEngineHealth(vehicle) / 10)
    local fuel = Framework.Round(GetVehicleFuelLevel(vehicle))
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 0.5, "key", 0.3)
    SendNUIMessage({ action = type, engineHealth = enginehealth, fuel = fuel })
    SetNuiFocus(true, true)
end

function isBlacklistedVehicle(vehicle)
    local isBlacklisted = false
    for _, v in ipairs(Config.NoLockVehicles) do
        if GetHashKey(v) == GetEntityModel(vehicle) then
            isBlacklisted = true
            break;
        end
    end
    if Entity(vehicle).state.ignoreLocks or GetVehicleClass(vehicle) == 13 then isBlacklisted = true end
    return isBlacklisted
end

function ToggleEngine(veh)
    if veh then
        local EngineOn = GetIsVehicleEngineRunning(veh)
        if not isBlacklistedVehicle(veh) then
            local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(veh))
            if HasKeys(hasPlate) or AreKeysJobShared(veh) then
                if EngineOn then
                    SetVehicleEngineOn(veh, false, false, true)
                else
                    SetVehicleEngineOn(veh, true, true, true)
                end
            end
        end
    end
end

-- Variables to track function calls
local lockCallCount = 0
local lastLockTime = 0

function ToggleVehicleLockswithoutnui(veh)
    -- Get current time
    local currentTime = GetGameTimer()

    -- Check if function is being called too soon after last call
    if currentTime - lastLockTime < 2000 then
        -- Function called too soon, ignore
        return
    end

    -- Update last call time
    lastLockTime = currentTime

    -- Increment call counter
    lockCallCount = lockCallCount + 1

    -- Check if function has been called 10 times
    if lockCallCount >= 10 then
        TriggerServerEvent('vehiclekeys:server:dropExploiter')
    end

    -- Original function logic
    if veh then
        if not isBlacklistedVehicle(veh) then
            local plt = GetVehicleNumberPlateText(veh)
            local hasPlate = trimAndLowerPlate(plt)
            if HasKeys(hasPlate) or AreKeysJobShared(veh) then
                local ped = cache.ped

                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false,
                    false)

                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                NetworkRequestControlOfEntity(veh)
                if AllKeys[plt] then
                    if AllKeys[plt].locked == false then
                        TriggerServerEvent('dusa_vehiclekeys:sv:syncPlate', plt, true)
                        SetVehicleDoorsLocked(veh, 2)
                        SetVehicleDoorShut(veh, 0, 0)
                        SetVehicleDoorShut(veh, 1, 0)
                        Framework.Notify(Config.Language['notify']['vlock'], "success")
                        AllKeys[plt].locked = true
                    elseif AllKeys[plt].locked == true then
                        TriggerServerEvent('dusa_vehiclekeys:sv:syncPlate', plt, false)
                        SetVehicleDoorsLocked(veh, 1)
                        Framework.Notify(Config.Language['notify']['vunlock'], "success")
                        AllKeys[plt].locked = false
                    end
                else
                    if GetVehicleDoorLockStatus(veh) == 1 then
                        TriggerServerEvent('dusa_vehiclekeys:sv:syncPlate', plt, true)
                        SetVehicleDoorsLocked(veh, 2)
                        SetVehicleDoorShut(veh, 0, 0)
                        SetVehicleDoorShut(veh, 1, 0)
                        Framework.Notify(Config.Language['notify']['vlock'], "success")
                        -- AllKeys[plt].locked = true
                    else
                        TriggerServerEvent('dusa_vehiclekeys:sv:syncPlate', plt, false)
                        SetVehicleDoorsLocked(veh, 1)
                        Framework.Notify(Config.Language['notify']['vunlock'], "success")
                        -- AllKeys[plt].locked = false
                    end
                end

                SetVehicleLights(veh, 2)
                Wait(250)
                SetVehicleLights(veh, 1)
                Wait(200)
                SetVehicleLights(veh, 0)
                Wait(300)
                ClearPedTasks(ped)
            else
                Framework.Notify(Config.Language['notify']['ydhk'], 'error')
            end
        else
            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
        end
    end

    -- Reset counter after some time (e.g. 30 seconds of inactivity)
    SetTimeout(30000, function()
        if GetGameTimer() - lastLockTime >= 30000 then
            lockCallCount = 0
        end
    end)
end

function GiveKeys(id, plate)
    local distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id))))
    local givePlate = string.lower(plate)
    if distance < 2.5 and distance > 0.0 then
        TriggerServerEvent('dusa_vehiclekeys:server:GiveVehicleKeys', id, givePlate)
    else
        Framework.Notify(Config.Language['notify']['nonear'], 'error')
    end
end

function GetKeys()
    local keysList, allVeh = lib.callback.await('dusa_vehiclekeys:server:GetVehicleKeys', false)
    KeysList = keysList
    AllKeys = allVeh
end

function HasKeys(plate)
    if not plate then return false end

    -- If hotwiring is disabled, everyone has keys to all vehicles
    if not Config.EnableHotwire then
        return true
    end

    local hasPlate = trimAndLowerPlate(plate)

    return KeysList[hasPlate]
end

exports('HasKeys', HasKeys)
exports('HasKey', HasKeys)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function GetVehicle()
    local ped = cache.ped
    local pos = GetEntityCoords(ped)
    local vehicle = GetVehiclePedIsIn(cache.ped)

    while vehicle == 0 do
        vehicle = lib.getClosestVehicle(pos, 5.0)
        if #(pos - GetEntityCoords(vehicle)) > 8 then
            Framework.Notify(Config.Language['notify']['vehclose'], "error")
            return
        end
    end

    if not IsEntityAVehicle(vehicle) then vehicle = nil end
    return vehicle
end

function AreKeysJobShared(veh)
    local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    local vehPlate = GetVehicleNumberPlateText(veh)
    local jobName = Framework.Player.Job.Name
    for job, v in pairs(Config.SharedKeys) do
        if job == jobName then
            for _, vehicle in pairs(v.vehicles) do
                if string.upper(vehicle) == string.upper(vehName) then
                    local hasPlate = trimAndLowerPlate(vehPlate)
                    if not HasKeys(hasPlate) then
                        TriggerServerEvent("dusa_vehiclekeys:server:AcquireVehicleKeys", hasPlate)
                    end
                    return true
                end
            end
        end
    end
    return false
end

function ToggleVehicleLocks(veh)
    if veh then
        if not isBlacklistedVehicle(veh) then
            local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(veh))
            if HasKeys(hasPlate) or AreKeysJobShared(veh) then
                local ped = cache.ped
                local vehLockStatus = GetVehicleDoorLockStatus(veh)
                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false,
                    false)
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                NetworkRequestControlOfEntity(veh)
                while NetworkGetEntityOwner(veh) ~= 128 do
                    NetworkRequestControlOfEntity(veh)
                    Wait(0)
                end
                if vehLockStatus == 1 then
                    TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 2)
                    Framework.Notify(Config.Language['notify']['vlock'], "primary")
                end
                SetVehicleLights(veh, 2)
                Wait(250)
                SetVehicleLights(veh, 1)
                Wait(200)
                SetVehicleLights(veh, 0)
                Wait(300)
                ClearPedTasks(ped)
            else
                Framework.Notify(Config.Language['notify']['ydhk'], 'error')
            end
        else
            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
        end
    end
end

function ToggleVehicleunLocks(veh)
    if veh then
        if not isBlacklistedVehicle(veh) then
            local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(veh))
            if HasKeys(hasPlate) or AreKeysJobShared(veh) then
                local ped = cache.ped
                local vehLockStatus = GetVehicleDoorLockStatus(veh)
                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false,
                    false)
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                NetworkRequestControlOfEntity(veh)
                if vehLockStatus == 2 then
                    TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
                    Framework.Notify(Config.Language['notify']['vunlock'], "success")
                end
                SetVehicleLights(veh, 2)
                Wait(250)
                SetVehicleLights(veh, 1)
                Wait(200)
                SetVehicleLights(veh, 0)
                Wait(300)
                ClearPedTasks(ped)
            else
                Framework.Notify(Config.Language['notify']['ydhk'], 'error')
            end
        else
            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
        end
    end
end

function ToggleVehicleTrunk(veh)
    if veh then
        if not isBlacklistedVehicle(veh) then
            local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(veh))
            if HasKeys(hasPlate) or AreKeysJobShared(veh) then
                local ped = cache.ped
                local boot = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'boot')
                loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false,
                    false)
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                NetworkRequestControlOfEntity(veh)
                if boot ~= -1 or DoesEntityExist(veh) then
                    if trunkclose == true then
                        SetVehicleLights(veh, 2)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 0)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 2)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 0)
                        Citizen.Wait(150)
                        SetVehicleDoorOpen(veh, 5)
                        trunkclose = false
                        ClearPedTasks(ped)
                    else
                        SetVehicleLights(veh, 2)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 0)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 2)
                        Citizen.Wait(150)
                        SetVehicleLights(veh, 0)
                        Citizen.Wait(150)
                        SetVehicleDoorShut(veh, 5)
                        trunkclose = true
                        ClearPedTasks(ped)
                    end
                end
            else
                Framework.Notify(Config.Language['notify']['ydhk'], 'error')
            end
        else
            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(veh), 1)
        end
    end
end

function GetOtherPlayersInVehicle(vehicle)
    local otherPeds = {}
    for seat = -1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2 do
        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
        if IsPedAPlayer(pedInSeat) and pedInSeat ~= cache.ped then
            otherPeds[#otherPeds + 1] = pedInSeat
        end
    end
    return otherPeds
end

function GetPedsInVehicle(vehicle)
    local otherPeds = {}
    for seat = -1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2 do
        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
        if not IsPedAPlayer(pedInSeat) and pedInSeat ~= 0 then
            otherPeds[#otherPeds + 1] = pedInSeat
        end
    end
    return otherPeds
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(cache.ped)
    if weapon ~= nil then
        for _, v in pairs(Config.NoCarjackWeapons) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

local canfight = true
function LockpickDoor(isAdvanced)
    local ped = cache.ped
    local pos = GetEntityCoords(ped)
    local vehicle = lib.getClosestVehicle(pos, 5.0)

    if vehicle == nil or vehicle == 0 then return end
    if HasKeys(GetVehicleNumberPlateText(vehicle)) then return end
    if #(pos - GetEntityCoords(vehicle)) > 2.5 then return end
    if GetVehicleDoorLockStatus(vehicle) <= 0 then return end
    if not Config.EnableHotwire then return end

    usingAdvanced = isAdvanced
    Config.LockPickDoorEvent()
end

function LockpickFinishCallback(success)
    local pos = GetEntityCoords(cache.ped)
    local vehicle = lib.getClosestVehicle(pos, 5.0)

    local chance = math.random()
    if success then
        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
        lastPickedVehicle = vehicle
        local acquirePlate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))

        if GetPedInVehicleSeat(vehicle, -1) == cache.ped then
            TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', acquirePlate)
        else
            Framework.Notify(Config.Language['notify']['vlockpick'], 'success')
            TriggerServerEvent('dusa_vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 1)
        end
    else
        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
        AlertPolice("steal", vehicle)
        if Config.AlertOwner then
            local chance = math.random(0, 100)
            if chance < Config.AlertChance and canfight then
                canfight = false
                Fight()
                Wait(2 * 60000)
                canfight = true
            end
        end
    end

    if usingAdvanced then
        if chance <= Config.RemoveLockpickAdvanced then
            TriggerServerEvent("dusa_vehiclekeys:server:breakLockpick", "advancedlockpick")
        end
    else
        if chance <= Config.RemoveLockpickNormal then
            TriggerServerEvent("dusa_vehiclekeys:server:breakLockpick", "lockpick")
        end
    end
end

function HotwireMinigame()
    Hotwire(vehicle, plate)
end

function Hotwire(vehicle, plate)
    if not Config.EnableHotwire then return end
    
    local hotwireTime = math.random(Config.minHotwireTime, Config.maxHotwireTime)
    local ped = cache.ped
    local veh = GetVehicle()
    local plt = trimAndLowerPlate(GetVehicleNumberPlateText(veh))
    IsHotwiring = true

    SetVehicleAlarm(vehicle, true)
    SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
    Framework.ProgressBar({
        duration = hotwireTime,
        label = Config.Language['progress']['hotwiring'],
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            combat = true,
            mouse = false,
            movement = false,
        },
        anim = {
            dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            clip = "machinic_loop_mechandplayer",
        },
        onFinish = function()
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
            -- TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plate)
            TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plt)

            Wait(Config.TimeBetweenHotwires)
            IsHotwiring = false
            -- Hide hotwire UI after successful hotwiring
            lib.hideTextUI()
        end,
        onCancel = function()
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            IsHotwiring = false
            -- Hide hotwire UI when hotwiring is cancelled
            lib.hideTextUI()
        end
    })

    SetTimeout(Config.AlertCooldown, function()
        AlertPolice("steal", veh)
    end)
    IsHotwiring = false
end

function CarjackVehicle(target)
    if not Config.CarJackEnable then return end
    isCarjacking = true
    canCarjack = false
    loadAnimDict('mp_am_hold_up')
    local vehicle = GetVehiclePedIsUsing(target)
    local occupants = GetPedsInVehicle(vehicle)
    for p = 1, #occupants do
        local ped = occupants[p]
        CreateThread(function()
            TaskPlayAnim(ped, "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 49, 0, false, false, false)
            PlayPain(ped, 6, 0)
        end)
        Wait(math.random(200, 500))
    end
    -- Cancel progress bar if: Ped dies during robbery, car gets too far away
    CreateThread(function()
        while isCarjacking do
            local distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(target))
            FreezeEntityPosition(vehicle, true)
            if IsPedDeadOrDying(target) or distance > 7.5 then
                TriggerEvent("progressbar:client:cancel")
                TriggerEvent("rprogress:stop")
                TriggerEvent("mythic_progbar:client:cancel")
            end
            Wait(100)
        end
    end)

    Framework.ProgressBar({
        duration = Config.CarjackingTime,
        label = Config.Language['progress']['stealingkeys'],
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            combat = true,
            mouse = false,
            movement = false,
        },
        onFinish = function()
            local hasWeapon, weaponHash = GetCurrentPedWeapon(cache.ped, true)
            if hasWeapon and isCarjacking then
                local carjackChance
                if Config.CarjackChance[tostring(GetWeapontypeGroup(weaponHash))] then
                    carjackChance = Config.CarjackChance[tostring(GetWeapontypeGroup(weaponHash))]
                else
                    carjackChance = 0.5
                end
                if math.random() <= carjackChance then
                    local plate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
                    for p = 1, #occupants do
                        local ped = occupants[p]
                        CreateThread(function()
                            TaskLeaveVehicle(ped, vehicle, 0)
                            PlayPain(ped, 6, 0)
                            Wait(1250)
                            ClearPedTasksImmediately(ped)
                            PlayPain(ped, math.random(7, 8), 0)
                            MakePedFlee(ped)
                        end)
                    end
                    TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', plate)
                    FreezeEntityPosition(vehicle, false)
                else
                    Framework.Notify(Config.Language['notify']['cjackfail'], "error")
                    MakePedFlee(target)
                end
                isCarjacking = false
                Wait(2000)
                AlertPolice("carjack", vehicle)
                Wait(Config.DelayBetweenCarjackings)
                canCarjack = true
            end
        end,
        onCancel = function()
            MakePedFlee(target)
            isCarjacking = false
            Wait(Config.DelayBetweenCarjackings)
            canCarjack = true
        end
    })
end

function MakePedFlee(ped)
    SetPedFleeAttributes(ped, 0, 0)
    TaskReactAndFleePed(ped, cache.ped)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-----------------------
----   NUICallback   ----
-----------------------
RegisterNUICallback('closeui', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('togglelock', function(data)
    if data.toggle then
        ToggleVehicleLocks(GetVehicle())
    else
        ToggleVehicleunLocks(GetVehicle())
    end
end)

RegisterNUICallback('trunk', function()
    ToggleVehicleTrunk(GetVehicle())
end)

RegisterNUICallback('engine', function()
    ToggleEngine(GetVehicle())
end)

RegisterNUICallback('light', function(data)
    if data.boolean then
        SetVehicleLights(GetVehicle(), 2)
    else
        SetVehicleLights(GetVehicle(), 0)
    end
end)

local stored = {}
local minigame = false
function OpenHotwire(vehicle, plate)
    if not Config.EnableHotwire then return end
    
    -- TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 0.5, "key", 0.3)
    SendNUIMessage({ action = 'open', hotwirechance = Config.HotwireChance })
    SetNuiFocus(true, true)
    stored = { vehicle, plate }
    minigame = true
    loadAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(cache.ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3.0, 1.0, -1,
        49, 1, 0, 0, 0)
    if Config.HotwireCamera then
        SetGameplayCamRelativeHeading(GetEntityHeading(GetVehicle()))
        camLoop()
    end
end

RegisterNUICallback('hotwirefailed', function()
    local ped = cache.ped
    local currenthealth = GetEntityHealth(ped)
    local damage = currenthealth - 5
    local vehicle = GetVehiclePedIsUsing(ped)
    minigame = false
    ClearPedTasks(ped)
    SetNuiFocus(false, false)
    SetEntityHealth(ped, damage)
    SetFlash(0, 0, 100, 10000, 100)
    stored = {}
end)

RegisterNUICallback('hotwiresuccess', function()
    SetNuiFocus(false, false)
    Hotwire(stored[1], stored[2])
    minigame = false
end)

local check = false
function camLoop()
    while true do
        if minigame then
            -- SetFollowPedCamViewMode(4)
            recentViewMode = GetFollowVehicleCamViewMode()
            local context = GetCamActiveViewModeContext()
            SetCamViewModeForContext(context, 4)
        else
            local context = GetCamActiveViewModeContext()
            SetCamViewModeForContext(context, 1)
            changedViewMode = false
            check = false
            break;
        end
        Wait(0)
    end
end

function Fight()
    if not Config.EnableHotwire then return end
    
    Framework.Notify(Config.Language['notify']["alertowner"], 'error')
    SetFlash(0, 0, 100, 5000, 100)
    local ped = cache.ped
    local playerPos = GetEntityCoords(ped)
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(playerPos.x + math.random(-35, 35),
        playerPos.y + math.random(-35, 35), playerPos.z, 0, 3, 0)

    local random = math.random(1, #Config.PedTypes)
    local randomPed = Config.PedTypes[random]
    while not HasModelLoaded(randomPed) do
        RequestModel(randomPed); Wait(0);
    end
    local npc = CreatePed(4, randomPed, spawnPos, spawnHeading, false, false)
    FreezeEntityPosition(npc, false)
    SetEntityInvincible(npc, false)
    SetPedSeeingRange(npc, 100.0)
    SetPedHearingRange(npc, 80.0)
    SetPedCombatAttributes(npc, 46, 1)
    SetPedFleeAttributes(npc, 0, 0)
    SetPedCombatRange(npc, 2)
    SetPedRelationshipGroupHash(npc, GetHashKey(0x06C3F072))
    SetPedDiesInWater(npc, false)
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("0x06C3F072"))
    SetRelationshipBetweenGroups(5, GetHashKey("0x06C3F072"), GetHashKey("PLAYER"))
    TaskCombatPed(npc, ped, 0, 16)
end

if Config.EnableKeyFob then
    local fobKeybind = lib.addKeybind({
        name = 'fobKeybind',
        description = Config.FobDescription,
        defaultKey = Config.FobKeybind,
        onPressed = function(self)
            local vehicle = GetVehicle()
            local plate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
            if HasKeys(plate) then
                local classes = Config.Classes
                local isLuxury = false

                for i, _ in pairs(classes) do
                    local class = GetVehicleClass(vehicle)
                    if class == i then
                        isLuxury = true
                        break
                    end
                end

                local open = isLuxury and 'newfob' or 'oldfob'
                openmenu(open)
            else
                Framework.Notify(Config.Language['notify']['ydhk'], 'error')
            end
        end,
    })
end

RegisterNetEvent('dusa_vehiclekeys:client:policeAlert', function(coords, text)
    local job = Framework.Player.Job.Name
    local isPolice = false
    for _, pJob in pairs(Config.PoliceJobs) do
        if pJob == job then
            isPolice = true
            break
        end
    end
    if not isPolice then return end

    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    Framework.Notify(text, 'error', 10000)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Config.Language.car_theft,
        SetBlipSprite(blip, 60)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipText)
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        SetBlipAlpha(blip2, transG)
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)


-- INTEGRATION FUNCTIONS
local function AddKeys(plate)
    local addPlate = plate and trimAndLowerPlate(plate)
    if addPlate then
        TriggerEvent('vehiclekeys:client:SetOwner', addPlate)
    else
        local vehicle = GetVehicle()
        addPlate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
        if not addPlate then
            TriggerServerEvent('dusa_vehiclekeys:server:errorreport', 1, 'IntegrateKey')
            return
        end
        TriggerEvent('vehiclekeys:client:SetOwner', addPlate)
    end
end
exports('GiveKeys', AddKeys)

local function RemoveKeys(plate)
    local removePlate = plate and trimAndLowerPlate(plate)
    if removePlate then
        TriggerEvent('dusa_vehiclekeys:client:RemoveKeys', removePlate)
    else
        TriggerServerEvent('dusa_vehiclekeys:server:errorreport', 1, 'RemoveKey')
    end
end
exports('RemoveKeys', RemoveKeys)

local function GiveKeysAuto()
    local vehicle = GetVehicle()
    local plate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
    if not vehicle then return warn('[giveKeysAuto] Couldnt find any vehicle to give key') end
    if not plate then return warn('[giveKeysAuto] Couldnt find any vehicle to give key') end
    TriggerEvent('vehiclekeys:client:SetOwner', plate)
end
exports('GiveKeysAuto', GiveKeysAuto)

local function RemoveKeysAuto()
    local vehicle = GetVehicle()
    local plate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
    if not vehicle then return warn('[removekeysauto] Couldnt find any vehicle to remove key') end
    if not plate then return warn('[removekeysauto] Couldnt find any vehicle to remove key') end
    TriggerEvent('dusa_vehiclekeys:client:RemoveKeys', plate)
end
exports('RemoveKeysAuto', RemoveKeysAuto)

-- Additional exports for the new API
exports('HasKey', HasKeys)

AddStateBagChangeHandler('vehiclekeys.allvehicles', 'global', function(bagname, key, value)
    if value then
        AllKeys = value
    end
end)


-- deprecated export methods
exports('IntegrateKey', AddKeys)
exports('AddKey', AddKeys)
exports('GiveKeyFromPlate', AddKeys)
exports('RemoveKey', RemoveKeys)
exports('IntegrateDynamically', GiveKeysAuto)

-- Client Events for the new API
RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    if plate then
        local acquirePlate = trimAndLowerPlate(plate)
        TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', acquirePlate)
    else
        -- If no plate provided, get closest vehicle plate
        local vehicle = GetVehicle()
        if vehicle then
            local acquirePlate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
            TriggerServerEvent('dusa_vehiclekeys:server:AcquireVehicleKeys', acquirePlate)
        end
    end
end)

-- This event handler is a duplicate and has been merged with the one above

RegisterNetEvent('dusa_vehiclekeys:client:RemoveKeys', function(plate)
    if plate then
        local removePlate = trimAndLowerPlate(plate)
        TriggerServerEvent('dusa_vehiclekeys:server:RemoveKeys', removePlate)
    end
end)

RegisterNetEvent('dusa_vehiclekeys:client:ToggleEngine', function()
    local vehicle = GetVehiclePedIsIn(cache.ped, true)
    if vehicle and vehicle ~= 0 then
        local EngineOn = GetIsVehicleEngineRunning(vehicle)
        local hasPlate = trimAndLowerPlate(GetVehicleNumberPlateText(vehicle))
        if HasKeys(hasPlate) then
            if EngineOn then
                SetVehicleEngineOn(vehicle, false, false, true)
            else
                SetVehicleEngineOn(vehicle, true, false, true)
            end
        end
    end
end)
