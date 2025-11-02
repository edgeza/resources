-- Dusa Garage Management System - Grade Validator
-- Version: 1.0.0
-- Job grade verification and access control

local GradeValidator = {}

-- Initialize grade validator
function GradeValidator.Init()
    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 Initializing GradeValidator...")
    end

    -- Register grade validation events
    GradeValidator.RegisterEvents()

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 GradeValidator initialized successfully")
    end
end

-- Register validation events
function GradeValidator.RegisterEvents()
    -- Validate grade for vehicle access
    RegisterNetEvent('dusa-garage:server:validateGradeAccess')
    AddEventHandler('dusa-garage:server:validateGradeAccess', function(vehicleModel, jobName)
        local source = source
        local validation = GradeValidator.ValidateVehicleAccess(source, vehicleModel, jobName)
        TriggerClientEvent('dusa-garage:client:gradeValidationResult', source, validation)
    end)
end

print('LOADED GRADE VALIDATOR')
-- Validate if player has required grade for vehicle access
function GradeValidator.ValidateVehicleAccess(source, vehicleModel, jobName)    
    local Player = Framework.GetPlayer(source)
    if not Player then
        return {
            success = false,
            error = "Player not found",
            errorCode = "PLAYER_NOT_FOUND"
        }
    end

    -- Get player job information
    local playerJob = GradeValidator.GetPlayerJobInfo(Player)
    if not playerJob then
        return {
            success = false,
            error = "Player has no job",
            errorCode = "NO_JOB"
        }
    end

    -- Check if player's job matches required job
    if playerJob.name ~= jobName then
        return {
            success = false,
            error = "Wrong job. Required: " .. jobName .. ", Your job: " .. playerJob.name,
            errorCode = "WRONG_JOB",
            required = {
                job = jobName
            },
            current = {
                job = playerJob.name,
                grade = playerJob.grade
            }
        }
    end

    -- Get vehicle configuration
    local ConfigManager = require('server.core.modules.config_manager')
    local jobVehicles = ConfigManager.GetJobVehicles(jobName)

    local vehicleConfig = nil
    for _, vehicle in ipairs(jobVehicles) do
        if vehicle.vehicle == vehicleModel then
            vehicleConfig = vehicle
            break
        end
    end

    if not vehicleConfig then
        return {
            success = false,
            error = "Vehicle not found in job configuration",
            errorCode = "VEHICLE_NOT_CONFIGURED"
        }
    end

    -- Check grade requirement
    if playerJob.grade < vehicleConfig.minGrade then
        return {
            success = false,
            error = "Insufficient job grade",
            errorCode = "INSUFFICIENT_GRADE",
            required = {
                job = jobName,
                grade = vehicleConfig.minGrade,
                gradeName = GradeValidator.GetGradeName(jobName, vehicleConfig.minGrade)
            },
            current = {
                job = playerJob.name,
                grade = playerJob.grade,
                gradeName = GradeValidator.GetGradeName(playerJob.name, playerJob.grade)
            },
            vehicle = {
                model = vehicleModel,
                displayName = vehicleConfig.displayName,
                category = vehicleConfig.category
            }
        }
    end

    -- Validation successful
    return {
        success = true,
        message = "Access granted",
        player = {
            job = playerJob.name,
            grade = playerJob.grade,
            gradeName = GradeValidator.GetGradeName(playerJob.name, playerJob.grade)
        },
        vehicle = {
            model = vehicleModel,
            displayName = vehicleConfig.displayName,
            category = vehicleConfig.category,
            minGrade = vehicleConfig.minGrade
        }
    }
end

-- Get player job information with enhanced grade details
function GradeValidator.GetPlayerJobInfo(Player)
    print('GetPlayerJobInfo [JOB]', Player)
    if not Player then return nil end

    -- Unified structure across all frameworks (dusa_bridge)
    if Player.Job then
        print('GetPlayerJobInfo [JOB]', Player.Job)
        return {
            name = Player.Job.Name,
            grade = Player.Job.Grade.Level or 0,
            label = Player.Job.Label or Player.Job.Name,
            gradeName = Player.Job.Grade.Name or "Unknown",
            isboss = Player.Job.Boss or false
        }
    end

    return nil
end

