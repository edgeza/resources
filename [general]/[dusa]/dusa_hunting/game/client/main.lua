if not rawget(_G, "lib") then include('ox_lib', 'init') end

-- ▒█▀▄▀█ ░█▀▀█ ▀█▀ ▒█▄░▒█
-- ▒█▒█▒█ ▒█▄▄█ ▒█░ ▒█▒█▒█
-- ▒█░░▒█ ▒█░▒█ ▄█▄ ▒█░░▀█
function SetLocations()
    -- Shop System Ped
    if Shared.EnableShopSystem then
        Functions.createPed(Shared.Shop.Ped.coords, Shared.Shop.Ped.model, { -- target options
            icon = Shared.Shop.Ped.icon,
            label = locale('shop.open_shop'),
            name = "talkToShop",
            distance = Shared.Shop.Ped.distance,
            job = Config.RequireJob and Config.JobName or false,
            onSelect = OpenMenu,
            target = Shared.Shop.Ped.target
        })
    end

    -- Tournament System Ped
    if Shared.EnableTournamentSystem then
        Functions.createPed(Shared.Shop.Tournament.coords, Shared.Shop.Tournament.model, { -- target options
            icon = Shared.Shop.Tournament.icon,
            label = locale('shop.open_tournament'),
            name = "talkToTournament",
            distance = Shared.Shop.Tournament.distance,
            job = false,
            onSelect = OpenTournamentMenu,
            target = Shared.Shop.Tournament.target
        })
    end

    if Shared.EnableShopSystem and Shared.Shop.Blip.Enabled then
        local blip = AddBlipForCoord(Shared.Shop.Blip.Coords.x, Shared.Shop.Blip.Coords.y, Shared.Shop.Blip.Coords.z)
        SetBlipSprite(blip, Shared.Shop.Blip.Sprite)
        SetBlipColour(blip, Shared.Shop.Blip.Color)
        SetBlipScale(blip, Shared.Shop.Blip.Scale)
        SetBlipAsShortRange(blip, Shared.Shop.Blip.ShortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Shared.Shop.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end

    if Shared.EnableShopSystem and Shared.Shop.Butcher.Enabled then
        local blip = AddBlipForCoord(Shared.Shop.Butcher.Coords.x, Shared.Shop.Butcher.Coords.y,
            Shared.Shop.Butcher.Coords.z)
        SetBlipSprite(blip, Shared.Shop.Butcher.Sprite)
        SetBlipColour(blip, Shared.Shop.Butcher.Color)
        SetBlipScale(blip, Shared.Shop.Butcher.Scale)
        SetBlipAsShortRange(blip, Shared.Shop.Butcher.ShortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Shared.Shop.Butcher.Name)
        EndTextCommandSetBlipName(blip)
    end

    SetButcheringZone()
end

local function setObjectiveAlignment()
    SendNUIMessage({
        action = "SET_OBJECTIVE_ALIGNMENT",
        data = Config.ObjectiveAlignment
    })
end

local defaultLoadProcessed = false
CreateThread(function()
    if not Framework.Player.Loaded and cache.ped then
        pcall(Framework.OnPlayerLoaded)
    end
end)

Framework.OnPlayerLoaded = function()
    if defaultLoadProcessed then return end
    defaultLoadProcessed = true
    Framework.Player.Loaded = true
    TriggerServerEvent('hunting:server:resourceStarted')
    ReloadObjects()
    setObjectiveAlignment()
    Functions.RemoveHuntingLaptopIfDisabled()
    if Bridge.InventoryName == 'ox_inventory' then
        exports.ox_inventory:displayMetadata({
            hideType = 'Hide Type',
            quality = 'Quality',
        })
    end
    -- SpawnDeadDeer()
    CreateZones()
    SetLocations()
    EnableLevelUpgrades()
end

-----------
--- CALLBACKS
RegisterNUICallback('close_ui', function(data, cb)
    SetNuiFocus(false, false)
    if STATE.ON_CAMPFIRE then
        closeCampfire()
    end
    cb(true)
end)


-- ▒█▀▀▀█ ▒█░▒█ ▒█▀▀▀█ ▒█▀▀█
-- ░▀▀▀▄▄ ▒█▀▀█ ▒█░░▒█ ▒█▄▄█
-- ▒█▄▄▄█ ▒█░▒█ ▒█▄▄▄█ ▒█░░░

local function shopData()
    local data = {}

    for i = 1, #Shared.Shop.Items do
        local v = Shared.Shop.Items[i]
        local itemData = Framework.Items[v.item]

        local itemLabel = v.item
        if itemData and itemData.label then
            itemLabel = itemData.label
        else
            itemLabel = v.name
        end

        local image = Functions.GetInventoryImage(v.item)
        table.insert(data, {
            id = i,
            name = itemLabel,
            price = v.price,
            item = v.item,
            image = image
        })
    end

    return data
end

RegisterNUICallback('buyProducts', function(data, cb)
    local res = lib.callback.await('hunting:server:buyCart', false, data.products, data.type, data.price)
    cb(res)
end)


-- ▒█░░▒█ ▀█▀ ▒█░▄▀ ▀█▀
-- ▒█▒█▒█ ▒█░ ▒█▀▄░ ▒█░
-- ▒█▄▀▄█ ▄█▄ ▒█░▒█ ▄█▄
local function returnWiki()
    local wiki = {}

    for type, data in pairs(Config.Wiki) do
        -- Önce Shared.Species'te bu tür var mı kontrol et
        if not Shared.Species[type] then
            goto continue -- Bu türü atla
        end

        local foundInZones = false

        for _zone, zd in pairs(Config.HuntingZones) do
            if zd.type == type then
                -- koordinatlar ters
                data.coords = { x = zd.coords.y, y = zd.coords.x, radius = zd.range }
                foundInZones = true
                break
            end
        end

        -- Eğer HuntingZones'ta bulunamadıysa fallback koordinatlar kullan
        if not foundInZones then
            -- Fallback koordinatlar - Shared.Species'te olup HuntingZones'ta olmayan türler için
            local fallbackCoords = {
                -- Mevcut HuntingZones'ta olan türler (fallback olarak da ekle)
                ['deer'] = { x = -575.706, y = 5460.014, radius = 250.0 },
                ['rabbit'] = { x = -716.885, y = 5310.257, radius = 370.0 },
                ['bear'] = { x = -117.283, y = 1435.516, radius = 300.0 },
                ['boar'] = { x = -299.741, y = 4806.736, radius = 300.0 },

                -- HuntingZones'ta olmayan türler
                ['lion'] = { x = 1506.253, y = 2078.924, radius = 300.0 },
                ['oryx'] = { x = 1506.253, y = 2078.924, radius = 300.0 },
                ['antelope'] = { x = 1439.352, y = 1568.055, radius = 300.0 },
                ['coyote'] = { x = -299.741, y = 4806.736, radius = 300.0 },
                ['mtlion'] = { x = -117.283, y = 1435.516, radius = 300.0 },
                ['redpanda'] = { x = -716.885, y = 5310.257, radius = 370.0 },
                ['pig'] = { x = -575.706, y = 5460.014, radius = 250.0 },
            }

            if fallbackCoords[type] then
                data.coords = fallbackCoords[type]
            else
                -- Genel fallback koordinat
                data.coords = { x = -575.706, y = 5460.014, radius = 250.0 }
            end
        end

        if not data.coords then
            goto continue
        end

        local imageType = type
        if type == "mtlion" or type == "lion" or type == "coyote" then
            imageType = "tiger"
        end
        table.insert(wiki, {
            type = type,
            name = data.name,
            infoText = data.info,
            description = data.description,
            howislook = "../../../assets/preview/" .. type .. ".png",     -- preview
            imageUrl = "../../../assets/animals/" .. imageType .. ".png", -- logo
            footprint = "",                                               -- ayak izi
            wherelocated = data.coords
        })

        ::continue::
    end

    return wiki
end

local function returnInventory()
    local inventory = lib.callback.await('hunting:server:getSellList', false) or {}

    for _, item in pairs(inventory) do
        item.image = Functions.GetInventoryImage(item.item)
    end

    return inventory
end

local function returnLeaderboard()
    local leaderboard = lib.callback.await('hunting:server:GetLeaderBoard', false)
    return leaderboard
end

local function returnProfile()
    local profile = lib.callback.await('hunting:server:getPlayerProfile', false)
    profile.role = profile.title
    return profile
end

local function returnMoney()
    local financials = lib.callback.await('hunting:server:getMoneyAmount', false)
    return financials
end

-- ▀▀█▀▀ ▒█▀▀█ ░█▀▀█ ▒█▀▀█
-- ░▒█░░ ▒█▄▄▀ ▒█▄▄█ ▒█▄▄█
-- ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░░░
local trapObject = `hunt_trap2`
local openTrapObject = `hunt_trap1`
local attachBone = 8
traps = {}

local function killTrappedAnimal(entity, trap)
    -- Oyuncuya karşıdan bakan kamera oluştur
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local entityCoords = GetEntityCoords(entity)

    -- Kamera pozisyonunu hesapla (hayvanın karşısında, oyuncuya doğru bakacak şekilde)
    local direction = playerCoords - entityCoords
    local distance = #direction
    local normalizedDirection = direction / distance

    -- Oyuncunun sağ eline bıçak objesi oluştur ve tak
    local knifeModel = `prop_knife`
    lib.requestModel(knifeModel)

    local knife = CreateObject(knifeModel, 0.0, 0.0, 0.0, true, true, true)
    AttachEntityToEntity(knife, playerPed, GetPedBoneIndex(playerPed, 57005), 0.12, 0.0, 0.0, 45.0, 0.0, 0.0, true, true,
        false, true, 1, true)
    SetModelAsNoLongerNeeded(knifeModel)

    local cameraPos = playerCoords + (normalizedDirection * -1.25) -- 3 metre mesafede
    cameraPos = vector3(cameraPos.x, cameraPos.y, cameraPos.z + 1) -- Biraz yukarıda

    -- Kamerayı oluştur
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, cameraPos.x, cameraPos.y, cameraPos.z)
    PointCamAtEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, false)

    -- Kamera geçiş efekti
    SetCamActiveWithInterp(cam, GetRenderingCam(), 1000, 1, 1)

    -- -- Animasyon için gerekli değişkenler
    -- local dict = "amb@world_human_gardener_plant@male@base"
    -- local anim = "base"

    -- -- Animasyon dictionary'sini yükle
    -- lib.requestAnimDict(dict)

    -- Oyuncuyu hayvana doğru çevir
    local heading = GetHeadingFromVector_2d(entityCoords.x - playerCoords.x, entityCoords.y - playerCoords.y)
    SetEntityHeading(playerPed, heading)

    -- Eğilme animasyonunu oynat
    -- TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)


    -- Bıçak animasyonu (bıçak çekme ve vurma)
    local knifeDict = "anim@gangops@facility@servers@bodysearch@"
    local knifeAnim = "player_search"

    lib.requestAnimDict(knifeDict)

    -- Bıçak çekme ve vurma animasyonu
    TaskPlayAnim(playerPed, knifeDict, knifeAnim, 8.0, -8.0, 6000, 0, 0, false, false, false)

    -- Bıçak vurma sesi
    Wait(3000)
    -- PlaySoundFrontend(-1, "Knife_Hit", "DLC_HEIST_FLEECA_SOUNDSET", 0)

    -- Hayvanı öldür
    SetEntityHealth(entity, 0)

    -- Animasyon bitene kadar bekle
    Wait(3000)

    -- Kamerayı kapat ve normal açıya dön
    -- SetCamActiveWithInterp(GetRenderingCam(), cam, 1000, 1, 1)
    -- Wait(1000)

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)

    -- Animasyonları temizle
    ClearPedTasks(playerPed)
    RemoveAnimDict(dict)
    RemoveAnimDict(knifeDict)

    -- Bıçakı sil
    DeleteEntity(knife)
    SetModelAsNoLongerNeeded(knifeModel)

    local quality = CheckHitAnimalQuality(entity, true)

    -- Remove the trap
    if trap and trap.object and DoesEntityExist(trap.object) then
        DeleteEntity(trap.object)
        trap.object = nil
        trap.triggered = false
    end

    Entity(entity).state.trapDead = true
    SetCarcassInteraction(entity)
    deadAnimals[entity] = true
