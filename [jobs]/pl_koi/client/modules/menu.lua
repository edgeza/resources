local ImagesPath = require("client/modules/Imagespath")
local ItemDefinitions = require("shared/recipe")

local function CategoryMenuCrafting(categories)
    local options = {}
    for categoryName, categoryData in pairs(categories) do
        local categoryOption = {
            title = categoryData.label,
            description = string.format(Locale('menu_crafting'), categoryData.label),
            onSelect = function()
                OpenShopMake(categoryName)
              end,
            arrow = true,
            icon = ItemDefinitions.categories[categoryName].icon,
            metadata = {
                category = categoryName
            }
        }
        table.insert(options, categoryOption)
    end

    return options
end
local function ItemCrafting(itemList, category,workingcoords)
    local options = {}
    for itemName, itemData in pairs(itemList) do
        local label = itemData.label
        local image = '' .. itemName .. '.png'
        local requiredItems = ""
        for _, requiredItem in ipairs(itemData.required) do
            requiredItemDescription = requiredItem.item
            requiredItems = requiredItems .. requiredItem.quantity .. "x " .. requiredItem.label .. ", "
        end
        requiredItems = string.sub(requiredItems, 1, -3) 
        
        local description = string.format(Locale("menu_item_crafting"),label)
        if requiredItems ~= "" then
            description = string.format(Locale('menu_item_required_items'), description, requiredItems)
        end
        local option = {
            title = label,
            description = description,
            icon = 'nui://'..ImagesPath .. image,
            image = 'nui://'..ImagesPath .. image,
            onSelect = function()
                MenuCraftItem(itemName,label, category,workingcoords)
            end,
            metadata = {
                {label = 'name', value = label},
                {label = 'required', value = requiredItems},
            },
            args = {
                itemName = itemName,
                itemRequired = requiredItems,
            },
        }
        table.insert(options, option)
    end
    
    local id = 'pl_koi_categorymenumake'
    local title = Locale("menu_item_make")
    local menu = 'pl_koi_categorymenumake'
    local options = options
    ContextMenu(id,title,options,menu)
end
local function CategoryManagementMenu(itemData, ImagesPath, Config)
    local options = {}

    for itemName, itemInfo in pairs(itemData) do
        local label = itemInfo.label
        local image = itemName .. '.png'
        local itemStock = itemInfo.stock
        local itemPrice = itemInfo.price
        local maxStock = Config.MaxStock
        local stockPercent = math.min(itemStock, maxStock)
        local color = itemStock < 30 and 'red' or 'green'

        local option = {
            title = label,
            description = string.format(Locale('menu_management_item_description'), itemPrice, itemStock),
            icon = 'nui://' .. ImagesPath .. image,
            image = 'nui://' .. ImagesPath .. image,
            onSelect = function()
                ManagementInput(label, itemName, itemPrice, itemStock)
            end,
            metadata = {
                { label = 'Name', value = label },
                { label = 'Price', value = itemPrice .. '$' },
                { label = 'Stock', value = itemStock },
            },
            progress = stockPercent,
            colorScheme = color,
            args = {
                itemName = itemName,
                itemPrice = itemPrice,
            },
        }

        table.insert(options, option)
    end

    local id = 'pl_koi_manage'
    local title = Locale("menu_management")
    local menu = 'pl_koi_categorymenu'
    local options = options
    ContextMenu(id,title,options,menu)
end
local function ShopManagementMenu(categories)
    local options = {}
    for categoryName, categoryData in pairs(categories) do
        local categoryOption = {
            title = categoryData.label,
            description = string.format(Locale("menu_crafting"), categoryData.label),
            onSelect = function()
                TriggerServerEvent('pl_koi:GetItemDataManage',ItemDefinitions.categories[categoryName].items)
            end,
            arrow = true,
            icon = ItemDefinitions.categories[categoryName].icon,
            metadata = {
                category = categoryName
            }
        }
        table.insert(options, categoryOption)
    end
    return options
end
local function FridgeInventory(category, itemList, stock)
    local options = {}
    for _, itemData in pairs(itemList[category]) do
        local label = itemData.label
        local image = '' .. itemData.name .. '.png'
        local price = itemData.price
        local stockAmount = stock[itemData.name] or 0
        local option = {
            title = label,
            description = string.format(Locale('menu_item_buy_shop'),label,price,stockAmount),
            icon = 'nui://'..ImagesPath .. image,
            image = 'nui://'..ImagesPath .. image,
            onSelect = function (data)
                BuyInventory(data)
            end,
            metadata = {
                {label = 'name', value = label},
                {label = 'price', value = '' .. price .. '$'},
            },
            args = {
                itemName = itemData.name,
                itemLabel = label,
                itemprice = price,
            },
        }
        table.insert(options, option)
    end
    return options
end

function ContextMenu(id,title,options,menu,header)
    if Config.ContextMenu == 'ox_lib' then
        lib.registerContext({
            id = id,
            title = title,
            options = options,
            menu = menu or nil,
            header = header or nil,
            onBack = function()
            end,
        })
        lib.showContext(id)
    elseif Config.ContextMenu == 'lation_ui' then
        exports.lation_ui:registerMenu({
            id = id,
            title = title,
            options = options,
            menu = menu or nil,
            header = header or nil,
            onBack = function()
            end,
        })
        exports.lation_ui:showMenu(id)
    end
end
function Menu(id, title, options, paymentOptions, itemName, label, itemAmount, price)
    if Config.ContextMenu == 'ox_lib' then
        lib.registerMenu({
            id = 'payment_menu',
            title = Locale("select_payment"),
            position = 'top-right',
            options = {
                {
                    label = Locale("payment_method"),
                    values = paymentOptions,
                    description = Locale("payment_description")
                }
            },
            onClose = function()
                lib.hideMenu('payment_menu')
            end
        }, function(selected, scrollIndex)
            local paymentMode = 'money'
            if scrollIndex == 2 then
                paymentMode = 'bank'
            elseif Config.EnableSocietyPayment and scrollIndex == 3 then
                paymentMode = 'society'
            end
            TriggerServerEvent('pl_koi:Ingredientshop', paymentMode, itemName, label, itemAmount, price)
        end)
        lib.showMenu('payment_menu')

    elseif Config.ContextMenu == 'lation_ui' then
        local lationOptions = {}
        for index, value in ipairs(paymentOptions) do
            table.insert(lationOptions, {
                title = value.label or value,
                description = Locale("payment_description"),
                icon = 'fas fa-money-bill',
                onSelect = function()
                    local paymentMode = 'money'
                    if index == 2 then
                        paymentMode = 'bank'
                    elseif Config.EnableSocietyPayment and index == 3 then
                        paymentMode = 'society'
                    end
                    TriggerServerEvent('pl_koi:Ingredientshop', paymentMode, itemName, label, itemAmount, price)
                end
            })
        end

        exports.lation_ui:registerMenu({
            id = 'payment_menu',
            title = Locale("select_payment"),
            subtitle = Locale("payment_description"),
            onExit = function()
                exports.lation_ui:hideMenu('payment_menu')
            end,
            options = lationOptions
        })

        exports.lation_ui:showMenu('payment_menu')
    end
end


return {
    OpenCategoryMenuCrafting = CategoryMenuCrafting,
    OpenItemCrafting = ItemCrafting,
    OpenCategoryManagementMenu = CategoryManagementMenu,
    OpenShopManagementMenu = ShopManagementMenu,
    OpenFridgeInventory = FridgeInventory,
}
