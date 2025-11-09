local function formatRewards(table)
    local rewards = ''
    for _, reward in pairs(table) do
        rewards = rewards .. string.format('**%s** (`%s`) x%s\n', reward.label, reward.item, reward.amount)
    end

    return rewards
end

AddEventHandler('rcore_xmas:log', function(name, data)
    local found = false
    for _, logName in pairs(Logs) do
        if logName == name then
            found = true
            break
        end
    end

    if not found then
        log.error('Log %s does not exist!', name)
        return
    end

    if not ServerConfig.Discord.Enabled then return end

    local webhook = ServerConfig.Discord.Webhooks[name]
    if data.data.position == nil then
        data.data.position = {
            coords = {
                x = 0,
                y = 0,
                z = 0,
            },
            rotation = {
                x = 0,
                y = 0,
                z = 0,
            },
            heading = 0,
        }
    end

    if data.data.position.coords == nil then
        data.data.position.coords = {
            x = 0,
            y = 0,
            z = 0,
        }
    end

    if data.data.position.rotation == nil then
        data.data.position.rotation = {
            x = 0,
            y = 0,
            z = 0,
        }
    end

    sendWebhook({
        url = webhook.url,
        username = webhook.username,
        content = webhook.content or '',
        embeds = webhook.embeds or {},
    }, {
        ['{player.id}'] = data.player.id,
        ['{player.name}'] = data.player.name,
        ['{player.identifier}'] = data.player.identifier,
        ['{data.tree}'] = data.data.tree,
        ['{data.snowman}'] = data.data.snowman,
        ['{data.part}'] = data.data.part,
        ['{data.position.coords}'] = string.format('x: %s, y: %s, z: %s', data.data.position.coords.x,
            data.data.position.coords.y, data.data.position.coords.z),
        ['{data.position.rotation}'] = string.format('x: %s, y: %s, z: %s', data.data.position.rotation.x,
            data.data.position.rotation.y, data.data.position.rotation.z),
        ['{data.position.heading}'] = data.data.position.heading,
        ['{data.present}'] = data.data.present,
        ['{data.gift}'] = data.data.gift,
        ['{data.nametag}'] = data.data.nametag,
        ['{data.rewards}'] = formatRewards(data.data.rewards or {}),
    })
end)

function sendWebhook(webhook, placeholders)
    local function multiGsub(str, vals)
        local result = str
        for placeholder, replacement in pairs(vals) do
            result = string.gsub(result, placeholder, replacement)
        end
        return result
    end

    local function replace(table, placeholders)
        local temp = {}
        for key, value in pairs(table) do
            if type(value) == 'table' then
                temp[key] = replace(value, placeholders)
            elseif type(value) == 'string' then
                local result = multiGsub(value, placeholders)
                temp[key] = result
            end
        end
        return temp
    end

    if webhook.url == nil then
        return
    end

    if placeholders ~= nil then
        webhook.embeds = replace(webhook.embeds, placeholders)
    end

    PerformHttpRequest(
        webhook.url,
        function(err, text, headers)
        end,
        'POST',
        json.encode(webhook),
        {
            ['Content-Type'] = 'application/json',
        }
    )
end
