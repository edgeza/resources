local bridge = {}
local ESX = exports["es_extended"]:getSharedObject()
local data_translate = require("data.translate")

function bridge.removePlayerItem(src, item)
    if GetResourceState("qs-inventory") == "started" then
        exports['qs-inventory']:RemoveItem(src, item, 1)
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeInventoryItem(item, 1)
    end
end

function bridge.registerItem(item, cb)
    if GetResourceState("ox_inventory") == "started" then
        exports("use_item_"..item, function(event, item, inventory, slot, data)
            if event ~= "usingItem" then return end
    
            local canUse = cb(inventory.id)
            if not canUse then
                return false
            end
        end)
    elseif GetResourceState("qs-inventory") == "started" then
        exports['qs-inventory']:CreateUsableItem(item, cb)
    else
        ESX.RegisterUsableItem(item, cb)
    end
end

function bridge.addItem(src, item, count)
    if GetResourceState("qs-inventory") == "started" then
        exports['qs-inventory']:AddItem(src, item, count)
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addInventoryItem(item, count)
    end
end

function bridge.addMoney(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local amount = math.random(100, 500)
    
    xPlayer.addMoney(amount)
    xPlayer.showNotification(("You stole $%d"):format(math.floor(amount+0.5)))
end

function bridge.getCopCount()
    local xPlayers = ESX.GetExtendedPlayers("job", "police")
    return #xPlayers
end

function bridge.dispatch(location, coords, src)
    if GetResourceState("cd_dispatch") == "started" then
        local dispatchData = {
            job_table = {"police"},
            coords = coords,
            title = data_translate["dispatch"],
            message = location,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            sound = 1,
            blip = {
                sprite = 459,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = data_translate["dispatch"],
                time = 5,
                radius = 0,
            }
        }

        TriggerClientEvent("cd_dispatch:AddNotification", -1, dispatchData)
    elseif GetResourceState("ps-dispatch") == "started" then
        local dispatchData = {
            message = data_translate["dispatch"],
            codeName = "susactivity",
            code = "10-66",
            icon = "fas fa-tablets",
            priority = 2,
            coords = coords,
            street = location,
            jobs = { "police" }
        }
    
        TriggerEvent("ps-dispatch:server:notify", dispatchData)
    elseif GetResourceState("qs-dispatch") == "started" then
        local dispatchData = {
            job = { "police", "sheriff", "traffic", "patrol" },
            callLocation = coords,
            callCode = { code = "1", snippet = "10-10" },
            message = data_translate["dispatch"],
            flashes = false,
            blip = {
                sprite = 459,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = data_translate["dispatch"],
                time = (20 * 1000),
            },
            otherData = {
                {
                    text = "Red Obscure",
                    icon = "fas fa-user-secret",
                }
            }
        }
        
        TriggerEvent("qs-dispatch:server:CreateDispatchCall", dispatchData)
    end
end

return bridge
