local framework = GetFramework()
CreateThread(function()
    if not Config.AutoInstallSQL then return end

    MySQL.Async.fetchScalar("SHOW TABLES LIKE 'pl_koi'", {}, function(result)
        if result then
            DebugPrint("[pl_koi] Tables already exist. Skipping SQL install.")
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
        DebugPrint("[pl_koi] Unknown framework in config. SQL not installed.")
    end
end

function installESXSchema()
    local sql = [[
        CREATE TABLE IF NOT EXISTS `pl_koi` (
          `stock` longtext DEFAULT NULL,
          `state` varchar(5) NOT NULL DEFAULT 'open'
        ) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

        INSERT INTO `addon_account` (name, label, shared) VALUES
        	('society_koi', 'koi', 1);

        INSERT INTO `datastore` (name, label, shared) VALUES
        	('society_koi', 'koi', 1);

        INSERT INTO `jobs` (name, label,whitelisted) VALUES
        	('koi', 'koi',1)
        ;

        INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
        	('koi',0,'cashier','Cashier',20,'{}','{}'),
        	('koi',1,'cook','Cook',40,'{}','{}'),
        	('koi',2,'staff','Staff',60,'{}','{}'),
        	('koi',3,'manager','Manager',85,'{}','{}'),
        	('koi',4,'boss','Owner',100,'{}','{}');
    ]]

    MySQL.Async.execute(sql, {}, function()
        DebugPrint("[pl_koi] ESX schema installed.")
    end)
end

function installQBCoreSchema()
    local sql = [[
        CREATE TABLE IF NOT EXISTS `pl_koi` (
          `stock` longtext DEFAULT NULL,
          `state` varchar(5) NOT NULL DEFAULT 'open'
        ) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
    ]]

    MySQL.Async.execute(sql, {}, function()
        DebugPrint("[pl_koi] QBCore schema installed.")
    end)
end
