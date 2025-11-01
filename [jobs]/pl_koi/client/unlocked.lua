local Framework = GetFramework()
if Framework == "esx" then
    ESX = exports[Config.FrameworkResources.esx.resource][Config.FrameworkResources.esx.export]()
elseif Framework == "qb" or Framework == "qbox"  then
    QBCore = exports[Config.FrameworkResources.qb.resource][Config.FrameworkResources.qb.export]()
end

function DoSkillCheck()
    if not Config.SkillCheck.Enable then return true end

    if Config.SkillCheck.Use == 'ox_lib' then
        return lib.skillCheck(Config.SkillCheck.Difficulty, Config.SkillCheck.Keys)

    elseif Config.SkillCheck.Use == 'lation_ui' then
        return exports.lation_ui:skillCheck(
            Config.SkillCheck.Lation.Title,
            Config.SkillCheck.Lation.Difficulties,
            Config.SkillCheck.Lation.Keys
        )
    end

    return false
end


function ProgressBar(label,duration,animDict,anim)
    
    if Config.Progressbar == 'qb' then
        QBCore.Functions.Progressbar(label, label, duration , false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,   
        }, {animDict = animDict, anim = anim}, {}, {}, function()
        end)
        Wait(duration)
        return true
    elseif Config.Progressbar == 'lation_ui' then
        exports.lation_ui:progressBar({
            label = label,
            duration = duration,
            icon = 'fas fa-hands-wash',
            iconColor = '#005DFF',
            color = '#005DFF',
            useWhileDead = false,
            disable = { 
                car = true,
                move = true,
                combat = true
            },
            anim = {
                dict = animDict,
                clip = anim
            },
        })
        return true
    elseif Config.Progressbar == 'ox_lib' then
        lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                car = true,
                combat = true,
                mouse = true,
            },
             anim = {
                dict = animDict,
                clip = anim
            },
        })
        return true
    elseif Config.Progressbar == 'ox_lib_circle' then
        lib.progressCircle({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                car = true,
                combat = true,
                mouse = true,
            },
            anim = {
                dict = animDict,
                clip = anim
            },
        })
        return true 
    end
end

function Duty()
    if GetResourceState('qb-core') == 'started' then
        TriggerServerEvent("QBCore:ToggleDuty")
    end
end

CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(Config.Blip.Coords)
        SetBlipSprite (blip, Config.Blip.Options.Sprite)
        SetBlipDisplay(blip, Config.Blip.Options.Display)
        SetBlipScale  (blip, Config.Blip.Options.Scale)
        SetBlipColour (blip, Config.Blip.Options.Color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.BlipName)
        EndTextCommandSetBlipName(blip)
    end
end)

function ClothMenu()
    local jobname = GetPlayerDataJob().name
    if jobname ~= Config.Jobname then return end

    local id = 'pl_koi:cloth_menu'
    local title = Locale("cloth_menu")
    local options = {
            {
                title = Locale("civilian_clothes"),
                description = Locale("switch_outfit_civilian"),
                icon = "fa-solid fa-user",
                onSelect = function()
                    OutfitMenu('civilian')
                end
            },
            {
                title = Locale("work_outfit"),
                description = Locale("switch_outfit_work"),
                icon = "fa-solid fa-briefcase",
                onSelect = function()
                    OutfitMenu('work')
                end
            }
        }
    ContextMenu(id,title,options,menu)
end

function OpenStash(name)
    OpenStashInventory(name)
end

function StashStorage()
    OpenStashInventory(Config.Jobname..'Storage')
end

