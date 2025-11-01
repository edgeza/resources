-- Drop table if it exists to ensure clean creation
DROP TABLE IF EXISTS `mms_beekeeper`;

-- Create the beekeeper table with correct structure
CREATE TABLE `mms_beekeeper` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`ident` VARCHAR(50) NULL DEFAULT NULL,
	`charident` VARCHAR(50) NULL DEFAULT NULL,
	`coords` LONGTEXT NULL DEFAULT '{"x":0,"y":0,"z":0}',
	`heading` FLOAT NULL DEFAULT 0,
	`data` LONGTEXT NULL DEFAULT '{}',
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
AUTO_INCREMENT=1;
