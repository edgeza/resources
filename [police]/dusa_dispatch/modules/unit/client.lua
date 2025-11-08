if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Unit      = {}
local plyState  = LocalPlayer.state

function Unit.listUnits()
    local unitList = {}
    for k, v in pairs(GlobalState.unitList) do
        v.active = false
        unitList[#unitList + 1] = v
    end

    SendNUIMessage({action = 'LIST_UNIT', data = unitList})
end

-- NUI Callbacks
-- Heist actions
RegisterNUICallback('createUnit', function (data, cb)
    if not data then
        return error('No data provided to create unit', 2)
    end
    TriggerServerEvent('dusa_dispatch:createUnit', data.created)
    cb("ok")
end)

RegisterNUICallback('removeUnit', function (data, cb)
    if not data then
        return error('No data provided to remove unit', 2)
    end

    TriggerServerEvent('dusa_dispatch:removeUnit', data.removed)
    cb("ok")
end)

RegisterNUICallback('joinUnit', function (data, cb)
    plyState.gps = true
    TriggerEvent('police:client:ConnectGps', data.unit.name)
    Wait(250)
    local properties = {
        label = data.unit.name .. ' - ' .. Framework.Player.Firstname .. " " .. Framework.Player.Lastname,
        color = Functions.GetGpsColor(Framework.Player.Job.Name),
    }
    TriggerServerEvent('police:server:UpsertBlipProperties', properties)
    TriggerServerEvent('dusa_dispatch:joinUnit', data, 'join')
    cb("ok")
end)

RegisterNetEvent('unit:client:connectPlayerToGps', function (unitName)
    TriggerEvent('police:client:ConnectGps', unitName)
    Wait(250)
    local properties = {
        label = unitName .. ' - ' .. Framework.Player.Firstname .. " " .. Framework.Player.Lastname,
        color = Functions.GetGpsColor(Framework.Player.Job.Name),
    }
    TriggerServerEvent('police:server:UpsertBlipProperties', properties)
end)

RegisterNUICallback('leaveUnit', function (data, cb)
    if plyState.gpsChannel then
            -- Handle Properties
        local properties = {
            label = Functions.Callsign() .. ' - ' .. Framework.Player.Firstname .. " " .. Framework.Player.Lastname,
            color = Functions.GetGpsColor(Framework.Player.Job.Name),
        }
        TriggerServerEvent('police:server:UpsertBlipProperties', properties)
    else
        plyState.gps = false
        if not shared.compatibility then
            DisconnectGps()
        end
    end

    TriggerServerEvent('dusa_dispatch:leaveUnit', data, 'leave')
    cb("ok")
end)

RegisterNetEvent('dusa_dispatch:UpdateUnit', function (unitList)
    SendNUIMessage({action = 'LIST_UNIT', data = unitList})
end)

return Unit