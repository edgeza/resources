function SetProximity(type, value)
    if type == 'level' then
        nuiMessage('setProximity', value)
    elseif type == 'talk' then
        nuiMessage('setProximityActive', value)
    end
end

local micIsOn = true
local firstCheck = true

SetTimeout(5000, function ()
    SetProximity('level', 1)
    SetProximity('talk', false)
end)

if config.Voice == 'mumble' or config.Voice == 'pma' then
    RegisterNetEvent('pma-voice:setTalkingMode')
    AddEventHandler('pma-voice:setTalkingMode', function(voiceMode)
        SetProximity('level', voiceMode)
    end)

    RegisterNetEvent("mumble:SetVoiceData")
    AddEventHandler("mumble:SetVoiceData", function(player, key, value)
        if GetPlayerServerId(NetworkGetEntityOwner(playerPed)) == player and key == 'mode' then
            SetProximity('level', value)             
        end
    end)

    local checkTalkStatus = false
    CreateThread(function()
        while true do
            if NetworkIsPlayerTalking(PlayerId()) then
                if not checkTalkStatus then
                    checkTalkStatus = true
                    SetProximity('talk', true)             
                end
            else
                if checkTalkStatus then
                    checkTalkStatus = false
                    SetProximity('talk', false)                 
                end
            end
            Wait(800)
        end
    end)

    CreateThread(function()
        while true do
            
            if not MumbleIsConnected() then
                if micIsOn or firstCheck then
                    micIsOn = false
                    firstCheck = false                 
                    SetProximity('isMuted', true)             

                end
            else
                if not micIsOn or firstCheck then
                    micIsOn = true
                    firstCheck = false                 
                    SetProximity('isMuted', false)             
                end
            end
            Wait(2000)
        end
    end)
else
    RegisterNetEvent('SaltyChat_VoiceRangeChanged')
    AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index, availableVoiceRanges)
        SetProximity('level', index+1)
    end)

    RegisterNetEvent('SaltyChat_TalkStateChanged')
    AddEventHandler('SaltyChat_TalkStateChanged', function(isTalking)
        SetProximity('talk', isTalking)
    end)
end