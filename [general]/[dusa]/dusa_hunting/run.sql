CREATE TABLE IF NOT EXISTS `dusa_hunting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT 'Avcı',
  `level` int(11) DEFAULT 1,
  `experience` int(11) DEFAULT 0,
  `shot` int(11) DEFAULT 0,
  `pet` varchar(50) DEFAULT NULL,
  `progress` int(11) GENERATED ALWAYS AS (`level` + `experience`) STORED,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `idx_identifier` (`identifier`),
  KEY `idx_progress` (`progress`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


