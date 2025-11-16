-- if not lib then return end
function Log(_source, message, type, metadata)
    local LogProperties = {
        resource = GetCurrentResourceName(),
        message = message,
        type = type,
        metadata = metadata
    }

    if ServerConfig.LogService == 'fivemerr' then
        exports['fm-logs']:createLog({
            LogType = LogProperties.type,
            Resource = LogProperties.resource,
            Message = LogProperties.message,
            Metadata = LogProperties.metadata
        })
    elseif ServerConfig.LogService == 'fivemanage' then
        exports.fmsdk:LogMessage("warning", "Fishing Exploiter", metadata)
    elseif ServerConfig.LogService == 'discord' then
        local tag = ServerConfig.Discord.TagEveryone or false
        local webHook = ServerConfig.Discord.Webhook
        local embedData = {
            {
                ["title"] = ServerConfig.Discord.Title,
                ["color"] = ServerConfig.Discord.Color,
                ["footer"] = {
                    ["text"] = os.date("%c"),
                },
                ["description"] = message,
            }
        }
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Fishing Log",embeds = embedData}), { ['Content-Type'] = 'application/json' })
        Citizen.Wait(100)
        if tag then
            PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Fishing Log", content = "@everyone"}), { ['Content-Type'] = 'application/json' })
        end
    end
end

function SecureCheck(source, action)
    local Player = Framework.GetPlayer(source)
    if not Player then return false end

    if action == 'distance' then
        local playerCoords = GetEntityCoords(GetPlayerPed(source))
        local isNearAnyFisher = false

        for _, location in pairs(config.ped.locations) do
            local fisherCoords = location
            local distance = #(playerCoords - fisherCoords.xyz)

            if distance <= ServerConfig.DistanceChecks['fisher'] then
                isNearAnyFisher = true
                break
            end
        end

        if not isNearAnyFisher then
            lib.print.error('[EXPLOITER WARNING] player tried to open fisher too far (game id, name, rp name, identifier)',
                source, Player.Name, Player.Firstname .. ' ' .. Player.Lastname, Player.Identifier)
            BanDropExploiter(source, 'Player tried to open fisher too far')
            return false
        end
    end

    return true
end

function BanDropExploiter(source, reason)
    local Player = Framework.GetPlayer(source)

    local tempData = {
        playerSource = source,
        name = Player.Name,
        rpname = Player.Firstname .. ' ' .. Player.Lastname,
        identifier = Player.Identifier,
        job = Player.Job.Name,
        reason = reason,
    }

    if ServerConfig.BanExploiter then
        ServerConfig.BanFunction(source, reason)
        Log(source, 'Player has been banned for exploiting', 'exploiter', tempData)
        return
    end

    if ServerConfig.DropExploiter then
        DropPlayer(source, '[FISHING] You have been kicked from the server for exploiting (' .. reason .. ')')
        Log(source, 'Player has been kicked for exploiting', 'exploiter', tempData)
        return
    end
end

lib.callback.register('dusa_fishing:shopCfg', function (_source, shopCfg)
    ServerConfig.Shop = shopCfg
end)