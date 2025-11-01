-- Finances Search Handler
-- This script handles the search functionality for finances

-- Register NUI callback for search
RegisterNUICallback('finances/search', function(data, cb)
    local searchTerm = data.searchTerm or ''
    print('[p_dojmdt] Debug: Finances search requested:', searchTerm)
    
    lib.callback('p_dojmdt/server/finances/searchFinances', false, function(financesData)
        if financesData then
            print('[p_dojmdt] Debug: Search returned', #financesData.accounts, 'accounts')
            
            -- Send search results to NUI
            SendNUIMessage({
                type = 'finances_search_results',
                accounts = financesData.accounts,
                transactions = financesData.transactions,
                searchTerm = searchTerm
            })
        else
            print('[p_dojmdt] Debug: No search results')
        end
    end, searchTerm)
    
    cb(true)
end)

-- Register NUI callback for loading all finances
RegisterNUICallback('finances/loadAll', function(data, cb)
    print('[p_dojmdt] Debug: Load all finances requested')
    
    lib.callback('p_dojmdt/server/finances/searchFinances', false, function(financesData)
        if financesData then
            print('[p_dojmdt] Debug: Load all returned', #financesData.accounts, 'accounts')
            
            -- Send all data to NUI
            SendNUIMessage({
                type = 'finances_all_data',
                accounts = financesData.accounts,
                transactions = financesData.transactions
            })
        else
            print('[p_dojmdt] Debug: No data returned')
        end
    end, '') -- Empty string to load all
    
    cb(true)
end)

-- Register command to search finances
RegisterCommand('searchfinances', function(source, args)
    local searchTerm = table.concat(args, ' ')
    print('[p_dojmdt] Debug: Search finances command triggered:', searchTerm)
    
    lib.callback('p_dojmdt/server/finances/searchFinances', false, function(financesData)
        if financesData then
            print('[p_dojmdt] Debug: Command search returned', #financesData.accounts, 'accounts')
            -- You can add notification here if needed
        end
    end, searchTerm)
end, false)

-- Register command to load all finances
RegisterCommand('loadallfinances', function()
    print('[p_dojmdt] Debug: Load all finances command triggered')
    
    lib.callback('p_dojmdt/server/finances/searchFinances', false, function(financesData)
        if financesData then
            print('[p_dojmdt] Debug: Command load all returned', #financesData.accounts, 'accounts')
            -- You can add notification here if needed
        end
    end, '')
end, false)

print('[p_dojmdt] Debug: Finances search handler loaded')
print('[p_dojmdt] Debug: Use /searchfinances [name] to search or /loadallfinances to load all') 