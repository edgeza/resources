local bridge = {}
local NDCore = exports["ND_Core"]

function bridge.notify(...)
    NDCore:notify(...)
end

return bridge
