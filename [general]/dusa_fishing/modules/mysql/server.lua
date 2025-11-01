local Query = {
    SELECT = 'SELECT * FROM dusa_fishing',
    UPDATE = 'UPDATE dusa_fishing SET level = ? WHERE identifier = ?',
    INSERT = 'INSERT INTO dusa_fishing (identifier, level) VALUES(?, ?)'
}

db = {}

function db.getLevels()
    return MySQL.query.await(Query.SELECT)
end

function db.saveLevels(TABLE)
    for identifier, level in pairs(TABLE) do
        if not level then return end
        -- if type(level) == 'table' then level = json.encode(level) end
        MySQL.prepare(Query.UPDATE, { json.encode(level), identifier })
    end
end

function db.savePlayerLevel(identifier, level)
    MySQL.prepare(Query.UPDATE, { json.encode(level), identifier })
end

function db.createPlayer(identifier, level)
    MySQL.prepare(Query.INSERT, { identifier, level })
end

return db