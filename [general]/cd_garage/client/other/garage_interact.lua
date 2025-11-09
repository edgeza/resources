if Config.SpawnGaragePeds then
    GaragePeds = {}

    local pedModelHash = `s_m_y_valet_01`

    for _, cd in pairs(Config.Locations) do
        GaragePeds[#GaragePeds+1] = {
            spawned = false,
            coords = vector(cd.x_1, cd.y_1, cd.z_1),
            heading = cd.h_2,
        }
    end

    local function SetPlayerCoordsSafely(ped, coords)
        local x, y, z = coords.x, coords.y, coords.z
        local ground_found = false
        local ground_Z = z
        local attempt = 0

        while not ground_found and attempt < 50 do
            ground_found, ground_Z = GetGroundZFor_3dCoord(x, y, z, true)
            if ground_found and math.abs(ground_Z - z) > 0.1 then
                break
            end

            z = z - 10.0
            attempt = attempt + 1
            Wait(100)
        end
        SetEntityCoords(ped, x, y, ground_Z, false, false, false, true)
    end

    local function SpawnStaticPed(coords, heading)
        RequestModel(pedModelHash)
        local timeout = 0
        while not HasModelLoaded(pedModelHash) and timeout <= 50 do
            Wait(0)
            timeout=timeout+1
        end
        local ped = CreatePed(0, pedModelHash, coords.x, coords.y, coords.z, heading, false, true)
        SetPlayerCoordsSafely(ped, coords)
        SetModelAsNoLongerNeeded(pedModelHash)
        SetEntityInvincible(ped, true)
        SetEntityProofs(ped, true, true, true, true, true, true, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanPlayAmbientAnims(ped, false)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetEntityCollision(ped, false, false)
        SetEntityAsMissionEntity(ped, true, true)
        ClearPedTasksImmediately(ped)
        return ped
    end

    local function CheckDuplicatedPed(coords)
        local peds = GetGamePool('CPed')
        for _, ped in ipairs(peds) do
            if DoesEntityExist(ped) then
                local pedModel = GetEntityModel(ped)
                local pedPos = GetEntityCoords(ped)

                if pedModel == pedModelHash and #(pedPos - coords) < 1.0 then
                    SetEntityAsNoLongerNeeded(ped)
                    DeleteEntity(ped)
                end
            end
        end
    end

    CreateThread(function()
        while true do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            for _, pedData in pairs(GaragePeds) do
                local inDistance = false
                local dist = #(playerCoords - pedData.coords)
                if dist < 50.0 then
                    inDistance = true
                end
                if not pedData.spawned and inDistance then
                    CheckDuplicatedPed(pedData.coords)
                    pedData.ped = SpawnStaticPed(pedData.coords, pedData.heading)
                    pedData.spawned = true
                elseif pedData.spawned and not inDistance then
                    if pedData.ped and DoesEntityExist(pedData.ped) then
                        SetEntityAsNoLongerNeeded(pedData.ped)
                        DeleteEntity(pedData.ped)
                    end
                    pedData.spawned = false
                end

            end
            Wait(1000)
        end
    end)
end

if Config.GarageInteractMethod == 'cd_drawtextui' or Config.GarageInteractMethod == 'jg-textui' or Config.GarageInteractMethod == 'okokTextUI' or Config.GarageInteractMethod == 'ps-ui' or Config.GarageInteractMethod == 'qbcore' or Config.GarageInteractMethod == 'vms_notifyv2' then

    --Public Garages
    CreateThread(function()
        local pausemenuopen = false
        local alreadyEnteredZone = false
        local GlobalText = nil
        local GlobalText_last = nil
        local wait = 5
        local garageRaidConfig = Config.GarageRaid.ENABLE
        while true do
            wait = 5
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local inZone = false
            local canRaidGarage = garageRaidConfig and HasGarageRaidingPerms()

            for cd = 1, #Config.Locations do
                local self = Config.Locations[cd]
                local dist = #(coords-vector3(self.x_1, self.y_1, self.z_1))
                if dist <= self.Dist then
                    wait = 5
                    inZone = true
                    GlobalText = self.Name

                    if canRaidGarage and not self.ImpoundName then
                        GlobalText = GlobalText..'</p>'..L('notif_garage_raid')
                    end
                    if InVehicle() then
                        GlobalText = '<b>'..L('garage')..'</b></p>'..L('notif_storevehicle')
                    end

                    if not CooldownActive then
                        if IsControlJustReleased(0, Config.Keys.QuickChoose_Key) then
                            TriggerEvent('cd_garage:EnterGarage_Outside', cd)
                        elseif IsControlJustReleased(0, Config.Keys.EnterGarage_Key) and self.EventName2 == 'cd_garage:EnterGarage' then
                            TriggerEvent('cd_garage:EnterGarage_Inside', cd)
                        elseif IsControlJustReleased(0, Config.Keys.StoreVehicle_Key) then
                            TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                        elseif IsControlJustReleased(0, Config.Keys.GarageRaid_Key) and canRaidGarage and not self.ImpoundName then
                            TriggerEvent('cd_garage:GarageRaid', self.Garage_ID)
                        end
                    end
                    if not pausemenuopen and IsPauseMenuActive() then
                        pausemenuopen = true
                        DrawTextUI('hide')
                    elseif pausemenuopen and not IsPauseMenuActive() then
                        pausemenuopen = false
                        DrawTextUI('show', GlobalText)
                    end
                    break
                else
                    wait = 1000
                end
            end

            if not pausemenuopen then
                if inZone and not alreadyEnteredZone then
                    alreadyEnteredZone = true
                    DrawTextUI('show', GlobalText)
                end

                if GlobalText_last ~= GlobalText then
                    DrawTextUI('show', GlobalText)
                end

                if not inZone and alreadyEnteredZone then
                    alreadyEnteredZone = false
                    DrawTextUI('hide')
                end
                GlobalText_last = GlobalText
            end
            Wait(wait)
        end
    end)

    if Config.Impound.ENABLE then
        --Impound
        CreateThread(function()
            local pausemenuopen = false
            local alreadyEnteredZone = false
            local wait = 5
            local Dist = 5
            local impoundText = '<b>'..L('impound')..'</b></p> '..L('open_impound')
            while true do
                wait = 5
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local inZone = false

                for c, d in pairs(Config.ImpoundLocations) do
                    local dist = #(coords-vector3(d.coords.x, d.coords.y, d.coords.z))
                    if dist <= Dist then
                        wait = 5
                        inZone = true
                        
                        if not CooldownActive then
                            if IsControlJustReleased(0, Config.Keys.QuickChoose_Key) then
                                OpenImpound(d.ImpoundID)
                            end
                        end
                        if not pausemenuopen and IsPauseMenuActive() then
                            pausemenuopen = true
                            DrawTextUI('hide')
                        elseif pausemenuopen and not IsPauseMenuActive() then
                            pausemenuopen = false
                            DrawTextUI('show', impoundText)
                        end
                        break
                    else
                        wait = 1000
                    end
                end

                if not pausemenuopen then
                    if inZone and not alreadyEnteredZone then
                        alreadyEnteredZone = true
                        DrawTextUI('show', impoundText)
                    end

                    if not inZone and alreadyEnteredZone then
                        alreadyEnteredZone = false
                        DrawTextUI('hide')
                    end
                end
                Wait(wait)
            end
        end)
    end

    if Config.JobVehicles.ENABLE then
        --Job Garage
        CreateThread(function()
            local pausemenuopen = false
            local alreadyEnteredZone = false
            local GlobalText = nil
            local GlobalText_last = nil
            local wait = 5
            while true do
                wait = 5
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local job = GetJob().name
                local inZone = false
                -- Allow patreon jobs regardless of duty (they have defaultDuty = true)
                local canAccess = on_duty or (job == 'patreon1' or job == 'patreon2' or job == 'patreon3')
                if Config.JobVehicles.Locations[job] ~= nil and canAccess then
                    for cd = 1, #Config.JobVehicles.Locations[job] do
                        local self = Config.JobVehicles.Locations[job][cd]
                        local dist = #(coords-vector3(self.coords.x, self.coords.y, self.coords.z))
                        if dist <= self.distance then
                            wait = 5
                            inZone = true
                            GlobalText = '<b>'..L('job_garage')..'</b></p>'..L('open_garage_1').. '</p>'..L('notif_storevehicle')
                            if InVehicle() then
                                GlobalText = '<b>'..L('job_garage')..'</b></p>'..L('notif_storevehicle')
                            end

                            if not CooldownActive then
                                if IsControlJustReleased(0, Config.Keys.QuickChoose_Key) then
                                    if not InVehicle() then
                                        TriggerEvent('cd_garage:Cooldown', 3000)
                                        if Config.JobVehicles.ENABLE and self.method == 'societyowned' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, self.garage_type, true, self.spawn_coords)
                                        elseif Config.JobVehicles.ENABLE and self.method == 'personalowned' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, self.garage_type, false, self.spawn_coords)
                                        elseif self.method == 'regular' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'not_owned', job, self.garage_type, Config.JobVehicles.RegularMethod[job], self.spawn_coords)
                                        end
                                    else
                                        Notif(3, 'get_out_veh')
                                    end
                                elseif IsControlJustReleased(0, Config.Keys.StoreVehicle_Key) then
                                    TriggerEvent('cd_garage:Cooldown', 1000)
                                    if Config.JobVehicles.ENABLE and self.method == 'societyowned' then
                                        TriggerEvent('cd_garage:StoreVehicle_Main', false, job, false)
                                    elseif Config.JobVehicles.ENABLE and self.method == 'personalowned' then
                                        TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                                    elseif self.method == 'regular' then
                                        local vehicle = GetClosestVehicle(5)
                                        if self.garage_type == 'boat' then
                                            Teleport(ped, self.coords.x, self.coords.y, self.coords.z, 90, false)
                                        end
                                        if vehicle then
                                            if IsPedInVehicle(ped, vehicle, true) then
                                                TaskLeaveVehicle(ped, vehicle, 0)
                                                while IsPedInVehicle(ped, vehicle, true) do
                                                    Wait(0)
                                                end
                                            end
                                            CD_DeleteVehicle(vehicle)
                                            Notif(1, 'vehicle_stored')
                                        else
                                            Notif(3, 'no_vehicle_found')
                                        end
                                    end
                                end
                            end
                            if not pausemenuopen and IsPauseMenuActive() then
                                pausemenuopen = true
                                DrawTextUI('hide')
                            elseif pausemenuopen and not IsPauseMenuActive() then
                                pausemenuopen = false
                                DrawTextUI('show', GlobalText)
                            end
                            break
                        else
                            wait = 1000
                        end
                    end
                    
                    if not pausemenuopen then
                        if inZone and not alreadyEnteredZone then
                            alreadyEnteredZone = true
                            DrawTextUI('show', GlobalText)
                        end

                        if GlobalText_last ~= GlobalText then
                            DrawTextUI('show', GlobalText)
                        end

                        if not inZone and alreadyEnteredZone then
                            alreadyEnteredZone = false
                            DrawTextUI('hide')
                        end
                        GlobalText_last = GlobalText
                    end
                else
                    if alreadyEnteredZone or inZone then
                        alreadyEnteredZone, inZone, pausemenuopen = false, false, false
                        DrawTextUI('hide')
                    end
                    wait = 5000
                end
                Wait(wait)
            end
        end)
    end

