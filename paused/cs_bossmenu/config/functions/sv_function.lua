Config = Config or {}

if Config.ServerType == "QB" then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.ServerType == "ESX" then 
    ESX = exports['es_extended']:getSharedObject()
end


function GetPlayer(source)
    if Config.ServerType == 'QB' then
        return QBCore.Functions.GetPlayer(source)
    elseif Config.ServerType == 'ESX' then
        return ESX.GetPlayerFromId(source)
    end
end

function GetIdentifier(Player)
    return Config.ServerType == 'QB' and Player.PlayerData.citizenid or Player.identifier
end

function GetPlayerFromIdentifier(identifier)
    if Config.ServerType == 'QB' then
        return QBCore.Functions.GetPlayerByCitizenId(identifier) or QBCore.Player.GetOfflinePlayer(identifier)
    elseif Config.ServerType == 'ESX' then
        return ESX.GetPlayerFromIdentifier(identifier)
    end
end

function GetPlayerJob(source)
    local Player = GetPlayer(source)
    if not Player then return end
    
    if Config.ServerType == 'QB' then
        return Player.PlayerData.job.name, Player.PlayerData.job.label, Player.PlayerData.job.grade.level
    elseif Config.ServerType == 'ESX' then
        return Player.job.name, Player.job.label, Player.job.grade
    end
end

function GetPlayerGang(source)  -- ONLY QB-Core
    if Config.ServerType ~= 'QB' then return end
    local Player = GetPlayer(source)
    if not Player then return end
    
    return Player.PlayerData.gang.name, Player.PlayerData.gang.label, Player.PlayerData.gang.grade.level
end

function GetPlayerName(Player)
    return Config.ServerType == 'QB' and 
           (Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname) or 
           Player.getName()
end

function SetPlayerJob(Player, job, rank)
    if Config.ServerType == 'QB' then
        Player.Functions.SetJob(tostring(job), tonumber(rank))
        Player.Functions.Save()
    elseif Config.ServerType == 'ESX' then
        Player.setJob(tostring(job), tonumber(rank))
    end
end

function AddPlayerMoney(Player, amount)
    if Config.ServerType == 'QB' then
        Player.Functions.AddMoney("cash", amount)
    elseif Config.ServerType == 'ESX' then
        Player.addAccountMoney('money', amount)
    end
end

function RemovePlayerMoney(Player, amount)
    if Config.ServerType == 'QB' then
        if Player.Functions.RemoveMoney("cash", amount) then
            return true
        end
        return false
    elseif Config.ServerType == 'ESX' then
        if amount <= Player.getAccount('money').money then
            Player.removeAccountMoney('money', amount)
            return true
        end
        return false
    end
end


-- This triggers when you fire an employee. Put your Multijob Events here to remove them from the multijob -- 

function FirePlayer(identifier, job, online)
    --[identifier = Player Identifier, job = Player Job, online = PLayer Online/Offline Status]--
    TriggerEvent('cs:multijob:removeJob', identifier, job)  -- This is CodeStudio Multijob [https://codestudio.tebex.io/package/5380051]
end


local function getQBOnlineEmployees(jobname)
    local employees = {}

    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == jobname then
            if v.PlayerData.charinfo and v.PlayerData.charinfo.firstname and v.PlayerData.charinfo.lastname then
                local firstname = v.PlayerData.charinfo.firstname or "Unknown"
                local lastname = v.PlayerData.charinfo.lastname or ""
            
                employees[#employees + 1] = {
                    empSource = v.PlayerData.citizenid,
                    grade = v.PlayerData.job.grade,
                    online = true,
                    name = firstname .. ' ' .. lastname
                }
            end
        end
    end

	local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
	if players[1] ~= nil then
		for _, value in pairs(players) do
			local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)
            if not isOnline and json.decode(value.job).name == jobname then
                employees[#employees+1] = {
                    empSource = value.citizenid,
                    grade = json.decode(value.job).grade,
                    online = false,
                    name = json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
                }
            end
		end
		table.sort(employees, function(a, b)
			return a.grade.level > b.grade.level
		end)
	end

    return employees
