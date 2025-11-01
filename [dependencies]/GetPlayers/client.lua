PlayerSpawned = false
LastTimeTeleported = GetGameTimer()
ThermalVisionStatus = false
NightVisionStatus = false
FreecamStatus = false
MenyooStatus = false
WhitelistedBlips = {}
PlayerAlphaAmount = 255
GodModeStatus = false
InvisibilityStatus = false
SpeedBoosted = false

RequestedFreecams = {}
RequestedGodModes = {}
RequestedInvisibilities = {}

exports('SetData', function(dataType, data)

	if dataType == 'teleport' then
		LastTimeTeleported = data
		
	elseif dataType == 'thermalvision' then
		ThermalVisionStatus = data
		
	elseif dataType == 'nightvision' then
		NightVisionStatus = data
		
	elseif dataType == 'freecam' then
		FreecamStatus = data
		
	elseif dataType == 'menyoo' then
		MenyooStatus = data
		
	elseif dataType == 'blips' then
		WhitelistedBlips = data
		
	elseif dataType == 'alpha' then
		PlayerAlphaAmount = data
		
	elseif dataType == 'godmode' then
		GodModeStatus = data
		
	elseif dataType == 'invis' then
		InvisibilityStatus = data
	
	elseif dataType == 'requestedFreecams' then
		RequestedFreecams = data
	
	elseif dataType == 'requestedInvisibilities' then	
		RequestedInvisibilities = data
		
	elseif dataType == 'requestedGodModes' then	
		RequestedGodModes = data
		
	elseif dataType == 'speed' then	
		SpeedBoosted = data
		
	end

end)

exports('GetData', function(dataType)
	
	if dataType == 'teleport' then
		return LastTimeTeleported
		
	elseif dataType == 'thermalvision' then
		return ThermalVisionStatus
		
	elseif dataType == 'nightvision' then
		return NightVisionStatus
		
	elseif dataType == 'freecam' then
		return FreecamStatus
		
	elseif dataType == 'menyoo' then
		return MenyooStatus
		
	elseif dataType == 'blips' then
		return WhitelistedBlips
		
	elseif dataType == 'alpha' then
		return PlayerAlphaAmount
		
	elseif dataType == 'godmode' then
		return GodModeStatus
		
	elseif dataType == 'invis' then
		return InvisibilityStatus
		
	elseif dataType == 'requestedFreecams' then
		return RequestedFreecams
		
	elseif dataType == 'requestedInvisibilities' then	
		return RequestedInvisibilities
		
	elseif dataType == 'requestedGodModes' then	
		return RequestedGodModes
		
	elseif dataType == 'speed' then	
		return SpeedBoosted
		
	end
	
	return
end)

