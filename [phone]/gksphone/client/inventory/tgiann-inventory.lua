if not Config.tgiannInventory then return end

exports["tgiann-inventory"]:DisplayMetadata({
    eSIMNumber = "Phone Number",
    phoneID = "Phone ID"
})

RegisterNetEvent("tgiann-inventory:dropItem", function(item)
    Wait(500)
    if PhoneUniqueId and LastItemData and LastItemData.name == item then
        ItemPhoneDeleted()
    end
end)

RegisterNetEvent("tgiann-inventory:addedItem", function(item)
    Wait(500)
    if Config.AutoOpen and PhoneUniqueId == nil then
        ForceLoadPhone(item)
    end
end)

exports("UsePhoneItem", function(data)
    TriggerEvent("gksphone:client:usePhone", data.name, data)
end)

function JobCenterHasItem(itemName)
    local result = exports['tgiann-inventory']:HasItem(itemName, 1)
    return result
end