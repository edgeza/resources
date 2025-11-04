-- Test Commands for Development and Validation
-- Server-side commands to run tests and validate implementation

local resourceName = GetCurrentResourceName()

-- Command to run all tests
RegisterCommand('garage:test:all', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    print(("[%s] Running all tests..."):format(resourceName))

    -- Load and run all test suites
    CreateThread(function()
        -- Database schema tests
        LoadResourceFile(resourceName, 'tests/unit/database_schema_test.lua')
        Wait(2000)

        -- Validation tests
        LoadResourceFile(resourceName, 'tests/unit/validation_test.lua')
        Wait(1000)

        -- Garage operations tests
        LoadResourceFile(resourceName, 'tests/unit/garage_operations_test.lua')
        Wait(2000)

        -- Bridge integration tests
        LoadResourceFile(resourceName, 'tests/integration/bridge_integration_test.lua')
        Wait(1000)

        -- Garage NUI integration tests
        LoadResourceFile(resourceName, 'tests/integration/garage_nui_test.lua')
        Wait(3000)

        print(("[%s] All tests completed. Check output above for results."):format(resourceName))
    end)
end, true) -- Restricted to server console

-- Command to run bridge integration tests
RegisterCommand('garage:test:bridge', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    print(("[%s] Running bridge integration tests..."):format(resourceName))
    LoadResourceFile(resourceName, 'tests/integration/bridge_integration_test.lua')
end, true)

-- Command to validate database schema
RegisterCommand('garage:validate:schema', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    if not Database then
        return print(("[%s] ERROR: Database not available"):format(resourceName))
    end

    print(("[%s] Validating database schema..."):format(resourceName))

    local tables = {'dusa_garages', 'dusa_vehicle_metadata', 'dusa_car_meets'}
    local completed = 0

    for _, tableName in ipairs(tables) do
        local query = [[
            SELECT COUNT(*) as count
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
            AND table_name = ?
        ]]

        Database.Fetch(query, {tableName}, function(result)
            completed = completed + 1
            if result and result[1] and result[1].count > 0 then
                print(("✓ Table %s exists"):format(tableName))
            else
                print(("✗ Table %s missing"):format(tableName))
            end

            if completed == #tables then
                print(("[%s] Schema validation completed"):format(resourceName))
            end
        end)
    end
end, true)

-- Command to test JSON validation
RegisterCommand('garage:test:validation', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    local ValidationModule = LoadResourceFile(resourceName, 'server/core/validation.lua')
    if not ValidationModule then
        return print(("[%s] ERROR: Could not load validation module"):format(resourceName))
    end

    local Validation = load(ValidationModule)()

    print(("[%s] Testing JSON validation..."):format(resourceName))

    -- Test valid garage locations
    local validLocations = {
        interaction = { x = 100.0, y = 200.0, z = 30.0 },
        spawn = { x = 110.0, y = 210.0, z = 30.0, h = 180.0 }
    }

    local isValid, result = Validation.ValidateGarageLocations(validLocations)
    if isValid then
        print("✓ Valid garage locations passed validation")
    else
        print("✗ Valid garage locations failed validation: " .. tostring(result))
    end

    -- Test invalid garage locations
    local invalidLocations = {
        interaction = { x = "invalid", y = 200.0, z = 30.0 }
    }

    local isInvalid, errors = Validation.ValidateGarageLocations(invalidLocations)
    if not isInvalid then
        print("✓ Invalid garage locations correctly rejected")
    else
        print("✗ Invalid garage locations incorrectly accepted")
    end

    print(("[%s] Validation test completed"):format(resourceName))
end, true)

-- Command to check bridge status
RegisterCommand('garage:status:bridge', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    print(("[%s] Dusa Bridge Status:"):format(resourceName))

    if Bridge then
        print(("✓ Dusa Bridge loaded"))
        print(("✓ Framework: %s"):format(Bridge.Framework or "Unknown framework"))
        print(("✓ Inventory: %s"):format(Bridge.Inventory or "Unknown inventory"))
        print(("✓ Target: %s"):format(Bridge.Target or "Unknown target"))
    else
        print("✗ Dusa Bridge not loaded")
    end

    if Database then
        print("✓ Dusa Bridge Database module available")
    else
        print("✗ Dusa Bridge Database module not available")
    end

    if Framework then
        print("✓ Dusa Bridge Framework object available")
    else
        print("✗ Dusa Bridge Framework object not available")
    end

    if Inventory then
        print("✓ Dusa Bridge Inventory object available")
    else
        print("✗ Dusa Bridge Inventory object not available")
    end

    if Target then
        print("✓ Dusa Bridge Target object available")
    else
        print("✗ Dusa Bridge Target object not available")
    end
end, true)

-- Command to run garage-specific tests only
RegisterCommand('garage:test:garage', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    print(("[%s] Running garage-specific tests..."):format(resourceName))

    CreateThread(function()
        -- Garage operations tests
        LoadResourceFile(resourceName, 'tests/unit/garage_operations_test.lua')
        Wait(2000)

        -- Garage NUI integration tests
        LoadResourceFile(resourceName, 'tests/integration/garage_nui_test.lua')
        Wait(3000)

        print(("[%s] Garage tests completed."):format(resourceName))
    end)
end, true)

-- Command to test garage operations specifically
RegisterCommand('garage:test:operations', function(source, args)
    if source ~= 0 then
        return print("This command can only be run from server console")
    end

    print(("[%s] Testing garage operations..."):format(resourceName))

    local GarageManagerModule = LoadResourceFile(resourceName, 'server/core/garage.lua')
    if not GarageManagerModule then
        return print(("[%s] ERROR: Could not load garage manager"):format(resourceName))
    end

    local GarageManager = load(GarageManagerModule)()

    -- Test garage location loading
    local garages = GarageManager.GetAllGarageLocations()
    print(("[%s] Loaded %d garage locations"):format(resourceName, #garages))

    for _, garage in ipairs(garages) do
        print(("  - %s (ID: %s, Type: %s)"):format(garage.name, garage.id, garage.type))
    end

    print(("[%s] Garage operations test completed"):format(resourceName))
end, true)

print(("[%s] Test commands registered: garage:test:all, garage:test:bridge, garage:test:garage, garage:test:operations, garage:validate:schema, garage:test:validation, garage:status:bridge"):format(resourceName))