if not BridgeLoaded then return end

if not Config.Trees.Persist.Enabled then
    log.warn('Trees Persistance is disabled - gifts stashes inside trees are disabled too.')
    return
end

log.debug('Trees Persistance enabled!')

function sendDataEventSplitted(playerId, toSplit, event)
    local i = 0
    local splitted = {}
    for key, value in pairs(toSplit) do
        if splitted[tostring(i)] == nil then
            splitted[tostring(i)] = {}
        end

        if table.size(splitted[tostring(i)]) >= TREES_SPAWN_EVENTS_SPLIT_TABLE_SIZE then
            i = i + 1
            splitted[tostring(i)] = {}
        end

        splitted[tostring(i)][tostring(key)] = value
    end

    log.debug('Splitted %s into %s tables (events)', event, table.size(splitted))
    Citizen.CreateThread(function()
        for split, value in pairs(splitted) do
            TriggerClientEvent(event, playerId, value)
        end
    end)
end

AddEventHandler('rcore_xmas:bridge:playerLoaded', function(client)
    local trees = {}
    for treeId, tree in pairs(CachedTrees) do
        local entityId = SpawnedTreeObjects[tostring(treeId)]
        if entityId == nil or not DoesEntityExist(entityId) then
            entityId = spawnTree(treeId, tree.model, tree.coords, tree.rotation, tree.heading, tree.owner, tree.bucket)
        end

        if not DoesEntityExist(entityId) then
            log.error('Failed to spawn tree %s (%s)', treeId, tree.model, client,
                GetPlayerName(client))
            return
        end

        local netId = NetworkGetNetworkIdFromEntity(entityId)
        trees[tostring(treeId)] = {
            id = treeId,
            owner = tree.owner,
            model = tree.model,
            netId = netId,
            coords = tree.coords,
        }
    end

    sendDataEventSplitted(client, trees, 'rcore_xmas:trees:addTreesTargets')
end)

-- AddEventHandler('rcore_xmas:trees:cachedTrees', function(cachedTrees)
--     local trees = {}
--     for treeId, tree in pairs(cachedTrees) do
--         local entityId = spawnTree(treeId, tree.model, tree.coords, tree.rotation, tree.heading, tree.owner, tree.bucket)
--         local netId = NetworkGetNetworkIdFromEntity(entityId)
--         trees[tostring(treeId)] = {
--             id = treeId,
--             owner = tree.owner,
--             model = tree.model,
--             netId = netId,
--             coords = tree.coords,
--         }
--     end

--     sendDataEventSplitted(-1, trees, 'rcore_xmas:trees:addTreesTargets')
-- end)

RegisterNetEvent('rcore_xmas:trees:buildTree', function(coords, rotation, heading)
    local client = source

    local playerPed = GetPlayerPed(client)
    local playerCoords = GetEntityCoords(playerPed)

    local distance = #(playerCoords - coords)

    if distance > 10.0 then
        log.error('Player %s (%s) is too far away from tree that he wanna place', client,
            GetPlayerName(client))
        return
    end

    local playersTrees = Cache.getTreesByOwner(client)
    local limit = Config.Trees.Persist.PerPlayerLimit
    if limit and playersTrees ~= nil and table.size(playersTrees) >= limit then
        Framework.sendNotification(client, Config.Trees.Notifications.PersistLimit, 'error')
        log.debug('Player %s (%s) has too many trees', client, GetPlayerName(client))
        return
    end

    local item = Config.Trees.Build.Item
    if item ~= nil then
        if not Inventory.hasItem(client, item) then
            Framework.sendNotification(client, Config.Trees.Notifications.NoItem, 'error')
            log.debug('Player %s (%s) does not have item %s', client, GetPlayerName(client), item)
            return
        end

        local success = Inventory.removeItem(client, item, 1)
        if not success then
            log.error('Failed to remove item %s from inventory %s (%s)', item, client,
                GetPlayerName(client))
        end
    end

    local model = Config.Trees.Build.Models.Undecored
    local bucket = GetPlayerRoutingBucket(client)
    local success, id = Database.insertTree(client, model, coords, rotation, heading, bucket)
    if not success then
        return
    end

    registerStash(id)

    local owner = Framework.getIdentifier(client)
    local entityId = spawnTree(id, model, coords, rotation, heading, owner, bucket)
    local netId = NetworkGetNetworkIdFromEntity(entityId)

    SetTimeout(1000, function()
        TriggerClientEvent('rcore_xmas:trees:addTreesTargets', -1, {
            [tostring(id)] = {
                id = id,
                owner = owner,
                model = model,
                netId = netId,
                coords = coords,
            }
        })
    end)

    Framework.sendNotification(client, Config.Trees.Notifications.TreeBuilt, 'success')

    TriggerEvent('rcore_xmas:log', Logs.TREE_PLACED, {
        player = {
            id = client,
            name = GetPlayerName(client),
            identifier = Framework.getIdentifier(client),
        },
        data = {
            tree = id,
            position = {
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                rotation = {
                    x = rotation.x,
                    y = rotation.y,
                    z = rotation.z,
                },
                heading = heading,
            },
        }
    })
end)

