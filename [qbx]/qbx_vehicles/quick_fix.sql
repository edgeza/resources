-- Quick fix for missing columns in player_vehicles table
-- Run this to fix the immediate errors

-- Add the missing columns that are causing errors
ALTER TABLE player_vehicles ADD COLUMN license varchar(50) DEFAULT NULL;
ALTER TABLE player_vehicles ADD COLUMN hash varchar(50) DEFAULT NULL;
