-- Test script for locker separation
-- This will help us debug why lockers aren't separating properly

local function TestLockerSeparation()
    print('^2[DOJ Job]^7 Testing locker separation...')
    
    -- Test regular lockers
    print('^3[DOJ Job]^7 Regular Lockers:')
    for lockerId, lockerData in pairs(Config.Lockers) do
        print('  - ' .. lockerId .. ' at ' .. tostring(lockerData.coords))
        print('    Locker ID: ' .. lockerId .. '_Locker')
        print('    Private: ' .. tostring(lockerData.private))
    end
    
    -- Test document lockers
    print('^3[DOJ Job]^7 Document Lockers:')
    for lockerId, lockerData in pairs(Config.DocumentLockers) do
        print('  - ' .. lockerId .. ' at ' .. tostring(lockerData.coords))
        print('    Document Locker ID: ' .. lockerId .. '_Document_Locker')
    end
    
    print('^2[DOJ Job]^7 Test completed. Check the coordinates above.')
end

-- Register command to test lockers
RegisterCommand('testlockers', function()
    TestLockerSeparation()
end, false)

print('^2[DOJ Job]^7 Locker test script loaded. Use /testlockers to run tests.') 