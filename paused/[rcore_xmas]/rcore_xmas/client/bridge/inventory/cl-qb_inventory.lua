if isBridgeLoaded('Inventory', Inventory.QB) then
    Inventory.openInventory = function(type, name, slots, maxweight)
        local version = GetResourceMetadata(Bridge.Inventory, 'version', 0)
        if version >= '2.0.0' then
            TriggerServerEvent('rcore_xmas:qb-inventory:open', type, name, slots, maxweight)
        end

        TriggerServerEvent('inventory:server:OpenInventory', type, name, {
            slots = slots,
            maxweight = maxweight,
        })
        TriggerEvent('inventory:client:SetCurrentStash', name)
    end
end
