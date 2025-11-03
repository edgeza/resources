----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = exports['qb-core']:GetCoreObject()
local TargetName = Config.CoreSettings.TargetName
local MenuName = Config.CoreSettings.MenuName
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Local state for spawned props to avoid global collisions with other resources
local SpawnedQuarryLights = {}
local SpawnedMineLights = {}
local SpawnedQuarryTargets = {}
local SpawnedQuarryCaveTargets = {}
local SpawnedMineTargets = {}
local SpawnedJewelBenches = {} -- Track created jewel bench zones to avoid removal warnings
local SpawnedPaydirt = {}
local SpawnedBlastRocks = {}
local ActiveQuarryMarkers = {}
local ActiveQuarryCaveMarkers = {}
local ActiveMineMarkers = {}
local isDiggingPaydirt = false
local PaydirtPositions = {}

-- quick inventory helper (client precheck; server re-validates)
local function playerHasItem(itemName)
    if not itemName or itemName == '' then 
        print('^1[boii-mining] Debug: No item name provided to playerHasItem')
        return false 
    end
    
    print('^6[boii-mining] Debug: Checking inventory for item: ' .. tostring(itemName))
    
    -- Try QBX export first (recommended for QBox)
    if exports.qbx_core then
        local success, hasItem = pcall(function()
            return exports.qbx_core:HasItem(itemName, 1)
        end)
        if success and hasItem ~= nil then 
            print('^6[boii-mining] Debug: QBX HasItem returned: ' .. tostring(hasItem))
            return hasItem 
        end
    end
    
    -- Fallback to manual inventory check
    local playerData = Core.Functions.GetPlayerData()
    if not playerData then 
        print('^1[boii-mining] Debug: No player data available')
        return false 
    end
    
    local inventory = playerData.items or playerData.inventory or {}
    if type(inventory) ~= 'table' then 
        print('^1[boii-mining] Debug: Inventory is not a table')
        return false 
    end
    
    print('^6[boii-mining] Debug: Checking ' .. #inventory .. ' inventory slots')
    
    for slot, item in pairs(inventory) do
        if item and item.name then
            print('^6[boii-mining] Debug: Slot ' .. tostring(slot) .. ': ' .. tostring(item.name) .. ' (amount: ' .. tostring(item.amount or item.count or 0) .. ')')
            if item.name == itemName and ((item.amount or item.count or 0) > 0) then
                print('^2[boii-mining] Debug: Found matching item!')
                return true
            end
        end
    end
    
    print('^1[boii-mining] Debug: Item not found in inventory')
    return false
end

-- helper to play an animation for a limited time
local function playTimedAnim(dict, anim, durationMs, flags)
    RequestAnimDict(dict)
    local tries=0
    while not HasAnimDictLoaded(dict) do
        tries=tries+1
        Wait(10)
        if tries>200 then break end
    end
    local ped = PlayerPedId()
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, durationMs, flags or 49, 0, false, false, false)
    Wait(durationMs)
    StopAnimTask(ped, dict, anim, 1.0)
end

-- robust delete for spawned marker objects (ensures network control and full cleanup)
local function safeDeleteMarker(handle)
    if not handle or handle == 0 or not DoesEntityExist(handle) then return end
    local tries = 0
    while not NetworkHasControlOfEntity(handle) and tries < 50 do
        tries = tries + 1
        Wait(10)
        NetworkRequestControlOfEntity(handle)
    end
    SetEntityAsMissionEntity(handle, true, true)
    DeleteEntity(handle)
    DeleteObject(handle)
end

-- remove jackhammer prop attached to ped (if any)
local function removeJackhammerProp(ped)
    local jackHash = GetHashKey('prop_tool_jackham')
    -- ensure local EnumerateObjects exists before use
    if not EnumerateObjects then return end
    for obj in EnumerateObjects() do
        if DoesEntityExist(obj) and IsEntityAttachedToEntity(obj, ped) then
            if GetEntityModel(obj) == jackHash then
                DeleteObject(obj)
            end
        end
    end
end

-- forward declare so it's in scope for functions defined above
local cleanupNearbyJackhammers
local forceDeleteEntity

--<!>-- NOTIFICATIONS --<!>--
-- Notifications
RegisterNetEvent('boii-mining:notify', function(msg, type)
    lib.notify({
        title = 'Mining',
        description = msg,
        type = type or 'info'
    })
end)
--<!>-- NOTIFICATIONS --<!>--

--<!>-- PROGRESS BAR HELPER --<!>--
local function showProgress(label, durationMs)
    lib.progressBar({
        duration = durationMs,
        label = label or 'Working...',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    })
end
--<!>-- PROGRESS BAR HELPER --<!>--

--<!>-- TARGET LOCK HELPERS --<!>--
local function setThirdEyeLocked(locked)
	-- Use ox_target
	pcall(function()
		if GetResourceState('ox_target') == 'started' then 
			exports['ox_target']:disableTargeting(locked) 
		end
	end)
end

local function setMiningBusy(isBusy)
	LocalPlayer.state:set('mining_busy', isBusy, true)
	setThirdEyeLocked(isBusy)
end
--<!>-- TARGET LOCK HELPERS --<!>--

--<!>-- BLIPS --<!>--
CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.useblip then
            v.blip = AddBlipForCoord(v['coords'].x, v['coords'].y, v['coords'].z)
            SetBlipSprite(v.blip, v.id)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, v.scale)
            SetBlipColour(v.blip, v.colour)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.title)
            EndTextCommandSetBlipName(v.blip)
        end
    end
end)
--<!>-- BLIPS --<!>--

