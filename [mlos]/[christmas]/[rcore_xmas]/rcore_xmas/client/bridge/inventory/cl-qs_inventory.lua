if isBridgeLoaded('Inventory', Inventory.QS) then
    Inventory.openInventory = function(type, name, slots, maxweight)
        TriggerServerEvent('inventory:server:OpenInventory', type, name, {
            slots = slots,
            maxweight = maxweight,
        })
        TriggerEvent('inventory:client:SetCurrentStash', name)
    end
end
