Citizen.CreateThread(function()
    -- Preload weapon models
    local models = {
        'w_ar_halloween2025ar15',
        'w_ar_halloween2025ar15_mag1'
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

