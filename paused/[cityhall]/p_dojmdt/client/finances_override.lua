-- Finances Override - Prevents automatic loading
-- This script overrides the default finances behavior to only load on search

local financesTabClicked = false
local searchPerformed = false

-- Override the default finances loading behavior
local function overrideFinancesLoading()
    -- Listen for NUI messages to detect finances tab clicks
    RegisterNUICallback('finances_tab_clicked', function(data, cb)
        print('[p_dojmdt] Debug: Finances tab clicked - preventing automatic load')
        financesTabClicked = true
        searchPerformed = false
        
        -- Send empty data to prevent loading
        SendNUIMessage({
            type = 'finances_data',
            accounts = {},
            transactions = {},
            searchTerm = nil,
            preventAutoLoad = true
        })
        
        cb(true)
    end)
    
    -- Listen for search requests
    RegisterNUICallback('finances_search', function(data, cb)
        local searchTerm = data.searchTerm
        print('[p_dojmdt] Debug: Finances search requested:', searchTerm)
        searchPerformed = true
        
        -- Load finances with search term
        exports['p_dojmdt']:loadFinances(searchTerm)
        
        cb(true)
    end)
    
    -- Listen for "load all" requests (empty search)
    RegisterNUICallback('finances_load_all', function(data, cb)
        print('[p_dojmdt] Debug: Load all finances requested')
        searchPerformed = true
        
        -- Load all finances
        exports['p_dojmdt']:loadAllFinances()
        
        cb(true)
    end)
end

-- Initialize the override
CreateThread(function()
    Wait(1000) -- Wait for everything to load
    overrideFinancesLoading()
    print('[p_dojmdt] Debug: Finances override loaded - automatic loading disabled')
end)

-- Export function to check if search was performed
exports('wasFinancesSearchPerformed', function()
    return searchPerformed
end)

-- Export function to reset search state
exports('resetFinancesSearchState', function()
    searchPerformed = false
    financesTabClicked = false
end) 