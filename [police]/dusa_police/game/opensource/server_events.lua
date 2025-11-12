--- THIS FILE IS SERVER SIDED
--- 
if not rawget(_G, "lib") then include('ox_lib', 'init') end

RegisterServerEvent('police:server:sendToJail')
RegisterServerEvent('police:server:issueBill')

-- Do not touch these values
Transactions = require 'game.data.transactions'
OfficerList = require 'game.data.officers'
RadarList = require 'game.data.radar'
savedData = require 'game.data.saved'
triggerEventHooks = require '@dusa_bridge.modules.hooks'


---@param id number Player Id
---@param type string Type of the penalty
---@param amount number Amount of the bill
---@param users table Table of selected users
AddEventHandler('police:server:issueBill', function(id, amount, reason, event)
    local source = source
    local targetId = tonumber(id)
    local ply = Framework.GetPlayer(source)
    local targetPly = Framework.GetPlayer(targetId)

    if not targetPly then return warn('Target player not found') end

    local officerPed = GetPlayerPed(source)
    local targetPed = GetPlayerPed(targetId)

    if not event == 'radar' then

        local dist = #(GetEntityCoords(officerPed) - GetEntityCoords(targetPed))
        if dist > ServerConfig.DistanceChecks['fine'] then
            return lib.print.warn(('[EXPLOTITER] Player [%s] tried to bill another player [%s] when too far away!'):format(src, id))
        end

        Framework.Notify(src, locale('fine.fine_created', amount), 'success')
    end

    local society = ply.Job.Name

    if GetResourceState('esx_billing'):find('start') then
        exports.esx_billing:BillPlayer(targetId, ply.Identifier, society, reason, amount)
    elseif GetResourceState('okokBilling'):find('start') then
        TriggerEvent('okokBilling:CreateCustomInvoice', targetId, amount, reason, 'LEO', society, society)
    elseif GetResourceState('dusa_billing'):find('start') then
        TriggerEvent('dusa_billing:sv:createCustomInvoice', targetId, 'LEO Bill', reason, amount, 'company')
    elseif GetResourceState('codem-billing'):find('start') then
        exports['codem-billing']:createBilling(source, targetId, amount, reason, society)
    elseif GetResourceState('qs-billing'):find('start') then
        exports['qs-billing']:ServerCreateInvoice(source, 'LEO Bill', reason, amount, true, false, true, true, society)
    else
        lib.print.warn('[INTEGRATION] Your billing system couldnt found! Please add your billing system integration to dusa_police/game/opensource/server_events.lua')
    end
end)



---@param id number Player Id
---@param duration integer Duration of the jail (minutes)
---@param reason string Reason of jail
AddEventHandler('police:server:sendToJail', function(id, duration, reason)
    local src = source
    local officerPed = GetPlayerPed(src)
    local targetId = id
    local targetPed = GetPlayerPed(targetId)

    local dist = #(GetEntityCoords(officerPed) - GetEntityCoords(targetPed))
    if dist > ServerConfig.DistanceChecks['jail'] then
        return lib.print.warn(('[EXPLOTITER] Player [%s] tried to jail another player [%s] when too far away!'):format(src, targetId))
    end

    Framework.Notify(src, locale('jail.sent_to_jail', duration), 'success')

    if GetResourceState('pickle_prisons'):find('start') then
        exports.pickle_prisons:JailPlayer(targetId, duration)
    elseif GetResourceState('qbx_prison'):find('start') then
        exports.qbx_prison:JailPlayer(targetId, duration)
    elseif GetResourceState('qb-prison'):find('start') then
        -- QB PRISON HAS INVOKE PREVENT!! MODIFY qb-prison/client/main.lua : event = prison:client:Enter
        -- QB PRISON HAS INVOKE PREVENT!! MODIFY qb-prison/client/main.lua : event = prison:client:Enter
        -- QB PRISON HAS INVOKE PREVENT!! MODIFY qb-prison/client/main.lua : event = prison:client:Enter
        TriggerClientEvent('prison:client:Enter', targetId, duration)
    elseif GetResourceState('esx-qalle-jail'):find('start') then
        TriggerClientEvent('esx-qalle-jail:jailPlayer', targetId, duration)
    elseif GetResourceState('rcore_prison'):find('start') then
        -- rcore_prison Jail export: (playerId, jailTime, reason)
        exports['rcore_prison']:Jail(targetId, duration, reason or '')
    elseif GetResourceState('xt-prison'):find('start') then
        lib.callback.await('xt-prison:client:enterJail', targetId, duration)
    end
end)

if Config.EnableWheelLock then
    RegisterServerEvent('police:server:attachWheelLock', function(netId)
        local src = source
        local vehicle = NetworkGetEntityFromNetworkId(netId)

        if vehicle == 0 or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 then return end
        
        local Player = Framework.GetPlayer(src)
        if not Player or not Functions.IsLEO(Player.Job.Name) then return end
        
        local state = Entity(vehicle).state
        if state then
            state:set('wheelLock', true, true)
        end
    end)

    RegisterServerEvent('police:server:removeWheelLock', function(netId)
        local src = source
        local vehicle = NetworkGetEntityFromNetworkId(netId)

        if vehicle == 0 or not DoesEntityExist(vehicle) or GetEntityType(vehicle) ~= 2 then return end
        
        local Player = Framework.GetPlayer(src)
        if not Player or not Functions.IsLEO(Player.Job.Name) then return end
        
        local state = Entity(vehicle).state
        if state then
            state:set('wheelLock', false, true)
        end
    end)
end