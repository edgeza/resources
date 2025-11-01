if not rawget(_G, "lib") then include('ox_lib', 'init') end

local fallbackModels = {
    leg = 'propk_redpanda_arm_raw',
    beef = 'propk_deer_beef_raw',
    rib = 'propk_deer_rib_raw',
    body = 'propk_pork_beef_big_raw',
}

-- Secure Controller
function SecureCheck(source, action)
    local Player = Framework.GetPlayer(source)
    if not Player then return false end

    if action == 'buy' then
        local shopCoords = Shared.Shop.Ped.coords
        local playerCoords = GetEntityCoords(GetPlayerPed(source))
        local distance = #(playerCoords - shopCoords.xyz)
        if distance > 10.0 then
            lib.print.error('[EXPLOITER WARNING] player is too far from shop (game id, name, identifier)',
                source, Player.Name, Player.Identifier)
            DropExploiter(source, 'Player tried to open shop too far from ped')
            return false
        end
    end

    return true
end

local huntingData = {}

CreateThread(function()
    for k, v in pairs(Shared.Species) do
        v.count = 0
        huntingData[k] = v
    end
end)


-- on player loaded, check database
-- update player hunting progress to huntingData
-- set huntingData to LocalPlayer.state.huntingData

-------------
--- SHOP
---

lib.callback.register('hunting:server:buyCart', function(source, cart, paymentMethod, price)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    if not SecureCheck(Source, 'buy') then return false end

    local money = Player.GetMoney(paymentMethod)
    if money < price then
        Framework.Notify(Source, locale('shop.not_enough_money'), 'error')
        return false
    end

    Player.RemoveMoney(paymentMethod, price, 'bought-hunting')

    for id, v in pairs(cart) do
        Framework.AddItem(Source, v.item, v.quantity or 1)
    end

    Framework.Notify(Source, locale('shop.paid', price), 'success')

    return true
end)

lib.callback.register('hunting:server:getSellList', function(source)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    local sellList = {}
    local sellListIndex = 1

    for id, item in pairs(Shared.Shop.Sell) do
        local hasItem = Framework.GetItem(Source, item.item)
        if hasItem then
            local basePrice = item.price

            -- Check if hasItem is a table (multiple items with different qualities) or single object
            local itemsToProcess = {}
            if type(hasItem) == 'table' and hasItem[1] then
                -- Multiple items with different metadata
                for _, invItem in ipairs(hasItem) do
                    if invItem.count > 0 then
                        table.insert(itemsToProcess, invItem)
                    end
                end
            else
                -- Single item
                if hasItem and hasItem.count and hasItem.count > 0 then
                    table.insert(itemsToProcess, hasItem)
                end
            end

            -- Group items by quality
            local qualityGroups = {}
            for _, invItem in ipairs(itemsToProcess) do
                local quality = 1 -- Default quality

                -- Check if item has quality metadata
                if invItem.metadata and invItem.metadata.quality then
                    quality = invItem.metadata.quality
                end

                -- Initialize quality group if not exists
                if not qualityGroups[quality] then
                    qualityGroups[quality] = {
                        count = 0,
                        quality = quality
                    }
                end

                -- Add count to quality group
                qualityGroups[quality].count = qualityGroups[quality].count + invItem.count
            end

            -- Create separate entries for each quality level
            for quality, groupData in pairs(qualityGroups) do
                if groupData.count > 0 then
                    -- Get quality multiplier from config
                    local qualityMultiplier = Shared.Shop.QualityMultipliers[quality] or 1.0
                    local itemPrice = math.floor(basePrice * qualityMultiplier)

                    -- Get item label from hasItem
                    local itemLabel = item.name -- Default to config name
                    if type(hasItem) == 'table' and hasItem[1] and hasItem[1].label then
                        itemLabel = hasItem[1].label
                    elseif hasItem and hasItem.label then
                        itemLabel = hasItem.label
                    end

                    table.insert(sellList, {
                        id = sellListIndex,
                        item = item.item,
                        name = itemLabel,
                        price = itemPrice,
                        quantity = groupData.count,
                        basePrice = basePrice,
                        quality = quality,
                        qualityInfo = {
                            hasQuality = true,
                            quality = quality,
                            qualityText = string.format("Quality %d", quality)
                        }
                    })

                    sellListIndex = sellListIndex + 1
                end
            end
        end
    end

    return sellList
end)

