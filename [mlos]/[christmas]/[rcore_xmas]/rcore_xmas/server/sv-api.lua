if not BridgeLoaded then return end

-- * Trees
exports('getTrees', function()
    return CachedTrees
end)

exports('getTreesByOwner', Cache.getTreesByOwner)

-- * PresentHunt
exports('getPresentsPositions', function()
    return PresentsPositions
end)

exports('getCollectedPresents', Database.getPresents)

-- * Snowman
exports('getSpawnedSnowmans', function()
    return SpawnedSnowmans
end)

exports('isEntitySnowman', isEntitySnowman)
