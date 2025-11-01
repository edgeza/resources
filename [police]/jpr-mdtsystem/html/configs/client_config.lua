function SendNotification(text, type)
    QBCore.Functions.Notify(text, type)
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    --local factor = (string.len(text)) / 370
    --DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function CreateTargetZone(zoneName, coords, options)
    if coords then
        if Config.TargetScript == "ox-target" or Config.TargetScript == "ox_target" then
            Citizen.Wait(1)

            parameters = {
                coords = coords,
                size = vector3(5.5, 4, 2),
                name = zoneName,
                rotation = -72,
                options = options,
                distance = 1.5
            }
            
            exports.ox_target:addBoxZone(parameters)
        else
            Citizen.Wait(1)
            
            exports[Config.TargetScript]:AddBoxZone(zoneName, coords, 5.5, 4, {
                name = zoneName,
                heading = -72,
                debugPoly = false,
                minZ = coords.z - 2,
                maxZ = coords.z + 2,
            }, {
                options = options,
                distance = 1.5
            })
        end
    end
end

RegisterNetEvent("jpr-mdtsystem:client:openFinesMenu", function()
    QBCore.Functions.TriggerCallback('jpr-mdtsystem:server:getAllMyFines', function(finesData)
        local qbmenuExtra = {}

        for k,v in pairs(finesData) do
            qbmenuExtra[#qbmenuExtra + 1] = {
                header = v.fineName.." - "..v.fineValue..Config.Currency,
                params = {
                    event = "jpr-mdtsystem:client:payBill",
                    args = v
                }
            }
        end

        qbmenuExtra[#qbmenuExtra + 1] = {
            header = Config.Locales["26"],
            params = {
                event = nil,
                args = nil
            }
        }

        exports[Config.MenuScript]:openMenu(qbmenuExtra)
    end)
end)