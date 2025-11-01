CREATE TABLE `cc_fleecaheist` (
    `bank` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
    `pc1` INT(11) NULL DEFAULT '0',
    `pc2` INT(11) NULL DEFAULT '0',
    `pc3` INT(11) NULL DEFAULT '0',
    `pc4` INT(11) NULL DEFAULT '0',
    `correct` VARCHAR(5) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
    PRIMARY KEY (`bank`) USING BTREE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('delperro', 0, 0, 0, 0, 'pc1');
INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('greatocean', 0, 0, 0, 0, 'pc1');
INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('harmony', 0, 0, 0, 0, 'pc1');
INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('hawick', 0, 0, 0, 0, 'pc1');
INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('legionsquare', 0, 0, 0, 0, 'pc1');
INSERT INTO `cc_fleecaheist` (`bank`, `pc1`, `pc2`, `pc3`, `pc4`, `correct`) VALUES ('pinkcage', 0, 0, 0, 0, 'pc1');