end

-- Helper function to get animal type from entity
local function GetAnimalTypeFromEntity(entity)
    if not DoesEntityExist(entity) then return nil end

    local model = GetEntityModel(entity)
    local modelHash = tostring(model)

    -- Map model hashes to animal types
    local animalModelMap = {
        [`a_c_deer`] = 'deer',
        [`a_c_rabbit_01`] = 'rabbit',
        [`BrnBear`] = 'bear',
        [`redpanda`] = 'redpanda',
        [`ft-lion`] = 'lion',
        [`ft-araboryx`] = 'oryx',
        [`pronghorn_antelope`] = 'antelope',
        [`a_c_boar`] = 'boar',
        [`a_c_coyote`] = 'coyote',
        [`a_c_mtlion`] = 'mtlion'
    }

    return animalModelMap[model] or nil
end

local function TrapAnimal(entity, trap)
    -- trap.coords, trap.object
    -- entity = animal
    if trap.triggered then return end

    -- Tuzak tetiklendiğinde ses efekti
    PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)

    -- Hayvanın sağlığını kaydet
    local aHealth = GetEntityHealth(entity)

    -- Hayvanı panik moduna geçir ve acı çekmesini sağla
    SetPedFleeAttributes(entity, 0, false)
    SetPedCombatAttributes(entity, 17, false)
    PlayPain(entity, 5, 0.0, false)

    -- Hayvana hasar ver
    ApplyDamageToPed(entity, Config.TrapDamage, false)

    -- Hayvanı yere yatır ve hareket etmesini engelle
    TaskSetBlockingOfNonTemporaryEvents(entity, true)

    -- Eski tuzağı sil
    DeleteEntity(trap.object)

    -- Yer koordinatlarını al
    _, groundZ = GetGroundZFor_3dCoord(trap.coords.x, trap.coords.y, trap.coords.z, false)

    -- Açık tuzağı oluştur
    local openedTrap = CreateObject(openTrapObject, trap.coords.x, trap.coords.y, groundZ, 0.0, true, false, false)
    trap.object = openedTrap
    trap.triggered = true
    SetEntityAsMissionEntity(openedTrap, true, true)
    SetModelAsNoLongerNeeded(openTrapObject)
    PlaceObjectOnGroundProperly(openedTrap)
    SetEntityRotation(openedTrap, -104.944, 3.205, trap.heading, 2, true)

    -- Hayvanı tuzağın üzerine yerleştir
    -- SetEntityCoords(entity, trap.coords.x, trap.coords.y, groundZ)

    -- Hayvanın yüzünü tuzağa doğru çevir
    -- local trapHeading = trap.heading + 180.0
    -- SetEntityHeading(entity, trapHeading)

    -- Tuzağı 63931 bone indexine attachle
    AttachEntityToEntity(openedTrap, entity, attachBone, -0.2, 0.0, -0.3, 0.0, 0.0, 0.0, false, false, true, false, 2,
        true)

    -- Hayvanı ragdoll yap ve sürekli ragdoll durumunda tut
    CreateThread(function()
        -- Hayvanı sürekli ragdoll durumunda tut
        while DoesEntityExist(entity) and trap.triggered do
            if IsEntityDead(entity) then
                break
            end

            -- Ragdoll durumunu kontrol et ve gerekirse yeniden uygula
            if not IsPedRagdoll(entity) then
                SetPedToRagdoll(entity, 1000, 1000, 0, true, true, false)
            end

            -- Acı çekme sesi ve animasyonu
            PlayPain(entity, 5, 0.0, false)

            Wait(1000) -- Her saniye kontrol et
        end
    end)

    -- Başarılı tuzak sesi
    Wait(1000)
    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 0)

    -- Get animal type for quest tracking
    local animalType = GetAnimalTypeFromEntity(entity)
    if animalType then
        -- Update quest progress for trapping
        exports['dusa_hunting']:UpdateQuestProgress('trap', animalType, 1)
    end

    AddEntityInteraction(entity, {
        {
            label = locale('labels.release_trap'),
            name = 'releaseTrap',
            icon = 'fa-solid fa-hand-sparkles',
            distance = 7.5,
            onSelect = function(data)
                RemoveEntityInteraction(entity, nil, true)
                killTrappedAnimal(entity, trap)
            end
        },
    }, true)
