local LogService = 'discord' -- fivemerr, discord, fivemanage

local Discord = {
    Webhook = '',
    Title = 'Chat Log',
    Color = 16711680,
}

function Log(source, message, type, metadata)
    local LogProperties = {
        resource = GetCurrentResourceName(),
        message = message,
        type = type,
        metadata = metadata
    }

    if LogService == 'fivemerr' then
        exports['fm-logs']:createLog({
            LogType = LogProperties.type,
            Resource = LogProperties.resource,
            Message = LogProperties.message,
            Metadata = LogProperties.metadata
        })
    elseif LogService == 'fivemanage' then
        exports.fmsdk:LogMessage("info", "Chat Log", {
            playerSource = source,
            type = LogProperties.type,
            message = LogProperties.message,
            metadata = LogProperties.metadata
        })
    elseif LogService == 'discord' then
        local webHook = Discord.Webhook
        local embedData = {
            {
                ["title"] = string.upper(LogProperties.type),
                ["color"] = Discord.Color,
                ["fields"] = {
                    {
                        ["name"] = "Player",
                        ["value"] = string.format("**Name:** %s\n**ID:** %s", metadata.rpname, metadata.playerSource),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Details",
                        ["value"] = string.format("**Command:** %s\n**Job:** %s", metadata.command, metadata.job),
                        ["inline"] = true
                    }
                },
                ["description"] = "```" .. message .. "```",
                ["footer"] = {
                    ["text"] = os.date("%c")
                },
                ["thumbnail"] = {
                    ["url"] = "https://i.ibb.co/TqFSrQ5R/logohd.png"
                }
            }
        }
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({
            username = Discord.Title,
            avatar_url = "https://i.ibb.co/TqFSrQ5R/logohd.png",
            embeds = embedData
        }), { ['Content-Type'] = 'application/json' })
    end
end
