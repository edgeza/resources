
RegisterServerEvent('codem-craft:AddXP')
AddEventHandler('codem-craft:AddXP', function (xp)
local src = source
AddXPCraft(src, xp)
end)

function AddXPCraft(source, xp)
   local identifier = GetIdentifier(source)
   local maxLevel = #Config.RequiredXP
   local level = craftData[identifier].level

   if level >= maxLevel then
      return
   end

   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      if craftData[identifier] then
         local level = craftData[identifier].level
         craftData[identifier].xp = tonumber(craftData[identifier].xp) + tonumber(xp)
         if craftData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end

      if craftData[identifier] then
         local level = craftData[identifier].level
         craftData[identifier].xp = tonumber(craftData[identifier].xp) + tonumber(xp)
         if craftData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   end
end

function CraftRemoveXP(source, xp)
   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if craftData[identifier] then
         craftData[identifier].xp = tonumber(craftData[identifier].xp) - xp
         if craftData[identifier].xp <= 0 then
            RemoveLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end

      local identifier = GetIdentifier(source)
      if craftData[identifier] then
         craftData[identifier].xp = tonumber(craftData[identifier].xp) - xp
         if craftData[identifier].xp <= 0 then
            RemoveLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end

   end
end

function SetXP(source, xp)
   if Config.Framework == 'esx' then
      if not xp and xp <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if craftData[identifier] then
         local level = craftData[identifier].level
         craftData[identifier].xp = tonumber(craftData[identifier].xp) + xp
         if craftData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   else
      if not xp and xp <= 0 then
         return
      end
      local identifier = GetIdentifier(source)

      if craftData[identifier] then
         local level = craftData[identifier].level
         craftData[identifier].xp = tonumber(craftData[identifier].xp) + xp
         if craftData[identifier].xp >= Config.RequiredXP[level] then
            AddLevel(source)
         else
            ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "' WHERE identifier = '".. identifier.."'"))
         end
      end
   end
end

function AddLevel(source)
   if Config.Framework == 'esx' then
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier

      if craftData[identifier] then
         craftData[identifier].level = craftData[identifier].level + 1
         if not Config.RequiredXP[craftData[identifier].level]  then
            craftData[identifier].level = #Config.RequiredXP
            craftData[identifier].xp = Config.RequiredXP[craftData[identifier].level]
         else
            craftData[identifier].xp = 0
         end
     
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return craftData[identifier].level
      end
   else
      local identifier = GetIdentifier(source)
      if craftData[identifier] then
         craftData[identifier].level = craftData[identifier].level + 1
         if not Config.RequiredXP[craftData[identifier].level]  then
            craftData[identifier].level = #Config.RequiredXP
            craftData[identifier].xp = Config.RequiredXP[craftData[identifier].level]
         else
            craftData[identifier].xp = 0
         end
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return craftData[identifier].level
      end

   end
end

function RemoveLevel(source)
   if Config.Framework == 'esx' then
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if craftData[identifier] then
         craftData[identifier].level = craftData[identifier].level - 1
         if craftData[identifier].level <= 0 then
            craftData[identifier].level = 1
         end
         craftData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return craftData[identifier].level
      end
   else
      local identifier = GetIdentifier(source)
      if craftData[identifier] then
         craftData[identifier].level = craftData[identifier].level - 1
         if craftData[identifier].level <= 0 then
            craftData[identifier].level = 1
         end
         craftData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return craftData[identifier].level
      end

   end
end

function SetCraftLevel(source, level)
   if Config.Framework == 'esx' then
      if not level and level <= 0 then
         return
      end
      local xPlayer = frameworkObject.GetPlayerFromId(source)
      local identifier = xPlayer.identifier
      if craftData[identifier] and tonumber(craftData[identifier].level) ~= tonumber(level) then
         craftData[identifier].level = level
         
         if craftData[identifier].level <= 0 then
            craftData[identifier].level = 1
         end
         craftData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))
         return craftData[identifier].level
      end
   else
      if not level and level <= 0 then
         return
      end
      local identifier = GetIdentifier(source)
      if craftData[identifier] and tonumber(craftData[identifier].level) ~= tonumber(level) then
         craftData[identifier].level = level
         if craftData[identifier].level <= 0 then
            craftData[identifier].level = 1
         end
         craftData[identifier].xp = 0
         ExecuteSql(string.format("UPDATE  `"..Config.MysqlTableName.."` SET `xp` = '" .. craftData[identifier].xp .. "', `level` = '"..craftData[identifier].level.."' WHERE identifier = '".. identifier.."'"))

         return craftData[identifier].level
      end

   end
end