-- Sell items with quality-based pricing
lib.callback.register('hunting:server:sellItems', function(source, itemsToSell)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    if not SecureCheck(Source, 'sell') then return false end

    local totalEarnings = 0
    local soldItems = {}

    for _, sellData in pairs(itemsToSell) do
        local itemName = sellData.item
        -- local quantityToSell = sellData.quantity or 1
        -- local targetQuality = sellData.quality or 1 -- Get target quality from sell data

        -- Get item from player inventory
        local hasItem = Framework.GetItem(Source, itemName)
        local targetQuality = sellData.quality or 1
        local quantityToSell = sellData.quantity or 1

        -- 1. Uygun item(ler) var mı? (quality ve count kontrolü)
        local totalAvailable = 0
        local matchingItems = {}

        if type(hasItem) == "table" and hasItem[1] then
            for _, invItem in ipairs(hasItem) do
                local quality = invItem.metadata and invItem.metadata.quality or 1
                if quality == targetQuality and invItem.count > 0 then
                    totalAvailable = totalAvailable + invItem.count
                    table.insert(matchingItems, invItem)
                end
            end
        elseif hasItem then
            local quality = hasItem.metadata and hasItem.metadata.quality or 1
            if quality == targetQuality and hasItem.count and hasItem.count > 0 then
                totalAvailable = hasItem.count
                table.insert(matchingItems, hasItem)
            end
        end

        if totalAvailable < quantityToSell then
            -- Yeterli item yok, hata döndür
            goto continue
        end

        -- Find base price from shop config
        local basePrice = 0
        for _, shopItem in pairs(Shared.Shop.Sell) do
            if shopItem.item == itemName then
                basePrice = shopItem.price
                break
            end
        end
        if basePrice > 0 then
            local itemsProcessed = 0
            local totalItemPrice = 0
            for _, invItem in ipairs(matchingItems) do
                local toRemove = math.min(invItem.count, quantityToSell - itemsProcessed)
                if toRemove > 0 then
                    local qualityMultiplier = Shared.Shop.QualityMultipliers[targetQuality] or 1.0
                    local itemPrice = math.floor(basePrice * qualityMultiplier)
                    totalItemPrice = totalItemPrice + (itemPrice * toRemove)
                    itemsProcessed = itemsProcessed + toRemove
                    Framework.RemoveItem(Source, itemName, toRemove, invItem.metadata)
                end
                if itemsProcessed >= quantityToSell then break end
            end
            totalEarnings = totalEarnings + totalItemPrice
            table.insert(soldItems, {
                item = itemName,
                quantity = itemsProcessed,
                totalPrice = totalItemPrice,
                basePrice = basePrice,
                quality = targetQuality
            })
        end
        ::continue::
    end

    -- Add money to player
    if totalEarnings > 0 then
        Player.AddMoney('cash', totalEarnings, 'sold-hunting-items')

        -- Calculate XP based on quality and quantity
        local totalXpGained = 0
        local xpDetails = {}

        for _, soldItem in pairs(soldItems) do
            local xpGained = 0

            -- XP chance based on quality
            if soldItem.quality == 3 then
                -- Quality 3: 3-4 XP per 10 items with low chance
                local xpChance = math.random(1, 100)
                if xpChance <= 20 then -- 20% chance
                    local xpPerTenItems = math.random(3, 4)
                    xpGained = math.floor((soldItem.quantity / 10) * xpPerTenItems)
                    if soldItem.quantity >= 5 and soldItem.quantity < 10 then
                        -- Give partial XP for 5-9 items
                        if math.random(1, 100) <= 30 then
                            xpGained = math.random(1, 2)
                        end
                    end
                end
            elseif soldItem.quality == 2 then
                -- Quality 2: 1-2 XP per 10 items with lower chance
                local xpChance = math.random(1, 100)
                if xpChance <= 15 then -- 15% chance
                    local xpPerTenItems = math.random(1, 2)
                    xpGained = math.floor((soldItem.quantity / 10) * xpPerTenItems)
                    if soldItem.quantity >= 5 and soldItem.quantity < 10 then
                        -- Give partial XP for 5-9 items
                        if math.random(1, 100) <= 20 then
                            xpGained = 1
                        end
                    end
                end
            end
            -- Quality 1 items don't give XP

            if xpGained > 0 then
                totalXpGained = totalXpGained + xpGained
                table.insert(xpDetails, {
                    item = soldItem.item,
                    quality = soldItem.quality,
                    quantity = soldItem.quantity,
                    xp = xpGained
                })
            end
        end

        -- Add XP if any was gained
        if totalXpGained > 0 then
            local success, level, isLevelUp = exports.dusa_hunting:addExperience(Source, totalXpGained)
            if success then
                -- Notify about XP gain
                Framework.Notify(Source, string.format(locale('notifications.xp_gained', totalXpGained)), 'info')

                -- Notify about level up if it happened
                if isLevelUp then
                    Framework.Notify(Source, string.format(locale('notifications.level_up', level)), 'success', 5000)
                end
            end
        end

        Framework.Notify(Source, string.format(locale('notifications.sale_completed', totalEarnings)), 'success')

        return {
            success = true,
            totalEarnings = totalEarnings,
            soldItems = soldItems,
            xpGained = totalXpGained,
            xpDetails = xpDetails
        }
    else
        Framework.Notify(Source, locale('notifications.no_items_to_sell'), 'error')
        return {
            success = false,
            message = locale('notifications.no_items_to_sell')
        }
    end
end)

