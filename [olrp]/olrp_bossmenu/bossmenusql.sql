-- =====================================================
-- OLRP Boss Menu Database Schema
-- =====================================================
-- This file contains all the necessary tables for the OLRP Boss Menu system
-- Simply copy and paste this entire file into your database management tool
-- =====================================================

-- Job Applications Table
-- Stores all job applications submitted by players
CREATE TABLE IF NOT EXISTS `job_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `job` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `answers` longtext NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `date_submitted` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_reviewed` timestamp NULL DEFAULT NULL,
  `reviewer_id` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job` (`job`),
  KEY `citizenid` (`citizenid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Job Employee Permissions Table
-- Stores custom permissions for employees in different jobs
CREATE TABLE IF NOT EXISTS `job_employee_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `job` varchar(50) NOT NULL,
  `permissions` text NOT NULL,
  `granted_by` varchar(50) NOT NULL,
  `granted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_employee_job` (`citizenid`,`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Job Manager Settings Table
-- Stores user interface settings for each player
CREATE TABLE IF NOT EXISTS `job_manager_settings` (
  `citizenid` varchar(50) NOT NULL,
  `settings` longtext DEFAULT NULL,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Job Playtime Table
-- Tracks how long players have worked in each job
CREATE TABLE IF NOT EXISTS `job_playtime` (
  `citizenid` varchar(50) NOT NULL,
  `job` varchar(50) NOT NULL,
  `total_minutes` int(10) unsigned NOT NULL DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`citizenid`,`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Society Table
-- Stores society bank accounts and balances
CREATE TABLE IF NOT EXISTS `society` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `money` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Society Transactions Table
-- Logs all society money transactions
CREATE TABLE IF NOT EXISTS `society_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `employee` varchar(255) DEFAULT NULL,
  `executor` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `society_index` (`society`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Add last_updated column to players table if it doesn't exist
-- This helps track when player data was last modified
ALTER TABLE `players` 
ADD COLUMN IF NOT EXISTS `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP();

-- =====================================================
-- Installation Complete!
-- =====================================================
-- All tables have been created successfully.
-- The OLRP Boss Menu system is now ready to use.
-- =====================================================