-- Dusa Garage Management System - Config Manager
-- Version: 1.0.0
-- Hot-reload config system for job vehicles

local ConfigManager = {}
local LoadedConfigs = {}
local ValidationErrors = {}

-- Initialize config manager
function ConfigManager.Init()
    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 Initializing ConfigManager...")
    end

    -- Load initial job vehicle configuration
    ConfigManager.LoadJobVehicleConfig()

    -- Register config reload command for admins
    if Config.JobVehicleHotReload.Enabled then
        ConfigManager.RegisterReloadCommand()
    end

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 ConfigManager initialized successfully")
    end
end

-- Load job vehicle configuration from file
function ConfigManager.LoadJobVehicleConfig()
    local configPath = "config/job_vehicles.lua"

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^3[Dusa Garage]^7 Loading job vehicle config from: " .. configPath)
    end

    -- Clear previous validation errors
    ValidationErrors = {}

    -- Load the config file
    local success, result = pcall(function()
        return LoadResourceFile(GetCurrentResourceName(), configPath)
    end)

    if not success or not result then
        local error = "Failed to load job vehicle config file: " .. configPath
        table.insert(ValidationErrors, error)
        if Config.Debug.Enabled then
            print("^1[Dusa Garage ERROR]^7 " .. error)
        end
        return false
    end

    -- Execute the config file to load Config.JobVehicles
    local configFunction, loadError = load(result)
    if not configFunction then
        local error = "Failed to parse job vehicle config: " .. (loadError or "Unknown error")
        table.insert(ValidationErrors, error)
        if Config.Debug.Enabled then
            print("^1[Dusa Garage ERROR]^7 " .. error)
        end
        return false
    end

    -- Execute the config
    local executeSuccess, executeError = pcall(configFunction)
    if not executeSuccess then
        local error = "Failed to execute job vehicle config: " .. (executeError or "Unknown error")
        table.insert(ValidationErrors, error)
        if Config.Debug.Enabled then
            print("^1[Dusa Garage ERROR]^7 " .. error)
        end
        return false
    end

    -- Validate the loaded configuration
    if Config.JobVehicleHotReload.ValidateOnReload then
        local isValid = ConfigManager.ValidateJobVehicleConfig()
        if not isValid then
            if Config.Debug.Enabled then
                print("^1[Dusa Garage ERROR]^7 Job vehicle config validation failed")
            end
            return false
        end
    end

    -- Store the loaded config
    LoadedConfigs.JobVehicles = Config.JobVehicles
    LoadedConfigs.JobVehicleCategories = Config.JobVehicleCategories

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        local jobCount = 0
        local vehicleCount = 0
        for jobName, vehicles in pairs(Config.JobVehicles or {}) do
            jobCount = jobCount + 1
            vehicleCount = vehicleCount + #vehicles
        end
        print("^2[Dusa Garage]^7 Loaded " .. vehicleCount .. " vehicles across " .. jobCount .. " jobs")
    end

    return true
end

-- Save job vehicle configuration to file
function ConfigManager.SaveJobVehicleConfig(newConfig, source)
    if not newConfig then
        if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
            print("^1[Dusa Garage ERROR]^7 No config provided to save")
        end
        return false, "No configuration provided"
    end

    local configPath = "config/job_vehicles.lua"

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^3[Dusa Garage]^7 Saving job vehicle config to: " .. configPath)
    end

    -- Generate config file content
    local configContent = GenerateConfigFileContent(newConfig)

    -- Save to file
    local success = SaveResourceFile(GetCurrentResourceName(), configPath, configContent, -1)

    if success then
        -- Update in-memory config
        Config.JobVehicles = newConfig
        LoadedConfigs.JobVehicles = newConfig

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
            print("^2[Dusa Garage]^7 Job vehicle config saved successfully")
        end

        return true, "Configuration saved successfully"
    else
        local error = "Failed to save configuration file"
        if Config.Debug.Enabled then
            print("^1[Dusa Garage ERROR]^7 " .. error)
        end
        return false, error
    end
