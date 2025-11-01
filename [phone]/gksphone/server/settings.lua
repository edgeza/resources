--- Freamwork Notification ---

function FreamworkNotify(source, message, notifyType, length)
  length = length or 5000
  if Config.Framework == "esx" then
    notifyType = notifyType or "info"
    TriggerClientEvent('esx:showNotification', source, message, notifyType, length)
  elseif Config.Framework == "qb" or Config.Framework == "qbx" then
    notifyType = notifyType or "success"
    TriggerClientEvent('QBCore:Notify', source, message, notifyType, length)
  elseif Config.Framework == "standalone" then
    notifyType = notifyType or "success"
    Debugprint(notifyType, source, message)
  end
end


--- Phone Unique ID ---

local function randomString(length)
  local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  local result = ''
  for i = 1, length do
      local rand = math.random(#chars)
      result = result .. chars:sub(rand, rand)
  end
  return result
end

function GenerateSerialNumber()
  :: generateSerial ::
  local prefix = Config.SerialNumberPrefix
  local date = os.date("%Y%m")
  local serial = randomString(4)
  local serialNumber = prefix .. date .. serial
  local result = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM gksphone_settings WHERE unique_id = ?', {serialNumber})
  if result > 0 then
    goto generateSerial
  end
  return serialNumber
end

--- Create Phone Number ---

function CreatePhoneNumber()
  :: createNumber ::
  -- Generate a random number with the configured length
  local phoneNumberBase = ""
  for i = 1, Config.PhoneNumber.Length do
    phoneNumberBase = phoneNumberBase .. math.random(0, 9)
  end
  
  -- Select a random prefix from the configured prefixes
  local prefix = Config.PhoneNumber.Prefixes[math.random(1, #Config.PhoneNumber.Prefixes)]
  
  -- Combine prefix and base number
  local completePhoneNumber = tostring(prefix .. phoneNumberBase)
  
  -- Check if the number already exists in the database
  local query = '%' .. completePhoneNumber .. '%'
  local result = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM gksphone_esim WHERE phone_number LIKE ?', { query })
  
  if result > 0 then
    goto createNumber -- If number exists, generate a new one
  end
  
  return completePhoneNumber
end

--- Is Player Banned Check ----

function IsPlayerBanned(identifier)
  if Config.Framework == "qb" or Config.Framework == "qbx" then
    local res = MySQL.single.await('SELECT license FROM players WHERE citizenid = ?', { identifier })
    if not res then return false end
    local result = MySQL.single.await('SELECT id, reason, expire FROM bans WHERE license = ?', { res.plicense })
    if not result then return false end
    if os.time() < result.expire then
      return true
    end
    return false
  end
  return false
end