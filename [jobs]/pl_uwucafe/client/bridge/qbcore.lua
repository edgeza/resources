local Framework = GetFramework()
if Framework ~= 'qb' then return end

local QBCore = exports[Config.FrameworkResources.qb.resource][Config.FrameworkResources.qb.export]()

function GetPlayersinNearby(data,distance)
    return QBCore.Functions.GetPlayersFromCoords(data, distance)
end

function GetPlayerData()
    return QBCore.Functions.GetPlayerData()
end

function GetPlayerDataJob()
    local playerData = QBCore.Functions.GetPlayerData().job
    return playerData
end

function GetPlayerGender()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.charinfo.gender == 1 then
        return "female"
    end
    return "male"
end