CREATE TABLE IF NOT EXISTS `hud_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `stress` int(3) DEFAULT NULL,
  `playlist` text DEFAULT NULL,
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;