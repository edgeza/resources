if isBridgeLoaded('Inventory', Inventory.ESX) then
    if not isBridgeLoaded('Framework', Framework.ESX) then
        log.error(
            'ESX inventory is selected but ESX is not the framework resource. Please change the framework resource or the inventory type.')
        return
    end

    Inventory.openInventory = function(type, name)
        log.error('ESX inventory does not support opening inventory stashes!')
    end
end
