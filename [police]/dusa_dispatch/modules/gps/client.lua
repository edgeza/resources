if not rawget(_G, "lib") then include('ox_lib', 'init') end

GPS = {}
IsEscorted = false
local dutyBlips = {}
local vehicleBlips = {}
local PlayerState = LocalPlayer.state
local PlayerGpsChannel = {}
local history = {}
local PlayerGpsProperties = {}
local dict, inAnim, outAnim = 'cellphone@', 'cellphone_text_in', 'cellphone_text_out'
local gpsChannels = {}
-----------------
--- FUNCTIONS ---
-----------------
local timer = 2000
local connectTimeout = false

if not config.enableGPS then
    print('^3[Dispatch - GPS]^0 GPS is disabled in config.')
    return
end

function ListGPS()
    local gpsList = {}
    for k, v in pairs(config.gpsConfiguration) do
        if Framework.Player.Job.Name == v.job then
            table.insert(gpsList, 1, {
                title = v.title,
                job = v.job,
                id = k,
                item = v.commonChannels
            })
        else
            table.insert(gpsList, {
                title = v.title,
                job = v.job,
                id = k,
                item = v.commonChannels
            })
        end
    end

    local playerList = {}
    for id, player in pairs(PlayerGpsChannel) do
        playerList[#playerList + 1] = {
            id = id,
            name = player.name,
            citizenId = player.ident,
            job = player.job,
            icon = player.job .. 'Civil',
            position = { x = player.loc?[1], y = player.loc?[2] }
        }
        if config.debug and not player.loc then
            print('^3 METHOD ListGPS ^0 player.loc not found', json.encode(player, { indent = true }))
        end
    end

    SendNUIMessage({ action = 'LIST_GPS_COMMON', data = gpsList })
    SendNUIMessage({ action = 'LIST_GPS_HEIST', data = gpsChannels })
    local pData = {
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        job = Framework.Player.Job.Name,
        jobRank = Framework.Player.Job.Grade.Name,
        citizenId = Framework.Player.Identifier
    }
    SendNUIMessage({ action = 'GPS_PLAYER', data = pData })
    SendNUIMessage({ action = 'SETUP_GPS_ICONS', data = { list = playerList, type = pData.job .. 'Civil' } })
end

local function isGpsActive()
    return PlayerState.gpsChannel or false
end