function ShowCategories(stock)
    local categories = {}

    for category, _ in pairs(Config.Shop.Storage.items) do
        local categoryLabel = ''
        local categoryEmoji = '🧑‍🍳'

       if category == 'Seafoods' then
            categoryLabel = '🐟 Seafoods'
        elseif category == 'Drinks' then
            categoryLabel = '🥤 Drinks'
        elseif category == 'Steaks' then
            categoryLabel = '🥩 Steaks'
        elseif category == 'Desserts' then
            categoryLabel = '🍰 Desserts'
        elseif category == 'Chicken' then
            categoryLabel = '🍗 Chicken'
        elseif category == 'Beef' then
            categoryLabel = '🥩 Beef'
        elseif category == 'RiceNoodles' then
            categoryLabel = '🍜 Rice & Noodles'
        elseif category == 'PremadeBoxes' then
            categoryLabel = '🍱 Premade Boxes'
        else
            categoryLabel = category
        end


        table.insert(categories, {
            id = tostring(category):lower(),
            title = categoryLabel,
            onSelect = function (data)
                ShowCategoryItems(data)
            end,
            args = { category = category, itemstock = stock },
            arrow = true,
            description = string.format(Locale("fridge_menu"), category),
        })
    end
    local id = 'pl_koi:categories'
    local title = Locale("fridge_inventory")
    local options = categories
    local header = Locale("fridge_inventory_description")
    ContextMenu(id,title,options,menu,header)
end

RegisterNetEvent('pl_koi:returnStock')
AddEventHandler('pl_koi:returnStock', function(stock)
    ShowCategories(stock)
end)

function lookEnt(entity)
	if type(entity) == "vector3" then
		if not IsPedHeadingTowardsPosition(PlayerPedId(), entity, 10.0) then
			TaskTurnPedToFaceCoord(PlayerPedId(), entity, 1500)
		end
	end
end

function SendReactMessage(action, data)
    SendNUIMessage({
      action = action,
      data = data
    })
end

local function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end
RegisterNUICallback('hideFrame', function(data, cb)
    toggleNuiFrame(false)
end)
  
RegisterNetEvent('pl_koi:openShopUI')
AddEventHandler('pl_koi:openShopUI', function(data)
    SendNUIMessage({
        action = 'showUI',
        products = data
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('purchaseItems', function(data)
    local paymentMode
    if data.paymentMethod == 'cash' then
        paymentMode = "money"
    elseif data.paymentMethod == 'bank' then
        paymentMode = "bank"
    end
    TriggerServerEvent('pl_koi:handlePurchase', paymentMode, data.items)
end)

RegisterNetEvent('pl_koi:hideShopUI')
AddEventHandler('pl_koi:hideShopUI', function()
    SendNUIMessage({
        action = 'hideUI',
    })
    SetNuiFocus(false, false)
end)

function CashOrCard(type, itemName, label, itemAmount, price)
    local paymentOptions = {'Cash', 'Card'}
    if Config.EnableSocietyPayment then
        table.insert(paymentOptions, 'Society')
    end
    local id = 'payment_menu'
    local title = Locale("select_payment")
    local options = {
        {
            label = Locale("payment_method"),
            values = paymentOptions,
            description = Locale("payment_description")
        }
    }
    Menu(id,title,options,paymentOptions,itemName, label, itemAmount, price)
end
local currentShopStatus = false
local insideZone = false

local function checkAndShowTextUI()
    lib.callback('pl_koi:getShopStatus', false, function(isOpen)
        currentShopStatus = isOpen
        if isOpen then
            TextUIShow(Locale("shop_open_textui"), {
                icon = 'fa-solid fa-store',
                style = {
                    borderRadius = 4,
                    backgroundColor = 'FF117EFA',
                    color = '#ffffff'
                }
            })

        else
            TextUIShow(Locale("shop_close_textui"), {
                icon = 'fa-solid fa-ban',
                style = {
                    borderRadius = 4,
                    backgroundColor = '#8B0000',
                    color = '#ffffff'
                }
            })
        end
    end)
end

for _, coords in ipairs(Location.BuyMenu) do
    local box = lib.zones.box({
        coords = coords, 
        size = vec3(1, 1, 1),
        rotation = 45, 
        debug = Config.Debug.PolyZone, 
        onEnter = function()
            insideZone = true
            checkAndShowTextUI()
            CreateThread(function()
                while insideZone do
                    Wait(0)
                    if currentShopStatus and IsControlJustReleased(0, 38) then
                        TriggerServerEvent('pl_koi:requestShopData')
                    end
                end
            end)
        end,
        onExit = function()
            insideZone = false
            TextUIHide()
        end
    })
end

AddEventHandler('onResourceStop', function(resourceName)
    TextUIHide()
end)
