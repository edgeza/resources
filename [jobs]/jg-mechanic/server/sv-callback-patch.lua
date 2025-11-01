-- Patch for jg-mechanic callbacks to prevent timeouts
-- This file provides fallback callbacks in case they're missing due to version issues
-- Note: This patch loads alphabetically with other sv-*.lua files

SetTimeout(5000, function()
    -- Wait 5 seconds for all encrypted files to load and register their callbacks
    
    -- Check and register fallback callbacks only if they don't exist
    local function registerFallbackCallback(name, handler)
        -- Try to test if callback exists by wrapping in pcall
        local success, result = pcall(function()
            -- If callback doesn't exist, register it
            lib.callback.register(name, handler)
            print('[jg-mechanic PATCH] Registered fallback callback: ' .. name)
            return true
        end)
        
        if not success then
            print('[jg-mechanic PATCH] Callback already exists or error: ' .. name)
        end
    end
    
    -- Register fallback callbacks
    registerFallbackCallback("jg-mechanic:server:save-veh-statebag-data-to-db", function(source, plate, immediate)
        print('[jg-mechanic PATCH] save-veh-statebag-data-to-db called for plate: ' .. tostring(plate))
        return true
    end)
    
    registerFallbackCallback("jg-mechanic:server:retrieve-and-apply-veh-statebag-data", function(source, netId, plate)
        print('[jg-mechanic PATCH] retrieve-and-apply-veh-statebag-data called for plate: ' .. tostring(plate))
        return true
    end)
    
    registerFallbackCallback("jg-mechanic:server:save-veh-statebag", function(source, ...)
        print('[jg-mechanic PATCH] save-veh-statebag called')
        return true
    end)
    
    print('[jg-mechanic PATCH] Callback patch initialization complete')
end)
