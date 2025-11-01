module 'shared/debug'
module 'shared/resource'
module 'shared/table'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

if not rawget(_G, "lib") then include('ox_lib', 'init') end

Framework.OnReady(QBCore, function()
    Framework.Items = {}
    -- Get items from codem-inventory config
    local itemList = exports['codem-inventory']:GetItemList()
    for k, v in pairs(itemList) do
        local item = {}
        if type(v) == 'string' then return end
        if not v.name then v.name = k end
        item.name = v.name
        item.label = v.label
        item.description = v.description
        item.stack = not v.unique and true
        item.weight = v.weight or 0
        item.close = v.shouldClose == nil and true or v.shouldClose
        item.type = v.type
        Framework.Items[v.name] = item
    end
end)

---Get Stash Items
---@return Item[]
local function GetStashItems(inventory)
    inventory = inventory:gsub("%-", "_")
    local items = {}
    local stashItems = exports['codem-inventory']:GetStashItems(inventory)
    if not stashItems then return items end

    for slot, item in pairs(stashItems) do
        local itemInfo = Framework.Items[item.name:lower()]
        if itemInfo then
            items[slot] = {
                name = itemInfo.name,
                count = tonumber(item.amount),
                label = itemInfo.label,
                description = itemInfo.description,
                metadata = item.info,
                stack = itemInfo.stack,
                weight = itemInfo.weight,
                close = itemInfo.close,
                image = itemInfo.image,
                type = itemInfo.type,
                slot = tonumber(slot),
            }
        end
    end
    return items
end

---Add Item To Stash
---@param inventory string
---@param item string
---@param count number
---@param metadata? table
---@param slot? number
---@return boolean
local function AddStashItem(inventory, item, count, metadata, slot)
    inventory = inventory:gsub("%-", "_")
    count = tonumber(count) or 1
    local stashItems = exports['codem-inventory']:GetStashItems(inventory) or {}
    local itemInfo = Framework.Items[item:lower()]
    metadata = metadata or {}
    metadata.created = metadata.created or os.time()
    metadata.quality = metadata.quality or 100
    
    if itemInfo['type'] == 'weapon' then
        metadata.serie = metadata.serie or tostring(Framework.RandomInteger(2) .. Framework.RandomString(3) .. Framework.RandomInteger(1) .. Framework.RandomString(2) .. Framework.RandomInteger(3) .. Framework.RandomString(4))
    end
    
    if not itemInfo.unique then
        if type(slot) == "number" and stashItems[slot] and stashItems[slot].name == item and table.matches(metadata, stashItems[slot].info) then
            stashItems[slot].amount = stashItems[slot].amount + count
        else
            slot = #stashItems + 1
            stashItems[slot] = {
                name = itemInfo["name"],
                amount = count,
                info = metadata or {},
                label = itemInfo["label"],
                description = itemInfo["description"] or "",
                weight = itemInfo["weight"],
                type = itemInfo["type"],
                unique = itemInfo["unique"],
                useable = itemInfo["useable"],
                image = itemInfo["image"],
                slot = slot,
            }
        end
    else
        slot = #stashItems + 1
        stashItems[slot] = {
            name = itemInfo["name"],
            amount = count,
            info = metadata or {},
            label = itemInfo["label"],
            description = itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = slot,
        }
    end
    
    exports['codem-inventory']:UpdateStash(inventory, stashItems)
    return true
end

