if not Config.AntiCheat then return end

local bannedWordWebhook = 'CHANGEME' --Add your Discord webhook URL here
local eventSpamWebhook = 'CHANGEME' --Add your Discord webhook URL here

function bannedWordDiscordLog(source, eventName, bannedWord, flaggedMessage)
    if bannedWordWebhook ~= nil and #bannedWordWebhook > 10 then
        local identifier = GetIdentifier(source)
        local name = GetPlayerName(source)
        local data = {{
            ['color'] = '2061822',
            ['title'] = GetLocales('discordlogs_bannedword_title'),
            ['description'] = GetLocales('discordlogs_bannedword_message', source, identifier, name, GetLocales('dropped_player'), eventName, bannedWord, flaggedMessage),
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        if Config.AntiCheat.BannedWords.discord_tag_everyone then
            PerformHttpRequest(bannedWordWebhook, function(err, text, headers) end, 'POST', json.encode({username = GetLocales('dispatch'), content = GetLocales('discordlogs_everyone')}), { ['Content-Type'] = 'application/json' })
        end
        PerformHttpRequest(bannedWordWebhook, function(err, text, headers) end, 'POST', json.encode({username = GetLocales('dispatch'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end

function spamEventDiscordLog(source, eventName, spamCount, spamLimit)
    if eventSpamWebhook ~= nil and #eventSpamWebhook > 10 then
        local identifier = GetIdentifier(source)
        local name = GetPlayerName(source)
        local data = {{
            ['color'] = '2061822',
            ['title'] = GetLocales('discordlogs_eventspam_title'),
            ['description'] = GetLocales('discordlogs_eventspam_message', source, identifier, name, GetLocales('dropped_player'), eventName, spamCount, spamLimit),
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        if Config.AntiCheat.EventSpam.discord_tag_everyone then
            PerformHttpRequest(eventSpamWebhook, function(err, text, headers) end, 'POST', json.encode({username = GetLocales('dispatch'), content = GetLocales('discordlogs_everyone')}), { ['Content-Type'] = 'application/json' })
        end
        PerformHttpRequest(eventSpamWebhook, function(err, text, headers) end, 'POST', json.encode({username = GetLocales('dispatch'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end