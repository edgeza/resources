-- Dispatch integration with dusa_dispatch
local dispatchCalls = {}
local latestDispatch = nil

-- Register NUI callbacks for dispatch functionality
RegisterNUICallback('getDispatchCalls', function(data, cb)
    QBCore.Functions.TriggerCallback('jpr-mdtsystem:server:getDispatchCalls', function(calls)
        dispatchCalls = calls
        cb(calls)
    end)
end)

RegisterNUICallback('getLatestDispatch', function(data, cb)
    QBCore.Functions.TriggerCallback('jpr-mdtsystem:server:getLatestDispatch', function(call)
        latestDispatch = call
        cb(call)
    end)
end)

RegisterNUICallback('setWaypoint', function(data, cb)
    if data.x and data.y then
        SetNewWaypoint(data.x, data.y)
        QBCore.Functions.Notify('Waypoint set to dispatch location', 'success')
    end
    cb('ok')
end)

RegisterNUICallback('joinDispatch', function(data, cb)
    if data.callId then
        -- Trigger dusa_dispatch join event if available
        if GetResourceState("dusa_dispatch") == "started" then
            TriggerEvent('dusa_dispatch:joinDispatch', data.callId)
        end
        QBCore.Functions.Notify('Joined dispatch call', 'success')
    end
    cb('ok')
end)

-- Function to refresh dispatch data
function RefreshDispatchData()
    SendNUIMessage({
        action = 'refreshDispatch'
    })
end

-- Auto-refresh dispatch data every 30 seconds
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000) -- 30 seconds
        RefreshDispatchData()
    end
end)

-- Export functions
exports('RefreshDispatchData', RefreshDispatchData)