end

function PlaceTrap()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    -- Animasyon dict'ini yükle
    local animDict = "amb@medic@standing@kneel@enter"
    local animName = "enter"

    -- Progressbar başlat
    if lib.progressBar({
            duration = 2000,
            label = locale('labels.placing_trap') or 'Placing Trap...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            anim = {
                dict = animDict,
                clip = animName,
                flag = 49,
            },
        }) then
        -- Progressbar başarılı olduysa devam et

        -- Zemin yüksekliğini bul
        local found, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z + 1.0, false)
        local spawnCoords = coords
        if found then
            spawnCoords = vector3(coords.x, coords.y, groundZ + 0.1)
        end

        -- Geçici obje oluştur ve doğru pozisyonu hesapla
        lib.requestModel(trapObject)
        local tempTrap = CreateObject(trapObject, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false)

        -- Zemine yerleştir
        PlaceObjectOnGroundProperly(tempTrap)
        for _ = 1, 5 do
            Wait(50)
            PlaceObjectOnGroundProperly(tempTrap)
        end

        -- Rotasyonu ayarla
        local finalRotation = vector3(-103.649, 0.000, 180.000)
        SetEntityRotation(tempTrap, finalRotation.x, finalRotation.y, finalRotation.z, 2, true)

        -- Final pozisyonu al (rotasyon ayarlandıktan sonra)
        local finalCoords = GetEntityCoords(tempTrap)

        -- Geçici objeyi sil
        DeleteEntity(tempTrap)
        SetModelAsNoLongerNeeded(trapObject)

        -- Send trap data to server with final position and rotation
        local trapData = {
            coords = finalCoords,
            rotation = finalRotation,
            heading = heading,
            triggered = false,
            placedBy = cache.serverId
        }

        TriggerServerEvent('hunting:server:addTrap', trapData)
    end
