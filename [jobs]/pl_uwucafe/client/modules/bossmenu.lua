local Framework = GetFramework()
if Framework == "esx" then
    ESX = exports[Config.FrameworkResources.esx.resource][Config.FrameworkResources.esx.export]()
end
local shopOpen = false
function ShopBossMenu()
    lib.callback('pl_uwucafe:getShopStatus', false, function(isOpen)
        shopOpen = isOpen
        openBossMenu() 
    end)
end

function openBossMenu()
    local options = {}

    local shopStatusLabel = shopOpen and Locale("bossmenu_close") or Locale("bossmenu_open")
    local shopStatusDescription = shopOpen
        and Locale("bossmenu_close_description")
        or Locale("bossmenu_open_description")

    table.insert(options, {
        title = shopStatusLabel,
        description = shopStatusDescription,
        icon = shopOpen and 'fa-solid fa-door-closed' or 'fa-solid fa-door-open',
        onSelect = function()
            shopOpen = not shopOpen
            TriggerServerEvent('pl_uwucafe:toggleShopStatus', shopOpen)
            lib.notify({
                title = 'Shop Status',
                description = shopOpen and Locale("bossmenu_shop_opened") or Locale("bossmenu_shop_closed"),
                type = shopOpen and 'success' or 'error'
            })
            Wait(200)
            openBossMenu()
        end
    })

    table.insert(options, {
        title = Locale("bossmenu_shop_management"),
        description = Locale("bossmenu_shop_management_description"),
        icon = 'fa-solid fa-clipboard-list',
        onSelect = function()
            BossMenuResource()
        end
    })

    lib.registerContext({
        id = 'shop_boss_menu',
        title = Locale("bossmenu_shop_menu"),
        description = Locale("bossmenu_shop_menu_description"),
        options = options
    })

    lib.showContext('shop_boss_menu')
end

local ResourceBossMenu = GetBossMenu()

function BossMenuResource()
    if ResourceBossMenu == 'esx_society' then
        TriggerEvent('esx_society:openBossMenu', Config.Jobname, function (menu)
	    ESX.CloseContext()
        end, {wash = false,}) 
     elseif ResourceBossMenu == 'qb-management' then
        TriggerEvent("qb-bossmenu:client:OpenMenu")
    elseif ResourceBossMenu == 'qbx_management' then
        exports.qbx_management:OpenBossMenu('job')
    elseif ResourceBossMenu == 'vms_bossmenu' then
        exports['vms_bossmenu']:openBossMenu(Config.Jobname, 'job')
    end
end