end

local function getESXOnlineEmployees(jobname)
    local employees = {}

    for _, player in pairs(ESX.GetExtendedPlayers()) do
        if player.job.name == jobname then
            employees[#employees + 1] = {
                empSource = player.identifier,
                grade = {level = player.job.grade, name = ESXJobs[jobname].grades[player.job.grade].name},
                online = true,
                name = GetPlayerName(player)
            }
        end
    end

	local players = MySQL.query.await('SELECT * FROM users WHERE job = ?', { jobname })
    if players[1] ~= nil then
        for _, value in pairs(players) do
            local isOnline = ESX.GetPlayerFromIdentifier(value.identifier)
            if not isOnline then
                employees[#employees + 1] = {
                    empSource = value.identifier,
                    grade = {level = value.job_grade, name = ESXJobs[jobname].grades[value.job_grade].name},
                    online = false,
                    name = value.firstname .. ' ' .. value.lastname
                }
            end
        end
        table.sort(employees, function(a, b)
            return a.grade.level < b.grade.level
        end)
    end

    return employees
end

lib.callback.register('cs:bossmenu:server:GetEmployees', function(_, jobname)
    local employees = {}
    local jobData

    if Config.ServerType == 'QB' then
		jobData = QBCore.Shared.Jobs
        employees = getQBOnlineEmployees(jobname)
    elseif Config.ServerType == 'ESX' then
		jobData = ESXJobs
        employees = getESXOnlineEmployees(jobname)
    end

    return employees, jobData
end)

lib.callback.register('cs:bossmenu:server:GetGangEmployees', function(_, gangname)
	local employees = {}

    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.gang.name == gangname then
            employees[#employees + 1] = {
                empSource = v.PlayerData.citizenid,
                grade = v.PlayerData.gang.grade,
                online = true,
                name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname
            }
        end
    end

    if Config.ServerType == 'QB' then
        local players = MySQL.query.await("SELECT * FROM `players` WHERE `gang` LIKE '%".. gangname .."%'", {})
        if players[1] ~= nil then
            for _, value in pairs(players) do
                local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)
                if not isOnline and json.decode(value.gang).name == gangname then
                    employees[#employees+1] = {
                        empSource = value.citizenid,
                        grade = json.decode(value.gang).grade,
                        online = false,
                        name = json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
                    }
                end
            end
            table.sort(employees, function(a, b)
                return a.grade.level > b.grade.level
            end)
        end
    end

	return employees, QBCore.Shared.Gangs
end)

lib.callback.register('cs:bossmenu:getplayers', function(source)
	local source = source
    local PlayerPed = GetPlayerPed(source)
	local players = {}
	if Config.HireNearbyPlayers then
		if Config.ServerType == 'QB' then
			local pCoords = GetEntityCoords(PlayerPed)
			for _, v in pairs(QBCore.Functions.GetPlayers()) do
				local targetped = GetPlayerPed(v)
				local tCoords = GetEntityCoords(targetped)
				local dist = #(pCoords - tCoords)
				if PlayerPed ~= targetped and dist < 10 then
					local ped = GetPlayer(v)
					players[#players+1] = {
						id = v,
						name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
						citizenid = ped.PlayerData.citizenid,
						sourceplayer = ped.PlayerData.source
					}
				end
			end
		elseif Config.ServerType == 'ESX' then
			local pCoords = GetEntityCoords(PlayerPed)
			for _, v in pairs(ESX.GetPlayers()) do
				local targetped = GetPlayerPed(v)
				local tCoords = GetEntityCoords(targetped)
				local dist = #(pCoords - tCoords)
				if PlayerPed ~= targetped and dist < 10 then
					local ped = GetPlayer(v)
					players[#players+1] = {
						id = v,
						name = ped.getName(),
						citizenid = ped.identifier,
						sourceplayer = v
					}
				end
			end
		end
	else
		if Config.ServerType == 'QB' then
			for _, v in pairs(QBCore.Functions.GetPlayers()) do
				local targetped = GetPlayerPed(v)
				if PlayerPed ~= targetped then
					local ped = GetPlayer(v)
					players[#players+1] = {
						id = v,
						name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
						citizenid = ped.PlayerData.citizenid,
						sourceplayer = ped.PlayerData.source
					}
				end
			end
		elseif Config.ServerType == 'ESX' then
			for _, v in pairs(ESX.GetPlayers()) do
				local targetped = GetPlayerPed(v)
				if PlayerPed ~= targetped then
					local ped = GetPlayer(v)
					players[#players+1] = {
						id = v,
						name = ped.getName(),
						citizenid = ped.identifier,
						sourceplayer = v
					}
				end
			end
		end
	end
	table.sort(players, function(a, b)
		return a.sourceplayer < b.sourceplayer
	end)
	return players
end)


