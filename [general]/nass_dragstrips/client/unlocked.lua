--[[
███╗   ██╗ █████╗ ███████╗███████╗    ██████╗ ██████╗  █████╗  ██████╗ ███████╗████████╗██████╗ ██╗██████╗ ███████╗
████╗  ██║██╔══██╗██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝
██╔██╗ ██║███████║███████╗███████╗    ██║  ██║██████╔╝███████║██║  ███╗███████╗   ██║   ██████╔╝██║██████╔╝███████╗
██║╚██╗██║██╔══██║╚════██║╚════██║    ██║  ██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║   ██╔══██╗██║██╔═══╝ ╚════██║
██║ ╚████║██║  ██║███████║███████║    ██████╔╝██║  ██║██║  ██║╚██████╔╝███████║   ██║   ██║  ██║██║██║     ███████║
╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝

https://discord.gg/nass
]]

local vehicles = {
    --["vehicle_model"] = "Vehicle Name",
    ["adder"] = "Adder",
}
function getVehicleName(vehicle)
    local spawnName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local labelText = GetLabelText(labelText)
    return vehicles[spawnName] or (labelText~="NULL" and labelText) or spawnName
end
runningTrees = {}
local lightPattern = {{1},{1,2},{3},{3,4},{3,4,5},{6}}
local oldlightPattern = {{1},{1,2},{1,2,3},{1,2,3,4},{5}}

local lightOffsets = { --Right side, inverted for left
    {pos=vector3(0.4, 0.45, 4.65), color = {255,255,0}}, -- Top Stage light
    {pos=vector3(0.4, 0.45, 4.05), color = {255,255,0}}, -- Bottom Stage light
    {pos=vector3(0.4, 0.45, 3.5), color = {255,255,0}}, -- Top Yellow light
    {pos=vector3(0.4, 0.45, 3.0), color = {255,255,0}}, -- Middle Yellow light
    {pos=vector3(0.4, 0.45, 2.55), color = {255,255,0}}, -- Bottom Yellow light
    {pos=vector3(0.4, 0.45, 2.1), color = {0,255,0}}, -- Green light
    {pos=vector3(0.4, 0.45, 1.65), color = {255,0,0}}, -- Red light
}

RegisterNetEvent('nass_dragstrips:startDragTreeCL')
AddEventHandler('nass_dragstrips:startDragTreeCL', function(stripData, left, right)
    if type(stripData) == "number" then 
        stripData = dragstrips[tostring(strip)]
    end

    if stripData.dragtreeType == "nass_dragtree" then
        basicDragTree(stripData)
        return
    end


    local dragTree = GetClosestObjectOfType(stripData.dragTree.x, stripData.dragTree.y, stripData.dragTree.z, 3.0, joaat(stripData.dragtreeType), false)
    if #(vector3(stripData.dragTree.x, stripData.dragTree.y, stripData.dragTree.z) - GetEntityCoords(PlayerPedId())) > Config.stripRenderDistance then return end
    runningTrees[stripData.id] = true
    local didBreak = false

    Wait(5)
    runningTrees[stripData.id] = false
    local step = 2
    CreateThread(function()
        Wait(2500)
        step = 3
        Wait(500)
        step = 4
        Wait(500)
        step = 5
        Wait(500)
        step = 6
        Wait(5000)
        if not didBreak then
            runningTrees[stripData.id] = true
        end
    end)

    while not runningTrees[stripData.id] do
        for _, v in pairs(lightPattern[step]) do
            local lightPositions = {}
            if right then
                table.insert(lightPositions, lightOffsets[v])
            end
            if left then
                local newOffset = nass.deepCopy(lightOffsets[v])
                newOffset.pos = vector3((newOffset.pos.x*(-1)), newOffset.pos.y, newOffset.pos.z)
                table.insert(lightPositions, newOffset)
            end
            
            for _, offset in ipairs(lightPositions) do
                local lightPos = GetOffsetFromEntityInWorldCoords(dragTree, offset.pos.x, offset.pos.y, offset.pos.z)
                DrawLightWithRange(lightPos.x, lightPos.y, lightPos.z, offset.color[1], offset.color[2], offset.color[3], 0.3, 500.0)
                local lightPosRev = GetOffsetFromEntityInWorldCoords(dragTree, offset.pos.x, (0-offset.pos.y), offset.pos.z)
                DrawLightWithRange(lightPosRev.x, lightPosRev.y, lightPosRev.z, offset.color[1], offset.color[2], offset.color[3], 0.3, 500.0)
            end
        end
        Wait(0)
    end
    didBreak = true
end)

