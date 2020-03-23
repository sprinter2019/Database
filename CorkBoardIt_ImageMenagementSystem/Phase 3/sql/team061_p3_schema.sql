-- CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
CREATE USER IF NOT EXISTS admin@localhost IDENTIFIED BY 'admin';

DROP DATABASE IF EXISTS `cs6400_fall18_team061`; 
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS cs6400_fall18_team061 
    DEFAULT CHARACTER SET utf8mb4 
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE cs6400_fall18_team061;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `admin`.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `cs6400_fall18_team061`.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;


-- Tables 
CREATE TABLE `User` (
	`email` varchar(100) NOT NULL,
	`PIN` varchar(4) NOT NULL,
	`name` varchar(100) NOT NULL,
	PRIMARY KEY (`email`)
);

CREATE TABLE `Follow` (
	`follower_email` varchar(100) NOT NULL,
	`followee_email` varchar(100) NOT NULL,
	PRIMARY KEY (`follower_email`, `followee_email`),
	FOREIGN KEY (`follower_email`) REFERENCES `User` (`email`),
	FOREIGN KEY (`followee_email`) REFERENCES `User` (`email`)
);

CREATE TABLE `Category` (
	`name` varchar(50) NOT NULL,
	PRIMARY KEY (`name`)
);

CREATE TABLE `CorkBoard` (
	`corkBoardID` int(16) unsigned NOT NULL AUTO_INCREMENT,
	`owner` varchar(100) NOT NULL,
	`date_updated` datetime NOT NULL,
	`title` varchar(50) NOT NULL,
	`category_name` varchar(50) NOT NULL,
	PRIMARY KEY (`corkBoardID`),
	UNIQUE (`owner`, `title`),
	FOREIGN KEY (`owner`) REFERENCES `User` (`email`),
	FOREIGN KEY (`category_name`) REFERENCES `Category` (`name`)
);

CREATE TABLE `PrivateCorkBoard` (
	`corkBoardID` int(16) unsigned NOT NULL,
	`password` varchar(60) NOT NULL,
	PRIMARY KEY (`corkBoardID`),
	FOREIGN KEY (`corkBoardID`) REFERENCES `CorkBoard` (`corkBoardID`)
);

CREATE TABLE `Watch` (
	`email` varchar(100) NOT NULL,
	`cork_board_id` int(16) unsigned NOT NULL,
	PRIMARY KEY (`email`, `cork_board_id`),
	FOREIGN KEY (`email`) REFERENCES `User` (`email`),
	FOREIGN KEY (`cork_board_id`) REFERENCES `CorkBoard` (`corkBoardID`)
);

CREATE TABLE `PushPin` (
	`pushPinID` int(16) unsigned NOT NULL AUTO_INCREMENT,
	`cork_board_id` int(16) unsigned NOT NULL,
	`URL` varchar(200) NOT NULL,
	`description` varchar(200) NOT NULL,
	`date_pinned` datetime NOT NULL,
	PRIMARY KEY (`pushPinID`),
	UNIQUE (`cork_board_id`, `URL`),
	FOREIGN KEY (`cork_board_id`) REFERENCES `CorkBoard` (`corkBoardID`)
);

CREATE TABLE `PushPinTag` (
	`pushpin_id` int(16) unsigned NOT NULL,
	`tag` varchar(20) NOT NULL,
	PRIMARY KEY (`pushpin_id`, `tag`),
	FOREIGN KEY (`pushpin_id`) REFERENCES `PushPin` (`pushPinID`)
);

CREATE TABLE `Like` (
	`email` varchar(100) NOT NULL,
	`pushpin_id` int(16) unsigned NOT NULL,
	PRIMARY KEY (`email`, `pushpin_id`),
	FOREIGN KEY (`email`) REFERENCES `User` (`email`),
	FOREIGN KEY (`pushpin_id`) REFERENCES `PushPin` (`pushPinID`)
);

CREATE TABLE `Comment` (
	`email` varchar(100) NOT NULL,
	`pushpin_id` int(16) unsigned NOT NULL,
	`date_time` datetime NOT NULL,
	`text` varchar(200) NOT NULL,
	PRIMARY KEY (`email`, `pushpin_id`, `date_time`),
	FOREIGN KEY (`email`) REFERENCES `User` (`email`),
	FOREIGN KEY (`pushpin_id`) REFERENCES `PushPin` (`pushPinID`)
);
