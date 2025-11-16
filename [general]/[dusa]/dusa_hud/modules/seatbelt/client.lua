if config.EnableSeatbelt then
    seatbelt = false ---Dont change
    lastSpeed = 0
    lastVelocity = vector3(0, 0, 0)

    local function Fwv(entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
    end
    
    local function CheckVehicleHasSeatbelt(vehicle)
        local vehicleType = GetVehicleType(vehicle)
        if vehicleType == 'bike' or vehicleType == 'ship' or vehicleType == 'plane' then
            return false 
        end
        return true
    end

    local function GetNumberOfVehicleRegularSeats(vehicle)
        local seats, numberOfSeats = { "seat_f", "seat_dside_f", "seat_r", "seat_dside_r", "seat_pside_f", "seat_pside_r" }, 0
    
        for _, v in pairs(seats) do
            if GetEntityBoneIndexByName(vehicle, v) ~= -1 then
                numberOfSeats = numberOfSeats + 1
            end
        end
    
        return numberOfSeats
    end

    local function GetPlayerSeatIndex(vehicle, maxSeat)
        for i = -1, maxSeat do
            if GetPedInVehicleSeat(vehicle, i) == PlayerPedId() then
                return i
            end
        end
        return -1
    end
    
    function ToggleSeatbelt()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(vehicle) then
            if CheckVehicleHasSeatbelt(vehicle) then
                local plate = GetVehicleNumberPlateText(vehicle)
                local maxSeat = GetNumberOfVehicleRegularSeats(vehicle)
                local seatIndex = GetPlayerSeatIndex(vehicle, maxSeat)
                seatbelt = not seatbelt
                if seatbelt then
                    notify(locale('seatbelt_on'), 'success')
                    TriggerEvent('InteractSound_CL:PlayOnOne', 'seatbelt', 0.1)
                else
                    notify(locale('seatbelt_off'), 'error')
                    TriggerEvent('InteractSound_CL:PlayOnOne', 'seatbeltoff', 0.1)
                end
                dp(plate, seatIndex, seatbelt)
                TriggerServerEvent("dusa_hud:toggleSeatbelt", plate, seatIndex, seatbelt)
                SetSeatbeltEnabled(plate, seatIndex, seatbelt)
                CreateThread(function()
                    while seatbelt do
                        Wait(0)
                        DisableControlAction(0, 75)
                    end
                end)
            else
                notify('Seatbelt not available for this vehicle type', 'info')
            end
        end
    end
    
    function SetSeatbeltEnabled(plate, seatIndex, beltState)
        local seats = lib.callback.await('dusa_hud:getSeatbelt', false, plate, seatIndex, beltState)
        dp('NUI Seatbelt Data: ', json.encode(seats))
        if not seats or not next(seats) then return end
        nuiMessage("setSeatBelts", seats)
    end

    SeatbeltControl = lib.addKeybind({
        name = 'SeatbeltControl',
        description = 'Enable Seatbelt',
        defaultKey = config.SeatbeltKey,
        onPressed = function ()
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
                ToggleSeatbelt()
            end
        end,
    })

    RegisterNetEvent("dusa_hud:EjectPlayer")
    AddEventHandler("dusa_hud:EjectPlayer", function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)
        
        -- Check if this is a high-speed crash (over 150 KMH)
        local isHighSpeedCrash = lastSpeed >= config.EjectionPhysics.instantDeathSpeed
        
        -- Eject if no seatbelt OR if it's a high-speed crash (150+ KMH)
        if not seatbelt or isHighSpeedCrash then
            -- Get vehicle momentum and direction for realistic ejection
            local vehicleVelocity = GetEntityVelocity(vehicle)
            local vehicleHeading = GetEntityHeading(vehicle)
            local vehicleSpeed = GetEntitySpeed(vehicle)
            
            -- Calculate impact force based on speed difference using config
            local speedDiff = lastSpeed - (vehicleSpeed * 3.6)
            local impactForce = math.min(speedDiff * config.EjectionPhysics.impactForceMultiplier, config.EjectionPhysics.maxImpactForce)
            
            -- For high-speed crashes, increase the impact force dramatically
            if isHighSpeedCrash then
                impactForce = config.EjectionPhysics.maxImpactForce * 2
                notify('HIGH-SPEED CRASH - EJECTED THROUGH WINDSHIELD', 'error')
                
                -- Add windshield breaking sound effect
                TriggerEvent('InteractSound_CL:PlayOnOne', 'seatbelt', 0.3)
                
                -- Create windshield breaking effect
                CreateThread(function()
                    Wait(50)
                    -- Add glass breaking particle effect (if available)
                    local vehicleCoords = GetEntityCoords(vehicle)
                    local vehicleForward = GetEntityForwardVector(vehicle)
                    local windshieldPos = vector3(
                        vehicleCoords.x + (vehicleForward.x * 3.0),
                        vehicleCoords.y + (vehicleForward.y * 3.0),
                        vehicleCoords.z + 0.5
                    )
                    
                    -- You can add particle effects here if you have a particle system
                    -- TriggerEvent('particle:create', 'glass_break', windshieldPos)
                end)
            end
            
            -- Calculate ejection direction based on vehicle movement and impact
            local ejectionAngle = vehicleHeading + math.random(-45, 45) -- Random angle variation
            local ejectionAngleRad = math.rad(ejectionAngle)
            
            -- For high-speed crashes, eject through front windshield forward
            if isHighSpeedCrash and config.EjectionPhysics.windshieldEjection.enabled then
                -- Eject through front windshield - forward direction
                ejectionAngle = vehicleHeading -- Forward direction (no random variation)
                ejectionAngleRad = math.rad(ejectionAngle)
                
                -- Calculate windshield position (front of vehicle) using config
                local vehicleCoords = GetEntityCoords(vehicle)
                local vehicleForward = GetEntityForwardVector(vehicle)
                local windshieldOffset = config.EjectionPhysics.windshieldEjection.windshieldOffset
                
                -- Position player at windshield location using config
                local windshieldX = vehicleCoords.x + (vehicleForward.x * windshieldOffset)
                local windshieldY = vehicleCoords.y + (vehicleForward.y * windshieldOffset)
                local windshieldZ = vehicleCoords.z + config.EjectionPhysics.windshieldEjection.heightOffset
                
                SetEntityCoords(ped, windshieldX, windshieldY, windshieldZ, true, true, true)
            end
            
            -- Calculate ejection distance based on impact force using config
            local ejectionDistance = math.min(impactForce * config.EjectionPhysics.ejectionDistanceMultiplier, config.EjectionPhysics.maxEjectionDistance)
            local ejectionX = math.cos(ejectionAngleRad) * ejectionDistance
            local ejectionY = math.sin(ejectionAngleRad) * ejectionDistance
            
            -- For high-speed crashes, eject forward and slightly down instead of up
            local upwardForce = 0
            if isHighSpeedCrash and config.EjectionPhysics.windshieldEjection.enabled then
                -- Forward ejection with slight downward trajectory using config
                upwardForce = config.EjectionPhysics.windshieldEjection.downwardVelocity
                ejectionDistance = ejectionDistance * config.EjectionPhysics.windshieldEjection.forwardDistanceMultiplier
            else
                -- Normal upward force for regular crashes
                upwardForce = math.min(impactForce * config.EjectionPhysics.upwardForceMultiplier, config.EjectionPhysics.maxUpwardForce)
            end
            
            -- Apply realistic physics
            if isHighSpeedCrash and config.EjectionPhysics.windshieldEjection.enabled then
                -- For windshield ejection, use the calculated windshield position
                local finalX = windshieldX + ejectionX
                local finalY = windshieldY + ejectionY
                local finalZ = windshieldZ + upwardForce
                SetEntityCoords(ped, finalX, finalY, finalZ, true, true, true)
            else
                -- Normal ejection from current position
                SetEntityCoords(ped, coords.x + ejectionX, coords.y + ejectionY, coords.z + upwardForce, true, true, true)
            end
            
            -- Calculate realistic velocity based on impact using config
            local velocityX = vehicleVelocity.x * config.EjectionPhysics.velocityRetention + (math.cos(ejectionAngleRad) * impactForce * 0.1)
            local velocityY = vehicleVelocity.y * config.EjectionPhysics.velocityRetention + (math.sin(ejectionAngleRad) * impactForce * 0.1)
            
            -- For high-speed crashes, forward velocity with downward component
            local velocityZ = 0
            if isHighSpeedCrash and config.EjectionPhysics.windshieldEjection.enabled then
                velocityZ = config.EjectionPhysics.windshieldEjection.downwardVelocity
                -- Increase forward velocity for dramatic windshield ejection using config
                velocityX = velocityX * config.EjectionPhysics.windshieldEjection.forwardVelocityMultiplier
                velocityY = velocityY * config.EjectionPhysics.windshieldEjection.forwardVelocityMultiplier
            else
                velocityZ = math.min(vehicleVelocity.z * 0.3 + upwardForce * 0.2, 15.0)
            end
            
            SetEntityVelocity(ped, velocityX, velocityY, velocityZ)
            
            -- Add rotation for more realistic movement
            local rotationX = math.random(-30, 30)
            local rotationY = math.random(-30, 30)
            local rotationZ = math.random(-180, 180)
            SetEntityRotation(ped, rotationX, rotationY, rotationZ, 2, true)
            
            if isHighSpeedCrash then
                -- High-speed crash - apply damage and ragdoll effects
                -- Dramatic ragdoll for high-speed crash
                SetPedToRagdoll(ped, 3000, 3000, 0, 0, 0, 0)
                
                -- Add dramatic effects for high-speed crash
                CreateThread(function()
                    Wait(100)
                    -- Apply damage will be handled in the damage calculation section
                    TriggerServerEvent('dusa_hud:playerCrashedAtHighSpeed', lastSpeed, impactForce)
                end)
            else
                -- Normal crash - apply damage and ragdoll
                -- Longer ragdoll for more realistic recovery time using config
                local ragdollTime = math.max(
                    math.min(impactForce * config.EjectionPhysics.ragdollTimeMultiplier, config.EjectionPhysics.maxRagdollTime),
                    config.EjectionPhysics.minRagdollTime
                )
                SetPedToRagdoll(ped, ragdollTime, ragdollTime, 0, 0, 0, 0)
                
                -- Add ragdoll breakout system
                if config.EjectionPhysics.allowRagdollBreakout then
                    CreateThread(function()
                        local ragdollStartTime = GetGameTimer()
                        local canBreakout = false
                        local maxRagdollTime = config.EjectionPhysics.maxRagdollTime + 2000 -- Extra safety buffer
                        
                        -- Wait minimum time before allowing breakout
                        Wait(config.EjectionPhysics.minRagdollTime)
                        canBreakout = true
                        
                        while IsPedRagdoll(ped) and canBreakout do
                            Wait(0)
                            
                            -- Show breakout indicator
                            if canBreakout then
                                SetTextScale(0.35, 0.35)
                                SetTextFont(4)
                                SetTextProportional(1)
                                SetTextColour(255, 255, 255, 255)
                                SetTextEntry("STRING")
                                AddTextComponentString("Press SPACE to break out of ragdoll")
                                DrawText(0.5, 0.8)
                            end
                            
                            -- Check for breakout key (SPACE)
                            if IsControlJustPressed(0, 22) then -- SPACE key
                                SetPedToRagdoll(ped, 0, 0, 0, 0, 0, 0)
                                ClearPedTasksImmediately(ped)
                                notify('Ragdoll broken out', 'success')
                                break
                            end
                            
                            -- Auto-breakout after max time (failsafe)
                            if GetGameTimer() - ragdollStartTime > maxRagdollTime then
                                SetPedToRagdoll(ped, 0, 0, 0, 0, 0, 0)
                                ClearPedTasksImmediately(ped)
                                notify('Ragdoll auto-recovered', 'info')
                                break
                            end
                        end
                        
                        -- Final cleanup to ensure ragdoll is cleared
                        if IsPedRagdoll(ped) then
                            SetPedToRagdoll(ped, 0, 0, 0, 0, 0, 0)
                            ClearPedTasksImmediately(ped)
                        end
                    end)
                end
            end
            
            -- Apply damage calculation for all crashes
            if config.EjectionPhysics.enableLethalCrashes then
                local damage = 0
                local currentHealth = GetEntityHealth(ped)
                
                -- Calculate damage based on impact force and speed
                damage = math.min(impactForce * config.EjectionPhysics.damageMultiplier, config.EjectionPhysics.maxDamage)
                
                -- Add speed-based damage for 150+ KMH crashes
                if lastSpeed >= config.EjectionPhysics.instantDeathSpeed then
                    -- High damage for very high speeds (at least 50% health)
                    local damagePercentage = 0.5 -- Base 50% damage
                    
                    -- Scale damage based on speed
                    if lastSpeed >= 200 then
                        damagePercentage = 0.8 -- 80% damage for 200+ KMH
                    elseif lastSpeed >= 180 then
                        damagePercentage = 0.7 -- 70% damage for 180+ KMH
                    elseif lastSpeed >= 160 then
                        damagePercentage = 0.6 -- 60% damage for 160+ KMH
                    end
                    
                    damage = math.max(damage, math.floor(currentHealth * damagePercentage))
                    notify('HIGH-SPEED CRASH - Major Damage', 'error')
                elseif lastSpeed >= config.EjectionPhysics.lethalSpeedThreshold then
                    -- Lethal damage for high speeds
                    damage = math.max(damage, currentHealth * 0.8)
                    notify('CRITICAL CRASH - Severe Damage', 'error')
                elseif lastSpeed >= config.SeatbeltEjectSpeed then
                    -- High damage for ejection speed crashes
                    damage = math.max(damage, currentHealth * 0.5)
                    notify('HIGH-SPEED CRASH - Major Damage', 'error')
                else
                    -- Normal damage for lower speed crashes
                    notify('CRASH - Moderate Damage', 'error')
                end
                
                -- Apply the damage
                SetEntityHealth(ped, currentHealth - damage)
                
                -- Ensure player doesn't die completely (minimum 1 health)
                if GetEntityHealth(ped) <= 0 then
                    SetEntityHealth(ped, 1)
                end
            end
            
            lastSpeed = 0
        end
    end)

    -- Apply crash damage sent from server (server cannot call SetEntityHealth)
    RegisterNetEvent('dusa_hud:ApplyCrashDamage')
    AddEventHandler('dusa_hud:ApplyCrashDamage', function(damagePercentage)
        local ped = PlayerPedId()
        if not ped or ped == 0 then return end

        local currentHealth = GetEntityHealth(ped)
        if currentHealth <= 0 then return end

        -- Calculate damage based on current health
        local rawDamage = math.floor(currentHealth * (damagePercentage or 0.5))
        local newHealth = currentHealth - rawDamage

        -- Clamp to minimum 1 so we don't fully kill from server instruction
        if newHealth <= 0 then newHealth = 1 end

        SetEntityHealth(ped, newHealth)
    end)

    -- Crash detection loop with improved sensitivity
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                if DoesEntityExist(vehicle) then
                    local speed = GetEntitySpeed(vehicle) * 3.6 -- Convert to KMH
                    local velocity = GetEntityVelocity(vehicle)
                    
                    -- Store last speed and velocity for crash detection
                    if speed > lastSpeed then
                        lastSpeed = speed
                        lastVelocity = velocity
                    end
                    
                    -- Check if vehicle has actually collided with something
                    local hasCollided = HasEntityCollidedWithAnything(vehicle)
                    local speedDrop = lastSpeed - speed
                    
                    -- Calculate velocity change magnitude for better impact detection
                    local velocityChange = #(velocity - lastVelocity)
                    local impactMagnitude = velocityChange * 3.6 -- Convert to KMH equivalent
                    
                    -- ULTRA STRICT crash detection - only eject on EXTREME impacts
                    -- Requires: collision + very high speed + MASSIVE speed drop + extreme velocity change
                    -- This prevents ejection from ANY minor taps/bumps - only severe crashes
                    local minEjectSpeed = config.SeatbeltEjectSpeed or 300 -- Fallback to 300 if config not set
                    local requiredSpeedDrop = minEjectSpeed * 0.8 -- 80% of the eject speed must be lost instantly (was 60%)
                    local requiredImpactMagnitude = 200 -- Doubled from 100 - requires extreme velocity change
                    
                    -- Only eject if ALL conditions are met: collision + no seatbelt + high speed + massive speed drop + extreme impact
                    if hasCollided and not seatbelt and lastSpeed >= minEjectSpeed and speedDrop >= requiredSpeedDrop and impactMagnitude >= requiredImpactMagnitude then
                        TriggerServerEvent("dusa_hud:EjectPlayers", {GetPlayerServerId(PlayerId())})
                    end
                    
                    -- Extreme high-speed crash detection (over 999 KMH) - basically disabled
                    if hasCollided and lastSpeed >= config.EjectionPhysics.instantDeathSpeed and speedDrop >= 200 then
                        TriggerServerEvent("dusa_hud:ForceHighSpeedCrash", {GetPlayerServerId(PlayerId())}, lastSpeed)
                        TriggerServerEvent("dusa_hud:EjectPlayers", {GetPlayerServerId(PlayerId())})
                    end
                end
            else
                -- Reset speed when not in vehicle
                lastSpeed = 0
                lastVelocity = vector3(0, 0, 0)
            end
            Wait(150) -- Less frequent checks to avoid detecting minor bumps
        end
    end)

    if config.SeatbeltWarning then
        CreateThread(function()
            while true do
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)
                if DoesEntityExist(vehicle) and CheckVehicleHasSeatbelt(vehicle) then
                    if not seatbelt then
                        local speed = GetEntitySpeed(vehicle) * 3.6
                        if speed > config.SeatbeltMinimumWarningSpeed then
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'beltalarm', config.SeatbeltWarningSoundVolume)
                        end
                    end
                end
                Wait(3500)
            end
        end)
    end

    -- DISABLED: Redundant crash detection that doesn't check seatbelt status
    -- The crash detection at lines 351-387 handles this properly with seatbelt checking
    --[[
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local speed = GetEntitySpeed(vehicle) * 3.6

                if lastSpeed > (config.SeatbeltEjectSpeed ) and (lastSpeed - speed) > (speed * 1.7) then
                    local seatPlayerId = {}
                    for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) do                       
                        if not IsVehicleSeatFree(vehicle, i-2) then
                            local otherPlayerId = GetPedInVehicleSeat(vehicle, i-2) 
                            local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                            local playerServerId = GetPlayerServerId(playerHandle)
                            table.insert(seatPlayerId, playerServerId)
                        end
                    end
                    if #seatPlayerId > 0 then TriggerServerEvent("dusa_hud:EjectPlayers", seatPlayerId) end                    
                end   
                lastSpeed = speed
                lastVelocity = GetEntityVelocity(vehicle)
            else
                if seatbelt then
    ]]--
    
    -- Reset seatbelt when exiting vehicle
    CreateThread(function()
        local wasInVehicle = false
        local lastVehicle = nil
        while true do
            local ped = PlayerPedId()
            local isInVehicle = IsPedInAnyVehicle(ped, false)
            
            if isInVehicle then
                wasInVehicle = true
                lastVehicle = GetVehiclePedIsIn(ped, false)
            elseif wasInVehicle then
                -- Player just exited vehicle - reset immediately
                if seatbelt then
                    seatbelt = false
                    -- Notify NUI that seatbelt is off (no parameters needed when player is not in vehicle)
                    nuiMessage("setSeatBelts", {})
                end
                -- Clear speed and velocity tracking immediately to prevent false ejections
                lastSpeed = 0
                lastVelocity = vector3(0, 0, 0)
                wasInVehicle = false
                lastVehicle = nil
                Wait(2000)
            end
            Wait(150)
        end
    end)

    exports('ToggleSeatbelt', ToggleSeatbelt)
end