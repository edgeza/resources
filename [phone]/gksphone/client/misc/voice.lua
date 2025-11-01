--- Starts a voice call on the client.
--- @param callIndex number - The index of the call channel.
function ClientVoiceStartCall(callIndex)
    if Config.UseMumbleVoIP then
        exports["mumble-voip"]:SetCallChannel(callIndex)
    elseif Config.PMAVoice then
        exports["pma-voice"]:setCallChannel(callIndex)
    end
end

--- Ends the ongoing voice call.
function ClientVoiceEndCall()
    if Config.UseMumbleVoIP then
        exports["mumble-voip"]:SetCallChannel(0)
    elseif Config.PMAVoice then
        exports["pma-voice"]:removePlayerFromCall()
    end
end

function MuteCall(PlyrId)
    exports["pma-voice"]:toggleMutePlayer(PlyrId)
end