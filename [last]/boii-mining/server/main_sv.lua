----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local PhoneEvent = Config.CoreSettings.PhoneEvent
local RemoveStress = Config.CoreSettings.RemoveStressEvent
local MetaDataName = Config.XP.MetaDataName
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- ADD/REMOVE ITEM EVENTS START --<!>--
-- Remove item event
RegisterServerEvent('boii-mining:sv:RemoveItem', function(itemremove, amount)
    local source = source
    local pData = Core.Functions.GetPlayer(source)
    if pData.Functions.RemoveItem(itemremove, tonumber(amount)) then
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[itemremove], 'remove', amount)
    end
end)
-- Add item event
RegisterServerEvent('boii-mining:sv:AddItem', function(itemadd, amount)
    local source = source
    local pData = Core.Functions.GetPlayer(source)
    if pData.Functions.AddItem(itemadd, tonumber(amount)) then
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[itemadd], 'add', amount)
    end
end)
--<!>-- ADD/REMOVE ITEM EVENTS END --<!>--

--<!>-- TAKE GUIDE --<!>--
RegisterServerEvent('boii-mining:sv:TakeGuide', function()
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if pData.Functions.GetItemByName('miningguide') ~= nil then TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Ped['hasguide'], 'error') return end
    pData.Functions.AddItem('miningguide', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items['miningguide'], 'add', 1)
    TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Ped['guide'], 'success')
end)
--<!>-- TAKE GUIDE --<!>--

--<!>-- MINING XP / SCOREBOARD --<!>--
local function computeMiningLevel(totalXp)
    local xp = tonumber(totalXp) or 0
    local level = 1
    local intoLevel = xp
    local levels = (Config.XP and Config.XP.Levels) or {}
    for i = 1, #levels do
        local req = tonumber(levels[i]) or 0
        if intoLevel >= req then
            intoLevel = intoLevel - req
            level = level + 1
        else
            break
        end
    end
    local nextReq = levels[level] or 0
    return level, intoLevel, nextReq
end

RegisterServerEvent('boii-mining:sv:GetMyMiningXP', function()
    local src = source
    -- simple rate limit: 1 request per 2s per player
    _G.__boiiMiningXpLast = _G.__boiiMiningXpLast or {}
    local now = GetGameTimer and GetGameTimer() or (os.time()*1000)
    local last = _G.__boiiMiningXpLast[src] or 0
    if (now - last) < 2000 then return end
    _G.__boiiMiningXpLast[src] = now
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local total = (pData.PlayerData and pData.PlayerData.metadata and pData.PlayerData.metadata[MetaDataName]) or 0
    local level, intoLevel, nextReq = computeMiningLevel(total)
    TriggerClientEvent('boii-mining:cl:OpenMyXPMenu', src, {
        total = total,
        level = level,
        intoLevel = intoLevel,
        nextReq = nextReq
    })
end)

