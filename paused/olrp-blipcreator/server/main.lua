local blipState = {}
local resourceName = GetCurrentResourceName()

local function resolveSprite(value)
    if value == nil then
        return Config.Defaults.sprite
    end

    if type(value) == 'number' then
        return value
    end

    if type(value) ~= 'string' then
        return Config.Defaults.sprite
    end

    local numeric = tonumber(value)
    if numeric then
        return numeric
    end

    if Config.SpriteAliases then
        local alias = Config.SpriteAliases[value:lower()]
        if alias then
            return alias
        end
    end

    return Config.Defaults.sprite
end

local function resolveNumber(value, defaultValue)
    if value == nil then
        return defaultValue
    end

    local numeric = tonumber(value)
    if numeric then
        return numeric
    end

    return defaultValue
end

local function resolveBoolean(value, defaultValue)
    if type(value) == 'boolean' then
        return value
    end

    if type(value) == 'string' then
        local lowered = value:lower()
        if lowered == 'true' or lowered == '1' or lowered == 'yes' then
            return true
        end

        if lowered == 'false' or lowered == '0' or lowered == 'no' then
            return false
        end
    end

    return defaultValue
end

local function toCoords(value)
    if value == nil then
        return nil
    end

    if type(value) == 'vector3' then
        return { x = value.x, y = value.y, z = value.z }
    end

    if type(value) == 'table' and value.x and value.y and value.z then
        return {
            x = tonumber(value.x) or 0.0,
            y = tonumber(value.y) or 0.0,
            z = tonumber(value.z) or 0.0
        }
    end

    return nil
end

local function normalizeBlip(entry, index)
    if type(entry) ~= 'table' then
        return nil
    end

    local coords = toCoords(entry.coords)
    if not coords then
        return nil
    end

    local label = entry.label or ('Blip %d'):format(index)

    local blip = {
        id = index,
        label = label:sub(1, 60),
        coords = coords,
        sprite = resolveSprite(entry.sprite),
        color = resolveNumber(entry.color, Config.Defaults.color),
        scale = resolveNumber(entry.scale, Config.Defaults.scale),
        short_range = resolveBoolean(entry.short_range, Config.Defaults.short_range),
        created_at = os.time()
    }

    return blip
end

local function loadBlipsFromConfig()
    blipState = {}

    local configuredBlips = Config.Blips or {}
    for index, entry in ipairs(configuredBlips) do
        local blip = normalizeBlip(entry, index)
        if blip then
            blipState[blip.id] = blip
        else
            print(('[olrp-blipcreator] Skipped invalid blip entry at index %d'):format(index))
        end
    end
end

local function syncPlayer(player)
    TriggerClientEvent('olrp-blipcreator:sync', player, blipState)
end

RegisterNetEvent('olrp-blipcreator:requestSync', function()
    local src = source
    syncPlayer(src)
end)

AddEventHandler('onResourceStart', function(resName)
    if resName ~= resourceName then
        return
    end

    loadBlipsFromConfig()

    for _, player in ipairs(GetPlayers()) do
        syncPlayer(tonumber(player))
    end
end)

