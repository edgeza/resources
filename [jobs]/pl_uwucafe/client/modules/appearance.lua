local ResourceClothing = GetClothing()
function setUniform(playerPed)
    local gender = GetPlayerGender()
    local uniformObject = Config.Uniforms['clothes'][gender]
    if ResourceClothing == 'esx_skin'then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
            else
                Notify(Locale("no_outfit"),"error")
            end
        end)
    elseif  ResourceClothing == 'illenium-appearance' then
        if not Appearance then
            Appearance = exports['illenium-appearance']:getPedAppearance(playerPed)
        end
        Wait(100)
        local undershirt = {component_id = 8, texture = uniformObject.tshirt_2, drawable = uniformObject.tshirt_1}
        local arms = {component_id = 3, texture = 0, drawable = uniformObject.arms}
        local torso = {component_id = 11, texture = uniformObject.torso_2, drawable = uniformObject.torso_1}
        local pants = {component_id = 4, texture = uniformObject.pants_2, drawable = uniformObject.pants_1}
        local shoes = {component_id = 6, texture = uniformObject.shoes_2, drawable = uniformObject.shoes_1}
        local accesories = {component_id = 7, texture = uniformObject.chain_2, drawable = uniformObject.chain_1}
        local props = {props = {{prop_id = 1, texture = uniformObject.glasses_2, drawable = uniformObject.glasses_1}, {prop_id = 2, texture = uniformObject.ears_2, drawable = uniformObject.ears_1}}}
        exports['illenium-appearance']:setPedComponents(playerPed, {torso, undershirt, pants, shoes, accesories, arms, props})
    elseif ResourceClothing == 'fivem-appearance' then
        if not Appearance then
            Appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
        end
        Wait(100)
        local undershirt = {component_id = 8, texture = uniformObject.tshirt_2, drawable = uniformObject.tshirt_1}
        local arms = {component_id = 3, texture = 0, drawable = uniformObject.arms}
        local torso = {component_id = 11, texture = uniformObject.torso_2, drawable = uniformObject.torso_1}
        local pants = {component_id = 4, texture = uniformObject.pants_2, drawable = uniformObject.pants_1}
        local shoes = {component_id = 6, texture = uniformObject.shoes_2, drawable = uniformObject.shoes_1}
        local accesories = {component_id = 7, texture = uniformObject.chain_2, drawable = uniformObject.chain_1}
        local props = {props = {{prop_id = 1, texture = uniformObject.glasses_2, drawable = uniformObject.glasses_1}, {prop_id = 2, texture = uniformObject.ears_2, drawable = uniformObject.ears_1}}}
            exports['fivem-appearance']:setPedComponents(playerPed, {torso, undershirt, pants, shoes, accesories, arms, props})
     elseif ResourceClothing == 'tgiann-clothing' then
        local skinData = {
            { name = "bags_1", val =  0 }, { name = 'bags_2', val = 0},
            { name = "glasses_1", val =  -1 }, { name = 'bags_2', val = 0},
            { name = "watches_1", val =  -1 }, { name = 'watches_2', val = 0},
            { name = "bracelets_1", val =  -1 }, { name = 'bracelets_2', val = 0},
            { name = "tshirt_1", val =  uniformObject.tshirt_1 or nil }, { name = "tshirt_2", val = uniformObject.tshirt_2 or nil},
            { name = "torso_1" , val =  uniformObject.torso_1 or nil}, { name = "torso_2", val = uniformObject.torso_2 or nil},
            { name = "decals_1", val =  uniformObject.decals_1 or nil}, { name = "decals_2", val = uniformObject.decals_2 or nil},
            { name = "arms"    , val = uniformObject.arms or nil },
            { name = "pants_1" , val =  uniformObject.pants_1 }, { name = "pants_2", val = uniformObject.pants_2},
            { name = "shoes_1" , val =  uniformObject.shoes_1 or nil}, { name = "shoes_2", val = uniformObject.shoes_2 or nil},
            { name = "mask_1"  , val =  0 }, { name = "mask_2", val = 0},
            { name = "helmet_1", val =  uniformObject.helmet_1 or nil }, { name = "helmet_2", val = uniformObject.helmet_2 or nil},
            { name = "chain_1" , val =  uniformObject.chain_1 or nil}, { name = 'chain_2', val = uniformObject.chain_2 or nil},
            { name = "ears_1"  , val = uniformObject.ears_1 or nil  }, { name = 'ears_2', val = uniformObject.ears_2 or nil},
            { name = "bproof_1", val =  0 }, { name = 'bproof_2', val = 0},
        }
        TriggerEvent("tgiann-clothing:changeScriptClothe", skinData)
    elseif ResourceClothing == 'rcore_clothing' then
         if not Appearance then
            Appearance = exports['rcore_clothing']:getPlayerClothing()
         end
         Wait(100)
         local skin = {
            { name = "bags_1", val =  0 }, { name = 'bags_2', val = 0},
            { name = "glasses_1", val =  -1 }, { name = 'bags_2', val = 0},
            { name = "watches_1", val =  -1 }, { name = 'watches_2', val = 0},
            { name = "bracelets_1", val =  -1 }, { name = 'bracelets_2', val = 0},
            { name = "tshirt_1", val =  uniformObject.tshirt_1 or nil }, { name = "tshirt_2", val = uniformObject.tshirt_2 or nil},
            { name = "torso_1" , val =  uniformObject.torso_1 or nil}, { name = "torso_2", val = uniformObject.torso_2 or nil},
            { name = "decals_1", val =  uniformObject.decals_1 or nil}, { name = "decals_2", val = uniformObject.decals_2 or nil},
            { name = "arms"    , val = uniformObject.arms or nil },
            { name = "pants_1" , val =  uniformObject.pants_1 }, { name = "pants_2", val = uniformObject.pants_2},
            { name = "shoes_1" , val =  uniformObject.shoes_1 or nil}, { name = "shoes_2", val = uniformObject.shoes_2 or nil},
            { name = "mask_1"  , val =  0 }, { name = "mask_2", val = 0},
            { name = "helmet_1", val =  uniformObject.helmet_1 or nil }, { name = "helmet_2", val = uniformObject.helmet_2 or nil},
            { name = "chain_1" , val =  uniformObject.chain_1 or nil}, { name = 'chain_2', val = uniformObject.chain_2 or nil},
            { name = "ears_1"  , val = uniformObject.ears_1 or nil  }, { name = 'ears_2', val = uniformObject.ears_2 or nil},
            { name = "bproof_1", val =  0 }, { name = 'bproof_2', val = 0},
        }
         exports['rcore_clothing']:setPedSkin(playerPed, skin)
    elseif ResourceClothing == 'qb-clothing' then
        local Data = {
            outfitData = {
                ["pants"]       = { item = uniformObject.pants_1, texture = uniformObject.pants_2},
                ["arms"]        = { item = uniformObject.arms or nil, texture = 0 or nil},  
                ["t-shirt"]     = { item = uniformObject.tshirt_1 or nil, texture = uniformObject.tshirt_2 or nil},  
                ["torso2"]      = { item = uniformObject.torso_1 or nil, texture = uniformObject.torso_2 or nil}, 
                ["shoes"]       = { item = uniformObject.shoes_1 or nil, texture = uniformObject.shoes_2 or nil},  
                ["glass"]       = { item = uniformObject.glasses_1 or nil, texture = uniformObject.glasses_2 or nil},  
                ["ear"]         = { item = uniformObject.ears_1 or nil, texture = uniformObject.ears_2 or nil},  
                ["mask"]         = { item = uniformObject.mask_1 or nil, texture = uniformObject.mask_2 or nil}, 
                ["hat"]         = { item = uniformObject.helmet_1 or nil, texture = uniformObject.helmet_2 or nil},  
            },
        }
        TriggerEvent('qb-clothing:client:loadOutfit', Data)
    end
end

function OutfitMenu(type)
    if type == 'civilian' then
         if ResourceClothing == 'esx_skin' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        elseif ResourceClothing == 'illenium-appearance' then
            if Appearance then
                exports['illenium-appearance']:setPedAppearance(PlayerPedId(), Appearance)
                Appearance = nil
            end
        elseif ResourceClothing == 'fivem-appearance' then
            if Appearance then
                exports['fivem-appearance']:setPedAppearance(PlayerPedId(), Appearance)
                Appearance = nil
            end
        elseif ResourceClothing == 'tgiann-clothing' then
            TriggerEvent("tgiann-clothing:changeScriptClothe")
        elseif ResourceClothing == 'qb-clothing' then
            TriggerServerEvent('qb-clothes:loadPlayerSkin')
        elseif ResourceClothing == 'rcore_clothing' then
            TriggerServerEvent('rcore_clothing:reloadSkin')
            Appearance = nil
        end
    else
        setUniform(PlayerPedId())
    end
end