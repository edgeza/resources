if not lib then return end

function client.OpenMenu()
    local fishlist  = ConvertFishlist()
    local shoplist  = ConvertShoplist()
    local tasklist  = ConvertTasklist()
    local infoList  = ConvertInfoList()
    local sellList  = ConvertSellList()
    local levelList = ConvertLevelList()

    Functions.Navigate('home')
    SendNUIMessage({
        action = 'SET_LIST',
        data = {fishList = fishlist, shopList = shoplist, taskList = tasklist, infoList = infoList, sellList = sellList, levelList = levelList}
    })
    local level     = GetCurrentLevel()
    local xp        = GetCurrentXP()
    local maxEXP    = config.levelSystem[level].xp
    local name      = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname
    local job       = Framework.Player.Job.Grade.Name
    local lastFish  = GetLatestFish()
    local rodLevel  = GetCurrentRodLevel()
    SendNUIMessage({
        action = 'SET_PROFILE',
        data = {level = level, rodLevel = rodLevel, xp = xp, maxEXP = maxEXP, name = name, job = job, lastFish = lastFish}
    })
    Wait(100)
    SendNUIMessage({
        action = 'SET_LANGUAGE',
        data = ui_locales
    })
end
RegisterNetEvent('dusa_fishing:OpenMenu', client.OpenMenu)

function client.CloseMenu()
    Functions.CUI()
end

function client.OpenMinigame()
    Functions.Navigate('miniGame')
end

function ConvertLevelList()
    local LEVELLIST = {}
    for k, v in pairs(config.levelSystem) do
        LEVELLIST[k] = {
            level = v.level,
            xp = v.xp,
            price = v.price
        }
    end
    return LEVELLIST
end