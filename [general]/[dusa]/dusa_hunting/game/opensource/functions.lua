Functions = {}

-- Color codes for pretty printing
local Colors = {
    Reset = '^0',
    Red = '^1',
    Green = '^2',
    Yellow = '^3',
    Blue = '^4',
    Magenta = '^5',
    Cyan = '^6',
    White = '^7',
    Gray = '^8',
    Orange = '^9'
}

local debugTypes = {
    ['createPed'] = true,
    ['cleanedUpAnimal'] = false,
    ['requestModel'] = false,
    ['weaponAim'] = true,
    ['removeAnimal'] = true
}

function DebugLog(message, type)
    if not Shared.Debug then return end
    if debugTypes[type] then
        print(Colors.Cyan .. '[DEBUG] ' .. Colors.Reset .. Colors.Yellow .. type .. Colors.Reset .. ': ' .. Colors.White .. message .. Colors.Reset)
    end
end

function Functions.HasLicense()
    return true
end

function Functions.IsHuntingWeapon(weapon)
    if not Config.OnlyHuntByHuntingWeapons then return true end
    
    -- Handle both string names and hash values
    local weaponToCheck = weapon
    if type(weapon) == 'number' then
        -- If weapon is a hash, convert it back to string for comparison
        for _, huntingWeapon in pairs(Config.HuntingWeapons) do
            if weapon == GetHashKey(huntingWeapon) then
                return true
            end
        end
    else
        -- If weapon is a string, do direct comparison
        for _, huntingWeapon in pairs(Config.HuntingWeapons) do
            if weapon == huntingWeapon then
                return true
            end
        end
    end
    
    return false
end

function Functions.GetCustomTitle()
    -- if you have any custom title system, you can return the title here
    return false
end

