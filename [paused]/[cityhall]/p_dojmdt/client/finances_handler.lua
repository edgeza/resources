-- Finances Handler - Search-based loading
-- This replaces the automatic loading with search-based loading

local financesLoaded = false
local currentSearchTerm = ""

-- Function to load finances data with search term
local function loadFinances(searchTerm)
    if not searchTerm or searchTerm == '' then
        searchTerm = nil -- Send nil for empty search to load all
    end
    
    print('[p_dojmdt] Debug: Loading finances with search term:', searchTerm)
    
    lib.callback('p_dojmdt/server/finances/searchFinances', false, function(financesData)
        if financesData then
            print('[p_dojmdt] Debug: Received finances data:', #financesData.accounts, 'accounts,', #financesData.transactions, 'transactions')
            
            -- Send data to NUI
            SendNUIMessage({
                type = 'finances_data',
                accounts = financesData.accounts,
                transactions = financesData.transactions,
                searchTerm = searchTerm
            })
            
            financesLoaded = true
            currentSearchTerm = searchTerm or ""
        else
            print('[p_dojmdt] Debug: No finances data received')
        end
    end, searchTerm)
end

-- Function to handle search input
local function handleFinancesSearch(searchTerm)
    print('[p_dojmdt] Debug: Handling finances search:', searchTerm)
    loadFinances(searchTerm)
end

-- Function to load all finances (when search is empty)
local function loadAllFinances()
    print('[p_dojmdt] Debug: Loading all finances')
    loadFinances(nil) -- Send nil to load all
end

-- Register NUI callbacks for finances
RegisterNUICallback('loadFinances', function(data, cb)
    local searchTerm = data.searchTerm
    handleFinancesSearch(searchTerm)
    cb(true)
end)

RegisterNUICallback('searchFinances', function(data, cb)
    local searchTerm = data.searchTerm
    handleFinancesSearch(searchTerm)
    cb(true)
end)

RegisterNUICallback('loadAllFinances', function(data, cb)
    loadAllFinances()
    cb(true)
end)

-- Export functions for external use
exports('loadFinances', loadFinances)
exports('searchFinances', handleFinancesSearch)
exports('loadAllFinances', loadAllFinances)

-- Register command to load all finances
RegisterCommand('loadfinances', function()
    print('[p_dojmdt] Debug: Load finances command triggered')
    loadAllFinances()
end, false)

-- Register command to search finances
RegisterCommand('searchfinances', function(source, args)
    local searchTerm = table.concat(args, ' ')
    print('[p_dojmdt] Debug: Search finances command triggered with term:', searchTerm)
    handleFinancesSearch(searchTerm)
end, false)

print('[p_dojmdt] Debug: Finances handler loaded - search-based loading enabled')
print('[p_dojmdt] Debug: Use /loadfinances to load all data or /searchfinances [name] to search') 