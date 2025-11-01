local fmsdk = GetResourceState('fmsdk') == 'started'
local fmlogs = GetResourceState('fm-logs') == 'started'

--Edit the Webhook
local Webhook = ""
Log = function(message)
    if not Config.Logging.LogEnable then return end
    if Config.Logging.LogType == 'fivemanage' then
        if not fmsdk then return end
            exports.fmsdk:LogMessage('info', message)
    elseif Config.Logging.LogType == 'fivemerr' then
        if not fmlogs then return end
            exports['fm-logs']:createLog({
                LogType = 'Resource',
                Resource = 'pl_koi',
                Level = 'info',
                Message = message,
            })
    elseif Config.Logging.LogType == 'discord' then
        PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({
            username = Config.Jobname,
            embeds = {{
                ["color"] = 16711680,
                ["author"] = {
                    ["name"] = "PL Logs",
                    ["icon_url"] = "https://r2.fivemanage.com/4YyjwlVZsyhSQqbpwvriN/images/pulsescriptsnewlogo.png"
                },
                ["title"] = Config.Jobname,
                ["description"] = message
            }}, 
            avatar_url = 'https://r2.fivemanage.com/4YyjwlVZsyhSQqbpwvriN/images/pulsescriptsnewlogo.png'
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end

CreateThread(function()
    if Config.Logging.LogEnable then
        if Webhook == "" then
            print("^1[pl_koi] Please enter a valid webhook URL in server/Log.lua^0")
        end
    end
end)