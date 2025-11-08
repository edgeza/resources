local resourceName = 'gksphone'

if not GetResourceState(resourceName):find('start') then return end
phone = {}
SetTimeout(0, function()
    function phone:getPhoneNumber(identifier)
        local phone_data = db.query('gksphone_settings', 'identifier', citizenid)
        phone_data = phone_data[1]
        if not phone_data then return end
        return phone_data.phone_number
    end
end)