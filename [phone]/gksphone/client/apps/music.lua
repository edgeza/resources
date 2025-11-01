--- GKSPHONE MUSIC APP ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0
MusicData = {}
local volume = 0.2
StreamMode = false

RegisterNUICallback('gksphone:musicListen', function(data, cb)
    Debugprint("Listening to music", data)
    if data.type == "music" then
        TriggerServerEvent('gksphone:server:musicListen', data.musicid, volume, "play", data.time)
    elseif data.type == "call" then
        TriggerServerEvent('gksphone:server:musicListen', data.musicid, data.volume, data.type)
    end
    cb('ok')
end)

RegisterNUICallback('gksphone:client:playMusic', function(data, cb)
    Debugprint("Playing music", data)
    local check = 'ok'
    if data.action == "volume" then
        volume = data.volume
    end
    local id = CurrentPlayerId
    if data.action == "stopcall" then
        TriggerServerEvent('gksphone:server:musicListen', nil, nil, data.action, nil)
    elseif MusicData[id] then
        if data.action == "stop" and exports["gks-sound"]:soundExists(id) then
            local getTime = exports["gks-sound"]:getTimeStamp(id)
            check = {time = getTime}
        end
        TriggerServerEvent('gksphone:server:musicListen', data.musicid, data.action == "volume" and data.volume or nil, data.action, data.action == "seek" and data.seekTime or nil)
    elseif not MusicData[id] and data.action == "musicNext" then
        TriggerServerEvent('gksphone:server:musicListen', data.musicid, volume, "play", 0)
    end
    cb(check)
end)

RegisterNetEvent("gksphone:client:musicListen", function (action)
    if MusicData[CurrentPlayerId] then return end
    exports["gks-sound"]:onPlayStart(CurrentPlayerId, function(event)
        Debugprint("Music started", event)
        MusicData[CurrentPlayerId] = {sid = CurrentPlayerId}
        CreateThread(function()
            while true do
                if not MusicData[CurrentPlayerId] then
                    break
                end
                local duration = exports["gks-sound"]:getMaxDuration(CurrentPlayerId)
                local currentTime = exports["gks-sound"]:getTimeStamp(CurrentPlayerId)
                local progress = (currentTime / duration) * 100
                if type(progress) == "number" and progress ~= progress then
                    progress = 0
                end
                SendNUIMessage({
                    action = 'updateProgress',
                    progress = progress,
                    currentTime = currentTime,
                })
                Wait(200)
            end
        end)
    end)
    exports['gks-sound']:onPlayEnd(CurrentPlayerId, function(event)
        Debugprint("Music ended", event)
        SendNUIMessage({
            action = 'updatePlay',
            isPlay = false,
            isEnd = true
        })
    end)
    exports['gks-sound']:onPlayPause(CurrentPlayerId, function(event)
        Debugprint("Music paused", event)
        SendNUIMessage({
            action = 'updatePlay',
            isPlay = false
        })
    end)
    exports['gks-sound']:onPlayResume(CurrentPlayerId, function(event)
        Debugprint("Music resumed", event)
        SendNUIMessage({
            action = 'updatePlay',
            isPlay = true
        })
    end)
    exports['gks-sound']:onPlayDestroy(CurrentPlayerId, function(event)
        Debugprint("Music destroy", event)
        MusicData[CurrentPlayerId] = nil
        TriggerServerEvent("gksphone:server:musicDestroy", CurrentPlayerId)
    end)
end)

RegisterCommand("musicfix2", function(source, args)
    exports["gks-sound"]:mute()
end, false)