end

RegisterNetEvent('hunting:client:PlaceTrap', PlaceTrap)

-- Client-side trap storage with objects (indexed by trap ID)
local clientTraps = {}

-- Add a single trap
local function CreateTrapObject(trapData)
    -- Check if trap already exists
    if clientTraps[trapData.id] then
        return
    end

    -- Only the player who placed the trap creates the object (it's networked so others will see it)
    if cache.serverId ~= trapData.placedBy then return end

    lib.requestModel(trapObject)

    -- Create networked object using server-calculated position and rotation
    local trap = CreateObject(trapObject, trapData.coords.x, trapData.coords.y, trapData.coords.z, true, true, false)
    SetEntityAsMissionEntity(trap, true, true)
    SetModelAsNoLongerNeeded(trapObject)

    -- Zemine yerleştir
    PlaceObjectOnGroundProperly(trap)
    for _ = 1, 5 do
        Wait(50)
        PlaceObjectOnGroundProperly(trap)
    end

    -- Apply rotation from server data
    if trapData.rotation then
        SetEntityRotation(trap, trapData.rotation.x, trapData.rotation.y, trapData.rotation.z, 2, true)
    else
        SetEntityRotation(trap, -103.649, 0.000, 180.000, 2, true)
    end

    -- Store trap with object reference
    local clientTrap = {
        id = trapData.id,
        coords = trapData.coords,
        heading = trapData.heading,
        rotation = trapData.rotation,
        triggered = trapData.triggered,
        placedBy = trapData.placedBy,
        object = trap
    }

    clientTraps[trapData.id] = clientTrap
    -- Add interaction to the trap for pickup
    AddEntityInteraction(trap, {
        {
            type = 'client',
            icon = 'fas fa-hand-paper',
            label = locale('labels.pick_up_trap'),
            distance = 2.0,
            onSelect = function()
                PickupTrap(trapData.id)
            end
        }
    }, true)
end

-- Event to add a single new trap
RegisterNetEvent('hunting:client:addTrap', function(trapData)
    CreateTrapObject(trapData)
end)

-- Event to remove a specific trap
RegisterNetEvent('hunting:client:removeTrap', function(trapId)
    local trap = clientTraps[trapId]
    if trap then
        if trap.object and DoesEntityExist(trap.object) then
            RemoveEntityInteraction(trap.object, nil, true)
            DeleteEntity(trap.object)
        end
        clientTraps[trapId] = nil
    end
end)

-- Sync traps from server (for initial load)
RegisterNetEvent('hunting:client:syncTraps', function(serverTraps)
    -- Clear existing trap objects and interactions
    for _, trap in pairs(clientTraps) do
        if trap.object and DoesEntityExist(trap.object) then
            RemoveEntityInteraction(trap.object, nil, true)
            DeleteEntity(trap.object)
        end
    end

    -- Clear client traps
    clientTraps = {}

    -- Create new trap objects based on server data
    for _, trapData in ipairs(serverTraps) do
        CreateTrapObject(trapData)
    end
end)

function PickupTrap(trapId)
    -- Check if trap still exists
    if not clientTraps[trapId] then
        Framework.Notify(locale('notifications.trap_not_found'), 'error')
        return
    end

    local trap = clientTraps[trapId]

    -- Check if player is close enough to the trap
    local playerCoords = GetEntityCoords(cache.ped)
    local trapCoords = trap.coords
    local distance = #(playerCoords - trapCoords)

    if distance > 3.0 then
        Framework.Notify(locale('notifications.too_far_from_trap'), 'error')
        return
    end

    -- Show progress bar
    local progressResult = lib.progressBar({
        duration = 3000,
        label = locale('progress.picking_up_trap'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'amb@prop_human_bum_bin@base',
            clip = 'base'
        }
    })

    if progressResult then
        -- Call server to handle trap pickup
        local success = lib.callback.await('hunting:server:pickupTrap', false, trapId)

        -- Note: Trap removal and sync will be handled by server event
    else
        Framework.Notify(locale('notifications.trap_pickup_cancelled'), 'error')
    end
end

function RemoveTraps()
    for _, trap in pairs(clientTraps) do
        if trap.object and DoesEntityExist(trap.object) then
            -- Remove interaction before deleting
            RemoveEntityInteraction(trap.object, nil, true)
            DeleteEntity(trap.object)
        end
    end
    clientTraps = {}
end

CreateThread(function()
    while true do
        local animalList = GetAliveAnimals()

        for _, animalHandle in pairs(animalList) do
            for _, trap in pairs(clientTraps) do
                local tCoords = trap.coords
                local aCoords = GetEntityCoords(animalHandle.entity)
                local dist = #(aCoords - tCoords)
                if dist < 3 then
                    -- apply trapped code here
                    TrapAnimal(animalHandle.entity, trap)
                end
            end
        end
        Wait(3000)
    end
end)


-- ▒█▀▀█ ▒█▀▀▀ ▒█▄░▒█ ▀▀█▀▀
-- ▒█▄▄▀ ▒█▀▀▀ ▒█▒█▒█ ░▒█░░
-- ▒█░▒█ ▒█▄▄▄ ▒█░░▀█ ░▒█░░
local function spawnVehicle()
    -- Call server to check money and rent vehicle
    local result = lib.callback.await('hunting:server:rentVehicle', false)

    if not result or not result.success then
        Framework.Notify(result and result.message or locale('notifications.vehicle_rent_failed'), 'error')
        return
    end

    -- Vehicle is already spawned on server, just notify success
    Framework.Notify(locale('notifications.vehicle_rented_successfully'), 'success')
end

-- Function to check if player has a rented vehicle nearby
local function hasRentedVehicleNearby()
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local vehicles = lib.getNearbyVehicles(playerCoords, 25.0, true)

    for _, v in pairs(vehicles) do
        if DoesEntityExist(v.vehicle) then
            -- Check if vehicle is a hunting rental using entity state
            local isHuntingRental = Entity(v.vehicle).state.huntingRental

            if isHuntingRental then
                -- Check ownership (server-side verification)
                local vehicleNetId = NetworkGetNetworkIdFromEntity(v.vehicle)
                local isOwner = lib.callback.await('hunting:server:checkVehicleOwnership', false, vehicleNetId)

                if isOwner then
                    return true, v.vehicle, vehicleNetId
                end
            end
        end
    end

    return false, nil, nil
end

-- Function to return rented vehicle
local function returnVehicle()
    local hasVehicle, vehicle, vehicleNetId = hasRentedVehicleNearby()

    if not hasVehicle then
        Framework.Notify(locale('notifications.no_rented_vehicle_nearby'), 'error')
        return { success = false, message = locale('notifications.no_rented_vehicle_nearby') }
    end

    local vehicleDisplayName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    -- Call server to return vehicle
    local result = lib.callback.await('hunting:server:returnVehicle', false, vehicleNetId, vehicleDisplayName)

    return result
end

RegisterNUICallback('rentVehicle', function(data, cb)
    -- Yakındaki kiralık araç kontrolü
    local hasVehicle, vehicle, vehicleNetId = hasRentedVehicleNearby()

    if hasVehicle then
        -- Kiralık araç bulundu, iade et
        local result = returnVehicle()
        cb(result)
        return
    end

    -- Kiralık araç bulunamadı, yeni araç kirala
    spawnVehicle()
    cb('ok')
end)

RegisterNUICallback('hasRentedVehicle', function(data, cb)
    local hasVehicle, vehicle, vehicleNetId = hasRentedVehicleNearby()
    cb(hasVehicle)
end)

-- Vehicle return zone
local vehicleReturnZone = lib.zones.box({
    coords = Shared.Rent.coords,
    size = vec3(5, 10, 3),
    rotation = Shared.Rent.heading,
    debug = false,
    inside = function()
        local ped = cache.ped
        local vehicle = GetVehiclePedIsIn(ped, false)

        -- Check if player is in a vehicle
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
            -- Check if it's a hunting rented vehicle using entity state
            local isHuntingRental = Entity(vehicle).state.huntingRental
            local rentalOwner = Entity(vehicle).state.huntingRentalOwner

            -- Client-side ownership check using entity state (no server callback needed)
            if isHuntingRental and rentalOwner == cache.serverId then
                -- Show text UI
                lib.showTextUI('[E] - ' .. locale('ui.returnRentedVehicle'), {
                    position = "left-center",
                    icon = 'car'
                })

                -- Check for E key press
                if IsControlJustPressed(0, 38) then -- E key
                    lib.hideTextUI()
                    returnVehicle()
                end
                return
            end
        end

        -- Hide text UI if conditions not met
        lib.hideTextUI()
    end,
    onExit = function()
        lib.hideTextUI()
    end
})


-- ▀█▀ ░█▀▀▄ 　 ░█▀▀█ ─█▀▀█ ░█▀▀█ ░█▀▀▄
-- ░█─ ░█─░█ 　 ░█─── ░█▄▄█ ░█▄▄▀ ░█─░█
-- ▄█▄ ░█▄▄▀ 　 ░█▄▄█ ░█─░█ ░█─░█ ░█▄▄▀



-- ▒█▀▀█ ▒█▀▀▀ ▒█▄░▒█ ▒█▀▀▀ ▒█▀▀█ ░█▀▀█ ▒█░░░
-- ▒█░▄▄ ▒█▀▀▀ ▒█▒█▒█ ▒█▀▀▀ ▒█▄▄▀ ▒█▄▄█ ▒█░░░
-- ▒█▄▄█ ▒█▄▄▄ ▒█░░▀█ ▒█▄▄▄ ▒█░▒█ ▒█░▒█ ▒█▄▄█


function OpenMenu()
    SetNuiFocus(true, true)

    local uiConfig = Config
    uiConfig.Peds = nil

    local uiShared = Shared
    uiShared.Shop.Ped = nil

    SendNUIMessage({
        action = 'OPEN_SHOP',
        data = {
            show = true,
            config = uiConfig,
            shared = uiShared,
            shop = shopData(),
            wiki = returnWiki(),
            inventory = returnInventory(),
            leaderboard = returnLeaderboard(),
            profile = returnProfile(),
            financials = returnMoney(),
            animals = BuildAnimalsTable()
        },
    })
end

exports('OpenMenu', OpenMenu)
RegisterNetEvent('hunting:client:OpenMenu', OpenMenu)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    TriggerEvent('hunting:handler:closeUI')
    cb('ok')
end)