local function CreateDutyBlips(playerId, playerName, playerLocation, playerProperties, playerChannel, playerSource)
    if not Functions.IsPolice(Framework.Player.Job.Name) then return end
    local ped = GetPlayerPed(playerId)
    local blip = GetBlipFromEntity(ped)

    if not isGpsActive() then
        return
    end

    if playerChannel ~= PlayerState.gpsChannel then
        PlayerGpsChannel[playerId] = nil
        return
    end

    if not DoesBlipExist(blip) then
        if NetworkIsPlayerActive(playerId) then
            blip = AddBlipForEntity(ped)
        else
            blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
        end
        SetBlipSprite(blip, 1)
        ShowHeadingIndicatorOnBlip(blip, true)
        SetBlipRotation(blip, math.ceil(playerLocation.w))
        SetBlipScale(blip, 1.0)

        if playerProperties?.color then
            SetBlipColour(blip, playerProperties.color)
        else
            SetBlipColour(blip, 5)
        end

        local label = playerProperties?.label or 'Unknown'

        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(label)
        EndTextCommandSetBlipName(blip)

        if config.CategorizeBlips then
            SetBlipCategory(blip, 10)
            AddTextEntry('BLIP_PROPCAT', config.DispatchBlipCategory)
        end
        dutyBlips[#dutyBlips + 1] = blip
    end

    -- if GetBlipFromEntity(cache.ped) == blip then
    --     -- Ensure we remove our own blip.
    --     RemoveBlip(blip)
    -- end
end

---comment
---@param pgc PlayerGpsChannel
local function updateUIGps(pgc)
    if not Functions.IsPolice(Framework.Player.Job.Name) then return end
    if pgc and next(pgc) then
        PlayerGpsChannel = pgc
    end

    local playerList = {}
    for id, player in pairs(PlayerGpsChannel) do
        -- if not player then return end
        playerList[#playerList + 1] = {
            id = id,
            name = player.name,
            citizenId = player.ident,
            job = player.job,
            icon = player.job .. 'Civil',
            position = { x = player.loc?[1], y = player.loc?[2] }
        }
        if config.debug and not player.loc then
            print('^3 METHOD updateUIGps ^0 player.loc not found', json.encode(player, { indent = true }))
        end
    end

    SendNUIMessage({ action = 'SETUP_GPS_ICONS', data = { list = playerList, type = Framework.Player.Job.Name .. 'Civil' } })
end
RegisterNetEvent('dispatch:client:UpdateUIGps', updateUIGps)

function RemoveDutyBlips()
    for i = 1, #dutyBlips do
        RemoveBlip(dutyBlips[i])
    end
    dutyBlips = {}
end

local function connectGps(channel)
    if not channel then
        return
    end

    -- Eğer gpsi açıksa bir işlem yap
    if isGpsActive() then
        RemoveDutyBlips()
    end

    -- Handle Properties
    local properties = {
        label = Functions.Callsign() .. ' - ' .. Framework.Player.Firstname .. " " .. Framework.Player.Lastname,
        color = Functions.GetGpsColor(Framework.Player.Job.Name),
    }

    -- Oyuncunun local propertiesini güncelle
    PlayerGpsProperties = properties

    -- Oyuncunun Gps kanalını koda güncelle
    PlayerState:set("gpsChannel", channel, true)

    TriggerServerEvent('police:server:UpsertBlipProperties', properties)
end
exports('ConnectGps', function(channel)
    connectGps(channel)
end)

RegisterNUICallback('connectGps', function(data, cb)
    data.channelCode = data.channel
    if connectTimeout then
        warn('You are trying to connect too fast', 2)
        cb("error")
        return
    end

    -- Dispatch yazılı gps kanalı kullanabilir
    -- if type(data.channelCode) == 'string' then
    --     data.channelCode = tonumber(data.channelCode)
    -- end
    connectGps(data.channelCode.code)

    connectTimeout = true
    SetTimeout(timer, function()
        connectTimeout = false
    end)

    cb("ok")
end)

RegisterNUICallback('joinGps', function(data, cb)
    connectGps(data.heistChannel.name)
    TriggerServerEvent('dusa_dispatch:joinGps', data.heistChannel)
    cb("ok")
end)


function DisconnectGps()
    if not isGpsActive() then
        Framework.Notify(locale('gps.not_connected_gps'), 'error')
        return
    end


    RemoveDutyBlips()
    PlayerState:set('gpsChannel', nil, true)
    PlayerGpsProperties = {}
    PlayerGpsChannel = {}
    updateUIGps()

    TriggerServerEvent('police:server:UpsertBlipProperties', false)
end

exports('DisconnectGps', DisconnectGps)

RegisterNUICallback('disconnectGps', function(data, cb)
    local source = GetPlayerServerId(PlayerId())
    TriggerEvent('police:client:DisconnectGps')
    TriggerServerEvent('dusa_dispatch:server:RemoveDispatchPlayer', source)
    cb("ok")
end)

RegisterNUICallback('leaveGps', function(data, cb)
    if not isGpsActive() then
        Framework.Notify(locale('gps.not_connected_gps'), 'error')
        cb("error")
        return
    end
    local source = GetPlayerServerId(PlayerId())
    TriggerEvent('police:client:DisconnectGps')
    TriggerServerEvent('dusa_dispatch:leaveGps', data.heistChannel)
    TriggerServerEvent('dusa_dispatch:server:RemoveDispatchPlayer', source)
    cb("ok")
end)

RegisterNUICallback('kickPlayer', function(data, cb)
    if data.id then
        PlayerGpsChannel[data.id] = nil
        TriggerServerEvent('police:server:RemoveKickedPlayerFromList', data.id)
    end
    cb("ok")
end)

--------------
--- GPS UI ---
--------------
local function removePlayerFromGps(playerId)
    playerId = tonumber(playerId)
    PlayerGpsChannel[playerId] = nil
    updateUIGps()
end
RegisterNetEvent('police:client:RemoveLeftPlayer', removePlayerFromGps)
RegisterNetEvent('dusa_dispatch:client:RemoveDisconnectedPlayer', removePlayerFromGps)

-- Creating GPS Channel
RegisterNUICallback('createGps', function(data, cb)
    if not data then
        return error('No data received from NUI', 2)
    end

    TriggerServerEvent('dusa_dispatch:createGps', data.created)
    cb("ok")
end)

RegisterNUICallback('removeGps', function(data, cb)
    if not data then
        return error('No data received from NUI', 2)
    end

    TriggerServerEvent('dusa_dispatch:removeGps', data.removed)
    cb("ok")
end)

RegisterNetEvent('dusa_dispatch:UpdateGpsChannels', function(data)
    gpsChannels = data
    SendNUIMessage({ action = 'LIST_GPS_HEIST', data = data })
end)


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    -- Clean up blips and reset GPS state
    RemoveDutyBlips()
    PlayerState:set('gpsChannel', nil, true)
    PlayerGpsProperties = {}
    PlayerGpsChannel = {}

    -- Notify server to clean up any remaining data
    TriggerServerEvent('police:server:UpsertBlipProperties', false)
end)


if shared.compatibility then
    print(
    '^3[Dispatch - GPS]^0 dusa_police detected, removed gps module from dispatch: ^5 Police already providing a gps system')
    return
end

-- GPS PLAYER LIST

RegisterNetEvent('police:client:DisconnectGps', DisconnectGps)

RegisterNetEvent('police:client:UpdateBlips', function(players)
    if not Framework.Player.Loaded then
        return
    end
    if Framework.Player.Job and Functions.IsPolice(Framework.Player.Job.Name) then
        RemoveDutyBlips()
        if players then
            for i = 1, #players do
                local id = GetPlayerFromServerId(players[i].src)
                local coords = vec4(players[i].loc[1], players[i].loc[2], players[i].loc[3], players[i].loc[4])
                PlayerGpsChannel[players[i].src] = players[i]
                CreateDutyBlips(id, players[i].name, coords, players[i].prop, players[i].ch, players[i].src)
                if config.debug and not players[i].loc then
                    print('^3 METHOD UpdateBlips ^0 players[i].loc not found', json.encode(players[i], { indent = true }))
                end
            end
        end
        updateUIGps()
    end
end)

-----------------
--- UI EVENTS ---
-----------------

RegisterNetEvent('police:client:ConnectGps', function(channel)
    connectGps(channel)
end)