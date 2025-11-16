if GetResourceState("qb-core") ~= "started" then return end

Core = {}
Core.job = {
    name = 'unemployed',
    grade = 0
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local QBCore = exports['qb-core']:GetCoreObject()
    local playerData = QBCore.Functions.GetPlayerData()
    Core.job.name = playerData.job.name
    Core.job.grade = playerData.job.grade.level
    LoadZone()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    Core.job.name = job.name
    Core.job.grade = job.grade.level
end)

RegisterNetEvent('an-engineswap:client:updatePlayerJob', function(job)
    if source == '' then return end
    Core.job.name = job.name
    Core.job.grade = job.grade
end)

if lib.context == 'server' then
    Core.Player = {}

    ---@class Player: OxClass
    local player = lib.class('Player')
    local QBCore = exports['qb-core']:GetCoreObject()

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:constructor(source)
        self.player = QBCore.Functions.GetPlayer(source) --[[@as table]]
        self.source = source
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:isAdmin()
        if not self.source then return false end
        return IsPlayerAceAllowed(self.source, 'admin')
    end
    
    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getIdentifier()
        return self.player.PlayerData.citizenid
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getJob()
        local pData = self.player.PlayerData
        return {
            name = pData.job.name,
            grade = pData.job.grade.level
        }
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:isGroups(groups)
        local _gt = type(groups)
        local myJob = self:getJob()
    
        if _gt == 'table' then
            local _tt = table.type(groups)
            if _tt == 'array' then
                return lib.array.find(groups, function (v)
                    if v == myJob.name then
                        return true
                    end
                end)
            elseif _tt == 'hash' then
                return groups[myJob.name] and groups[myJob.name] >= myJob.grade
            end
        elseif _gt == 'string' then
            return groups == myJob.name
        end
        return false
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:removeMoney(type, count)
        return self.player.Functions.RemoveMoney(type, count, '')
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getName()
        local charinfo = self.player.PlayerData.charinfo
        return ('%s %s'):format(charinfo.firstname, charinfo.lastname)
    end

    local function ensurePlayerLoaded(source)
        local src = tonumber(source)
        if not src then return end

        local existing = Core.Player[src]
        if existing and existing.player then
            return existing
        end

        local newPlayer = player:new(src)
        if not newPlayer.player then
            return nil
        end

        Core.Player[src] = newPlayer
        SetTimeout(0, function()
            TriggerClientEvent('an-engineswap:client:updatePlayerJob', src, newPlayer:getJob())
        end)

        return newPlayer
    end

    Core.GetOrCreatePlayer = ensurePlayerLoaded

    RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
        ensurePlayerLoaded(source)
    end)

    RegisterNetEvent('QBCore:Server:OnPlayerUnload', function()
        Core.Player[source] = nil
    end)

    AddEventHandler('playerDropped', function()
        Core.Player[source] = nil
    end)

    lib.addCommand('loadplayer', {
        help = 'Load player',
        restricted = 'group.admin'
    }, function(source, args, raw)
        ensurePlayerLoaded(source)
    end)
end
