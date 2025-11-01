

if config.EnableStress then
    dp('stress started')
    stress_data = {}

    function IsWhitelisted(source)
        local player = GetPlayer(source)
        if player then
            local jobName = shared.framework == 'esx' and player.job.name or player.PlayerData.job.name
            for _, v in pairs(config.StressWhitelistJobs) do
                if jobName == v then
                    return true
                end
            end
        end
        return false
    end

    RegisterServerEvent("dusa_hud:CheckStress")
    AddEventHandler("dusa_hud:CheckStress", function()
        local src = source
        Wait(1500)
        local citizenid = GetIdentifier(src)
        if not citizenid then
            print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(src))
            return
        end
        local data = db.query("hud_settings", {"stress"}, "citizenid", citizenid)
        if not data or not next(data) or not data[1] then
            local playlist, settings = {}, {}            
            db.insert("hud_settings", {'citizenid', 'stress', 'playlist', 'settings'}, {citizenid, 0, json.encode(playlist), json.encode(settings)})
            stress_data[citizenid] = 0
            TriggerClientEvent('hud:client:UpdateStress', src, stress_data[citizenid])
        else
            stress_data[citizenid] = data[1].stress or 0
            TriggerClientEvent('hud:client:UpdateStress', src, stress_data[citizenid])
        end
    end)

    RegisterServerEvent("esx:playerLogout")
    AddEventHandler("esx:playerLogout", function(source)
        local src = source
        local citizenid = GetIdentifier(src)
        if citizenid and stress_data[citizenid] then
            stress_data[citizenid] = math.floor(stress_data[citizenid])
            db.save('hud_settings', 'stress', 'citizenid', stress_data[citizenid], citizenid)
        end
    end)

    RegisterServerEvent("QBCore:Server:OnPlayerUnload")
    AddEventHandler("QBCore:Server:OnPlayerUnload", function(source)
        local src = source
        local citizenid = GetIdentifier(src)
        if citizenid and stress_data[citizenid] then
            stress_data[citizenid] = math.floor(stress_data[citizenid])
            db.save('hud_settings', 'stress', 'citizenid', stress_data[citizenid], citizenid)
        end
    end)

    AddEventHandler('playerDropped', function()
        local src = source
        local citizenid = GetIdentifier(src)
        if citizenid and stress_data[citizenid] then
            stress_data[citizenid] = math.floor(stress_data[citizenid])
            db.save('hud_settings', 'stress', 'citizenid', stress_data[citizenid], citizenid)
        end
    end)

    RegisterNetEvent('hud:server:GainStress', function(amount)
        local src = source
        local citizenid = GetIdentifier(src)
        if not citizenid then
            print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(src))
            return
        end
        local newStress
        if IsWhitelisted(src) then
            return
        end
        if stress_data[citizenid] == nil then
            stress_data[citizenid] = 0
        end
        newStress = tonumber(stress_data[citizenid]) + amount
        if newStress <= 0 then newStress = 0 end
    
        if newStress > 100 then
            newStress = 100
        end
        stress_data[citizenid] = newStress
        -- ExecuteSql("UPDATE `"..Config.StressMysqlTable.."` SET stress = '"..newStress.."' WHERE identifier = '"..identifier.."'")
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
        if newStress > 0 then
            notify(locale('stressing'), 'error')
        end
    end)
    
    RegisterNetEvent('hud:server:RelieveStress', function(amount)
        local src = source
        local citizenid = GetIdentifier(src)
        if not citizenid then
            print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(src))
            return
        end
    
        local newStress
            
        if stress_data[citizenid] == nil then
            stress_data[citizenid] = 0
        end
        newStress = tonumber(stress_data[citizenid]) - amount
        if newStress <= 0 then newStress = 0 end

        if newStress > 100 then
            newStress = 100
        end
        stress_data[citizenid] = newStress
        -- removed stress update from here
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
        if newStress > 0 then
            notify(locale('relieved_stress'), 'success')
        end
    end)
end