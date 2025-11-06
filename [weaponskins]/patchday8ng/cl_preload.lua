Citizen.CreateThread(function()
    -- Preload weapon models
    local models = {
        'w_pi_combatpistol',
        'w_pi_combatpistol_mag1',
        'w_at_pi_supp'
    }
    
    for _, model in ipairs(models) do
        local hash = GetHashKey(model)
        RequestModel(hash)
        
        while not HasModelLoaded(hash) do
            Wait(100)
            RequestModel(hash)
        end
        
        SetModelAsNoLongerNeeded(hash)
    end
end)

