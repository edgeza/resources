if not BridgeLoaded then return end

CachedTrees = {}
IsTreesCached = false

MySQL.ready(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `xmas_trees` (
            `id` INT(10) NOT NULL AUTO_INCREMENT,
	        `model` VARCHAR(52) NOT NULL,
	        `owner` VARCHAR(512) NOT NULL,
	        `coords` LONGTEXT NOT NULL,
	        `rotation` LONGTEXT NOT NULL,
	        `heading` FLOAT NOT NULL DEFAULT (0),
            PRIMARY KEY (`id`)
        )
        COLLATE='utf8mb4_general_ci';
    ]])

    pcall(function()
        MySQL.Sync.execute("ALTER TABLE `xmas_trees` ADD COLUMN `bucket` INT(10) NOT NULL DEFAULT '0';")
    end)

    if Config.Trees.Persist.Enabled then
        local trees = Database.getTrees()
        CachedTrees = trees
        TriggerEvent('rcore_xmas:trees:cachedTrees', CachedTrees)
        log.info('Successfully cached %s trees from database.', table.size(trees))
        IsTreesCached = true
    end
end)

function Database.getTrees(client)
    local sql = 'SELECT * FROM xmas_trees'
    local params = {}
    if client ~= nil then
        local identifier = Framework.getIdentifier(client)
        if identifier == nil then
            log.error('Player %s (%s) tried to get trees, but he has no identifier!', client,
                GetPlayerName(client))
            return {}
        end

        sql = sql .. ' WHERE owner = ?'
        params = { identifier }
    end

    local rows = MySQL.Sync.fetchAll(sql, params)
    if rows == nil then
        return {}
    end

    local trees = {}
    for _, row in ipairs(rows) do
        local coords = json.decode(row.coords)
        coords = vector3(coords.x, coords.y, coords.z)
        local rotation = json.decode(row.rotation)
        rotation = vector3(rotation.x, rotation.y, rotation.z)
        local heading = row.heading
        local tree = {
            owner = row.owner,
            model = tonumber(row.model),
            coords = coords,
            rotation = rotation,
            heading = heading,
            bucket = row.bucket
        }
        trees[tostring(row.id)] = tree
    end

    return trees
end

function Database.insertTree(client, model, coords, rotation, heading, bucket)
    local identifier = Framework.getIdentifier(client)
    if identifier == nil then
        log.error('Player %s (%s) tried to insert tree, but he has no identifier!', client,
            GetPlayerName(client))
        return
    end

    local id = MySQL.Sync.insert(
        'INSERT INTO xmas_trees (model, owner, coords, rotation, heading, bucket) VALUES (?, ?, ?, ?, ?, ?)',
        { model, identifier, json.encode(coords), json.encode(rotation), heading, bucket }
    )
    if id < 1 then
        log.error('Player %s (%s) tried to insert tree, but tree can not be inserted into database!', client,
            GetPlayerName(client))
        return false
    end

    CachedTrees[tostring(id)] = {
        owner = identifier,
        model = tonumber(model),
        coords = coords,
        rotation = rotation,
        heading = heading,
        bucket = bucket
    }
    return true, id
end

function Database.deleteTree(treeId)
    local success = MySQL.Sync.execute('DELETE FROM xmas_trees WHERE id = ?', { treeId })
    if success < 1 then
        log.error('Tree with id %s can not be deleted from database!', treeId)
        return false
    end

    CachedTrees[tostring(treeId)] = nil
    return true
end

function Database.changeTreeModel(treeId, newModel)
    local success = MySQL.Sync.execute('UPDATE xmas_trees SET model = ? WHERE id = ?', { newModel, treeId })
    if success < 1 then
        log.error('Tree with id %s can not be updated in database!', treeId)
        return false
    end

    CachedTrees[tostring(treeId)].model = newModel
    return true
end

function Cache.getTreesByOwner(client)
    local identifier = Framework.getIdentifier(client)
    if identifier == nil then
        log.error('Player %s (%s) tried to get cached trees, but he has no identifier!', client,
            GetPlayerName(client))
        return {}
    end

    local trees = {}
    for treeId, tree in pairs(CachedTrees) do
        if tree.owner == identifier then
            trees[tostring(treeId)] = tree
        end
    end

    return trees
end
