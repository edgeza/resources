if GetResourceState("es_extended") ~= "started" then return end

Core = {}
Core.job = {
    name = 'unemployed',
    grade = 0
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    local ESX = exports['es_extended']:getSharedObject()
    Core.job.name = playerData.job.name
    Core.job.grade = playerData.job.grade
    LoadZone()
end)

RegisterNetEvent('esx:setJob', function(job)
    Core.job.name = job.name
    Core.job.grade = job.grade
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
    local ESX = exports.es_extended:getSharedObject()

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:constructor(source)
        self.player = ESX.GetPlayerFromId(source)
        self.source = source
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getJob()
        return {
            name = self.player.job.name,
            grade = self.player.job.grade
        }
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getIdentifier()
        return self.player.identifier
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
    function player:isAdmin()
        return self.player.getGroup() == 'admin'
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:removeMoney(type, count)
        local moneyType = type == "cash" and "money" or type

        if self.player.getAccount(moneyType).money >= count then
            self.player.removeAccountMoney(moneyType, count, '')
            return true
        end
        return false
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function player:getName()
        return self.player.name
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

    RegisterNetEvent('esx:playerLoaded', function(_, xPlayer, isNew)
        local statebag = Player(xPlayer.source).state
        if not statebag.isLoggedIn then statebag:set("isLoggedIn", true, true) end
        ensurePlayerLoaded(xPlayer.source)
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