else

    function CreateInsideGarageExit(shellDoorCoords)
        if Config.GarageInteractMethod == 'ox_target' then
            exports.ox_target:addSphereZone({
                coords = vector3(shellDoorCoords.x, shellDoorCoords.y, shellDoorCoords.z+1),
                name = 'Garage Exit: '..#Config.Locations,
                radius = 5.0,
                debug = false,
                drawSprite = false,
                options = {
                    {
                        label = L('exit_garage'),
                        name = 'exit_garage',
                        icon = 'fa-solid fa-door-open',
                        iconColor = 'orange',
                        distance = 10.0,
                        onSelect = function()
                            TriggerEvent('cd_garage:Exit')
                        end
                    }
                },
            })
        elseif Config.GarageInteractMethod == 'qb-target' then
            exports['qb-target']:AddCircleZone('Garage Exit: '..#Config.Locations, vector3(shellDoorCoords.x, shellDoorCoords.y, shellDoorCoords.z+1), 5.0, {
                name = 'Garage Exit: '..#Config.Locations,
                debugPoly = false,
                useZ = true
            }, {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = "fa-solid fa-door-open",
                    label = L('exit_garage'),
                    targeticon = "fa-solid fa-car",
                    action = function()
                        TriggerEvent('cd_garage:Exit')
                    end,
                    drawDistance = 10.0,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {0, 255, 0, 255}
                },
            },
            distance = 5.0
            })
        end
    end

    Wait(500)
    if Config.GarageInteractMethod == 'ox_target' then
        for c, d in pairs(Config.Locations) do
            exports.ox_target:addSphereZone({
                coords = vector3(d.x_1, d.y_1, d.z_1),
                name = 'Garage: '..c,
                radius = d.Dist,
                debug = false,
                drawSprite = false,
                options = {
                    {
                        label = L('open_garage'),
                        name = 'open_garage',
                        icon = 'fa-solid fa-car',
                        iconColor = 'orange',
                        distance = d.Dist*2,
                        onSelect = function(data)
                            TriggerEvent('cd_garage:EnterGarage_Outside', c)
                        end
                    },

                    {
                        label = L('enter_garage'),
                        name = 'enter_garage',
                        icon = 'fa-solid fa-warehouse',
                        iconColor = 'orange',
                        distance = d.Dist*2,
                        onSelect = function()
                            TriggerEvent('cd_garage:EnterGarage_Inside', c)
                        end
                    },

                    {
                        label = L('store_vehicle'),
                        name = 'store_vehicle',
                        icon = 'fa-solid fa-trash',
                        iconColor = 'orange',
                        distance = d.Dist*2,
                        onSelect = function()
                            TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                        end
                    },

                    {
                        label = L('garage_raid'),
                        name = 'store_vehicle',
                        icon = 'fa-solid fa-handcuffs',
                        iconColor = 'orange',
                        distance = d.Dist*2,
                        onSelect = function()
                            TriggerEvent('cd_garage:GarageRaid', d.Garage_ID)
                        end,
                        canInteract = function()
                            return not d.ImpoundName and Config.GarageRaid.ENABLE and HasGarageRaidingPerms()
                        end,
                    }
                },

            })
        end

        if Config.Impound.ENABLE then
            for c, d in pairs(Config.ImpoundLocations) do
                exports.ox_target:addSphereZone({
                    coords = vector3(d.coords.x, d.coords.y, d.coords.z),
                    name = 'Impound: '..c,
                    radius = 10.0,
                    debug = false,
                    drawSprite = false,
                    options = {
                        {
                            label = L('impound'),
                            name = 'impound',
                            icon = 'fa-solid faa-warehouse',
                            iconColor = 'orange',
                            distance = 20.0,
                            onSelect = function()
                                OpenImpound(d.ImpoundID)
                            end,
                        }
                    },

                })
            end
        end

        if Config.JobVehicles.ENABLE then
            for c, d in pairs(Config.JobVehicles.Locations) do
                for cc, dd in pairs(d) do
                    exports.ox_target:addSphereZone({
                        coords = vector3(dd.coords.x, dd.coords.y, dd.coords.z),
                        name = 'Job Garage: '..c..' - '..cc,
                        radius = dd.distance,
                        debug = false,
                        drawSprite = false,
                        options = {
                            {
                                label = L('open_garage'),
                                name = 'open_job_garage',
                                icon = 'fa-solid fa-car',
                                iconColor = 'orange',
                                distance = dd.distance*2,
                                onSelect = function()
                                    local job = GetJob().name
                                    local hasJob = CheckJob(job)
                                    if hasJob then
                                        if dd.method == 'societyowned' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, dd.garage_type, true, dd.spawn_coords)
                                        elseif dd.method == 'personalowned' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, dd.garage_type, false, dd.spawn_coords)
                                        elseif dd.method == 'regular' then
                                            TriggerEvent('cd_garage:JobVehicleSpawn', 'not_owned', job, dd.garage_type, Config.JobVehicles.RegularMethod[job], dd.spawn_coords)
                                        end
                                    else
                                        Notif(3, 'no_permissions')
                                    end
                                end
                            },

                            {
                                label = L('store_vehicle'),
                                name = 'store_vehicle',
                                icon = 'fa-solid fa-trash',
                                iconColor = 'orange',
                                distance = dd.distance*2,
                                onSelect = function()
                                    local ped = PlayerPedId()
                                    local job = GetJob().name
                                    if dd.method == 'societyowned' then
                                        TriggerEvent('cd_garage:StoreVehicle_Main', false, job, false)
                                    elseif dd.method == 'personalowned' then
                                        TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                                    elseif dd.method == 'regular' then
                                        local vehicle = GetClosestVehicle(5)
                                        if dd.garage_type == 'boat' then
                                            Teleport(ped, dd.coords.x, dd.coords.y, dd.coords.z, 90, false)
                                        end
                                        if vehicle then
                                            if IsPedInVehicle(ped, vehicle, true) then
                                                TaskLeaveVehicle(ped, vehicle, 0)
                                                while IsPedInVehicle(ped, vehicle, true) do
                                                    Wait(0)
                                                end
                                            end
                                            CD_DeleteVehicle(vehicle)
                                            Notif(1, 'vehicle_stored')
                                        else
                                            Notif(3, 'no_vehicle_found')
                                        end
                                    end
                                end
                            }
                        },
                    })
                end
            end
        end


    elseif Config.GarageInteractMethod == 'qb-target' then
        for c, d in pairs(Config.Locations) do
            exports['qb-target']:AddCircleZone('Garage: '..c, vector3(d.x_1, d.y_1, d.z_1), d.Dist, {
                name = 'Garage: '..c,
                debugPoly = false,
                useZ = true
            }, {
            options = {
                {
                    num = 1,
                    type = "client",
                    icon = "fa-solid fa-car",
                    label = L('open_garage'),
                    targeticon = "fa-solid fa-car",
                    action = function()
                        TriggerEvent('cd_garage:EnterGarage_Outside', c)
                    end,
                    drawDistance = d.Dist*2,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {0, 255, 0, 255}
                },

                {
                    num = 2,
                    type = "client",
                    icon = "fa-solid fa-warehouse",
                    label = L('enter_garage'),
                    targeticon = "fa-solid fa-car",
                    action = function()
                        TriggerEvent('cd_garage:EnterGarage_Inside', c)
                    end,
                    drawDistance = d.Dist*2,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {0, 255, 0, 255}
                },

                {
                    num = 3,
                    type = "client",
                    icon = "fa-solid fa-trash",
                    label = L('store_vehicle'),
                    targeticon = "fa-solid fa-car",
                    action = function()
                        TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                    end,
                    drawDistance = d.Dist*2,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {0, 255, 0, 255}
                },

                {
                    num = 4,
                    type = "client",
                    icon = "fa-solid fa-handcuffs",
                    label = L('garage_raid'),
                    targeticon = "fa-solid fa-car",
                    action = function()
                        TriggerEvent('cd_garage:GarageRaid', d.Garage_ID)
                    end,
                    canInteract = function()
                        return not d.ImpoundName and Config.GarageRaid.ENABLE and HasGarageRaidingPerms()
                    end,
                    drawDistance = d.Dist*2,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {0, 255, 0, 255},
                }
            },
            distance = d.Dist
            })
        end

        if Config.Impound.ENABLE then
            for c, d in pairs(Config.ImpoundLocations) do
                exports['qb-target']:AddCircleZone('Impound: '..c, vector3(d.coords.x, d.coords.y, d.coords.z), 10.0, {
                    name = 'Impound: '..c,
                    debugPoly = false,
                    useZ = true
                }, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        icon = "fa-solid fa-car",
                        label = L('impound'),
                        targeticon = "fa-solid fa-car",
                        action = function()
                            OpenImpound(d.ImpoundID)
                        end,
                        drawDistance = 20.0,
                        drawColor = {255, 255, 255, 255},
                        successDrawColor = {0, 255, 0, 255}
                    },
                },
                distance = 10.0
                })
            end
        end

        if Config.JobVehicles.ENABLE then
            for c, d in pairs(Config.JobVehicles.Locations) do
                for cc, dd in pairs(d) do
                    exports['qb-target']:AddCircleZone('Job Garage: '..c..' - '..cc, vector3(dd.coords.x, dd.coords.y, dd.coords.z), dd.distance, {
                        name = 'Job Garage: '..c..' - '..cc,
                        debugPoly = false,
                        useZ = true
                    }, {
                    options = {
                        {
                            num = 1,
                            type = "client",
                            icon = "fa-solid fa-car",
                            label = L('open_garage'),
                            targeticon = "fa-solid fa-car",
                            action = function()
                                local job = GetJob().name
                                local hasJob = CheckJob(job)
                                if hasJob then
                                    if dd.method == 'societyowned' then
                                        TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, dd.garage_type, true, dd.spawn_coords)
                                    elseif dd.method == 'personalowned' then
                                        TriggerEvent('cd_garage:JobVehicleSpawn', 'owned', job, dd.garage_type, false, dd.spawn_coords)
                                    elseif dd.method == 'regular' then
                                        TriggerEvent('cd_garage:JobVehicleSpawn', 'not_owned', job, dd.garage_type, Config.JobVehicles.RegularMethod[job], dd.spawn_coords)
                                    end
                                else
                                    Notif(3, 'no_permissions')
                                end
                            end,
                            drawDistance = dd.distance*2,
                            drawColor = {255, 255, 255, 255},
                            successDrawColor = {0, 255, 0, 255}
                        },

                        {
                            num = 2,
                            type = "client",
                            icon = "fa-solid fa-car",
                            label = L('store_vehicle'),
                            targeticon = "fa-solid fa-trash",
                            action = function()
                                local ped = PlayerPedId()
                                local job = GetJob().name
                                if dd.method == 'societyowned' then
                                    TriggerEvent('cd_garage:StoreVehicle_Main', false, job, false)
                                elseif dd.method == 'personalowned' then
                                    TriggerEvent('cd_garage:StoreVehicle_Main', false, false, false)
                                elseif dd.method == 'regular' then
                                    local vehicle = GetClosestVehicle(5)
                                    if dd.garage_type == 'boat' then
                                        Teleport(ped, dd.coords.x, dd.coords.y, dd.coords.z, 90, false)
                                    end
                                    if vehicle then
                                        if IsPedInVehicle(ped, vehicle, true) then
                                            TaskLeaveVehicle(ped, vehicle, 0)
                                            while IsPedInVehicle(ped, vehicle, true) do
                                                Wait(0)
                                            end
                                        end
                                        CD_DeleteVehicle(vehicle)
                                        Notif(1, 'vehicle_stored')
                                    else
                                        Notif(3, 'no_vehicle_found')
                                    end
                                end
                            end,
                            drawDistance = dd.distance*2,
                            drawColor = {255, 255, 255, 255},
                            successDrawColor = {0, 255, 0, 255}
                        },
                    },
                    distance = dd.distance
                    })
                end
            end
        end
    end
end
