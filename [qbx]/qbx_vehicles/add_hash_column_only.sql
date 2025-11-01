-- Add only the missing hash column to player_vehicles table
-- The license column already exists, so we only need to add hash

ALTER TABLE player_vehicles ADD COLUMN hash varchar(50) DEFAULT NULL;
