function CoreAwait()
    if shared.framework == 'qb' then
        while QBCore == nil do
            Wait(0)
        end
    elseif shared.framework == 'esx' then
        while ESX == nil do
            dp('Core not loaded yet, waiting..')
            Wait(0)
        end
    end
end