CREATE TABLE IF NOT EXISTS `dusa_garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'public' COMMENT 'Types: public, property, job',
  `owner_identifier` varchar(255) DEFAULT NULL COMMENT 'Owner identifier for property/job garages',
  `locations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Interaction, vehicle spawn, and parking point coordinates' CHECK (json_valid(`locations`)),
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Garage-specific settings (e.g., transfer fees)' CHECK (json_valid(`settings`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_garage_name` (`name`),
  KEY `idx_type` (`type`),
  KEY `idx_owner` (`owner_identifier`),
  CONSTRAINT `chk_garage_type` CHECK (`type` in ('public','property','job'))
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tablo yapısı dökülüyor qboxproject_bf7e0d.dusa_vehicle_impounds
CREATE TABLE IF NOT EXISTS `dusa_vehicle_impounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(15) NOT NULL,
  `impound_type` enum('temporary','permanent','paid') NOT NULL DEFAULT 'temporary',
  `reason` text DEFAULT NULL COMMENT 'Reason for impound',
  `impounded_by` varchar(255) NOT NULL COMMENT 'Player identifier who impounded the vehicle',
  `impounded_at` timestamp NULL DEFAULT current_timestamp(),
  `release_at` timestamp NULL DEFAULT NULL COMMENT 'Release time for temporary impounds (NULL for permanent)',
  `duration_hours` int(11) DEFAULT NULL COMMENT 'Duration in hours for temporary impounds',
  `is_released` tinyint(1) DEFAULT 0,
  `released_at` timestamp NULL DEFAULT NULL,
  `released_by` varchar(255) DEFAULT NULL COMMENT 'Player identifier who released the vehicle',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `release_fee` decimal(10,2) DEFAULT NULL COMMENT 'Fee required to release the vehicle (NULL for temporary/permanent, value for paid impounds)',
  PRIMARY KEY (`id`),
  KEY `idx_plate` (`plate`),
  KEY `idx_impounded_by` (`impounded_by`),
  KEY `idx_impound_type` (`impound_type`),
  KEY `idx_is_released` (`is_released`),
  KEY `idx_release_at` (`release_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- tablo yapısı dökülüyor qboxproject_bf7e0d.dusa_vehicle_metadata
CREATE TABLE IF NOT EXISTS `dusa_vehicle_metadata` (
  `plate` varchar(15) NOT NULL,
  `mileage` float DEFAULT 0 COMMENT 'Total distance traveled by vehicle (km)',
  `health_props` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Health status of vehicle parts (engine, brakes, etc.)' CHECK (json_valid(`health_props`)),
  `custom_name` varchar(50) DEFAULT NULL COMMENT 'Custom name for the vehicle',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`plate`),
  KEY `idx_mileage` (`mileage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;