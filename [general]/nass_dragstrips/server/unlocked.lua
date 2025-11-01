--[[
███╗   ██╗ █████╗ ███████╗███████╗    ██████╗ ██████╗  █████╗  ██████╗ ███████╗████████╗██████╗ ██╗██████╗ ███████╗
████╗  ██║██╔══██╗██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝
██╔██╗ ██║███████║███████╗███████╗    ██║  ██║██████╔╝███████║██║  ███╗███████╗   ██║   ██████╔╝██║██████╔╝███████╗
██║╚██╗██║██╔══██║╚════██║╚════██║    ██║  ██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║   ██╔══██╗██║██╔═══╝ ╚════██║
██║ ╚████║██║  ██║███████║███████║    ██████╔╝██║  ██║██║  ██║╚██████╔╝███████║   ██║   ██║  ██║██║██║     ███████║
╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝

https://discord.gg/nass
]]
local webhook = "https://discord.com/api/webhooks/1218964393249734717/kOZ9L9LTZsZGdQ22E-Achgb0YylAggEv7bKZus4e9wsPe_7EdxQ3yXfjysIHk-tp0UwD"

--add_ace group.admin command.dragstrips allow
RegisterCommand("dragstrips", function(source)
    TriggerClientEvent("nass_dragstrips:openDragstripMenu", source)
end, true)

function sendToDiscord(data)
    local embed = {
        {
            title = ""..data.strip.name .. " " .. namedDistance[data.strip.distance],
            fields = {},
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/224653951335792640/1218377071512911903/logopng.png"
            },
            color = data.color
        }
    }
    table.insert(embed[1].fields, {
        name = "**Name**",
        value = "" .. data.first.name .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Name**",
            value = "" .. data.second.name .. "",
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Time**",
        value = "" .. data.first.time .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Time**",
            value = "" .. data.second.time .. "",
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Top Speed**",
        value = "" .. data.first.speed .. " " .. (data.first.speed ~= Config.locale["dnf"] and (Config.MPH and Config.locale["mph"] or Config.locale["kph"])or""),
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Top Speed**",
            value = "" .. data.second.speed .. " " .. (data.second.speed ~= Config.locale["dnf"] and (Config.MPH and Config.locale["mph"] or Config.locale["kph"])or""),
            inline = true
        })
    end

    -- Spacer
    table.insert(embed[1].fields, {
        name = "",
        value = "",
        inline = false
    })
    -- Spacer

    table.insert(embed[1].fields, {
        name = "**Car**",
        value = "" .. data.first.model .. "",
        inline = true
    })
    if data.second then
        table.insert(embed[1].fields, {
            name = "**Car**",
            value = "" .. data.second.model .. "",
            inline = true
        })
    end

    PerformHttpRequest(webhook, function(err, text, headers) end,"POST",
        json.encode({
            username = "Nass Scripts",
            embeds = embed,
            avatar_url = "https://cdn.discordapp.com/attachments/224653951335792640/1218377071512911903/logopng.png"
        }),{["Content-Type"] = "application/json"})
end

nass.versionCheck(GetCurrentResourceName())