function EnableLevelUpgrades()
    Wait(30000)
    local level = lib.callback.await('hunting:server:getPlayerLevel', false)
    if level and level >= 1 then
        VisorKeybind:disable(false)
    end
end

function IsHoldingHuntingWeapon()
    local huntingWeapons = Config.HuntingWeapons
    local weapon = GetSelectedPedWeapon(cache.ped)
    for _, v in pairs(huntingWeapons) do
        if weapon == GetHashKey(v) then
            return true
        end
    end
    return false
end

local testDeer = nil
local currentTrap = nil

-- Resource stop olduğunda temizlik
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if testDeer and DoesEntityExist(testDeer) then
            DeletePed(testDeer)
        end
        if currentTrap and DoesEntityExist(currentTrap) then
            DeleteObject(currentTrap)
        end
    end
end)


function CheckHitAnimalQuality(entity, isTrapped)
    if not entity then
        return false
    end

    local quality = 1

    -- Avcının seviyesini al
    local hunterLevel = lib.callback.await('hunting:server:getPlayerLevel', false) or 1
    -- Hayvanın vurulduğu bölgeyi tespit et
    local hitBone = GetPedLastDamageBone(entity)
    local hitQuality = 1 -- Varsayılan kalite (gövde)

    -- Kafa bölgesi kontrolü (bone 99 ve 98)
    if hitBone then
        if hitBone == 99 or hitBone == 98 then
            hitQuality = 3 -- En kaliteli (kafa vuruşu)
        elseif hitBone >= 1 and hitBone <= 20 then
            hitQuality = 2 -- Orta kalite (bacak/ayak vuruşu)
        else
            hitQuality = 1 -- Düşük kalite (gövde vuruşu)
        end
    end

    -- Kalite hesaplama
    if isTrapped then
        -- Tuzaklı hayvanlar 2. kalite
        quality = 3
    else
        -- Vuruş bölgesine göre kalite
        quality = hitQuality
    end

    -- Avcı seviyesine göre kalite artışı
    local levelBonus = math.floor(hunterLevel / 3) -- Her 3 seviyede 1 kalite artışı
    if levelBonus > 0 then
        quality = math.min(3, quality + levelBonus)
    end

    return quality
