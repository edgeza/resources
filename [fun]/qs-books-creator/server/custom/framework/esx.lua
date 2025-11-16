if Config.Framework ~= 'esx' then return end

ESX = exports['es_extended']:getSharedObject()

RegisterUsableItem = function(name, cb)
    ESX.RegisterUsableItem(name, cb)
end
