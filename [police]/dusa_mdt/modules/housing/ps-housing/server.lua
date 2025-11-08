local resourceName = 'ps-housing'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2ps-housing ^0detected, running')
    lib.callback.register("dusa_mdt:cachehouse", function(source, properties)
        house.properties = properties

        set:userList(house.properties, nil, nil, nil, source)

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
    
        for _, hous in pairs(house.properties) do
            local coords = vector3(hous.propertyData.door_data.x, hous.propertyData.door_data.y, hous.propertyData.door_data.z)
            local house_data = {
                img = "https://gta.com.ua/userfiles13/Franklins-Residence-From-GTAV-gta.com.ua1.jpg",
                name = "House",
                address = hous.propertyData.street,
                id = hous.property_id,
                citizen = hous.propertyData.owner or 0,
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