--<!>-- PEDS --<!>--
CreateThread(function()
        for k, v in pairs(Config.Peds) do
        if v.useped then
            local mdl = GetHashKey(v.model)
            if mdl == 0 or mdl == nil then
                print('^1[boii-mining] Error: Invalid model name for ped: ' .. tostring(v.model))
                goto continue
            end
            RequestModel(mdl)
            local tries=0
            while not HasModelLoaded(mdl) and tries<400 do
                tries=tries+1
                Wait(5)
            end
            if not HasModelLoaded(mdl) then
                print('^1[boii-mining] Error: Failed to load model: ' .. tostring(v.model))
                goto continue
            end
            -- Double-check mdl is valid before CreatePed
            if not mdl or mdl == 0 then
                print('^1[boii-mining] Error: Model hash invalid before CreatePed: ' .. tostring(mdl))
                goto continue
            end
            MiningPeds = CreatePed(0, mdl, v['coords'].x, v['coords'].y, v['coords'].z-1, v['coords'].w, false, false)
            
            -- Validate that the ped was created successfully
            if MiningPeds and MiningPeds ~= 0 and DoesEntityExist(MiningPeds) then
                FreezeEntityPosition(MiningPeds, true)
                SetEntityInvincible(MiningPeds, true)
                SetBlockingOfNonTemporaryEvents(MiningPeds, true)
                TaskStartScenarioInPlace(MiningPeds, v.scenario, 0, true)
                
                -- Ensure ox_target is ready before adding entity zone
                local waitMs = 0
                while (GetResourceState(TargetName) ~= 'started') and waitMs < 5000 do
                    Wait(100)
                    waitMs = waitMs + 100
                end
                
                -- Add entity zone with proper error handling
                if GetResourceState(TargetName) == 'started' and exports[TargetName] and exports[TargetName].addLocalEntity then
                    local success, result = pcall(function()
                        return exports[TargetName]:addLocalEntity(MiningPeds, {
                            {
                                name = 'mining_peds'..MiningPeds,
                                icon = v.icon,
                                label = v.label,
                                onSelect = function()
                                    TriggerEvent(v.event)
                                end,
                                canInteract = function(entity)
                                    if IsPedDeadOrDying(entity, true) or IsPedAPlayer(entity) or IsPedInAnyVehicle(PlayerPedId()) then return false end
                                    return true
                                end,
                                distance = v.distance
                            }
                        })
                    end)
                    
                    if not success then
                        print('^1[boii-mining] Error adding entity zone for ped: ' .. tostring(result))
                    end
                else
                    print('^3[boii-mining] Warning: ox_target not ready or addLocalEntity export not available')
                end
            else
                print('^1[boii-mining] Error: Failed to create ped for ' .. (v.name or 'unknown'))
            end
            ::continue::
        end
    end
end)
--<!>-- PEDS --<!>--

