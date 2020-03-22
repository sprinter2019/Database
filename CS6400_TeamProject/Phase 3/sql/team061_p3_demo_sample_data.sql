USE cs6400_fall18_team061;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `admin`.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON `cs6400_fall18_team061`.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

-- Insert Test (seed) Data 

-- Insert into User
-- example of using a 60 char length hashed password 'michael123' = $2y$08$kr5P80A7RyA0FDPUa8cB2eaf0EqbUay0nYspuajgHRRXM9SgzNgZO
-- depends on if you are storing the hash $storedHash or plaintext $storedPassword in login.php
INSERT INTO `User` (email, `PIN`, name) VALUES('john.doe@gatech.edu', '1234', 'John Doe');
INSERT INTO `User` (email, `PIN`, name) VALUES('jane.doe@gatech.edu', '0120', 'Jane Doe');
INSERT INTO `User` (email, `PIN`, name) VALUES('jane.doe1@gatech.edu', '123', 'Jane Doe1');
INSERT INTO `User` (email, `PIN`, name) VALUES('dschrute@dundermifflin.com', '1234', 'Dwight Schrute');
INSERT INTO `User` (email, `PIN`, name) VALUES('gbluth@bluthco.com', '1234', 'George Bluth');
INSERT INTO `User` (email, `PIN`, name) VALUES('jhalpert@dundermifflin.com', '1234', 'Jim Halpert');

-- Insert into Follow
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('john.doe@gatech.edu', 'gbluth@bluthco.com');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('john.doe@gatech.edu', 'jhalpert@dundermifflin.com');

INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jane.doe@gatech.edu', 'jhalpert@dundermifflin.com');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jane.doe@gatech.edu', 'john.doe@gatech.edu');

INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jane.doe1@gatech.edu', 'john.doe@gatech.edu');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jane.doe1@gatech.edu', 'jane.doe@gatech.edu');

INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('dschrute@dundermifflin.com', 'jane.doe@gatech.edu');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('dschrute@dundermifflin.com', 'jane.doe1@gatech.edu');

INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('gbluth@bluthco.com', 'jane.doe1@gatech.edu');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('gbluth@bluthco.com', 'dschrute@dundermifflin.com');

INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jhalpert@dundermifflin.com', 'dschrute@dundermifflin.com');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('jhalpert@dundermifflin.com', 'gbluth@bluthco.com');


-- Insert into Category
INSERT INTO `Category` (`name`) VALUES('Education');
INSERT INTO `Category` (`name`) VALUES('People');
INSERT INTO `Category` (`name`) VALUES('Sports');
INSERT INTO `Category` (`name`) VALUES('Other');
INSERT INTO `Category` (`name`) VALUES('Architecture');
INSERT INTO `Category` (`name`) VALUES('Travel');
INSERT INTO `Category` (`name`) VALUES('Pets');
INSERT INTO `Category` (`name`) VALUES('Food & Drink');
INSERT INTO `Category` (`name`) VALUES('Home & Garden');
INSERT INTO `Category` (`name`) VALUES('Photography');
INSERT INTO `Category` (`name`) VALUES('Technology');
INSERT INTO `Category` (`name`) VALUES('Art');


-- Insert into CorkBoard
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (1, 'dschrute@dundermifflin.com', '2011-12-18 13:17:17', "Georgia Tech", 'Education');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (2, 'dschrute@dundermifflin.com', '2011-12-19 13:17:17', "My Favorite People", 'People');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (3, 'dschrute@dundermifflin.com', '2011-12-20 13:17:17', "Architecture around Campus", 'Architecture');

INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (4, 'john.doe@gatech.edu', '2011-10-18 13:17:17', "Game Day!", 'Sports');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (5, 'jane.doe1@gatech.edu', '2011-12-20 13:17:17', "Food at Georgia Tech", 'Food & Drink');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (6, 'jane.doe@gatech.edu', '2011-11-19 13:17:17', "For Geeks Only", 'Technology');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (7, 'gbluth@bluthco.com', '2011-12-18 13:17:17', "Travel at Georgia Tech", 'Travel');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (8, 'jhalpert@dundermifflin.com', '2012-12-19 13:17:17', "Love My Pets", 'Pets');

-- Insert into PrivateCorkBoard
INSERT INTO `PrivateCorkBoard` (`corkBoardID`, `password`) VALUES (2, '1234');
INSERT INTO `PrivateCorkBoard` (`corkBoardID`, `password`) VALUES (8, '1234');

-- Insert into Watch
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('dschrute@dundermifflin.com', 4);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('dschrute@dundermifflin.com', 6);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('john.doe@gatech.edu', 1);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('john.doe@gatech.edu', 3);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jane.doe@gatech.edu', 5);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jane.doe@gatech.edu', 1);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jane.doe1@gatech.edu', 3);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jane.doe1@gatech.edu', 7);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('gbluth@bluthco.com', 4);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('gbluth@bluthco.com', 6);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jhalpert@dundermifflin.com', 4);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jhalpert@dundermifflin.com', 5);

