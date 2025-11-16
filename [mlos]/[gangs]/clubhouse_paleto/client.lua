Config = {}

Config.bike = {
    ['coords'] = vector4(256.49, 6621.61, 29.6, 89.42),
    ['bike'] =  'nightblade', -- BIKE MODEL 
    ['plate'] = 'APOLLO', --NUMBER PLATE  Make sure only 8 characters
}
r, g, b = 0, 0, 0  -- bike colour RGB



    CreateThread(function()
        local model = GetHashKey(Config.bike['bike'])
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        local veh = CreateVehicle(model, Config.bike['coords'].x, Config.bike['coords'].y, Config.bike['coords'].z-0.5, false, false)
        SetModelAsNoLongerNeeded(model)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleDoorsLocked(veh, 3)
        SetEntityHeading(veh,Config.bike['coords'].w)
        SetVehicleCustomPrimaryColour(veh, r, g, b) -- bike colour
        SetVehicleCustomSecondaryColour(veh, r, g, b) -- bike colour
        SetVehicleExtraColours(veh, 1, 1)-- bike colour
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, Config.bike['plate'])
    end)



CreateThread(function()
    while true do
       
        ClearAreaOfPeds(260.04, 6615.12, 29.88, 30.0);
        ClearAreaOfPeds(265.74, 6654.32, 29.88, 30.0);
        ClearAreaOfPeds(289.65, 6621.95, 29.88, 30.0);
        ClearAreaOfPeds(287.18, 6609.69, 29.77, 30.0);
        ---ClearAreaOfVehicles(265.74, 6654.32, 29.88, 1000, false, false, false, false, false);
        
        Wait(100)
    end
end)
