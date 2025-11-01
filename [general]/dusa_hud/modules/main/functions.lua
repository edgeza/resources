function GetCoin()
    -- here goes your special server coin
    return 0
end

function GetFuel(vehicle)
    if DoesEntityExist(vehicle) then
        if GetResourceState('LegacyFuel') == 'started' then
            return exports["LegacyFuel"]:GetFuel(vehicle)
        end
        return GetVehicleFuelLevel(vehicle)
    end
    return 0
end

function ToggleCursor(bool)
    dp('Toggle Cursor')
    SetNuiFocus(bool, bool)
    cursorEnabled = bool
end

function ToggleSettings(type, value)
    dp('Toggle Settings: ', type, value)
    if type == 'cinematicMode' then
        if value then
            ToggleCursorKey:disable(true)
            Cinematic(true)
        else
            ToggleCursorKey:disable(false)
            Cinematic(false)
        end
    elseif type == 'speedo' then
        hudSettings.speedType = value
        dp('Speedo Type Switched To: ', hudSettings.speedType) 
    elseif type == 'minimap' then
        DisplayRadar(value)
        hudSettings.showMiniMap = value
        nuiMessage('toggleMap', value)
    elseif type == 'hideAllHud' then
        if not value then
            SetHud() LoadRectMinimap() 
            ToggleCursorKey:disable(false)
        else 
            ToggleCursorKey:disable(true)
            DisplayRadar(false) 
        end 
    end
end 

function SetRefreshRate(rate)
    if rate == 'Low' then rate = 1000 end
    if rate == 'Medium' then rate = 750 end
    if rate == 'High' then rate = 150 end
    if rate == 'Real Time' then rate = 100 end
    hudSettings.speedoRefreshRate = rate
    return rate
end

-- @@ destroy
function ManageMusic(status)
    nuiMessage('pauseSong')
end

function GetVehicleType(vehicle)
    local class = GetVehicleClass(vehicle)
    if class == 14 then
        return 'ship'
    elseif class == 15 or class == 16 then
        return 'plane'
    elseif class == 13 then
        return 'bike'
    end
    return 'car'
end

-- Cinematic Mode
CinematicModeOn = false
CinematicHeight = 0.2
function Cinematic(bool)
    local pPed = PlayerPedId()
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    CinematicModeOn = bool
    if bool then
        for i = CinematicHeight, 0, -1.0 do
            Wait(10)
            w = i
        end
        DisplayRadar(false)
        HideHud()
    else
        for i = 0, CinematicHeight, 1.0 do
            Wait(10)
            w = i
        end
        ShowHud()
        LoadRectMinimap()
        if IsPedInAnyVehicle(pPed) then
            DisplayRadar(true)
            nuiMessage('toggleMap', true)
        else
            if config.mapWhileWalking or config.DisableMinimapOption then
                Wait(200)
                DisplayRadar(true)  
                nuiMessage('toggleMap', true)  
            end
        end
    end
    if w > 0 then
        CreateThread(function()
            local minimap = RequestScaleformMovie("minimap")
            if not HasScaleformMovieLoaded(minimap) then
                RequestScaleformMovie(minimap)
                while not HasScaleformMovieLoaded(minimap) do
                    Wait(1)
                end
            end
            while w > 0 do
                Wait(0)
                BlackBars()
                DisplayRadar(0)
                -- nuiMessage('toggleMap', false)
            end
        end)
    end
end

function BlackBars()
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

local latestDoor = nil
function ToggleDoor(door)
    local doorIndex
    if not door and latestDoor then 
        doorIndex = latestDoor
    else 
        doorIndex = DoorNameToIndex(door) 
    end

    if not doorIndex then return end
    latestDoor = doorIndex
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh == 0 then return end
    local doorState = GetVehicleDoorAngleRatio(veh, doorIndex)
    if doorState == 0.0 then
        SetVehicleDoorOpen(veh, doorIndex, false, false)
    else
        SetVehicleDoorShut(veh, doorIndex, false)
    end
end

function DoorNameToIndex(door)
    if door == 'LeftFront' then
        return 0
    elseif door == 'RightFront' then
        return 1
    elseif door == 'LeftBack' then
        return 2
    elseif door == 'RightBack' then
        return 3
    elseif door == 'Bonnet' then
        return 4
    elseif door == 'Trunk' then
        return 5
    end
    return false
end

function CheckOpenDoors(vehicle)
    for i=0, 3 do
        local doorState = GetVehicleDoorAngleRatio(vehicle, i)
        if doorState ~= 0.0 then
            return true
        end
    end
    return false
end

local partyMode = false
function ToggleNeon(neon)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    partyMode = false
    if neon == "Party" then
        PartyMode()
    elseif neon == "All" then
        local toggle = true
        for i=0, 3 do
            if IsVehicleNeonLightEnabled(vehicle, i) then
                toggle = false                            
            end
        end
        for i=0, 3 do
            SetVehicleNeonLightEnabled(vehicle, i, toggle)
        end
    else
        local neonIndex = NeonToIndex(neon)
        if not neonIndex then return end
        if IsVehicleNeonLightEnabled(vehicle, neonIndex) then
            SetVehicleNeonLightEnabled(vehicle, neonIndex, false)
        else
            SetVehicleNeonLightEnabled(vehicle, neonIndex, true)
        end
    end
end

function ToggleRainbow()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
	Citizen.CreateThread(function()
		local function RGBRainbow(frequency)
			local result = {}
			local curtime = GetGameTimer() / 1000
			result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
			result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
			result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )	
			return result
		end
	    while true do
	    	Citizen.Wait(500)
			if player == nil then
				player = PlayerPedId()
			end
			if vehicle == nil then
				vehicle = GetVehiclePedIsIn(player, false)
			end
			if vehicleplate == nil then
				vehicleplate = GetVehicleNumberPlateText(vehicle)
			end				
			if IsPedSittingInAnyVehicle(player) and GetPedInVehicleSeat(vehicle, -1) == player and partyMode then
                local rainbow = RGBRainbow(1.36)
                SetVehicleNeonLightsColour(vehicle, rainbow.r, rainbow.g, rainbow.b)
			else
				break
			end
		end
	end)
end

function NeonToIndex(neon)
    if neon == 'Left' then
        return 0
    elseif neon == 'Right' then
        return 1
    elseif neon == 'Front' then
        return 2
    elseif neon == 'Rear' then
        return 3
    end
    return false
end

function PartyMode()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    partyMode = true
    ToggleRainbow()
    CreateThread(function()
        while partyMode do  
            for i=0, 3 do
                if IsVehicleNeonLightEnabled(vehicle, i) then
                    SetVehicleNeonLightEnabled(vehicle, i, false)
                else
                    SetVehicleNeonLightEnabled(vehicle, i, true)
                end
                Wait(120)
            end
            Wait(0)
        end
    end)
    Wait(12000)
    partyMode = false
end