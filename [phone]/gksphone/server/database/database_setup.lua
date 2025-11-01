local DBTables = {
    ["gksphone_settings"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_settings` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `unique_id` varchar(50) NOT NULL DEFAULT '',
            `identifier` longtext NOT NULL,
            `setup_owner` longtext NOT NULL,
            `model_type` varchar(50) NOT NULL DEFAULT '0',
            `mail_address` longtext NOT NULL,
            `mail_password` longtext NOT NULL,
            `phone_lang` varchar(50) NOT NULL DEFAULT '0',
            `status` tinyint(4) NOT NULL DEFAULT 0,
            `setup_status` tinyint(4) NOT NULL DEFAULT 0,
            `phone_password` varchar(50) NOT NULL DEFAULT '0',
            `look_id` tinyint(4) NOT NULL DEFAULT 0,
            `security_question` VARCHAR(50) NOT NULL DEFAULT '0',
            `security_answer` longtext NOT NULL,
            `phone_settings` longtext NOT NULL,
            `social_accounts` text NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            UNIQUE KEY `unique_id` (`unique_id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_esim"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_esim` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `pin` int(11) NOT NULL DEFAULT 0,
            `operator` varchar(50) NOT NULL DEFAULT '0',
            `package_id` int(11) NOT NULL DEFAULT 0,
            `phone_number` varchar(50) NOT NULL DEFAULT '0',
            `phone_id` varchar(50) NOT NULL DEFAULT '',
            `is_active` tinyint(4) NOT NULL DEFAULT 0,
            `package_sms` int(11) NOT NULL DEFAULT 0,
            `package_call` int(11) NOT NULL DEFAULT 0,
            `package_internet` int(11) NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`),
            UNIQUE KEY `phone_number` (`phone_number`),
            KEY `idx_phone_id` (`phone_id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_advertising"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_advertising` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_number` varchar(50) NOT NULL,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL,
            `firstname` varchar(256) NOT NULL,
            `message` longtext NOT NULL,
            `image` longtext DEFAULT NULL,
            `filter` varchar(255) DEFAULT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_advertising_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_bank_history"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_bank_history` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_number` varchar(50) NOT NULL DEFAULT '',
            `type` int(11) NOT NULL,
            `amount` int(11) NOT NULL DEFAULT 0,
            `description` longtext NOT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_bank_histroy_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_billing"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_billing` (
            `id` int(10) NOT NULL AUTO_INCREMENT,
            `citizenid` varchar(50) NOT NULL,
            `amount` int(11) NOT NULL DEFAULT 0,
            `society` varchar(50) NOT NULL DEFAULT '',
            `societylabel` varchar(50) NOT NULL DEFAULT '',
            `sender` varchar(50) NOT NULL,
            `sendercitizenid` varchar(50) NOT NULL,
            `description` varchar(250) NOT NULL,
            `status` varchar(50) NOT NULL DEFAULT '',
            `bill_holder` varchar(50) NOT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_calls"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_calls` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) NOT NULL DEFAULT '',
            `caller` varchar(50) NOT NULL,
            `receiver` varchar(50) NOT NULL DEFAULT '',
            `type` varchar(50) NOT NULL DEFAULT '',
            `status` int(11) NOT NULL,
            `hidden` int(11) NOT NULL DEFAULT 0,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`),
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_calls_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_contacts"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_contacts` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_number` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
            `number` varchar(30) CHARACTER SET utf8mb4 NOT NULL,
            `display` longtext CHARACTER SET utf8mb4 NOT NULL,
            `options` longtext CHARACTER SET utf8mb4 NOT NULL,
            `block` TINYINT(1) NOT NULL DEFAULT 0,
            `phone_id` varchar(50) NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `gksphone_contacts_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]],
        columns = {
            options = "`options` LONGTEXT NULL DEFAULT NULL",
            block = "`block` TINYINT(1) NOT NULL DEFAULT 0",
        }
    },
    ["gksphone_gallery"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_gallery` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
            `image` longtext NOT NULL,
            `favorite` tinyint(4) NOT NULL DEFAULT 0,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_gallery_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_gameleaderboard"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_gameleaderboard` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `tetris` int(11) NOT NULL DEFAULT 0,
            `snake` int(11) NOT NULL DEFAULT 0,
            `twenty` int(11) NOT NULL DEFAULT 0,
            `phone_id` varchar(500) NOT NULL,
            `name` varchar(500) NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_gameleaderboard_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_gps"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_gps` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `citizenid` longtext NOT NULL,
            `gps_name` longtext NOT NULL,
            `gps_coord` longtext NOT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_gps_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_mails"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_mails` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `citizenid` varchar(255) NOT NULL DEFAULT '0',
            `sender` varchar(255) NOT NULL DEFAULT '0',
            `subject` varchar(255) NOT NULL DEFAULT '0',
            `image` varchar(250) DEFAULT NULL,
            `message` text NOT NULL,
            `button` longtext DEFAULT NULL,
            `read_at` timestamp NULL DEFAULT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_messages"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_messages` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `sender` longtext CHARACTER SET utf8mb4 NOT NULL,
            `receiver` longtext CHARACTER SET utf8mb4 NOT NULL,
            `message` longtext CHARACTER SET utf8mb4 NOT NULL,
            `phone_id` varchar(50) NOT NULL DEFAULT '0',
            `read_at` timestamp NULL DEFAULT NULL,
            `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
            `is_editable` tinyint(1) NOT NULL DEFAULT 0,
            `is_sender` tinyint(1) NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`),
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_messages_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_messages_groups"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_messages_groups` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
            `phone_number` varchar(50) NOT NULL,
            `iscreator` tinyint(4) NOT NULL DEFAULT 0,
            `group_name` longtext NOT NULL,
            `group_about` longtext NOT NULL,
            `group_image` longtext NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`),
            CONSTRAINT `FK_gksphone_messages_group_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_messages_groups_members"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_messages_groups_members` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
            `group_id` int(11) NOT NULL,
            `phone_number` varchar(50) NOT NULL,
            `joined_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`) USING BTREE,
            KEY `group_id` (`group_id`) USING BTREE,
            CONSTRAINT `FK_gksphone_messages_groups_members_gksphone_messages_groups` FOREIGN KEY (`group_id`) REFERENCES `gksphone_messages_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
            CONSTRAINT `gksphone_messages_groups_members_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
        ]]
    },
    ["gksphone_messages_groups_messages"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_messages_groups_messages` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
            `group_id` int(11) NOT NULL,
            `message` text NOT NULL,
            `sender` varchar(50) NOT NULL,
            `sent_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            `read_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`) USING BTREE,
            KEY `group_id` (`group_id`) USING BTREE,
            CONSTRAINT `gksphone_messages_groups_messages_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `gksphone_messages_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
            CONSTRAINT `gksphone_messages_groups_messages_ibfk_2` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
        ]]
    },
    ["gksphone_news"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_news` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `news_text` longtext NOT NULL,
            `news_title` longtext NOT NULL,
            `news_image` longtext DEFAULT NULL,
            `news_video` longtext DEFAULT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;
        ]]
    },
    ["gksphone_notes"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_notes` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
            `title` longtext NOT NULL,
            `image` longtext DEFAULT NULL,
            `note` longtext NOT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE,
            KEY `phone_id` (`phone_id`) USING BTREE,
            CONSTRAINT `gksphone_notes_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
        ]]
    },
    ["gksphone_stockmarket"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_stockmarket` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `phone_id` varchar(50) CHARACTER SET utf8 NOT NULL,
            `stock_market` longtext NOT NULL,
            `stock_histroy` longtext NOT NULL,
            PRIMARY KEY (`id`) USING BTREE,
            UNIQUE KEY `phone_id` (`phone_id`),
            CONSTRAINT `gksphone_stockmarket_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
        ]]
    },
    ["gksphone_twt_users"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_users` (
            `user_id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` longtext NOT NULL,
            `username` varchar(255) NOT NULL,
            `password` varchar(255) NOT NULL,
            `displayname` varchar(255) NOT NULL,
            `avatar` varchar(255) DEFAULT NULL,
            `banner` varchar(255) DEFAULT NULL,
            `is_verified` int(11) NOT NULL DEFAULT 0,
            `verifedbuytime` timestamp NULL DEFAULT current_timestamp(),
            `banned` int(11) NOT NULL DEFAULT 0,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`user_id`) USING BTREE,
            UNIQUE KEY `unique_username` (`username`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_twt_posts"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_posts` (
            `post_id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` longtext NOT NULL,
            `user_id` int(11) DEFAULT NULL,
            `content` longtext CHARACTER SET utf8mb4 NOT NULL,
            `media` longtext DEFAULT NULL,
            `poll_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
            `end_date` timestamp NULL DEFAULT NULL,
            `comment` int(11) NOT NULL DEFAULT 0,
            `commentid` int(11) NOT NULL DEFAULT 0,
            `pinned` int(11) NOT NULL DEFAULT 0,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`post_id`) USING BTREE,
            KEY `user_id` (`user_id`) USING BTREE,
            CONSTRAINT `gksphone_twt_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `gksphone_twt_users` (`user_id`) ON DELETE CASCADE,
            CONSTRAINT `poll_options` CHECK (json_valid(`poll_options`))
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_twt_followers"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_followers` (
            `follow_id` int(11) NOT NULL AUTO_INCREMENT,
            `userid` int(11) NOT NULL,
            `followid` int(11) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`follow_id`) USING BTREE,
            KEY `userid` (`userid`) USING BTREE,
            KEY `FK_gksphone_twt_follower_gksphone_twt_users` (`followid`) USING BTREE,
            CONSTRAINT `FK_gksphone_twt_follower_gksphone_twt_users` FOREIGN KEY (`followid`) REFERENCES `gksphone_twt_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
            CONSTRAINT `FK_gksphone_twt_followers_gksphone_twt_users` FOREIGN KEY (`userid`) REFERENCES `gksphone_twt_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_twt_hastags"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_hastags` (
            `hastag_id` int(11) NOT NULL AUTO_INCREMENT,
            `hastag` varchar(250) NOT NULL DEFAULT '',
            `postid` int(11) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`hastag_id`) USING BTREE,
            KEY `postid` (`postid`) USING BTREE,
            CONSTRAINT `FK_gksphone_twt_hastags_gksphone_twt_posts` FOREIGN KEY (`postid`) REFERENCES `gksphone_twt_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_twt_likepost"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_likepost` (
            `like_id` int(11) NOT NULL AUTO_INCREMENT,
            `postid` int(11) NOT NULL,
            `userid` int(11) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`like_id`) USING BTREE,
            KEY `userid` (`userid`) USING BTREE,
            KEY `postid` (`postid`) USING BTREE,
            CONSTRAINT `FK_gksphone_twt_likepost_gksphone_twt_posts` FOREIGN KEY (`postid`) REFERENCES `gksphone_twt_posts` (`post_id`) ON DELETE CASCADE,
            CONSTRAINT `FK_gksphone_twt_likepost_gksphone_twt_users` FOREIGN KEY (`userid`) REFERENCES `gksphone_twt_users` (`user_id`) ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_twt_retweet"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_twt_retweet` (
            `retwettsid` int(11) NOT NULL AUTO_INCREMENT,
            `postid` int(11) NOT NULL,
            `userid` int(11) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`retwettsid`) USING BTREE,
            KEY `userid` (`userid`) USING BTREE,
            KEY `postid` (`postid`) USING BTREE,
            CONSTRAINT `FK_gksphone_twt_retweet_gksphone_twt_posts` FOREIGN KEY (`postid`) REFERENCES `gksphone_twt_posts` (`post_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
            CONSTRAINT `FK_gksphone_twt_retweet_gksphone_twt_users` FOREIGN KEY (`userid`) REFERENCES `gksphone_twt_users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_vehicle_sales"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_vehicle_sales` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `identifier` longtext NOT NULL,
            `player_name` varchar(50) NOT NULL,
            `phone_number` varchar(255) NOT NULL,
            `plate` varchar(255) NOT NULL,
            `model` varchar(255) NOT NULL,
            `price` int(11) NOT NULL,
            `image` longtext NOT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_wanted"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_wanted` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `citizenid` varchar(50) NOT NULL,
            `fullname` varchar(50) NOT NULL,
            `reason` varchar(250) DEFAULT NULL,
            `appearance` varchar(250) DEFAULT NULL,
            `lastseen` varchar(250) DEFAULT NULL,
            `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
            PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_music"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_music` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `playlist_name` LONGTEXT NOT NULL,
                `playlist_img` LONGTEXT NOT NULL,
                `details` LONGTEXT NOT NULL,
                `phone_id` VARCHAR(50) NOT NULL,
                PRIMARY KEY (`id`) USING BTREE,
                INDEX `FK_gksphone_music_gksphone_esim` (`phone_id`) USING BTREE,
                CONSTRAINT `FK_gksphone_music_gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON UPDATE CASCADE ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_music_like"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_music_like` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `phone_id` VARCHAR(50) NOT NULL,
                `songid` VARCHAR(50) NOT NULL,
                `title` VARCHAR(250) NOT NULL,
                `artist` VARCHAR(250) NOT NULL,
                `img` LONGTEXT NOT NULL,
                `seconds` INT(11) NOT NULL DEFAULT '0',
                PRIMARY KEY (`id`) USING BTREE,
                INDEX `FK__gksphone_esim` (`phone_id`) USING BTREE,
                CONSTRAINT `FK__gksphone_esim` FOREIGN KEY (`phone_id`) REFERENCES `gksphone_esim` (`phone_id`) ON UPDATE CASCADE ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;
        ]]
    },
    ["gksphone_flare_users"] = {
        create = [[
            CREATE TABLE `gksphone_flare_users` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `phone_id` VARCHAR(100) NULL DEFAULT NULL,
                `name` VARCHAR(100) NULL DEFAULT NULL,
                `about` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `birthday` VARCHAR(50) NULL DEFAULT NULL,
                `gender` ENUM('woman','man') NULL DEFAULT NULL,
                `interested` ENUM('women','men','everyone') NULL DEFAULT NULL,
                `images` LONGTEXT NULL DEFAULT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`id`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_flare_swipes"] = {
        create = [[
            CREATE TABLE `gksphone_flare_swipes` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `swiper_id` INT(11) NULL DEFAULT NULL,
                `target_id` INT(11) NULL DEFAULT NULL,
                `swipe_type` ENUM('like','pass','undo') NULL DEFAULT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`id`) USING BTREE,
                INDEX `FK_gksphone_flare_swipes_gksphone_flare_users` (`swiper_id`) USING BTREE,
                INDEX `FK_gksphone_flare_swipes_gksphone_flare_users_2` (`target_id`) USING BTREE,
                CONSTRAINT `FK_gksphone_flare_swipes_gksphone_flare_users` FOREIGN KEY (`swiper_id`) REFERENCES `gksphone_flare_users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE,
                CONSTRAINT `FK_gksphone_flare_swipes_gksphone_flare_users_2` FOREIGN KEY (`target_id`) REFERENCES `gksphone_flare_users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_flare_matches"] = {
        create = [[
            CREATE TABLE `gksphone_flare_matches` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `user1_id` INT(11) NULL DEFAULT NULL,
                `user2_id` INT(11) NULL DEFAULT NULL,
                `matched_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`id`) USING BTREE,
                UNIQUE INDEX `user1_id` (`user1_id`, `user2_id`) USING BTREE,
                INDEX `user2_id` (`user2_id`) USING BTREE,
                CONSTRAINT `gksphone_flare_matches_ibfk_1` FOREIGN KEY (`user1_id`) REFERENCES `gksphone_flare_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_flare_matches_ibfk_2` FOREIGN KEY (`user2_id`) REFERENCES `gksphone_flare_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_flare_messages"] = {
        create = [[
            CREATE TABLE `gksphone_flare_messages` (
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `match_id` INT(11) NULL DEFAULT NULL,
                `sender_id` INT(11) NULL DEFAULT NULL,
                `message` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `read_at` TINYINT(4) NOT NULL DEFAULT '0',
                `sent_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`id`) USING BTREE,
                INDEX `match_id` (`match_id`) USING BTREE,
                INDEX `sender_id` (`sender_id`) USING BTREE,
                CONSTRAINT `gksphone_flare_messages_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `gksphone_flare_matches` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_flare_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `gksphone_flare_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_users"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_users` (
                `user_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `identifier` MEDIUMTEXT NOT NULL,
                `username` VARCHAR(30) NOT NULL,
                `password` VARCHAR(255) NOT NULL,
                `full_name` VARCHAR(100) NULL DEFAULT NULL,
                `bio` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `profile_picture_url` VARCHAR(500) NULL DEFAULT NULL,
                `is_verified` TINYINT(1) NULL DEFAULT '0',
                `is_private` TINYINT(1) NULL DEFAULT '0',
                `is_active` TINYINT(1) NULL DEFAULT '1',
                `followers_count` INT(11) NULL DEFAULT '0',
                `following_count` INT(11) NULL DEFAULT '0',
                `posts_count` INT(11) NULL DEFAULT '0',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                PRIMARY KEY (`user_id`) USING BTREE,
                UNIQUE INDEX `username` (`username`) USING BTREE,
                INDEX `idx_username` (`username`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_is_active` (`is_active`) USING BTREE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_stories"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_stories` (
                `story_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `user_id` BIGINT(20) NOT NULL,
                `media_url` VARCHAR(500) NOT NULL,
                `media_type` ENUM('image','video') NOT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `expires_at` DATETIME NOT NULL,
                PRIMARY KEY (`story_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_expires_at` (`expires_at`) USING BTREE,
                INDEX `idx_user_created` (`user_id`, `created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_stories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB;
        ]]
    },
    ["gksphone_instagram_posts"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_posts` (
                `post_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `user_id` BIGINT(20) NOT NULL,
                `caption` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `location` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `media` LONGTEXT NULL DEFAULT NULL,
                `likes_count` INT(11) NULL DEFAULT '0',
                `comments_count` INT(11) NULL DEFAULT '0',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`post_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_user_created` (`user_id`, `created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_post_likes"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_post_likes` (
                `like_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `post_id` BIGINT(20) NOT NULL,
                `user_id` BIGINT(20) NOT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`like_id`) USING BTREE,
                UNIQUE INDEX `unique_post_like` (`post_id`, `user_id`) USING BTREE,
                INDEX `idx_post_id` (`post_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_post_likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `gksphone_instagram_posts` (`post_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_post_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_follows"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_follows` (
                `follow_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `follower_id` BIGINT(20) NOT NULL,
                `following_id` BIGINT(20) NOT NULL,
                `is_accepted` TINYINT(1) NULL DEFAULT '1',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `requested_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `accepted_at` TIMESTAMP NULL DEFAULT NULL,
                PRIMARY KEY (`follow_id`) USING BTREE,
                UNIQUE INDEX `unique_follow` (`follower_id`, `following_id`) USING BTREE,
                INDEX `idx_follower_id` (`follower_id`) USING BTREE,
                INDEX `idx_following_id` (`following_id`) USING BTREE,
                INDEX `idx_is_accepted` (`is_accepted`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_follows_status` (`is_accepted`, `created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_follows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_follows_ibfk_2` FOREIGN KEY (`following_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `CONSTRAINT_1` CHECK (`follower_id` <> `following_id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_comments"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_comments` (
                `comment_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `post_id` BIGINT(20) NOT NULL,
                `user_id` BIGINT(20) NOT NULL,
                `parent_comment_id` BIGINT(20) NULL DEFAULT NULL,
                `comment_text` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
                `likes_count` INT(11) NULL DEFAULT '0',
                `replies_count` INT(11) NULL DEFAULT '0',
                `is_pinned` TINYINT(1) NULL DEFAULT '0',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                PRIMARY KEY (`comment_id`) USING BTREE,
                INDEX `idx_post_id` (`post_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                INDEX `idx_parent_comment` (`parent_comment_id`) USING BTREE,
                INDEX `idx_post_created` (`post_id`, `created_at`) USING BTREE,
                INDEX `idx_is_pinned` (`is_pinned`) USING BTREE,
                INDEX `idx_comments_parent_created` (`parent_comment_id`, `created_at`) USING BTREE,
                INDEX `idx_comments_post_parent` (`post_id`, `parent_comment_id`) USING BTREE,
                INDEX `idx_comments_parent_id` (`parent_comment_id`) USING BTREE,
                INDEX `idx_comments_replies_count` (`replies_count`) USING BTREE,
                CONSTRAINT `gksphone_instagram_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `gksphone_instagram_posts` (`post_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_comments_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `gksphone_instagram_comments` (`comment_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_comment_likes"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_comment_likes` (
                `like_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `comment_id` BIGINT(20) NOT NULL,
                `user_id` BIGINT(20) NOT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`like_id`) USING BTREE,
                UNIQUE INDEX `unique_comment_like` (`comment_id`, `user_id`) USING BTREE,
                INDEX `idx_comment_id` (`comment_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                CONSTRAINT `gksphone_instagram_comment_likes_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `gksphone_instagram_comments` (`comment_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_comment_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_conversations"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_conversations` (
                `conversation_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `conversation_type` ENUM('direct') NULL DEFAULT 'direct',
                `created_by` BIGINT(20) NULL DEFAULT NULL,
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                PRIMARY KEY (`conversation_id`) USING BTREE,
                INDEX `idx_created_by` (`created_by`) USING BTREE,
                INDEX `idx_updated_at` (`updated_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_conversations_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_conversation_participants"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_conversation_participants` (
                `participant_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `conversation_id` BIGINT(20) NOT NULL,
                `user_id` BIGINT(20) NOT NULL,
                `joined_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `messages_deleted_at` TIMESTAMP NULL DEFAULT NULL,
                PRIMARY KEY (`participant_id`) USING BTREE,
                UNIQUE INDEX `unique_participant` (`conversation_id`, `user_id`) USING BTREE,
                INDEX `idx_conversation_id` (`conversation_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                CONSTRAINT `gksphone_instagram_conversation_participants_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `gksphone_instagram_conversations` (`conversation_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_conversation_participants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_messages"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_messages` (
                `message_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `conversation_id` BIGINT(20) NOT NULL,
                `sender_id` BIGINT(20) NOT NULL,
                `message_text` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
                `message_type` ENUM('text','image','video','audio','post_share','profile_share') NULL DEFAULT 'text',
                `is_read` TINYINT(1) NULL DEFAULT '0',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                `updated_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                PRIMARY KEY (`message_id`) USING BTREE,
                INDEX `idx_conversation_id` (`conversation_id`) USING BTREE,
                INDEX `idx_sender_id` (`sender_id`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_conversation_created` (`conversation_id`, `created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `gksphone_instagram_conversations` (`conversation_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_notifications"] = {
        create = [[
            CREATE TABLE `gksphone_instagram_notifications` (
                `notification_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
                `user_id` BIGINT(20) NOT NULL,
                `actor_id` BIGINT(20) NOT NULL,
                `notification_type` ENUM('like','comment','follow','mention','post_tag') NOT NULL,
                `post_id` BIGINT(20) NULL DEFAULT NULL,
                `comment_id` BIGINT(20) NULL DEFAULT NULL,
                `is_read` TINYINT(1) NULL DEFAULT '0',
                `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
                PRIMARY KEY (`notification_id`) USING BTREE,
                INDEX `post_id` (`post_id`) USING BTREE,
                INDEX `comment_id` (`comment_id`) USING BTREE,
                INDEX `idx_user_id` (`user_id`) USING BTREE,
                INDEX `idx_actor_id` (`actor_id`) USING BTREE,
                INDEX `idx_created_at` (`created_at`) USING BTREE,
                INDEX `idx_is_read` (`is_read`) USING BTREE,
                INDEX `idx_user_unread` (`user_id`, `is_read`, `created_at`) USING BTREE,
                CONSTRAINT `gksphone_instagram_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_notifications_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `gksphone_instagram_users` (`user_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_notifications_ibfk_3` FOREIGN KEY (`post_id`) REFERENCES `gksphone_instagram_posts` (`post_id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_instagram_notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `gksphone_instagram_comments` (`comment_id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=0;
        ]]
    },
    ["gksphone_instagram_active_stories_v2"] = {
        create = [[
            CREATE VIEW `gksphone_instagram_active_stories_v2` AS SELECT 
                s.story_id,
                s.user_id,
                s.media_url,
                s.media_type,
                s.created_at,
                s.expires_at,
                u.username,
                u.profile_picture_url,
                u.is_verified,
                TIMESTAMPDIFF(HOUR, s.created_at, NOW()) as hours_ago,
                TIMESTAMPDIFF(MINUTE, s.created_at, NOW()) as minutes_ago
            FROM  gksphone_instagram_stories s
            JOIN  gksphone_instagram_users u ON s.user_id = u.user_id
            WHERE s.expires_at > NOW() 
            AND u.is_active = TRUE
            ORDER BY s.created_at ASC;
        ]]
    },
    ["gksphone_instagram_conversations_v1"] = {
        create = [[
            CREATE VIEW `gksphone_instagram_conversations_v1` AS SELECT 
                c.conversation_id,
                c.created_by,
                c.updated_at,
                cp.user_id as participant_id,
                u2.user_id as other_user_id,
                u2.username as other_username,
                u2.profile_picture_url as other_profile_picture,
                u2.is_verified as other_is_verified,
                m.message_text as last_message,
                m.message_type as last_message_type,
                m.created_at as last_message_time,
                m.sender_id as last_message_sender_id,
                u3.username as last_message_sender_username,
                COUNT(CASE WHEN m2.is_read = FALSE AND m2.sender_id != cp.user_id THEN 1 END) as unread_count
            FROM gksphone_instagram_conversations c
            JOIN gksphone_instagram_conversation_participants cp ON c.conversation_id = cp.conversation_id
            LEFT JOIN gksphone_instagram_conversation_participants cp2 ON c.conversation_id = cp2.conversation_id AND cp2.user_id != cp.user_id
            LEFT JOIN gksphone_instagram_users u2 ON cp2.user_id = u2.user_id
            LEFT JOIN gksphone_instagram_messages m ON c.conversation_id = m.conversation_id AND m.message_id = (
                SELECT MAX(message_id) FROM gksphone_instagram_messages WHERE conversation_id = c.conversation_id
            )
            LEFT JOIN gksphone_instagram_users u3 ON m.sender_id = u3.user_id
            LEFT JOIN gksphone_instagram_messages m2 ON c.conversation_id = m2.conversation_id
            WHERE cp.user_id IS NOT NULL
            AND u2.user_id IS NOT NULL
            GROUP BY c.conversation_id, cp.user_id, u2.user_id, m.message_id;
        ]]
    },
    ["gksphone_darkchat_users"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_darkchat_users` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `identifier` VARCHAR(255) NOT NULL, 
                `username` varchar(50) NOT NULL,
                `password` varchar(255) NOT NULL, 
                `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                `is_active` tinyint(1) DEFAULT 1,
                PRIMARY KEY (`id`) USING BTREE,
                UNIQUE INDEX `username` (`username`) USING BTREE,
                INDEX `idx_users_search` (`username`, `is_active`) USING BTREE
            ) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
        ]]
    },
    ["gksphone_darkchat_rooms"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_darkchat_rooms` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `owner_id` int(11) NOT NULL,
                `room_name` varchar(100) NOT NULL,
                `room_image` text DEFAULT NULL, 
                `is_password_protected` tinyint(1) DEFAULT 0,
                `password` varchar(255) DEFAULT NULL,
                `is_private` tinyint(1) DEFAULT 0,
                `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                `is_active` tinyint(1) DEFAULT 1,
                PRIMARY KEY (`id`) USING BTREE,
                UNIQUE INDEX `room_name` (`room_name`) USING BTREE,
                INDEX `idx_owner` (`owner_id`) USING BTREE,
                INDEX `idx_private` (`is_private`) USING BTREE,
                INDEX `idx_rooms_search` (`room_name`, `is_private`, `is_active`) USING BTREE,
                CONSTRAINT `gksphone_darkchat_rooms_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `gksphone_darkchat_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
        ]]
    },
    ["gksphone_darkchat_room_members"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_darkchat_room_members` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `room_id` int(11) NOT NULL,
                `user_id` int(11) NOT NULL,
                `joined_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                `role` enum('owner','member') DEFAULT 'member',
                `is_muted` tinyint(1) DEFAULT 0,
                PRIMARY KEY (`id`) USING BTREE,
                UNIQUE INDEX `unique_member` (`room_id`, `user_id`) USING BTREE,
                INDEX `idx_room_members` (`room_id`) USING BTREE,
                INDEX `idx_user_rooms` (`user_id`) USING BTREE,
                CONSTRAINT `gksphone_darkchat_room_members_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `gksphone_darkchat_rooms` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_darkchat_room_members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gksphone_darkchat_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
        ]]
    },
    ["gksphone_darkchat_messages"] = {
        create = [[
            CREATE TABLE IF NOT EXISTS `gksphone_darkchat_messages` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `room_id` int(11) NOT NULL,
                `sender_id` int(11) NOT NULL,
                `message` text NOT NULL,
                `message_type` enum('text','image','video','location') DEFAULT 'text',
                `attachment_data` longtext DEFAULT NULL,
                `sent_at` timestamp DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY (`id`) USING BTREE,
                INDEX `idx_room_messages` (`room_id`, `sent_at`) USING BTREE,
                INDEX `idx_sender` (`sender_id`) USING BTREE,
                INDEX `idx_messages_recent` (`room_id`, `sent_at`) USING BTREE,
                CONSTRAINT `gksphone_darkchat_messages_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `gksphone_darkchat_rooms` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
                CONSTRAINT `gksphone_darkchat_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `gksphone_darkchat_users` (`id`) ON UPDATE RESTRICT ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        ]]
    }
}

local DBTriggers = {
    ["gksphone_instagram_create_comment_notification"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_create_comment_notification` AFTER INSERT ON `gksphone_instagram_comments` FOR EACH ROW BEGIN
                DECLARE post_owner_id BIGINT;
                SELECT user_id INTO post_owner_id FROM gksphone_instagram_posts WHERE post_id = NEW.post_id;
                IF post_owner_id != NEW.user_id THEN
                    INSERT INTO gksphone_instagram_notifications (user_id, actor_id, notification_type, post_id, comment_id)
                    VALUES (post_owner_id, NEW.user_id, 'comment', NEW.post_id, NEW.comment_id);
                END IF;
            END;
        ]]
    },
    ["gksphone_instagram_create_like_notification"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_create_like_notification` AFTER INSERT ON `gksphone_instagram_post_likes` FOR EACH ROW BEGIN
                DECLARE post_owner_id BIGINT;
                SELECT user_id INTO post_owner_id FROM gksphone_instagram_posts WHERE post_id = NEW.post_id;

                IF post_owner_id != NEW.user_id THEN
                    INSERT INTO gksphone_instagram_notifications (user_id, actor_id, notification_type, post_id)
                    VALUES (NEW.user_id, post_owner_id, 'like', NEW.post_id);
                END IF;
            END;
        ]]
    },
    ["gksphone_instagram_update_comment_count"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_comment_count` AFTER INSERT ON `gksphone_instagram_comments` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_posts SET comments_count = comments_count + 1 WHERE post_id = NEW.post_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_comment_count_delete"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_comment_count_delete` AFTER DELETE ON `gksphone_instagram_comments` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_posts SET comments_count = comments_count - 1 WHERE post_id = OLD.post_id;
            END
        ]]
    },
    ["gksphone_instagram_update_comment_likes_count"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_comment_likes_count` AFTER INSERT ON `gksphone_instagram_comment_likes` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_comments SET likes_count = likes_count + 1 WHERE comment_id = NEW.comment_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_comment_likes_count_delete"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_comment_likes_count_delete` AFTER DELETE ON `gksphone_instagram_comment_likes` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_comments SET likes_count = likes_count - 1 WHERE comment_id = OLD.comment_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_follow_counts"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_follow_counts` AFTER INSERT ON `gksphone_instagram_follows` FOR EACH ROW BEGIN
                IF NEW.is_accepted = TRUE THEN
                    UPDATE gksphone_instagram_users SET followers_count = followers_count + 1 WHERE user_id = NEW.following_id;
                    UPDATE gksphone_instagram_users SET following_count = following_count + 1 WHERE user_id = NEW.follower_id;
                    INSERT INTO gksphone_instagram_notifications (user_id, actor_id, notification_type) VALUES (NEW.follower_id, NEW.following_id, 'follow');
                END IF;
            END;
        ]]
    },
    ["gksphone_instagram_update_follow_counts_delete"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_follow_counts_delete` AFTER DELETE ON `gksphone_instagram_follows` FOR EACH ROW BEGIN
                IF OLD.is_accepted = TRUE THEN
                    UPDATE gksphone_instagram_users SET followers_count = followers_count - 1 WHERE user_id = OLD.following_id;
                    UPDATE gksphone_instagram_users SET following_count = following_count - 1 WHERE user_id = OLD.follower_id;
                END IF;
            END;
        ]]
    },
    ["gksphone_instagram_update_follow_counts_update"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_follow_counts_update` AFTER UPDATE ON `gksphone_instagram_follows` FOR EACH ROW BEGIN
                IF NEW.is_accepted = TRUE THEN
                    UPDATE gksphone_instagram_users SET followers_count = followers_count + 1 WHERE user_id = NEW.following_id;
                    UPDATE gksphone_instagram_users SET following_count = following_count + 1 WHERE user_id = NEW.follower_id;
                    INSERT INTO gksphone_instagram_notifications (user_id, actor_id, notification_type) VALUES (NEW.follower_id, NEW.following_id, 'follow');
                END IF;
            END;
        ]]
    },
    ["gksphone_instagram_update_posts_count"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_posts_count` AFTER INSERT ON `gksphone_instagram_posts` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_users SET posts_count = posts_count + 1 WHERE user_id = NEW.user_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_posts_count_delete"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_posts_count_delete` AFTER DELETE ON `gksphone_instagram_posts` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_users SET posts_count = posts_count - 1 WHERE user_id = OLD.user_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_post_likes_count"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_post_likes_count` AFTER INSERT ON `gksphone_instagram_post_likes` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_posts SET likes_count = likes_count + 1 WHERE post_id = NEW.post_id;
            END;
        ]]
    },
    ["gksphone_instagram_update_post_likes_count_delete"] = {
        create = [[
            CREATE TRIGGER `gksphone_instagram_update_post_likes_count_delete` AFTER DELETE ON `gksphone_instagram_post_likes` FOR EACH ROW BEGIN
                UPDATE gksphone_instagram_posts SET likes_count = likes_count - 1 WHERE post_id = OLD.post_id;
            END;
        ]]
    }
}

function GetDefaultDatabaseTables()
    return DBTables, DBTriggers
end