--<!>-- LIGHTS --<!>--
CreateThread(function()
    for k, v in pairs(Config.Quarry.Mining.Lights) do
        local mdl=GetHashKey(v.model)
        RequestModel(mdl)
        local tries=0
        while not HasModelLoaded(mdl) and tries<400 do
            tries=tries+1
            Wait(5)
        end
        local QuarryLights = CreateObject(v.model, v['coords'].x, v['coords'].y, v['coords'].z, true, true, false)
        SetEntityHeading(QuarryLights, v['coords'].w)
        SetEntityInvincible(QuarryLights, true)
        SetBlockingOfNonTemporaryEvents(QuarryLights, true)
        FreezeEntityPosition(QuarryLights, true)
        PlaceObjectOnGroundProperly(QuarryLights)
        SpawnedQuarryLights[#SpawnedQuarryLights+1] = QuarryLights
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Mine.Caving.Lights) do
        local mdl=GetHashKey(v.model)
        RequestModel(mdl)
        local tries=0
        while not HasModelLoaded(mdl) and tries<400 do
            tries=tries+1
            Wait(5)
        end
        local MineLights = CreateObject(v.model, v['coords'].x, v['coords'].y, v['coords'].z, true, true, false)
        SetEntityHeading(MineLights, v['coords'].w)
        SetEntityInvincible(MineLights, true)
        SetBlockingOfNonTemporaryEvents(MineLights, true)
        FreezeEntityPosition(MineLights, true)
        PlaceObjectOnGroundProperly(MineLights)
        SpawnedMineLights[#SpawnedMineLights+1] = MineLights
    end
end)
--<!>-- LIGHTS --<!>--

--<!>-- SMELTING --<!>--
for k, v in pairs(Config.Smelting.Locations.Foundry) do
    exports[TargetName]:addSphereZone({
        coords = v.coords,
        radius = v.radius,
        options = {
            {
                name = v.name,
                icon = Language.Mining.Smelting.Target['icon'],
                label = Language.Mining.Smelting.Target['label'],
                onSelect = function()
                    TriggerEvent('boii-mining:cl:SmeltingMenu')
                end,
                distance = v.distance
            }
        }
    })
end

if Config.MLO.k4mb1_cave then
    for k, v in pairs(Config.Smelting.Locations.KambiCave) do
        exports[TargetName]:addSphereZone({
            coords = v.coords,
            radius = v.radius,
            options = {
                {
                    name = v.name,
                    icon = Language.Mining.Smelting.Target['icon'],
                    label = Language.Mining.Smelting.Target['label'],
                    onSelect = function()
                        TriggerEvent('boii-mining:cl:SmeltingMenu')
                    end,
                    distance = v.distance
                }
            }
        })
    end
end
--<!>-- SMELTING --<!>--

--<!>-- BLASTING MARKERS (X props) --<!>--
CreateThread(function()
    -- Quarry wall blasting markers
    if Config.Quarry and Config.Quarry.Mining and Config.Quarry.Mining.Prop and Config.Quarry.Mining.Locations then
        local model = GetHashKey(Config.Quarry.Mining.Prop.model)
        RequestModel(model)
        local tries=0
        while not HasModelLoaded(model) and tries<400 do
            tries=tries+1
            Wait(5)
        end
        for i, loc in ipairs(Config.Quarry.Mining.Locations) do
            local idx = i
            local lx, ly, lz, lw = loc.x, loc.y, loc.z, (loc.w or 0.0)
            -- create as local (non-networked) object
            local obj = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
            SetEntityHeading(obj, lw)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)
            PlaceObjectOnGroundProperly(obj)
            SpawnedQuarryTargets[#SpawnedQuarryTargets+1] = obj
            ActiveQuarryMarkers[i] = obj
            exports[TargetName]:addLocalEntity(obj, {
                {
                    name = 'quarry_marker_' .. idx,
                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                    onSelect = function(entity)
                        local index = idx
                        -- remove this target marker and respawn it after 90s
                        if entity and DoesEntityExist(entity) then
                            exports[TargetName]:removeLocalEntity(entity)
                            safeDeleteMarker(entity)
                        end
                        ActiveQuarryMarkers[index] = nil
                        SetTimeout(90000, function()
                            -- don't double-spawn if one already exists for this location
                            if ActiveQuarryMarkers[index] and DoesEntityExist(ActiveQuarryMarkers[index]) then return end
                            local new = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                            SetEntityHeading(new, lw)
                            SetEntityInvincible(new, true)
                            FreezeEntityPosition(new, true)
                            PlaceObjectOnGroundProperly(new)
                            ActiveQuarryMarkers[index] = new
                            exports[TargetName]:addLocalEntity(new, {
                                {
                                    name = 'quarry_marker_' .. index,
                                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                                    onSelect = function(e)
                                        local ent = ActiveQuarryMarkers[index]
                                        if ent and DoesEntityExist(ent) then
                                            exports[TargetName]:removeLocalEntity(ent)
                                            safeDeleteMarker(ent)
                                            ActiveQuarryMarkers[index] = nil
                                        end
                                        SetTimeout(90000, function()
                                            if ActiveQuarryMarkers[index] and DoesEntityExist(ActiveQuarryMarkers[index]) then return end
                                            local newer = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                                            SetEntityHeading(newer, lw)
                                            SetEntityInvincible(newer, true)
                                            FreezeEntityPosition(newer, true)
                                            PlaceObjectOnGroundProperly(newer)
                                            ActiveQuarryMarkers[index] = newer
                                            exports[TargetName]:addLocalEntity(newer, {
                                                {
                                                    name = 'quarry_marker_' .. index,
                                                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                                                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                                                    onSelect = function()
                                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Quarry' })
                                                    end,
                                                    distance = 2.0
                                                }
                                            })
                                        end)
                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Quarry' })
                                    end,
                                    distance = 2.0
                                }
                            })
                        end)
                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Quarry' })
                    end,
                    distance = 2.0
                }
            })
        end
    end
    -- Quarry cave blasting markers (only if cave MLO toggled)
    if Config.MLO.k4mb1_cave and Config.Quarry and Config.Quarry.Caving and Config.Quarry.Caving.Prop and Config.Quarry.Caving.Locations then
        local model = GetHashKey(Config.Quarry.Caving.Prop.model)
        RequestModel(model)
        local tries=0
        while not HasModelLoaded(model) and tries<400 do
            tries=tries+1
            Wait(5)
        end
        for i, loc in ipairs(Config.Quarry.Caving.Locations) do
            local idx = i
            local lx, ly, lz, lw = loc.x, loc.y, loc.z, (loc.w or 0.0)
            local obj = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
            SetEntityHeading(obj, lw)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)
            PlaceObjectOnGroundProperly(obj)
            SpawnedQuarryCaveTargets[#SpawnedQuarryCaveTargets+1] = obj
            ActiveQuarryCaveMarkers[i] = obj
            exports[TargetName]:addLocalEntity(obj, {
                {
                    name = 'quarry_cave_marker_' .. idx,
                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                    onSelect = function(entity)
                        local index = idx
                        if entity and DoesEntityExist(entity) then
                            exports[TargetName]:removeLocalEntity(entity)
                            safeDeleteMarker(entity)
                        end
                        ActiveQuarryCaveMarkers[index] = nil
                        SetTimeout(90000, function()
                            if ActiveQuarryCaveMarkers[index] and DoesEntityExist(ActiveQuarryCaveMarkers[index]) then return end
                            local new = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                            SetEntityHeading(new, lw)
                            SetEntityInvincible(new, true)
                            FreezeEntityPosition(new, true)
                            PlaceObjectOnGroundProperly(new)
                            ActiveQuarryCaveMarkers[index] = new
                            exports[TargetName]:addLocalEntity(new, {
                                {
                                    name = 'quarry_cave_marker_' .. index,
                                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                                    onSelect = function()
                                        local ent = ActiveQuarryCaveMarkers[index]
                                        if ent and DoesEntityExist(ent) then
                                            exports[TargetName]:removeLocalEntity(ent)
                                            safeDeleteMarker(ent)
                                            ActiveQuarryCaveMarkers[index] = nil
                                        end
                                        SetTimeout(90000, function()
                                            if ActiveQuarryCaveMarkers[index] and DoesEntityExist(ActiveQuarryCaveMarkers[index]) then return end
                                            local newer = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                                            SetEntityHeading(newer, lw)
                                            SetEntityInvincible(newer, true)
                                            FreezeEntityPosition(newer, true)
                                            PlaceObjectOnGroundProperly(newer)
                                            ActiveQuarryCaveMarkers[index] = newer
                                            exports[TargetName]:addLocalEntity(newer, {
                                                {
                                                    name = 'quarry_cave_marker_' .. index,
                                                    icon = Language.Mining.Quarry.Dynamite.Target['icon'],
                                                    label = Language.Mining.Quarry.Dynamite.Target['label'],
                                                    onSelect = function()
                                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'QuarryCave' })
                                                    end,
                                                    distance = 2.0
                                                }
                                            })
                                        end)
                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'QuarryCave' })
                                    end,
                                    distance = 2.0
                                }
                            })
                        end)
                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'QuarryCave' })
                    end,
                    distance = 2.0
                }
            })
        end
    end
    -- Mineshaft cave blasting markers
    if Config.Mine and Config.Mine.Caving and Config.Mine.Caving.Prop and Config.Mine.Caving.Locations then
        local model = GetHashKey(Config.Mine.Caving.Prop.model)
        RequestModel(model)
        local tries=0
        while not HasModelLoaded(model) and tries<400 do
            tries=tries+1
            Wait(5)
        end
        for i, loc in ipairs(Config.Mine.Caving.Locations) do
            local idx = i
            local lx, ly, lz, lw = loc.x, loc.y, loc.z, (loc.w or 0.0)
            local obj = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
            SetEntityHeading(obj, lw)
            SetEntityInvincible(obj, true)
            FreezeEntityPosition(obj, true)
            PlaceObjectOnGroundProperly(obj)
            SpawnedMineTargets[#SpawnedMineTargets+1] = obj
            ActiveMineMarkers[i] = obj
            exports[TargetName]:addLocalEntity(obj, {
                {
                    name = 'mine_marker_' .. idx,
                    icon = Language.Mining.Mine.Dynamite.Target['icon'],
                    label = Language.Mining.Mine.Dynamite.Target['label'],
                    onSelect = function(entity)
                        local index = idx
                        if entity and DoesEntityExist(entity) then
                            exports[TargetName]:removeLocalEntity(entity)
                            safeDeleteMarker(entity)
                        end
                        ActiveMineMarkers[index] = nil
                        SetTimeout(90000, function()
                            if ActiveMineMarkers[index] and DoesEntityExist(ActiveMineMarkers[index]) then return end
                            local new = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                            SetEntityHeading(new, lw)
                            SetEntityInvincible(new, true)
                            FreezeEntityPosition(new, true)
                            PlaceObjectOnGroundProperly(new)
                            ActiveMineMarkers[index] = new
                            exports[TargetName]:addLocalEntity(new, {
                                {
                                    name = 'mine_marker_' .. index,
                                    icon = Language.Mining.Mine.Dynamite.Target['icon'],
                                    label = Language.Mining.Mine.Dynamite.Target['label'],
                                    onSelect = function()
                                        local ent = ActiveMineMarkers[index]
                                        if ent and DoesEntityExist(ent) then
                                            exports[TargetName]:removeLocalEntity(ent)
                                            safeDeleteMarker(ent)
                                            ActiveMineMarkers[index] = nil
                                        end
                                        SetTimeout(90000, function()
                                            if ActiveMineMarkers[index] and DoesEntityExist(ActiveMineMarkers[index]) then return end
                                            local newer = CreateObjectNoOffset(model, lx, ly, lz, false, false, false)
                                            SetEntityHeading(newer, lw)
                                            SetEntityInvincible(newer, true)
                                            FreezeEntityPosition(newer, true)
                                            PlaceObjectOnGroundProperly(newer)
                                            ActiveMineMarkers[index] = newer
                                            exports[TargetName]:addLocalEntity(newer, {
                                                {
                                                    name = 'mine_marker_' .. index,
                                                    icon = Language.Mining.Mine.Dynamite.Target['icon'],
                                                    label = Language.Mining.Mine.Dynamite.Target['label'],
                                                    onSelect = function()
                                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Mine' })
                                                    end,
                                                    distance = 2.0
                                                }
                                            })
                                        end)
                                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Mine' })
                                    end,
                                    distance = 2.0
                                }
                            })
                        end)
                        TriggerEvent('boii-mining:cl:PlaceDynamite', { area = 'Mine' })
                    end,
                    distance = 2.0
                }
            })
        end
    end
end)
--<!>-- BLASTING MARKERS (X props) --<!>--

