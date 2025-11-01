local sharedConfig = require 'config.shared'

function NewMetaDataLicense(src, itemName)
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end
    
    local hasItem = exports['qs-inventory']:HasItem(src, itemName, 1)
    if not hasItem then return end
    
    local mugShot = lib.callback.await('um-idcard:client:callBack:getMugShot', src)
    if mugShot then
        exports['qs-inventory']:SetItemMetadata(src, itemName, {mugShot = mugShot})
    end
end

RegisterNetEvent('um-idcard:server:sendData', function(src, item, metadata)
    if metadata.mugShot then
        local source = src

        lib.callback('um-idcard:client:callBack:getClosestPlayer', src, function(player)
            if player ~= 0 then
                TriggerClientEvent('um-idcard:client:notifyOx', src, {
                    title = 'You showed your idcard',
                    desc = 'You are showing your ID Card to the closest player',
                    icon = 'id-card',
                    iconColor = 'green'
                })

                src = player
            end

            local data = exports.qbx_core:GetPlayer(source).PlayerData.charinfo
            data.sex = data.gender == 0 and 'Male' or 'Female' -- Resolve gender being int
            data.cardtype = item or "id_card" -- Define card type default if not found
            data.mugShot = metadata.mugShot -- Append mugshot to data obj

            TriggerClientEvent('um-idcard:client:sendData', src, data)
        end)

        TriggerClientEvent('um-idcard:client:startAnim', src, item)
    else
        NewMetaDataLicense(src, item)
    end
end)

for k,_ in pairs(sharedConfig.licenses) do
    CreateRegisterItem(k)
end