lib.callback.register('hunting:server:getIDCard', function(source)
    local player = Framework.GetPlayer(source)
    if not player then return false end

    local title = hunting[player.Identifier].title or 'beginner'

    local data = {
        name = player.Firstname .. ' ' .. player.Lastname,
        dob = player.DateOfBirth,
        exp = '12/08/2029',
        gender = player.Gender,
        class = locale(('title.%s'):format(title)),
        sign = player.Lastname,
        images = {
            logo = "../../../assets/logo.png",
            userImg = "../../../assets/user-img-2.png",
            barcode = "../../../assets/barcode.png",
        },
    }
end)

lib.callback.register('hunting:server:getMoneyAmount', function(source)
    local player = Framework.GetPlayer(source)
    if not player then return false end

    local bank = player.GetMoney('bank')
    local cash = player.GetMoney('cash')

    local financials = {
        bank = bank,
        cash = cash,
    }

    return financials
end)


-- ▀█▀ ▒█▄░▒█ ▀▀█▀▀ ▒█▀▀▀ ▒█▀▀█ ▒█░░▒█ ░█▀▀█ ▒█░░░ ▒█▀▀▀█
-- ▒█░ ▒█▒█▒█ ░▒█░░ ▒█▀▀▀ ▒█▄▄▀ ░▒█▒█░ ▒█▄▄█ ▒█░░░ ░▀▀▀▄▄
-- ▄█▄ ▒█░░▀█ ░▒█░░ ▒█▄▄▄ ▒█░▒█ ░░▀▄▀░ ▒█░▒█ ▒█▄▄█ ▒█▄▄▄█




---- CAMPFIRE
lib.callback.register('hunting:server:cookItem', function(source, item)
    local found = false
    local itemConfig = nil

    -- Search through Config.AnimalRewards to find the item
    for animalType, animalData in pairs(Config.AnimalRewards) do
        if animalData.meat and animalData.meat.parts then
            for partType, partData in pairs(animalData.meat.parts) do
                if partData.item == item then
                    found = true
                    itemConfig = partData
                    break
                end
            end
        end
        if found then break end
    end

    if not found then
        return warn('this item not found in Config.AnimalRewards')
    end

    local Player = Framework.GetPlayer(source)
    if not Player then return false end
end)

-- Get animal rewards with fallback logic
function getAnimalReward(animalType, meatType, quality)
    if not animalType or not meatType then
        return nil
    end

    -- Get animal config
    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig or not animalConfig.meat.parts[meatType] then
        return nil
    end

    local meatConfig = animalConfig.meat.parts[meatType]

    -- Use animal's custom model if available, otherwise use fallback model
    local model = meatConfig.model or fallbackModels[meatType]

    return {
        amount = meatConfig.amount,
        model = model,
        item = meatConfig.item -- Use the specific item name from the part config
    }
end

-- Get hide reward
function getHideReward(animalType, quality)
    if not animalType then
        return nil
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return nil
    end

    local hideConfig = animalConfig.hide
    if not hideConfig then
        return nil
    end

    return {
        amount = hideConfig.amount,
        item = 'hide' -- Use the hide item name from config
    }
end

-- Process animal kill and add items to player inventory
function processAnimalKill(source, animalType, quality)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return false
    end

    if not animalType then
        return false
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return false
    end

    local rewards = {}
    local totalItems = 0

    -- Process each meat type
    for meatType, meatConfig in pairs(animalConfig.meat.parts) do
        local reward = getAnimalReward(animalType, meatType, quality)
        if reward then
            -- Add item to player inventory
            local metadata = {
                quality = quality,
            }
            Framework.AddItem(source, reward.item, reward.amount, metadata)

            table.insert(rewards, {
                type = 'meat',
                item = reward.item,
                amount = reward.amount,
                model = reward.model
            })

            totalItems = totalItems + reward.amount
        end
    end

    -- Process hide
    local hideReward = getHideReward(animalType, quality)
    if hideReward then
        -- Add hide to player inventory
        local metadata = {
            hideType = animalType,
            quality = quality,
        }
        Framework.AddItem(source, hideReward.item, hideReward.amount, metadata)

        table.insert(rewards, {
            type = 'hide',
            item = hideReward.item,
            amount = hideReward.amount
        })

        totalItems = totalItems + hideReward.amount
    end

    -- Update quest progress for hunting
    exports['dusa_hunting']:UpdateQuestProgress(source, 'hunt', animalType, 1)

    -- Notify player
    if totalItems > 0 then
        Framework.Notify(source, string.format(locale('notifications.animal_killed', totalItems)),
            'success')
    end

    return rewards
