utils = {}
mdt = {}
zones = {}
house = {}
local currentResourceName = GetCurrentResourceName()
local debugIsEnabled = config.debug

function errorMessage(...)
    local currentFunction = debug.getinfo(2, 'n').name
    local args = {...}
    local argString = ''
    for i, arg in ipairs(args) do
        argString = argString .. tostring(arg) .. ' '
    end
    print('^1[ERROR] ^0' .. argString .. '| ^4Code: ' .. currentFunction .. '^0')
end


--- A simple debug print function that is dependent on a convar
--- will output a nice prettfied message if debugMode is on
function dp(...)
    -- if not debugIsEnabled then return end
    local args<const> = {...}
    local currentFunction = debug.getinfo(2, 'n').name

    local appendStr = ''
    for _, v in ipairs(args) do appendStr = appendStr .. ' ' .. tostring(v) end
    local msgTemplate = '^3[%s] ^2[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, currentFunction, appendStr)
    print(finalMsg)
end

function debugPrint(...)
    if config.debug then
        print('^1[DEBUG]^0', ...)
    end
end

function vehicleName(model)
    local _veh = GetDisplayNameFromVehicleModel(model)
    local _label = GetLabelText(_veh)
    local _name = _label == 'NULL' and _veh or _label
    return _name
end

function utils:filterJob(job, data)
    -- If separateMdt is false, return data without filtering
    if not config.separateMdt then
        return data
    end
    
    -- Filter data where item.job matches the job parameter
    local filteredData = {}

    for i, item in ipairs(data) do
        if item.job == job then
            table.insert(filteredData, item)
        end
    end
    
    return filteredData
end