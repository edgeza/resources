local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local activeStorm = nil
local activeProbes = {}
local weatherState = {
    current = nil
}

local function canSpawnDuringWeather()
    if not Config.WeatherTrigger or not Config.WeatherTrigger.enabled then
        return true
    end

    if not weatherState.current then
        return false
    end

    local weatherTypes = Config.WeatherTrigger.weatherTypes or {}
    return weatherTypes[weatherState.current] == true
end

local function debugPrint(...)
    if not Config.Debug then return end
    print('[stormchaser]', ...)
end

local function randomFloat(min, max)
    return min + (max - min) * math.random()
end

local function getRandomStormCoords()
    local min = Config.MapBounds.min
    local max = Config.MapBounds.max
    local x = randomFloat(min.x, max.x)
    local y = randomFloat(min.y, max.y)
    local z = 70.0
    return vector3(x, y, z)
end

local function sendStormUpdate(target)
    local dest = target or -1
    TriggerClientEvent('stormchaser:client:updateStorm', dest, activeStorm and {
        id = activeStorm.id,
        coords = activeStorm.coords,
        heading = activeStorm.heading,
        radius = Config.StormRadius,
        expires = activeStorm.expires,
        created = activeStorm.created
    } or nil)
end

local function syncProbesToPlayer(src)
    TriggerClientEvent('stormchaser:client:syncProbes', src, activeProbes)
end

local function broadcastProbeUpdate(id)
    local entry = activeProbes[id]
    if not entry then
        TriggerClientEvent('stormchaser:client:updateProbe', -1, id, { removed = true })
        return
    end

    TriggerClientEvent('stormchaser:client:updateProbe', -1, id, {
        coords = entry.coords,
        ready = entry.ready,
        quality = entry.quality,
        heading = entry.heading,
        owner = entry.owner
    })
end

local function removeProbe(id)
    if activeProbes[id] then
        activeProbes[id] = nil
        TriggerClientEvent('stormchaser:client:updateProbe', -1, id, { removed = true })
    end
end

local function getPlayerProbeCount(src)
    local count = 0
    for _, probe in pairs(activeProbes) do
        if probe.owner == src then
            count = count + 1
        end
    end
    return count
end