end

-- Callback for client to trigger animal kill processing
lib.callback.register('hunting:server:processAnimalKill', function(source, animalType, quality)
    return processAnimalKill(source, animalType, quality)
end)

-- Get butchery objects based on animal type and quality
function getButcheryObjects(animalType, quality)
    if not animalType then
        return {}
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return {}
    end

    local objects = {}
    local totalObjects = 0

    -- Process each meat part
    for meatType, meatConfig in pairs(animalConfig.meat.parts) do
        local baseAmount = meatConfig.amount
        local qualityBonus = Config.IncreaseAmountByQuality and math.min(2, quality - 1) or 0
        local finalAmount = baseAmount + qualityBonus

        -- Use custom model if available, otherwise use fallback
        local model = meatConfig.model or fallbackModels[meatType]

        if model then
            for i = 1, finalAmount do
                table.insert(objects, {
                    model = model,
                    type = 'meat',
                    part = meatType,
                    delay = totalObjects * 2500 -- Stagger creation by 2.5 seconds each
                })
                totalObjects = totalObjects + 1
            end
        end
    end

    -- Process hide
    local hideConfig = animalConfig.hide
    if hideConfig then
        local baseAmount = hideConfig.amount
        local qualityBonus = Config.IncreaseAmountByQuality and math.min(2, quality - 1) or 0
        local finalAmount = baseAmount + qualityBonus

        for i = 1, finalAmount do
            table.insert(objects, {
                model = 'hei_prop_hei_paper_bag', -- Default hide model
                type = 'hide',
                part = 'hide',
                delay = totalObjects * 2500
            })
            totalObjects = totalObjects + 1
        end
    end

    return objects
end

-- Callback for client to get butchery objects
lib.callback.register('hunting:server:getButcheryObjects', function(source, animalType, quality)
    return getButcheryObjects(animalType, quality)
end)

-- Callback for client to add items based on animal type and part
lib.callback.register('hunting:server:addItemFromObject', function(source, animalType, part, quality)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return false
    end

    if not animalType then
        return false
    end

    if not part then
        return false
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return false
    end

    -- Handle hide items
    if part == 'hide' then
        local hideConfig = animalConfig.hide
        if hideConfig then
            local metadata = {
                hideType = animalType,
            }
            Framework.AddItem(source, 'hide', 1, metadata)
            Framework.Notify(source, string.format(locale('notifications.hide_added', animalType)), 'success')
            return true
        else
            return false
        end
    end

    -- Handle meat items
    local meatConfig = animalConfig.meat

    if meatConfig and meatConfig.parts then
        local availableParts = {}
        for k, v in pairs(meatConfig.parts) do
            table.insert(availableParts, k)
        end

        if meatConfig.parts[part] then
            local partConfig = meatConfig.parts[part]

            local metadata = {
                quality = quality,
            }
            local success = Framework.AddItem(source, partConfig.item, 1, metadata)

            if success then
                Framework.Notify(source, string.format(locale('notifications.default_item_added', partConfig.item)), 'success')
                return true
            else
                print('^1 [DEBUG] AddItem failed^0')
                return false
            end
        else
            print('^1 [DEBUG] Part not found in config:^0', part)
            return false
        end
    else
        print('^1 [DEBUG] meatConfig.parts not found^0')
        return false
    end
end)

-- Callback to add all butchered parts at once
lib.callback.register('hunting:server:addAllButcheredParts', function(source, animalType, quality)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return false
    end

    if not animalType then
        return false
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return false
    end

    local itemsAdded = 0

    -- Add hide if available
    local hideConfig = animalConfig.hide
    if hideConfig then
        local metadata = {
            hideType = animalType,
        }
        if Framework.AddItem(source, 'hide', 1, metadata) then
            itemsAdded = itemsAdded + 1
        end
    end

    -- Add all meat parts
    local meatConfig = animalConfig.meat
    if meatConfig and meatConfig.parts then
        for partName, partConfig in pairs(meatConfig.parts) do
            local metadata = {
                quality = quality,
            }
            if Framework.AddItem(source, partConfig.item, 1, metadata) then
                itemsAdded = itemsAdded + 1
            end
        end
    end

    if itemsAdded > 0 then
        Framework.Notify(source, string.format(locale('notifications.all_parts_collected', itemsAdded)), 'success')
        return true
    else
        Framework.Notify(source, locale('notifications.no_parts_to_collect'), 'error')
        return false
    end
end)

