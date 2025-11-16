
local policeBlips = {}
local POLICE_BLIP_COORDS = {
    vector3(-1598.49, -1201.4, 0.82),
    vector3(-1820.11, -946.19, 1.05),
    vector3(-793.86, -1510.48, 1.6),
    vector3(-900.84, -3546.82, 0.82),
    vector3(1298.07, -3062.78, 5.91),
    vector3(-285.38, 6626.74, 7.12),
    vector3(467.48, -3389.73, 6.07),
    vector3(-444.17, -2421.32, 6.04),
    vector3(1426.31, 3750.12, 31.76)
}

local function createPoliceBlips()
    if next(policeBlips) ~= nil then return end
    for index, coords in ipairs(POLICE_BLIP_COORDS) do
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 427)          -- Racing flag icon
        SetBlipDisplay(blip, 4)           -- Display type
        SetBlipScale(blip, 0.7)           -- Size of blip
        SetBlipColour(blip, 38)           -- Yellow color
        SetBlipAsShortRange(blip, true)   -- Only show when nearby
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Police Boat Garage")
        EndTextCommandSetBlipName(blip)
        policeBlips[index] = blip
    end
end

local function removePoliceBlips()
    if next(policeBlips) == nil then return end
    for index, blip in pairs(policeBlips) do
        if blip ~= nil then
            RemoveBlip(blip)
            policeBlips[index] = nil
        end
    end
end

local function handleJobVisibility(jobName)
    if jobName == "police" then
        createPoliceBlips()
    else
        removePoliceBlips()
    end
end

CreateThread(function()
    local initialized = false

    -- ESX support
    if GetResourceState and GetResourceState('es_extended') == 'started' then
        local ESX = nil
        local attempts = 0
        while ESX == nil and attempts < 50 do
            local ok, obj = pcall(function()
                return exports['es_extended']:getSharedObject()
            end)
            if ok then ESX = obj end
            attempts = attempts + 1
            if ESX == nil then Wait(100) end
        end

        if ESX then
            local function refreshFromESX()
                local playerData = ESX.GetPlayerData and ESX.GetPlayerData() or nil
                if playerData and playerData.job and playerData.job.name then
                    handleJobVisibility(playerData.job.name)
                end
            end

            RegisterNetEvent('esx:setJob', function(job)
                if job and job.name then
                    handleJobVisibility(job.name)
                end
            end)

            RegisterNetEvent('esx:playerLoaded', function()
                refreshFromESX()
            end)

            refreshFromESX()
            initialized = true
        end
    end

    -- QBCore support
    if not initialized and GetResourceState and GetResourceState('qb-core') == 'started' then
        local QBCore = nil
        local ok, obj = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)
        if ok then QBCore = obj end

        if QBCore then
            local function refreshFromQBCore()
                local playerData = QBCore.Functions and QBCore.Functions.GetPlayerData() or nil
                if playerData and playerData.job and playerData.job.name then
                    handleJobVisibility(playerData.job.name)
                end
            end

            RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
                refreshFromQBCore()
            end)

            RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
                if job and job.name then
                    handleJobVisibility(job.name)
                end
            end)

            refreshFromQBCore()
            initialized = true
        end
    end

    -- Fallback: try LocalPlayer state (if framework not detected)
    if not initialized and LocalPlayer and LocalPlayer.state then
        local job = LocalPlayer.state.job
        if type(job) == 'string' then
            handleJobVisibility(job)
        else
            removePoliceBlips()
        end
    end
end)
