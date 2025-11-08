if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Unit           = {}
local unitList       = {}
GlobalState.unitList = {}

Citizen.CreateThread(function()
    -- Code to run on resource start
    local units = db.listUnits()
    for i = 1, #units do
        local add = {}
        add.id = units[i].unit_id
        add.name = units[i].unit_name
        add.dropId = units[i].drop_id
        add.maxCount = units[i].max_count
        add.userList = {}
        unitList[#unitList + 1] = add
    end
    GlobalState.unitList = unitList
end)


--- @param created table
--- @param table table
function Unit.createUnit(created, table)
    unitList[#unitList + 1] = created
    db.createUnit(created.id, created.name, created.dropId, created.maxCount)
    GlobalState.unitList = unitList
    TriggerClientEvent('dusa_dispatch:UpdateUnit', -1, GlobalState.unitList)
end
RegisterServerEvent('dusa_dispatch:createUnit', Unit.createUnit)

function Unit.removeUnit(id)
    for i = 1, #unitList do
        if unitList[i].id == id then
            table.remove(unitList, i)
            db.deleteUnit(id)
            TriggerClientEvent('dusa_dispatch:UpdateUnit', -1, GlobalState.unitList)
            break
        end
    end
    GlobalState.unitList = unitList
end
RegisterServerEvent('dusa_dispatch:removeUnit', Unit.removeUnit)

function Unit.UpdateUnit(data, action)
    for i = 1, #unitList do
        if unitList[i].id == data.unit.id then
            unitList[i].userList = data.unit.userList
            GlobalState.unitList = unitList
            TriggerClientEvent('dusa_dispatch:UpdateUnit', -1, GlobalState.unitList)
            break
        end
    end

    if data.user.gameId then
        if action == 'join' then
            TriggerClientEvent('unit:client:connectPlayerToGps', data.user.gameId, data.unit.name)
            Utils.notify(data.user.gameId, locale('unit_joined', data.unit.name), 'success')
        else
            TriggerClientEvent('police:client:DisconnectGps', data.user.gameId)
            Utils.notify(data.user.gameId, locale('unit_left', data.unit.name), 'error')
        end
    end
end
RegisterServerEvent('dusa_dispatch:joinUnit', Unit.UpdateUnit)
RegisterServerEvent('dusa_dispatch:leaveUnit', Unit.UpdateUnit)

return Unit