Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == 'esx' then
        frameworkObject.RegisterCommand('craftaddxp', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(args.id)
            local xp = args.xp
            if xPlayer then
                AddXPCraft(xPlayer.source, xp)
            end
        end, true, {help = "Add xp craft.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'xp', help = "xp count", type = 'number'}
        }})

        frameworkObject.RegisterCommand('craftremovexp', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(args.id)
            local xp = args.xp
            if xPlayer then
                CraftRemoveXP(xPlayer.source, xp)
            end
        end, true, {help = "Remove xp craft.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'xp', help = "xp count", type = 'number'}
        }})

        frameworkObject.RegisterCommand('craftsetlevel', 'admin', function(source, args, showError)
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(args.id)
            local level = args.level
            if xPlayer then
                SetCraftLevel(xPlayer.source, level)
            end
        end, true, {help = "Set level craft.", validate = true, arguments = {
            {name = 'id', help = "Player ID", type = 'number'},
            {name = 'level', help = "level count", type = 'number'}
        }})
    else
        frameworkObject.Commands.Add('craftaddxp', "Add xp craft", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                AddXPCraft(Player.PlayerData.source, xp)
            end
        end, 'admin')

        frameworkObject.Commands.Add('craftremovexp', "Remove xp craft", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local xp = tonumber(args[2])
            if Player then
                CraftRemoveXP(Player.PlayerData.source, xp)
            end
        end, 'admin')

        frameworkObject.Commands.Add('craftsetlevel', "Add level craft", {}, false, function(source,args)
            local src = source
            local Player = frameworkObject.Functions.GetPlayer(tonumber(args[1]))
            local level = tonumber(args[2])
            if Player then
                SetCraftLevel(Player.PlayerData.source, level)
            end
        end, 'admin')
    end
end)