-- Database module for dusa_hud
-- This handles all database operations

db = {}

-- Make db globally accessible
_G.db = db

-- Query database for specific columns
function db.query(tableName, columns, whereColumn, whereValue)
    if not tableName or not columns then return {} end
    
    local columnStr = type(columns) == 'table' and table.concat(columns, ', ') or columns
    local query = string.format('SELECT %s FROM %s', columnStr, tableName)
    
    if whereColumn and whereValue then
        query = string.format('%s WHERE %s = ?', query, whereColumn)
        local result = MySQL.query.await(query, {whereValue})
        return result or {}
    else
        local result = MySQL.query.await(query)
        return result or {}
    end
end

-- Insert data into database
function db.insert(tableName, columns, values)
    if not tableName or not columns or not values then return false end
    
    local columnStr = type(columns) == 'table' and table.concat(columns, ', ') or columns
    local placeholders = {}
    local valueCount = type(values) == 'table' and #values or 1
    
    for i = 1, valueCount do
        placeholders[i] = '?'
    end
    
    local query = string.format('INSERT INTO %s (%s) VALUES (%s)', 
        tableName, columnStr, table.concat(placeholders, ', '))
    
    local result = MySQL.insert.await(query, values)
    return result ~= nil
end

-- Update/Save data in database
function db.save(tableName, column, whereColumn, value, whereValue)
    if not tableName or not column or not whereColumn or not value or not whereValue then return false end
    
    local query = string.format('UPDATE %s SET %s = ? WHERE %s = ?', tableName, column, whereColumn)
    local result = MySQL.update.await(query, {value, whereValue})
    return result ~= nil
end

-- Delete data from database
function db.delete(tableName, whereColumn, whereValue)
    if not tableName or not whereColumn or not whereValue then return false end
    
    local query = string.format('DELETE FROM %s WHERE %s = ?', tableName, whereColumn)
    local result = MySQL.query.await(query, {whereValue})
    return result ~= nil
end

-- Execute custom query
function db.execute(query, params)
    if not query then return false end
    local result = MySQL.query.await(query, params or {})
    return result
end

-- Fetch/Query data (alias for query with all columns)
function db.fetch(tableName, columns, whereColumn, whereValue)
    return db.query(tableName, columns, whereColumn, whereValue)
end

return db

