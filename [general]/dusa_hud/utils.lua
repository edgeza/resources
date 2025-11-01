--- A simple wrapper around SendNUIMessage that you can use to
--- dispatch actions to the React frame.
---
---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function nuiMessage(action, data)
    SendNUIMessage({action = action, data = data})
end

local currentResourceName = GetCurrentResourceName()
local debugIsEnabled = config.debug
local errorIsEnabled = config.error

--- A simple debug print function that is dependent on a convar
--- will output a nice prettfied message if debugMode is on
function dp(...)
    if not debugIsEnabled then return end
    local args<const> = {...}
    local currentFunction = debug.getinfo(2, 'n').name

    local appendStr = ''
    for _, v in ipairs(args) do appendStr = appendStr .. ' ' .. tostring(v) end
    local msgTemplate = '^3[%s] ^2[%s]^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, currentFunction, appendStr)
    print(finalMsg)
end

function error(...)
    if not errorIsEnabled then return end
    local currentFunction = debug.getinfo(2, 'n').name
    local usercore = shared.framework
    local args = {...}
    local argString = ''
    for i, arg in ipairs(args) do
        argString = argString .. tostring(arg) .. ' '
    end
    local msgTemplate = '^3[%s] ^1%s ^0%s'
    local finalMsg = msgTemplate:format('ERROR', currentFunction,
                                        argString, '[CORE] '..shared.framework)
    print(finalMsg)
end