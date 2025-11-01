local ResourceNotify = GetNotify()
function Notify(message, type)
    if ResourceNotify == 'ox_lib' then
        local data = {
            title = Config.Blip.BlipName,
            description = message,
            type = type or "success"
        }
        lib.notify(data)
    elseif ResourceNotify == 'esx_notify' then
        exports['esx_notify']:Notify(type, message,  1500, Config.Blip.BlipName) 
    elseif ResourceNotify == 'okokNotify' then
        exports['okokNotify']:Alert('Notify', message, 6000, 'type', true)
    elseif ResourceNotify == 'lation_ui' then
        exports.lation_ui:notify({
            title = Config.Blip.BlipName,
            message = message,
            type = type,
        })
    elseif ResourceNotify == 'wasabi_notify' then
        exports.wasabi_notify:notify(Config.Jobname, message, 6000, type, false, 'fas fa-ghost')
    elseif ResourceNotify == 'brutal_notify' then
        exports['brutal_notify']:SendAlert('Notify', message, 6000, type, false)
    elseif ResourceNotify == 'mythic_notify' then
        exports['mythic_notify']:SendAlert(type, message)
    end
end

RegisterNetEvent("pl_uwucafe:client:notify", function(message, type)
  Notify(message, type)
end)