----- Purple Box DVD Creation Script
-- CS3550 Fall 2018
-- Rachel Laub

-----------------------------------------
-- CS 3550 Assignment 5
-----------------------------------------
USE Master;

--- Drop Previous Copies of the DATABASE
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'PurpleBoxDVD')
	DROP Database PurpleBoxDVD;


--- Create the database
CREATE DATABASE [PurpleBoxDVD]
	ON PRIMARY 
		(NAME = N'PurpleBoxDVD',
		FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PurpleBoxDVD.mdf',
		SIZE = 5120KB, 
		FILEGROWTH = 1024KB
		)
	LOG ON 
		(NAME = N'PurpleBoxDVDLog', 
		FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PurpleBoxDVD.ldf',
		SIZE = 2048KB,
		FILEGROWTH = 10%
		)
;
GO

--- Attach to the database
USE PurpleBoxDVD;


--- Drop All exisiting tables
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbActor')
	DROP Table PbActor;

IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbDirector')
	DROP Table PbDirector;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbGenre')
	DROP Table PbGenre;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbKeyword')
	DROP Table PbKeyword;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieActor')
	DROP Table PbMovieActor;

IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieKeyword')
	DROP Table PbMovieKeyword;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieDirector')
	DROP Table PbMovieDirector;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieGenre')
	DROP Table PbMovieGenre;
		
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbQuestion')
	DROP Table PbQuestion;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbUserQuestion')
	DROP Table PbUserQuestion;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieReservation')
	DROP Table PbUserQuestion;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieRental')
	DROP Table PbMovieRental;

IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbUser')
	DROP Table PbUser;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovieItem')
	DROP Table PbMovieItem;
	
IF EXISTS (SELECT * FROM sys.tables WHERE Name = N'PbMovie')
	DROP Table PbMovie;


--- Create new tables
CREATE TABLE dbo.PbUser
	(
	pbUser_id int IDENTITY(1,1) NOT NULL,
	userID nvarchar(9) NOT NULL,
	userFirstName nvarchar(25) NOT NULL,
	userLastName nvarchar(50) NOT NULL,
	userPassword nvarchar(255) NOT NULL,
	userPhoneNumber nvarchar(10) NOT NULL,
	userPhoneNumber2 nvarchar(10),
	userType nvarchar(1) NOT NULL,
	customerType nvarchar(10) NOT NULL,
	banStatus nvarchar(1) NOT NULL,
	fees money NOT NULL DEFAULT 0.0,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
	)
;

CREATE TABLE dbo.PbMovie
	(
	pbMovie_id int IDENTITY(1,1) NOT NULL,
	movieID nvarchar(10) NOT NULL,
	title nvarchar(255) NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
)
;
CREATE TABLE dbo.PbQuestion
(
	pbQuestion_id int IDENTITY(1,1) NOT NULL,
	question nvarchar(255) NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
	
);

CREATE TABLE dbo.PbUserQuestion
(
	pbUser_id int NOT NULL,
	pbQuestion_id int NOT NULL,
	answer nvarchar(255) NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);


