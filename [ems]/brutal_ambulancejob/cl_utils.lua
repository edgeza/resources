ESX = Core
QBCore = Core

-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(title, text, time, type)
    if Config.BrutalNotify then
        exports['brutal_notify']:SendAlert(title, text, time, type)
    else
        -- Put here your own notify and set the Config.BrutalNotify to false
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(0,1)

        -- Default ESX Notify:
        --TriggerEvent('esx:showNotification', text)

        -- Default QB Notify:
        --TriggerEvent('QBCore:Notify', text, 'info', 5000)

        -- OKOK Notify:
        -- exports['okokNotify']:Alert(title, text, time, type, false)

    end
end

function TextUIFunction(type, text)
    if type == 'open' then
        if Config.TextUI:lower() == 'ox_lib' then
            lib.showTextUI(text)
        elseif Config.TextUI:lower() == 'okoktextui' then
            exports['okokTextUI']:Open(text, 'darkblue', 'right')
        elseif Config.TextUI:lower() == 'esxtextui' then
            ESX.TextUI(text)
        elseif Config.TextUI:lower() == 'qbdrawtext' then
            exports['qb-core']:DrawText(text,'left')
        elseif Config.TextUI:lower() == 'brutal_textui' then
            exports['brutal_textui']:Open(text, "blue")
        end
    elseif type == 'hide' then
        if Config.TextUI:lower() == 'ox_lib' then
            lib.hideTextUI()
        elseif Config.TextUI:lower() == 'okoktextui' then
            exports['okokTextUI']:Close()
        elseif Config.TextUI:lower() == 'esxtextui' then
            ESX.HideUI()
        elseif Config.TextUI:lower() == 'qbdrawtext' then
            exports['qb-core']:HideText()
        elseif Config.TextUI:lower() == 'brutal_textui' then
            exports['brutal_textui']:Close()
        end
    end
end

