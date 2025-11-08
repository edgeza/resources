
if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

local BodycamList = {}

function BodycamLoadHandler(source)
    local src = source
    if not src then return end
    local player = Framework.GetPlayer(src)

    if player then
        local IsPolice = Functions.IsPolice(player.Job.Name)
        if IsPolice then
            local isIncluded = Utils.isInTable(BodycamList, 'gameId', src)
            if not isIncluded then
                BodycamList[#BodycamList + 1] = {
                    name = player.Firstname .. ' ' .. player.Lastname,
                    citizenId = player.Identifier,
                    job = player.Job.Name,
                    gameId = src
                }
            end
        end
    end
end

function BodycamUnloadHandler(source)
    if not source then return end

    for k, v in pairs(BodycamList) do
        if v.gameId == source then
            table.remove(BodycamList, k)
        end
    end
end

exports('GetBodycamList', function()
    return BodycamList
end)

lib.callback.register('bodycam:getBodycamList', function(source, removeSelf)
    return BodycamList
end)

lib.callback.register('bodycam:getBodycamCoords', function(_, id)
    local ped = GetPlayerPed(id)
    local playerCoords = GetEntityCoords(ped)
    return playerCoords
end)

lib.callback.register('bodycam:getBodycamPed', function (_, id)
    local ped = GetPlayerPed(id)
    local netId = NetworkGetNetworkIdFromEntity(ped)
    return netId
end)