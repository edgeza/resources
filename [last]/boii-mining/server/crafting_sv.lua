----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = (function()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    else
        -- QBX compatibility: return the exports table directly
        return exports[CoreFolder]
    end
end)()
local CraftingBusy = {}
local LastCraftAt = {}
local LastCraftRewardAt = {}
local LastCraftTs = {}
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

local function sdbg(...)
    if Config and Config.Debug then
        local args = { ... }
        print('^5[jewellery-crafting]^7', table.unpack(args))
    end
end

-- Crafting recipe definitions (ported from jim-mining)
local Crafting = (Config and Config.Crafting) or {
    GemCut = {},
    RingCut = {},
    NeckCut = {},
    EarCut = {},
}

local function buildCraftMenu(category, src)
    local items = {}
    if not Crafting[category] then return items end
    local pData = src and Core.Functions.GetPlayer(src) or nil
    -- removed debug clickable
    for _, r in ipairs(Crafting[category]) do
        local header = (Core.Shared.Items[r.reward.name] and Core.Shared.Items[r.reward.name].label) or r.reward.name
        local reqText = ''
        for req, amt in pairs(r.required) do
            local label = (Core.Shared.Items[req] and Core.Shared.Items[req].label) or req
            reqText = reqText .. amt .. 'x ' .. label .. '</p>'
        end
        -- All jeweller crafts require drill bit present (not always consumed)
        local needBit = true
        local hasAll = true
        local hasBit = true
        if pData then
            for req, amt in pairs(r.required) do
                local have = pData.Functions.GetItemByName(req)
                if have == nil or have.amount < amt then hasAll = false end
            end
            if needBit then
                local drill = pData.Functions.GetItemByName(Config.Tools.DrillBit.name)
                if drill == nil or drill.amount < 1 then hasBit = false end
            end
        end
        -- prefer PNG icon/image from inventory UI if available; fall back to provided icon or FA gem
        local png = string.format('nui://qs-inventory/html/images/%s.png', r.reward.name)
        items[#items+1] = {
            header = header..' x'..r.reward.amount,
            txt = 'Required:</p>'..reqText,
            icon = r.icon or png,
            image = r.image or png,
            params = {
                event = 'boii-mining:cl:DoJewelCraft',
                isServer = false,
                args = { rewardName = r.reward.name, required = r.required, needBit = needBit }
            },
            disabled = not (hasAll and hasBit)
        }
    end
    -- safety: strip any lingering debug/test entries in case another resource injected them
    do
        local cleaned = {}
        for _, it in ipairs(items) do
            local h = tostring(it.header or ''):lower()
            local ev = (it.params and it.params.event) or ''
            if not h:find('craft test') and ev ~= 'boii-mining:cl:_debugClick' then
                cleaned[#cleaned+1] = it
            end
        end
        items = cleaned
    end
    -- removed back entry in craft category
    return items
end

local function findRecipeByReward(rewardName)
    for _, cat in pairs(Crafting) do
        for _, r in ipairs(cat) do
            if r.reward and r.reward.name == rewardName then
                return r
            end
        end
    end
    return nil
end

RegisterNetEvent('boii-mining:sv:OpenCraft', function(category)
    local src = source
    local items = buildCraftMenu(category, src)
    if #items == 0 then
        TriggerClientEvent('boii-mining:notify', src, 'Crafting is currently unavailable.', 'error')
        return
    end
    TriggerClientEvent('boii-mining:cl:OpenCraftMenu', src, { label = 'Crafting', items = items })
end)

local function handleCraft(data)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local requestedName = (data and (data.rewardName or (data.reward and data.reward.name))) or 'unknown'
    if Config and Config.Debug then
        print(('^6[jewellery-crafting]^7 received craft for %s from %s'):format(requestedName, tostring(src)))
    end
    -- hard single-flight + short cooldown per player to stop duplicate triggers
    local now = GetGameTimer and GetGameTimer() or (os.time()*1000)
    if LastCraftTs[src] and (now - LastCraftTs[src] < 1500) then
        sdbg('blocked by cooldown', src, now - LastCraftTs[src])
        return
    end
    LastCraftTs[src] = now
    if CraftingBusy[src] then
        sdbg('craft blocked: busy for src', src)
        TriggerClientEvent('boii-mining:notify', src, 'Craft already in progress, please wait a moment.', 'error')
        return
    end
    CraftingBusy[src] = true
    local payload = '[no json]'
    if json and json.encode then
        pcall(function() payload = json.encode(data) end)
    end
    sdbg('craft start', src, payload)
    -- Require drill bit only for jewel-cutting crafts
    local requiresBit = true
    if requestedName then
        local nonBit = {
            gold_ingot=true, silver_ingot=true, aluminum_ingot=true, iron_ingot=true, tin_ingot=true,
            bronze_ingot=true, steel_ingot=true, cobalt_ingot=true
        }
        if nonBit[requestedName] then requiresBit = false end
    end
    if requiresBit then
        -- Require exactly 1 drill bit per gem cut action (2 outputs). 25% chance it breaks additionally (not extra cost to player).
        local drill = pData.Functions.GetItemByName(Config.Tools.DrillBit.name)
        if drill == nil or drill.amount < 1 then
            TriggerClientEvent('boii-mining:notify', src, 'You need a '..Config.Tools.DrillBit.label..' to craft here.', 'error')
            CraftingBusy[src] = false
            return
        end
        sdbg('drillbit present amount', drill.amount)
    end
    -- Resolve canonical server recipe to avoid client mismatch/duplication
    local recipe = findRecipeByReward(requestedName)
    if not recipe then
        CraftingBusy[src] = false
        TriggerClientEvent('boii-mining:notify', src, 'No crafting recipes available.', 'error')
        return
    end
    local required = recipe.required or {}
    local reward = recipe.reward or data.reward
    sdbg('resolved recipe reward', reward.name, 'x'..tostring(reward.amount))
    -- Check requirements
    for item, amount in pairs(required) do
        local have = pData.Functions.GetItemByName(item)
        sdbg('checking req', item, 'need', amount, 'have', have and have.amount or 0)
        if have == nil or have.amount < amount then
            TriggerClientEvent('boii-mining:notify', src, Language.Shared['noinvent'], 'error')
            CraftingBusy[src] = false
            return
        end
    end
    -- Remove required materials (not drill bits)
    for item, amount in pairs(required) do
        pData.Functions.RemoveItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[item], 'remove', amount)
        sdbg('removed', amount, item)
    end
    -- 25% break chance: require a drill bit to be present, but only consume it on failure
    if requiresBit then
        local broke = (math.random(1,100) <= 25)
        sdbg('drillbit break roll', broke)
        if broke then
            pData.Functions.RemoveItem(Config.Tools.DrillBit.name, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Tools.DrillBit.name], 'remove', 1)
        end
    end
    -- Add reward
    pData.Functions.AddItem(reward.name, reward.amount)
    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[reward.name], 'add', reward.amount)
    sdbg('granted', reward.amount, reward.name)
    -- Contextual success notifications
    local r = tostring(reward.name or '')
    local msg = 'Successfully cut a gem.'
    if r:find('necklace') or r == 'goldchain' then
        msg = 'Successfully crafted a necklace.'
    elseif r:find('ring') then
        msg = 'Successfully crafted a ring.'
    end
    TriggerClientEvent('boii-mining:notify', src, msg, 'success')
    CraftingBusy[src] = false
end

RegisterNetEvent('boii-mining:sv:CraftItem', handleCraft)
RegisterNetEvent('boii-mining:sv:CraftItem:custom', handleCraft)