end

-- Generate config file content from config table
function GenerateConfigFileContent(jobVehicles)
    local lines = {
        "-- Dusa Garage Management System - Job Vehicle Configuration",
        "-- Version: 1.0.0",
        "-- Advanced job garage features with grade restrictions and ownership tracking",
        "-- Auto-generated by Config Editor",
        "",
        "Config = Config or {}",
        "",
        "-- Job Vehicle Configuration System",
        "Config.JobVehicles = {"
    }

    -- Get all job names and sort them for consistent ordering
    local jobNames = {}
    for key in pairs(jobVehicles) do
        table.insert(jobNames, key)
    end
    table.sort(jobNames)

    for i, jobName in ipairs(jobNames) do
        local vehicles = jobVehicles[jobName]
        table.insert(lines, "    -- " .. string.upper(jobName:sub(1,1)) .. jobName:sub(2) .. " Department Vehicles")
        table.insert(lines, "    [\"" .. jobName .. "\"] = {")

        for i, vehicle in ipairs(vehicles) do
            table.insert(lines, "        {")
            table.insert(lines, "            vehicle = \"" .. vehicle.vehicle .. "\",")
            table.insert(lines, "            displayName = \"" .. vehicle.displayName .. "\",")
            table.insert(lines, "            minGrade = " .. vehicle.minGrade .. ",")
            table.insert(lines, "            category = \"" .. vehicle.category .. "\",")
            table.insert(lines, "            description = \"" .. vehicle.description .. "\",")
            table.insert(lines, "            vehicleType = \"" .. (vehicle.vehicleType or "car") .. "\"")

            if i < #vehicles then
                table.insert(lines, "        },")
            else
                table.insert(lines, "        }")
            end
        end

        -- Check if this is the last job in the sorted list
        local isLastJob = (i == #jobNames)

        if isLastJob then
            table.insert(lines, "    }")
        else
            table.insert(lines, "    },")
        end
        table.insert(lines, "")
    end

    table.insert(lines, "}")
    table.insert(lines, "")

    return table.concat(lines, "\n")
end

-- Validate job vehicle configuration
function ConfigManager.ValidateJobVehicleConfig()
    if not Config.JobVehicles then
        table.insert(ValidationErrors, "Config.JobVehicles is missing")
        return false
    end

    if type(Config.JobVehicles) ~= "table" then
        table.insert(ValidationErrors, "Config.JobVehicles must be a table")
        return false
    end

    local validation = Config.JobVehicleValidation
    local isValid = true

    for jobName, vehicles in pairs(Config.JobVehicles) do
        if type(vehicles) ~= "table" then
            table.insert(ValidationErrors, "Job '" .. jobName .. "' vehicles must be a table")
            isValid = false
            goto continue
        end

        for i, vehicle in ipairs(vehicles) do
            local vehicleId = jobName .. "[" .. i .. "]"

            -- Check required fields
            for _, field in ipairs(validation.RequiredFields) do
                if vehicle[field] == nil then
                    table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " missing required field: " .. field)
                    isValid = false
                end
            end

            -- Check field types
            for field, expectedType in pairs(validation.FieldTypes) do
                if vehicle[field] ~= nil and type(vehicle[field]) ~= expectedType then
                    table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " field '" .. field .. "' must be " .. expectedType)
                    isValid = false
                end
            end

            -- Check constraints
            if vehicle.minGrade then
                local gradeConstraint = validation.Constraints.minGrade
                if vehicle.minGrade < gradeConstraint.min or vehicle.minGrade > gradeConstraint.max then
                    table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " minGrade must be between " .. gradeConstraint.min .. " and " .. gradeConstraint.max)
                    isValid = false
                end
            end

            -- Check string length constraints
            for field, constraint in pairs(validation.Constraints) do
                if vehicle[field] and type(vehicle[field]) == "string" then
                    local length = string.len(vehicle[field])
                    if constraint.minLength and length < constraint.minLength then
                        table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " field '" .. field .. "' too short (min: " .. constraint.minLength .. ")")
                        isValid = false
                    end
                    if constraint.maxLength and length > constraint.maxLength then
                        table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " field '" .. field .. "' too long (max: " .. constraint.maxLength .. ")")
                        isValid = false
                    end
                end
            end

            -- Check if category exists in categories config
            if vehicle.category and Config.JobVehicleCategories then
                if not Config.JobVehicleCategories[vehicle.category] then
                    table.insert(ValidationErrors, "Vehicle " .. vehicleId .. " uses undefined category: " .. vehicle.category)
                    isValid = false
                end
            end
        end

        ::continue::
    end

    if not isValid and Config.Debug.Enabled then
        print("^1[Dusa Garage ERROR]^7 Configuration validation errors:")
        for _, error in ipairs(ValidationErrors) do
            print("^1[Dusa Garage ERROR]^7 - " .. error)
        end
    end

    return isValid