end

-- Güvenli GetEntityArchetypeName wrapper fonksiyonu
local function SafeGetEntityArchetypeName(entity)
    if not entity or not DoesEntityExist(entity) then
        return nil
    end

    local success, modelName = pcall(GetEntityArchetypeName, entity)
    if success and modelName then
        return modelName
    else
        -- Alternatif olarak GetEntityModel kullan
        local modelHash = GetEntityModel(entity)
        if modelHash and modelHash ~= 0 then
            -- Model hash'ini string'e çevir (hex format)
            return string.format("0x%08X", modelHash)
        end
        return nil
    end
end

function CheckAnimalType(entity)
    if not entity or not DoesEntityExist(entity) then
        return nil
    end

    local modelName = SafeGetEntityArchetypeName(entity)
    if not modelName then
        return nil
    end


    -- Convert model name to animal type for config lookup
    local animalType = nil

    -- Check Shared.Species to find matching animal type
    for speciesKey, speciesData in pairs(Shared.Species) do
        if speciesData.model == modelName then
            animalType = speciesData.type
            break
        end
    end

    -- Eğer direkt match bulunamazsa, model hash ile de kontrol et
    if not animalType then
        local modelHash = GetEntityModel(entity)
        for speciesKey, speciesData in pairs(Shared.Species) do
            -- Model string'i hash ise karşılaştır
            if speciesData.model and (
                    speciesData.model == modelName or
                    GetHashKey(speciesData.model) == modelHash or
                    speciesData.model == string.format("0x%08X", modelHash)
                ) then
                animalType = speciesData.type
                break
            end
        end
    end

    if not animalType then
        -- Shared.Species'teki tüm modelleri listele (debug için) - sadece ilk 5 tanesini göster
        local count = 0
        for key, data in pairs(Shared.Species) do
            if count < 5 then
                count = count + 1
            else
                break
            end
        end
    end

    return animalType
