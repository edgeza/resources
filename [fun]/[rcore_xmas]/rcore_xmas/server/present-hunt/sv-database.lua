MySQL.ready(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `xmas_presentshunt` (
	        `player` VARCHAR(512) NOT NULL,
	        `present` VARCHAR(52) NOT NULL
        )
        COLLATE='utf8mb4_general_ci';
    ]])
end)

function Database.getPresents(client)
    local identifier = Framework.getIdentifier(client)
    if identifier == nil then
        log.debug('Player %s (%s) tried to get presents, but he has no identifier yet!', client,
            GetPlayerName(client))
        return {}
    end
    local rows = MySQL.Sync.fetchAll('SELECT * FROM xmas_presentshunt WHERE player = ?', { identifier })
    if rows == nil then
        return {}
    end

    local presents = {}
    for _, row in ipairs(rows) do
        presents[row.present] = true
    end

    return presents
end

function Database.collectPresent(client, presentIndex)
    local identifier = Framework.getIdentifier(client)
    if identifier == nil then
        log.error('Player %s (%s) tried to collect present, but he has no identifier!', client,
            GetPlayerName(client))
        return
    end

    local affectedRows = MySQL.Sync.execute('INSERT INTO xmas_presentshunt (player, present) VALUES (?, ?)',
        { identifier, presentIndex })
    if affectedRows < 1 then
        log.error('Player %s (%s) tried to collect present %s, but present index can not be inserted into database!',
            client,
            GetPlayerName(client), presentIndex)
        return false
    end

    return true
end
