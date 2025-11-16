-- MDT Police Client Script
local isMDTOpen = false
local QBCore = nil
local activeDispatchCall = nil
local dispatchBlip = nil
local dispatchRoute = nil
local miniDispatchVisible = false

-- Try to get QBCore/ESX framework (adjust based on your framework)
if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == 'started' then
    QBCore = exports['es_extended']:getSharedObject()
end

-- Register NUI callback for closing MDT
RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    isMDTOpen = false
    SendNUIMessage({
        action = 'closeMDT'
    })
    cb('ok')
end)

-- Register NUI callback for getting officer data
RegisterNUICallback('getOfficerData', function(data, cb)
    TriggerServerEvent('mdt:getOfficerData')
    cb('ok')
end)

-- Register NUI callback for getting active units
RegisterNUICallback('getActiveUnits', function(data, cb)
    TriggerServerEvent('mdt:getActiveUnits')
    cb('ok')
end)

-- Register NUI callback for searching profiles
RegisterNUICallback('searchProfiles', function(data, cb)
    if data and data.query then
        TriggerServerEvent('mdt:searchProfiles', data.query)
        cb('ok')
    else
        cb({error = 'No query provided'})
    end
end)

-- Register NUI callback for submitting report
RegisterNUICallback('submitReport', function(data, cb)
    if data and data.report then
        TriggerServerEvent('mdt:submitReport', data.report)
        cb({success = true})
    else
        cb({success = false, error = 'No report data provided'})
    end
end)

-- Register NUI callback for getting reports
RegisterNUICallback('getReports', function(data, cb)
    TriggerServerEvent('mdt:getReports')
    cb('ok')
end)

-- Register NUI callback for getting BOLOs
RegisterNUICallback('getBOLOs', function(data, cb)
    TriggerServerEvent('mdt:getBOLOs')
    cb('ok')
end)

-- Register NUI callback for vehicle search
RegisterNUICallback('searchVehicle', function(data, cb)
    if data and data.plate then
        TriggerServerEvent('mdt:searchVehicle', data.plate)
        cb('ok')
    else
        cb({error = 'No plate provided'})
    end
end)

-- Register NUI callback for weapon search
RegisterNUICallback('searchWeapons', function(data, cb)
    if data and data.query then
        TriggerServerEvent('mdt:searchWeapons', data.query)
        cb('ok')
    else
        cb({error = 'No query provided'})
    end
end)

-- Register NUI callback for getting cameras
RegisterNUICallback('getCameras', function(data, cb)
    TriggerServerEvent('mdt:getCameras')
    cb('ok')
end)

-- Register NUI callback for getting staff logs
RegisterNUICallback('getStaffLogs', function(data, cb)
    TriggerServerEvent('mdt:getStaffLogs')
    cb('ok')
end)

-- Register NUI callback for getting active dispatch calls
RegisterNUICallback('getActiveCalls', function(data, cb)
    TriggerServerEvent('mdt:getActiveCalls')
    cb('ok')
end)

-- Register NUI callback for getting bodycam feeds
RegisterNUICallback('getBodycamFeeds', function(data, cb)
    TriggerServerEvent('mdt:getBodycamFeeds')
    cb('ok')
end)

