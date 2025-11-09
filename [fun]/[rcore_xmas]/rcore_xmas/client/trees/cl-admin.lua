RegisterCommand('admintreedelete', function()
    if ObjectPlacer.isPlacing() then
        Framework.sendNotification(Config.Trees.Notifications.AlreadyBuilding, 'error')
        return
    end

    startRaycastSelection(
        {
            Config.Trees.Build.Models.Undecored,
            Config.Trees.Build.Models.Decored
        },
        5.0,
        function(entity, model, endCoords, distance, correctModel)
            if not correctModel then
                Framework.sendNotification(Config.Trees.Notifications.AdminWrongArchetype, 'error')
                return
            end

            local id = Entity(entity).state[TREE_ID_STATE_KEY]
            if id == nil or tonumber(id) < 1 then
                Framework.sendNotification(Config.Trees.Notifications.AdminNoTree, 'error')
                return
            end

            TriggerServerEvent('rcore_xmas:trees:adminDeleteTree', id)
        end,
        function()
            Framework.sendNotification(Config.Trees.Notifications.AdminCancelled, 'error')
        end
    )
end, Config.AcePermsInsteadOfFramework)
