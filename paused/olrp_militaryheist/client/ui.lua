local QBCore = exports['qb-core']:GetCoreObject()
local uiOpen = false
local lastUpdate = 0

-- UI Settings
local UI = {
    position = {x = 0.02, y = 0.02},
    size = {width = 0.25, height = 0.15},
    colors = {
        background = {r = 0, g = 0, b = 0, a = 150},
        border = {r = 255, g = 0, b = 0, a = 255},
        text = {r = 255, g = 255, b = 255, a = 255},
        warning = {r = 255, g = 165, b = 0, a = 255},
        danger = {r = 255, g = 0, b = 0, a = 255}
    }
}

-- PERFORMANCE: Cache status data for UI
local cachedStatus = {
    activePatrols = 0,
    alertedUnits = 0,
    distance = 0,
    playerJob = "unemployed",
    isExcluded = false,
    inRestrictedArea = false
}
local STATUS_UPDATE_INTERVAL = 200 -- Update status data every 200ms (still feels instant)

-- Single thread to update cached status data
CreateThread(function()
    while true do
        Wait(STATUS_UPDATE_INTERVAL)
        
        -- Cache restricted area check
        cachedStatus.inRestrictedArea = exports['olrp_militaryheist']:IsInRestrictedArea()
        
        if cachedStatus.inRestrictedArea then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local center = Config.MilitaryBase.center
            
            -- Cache status data
            cachedStatus.distance = math.floor(#(playerCoords - center))
            
            local status = exports['olrp_militaryheist']:GetPatrolStatus()
            cachedStatus.activePatrols = status.activePatrols
            cachedStatus.alertedUnits = status.alertedUnits
            
            cachedStatus.playerJob = exports['olrp_militaryheist']:GetPlayerJob()
            cachedStatus.isExcluded = false
            for _, excludedJob in pairs(Config.ExcludedJobs) do
                if cachedStatus.playerJob == excludedJob then
                    cachedStatus.isExcluded = true
                    break
                end
            end
        end
    end
end)

-- Draw UI using RenderScriptCams for smooth rendering
CreateThread(function()
    while true do
        Wait(0)
        
        -- Draw using cached area check (no export calls in render loop)
        if cachedStatus.inRestrictedArea then
            DrawMilitaryUI()
        end
    end
end)

-- Draw military heist UI
function DrawMilitaryUI()
    -- Calculate UI position
    local x = UI.position.x
    local y = UI.position.y
    local width = UI.size.width
    local height = UI.size.height
    
    -- Background
    DrawRect(x + width/2, y + height/2, width, height, UI.colors.background.r, UI.colors.background.g, UI.colors.background.b, UI.colors.background.a)
    
    -- Border
    DrawRect(x + width/2, y, width, 0.002, UI.colors.border.r, UI.colors.border.g, UI.colors.border.b, UI.colors.border.a)
    DrawRect(x + width/2, y + height, width, 0.002, UI.colors.border.r, UI.colors.border.g, UI.colors.border.b, UI.colors.border.a)
    DrawRect(x, y + height/2, 0.002, height, UI.colors.border.r, UI.colors.border.g, UI.colors.border.b, UI.colors.border.a)
    DrawRect(x + width, y + height/2, 0.002, height, UI.colors.border.r, UI.colors.border.g, UI.colors.border.b, UI.colors.border.a)
    
    -- Title
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.0, 0.5)
    SetTextColour(UI.colors.danger.r, UI.colors.danger.g, UI.colors.danger.b, UI.colors.danger.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString("MILITARY BASE - RESTRICTED AREA")
    DrawText(x + 0.01, y + 0.01)
    
    -- Distance info (using cached data)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.0, 0.35)
    SetTextColour(UI.colors.text.r, UI.colors.text.g, UI.colors.text.b, UI.colors.text.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString("Distance: " .. cachedStatus.distance .. "m")
    DrawText(x + 0.01, y + 0.04)
    
    -- Status info (using cached data)
    local statusText = "Units Active: " .. cachedStatus.activePatrols
    if cachedStatus.alertedUnits > 0 then
        statusText = statusText .. " | ALERTED: " .. cachedStatus.alertedUnits
    end
    
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.0, 0.35)
    local textColor = cachedStatus.alertedUnits > 0 and UI.colors.warning or UI.colors.text
    SetTextColour(textColor.r, textColor.g, textColor.b, textColor.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(statusText)
    DrawText(x + 0.01, y + 0.07)
    
    -- Warning message
    if cachedStatus.alertedUnits > 0 then
        SetTextFont(4)
        SetTextProportional(0)
        SetTextScale(0.0, 0.3)
        SetTextColour(UI.colors.danger.r, UI.colors.danger.g, UI.colors.danger.b, UI.colors.danger.a)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString("WARNING: Military units are hunting you!")
        DrawText(x + 0.01, y + 0.10)
    end
    
    -- Job status (using cached data)
    if cachedStatus.isExcluded then
        SetTextFont(4)
        SetTextProportional(0)
        SetTextScale(0.0, 0.3)
        SetTextColour(0, 255, 0, 255) -- Green
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString("Status: AUTHORIZED PERSONNEL")
        DrawText(x + 0.01, y + 0.13)
    else
        SetTextFont(4)
        SetTextProportional(0)
        SetTextScale(0.0, 0.3)
        SetTextColour(255, 0, 0, 255) -- Red
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString("Status: UNAUTHORIZED - HOSTILE")
        DrawText(x + 0.01, y + 0.13)
    end
end

-- Show notification
function ShowNotification(message, type, duration)
    if type == "error" then
        QBCore.Functions.Notify(message, 'error', duration or 5000)
    elseif type == "success" then
        QBCore.Functions.Notify(message, 'success', duration or 3000)
    elseif type == "info" then
        QBCore.Functions.Notify(message, 'primary', duration or 4000)
    else
        QBCore.Functions.Notify(message, 'primary', duration or 4000)
    end
end

-- Show military alert
function ShowMilitaryAlert(unitCount, isAlerted)
    local message = "Military units detected: " .. unitCount
    if isAlerted then
        message = message .. " - UNITS ALERTED!"
    end
    
    ShowNotification(message, isAlerted and "error" or "info", 5000)
end

-- Show area entry/exit
function ShowAreaNotification(entering)
    local message = entering and Locales['en']['entering_restricted'] or Locales['en']['leaving_restricted']
    local type = entering and "error" or "success"
    
    ShowNotification(message, type, 5000)
end

-- Export functions
exports('ShowNotification', ShowNotification)
exports('ShowMilitaryAlert', ShowMilitaryAlert)
exports('ShowAreaNotification', ShowAreaNotification)
