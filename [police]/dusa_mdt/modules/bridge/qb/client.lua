local resourceName = 'qb-core'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    QB = exports[resourceName]:GetCoreObject()
    core = QB

    PlayerData = core.Functions.GetPlayerData()

    if PlayerData?.citizenid and LocalPlayer.state.isLoggedIn then end

    -- Handles state right when the player selects their character and location.
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = core.Functions.GetPlayerData()
        TriggerEvent("dusa_mdt:playerLoaded")
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        PlayerData.job = job
    end)

    AddEventHandler('gameEventTriggered', function(event, data)
        if event ~= 'CEventNetworkEntityDamage' then return end
        local playerPed = PlayerPedId()
        local victim, victimDied = data[1], data[4]
        if not IsPedAPlayer(victim) then return end
        local player = PlayerId()
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim))  then
            local deathCause = GetPedCauseOfDeath(playerPed)
            local data = {
                deathCause = deathCause,
                victimCoords = GetEntityCoords(victim)
            }
            mdt:onDeath()
        end
    end)

    function bridge.getIdentifier()
        return PlayerData?.citizenid or cache.player
    end

    function bridge.notify(msg, type)
        lib.notify({
            description = msg,
            type = type,
        })
    end

    function bridge.progress(data)
        if lib.progressCircle(data) then
            return true
        end

        return false
    end

    function bridge.callback(name, cb, ...)
        core.Functions.TriggerCallback(name, cb,  ...)
    end

    function bridge.getName()
        return PlayerData.charinfo.firstname.. " ".. PlayerData.charinfo.lastname
    end

    function bridge.job()
        return PlayerData.job
    end

    function bridge.jobgrade()
        return PlayerData.job.grade.level
    end

    function getNearby(coords, distance)
        return QBCore.Functions.GetPlayersFromCoords(coords, distance)
    end

    function bridge.setDuty(duty)
        TriggerServerEvent('QBCore:ToggleDuty')
    end

    shared.framework = 'qb'
end)