---Remove Item From Stash
---@param inventory string
---@param item string
---@param count number
---@param metadata? table
---@param slot? number
---@return boolean
local function RemoveStashItem(inventory, item, count, metadata, slot)
    inventory = inventory:gsub("%-", "_")
    local stashItems = exports['codem-inventory']:GetStashItems(inventory)
    if not stashItems then return false end
    count = tonumber(count) or 1
    
    if type(slot) == "number" and stashItems[slot] and stashItems[slot].name == item then
        if metadata and not table.matches(metadata, stashItems[slot].info) then return false end
        if stashItems[slot].amount > count then
            stashItems[slot].amount = stashItems[slot].amount - count
        else
            stashItems[slot] = nil
        end
        exports['codem-inventory']:UpdateStash(inventory, stashItems)
        return true
    else
        local removed = count
        local newstash = stashItems
        for slotKey, v in pairs(stashItems) do
            if v.name == item then
                if metadata and table.matches(metadata, v.info) then 
                    if removed >= v.amount then
                        newstash[slotKey] = nil
                        removed = removed - v.amount
                    else
                        newstash[slotKey].amount = newstash[slotKey].amount - removed
                        removed = removed - removed
                    end
                elseif not metadata then
                    if removed >= v.amount then
                        newstash[slotKey] = nil
                        removed = removed - v.amount
                    else
                        newstash[slotKey].amount = newstash[slotKey].amount - removed
                        removed = removed - removed
                    end
                end
            end
            
            if removed == 0 then
                break
            end
        end

        if removed == 0 then
            exports['codem-inventory']:UpdateStash(inventory, newstash)
            return true
        else
            return false
        end
    end
end

Framework.AddItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then
        return AddStashItem(inventory, item, count, metadata, slot)
    elseif type(inventory) == "number" then
        return exports['codem-inventory']:AddItem(inventory, item, count, slot, metadata)
    end
    return false
end

Framework.RemoveItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then
        return RemoveStashItem(inventory, item, count, metadata, slot)
    elseif type(inventory) == "number" then
        return exports['codem-inventory']:RemoveItem(inventory, item, count, slot)
    end
    return false
end

---@diagnostic disable-next-line: duplicate-set-field
Framework.GetItem = function(inventory, item, metadata, strict)
    local items = {}
    ---@cast items Item[]
    if type(inventory) == "string" then
        for k, v in pairs(GetStashItems(inventory)) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then goto skipLoop end
            items[#items + 1] = v
            ::skipLoop::
        end
    elseif type(inventory) == "number" then
        local playerInventory = exports['codem-inventory']:GetInventory(nil, inventory)
        for k, v in pairs(playerInventory) do 
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.info, metadata) or not table.contains(v.info, metadata)) then goto skipLoop end
            items[#items+1] = {
                name = v.name,
                count = tonumber(v.amount),
                label = v.label,
                description = v.description,
                metadata = v.info,
                stack = not v.unique and true,
                weight = v.weight or 0,
                close = v.shouldClose == nil and true or v.shouldClose,
                image = v.image,
                type = v.type,
                slot = v.slot,
            }
            ::skipLoop::
        end
    end
    return items
end

Framework.GetItemCount = function(inventory, item, metadata, strict)
    local count = 0
    if type(inventory) == "string" then
        for k, v in pairs(GetStashItems(inventory)) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then
                goto skipLoop
            end
            count = count + tonumber(v.count)
            ::skipLoop::
        end
    elseif type(inventory) == "number" then
        return exports['codem-inventory']:GetItemsTotalAmount(inventory, item) or 0
    end
    return count
end

---@diagnostic disable-next-line: duplicate-set-field
Framework.HasItem = function(inventory, items, count, metadata, strict)
    if type(items) == "string" then
        local counted = 0
        for _, v in pairs(Framework.GetItem(inventory, items, metadata, strict)) do
            counted+=v.count
        end
        return counted >= (count or 1)
    elseif type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                local counted = 0
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < amount then return false end
            end
            return true
        elseif table.type(items) == 'array' then
            local counted = 0
            for i = 1, #items do
                local item = items[i]
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < (count or 1) then return false end
            end
            return true
        end
    end
end

