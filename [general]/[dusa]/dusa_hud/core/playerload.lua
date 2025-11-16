local firstLoad = false
playerLoaded = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Wait(2000)
    playerLoaded = true
    TriggerEvent('dusa_hud:playerLoaded')
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    playerLoaded = true
    TriggerEvent('dusa_hud:playerLoaded')
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    playerLoaded = true
    TriggerEvent('dusa_hud:playerLoaded')
end)

RegisterNetEvent('dusa_hud:playerLoaded', function()
    cache.vehicle = cache.vehicle or GetVehiclePedIsIn(PlayerPedId(), false)
    LoadHud()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    local newJob = {
        name = job.name,
        label = job.label,
        grade = {
            name = job.grade_label,
        }
    }
	TriggerEvent('dusa:setJob', newJob)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    TriggerEvent('dusa:setJob', job)
end)

RegisterNetEvent('dusa:setJob', function(job)
    if playerLoaded then
        if not shared.playerdata then LoadPlayerData() end
        local job = GetJob(job)
        SetInfo('setJob', job)
    end
end)

function LoadHud()
    Wait(1000)
    CoreAwait()
    PlayerAwait()
    nuiMessage('hideHud', false)
    LoadPlayerData()
    -- Send server info immediately to prevent showing default "yeni server" text
    if config.EnableInformations then
        SetInfo('setLogo', config.Logo)
        SetInfo('setName', config.ServerName)
        SetInfo('setServerLink', config.Link)
    end
    LoadSettings() -- This calls ApplyDefaults internally
    SetupPlaylist()
    SetHud()
    LoadRectMinimap()
    InfoLoop()
end

function PlayerAwait()
    if shared.framework == 'qb' then
        while QBCore == nil or QBCore.Functions.GetPlayerData() == nil or QBCore.Functions.GetPlayerData().metadata == nil or not playerLoaded do
            Citizen.Wait(0)
        end
    else
        while ESX == nil or ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil or not playerLoaded do
            Citizen.Wait(0)
        end
    end
end

function LoadSettings()
    local settings = lib.callback.await('dusa_hud:getSettings', false)
    if type(settings) == 'string' then settings = json.decode(settings) end
    if not settings or not next(settings) then
        hudSettings.currentStatus = config.DefaultStatus
        hudSettings.currentSpeedometer = config.DefaultSpeedometer
        hudSettings.showMiniMap = true
        SetRefreshRate(config.defaultRefreshRateLevel)
        nuiMessage('applyDefaultSettings', {speedometer = config.DefaultSpeedometer, status = config.DefaultStatus})
        ApplyDefaults(true) -- Apply defaults including server info options
        return
    end
    dp('Minimap set to: ', settings[1].general.minimap)
    hudSettings.showMiniMap = settings[1].general.minimap
    hudSettings.speedoRefreshRate = settings[1].general.refreshRate
    hudSettings.speedType = settings[1].speedometers.units
    hudSettings.currentStatus = settings[1].status.statusStyleType
    hudSettings.currentSpeedometer = settings[1].speedometers.speedometerType
    SetRefreshRate(hudSettings.speedoRefreshRate)
    config.language.caps = config.CursorKeyLabel
    nuiMessage('translate', config.language)
    nuiMessage('setupSettings', {settings = settings})
    Wait(100) -- Reduced wait time for faster initialization
    ApplyDefaults(false) -- Don't overwrite server info settings with config defaults
end

function LoadPlayerData()
    if shared.framework == 'qb' then
        shared.playerdata = QBCore.Functions.GetPlayerData()
        if not shared.playerdata then error('Couldnt get player data - Code 217') end
        shared.playerdata.job = {
            name = shared.playerdata.job.name,
            label = shared.playerdata.job.label,
            grade = shared.playerdata.job.grade.name
        }
    else
        shared.playerdata = ESX.GetPlayerData()
        if not shared.playerdata then error('Couldnt get player data - Code 268') end
        
        -- Fixed job data handling to prevent "unemployed" spam
        if shared.playerdata.job and shared.playerdata.job.name and shared.playerdata.job.name ~= "unemployed" then
            shared.playerdata.job = {
                name = shared.playerdata.job.name,
                label = shared.playerdata.job.label or "Unknown",
                grade = shared.playerdata.job.grade_label or shared.playerdata.job.grade or "Unknown"
            }
        else
            -- Single fallback job data if job is not properly loaded
            shared.playerdata.job = {
                name = "unemployed",
                label = "Unemployed",
                grade = "Unemployed"
            }
        end
    end
end

function ApplyDefaults(applyServerInfoDefaults)
    -- Only apply server info defaults when explicitly requested (no saved settings)
    if applyServerInfoDefaults then
        nuiMessage('setServerInformationOptions', config.EnableServerInfoOptions)
    end
    
    SetStatus('armor', 0)
    SetStatus('stamina', 100)

    -- Fixed map visibility logic
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        -- In vehicle - show map if enabled
        if hudSettings.showMiniMap then
            DisplayRadar(true)
            nuiMessage('toggleMap', true)
        else
            DisplayRadar(false)
            nuiMessage('toggleMap', false)
        end
    else
        -- On foot - respect mapWhileWalking setting
        if config.mapWhileWalking then
            DisplayRadar(true)
            nuiMessage('toggleMap', true)
        else
            DisplayRadar(false)
            nuiMessage('toggleMap', false)
        end
    end
    
    nuiMessage('disableMinimap', config.DisableMinimapOption)

    local tabs = {}
    if config.MenuTabs.media then
        tabs[#tabs+1] = { label = config.language.media, id = 'media' }
    end
    if config.MenuTabs.vehicle then
        tabs[#tabs+1] = { label = config.language.vehicle, id = 'vehicle' }
    end
    if config.MenuTabs.map then
        tabs[#tabs+1] = { label = config.language.map, id = 'map' }
    end
    nuiMessage('setTabs', tabs)
end
