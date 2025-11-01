local function registerUsableItems()
    for item, model in pairs(Config.Toys) do
        if ESX then
            ESX.RegisterUsableItem(item, function(source)
                TriggerClientEvent('pl_uwucafe:shouldertoy:useToy', source, item, model)
            end)
        elseif QBCore then
            QBCore.Functions.CreateUseableItem(item, function(source)
                TriggerClientEvent('pl_uwucafe:shouldertoy:useToy', source, item, model)
            end)
        end
    end
end

CreateThread(registerUsableItems)