RegisterNetEvent('rcore_xmas:trees:destroyTree', function(treeId)
    local client = source

    local playerIdentifier = Framework.getIdentifier(client)
    if playerIdentifier == nil then
        log.error('Player %s (%s) tried to destroy tree, but he has no identifier!', client,
            GetPlayerName(client))
        return
    end

    local tree = CachedTrees[tostring(treeId)]
    if tree == nil then
        log.error('Player %s (%s) tried to destroy tree, but tree with id %s does not exist!', client,
            GetPlayerName(client), treeId)
        return
    end

    if tree.owner ~= playerIdentifier then
        log.error('Player %s (%s) tried to destroy tree, but he is not owner of tree with id %s!', client,
            GetPlayerName(client), treeId)
        return
    end

    Framework.sendNotification(client, Config.Trees.Notifications.TreeDestroyed, 'success')

    local success = Database.deleteTree(treeId)
    if not success then
        return
    end

    local entityId = SpawnedTreeObjects[tostring(treeId)]
    local netId = NetworkGetNetworkIdFromEntity(entityId)
    TriggerClientEvent('rcore_xmas:trees:deleteTreesTargets', -1, {
        [tostring(netId)] = true,
    })

    destroyTree(treeId)
    destroyGifts(treeId)

    local coords = GetEntityCoords(GetPlayerPed(client))
    TriggerEvent('rcore_xmas:log', Logs.TREE_DESTROYED, {
        player = {
            id = client,
            name = GetPlayerName(client),
            identifier = Framework.getIdentifier(client),
        },
        data = {
            tree = treeId,
            position = {
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
            }
        }
    })
end)

RegisterNetEvent('rcore_xmas:trees:decorate', function(treeId)
    local client = source
    local tree = CachedTrees[tostring(treeId)]
    if tree == nil then
        log.error('Tree with id %s does not exist!', treeId)
    end

    local has = true
    for _, item in ipairs(Config.Trees.Decorate.Required) do
        if not Inventory.hasItem(client, item.item, item.amount) then
            has = false
            break
        end
    end

    if not has then
        log.debug('Player %s (%s) does not have enough items to decorate tree with id %s.', client,
            GetPlayerName(client), treeId)
        Framework.sendNotification(client, Config.Trees.Notifications.EnoughItems, 'error')
        return
    end

    for _, item in ipairs(Config.Trees.Decorate.Required) do
        Inventory.removeItem(client, item.item, item.amount)
    end

    local status = Database.changeTreeModel(treeId, Config.Trees.Build.Models.Decored)
    if not status then
        return
    end

    Framework.sendNotification(client, Config.Trees.Notifications.TreeDecorated, 'success')

    tree.model = Config.Trees.Build.Models.Decored


    local spawnedEntityId = SpawnedTreeObjects[tostring(treeId)]
    local spawnedNetId = NetworkGetNetworkIdFromEntity(spawnedEntityId)
    TriggerClientEvent('rcore_xmas:trees:deleteTreesTargets', -1, {
        [tostring(spawnedNetId)] = true,
    })

    local entityId = spawnTree(treeId, tree.model, tree.coords, tree.rotation, tree.heading, tree.owner, tree.bucket)
    local netId = NetworkGetNetworkIdFromEntity(entityId)

    SetTimeout(1000, function()
        TriggerClientEvent('rcore_xmas:trees:addTreesTargets', -1, {
            [tostring(treeId)] = {
                id = treeId,
                owner = tree.owner,
                model = tree.model,
                netId = netId,
                coords = tree.coords,
            }
        })
    end)

    local coords = GetEntityCoords(GetPlayerPed(client))
    TriggerEvent('rcore_xmas:log', Logs.TREE_DECORATED, {
        player = {
            id = client,
            name = GetPlayerName(client),
            identifier = Framework.getIdentifier(client),
        },
        data = {
            tree = treeId,
            position = {
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
            }
        }
    })
end)
