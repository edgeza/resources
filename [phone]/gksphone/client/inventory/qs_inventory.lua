if not Config.qsInvetory then return end

RegisterNetEvent("esx:removeInventoryItem", function(item, count)
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

function JobCenterHasItem(itemName)
    local result = exports['qs-inventory']:Search(itemName)
    return result > 0 and true or false
end