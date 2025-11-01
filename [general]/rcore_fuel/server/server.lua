function UpdateConfigForClient(source, identifier)
    if LoadedAllShopData then
        local updatedDataForClient = {}
        for k, v in pairs(Config.ShopList) do
            updatedDataForClient[k] = {
                for_sale = v.for_sale,
                price = v.price,
                open = v.open,
                owner_identifier = v.owner_identifier,
                gasPrices = v.gasPrices,
                capacity = v.capacity,
                fuel_only_employee = v.fuel_only_employee,
                companyMoney = v.companyMoney,
                isMissionRunning = v.isMissionRunning,
            }
        end

        if identifier then
            if updatedDataForClient[identifier] then
                updatedDataForClient = {
                    [identifier] = updatedDataForClient[identifier],
                }
            end
        end

        TriggerClientEvent("rcore_fuel:updateConfig", source, updatedDataForClient)
    end
end

RegisterNetEvent("rcore_fuel:requestConfigChanges", function()
    local source = source
    UpdateConfigForClient(source)
end)

RegisterNetEvent("rcore_fuel:requestPlayerIdentifier", function()
    local source = source
    local player = SharedObject.GetPlayerFromId(source)
    if player then
        TriggerClientEvent("rcore_fuel:requestPlayerIdentifier", source, player.identifier)
    end
end)