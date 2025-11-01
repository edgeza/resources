-- Migration script to add missing license column to player_vehicles table
-- This fixes the "Unknown column 'license'" error in qbx_vehicles

-- Check if the license column exists, if not add it
SET @sql = (SELECT IF(
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE TABLE_SCHEMA = DATABASE() 
     AND TABLE_NAME = 'player_vehicles' 
     AND COLUMN_NAME = 'license') > 0,
    'SELECT "License column already exists" as message',
    'ALTER TABLE player_vehicles ADD COLUMN license varchar(50) DEFAULT NULL AFTER id'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
