lib.versionCheck('Qbox-project/qbx_diving')
assert(lib.checkDependency('ox_lib', '3.20.0', true))

local logger = require '@qbx_core.modules.logger'
local config = require 'config.server'
local sharedConfig = require 'config.shared'
local currentAreaIndex = math.random(1, #sharedConfig.coralLocations)

---@type table<integer, true> Set of coralIndex
local pickedUpCoralIndexes = {}

local function resolveInventoryType()
    if GetResourceState('qs-inventory') == 'started' then
        return 'qs'
    elseif GetResourceState('ox_inventory') == 'started' then
        return 'ox'
    end
    return 'qb'
end

local inventoryType = resolveInventoryType()

local function getPlayer(src)
    return exports.qbx_core:GetPlayer(src)
end

local function getItemCount(src, player, item)
    if inventoryType == 'ox' then
        return exports.ox_inventory:GetItemCount(src, item) or 0
    end

    player = player or getPlayer(src)
    if not player or not player.Functions then return 0 end

    local itemData

    if player.Functions.GetItemByName then
        itemData = player.Functions.GetItemByName(item)
    end

    if (not itemData or not itemData.amount) and player.Functions.GetItemsByName then
        itemData = player.Functions.GetItemsByName(item)
    end

    if not itemData then
        return 0
    end

    if type(itemData.amount) == 'number' then
        return itemData.amount
    end

    if type(itemData) == 'table' then
        local total = 0
        for _, entry in pairs(itemData) do
            if entry and entry.amount then
                total += entry.amount
            end
        end
        return total
    end

    return 0
end

local function removeItem(src, player, item, amount)
    if amount <= 0 then return false end

    if inventoryType == 'ox' then
        return exports.ox_inventory:RemoveItem(src, item, amount)
    end

    player = player or getPlayer(src)
    if not player or not player.Functions or not player.Functions.RemoveItem then return false end

    return player.Functions.RemoveItem(item, amount)
end

local function addItem(src, player, item, amount)
    if amount <= 0 then return false end

    if inventoryType == 'ox' then
        return exports.ox_inventory:AddItem(src, item, amount)
    end

    player = player or getPlayer(src)
    if not player or not player.Functions or not player.Functions.AddItem then return false end

    return player.Functions.AddItem(item, amount)
end

local function getItemPrice(amount, price)
    for i = 1, #config.priceModifiers do
        local modifier = config.priceModifiers[i]
        local shouldModify = i == #config.priceModifiers and amount >= modifier.minAmount or
        amount >= modifier.minAmount and amount <= modifier.maxAmount
        if shouldModify then
            price = price / 100 * math.random(modifier.minPercentage, modifier.maxPercentage)
            break
        end
    end
    return price
end

RegisterNetEvent('qbx_diving:server:sellCoral', function()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return end
    local payout = 0

    for i = 1, #config.coralTypes do
        local coral = config.coralTypes[i]
        local count = getItemCount(src, player, coral.item)

        if count and count > 0 then
            if removeItem(src, player, coral.item, count) then
                local price = count * coral.price
                local reward = getItemPrice(count, price)
                payout += math.ceil(reward)
            end
        end
    end

    if payout == 0 then
        logger.log({
            source = src,
            event = 'qbx_diving:server:sellCoral',
            message = locale('logs.tried_sell'),
            webhook = config.discordWebhook,
        })
        return exports.qbx_core:Notify(locale('error.no_coral'), 'error')
    end

    logger.log({
        source = src,
        event = 'qbx_diving:server:sellCoral',
        message = locale('logs.sell_coral', payout),
        webhook = config.discordWebhook,
    })
    player.Functions.AddMoney('cash', payout, 'sold-coral')
end)

local function getNewLocation()
    local newLocation
    repeat
        newLocation = math.random(1, #sharedConfig.coralLocations)
    until newLocation ~= currentAreaIndex or #sharedConfig.coralLocations == 1
    return newLocation
end

RegisterNetEvent('qbx_diving:server:takeCoral', function(coralIndex)
    if pickedUpCoralIndexes[coralIndex] then return end
    local src = source
    local player = getPlayer(src)
    if not player then return end
    local coralType = config.coralTypes[math.random(1, #config.coralTypes)]
    local amount = math.random(1, coralType.maxAmount)

    if not addItem(src, player, coralType.item, amount) then return end
    pickedUpCoralIndexes[coralIndex] = true
    TriggerClientEvent('qbx_diving:client:coralTaken', -1, coralIndex)
    TriggerEvent('qbx_diving:server:coralTaken', sharedConfig.coralLocations[currentAreaIndex].corals[coralIndex].coords)

    logger.log({
        source = src,
        event = 'qbx_diving:server:takeCoral',
        message = locale('logs.collect_coral', coralIndex),
        webhook = config.discordWebhook,
    })

    if qbx.table.size(pickedUpCoralIndexes) == sharedConfig.coralLocations[currentAreaIndex].maxHarvestAmount then
        pickedUpCoralIndexes = {}
        currentAreaIndex = getNewLocation()
        TriggerClientEvent('qbx_diving:client:newLocationSet', -1, currentAreaIndex)
        logger.log({
            source = src,
            event = 'qbx_diving:server:takeCoral',
            message = locale('logs.new_location', currentAreaIndex),
            webhook = config.discordWebhook,
        })
    end
end)

---@return integer areaIndex
---@return table<integer, true> pickedUpCoralIndexes
lib.callback.register('qbx_diving:server:getCurrentDivingArea', function()
    return currentAreaIndex, pickedUpCoralIndexes
end)