RegisterServerEvent('boii-mining:sv:GetMiningScoreboard', function()
    local src = source
    -- simple rate limit: 1 request per 10s per player
    _G.__boiiMiningScoreLast = _G.__boiiMiningScoreLast or {}
    local now = GetGameTimer and GetGameTimer() or (os.time()*1000)
    local last = _G.__boiiMiningScoreLast[src] or 0
    if (now - last) < 10000 then return end
    _G.__boiiMiningScoreLast[src] = now
    local function send(rows)
        table.sort(rows, function(a, b)
            if a.level == b.level then return (a.total or 0) > (b.total or 0) end
            return a.level > b.level
        end)
        TriggerClientEvent('boii-mining:cl:OpenScoreboardMenu', src, rows)
    end

    -- Prefer global scoreboard from DB if oxmysql is available
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT charinfo, metadata FROM players', {}, function(rows)
            local out = {}
            if type(rows) == 'table' then
                for _, r in ipairs(rows) do
                    local ci, md
                    if type(r.charinfo) == 'string' then
                        pcall(function() ci = json.decode(r.charinfo) end)
                    elseif type(r.charinfo) == 'table' then
                        ci = r.charinfo
                    end
                    if type(r.metadata) == 'string' then
                        pcall(function() md = json.decode(r.metadata) end)
                    elseif type(r.metadata) == 'table' then
                        md = r.metadata
                    end
                    local total = (md and md[MetaDataName]) or 0
                    if (total or 0) > 0 then
                        local level = computeMiningLevel(total)
                        local name = 'Unknown'
                        if ci and ci.firstname then
                            name = (ci.firstname or '') .. ' ' .. (ci.lastname or '')
                        end
                        out[#out+1] = { name = name, level = level, total = total }
                    end
                end
            end
            -- Fallback to online-only if DB returned nothing
            if #out == 0 then
                local players = Core.Functions.GetPlayers()
                for _, id in ipairs(players) do
                    local pData = Core.Functions.GetPlayer(id)
                    if pData and pData.PlayerData then
                        local total = (pData.PlayerData.metadata and pData.PlayerData.metadata[MetaDataName]) or 0
                        if (total or 0) > 0 then
                            local level = computeMiningLevel(total)
                            local name
                            if pData.PlayerData.charinfo and pData.PlayerData.charinfo.firstname then
                                local ci2 = pData.PlayerData.charinfo
                                name = (ci2.firstname or '') .. ' ' .. (ci2.lastname or '')
                            else
                                name = GetPlayerName(id) or ('ID ' .. tostring(id))
                            end
                            out[#out+1] = { name = name, level = level, total = total }
                        end
                    end
                end
            end
            send(out)
        end)
        return
    end

    -- No DB available: online-only scoreboard
    local result = {}
    local players = Core.Functions.GetPlayers()
    for _, id in ipairs(players) do
        local pData = Core.Functions.GetPlayer(id)
        if pData and pData.PlayerData then
            local total = (pData.PlayerData.metadata and pData.PlayerData.metadata[MetaDataName]) or 0
            if (total or 0) > 0 then
                local level = computeMiningLevel(total)
                local name
                if pData.PlayerData.charinfo and pData.PlayerData.charinfo.firstname then
                    local ci = pData.PlayerData.charinfo
                    name = (ci.firstname or '') .. ' ' .. (ci.lastname or '')
                else
                    name = GetPlayerName(id) or ('ID ' .. tostring(id))
                end
                result[#result+1] = { name = name, level = level, total = total }
            end
        end
    end
    send(result)
end)
--<!>-- MINING XP / SCOREBOARD --<!>--

--<!>-- SERVER-SIDE JEWEL CUTTING BENCH SPAWNER --<!>--
-- Spawns networked bench props so late joiners always see them
local SpawnedJewelBenches = {}

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    local propModel = Config and Config.JewelCutting and Config.JewelCutting.Prop and Config.JewelCutting.Prop.model
    local locations = Config and Config.JewelCutting and Config.JewelCutting.Locations
    if not propModel or type(locations) ~= 'table' then return end

    local model = GetHashKey(propModel)
    for _, v in pairs(locations) do
        if v and v.coords then
            local x, y, z = v.coords.x, v.coords.y, v.coords.z
            local h = v.heading or 0.0
            -- Spawn at configured Z (client code handled ground snapping when client-spawned). Using exact Z avoids burying the prop server-side.
            local obj = CreateObject(model, x, y, z, true, true, false)
            if obj and obj ~= 0 then
                SetEntityHeading(obj, h)
                FreezeEntityPosition(obj, true)
                SpawnedJewelBenches[#SpawnedJewelBenches+1] = obj
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for _, obj in ipairs(SpawnedJewelBenches) do
        if obj and DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    SpawnedJewelBenches = {}
end)
--<!>-- SERVER-SIDE JEWEL CUTTING BENCH SPAWNER --<!>--