-- Insert into PushPin
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (1, 1, "https://www.cc.gatech.edu/sites/default/files/images/mercury/oms-cs-web-rotator_2_0_3.jpeg", "OMSCS program logo", '2011-12-18 13:17:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (2, 1, "http://www.buzzcard.gatech.edu/sites/default/files/uploads/images/superblock_images/img_2171.jpg", "student ID for Georgia Tech", '2011-12-18 13:18:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (3, 1, "https://www.news.gatech.edu/sites/default/files/uploads/mercury_images/piazza-icon.png", "logo for Piazza", '2011-12-18 13:19:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (4, 1, "http://www.comm.gatech.edu/sites/default/files/images/brand-graphics/gt-seal.png", "official seal of Georgia Tech", '2011-12-18 13:20:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (5, 2, "http://www.me.gatech.edu/sites/default/files/styles/180_240/public/gpburdell.jpg", "the struggle is real!", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (6, 2, "https://www.cc.gatech.edu/projects/XMLApe/people/imgs/leo.jpg", "Leo Mark, CS 6400 professor", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (7, 2, "https://www.cc.gatech.edu/sites/default/files/images/27126038747_06d417015b_z.jpg", "fearless leader of OMSCS", '2011-12-18 13:23:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (8, 3, "http://daily.gatech.edu/sites/default/files/styles/1170_x_x/public/hgt-tower-crop.jpg", "Tech Tower interior photo", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (9, 3, "http://www.livinghistory.gatech.edu/s/1481/images/content_images/techtower1_636215523842964533.jpg", "Tech Tower exterior photo", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (10, 3, "https://www.ece.gatech.edu/sites/default/files/styles/1500_x_scale/public/images/mercury/kessler2.0442077-p16-49.jpg", "Kessler Campanile at Georgia Tech", '2011-12-18 13:23:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (11, 3, "https://www.scs.gatech.edu/sites/scs.gatech.edu/files/files/klaus-building.jpg", "Klaus building", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (12, 3, "https://www.news.gatech.edu/sites/default/files/styles/740_x_scale/public/uploads/mercury_images/Tech_Tower_WebFeature_1.jpg", "Tech tower sign", '2011-12-18 13:22:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (13, 4, "http://traditions.gatech.edu/images/mantle-reck3.jpg", "Ramblin’ wreck today", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (14, 4, "http://www.swag.gatech.edu/sites/default/files/buzz-android-tablet.jpg", "Driving the mini wreck", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (15, 4, "http://www.livinghistory.gatech.edu/s/1481/images/content_images/ramblinwreck1_636215542678295357.jpg", "Ramblin’ Wreck of the past", '2011-12-18 13:23:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (16, 4, "https://www.news.gatech.edu/sites/default/files/uploads/mercury_images/screen_shot_2016-08-11_at_12.45.48_pm_10.png", "Bobby Dodd stadium", '2011-12-18 13:21:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (17, 5, "http://www.livinghistory.gatech.edu/s/1481/images/content_images/thevarsity1_636215546286483906.jpg", "The Varsity", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (18, 5, "http://blogs.iac.gatech.edu/food14/files/2014/09/wafflefries2.jpg", "Chick-fil-a Waffle Fries", '2011-12-18 13:22:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (19, 6, "http://it.studentlife.gatech.edu/sites/default/files/uploads/images/superblock_images/it_imac.png", "iMac", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (20, 6, "https://pe.gatech.edu/sites/pe.gatech.edu/files/component_assets/Computer_Lab_Tech_750_x_500.jpg", "Computer lab", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (21, 6, "https://www.scs.gatech.edu/sites/scs.gatech.edu/files/files/cs-research-databases.jpg", "Database server", '2011-12-18 13:23:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (22, 7, "https://pbs.twimg.com/media/DZzi7dyU8AAUSJe.jpg", "Georgia Tech Transette", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (23, 7, "https://www.calendar.gatech.edu/sites/default/files/events/related-images/mini_500_0_0.jpg", "Mini 500", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (24, 7, "https://www.gatech.edu/sites/default/files/uploads/images/superblock_images/tech-trolly.png", "Tech Trolley", '2011-12-18 13:23:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (25, 8, "https://hr.gatech.edu/sites/default/files/uploads/images/superblock_images/nee-buzz.jpg", "Buzz", '2011-12-18 13:21:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (26, 8, "https://georgiadogs.com/images/2018/4/6/18_Uga_VIII.jpg", "Uga the \"dog\"", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (27, 8, "https://www.news.gatech.edu/sites/default/files/pictures/feature_images/running%20sideways.jpg", "Sideways the dog", '2011-12-18 13:23:17');

-- Insert into PushPinTag
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (1, "OMSCS");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (2, "buzzcard");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (3, "Piazza");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (4, "Georgia tech seal");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (4, "great seal");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (4, "official");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (5, "burdell");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (5, "george p burdell");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (5, "student");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (6, "database faculty");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (6, "computing");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (6, "gtcomputing");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "zvi");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "dean");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "computer science");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "computing");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "gtcomputing");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (8, "administration");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (8, "facilities");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (9, "administration");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (9, "facilities");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (11, "student facilities");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (11, "computing");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (11, "gtcomputing");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (13, "tohellwithgeorgia");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (13, "decked out");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (13, "parade");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (14, "ramblin wreck");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (14, "buzz");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (14, "mascot");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (14, "parade");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (15, "football game");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (15, "parade");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (16, "football");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (16, "game day");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (16, "tohellwithgeorgia");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (17, "traditions");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (18, "delicious");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (19, "Macintosh");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (19, "computer");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (19, "macOS");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (20, "PCs");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (20, "student facilities");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (20, "gtcomputing");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (21, "computing");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (21, "blades");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (22, "rapid transit");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (22, "historical oddity");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (23, "tricycle");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (23, "race");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (23, "traditions");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (24, "free");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (24, "transit");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (24, "connections");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (25, "mascot");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (26, "tohellwithgeorgia");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (26, "dawgs");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (26, "not our mascot");

INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (27, "mascot");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (27, "traditions");
