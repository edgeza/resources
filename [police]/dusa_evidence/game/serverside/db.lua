
local Query = {
    INSERT_FILE = 'INSERT INTO evidence_archive (id, name, content, details) VALUES (?, ?, ?, ?)',
    SELECT_FILE = 'SELECT * FROM evidence_archive WHERE id = ?',
    DELETE_FILE = 'DELETE FROM evidence_archive WHERE id = ?',
    SELECT_FILES = 'SELECT * FROM evidence_archive',
    UPDATE_FILE = 'UPDATE evidence_archive SET name = ?, content = ?, details = ? WHERE id = ?',
}

db = {}

function db.createFile(id, name, content, details)
    return MySQL.prepare(Query.INSERT_FILE, { id, name, json.encode(content), json.encode(details) })
end

function db.selectFile(id)
    return MySQL.prepare.await(Query.SELECT_FILE, { id })
end

function db.listFiles()
    return MySQL.query.await(Query.SELECT_FILES)
end

function db.deleteFile(id)
    return MySQL.query.await(Query.DELETE_FILE, { id })
end

function db.updateFile(id, name, content, details)
    return MySQL.prepare(Query.UPDATE_FILE, { name, json.encode(content), json.encode(details), id })
end

return db