Framework.GetItemMetadata = function(inventory, slot)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stashItems = exports['codem-inventory']:GetStashItems(inventory)
        if not stashItems then return nil end
        for k, item in pairs(stashItems) do
            if item.slot == slot then
                return item.info
            end
        end
        return {}
    elseif type(inventory) == "number" then
        local item = exports['codem-inventory']:GetItemBySlot(inventory, slot)
        return item?.info or {}
    end
    return {}
end

Framework.SetItemMetadata = function(inventory, slot, metadata)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stashItems = exports['codem-inventory']:GetStashItems(inventory)
        if not stashItems then return end
        for k, item in pairs(stashItems) do
            if item.slot == slot then
                stashItems[k].info = metadata
                break
            end
        end
        if not next(stashItems) then return end
        exports['codem-inventory']:UpdateStash(inventory, stashItems)
    elseif type(inventory) == "number" then
        exports['codem-inventory']:SetItemMetadata(inventory, slot, metadata)
    end
end

Framework.GetInventory = function(inventory)
    local items = {}
    if type(inventory) == "string" then
        items = GetStashItems(inventory)
    elseif type(inventory) == "number" then
        local playerInventory = exports['codem-inventory']:GetInventory(nil, inventory)
        for k, v in pairs(playerInventory) do
            items[k] = {
                name = v.name,
                count = tonumber(v.amount),
                label = v.label,
                description = v.description,
                metadata = v.info,
                stack = not v.unique and true,
                weight = v.weight or 0,
                close = v.shouldClose == nil and true or v.shouldClose,
                image = v.image,
                type = v.type,
                slot = v.slot,
            }
        end
    end
    return items
end

Framework.ClearInventory = function(inventory, keep)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stashItems = exports['codem-inventory']:GetStashItems(inventory) or {}
        local newStash = {}
        
        if keep then
            local keepType = type(keep)
            if keepType == "string" then
                for k, v in pairs(stashItems) do
                    if v.name == keep then
                        newStash[k] = v
                    end
                end
            elseif keepType == "table" and table.type(keep) == "array" then
                for k, v in pairs(stashItems) do
                    for i = 1, #keep do
                        if v.name == keep[i] then
                            newStash[k] = v
                        end
                    end
                end
            end
        end
        
        exports['codem-inventory']:UpdateStash(inventory, newStash)
    elseif type(inventory) == "number" then
        exports['codem-inventory']:ClearInventory(inventory)
    end
end

local stashes = {}
Framework.RegisterStash = function(name, slots, weight, owner, groups)
    name = name:gsub("%-", "_")
    if not stashes[name] then
        stashes[name] = { slots = slots, weight = weight, owner = owner, groups = groups }
    end
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:GetStash', function(source, cb, name)
    name = name:gsub("%-", "_")
    cb(stashes[name] and stashes[name] or nil)
end)

local shops = {}
Framework.RegisterShop = function(name, data)
    if shops[name] then return end
    shops[name] = data
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:OpenShop', function(source, cb, name)
    if not shops[name] then cb({}) end
    local isAllowed = false
    local Player = Framework.GetPlayer(source)
    if shops[name].groups and Framework.HasJob(shops[name].groups, Player) then isAllowed = true end
    if shops[name].groups and Framework.HasGang(shops[name].groups, Player) then isAllowed = true end
    if type(shops[name].groups) == "table" and (shops[name].groups and not isAllowed) then cb({}) end
    cb(shops[name])
end)

Framework.ConfiscateInventory = function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.SetMetaData("jailitems", exports['codem-inventory']:GetInventory(nil, src))
    Wait(2000)
    exports['codem-inventory']:ClearInventory(src)
end

Framework.ReturnInventory = function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local jailItems = Player.PlayerData.metadata['jailitems'] or {}
    for _, item in pairs(jailItems) do
        if item then
            exports['codem-inventory']:AddItem(src, item.name, item.amount, nil, item.info)
        end
    end
    Wait(2000)
    Player.Functions.SetMetaData("jailitems", {})
end

Framework.GetCurrentWeapon = function (inventory)
    return nil
end
