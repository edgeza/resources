local Framework = GetFramework()
if Framework == "qb" then
    QBCore = exports[Config.FrameworkResources.qb.resource][Config.FrameworkResources.qb.export]()
end
function AddItem(src, item, amount)
    if GetResourceState("ox_inventory") == "started" then
        local ItemAdded = exports.ox_inventory:AddItem(src, item, amount, false)
        if not ItemAdded then return false end
    elseif GetResourceState('qb-inventory') == "started" then
        if lib.checkDependency('qb-inventory', '2.0.0') then
            local ItemAdded = exports['qb-inventory']:AddItem(src, item, amount, false, false)
            if not ItemAdded then return false end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        else
            local Player = QBCore.Functions.GetPlayer(src)
            local ItemAdded = Player.Functions.AddItem(item, amount)
            if not ItemAdded then return false end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        end
    elseif GetResourceState('codem-inventory') == "started" then
        local ItemAdded = exports["codem-inventory"]:AddItem(src, item, amount)
        if not ItemAdded then return false end
    elseif GetResourceState("qs-inventory") == "started" then
        local ItemAdded = exports["qs-inventory"]:AddItem(src, item, amount)
        if not ItemAdded then return false end
    elseif GetResourceState("ps-inventory") == "started" then
        local ItemAdded = exports['ps-inventory']:AddItem(src, item, amount, false, false)
        if not ItemAdded then return false end
        TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    elseif GetResourceState("tgiann-inventory") == "started" then
        local ItemAdded = exports["tgiann-inventory"]:AddItem(src, item, amount)
        if not ItemAdded then return false end
    elseif GetResourceState("origen_inventory") == "started" then
        local ItemAdded = exports.origen_inventory:addItem(src, item, amount)
        if not ItemAdded then return false end
    elseif GetResourceState("ak47_inventory") == "started" or GetResourceState("ak47_qb_inventory") == "started" then
        local ItemAdded = exports['ak47_inventory']:AddItem(src, item, amount)
        if not ItemAdded then return false end
    else
        print("No inventory resource found")
    end

    return true
end

function RemoveItem(src, item, amount)
    if GetResourceState("ox_inventory") == "started" then
        local ItemRemoved = exports.ox_inventory:RemoveItem(src, item, amount, false)
        if not ItemRemoved then return false end
    elseif GetResourceState('qb-inventory') == "started" then
        if lib.checkDependency('qb-inventory', '2.0.0') then
            local ItemRemoved = exports['qb-inventory']:RemoveItem(src, item, amount, false, false)
            if not ItemRemoved then return false end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
        else
            local Player = QBCore.Functions.GetPlayer(src)
            local ItemRemoved = Player.Functions.RemoveItem(item, amount)
            if not ItemRemoved then return false end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        end
    elseif GetResourceState('codem-inventory') == "started" then
        local ItemRemoved = exports["codem-inventory"]:RemoveItem(src, item, amount)
        if not ItemRemoved then return false end
    elseif GetResourceState("qs-inventory") == "started" then
        local ItemRemoved = exports["qs-inventory"]:RemoveItem(src, item, amount)
        if not ItemRemoved then return false end
    elseif GetResourceState("ps-inventory") == "started" then
        local ItemRemoved = exports['ps-inventory']:RemoveItem(src, item, amount, false, false)
        if not ItemRemoved then return false end
        TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    elseif GetResourceState("tgiann-inventory") == "started" then
        local ItemRemoved = exports["tgiann-inventory"]:RemoveItem(src, item, amount)
        if not ItemRemoved then return false end
    elseif GetResourceState("origen_inventory") == "started" then
        local ItemRemoved = exports.origen_inventory:RemoveItem(src, item, amount)
        if not ItemRemoved then return false end
    elseif GetResourceState("ak47_inventory") == "started" or GetResourceState("ak47_qb_inventory") == "started" then
        local ItemRemoved = exports['ak47_inventory']:RemoveItem(src, item, amount)
        if not ItemRemoved then return false end
    else
        print("No inventory resource found")
    end

    return true
end

function HasItem(src,item)
    local playerItemCount = 0
    if GetResourceState("ox_inventory") == "started" then
        playerItemCount = exports.ox_inventory:GetItem(src, item, nil, true)
        return playerItemCount
    elseif GetResourceState('qb-inventory') == "started" then
        local Player = getPlayer(src)
        playerItemCount = Player.Functions.GetItemByName(item)?.amount or 0
        return playerItemCount
    elseif GetResourceState('esx_inventory') == "started" then
        local xPlayer = getPlayer(src)
        playerItemCount = xPlayer.getInventoryItem(item)?.count or 0
        return playerItemCount
    elseif GetResourceState("qs-inventory") == "started" then
        playerItemCount = exports["qs-inventory"]:GetItemTotalAmount(src, item)
        return playerItemCount
    elseif GetResourceState('codem-inventory') == "started" then
        playerItemCount = exports["codem-inventory"]:GetItemsTotalAmount(src, item)
        return playerItemCount
     elseif GetResourceState("ps-inventory") == "started" then
        playerItemCount = exports['ps-inventory']:GetItemByName(src, item)
        return playerItemCount
    elseif GetResourceState("tgiann-inventory") == "started" then
        playerItemCount = exports["tgiann-inventory"]:GetItem(src, item, false, true)
        return playerItemCount
    elseif GetResourceState("origen_inventory") == "started" then
        playerItemCount = exports.origen_inventory:getItemCount(src, item, false, false)
        return playerItemCount
    elseif GetResourceState("ak47_inventory") == "started" or GetResourceState("ak47_qb_inventory") == "started" then
        playerItemCount = exports['ak47_inventory']:GetItem(src, item, false, false)
        return playerItemCount
    else
        print("No inventory resource found")
    end
end

AddEventHandler('onServerResourceStart', function(resourceName)
    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:RegisterStash(Config.Jobname..'Storage', ""..Config.Jobname.." Stash", Config.StashInventory.StashSlot, Config.StashInventory.StashWeight, nil,{[Config.Jobname] = 0,})
        for k, v in pairs(Location.Counter) do 
            exports.ox_inventory:RegisterStash(v.name,v.name, Config.StashInventory.CounterSlot, Config.StashInventory.CounterWeight)
        end
        for k, v in pairs(Location.Tables) do
            exports.ox_inventory:RegisterStash(v.name,v.name, Config.StashInventory.TableSlot, Config.StashInventory.TableWeight)
        end
        for k, v in pairs(Location.TrashCan) do
            exports.ox_inventory:RegisterStash(v.name,v.name, Config.StashInventory.TrashCanSlot, Config.StashInventory.TrashCanWeight)
            exports.ox_inventory:ClearInventory(v.name, nil)
        end
    end
end)

RegisterNetEvent('pl_uwucafe:OpenInvNewQB')
AddEventHandler('pl_uwucafe:OpenInvNewQB', function(stashName)
    local src = source
    if GetJob(src) ~= Config.Jobname then return end
    local data = { label = stashName, maxweight = Config.StashInventory.TableWeight, slots = Config.StashInventory.TableSlot }
    exports['qb-inventory']:OpenInventory(src, stashName, data)
end)