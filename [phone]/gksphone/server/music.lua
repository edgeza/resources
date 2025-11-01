local musicData = {}

RegisterNetEvent("gksphone:server:musicListen", function (musicid, volume, action, time)
    Debugprint("Music event", {musicid, volume, action, time, source})
    local src = source
    if action == "play" then
        musicData[src] = "play"
        exports["gks-sound"]:PlayUrlPos(-1, src, musicid, volume, time)
        TriggerClientEvent("gksphone:client:musicListen", src)
    elseif action == "volume" then
        if musicData[src] then
            exports["gks-sound"]:SetVolume(-1, src, volume)
        end
    elseif action == "pause" or action == "resume" or action == "stop" or action == "stopcall" then
        if action == "stop" or action == "stopcall" then
            musicData[src] = nil
            exports["gks-sound"]:Destroy(-1, src)
        elseif action == "pause" then
            exports["gks-sound"]:Pause(-1, src)
        elseif action == "resume" then
            exports["gks-sound"]:Resume(-1, src)
        end
    elseif action == "seek" then
        exports["gks-sound"]:SeekTo(-1, src, time)
    elseif action == "call" then
        musicData[src] = "call"
        exports["gks-sound"]:PlayUrlPos(-1, src, musicid, volume, time)
    elseif action == "musicNext" then
        if musicData[src] then
            exports["gks-sound"]:SetChangeMusic(-1, src, musicid)
        else
            musicData[src] = "play"
            exports["gks-sound"]:PlayUrlPos(-1, src, musicid, 0.2, nil)
            TriggerClientEvent("gksphone:client:musicListen", src)
        end
    end
end)

RegisterNetEvent("gksphone:server:musicDestroy", function (musicid)
    if musicData[musicid] then
        musicData[musicid] = nil
    end
end)

AddEventHandler('playerDropped', function (reason)
    local src = source
    if src then
        if musicData[src] then
            exports["gks-sound"]:Destroy(-1, src)
            musicData[src] = nil
        end
    end
end)

AddEventHandler("gksphone:server:PlayerItemRemoved", function()
    local src = source
    if musicData[src] then
        exports["gks-sound"]:Destroy(-1, src)
        musicData[src] = nil
    end
end)