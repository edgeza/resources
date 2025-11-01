local isRolling = false
local rollEndTime = 0
local lastRollTime = 0

-- Function to check if player is currently rolling
local function IsPlayerRolling()
    local ped = PlayerPedId()
    local animDict = "move_crawl"
    local animName = "frontcrawl"
    
    -- Check if player is in roll animation
    if IsEntityPlayingAnim(ped, animDict, animName, 3) then
        return true
    end
    
    -- Check for other roll-related animations
    local rollAnims = {
        "move_crawl@onfloor@base",
        "move_crawl@onfloor@front",
        "move_crawl@onfloor@back"
    }
    
    for _, anim in pairs(rollAnims) do
        if IsEntityPlayingAnim(ped, anim, "frontcrawl", 3) then
            return true
        end
    end
    
    return false
end

-- Function to check if player is trying to glitch roll
local function IsPlayerGlitchRolling()
    local ped = PlayerPedId()
    local velocity = GetEntityVelocity(ped)
    local speed = math.sqrt(velocity.x^2 + velocity.y^2 + velocity.z^2)
    
    -- Check if player is moving fast while prone (potential glitch roll)
    if IsPedProne(ped) and speed > 2.0 then
        return true
    end
    
    -- Check for rapid movement while in roll animation
    if IsPlayerRolling() and speed > 1.5 then
        return true
    end
    
    return false
end

-- Function to check if shooting should be blocked
local function ShouldBlockShooting()
    if not Config.Enabled then
        return false
    end
    
    local currentTime = GetGameTimer()
    
    -- Check if we're still in cooldown period
    if currentTime < rollEndTime then
        return true
    end
    
    -- Check if currently rolling
    if IsPlayerRolling() then
        rollEndTime = currentTime + Config.RollCooldown
        lastRollTime = currentTime
        return true
    end
    
    -- Check if glitch rolling
    if IsPlayerGlitchRolling() then
        rollEndTime = currentTime + Config.RollCooldown
        lastRollTime = currentTime
        return true
    end
    
    return false
end

-- Main thread to monitor rolling and shooting
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if Config.Enabled then
            local ped = PlayerPedId()
            
            -- Check if player is trying to shoot
            if IsControlPressed(0, 24) or IsControlPressed(0, 25) then -- Left click or right click
                if ShouldBlockShooting() then
                    -- Disable shooting
                    DisableControlAction(0, 24, true) -- Disable left click
                    DisableControlAction(0, 25, true) -- Disable right click
                    DisableControlAction(0, 68, true) -- Disable aim
                    DisableControlAction(0, 69, true) -- Disable aim
                    
                    -- Show message if enabled
                    if Config.ShowMessage and GetGameTimer() - lastRollTime < 100 then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(Config.BlockedMessage)
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                    end
                    
                    if Config.Debug then
                        print("^3[Anti-Roll]^7 Shooting blocked - Player is rolling or glitch rolling")
                    end
                end
            end
            
            -- Update rolling state
            if IsPlayerRolling() or IsPlayerGlitchRolling() then
                if not isRolling then
                    isRolling = true
                    if Config.Debug then
                        print("^2[Anti-Roll]^7 Player started rolling")
                    end
                end
            else
                if isRolling then
                    isRolling = false
                    if Config.Debug then
                        print("^2[Anti-Roll]^7 Player stopped rolling")
                    end
                end
            end
        end
        
        Citizen.Wait(100) -- Check every 100ms for performance
    end
end)

-- Event handlers
RegisterNetEvent('stitch_antiroll:setEnabled')
AddEventHandler('stitch_antiroll:setEnabled', function(enabled)
    Config.Enabled = enabled
    if Config.Debug then
        print("^3[Anti-Roll]^7 System " .. (enabled and "enabled" or "disabled"))
    end
end)

-- Command to toggle the system
RegisterCommand('antiroll', function(source, args)
    Config.Enabled = not Config.Enabled
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 0},
        multiline = true,
        args = {"[Anti-Roll]", "System " .. (Config.Enabled and "enabled" or "disabled")}
    })
end, false)

if Config.Debug then
    print("^2[Anti-Roll]^7 Script loaded successfully")
end
