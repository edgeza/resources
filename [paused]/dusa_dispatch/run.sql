CREATE TABLE IF NOT EXISTS `dispatch_user` (
  `identifier` varchar(50) DEFAULT NULL,
  `callsign` varchar(50) DEFAULT NULL,
  `filters` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `dispatch_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_id` varchar(20) NOT NULL DEFAULT '',
  `unit_name` varchar(50) DEFAULT NULL,
  `drop_id` varchar(20) DEFAULT NULL,
  `max_count` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `dispatch_camera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `camid` varchar(50) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `setting` longtext DEFAULT NULL,
  `coords` longtext DEFAULT NULL,
  `rot` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
