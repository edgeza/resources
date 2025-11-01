CoreAwait()
playerPlaylist = {}

CreateThread(function()
    Wait(1000)
    createServerPlaylists() 
end)

function createServerPlaylists()
    local data = db.query("hud_settings", {"playlist", "citizenid"})
    for i,v in pairs(data) do
        playerPlaylist[v.citizenid] = json.decode(v.playlist)
        dp('Playlist added for player', v.citizenid, playerPlaylist[v.citizenid])
    end
end

function synchronizePlaylist()
    TriggerClientEvent('dusa_hud:syncPlaylist', -1, playerPlaylist)
end

lib.callback.register("dusa_hud:updatePlaylist", function(source, playlist)
    local citizenid = GetIdentifier(source)
    local data_playlist = playerPlaylist[citizenid]
    if not data_playlist then error('Callback: updatePlaylist - Player couldnt find at playerPlaylist table, this error caused by current player dont have any data at database. - Code 468') return end
    dp('updated playlist')
    db.save("hud_settings", "playlist", "citizenid", json.encode(playlist), citizenid)
    if type(playlist) == 'string' then playlist = json.decode(playlist) end
    playerPlaylist[citizenid] = playlist
    synchronizePlaylist()
    return true
end)

lib.callback.register("dusa_hud:getPlaylist", function(source)
    local citizenid = GetIdentifier(source)
    local playlist = playerPlaylist[citizenid]
    if type(playlist) == 'string' then playlist = json.decode(playlist) end
    return playlist
end)

lib.callback.register("dusa_hud:removeMusic", function(source, url)
    local citizenid = GetIdentifier(source)
    local playlist = playerPlaylist[citizenid]
    if type(playlist) == 'string' then playlist = json.decode(playlist) end
    for i,v in pairs(playlist) do
        if v.url == url then
            dp('removed music', url)
            table.remove(playlist, i)
            db.save("hud_settings", "playlist", "citizenid", json.encode(playlist), citizenid)
        end
    end
    playerPlaylist[citizenid] = playlist
    synchronizePlaylist()
    return true
end)
