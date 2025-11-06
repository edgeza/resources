if not Config.AutoInsertSQL then return end

function InsertSQL()
    local inserted = false
    local vehicleTable = Config.FrameworkSQLtables.vehicle_table
    local usersTable = Config.FrameworkSQLtables.users_table
    local columns = {
        {table = vehicleTable, column = "in_garage",        data = "TINYINT(1) NOT NULL DEFAULT 0"},
        {table = vehicleTable, column = "garage_id",        data = "VARCHAR(50) NOT NULL DEFAULT 'A'"},
        {table = vehicleTable, column = "garage_type",      data = "VARCHAR(50) NOT NULL DEFAULT 'car'"},
        {table = vehicleTable, column = "job_personalowned",data = "VARCHAR(50) NOT NULL DEFAULT ''"},
        {table = vehicleTable, column = "property",         data = "INT(10) NOT NULL DEFAULT 0"},
        {table = vehicleTable, column = "impound",          data = "INT(10) NOT NULL DEFAULT 0"},
        {table = vehicleTable, column = "impound_data",     data = "LONGTEXT NOT NULL DEFAULT ''"},
        {table = vehicleTable, column = "adv_stats",        data = "LONGTEXT NOT NULL DEFAULT '{\"plate\":\"nil\",\"mileage\":0.0,\"maxhealth\":1000.0}'"},
        {table = vehicleTable, column = "custom_label",     data = "VARCHAR(30) NULL DEFAULT NULL"},
        {table = vehicleTable, column = "fakeplate",        data = "VARCHAR(8) NULL DEFAULT NULL"},
        {table = usersTable,   column = "garage_limit",     data = "INT(10) NOT NULL DEFAULT 7"},
    }

    for _, cd in pairs(columns) do
        local query = string.format('SELECT %s FROM %s LIMIT 1', cd.column, cd.table)
        local result = DatabaseQuery(query)
        if not result then
            print(string.format('^5Automatically inserting [%s] into [%s].', cd.column, cd.table))
            local create_query = string.format('ALTER TABLE %s ADD COLUMN %s %s;', cd.table, cd.column, cd.data)
            DatabaseQuery(create_query)
            inserted = true
        end
    end

    local database_name = DatabaseQuery('SELECT database()')[1]['database()']
    local garage_id_column = DatabaseQuery('SELECT column_default FROM information_schema.columns WHERE table_schema = "'..database_name..'" AND (table_name = "'..vehicleTable..'" AND column_name = "garage_id");')[1]
    if garage_id_column then
        garage_id_column = garage_id_column.column_default or garage_id_column.COLUMN_DEFAULT
        garage_id_column = garage_id_column:gsub("%'", "")
        if garage_id_column ~= Config.Locations[1].Garage_ID then        
            DatabaseQuery('ALTER TABLE '..vehicleTable..' ALTER garage_id SET DEFAULT("'..Config.Locations[1].Garage_ID..'");')
            DatabaseQuery('UPDATE '..vehicleTable..' SET garage_id="'..Config.Locations[1].Garage_ID..'" WHERE garage_id="'..garage_id_column..'";')
            print(string.format('^5Automatically changing [%s.garage_id] default_value from ^2[%s]^0 ^5to^0 ^2[%s]^0.', vehicleTable, garage_id_column, Config.Locations[1].Garage_ID))
            inserted = true
        end
    else
        print(string.format('^1Error: [%s] table does not exist in your database.^0', vehicleTable))
    end


    if Config.VehicleKeys.ENABLE then
        local Query_1 = DatabaseQuery('SELECT 1 FROM cd_garage_keys LIMIT 1')
        if not Query_1 then
            DatabaseQuery('CREATE TABLE cd_garage_keys (plate VARCHAR(8) NOT NULL, owner_identifier VARCHAR(50) NOT NULL, reciever_identifier VARCHAR(50) NOT NULL, owner_name VARCHAR(50) NOT NULL, reciever_name VARCHAR(50) NOT NULL, model VARCHAR(50) NOT NULL);')
            print('^5Automatically created [cd_garage_keys] table.')
            inserted = true
        else
            local Query_2 = DatabaseQuery('SELECT owner_name, reciever_name FROM cd_garage_keys LIMIT 1')
            if not Query_2 then
                DatabaseQuery('ALTER TABLE cd_garage_keys ADD COLUMN owner_name VARCHAR(50) NOT NULL, ADD COLUMN reciever_name VARCHAR(50) NOT NULL;')
                print('^5Automatically added [owner_name reciever_name] columns to [cd_garage_keys] table.')

                DatabaseQuery('ALTER TABLE cd_garage_keys DROP COLUMN char_name;')
                print('^5Automatically removed [char_name] column from [cd_garage_keys] table.')

                DatabaseQuery('TRUNCATE TABLE cd_garage_keys;')
                print('^5Automatically cleared all data from [cd_garage_keys] table to prevent issues.');
                inserted = true
            end

            local Query_3 = DatabaseQuery('SELECT model FROM cd_garage_keys LIMIT 1')
            if not Query_3 then
                DatabaseQuery('ALTER TABLE cd_garage_keys ADD COLUMN model VARCHAR(50) NOT NULL;')
                print('^5Automatically added [model] column to [cd_garage_keys] table.')
                inserted = true
            end
        end

    end

    if Config.PrivateGarages.ENABLE then
        local Query = DatabaseQuery('SELECT 1 FROM cd_garage_privategarage LIMIT 1')
        if not Query then
            DatabaseQuery('CREATE TABLE cd_garage_privategarage (identifier VARCHAR(50) NOT NULL, data LONGTEXT NOT NULL);')
            print('^5Automatically created [cd_garage_privategarage] table.')
            inserted = true
        end
    end

    if Config.PersistentVehicles.ENABLE then
        local Query = DatabaseQuery('SELECT 1 FROM cd_garage_persistentvehicles LIMIT 1')
        if not Query then
            DatabaseQuery('CREATE TABLE cd_garage_persistentvehicles (persistent LONGTEXT NOT NULL);')
            DatabaseQuery('INSERT INTO cd_garage_persistentvehicles (persistent) VALUES (@persistent)', {
                ['@persistent'] = json.encode({}),
            })
            print('^5Automatically created [cd_garage_persistentvehicles] table.')
            inserted = true
        end
    end

    if inserted then
        print('^5--------------------------^0')
        print('^5SQL Inserted Successfully.^0')
        print('^5Ignore any errors abvove.^0')
        print('^5--------------------------^0')
    end
end