-- Listen for server events to send data to UI
RegisterNetEvent('mdt:receiveOfficerData', function(data)
    SendNUIMessage({
        action = 'receiveOfficerData',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveActiveUnits', function(data)
    SendNUIMessage({
        action = 'receiveActiveUnits',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveProfiles', function(data)
    SendNUIMessage({
        action = 'receiveProfiles',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveReports', function(data)
    SendNUIMessage({
        action = 'receiveReports',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveBOLOs', function(data)
    SendNUIMessage({
        action = 'receiveBOLOs',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveVehicle', function(data)
    SendNUIMessage({
        action = 'receiveVehicle',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveWeapons', function(data)
    SendNUIMessage({
        action = 'receiveWeapons',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveCameras', function(data)
    SendNUIMessage({
        action = 'receiveCameras',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveStaffLogs', function(data)
    SendNUIMessage({
        action = 'receiveStaffLogs',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveActiveCalls', function(data)
    SendNUIMessage({
        action = 'receiveActiveCalls',
        data = data
    })
end)

RegisterNetEvent('mdt:receiveBodycamFeeds', function(data)
    SendNUIMessage({
        action = 'receiveBodycamFeeds',
        data = data
    })
end)

-- Dispatch call notifications
RegisterNetEvent('mdt:receiveDispatchCall', function(callData)
    activeDispatchCall = callData
    showMiniDispatch(callData)
    -- Also notify UI
    SendNUIMessage({
        action = 'receiveDispatchCall',
        data = callData
    })
end)

RegisterNetEvent('mdt:removeDispatchCall', function(callId)
    if activeDispatchCall and activeDispatchCall.id == callId then
        activeDispatchCall = nil
        hideMiniDispatch()
    end
    SendNUIMessage({
        action = 'removeDispatchCall',
        data = { id = callId }
    })
end)

-- Function to show mini dispatch on screen
function showMiniDispatch(callData)
    miniDispatchVisible = true
    
    Citizen.CreateThread(function()
        while miniDispatchVisible and activeDispatchCall do
            -- Draw dispatch notification on screen
            DrawDispatchNotification(callData)
            Citizen.Wait(0)
        end
    end)
end

function hideMiniDispatch()
    miniDispatchVisible = false
    if dispatchBlip then
        RemoveBlip(dispatchBlip)
        dispatchBlip = nil
    end
    if dispatchRoute then
        RemoveBlip(dispatchRoute)
        dispatchRoute = nil
    end
end

function DrawDispatchNotification(callData)
    -- Background box
    DrawRect(0.15, 0.12, 0.25, 0.15, 0, 0, 0, 180)
    
    -- Border
    DrawRect(0.15, 0.12, 0.25, 0.002, 255, 0, 0, 255) -- Top border (red)
    
    -- Title
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(false)
    AddTextComponentString("~r~DISPATCH CALL~w~")
    DrawText(0.03, 0.05)
    
    -- Call code and priority
    SetTextFont(4)
    SetTextScale(0.4, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(false)
    AddTextComponentString("~b~" .. (callData.code or "N/A") .. "~w~ - " .. (callData.location or "Unknown"))
    DrawText(0.03, 0.08)
    
    -- Description
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(false)
    AddTextComponentString(callData.description or "No description")
    DrawText(0.03, 0.11)
    
    -- Instructions
    SetTextFont(4)
    SetTextScale(0.3, 0.3)
    SetTextColour(255, 255, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(false)
    AddTextComponentString("Press ~y~G~w~ to set route | Press ~y~F1~w~ for MDT")
    DrawText(0.03, 0.14)
end

function createDispatchRoute(callData)
    if not callData or not callData.coords then return end
    
    -- Remove existing blip and route
    if dispatchBlip then
        RemoveBlip(dispatchBlip)
    end
    if dispatchRoute then
        RemoveBlip(dispatchRoute)
    end
    
    -- Create blip at dispatch location
    dispatchBlip = AddBlipForCoord(callData.coords.x, callData.coords.y, callData.coords.z)
    SetBlipSprite(dispatchBlip, callData.blipSprite or 487) -- Default to police station blip
    SetBlipColour(dispatchBlip, callData.blipColor or 1) -- Default to red
    SetBlipScale(dispatchBlip, 1.2)
    SetBlipAsShortRange(dispatchBlip, false)
    
    -- Set blip name based on call type
    local blipName = "Dispatch: " .. (callData.code or "Call")
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(dispatchBlip)
    
    -- Create route to location
    dispatchRoute = AddBlipForCoord(callData.coords.x, callData.coords.y, callData.coords.z)
    SetBlipRoute(dispatchRoute, true)
    SetBlipRouteColour(dispatchRoute, callData.blipColor or 1)
    
    -- Show notification
    ShowNotification("Route set to dispatch call: " .. (callData.code or "Call"))
end

function ShowNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end

-- Key mapping for accepting dispatch call (G key)
RegisterCommand('acceptdispatch', function()
    if activeDispatchCall and not isMDTOpen then
        createDispatchRoute(activeDispatchCall)
    end
end, false)

RegisterKeyMapping('acceptdispatch', 'Accept Dispatch Call', 'keyboard', 'G')

-- Function to get player's current location
function GetCurrentLocation()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Get street name
    local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(streetHash)
    local crossingName = GetStreetNameFromHashKey(crossingHash)
    
    -- Get zone name
    local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)
    
    -- Format location string
    local location = streetName
    if crossingName and crossingName ~= "" and crossingName ~= streetName then
        location = location .. " / " .. crossingName
    end
    if zoneName and zoneName ~= "" then
        location = location .. ", " .. zoneName
    end
    
    if location == "" or location == nil then
        location = "Unknown Location"
    end
    
    return location
end

-- Server event to request player location
RegisterNetEvent('mdt:requestPlayerLocation')
AddEventHandler('mdt:requestPlayerLocation', function(requestId)
    local location = GetCurrentLocation()
    TriggerServerEvent('mdt:receivePlayerLocation', requestId, location)
end)

-- Command to open MDT
RegisterCommand('mdt', function()
    if not isMDTOpen then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openMDT'
        })
        isMDTOpen = true
        
        -- Request initial data
        TriggerServerEvent('mdt:getOfficerData')
    end
end, false)

-- Key mapping (F1 to open MDT)
RegisterKeyMapping('mdt', 'Open Police MDT', 'keyboard', 'F1')

-- Close MDT with ESC key
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isMDTOpen then
            DisableControlAction(0, 322, true) -- Disable ESC key from opening pause menu
            if IsDisabledControlJustPressed(0, 322) then -- ESC key
                SetNuiFocus(false, false)
                isMDTOpen = false
                SendNUIMessage({
                    action = 'closeMDT'
                })
            end
        else
            Citizen.Wait(500) -- Wait longer when MDT is closed to save resources
        end
    end
end)