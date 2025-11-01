CREATE TABLE IF NOT EXISTS `multijobs` (
  `citizenid` varchar(50) NOT NULL,
  `jobdata` longtext DEFAULT NULL,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
