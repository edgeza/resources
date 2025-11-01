if not Config.QbInventory then return end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    Debugprint('QBCore:Player:SetPlayerData', val)
    if not LocalPlayer.state.isLoggedIn then return end
    if PlayerData.job == nil then return end
    Wait(1000)
    if Config.QbInventory then
        local item = val.items
        local itemCheck = false
        if item then
            item = type(item) == "string" and json.decode(item) or item
            for k, v in pairs(item) do
                if v and Config.ItemName[v.name]  then
                    if v and v.name == LastItemData.name then
                        if Config.MetaItem then
                            local metadata = v.metadata or v.info
                            if metadata.phoneID == PhoneUniqueId then
                                itemCheck = true
                                break
                            end
                        else
                            itemCheck = true
                            break
                        end
                    end
                end
            end
            if not itemCheck and Config.ItemRequire then
                ItemPhoneDeleted()
            end
            if Config.AutoOpen and PhoneUniqueId == nil then
                Debugprint('Config.AutoOpen SetPlayerData')
                ForceLoadPhone()
            end
        end
    end
end)