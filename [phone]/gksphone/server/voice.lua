--- Starts a voice call on the server.
--- @param callIndex number The index of the call.
--- @param source number The source of the call.
--- @param callData table The data associated with the call.
function ServerVoiceStartCall(callIndex, source, callData)
    if Config.SaltyChat then
        exports["saltychat"]:AddPlayerToCall(tostring(callIndex), source)
    elseif Config.YacaVoice then
        if callData and callData.status and callData.callerSource and callData.receiverSource then
            exports["yaca-voice"]:callPlayer(callData.callerSource, callData.receiverSource, true)
        end
    end
end

--- Sets the phone speaker for a player.
--- @param source number The player's source.
--- @param isSpeak boolean indicating whether the player is speaking or not.
function ServerVoiceSpeaker(source, isSpeak)
    if Config.SaltyChat then
        exports["saltychat"]:SetPhoneSpeaker(source, isSpeak)
    elseif Config.YacaVoice then
        exports["yaca-voice"]:enablePhoneSpeaker(source, isSpeak)
    end
end

--- Function to end a voice call on the server side
--- @param callIndex number The index of the call
--- @param source number The source of the call
--- @param callData table The data associated with the call
function ServerVoiceEndCall(callIndex, source, callData)
    if Config.SaltyChat then
        exports["saltychat"]:RemovePlayerFromCall(tostring(callIndex), source)
    elseif Config.YacaVoice then
        if callData and callData.status and callData.callerSource and callData.receiverSource then
            exports["yaca-voice"]:callPlayer(callData.callerSource, callData.receiverSource, false)
        end
    end
end