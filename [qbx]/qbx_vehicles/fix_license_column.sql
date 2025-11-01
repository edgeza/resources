-- Simple fix for missing license column in player_vehicles table
-- Run this SQL script in your database to fix the admincar command error

ALTER TABLE player_vehicles ADD COLUMN license varchar(50) DEFAULT NULL;
