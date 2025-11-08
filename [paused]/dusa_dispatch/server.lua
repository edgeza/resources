if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end


-- ██╗░░░██╗██████╗░██╗░░░░░░█████╗░░█████╗░██████╗░
-- ██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔══██╗
-- ██║░░░██║██████╔╝██║░░░░░██║░░██║███████║██║░░██║
-- ██║░░░██║██╔═══╝░██║░░░░░██║░░██║██╔══██║██║░░██║
-- ╚██████╔╝██║░░░░░███████╗╚█████╔╝██║░░██║██████╔╝
-- ░╚═════╝░╚═╝░░░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

-- Upload Service
--- @param -- discord / fivemanage
local uploadService = 'discord' -- discord / fivemanage

--- @param -- webhook / apikey
-- If you use fivemanage, you need to set your API key from here
-- If you use discord, you need to set your webhook from here
local serviceAPI = ""

--------------------------------------------------------

if serviceAPI == "" or not serviceAPI then
    print("^1 [IMPORTANT] ^3Please set a service API for image uploading in the ^4dusa_dispatch/server.lua^0")
end

local PlayerData = {}
UserList = {}

function ServerPlayerLoadHandler(source)
    local Player = Framework.GetPlayer(source)
    if not Player then return end
    
    local IsPolice = Functions.IsPolice(Player.Job.Name)
    if IsPolice then
        local isIncluded = Utils.isInTable(UserList, 'gameId', source)
        if not isIncluded then
            UserList[#UserList + 1] = {
                name = Player.Firstname .. ' ' .. Player.Lastname,
                citizenId = Player.Identifier,
                job = Player.Job.Name,
                jobRank = Player.Job.Grade.Name,
                gameId = source,
            }
        end
    end
end

lib.callback.register('dispatch:getAgentList', function()
    return UserList
end)

lib.callback.register('dispatch:updateAgentList', function(source)
    local Player = Framework.GetPlayer(source)
    local isIncluded = Utils.isInTable(UserList, 'gameId', source)
    local IsPolice = Functions.IsPolice(Player.Job.Name)
    if IsPolice then
        if not isIncluded then
            UserList[#UserList + 1] = {
                name = Player.Firstname .. ' ' .. Player.Lastname,
                citizenId = Player.Identifier,
                job = Player.Job.Name,
                jobRank = Player.Job.Grade.Name,
                gameId = source,
            }
        end
    elseif isIncluded then
        Utils.removeFromTable(UserList, 'gameId', source)
    end
    return UserList
end)

lib.callback.register('dispatch:getUploadAPI', function ()
    return uploadService, serviceAPI
end)

CreateThread(function ()
    for k, v in pairs(config.Commands) do
        if v.enabled then
            lib.addCommand(v.command, {
                help = v.help,
            }, function(source, args, raw)
                TriggerClientEvent(v.event, source)
            end)
        end
    end
end)

RegisterNetEvent('dispatch:server:playerLoaded', function ()
    Framework.OnPlayerLoaded(source)
end)

Framework.OnPlayerLoaded = function (source)
    ServerPlayerLoadHandler(source)
    BodycamLoadHandler(source)
    SettingsLoadHandler(source)
end

Framework.OnPlayerUnload = function (source)
    BodycamUnloadHandler(source)
    if not shared.compatibility then
        RemoveLeftPlayerGps(source)
    end
    Utils.removeFromTable(UserList, 'gameId', source)
end