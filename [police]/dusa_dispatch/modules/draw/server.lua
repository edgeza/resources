if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Draw               = {}
local createdDraws       = {}
GlobalState.createdDraws = {}

function Draw.createDraw(draw)
    local isDrawIncluded = Utils.isInTable(createdDraws, 'groupId', draw.groupId)

    if isDrawIncluded then
        return
    end

    createdDraws[#createdDraws + 1] = draw
    GlobalState.createdDraws = createdDraws
    TriggerClientEvent('dusa_dispatch:UpdateDraws', -1, GlobalState.createdDraws)
end
RegisterServerEvent('dusa_dispatch:createDraw', Draw.createDraw)

function Draw.removeDraw(id)
    -- id?
    for i = 1, #createdDraws do
        if createdDraws[i].groupId == id then
            table.remove(createdDraws, i)
            break
        end
    end
    GlobalState.createdDraws = createdDraws
    TriggerClientEvent('dusa_dispatch:UpdateDraws', -1, GlobalState.createdDraws)
end
RegisterServerEvent('dusa_dispatch:removeDraw', Draw.removeDraw)

function Draw.updateDraw(draw)
    createdDraws = draw
    GlobalState.createdDraws = createdDraws
    TriggerClientEvent('dusa_dispatch:UpdateDraws', -1, GlobalState.createdDraws)
end
RegisterServerEvent('dusa_dispatch:updateDraw', Draw.updateDraw)

return Draw