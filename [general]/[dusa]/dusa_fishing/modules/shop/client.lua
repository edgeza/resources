
Shop      = {}

if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end

RegisterNUICallback('closeMenu', function (data, cb)
    client.CloseMenu()
    cb('ok')
end)

function CalculateLeftXP(level)
    for k, v in pairs(config.levelSystem) do
        if v.level == level then
            local result = v.xp - GetCurrentXP()
            return result
        end
    end
    return 0
end

function GetLatestFish()
    local lastFish = LocalPlayer.state.lastFish or 'None'
    return lastFish
end

function GetCurrentRodLevel()
    -- check inventory item, if not exists return player level
    local rodLevel = LocalPlayer.state.rodLevel or 1
    return rodLevel
end

function ConvertFishlist() 
    local TABLE = config.fish
    local FISHLIST = {}
    for k, v in pairs(TABLE) do
        local img = ('nui://%s%s.png'):format(Bridge.InventoryImagePath, k)
        table.insert(FISHLIST, {
            name = v.label,
            description = v.description,
            type = v.type,
            typeLabel = v.typeLabel,
            -- price = 50,
            chance = v.chance,
            model = v.model,
            difficulty = v.difficulty,
            img = img,
            level = v.requiredLevel,
            rodLevel = v.requiredLevel
        })
    end

    table.sort(FISHLIST, function(a, b)
        local order = {
            ["common"] = 1,
            ["rare"] = 2,
            ["epic"] = 3,
            ["legendary"] = 4
        }
        return order[a.type] < order[b.type]
    end)

    return FISHLIST
end

function ConvertShoplist()
    local TABLE = config.shop
    local SHOPLIST = {}
    for k, v in pairs(TABLE) do
        local img = ('nui://%s%s.png'):format(Bridge.InventoryImagePath, v.itemCode)
        table.insert(SHOPLIST, {
            name = v.name,
            description = v.description,
            itemCode = v.itemCode,
            price = v.price,
            img = img,
            level = v.minLevel,
            type = v.type
        })
    end
    return SHOPLIST
end

function ConvertInfoList()
    local TABLE = config.infoList
    local INFOLIST = {}
    for k, v in pairs(TABLE) do
        table.insert(INFOLIST, {
            title = v.title,
            title2 = v.category,
            description = v.description
        })
    end
    return INFOLIST
end

function ConvertSellList()
    local TABLE = lib.callback.await('dusa_fishing:itemList', false)
    return TABLE
end

RegisterNUICallback('buyItem', function (data, cb)
    local buy = lib.callback.await('dusa_fishing:buyItem', false, data.cart, data.type)
    cb('ok')
end)

RegisterNUICallback('sellItem', function (data, cb)
    local sell = lib.callback.await('dusa_fishing:sellItem', false, data.cart)
    cb('ok')
end)

RegisterNUICallback('upgradeLevel', function (data, cb)
    local level = tonumber(data.level)
    Framework.Notify(locale('level_upgraded', level), 'success')
    TriggerServerEvent('dusa_fishing:upgradeLevel', level)
    cb('ok')
end)

-- TriggerServerEvent('dusa_fishing:upgradeLevel', amount)
-- TriggerServerEvent('dusa_fishing:addXP', amount)


return Shop