function InventoryOpenFunction(type, data)
    if type == 'society' then
        local job = data
        local label = job:sub(1, 1):upper() .. job:sub(2):lower().." Stash"

        if Config.Inventory:lower() == 'ox_inventory' then
            exports.ox_inventory:openInventory('stash', {id = "stash_"..job})
        elseif Config.Inventory:lower() == 'qb_inventory' then
            if GetResourceState('qb-inventory') == "started" then
                TriggerServerEvent("brutal_ambulancejob:qb-inventory:server:OpenInventory", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
                TriggerEvent("inventory:client:SetCurrentStash", "stash_"..job)
            end
        elseif Config.Inventory:lower() == 'quasar_inventory' then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
            TriggerEvent("inventory:client:SetCurrentStash", "stash_"..job)
        elseif Config.Inventory:lower() == 'chezza_inventory' then
            TriggerEvent("inventory:openInventory", {type = "stash", id = "stash_"..job, title = label, weight = 100000, delay = 100, save = true})
        elseif Config.Inventory:lower() == 'core_inventory' then
            TriggerServerEvent("core_inventory:server:openInventory", "stash_"..job, "big_storage")
        elseif Config.Inventory:lower() == 'codem_inventory' then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
        elseif Config.Inventory:lower() == 'origen_inventory' then
            exports.origen_inventory:openInventory("stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
        elseif Config.Inventory:lower() == 'ps-inventory' then
            if GetResourceState('ps-inventory') == "started" then
                TriggerServerEvent("ps-inventory:server:OpenInventory", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
                TriggerEvent("ps-inventory:client:SetCurrentStash", "stash_"..job)
            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
                TriggerEvent("inventory:client:SetCurrentStash", "stash_"..job)
            end
        elseif Config.Inventory:lower() == 'tgiann-inventory' then
            exports["tgiann-inventory"]:OpenInventory("stash", "stash_"..job, {label = label, maxweight = 100000, slots = 100})
        end
    end
end

function ProgressBarFunction(time, text)
    if Config.ProgressBar:lower() == 'progressbars' then -- LINK: https://github.com/EthanPeacock/progressBars/releases/tag/1.0
        exports['progressBars']:startUI(time, text)
    elseif Config.ProgressBar:lower() == 'mythic_progbar' then -- LINK: https://github.com/HarryElSuzio/mythic_progbar
        TriggerEvent("mythic_progbar:client:progress", {name = "policejobduty", duration = time, label = text, useWhileDead = false, canCancel = false})
    elseif Config.ProgressBar:lower() == 'pogressbar' then -- LINK: https://github.com/SWRP-PUBLIC/pogressBar
        exports['pogressBar']:drawBar(time, text)
    end
end

function BossMenuFunction(job)
    if Config['Core']:upper() == 'ESX' then
        TriggerEvent('esx_society:openBossMenu', job, function(data) end, { wash = false })
    elseif Config['Core']:upper() == 'QBCORE' then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    end
end    

AddEventHandler('brutal_ambulancejob:client:onPlayerDeath', function()
    -- this event run when the player died.

    --exports['qs-smartphone']:canUsePhone(false)
    --exports["lb-phone"]:ToggleDisabled(true)
end)

AddEventHandler('brutal_ambulancejob:revive', function()
    -- this event run when the player revived.

    --exports['qs-smartphone']:canUsePhone(true)
    --exports["lb-phone"]:ToggleDisabled(false)

    if Config['Core']:upper() == 'ESX' then
        TriggerEvent('esx_basicneeds:resetStatus')
    elseif Config['Core']:upper() == 'QBCORE' then
        TriggerServerEvent("hospital:server:resetHungerThirst")
    end
end)

AddEventHandler('brutal_ambulancejob:server:heal', function()
    -- this event run when the player healed.

    if Config['Core']:upper() == 'ESX' then
        TriggerEvent('esx_basicneeds:resetStatus')
    elseif Config['Core']:upper() == 'QBCORE' then
        TriggerServerEvent("hospital:server:resetHungerThirst")
    end
end)

RegisterNetEvent('txcl:heal', function()
    TriggerEvent('brutal_ambulancejob:revive')
end)

RegisterNetEvent('brutal_ambulancejob:client:ReviveKeyPressed')
AddEventHandler('brutal_ambulancejob:client:ReviveKeyPressed', function()
    -- this event runs when the player presses the get help button on the death screen

end)

function CustomMDT()
    -- You can open another MDT here
end

function OpenCloakroomMenuEvent()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end

function CitizenWear()
    if Config['Core']:upper() == 'ESX' then
        Core.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    elseif Config['Core']:upper() == 'QBCORE' then
       TriggerServerEvent('qb-clothes:loadPlayerSkin')
    end
end

function setUniform(uniformTable)
    if Config['Core']:upper() == 'ESX' then
        TriggerEvent('skinchanger:getSkin', function(skin)
            local uniform
            if skin.sex == 0 then
                uniform = uniformTable.male
            else
                uniform = uniformTable.female
            end

            local table = {}

            for k,v in pairs(uniform) do
                if k == 't-shirt' then
                    table.tshirt_1 = uniform['t-shirt'].item
                    table.tshirt_2 = uniform['t-shirt'].texture
                elseif k == 'torso2' then
                    table.torso_1 = uniform['torso2'].item
                    table.torso_2 = uniform['torso2'].texture
                elseif k == 'decals' then
                    table.decals_1 = uniform['decals'].item
                    table.decals_2 = uniform['decals'].texture
                elseif k == 'arms' then
                    table.arms = uniform['arms'].item
                elseif k == 'pants' then
                    table.pants_1 = uniform['pants'].item
                    table.pants_2 = uniform['pants'].texture
                elseif k == 'shoes' then
                    table.shoes_1 = uniform['shoes'].item
                    table.shoes_2 = uniform['shoes'].texture
                elseif k == 'hat' then
                    table.helmet_1 = uniform['hat'].item
                    table.helmet_2 = uniform['hat'].texture
                elseif k == 'accessory' then
                    table.chain_1 = uniform['accessory'].item
                    table.chain_2 = uniform['accessory'].texture
                elseif k == 'ear' then
                    table.ears_1 = uniform['ear'].item
                    table.ears_2 = uniform['ear'].texture
                elseif k == 'mask' then
                    table.mask_1 = uniform['mask'].item
                    table.mask_2 = uniform['mask'].texture
                end
            end

            TriggerEvent('skinchanger:loadClothes', skin, table)
        end)
    elseif Config['Core']:upper() == 'QBCORE' then
        local table = {}
        local gender = QBCore.Functions.GetPlayerData().charinfo.gender
        if gender == 0 then
            table.outfitData = uniformTable.male
        else
            table.outfitData = uniformTable.female
        end

        TriggerEvent('qb-clothing:client:loadOutfit', table)
    end
end

function DisableMinimap()
    DisplayRadar(false)
end

function EnableMinimap()
    DisplayRadar(true)
end

function OpenMenuUtil()
    InMenu = true
    SetNuiFocus(true, true)

    Citizen.CreateThread(function()
        while InMenu do
            N_0xf4f2c0d4ee209e20() -- it's disable the AFK camera zoom
            Citizen.Wait(15000)
        end 
    end)

    DisplayRadar(false)
end

function CloseMenuUtil()
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        InMenu = false
    end)

    SetNuiFocus(false, false)

    DisplayRadar(true)
end

function GenerateAmbulancePlace()
    return string.sub(PlayerData.job.label, 1, 4)..''..math.random(0001, 9999)
end

-----------------------| UTILS TRIGGERS |-----------------------

RegisterNetEvent('brutal_ambulancejob:client:utils:CreateVehicle')
AddEventHandler('brutal_ambulancejob:client:utils:CreateVehicle', function(Vehicle)
    local plate = GetVehicleNumberPlateText(Vehicle)
    
    SetVehicleFuelLevel(Vehicle, 100.0)
    DecorSetFloat(Vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(Vehicle))

    if Config.BrutalKeys and GetResourceState("brutal_keys") == "started" then 
        exports.brutal_keys:addVehicleKey(plate, plate) 
    end	

    if Config['Core']:upper() == 'QBCORE' then
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(Vehicle))
    end
end)

RegisterNetEvent('brutal_ambulancejob:client:utils:DeleteVehicle')
AddEventHandler('brutal_ambulancejob:client:utils:DeleteVehicle', function(Vehicle)
    local plate = GetVehicleNumberPlateText(Vehicle)

    if Config.BrutalKeys and GetResourceState("brutal_keys") == "started" then 
		exports.brutal_keys:removeKey(plate, true) 
	end	
end)