CREATE TABLE IF NOT EXISTS `dusa_guitarzero` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `personal` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `dusa_guitargroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `leader` varchar(255) DEFAULT NULL,
  `members` longtext DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4;