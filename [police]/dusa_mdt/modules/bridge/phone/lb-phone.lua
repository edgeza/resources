local resourceName = 'lb-phone'

if not GetResourceState(resourceName):find('start') then return end
phone = {}
SetTimeout(0, function()
    function phone:getPhoneNumber(citizenid)
        local phone_data = db.query('phone_phones', 'owner_id', citizenid)
        phone_data = phone_data[1]
        if not phone_data then return end
        return phone_data.phone_number
    end
end)