function Functions.randomFromTable(t)
    local index = math.random(1, #t)
    return t[index], index
end

local scenarios = {
    'WORLD_HUMAN_AA_COFFEE',
    'WORLD_HUMAN_AA_SMOKE',
    'WORLD_HUMAN_SMOKING'
}

-- Track created peds for cleanup
local createdPeds = {}

function Functions.createPed(coords, model, options)
    local ped, id
    lib.points.new({
        coords = coords.xyz,
        distance = 20.0,
        debugPoly = true,
        onEnter = function()
            lib.requestModel(model)
            ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
            SetEntityAlpha(ped, 0, false)
            SetEntityInvincible(ped, true)
            SetEntityProofs(ped, true, true, true, true, true, true, true, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedCanRagdoll(ped, false)
            SetPedCanBeTargetted(ped, false)
            SetPedCanBeTargettedByPlayer(ped, PlayerId(), false)
            SetEntityCanBeDamaged(ped, false)
            TaskStartScenarioInPlace(ped, Functions.randomFromTable(scenarios))

            -- Track the ped for cleanup
            table.insert(createdPeds, ped)

            -- Fade in ped model
            for i = 0, 255, 51 do
                SetEntityAlpha(ped, i, false)
                Wait(50)
            end
            SetEntityAlpha(ped, 255, false)
            if not options then return end

            AddEntityInteraction(ped, type(options) == 'table' and options[1] and options or {options})
        end,
        onExit = function()
            if DoesEntityExist(ped) then
                -- Remove from tracking table
                for i = #createdPeds, 1, -1 do
                    if createdPeds[i] == ped then
                        table.remove(createdPeds, i)
                        break
                    end
                end
                
                for i = 255, 0, -51 do
                    SetEntityAlpha(ped, i, false)
                    Wait(50)
                end
            end
            DeleteEntity(ped)
            SetModelAsNoLongerNeeded(model)
            ped = nil

            if id then
                id = nil
            end
        end
    })
end

-- Cleanup function for resource stop
function Functions.cleanupAllPeds()
    for i = #createdPeds, 1, -1 do
        local ped = createdPeds[i]
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
        table.remove(createdPeds, i)
    end
end

function Functions.GiveVehicleKeys(source, vehicle, plate)
    local model = GetEntityModel(vehicle)

    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports["dusa_vehiclekeys"]:GiveKeys(source, plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports.wasabi_carlock:GiveKey(source, plate)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        exports['qb-vehiclekeys']:GiveKeys(source, plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveServerKeys(source, plate, model)
    elseif GetResourceState('vehicles_keys') == 'started' then
        exports["vehicles_keys"]:giveVehicleKeysToPlayerId(source, plate)
    elseif GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:GiveKey(source, plate, false)
    elseif GetResourceState('Renewed-Vehiclekeys') == 'started' then
        exports['Renewed-Vehiclekeys']:addKey(source, plate)
    end
end

Functions.RemoveVehicleKeys = function(source, vehicle, plate, vehicleDisplayName)
    -- Integrate yours here ( for key system who using key as item )
    if GetResourceState('Renewed-Vehiclekeys') == 'started' then
        exports['Renewed-Vehiclekeys']:removeKey(source, plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        local vehicleModel = GetEntityModel(vehicle)
        exports['qs-vehiclekeys']:RemoveServerKeys(source, plate, vehicleDisplayName)
    end
end

function Functions.SpawnVehicle(params)
    local model = params.model
    local source = params.spawnSource
    local sourceType = type(source)
    local warp = params.warp
    local ped = type(warp) == 'number' and warp or (sourceType == 'number' and warp and source or nil)
    local props = params.props
    -- local bucket = params.bucket or ped and GetEntityRoutingBucket(ped) or nil

    ---@type vector4
    local coords
    if sourceType == 'vector3' then
        coords = vec4(source.x, source.y, source.z, 0)
    elseif sourceType == 'vector4' then
        coords = source
    else
        local pedCoords = GetEntityCoords(source)
        coords = vec4(pedCoords.x, pedCoords.y, pedCoords.z, GetEntityHeading(source))
    end    

    local tempVehicle = CreateVehicle(model, 0, 0, -200, 0, true, true)
    while not DoesEntityExist(tempVehicle) do Wait(0) end

    local vehicleType = GetVehicleType(tempVehicle)
    DeleteEntity(tempVehicle)

    local veh = CreateVehicleServerSetter(model, vehicleType, coords.x, coords.y, coords.z, coords.w)
    while not DoesEntityExist(veh) do Wait(0) end
    while GetVehicleNumberPlateText(veh) == '' do Wait(0) end

    -- if bucket and bucket > 0 then
    --     exports.qbx_core:SetEntityBucket(veh, bucket)
    -- end

    if ped then
        SetPedIntoVehicle(ped, veh, -1)
    end

    if not pcall(function()
            lib.waitFor(function()
                local owner = NetworkGetEntityOwner(veh)
                if ped then
                    --- the owner should be transferred to the driver
                    if owner == NetworkGetEntityOwner(ped) then return true end
                else
                    if owner ~= -1 then return true end
                end
            end, 'client never set as owner', 5000)
        end) then
        DeleteEntity(veh)
        error('Deleting vehicle which timed out finding an owner')
    end

    local state = Entity(veh).state
    state:set('initVehicle', true, true)

    if params.plate then
        SetVehicleNumberPlateText(veh, params.plate)
    end

    if props and type(props) == 'table' and props.plate then
        state:set('setVehicleProperties', props, true)
        if not pcall(function()
                lib.waitFor(function()
                    if Framework.Trim(GetVehicleNumberPlateText(veh)) == Framework.Trim(props.plate) then
                        return true
                    end
                end, 'Failed to set vehicle properties within 5 seconds', 5000)
            end) then
            DeleteEntity(veh)
            error('Deleting vehicle which timed out setting vehicle properties')
        end
    end

    local netId = NetworkGetNetworkIdFromEntity(veh)
    Entity(veh).state:set('persisted', true, true)

    return netId, veh
end

function dcd(data)
    if type(data) == 'string' then
        data = json.decode(data)Functions.RemoveVehicleKey = function(source, vehicle, plate)
    -- Integrate yours here ( for key system who using key as item )
end
    end
    return data
end

function t(tab)
    if IsDuplicityVersion() then
        print(Colors.Yellow .. '╔══════════════════════════════════════════════════════════════════╗' .. Colors.Reset)
        print(Colors.Yellow .. '║' .. Colors.Reset .. Colors.Cyan .. '                           DEBUG TABLE                           ' .. Colors.Reset .. Colors.Yellow .. '║' .. Colors.Reset)
        print(Colors.Yellow .. '╠══════════════════════════════════════════════════════════════════╣' .. Colors.Reset)
        print(Colors.White .. json.encode(tab, {indent = true}) .. Colors.Reset)
        print(Colors.Yellow .. '╚══════════════════════════════════════════════════════════════════╝' .. Colors.Reset)
    else
        print(Colors.Yellow .. '╔══════════════════════════════════════════════════════════════════╗' .. Colors.Reset)
        print(Colors.Yellow .. '║' .. Colors.Reset .. Colors.Cyan .. '                           DEBUG TABLE                           ' .. Colors.Reset .. Colors.Yellow .. '║' .. Colors.Reset)
        print(Colors.Yellow .. '╠══════════════════════════════════════════════════════════════════╣' .. Colors.Reset)
        print(Colors.White .. json.encode(tab, {indent = true}) .. Colors.Reset)
        print(Colors.Yellow .. '╚══════════════════════════════════════════════════════════════════╝' .. Colors.Reset)
        TriggerServerEvent('huntingdebug', tab)
    end
end

if IsDuplicityVersion() then
    RegisterServerEvent('huntingdebug', function(tab)
        t(tab)
    end)
end

function Functions.RemoveHuntingLaptopIfDisabled()
    -- Check if DUI laptop is disabled
    if not Shared.EnableDUILaptop then
        -- Remove hunting_laptop item from all shops
        if Shared.Shop and Shared.Shop.Items then
            for i, shopData in pairs(Shared.Shop.Items) do
                if shopData and shopData.item then
                    if shopData.item == 'hunting_laptop' then
                        print(Colors.Red .. '[WARNING] ' .. Colors.Reset .. Colors.Yellow .. 'Removing hunting_laptop from shop, because DUI laptop is disabled' .. Colors.Reset)
                        table.remove(Shared.Shop.Items, i)
                    end
                end
            end
        end
    end
end

-- Helper function to get inventory image path with webp/png support
-- This will check for .webp first, then fallback to .png
-- If neither exists, it defaults to .png
-- Users can override the extension in config (Shared.InventoryImageExtension)
function Functions.GetInventoryImage(itemName)
    local basePath = Bridge.InventoryImagePath

    -- Check if user has overridden the extension in config
    if Shared.InventoryImageExtension then
        return ('nui://%s%s.%s'):format(basePath, itemName, Shared.InventoryImageExtension)
    end

    if IsDuplicityVersion() then
        -- Server-side: Check actual file paths
        local resourceName = GetCurrentResourceName()

        -- Extract the inventory resource name from the path
        -- Example: "ox_inventory/web/images/" -> "ox_inventory"
        local inventoryResource = basePath:match("([^/]+)/")

        if inventoryResource then
            -- Try webp first
            local webpFile = LoadResourceFile(inventoryResource, basePath:gsub("nui://[^/]+/", "") .. itemName .. '.webp')
            if webpFile then
                return ('nui://%s%s.webp'):format(basePath, itemName)
            end

            -- Fallback to png
            local pngFile = LoadResourceFile(inventoryResource, basePath:gsub("nui://[^/]+/", "") .. itemName .. '.png')
            if pngFile then
                return ('nui://%s%s.png'):format(basePath, itemName)
            end
        end

        -- Default to png if nothing found
        return ('nui://%s%s.png'):format(basePath, itemName)
    else
        -- Client-side: We can't reliably check file existence
        -- So we return both paths and let the UI handle the fallback
        -- For now, default to png
        return ('nui://%s%s.png'):format(basePath, itemName)
    end
end

-- Cleanup all peds on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Functions.cleanupAllPeds()
    end
end)