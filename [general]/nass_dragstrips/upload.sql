
CREATE TABLE IF NOT EXISTS `nass_dragstrips_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DELETE FROM `nass_dragstrips_data`;
INSERT INTO `nass_dragstrips_data` (`id`, `data`) VALUES
	(1, '{"blipData":{"shortRange":true,"enabled":true,"scale":0.65,"sprite":309,"color":0},"name":"Sandy Shores","startPositions":[{"w":103.60369873046877,"z":40.18209457397461,"y":3248.548095703125,"x":1719.6097412109376},{"w":104.264404296875,"z":40.18209457397461,"y":3260.0107421875,"x":1715.69580078125}],"distance":1320,"maxTime":30,"dragtreeType":"nass_dragtree_pro","timingBoard":{"w":76.06320190429688,"z":40.14923858642578,"y":3265.572998046875,"x":1701.8902587890626},"dragTree":{"x":1696.71923828125,"y":3248.78076171875,"z":40.17494583129883,"w":104.62474822998047}}');

