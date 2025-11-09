local function getAllSnowmanModels(plan)
    local models = { Config.Snowman.BuiltModel }
    for name, part in pairs(plan) do
        for key, value in pairs(part) do
            if key == 'Model' then
                table.insert(models, value)
            elseif key == 'Next' then
                local nextModels = getAllSnowmanModels(value)
                for _, model in ipairs(nextModels) do
                    table.insert(models, model)
                end
            end
        end
    end

    return models
end

RegisterCommand('adminsnowmandelete', function()
    if ObjectPlacer.isPlacing() then
        Framework.sendNotification(Config.Snowman.Notifications.AlreadyBuilding, 'error')
        return
    end

    startRaycastSelection(
        getAllSnowmanModels(Config.Snowman.Plan),
        5.0,
        function(entity, model, endCoords, distance, correctModel)
            if not correctModel then
                Framework.sendNotification(Config.Snowman.Notifications.AdminWrongArchetype, 'error')
                return
            end

            local snowmanPart = Entity(entity).state[SNOWMAN_BUILD_PART_STATE_KEY]
            local snowmanId = Entity(entity).state[SNOWMAN_ID_STATE_KEY]
            if snowmanPart ~= nil then
                TriggerServerEvent('rcore_xmas:snowman:adminDeletePart', NetworkGetNetworkIdFromEntity(entity))
            elseif snowmanId ~= nil then
                TriggerServerEvent('rcore_xmas:snowman:adminDeleteSnowman', NetworkGetNetworkIdFromEntity(entity))
            else
                Framework.sendNotification(Config.Snowman.Notifications.AdminNoSnowman, 'error')
            end
        end,
        function()
            Framework.sendNotification(Config.Snowman.Notifications.AdminCancelled, 'error')
        end
    )
end, Config.AcePermsInsteadOfFramework)
