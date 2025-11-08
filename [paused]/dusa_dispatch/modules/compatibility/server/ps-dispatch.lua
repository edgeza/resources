RegisterNetEvent("ps-dispatch:server:notify", function(dispatch)
    local src = source
    local playerPed = GetPlayerPed(src)

    dispatch.coords = dispatch.coords or GetEntityCoords(playerPed)
    dispatch.recipientJobs = dispatch.recipientJobs or dispatch.jobs
    
    dispatch.recipientJobs = type(dispatch.recipientJobs) == 'string' and { dispatch.recipientJobs } or dispatch.recipientJobs

    Dispatch.SendDispatch(dispatch)
end)