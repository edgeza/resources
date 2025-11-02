Core = nil

if Config['Core']:upper() == 'ESX' then
    local _esx_ = 'new' -- 'new' / 'old'

    if _esx_ then
        Core = exports['es_extended']:getSharedObject()
    else
        while Core == nil do
            TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
            Citizen.Wait(0)
        end
    end

    LoadedEvent = 'esx:playerLoaded'
    ReviveEvent = 'esx_ambulancejob:revive'
    JobUpdateEvent = 'esx:setJob'
    TSCB = Core.TriggerServerCallback

    function GetPlayerJobDatas()
        local playerData = Core.GetPlayerData()
        if playerData and playerData.job then
            return playerData.job
        end
        return nil
    end

    function GetPlayersFunction()
        local players = Core.Game.GetPlayers()
        return players or {}
    end

    function GetVehiclePropertiesFunction(vehicle)
        return Core.Game.GetVehicleProperties(vehicle)
    end

    function SetVehiclePropertiesFunction(vehicle, properties)
        return Core.Game.SetVehicleProperties(vehicle, properties)
    end

    function GetClosestVehicleFunction(coords, modelFilter)
        return Core.Game.GetClosestVehicle(coords, modelFilter)
    end

elseif Config['Core']:upper() == 'QBCORE' then
    Core = exports['qb-core']:GetCoreObject()

    LoadedEvent = 'QBCore:Client:OnPlayerLoaded'
    ReviveEvent = 'hospital:client:Revive'
    JobUpdateEvent = 'QBCore:Client:OnGangUpdate'
    TSCB = Core.Functions.TriggerCallback

    function GetPlayerJobDatas()
        local playerData = Core.Functions.GetPlayerData()
        if playerData and playerData.gang then
            return playerData.gang
        end
        return nil
    end

    function GetPlayersFunction()
        local players = Core.Functions.GetPlayers()
        return players or {}
    end

    function GetVehiclePropertiesFunction(vehicle)
        return Core.Functions.GetVehicleProperties(vehicle)
    end

    function SetVehiclePropertiesFunction(vehicle, properties)
        return Core.Functions.SetVehicleProperties(vehicle, properties)
    end

    function GetClosestVehicleFunction(coords, modelFilter)
        return Core.Functions.GetClosestVehicle(coords, modelFilter)
    end
    
end