--<!>-- PAYDIRT PILES --<!>--
-- helper: spawn a single paydirt pile and wire up its target
local function spawnSinglePaydirt()
    if not (Config.Paydirt and Config.Paydirt.Dirt and Config.Paydirt.Dirt.Prop and Config.Paydirt.Dirt.Prop.model) then return end
    local model = GetHashKey(Config.Paydirt.Dirt.Prop.model)
    RequestModel(model)
    local tries=0
    while not HasModelLoaded(model) and tries<400 do
        tries=tries+1
        Wait(5)
    end

    local base = Config.Paydirt.Dirt.Coords
    local minSpacing = 3.5
    local innerRadius = 8.0
    local outerRadius = 32.0
    local px, py, pz
    local tries = 0
    while true do
        tries = tries + 1
        local angle = GetRandomFloatInRange(0.0, 2.0 * math.pi)
        local radius = GetRandomFloatInRange(innerRadius, outerRadius)
        px = base.x + math.cos(angle) * radius
        py = base.y + math.sin(angle) * radius
        pz = base.z - (Config.Paydirt.Dirt.Prop.zheight or 1.0)
        local ok = true
        for _, pos in ipairs(PaydirtPositions) do
            if #(vector3(px, py, pz) - pos) < minSpacing then
                ok = false
                break
            end
        end
        if ok or tries > 200 then break end
        Wait(10)
    end
    -- spawn slightly above then resolve to ground to prevent floating
    local obj = CreateObjectNoOffset(model, px, py, pz + 1.5, false, false, false)
    SetEntityInvincible(obj, true)
    -- wait for collision to load so placement can snap correctly
    local waitStart = GetGameTimer()
    while not HasCollisionLoadedAroundEntity(obj) and (GetGameTimer() - waitStart) < 2000 do
        RequestCollisionAtCoord(px, py, pz)
        Wait(10)
    end
    PlaceObjectOnGroundProperly(obj)
    -- extra guard: if native failed, try using ground probe to adjust Z
    local found, gz = GetGroundZFor_3dCoord(px, py, pz + 10.0, false)
    if found then
        SetEntityCoords(obj, px, py, gz - (Config.Paydirt.Dirt.Prop.zheight or 1.0), false, false, false, true)
        PlaceObjectOnGroundProperly(obj)
    end
    FreezeEntityPosition(obj, true)
    SpawnedPaydirt[#SpawnedPaydirt+1] = obj
    PaydirtPositions[#PaydirtPositions+1] = vector3(px, py, pz)

    exports[TargetName]:addLocalEntity(obj, {
        {
            name = 'paydirt_' .. #SpawnedPaydirt,
            icon = Language.Mining.Quarry.Paydirt.Digging.Target['icon'],
            label = Language.Mining.Quarry.Paydirt.Digging.Target['label'],
            onSelect = function(entity)
                -- Handle entity parameter - it might be a table with .entity or just the entity handle
                local targetEntity = entity
                if type(entity) == 'table' and entity.entity then
                    targetEntity = entity.entity
                elseif type(entity) ~= 'number' then
                    targetEntity = nil
                end
                
                if isDiggingPaydirt then
                    TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Digging['busy'], 'error')
                    return
                end
                -- client-side precheck for shovel and sack before starting animation
                local shovelName = Config.Paydirt.Dirt.Required[1] and Config.Paydirt.Dirt.Required[1].name
                local sackName = Config.Paydirt.Dirt.Required[2] and Config.Paydirt.Dirt.Required[2].name
                
                print('^6[boii-mining] Debug: Checking for shovel: ' .. tostring(shovelName))
                local hasShovel = playerHasItem(shovelName)
                print('^6[boii-mining] Debug: Has shovel: ' .. tostring(hasShovel))
                
                if shovelName and not hasShovel then
                    TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Digging['notool'], 'error')
                    return
                end
                
                print('^6[boii-mining] Debug: Checking for sack: ' .. tostring(sackName))
                local hasSack = playerHasItem(sackName)
                print('^6[boii-mining] Debug: Has sack: ' .. tostring(hasSack))
                
                if sackName and not hasSack then
                    TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Digging['notool2'], 'error')
                    return
                end
                isDiggingPaydirt = true
                setMiningBusy(true)
                local ped = PlayerPedId()
                local dig = Config.Animations and Config.Animations.Paydirt and Config.Animations.Paydirt.Dig
                local dur = (Config.Paydirt.Dirt.Time or 5) * 1000
                showProgress('Digging paydirt', dur)
                if dig and dig.Dict and dig.Anim then
                    playTimedAnim(dig.Dict, dig.Anim, dur, (dig.Flags or 49))
                else
                    Wait(dur)
                end
                TriggerServerEvent('boii-mining:sv:DigPaydirt')

                -- delete the dug pile and schedule respawn in 60s
                local function safeDelete(handle)
                    if not handle or handle == 0 or not DoesEntityExist(handle) then return end
                    SetEntityAsMissionEntity(handle, true, true)
                    NetworkRequestControlOfEntity(handle)
                    local tries2 = 0
                    while not NetworkHasControlOfEntity(handle) and tries2 < 50 do
                        tries2 = tries2 + 1
                        Wait(10)
                        NetworkRequestControlOfEntity(handle)
                    end
                    exports[TargetName]:removeLocalEntity(handle)
                    DeleteEntity(handle)
                    DeleteObject(handle)
                end
                local removedPos
                if targetEntity and type(targetEntity) == 'number' and DoesEntityExist(targetEntity) then
                    removedPos = GetEntityCoords(targetEntity)
                    safeDelete(targetEntity)
                    for idx, handle in ipairs(SpawnedPaydirt) do
                        if handle == targetEntity then
                            table.remove(SpawnedPaydirt, idx)
                            break
                        end
                    end
                end
                if removedPos then
                    for i = #PaydirtPositions, 1, -1 do
                        if #(PaydirtPositions[i] - removedPos) < 3.5 then
                            table.remove(PaydirtPositions, i)
                            break
                        end
                    end
                end
                SetTimeout(90000, function()
                    spawnSinglePaydirt()
                end)
                isDiggingPaydirt = false
                setMiningBusy(false)
            end,
            canInteract = function(entity)
                if not entity or entity == 0 then return false end
                return GetEntityModel(entity) == GetHashKey(Config.Paydirt.Dirt.Prop.model) and not IsPedInAnyVehicle(PlayerPedId())
            end,
            distance = 1.5
        }
    })
