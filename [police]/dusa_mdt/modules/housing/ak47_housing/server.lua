local resourceName = 'ak47_qb_housing'

if not GetResourceState(resourceName):find('start') then
    resourceName = 'ak47_housing'
    if not GetResourceState(resourceName):find('start') then
        return
    end
end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2ak47_housing ^0detected, running')
    lib.callback.register("dusa_mdt:cachehouse", function(source)
        house.owned = db.fetch(resourceName)
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

        for _, phous in pairs(house.owned) do
            if type(phous.position) == 'string' then phous.position = json.decode(phous.position) end
            local house_data = {
                img = "https://gta.com.ua/userfiles13/Franklins-Residence-From-GTAV-gta.com.ua1.jpg",
                name = "House #".. phous.id,
                address = "Citizen house",
                id = phous.id,
                citizen = phous.owner or 0,
                coords = json.encode({enter = json.decode(phous.enter)}) or vector3(0, 0, 0)
            }
            table.insert(pv, house_data)
        end

        house.all = pv

        if promise then
            return promise:resolve(pv)
        end
    end)
end)