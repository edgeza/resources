
if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

local Query = {
    INSERT_UNIT = 'INSERT INTO dispatch_units (unit_id, unit_name, drop_id, max_count) VALUES (?, ?, ?, ?)',
    SELECT_UNIT = 'SELECT * FROM dispatch_units WHERE unit_id = ?',
    SELECT_SETTINGS = 'SELECT * FROM dispatch_user WHERE identifier = ?',
    UPDATE_SETTINGS = 'UPDATE dispatch_user SET callsign = ?, filters = ? WHERE identifier = ?',
    INSERT_SETTINGS = 'INSERT INTO dispatch_user (identifier, callsign, filters) VALUES (?, ?, ?)',
    SETTINGS_EXIST = 'SELECT 1 FROM dispatch_user WHERE identifier = ? LIMIT 1',
    SELECT_UNITS = 'SELECT * FROM dispatch_units',
    DELETE_UNIT = 'DELETE FROM dispatch_units WHERE unit_id = ?',
    SELECT_CAMERAS = 'SELECT * FROM dispatch_camera',
    INSERT_CAMERA = 'INSERT INTO dispatch_camera (camid, name, setting, coords, rot) VALUES (?, ?, ?, ?, ?)',
    DELETE_CAMERA = 'DELETE FROM dispatch_camera WHERE camid = ?'
}

db = {}

function db.createUnit(id, name, dropId, maxCount)
    return MySQL.prepare(Query.INSERT_UNIT, { id, name, dropId, maxCount })
end

function db.selectUnit(id)
    return MySQL.prepare.await(Query.SELECT_UNIT, { id })
end

function db.listUnits()
    return MySQL.query.await(Query.SELECT_UNITS)
end

function db.deleteUnit(id)
    return MySQL.query.await(Query.DELETE_UNIT, { id })
end

function db.createCamera(camid, name, setting, coords, rot)
    return MySQL.prepare(Query.INSERT_CAMERA, { camid, name, setting, coords, rot })
end

function db.deleteCamera(id)
    return MySQL.query.await(Query.DELETE_CAMERA, { id })
end

function db.listCamera()
    return MySQL.query.await(Query.SELECT_CAMERAS)
end

function db.getSettings(id)
    return MySQL.prepare.await(Query.SELECT_SETTINGS, { id })
end

function db.saveSettings(TABLE)
    for identifier, data in pairs(TABLE) do
        -- callsign filters identifier
        if not data then return end
        MySQL.prepare(Query.UPDATE_SETTINGS, { data.callsign, json.encode(data.filters), identifier })
    end
end

function db.createSettings(identifier, callsign, filters)
    return MySQL.prepare(Query.INSERT_SETTINGS, { identifier, callsign, filters })
end

function db.checkSettingsExist(identifier)
    return MySQL.single.await(Query.SETTINGS_EXIST, { identifier })
end

return db