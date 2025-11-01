CREATE TABLE IF NOT EXISTS `codem_craft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `table` longtext DEFAULT NULL,
  `craftitems` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4;