end

-- Clean up dead animals when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for entity, _ in pairs(deadAnimals) do
            if DoesEntityExist(entity) then
                DeleteEntity(entity)
            end
        end
        deadAnimals = {}
    end
end)

-- Cache for animal config from server
local cachedAnimalConfig = nil

-- Get animal config from server
local function getAnimalConfig()
    if not cachedAnimalConfig then
        cachedAnimalConfig = lib.callback.await('hunting:server:getAnimalConfig', false) or {}
    end
    return cachedAnimalConfig
end

function CheckObjectType(object)
    local objectModel = GetEntityArchetypeName(object)
    if not objectModel then
        return nil
    end

    -- Fallback models mapping
    local fallbackModels = {
        leg = 'propk_redpanda_arm_raw',
        beef = 'propk_deer_beef_raw',
        rib = 'propk_deer_rib_raw',
        body = 'propk_pork_beef_big_raw',
    }

    -- Get animal config from server
    local animalConfig = getAnimalConfig()

    -- Check all animal configs for the model
    for animalType, animalConfig in pairs(animalConfig) do
        if animalConfig.meat and animalConfig.meat.parts then
            for partType, partConfig in pairs(animalConfig.meat.parts) do
                if partConfig.model == objectModel then
                    return partType
                end
            end
        end
    end

    -- Check fallback models
    for partType, fallbackModel in pairs(fallbackModels) do
        if fallbackModel == objectModel then
            return partType
        end
    end

    -- Check if it's a hide object
    if objectModel == 'hei_prop_hei_paper_bag' then
        return 'hide'
    end

    return nil
end