-- Callback for client to get animal config
lib.callback.register('hunting:server:getAnimalConfig', function(source)
    return Config.AnimalRewards
end)

-- Callback to get butchery parts for spawning objects
lib.callback.register('hunting:server:getButcheryParts', function(source, animalType, quality)
    if not animalType then
        return {}
    end

    local animalConfig = Config.AnimalRewards[animalType]
    if not animalConfig then
        return {}
    end

    local parts = {}

    -- Add hide if available
    local hideConfig = animalConfig.hide
    if hideConfig then
        table.insert(parts, {
            item = 'hide',
            partType = 'hide',
            model = 'hei_prop_hei_paper_bag',
            metadata = {
                hideType = animalType,
            }
        })
    end

    -- Add all meat parts
    local meatConfig = animalConfig.meat
    if meatConfig and meatConfig.parts then
        for partName, partConfig in pairs(meatConfig.parts) do
            table.insert(parts, {
                item = partConfig.item,
                partType = partName,
                model = partConfig.model or 'hei_prop_hei_paper_bag',
                metadata = {
                    quality = quality,
                }
            })
        end
    end

    return parts
end)

-- Callback to get player's inventory items that match Config.AnimalRewards parts
lib.callback.register('hunting:server:getPlayerInventoryItems', function(source)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return {}
    end

    local inventoryItems = {}

    -- Iterate through all animal types in Config.AnimalRewards
    for animalType, animalConfig in pairs(Config.AnimalRewards) do
        if animalConfig.meat and animalConfig.meat.parts then
            -- Check each meat part for the animal
            for partName, partConfig in pairs(animalConfig.meat.parts) do
                local itemName = partConfig.item
                local hasItem = Framework.GetItem(source, itemName)

                if hasItem then
                    local itemsToProcess = {}

                    -- Check if hasItem is a table (multiple items) or single object
                    if type(hasItem) == 'table' and hasItem[1] then
                        -- Multiple items
                        for _, item in ipairs(hasItem) do
                            if item.count > 0 then
                                table.insert(itemsToProcess, item)
                            end
                        end
                    else
                        -- Single item
                        if hasItem and hasItem.count and hasItem.count > 0 then
                            table.insert(itemsToProcess, hasItem)
                        end
                    end

                    -- Process all valid items
                    for _, item in ipairs(itemsToProcess) do
                        table.insert(inventoryItems, {
                            name = item.label,
                            item = itemName,
                            part = partName,
                            image = Functions.GetInventoryImage(itemName),
                            count = item.count,
                            cookingTime = 10, -- Default cooking time, can be customized per item
                        })
                    end
                end
            end
        end

        -- Check for hide items
        -- if animalConfig.hide then
        --     local hasHide = Framework.GetItem(source, 'hide')
        --     if hasHide then
        --         local hideItems = {}

        --         -- Check if hasHide is a table (multiple items) or single object
        --         if type(hasHide) == 'table' and hasHide[1] then
        --             -- Multiple hide items
        --             for _, hideItem in ipairs(hasHide) do
        --                 if hideItem.count > 0 then
        --                     local isFromThisAnimal = false
        --                     if hideItem.metadata and hideItem.metadata.hideType == animalType then
        --                         isFromThisAnimal = true
        --                     end

        --                     if isFromThisAnimal then
        --                         table.insert(hideItems, {
        --                             name = string.upper(animalType) .. ' HIDE',
        --                             item = animalType,
        --                             part = 'hide',
        --                             image = 'geyik',
        --                             count = hideItem.count,
        --                             cookingTime = 3,
        --                             itemName = 'hide',
        --                             quality = hideItem.metadata and hideItem.metadata.quality or 1
        --                         })
        --                     end
        --                 end
        --             end
        --         else
        --             -- Single hide item
        --             if hasHide and hasHide.count and hasHide.count > 0 then
        --                 local isFromThisAnimal = false
        --                 if hasHide.metadata and hasHide.metadata.hideType == animalType then
        --                     isFromThisAnimal = true
        --                 end

        --                 if isFromThisAnimal then
        --                     table.insert(hideItems, {
        --                         name = string.upper(animalType) .. ' HIDE',
        --                         item = animalType,
        --                         part = 'hide',
        --                         image = 'geyik',
        --                         count = hasHide.count,
        --                         cookingTime = 3,
        --                         itemName = 'hide',
        --                         quality = hasHide.metadata and hasHide.metadata.quality or 1
        --                     })
        --                 end
        --             end
        --         end

        --         -- Add all hide items to inventoryItems
        --         for _, hideItem in ipairs(hideItems) do
        --             table.insert(inventoryItems, hideItem)
        --         end
        --     end
        -- end
    end

    return inventoryItems
end)