--- Discord Logs ---

function SendDiscordLog(action, data)
    local webHook = Config.DicordLogs.WebHook
    local embedData
    if action == 'money' then
        if data.add then
            embedData = {
                {
                    ['title'] = data.type,
                    ['color'] = 65280,
                    ['footer'] = {
                        ['text'] = os.date('%c'),
                    },
                    ['description'] = '**Money Added By: **' ..GetPlayerName(data.Ply).."\n**Amount: **$"..data.amount..'\n**Account Name: **'..data.account
                }
            }
        else
            embedData = {
                {
                    ['title'] = data.type,
                    ['color'] = 16711680,
                    ['footer'] = {
                        ['text'] = os.date('%c'),
                    },
                    ['description'] = '**Money Deducted By: **' ..GetPlayerName(data.Ply).."\n**Amount: **$"..data.amount..'\n**Account Name: **'..data.account
                }
            }

        end
    elseif action == 'recruit' then
        embedData = {
            {
                ['title'] = 'Player Recruitment',
                ['color'] = 16777215,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = '**Player Recruited By: **' ..GetPlayerName(data.Ply).."\n**Player Recruited: **"..GetPlayerName(data.target)..'\n**Job Name: **'..data.job..'\n**Type: **'..data.type
            }
        }
    elseif action == 'fire' then
        embedData = {
            {
                ['title'] = 'Player Fired',
                ['color'] = 16744192,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = '**Player Fired By: **' ..GetPlayerName(data.Ply).."\n**Fired Player: **"..GetPlayerName(data.target)..'\n**Job Name: **'..data.job..'\n**Type: **'..data.type
            }
        }
    elseif action == 'rank' then
        embedData = {
            {
                ['title'] = 'Player Rank Changed',
                ['color'] = 16776960,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = '**Player Action By: **' ..GetPlayerName(data.Ply).."\n**Managed Player: **"..GetPlayerName(data.target)..'\n**Job Name: **'..data.job..'\n**New Rank: **'..data.rank..'\n**Type: **'..data.type
            }
        }
    end
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Boss Menu Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
end



-- [ox_inventory] Boss Inventory Creation --

RegisterNetEvent('cs:bossmenu:oxInventory', function(job)
	exports.ox_inventory:RegisterStash("boss_" .. job, 'Stash', 20, 20000, job)
end)




--Backwards Compatability of qb-management  

local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_qb-management_%s'):format(exportName), 
    function(setCB)
        setCB(func)
    end)
end

-- GetAccount export
exportHandler('GetAccount', function(name)
    return exports['cs_bossmenu']:GetAccount(name)
end)

-- GetGangAccount export
exportHandler('GetGangAccount', function(name)
    return exports['cs_bossmenu']:GetGangAccount(name)
end)

-- AddMoney export
exportHandler('AddMoney', function(account, amount)
    exports['cs_bossmenu']:AddMoney(account, amount)
end)

-- AddGangMoney export
exportHandler('AddGangMoney', function(account, amount)
    exports['cs_bossmenu']:AddGangMoney(account, amount)
end)

-- RemoveMoney export
exportHandler('RemoveMoney', function(account, amount)
    exports['cs_bossmenu']:RemoveMoney(account, amount)
end)

-- RemoveGangMoney export
exportHandler('RemoveGangMoney', function(account, amount)
    exports['cs_bossmenu']:RemoveGangMoney(account, amount)
end)