CREATE TABLE dbo.PbMovieItem
(
	pbMovieItem_id int IDENTITY(1,1) NOT NULL,
	pbMovie_id int NOT NULL,
	copyNumber int NOT NULL,
	movieType nvarchar(1),
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbMovieRental 
(
	pbUser_id int NOT NULL,
	pbMovieItem_id int NOT NULL,
	rentalDate dateTime2 NOT NULL,
	returnDate dateTime2,
	dueDate dateTime2 NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbMovieReservation
(
	pbMovie_id int NOT NULL,
	pbUser_id int NOT NULL,
	reservationDate dateTime2 NOT NULL,
	movieType nvarchar(1) NOT NULL,
	lastUpdatedBy nvarchar(25)NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbActor
(
	pbActor_id int IDENTITY(1,1) NOT NULL,
	actorFirstName nvarchar(25) NOT NULL,
	actorLastName nvarchar(50) NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbMovieActor
(
	pbMovie_id int NOT NULL,
	pbActor_id int NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbKeyword
(
	pbKeyword_id int IDENTITY(1,1) NOT NULL,
	keyword nvarchar(25) NOT NULL
);

CREATE TABLE dbo.PbMovieKeyword 
(
	pbKeyword_id int NOT NULL,
	pbMovie_id int NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbDirector 
(
	pbDirector_id int IDENTITY(1,1) NOT NULL,
	directorFirstName nvarchar(25) NOT NULL,
	directorLastName nvarchar(50) NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbMovieDirector 
(
	pbMovie_id int NOT NULL,
	pbDirector_id int NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbGenre
(
	pbGenre_id int IDENTITY(1,1) NOT NULL,
	genre nvarchar(25),
	genreDescription nvarchar(255),
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);

CREATE TABLE dbo.PbMovieGenre 
(
	pbMovie_id int NOT NULL,
	pbGenre_id int NOT NULL,
	lastUpdatedBy nvarchar(25) NOT NULL,
	lastUpdatedDate dateTime2 NOT NULL
);



--- Create Primary Keys
ALTER TABLE PbUser
	ADD CONSTRAINT PK_PbUser PRIMARY KEY CLUSTERED (pbUser_id);

ALTER TABLE PbMovie
	ADD CONSTRAINT PK_PbMovie PRIMARY KEY CLUSTERED (pbMovie_id);
	
ALTER TABLE PbMovieItem
	ADD CONSTRAINT PK_PbMovieItem PRIMARY KEY CLUSTERED (pbMovieItem_id);
	
ALTER TABLE PbMovieRental
	ADD CONSTRAINT PK_PbMovieRental PRIMARY KEY CLUSTERED (pbUser_id, pbMovieItem_id, rentalDate);
	
ALTER TABLE PbMovieReservation
	ADD CONSTRAINT PK_PbMovieReservation PRIMARY KEY CLUSTERED (pbMovie_id, pbUser_id, reservationDate, movieType);

ALTER TABLE PbQuestion
	ADD CONSTRAINT PK_PbQuestion PRIMARY KEY CLUSTERED (pbQuestion_id);
	
ALTER TABLE PbUserQuestion
	ADD CONSTRAINT PK_PbUserQuestion PRIMARY KEY CLUSTERED (pbUser_id, pbQuestion_id);
	
ALTER TABLE PbActor	
	ADD CONSTRAINT PK_PbActor PRIMARY KEY CLUSTERED (pbActor_id);
	
ALTER TABLE PbMovieActor
	ADD CONSTRAINT PK_PbMovieActor PRIMARY KEY CLUSTERED (pbMovie_id, pbActor_id);
	
ALTER TABLE PbKeyword
	ADD CONSTRAINT PK_PbKeyword PRIMARY KEY CLUSTERED (pbKeyword_id);
	
ALTER TABLE PbDirector
	ADD CONSTRAINT PK_PbDirector PRIMARY KEY CLUSTERED (pbDirector_id);
	
ALTER TABLE PbMovieDirector
	ADD CONSTRAINT PK_PbMovieDirector PRIMARY KEY CLUSTERED (pbMovie_id, pbDirector_id);
	
ALTER TABLE PbGenre
	ADD CONSTRAINT PK_PbGenre PRIMARY KEY CLUSTERED (pbGenre_id);
	
ALTER TABLE PbMovieGenre	
	ADD CONSTRAINT PK_PbMovieGenre PRIMARY KEY CLUSTERED (pbMovie_id, pbGenre_id);
--- Create Foreign Keys
ALTER TABLE pbUserQuestion
	ADD CONSTRAINT FK_PbUserQuestion_PbQuestion 
	FOREIGN KEY (pbQuestion_id) REFERENCES PbQuestion(PbQuestion_id);

ALTER TABLE pbUserQuestion
	ADD CONSTRAINT 	FK_PbUserQuestion_PbUser
	FOREIGN KEY (pbUser_id) REFERENCES PbUser(pbUser_id);
	
ALTER TABLE PbMovieItem
	ADD CONSTRAINT FK_PbMovieItem_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);

ALTER TABLE PbMovieRental
	ADD CONSTRAINT FK_PbMovieRental_PbMovieItem
	FOREIGN KEY (pbMovieItem_id) REFERENCES PbMovieItem(pbMovieItem_id);

ALTER TABLE PbMovieRental
	ADD CONSTRAINT FK_PbMovieRental_PbUser
	FOREIGN KEY (pbUser_id) REFERENCES PbUser(pbUser_id);

ALTER TABLE PbMovieReservation
	ADD CONSTRAINT FK_PbReservation_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);

ALTER TABLE PbMovieReservation
	ADD CONSTRAINT FK_PbMovieReservation_PbUser
	FOREIGN KEY (pbUser_id) REFERENCES PbUser(pbUser_id);
	
ALTER TABLE PbMovieActor
	ADD CONSTRAINT FK_PbMovieActor_PbActor
	FOREIGN KEY (pbActor_id) REFERENCES PbActor(pbActor_id);

ALTER TABLE PbMovieActor
	ADD CONSTRAINT FK_PbMovieActor_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);
	
ALTER TABLE PbMovieKeyword
	ADD CONSTRAINT FK_PbMovieKeyword_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);
	
ALTER TABLE PbMovieKeyword
	ADD CONSTRAINT FK_PbMovieKeyword_PbKeyword
	FOREIGN KEY (pbKeyword_id) REFERENCES PbKeyword(pbKeyword_id);
	
ALTER TABLE PbMovieDirector
	ADD CONSTRAINT FK_PbMovieDirector_PbDirector
	FOREIGN KEY (pbDirector_id) REFERENCES PbDirector(pbDirector_id);
	
ALTER TABLE PbMovieDirector
	ADD CONSTRAINT FK_PbMovieDirector_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);

ALTER TABLE PbMovieGenre
	ADD CONSTRAINT FK_PbMovieGenre_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);
	
ALTER TABLE PbMovieGenre
	ADD CONSTRAINT FK_PbMovieGenre_PbGenre
	FOREIGN KEY (pbGenre_id) REFERENCES PbGenre(pbGenre_id);
	
--- Create Alternate Keys
ALTER TABLE PbUser
	ADD CONSTRAINT AK_PbUser_UserID
	UNIQUE (UserID);
ALTER TABLE PbActor
	ADD CONSTRAINT AK_PbActor_actorFirst_actorLast
	UNIQUE (actorFirstName, actorLastName);
ALTER TABLE PbDirector
	ADD CONSTRAINT AK_PbDirector_directorFirst_directorLast
	UNIQUE (directorFirstName, directorLastName);
ALTER TABLE PbMovieItem
	ADD CONSTRAINT AK_PbMovieItem_copyNumber_movieType_pbMovieId
	UNIQUE (copyNumber, movieType, pbMovie_id);
ALTER TABLE PbMovie
	ADD CONSTRAINT AK_PbMovie_movieID
	UNIQUE (movieID);
ALTER TABLE pbGenre
	ADD CONSTRAINT AK_PbGenre_genre
	UNIQUE (genre);
ALTER TABLE PbKeyword
	ADD CONSTRAINT AK_PbKeyword_keyword
	UNIQUE (keyword);
ALTER TABLE PbQuestion
	ADD CONSTRAINT AK_PbQuestion_question
	UNIQUE (question);

--- Create Data CONSTRAINTS
ALTER TABLE PbUser	
	ADD CONSTRAINT CK_PbUser_UserType
	CHECK (userType = 'A' OR userType = 'N');

ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_userFirstName
	CHECK (userFirstName LIKE '%[A-z]%');
ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_userLastName
	CHECK (userLastName LIKE '%[A-z]%');
	
ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_UserID
	CHECK (UserID LIKE 'PB[0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
	
ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_userPhoneNumber
	CHECK (userPhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_customerType
	CHECK (customerType = 'P' OR customerType = 'S');
ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_banStatus
	CHECK (banStatus = 'B' OR banStatus = 'N');
	
ALTER TABLE PbActor
	ADD CONSTRAINT CK_PbActor_actorFirstName
	CHECK (actorFirstName LIKE '%[A-z]%');
ALTER TABLE PbActor
	ADD CONSTRAINT CK_PbActor_actorLastName
	CHECK (actorLastName LIKE '%[A-z]%');
ALTER TABLE PbDirector
	ADD CONSTRAINT CK_PbDirector_directorFirstName
	CHECK (directorFirstName LIKE '%[A-z]%');
ALTER TABLE PbDirector
	ADD CONSTRAINT CK_PbDirector_directorLastName
	CHECK (directorLastName LIKE '%[A-z]%');

ALTER TABLE PbMovie
	ADD CONSTRAINT CK_PbMovie_MovieID
	CHECK (MovieID = 'a-zA-Z0-9');
ALTER TABLE PbMovieRental
	ADD CONSTRAINT CK_PbMovieRental_dueDate
	CHECK (dueDate > rentalDate);

ALTER TABLE PbMovieReservation
	ADD CONSTRAINT CK_PbMovieReservation_movieType
	CHECK (movieType = 'DVD' OR movieType = 'BLU');

ALTER TABLE PbMovieItem
	ADD CONSTRAINT CK_PbMovieItem_movieType
	CHECK (movieType = 'DVD' OR movieType = 'BLU');
	
	
	
---------------------------------------------------
-- CS 3550 Assignment 6
---------------------------------------------------

---Insert Users

INSERT INTO dbo.PbUser
(
	userId,
	userFirstName,
	userLastName
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'PB00000001',
	'Drew',
	'Weidman',
	'SQLRules',
	8016267025,
	NULL,
	'A',
	'P',
	'N',
	0.00,
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbUser
(
	userId,
	userFirstName,
	userLastName
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'PB00000021',
	'Spencer',
	'Hilton',
	'CSRocks!',
	8016266098,
	8016265500,
	'N',
	'P',
	'N',
	0.00,
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbUser
(
	userId,
	userFirstName,
	userLastName
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'PB00000027',
	'Josh',
	'Jensen',
	'AndriodIsKing',
	8016266323,
	8016266000,
	'N',
	'S',
	'N',
	0.00,
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbUser
(
	userId,
	userFirstName,
	userLastName
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'PB00000101',
	'Waldo',
	'Wildcat',
	'GoWildcats!',
	8016266001,
	8016268080,
	'N',
	'S',
	'N',
	0.00,
	'RLAUB',
	GETDATE()
);
INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What was the name of your first elementary school?',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What was the name of your first pet?',
	'RLAUB',
	GETDATE()
);
INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What is your mothers maiden name?',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What is the make and model of your first car?',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What was your favorite subject in school?',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	'What is the place where you were born?',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Drew'
	 AND userLastName = 'Weidman'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What was the name of your first elementary school?'),
	  
	  'Woods Cross',
	  
	  'RLAUB',
	  GETDATE()
);

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Drew'
	 AND userLastName = 'Weidman'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What is the place where you were born?'),
	  
	  'Ogden, UT',
	  
	  'RLAUB',
	  GETDATE()
);

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Spencer'
	 AND userLastName = 'Hilton'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What is the place where you were born?'),
	  
	  'Salt Lake City, UT',
	  
	  'RLAUB',
	  GETDATE()
);
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Spencer'
	 AND userLastName = 'Hilton'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What was your favorite subject in school??'),
	  
	  'Computer Science',
	  
	  'RLAUB',
	  GETDATE()
);

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Josh'
	 AND userLastName = 'Jensen'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What is your mothers maiden name?'),
	  
	  'Smith',
	  
	  'RLAUB',
	  GETDATE()
);
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Josh'
	 AND userLastName = 'Jensen'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What was the name of your first pet?'),
	  
	  'Bobby',
	  
	  'RLAUB',
	  GETDATE()
);
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Waldo'
	 AND userLastName = 'Wildcat'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What is the make and model of your first car?'),
	  
	  'Honda Civic',
	  
	  'RLAUB',
	  GETDATE()
);

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Waldo'
	 AND userLastName = 'Wildcat'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What was your favorite subject in school?'),
	  
	  'Math',
	  
	  'RLAUB',
	  GETDATE()
);


INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'TRGRT',
	'True Grit',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'SonKElder',
	'The Sons of Katie Elder',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'Avngrs',
	'The Avengers',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'GrtstShwman',
	'Greatest Showman',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'XMEN',
	'X-Men',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'Incrdbles2',
	'Incredibles 2',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'Deadpl',
	'Deadpool',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES
(
	'StrWrsIVNwHp',
	'Star Wars: Episode IV- New Hope',
	'RLAUB',
	GETDATE()
);

INSERT INTO dbo.MovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
);
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'TRGRT'),
	 'TRGRTBlu1',
	 
);
