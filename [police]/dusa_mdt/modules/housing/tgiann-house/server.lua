local resourceName = 'tgiann-house'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2tgiann-house ^0detected, running')
    lib.callback.register("dusa_mdt:cachehouse", function(source)
        house.owned = db.fetch('tgiann_house')
        set:userList(house.owned, nil, nil, nil, source)

        return true
    end)
    
    lib.callback.register("dusa_mdt:gethouses", function(_)
        local promise = promise.new()
        citizenid = tostring(citizenid)
        local pv = {}
        if not house then house = {} end
    
        if type(house) == 'string' then
            house = json.decode(house)
        end
    
        for _, hous in pairs(house.owned) do
            local coords = vector3(0, 0, 0)
            local house_data = {
                img = "https://gta.com.ua/userfiles13/Franklins-Residence-From-GTAV-gta.com.ua1.jpg",
                name = "House #"..hous.identifier,
                address = "Los Santos",
                id = hous.identifier,
                citizen = hous.owner or 0,
                coords = coords,
            }
            table.insert(pv, house_data)
        end
        house.all = pv
        if promise then
            return promise:resolve(pv)
        end
    end)
end)
