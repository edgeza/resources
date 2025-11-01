local framework = GetFramework()
CreateThread(function()
    if not Config.AutoInstallSQL then return end

    MySQL.Async.fetchScalar("SHOW TABLES LIKE 'pl_uwucafe'", {}, function(result)
        if result then
            DebugPrint("[pl_uwucafe] Tables already exist. Skipping SQL install.")
        else
            installSchema(framework)
        end
    end)
end)

function installSchema(framework)
    if framework == "esx" then
        installESXSchema()
    elseif framework == "qb" or framework == "qbox" then
        installQBCoreSchema()
    else
        DebugPrint("[pl_uwucafe] Unknown framework in config. SQL not installed.")
    end
end

function installESXSchema()
    local sql = [[
        CREATE TABLE IF NOT EXISTS `pl_uwucafe` (
          `stock` longtext DEFAULT NULL,
          `state` varchar(5) NOT NULL DEFAULT 'open'
        ) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
        
        INSERT INTO `addon_account` (name, label, shared) VALUES
        	('society_uwu', 'Uwu Cafe', 1);
        
        INSERT INTO `datastore` (name, label, shared) VALUES
        	('society_uwu', 'Uwu Cafe', 1);
        
        INSERT INTO `jobs` (name, label,whitelisted) VALUES
        	('uwu', 'UwU Cafe',1)
        ;
        
        INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
        	('uwu',0,'cashier','Cashier',20,'{}','{}'),
        	('uwu',1,'cook','Cook',40,'{}','{}'),
        	('uwu',2,'staff','Staff',60,'{}','{}'),
        	('uwu',3,'manager','Manager',85,'{}','{}'),
        	('uwu',4,'boss','Owner',100,'{}','{}');
    ]]

    MySQL.Async.execute(sql, {}, function()
        DebugPrint("[pl_uwucafe] ESX schema installed.")
    end)
end

function installQBCoreSchema()
    local sql = [[
        CREATE TABLE IF NOT EXISTS `pl_uwucafe` (
            `stock` LONGTEXT DEFAULT NULL,
            `state` VARCHAR(5) NOT NULL DEFAULT 'open'
        ) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
    ]]

    MySQL.Async.execute(sql, {}, function()
        DebugPrint("[pl_uwucafe] QBCore schema installed.")
    end)
end