end

-- Register admin command for config reload
function ConfigManager.RegisterReloadCommand()
    RegisterCommand("garage:reload-config", function(source, args, rawCommand)
        if source == 0 then
            -- Console command
            ConfigManager.ReloadJobVehicleConfig(0)
        else
            -- Player command - check admin permissions
            local Player = Framework.GetPlayer(source)
            if not Player then
                return
            end

            -- Use FiveM's native ACE permission system for admin check
            local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                           IsPlayerAceAllowed(source, "admin") or
                           IsPlayerAceAllowed(source, "group.admin")

            if Config.JobVehicleHotReload.AdminOnly and not isAdmin then
                TriggerClientEvent('dusa-garage:client:notification', source, "You don't have permission to reload config", "error")
                return
            end

            ConfigManager.ReloadJobVehicleConfig(source)
        end
    end, false)

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 Registered config reload command: /garage:reload-config")
    end
end

-- Reload job vehicle configuration
function ConfigManager.ReloadJobVehicleConfig(source)
    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^3[Dusa Garage]^7 Reloading job vehicle configuration...")
    end

    local success = ConfigManager.LoadJobVehicleConfig()

    if success then
        local message = "Job vehicle configuration reloaded successfully"
        if source == 0 then
            print("^2[Dusa Garage]^7 " .. message)
        else
            TriggerClientEvent('dusa-garage:client:notification', source, message, "success")
            if Config.Debug.Enabled then
                print("^2[Dusa Garage]^7 " .. message .. " (requested by player " .. source .. ")")
            end
        end

        -- Notify other admins if configured
        if Config.JobVehicleHotReload.NotifyPlayers and source ~= 0 then
            TriggerClientEvent('dusa-garage:client:notification', -1, "Job vehicle configuration has been updated", "info")
        end
    else
        local message = "Failed to reload job vehicle configuration"
        if #ValidationErrors > 0 then
            message = message .. ": " .. table.concat(ValidationErrors, ", ")
        end

        if source == 0 then
            print("^1[Dusa Garage ERROR]^7 " .. message)
        else
            TriggerClientEvent('dusa-garage:client:notification', source, message, "error")
        end
    end

    return success
end

-- Get loaded job vehicles for a specific job
function ConfigManager.GetJobVehicles(jobName)
    if not LoadedConfigs.JobVehicles then
        return {}
    end

    return LoadedConfigs.JobVehicles[jobName] or {}
end

-- Get all loaded job vehicles
function ConfigManager.GetAllJobVehicles()
    return LoadedConfigs.JobVehicles or {}
end

-- Get job vehicle categories
function ConfigManager.GetJobVehicleCategories()
    return LoadedConfigs.JobVehicleCategories or {}
end

-- Get validation errors
function ConfigManager.GetValidationErrors()
    return ValidationErrors
end

-- Check if config is loaded and valid
function ConfigManager.IsConfigValid()
    return LoadedConfigs.JobVehicles ~= nil and #ValidationErrors == 0
end

-- Export the module
return ConfigManager