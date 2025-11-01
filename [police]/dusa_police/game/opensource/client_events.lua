---comment
---
---

-- Do not touch these values
RadarList = require 'game.data.radar'

---@param type string Type of the dispatch (speed)
AddEventHandler('police:client:sendDispatch', function(type)
    if type == 'speed' then
        if GetResourceState('dusa_dispatch'):find('start') then
            exports.dusa_dispatch:SpeedingVehicle()
        elseif GetResourceState('ps-dispatch'):find('start') then
            exports['ps-dispatch']:SpeedingVehicle()
        elseif GetResourceState('qs-dispatch'):find('start') then
            exports['qs-dispatch']:SpeedingVehicle()
        elseif GetResourceState('rcore_dispatch'):find('start') then
            exports['rcore_dispatch']:SpeedingVehicle()
        else
            -- custom dispatch goes here
        end
    end
end)

---@param id number Player Id
---@param type string Type of the penalty
---@param amount number Amount of the bill
---@param users table Table of selected users
AddEventHandler('police:client:issueBill', function(target, amount, reason, event)
    TriggerServerEvent('police:server:issueBill', target, amount, reason, event)
end)

RegisterNetEvent('police:client:openMdt')
AddEventHandler('police:client:openMdt', function()
    if GetResourceState('dusa_mdt'):find('start') then
        TriggerEvent('dusa_mdt:open')
    elseif GetResourceState('ps-mdt'):find('start') then
        TriggerServerEvent('mdt:server:openMDT')
        TriggerServerEvent('mdt:requestOfficerData')
    elseif GetResourceState('lb-tablet'):find('start') then
        exports["lb-tablet"]:ToggleOpen(true)
    elseif GetResourceState('redutzu-mdt'):find('start') then
        TriggerEvent('redutzu-mdt:client:openMDT')
    elseif GetResourceState('tk_mdt'):find('start') then
        exports.tk_mdt:openUI('police')
    elseif GetResourceState('drx_mdt'):find('start') then
        exports.drx_mdt:OpenMDT()
    else
        -- your mdt goes here
        print(
        '^3[POLICE SETUP] ^5 Your MDT system is not integrated are not available. Please integrate to dusa_police/game/opensource/events.lua Line:75 ^0')
    end
end)

-- Blips


--- OPTIONAL OFFICER DOWN DISPATCH ---
local timer = {}
local function WaitTimer(name, action, ...)
    if not timer[name] then
        timer[name] = true
        action(...)
        Wait(3 * 1000)
        timer[name] = false
    end
end
if Config.SendDispatchWhenOfficerDead then
    AddEventHandler('gameEventTriggered', function(name, args)
        if name ~= 'CEventNetworkEntityDamage' then return end
        local victim = args[1]
        local isDead = args[6] == 1
        WaitTimer('PlayerDowned', function()
            if not victim or victim ~= cache.ped then return end
            if not isDead then return end

            local isLeo = Functions.IsLEO(Framework.Player.Job.Name)

            if isLeo then
                if GetResourceState('dusa_dispatch'):find('start') then
                    -- exports['dusa_dispatch']:OfficerDown() -- Already inside dispatch system, not needed
                elseif GetResourceState('qs-dispatch'):find('start') then
                    exports['qs-dispatch']:OfficerDown()
                elseif GetResourceState('ps-dispatch'):find('start') then
                    -- exports['ps-dispatch']:OfficerDown() -- Already inside dispatch system, not needed
                elseif GetResourceState('rcore_dispatch'):find('start') then
                    local data = {
                        code = '10-99',                          -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
                        default_priority = 'high',               -- 'low' | 'medium' | 'high' -> The alert priority
                        coords = GetEntityCoords(PlayerPedId()), -- vector3 -> The coords of the alert
                        job = { 'police' },                      -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
                        text = 'Officer Down!',                  -- string -> The alert text
                        type = 'alerts',                         -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
                        blip_time = 5,                           -- number (optional) -> The time until the blip fades
                        blip = {                                 -- Blip table (optional)
                            sprite = 54,                         -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
                            colour = 3,                          -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                            scale = 0.7,                         -- number -> The blip scale
                            text = 'Officer Down',               -- number (optional) -> The blip text
                            flashes = true,                      -- boolean (optional) -> Make the blip flash
                            radius = 0,                          -- number (optional) -> Create a radius blip instead of a normal one
                        }
                    }
                    TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
                elseif GetResourceState('tk_dispatch'):find('start') then
                    exports.tk_dispatch:addCall({
                        title = 'Officer Down',
                        code = '10-99',
                        priority = 'Priority 3',
                        coords = GetEntityCoords(PlayerPedId()),
                        showLocation = true,
                        showGender = true,
                        playSound = true,
                        blip = {
                            color = 3,
                            sprite = 357,
                            scale = 1.0,
                        },
                        jobs = { 'police' }
                    })
                elseif GetResourceState('codem-dispatch'):find('start') then
                    local Text = 'An officer is wounded!'
                    local Type = 'OfficerDown'

                    local Data = {
                        type = Type,
                        header = 'Officer Down',
                        text = Text,
                        code = '10-99',
                    }
                    exports['codem-dispatch']:CustomDispatch(Data)
                end
            end
        end)
    end)
end
