SetTimeout(0, function()
    Wait(1000)
    lib.callback.register("dusa_hud:getMoney", function(source, type)
        -- Safety check for GetMoney function
        if not GetMoney then 
            print('[ERROR] dusa_hud: GetMoney function not available. Framework may not be loaded.')
            return 0
        end
        
        local amount = GetMoney(source, type)
        return amount or 0
    end)
end)