local QBCore = nil
local ESX = nil

-- Initialize framework
Citizen.CreateThread(function()
    Wait(1000) -- Wait for framework to load
    
    if SDC.Framework == "qb-core" then
        QBCore = exports['qb-core']:GetCoreObject()
        if not QBCore then
            print("SDC_MetalDetector: Failed to get QBCore object")
        else
            print("SDC_MetalDetector: QBCore initialized successfully")
        end
    elseif SDC.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
        if not ESX then
            print("SDC_MetalDetector: Failed to get ESX object")
        else
            print("SDC_MetalDetector: ESX initialized successfully")
        end
    else
        print("SDC_MetalDetector: Invalid framework specified: " .. tostring(SDC.Framework))
    end
end)


function hasItem(src, item)
    if not src or not item then
        print("SDC_MetalDetector: Invalid parameters for hasItem - src: " .. tostring(src) .. ", item: " .. tostring(item))
        return false
    end
    
    if SDC.Framework == "qb-core" then
        if not QBCore then
            print("SDC_MetalDetector: QBCore not initialized")
            return false
        end
        
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then
            print("SDC_MetalDetector: Player not found for source: " .. tostring(src))
            return false
        end
        local inventoryItem = Player.Functions.GetItemByName(item)
        if inventoryItem then
            return true
        else
            return false
        end
    elseif SDC.Framework == "esx" then
        if not ESX then
            print("SDC_MetalDetector: ESX not initialized")
            return false
        end
        
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then
            print("SDC_MetalDetector: Player not found for source: " .. tostring(src))
            return false
        end
        local hasItem = xPlayer.hasItem(item)
        local foundItem = false

        foundItem = hasItem and hasItem.count > 0

        if not foundItem then
            for k, v in ipairs(xPlayer.loadout) do
                if item:upper() == v.name:upper() then
                    foundItem = true
                    break
                end
            end
        end

        return foundItem
    else
        print("SDC_MetalDetector: Invalid framework specified: " .. tostring(SDC.Framework))
        return false
    end
end

function removeAllOfItem(src, item)
    if not src or not item then
        print("SDC_MetalDetector: Invalid parameters for removeAllOfItem - src: " .. tostring(src) .. ", item: " .. tostring(item))
        return
    end
    
    if SDC.Framework == "qb-core" then
        if not QBCore then
            print("SDC_MetalDetector: QBCore not initialized")
            return
        end
        
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then
            print("SDC_MetalDetector: Player not found for source: " .. tostring(src))
            return
        end
        local inventoryItem = Player.Functions.GetItemByName(item)
        if inventoryItem then
            Player.Functions.RemoveItem(item, inventoryItem.amount)
        end
    elseif SDC.Framework == "esx" then
        if not ESX then
            print("SDC_MetalDetector: ESX not initialized")
            return
        end
        
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then
            print("SDC_MetalDetector: Player not found for source: " .. tostring(src))
            return
        end
        local hasItem = xPlayer.hasItem(item)
        local foundItem = false

        if hasItem then
            foundItem = true
            xPlayer.removeInventoryItem(item, hasItem.count)
        end

        if not foundItem then
            for k, v in ipairs(xPlayer.loadout) do
                if item:upper() == v.name:upper() then
                    xPlayer.removeWeapon(item)
                    break
                end
            end
        end
    else
        print("SDC_MetalDetector: Invalid framework specified: " .. tostring(SDC.Framework))
    end
end