end

CreateThread(function()
    if Config.Paydirt and Config.Paydirt.Dirt and Config.Paydirt.Dirt.Prop and Config.Paydirt.Dirt.Prop.model then
        -- wait for target resource to be ready to avoid lost targets
        local waitMs = 0
        while (GetResourceState(TargetName) ~= 'started') and waitMs < 5000 do
            Wait(100)
            waitMs = waitMs + 100
        end
        local desired = (Config.Paydirt.Dirt.Prop.amount or 15)
        -- keep trying until we have the desired amount
        local guard = 0
        while #SpawnedPaydirt < desired and guard < desired * 4 do
            spawnSinglePaydirt()
            guard = guard + 1
            Wait(5)
        end
    end
end)
--<!>-- PAYDIRT PILES --<!>--

--<!>-- CLEANUP ON RESOURCE STOP --<!>--
AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    -- remove paydirt
    for _, h in ipairs(SpawnedPaydirt) do
        if DoesEntityExist(h) then
            exports[TargetName]:removeLocalEntity(h)
            DeleteEntity(h)
        end
    end
    -- remove blast rocks
    for _, h in ipairs(SpawnedBlastRocks) do
        if DoesEntityExist(h) then
            exports[TargetName]:removeLocalEntity(h)
            DeleteEntity(h)
        end
    end
    -- remove markers
    local lists = {ActiveQuarryMarkers, ActiveQuarryCaveMarkers, ActiveMineMarkers}
    for _, lst in ipairs(lists) do
        for k, h in pairs(lst) do
            if h and DoesEntityExist(h) then
                exports[TargetName]:removeLocalEntity(h)
                DeleteEntity(h)
                lst[k] = nil
            end
        end
    end
    -- remove lights
    for _, h in ipairs(SpawnedQuarryLights) do if DoesEntityExist(h) then DeleteEntity(h) end end
    for _, h in ipairs(SpawnedMineLights) do if DoesEntityExist(h) then DeleteEntity(h) end end
    -- remove jewel bench zones
    if GetResourceState(TargetName) == 'started' then
        for zoneName, _ in pairs(SpawnedJewelBenches) do
            pcall(function() exports[TargetName]:removeZone(zoneName) end)
        end
    end
    SpawnedJewelBenches = {} -- Reset tracking table
