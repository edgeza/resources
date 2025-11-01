-- Comprehensive database schema fix for player_vehicles table
-- This script adds all missing columns that qbx_vehicles expects

-- Add license column if it doesn't exist
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS license varchar(50) DEFAULT NULL;

-- Add hash column if it doesn't exist  
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS hash varchar(50) DEFAULT NULL;

-- Add fakeplate column if it doesn't exist
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS fakeplate varchar(50) DEFAULT NULL;

-- Add fuel column if it doesn't exist (with default value)
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS fuel int(11) DEFAULT 100;

-- Add engine column if it doesn't exist (with default value)
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS engine float DEFAULT 1000;

-- Add body column if it doesn't exist (with default value)  
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS body float DEFAULT 1000;

-- Add state column if it doesn't exist (with default value)
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS state int(11) DEFAULT 1;

-- Add depotprice column if it doesn't exist (with default value)
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS depotprice int(11) NOT NULL DEFAULT 0;

-- Add drivingdistance column if it doesn't exist
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS drivingdistance int(50) DEFAULT NULL;

-- Add status column if it doesn't exist
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS status text DEFAULT NULL;

-- Add coords column if it doesn't exist
ALTER TABLE player_vehicles ADD COLUMN IF NOT EXISTS coords text DEFAULT NULL;

-- Ensure the plate column has the correct constraint
ALTER TABLE player_vehicles MODIFY COLUMN plate varchar(15) NOT NULL;

-- Add unique constraint on plate if it doesn't exist
ALTER TABLE player_vehicles ADD UNIQUE KEY IF NOT EXISTS plate (plate);
