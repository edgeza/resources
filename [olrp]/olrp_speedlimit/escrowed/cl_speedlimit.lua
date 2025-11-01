-- Minimal, client-only speed limiter

local MAX_SPEED_KMH = 320.0
local OVERRIDE_MODEL = GetHashKey('f1')
local OVERRIDE_SPEED_KMH = 380.0
local CHECK_INTERVAL_MS = 1000

-- Build high-speed vehicles hash set for fast lookup
local highSpeedVehicles = {}
if Config and Config.HighSpeedVehicles then
    for _, modelName in ipairs(Config.HighSpeedVehicles) do
        highSpeedVehicles[GetHashKey(modelName)] = true
    end
end
local HIGH_SPEED_KMH = (Config and Config.HighSpeedLimit) or 350.0

local function applySpeedLimitIfDriver()
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed, false) then
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle == 0 then
        return
    end

    if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
        return
    end

    -- Determine speed limit based on vehicle model
    local vehicleModel = GetEntityModel(vehicle)
    local desiredKmh = MAX_SPEED_KMH
    
    if vehicleModel == OVERRIDE_MODEL then
        desiredKmh = OVERRIDE_SPEED_KMH
    elseif highSpeedVehicles[vehicleModel] then
        desiredKmh = HIGH_SPEED_KMH
    end

    local maxSpeedMs = desiredKmh / 3.6
    SetVehicleMaxSpeed(vehicle, maxSpeedMs)
end

CreateThread(function()
    while true do
        applySpeedLimitIfDriver()
        Wait(CHECK_INTERVAL_MS)
    end
end)