end)
--<!>-- CLEANUP ON RESOURCE STOP --<!>--
--<!>-- PLACE DYNAMITE HANDLER --<!>--
RegisterNetEvent('boii-mining:cl:PlaceDynamite', function(ctx)
    local area = (ctx and ctx.area) or 'Quarry'
    -- Client-side XP gate to prevent wasting time if under level
    if Config and Config.XP and Config.XP.Use then
        local playerData = Core.Functions.GetPlayerData()
        local miningXp = (playerData and playerData.metadata and playerData.metadata[Config.XP.MetaDataName]) or 0
        local isMine = (area == 'Mine' or area == 'QuarryCave')
        local req = (isMine and ((Config.XP.Thresholds and Config.XP.Thresholds.Cave) or 2441)) or ((Config.XP.Thresholds and Config.XP.Thresholds.Quarry) or 1250)
        if miningXp < req then
            TriggerEvent('boii-mining:notify', isMine and 'Your mining level is too low to place dynamite in caves.' or 'Your mining level is too low to place dynamite at the quarry.', 'error')
            return
        end
    end
    TriggerServerEvent('boii-mining:sv:RequestPlaceDynamite', area)
end)

RegisterNetEvent('boii-mining:cl:ProceedPlaceDynamite', function(data)
    local area = (data and data.area) or 'Quarry'
    local delay = (data and tonumber(data.delay)) or ((area == 'Mine') and Config.Mine.Dynamite.Delay or Config.Quarry.Dynamite.Delay)
    TriggerEvent('boii-mining:notify', (area == 'Mine') and Language.Mining.Mine.Dynamite['delay'] or Language.Mining.Quarry.Dynamite['delay'], 'primary')
    -- play placement animation if configured
    local place = Config.Animations and Config.Animations.Dynamite and Config.Animations.Dynamite.Place
    if place and place.Dict and place.Anim then
        showProgress('Placing dynamite', 1500)
        playTimedAnim(place.Dict, place.Anim, 1500, (place.Flags or 49))
    end
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local smallRockHashes = {
        GetHashKey('ng_proc_rock_1a'), GetHashKey('ng_proc_rock_1b'), GetHashKey('ng_proc_rock_1c'),
        GetHashKey('ng_proc_rock_2a'), GetHashKey('ng_proc_rock_2b'), GetHashKey('ng_proc_rock_2c'),
        GetHashKey('ng_proc_rock_3a')
    }
    for _, h in ipairs(smallRockHashes) do RequestModel(h) end
    local fallbackRockHashes = { GetHashKey('prop_rock_4_c'), GetHashKey('prop_rock_4_d') }
    for _, h in ipairs(fallbackRockHashes) do RequestModel(h) end
    SetTimeout(delay * 1000, function()
        AddExplosion(pos.x, pos.y, pos.z, 2, 2.0, true, false, 1.0)
        local rockModels = {}
        for _, h in ipairs(smallRockHashes) do if HasModelLoaded(h) then rockModels[#rockModels+1] = h end end
        if #rockModels == 0 then rockModels = fallbackRockHashes end
        local function isRockModel(mdl)
            for _, h in ipairs(rockModels) do if mdl == h then return true end end
            return false
        end
        local rocksToSpawn = math.random(3, 5)
        for i = 1, rocksToSpawn do
            local m = rockModels[math.random(1, #rockModels)]
            local ang = math.rad(math.random(0, 359))
            local power = 2.0 + math.random() * 1.0
            local sx = pos.x + math.cos(ang) * 0.2
            local sy = pos.y + math.sin(ang) * 0.2
            local sz = pos.z + 0.2
            local rock = CreateObject(m, sx, sy, sz, false, false, false)
            SetEntityCoordsNoOffset(rock, sx, sy, sz, false, false, false)
            SetEntityCollision(rock, true, true)
            SetEntityDynamic(rock, true)
            ActivatePhysics(rock)
            ApplyForceToEntity(rock, 1, math.cos(ang) * power, math.sin(ang) * power, 2.8, 0.0, 0.0, 0.0, 0, false, true, true, true, true)
            SpawnedBlastRocks[#SpawnedBlastRocks+1] = rock
            CreateThread(function()
                Wait(1200)
                PlaceObjectOnGroundProperly(rock)
                FreezeEntityPosition(rock, true)
                exports[TargetName]:addLocalEntity(rock, {
                    {
                        name = 'blast_rock_' .. i,
                        icon = 'fa-solid fa-person-digging',
                        label = 'Drill Rock',
                        onSelect = function(entity)
                            if LocalPlayer.state.mining_busy then return end
                            -- remove this rock's target immediately to avoid re-trigger spam
                            if entity and DoesEntityExist(entity) then
                                exports[TargetName]:removeLocalEntity(entity)
                            end
                            TriggerEvent('boii-mining:cl:StartDrillRock', { area = area }, entity)
                        end,
                        canInteract = function(entity)
                            if not entity or entity == 0 then return false end
                            local mdl = GetEntityModel(entity)
                            if LocalPlayer.state.mining_busy then return false end
                            return isRockModel(mdl) and not IsPedInAnyVehicle(PlayerPedId())
                        end,
                        distance = 1.8
                    }
                })
            end)
        end
    end)
end)
--<!>-- PLACE DYNAMITE HANDLER --<!>--

--<!>-- START DRILL ROCK (qb-target client event) --<!>--
RegisterNetEvent('boii-mining:cl:StartDrillRock', function(args, entity)
    if LocalPlayer.state.mining_busy then return end
    local area = args and args.area or 'Quarry'
    -- Require jackhammer client-side before starting to save animations/time
    local jackItem = (area == 'Mine' or area == 'QuarryCave') and (Config.Mine and Config.Mine.Drilling and Config.Mine.Drilling.Required and Config.Mine.Drilling.Required.name)
        or (Config.Quarry and Config.Quarry.Drilling and Config.Quarry.Drilling.Required and Config.Quarry.Drilling.Required.name)
        or 'jackhammer'
    if not playerHasItem(jackItem) then
        TriggerEvent('boii-mining:notify', 'You need a '..(Config.Quarry.Drilling.Required.label or 'Jackhammer')..' to drill.', 'error')
        return
    end
    -- Client-side XP gate before drilling
    if Config and Config.XP and Config.XP.Use then
        local playerData = Core.Functions.GetPlayerData()
        local miningXp = (playerData and playerData.metadata and playerData.metadata[Config.XP.MetaDataName]) or 0
        local isMine = (area == 'Mine' or area == 'QuarryCave')
        local req = (isMine and ((Config.XP.Thresholds and Config.XP.Thresholds.Cave) or 2441)) or ((Config.XP.Thresholds and Config.XP.Thresholds.Quarry) or 1250)
        if miningXp < req then
            TriggerEvent('boii-mining:notify', isMine and 'Your mining level is too low for cave drilling.' or 'Your mining level is too low for quarry drilling.', 'error')
            return
        end
    end
    local rock = (entity and DoesEntityExist(entity)) and entity or 0
    if rock == 0 and args and args.net then
        local obj = NetToObj(args.net)
        if obj and DoesEntityExist(obj) then rock = obj end
    end
    -- ensure this rock cannot be re-triggered during drilling
    if rock ~= 0 and DoesEntityExist(rock) then
        pcall(function() exports[TargetName]:removeLocalEntity(rock) end)
    end
    local ped = PlayerPedId()
    local t = (area == 'Mine' and Config.Mine.Drilling.Time or Config.Quarry.Drilling.Time) * 1000
    setMiningBusy(true)
    if t and t > 0 then
        showProgress('Drilling rock', t)
        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CONST_DRILL', 0, true)
        Wait(t)
        ClearPedTasks(ped)
        removeJackhammerProp(ped)
        cleanupNearbyJackhammers(ped, 4.0)
    else
        local drill = Config.Animations and Config.Animations.Drilling
        if drill and drill.Dict and drill.Anim then
            showProgress('Drilling rock', 2500)
            playTimedAnim(drill.Dict, drill.Anim, 2500, (drill.Flags or 49))
        else
            showProgress('Drilling rock', 2500)
            Wait(2500)
        end
        cleanupNearbyJackhammers(ped, 4.0)
    end
    if area == 'Mine' then
        TriggerServerEvent('boii-mining:sv:CaveDrilling')
    else
        TriggerServerEvent('boii-mining:sv:QuarryDrilling')
    end
    if rock ~= 0 and DoesEntityExist(rock) then
        exports[TargetName]:removeLocalEntity(rock)
        DeleteObject(rock)
    end
    setMiningBusy(false)
end)
--<!>-- START DRILL ROCK --<!>--

--<!>-- DIG PAYDIRT HANDLER --<!>--
RegisterNetEvent('boii-mining:cl:DigPaydirt', function()
    local shovelName = Config.Paydirt.Dirt.Required[1] and Config.Paydirt.Dirt.Required[1].name
    local sackName = Config.Paydirt.Dirt.Required[2] and Config.Paydirt.Dirt.Required[2].name
    if shovelName and not playerHasItem(shovelName) then
        TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Digging['notool'], 'error')
        return
    end
    if sackName and not playerHasItem(sackName) then
        TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Digging['notool2'], 'error')
        return
    end
    TriggerServerEvent('boii-mining:sv:DigPaydirt')
end)
--<!>-- DIG PAYDIRT HANDLER --<!>--

--<!>-- PAN PAYDIRT (client handler from useable gold pan) --<!>--
RegisterNetEvent('boii-mining:cl:PanPaydirt', function()
    if isDiggingPaydirt then
        TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Panning['busy'], 'error')
        return
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if not IsPointOnRoad(coords.x, coords.y, coords.z, 0) and not IsPedSwimming(ped) then
        -- allow if near water
        if not TestProbeAgainstWater(coords.x, coords.y, coords.z + 1.0, coords.x, coords.y, coords.z - 5.0) then
            TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Paydirt.Panning['nowater'], 'error')
            return
        end
    end
    isDiggingPaydirt = true
    setMiningBusy(true)
    local pan = Config.Animations and Config.Animations.Paydirt and Config.Animations.Paydirt.Panning
    local dur = (Config.Paydirt.Panning.Time or 4) * 1000
    showProgress('Panning paydirt', dur)
    if pan and pan.Dict and pan.Anim then
        playTimedAnim(pan.Dict, pan.Anim, dur, (pan.Flags or 49))
    else
        Wait(dur)
    end
    TriggerServerEvent('boii-mining:sv:PanPaydirt')
    isDiggingPaydirt = false
    setMiningBusy(false)
end)
--<!>-- PAN PAYDIRT --<!>--

