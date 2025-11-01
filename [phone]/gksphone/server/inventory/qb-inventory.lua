if not Config.QbInventory then return end
print('[GKSPHONE] Qb Inventory Loaded')
for index in pairs(Config.ItemName) do
    RegisterUsableItem(index, function(source, item)
        TriggerClientEvent('gksphone:client:usePhone', source, index, item)
    end)
end

--- Set Item Data ---
-- Sets the metadata of an item for a player.
--- @param source number The player's source ID.
--- @param item table The item to set the metadata for.
--- @param data table The metadata to set.
-- @return True if the metadata was set successfully, false otherwise.
function SetItemData(source, item, data)
    local src = source
    local Player = Config.Core.Functions.GetPlayer(src)
    if Player then
        local itemData = Player.Functions.GetItemBySlot(item.slot)
        if itemData ~= nil then
            Player.PlayerData.items[itemData.slot].info = data
            Player.Functions.SetInventory(Player.PlayerData.items)
            return true
        end
    end
    return false
end

--- Updates the metadata of an item for a player based on the provided datatype and data.
--- @param source number The player's source ID.
--- @param item table The item to update the metadata for.
--- @param datatype string The type of metadata to update.
--- @param data any The new data to set for the specified metadata type.
function UpdateItemData(source, item, datatype, data)
    Debugprint('UpdateItemData', source, item, datatype, data)
    local src = source
    local metadata = item.metadata or item.info
    metadata[datatype] = data
    local Player = Config.Core.Functions.GetPlayer(src)
    if Player then
        local itemData = Player.Functions.GetItemBySlot(item.slot)
        if itemData ~= nil then
            Player.PlayerData.items[itemData.slot].info = metadata
            Player.Functions.SetInventory(Player.PlayerData.items)
        end
    end
end

--- Searches the player's inventory for the specified item.
--- @param source number The player's source ID.
--- @return table item data if found, an empty table otherwise.
function SearchPhoneItems(source)
    local src = source
    local Player = Config.Core.Functions.GetPlayer(src)
    local itemData = {}
    if Player then
        for k, _ in pairs(Config.ItemName) do
            local itemCheck = Player.Functions.GetItemsByName(k)
            if itemCheck and #itemCheck > 0 then
                itemData = itemCheck
                break
            end
        end
        if #itemData > 0 then
            return itemData
        end
    end
    return itemData
end


-- Powerbank Item Use Event
if ChargeOn then
    for _, value in ipairs(Config.ChargeItems) do
        RegisterUsableItem(value, function(source)
            local src = source
            local Player = Config.Core.Functions.GetPlayer(src)
            if Player and Player.Functions.RemoveItem(value, 1) then
                TriggerClientEvent('gksphone:client:powerbank', src)
            end
        end)
    end
end