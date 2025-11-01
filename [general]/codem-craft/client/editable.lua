RegisterNetEvent('codem-craft:openmenu')
AddEventHandler('codem-craft:openmenu', function(k)
    while not response do
        Citizen.Wait(0)
    end
    openCraftMenu(k)
end)

RegisterNetEvent('codem-craft:closemenu')
AddEventHandler('codem-craft:closemenu', function()
    closeCraftMenu()
end)

OpenTrigger = function()
    if Config.InteractionHandler == "qb-target" then
       Citizen.CreateThread(function()
            while true do
                local wait = 1500
                if frameworkObject then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k,v in pairs(Config.CraftNpc) do
                        local dist = #(coords - v.ped["position"])
                        if dist < 5.5 and not v.TargetEnabled then
                            wait = 0
                            exports['qb-target']:AddBoxZone("craft"..k, vector3(v.ped["position"].x, v.ped["position"].y, v.ped["position"].z), 1.5, 1.5, {
                                name="market"..k,
                                heading=0,
                                minZ=v.ped["position"].z,
                                maxZ=v.ped["position"].z+1.5,
                                }, {
                                options = {
                                    {
                                    type = "client",
                                    action = function()
                                        openCraftMenu(k)
                                    end,
                                    icon = "fas fa-hammer",
                                    label = "Craft",
                                    },
                                },
                                job = {"all"},
                                distance = 1.5
                            })
        
                            v.TargetEnabled = true
                        end
                    end
                end
                Citizen.Wait(wait)
            end
       end)
    elseif Config.InteractionHandler == "ox_target" then
        Citizen.CreateThread(function()
            while true do
                local wait = 1500
                if frameworkObject then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k,v in pairs(Config.CraftNpc) do
                        local dist = #(coords - v.ped["position"])
                        if dist < 5.5 and not v.TargetEnabled then
                            wait = 0
                            local parameters = {
                                name = 'craft'..k,
                                coords = vector3(v.ped["position"].x, v.ped["position"].y, v.ped["position"].z + 0.98),
                                options = {
                                    {
                                    onSelect = function()
                                        openCraftMenu(k)
                                    end,
                                    icon = "fas fa-hammer",
                                    label = "Craft",
                                    },
                                }
                    
                            }
                            exports.ox_target:addBoxZone(parameters)
                            
                            v.TargetEnabled = true
                        end
                    end
                end
                Citizen.Wait(wait)
            end
        
        end)
 
    elseif Config.InteractionHandler == "drawtext" then
        Citizen.CreateThread(function()
            while true do
                local wait = 1500
                if frameworkObject then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k,v in pairs(Config.CraftNpc) do
                        local dist = #(coords - v.ped["position"])
                        if dist < 2.5 then
                            wait = 0
                            if Config.Draw.enabled  then
                                DrawText3D(v.ped["position"].x, v.ped["position"].y, v.ped["position"].z +1.98,Config.Draw.textmarket)
                            end
                            if IsControlJustReleased(0, 38) then
                                openCraftMenu(k)
                            end
                        end
                    end
                end
                Citizen.Wait(wait)
            end
       end)
    end
end

function openCraftMenu(k)
    while not response do
        Citizen.Wait(0)
    end

    local allowed = false

    if Config.CraftNpc[k].job == "public" and Config.CraftNpc[k].gang == "none" then
        allowed = true
    elseif Config.CraftNpc[k].job == "public" and Config.CraftNpc[k].gang == GetGang() then
        allowed = true
    elseif Config.CraftNpc[k].job == GetJob() and Config.CraftNpc[k].gang == "none" then
        allowed = true
    elseif Config.CraftNpc[k].job == GetJob() and Config.CraftNpc[k].gang == GetGang() then
        allowed = true
    else
        Config.ClientNotification(Config.NotificationText["NOT_ALLOWED"].text, Config.NotificationText["NOT_ALLOWED"].type, Config.NotificationText["NOT_ALLOWED"].timeout)
    end

    if allowed then

        SendNUIMessage({
            action = 'CRAFTITEMS',
            value = Config.CraftNpc[k].craftitems,
        })

        local inserData = Callback('codem-craft:insertData')

        if inserData then
            local playerlevel = Callback('codem-craft:GetLevel')
            local playername  = Callback('codem-craft:GetName')
            local playerxp    = Callback('codem-craft:GetXp')
            local item  = Callback("codem-craft:GetItems")

            TriggerServerEvent('codem-craft:firstData')
            SetNuiFocus(true,true)
            craftOpened = true

            SendNUIMessage({
                action = "OPEN_MENU",
                value = playerlevel,
                playername = playername,
                playerxp = playerxp,
                items = item,
            })
        end
        
    end
end

RegisterNetEvent('codem-craft:setItems')
AddEventHandler('codem-craft:setItems', function()
    items = Callback("codem-craft:GetItems")
    SendNUIMessage({
        action = 'SET_ITEMS',
        value = items,
    })
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end