-- Vehicle rental callback
lib.callback.register('hunting:server:rentVehicle', function(source)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then
        Framework.Notify(Source, locale('notifications.player_not_found'), 'error')
        return { success = false, message = locale('notifications.player_not_found') }
    end

    -- Check if player has enough money
    local money = Player.GetMoney('bank')
    local rentPrice = Shared.Rent.price

    if money < rentPrice then
        Framework.Notify(Source, locale('notifications.not_enough_money'), 'error')
        return { success = false, message = locale('notifications.not_enough_money') }
    end

    -- Remove money from player
    Player.RemoveMoney('bank', rentPrice, 'vehicle-rental')

    -- Get player coordinates
    local playerPed = GetPlayerPed(Source)

    -- Spawn vehicle on server
    local params = {
        model = Shared.Rent.vehicle,
        spawnSource = vector4(Shared.Rent.coords.x, Shared.Rent.coords.y, Shared.Rent.coords.z, Shared.Rent.heading),
        -- plate = 'HUNT' .. tostring(math.random(1000, 9999)),
        warp = playerPed -- Player server ID
    }

    local netId, vehicle = Functions.SpawnVehicle(params)

    -- vkey
    Functions.GiveVehicleKeys(source, vehicle, GetVehicleNumberPlateText(vehicle))

    if vehicle and DoesEntityExist(vehicle) then
        -- Mark vehicle as hunting rental with owner
        Entity(vehicle).state:set('huntingRental', true, true)
        Entity(vehicle).state:set('huntingRentalOwner', Source, true)

        Framework.Notify(Source, string.format(locale('notifications.vehicle_rented', rentPrice)), 'success')

        return {
            success = true,
            message = locale('notifications.vehicle_rented'),
            vehicle = {
                model = Shared.Rent.vehicle,
                netId = netId,
                entity = vehicle,
                price = rentPrice
            }
        }
    else
        -- Refund money if vehicle spawn failed
        Player.AddMoney('bank', rentPrice, 'vehicle-rental-refund')
        Framework.Notify(Source, locale('notifications.vehicle_spawn_failed'), 'error')

        return {
            success = false,
            message = 'Failed to spawn vehicle'
        }
    end
end)

-- Vehicle return callback
lib.callback.register('hunting:server:returnVehicle', function(source, vehicleNetId, vehicleDisplayName)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then
        Framework.Notify(Source, locale('notifications.player_not_found'), 'error')
        return { success = false, message = locale('notifications.player_not_found') }
    end

    -- Get vehicle entity from netId
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not vehicle or not DoesEntityExist(vehicle) then
        Framework.Notify(Source, locale('notifications.vehicle_not_found'), 'error')
        return { success = false, message = locale('notifications.vehicle_not_found') }
    end

    -- Check if this is a rented vehicle using entity state
    local isHuntingRental = Entity(vehicle).state.huntingRental
    local rentalOwner = Entity(vehicle).state.huntingRentalOwner

    if not isHuntingRental or rentalOwner ~= Source then
        Framework.Notify(Source, locale('notifications.not_rented_vehicle'), 'error')
        return { success = false, message = locale('notifications.not_rented_vehicle') }
    end

    local plate = GetVehicleNumberPlateText(vehicle)

    -- Remove vehicle keys
    Functions.RemoveVehicleKeys(source, vehicle, plate, vehicleDisplayName)

    -- Refund money to player
    local refundAmount = Shared.Rent.price
    Player.AddMoney('bank', refundAmount, 'vehicle-rental-refund')

    -- Delete the vehicle
    DeleteEntity(vehicle)

    -- Notify player
    Framework.Notify(Source, string.format(locale('notifications.vehicle_returned', refundAmount)), 'success')

    return {
        success = true,
        message = locale('notifications.vehicle_returned'),
        refundAmount = refundAmount
    }
end)

-- Check vehicle ownership callback
lib.callback.register('hunting:server:checkVehicleOwnership', function(source, vehicleNetId)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then
        return false
    end

    -- Get vehicle entity from netId
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not vehicle or not DoesEntityExist(vehicle) then
        return false
    end

    -- Check if this is a rented vehicle using entity state
    local isHuntingRental = Entity(vehicle).state.huntingRental
    local rentalOwner = Entity(vehicle).state.huntingRentalOwner

    if not isHuntingRental or rentalOwner ~= Source then
        return false
    end

    return true
end)

