-- Dusa Garage Management System Database Schema
-- Version: 1.0.0
-- Date: 2025-09-16

-- Create dusa_garages table
CREATE TABLE IF NOT EXISTS `dusa_garages` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(50) NOT NULL DEFAULT 'public' COMMENT 'Types: public, property, job',
    `owner_identifier` VARCHAR(255) NULL COMMENT 'Owner identifier for property/job garages',
    `locations` JSON NOT NULL COMMENT 'Interaction, vehicle spawn, and parking point coordinates',
    `settings` JSON NULL COMMENT 'Garage-specific settings (e.g., transfer fees)',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY `uk_garage_name` (`name`),
    INDEX `idx_type` (`type`),
    INDEX `idx_owner` (`owner_identifier`),
    CONSTRAINT `chk_garage_type` CHECK (`type` IN ('public', 'property', 'job'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create dusa_vehicle_metadata table
CREATE TABLE IF NOT EXISTS `dusa_vehicle_metadata` (
    `plate` VARCHAR(15) PRIMARY KEY,
    `mileage` FLOAT DEFAULT 0.0 COMMENT 'Total distance traveled by vehicle (km)',
    `health_props` JSON NULL COMMENT 'Health status of vehicle parts (engine, brakes, etc.)',
    `custom_name` VARCHAR(50) NULL COMMENT 'Custom name for the vehicle',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX `idx_mileage` (`mileage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create dusa_car_meets table
CREATE TABLE IF NOT EXISTS `dusa_car_meets` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `location` JSON NOT NULL COMMENT 'Predefined location coordinates for the event',
    `creator_identifier` VARCHAR(255) NOT NULL COMMENT 'Creator player identifier',
    `start_time` TIMESTAMP NOT NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `expires_at` TIMESTAMP NOT NULL COMMENT 'Automatic deletion time for this record',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX `idx_creator` (`creator_identifier`),
    INDEX `idx_active` (`is_active`),
    INDEX `idx_expires` (`expires_at`),
    INDEX `idx_start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default public garages (examples)
INSERT IGNORE INTO `dusa_garages` (`name`, `type`, `locations`, `settings`) VALUES
('Central Los Santos Garage', 'public', JSON_OBJECT(
    'interaction', JSON_OBJECT('x', 228.9, 'y', -991.0, 'z', 29.0),
    'spawn', JSON_OBJECT('x', 215.0, 'y', -991.0, 'z', 29.0, 'h', 180.0),
    'parking', JSON_ARRAY(
        JSON_OBJECT('x', 220.0, 'y', -985.0, 'z', 29.0, 'h', 0.0),
        JSON_OBJECT('x', 225.0, 'y', -985.0, 'z', 29.0, 'h', 0.0),
        JSON_OBJECT('x', 230.0, 'y', -985.0, 'z', 29.0, 'h', 0.0)
    )
), JSON_OBJECT('transferFee', 100)),

('Sandy Shores Garage', 'public', JSON_OBJECT(
    'interaction', JSON_OBJECT('x', 1737.0, 'y', 3710.0, 'z', 34.0),
    'spawn', JSON_OBJECT('x', 1729.0, 'y', 3719.0, 'z', 34.0, 'h', 20.0),
    'parking', JSON_ARRAY(
        JSON_OBJECT('x', 1735.0, 'y', 3715.0, 'z', 34.0, 'h', 200.0),
        JSON_OBJECT('x', 1740.0, 'y', 3718.0, 'z', 34.0, 'h', 200.0)
    )
), JSON_OBJECT('transferFee', 150)),

('Paleto Bay Garage', 'public', JSON_OBJECT(
    'interaction', JSON_OBJECT('x', 105.0, 'y', 6613.0, 'z', 32.0),
    'spawn', JSON_OBJECT('x', 110.0, 'y', 6607.0, 'z', 32.0, 'h', 45.0),
    'parking', JSON_ARRAY(
        JSON_OBJECT('x', 115.0, 'y', 6610.0, 'z', 32.0, 'h', 225.0),
        JSON_OBJECT('x', 120.0, 'y', 6615.0, 'z', 32.0, 'h', 225.0)
    )
), JSON_OBJECT('transferFee', 200));