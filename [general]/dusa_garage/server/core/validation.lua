-- JSON Input Validation Module
-- Provides validation for JSON data before database operations

Validation = {}

-- JSON schema validators for each table
Validation.Schemas = {
    dusa_garages = {
        locations = {
            required_fields = { "interaction", "spawn" },
            optional_fields = { "parking" },
            interaction = { x = "number", y = "number", z = "number" },
            spawn = { x = "number", y = "number", z = "number", h = "number" },
            parking = "array" -- Array of parking spots with x, y, z, h
        },
        settings = {
            optional_fields = { "transferFee", "maxVehicles", "restrictions" },
            transferFee = "number",
            maxVehicles = "number",
            restrictions = "table"
        }
    },
    dusa_vehicle_metadata = {
        health_props = {
            optional_fields = { "engine", "body", "brakes", "transmission", "clutch", "radiator", "fuel", "tires" },
            engine = "number",
            body = "number",
            brakes = "number",
            transmission = "number",
            clutch = "number",
            radiator = "number",
            fuel = "number",
            tires = "number"
        }
    },
    dusa_car_meets = {
        location = {
            required_fields = { "x", "y", "z" },
            optional_fields = { "h", "radius", "name" },
            x = "number",
            y = "number",
            z = "number",
            h = "number",
            radius = "number",
            name = "string"
        }
    }
}

-- Validate value against expected type
function Validation.ValidateType(value, expectedType)
    local actualType = type(value)

    if expectedType == "array" then
        return actualType == "table" and value[1] ~= nil
    elseif expectedType == "number" then
        return actualType == "number" and not (value ~= value) -- Check for NaN
    elseif expectedType == "string" then
        return actualType == "string" and #value > 0
    elseif expectedType == "table" then
        return actualType == "table"
    else
        return actualType == expectedType
    end
end

-- Sanitize string values to prevent injection
function Validation.SanitizeString(str)
    if type(str) ~= "string" then
        return str
    end

    -- Remove null bytes and control characters except newlines
    str = string.gsub(str, "[\000-\008\011\012\014-\031\127]", "")

    -- Limit string length
    if #str > 1000 then
        str = string.sub(str, 1, 1000)
    end

    return str
end

-- Validate coordinate values
function Validation.ValidateCoordinate(coord)
    if type(coord) ~= "number" then
        return false, "Coordinate must be a number"
    end

    -- GTA V world coordinates are roughly -4000 to 4000
    if coord < -5000 or coord > 5000 then
        return false, "Coordinate out of valid range"
    end

    return true
end

-- Validate JSON object against schema
function Validation.ValidateJsonObject(data, schema)
    if type(data) ~= "table" then
        return false, "Data must be a table/object"
    end

    local errors = {}

    -- Check required fields
    if schema.required_fields then
        for _, field in ipairs(schema.required_fields) do
            if data[field] == nil then
                table.insert(errors, ("Missing required field: %s"):format(field))
            end
        end
    end

    -- Validate all fields in data
    for key, value in pairs(data) do
        if schema[key] then
            local expectedType = schema[key]

            if type(expectedType) == "table" then
                -- Nested object validation
                local success, nestedErrors = Validation.ValidateJsonObject(value, expectedType)
                if not success then
                    for _, err in ipairs(nestedErrors) do
                        table.insert(errors, ("%s.%s"):format(key, err))
                    end
                end
            else
                -- Type validation
                if not Validation.ValidateType(value, expectedType) then
                    table.insert(errors, ("Field '%s' should be %s, got %s"):format(key, expectedType, type(value)))
                end

                -- Special coordinate validation
                if expectedType == "number" and (key == "x" or key == "y" or key == "z") then
                    local valid, err = Validation.ValidateCoordinate(value)
                    if not valid then
                        table.insert(errors, ("Field '%s': %s"):format(key, err))
                    end
                end

                -- String sanitization
                if expectedType == "string" then
                    data[key] = Validation.SanitizeString(value)
                end
            end
        else
            -- Check if field is allowed (required or optional)
            local allowed = false
            if schema.required_fields then
                for _, field in ipairs(schema.required_fields) do
                    if field == key then
                        allowed = true
                        break
                    end
                end
            end
            if not allowed and schema.optional_fields then
                for _, field in ipairs(schema.optional_fields) do
                    if field == key then
                        allowed = true
                        break
                    end
                end
            end

            if not allowed then
                table.insert(errors, ("Unknown field: %s"):format(key))
            end
        end
    end

    if #errors > 0 then
        return false, errors
    end

    return true, data
end

-- Validate garage locations JSON
function Validation.ValidateGarageLocations(locations)
    if type(locations) == "string" then
        local success, decoded = pcall(json.decode, locations)
        if not success then
            return false, "Invalid JSON format"
        end
        locations = decoded
    end

    return Validation.ValidateJsonObject(locations, Validation.Schemas.dusa_garages.locations)
end

-- Validate garage settings JSON
function Validation.ValidateGarageSettings(settings)
    if settings == nil then
        return true, nil -- Settings are optional
    end

    if type(settings) == "string" then
        local success, decoded = pcall(json.decode, settings)
        if not success then
            return false, "Invalid JSON format"
        end
        settings = decoded
    end

    return Validation.ValidateJsonObject(settings, Validation.Schemas.dusa_garages.settings)
end

-- Validate vehicle health properties JSON
function Validation.ValidateVehicleHealth(healthProps)
    if healthProps == nil then
        return true, nil -- Health props are optional
    end

    if type(healthProps) == "string" then
        local success, decoded = pcall(json.decode, healthProps)
        if not success then
            return false, "Invalid JSON format"
        end
        healthProps = decoded
    end

    return Validation.ValidateJsonObject(healthProps, Validation.Schemas.dusa_vehicle_metadata.health_props)
end

-- Validate car meet location JSON
function Validation.ValidateCarMeetLocation(location)
    if type(location) == "string" then
        local success, decoded = pcall(json.decode, location)
        if not success then
            return false, "Invalid JSON format"
        end
        location = decoded
    end

    return Validation.ValidateJsonObject(location, Validation.Schemas.dusa_car_meets.location)
end

-- Main validation function for database operations
function Validation.ValidateForDatabase(tableName, columnName, data)
    if tableName == "dusa_garages" then
        if columnName == "locations" then
            return Validation.ValidateGarageLocations(data)
        elseif columnName == "settings" then
            return Validation.ValidateGarageSettings(data)
        end
    elseif tableName == "dusa_vehicle_metadata" then
        if columnName == "health_props" then
            return Validation.ValidateVehicleHealth(data)
        end
    elseif tableName == "dusa_car_meets" then
        if columnName == "location" then
            return Validation.ValidateCarMeetLocation(data)
        end
    end

    return false, ("Unknown table/column combination: %s.%s"):format(tableName, columnName)
end

return Validation