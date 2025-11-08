function utils:update(cachetable, updtable, key1, key2)
    for i, val in ipairs(cachetable) do
        val.citizen = val.citizenid or val.userCitizen or val.citizen or val.id or val.command_id
        updtable.citizen = updtable.citizenid or updtable.userCitizen or updtable.citizen or updtable.id or updtable.command_id
        if val.citizen == updtable.citizen then
            val[key1] = updtable[key2]
            break
        end
    end
end

function utils:convertPlayers(v)
    if shared.framework == 'qb' then
        v.charinfo = type(v.charinfo) == 'string' and json.decode(v.charinfo) or v.charinfo
        v.job = type(v.job) == 'string' and json.decode(v.job) or v.job
        v.metadata = type(v.metadata) == 'string' and json.decode(v.metadata) or v.metadata
    elseif shared.framework == 'esx' then
        v.citizenid = v.identifier
        v.charinfo = {
          firstname = v.firstname,
          lastname = v.lastname,
          birthdate = v.dateofbirth,
          phone = v.phone_number,
          gender = v.sex == "m" and 0 or 1
        }
        v.job = {
          name = v.job,
          grade = {
              name = v.job or v.job.grade.name
          }
        }
    end
end

function utils:clearcache()
    store:clear()
end

-- create a function that find a value from table
-- k1 : id, citizenid
function utils:find(tbl, searchFor, key)
    for k, v in pairs(tbl) do
        if v[searchFor] == key then
            return true
        end
    end
    return false
end

lib.callback.register('dusa_mdt:ready', function(source)
    store:init()
    return true
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        store:init()
    end
end)