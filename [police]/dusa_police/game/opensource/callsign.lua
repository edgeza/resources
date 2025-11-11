if not rawget(_G, "lib") then include('ox_lib', 'init') end

local qbxCore = exports['qbx_core']

lib.addCommand('callsign', {
    help = 'Give yourself a callsign',
    params = {{
        name = 'callsign',
        type = 'number',
        help = 'Callsign number'
    }},
}, function(source, args)
    local callsign = args.callsign
    if not callsign then
        Framework.Notify(source, 'Usage: /callsign <number>', 'error')
        return
    end

    local player = qbxCore:GetPlayer(source)
    if not player then return end

    local job = player.PlayerData and player.PlayerData.job
    local jobName = job and job.name

    if not jobName or not Functions.IsLEO(jobName) then
        Framework.Notify(source, locale('not_leo'), 'error')
        return
    end

    player.Functions.SetMetaData('callsign', callsign)
    Framework.Notify(source, locale('gps.callsign_updated', callsign), 'success')
end)

