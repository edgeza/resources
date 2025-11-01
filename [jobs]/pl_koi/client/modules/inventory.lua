
function OpenInventoryPS(stashName)
    TriggerEvent("ps-inventory:client:SetCurrentStash", stashName)
        TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", stashName, {
            maxweight = Config.TableWeight,
            slots = Config.TableSlot,
    })
end

function OpenInventory(stashName)
    TriggerEvent("inventory:client:SetCurrentStash", stashName)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
            maxweight = Config.TableWeight,
            slots = Config.TableSlot,
    })
end

function OpenStashInventory(stashName)
    if GetResourceState("qb-inventory") == "started" then
        if lib.checkDependency('qb-inventory', '2.0.0') then
            TriggerServerEvent("pl_koi:OpenInvNewQB",stashName)
        else
            OpenInventory(stashName)
        end
    elseif GetResourceState("qs-inventory") == "started" then
        OpenInventory(stashName)
    elseif GetResourceState("ps-inventory") == "started" then
        OpenInventoryPS(stashName)
    elseif GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:openInventory('stash', stashName)
    elseif GetResourceState("ak47_inventory") == "started" or GetResourceState("ak47_qb_inventory") == "started" then
        exports['ak47_inventory']:OpenInventory({
            identifier = stashName,
            label = Config.Blip.BlipName..stashName,
            type = 'stash',
            maxWeight = 120000,
            slots = 15,
        })
    elseif GetResourceState("codem-inventory") == "started" then
        TriggerServerEvent('codem-inventory:server:openstash', stashName, Config.TableSlot,Config.TableWeight, stashName)
    elseif GetResourceState("tgiann-inventory") == "started" then
        exports["tgiann-inventory"]:OpenInventory('stash', stashName)
    elseif GetResourceState("origen_inventory") == "started" then
        exports.origen_inventory:openInventory('stash',stashName)
    end 
end
