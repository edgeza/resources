if Config.Framework == "esx" and not Config.OxInvetory then
    local EsxGetConfig = Config.Core.GetConfig()
    if EsxGetConfig and not EsxGetConfig.EnableDefaultInventory then return end
    if EsxGetConfig and EsxGetConfig.CustomInventory ~= nil or false then return end
    print("[GKSPHONE] ESX Default Inventory Loaded")
    for index, _ in pairs(Config.ItemName) do
        RegisterUsableItem(index, function(source, item, data)
            Debugprint("Item Check", source, item, data)
            TriggerClientEvent('gksphone:client:usePhone', source, index, data)
        end)
    end

    -- Sets the metadata of an item for a player.
    --- @param source number The player's source ID.
    --- @param item table The item to set the metadata for.
    --- @param data table The metadata to set.
    --- @return boolean True if the metadata was set successfully, false otherwise.
    function SetItemData(source, item, data)
        return true
    end

    --- Updates the metadata of an item for a player based on the provided datatype and data.
    --- @param source number The player's source ID.
    --- @param item table The item to update the metadata for.
    --- @param datatype string The type of metadata to update.
    --- @param data any The new data to set for the specified metadata type.
    function UpdateItemData(source, item, datatype, data)
        Debugprint('UpdateItemData', source, item, datatype, data)
    end

    --- Searches the player's inventory for the specified item.
    --- @param source number The player's source ID.
    --- @return table item data if found, an empty table otherwise.
    function SearchPhoneItems(source)
        local src = source
        local Player = Config.Core.GetPlayerFromId(source)
        local itemData = {}
        if Player then
            for index, _ in pairs(Config.ItemName) do
                local item = Player.getInventoryItem(index)
                if item and item.count > 0 then
                    itemData[#itemData+1] = item
                    break
                end
            end
        end
        return itemData
    end

    -- Powerbank Item Use Event
    if ChargeOn then
        for _, value in ipairs(Config.ChargeItems) do
            RegisterUsableItem(value, function(source)
                RemoveItem(source, value, 1)
                TriggerClientEvent('gksphone:client:powerbank', source)
            end)
        end
    end
end