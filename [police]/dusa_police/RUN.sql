CREATE TABLE IF NOT EXISTS `police_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service` int(11) NOT NULL,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `police_scenes` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE `police_objects` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`model` varchar(50) NOT NULL,
	`x` varchar(50) NOT NULL,
    `y` varchar(50) NOT NULL,
    `z` varchar(50) NOT NULL,
    `rx` varchar(50) NOT NULL,
    `ry` varchar(50) NOT NULL,
    `rz` varchar(50) NOT NULL,
    `heading` int(11) NOT NULL,
    `sceneid` int(11) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE,
    KEY `FK_objects_scene` (`sceneid`) USING BTREE,
	CONSTRAINT `FK_objects_scene` FOREIGN KEY (`sceneid`) REFERENCES `police_scenes` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;