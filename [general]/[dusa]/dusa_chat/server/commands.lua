local function convertCommand(command)
    local commandProperties = {}

    commandProperties.help = command?.description or ""
    commandProperties.restricted = command?.permission or nil

    if command?.parameters then
        commandProperties.params = {}
        for _, parameter in ipairs(command.parameters) do
            local param = {}
            param.name = parameter.name
            param.type = parameter.type
            param.help = parameter.help or ""
            param.optional = parameter.optional or false
            table.insert(commandProperties.params, param)
        end
    end

    return commandProperties
end

local function announcement(source, message, duration)
    if not message then return end
    local Player = Framework.GetPlayer(source)
    local tempData = {
        playerSource = source,
        name = Player.Name,
        rpname = Player.Firstname .. ' ' .. Player.Lastname,
        identifier = Player.Identifier,
        job = Player.Job.Name,
        command = "/" .. Config.Commands.announcement.command,
        message = message,
    }

    Log(source, message, 'announcement', tempData)
    
    TriggerClientEvent('dusa_chat:client:announcement', -1, message, duration or Config.Commands.announcement.duration)
end

lib.addCommand(Config.Commands.announcement.command, convertCommand(Config.Commands.announcement), function(source, args, raw)
    local messageText = raw:gsub("^%S+%s+", "")
    announcement(source, messageText, Config.Commands.announcement.duration)
end)
exports('Announcement', announcement)
RegisterServerEvent('dusa_chat:server:announcement', function(message, duration)
    announcement(source, message, duration)
end)

if Config.Commands.adminchat and Config.Commands.adminchat.enabled then
    local command = {
        description = Config.Commands.adminchat.description,
        parameters = Config.Commands.adminchat.parameters,
        permission = Config.Commands.adminchat.permission,
    }

    lib.addCommand(Config.Commands.adminchat.command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "")
        local name = Config.Commands.adminchat.useRoleplayName
            and Player.Firstname .. " " .. Player.Lastname
            or Player.Name

        local messageProperties = {
            name = name,
            id = source,
            command = "/" .. Config.Commands.adminchat.command,
            type = Config.Commands.adminchat.customization.label,
            color = Config.Commands.adminchat.customization.color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:adminChat', -1, messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Config.Commands.adminchat.command,
            message = messageText,
        }
    
        Log(source, messageText, 'adminchat', tempData)
    end)
end

if Config.Commands.pm and Config.Commands.pm.enabled then
    local command = {
        description = Config.Commands.pm.description,
        parameters = Config.Commands.pm.parameters,
    }

    lib.addCommand(Config.Commands.pm.command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local targetPlayer = Framework.GetPlayer(args.target)
        local messageText = raw:gsub("^%S+%s+%d+%s+", "") -- Remove command, spaces, number and following space
        if not targetPlayer then return end

        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Config.Commands.pm.command,
            type = Config.Commands.pm.customization.label,
            color = Config.Commands.pm.customization.color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:pm', args.target, messageProperties)
        TriggerClientEvent('dusa_chat:client:pm', source, messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Config.Commands.pm.command,
            target = args.target,
            message = messageText,
        }
    
        Log(source, messageText, 'pm', tempData)
    end)
end


if Config.JobChat and Config.JobChat.enabled then
    local command = {
        description = Config.JobChat.description,
        parameters = Config.JobChat.parameters,
    }

    lib.addCommand(Config.JobChat.command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "")
        for job, data in pairs(Config.JobChat.jobs) do
            if data.enabled then
                if Player.Job.Name == job then
                    local messageProperties = {
                        name = Player.Firstname .. " " .. Player.Lastname,
                        id = source,
                        command = "/" .. Config.JobChat.command,
                        type = data.label,
                        color = data.color,
                        text = messageText,
                    }

                    local jobProperties = {
                        job = job,
                        restrictedGrade = data.restrictedGrade
                    }

                    if data.restrictedGrade then
                        if Player.Job.Grade.Level >= data.restrictedGrade then
                            TriggerClientEvent('dusa_chat:client:jobChat', -1, messageProperties, jobProperties)
                            local tempData = {
                                playerSource = source,
                                name = Player.Name,
                                rpname = Player.Firstname .. ' ' .. Player.Lastname,
                                identifier = Player.Identifier,
                                job = Player.Job.Name,
                                command = "/" .. Config.JobChat.command,
                                message = messageText,
                            }
                        
                            Log(source, messageText, 'jobchat', tempData)
                        end
                    else
                        TriggerClientEvent('dusa_chat:client:jobChat', -1, messageProperties, jobProperties)
                        local tempData = {
                            playerSource = source,
                            name = Player.Name,
                            rpname = Player.Firstname .. ' ' .. Player.Lastname,
                            identifier = Player.Identifier,
                            job = Player.Job.Name,
                            command = "/" .. Config.JobChat.command,
                            message = messageText,
                        }

                        Log(source, messageText, 'jobchat', tempData)
                    end
                end
            end
        end
    end)
