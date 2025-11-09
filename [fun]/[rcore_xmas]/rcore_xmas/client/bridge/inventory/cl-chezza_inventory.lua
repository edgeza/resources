if isBridgeLoaded('Inventory', Inventory.CHEZZA) then
    if not isBridgeLoaded('Framework', Framework.ESX) then
        log.error(
            'CHEZZA inventory is selected but ESX is not the framework resource. Please change the framework resource or the inventory type.')
        return
    end

    Inventory.openInventory = function(type, name)
        log.error('CHEZZA inventory does not support this!')
    end
end
