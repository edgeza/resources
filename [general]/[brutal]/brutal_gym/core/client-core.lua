Core = nil

if Config.Core:upper() == 'ESX' then

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
    TSCB = Core.TriggerServerCallback

elseif Config.Core:upper() == 'QBCORE' then

    Core = exports['qb-core']:GetCoreObject()
    LoadedEvent = 'QBCore:Client:OnPlayerLoaded'
    ReviveEvent = 'hospital:client:Revive'
    TSCB = Core.Functions.TriggerCallback

end