if not BridgeLoaded then return end

GiftsTrees = {}

if isBridgeLoaded('Inventory', Inventory.CHEZZA) or isBridgeLoaded('Inventory', Inventory.ESX) then
    return
end

function registerStash(treeId)
    local stash = Config.Trees.Stash
    return Inventory.createInventory(string.format(TREE_STASH_INVENTORY_ID, treeId), stash.Title:format(treeId),
        stash.Slots, stash.MaxWeight)
end

AddEventHandler('rcore_xmas:trees:cachedTrees', function(trees)
    for treeId, tree in pairs(trees) do
        registerStash(treeId)

        local items = Inventory.getInventoryItems(string.format(TREE_STASH_INVENTORY_ID, treeId))

        if table.size(items) ~= 0 then
            GiftsTrees[tostring(treeId)] = tree
            spawnGifts(treeId, tree.coords, tree.rotation, tree.heading, tree.bucket)
        end
    end
end)

Citizen.CreateThread(function()
    if isBridgeLoaded('Inventory', Inventory.OX) then
        local getTreeIdFromInventory = function(inventory)
            return string.match(inventory, "tree_(%d+)")
        end

        local hook = Config.Trees.Stash.OxInventoryHook
        exports[Inventory.OX]:registerHook('swapItems', function(payload)
            local fromType = payload.fromType
            local toType = payload.toType
            local toInventory = payload.toInventory
            local fromInventory = payload.fromInventory
            local fromSlot = payload.fromSlot

            if (toType == 'stash' and string.sub(toInventory, 1, 5) == 'tree_') or (fromType == 'stash' and string.sub(fromInventory, 1, 5) == 'tree_') then
                if fromSlot ~= nil then
                    local item = fromSlot.name
                    if item ~= Config.Gifts.PackedItem and hook.OnlyGifts then
                        Framework.sendNotification(payload.source, Config.Trees.Notifications.StashOnlyGifts, 'error')
                        return false
                    end
                end

                local treeId = getTreeIdFromInventory(toInventory)
                if treeId == nil then
                    treeId = getTreeIdFromInventory(fromInventory)
                end

                if treeId == nil then
                    log.error('Tree ID not found in inventory %s or %s', toInventory, fromInventory)
                    return true
                end

                if fromSlot ~= nil and hook.GiftsOnGround.Enabled then
                    local toItems = exports[Inventory.OX]:GetInventoryItems(toInventory)
                    if table.size(toItems) == 0 then
                        local tree = CachedTrees[tostring(treeId)]
                        if tree == nil then
                            log.error('Tree %s not found!', treeId)
                            return true
                        end

                        spawnGifts(treeId, tree.coords, tree.rotation, tree.heading, tree.bucket)

                        GiftsTrees[tostring(treeId)] = tree
                    end

                    local fromItems = exports[Inventory.OX]:GetInventoryItems(payload.fromInventory)
                    if table.size(fromItems) == 1 then
                        local lastItem = fromItems[1]
                        if lastItem == nil or lastItem.count - fromSlot.count == 0 then
                            destroyGifts(treeId)
                            GiftsTrees[tostring(treeId)] = nil
                        end
                    end
                end
            end

            return true
        end)
    end
end)

RegisterNetEvent('rcore_xmas:trees:openStash', function(treeId)
    local client = source
    local stashId = string.format(TREE_STASH_INVENTORY_ID, treeId)

    Inventory.openInventory(client, stashId, 'stash', {
        slots = Config.Trees.Stash.Slots,
        maxWeight = Config.Trees.Stash.MaxWeight,
        label = Config.Trees.Stash.Title:format(treeId),
    })
end)
