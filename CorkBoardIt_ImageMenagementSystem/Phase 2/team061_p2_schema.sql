-- Create User
CREATE USER IF NOT EXISTS user1@localhost IDENTIFIED BY '1357';

-- Create the database

DROP DATABASE IF EXISTS 'CS6400_FA18_TEAM061';
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb_unicode_ci;

CREATE DATABASE IF EXISTS 'CS6400_FA18_TEAM061';
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_unicode_ci;
USE CS6400_FA18_TEAM061;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO
'user1'@'localhost';
GRANT ALL PRIVILEGES ON `user1`.* TO 'user1'@'localhost';
GRANT ALL PRIVILEGES ON `CS6400_FA18_TEAM061`.* TO 'user1'@'localhost';
FLUSH PRIVILEGES;

-- Tables

CREATE TABLE User (
	Email varchar(250) NOT NULL,
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
	PIN char(4) NOT NULL,
	PRIMARY KEY(email)
);

CREATE TABLE Corkboard (
	Email varchar(250) NOT NULL,
	Title varchar(250) NOT NULL,
	DateUpdated datetime NOT NULL,
	Type varchar(20) NOT NULL
	Password varchar(20) NULL,
	PRIMARY KEY(Email, Title),
);

CREATE TABLE Watches (
	WatchersEmail varchar(250),
	OwnersEmail varchar(250),
	Title varchar(100),
	PRIMARY KEY(WatchersEmail, OwnersEmail, Title)
);

CREATE TABLE Follows (
	OwnersEmail varchar(250),
	FollowersEmail varchar(250),
	PRIMARY KEY(OwnersEmail, FollowersEmail)
);

CREATE TABLE PushPin (
	Email varchar(250),
	Title varchar(100),
	URL varchar(250),
	Description varchar(250),
	TimePinned datetime,
	PRIMARY KEY(Email, Title, URL)
);

CREATE TABLE Tag (
	Email varchar(250),
	URL varchar(250),
	Tag varchar(100),
	UNIQUE KEY(Email, URL, Tag)
);

CREATE TABLE Likes (
	Email varchar(250),
	URL varchar(250),
	Tag varchar(100),
	PRIMARY KEY(Email, OwnersEmail, URL)
);

CREATE TABLE Comment (
	Email varchar(250),
	Title varchar(100),
	URL varchar(250),
	UserEmail varchar(250),
	CommentTime datetime,
	Description varchar(250),
	PRIMARY KEY(Email, Title, URL, UserEmail, CommentTime)
);

CREATE TABLE Category (
	Email varchar(250),
	Title varchar(100),
	Category varchar(100)
	PRIMARY KEY(Email, Title)
);

-- Constraints Foreign Keys:

ALTER TABLE Corkboard
	ADD CONSTRAINT fk_Corkboard_Email_User_Email FOREIGN KEY (Email)
REFERENCES 'User' (Email);


ALTER TABLE Watches
	ADD CONSTRAINT fk_Watches_WatchersEmail_User_Email FOREIGN KEY (WatchersEmail)
REFERENCES 'User' (Email),
	ADD CONSTRAINT fk_Watches_Email_User_Email FOREIGN KEY (OwnersEmail)
REFERENCES Corkboard (Email),
	ADD CONSTRAINT fk_Watches_Title_Corkboard_Title FOREIGN KEY (Title)
REFERENCES Corkboard (Title);


ALTER TABLE Follows
	ADD CONSTRAINT fk_Follows_FollowersEmail_User_Email FOREIGN KEY (FollowersEmail)
REFERENCES 'User' (Email),
	ADD CONSTRAINT fk_Follows_OwnersEmail_User_Email FOREIGN KEY (OwnersEmail)
REFERENCES 'User' (Email);


ALTER TABLE PushPin
	ADD CONSTRAINT fk_PushPin_Email_Corkboard_Email FOREIGN KEY (Email)
REFERENCES Corkboard (Email),
	ADD CONSTRAINT fk_PushPin_Title_Corkboard_Title FOREIGN KEY (Title)
REFERENCES Corkboard (Title);


ALTER TABLE Tag
	ADD CONSTRAINT fk_Tag_Email_PushPin_Email FOREIGN KEY (Email)
REFERENCES PushPin (Email),
	ADD CONSTRAINT fk_Tag_Title_PushPin_Title FOREIGN KEY (Title)
REFERENCES PushPin (Title),
	ADD CONSTRAINT fk_Tag_URL_PushPin_URL FOREIGN KEY (URL)
REFERENCES PushPin (URL);


ALTER TABLE Likes
	ADD CONSTRAINT fk_Likes_Email_User_Email FOREIGN KEY (Email)
REFERENCES 'User' (Email),
	ADD CONSTRAINT fk_Likes_OwnersEmail_PushPin_Email FOREIGN KEY (OwnersEmail)
REFERENCES PushPin (Email),
	ADD CONSTRAINT fk_Likes_URL_PushPin_URL FOREIGN KEY (URL)
REFERENCES PushPin (URL);


ALTER TABLE Comments
	ADD CONSTRAINT fk_Comments_Email_PushPin_Email FOREIGN KEY (Email)
REFERENCES PushPin (Email),
	ADD CONSTRAINT fk_Comments_Title_PushPin_Title FOREIGN KEY (Title)
REFERENCES PushPin (Title),
	ADD CONSTRAINT fk_Comments_URL_PushPin_URL FOREIGN KEY (URL)
REFERENCES PushPin (URL),
	ADD CONSTRAINT fk_comments_UserEmail_User_Email FOREIGN KEY (UserEmail)
REFERENCES 'User' (Email);

ALTER TABLE Category
	ADD CONSTRAINT fk_Category_Email_Corkboard_Email FOREIGN KEY (Email)
REFERENCES Corkboard (Email),
	ADD CONSTRAINT fk_Category_Title_Corkboard_Title FOREIGN KEY (Title)
REFERENCES Corkboard (Title);