--<!>-- CLIENT CRAFT MENU OPEN --<!>--
RegisterNetEvent('boii-mining:cl:OpenCraftMenu', function(shop)
    -- ox_lib menu expects an array of entries; pass through the built list
    LocalPlayer.state:set('jewel_crafting_busy', false, true)
    if Config.Debug then print('^6[boii-mining]^7 opening craft menu with', #(shop.items or {}), 'entries') end
    lib.registerContext({
        id = 'mining_craft_menu',
        title = shop.label or 'Crafting',
        options = shop.items or {}
    })
    lib.showContext('mining_craft_menu')
end)
--<!>-- CLIENT CRAFT MENU OPEN --<!>--

-- Lightweight object enumeration helpers (scoped to this file)
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        disposeFunc(iter)
    end)
end

local function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

forceDeleteEntity = function(entity)
    if not entity or entity == 0 then return end
    SetEntityAsMissionEntity(entity, true, true)
    NetworkRequestControlOfEntity(entity)
    local tries = 0
    while not NetworkHasControlOfEntity(entity) and tries < 50 do
        tries = tries + 1
        Wait(10)
        NetworkRequestControlOfEntity(entity)
    end
    DeleteEntity(entity)
    DeleteObject(entity)
end

-- remove any dropped jackhammer props near the player (cleanup after drilling)
cleanupNearbyJackhammers = function(ped, radius)
    local jackHash = GetHashKey('prop_tool_jackham')
    local pcoords = GetEntityCoords(ped)
    local r = radius or 3.0
    if not EnumerateObjects then return end
    for obj in EnumerateObjects() do
        if DoesEntityExist(obj) and GetEntityModel(obj) == jackHash then
            local ocoords = GetEntityCoords(obj)
            if #(pcoords - ocoords) <= r then
                forceDeleteEntity(obj)
            end
        end
    end
