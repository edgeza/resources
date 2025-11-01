Functions = {}
local idHistory = {}

local function CreateEvidenceId(evidenceType)
    local prefix = string.sub(string.upper(evidenceType), 1, 3)
    local id = math.random(1000, 9999)
    local idString = prefix .. id
    while idHistory[idString] do
        id = math.random(1000, 9999)
        idString = prefix .. id
    end

    return idString
end

local function WhitelistedWeapon(weapon)
    local WhitelistedWeapons = Config.WhitelistedWeapons
    for i = 1, #WhitelistedWeapons do
        if WhitelistedWeapons[i] == weapon then
            return true
        end
    end
    return false
end

local function WhitelistedLocation(ped, evidenceType)
    local coords = GetEntityCoords(ped)
    local WhitelistedLocations = Config.WhitelistedLocations
    for k, v in pairs(WhitelistedLocations) do
        local distance = #(coords - v.coords)
        if distance <= v.radius and (v.disabled == 'all' or v.disabled == evidenceType) then
            return true
        end
    end
    return false
end

local function IsGloveWhitelisted()
    local ped = PlayerPedId()
    local WhitelistedGloves = Config.WhitelistedGloves
    local pedGender = IsPedMale(ped) and 'male' or 'female'

    for gender, value in pairs(WhitelistedGloves) do
        if pedGender == gender then

            for i = 1, #value do
                local glove = GetPedDrawableVariation(ped, value[i].component)
                for j = 1, #value[i].gloves do
                    if glove == value[i].gloves[j] then
                        return true
                    end
                end
            end
        end
    end

    return false
end

local function isLeo(job)
    for k, v in pairs(Config.PoliceJobs) do
         if v == job then
             return true
         end
    end
    return false
end

local function GetStreet(coords)
    local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 then
        streetLabel = streetLabel .. ', ' .. street2
    end
    return streetLabel
end

local function GetDate()
    local year, month, day = GetLocalTime()
    local date = string.format("%02d.%02d.%04d", day, month, year)
    return date
end

local function GetClock()
    local _, _, _, hour, minute = GetLocalTime()
    local clock = string.format("%02d:%02d", hour, minute)
    return clock
end

Functions.WhitelistedWeapon = WhitelistedWeapon
Functions.WhitelistedLocation = WhitelistedLocation
Functions.isLeo = isLeo
Functions.GetStreet = GetStreet
Functions.IsGloveWhitelisted = IsGloveWhitelisted
Functions.CreateEvidenceId = CreateEvidenceId
Functions.GetDate = GetDate
Functions.GetClock = GetClock