musics = {}
myPlaylists = {}
playlists = {}
xSound = exports.xsound

function SetupPlaylist()
    local playlist = lib.callback.await('dusa_hud:getPlaylist', false)
    TriggerEvent('table', playlist)
    if type(playlist) == 'string' then playlist = json.decode(playlist) end
    nuiMessage('setupPlaylist', {playlist = playlist})
end

RegisterNUICallback('updatePlaylist', function(data, cb)
    dp('Playlist', json.encode(data))
    local update = lib.callback.await('dusa_hud:updatePlaylist', false, data)
    cb("ok")
  end)

RegisterNUICallback('volumeUp', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('volumeDown', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('removeSong', function(data, cb)
    dp('Silinen şarkı: ', data)
    local remove = lib.callback.await('dusa_hud:removeMusic', false, data)
    cb('ok')
end)

RegisterNUICallback('skipSong', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('pauseSong', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('startMusic', function(data, cb)
    
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    dp('close ui')
    ToggleCursor(false)
    cb('ok')
end)

-- Events
RegisterNetEvent("dusa_hud:syncPlaylist")
-- local xs = exports.xsound
-- local generateId = function ()
--     return math.random(100000, 999999)
-- end
--[[
    setSoundDynamic(name, bool)
    destroyOnFinish(name, bool)
    setVolume(name,volume)
    Resume(name)
    Pause(name)
    Destroy(name)
    PlayUrlPos(name, url, volume, Vector3 vec, loop, options)

    -- Müziğin konumunu aracın koordinatına ver
    Position(name, Vector3 vec)

onPlayStart
onPlayEnd
onLoading
onPlayPause
onPlayResume
]]

-- local function ManageMusic(action, data)
--     local player = PlayerPedId()
--     local vehicle = GetVehiclePedIsIn(player)
--     local id = 1
--     if not vehicle or vehicle == 0 then end
--     local vpos = GetEntityCoords(vehicle)

--     if action ~= 'play' and not xs.soundExists('music_'..id) then
--         warn('Müzik mevcut değil')
--         return
--     end

--     if action == 'play' then
--         -- generateId
--         xs.PlayUrlPos('music_'..id, data.url, 0.5, vpos, false)
--         xs.setSoundDynamic('music_'..id, true)
--     elseif action == 'pause' then
--         xs.Pause('music_'..id)
--     elseif action == 'resume' then
--         xs.Resume('music_'..id)
--     elseif action == 'destroy' then
--         xs.Destroy('music_'..id)
--     elseif action == 'volume' then
--         xs.setVolume('music_'..id, data.volume)
--     end
-- end

RegisterNUICallback('runMusic', function(data, cb)
    -- ManageMusic(data.action, data)
    cb('ok')
end)


-- RegisterNetEvent("mHud:SetTimeStamp")
-- AddEventHandler("mHud:SetTimeStamp", function(src, timestamp)
--     if xSound:soundExists('music-'..src) then
--         xSound:setTimeStamp('music-'..src, timestamp)
--     end
-- end)

-- RegisterNetEvent("mHud:musicChange")
-- AddEventHandler("mHud:musicChange", function(src)
--     if xSound:soundExists('music-'..src) then
--         xSound:Destroy('music-'..src)
--     end
-- end)

-- function GetWindowsOpen(vehicle)
--     local open = false
--     for i=0, 3 do
--         local door = i
--         if door == 2 then
--             door = 3
--         elseif door == 3 then
--             door = 2
--         end
--         local isclosed = IsVehicleWindowIntact(vehicle,i)
--         if not isclosed and GetIsDoorValid(vehicle, door) then
--             open = true
--         end
--     end
--     return open
-- end



-- CreateThread(function()
--     while true do
--         for src, data in pairs(musics) do
--             if data then
--                 local player = GetPlayerFromServerId(src)
--                 if player ~= -1 then
--                     local ped = GetPlayerPed(player)
--                     local vehicle = GetVehiclePedIsIn(ped)
                    
--                     if vehicle and DoesEntityExist(vehicle) then
--                         if not xSound:soundExists('music-'..src) then
--                             xSound:PlayUrlPos('music-'..src, data.url, data.volume, GetEntityCoords(vehicle))
--                             xSound:setVolumeMax('music-'..src, 1.0)
--                             local myVehicle = GetVehiclePedIsIn(PlayerPed)
--                             if vehicle == myVehicle then
--                                 xSound:setVolume('music-'..src, data.volume)
--                             else
--                                 local count = 0

--                                 if  GetWindowsOpen(vehicle) then
--                                     count = 1/13
--                                 end

--                                 local volume = ((0.03) + count)
--                                 local distance = (#(GetEntityCoords(PlayerPed) - GetEntityCoords(vehicle))) / 90
--                                 xSound:setVolume('music-'..src, volume-distance)
--                             end

--                         else                        
--                             local url = xSound:getLink('music-'..src)
--                             if url ~= data.url then
--                                 xSound:Destroy('music-'..src)
--                                 xSound:PlayUrlPos('music-'..src, data.url, data.volume, GetEntityCoords(vehicle))
--                                 xSound:setVolumeMax('music-'..src, 1.0)       
--                                 if xSound:isPaused('music-'..src) then
--                                     xSound:Resume('music-'..src)      
--                                 end                              
--                             end
--                             if hudSettings.streamerMode then
--                                 xSound:setVolume('music-'..src, 0)
--                             else
--                                 local myVehicle = GetVehiclePedIsIn(PlayerPed)
--                                 if vehicle == myVehicle then
--                                     xSound:setVolume('music-'..src, data.volume)
--                                 else

--                                     local count = 0
--                                     if  GetWindowsOpen(vehicle) then
--                                         count = 1/13
--                                     end

--                                     local volume = ((0.03) + count)
--                                     local distance = (#(GetEntityCoords(PlayerPed) - GetEntityCoords(vehicle))) / 90
--                                     xSound:setVolume('music-'..src, volume-distance)
--                                 end
--                             end 
                          
--                             xSound:Position('music-'..src, GetEntityCoords(vehicle))
--                             if data.isPaused  then
--                                 xSound:Pause('music-'..src)
--                             elseif not data.isPaused then
--                                 xSound:Resume('music-'..src)
--                             end
                      
                           
              
--                             xSound:Distance('music-'..src, 130)
--                         end  
--                     else
--                         if xSound:soundExists('music-'..src) then
--                             xSound:Pause('music-'..src)   
--                             local mysrc = GetPlayerServerId(PlayerId()) 
                            
--                             if mysrc == src then
--                                 TriggerServerEvent("mHud:PauseMusic")
--                             end
--                         end 
--                     end
--                 end
--             else
--                 if xSound:soundExists('music-'..src) then
--                     xSound:Destroy('music-'..src)     
--                 end      
--             end
--         end
--         Wait(50)
--     end
-- end)

-- RegisterNetEvent("mHud:DestroyMusic")
-- AddEventHandler("mHud:DestroyMusic", function(src)
--     if xSound:soundExists('music-'..src) then
--         xSound:Destroy('music-'..src)     
--     end    
-- end)

-- CreateThread(function()
--     while true do
--         local src = GetPlayerServerId(PlayerId()) 
--         local cd = 2000
--         if xSound:soundExists('music-'..src) then
--             local maxDuration = xSound:getMaxDuration('music-'..src)
--             local timeStamp = xSound:getTimeStamp('music-'..src)
--             nuiMessage("SET_SONG_INFORMATIONS", {
--                 type = 'isPaused',
--                 value = xSound:isPaused('music-'..src),
--             })
--             nuiMessage("SET_SONG_INFORMATIONS", {
--                 type = 'volume',
--                 value = xSound:getVolume('music-'..src),
--             })
--             if not xSound:isPaused('music-'..src) then
--                 nuiMessage("SET_MUSIC_TIME", {
--                     maxDuration = maxDuration,
--                     timeStamp = timeStamp,
--                 })
--                 if (maxDuration == math.ceil(timeStamp)+1 or maxDuration == math.ceil(timeStamp)+2 or maxDuration == math.ceil(timeStamp)) and maxDuration ~= 0 then
--                     nuiMessage("CHANGE_MUSIC")   
--                 end
--             end
--             cd = 1000
--         end
--         Wait(cd)
--     end
-- end)