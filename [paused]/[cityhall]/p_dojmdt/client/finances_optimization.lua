-- Finances Optimization Client-Side Handler
-- This file provides optimized client-side handling for finances data loading

local financesCache = {}
local currentPage = 1
local pageSize = 20
local isLoading = false
local currentSearchTerm = ''

-- Function to load finances data with search
local function loadFinancesData(searchTerm, page, limit)
    if isLoading then
        print('[p_dojmdt] Debug: Finances data already loading, skipping request')
        return
    end
    
    isLoading = true
    currentSearchTerm = searchTerm or ''
    print('[p_dojmdt] Debug: Loading finances data for search:', searchTerm, 'page:', page, 'limit:', limit)
    
    -- Call the server callback with search parameters
    local financesData = lib.callback.await('p_dojmdt/server/finances/getFinances', false, searchTerm, page, limit)
    
    if not financesData then
        print('[p_dojmdt] Debug: No finances data received from server')
        isLoading = false
        return
    end
    
    financesCache = financesData
    currentPage = page or 1
    print('[p_dojmdt] Debug: Successfully loaded finances data')
    
    -- Send data to NUI
    SendNUIMessage({
        type = 'financesData',
        data = financesData,
        page = page or 1,
        searchTerm = searchTerm or '',
        hasMore = #financesData.accounts >= (limit or pageSize)
    })
    
    isLoading = false
end

-- Function to load transactions for a specific player
local function loadPlayerTransactions(citizenid)
    if isLoading then
        print('[p_dojmdt] Debug: Already loading data, skipping request')
        return
    end
    
    isLoading = true
    print('[p_dojmdt] Debug: Loading transactions for player:', citizenid)
    
    -- Call the server callback to get transactions for specific player
    local transactions = lib.callback.await('p_dojmdt/server/finances/getPlayerTransactions', false, citizenid)
    
    if not transactions then
        print('[p_dojmdt] Debug: No transactions received from server')
        isLoading = false
        return
    end
    
    print('[p_dojmdt] Debug: Successfully loaded', #transactions, 'transactions for player:', citizenid)
    
    -- Send transactions data to NUI
    SendNUIMessage({
        type = 'playerTransactions',
        data = transactions,
        citizenid = citizenid
    })
    
    isLoading = false
end

-- Function to search for players
local function searchPlayers(searchTerm)
    if not searchTerm or searchTerm == '' then
        -- If no search term, return empty
        SendNUIMessage({
            type = 'financesData',
            data = {accounts = {}, transactions = {}},
            page = 1,
            searchTerm = '',
            hasMore = false
        })
    else
        -- Search for specific players
        loadFinancesData(searchTerm, 1, pageSize)
    end
end

-- Function to clear finances cache
local function clearFinancesCache()
    financesCache = {}
    currentPage = 1
    currentSearchTerm = ''
    print('[p_dojmdt] Debug: Client finances cache cleared')
end

-- Function to load next page
local function loadNextPage()
    loadFinancesData(currentSearchTerm, currentPage + 1, pageSize)
end

-- Function to load previous page
local function loadPreviousPage()
    if currentPage > 1 then
        loadFinancesData(currentSearchTerm, currentPage - 1, pageSize)
    end
end

-- Function to refresh finances data
local function refreshFinancesData()
    clearFinancesCache()
    loadFinancesData(currentSearchTerm, 1, pageSize)
end

-- Export functions for use in other scripts
exports('loadFinancesData', loadFinancesData)
exports('loadPlayerTransactions', loadPlayerTransactions)
exports('searchPlayers', searchPlayers)
exports('clearFinancesCache', clearFinancesCache)
exports('loadNextPage', loadNextPage)
exports('loadPreviousPage', loadPreviousPage)
exports('refreshFinancesData', refreshFinancesData)

-- Register NUI callback for finances tab click (loads empty data - search only)
RegisterNUICallback('loadFinances', function(data, cb)
    print('[p_dojmdt] Debug: NUI requested finances data - returning empty (search only)')
    -- Send empty data to NUI - no automatic loading
    SendNUIMessage({
        type = 'financesData',
        data = {accounts = {}, transactions = {}},
        page = 1,
        searchTerm = '',
        hasMore = false
    })
    cb('ok')
end)

-- Register NUI callback for search
RegisterNUICallback('searchFinances', function(data, cb)
    local searchTerm = data.searchTerm or ''
    print('[p_dojmdt] Debug: NUI requested finances search for:', searchTerm)
    searchPlayers(searchTerm)
    cb('ok')
end)

-- Register NUI callback for pagination
RegisterNUICallback('loadFinancesPage', function(data, cb)
    local page = data.page or 1
    local limit = data.limit or pageSize
    local searchTerm = data.searchTerm or currentSearchTerm
    print('[p_dojmdt] Debug: NUI requested finances page:', page, 'search:', searchTerm)
    loadFinancesData(searchTerm, page, limit)
    cb('ok')
end)

-- Register NUI callback for player transactions
RegisterNUICallback('loadPlayerTransactions', function(data, cb)
    local citizenid = data.citizenid
    print('[p_dojmdt] Debug: NUI requested transactions for player:', citizenid)
    loadPlayerTransactions(citizenid)
    cb('ok')
end)

-- Register NUI callback for refresh
RegisterNUICallback('refreshFinances', function(data, cb)
    print('[p_dojmdt] Debug: NUI requested finances refresh')
    refreshFinancesData()
    cb('ok')
end)

-- Register NUI callback for cache clear
RegisterNUICallback('clearFinancesCache', function(data, cb)
    print('[p_dojmdt] Debug: NUI requested cache clear')
    clearFinancesCache()
    cb('ok')
end)

print('[p_dojmdt] Debug: Finances optimization client-side handler loaded')

-- Test function to verify callback registration
local function testCallback()
    print('[p_dojmdt] Debug: Testing callback registration')
    local result = lib.callback.await('p_dojmdt/server/finances/test', false)
    if result then
        print('[p_dojmdt] Debug: Test callback successful:', json.encode(result))
    else
        print('[p_dojmdt] Debug: Test callback failed')
    end
end

-- Export test function
exports('testCallback', testCallback) 