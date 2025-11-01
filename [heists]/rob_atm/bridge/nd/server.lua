local bridge = {}
local NDCore = exports["ND_Core"]
local policeDepartments = {"sahp", "lspd", "bcso"}
local data_translate = require("data.translate")

function bridge.registerItem(item, cb)
    exports("use_item_"..item, function(event, item, inventory, slot, data)
        if event ~= "usingItem" then return end

        local canUse = cb(inventory.id)
        if not canUse then
            return false
        end
    end)
end

function bridge.addItem(src, item, count)
    if GetResourceState("ox_inventory") ~= "started" then return end
    exports.ox_inventory:AddItem(src, item, count)
end

function bridge.addMoney(src)
    local player = NDCore:getPlayer(src)
    if not player then return end

    local amount = math.random(100, 500)
    player.addMoney("cash", amount)

    player.notify({ title = ("You stole $%d"):format(math.floor(amount+0.5)) })
end

function bridge.getCopCount()
    local cops = 0
    local players = NDCore:getPlayers()

    for _, player in pairs(players) do
        for i=1, #policeDepartments do
            if player.groups[policeDepartments[i]] then
                cops += 1
            end
        end
    end
    
    return cops
end

function bridge.dispatch(location, coords, src)
    if GetResourceState("ND_MDT") ~= "started" then return end

    exports["ND_MDT"]:createDispatch({
        callDescription = data_translate["dispatch"],
        location = location,
        coords = coords
    })
end

return bridge