end

if Shared.RoleplayCommands['me'] and Shared.RoleplayCommands['me'].enable then
    local command = {
        description = Shared.RoleplayCommands['me'].description,
        parameters = Shared.RoleplayCommands['me'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['me'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        -- Remove command prefix from raw message
        local messageText = raw:gsub("^%S+%s+", "") -- Removes first word and following spaces

        TriggerClientEvent('dusa_chat:client:3d', -1, 'me', messageText, source)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['me'].command,
            message = messageText,
        }

        Log(source, messageText, 'me', tempData)
    end)
end

if Shared.RoleplayCommands['do'] and Shared.RoleplayCommands['do'].enable then
    local command = {
        description = Shared.RoleplayCommands['do'].description,
        parameters = Shared.RoleplayCommands['do'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['do'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "") -- Removes first word and following spaces

        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['do'].command,
            type = Shared.RoleplayCommands['do'].label,
            color = Shared.RoleplayCommands['do'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:3d', -1, 'do', messageText, source)
        TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'do', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['me'].command,
            message = messageText,
        }

        Log(source, messageText, 'do', tempData)
    end)
end

if Shared.RoleplayCommands['pme'] and Shared.RoleplayCommands['pme'].enable then
    local command = {
        description = Shared.RoleplayCommands['pme'].description,
        parameters = Shared.RoleplayCommands['pme'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['pme'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+%d+%s+", "") -- Removes first word and following spaces

        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['pme'].command,
            type = Shared.RoleplayCommands['pme'].label,
            color = Shared.RoleplayCommands['pme'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:3d', args.target, 'pme', messageText, source)
        TriggerClientEvent('dusa_chat:client:onEmote', args.target, source, 'pme', messageProperties)
        TriggerClientEvent('dusa_chat:client:3d', source, 'pme', messageText, source)
        TriggerClientEvent('dusa_chat:client:onEmote', source, source, 'pme', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['pme'].command,
            target = args.target,
            message = messageText,
        }

        Log(source, messageText, 'pme', tempData)
    end)
end

if Shared.RoleplayCommands['pdo'] and Shared.RoleplayCommands['pdo'].enable then
    local command = {
        description = Shared.RoleplayCommands['pdo'].description,
        parameters = Shared.RoleplayCommands['pdo'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['pdo'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+%d+%s+", "") -- Removes first word and following spaces

        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['pdo'].command,
            type = Shared.RoleplayCommands['pdo'].label,
            color = Shared.RoleplayCommands['pdo'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:3d', args.target, 'pdo', messageText, source)
        TriggerClientEvent('dusa_chat:client:onEmote', args.target, source, 'pdo', messageProperties)
        TriggerClientEvent('dusa_chat:client:3d', source, 'pdo', messageText, source)
        TriggerClientEvent('dusa_chat:client:onEmote', source, source, 'pdo', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['pdo'].command,
            target = args.target,
            message = messageText,
        }

        Log(source, messageText, 'pdo', tempData)
    end)
end


if Shared.RoleplayCommands['ooc'] and Shared.RoleplayCommands['ooc'].enable then
    local command = {
        description = Shared.RoleplayCommands['ooc'].description,
        parameters = Shared.RoleplayCommands['ooc'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['ooc'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "")
        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['ooc'].command,
            type = Shared.RoleplayCommands['ooc'].label,
            color = Shared.RoleplayCommands['ooc'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'ooc', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['ooc'].command,
            message = messageText,
        }

        Log(source, messageText, 'ooc', tempData)
    end)
end

if Shared.RoleplayCommands['requestid'] and Shared.RoleplayCommands['requestid'].enable then
    local command = {
        description = Shared.RoleplayCommands['requestid'].description,
        parameters = Shared.RoleplayCommands['requestid'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['requestid'].command, convertCommand(command), function(source, args)
        local Player = Framework.GetPlayer(source)
        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['requestid'].command,
            type = Shared.RoleplayCommands['requestid'].label,
            color = Shared.RoleplayCommands['requestid'].color,
            text = locale('requestid.closest_player_id'),
        }

        TriggerClientEvent('dusa_chat:client:onRequestId', source, messageProperties)
    end)
end

if Shared.RoleplayCommands['tweet'] and Shared.RoleplayCommands['tweet'].enable then
    local command = {
        description = Shared.RoleplayCommands['tweet'].description,
        parameters = Shared.RoleplayCommands['tweet'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['tweet'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "")
        local messageProperties = {
            name = Player.Firstname .. " " .. Player.Lastname,
            id = source,
            command = "/" .. Shared.RoleplayCommands['tweet'].command,
            type = Shared.RoleplayCommands['tweet'].label,
            color = Shared.RoleplayCommands['tweet'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'tweet', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['tweet'].command,
            message = messageText,
        }

        Log(source, messageText, 'tweet', tempData)
    end)
end


if Shared.RoleplayCommands['anontweet'] and Shared.RoleplayCommands['anontweet'].enable then
    local command = {
        description = Shared.RoleplayCommands['anontweet'].description,
        parameters = Shared.RoleplayCommands['anontweet'].parameters,
    }

    lib.addCommand(Shared.RoleplayCommands['anontweet'].command, convertCommand(command), function(source, args, raw)
        local Player = Framework.GetPlayer(source)
        local messageText = raw:gsub("^%S+%s+", "")
        local messageProperties = {
            name = locale('anonymous'),
            id = source,
            command = "/" .. Shared.RoleplayCommands['anontweet'].command,
            type = Shared.RoleplayCommands['anontweet'].label,
            color = Shared.RoleplayCommands['anontweet'].color,
            text = messageText,
        }

        TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'anontweet', messageProperties)

        local tempData = {
            playerSource = source,
            name = Player.Name,
            rpname = Player.Firstname .. ' ' .. Player.Lastname,
            identifier = Player.Identifier,
            job = Player.Job.Name,
            command = "/" .. Shared.RoleplayCommands['anontweet'].command,
            message = messageText,
        }

        Log(source, messageText, 'anontweet', tempData)
    end)
end

-- Flight Logs: Player Join/Leave Messages
-- Store player names for use when they disconnect
local playerNames = {}

AddEventHandler('playerJoining', function()
    local source = source
    CreateThread(function()
        Wait(2000) -- Wait for player to fully load and framework to initialize
        
        local Player = Framework.GetPlayer(source)
        local playerName
        
        if Player then
            playerName = Player.Firstname .. " " .. Player.Lastname
            -- Store for later use
            playerNames[source] = playerName
        else
            -- Fallback to basic name if framework not ready
            playerName = GetPlayerName(source) or "Unknown Player"
            playerNames[source] = playerName
        end
        
        local messageText = playerName .. " joined"
        
        local messageProperties = {
            name = "System",
            id = 0,
            command = "/system",
            type = "FLIGHT LOG",
            color = "#00FF00",
            text = messageText,
        }
        
        TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'system', messageProperties)
    end)
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    
    -- Try to get stored player name first
    local playerName = playerNames[source]
    
    if not playerName then
        -- Try framework
        local Player = Framework.GetPlayer(source)
        if Player then
            playerName = Player.Firstname .. " " .. Player.Lastname
        else
            -- Last resort: try GetPlayerName (might not work if already disconnected)
            playerName = GetPlayerName(source) or "Unknown Player"
        end
    end
    
    -- Clean up stored name
    playerNames[source] = nil
    
    local messageText = playerName .. " left"
    
    if reason then
        local reasonLower = string.lower(reason or "")
        if string.find(reasonLower, "crash") or string.find(reasonLower, "error") or string.find(reasonLower, "exception") or string.find(reasonLower, "fatal") then
            messageText = playerName .. " crashed (" .. reason .. ")"
        elseif string.find(reasonLower, "disconnect") or string.find(reasonLower, "quit") or string.find(reasonLower, "exited") then
            messageText = playerName .. " disconnected"
        else
            messageText = playerName .. " left (" .. reason .. ")"
        end
    end
    
    local messageProperties = {
        name = "System",
        id = 0,
        command = "/system",
        type = "FLIGHT LOG",
        color = "#FF0000",
        text = messageText,
    }
    
    TriggerClientEvent('dusa_chat:client:onEmote', -1, source, 'system', messageProperties)
end)