RegisterNetEvent('nass_dragstrips:showDragTreeLight')
AddEventHandler('nass_dragstrips:showDragTreeLight', function(stripData, left, right, time)
    if type(stripData) == "number" then 
        stripData = dragstrips[tostring(stripData)]
    end

    if stripData.dragtreeType == "nass_dragtree" then return end

    local dragTree = GetClosestObjectOfType(stripData.dragTree.x, stripData.dragTree.y, stripData.dragTree.z, 3.0, joaat(stripData.dragtreeType), false)
    if #(vector3(stripData.dragTree.x, stripData.dragTree.y, stripData.dragTree.z) - GetEntityCoords(PlayerPedId())) > Config.stripRenderDistance then return end
    runningTrees[stripData.id] = true

    Wait(1)
    runningTrees[stripData.id] = false
    local didBreak = false
    local lightPositions = {}
    if right ~= nil then
        for k, v in pairs(right) do
            table.insert(lightPositions, lightOffsets[v])
        end
    end
    if left ~= nil  then
        for k, v in pairs(left) do
            local newOffset = nass.deepCopy(lightOffsets[v])
            newOffset.pos = vector3((newOffset.pos.x*(-1)), newOffset.pos.y, newOffset.pos.z)
            table.insert(lightPositions, newOffset)
        end
    end

    

    CreateThread(function()
        if time ~= nil and time == "forever" then return end
        Wait(time or 5000)
        if not didBreak then
            runningTrees[stripData.id] = true
        end
    end)

    while not runningTrees[stripData.id] do
        for _, offset in ipairs(lightPositions) do
            local lightPos = GetOffsetFromEntityInWorldCoords(dragTree, offset.pos.x, offset.pos.y, offset.pos.z)
            DrawLightWithRange(lightPos.x, lightPos.y, lightPos.z, offset.color[1], offset.color[2], offset.color[3], 0.3, 500.0)
            local lightPosRev = GetOffsetFromEntityInWorldCoords(dragTree, offset.pos.x, (0-offset.pos.y), offset.pos.z)
            DrawLightWithRange(lightPosRev.x, lightPosRev.y, lightPosRev.z, offset.color[1], offset.color[2], offset.color[3], 0.3, 500.0)
        end
        Wait(0)
    end
    didBreak = true
end)

function basicDragTree(stripData)
    local dragTree = GetClosestObjectOfType(stripData.dragTree.x, stripData.dragTree.y, stripData.dragTree.z, 3.0, joaat(stripData.dragtreeType), false)
    local topCoords = GetOffsetFromEntityInWorldCoords(dragTree, 0.0, -0.4, 2.95)
    if #(topCoords - GetEntityCoords(PlayerPedId())) < Config.stripRenderDistance then
        local destroyLights = false
        local step = 1
        CreateThread(function()
            Wait(3000)
            step = 2
            Wait(500)
            step = 3
            Wait(500)
            step = 4
            Wait(500)
            step = 5
            Wait(2000)
            destroyLights = true
        end)
        local intensity = 100.0
        local range = 0.3
        while not destroyLights do
            for k,v in pairs(oldlightPattern[step]) do
                if v == 1 then
                    DrawLightWithRange(topCoords.x, topCoords.y, topCoords.z+1.53, 255, 0,   0, range, intensity)
                elseif v == 2 then
                    DrawLightWithRange(topCoords.x, topCoords.y, topCoords.z+1.15, 255, 255, 0, range, intensity)
                elseif v == 3 then
                    DrawLightWithRange(topCoords.x, topCoords.y, topCoords.z+0.77, 255, 255, 0, range, intensity)
                elseif v == 4 then
                    DrawLightWithRange(topCoords.x, topCoords.y, topCoords.z+0.39, 255, 255, 0, range, intensity)
                elseif v == 5 then
                    DrawLightWithRange(topCoords.x, topCoords.y, topCoords.z+0.01, 0,   255, 0, range, intensity)
                end
            end
            Wait(0)
        end
    end
end