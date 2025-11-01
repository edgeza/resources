if not Config.qsInvetory then return end
print('[GKSPHONE] QS Inventory Loaded')
for index, _ in pairs(Config.ItemName) do
    exports['qs-inventory']:CreateUsableItem(index, function(source, item)
        if item then
            TriggerClientEvent('gksphone:client:usePhone', source, index, item)
        end
    end)
end

-- Sets the metadata of an item for a player.
--- @param source number The player's source ID.
--- @param item table The item to set the metadata for.
--- @param data table The metadata to set.
--- @return boolean True if the metadata was set successfully, false otherwise.
function SetItemData(source, item, data)
    local src = source
    local Player = GetIdentifier(src)
    if Player then
        exports['qs-inventory']:SetItemMetadata(src, item.slot, data)
        return true
    end
    return false
end

--- Updates the metadata of an item for a player based on the provided datatype and data.
--- @param source number The player's source ID.
--- @param item table The item to update the metadata for.
--- @param datatype string The type of metadata to update.
--- @param data any The new data to set for the specified metadata type.
function UpdateItemData(source, item, datatype, data)
    local src = source
    local metadata = item.metadata or item.info
    metadata[datatype] = data
    exports['qs-inventory']:SetItemMetadata(src, item.slot, metadata)
end

--- Searches the player's inventory for the specified item.
--- @param source number The player's source ID.
--- @return table item data if found, an empty table otherwise.
function SearchPhoneItems(source)
    local src = source
    local Player = GetIdentifier(src)
    local itemData = {}
    if Player then
        local item = exports['qs-inventory']:GetInventory(src)
        if #item > 0 then
            for _, v in pairs(item) do
                if Config.ItemName[v.name] then
                    itemData[#itemData+1] = v
                    break
                end
            end
        end
    end
    return itemData
end


-- Powerbank Item Use Event
if ChargeOn then
    for _, value in ipairs(Config.ChargeItems) do
        exports['qs-inventory']:CreateUsableItem(value, function(source)
            local src = source
            local Player = GetIdentifier(src)
            if Player then
                exports['qs-inventory']:RemoveItem(src, value, 1)
                TriggerClientEvent('gksphone:client:powerbank', src)
            end
        end)
    end
end