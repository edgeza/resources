if not rawget(_G, "lib") then include('ox_lib', 'init') end

--- Used to send NUI events to the UI
--- @param action string
--- @param data any
function SendNUIEvent(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

-- ========================================
-- Vehicle Properties Helper Functions
-- ========================================

--- Get vehicle properties from a vehicle entity
--- Framework-agnostic wrapper around lib.getVehicleProperties
--- @param vehicle number Vehicle entity handle
--- @return table? Properties table or nil if vehicle doesn't exist
local function GetVehicleProperties(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then
        return nil
    end

    -- Use lib.getVehicleProperties as default
    -- Framework-specific logic can be added here if needed in the future
    return lib.getVehicleProperties(vehicle)
end

--- Set vehicle properties to a vehicle entity
--- Framework-agnostic wrapper around lib.setVehicleProperties
--- @param vehicle number Vehicle entity handle
--- @param props table Properties table
--- @return boolean Success status
local function SetVehicleProperties(vehicle, props)
    if not vehicle or not DoesEntityExist(vehicle) then
        return false
    end

    if not props or type(props) ~= "table" then
        return false
    end

    -- Use lib.setVehicleProperties as default
    -- Framework-specific logic can be added here if needed in the future
    lib.setVehicleProperties(vehicle, props)
    return true
end

-- Export functions globally for use in other client files
_G.GetVehicleProperties = GetVehicleProperties
_G.SetVehicleProperties = SetVehicleProperties

--- Callback to get vehicle display name from model hash
--- @param modelHash number
--- @return string
lib.callback.register('dusa-garage:client:getVehicleDisplayName', function(modelHash)
    if not modelHash then
        return "Unknown"
    end

    -- Convert to number if it's a string
    if type(modelHash) == "string" then
        modelHash = tonumber(modelHash)
    end

    if not modelHash then
        return "Unknown"
    end

    -- Get display name from model hash
    local displayName = GetDisplayNameFromVehicleModel(modelHash)

    -- Return display name or Unknown as fallback
    return displayName or "Unknown"
end)

--- Server callback: Set vehicle properties (called from server)
lib.callback.register('garage:client:setVehicleProperties', function(vehicleNetId, props)
    if not vehicleNetId or not props then
        return false
    end

    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not vehicle or vehicle == 0 or not DoesEntityExist(vehicle) then
        return false
    end

    return SetVehicleProperties(vehicle, props)
end)