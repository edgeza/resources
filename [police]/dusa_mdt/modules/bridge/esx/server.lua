local resourceName = 'es_extended'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    ESX = exports[resourceName]:getSharedObject()
    core = ESX
    core.players = 'users'
    core.vehicles = 'owned_vehicles'
    core.citizenid = 'identifier'
    core.vehicle_owner = 'owner'
    core.charinfo = 'firstname'
    core.job = 'job'
    core.playerInformations = {'identifier', 'job', 'firstname', 'lastname', 'dateofbirth', 'sex'}
    core.searchVehicle = {'owner', 'vehicle', 'plate'}
    
    if not ESX then
        print('^8[IMPORTANT] ^0ESX is ^1not running^0, please make sure you have es_extended started before running this script.')
        return
    end

    function bridge.getIdentifier(source)
        local player = core.GetPlayerFromId(source)

        if player then
            return player.identifier
        end

        return source
    end

    function bridge.getPlayer(source)
        local player = core.GetPlayerFromId(source)

        player.PlayerData = {
            charinfo = {
                birthdate = player.variables.dateofbirth,
                firstname = player.variables.firstName,
                lastname = player.variables.lastName,
                gender = player.variables.sex == "m" and 0 or 1
            },
            metadata = {
                callsign = 'NO CALLSIGN'
            },
            job = player.job,
        }

        return player
    end

    function bridge.notify(source, msg, type)
        lib.triggerClientEvent('ox_lib:notify', source, {
            description = msg,
            type = type,
        })
    end

    function bridge.getName(source)
        local player = core.GetPlayerFromId(source)
        if not player then return false end
        return player.getName()
    end

    function bridge.getJob(source)
        local player = core.GetPlayerFromId(source)
        local job = {
            name = player.job.name,
            grade = {
                level = player.job.grade,
                name = player.job.grade_label,
            }
        }
        return job
    end

    function bridge.getPlayers()
        local players = core.GetExtendedPlayers() or core.GetPlayers()
        return players
    end

    -- grade name
    function bridge.getGrade(job)
        local grade = job.grade.name
        return grade
    end
    
    function bridge.getGradeLevel(source)
        local player = core.GetPlayerFromId(source)
        if not player then return false end
        return player.job.grade
    end
    

    function bridge.addMoney(source, amount, reason)
        local Player = core.GetPlayerFromId(source)

        if Player ~= nil then
            Player.addAccountMoney('money', amount, reason or 'Claw machine')

            return true
        end

        return false
    end

    function bridge.removeMoney(source, amount, reason)
        local Player = core.GetPlayerFromId(source)

        if Player ~= nil then
            local money = Player.getAccount('money').money

            if money >= amount then
                Player.removeAccountMoney('money', amount, reason or 'Claw machine')

                return true
            end

            return false
        end

        return false
    end

    
    function bridge.registerItem(item, cb)
        core.RegisterUsableItem(item, cb)
    end

    shared.framework = 'esx'
end)
