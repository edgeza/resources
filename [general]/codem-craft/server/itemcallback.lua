function itemCallbacks()
   if Config.Framework == 'esx' then
      frameworkObject.RegisterServerCallback('codem-craft:GetItems', function(source, cb)
         local xPlayer = frameworkObject.GetPlayerFromId(source)
         if xPlayer then
            local items = {}
            for _,v in pairs(xPlayer.getInventory()) do
               if tonumber(v.count) > 0 then
                  table.insert(items, v)
               end
            end
            cb(items)
         else
            cb(false)
         end
     end)
   else
      frameworkObject.Functions.CreateCallback('codem-craft:GetItems', function(source, cb)
         local xPlayer = frameworkObject.Functions.GetPlayer(source)
         if xPlayer then
            local items = {}
            for _,v in pairs(xPlayer.PlayerData.items) do
               if v and tonumber(v.amount or v.count) > 0 then
                  table.insert(items, v)
               end
            end
            cb(items)
         else
            cb(false)
         end
      end)
   end
end

local claimedUniqeId = nil

RegisterServerEvent('codem-craft:claimItem')
AddEventHandler('codem-craft:claimItem', function(uniqeid)
  local src = source
  local identifier = GetIdentifier(src)
  claimedUniqeId = nil
  
  local data = ExecuteSql("SELECT * FROM `"..Config.MysqlTableName.."` WHERE identifier = '"..identifier.."'")
   for k, v in pairs(data) do 
     local newArray = {}
     local itemTable = json.decode(v.craftitems)
     for _, w in pairs(itemTable) do
         if w.uniqeid == uniqeid then 
           local difftime = os.difftime(w.itemtime, os.time())
            if difftime <= 0 then 
               if claimedUniqeId == uniqeid then 
                  return
               end
               claimedUniqeId = uniqeid
               if Config.Framework == 'esx' then
                  local xTarget = frameworkObject.GetPlayerFromId(src)

                  table.remove(itemTable,_)
                  
                  xTarget.addInventoryItem(w.itemname, w.itemamount or 1)

                  AddXPCraft(src,tonumber(w.xp))

                  if Config.Webhook and PlayerWebhook ~= ''then 
                     sendDiscordLog(src,w.itemlabel)
                  end

                  local data  = ExecuteSql("UPDATE `"..Config.MysqlTableName.."` SET `craftitems` = '"..json.encode(itemTable).."' WHERE identifier = '"..identifier.."'")
                  resultData(src)
               else
                  local xTarget = frameworkObject.Functions.GetPlayer(src)
                  table.remove(itemTable,_)
                  
                  xTarget.Functions.AddItem(w.itemname,w.itemamount or 1)

                  AddXPCraft(src,tonumber(w.xp))

                  if Config.Webhook and PlayerWebhook ~= ''then 
                     sendDiscordLog(src,w.itemlabel)
                  end

                  local data  = ExecuteSql("UPDATE `"..Config.MysqlTableName.."` SET `craftitems` = '"..json.encode(itemTable).."' WHERE identifier = '"..identifier.."'")
                  resultData(src)
          
              end
           end
         end  
      end
   end
end)