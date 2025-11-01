if not rawget(_G, "lib") then 
    if GetResourceState('ox_lib') ~= 'missing' then
        include('ox_lib', 'init')
    else
        print('[^3DUSA FISHING^0] ^1ox_lib not found, some features may not work^0')
    end
end

local function addDeferral(err)
    err = err:gsub("%^%d", "")

    AddEventHandler('playerConnecting', function(_, _, deferrals)
        deferrals.defer()
        deferrals.done(err)
    end)
end

lib.locale(config.locale)

shared = {
    resource = GetCurrentResourceName(),
}

-- local Import = require 'core.import'
if IsDuplicityVersion() then
    -- sunucu tarafıdır, sunucu taraflı depolanacak table aşağıdadır
    server = {

    }
else
    -- client tarafıdır, client taraflı depolanacak table aşağıdadır
    PlayerData = {

    }
    client = {

    }
end

---Throws a formatted type error.
---```lua
---error("expected %s to have type '%s' (received %s)")
---```
---@param variable string
---@param expected string
---@param received string
function TypeError(variable, expected, received)
    error(("expected %s to have type '%s' (received %s)"):format(variable, expected, received))
end

-- People like ignoring errors for some reason
local function spamError(err)
    shared.ready = false

    CreateThread(function()
        while true do
            Wait(10000)
            CreateThread(function()
                error(err, 0)
            end)
        end
    end)

    addDeferral(err)
    error(err, 0)
end

---@param name string
---@return table
---@deprecated
function data(name)
    if shared.server and shared.ready == nil then return {} end
    local file = ('data/%s.lua'):format(name)
    local datafile = LoadResourceFile(shared.resource, file)
    local path = ('@@%s/%s'):format(shared.resource, file)

    if not datafile then
        warn(('no datafile found at path %s'):format(path:gsub('@@', '')))
        return {}
    end

    local func, err = load(datafile, path)

    if not func or err then
        shared.ready = false
        ---@diagnostic disable-next-line: return-type-mismatch
        return spamError(err)
    end

    return func()
end

function dp(...)
    if not config.debug then return end
    local args<const> = {...}
    local currentFunction = debug.getinfo(2, 'n').name

    local appendStr = ''
    for _, v in ipairs(args) do appendStr = appendStr .. ' ' .. tostring(v) end
    local msgTemplate = '^2[%s]^0%s'
    local finalMsg = msgTemplate:format(currentFunction, appendStr)
    print(finalMsg)
end

-- if lib.context == 'server' then
--     shared.ready = false
--     return require 'server'
-- end

-- require 'client'