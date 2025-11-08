if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Settings             = {}
local playerSettings = {}

local plyState       = LocalPlayer.state

--[[
    TODO
    Set settings userlist
    Save settings
    Get Settings
    Update settings

    settingsUserList: [
        {
          label: "John Doee",
          value: "828djJAd1",
        },
    ]
]]

--[[
    local data = {
        callsign: "3914",
        filter: {
            police: false,
            ambulance: true,
            sheriff: true,
            bcso: true,
            highway: true,
            state: false,
            ranger: true,
        },
        alertEnabled: true,
        operator: "John Doe"
    }
]]

defaultPermissions = {
    draw = false,
    bodycam = false,
    unitsEdit = false,
    dispatchEdit = false,
    createUnit = false,
    createGps = false,
    createRadio = false,
    createCamera = false,
    editCamera = false,
    selectManager = false,
}

function Settings.Set()
    local settings = lib.callback.await('dusa_dispatch:getSettings', false)
    playerSettings = settings
    Settings.UpdatePermissions()
    SendNUIMessage({ action = 'SET_SETTINGS', data = settings })
    SendNUIMessage({ action = 'SET_PERMISSIONS', data = defaultPermissions })
    SendNUIMessage({ action = 'SET_MANAGER', data = GlobalState.DispatchManager })
    SendNUIMessage({
        action = 'ACTIVE_CHANNEL',
        data = {
            radio = getRadioChannel(),
            gps = plyState.gpsChannel,
        }
    })
    Framework.Player.Metadata.callsign = settings?.callsign or config.defaultCallsign
end

function Settings.ListManagers()
    -- if PlayerData.job.name
    local agentList   = lib.callback.await('dispatch:getAgentList', false, false)
    local clearedList = client.ClearAgentList(agentList)
    local managerList = {}

    for k, v in pairs(clearedList) do
        table.insert(managerList, {
            label = v.name,
            value = v.gameId
        })
    end
    SendNUIMessage({ action = "LIST_MANAGER", data = managerList })
end

RegisterNUICallback('saveSettings', function(data, cb)
    if not playerSettings then
        playerSettings = {
            callsign = data.callsign,
            filter = data.filter,
            alertEnabled = data.alertEnabled,
            operator = data.operator
        }
        Framework.Player.Metadata.callsign = data.callsign
    else
        playerSettings.callsign = data.callsign
        playerSettings.filter = data.filter
        playerSettings.alertEnabled = data.alertEnabled
        playerSettings.operator = data.operator
        Framework.Player.Metadata.callsign = data.callsign
    end

    TriggerServerEvent('dusa_dispatch:updateSettings', data)

    -- update opened gps name
    if not shared.compatibility and plyState.gps then
        local properties = {
            label = Functions.Callsign() .. ' - ' .. Framework.Player.Firstname .. " " .. Framework.Player.Lastname,
            color = Functions.GetGpsColor(Framework.Player.Job.Name),
        }
        TriggerServerEvent('police:server:UpsertBlipProperties', properties)
    end
    cb('ok')
end)

RegisterNUICallback('setNewManager', function(data, cb)
    TriggerServerEvent('dusa_dispatch:setNewManager', data)
    cb('ok')
end)

function Settings.UpdateManager(managerSource)
    local source = GetPlayerServerId(PlayerId())
    if source == managerSource then
        notify(locale('you_are_manager'), 'success')
        for k, v in pairs(defaultPermissions) do
            defaultPermissions[k] = true
        end
    else
        for k, v in pairs(defaultPermissions) do
            defaultPermissions[k] = false
        end
        Settings.UpdatePermissions()
    end
    SendNUIMessage({ action = 'SET_PERMISSIONS', data = defaultPermissions })
end

RegisterNetEvent('dusa_dispatch:updateManagerPermissions', Settings.UpdateManager)

RegisterNetEvent('dusa_dispatch:UpdateManager', function(manager)
    SendNUIMessage({ action = 'SET_MANAGER', data = manager })
end)

function Settings.UpdatePermissions()
    local id = GetPlayerServerId(PlayerId())
    if GlobalState.DispatchManager?.id == id then return end
    for k, v in pairs(config.accessManagement) do
        if k == Framework.Player.Job.Name and Framework.Player.Job.Grade.Level >= v then
            for key, value in pairs(defaultPermissions) do
                defaultPermissions[key] = true
            end
        elseif k == Framework.Player.Job.Name and Framework.Player.Job.Grade.Level < v then
            for key, value in pairs(defaultPermissions) do
                defaultPermissions[key] = false
            end
        end
    end
end

RegisterNetEvent('dusa_dispatch:updatePlayerPermissions', Settings.UpdatePermissions)

return Settings
