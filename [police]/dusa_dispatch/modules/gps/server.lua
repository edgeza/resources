--- CREATING - REMOVING CHANNELS
local gpsChannels = {}
local BlipProperties = {}

if not config.enableGPS then
    print('^3[Dispatch - GPS]^0 GPS is disabled in config.')
    return
end

local function createChannel(channel)
    for i = 1, #gpsChannels do
        if gpsChannels[i].channelId == channel.channelId then
            return
        end
    end

    gpsChannels[#gpsChannels + 1] = channel
    GlobalState.gpsChannels = gpsChannels
    TriggerClientEvent('dusa_dispatch:UpdateGpsChannels', -1, GlobalState.gpsChannels)
end
exports('CreateChannel', createChannel)
RegisterServerEvent('dusa_dispatch:createGps', createChannel)

local function removeChannel(channelId)
    for i = 1, #gpsChannels do
        if gpsChannels[i].channelId == channelId then
            for _, user in pairs(gpsChannels[i].users) do
                local player = Framework.GetPlayerByIdentifier(user.citizenId)
                RemoveLeftPlayerGps(player.source)
            end
            table.remove(gpsChannels, i)
            break
        end
    end
    TriggerClientEvent('dusa_dispatch:UpdateGpsChannels', -1, gpsChannels)
end
exports('RemoveChannel', removeChannel)
RegisterServerEvent('dusa_dispatch:removeGps', removeChannel)

local function updateChannel(channel)
    local src = source
    for i = 1, #gpsChannels do
        if gpsChannels[i].channelId == channel.channelId then
            gpsChannels[i].users = channel.users
            TriggerClientEvent('dusa_dispatch:UpdateGpsChannels', -1, gpsChannels)
            break
        end
    end
end
RegisterServerEvent('dusa_dispatch:joinGps', updateChannel)
RegisterServerEvent('dusa_dispatch:leaveGps', updateChannel)

function RemoveLeftPlayerGps(source)
    Player(source).state.gpsChannel = nil
    BlipProperties[source] = nil
    TriggerClientEvent('police:client:RemoveLeftPlayer', -1, source)
end
RegisterServerEvent('dusa_dispatch:server:RemoveLeftPlayerFromGps')

local function removeDispatchPlayer(playerId)
    TriggerClientEvent('police:client:RemoveDispatchPlayer', -1, playerId)
    TriggerClientEvent('dusa_dispatch:client:RemoveDisconnectedPlayer', -1, playerId)
end
RegisterServerEvent('dusa_dispatch:server:RemoveDispatchPlayer', removeDispatchPlayer)

local function updateBlips()
    local dutyPlayers = {}
    local players = Framework.GetPlayers()
    for _, xPlayer in pairs(players) do
        local source = xPlayer.source or xPlayer.PlayerData.source
        local player = Framework.GetPlayer(source)
        local channel = Player(source).state.gpsChannel
        local isGpsActive = channel or false

        if isGpsActive and Functions.IsPolice(player.Job.Name) then
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local properties = BlipProperties[source] or {}
            dutyPlayers[#dutyPlayers+1] = {
                src = source,
                name = player.Firstname ..' '..player.Lastname,
                loc = {math.floor(coords.x), math.floor(coords.y), math.floor(coords.z), math.floor(heading)},
                prop = properties,
                ch = channel,
                job = player.Job.Name,
                ident = player.Identifier,
            }
        end
    end

    TriggerClientEvent('police:client:UpdateBlips', -1, dutyPlayers)
end

RegisterServerEvent('police:server:UpsertBlipProperties', function (properties)
    if not properties then
        BlipProperties[source] = nil
        return
    end

    BlipProperties[source] = properties
end)

RegisterServerEvent('police:server:RemoveKickedPlayerFromList', function (playerId)
    Player(playerId).state.gpsChannel = nil
    BlipProperties[playerId] = nil
    updateBlips()
end)

CreateThread(function()
    while true do
        Wait(5000)
        updateBlips()
    end
end)
