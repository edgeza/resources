
local startped
local spawnedVehicle
local isVehicleSpawned = false

function isSpawnedVehicleNearby()
    if not spawnedVehicle or not DoesEntityExist(spawnedVehicle) then
        return false
    end
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicleCoords = GetEntityCoords(spawnedVehicle)
    local distance = #(playerCoords - vehicleCoords)
    if distance <= 15 then 
        return true, spawnedVehicle
    end
    return false, nil
end

function OpenDeliveryMenu()
    local id = 'delivery_menu'
    local title = Locale('delivery_menu')
    local options = {
            {
                title = Locale("delivery_menu_start"),
                description = Locale("delivery_menu_start_description"),
                icon = 'truck-fast',
                onSelect = function ()
                    if not isVehicleSpawned then
                        SpawnDeliveryVehicle()
                    else
                        Notify(Locale("delivery_vehicle_spawned"), 'error')
                    end
                end
            },
            {
                title = Locale("delivery_menu_return"),
                description = Locale("delivery_menu_return_description"),
                icon = 'fa fa-undo',
                onSelect = function()
                    local isNearby = isSpawnedVehicleNearby()
                    if isVehicleSpawned and isNearby then
                        DeleteDeliveryVehicle()
                        isVehicleSpawned = false
                    else
                        Notify( Locale("delivery_vehicle_nofound"), 'error')
                    end
                end
            }
        }
    ContextMenu(id,title,options)
end

function SpawnDeliveryVehicle()
    local vehicleModel = Config.Delivery.VehicleSpawn.model
    local vehiclecoords = Location.Delivery.VehicleSpawn
    RequestModel(GetHashKey(vehicleModel))
    while not HasModelLoaded(GetHashKey(vehicleModel)) do
        Wait(1)
    end
    spawnedVehicle = CreateVehicle(vehicleModel, vehiclecoords.x, vehiclecoords.y, vehiclecoords.z, Location.Delivery.VehicleHeading, true, false)
    SetVehicleNumberPlateText(spawnedVehicle, 'Delivery'..tostring(math.random(1000, 9999)))
    GiveKeys(spawnedVehicle)
    TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
    Fuel(spawnedVehicle)
    isVehicleSpawned = true
    TriggerServerEvent("pl_koi:generateOrders")
    Notify( Locale("delivery_order_command"), 'success')
end

