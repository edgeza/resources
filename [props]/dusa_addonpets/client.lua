-- Dusa Pet Addons Client
-- This resource provides custom pet models for dusa_pet

print('^2[dusa_addonpets]^7 Resource started successfully')
print('^2[dusa_addonpets]^7 Models available: dusa_doberman, dusa_cane, dusa_englishbulldog, A_C_shepherd_2, A_C_husky_2, A_C_retriever_2, A_C_poodle_2, A_C_westy_2, dusa_sphynx, a_c_chop')

-- Pre-load models on resource start to ensure they're available
CreateThread(function()
    Wait(2000) -- Wait for peds.meta to be loaded
    
    local modelsToPreload = {
        'dusa_doberman',
        'dusa_cane', 
        'dusa_englishbulldog',
        'A_C_shepherd_2',
        'A_C_husky_2',
        'A_C_retriever_2',
        'A_C_poodle_2',
        'A_C_westy_2',
        'dusa_sphynx',
        'a_c_chop'
    }
    
    for _, modelName in pairs(modelsToPreload) do
        local hash = GetHashKey(modelName)
        if not HasModelLoaded(hash) then
            RequestModel(hash)
        end
    end
    
    print('^2[dusa_addonpets]^7 Models pre-loaded')
end)