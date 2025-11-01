if not GetResourceState('es_extended'):find('start') then return end
shared.framework = 'esx'
importCore('esx')

SetTimeout(0, function()
    function notify(message, type)
        lib.notify({
            description = message,
            type = type,
            position = 'top'
        })
    end
end)