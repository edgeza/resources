local resourceName = 'qb-core'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    QB = exports[resourceName]:GetCoreObject()
    core = QB
    core.players = 'players'
    core.vehicles = 'player_vehicles'
    core.citizenid = 'citizenid'
    core.vehicle_owner = 'citizenid'
    core.charinfo = 'charinfo'
    core.playerInformations = {'citizenid', 'job', 'charinfo', 'metadata'}
    core.searchVehicle = {'citizenid', 'vehicle', 'plate'}

    if not QB then
        print('^8[IMPORTANT] ^0QBCore is ^1not running^0, please make sure you have qb-core started before running this script.')
        return
    end

    function bridge.getIdentifier(source)
        local player = core.Functions.GetPlayer(source)

        if player then
            return player.PlayerData.citizenid
        end

        return source
    end

    function bridge.getPlayer(source)
        local player = core.Functions.GetPlayer(source)
        return player
    end

    function bridge.notify(source, msg, type, duration)
        lib.triggerClientEvent('ox_lib:notify', source, {
            description = msg,
            type = type,
            duration = duration or 5000,
        })
    end

    function bridge.getName(source)
        local player = core.Functions.GetPlayer(source)
        if not player then print('DEBUG - Player not detected') return false end
        return player.PlayerData.charinfo.firstname.. " "..player.PlayerData.charinfo.lastname
    end

    function bridge.getJob(source)
        local player = core.Functions.GetPlayer(source)
        return player.PlayerData.job
    end

    -- grade name
    function bridge.getGrade(job)
        local grade = job.grade.name
        return grade
    end

    function bridge.getGradeLevel(source)
        local player = core.Functions.GetPlayer(source)
        if not player then dp('Player not detected') return false end
        local job = player.PlayerData.job
        local level = job.grade.level
        return level
    end

    function bridge.getPlayers()
        local players = core.Functions.GetPlayers()
        return players
    end

    function bridge.addMoney(source, amount)
        local Player = core.Functions.GetPlayer(source)

        if Player and Player.Functions.AddMoney('cash', amount, 'Claw machine refund') then
            return true
        end

        return false
    end

    function bridge.removeMoney(source, amount)
        local Player = core.Functions.GetPlayer(source)

        if Player and Player.Functions.RemoveMoney('cash', amount, 'Claw machine payment') then
            return true
        end

        return false
    end

    function bridge.registerItem(item, cb)
        core.Functions.CreateUseableItem(item, cb)
    end

    shared.framework = 'qb'
end)
