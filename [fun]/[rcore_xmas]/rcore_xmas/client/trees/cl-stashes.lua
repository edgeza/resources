AddEventHandler('rcore_xmas:trees:openStash', function(treeId)
    local stashId = string.format(TREE_STASH_INVENTORY_ID, treeId)
    log.debug('Opening stash for tree %s (%s)', treeId, stashId)
    if isBridgeLoaded('Inventory', Inventory.CORE) or isBridgeLoaded('Inventory', Inventory.ORIGEN) or isBridgeLoaded('Inventory', Inventory.AK47) then
        TriggerServerEvent('rcore_xmas:trees:openStash', treeId)
        return
    end

    Inventory.openInventory('stash', stashId, Config.Trees.Stash.Slots, Config.Trees.Stash.MaxWeight)
end)