end

--<!>-- JEWEL CUTTING BENCH --<!>--
local function SetupJewelBenches()
    -- Ensure target resource is started before adding zones to avoid export errors
    local waitMs = 0
    while (GetResourceState(TargetName) ~= 'started') and waitMs < 10000 do
        Wait(100)
        waitMs = waitMs + 100
    end
    for k, v in pairs(Config.JewelCutting.Locations) do
        -- ensure bench prop exists (but avoid duplicates if a mapping or another resource already placed it)
        if Config.JewelCutting.Prop and Config.JewelCutting.Prop.model then
            local model = GetHashKey(Config.JewelCutting.Prop.model)
            local existing = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 0.9, model, false, false, false)
            if existing == 0 then
                RequestModel(model)
                while not HasModelLoaded(model) do Wait(0) end
                local obj = CreateObject(model, v.coords.x, v.coords.y, v.coords.z - 1.0, true, true, false)
                SetEntityHeading(obj, v.heading or 0.0)
                SetEntityInvincible(obj, true)
                SetEntityAsMissionEntity(obj, true, true)
                FreezeEntityPosition(obj, true)
                PlaceObjectOnGroundProperly(obj)
            else
                if GetEntityModel(existing) == model then
                    SetEntityHeading(existing, v.heading or 0.0)
                    local pos = GetEntityCoords(existing)
                    if #(pos - v.coords) > 0.2 then
                        SetEntityCoords(existing, v.coords.x, v.coords.y, v.coords.z - 1.0, false, false, false, true)
                        PlaceObjectOnGroundProperly(existing)
                        FreezeEntityPosition(existing, true)
                    end
                end
            end
        end

        -- Create target zone for each bench (idempotent by name in most target resources)
        if GetResourceState(TargetName) == 'started' then
            -- prevent duplicate zones by trying to remove any existing first (only if already created)
            if SpawnedJewelBenches[v.name] then
                pcall(function() exports[TargetName]:removeZone(v.name) end)
            end
            exports[TargetName]:addSphereZone({
                coords = v.coords,
                radius = v.radius,
                options = {
                    {
                        name = v.name,
                        icon = 'fa-solid fa-gem',
                        label = 'Cut Gems/Craft',
                        onSelect = function()
                            TriggerEvent('boii-mining:cl:JewelleryCraftMenu')
                        end,
                        canInteract = function()
                            return #(GetEntityCoords(PlayerPedId()) - v.coords) < 2.0
                        end,
                        distance = v.distance
                    }
                }
            })
            SpawnedJewelBenches[v.name] = true -- Mark zone as created
        end
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    SetupJewelBenches()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SetupJewelBenches()
end)

AddEventHandler('playerSpawned', function()
    SetupJewelBenches()
end)

--<!>-- OPEN SHOP --<!>--
RegisterNetEvent('boii-mining:cl:OpenStore', function(args)
    items = {}
    items.label = args.label
    items.items = args.items
    items.slots = #args.items
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', args.label, items)
end)
--<!>-- OPEN SHOP --<!>--

--<!>-- MINING XP COMMAND --<!>--
if Config.XP and Config.XP.Use and Config.XP.Command then
    local function computeMiningLevel(totalXp)
        local xp = tonumber(totalXp) or 0
        local level = 1
        local remaining = xp
        local levels = (Config.XP and Config.XP.Levels) or {}
        for i = 1, #levels do
            local req = tonumber(levels[i]) or 0
            if remaining >= req then
                remaining = remaining - req
                level = level + 1
            else
                break
            end
        end
        local nextReq = levels[level] or 0
        return level, remaining, nextReq
    end

    RegisterCommand('miningxp', function()
        local playerData = Core.Functions.GetPlayerData()
        local metaName = (Config.XP and Config.XP.MetaDataName) or 'miningxp'
        local total = (playerData and playerData.metadata and playerData.metadata[metaName]) or 0
        local level, intoLevel, nextReq = computeMiningLevel(total)
        local msg
        if nextReq and nextReq > 0 then
            msg = ('Mining Level %d | XP %d/%d (total %d)'):format(level, intoLevel, nextReq, total)
        else
            msg = ('Mining Level %d | XP %d (MAX)'):format(level, total)
        end
        TriggerEvent('boii-mining:notify', msg, 'primary')
    end)
end
--<!>-- MINING XP COMMAND --<!>--