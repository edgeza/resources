-- Generic Item Decay System
-- Handles realistic decay for all items with decay property (food, drinks, etc.)
-- Prevents exploit where stacking new items refreshes decay
-- Optimized to only process items that have decay enabled

CreateThread(function()
    while true do
        Wait(60000) -- Check every minute
        
        local currentTime = os.time()
        local players = GetPlayers()
        
        for _, playerId in pairs(players) do
            local playerIdNum = tonumber(playerId)
            if not playerIdNum then goto continue end
            
            local inventory = Inventories[playerIdNum]
            if not inventory then goto continue end
            
            local needsUpdate = false
            local itemsToRemove = {}
            
            -- Process all items in inventory
            for slot, item in pairs(inventory) do
                if item and item.name then
                    local itemName = item.name:lower()
                    local itemInfo = ItemList[itemName]
                    
                    -- Only process items that have decay property
                    if itemInfo and itemInfo['decay'] and itemInfo['decay'] > 0 then
                        local info = item.info or {}
                        local freshness = info.freshness or 100
                        local created = info.created or currentTime
                        
                        -- Calculate age in minutes
                        local ageMinutes = (currentTime - created) / 60
                        
                        -- Calculate decay based on decay rate (higher = faster decay)
                        -- Formula: freshness decreases by decayRate per minute
                        local decayRate = itemInfo['decay']
                        local decayAmount = decayRate * ageMinutes
                        local newFreshness = math.max(0, 100 - decayAmount)
                        
                        -- Only update if freshness changed significantly (more than 0.1%)
                        if math.abs(newFreshness - freshness) > 0.1 then
                            info.freshness = math.floor(newFreshness * 100) / 100 -- Round to 2 decimals
                            info.created = created -- Preserve original creation time
                            
                            inventory[slot].info = info
                            needsUpdate = true
                            
                            -- Mark for removal if freshness reaches 0
                            if newFreshness <= 0 then
                                table.insert(itemsToRemove, {
                                    slot = slot,
                                    name = item.name,
                                    amount = item.amount
                                })
                            end
                        end
                    end
                end
            end
            
            -- Update inventory once if any changes were made
            if needsUpdate then
                UpdateFrameworkInventory(playerIdNum, inventory, true)
                UpdateInventoryState(playerIdNum)
            end
            
            -- Remove expired items
            for _, itemData in ipairs(itemsToRemove) do
                RemoveItem(playerIdNum, itemData.name, itemData.amount, itemData.slot, nil, true)
            end
            
            ::continue::
        end
    end
end)

