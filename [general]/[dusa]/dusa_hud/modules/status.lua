function SetStatus(type, value)
    if playerLoaded then
        local nuiMessageType = "set" .. string.upper(string.sub(type, 1, 1)) .. string.sub(type, 2)
        dp(nuiMessageType, value)
        if type == "health" then
            value = value
        end
        if value > 100 then
            value = 100
        elseif value < 0 then
            value = 0
        end
        nuiMessage(nuiMessageType, value)
    end
end

function HideStatus(type, bool)
    dp('Hide Status: ', type, bool)
    if type == 'stamina' then type = 'energy' end
    Wait(100)
    nuiMessage('changeStatusVisibility', {type = type, value = bool})
end

local lastHunger = nil
local lastThirst = nil
local firstStatus = false
CreateThread(function()
    CoreAwait()
    PlayerAwait()
    while true do
        if shared.framework == "esx" then
            TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
                TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                    local hungerPercent = hunger.getPercent()
                    local thirstPercent = thirst.getPercent()
                    
                    if lastHunger == nil or hungerPercent ~= lastHunger then
                        SetStatus('hunger', hungerPercent)
                        lastHunger = hungerPercent
                    end
                    
                    if lastThirst == nil or thirstPercent ~= lastThirst then
                        SetStatus('thirst', thirstPercent)
                        lastThirst = thirstPercent
                    end

                    if not firstStatus then
                        firstStatus = true
                        Wait(5000)
                        SetStatus('hunger', hungerPercent)
                        lastHunger = hungerPercent
                        Wait(500)
                        SetStatus('thirst', thirstPercent)
                        lastThirst = thirstPercent
                    end
                end)
            end)
        elseif shared.framework == 'qb' then
            local playerData = QBCore.Functions.GetPlayerData()
            local hunger = playerData.metadata["hunger"]
            local thirst = playerData.metadata["thirst"]

            if lastHunger == nil or hunger ~= lastHunger then
                SetStatus('hunger', hunger)
                lastHunger = hunger                
            end

            if lastThirst == nil or thirst ~= lastThirst then

                SetStatus('thirst', thirst)
                lastThirst = thirst
            end

            if not firstStatus then
                firstStatus = true
                Wait(5000)
                SetStatus('hunger', hunger)
                lastHunger = hunger
                Wait(500)
                SetStatus('thirst', thirst)
                lastThirst = thirst
            end
        end
        Wait(6000)
    end
end)

local lastHealth = nil
local firstHealth = false
CreateThread(function()
    CoreAwait()
    PlayerAwait()
    while true do
        local playerPed = PlayerPedId()
        local health = GetEntityHealth(playerPed)
        if not lastHealth or lastHealth ~= health then
            local val = health - 100
            SetStatus('health', val)
            lastHealth = health
        end

        if not firstHealth then 
            local val = health - 100 
            Wait(5000) 
            SetStatus('health', val) 
            firstHealth = true 
        end
        Wait(500)
    end
end)

local lastArmor = nil
local firstArmor = false
CreateThread(function()
    CoreAwait()
    PlayerAwait()
    while true do
        local playerPed = PlayerPedId()
        local armor = GetPedArmour(playerPed)
        if not lastArmor  or lastArmor ~= armor then
            local val = armor
            SetStatus('armor', val)
            lastArmor = armor
        end
        if not firstArmor then Wait(5000) SetStatus('armor', armor) firstArmor = true end
        Wait(750)
    end
end)

local inWater = false
local lastStamina = nil
local lastOxygen = nil
local inHeli = false

CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        if IsEntityInWater(pPed) then
            local value = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            if not inWater and not inHeli then
                HideStatus("stamina", true)
                HideStatus("oxygen", false)
                inWater = true
            end
            if value < 0 then
                value = 0
            end
            if lastOxygen == nil or lastOxygen ~= value then
                SetStatus('oxygen', value)
                lastOxygen = value
            end
        else
            if inWater and not inHeli then
                HideStatus("stamina", false)
                HideStatus("oxygen", true)    
                inWater = false      
            end
            local value = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
            if lastStamina == nil or lastStamina ~= value then
                SetStatus('stamina', value)
                lastStamina = value
            end
        end
        Wait(750)
    end    
end)


CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        if GetEntityMaxHealth(pPed) ~= 200 then
            SetEntityMaxHealth(pPed, 200)
            SetEntityHealth(pPed, 200)
        end
        Wait(2000)
    end
end)