lib.callback.register('hunting:server:getCookingConfig', function(source, animal, part)
    if not Config.AnimalRewards[animal] or not Config.AnimalRewards[animal].meat or not Config.AnimalRewards[animal].meat.parts[part] then
        return nil
    end

    local partConfig = Config.AnimalRewards[animal].meat.parts[part]
    if not partConfig.cook then
        return nil
    end

    -- Use partConfig.model if available, otherwise use fallback model
    local rawModel = partConfig.model or fallbackModels[part]

    return {
        method = partConfig.cook.method,
        cookingTime = partConfig.cook.cookingTime,
        rawModel = rawModel,
        cookedModel = partConfig.cook.cookedModel
    }
end)

lib.callback.register('hunting:server:getCookingConfigByItem', function(source, itemName)
    -- Search through all animals and parts to find the item
    for animalName, animalConfig in pairs(Config.AnimalRewards) do
        if animalConfig.meat and animalConfig.meat.parts then
            for partName, partConfig in pairs(animalConfig.meat.parts) do
                -- Check if the item name matches the raw model (use fallback if model not specified)
                local rawModel = partConfig.model or fallbackModels[partName]
                if rawModel == itemName and partConfig.cook then
                    return {
                        method = partConfig.cook.method,
                        cookingTime = partConfig.cook.cookingTime,
                        rawModel = rawModel,
                        cookedModel = partConfig.cook.cookedModel,
                        animal = animalName,
                        part = partName
                    }
                end
            end
        end
    end

    return nil
end)

lib.callback.register('hunting:server:addCookedItem', function(source, data)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    -- Validate data
    if not data.item or not data.part or not data.count or data.count <= 0 then
        return false
    end

    -- Get cooking config to find the cooked item
    local cookingConfig = nil
    for animalName, animalConfig in pairs(Config.AnimalRewards) do
        if animalConfig.meat and animalConfig.meat.parts then
            for partName, partConfig in pairs(animalConfig.meat.parts) do
                local rawItem = partConfig.item
                if rawItem == data.item and partConfig.cook then
                    cookingConfig = partConfig
                    break
                end
            end
            if cookingConfig then break end
        end
    end

    if not cookingConfig or not cookingConfig.cook then
        Framework.Notify(Source, locale('notifications.invalid_cooking_configuration'), 'error')
        return false
    end

    -- Get the cooked item name from the cooking config
    local cookedItemName = cookingConfig.cook.cookedItem or cookingConfig.item .. '_cooked'

    -- Add the cooked item to player inventory
    local success = Framework.AddItem(Source, cookedItemName, data.count)

    if success then
        Framework.Notify(Source, string.format(locale('notifications.cooked_item_added', data.count, cookedItemName)),
            'success')
        return true
    else
        Framework.Notify(Source, locale('notifications.failed_to_add_cooked_item'), 'error')
        return false
    end
end)

lib.callback.register('hunting:server:removeRawItem', function(source, data)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    -- Validate data
    if not data.item or not data.count or data.count <= 0 then
        return false
    end

    -- Find the raw item in player inventory and remove it
    local hasItem = Framework.GetItem(Source, data.item)
    if not hasItem then
        Framework.Notify(Source, locale('notifications.item_not_found'), 'error')
        return false
    end

    -- Check if player has enough of the item
    local totalCount = 0
    if type(hasItem) == "table" and hasItem[1] then
        for _, invItem in ipairs(hasItem) do
            totalCount = totalCount + invItem.count
        end
    elseif hasItem and hasItem.count then
        totalCount = hasItem.count
    end

    if totalCount < data.count then
        Framework.Notify(Source, locale('notifications.not_enough_items'), 'error')
        return false
    end

    -- Remove the raw item from player inventory
    local success = Framework.RemoveItem(Source, data.item, data.count)

    if success then
        Framework.Notify(Source, string.format(locale('notifications.item_removed', data.count, data.item)), 'success')
        return true
    else
        Framework.Notify(Source, locale('notifications.failed_to_remove_item'), 'error')
        return false
    end
end)

lib.callback.register('hunting:server:returnRawItem', function(source, data)
    local Source = source
    local Player = Framework.GetPlayer(Source)
    if not Player then return false end

    -- Validate data
    if not data.item or not data.count or data.count <= 0 then
        return false
    end

    -- Add the raw item back to player inventory
    local success = Framework.AddItem(Source, data.item, data.count)

    if success then
        Framework.Notify(Source, string.format(locale('notifications.item_returned', data.count, data.item)), 'success')
        return true
    else
        Framework.Notify(Source, locale('notifications.failed_to_return_item'), 'error')
        return false
    end
end)

