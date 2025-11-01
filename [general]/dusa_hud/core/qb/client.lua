if not GetResourceState('qb-core'):find('start') then return end
shared.framework = 'qb'
importCore('qb')

SetTimeout(0, function()
    function notify(message, type)
        lib.notify({
            description = message,
            type = type,
            position = 'top'
        })
    end
end)