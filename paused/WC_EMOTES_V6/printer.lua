print("WHITE CUSTOM, https://discord.gg/cUxnazUxqU loaded sucessfully.")

SetTimeout( 1000, function ()
    if GetResourceState('dpemotes') == 'started' then
        for i = 1, 10 do
            print("WC EMOTES: Warning! dpemotes is on the server, this WILL cause issues.")
        end
    end
end)
