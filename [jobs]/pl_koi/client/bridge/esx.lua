local Framework = GetFramework()
if Framework ~= 'esx' then return end

ESX = exports[Config.FrameworkResources.esx.resource][Config.FrameworkResources.esx.export]()

function GetPlayersinNearby(data,distance)
    return ESX.Game.GetPlayersInArea(data, distance)
end

function GetPlayerData()
    return ESX.GetPlayerData()
end

function GetPlayerDataJob()
    local playerData = GetPlayerData()
    return playerData and playerData.job
end

function GetPlayerGender()
    ESX.PlayerData = ESX.GetPlayerData()
    if ESX.PlayerData.sex == "f" then
        return "female"
    end
    return "male"
end