local function distance2D(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    return math.sqrt(dx * dx + dy * dy)
end

local function evaluateQuality(distance)
    if distance <= Config.StormRadius.inner then
        return 'close'
    elseif distance <= Config.StormRadius.outer then
        return 'medium'
    end
    return 'far'
end

local function payoutForQuality(quality)
    local multiplier = Config.QualityMultiplier[quality] or 1.0
    return math.floor(Config.BasePayout * multiplier)
end

local function spawnStorm()
    if Config.WeatherTrigger and Config.WeatherTrigger.enabled and not canSpawnDuringWeather() then
        debugPrint('Blocked storm spawn; unsuitable weather:', weatherState.current or 'unknown')
        return false
    end

    local id = ('storm-%s'):format(os.time() .. math.random(100, 999))
    local coords = getRandomStormCoords()
    local heading = math.random(0, 359)
    local speed = randomFloat(Config.StormSpeed.min, Config.StormSpeed.max)
    local radians = math.rad(heading)
    local velocity = vector3(math.cos(radians) * speed, math.sin(radians) * speed, 0.0)
    local created = os.time()
    local expires = created + (Config.StormLifetimeMinutes * 60)

    activeStorm = {
        id = id,
        coords = coords,
        heading = heading,
        velocity = velocity,
        created = created,
        expires = expires
    }

    debugPrint(('Spawned storm %s at (%.2f, %.2f) heading %d'):format(id, coords.x, coords.y, heading))
    sendStormUpdate()
    return true
end

local function endStorm()
    if not activeStorm then return end
    debugPrint(('Storm %s dissipated'):format(activeStorm.id))
    activeStorm = nil
    sendStormUpdate()
end

local function updateStormPosition(delta)
    if not activeStorm then return end

    local driftX = randomFloat(-Config.RandomDrift, Config.RandomDrift)
    local driftY = randomFloat(-Config.RandomDrift, Config.RandomDrift)

    local newCoords = activeStorm.coords + activeStorm.velocity * delta
    newCoords = newCoords + vector3(driftX, driftY, 0.0)

    local min = Config.MapBounds.min
    local max = Config.MapBounds.max
    newCoords = vector3(
        math.max(min.x, math.min(max.x, newCoords.x)),
        math.max(min.y, math.min(max.y, newCoords.y)),
        newCoords.z
    )

    activeStorm.coords = newCoords

    sendStormUpdate()
end

local function handleProbeSweeps()
    if not activeStorm then return end

    for id, probe in pairs(activeProbes) do
        if not probe.ready then
            local dist = distance2D(activeStorm.coords, probe.coords)
            if dist <= Config.StormRadius.outer then
                probe.ready = true
                probe.quality = evaluateQuality(dist)
                probe.capturedAt = os.time()

                local src = probe.owner
                local payout = payoutForQuality(probe.quality)

                TriggerClientEvent('stormchaser:client:notify', src,
                    ('Probe %s captured valuable data!'):format(id), 'success')
                TriggerClientEvent('stormchaser:client:notify', src,
                    ('Quality: %s | Potential payout: $%s'):format(probe.quality, payout), 'primary')

                broadcastProbeUpdate(id)
            end
        end

        if probe.deployedAt and (os.time() - probe.deployedAt) >= (Config.ProbeDespawnMinutes * 60) then
            TriggerClientEvent('stormchaser:client:notify', probe.owner, 'Your probe self-destructed due to old hardware.', 'error')
            removeProbe(id)
        end
    end
end

local function stormLoop()
    local interval = Config.StormUpdateIntervalSeconds * 1000
    while true do
        Wait(interval)
        local now = os.time()
        if activeStorm then
            if now >= activeStorm.expires then
                endStorm()
            else
                updateStormPosition(Config.StormUpdateIntervalSeconds)
                handleProbeSweeps()
            end
        end
    end
end

local function stormSpawner()
    while true do
        if activeStorm then
            Wait(60000)
        else
            if not canSpawnDuringWeather() then
                Wait(60000)
            else
                local min = Config.StormSpawnIntervalMinutes.min * 60000
                local max = Config.StormSpawnIntervalMinutes.max * 60000
                local waitTime = math.random(min, max)
                Wait(waitTime)

                if not activeStorm then
                    spawnStorm()
                end
            end
        end
    end
end

Citizen.CreateThread(stormLoop)
Citizen.CreateThread(stormSpawner)

local function updateWeatherState(weatherData)
    if type(weatherData) ~= 'table' then return end
    local previous = weatherState.current
    local weatherType = weatherData.weather
    if type(weatherType) == 'string' then
        weatherType = weatherType:upper()
    else
        weatherType = nil
    end
    weatherState.current = weatherType

    if previous == weatherState.current then return end

    debugPrint(('Weather changed from %s to %s'):format(previous or 'nil', weatherState.current or 'nil'))

    if canSpawnDuringWeather() and not activeStorm then
        debugPrint('Triggering storm spawn due to weather change.')
        spawnStorm()
    elseif activeStorm and Config.WeatherTrigger and Config.WeatherTrigger.despawnOnMismatch and not canSpawnDuringWeather() then
        debugPrint('Ending active storm due to weather mismatch.')
        endStorm()
    end
end

if Config.WeatherTrigger and Config.WeatherTrigger.enabled then
    local initialWeather = GlobalState.weather
    if initialWeather then
        updateWeatherState(initialWeather)
    end

    AddStateBagChangeHandler('weather', 'global', function(_, _, value)
        updateWeatherState(value)
    end)
end

RegisterNetEvent('stormchaser:server:requestSync', function()
    local src = source
    sendStormUpdate(src)
    syncProbesToPlayer(src)
end)

RegisterNetEvent('stormchaser:server:deployProbe', function(coords, heading)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if getPlayerProbeCount(src) >= Config.MaxProbePerPlayer then
        TriggerClientEvent('stormchaser:client:notify', src, ('You can only have %d probes deployed.'):format(Config.MaxProbePerPlayer), 'error')
        return
    end

    local item = Player.Functions.GetItemByName(Config.ProbeItem)
    if not item or item.amount < 1 then
        TriggerClientEvent('stormchaser:client:notify', src, 'You are missing a probe.', 'error')
        return
    end

    Player.Functions.RemoveItem(Config.ProbeItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ProbeItem], 'remove')

    local id = ('probe-%s'):format(os.time() .. ('%02d'):format(math.random(10, 99)))
    activeProbes[id] = {
        owner = src,
        coords = coords,
        heading = heading,
        ready = false,
        deployedAt = os.time()
    }

    broadcastProbeUpdate(id)
    TriggerClientEvent('stormchaser:client:notify', src, 'Probe deployed. Monitor the storm tablet for data.', 'success')
end)