RegisterNUICallback('getCookableItems', function(data, cb)
    local items = lib.callback.await('hunting:server:getPlayerInventoryItems', false)
    -- Update cooking times based on server config
    for i, item in ipairs(items) do
        local cookingTime = 5 -- Default cooking time

        -- Check if item has a model that matches cooking config
        if item.item then
            -- Get cooking config from server for this item
            local cookingConfig = lib.callback.await('hunting:server:getCookingConfigByItem', false, item.item)
            if cookingConfig then
                cookingTime = cookingConfig.cookingTime
            end
        end

        -- Update the item's cooking time
        items[i].cookingTime = cookingTime
    end

    cb(items)
end)

function BuildAnimalsTable()
    local result = {}

    for type, species in pairs(Shared.Species) do
        local foundZone = nil
        for _, zone in pairs(Config.HuntingZones) do
            if zone.type == type then
                foundZone = zone
                break
            end
        end
        if foundZone then
            table.insert(result, {
                type = type,
                name = species.name,
                description = locale('animals.click_to_find_location', species.name),
                position = { x = foundZone.coords.y, y = foundZone.coords.x, radius = foundZone.range }
            })
        end
    end

    return result
end

RegisterNUICallback('sellItems', function(data, cb)
    local items = lib.callback.await('hunting:server:sellItems', false, data)
    cb(items)
end)


lib.onCache('weapon', function(value)
    if not value then return end
    if not Config.DisableHuntingRiflePVP then return end
    -- Check if the current weapon is a hunting weapon
    if Functions.IsHuntingWeapon(value) then
        DebugLog('Player is holding hunting weapon, proceed disable aim', 'weaponAim')
        local holding = true
        local sleep = 250
        local currentWeaponHash = value
        local aimStartTime = nil
        local aimDelayActive = false

        CreateThread(function()
            while holding and GetSelectedPedWeapon(PlayerPedId()) == currentWeaponHash do
                local isRightClickAiming = IsControlPressed(0, 25)
                if IsPlayerFreeAiming(PlayerId()) or isRightClickAiming or IsAimCamActive() then
                    sleep = 0
                    DisableControlAction(0, 22, true) -- INPUT_JUMP (Space)

                    -- Aim başladığında zamanlayıcıyı başlat
                    if not aimStartTime then
                        aimStartTime = GetGameTimer()
                        aimDelayActive = true
                    end

                    -- Yarım saniyelik delay kontrolü
                    local timeSinceAimStart = GetGameTimer() - aimStartTime
                    if aimDelayActive and timeSinceAimStart < 500 then
                        -- 500ms içinde ateş etmeyi engelle
                        DisablePlayerFiring(PlayerId(), true)
                    else
                        aimDelayActive = false
                        -- Eğer oyuncu bir kişiye nişan alıyorsa ve o kişi bir oyuncuysa, ateş etmeyi engelle
                        local _, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                        if entity and IsEntityAPed(entity) and IsPedAPlayer(entity) then
                            DisablePlayerFiring(PlayerId(), true)
                        end
                    end
                else
                    -- Aim bırakıldığında zamanlayıcıyı sıfırla
                    aimStartTime = nil
                    aimDelayActive = false
                    -- Aim almadan ateş etmeyi engelle
                    sleep = 0
                    DisableControlAction(0, 24, true)  -- INPUT_ATTACK (Sol Tık)
                    DisableControlAction(0, 257, true) -- INPUT_ATTACK2 (Sol Tık alternatif)
                end
                -- Eğer oyuncu artık hunting silahını tutmuyorsa loop'u bitir
                if not Functions.IsHuntingWeapon(GetSelectedPedWeapon(PlayerPedId())) then
                    holding = false
                end

                Wait(sleep)
            end
        end)
    end
end)

-- Clean up trap interactions when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        RemoveTraps()
    end
end)

-- Sync traps when player joins
CreateThread(function()
    -- Wait for player to be fully loaded
    while not cache.ped do
        Wait(100)
    end

    -- Request current traps from server
    local serverTraps = lib.callback.await('hunting:server:getTraps', false)
    if serverTraps and #serverTraps > 0 then
        TriggerEvent('hunting:client:syncTraps', serverTraps)
    end
end)

-- UI Translations
local UITranslations = {}

-- Receive UI translations from server
RegisterNetEvent('dusa_hunting:setUITranslations', function(translations)
    Wait(1500)
    UITranslations = translations
    lib.locale(Config.Locale)
    -- Send translations to DUI
    if UITranslations and next(UITranslations) then
        SendNUIMessage({
            action = 'language',
            data = UITranslations
        })
    end
end)

-- Helper function to count table elements
function table_count(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- Request UI translations when client starts
CreateThread(function()
    -- Wait for player to spawn
    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(100)
    end

    -- Request UI translations from server
    TriggerServerEvent('dusa_hunting:requestUITranslations')
end)

-- Handle shot count update from server
RegisterNetEvent('hunting:client:updateShotCount', function(newShotCount)
    -- Send NUI event to update UI with new shot count
    SendNUIMessage({
        action = "UPDATE_SHOT_COUNT",
        shotCount = newShotCount
    })
end)
