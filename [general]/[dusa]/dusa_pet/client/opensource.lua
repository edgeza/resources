function OpenPetShop()
    local petShopPets = {}
    local pd = GetPetData('allpets')
    if pd then
        for _, petData in ipairs(pd) do
            petShopPets[petData.modelname] = true
        end
    end

    local result = {}
    for _, petData in ipairs(Config.PetShop.pets) do
        if not petShopPets[petData.pet] then
            table.insert(result, petData)
        end
    end
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "o_petshop",
        action = 'open',
        petshopData = result,
        k9data = CheckAvailableK9(),
        isPolice = isPolice()
    })
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Keybinds) do
        if Config.EnableKeybinds == 'ox' then
            k = lib.addKeybind({
                name = k,
                description = v.description,
                defaultKey = v.key,
                onPressed = v.func,
            })
        elseif Config.EnableKeybinds == 'default' then
            RegisterKeyMapping(v.command, v.description, "keyboard", v.key)
        end
        if v.func then
            RegisterCommand(v.command, v.func, false)
        end
        if k == 'movehud' then
            RegisterCommand(v.command, function(source, args)
                if hudstatus then
                    SetNuiFocus(true, true)
                end
            end)
        end
        TriggerEvent("chat:addSuggestion", "/"..v.command)
    end
end)