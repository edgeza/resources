if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end

Dispatch = {}
local calls = {}
local callCount = 0

exports('GetDispatchCalls', function()
    return calls
end)

lib.callback.register('dusa_dispatch:getCalls', function()
    return calls
end)

lib.callback.register('dusa_dispatch:getLatestDispatch', function()
    return calls[#calls]
end)

---@param data table
function Dispatch.SendDispatch(data)
    local src = source

    if not data.coords or not data.coords.x then
        local ped = GetPlayerPed(src)
        if ped and ped ~= -1 then
            local coords = GetEntityCoords(ped)
            data.coords = vec3(coords.x, coords.y, coords.z)
        else
            warn('[Dispatch] Invalid coords or ped not found')
            return
        end
    end

    if not data.recipientJobs then
        data.recipientJobs = { "leo" }
    end



    callCount += 1
    data.id = callCount
    data.timeout = os.time() * 1000
    data.units = {}
    data.responses = {}

    if config.DeleteOldAlerts and #calls >= config.AlertLimit then
        table.remove(calls, 1)
    end

    calls[#calls + 1] = data

   
    TriggerClientEvent('dusa_dispatch:client:SendDispatch', -1, data)

    -- Auto remove after timeout
    CreateThread(function()
        Wait(config.AlertTimeout * 60000)
        for i = 1, #calls do
            if calls[i] and calls[i].id == data.id then
                table.remove(calls, i)
                for _, playerId in ipairs(GetPlayers()) do
                    TriggerClientEvent('dusa_dispatch:removeDispatch', tonumber(playerId), data.id)
                end
                break
            end
        end
    end)
end
RegisterServerEvent('dusa_dispatch:sendDispatch', Dispatch.SendDispatch)

---@param dispatch table
---@param count number
function Dispatch.UpdateAlerts(dispatch, count)
    for i = 1, #calls do
        if calls[i].id == dispatch.id then
            calls[i].units = dispatch.units
            calls[i].unitCount = count
            for _, playerId in ipairs(GetPlayers()) do
                TriggerClientEvent('dusa_dispatch:UpdateAlerts', tonumber(playerId), calls[i])
            end
            break
        end
    end
end
RegisterServerEvent('dusa_dispatch:sv:UpdateAlerts', Dispatch.UpdateAlerts)
