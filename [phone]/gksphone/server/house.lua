RegisterNetEvent('gksphone:server:loafhouseTransfer', function(houseData, PhoneNumber)
    local src = source
    local phoneData = GetPhoneDataByNumber(PhoneNumber)
    if phoneData then
        Debugprint('loafHouse transfer', houseData, PhoneNumber)
        if phoneData.setup_owner ~= nil then
            TriggerClientEvent('gksphone:client:transferHouse', src, phoneData.source, houseData.id)
        else
            Debugprint('loafHouse transfer fail', houseData, PhoneNumber)
        end
    else
        Debugprint('loafHouse transfer fail', houseData, PhoneNumber)
    end
end)

CallBackRegisterServer('gksphone:server:getCizitinIDSource', function(source, cb, data)
    Debugprint("gksphone:server:getCizitinIDSource", data)
    local phoneData = GetPhoneDataByNumber(data)
    if phoneData then
        Debugprint('House transfer', data)
        if phoneData.setup_owner ~= nil then
            cb(phoneData.setup_owner, phoneData.source)
        else
            Debugprint('House transfer fail 2', data)
            cb(nil)
        end
    else
        Debugprint('House transfer fail 3', data)
        cb(nil)
    end
end)