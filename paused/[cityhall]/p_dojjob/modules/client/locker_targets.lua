-- Locker target creation script
-- This ensures all configured lockers have proper targets

CreateThread(function()
    Wait(2000) -- Wait for everything to load
    
    print('^2[DOJ Job]^7 Creating locker targets...')
    
    -- Create targets for regular lockers
    for lockerId, lockerData in pairs(Config.Lockers) do
        local success = pcall(function()
            exports['qb-target']:AddBoxZone(lockerId .. '_locker', lockerData.coords, 1.0, 1.0, {
                name = lockerId .. '_locker',
                heading = 0.0,
                debugPoly = Config.Debug,
                minZ = lockerData.coords.z - 1.0,
                maxZ = lockerData.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "p_dojjob:openLocker",
                        icon = "fas fa-box",
                        label = "Open Locker",
                        job = lockerData.jobs,
                        lockerId = lockerId,
                        lockerData = lockerData
                    },
                },
                distance = 2.0
            })
        end)
        
        if success then
            print('^2[DOJ Job]^7 Created target for locker: ' .. lockerId)
        else
            print('^1[DOJ Job]^7 Failed to create target for locker: ' .. lockerId)
        end
    end

    -- Create targets for document lockers
    for lockerId, lockerData in pairs(Config.DocumentLockers) do
        local success = pcall(function()
            exports['qb-target']:AddBoxZone(lockerId .. '_document_locker', lockerData.coords, 1.0, 1.0, {
                name = lockerId .. '_document_locker',
                heading = 0.0,
                debugPoly = Config.Debug,
                minZ = lockerData.coords.z - 1.0,
                maxZ = lockerData.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "p_dojjob:openDocumentLocker",
                        icon = "fas fa-file-alt",
                        label = "Open Document Locker",
                        job = lockerData.jobs,
                        lockerId = lockerId,
                        lockerData = lockerData
                    },
                },
                distance = 2.0
            })
        end)
        
        if success then
            print('^2[DOJ Job]^7 Created target for document locker: ' .. lockerId)
        else
            print('^1[DOJ Job]^7 Failed to create target for document locker: ' .. lockerId)
        end
    end
    
    print('^2[DOJ Job]^7 Locker targets created successfully')
end)

-- Open regular locker
RegisterNetEvent('p_dojjob:openLocker', function(data)
    local lockerId = data.lockerId
    local lockerData = data.lockerData
    
    print('^3[DOJ Job]^7 Opening locker: ' .. lockerId .. '_Locker')
    print('^3[DOJ Job]^7 Locker ID: ' .. tostring(lockerId))
    print('^3[DOJ Job]^7 Locker Data: ' .. json.encode(lockerData))
    
    -- Check which inventory system is available
    local qsInventory = GetResourceState('qs-inventory')
    local oxInventory = GetResourceState('ox_inventory')
    local qbInventory = GetResourceState('qb-inventory')
    
    print('^3[DOJ Job]^7 Inventory systems - qs-inventory: ' .. tostring(qsInventory) .. ', ox_inventory: ' .. tostring(oxInventory) .. ', qb-inventory: ' .. tostring(qbInventory))
    
    -- Open inventory based on the inventory system being used
    if qsInventory == 'started' then
        print('^2[DOJ Job]^7 Using qs-inventory')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', lockerId .. '_Locker', {maxweight = lockerData.weight, slots = lockerData.slots})
    elseif oxInventory == 'started' then
        print('^2[DOJ Job]^7 Using ox_inventory')
        exports.ox_inventory:openInventory('stash', lockerId .. '_Locker')
    elseif qbInventory == 'started' then
        print('^2[DOJ Job]^7 Using qb-inventory')
        TriggerClientEvent('inventory:client:SetCurrentStash', GetPlayerServerId(PlayerId()), lockerId .. '_Locker')
        TriggerClientEvent('inventory:client:OpenStash', GetPlayerServerId(PlayerId()))
    else
        print('^1[DOJ Job]^7 No compatible inventory system found')
        print('^1[DOJ Job]^7 Available resources:')
        for i = 0, GetNumResources() - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if string.find(resourceName, 'inventory') then
                print('^3[DOJ Job]^7 - ' .. resourceName .. ': ' .. GetResourceState(resourceName))
            end
        end
    end
end)

-- Open document locker
RegisterNetEvent('p_dojjob:openDocumentLocker', function(data)
    local baseLockerId = data.lockerId
    local lockerData = data.lockerData
    
    print('^3[DOJ Job]^7 Document locker clicked: ' .. baseLockerId)
    print('^3[DOJ Job]^7 Locker Data: ' .. json.encode(lockerData))
    
    -- Prompt user for locker ID
    local input = lib.inputDialog(locale('document_locker'), {
        {
            type = 'input',
            label = locale('locker_id'),
            description = locale('enter_locker_id'),
            required = true,
            min = 1,
            max = 999999
        }
    })
    
    if not input or not input[1] then
        print('^1[DOJ Job]^7 User cancelled locker ID input')
        return
    end
    
    local userLockerId = tostring(input[1])
    local finalLockerId = baseLockerId .. '_' .. userLockerId
    
    print('^3[DOJ Job]^7 Opening document locker: ' .. finalLockerId .. '_Document_Locker')
    print('^3[DOJ Job]^7 User Locker ID: ' .. userLockerId)
    print('^3[DOJ Job]^7 Final Locker ID: ' .. finalLockerId)
    
    -- Check which inventory system is available
    local qsInventory = GetResourceState('qs-inventory')
    local oxInventory = GetResourceState('ox_inventory')
    local qbInventory = GetResourceState('qb-inventory')
    
    print('^3[DOJ Job]^7 Inventory systems - qs-inventory: ' .. tostring(qsInventory) .. ', ox_inventory: ' .. tostring(oxInventory) .. ', qb-inventory: ' .. tostring(qbInventory))
    
    -- Open inventory based on the inventory system being used
    if qsInventory == 'started' then
        print('^2[DOJ Job]^7 Using qs-inventory')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', finalLockerId .. '_Document_Locker', {maxweight = lockerData.weight, slots = lockerData.slots})
    elseif oxInventory == 'started' then
        print('^2[DOJ Job]^7 Using ox_inventory')
        exports.ox_inventory:openInventory('stash', finalLockerId .. '_Document_Locker')
    elseif qbInventory == 'started' then
        print('^2[DOJ Job]^7 Using qb-inventory')
        TriggerClientEvent('inventory:client:SetCurrentStash', GetPlayerServerId(PlayerId()), finalLockerId .. '_Document_Locker')
        TriggerClientEvent('inventory:client:OpenStash', GetPlayerServerId(PlayerId()))
    else
        print('^1[DOJ Job]^7 No compatible inventory system found')
        print('^1[DOJ Job]^7 Available resources:')
        for i = 0, GetNumResources() - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if string.find(resourceName, 'inventory') then
                print('^3[DOJ Job]^7 - ' .. resourceName .. ': ' .. GetResourceState(resourceName))
            end
        end
    end
end) 