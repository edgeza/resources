if not rawget(_G, "lib") then include('ox_lib', 'init') end


local dispOpen = false
local plyState = LocalPlayer.state
local playerPed = cache.ped


lib.onCache('ped', function(ped)
    playerPed = ped
end)



function client.openDispatch()
    if dispOpen then return end

    if not Functions.IsPolice(Framework.Player.Job.Name) then return Utils.Notify(locale('no_authorization'), 'error') end
    if not Functions.IsOnDuty() then return Utils.Notify(locale('no_duty'), 'error') end
    if Framework.IsPlayerDead() then return Utils.Notify(locale('dead'), 'error') end

    dispOpen = true
    SetNuiFocus(true, true)
    client.closeAlert(true)
    Bodycam.hideBodycam()
    SendNUIMessage({ action = 'route', data = 'dispatch' })
    Bodycam.listBodycam()
    Radio.listRadio()
    client.ListAgents()
    Settings.ListManagers()
    Unit.listUnits()
    Draw.listDraws()
    Camera.listCamera()
    Settings.Set()
    -- if not shared.compatibility then
    -- end
    if config.enableGPS then
        ListGPS()
    end
    -- Configuration
    -- SetInterval(client.interval, 200)
    RespondToDispatch:disable(true)
    OpenDispatchMenu:disable(true)
    Wait(200)

    if dispOpen then
        TriggerServerEvent('dusa_dispatch:openDispatch')
        plyState.onDispatch = true
        SendNUIMessage({
            action = 'SET_LANGUAGE',
            data = ui_locales
        })
    end
end

RegisterNetEvent('dusa_dispatch:openDispatch', client.openDispatch)
exports('openDispatch', client.openDispatch)

function client.closeDispatch(server)
    if dispOpen then
        dispOpen = nil
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'route', data = '' })
        -- SetInterval(client.interval, 200)
        Wait(200)
        RespondToDispatch:disable(false)
        OpenDispatchMenu:disable(false)
        client.openAlert(true)
        if plyState.onBodycam then
            Bodycam.openBodycam()
        end
        if dispOpen ~= nil then return end

        if not server then
            TriggerServerEvent('dusa_dispatch:closeDispatch')
        end

        plyState.onDispatch = false
    end
end

RegisterNetEvent('dusa_dispatch:closeDispatch', client.closeDispatch)
exports('closeDispatch', client.closeDispatch)

CreateThread(function()
    while true do
        if IsPauseMenuActive() and not pauseActive then
            pauseActive = true
            client.closeAlert(true)
        end
        if not IsPauseMenuActive() and pauseActive and not CinematicModeOn then
            pauseActive = false
            client.openAlert(true)
        end
        Wait(500)
    end
end)

SetTimeout(5000, function()
    if not Framework.Player.Loaded then return end

    SendNUIMessage({ action = 'SET_CONFIG', data = config })
end)

alertShown = false
function client.openAlert(show)
    local isPolice = Functions.IsPolice(Framework.Player.Job.Name)
    if not isPolice then 
        -- return Utils.Notify(locale('no_authorization'), 'error') 
        return
    end

    local isDuty = Functions.IsOnDuty()
    if not isDuty then
        return Utils.Notify(locale('no_duty'), 'error')
    end

    if show then
        if not alertShown then
            return
        end
        SendNUIMessage({ action = 'SHOW_ALERT', data = true })
        RespondToDispatch:disable(false)
        OpenDispatchMenu:disable(false)
        return
    end

    if not alertShown then
        if Framework.IsPlayerDead() then return Utils.Notify(locale('dead'), 'error') end
        alertShown = true
        SendNUIMessage({ action = 'SHOW_ALERT', data = true })
        RespondToDispatch:disable(false)
        OpenDispatchMenu:disable(false)
    else
        warn('alert already showing')
    end
end

RegisterNetEvent('dusa_dispatch:openAlert', client.openAlert)
exports('openAlert', client.openAlert)

function client.closeAlert(hide)
    if hide then
        SendNUIMessage({ action = 'SHOW_ALERT', data = false })
        RespondToDispatch:disable(true)
        OpenDispatchMenu:disable(true)
        return
    end

    if alertShown then
        alertShown = false
        SendNUIMessage({ action = 'SHOW_ALERT', data = false })
        RespondToDispatch:disable(true)
        OpenDispatchMenu:disable(true)
    else
        warn('alert already closed')
    end
end

RegisterNetEvent('dusa_dispatch:closeAlert', client.closeAlert)
exports('closeAlert', client.closeAlert)

-- RegisterCommand('openAlert', client.openAlert)
-- RegisterCommand('closeAlert', client.closeAlert)

function client.ListAgents()
    local agentList   = lib.callback.await('dispatch:getAgentList', false, false)
    local clearedList = client.ClearAgentList(agentList)

    SendNUIMessage({ action = "LIST_OFFICER", data = clearedList })
end

function client.ClearAgentList(agentList)
    for _, unit in ipairs(GlobalState.unitList) do
        if unit.userList then
            for _, user in ipairs(unit.userList) do
                for index, agent in ipairs(agentList) do
                    if agent.gameId == user.gameId then
                        table.remove(agentList, index)
                    end
                end
            end
        end
    end
    for index, agent in ipairs(agentList) do
        if agent.job ~= Framework.Player.Job.Name then
            table.remove(agentList, index)
        end
    end

    return agentList
end

function OpenDispatch()
    client.openDispatch()
end

function client.ToggleAlert()
    if not alertShown then
        client.openAlert()
    else
        client.closeAlert()
    end
end

RegisterNetEvent('dusa_dispatch:ToggleAlert', client.ToggleAlert)

RegisterCommand('closedispatch', function()
    client.closeDispatch()
end)

RegisterNUICallback('alertNotification', function(data, cb)
    alertShown = data.alertNot
    cb('ok')
end)

RegisterNUICallback('closeNuiFocus', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

AddEventHandler('dusa_dispatch:onPlayerDeath', function()
    local IsPolice = Functions.IsPolice(Framework.Player.Job.Name)
    if IsPolice then
        client.closeDispatch()
        client.closeAlert()
    end
    -- PlayerData.dead = true
end)

CreateThread(function()
    if not Framework.Player.Loaded and cache.ped then
        pcall(Framework.OnPlayerLoaded)
    end

    SendNUIMessage({
        action = 'SET_LANGUAGE',
        data = config.language
    })
end)


Framework.OnPlayerLoaded = function ()
    Framework.Player.Loaded = true
    TriggerServerEvent('dispatch:server:playerLoaded')
    createZones()
    Framework.Player.Metadata.callsign = lib.callback.await('dusa_dispatch:getCallsign', false)
end

Framework.OnPlayerUnload = function ()
    Framework.Player.Loaded = false
    removeZones()
end