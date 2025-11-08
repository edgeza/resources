DROP TABLE IF EXISTS `mdt_incidents`;
CREATE TABLE IF NOT EXISTS `mdt_incidents` (
    `id` varchar(50) DEFAULT NULL,
    `citizenid` varchar(50) DEFAULT NULL,
    `addedCitizen` varchar(1000) DEFAULT NULL,
    `name` varchar(50) DEFAULT NULL,
    `description` varchar(500) DEFAULT NULL,
    `image` LONGTEXT DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL,
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_bolos`;
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
    `id` varchar(50) DEFAULT NULL,
    `showId` varchar(50) DEFAULT NULL,
    `citizen` varchar(50) DEFAULT NULL,
    `name_bolo` varchar(250) DEFAULT NULL,
    `name` varchar(250) NOT NULL,
    `plate` varchar(15) DEFAULT NULL,
    `type` varchar(20) DEFAULT NULL,
    `definition_person` LONGTEXT DEFAULT NULL,
    `definition_event` LONGTEXT DEFAULT NULL,
    `definition_car` LONGTEXT DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_commands`;
CREATE TABLE IF NOT EXISTS `mdt_commands` (
    `command_id` varchar(10) NOT NULL,
    `code` TEXT DEFAULT NULL,
    `date` varchar(10) DEFAULT NULL,
    `userImage` varchar(255) DEFAULT NULL,
    `user` varchar(50) DEFAULT NULL,
    `description` longtext DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `mdt_evidences`;
CREATE TABLE IF NOT EXISTS `mdt_evidences` (
    `id` varchar(50) DEFAULT NULL,
    `citizenid` varchar(50) DEFAULT NULL,
    `addedCitizen` varchar(1000) DEFAULT NULL,
    `name` varchar(50) DEFAULT NULL,
    `description` varchar(500) DEFAULT NULL,
    `image` LONGTEXT DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL,
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_fines`;
CREATE TABLE IF NOT EXISTS `mdt_fines` (
    `id` varchar(50) DEFAULT NULL,
    `name` varchar(50) NOT NULL,
    `data` varchar(100) DEFAULT NULL,
    `code` TEXT DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_forms`;
CREATE TABLE IF NOT EXISTS `mdt_forms` (
    `id` varchar(50) DEFAULT NULL,
    `user` varchar(30) DEFAULT NULL,
    `title` varchar(50) DEFAULT NULL,
    `description` varchar(500) DEFAULT NULL,
    `time` varchar(10) NOT NULL,
    `date` varchar(20) DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_mugshot`;
CREATE TABLE IF NOT EXISTS `mdt_mugshot` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `creatorCitizenid` varchar(50) DEFAULT NULL,
    `createdBy` varchar(25) DEFAULT NULL,
    `suspectCitizen` varchar(50) DEFAULT NULL,
    `suspectName` varchar(25) DEFAULT NULL,
    `suspectCrime` varchar(25) DEFAULT NULL,
    `suspectNotes` varchar(500) DEFAULT NULL,
    `image` LONGTEXT DEFAULT NULL,
    `date` varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`creatorCitizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_reports`;
CREATE TABLE IF NOT EXISTS `mdt_reports` (
    `id` varchar(15) DEFAULT NULL,
    `name` varchar(100) NOT NULL,
    `user` varchar(50) DEFAULT NULL,
    `userRank` varchar(50) DEFAULT NULL,
    `citizen` varchar(50) DEFAULT NULL,
    `description` TEXT DEFAULT NULL,
    `locationName` varchar(50) DEFAULT NULL,
    `location` TEXT DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `job` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_settings`;
CREATE TABLE IF NOT EXISTS `mdt_settings` (
    `citizenid` varchar(255) NOT NULL,
    `language` varchar(10) DEFAULT NULL,
    `theme` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_wanted`;
CREATE TABLE IF NOT EXISTS `mdt_wanted` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `image` LONGTEXT NOT NULL DEFAULT '',
    `crimes` varchar(250) NOT NULL DEFAULT '',
    `pastcrimes` varchar(250) NOT NULL DEFAULT '',
    `notes` varchar(500) NOT NULL DEFAULT '',
    `reports` varchar(500) NOT NULL DEFAULT '',
    `wanted` tinyint(1) NOT NULL DEFAULT 0,
    `caught` tinyint(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mdt_vehicles`;
CREATE TABLE IF NOT EXISTS `mdt_vehicles` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `plate` varchar(50) DEFAULT NULL,
    `name` varchar(50) DEFAULT NULL,
    `wanted` varchar(10) DEFAULT NULL,
    `reports` LONGTEXT DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;