local resourceName = 'es_extended'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    ESX = exports[resourceName]:getSharedObject()
    core = ESX

    PlayerData = core.GetPlayerData()
    PlayerData.charinfo = {
        birthdate = PlayerData.dateofbirth,
        firstname = PlayerData.firstName,
        lastname = PlayerData.lastName,
    }

    -- Handles state right when the player selects their character and location.
    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
        TriggerEvent("dusa_mdt:playerLoaded")
    end)

    RegisterNetEvent("esx:setJob")
    AddEventHandler("esx:setJob", function(response)
        PlayerData.job = response
    end)

    AddEventHandler('esx:onPlayerDeath', function(data)
        mdt:onDeath()
        isDead = true
    end)

    function bridge.getIdentifier()
        return PlayerData?.identifier or cache.player
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
        core.TriggerServerCallback(name, cb,  ...)
    end
    
    function bridge.getName()
        if not PlayerData then PlayerData = ESX.GetPlayerData() end
        local name = PlayerData and PlayerData.firstName.. " ".. PlayerData.lastName or "Unknown"
        return name
    end
    
    function bridge.job()
        return PlayerData.job
    end

    
    function bridge.jobgrade()
        return PlayerData.job.grade
    end

    function getNearby(coords, distance)
        return ESX.Game.GetPlayersInArea(coords, distance)
    end
    
    function bridge.setDuty(duty)
        -- duty = true/false
        TriggerServerEvent('es_extended:setDuty', duty)
    end

    shared.framework = 'esx'
end)
