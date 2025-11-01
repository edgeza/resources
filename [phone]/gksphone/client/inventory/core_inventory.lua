if not Config.CoreInventory then return end

RegisterNetEvent('core_inventory:client:itemRemove', function(itemName, amountRemoved)
    Wait(500)
    if PhoneUniqueId and LastItemData and LastItemData.name == itemName then
        ItemPhoneDeleted()
    end
end)


RegisterNetEvent('core_inventory:client:itemAdd', function(itemName, amountRemoved)
    Wait(500)
    if Config.AutoOpen and PhoneUniqueId == nil then
        ForceLoadPhone(itemName)
    end
end)