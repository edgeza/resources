NONE_RESOURCE = 'none'

local function getImmediateModule(filePath)
    local startIndex, endIndex = string.find(filePath, "modules/")
    if startIndex then
        local remainingPath = string.sub(filePath, endIndex + 1)
        local nextSlashIndex = string.find(remainingPath, "/")
        if nextSlashIndex then
            return string.sub(remainingPath, 1, nextSlashIndex - 1)
        end

        return remainingPath
    end

    return 'base'
end

local prefixes = {
    ['error'] = '^1[%s:%s | error] ^7',
    ['warn'] = '^3[%s:%s | warn] ^7',
    ['info'] = '^2[%s:%s | info] ^7',
    ['load'] = '^3[%s:%s | load] ^7',
    ['debug'] = '^5[%s:%s | debug] ^7',
    ['dev'] = '^6[%s:%s | dev] ^7',
}

log = {}

for name, prefix in pairs(prefixes) do
    if name == 'debug' and not Config.Debug then
        log.debug = function(content, ...)
        end
    elseif name == 'error' then
        log[name] = function(content, ...)
            local file = debug.getinfo(2, 'S').source
            local line = debug.getinfo(2, 'l').currentline
            print(prefix:format(file:gsub('@@' .. GetCurrentResourceName() .. '/', ''), line) .. content:format(...))
        end
    else
        log[name] = function(content, ...)
            local source = debug.getinfo(2, 'S').source
            print(prefix:format(GetCurrentResourceName(), getImmediateModule(source)) .. content:format(...))
        end
    end
end

function log.table(_table, debug)
    if debug and not Config.Debug then return end

    if type(_table) ~= 'table' then return end

    print(json.encode(_table, { indent = true }))
end

function isResourceLoaded(resource)
    if resource == NONE_RESOURCE then return true end
    local state = GetResourceState(resource)
    return state == 'started' or state == 'starting'
end

function isBridgeLoaded(type, resource)
    return Bridge[type] == resource
end

function formatPossibleBridge(list, prefix)
    local excludedList = {}
    for key, _ in pairs(list) do
        table.insert(excludedList, string.format('^1%s.%s^7', prefix, key))
    end
    return table.concat(excludedList, ', ')
end

Citizen.CreateThread(function()
    if Config.Snowballs.Pickup.Receive.Item == 'WEAPON_SNOWBALL' and (Config.Framework == Framework.QBCore or Config.Inventory == Inventory.QS) then
        log.error('!!! Replace all ^1WEAPON_SNOWBALL^7 with ^1weapon_snowball^7 in config.lua !!!')
    end
end)

function getCurrentCodeInformations()
    local source = debug.getinfo(2, 'S').source
    return {
        resource = GetCurrentResourceName(),
        file = source,
        module = getImmediateModule(source),
        line = debug.getinfo(2, 'l').currentline
    }
end
