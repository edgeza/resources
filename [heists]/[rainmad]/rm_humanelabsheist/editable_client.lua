function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('humanelabsheist:client:showNotification', function(str)
    ShowNotification(str)
end)

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

function DrawBusySpinner(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

policeAlert = function(coords)
    if Config['HumaneLabs']["dispatch"] == "default" then
        TriggerServerEvent('humanelabsheist:server:policeAlert', coords)
    elseif Config['HumaneLabs']["dispatch"] == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config["HumaneLabs"]['dispatchJobs'], 
            coords = coords,
            title = 'Humanelab Robbery',
            message = 'A '..data.sex..' robbing a Humanelab at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - Humanelab Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif Config['HumaneLabs']["dispatch"] == "qs-dispatch" then
        exports['qs-dispatch']:HumaneRobery()
    elseif Config['HumaneLabs']["dispatch"] == "ps-dispatch" then
        exports['ps-dispatch']:HumaneRobery()
    elseif Config['HumaneLabs']["dispatch"] == "rcore_dispatch" then
        local data = {
            code = '10-64', -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
            default_priority = 'high', -- 'low' | 'medium' | 'high' -> The alert priority
            coords = coords, -- vector3 -> The coords of the alert
            job = Config["HumaneLabs"]['dispatchJobs'], -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
            text = 'Humanelab Robbery', -- string -> The alert text
            type = 'alerts', -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
            blip_time = 5, -- number (optional) -> The time until the blip fades
            blip = { -- Blip table (optional)
                sprite = 431, -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
                colour = 3, -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                scale = 1.2, -- number -> The blip scale
                text = 'Humanelab Robbery', -- number (optional) -> The blip text
                flashes = false, -- boolean (optional) -> Make the blip flash
                radius = 0, -- number (optional) -> Create a radius blip instead of a normal one
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
    elseif Config['HumaneLabs']["dispatch"] == "sonoran_cad" then
        local pos = GetEntityCoords(PlayerPedId())
        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        local streetLabel = street1
        if street2 ~= nil then
            streetLabel = streetLabel .. ' ' .. street2
        end
        TriggerServerEvent('SonoranScripts::Call911', 'Bystander', streetLabel, 'A silent alarm has been triggered at ' .. streetLabel .. '.', exports['nearest-postal']:getPostal(), nil)
    end
end