function CreateDeliveryBlips(coords)
    JobBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(JobBlip, 1)
    SetBlipDisplay(JobBlip, 4)
    SetBlipScale(JobBlip, 0.8)
    SetBlipFlashes(JobBlip, true)
    SetBlipAsShortRange(JobBlip, true)
    SetBlipColour(JobBlip, 3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Customer')
    EndTextCommandSetBlipName(JobBlip)
end

function DeleteDeliveryVehicle()
    if spawnedVehicle and DoesEntityExist(spawnedVehicle) then
        DeleteVehicle(spawnedVehicle)
        spawnedVehicle = nil
        Notify(Locale("delivery_vehicle_returned"),'success')
    else
        Notify(Locale("delivery_vehicle_nofound"),'error')
    end
end

local isPedSpawned = false
local ResourceTarget = GetTarget()
function StartPoint()
    if not Config.Delivery.Enable then return end
    RequestModel(Config.Delivery.Ped.model)
    while not HasModelLoaded(Config.Delivery.Ped.model) do Wait(0) end
    startped = CreatePed(0, Config.Delivery.Ped.model, Location.Delivery.Ped.x, Location.Delivery.Ped.y, Location.Delivery.Ped.z - 1, Location.Delivery.Pedheading, false, false)
    FreezeEntityPosition(startped, true)
    SetEntityInvincible(startped, true)
    SetBlockingOfNonTemporaryEvents(startped, true)
    if ResourceTarget == 'ox_target' then
        exports.ox_target:addLocalEntity(startped,{
            name = 'start_delivery',
            label = Locale("delivery_interaction"),
            icon = 'fas fa-truck',
            onSelect = function ()
                OpenDeliveryMenu()
            end,
            groups = {[Config.Jobname] = 0},
            distance = 1.0
        })
    elseif ResourceTarget == 'qb-target' then
        exports['qb-target']:AddTargetEntity(startped, { 
            options = {
                {
                    icon = 'fas fa-truck',
                    label = Locale("delivery_interaction"),
                    action = function()
                        OpenDeliveryMenu()
                    end,
                    job = Config.Jobname,
                },
            }, 
            distance = 1.0, 
        })
    end
end

CreateThread(function()
    while true do
        Wait(2000)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distanceFromPed = #(Location.Delivery.Coords - playerCoords)

        if distanceFromPed < 200 and not isPedSpawned then
            isPedSpawned = true
            StartPoint()
        end

        if startped and distanceFromPed >= 200 and isPedSpawned then
            isPedSpawned = false
            DeletePed(startped)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if DoesEntityExist(startped) then
            DeleteEntity(startped)
        end
    end
end)


function displayActiveOrders(orders)
    local menuOptions = {}

    if not orders or #orders == 0 then
        table.insert(menuOptions, {
            title = Locale("delivery_no_active_orders"),
            description = Locale("delivery_no_active_orders_description"),
            icon = "fa-info-circle",
            iconColor = "gray",
        })
    else
        for _, order in pairs(orders) do
            local statusInfo = getStatusColor(order.status)

            local itemIcons = {
                ["seafoods"] = "🍔",
                ["drink"] = "🥤",
                ["chicken"] = "🍗",
            }

            local itemList = ""
            for _, item in ipairs(order.food) do
                local icon = "🔹"
                for keyword, emoji in pairs(itemIcons) do
                    if string.lower(item.label or item.name or ""):find(keyword) then
                        icon = emoji
                        break
                    end
                end
                itemList = itemList .. string.format("%s %s x%d\n", icon, item.label or item.name, item.quantity or 1)
            end

            table.insert(menuOptions, {
                title = "🧾 " .. order.customer,
                description = string.format(
                    "**🛍 Items:**\n%s\n**📍 Status:** %s\n**💵 Total:** $%d",
                    itemList,
                    order.status,
                    order.total
                ),
                icon = statusInfo.icon,
                iconColor = statusInfo.color,
                onSelect = function()
                    openOrderDetails(order)
                end
            })
        end
    end

    local id = 'active_orders_menu'
    local title = Locale("delivery_active_orders")
    local options = menuOptions
    ContextMenu(id,title,options)
end




function getStatusColor(status)
    local color, icon
    if status == "Pending" then
        color = "yellow"
        icon = "fa-clock"
    elseif status == "Accepted" then
        color = "green"
        icon = "fa-check-circle"
    elseif status == "Enroute" then
        color = "blue"
        icon = "fa-road"
    else
        color = "gray"
        icon = "fa-truck"
    end
    return { color = color, icon = icon }
end

function CreateDeliveryBlips(coords)
    JobBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(JobBlip, 1)
    SetBlipDisplay(JobBlip, 4)
    SetBlipScale(JobBlip, 0.8)
    SetBlipFlashes(JobBlip, true)
    SetBlipAsShortRange(JobBlip, true)
    SetBlipColour(JobBlip, 3)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Customer')
    EndTextCommandSetBlipName(JobBlip)
end
local activeOrder = nil
function openOrderDetails(order)
    local menuOptions = {}

    if order.status == "Pending" then
        table.insert(menuOptions, {
            title =Locale("delivery_accept_order"),
            description = Locale("delivery_accept_order_description"),
            icon = "fa-check",
            iconColor = "green",
            onSelect = function()
                TriggerServerEvent('pl_koi:acceptOrder', order)
                if Config.ContextMenu == 'ox_lib' then
                    lib.hideContext()
                elseif Config.ContextMenu == 'lation_ui' then
                    exports.lation_ui:hideMenu()
                end
            end
        })
        table.insert(menuOptions, {
        title =Locale("delivery_decline_order"),
        description = Locale("delivery_decline_order_description"),
        icon = "fa-times",
        iconColor = "red",
        onSelect = function() 
            TriggerServerEvent('pl_koi:declineOrder', order)
            if Config.ContextMenu == 'ox_lib' then
                lib.hideContext()
            elseif Config.ContextMenu == 'lation_ui' then
                exports.lation_ui:hideMenu()
            end
        end
    })
    elseif order.status == "Accepted" then
        table.insert(menuOptions, {
            title = Locale("delivery_order_enroute"),
            description = Locale("delivery_order_enroute_decription"),
            icon = "fa-road",
            iconColor = "blue",
            onSelect = function()
                activeOrder = order
                TriggerServerEvent('pl_koi:setOrderEnroute', order)
                setupZoneForDelivery(order.location,order.customer,order)
                SetNewWaypoint(order.location.x, order.location.y)
                CreateDeliveryBlips(order.location)
                if Config.ContextMenu == 'ox_lib' then
                    lib.hideContext()
                elseif Config.ContextMenu == 'lation_ui' then
                    exports.lation_ui:hideMenu()
                end
            end
        })
    end

    local id = 'order_details_menu_' .. order.customer
    local title = string.format(Locale("delivery_order_details"), order.customer)
    local options = menuOptions
    ContextMenu(id,title,options)
end

function setupZoneForDelivery(location, customer,order)
    local deliveryid = location
    local textUi = nil

    function onEnter(self)
        textUi = TextUIShow(Locale("delivery_order_textui"))
    end

    function onExit(self)
        TextUIHide()
        textUi = nil
    end

    function inside(self)
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent('pl_koi:deliverOrder', order)
            RemoveBlip(JobBlip)
            TextUIHide()
            self:remove() 
        end
    end

    local deliveryZone = lib.zones.box({
        coords = location,
        size = vector3(1, 1, 1),
        rotation = 0,
        debug = Config.Debug.PolyZone,
        inside = inside,
        onEnter = onEnter,
        onExit = onExit
    })
end

RegisterNetEvent('pl_koi:displayOrdersMenu')
AddEventHandler('pl_koi:displayOrdersMenu', function(orders)
    displayActiveOrders(orders)
end)

RegisterCommand('dinershoworders', function()
    TriggerServerEvent('pl_koi:getOrders')
end, false)









