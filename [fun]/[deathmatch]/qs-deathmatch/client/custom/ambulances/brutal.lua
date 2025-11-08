if Config.Ambulance ~= 'brutal' then return end

function IsPlayerDead()
    -- Check if brutal_ambulancejob is available
    if GetResourceState('brutal_ambulancejob') == 'started' then
        -- Check LocalPlayer.state first (if brutal ambulance sets it)
        if LocalPlayer.state.isDead or LocalPlayer.state.dead then
            return true
        end
        
        -- Check player metadata for isdead status (brutal ambulance uses QBCore metadata)
        local QBCore = exports['qb-core']:GetCoreObject()
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData and PlayerData.metadata and PlayerData.metadata.isdead then
            return PlayerData.metadata.isdead
        end
    end
    return false
end

