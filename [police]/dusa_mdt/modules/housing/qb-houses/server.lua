local resourceName = 'qb-houses'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2qb-houses ^0detected, running')
    lib.callback.register("dusa_mdt:cachehouse", function(source)
        house.owned = db.fetch('player_houses')
        house.locations = db.fetch('houselocations')

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

        for _, hous in pairs(house.locations) do
            for _, phous in pairs(house.owned) do
                if phous.house == hous.name then
                    if type(hous.coords) == 'string' then hous.coords = json.decode(hous.coords) end
                    local coords = vector3(hous.coords.enter.x, hous.coords.enter.y, hous.coords.enter.z)
                    local house_data = {
                        img = "https://gta.com.ua/userfiles13/Franklins-Residence-From-GTAV-gta.com.ua1.jpg",
                        name = "House ".. hous.label,
                        address = hous.label,
                        id = hous.name,
                        citizen = phous.citizenid or 0,
                        coords = hous.coords,
                    }
                    table.insert(pv, house_data)
                end
            end
        end

        house.all = pv

        if promise then
            return promise:resolve(pv)
        end
    end)
end)