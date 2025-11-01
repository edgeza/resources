if Config.Framework == "esx" and not Config.OxInvetory then
    if Config.OxInvetory then return end
    local EsxGetConfig = Config.Core.GetConfig()
    if EsxGetConfig and not EsxGetConfig.EnableDefaultInventory then return end
    local CustomInv = EsxGetConfig?.CustomInventory or false
    if EsxGetConfig and (CustomInv ~= false) then return end
    RegisterNetEvent("esx:removeInventoryItem", function(item, count, showNotification)
        Debugprint("Removing item: " .. item .. " Count: " .. count)
        if Config.ItemName[item] then
            if PhoneUniqueId and LastItemData and LastItemData.name == item then
                ItemPhoneDeleted()
            end
        end
    end)

    RegisterNetEvent("esx:addInventoryItem", function(item)
        if item == Config.ItemName[item] then
            if Config.AutoOpen and PhoneUniqueId == nil then
                ForceLoadPhone(item)
            end
        end
    end)
end