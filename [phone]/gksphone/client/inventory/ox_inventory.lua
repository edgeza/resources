if not Config.OxInvetory then return end

exports.ox_inventory:displayMetadata({
    eSIMNumber = 'Phone Number',
    phoneID = 'Phone ID'
})

RegisterNetEvent("gksphone:client:ItemRemoved", function(item)
    Wait(500)
    if PhoneUniqueId and LastItemData and LastItemData.name == item then
        ItemPhoneDeleted()
    end
end)

RegisterNetEvent("gksphone:client:ItemAdded", function(item)
    Wait(500)
    if Config.AutoOpen and PhoneUniqueId == nil then
        ForceLoadPhone(item)
    end
end)

exports("UsePhoneItem", function(data, itemData)
    --data = {name = 'phone', label = 'Phone', slot = 1, count = 1}
    --itemData = {name = 'phone', slot = 1, metadata = {phoneID = '1234567890'}}
    TriggerEvent("gksphone:client:usePhone", data.name, itemData)
end)

function JobCenterHasItem(itemName)
    local count = exports.ox_inventory:Search('count', itemName)
    return count > 0 and true or false
end