-- Get grade name for job and grade level
function GradeValidator.GetGradeName(jobName, gradeLevel)
    -- Default grade names - you can expand this based on your server's job configuration
    local defaultGradeNames = {
        ["police"] = {
            [0] = "Cadet",
            [1] = "Officer",
            [2] = "Senior Officer",
            [3] = "Corporal",
            [4] = "Sergeant",
            [5] = "Lieutenant",
            [6] = "Captain",
            [7] = "Commander",
            [8] = "Deputy Chief",
            [9] = "Chief"
        },
        ["ambulance"] = {
            [0] = "Trainee",
            [1] = "Paramedic",
            [2] = "Senior Paramedic",
            [3] = "Supervisor",
            [4] = "Manager",
            [5] = "Director"
        },
        ["fire"] = {
            [0] = "Trainee",
            [1] = "Firefighter",
            [2] = "Senior Firefighter",
            [3] = "Lieutenant",
            [4] = "Captain",
            [5] = "Chief"
        },
        ["mechanic"] = {
            [0] = "Apprentice",
            [1] = "Mechanic",
            [2] = "Senior Mechanic",
            [3] = "Supervisor",
            [4] = "Manager"
        },
        ["taxi"] = {
            [0] = "Driver",
            [1] = "Senior Driver",
            [2] = "Supervisor",
            [3] = "Manager"
        },
        ["bus"] = {
            [0] = "Driver",
            [1] = "Senior Driver",
            [2] = "Supervisor"
        },
        ["garbage"] = {
            [0] = "Worker",
            [1] = "Senior Worker",
            [2] = "Supervisor"
        },
        ["reporter"] = {
            [0] = "Intern",
            [1] = "Reporter",
            [2] = "Senior Reporter",
            [3] = "Editor"
        }
    }

    if defaultGradeNames[jobName] and defaultGradeNames[jobName][gradeLevel] then
        return defaultGradeNames[jobName][gradeLevel]
    end

    return "Grade " .. gradeLevel
end

-- Validate multiple vehicles at once (for UI loading)
function GradeValidator.ValidateMultipleVehicles(source, vehicles, jobName)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return {
            success = false,
            error = "Player not found"
        }
    end

    local playerJob = GradeValidator.GetPlayerJobInfo(Player)
    if not playerJob or playerJob.name ~= jobName then
        return {
            success = false,
            error = "Invalid job"
        }
    end

    local results = {}
    for _, vehicleModel in ipairs(vehicles) do
        local validation = GradeValidator.ValidateVehicleAccess(source, vehicleModel, jobName)
        results[vehicleModel] = validation
    end

    return {
        success = true,
        results = results,
        playerInfo = playerJob
    }
end

-- Check if player has minimum required grade for any job vehicle
function GradeValidator.HasAnyVehicleAccess(source, jobName)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return false
    end

    local playerJob = GradeValidator.GetPlayerJobInfo(Player)
    if not playerJob or playerJob.name ~= jobName then
        return false
    end

    local ConfigManager = require('server.core.modules.config_manager')
    local jobVehicles = ConfigManager.GetJobVehicles(jobName)

    for _, vehicle in ipairs(jobVehicles) do
        if playerJob.grade >= vehicle.minGrade then
            return true
        end
    end

    return false
end

-- Get accessible vehicles for player
function GradeValidator.GetAccessibleVehicles(source, jobName)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return {}
    end

    local playerJob = GradeValidator.GetPlayerJobInfo(Player)
    if not playerJob or playerJob.name ~= jobName then
        return {}
    end

    local ConfigManager = require('server.core.modules.config_manager')
    local jobVehicles = ConfigManager.GetJobVehicles(jobName)
    local accessibleVehicles = {}

    for _, vehicle in ipairs(jobVehicles) do
        if playerJob.grade >= vehicle.minGrade then
            table.insert(accessibleVehicles, vehicle)
        end
    end

    return accessibleVehicles
end

-- Get locked vehicles for player (for UI display)
function GradeValidator.GetLockedVehicles(source, jobName)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return {}
    end

    local playerJob = GradeValidator.GetPlayerJobInfo(Player)
    if not playerJob or playerJob.name ~= jobName then
        return {}
    end

    local ConfigManager = require('server.core.modules.config_manager')
    local jobVehicles = ConfigManager.GetJobVehicles(jobName)
    local lockedVehicles = {}

    for _, vehicle in ipairs(jobVehicles) do
        if playerJob.grade < vehicle.minGrade then
            local lockedVehicle = table.clone(vehicle)
            lockedVehicle.requiredGradeName = GradeValidator.GetGradeName(jobName, vehicle.minGrade)
            lockedVehicle.playerGrade = playerJob.grade
            lockedVehicle.playerGradeName = GradeValidator.GetGradeName(jobName, playerJob.grade)
            table.insert(lockedVehicles, lockedVehicle)
        end
    end

    return lockedVehicles
end

-- Generate user-friendly error messages
function GradeValidator.GetErrorMessage(validation)
    if validation.success then
        return nil
    end

    local messages = {
        PLAYER_NOT_FOUND = "Player information not found. Please try again.",
        NO_JOB = "You must have a job to access job vehicles.",
        WRONG_JOB = function(v)
            return string.format("This vehicle requires the %s job. You are currently employed as %s.",
                v.required.job, v.current.job)
        end,
        VEHICLE_NOT_CONFIGURED = "This vehicle is not configured for your job.",
        INSUFFICIENT_GRADE = function(v)
            return string.format("You need %s rank (%s) to access this vehicle. Your current rank is %s (%s).",
                v.required.gradeName, v.required.grade,
                v.current.gradeName, v.current.grade)
        end
    }

    local message = messages[validation.errorCode]
    if type(message) == "function" then
        return message(validation)
    elseif type(message) == "string" then
        return message
    else
        return validation.error or "Access denied"
    end
end

-- Table clone utility function
function table.clone(t)
    local clone = {}
    for k, v in pairs(t) do
        clone[k] = v
    end
    return clone
end

-- Export the module
return GradeValidator