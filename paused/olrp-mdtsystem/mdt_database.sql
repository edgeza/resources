-- MDT System Database Setup
-- Run this SQL file in your MySQL database to create all necessary tables

-- ============================================
-- MDT REPORTS TABLE
-- Stores all incident reports submitted by officers
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_reports` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `title` varchar(255) NOT NULL,
    `location` varchar(255) DEFAULT NULL,
    `summary` text,
    `suspects` varchar(255) DEFAULT NULL,
    `fine` int(11) DEFAULT 0,
    `officer` varchar(255) NOT NULL,
    `date` varchar(50) NOT NULL,
    `time` varchar(50) NOT NULL,
    `status` varchar(50) DEFAULT 'Open',
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_officer` (`officer`),
    KEY `idx_date` (`date`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT BOLOs TABLE
-- Stores Be On Lookout alerts
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `type` varchar(50) NOT NULL,
    `title` varchar(255) NOT NULL,
    `description` text,
    `date` varchar(50) NOT NULL,
    `created_by` varchar(255) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_type` (`type`),
    KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT STAFF LOGS TABLE
-- Stores staff duty logs and shift information
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_staff_logs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `officer` varchar(255) NOT NULL,
    `badge` varchar(50) NOT NULL,
    `start_time` varchar(50) NOT NULL,
    `end_time` varchar(50) DEFAULT NULL,
    `duration` varchar(50) DEFAULT NULL,
    `date` varchar(50) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_officer` (`officer`),
    KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT VEHICLE NOTES TABLE (Optional)
-- Stores additional notes about vehicles
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_vehicle_notes` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `plate` varchar(20) NOT NULL,
    `note` text NOT NULL,
    `officer` varchar(255) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT CITIZEN NOTES TABLE (Optional)
-- Stores notes about citizens/profiles
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_citizen_notes` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `note` text NOT NULL,
    `officer` varchar(255) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT WARRANTS TABLE (Optional)
-- Stores active warrants for citizens
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `name` varchar(255) NOT NULL,
    `charge` varchar(255) NOT NULL,
    `description` text,
    `officer` varchar(255) NOT NULL,
    `date` varchar(50) NOT NULL,
    `status` varchar(50) DEFAULT 'Active',
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_citizenid` (`citizenid`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- MDT CHARGES TABLE (Optional)
-- Stores charges/citations issued to citizens
-- ============================================
CREATE TABLE IF NOT EXISTS `mdt_charges` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `name` varchar(255) NOT NULL,
    `charge` varchar(255) NOT NULL,
    `fine` int(11) DEFAULT 0,
    `officer` varchar(255) NOT NULL,
    `date` varchar(50) NOT NULL,
    `time` varchar(50) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_citizenid` (`citizenid`),
    KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

