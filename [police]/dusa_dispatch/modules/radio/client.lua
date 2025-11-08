
if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Radio         = {}

function getRadioChannel()
	return LocalPlayer.state.radioChannel
end

local function connectFrequency(frequency)
	exports['pma-voice']:addPlayerToRadio(frequency)
end

local function disconnectRadio()
	exports['pma-voice']:removePlayerFromRadio()
end


function Radio.listRadio()
    local radioList = {}
    for k, v in pairs(config.radioConfiguration) do
        if Framework.Player.Job.Name == v.job then
            table.insert(radioList, 1, {
                title = v.title,
                job = v.job,
                id = k,
                item = v.commonChannels
            })
        else
            table.insert(radioList, {
                title = v.title,
                job = v.job,
                id = k,
                item = v.commonChannels
            })
        end
    end

    SendNUIMessage({action = 'LIST_RADIO_COMMON', data = radioList})
    SendNUIMessage({action = 'LIST_RADIO_HEIST', data = GlobalState.radioChannels})
end

-- NUI Callbacks
RegisterNUICallback('connectRadio', function (data, cb)
    -- data.channel.frequency = frekans
    connectFrequency(data.channel.frequency)
    cb("ok")
end)

RegisterNUICallback('disconnectRadio', function (data, cb)
    -- data.channel.frequency = frekans
    local connected = getRadioChannel()
    if not connected or connected == 0 then
        warn(string.format('Player %s is not connected to any radio channel, failed to disconnect', GetPlayerServerId(PlayerId())))
        cb("ok")
        return
    end
    disconnectRadio()
    cb("ok")
end)

-- Heist actions
RegisterNUICallback('createRadio', function (data, cb)
    if not data then
        return error('No data provided to create radio channel', 2)
    end

    TriggerServerEvent('dusa_dispatch:createRadio', data.created)
    cb("ok")
end)

RegisterNUICallback('removeRadio', function (data, cb)
    if not data then
        return error('No data provided to remove radio channel', 2)
    end

    TriggerServerEvent('dusa_dispatch:removeRadio', data.removed)
    cb("ok")
end)

RegisterNUICallback('joinRadio', function (data, cb)
    data.heistChannelId = tonumber(data.heistChannelId)
    connectFrequency(data.heistChannelId)
    TriggerServerEvent('dusa_dispatch:joinRadio', data.heistChannel)
    cb("ok")
end)

RegisterNUICallback('leaveRadio', function (data, cb)
    disconnectRadio()
    TriggerServerEvent('dusa_dispatch:leaveRadio', data.heistChannel)
    cb("ok")
end)

RegisterNetEvent('dusa_dispatch:UpdateRadioChannels', function (data)
    SendNUIMessage({action = 'LIST_RADIO_HEIST', data = data})
end)

return Radio