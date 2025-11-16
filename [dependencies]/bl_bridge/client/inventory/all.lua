local inventory = {}
local invFramework = GetFramework('inventory')
local Utils = require'utils'
local isOx = invFramework == 'ox_inventory'
local isOrigen = invFramework == 'origen_inventory'
-- Check for both 'qs-inventory' (resource name) and 'qs' (convar value)
local isQs = invFramework == 'qs-inventory' or invFramework == 'qs'

-- Debug: Log framework detection (remove after testing)
-- print("^3[bl_bridge]^7 Inventory framework detected: " .. tostring(invFramework) .. " | isQs: " .. tostring(isQs))

-- function inventory.items()
--     local inventoryItems = isOx and exports.ox_inventory:Items() or core.getPlayerData().items or {}
--     return inventoryItems
-- end

function inventory.playerItems()
    -- CRITICAL: Always return a table, never a number or other type
    -- Wrap everything in pcall to catch any errors and always return a table
    local success, result = pcall(function()
        local playerData = {}
        if isOx then
            local items = exports.ox_inventory:GetPlayerItems()
            playerData = (type(items) == 'table') and items or {}
        elseif isOrigen then
            local items = exports.origen_inventory:GetInventory()
            playerData = (type(items) == 'table') and items or {}
        elseif isQs then
            -- qs-inventory has its own inventory system, use getUserInventory export
            -- According to qs-inventory docs: returns { [itemName] = { amount = number } }
            local qsSuccess, qsInventory = pcall(function() 
                return exports['qs-inventory']:getUserInventory() 
            end)
            
            if qsSuccess and qsInventory and type(qsInventory) == 'table' then
                -- Convert qs format { [itemName] = { amount = number } } to standard format
                local formattedData = {}
                for itemName, itemData in pairs(qsInventory) do
                    if type(itemName) == 'string' and type(itemData) == 'table' and itemData.amount then
                        table.insert(formattedData, {
                            name = itemName,
                            amount = itemData.amount or 0,
                            count = itemData.amount or 0,
                            -- Preserve other itemData properties if they exist
                            info = itemData.info or {},
                            metadata = itemData.info or {}
                        })
                    end
                end
                playerData = formattedData
            else
                -- qs-inventory doesn't use core framework inventory, return empty table
                -- DO NOT fall back to core.getPlayerData().inventory as it won't work with qs-inventory
                playerData = {}
            end
        else
            local core = Framework.core
            if not core then
                Utils.waitFor(function()
                    if Framework.core then return true end
                end)
            end
            local coreData = core and core.getPlayerData()
            if coreData and coreData.inventory then
                -- Ensure inventory is a table, handle string JSON if needed
                if type(coreData.inventory) == 'string' then
                    local decoded = json.decode(coreData.inventory)
                    if type(decoded) == 'table' then
                        playerData = decoded
                    else
                        playerData = {}
                    end
                elseif type(coreData.inventory) == 'table' then
                    -- Verify it's actually a table of items (array-like or key-value pairs)
                    local hasItems = false
                    for k, v in pairs(coreData.inventory) do
                        hasItems = true
                        break
                    end
                    if hasItems then
                        playerData = coreData.inventory
                    else
                        playerData = {}
                    end
                else
                    -- If it's a number or other type, return empty table
                    playerData = {}
                end
            else
                playerData = {}
            end
        end

        -- Ensure playerData is always a table before iterating
        if type(playerData) ~= 'table' then
            playerData = {}
        end

        -- Safely iterate and normalize item data
        local normalizedData = {}
        if type(playerData) == 'table' then
            for k, itemData in pairs(playerData) do
                if type(itemData) == 'table' then
                    local count = itemData.count
                    if count then
                        itemData.amount = count
                        itemData.count = nil
                    end
                    normalizedData[k] = itemData
                end
            end
        end
        
        -- CRITICAL: Ensure normalizedData is always a table before returning
        if type(normalizedData) ~= 'table' then
            normalizedData = {}
        end
        
        -- Return normalized data (or empty table if nothing was valid)
        return normalizedData
    end)
    
    -- CRITICAL: Always return a table, never a number or other type
    -- If pcall failed or result is not a table, return empty table
    local finalResult = {}
    if success and result and type(result) == 'table' then
        finalResult = result
    end
    
    -- Double-check: ensure we're returning a table
    if type(finalResult) ~= 'table' then
        finalResult = {}
    end
    
    return finalResult
end

function inventory.openInventory(invType, invId)
    if isOx then
        exports.ox_inventory:openInventory(invType, invType == 'stash' and invId or {type = invId})
    elseif isOrigen then
        exports.origen_inventory:openInventory(invType, invId)
    elseif isQs then
        -- qs-inventory uses inventory:server:OpenInventory event
        local inventoryData = Utils.await('bl_bridge:validInventory', 10, invType, invId)
        if not inventoryData then
            -- If no registered inventory, use default values for stashes
            if invType == 'stash' then
                TriggerServerEvent('inventory:server:OpenInventory', invType, invId, {
                    maxweight = 1000,
                    slots = 50
                })
            else
                return
            end
        else
            -- Format the other parameter for qs-inventory
            local other = {
                maxweight = inventoryData.maxweight or 1000,
                slots = inventoryData.slots or 50
            }
            TriggerServerEvent('inventory:server:OpenInventory', invType, invId, other)
        end
    elseif invFramework == 'qb-inventory' then
        local inventoryData = Utils.await('bl_bridge:validInventory', 10, invType, invId)
        if not inventoryData then return end

        TriggerServerEvent('inventory:server:OpenInventory', invType, invId, inventoryData)
    elseif invFramework == 'codem' then
        local inventoryData = Utils.await('bl_bridge:validInventory', 10, invType, invId)
        if not inventoryData then return end

        TriggerServerEvent('inventory:server:OpenInventory', invType, invId, inventoryData)
    end
end

function inventory.hasItem(itemName, itemCount)
    itemCount = itemCount or 1
    local notify = Framework.notify

    if type(itemName) ~= 'string' then
        notify({
            title = 'item isn\'t string'
        })
        return
    end

    if isQs then
        -- Use qs-inventory Search export for better performance
        local result = exports['qs-inventory']:Search(itemName)
        return result and result >= itemCount
    end

    local playerData = inventory.playerItems()
    for _, itemData in pairs(playerData) do
        local name, amount in itemData
        if itemName == name and itemCount <= amount then
            return true
        end
    end
    return false
end

return inventory
