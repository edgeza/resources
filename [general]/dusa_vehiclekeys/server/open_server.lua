lib.addCommand(Config.Commands.GiveKey.command, {
    help = Config.Commands.GiveKey.description,
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = Config.Commands.GiveKey.params[1].help,
            optional = true,
        },
    },
}, function(source, args, raw)
    local src = source
    TriggerClientEvent('dusa_vehiclekeys:client:GiveKeys', src, tonumber(args.target))
end)

lib.addCommand(Config.Commands.AddKeyOfVehicle.command, {
    help = Config.Commands.AddKeyOfVehicle.description,
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = Config.Commands.AddKeyOfVehicle.params[1].help,
        },
        {
            name = 'plate',
            type = 'string',
            help = Config.Commands.AddKeyOfVehicle.params[2].help,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    local src = source
    if not args.target or not args.plate then
        Framework.Notify(src, Lang:t("notify.fpid"), "error")
        return
    end
    GiveKeys(tonumber(args.target), args.plate)
end)

lib.addCommand(Config.Commands.RemoveKeyOfVehicle.command, {
    help = Config.Commands.RemoveKeyOfVehicle.description,
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = Config.Commands.RemoveKeyOfVehicle.params[1].help,
        },
        {
            name = 'plate',
            type = 'string',
            help = Config.Commands.RemoveKeyOfVehicle.params[2].help,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    local src = source
    if not args.target or not args.plate then
        Framework.Notify(src, Lang:t("notify.fpid"), "error")
        return
    end
    RemoveKeys(tonumber(args.target), args.plate)
end)

Framework.CreateUseableItem('lockpick', function(source)
    TriggerClientEvent('lockpicks:UseLockpick', source, false)
end)

Framework.CreateUseableItem('advancedlockpick', function(source)
    TriggerClientEvent('lockpicks:UseLockpick', source, true)
end)

RegisterNetEvent('dusa_vehiclekeys:server:breakLockpick', function(itemName)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    if not (itemName == "lockpick" or itemName == "advancedlockpick") then return end

    if Framework.HasItem(source, itemName) then
        Framework.RemoveItem(source, itemName, 1)
    end
end)

RegisterNetEvent('dusa_vehiclekeys:server:policeAlert', function(vehicle, vehicleInfo, location)
    local src = source
    local description = string.format('Vehicle Informations:\n Model: %s\nPlate: %s\nColor: %s', vehicleInfo.model,
        vehicleInfo.plate, vehicleInfo.color)


    if GetResourceState("lb-tablet") == "started" then
        local dispatch = {
            priority = 'medium',
            code = '10-85',
            title = 'Car Theft',
            description = description,
            time = 600,
            location = {
                label = location.street,
                coords = location.coords
            }
        }
        exports["lb-tablet"]:AddDispatch(dispatch)
    elseif GetResourceState("qs-dispatch") == "started" then
        TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = Config.PoliceJobs, -- List of jobs to receive the dispatch
            callLocation = location.coords, -- Coordinates of the call
            callCode = { code = '10-55', snippet = 'Car Theft' }, -- Call code and description
            message = description, -- Dispatch call message
            flashes = true, -- Should the blip on the map flash?
            image = "URL", -- Optional: URL for an image attachment (use `getSSURL` if needed)
            blip = { -- Blip details for the map
                sprite = 56, -- Blip icon type
                scale = 1, -- Blip size
                colour = 1, -- Blip color
                flashes = true, -- Blip flashes
                text = 'Car Theft', -- Blip label
                time = (60 * 1000), -- Duration of the blip (milliseconds)
            },
            otherData = {}
        })
    elseif GetResourceState("rcore_dispatch") == "started" then
        local data = {
            code = '10-55', -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
            default_priority = 'medium', -- 'low' | 'medium' | 'high' -> The alert priority
            coords = location.coords, -- vector3 -> The coords of the alert
            job = Config.PoliceJobs, -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
            text = message, -- string -> The alert text
            type = 'car_robbery', -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
            blip = { -- Blip table (optional)
                sprite = 56, -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
                colour = 1, -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                scale = 0.7, -- number -> The blip scale
                text = 'Car Theft', -- number (optional) -> The blip text
                flashes = false, -- boolean (optional) -> Make the blip flash
                radius = 0, -- number (optional) -> Create a radius blip instead of a normal one
            }
        }
        TriggerEvent('rcore_dispatch:server:sendAlert', data)
    elseif GetResourceState("dusa_dispatch") == "started" then
        local dispatchData = {
            id = 0,
            event = 'Car Theft',
            title = 'Car Theft In Progress',
            description = description,
            code = '10-55',
            codeName = 'cartheft',
            coords = location.coords,
            icon = 'theft', -- theft, suspect, conflict, traffic
            priority = 1, -- 0, 1, 2
            street = location.street,
            recipientJobs = Config.PoliceJobs,
        }
    
        TriggerClientEvent('dusa_dispatch:sendCustomDispatch', src, dispatchData)
    else
        TriggerClientEvent('dusa_vehiclekeys:client:policeAlert', -1, location.coords, description)
    end
end)
