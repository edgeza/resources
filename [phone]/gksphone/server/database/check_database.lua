local logFileName = "database_setup.log"

local function GetLogFileContent()
    local file = LoadResourceFile(GetCurrentResourceName(), logFileName)
    return file or ""
end

local function LogDatabaseChange(message)
    local timestamp = os.date("[%Y-%m-%d %H:%M:%S] ")
    local line = timestamp .. message .. "\n"
    SaveResourceFile(GetCurrentResourceName(), logFileName, GetLogFileContent() .. line, -1)
end

local function ensureTable(tableName, data, cb)
    MySQL.query("SHOW TABLES LIKE ?", {tableName}, function(result)
        if not result[1] then
            MySQL.query(data.create, {}, function(createResult)
                if createResult then
                    print("[GKSPHONE] Table created: "..tableName)
                    LogDatabaseChange("Table created: "..tableName)
                else
                    print("[GKSPHONE] Failed to create table: "..tableName)
                    LogDatabaseChange("Failed to create table: "..tableName)
                end
                cb()
            end)
        else
            cb()
        end
    end)
end

local function ensureColumns(tableName, columns, cb)
    if not columns or next(columns) == nil then
        cb()
        return
    end
    
    local keys = {}
    for colName in pairs(columns) do 
        table.insert(keys, colName) 
    end
    
    if #keys == 0 then
        cb()
        return
    end
    
    local done = 0
    MySQL.query("SHOW COLUMNS FROM `"..tableName.."`", {}, function(existing)
        local existingCols = {}
        for _, c in ipairs(existing or {}) do 
            existingCols[c.Field] = true 
        end
        
        for _, col in ipairs(keys) do
            if not existingCols[col] then
                local alter = "ALTER TABLE `"..tableName.."` ADD COLUMN "..columns[col]
                MySQL.query(alter, {}, function(alterResult)
                    if alterResult then
                        print("[GKSPHONE] Added column `"..col.."` → "..tableName)
                        LogDatabaseChange("Added column: "..col.." → "..tableName)
                    else
                        print("[GKSPHONE] Failed to add column `"..col.."` → "..tableName)
                        LogDatabaseChange("Failed to add column: "..col.." → "..tableName)
                    end
                    
                    done = done + 1
                    if done >= #keys then 
                        cb() 
                    end
                end)
            else
                done = done + 1
                if done >= #keys then 
                    cb() 
                end
            end
        end
    end)
end

local function ensureTrigger(triggerName, data, cb)
    MySQL.query("SHOW TRIGGERS WHERE `Trigger` = ?", {triggerName}, function(result)
        if not result[1] then
            MySQL.query(data.create, {}, function(createResult)
                if createResult then
                    print("[GKSPHONE] Trigger created: "..triggerName)
                    LogDatabaseChange("Trigger created: "..triggerName)
                else
                    print("[GKSPHONE] Failed to create trigger: "..triggerName)
                    LogDatabaseChange("Failed to create trigger: "..triggerName)
                end
                cb()
            end)
        else
            cb()
        end
    end)
end

local DBTablesOrder = {
    "gksphone_settings",
    "gksphone_esim",
    "gksphone_advertising",
    "gksphone_bank_history",
    "gksphone_billing",
    "gksphone_calls",
    "gksphone_contacts",
    "gksphone_gallery",
    "gksphone_gameleaderboard",
    "gksphone_gps",
    "gksphone_mails",
    "gksphone_messages",
    "gksphone_messages_groups",
    "gksphone_messages_groups_members",
    "gksphone_messages_groups_messages",
    "gksphone_news",
    "gksphone_notes",
    "gksphone_stockmarket",
    "gksphone_twt_users",
    "gksphone_twt_posts",
    "gksphone_twt_followers",
    "gksphone_twt_hastags",
    "gksphone_twt_likepost",
    "gksphone_twt_retweet",
    "gksphone_vehicle_sales",
    "gksphone_wanted",
    "gksphone_music",
    "gksphone_music_like",
    "gksphone_flare_users",
    "gksphone_flare_swipes",
    "gksphone_flare_matches",
    "gksphone_flare_messages",
    "gksphone_instagram_users",
    "gksphone_instagram_stories",
    "gksphone_instagram_posts",
    "gksphone_instagram_post_likes",
    "gksphone_instagram_follows",
    "gksphone_instagram_comments",
    "gksphone_instagram_comment_likes",
    "gksphone_instagram_conversations",
    "gksphone_instagram_conversation_participants",
    "gksphone_instagram_messages",
    "gksphone_instagram_notifications",
    "gksphone_instagram_active_stories_v2",
    "gksphone_instagram_conversations_v1",
    "gksphone_darkchat_users",
    "gksphone_darkchat_rooms",
    "gksphone_darkchat_room_members",
    "gksphone_darkchat_messages"
}
local defaultTables = {}
local deafaultTriggers = {}

local function SetupDatabaseTriggers()
    for tableName, data in pairs(deafaultTriggers) do
        ensureTrigger(tableName, data, function()

        end)
    end
end

local function SetupDatabaseSequential()
    local function processNextTable(index)
        if index > #DBTablesOrder then
            SetupDatabaseTriggers()
            return
        end
        local tableName = DBTablesOrder[index]
        local data = defaultTables[tableName]
        if data then
            ensureTable(tableName, data, function()
                ensureColumns(tableName, data.columns or {}, function()
                    processNextTable(index + 1)
                end)
            end)
        else
            LogDatabaseChange("Error: No data found for table: "..tableName)
            print("[GKSPHONE] Error: No data found for table: "..tableName)
            processNextTable(index + 1)
        end
    end
    processNextTable(1)
end

if Config and Config.DatabaseAutoSetup then
    MySQL.ready(function()
        if Config.DatabaseAutoSetup then
            Wait(1)
            defaultTables, deafaultTriggers = GetDefaultDatabaseTables()
            SetupDatabaseSequential()
        end
    end)
end
