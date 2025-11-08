local resourceName = 'qs-smartphone'

if not GetResourceState(resourceName):find('start') then return end
phone = {}
SetTimeout(0, function()
    function phone:getPhoneNumber(citizenid)
        local player = db.query(core.players, core.citizenid, citizenid)
        player = player[1]
        local phone
        if shared.framework == 'qb' then
            if type(player.charinfo) == 'string' then 
                player.charinfo = json.decode(player.charinfo) 
            end
            phone = player.charinfo.phone
        elseif shared.framework == 'esx' then
            phone = player.phone_number
        end
        if not phone then error('Phone number problem | [Framework]'..shared.framework..'[CitizenID]'..citizenid) end
        return phone
    end
end)