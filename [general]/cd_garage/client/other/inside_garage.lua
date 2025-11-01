if Config.InsideGarage.ENABLE then
    
    RegisterNetEvent('cd_garage:StartThread_1')
    AddEventHandler('cd_garage:StartThread_1', function()
        CreateThread(function()
            while true do
                Wait(5)
                if InGarage and MyCars ~= nil then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local vehicle = GetClosestVehicleData(coords, 5.1)
                    if vehicle.state then
                        for cd = 1, #MyCars do
                            if MyCars[cd] ~= nil then
                                -- Patreon-only garage filter: hide vehicles not in tier when inside Patreon garage
                                if CurrentGarage == 'Patreon Hub' and Config.PatreonTiers and Config.PatreonTiers.ENABLE then
                                    local appearsInAny = false
                                    local minTier = nil
                                    for t, tierData in pairs(Config.PatreonTiers.tiers or {}) do
                                        local list = (tierData and tierData.vehicles) or {}
                                        for i = 1, #list do
                                            if tostring(list[i]):upper() == tostring(MyCars[cd].vehicle.model):upper() then
                                                appearsInAny = true
                                                minTier = (minTier and math.min(minTier, t)) or t
                                            end
                                        end
                                    end
                                    if appearsInAny then
                                        local p = QBCore and QBCore.Functions.GetPlayerData() or nil
                                        local md = p and p.metadata or {}
                                        local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                                        local tier = md and md[key]
                                        local tierNum = 0
                                        if type(tier) == 'number' then tierNum = tier elseif type(tier) == 'string' then tierNum = tonumber(tier) or 0 end
                                        if (Config.PatreonTiers.inherit ~= false and tierNum < (minTier or 1)) or (Config.PatreonTiers.inherit == false and tierNum ~= (minTier or 1)) then
                                            goto continue_thread1
                                        end
                                    else
                                        -- Not in any tier list: do not display in Patreon Garage
                                        goto continue_thread1
                                    end
                                end
                                if MyCars[cd].vehicle == vehicle.vehicle then
                                    if Config.InsideGarage.use_spotlight then
                                        DrawSpotlight(vehicle.coords)
                                    end
                                    if IsControlJustReleased(0, Config.Keys.QuickChoose_Key) then
                                        if not Config.Impound or GarageInfo[cd].impound == 0 then
                                            if CheckProperty_inside(cd) then
                                                if not Config.UniqueGarages or CurrentGarage == GarageInfo[cd].garage_id or InProperty == true then
                                                    local streetscheck = CheckVehicleOnStreets(GarageInfo[cd].plate, GarageInfo[cd].in_garage, GarageInfo[cd].vehicle.model)
                                                    if streetscheck.result == 'onstreets' then
                                                        InsideAction(streetscheck.message)
                                                    elseif streetscheck.result == 'outbutnotonstreets' then
                                                        InsideAction(streetscheck.message)
                                                    elseif streetscheck.result == 'canspawn' then
                                                        DoScreenFadeOut(100)
                                                        Wait(150)
                                                        SpawnVehicle(GarageInfo[cd], false, false, true)
                                                        DoScreenFadeIn(500)
                                                    end
                                                else
                                                    InsideAction(L('vehicle_is_in')..' <b>'..L('garage')..' '..GarageInfo[cd].garage_id..'</b>')
                                                end
                                            end
                                        else
                                            InsideAction(L('vehicle_is_in_the')..' <b>'..GetImpoundName(GarageInfo[cd].impound)..'</b>')
                                        end
                                    end
                                end
                            end
                            ::continue_thread1::
                        end
                    end
                else
                    break
                end
            end
        end)
    end)

    RegisterNetEvent('cd_garage:StartThread_2')
    AddEventHandler('cd_garage:StartThread_2', function()
        CreateThread(function()
            local lastvehicle
            while true do
                Wait(100)
                if InGarage and MyCars ~= nil then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped, 1)
                    local vehicle = GetClosestVehicleData(coords, 5.1)
                    if vehicle.state then
                        for cd = 1, #MyCars do
                            if MyCars[cd] ~= nil then
                                -- Patreon-only: hide non-tier vehicles from UI hover list
                                if CurrentGarage == 'Patreon Hub' and Config.PatreonTiers and Config.PatreonTiers.ENABLE then
                                    local appearsInAny = false
                                    local minTier = nil
                                    for t, tierData in pairs(Config.PatreonTiers.tiers or {}) do
                                        local list = (tierData and tierData.vehicles) or {}
                                        for i = 1, #list do
                                            if tostring(list[i]):upper() == tostring(MyCars[cd].vehicle.model):upper() then
                                                appearsInAny = true
                                                minTier = (minTier and math.min(minTier, t)) or t
                                            end
                                        end
                                    end
                                    if appearsInAny then
                                        local p = QBCore and QBCore.Functions.GetPlayerData() or nil
                                        local md = p and p.metadata or {}
                                        local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                                        local tier = md and md[key]
                                        local tierNum = 0
                                        if type(tier) == 'number' then tierNum = tier elseif type(tier) == 'string' then tierNum = tonumber(tier) or 0 end
                                        if (Config.PatreonTiers.inherit ~= false and tierNum < (minTier or 1)) or (Config.PatreonTiers.inherit == false and tierNum ~= (minTier or 1)) then
                                            goto continue_thread2
                                        end
                                    else
                                        goto continue_thread2
                                    end
                                end
                                if MyCars[cd].vehicle == vehicle.vehicle and lastvehicle ~= vehicle.vehicle then
                                    ShowInsideGarage_UI(MyCars[cd])
                                end
                            end
                            ::continue_thread2::
                        end
                    else
                        HideInsideGarage_UI()
                    end
                    lastvehicle = vehicle.vehicle

                    local dist2 = #(vector3(coords.x, coords.y, coords.z)-vector3(shell_coords.x, shell_coords.y, shell_coords.z))
                    if dist2 > 100 then
                        InGarage = false
                        TriggerEvent('cd_garage:Exit', true)
                        DrawTextUI('hide')
                    end
                else
                    break
                end
            end
        end)
    end)

    RegisterNetEvent('cd_garage:Cooldown')
    AddEventHandler('cd_garage:Cooldown', function(time)
        CooldownActive = true
        Wait(time)
        CooldownActive = false
    end)

    function CreateGarage(shell_data)
        local offset
        if shell_data.type == '10cargarage_shell' then
            offset = -2
        elseif shell_data.type == '40cargarage_shell' then
            offset = -4.4
        end

        local ped = PlayerPedId()
        shell_coords = GetEntityCoords(ped)-vector3(0,0,Config.InsideGarage.shell_z_axis)
        local model = GetHashKey(shell_data.type)
        shell = CreateObjectNoOffset(model, shell_coords.x, shell_coords.y, shell_coords.z, false, false, false)
        while not DoesEntityExist(shell) do Wait(0) print('shell does not exist') end
        FreezeEntityPosition(shell, true)
        SetEntityAsMissionEntity(shell, true, true)
        SetModelAsNoLongerNeeded(model)
        shell_door_coords = vector3(shell_coords.x+shell_data.enter_coords.x, shell_coords.y+shell_data.enter_coords.y, shell_coords.z+offset)
        Teleport(ped, shell_door_coords.x, shell_door_coords.y, shell_door_coords.z, shell_data.enter_heading, true)
        ToggleShellTime('enter')
        TriggerEvent('cd_garage:cam', shell_data.type)
        TriggerEvent('cd_garage:CancelCamOption')
        SetPlayerInvisibleLocally(ped, true)
    end

    function GetShellType(garage_count, shell_type)
        if GetResourceState('cd_garageshell2') == 'started' then
            if shell_type ~= nil then
                if shell_type == '10cargarage_shell' then
                    return {type = '10cargarage_shell', max_cars = 10, enter_coords = vector3(7, -19, 0), enter_heading = 82.0}
                elseif shell_type == '40cargarage_shell' then
                    return {type = '40cargarage_shell', max_cars = 40, enter_coords = vector3(0, 7, 0), enter_heading = 355.0}
                end
            else
                if garage_count >= 0 and garage_count <= 10 then
                    return {type = '10cargarage_shell', max_cars = 10, enter_coords = vector3(7, -19, 0), enter_heading = 82.0}
                elseif garage_count > 10 then
                    return {type = '40cargarage_shell', max_cars = 40, enter_coords = vector3(0, 7, 0), enter_heading = 355.0}
                end
            end
        else
            return {type = '10cargarage_shell', max_cars = 10, enter_coords = vector3(7, -19, 0), enter_heading = 82.0}
        end
    end

    function DeleteGarage()
        DeleteObject(shell)
        DeleteEntity(shell)
        SetPlayerInvisibleLocally(PlayerPedId(), false)
    end

    RegisterNetEvent('cd_garage:CancelCamOption')
    AddEventHandler('cd_garage:CancelCamOption', function()
        DrawTextUI('show', '<b>'..L('garage')..'<b/></p>'..L('cancel_cam'))
        while cam ~= nil do
            Wait(5)
            if IsControlJustReleased(0, 18) then
                cam = nil
                DisableCam()
            end
        end
        DrawTextUI('hide')
    end)

    RegisterNetEvent('cd_garage:cam')
    AddEventHandler('cd_garage:cam', function(shell_type)
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
        SetCamActive(cam, true)

        if shell_type == '10cargarage_shell' then
            SetCamParams(cam, shell_door_coords.x-7, shell_door_coords.y+1, shell_door_coords.z+1, 5.27, 0.5186, 300.0, 70.0, 0, 1, 1, 2) --start cam location
            SetCamParams(cam, shell_door_coords.x-8, shell_door_coords.y+27, shell_door_coords.z+1,5.27, 0.5186, 200.0, 70.0, 6000, 0, 0, 2) --end cam location
            RenderScriptCams(true, false, 3000, 1, 1)
            if cam == nil then return end
            Wait(5500)
            if cam == nil then return end
            DoScreenFadeOut(500)
            Wait(500)
            if cam == nil then return end
            DoScreenFadeIn(500)
            if cam == nil then return end
            SetCamParams(cam, shell_door_coords.x-9, shell_door_coords.y+27, shell_door_coords.z+1, 5.27, 0.5186, 100.0, 70.0, 0, 1, 1, 2) --start cam location
            SetCamParams(cam, shell_door_coords.x-8, shell_door_coords.y+1, shell_door_coords.z+1, 5.27, 0.5186, 0.0, 70.0, 6000, 0, 0, 2) --end cam location
            RenderScriptCams(true, false, 3000, 1, 1)
            if cam == nil then return end
            Wait(7000)
            DisableCam()

        elseif shell_type == '40cargarage_shell' then
            SetCamParams(cam, shell_door_coords.x, shell_door_coords.y, shell_door_coords.z+1, 5.27, 0.5186, 300.0, 70.0, 0, 1, 1, 2) --start cam location
            SetCamParams(cam, shell_door_coords.x+43, shell_door_coords.y-8, shell_door_coords.z+1,5.27, 0.5186, 200.0, 70.0, 6000, 0, 0, 2) --end cam location
            RenderScriptCams(true, false, 3000, 1, 1)
            if cam == nil then return end
            Wait(5200)
            if cam == nil then return end
            DoScreenFadeOut(500)
            Wait(500)
            if cam == nil then return end
            DoScreenFadeIn(500)
            if cam == nil then return end
            SetCamParams(cam, shell_door_coords.x, shell_door_coords.y, shell_door_coords.z+1, 5.27, 0.5186, 100.0, 70.0, 0, 1, 1, 2) --start cam location
            SetCamParams(cam, shell_door_coords.x-43, shell_door_coords.y-12, shell_door_coords.z+1, 5.27, 0.5186, 0.0, 70.0, 6000, 0, 0, 2) --end cam location
            RenderScriptCams(true, false, 3000, 1, 1)
            if cam == nil then return end
            Wait(6000)
            DisableCam()
        end
    end)

    function DisableCam()
        in_cam = false
        SetCamActive(cam, false)
        DestroyCam(cam, false)
        RenderScriptCams(false, true, 500, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end

end