RegisterNetEvent('stormchaser:server:collectProbe', function(id)
    local src = source
    local probe = activeProbes[id]
    if not probe or probe.owner ~= src then
        TriggerClientEvent('stormchaser:client:notify', src, 'That probe is not linked to your team.', 'error')
        return
    end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not probe.ready then
        TriggerClientEvent('stormchaser:client:notify', src, 'This probe has not collected any usable data yet.', 'error')
        return
    end

    local quality = probe.quality or 'far'
    local payout = payoutForQuality(quality)

    Player.Functions.AddItem(Config.ProbeItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ProbeItem], 'add')

    Player.Functions.AddItem(Config.DataItem, 1, false, {
        storm = activeStorm and activeStorm.id or 'archived',
        quality = quality,
        payout = payout
    })
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DataItem], 'add')

    removeProbe(id)
    TriggerClientEvent('stormchaser:client:notify', src, 'Data drive collected. Deliver it to the news station for payment.', 'success')
end)

RegisterNetEvent('stormchaser:server:sellData', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item = Player.Functions.GetItemByName(Config.DataItem)
    if not item or item.amount < 1 then
        TriggerClientEvent('stormchaser:client:notify', src, 'You do not have any storm data drives.', 'error')
        return
    end

    local payout = 0
    for slot, info in pairs(Player.PlayerData.items) do
        if info and info.name == Config.DataItem then
            local meta = info.info or {}
            local reward = meta.payout or payoutForQuality(meta.quality or 'far')
            payout = payout + reward
            Player.Functions.RemoveItem(Config.DataItem, info.amount, slot)
        end
    end

    if payout <= 0 then
        TriggerClientEvent('stormchaser:client:notify', src, 'No data processed.', 'error')
        return
    end

    Player.Functions.AddMoney('cash', payout, 'storm-data-sale')
    TriggerClientEvent('stormchaser:client:notify', src,
        ('Weazel News wired you $%s for the storm intel.'):format(payout), 'success')
end)

RegisterNetEvent('stormchaser:server:useTablet', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item = Player.Functions.GetItemByName(Config.TabletItem)
    if not item or item.amount < 1 then
        TriggerClientEvent('stormchaser:client:notify', src, 'You need the storm tablet item to access intel.', 'error')
        return
    end

    TriggerClientEvent('stormchaser:client:toggleTablet', src)
end)

QBCore.Functions.CreateUseableItem(Config.TabletItem, function(source, _)
    TriggerClientEvent('stormchaser:client:toggleTablet', source)
end)

QBCore.Functions.CreateUseableItem(Config.ProbeItem, function(source, _)
    TriggerClientEvent('stormchaser:client:deployProbe', source)
end)

AddEventHandler('playerDropped', function(_, reason)
    local src = source
    for id, probe in pairs(activeProbes) do
        if probe.owner == src then
            removeProbe(id)
            debugPrint(('Removed probe %s due to player drop (%s)'):format(id, reason))
        end
    end
end)

-- Optional qb-target integration
CreateThread(function()
    if not Config.NewsStation then return end

    if GetResourceState('qb-target') ~= 'started' then
        debugPrint('qb-target not detected; players must use /stormtablet to sell data.')
        return
    end

    exports['qb-target']:AddBoxZone('stormchaser-newsdesk', Config.NewsStation.coords,
        2.0, 2.0, {
            name = 'stormchaser-newsdesk',
            heading = Config.NewsStation.heading or 0.0,
            debugPoly = Config.Debug,
            minZ = Config.NewsStation.coords.z - 1.0,
            maxZ = Config.NewsStation.coords.z + 1.5
        }, {
            options = {
                {
                    type = 'client',
                    event = 'stormchaser:client:initiateSell',
                    icon = 'fas fa-bolt',
                    label = 'Sell Storm Data'
                }
            },
            distance = 2.0
        })
end)