-- Server-side trap storage
local serverTraps = {}
local trapIdCounter = 0

-- Server event to add trap
RegisterNetEvent('hunting:server:addTrap', function(trapData)
    local source = source
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    -- Add unique ID to trap
    trapIdCounter = trapIdCounter + 1
    trapData.id = trapIdCounter

    -- Add trap to server storage
    table.insert(serverTraps, trapData)

    -- Sync only the new trap to all clients
    TriggerClientEvent('hunting:client:addTrap', -1, trapData)
end)

-- Server event to remove trap (deprecated - use callback instead)
RegisterNetEvent('hunting:server:removeTrap', function(trapId)
    local source = source
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    -- Find trap by ID
    local trapIndex = nil
    for i, trap in ipairs(serverTraps) do
        if trap.id == trapId then
            trapIndex = i
            break
        end
    end

    if not trapIndex then
        Framework.Notify(source, locale('notifications.trap_not_found'), 'error')
        return
    end

    -- Remove trap from server storage
    table.remove(serverTraps, trapIndex)

    -- Give trap item back to player
    local success = Framework.AddItem(source, 'hunting_trap', 1)

    if success then
        Framework.Notify(source, locale('notifications.trap_returned'), 'success')

        -- Notify all clients to remove this specific trap
        TriggerClientEvent('hunting:client:removeTrap', -1, trapId)
    else
        Framework.Notify(source, locale('notifications.failed_to_return_trap'), 'error')
    end
end)

-- Callback to get current traps for client
lib.callback.register('hunting:server:getTraps', function(source)
    return serverTraps
end)

-- Trap pickup callback (simplified)
lib.callback.register('hunting:server:pickupTrap', function(source, trapId)
    local Source = source
    local Player = Framework.GetPlayer(Source)

    if not Player then return false end

    -- Find trap by ID
    local trapIndex = nil
    for i, trap in ipairs(serverTraps) do
        if trap.id == trapId then
            trapIndex = i
            break
        end
    end

    if not trapIndex then
        Framework.Notify(Source, locale('notifications.trap_not_found'), 'error')
        return false
    end

    -- Remove trap from server storage
    table.remove(serverTraps, trapIndex)

    -- Give trap item back to player
    local success = Framework.AddItem(Source, 'hunting_trap', 1)

    if success then
        Framework.Notify(Source, locale('notifications.trap_returned'), 'success')

        -- Notify all clients to remove this specific trap
        TriggerClientEvent('hunting:client:removeTrap', -1, trapId)

        return true
    else
        Framework.Notify(Source, locale('notifications.failed_to_return_trap'), 'error')
        return false
    end
end)

-- UI Translations
local function LoadUITranslations()
    local locale = Shared.Locale or 'en'
    local localeFile = ('locales/%s.json'):format(locale)
    local file = LoadResourceFile(GetCurrentResourceName(), localeFile)
    if not file then
        return {}
    end

    local success, localeData = pcall(json.decode, file)
    if not success then
        return {}
    end

    return localeData.ui or {}
end

-- Load UI translations on resource start
local UITranslations = LoadUITranslations()

-- Send UI translations to client when player loads
function Framework.OnPlayerLoaded(source, player)
    -- Wait a bit for the client to be ready
    Wait(1000)

    -- Send UI translations to client
    TriggerClientEvent('dusa_hunting:setUITranslations', source, UITranslations)


    -- Set level properties
    OnPlayerLoadLevel(source)
end

-- Handle UI translations request from client
RegisterNetEvent('dusa_hunting:requestUITranslations', function()
    local source = source
    TriggerClientEvent('dusa_hunting:setUITranslations', source, UITranslations)
end)

-- Export function to reload translations
exports('reloadUITranslations', function()
    UITranslations = LoadUITranslations()

    -- Send updated translations to all clients
    local players = GetPlayers()
    for i = 1, #players do
        TriggerClientEvent('dusa_hunting:setUITranslations', players[i], UITranslations)
    end
end)

-- Check for MugShotBase64 dependency after 10 seconds
CreateThread(function()
    Wait(10000) -- Wait 10 seconds after resource start

    if GetResourceState('MugShotBase64') ~= 'started' then
        print('^3[DUSA HUNTING] ^6INFO: MugShotBase64 resource is not started.^0')
        print('^3[DUSA HUNTING] ^7MugShotBase64 is used for ID card avatars but is optional.^0')
        print('^3[DUSA HUNTING] ^7Without it, anonymous photos will be displayed on ID cards.^0')
        print('^3[DUSA HUNTING] ^4Download from: https://github.com/BaziForYou/MugShotBase64^0')
    end
end)
