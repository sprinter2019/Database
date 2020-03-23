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
INSERT INTO `User` (email, `PIN`, name) VALUES('jane.doe2@gatech.edu', '123a', 'Jane Doe2');
INSERT INTO `User` (email, `PIN`, name) VALUES('jane.doe3@gatech.edu', 'a1b4', 'Jane Doe3');
INSERT INTO `User` (email, `PIN`, name) VALUES('dschrute@dundermifflin.com', '1234', 'Dwight Schrute');
INSERT INTO `User` (email, `PIN`, name) VALUES('gbluth@bluthco.com', '1234', 'George Bluth');
INSERT INTO `User` (email, `PIN`, name) VALUES('jhalpert@dundermifflin.com', '1234', 'Jim Halpert');

-- Insert into Follow
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('dschrute@dundermifflin.com', 'jhalpert@dundermifflin.com');
INSERT INTO `Follow` (`follower_email`, `followee_email`) VALUES('dschrute@dundermifflin.com', 'gbluth@bluthco.com');
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
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (1, 'dschrute@dundermifflin.com', '2011-12-18 13:17:17', "Dwight's 1st corkBoard", 'People');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (2, 'dschrute@dundermifflin.com', '2011-12-19 13:17:17', "Dwight's 2nd corkBoard", 'Pets');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (3, 'dschrute@dundermifflin.com', '2011-12-20 13:17:17', "Dwight's 3rd corkBoard", 'Sports');

INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (4, 'gbluth@bluthco.com', '2011-10-18 13:17:17', "George's 1st corkBoard", 'Food & Drink');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (5, 'gbluth@bluthco.com', '2011-11-19 13:17:17', "George's 2nd corkBoard", 'Art');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (6, 'gbluth@bluthco.com', '2011-12-20 13:17:17', "George's 3rd corkBoard", 'Architecture');

INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (7, 'jhalpert@dundermifflin.com', '2011-12-18 13:17:17', "Jim's 1st corkBoard", 'Home & Garden');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (8, 'jhalpert@dundermifflin.com', '2012-12-19 13:17:17', "Jim's 2nd corkBoard", 'Technology');
INSERT INTO `CorkBoard` (`corkBoardID`,	`owner`, `date_updated`, `title`, `category_name`) VALUES (9, 'jhalpert@dundermifflin.com', '2013-12-20 13:17:17', "Jim's 3rd corkBoard", 'Travel');


-- Insert into PrivateCorkBoard
INSERT INTO `PrivateCorkBoard` (`corkBoardID`, `password`) VALUES (1, '1234');
INSERT INTO `PrivateCorkBoard` (`corkBoardID`, `password`) VALUES (4, '1234');
INSERT INTO `PrivateCorkBoard` (`corkBoardID`, `password`) VALUES (7, '1234');

-- Insert into Watch
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('dschrute@dundermifflin.com', 5);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('dschrute@dundermifflin.com', 6);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('dschrute@dundermifflin.com', 8);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('gbluth@bluthco.com', 2);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('gbluth@bluthco.com', 3);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('gbluth@bluthco.com', 8);

INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jhalpert@dundermifflin.com', 2);
INSERT INTO `Watch` (`email`, `cork_board_id`) VALUES ('jhalpert@dundermifflin.com', 5);

-- Insert into PushPin
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (1, 1, "https://upload.wikimedia.org/wikipedia/commons/a/ae/Michael_Jordan_in_2014.jpg", "Michael Jordan", '2011-12-18 13:17:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (2, 1, "https://upload.wikimedia.org/wikipedia/commons/0/05/Kobe_Bryant_warming_up.jpg", "Kobe Bryant", '2011-12-18 13:18:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (3, 2, "https://en.wikipedia.org/wiki/Dog#/media/File:Terrier_mixed-breed_dog.jpg", "Dog", '2011-12-18 13:19:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (4, 4, "https://cdn1.medicalnewstoday.com/content/images/articles/321/321028/a-glass-of-red-wine.jpg", "Wine", '2011-12-18 13:20:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (5, 5, "https://media.overstockart.com/optimized/cache/data/product_images/MU925-1000x1000.jpg", "The Scream", '2011-12-18 13:21:17');

INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (6, 7, "https://en.wikipedia.org/wiki/File:Larix_decidua_Aletschwald.jpg", "Tree", '2011-12-18 13:22:17');
INSERT INTO `PushPin` (`pushPinID`, `cork_board_id`, `URL`, `description`, `date_pinned`) VALUES (7, 8, "https://cdn0.vox-cdn.com/hermano/verge/product/image/8846/jbareham_180917_2948_0415_squ.jpg", "iPhone", '2011-12-18 13:23:17');


-- Insert into PushPinTag
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (1, "basketball");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (1, "bulls");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (2, "basketball");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (2, "lakers");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (3, "cute");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (4, "cheese");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (4, "good");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (5, "edvard");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (5, "munch");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (6, "green");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (6, "forest");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "xs");
INSERT INTO `PushPinTag` (`pushpin_id`,	`tag`) VALUES (7, "apple");

-- Insert into Like
INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('gbluth@bluthco.com', 1);
INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('gbluth@bluthco.com', 2);
INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('gbluth@bluthco.com', 3);

INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('jhalpert@dundermifflin.com', 4);
INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('jhalpert@dundermifflin.com', 5);

INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('dschrute@dundermifflin.com', 6);
INSERT INTO `Like` (`email`, `pushpin_id`) VALUES ('dschrute@dundermifflin.com', 7);

-- Insert into Comment
INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 1, '2011-12-18 13:17:17', "Michael Jordan!");
INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 3, '2011-12-18 13:17:17', "So cute!");

INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 4, '2011-12-18 13:17:17', "Good wine!");
INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 5, '2011-12-18 13:17:17', "Museum tour");

INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 6, '2011-12-18 13:17:17', "Let's go hiking!");
INSERT INTO `Comment` (`email`, `pushpin_id`, `date_time`, `text`) VALUES ('gbluth@bluthco.com', 7, '2011-12-18 13:17:17', "Buy buy buy!");
