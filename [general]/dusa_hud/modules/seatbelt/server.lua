local seatbelt = {}

RegisterServerEvent("dusa_hud:EjectPlayers")
AddEventHandler("dusa_hud:EjectPlayers", function(table)
    for i=1, #table do
        if table[i] then
            if tonumber(table[i]) ~= 0 then
                TriggerClientEvent("dusa_hud:EjectPlayer", table[i])
            end
        end
    end
end)

RegisterNetEvent("dusa_hud:toggleSeatbelt")
AddEventHandler("dusa_hud:toggleSeatbelt", function(plate, seatIndex, beltState)
    if seatbelt[plate] == nil then seatbelt[plate] = {['seat_1'] = false, ['seat_2'] = false, ['seat_3'] = false, ['seat_4'] = false} end
    seatIndex = seatIndex + 2
    local seat = 'seat_'..seatIndex
    dp(plate, seat, beltState)
    seatbelt[plate][seat] = beltState
    dp(plate, json.encode(seatbelt[plate]))
end)

lib.callback.register('dusa_hud:getSeatbelt', function(source, plate, seatIndex, beltState)
    -- Return current seatbelt state for the vehicle
    if not plate then
        print('[ERROR] dusa_hud: getSeatbelt called without plate')
        return {}
    end
    
    -- Initialize seatbelt table for this plate if it doesn't exist
    if seatbelt[plate] == nil then 
        seatbelt[plate] = {
            ['seat_1'] = false, 
            ['seat_2'] = false, 
            ['seat_3'] = false, 
            ['seat_4'] = false
        } 
    end
    
    return seatbelt[plate]
end)

RegisterNetEvent("dusa_hud:ForceHighSpeedCrash")
AddEventHandler("dusa_hud:ForceHighSpeedCrash", function(playerIds, speed)
    for _, playerId in ipairs(playerIds) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed and targetPed ~= 0 then
            -- Calculate damage percentage based on speed
            local damagePercentage = 0.5
            if speed >= 200 then
                damagePercentage = 0.8
            elseif speed >= 180 then
                damagePercentage = 0.7
            elseif speed >= 160 then
                damagePercentage = 0.6
            end

            -- Let the client apply damage safely
            TriggerClientEvent('dusa_hud:ApplyCrashDamage', playerId, damagePercentage)

            -- Notify the player
            local speedText = string.format("%.0f", speed)
            TriggerClientEvent('chat:addMessage', playerId, {
                color = {255, 165, 0},
                multiline = true,
                args = {"SYSTEM", string.format("HIGH-SPEED CRASH at %s KMH - You took %d damage!", speedText, damage)}
            })
            
            print(string.format("[DUSA HUD] Player %s took %d damage from high-speed crash at %s KMH", GetPlayerName(playerId), damage, speedText))
        end
    end
end)

RegisterNetEvent("dusa_hud:playerCrashedAtHighSpeed")
AddEventHandler("dusa_hud:playerCrashedAtHighSpeed", function(speed, impactForce)
    local source = source
    local player = GetPlayerPed(source)
    
    if player then
        -- Log the high-speed crash for admin purposes
        print(string.format("[DUSA HUD] Player %s crashed at high speed %.1f KMH with impact force %.1f", 
            GetPlayerName(source), speed, impactForce))
        
        -- You can add additional crash handling here
        -- For example, notify admins, log to database, etc. ---Dont change
    end
end)