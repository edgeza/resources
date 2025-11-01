local QBCore = exports['qb-core']:GetCoreObject()

-- Cache to avoid hitting the DB repeatedly and to minimize latency
local CONTACT_CACHE = { data = nil, timestamp = 0 }
local CACHE_TTL_SECONDS = 60

local function buildContactsFromRows(rows)
    local contacts = {}
    for _, row in ipairs(rows or {}) do
        local charinfo = row.charinfo
        if type(charinfo) == 'string' then
            pcall(function()
                charinfo = json.decode(charinfo)
            end)
        end
        charinfo = charinfo or {}

        local metadata = row.metadata
        if type(metadata) == 'string' then
            pcall(function()
                metadata = json.decode(metadata)
            end)
        end
        metadata = metadata or {}

        local first = (charinfo.firstname or '')
        local last = (charinfo.lastname or '')
        local name = (first .. ' ' .. last):gsub('^%s*(.-)%s*$', '%1')

        local number = charinfo.phone or charinfo.phonenumber or metadata.phone or metadata.phonenumber or row.citizenid
        if name ~= '' and number then
            contacts[#contacts+1] = { name = name, number = tostring(number) }
        end
    end

    table.sort(contacts, function(a, b)
        return a.name:lower() < b.name:lower()
    end)
    return contacts
end

-- Return all players (offline + online) from DB
QBCore.Functions.CreateCallback('olrp_phonebook:getContacts', function(source, cb)
    local now = os.time()
    if CONTACT_CACHE.data and (now - CONTACT_CACHE.timestamp) < CACHE_TTL_SECONDS then
        cb(CONTACT_CACHE.data)
        return
    end

    local rows = MySQL.query.await('SELECT citizenid, charinfo, metadata FROM players', {}) or {}
    local contacts = buildContactsFromRows(rows)

    CONTACT_CACHE.data = contacts
    CONTACT_CACHE.timestamp = now
    cb(contacts)
end)


