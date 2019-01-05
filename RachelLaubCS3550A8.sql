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
	DROP Table PbMovieReservation;
	
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
	userID nvarchar(12) NOT NULL,
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
	movieID nvarchar(12) NOT NULL,
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
	movieType nvarchar(1) NOT NULL,
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
/*
CREATE TABLE dbo.PbRentalHistory
(
		pbRentalHistory_id int IDENTITY(1,1) NOT NULL,
		pbUser_id int NOT NULL,
		pbMovieItem_id int NOT NULL,
		rentalDate dateTime2 NOT NULL,
		dueDate dateTime2 NOT NULL,
		lastUpdatedBy nvarchar(25) NOT NULL,
		lastUpdatedDate dateTime2 NOT NULL
)*/

--------------------------Assignment 8 CREATE TABLE
--Create a new table named pbRentalHistory.
CREATE TABLE dbo.pbRentalHistory
(
	pbRentalHistory_id int IDENTITY(1,1) NOT NULL,
	pbUser_id int NOT NULL,
	pbMovieItem_id int NOT NULL,
	rentalDate dateTime2 NOT NULL,
	dueDate dateTime2 NOT NULL,
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
	
ALTER TABLE PbMovieKeyword
	ADD CONSTRAINT PK_PbMovieKeyword PRIMARY KEY CLUSTERED (pbKeyword_id, pbMovie_id);
	
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
	ADD CONSTRAINT FK_PbMovieKeyword_PbKeyword
	FOREIGN KEY (pbKeyword_id) REFERENCES PbKeyword(pbKeyword_id);
ALTER TABLE PbMovieKeyword
	ADD CONSTRAINT FK_PbMovieKeyword_PbMovie
	FOREIGN KEY (pbMovie_id) REFERENCES PbMovie(pbMovie_id);
	
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
	ADD CONSTRAINT CK_PbUser_userID
	CHECK (userID LIKE 'PB[0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
	
ALTER TABLE PbUser
	ADD CONSTRAINT CK_PbUser_userPhoneNumber
	CHECK (userPhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

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
	ADD CONSTRAINT CK_PbMovie_movieID
	CHECK (movieID LIKE '%[A-z]%');
ALTER TABLE PbMovieRental
	ADD CONSTRAINT CK_PbMovieRental_dueDate
	CHECK (dueDate > rentalDate);

ALTER TABLE PbMovieReservation
	ADD CONSTRAINT CK_PbMovieReservation_movieType
	CHECK (movieType = 'DVD' OR movieType = 'BLU');

ALTER TABLE PbMovieItem
	ADD CONSTRAINT CK_PbMovieItem_movieType
	CHECK (movieType = 'D' OR movieType = 'B');
	
	
	/*
---------------------------------------------------
-- CS 3550 Assignment 6
---------------------------------------------------

---Insert Users

INSERT INTO dbo.PbUser
(
	userID,
	userFirstName,
	userLastName,
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'PB0000001',
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
)

INSERT INTO dbo.PbUser
(
	userID,
	userFirstName,
	userLastName,
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'PB0000021',
	'Spencer',
	'Hilton',
	'CSRocks!',
	'8016266098',
	'8016265500',
	'N',
	'P',
	'N',
	0.00,
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbUser
(
	userID,
	userFirstName,
	userLastName,
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'PB0000027',
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
)

INSERT INTO dbo.PbUser
(
	userID,
	userFirstName,
	userLastName,
	userPassword,
	userPhoneNumber,
	userPhoneNumber2,
	userType,
	customerType,
	banStatus,
	fees,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'PB0000101',
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
)
INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What was the name of your first elementary school?',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What was the name of your first pet?',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What is your mothers maiden name?',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What is the make and model of your first car?',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What was your favorite subject in school?',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbQuestion
( 
	question,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	'What is the place where you were born?',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT PbUser_id FROM PbUser
	 WHERE userFirstName = 'Spencer'
	 AND userLastName = 'Hilton'),
	 
	 (SELECT PbQuestion_id FROM PbQuestion
	  WHERE question= 'What was your favorite subject in school?'),
	  
	  'Computer Science',
	  
	  'RLAUB',
	  GETDATE()
)

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)
INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)

INSERT INTO dbo.PbUserQuestion 
(
	pbUser_id,
	pbQuestion_id,
	answer,
	lastUpdatedBy,
	lastUpdatedDate
)
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
)


INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'TRGRT',
	'True Grit',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'SonKElder',
	'The Sons of Katie Elder',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Avngrs',
	'The Avengers',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'GrtstShwman',
	'Greatest Showman',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'XMEN',
	'X-Men',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Incrdbles2',
	'Incredibles 2',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Deadpl',
	'Deadpool',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovie
(
	movieID,
	title,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'StrWrsIVNwHp',
	'Star Wars: Episode IV- New Hope',
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'TRGRT'),
	 '1',
	  'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'TRGRT'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'TRGRT'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'TRGRT'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'SonKElder'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'SonKElder'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'SonKElder'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'SonKElder'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Avngrs'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Avngrs'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Avngrs'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Avngrs'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'GrtstShwman'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'GrtstShwman'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'GrtstShwman'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'GrtstShwman'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'XMEN'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'XMEN'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'XMEN'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'XMEN'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Incrdbles2'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Incrdbles2'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Incrdbles2'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Incrdbles2'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Deadpl'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)

INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Deadpl'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Deadpl'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'Deadpl'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'StrWrsIVNwHp'),
	 '1',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'StrWrsIVNwHp'),
	 '2',
	 'B',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'StrWrsIVNwHp'),
	 '1',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbMovieItem
(
	pbMovie_id,
	copyNumber,
	movieType,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES 
(
	(SELECT pbMovie_id FROM PbMovie
	 WHERE movieID= 'StrWrsIVNwHp'),
	 '2',
	 'D',
	  'RLAUB',
	  GETDATE()
	 
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'John',
	'Wayne',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Glen',
	'Campbell',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Dean',
	'Martin',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Robert',
	'Downey Jr.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Chris',
	'Evans',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Hugh',
	'Jackman',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Michelle',
	'Williams',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Patrick',
	'Stewart',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Craig T',
	'Nelson',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Holly',
	'Hunter',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Ryan',
	'Reynolds',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Morena',
	'Baccarin',
	'RLAUB',
	GETDATE()
) 
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Mark',
	'Hamill',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbActor
(
	actorFirstName,
	actorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Carrie',
	'Fisher',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Henry',
	'Hathaway',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Joss',
	'Whedon',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Michael',
	'Gracey',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Bryan',
	'Singer',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Brad',
	'Bird',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Tim',
	'Miller',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbDirector
(
	directorFirstName,
	directorLastName,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'George',
	'Lucas',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Adventure',
	'unusual and exciting, typically hazardous, experience or activity.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Drama',
	'an exciting, emotional, or unexpected series of events or set of circumstances.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Western',
	' about cowboys in the western US, especially in the late 19th and early 20th centuries.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Action',
	' the protagonist thrust into a series of challenges',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Sci-Fi',
	'fiction based on imagined future scientific advances',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Biography',
	'an account of someones life written by someone else.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Musical',
	'singing and dancing play an essential part',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Comedy',
	'intended to make an audience laugh',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Animation',
	'a combination of drawerings into a movie',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbGenre
(
	genre,
	genreDescription,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	'Fantasy',
	'things that are impossible or improbable.',
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbKeyword
(
	keyword
)
VALUES
(
	'Rooster Cogburn'
)
INSERT INTO dbo.PbKeyword
(
	keyword
)
VALUES
(
	'US Marshal'
)
INSERT INTO dbo.PbKeyword
(
	keyword
)
VALUES
(
	'Oscar Award Winner'
)
INSERT INTO dbo.PbKeyword
(
	keyword
)
VALUES
(
	'Gun Fighter'
)
INSERT INTO dbo.PbKeyword
(
	keyword
)
VALUES
(
	'Family'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Captain America'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Iron Man'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Thor'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Circus'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Barnum'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Singing'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Million Dreams'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Wolverine'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Mutants'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Elastigirl'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Dash'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Jack Jack'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Mercinary'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Morbid'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'healing power'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Jedi Knight'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Darth Vader'
)
INSERT INTO dbo.PbKeyword
(
	Keyword
)
VALUES
(
	'Yoda'
)

INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'John'
	AND actorLastName = 'Wayne'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Glen'
	AND actorLastName = 'Campbell'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'John'
	AND actorLastName = 'Wayne'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Dean'
	AND actorLastName = 'Martin'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Robert'
	AND actorLastName = 'Downey Jr.'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Chris'
	AND actorLastName = 'Evans'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Hugh'
	AND actorLastName = 'Jackman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Michelle'
	AND actorLastName = 'Williams'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Patrick'
	AND actorLastName = 'Stewart'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Hugh'
	AND actorLastName = 'Jackman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Craig T'
	AND actorLastName = 'Nelson'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Holly'
	AND actorLastName = 'Hunter'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Ryan'
	AND actorLastName = 'Reynolds'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Morena'
	AND actorLastName = 'Baccarin'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Mark'
	AND actorLastName = 'Hamill'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieActor
(
	pbMovie_id,
	pbActor_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbActor_id FROM PbActor
	WHERE actorFirstName = 'Carrie'
	AND actorLastName = 'Fisher'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Henry'
	AND directorLastName = 'Hathaway'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Henry'
	AND directorLastName = 'Hathaway'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
( 
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Joss'
	AND directorLastName = 'Whedon'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Michael'
	AND directorLastName = 'Gracey'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Bryan'
	AND directorLastName = 'Singer'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Brad'
	AND directorLastName = 'Bird'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'Tim'
	AND directorLastName = 'Miller'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieDirector
(
	pbMovie_id,
	pbDirector_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbDirector_id FROM PbDirector
	WHERE directorFirstName = 'George'
	AND directorLastName = 'Lucas'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Drama'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Western'),
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Western'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Action'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Sci-Fi'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Biography'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Drama'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Musical'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Action'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Sci-Fi'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Action'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Animation'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Action'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Comedy'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Action'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Adventure'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieGenre
(
	pbMovie_id,
	pbGenre_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	(SELECT pbGenre_id FROM PbGenre
	WHERE genre = 'Fantasy'),
	'RLAUB',
	GETDATE()
)

INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Rooster Cogburn'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'US Marshal'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Oscar Award Winner'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'TRGRT'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Gun Fighter'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Family'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'SonKElder'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Captain America'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Iron Man'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Thor'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Avngrs'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Circus'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Barnum'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Singing'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Million Dreams'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'GrtstShwman'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Wolverine'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Mutants'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'XMEN'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Elastigirl'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Dash'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Jack Jack'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Incrdbles2'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(

	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Mercinary'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Morbid'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'healing power'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'Deadpl'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Jedi Knight'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Darth Vader'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	'RLAUB',
	GETDATE()
)
INSERT INTO dbo.PbMovieKeyword
(
	pbKeyword_id,
	pbMovie_id,
	lastUpdatedBy,
	lastUpdatedDate
)
VALUES
(
	(SELECT pbKeyword_id FROM PbKeyword
	WHERE keyword = 'Yoda'),
	(SELECT pbMovie_id FROM PbMovie
	WHERE movieID = 'StrWrsIVNwHp'),
	'RLAUB',
	GETDATE()
)
SELECT * FROM PbUser;
SELECT * FROM PbQuestion;
SELECT * FROM PbUserQuestion;
SELECT * FROM PbMovie;
SELECT * FROM PbMovieItem;
SELECT * FROM PbActor;
SELECT * FROM PbMovieActor;
SELECT * FROM PbDirector;
SELECT * FROM PbMovieDirector;
SELECT * FROM PbGenre;
SELECT * FROM PbMovieGenre;
SELECT * FROM PbKeyword;
SELECT * FROM PbMovieKeyword;
*/
----------------------------------------------------------
---- Assignment 7
----------------------------------------------------------
---- Create Stored Procedures

USE PurpleBoxDVD;
GO
----------Add User Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addUser'
	)
	DROP PROCEDURE usp_addUser;

GO


CREATE PROCEDURE usp_addUser

@userId nvarchar(10),
@userFirstName nvarchar(25),
@userLastName nvarchar(50),
@userPassword nvarchar(255),
@userPhoneNumber nvarchar(10),
@userPhoneNumber2 nvarchar(10) NULL,
@userType nvarchar(1),
@customerType nvarchar(1),
@banStatus nvarchar(1),
@fees money



AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbUser
			(userId , userFirstName, userLastName, userPassword, userPhoneNumber, userPhoneNumber2, userType, customerType, banStatus, fees, lastUpdatedBy, lastUpdatedDate)
		VALUES( @userId , @userFirstName, @userLastName, @userPassword, @userPhoneNumber, @userPhoneNumber2, @userType, @customerType, @banStatus, @fees,'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbUser FAILED') ---RAISEERROR
	END CATCH
END

GO


EXECUTE usp_addUser @userId = 'PB0000001' , @userFirstName = 'Drew', @userLastName = 'Weidman', @userPassword = 'SQLRules', @userPhoneNumber = 8016267025, @userPhoneNumber2 = NULL, @userType = 'A', @customerType = 'P', @banStatus = 'N', @fees = 0.0;
EXECUTE usp_addUser @userId = 'PB0000021' , @userFirstName = 'Spencer', @userLastName = 'Hilton', @userPassword = 'CSRocks!', @userPhoneNumber = 8016266098, @userPhoneNumber2 = 8016265500, @userType = 'N', @customerType = 'P', @banStatus = 'N', @fees = 0.0;
EXECUTE usp_addUser @userId = 'PB0000027' , @userFirstName = 'Josh', @userLastName = 'Jensen', @userPassword = 'AndroidIsKing', @userPhoneNumber = 8016266323, @userPhoneNumber2 = 8016266000, @userType = 'N', @customerType = 'S', @banStatus = 'N', @fees = 0.0;
EXECUTE usp_addUser @userId = 'PB0000101' , @userFirstName = 'Waldo', @userLastName = 'Wildcat', @userPassword = 'GoWildcats!', @userPhoneNumber = 8016266001, @userPhoneNumber2 = 8016268080, @userType = 'N', @customerType = 'S', @banStatus = 'N', @fees = 0.0;
EXECUTE usp_addUser @userId = 'PB0000033' , @userFirstName = 'Rachel', @userLastName = 'Laub', @userPassword = 'CSisCool!', @userPhoneNumber = 8014149604, @userPhoneNumber2 = NULL, @userType = 'N', @customerType = 'S', @banStatus = 'B', @fees = 0.0;
EXECUTE usp_addUser @userId = 'PB0000177' , @userFirstName = 'Jacob', @userLastName = 'Loose', @userPassword = 'HelloWorld!', @userPhoneNumber = 8015930538, @userPhoneNumber2 = 8018244831, @userType = 'N', @customerType = 'S', @banStatus = 'N', @fees = 0.0;

----------End User Procedure
----------Add Actor Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addActor'
	)
	DROP PROCEDURE usp_addActor;

GO


CREATE PROCEDURE usp_addActor

@actorFirstName nvarchar(25),
@actorLastName nvarchar(50)

AS 
BEGIN

	--IF @actorFirstName IS NULL THEN Print('No actorFirstName');

	BEGIN TRY 

		INSERT INTO dbo.PbActor
			(actorFirstName, actorLastName, lastUpdatedBy, lastUpdatedDate)
		VALUES( @actorFirstName, @actorLastName, 'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbActor FAILED') ---RAISEERROR
	END CATCH
END

GO


EXECUTE usp_addActor @actorFirstname = 'John', @actorLastName = 'Wayne';
EXECUTE usp_addActor @actorFirstname = 'Glen', @actorLastName = 'Campbell';
EXECUTE usp_addActor @actorFirstname = 'Dean', @actorLastName = 'Martin';
EXECUTE usp_addActor @actorFirstname = 'Robert', @actorLastName = 'Downey Jr.';
EXECUTE usp_addActor @actorFirstname = 'Chris', @actorLastName = 'Evans';
EXECUTE usp_addActor @actorFirstname = 'Hugh', @actorLastName = 'Jackman';
EXECUTE usp_addActor @actorFirstname = 'Michelle', @actorLastName = 'Williams';
EXECUTE usp_addActor @actorFirstname = 'Patrick', @actorLastName = 'Stewart';
EXECUTE usp_addActor @actorFirstname = 'Craig T', @actorLastName = 'Nelson';
EXECUTE usp_addActor @actorFirstname = 'Holly', @actorLastName = 'Hunter';
EXECUTE usp_addActor @actorFirstname = 'Ryan', @actorLastName = 'Reynolds';
EXECUTE usp_addActor @actorFirstname = 'Morena', @actorLastName = 'Baccarin';
EXECUTE usp_addActor @actorFirstname = 'Mark', @actorLastName = 'Hamill';
EXECUTE usp_addActor @actorFirstname = 'Carrie', @actorLastName = 'Fisher';

-----------End Actor Procedure
-----------Add Director Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addDirector'
	)
	DROP PROCEDURE usp_addDirector;

GO


CREATE PROCEDURE usp_addDirector

@directorFirstName nvarchar(25),
@directorLastName nvarchar(50)

AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbDirector
			(directorFirstName, directorLastName, lastUpdatedBy, lastUpdatedDate)
		VALUES( @directorFirstName, @directorLastName, 'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbDirector FAILED') ---RAISEERROR
	END CATCH
END

GO

EXECUTE usp_addDirector @directorFirstname = 'Henry', @directorLastName = 'Hathaway';
EXECUTE usp_addDirector @directorFirstname = 'Joss', @directorLastName = 'Whedon';
EXECUTE usp_addDirector @directorFirstname = 'Michael', @directorLastName = 'Gracey';
EXECUTE usp_addDirector @directorFirstname = 'Bryan', @directorLastName = 'Singer';
EXECUTE usp_addDirector @directorFirstname = 'Brad', @directorLastName = 'Bird';
EXECUTE usp_addDirector @directorFirstname = 'Tim', @directorLastName = 'Miller';
EXECUTE usp_addDirector @directorFirstname = 'George', @directorLastName = 'Lucas';
-------------End Director Procedure
-------------Add Genre Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addGenre'
	)
	DROP PROCEDURE usp_addGenre;

GO


CREATE PROCEDURE usp_addGenre

@genre nvarchar(25),
@genreDescription nvarchar(255)

AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbGenre
			(genre, genreDescription, lastUpdatedBy, lastUpdatedDate)
		VALUES( @genre, @genreDescription, 'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbGenre FAILED') ---RAISEERROR
	END CATCH
END

GO

EXECUTE usp_addGenre @genre = 'Adventure', @genreDescription = 'unusual and exciting, typically hazardous, experience or activity.';
EXECUTE usp_addGenre @genre = 'Drama', @genreDescription = 'an exciting, emotional, or unexpected series of events or set of circumstances.';
EXECUTE usp_addGenre @genre = 'Western', @genreDescription = 'about cowboys in the western US, especially in the late 19th and early 20th centuries.';
EXECUTE usp_addGenre @genre = 'Action', @genreDescription = 'the protagonist or protagonists are thrust into a series of challenges that typically include violence, extended fighting, physical feats, and frantic chases';
EXECUTE usp_addGenre @genre = 'Sci-Fi', @genreDescription = 'fiction based on imagined future scientific advances';
EXECUTE usp_addGenre @genre = 'Biography', @genreDescription = 'an account of someones life written by someone else.';
EXECUTE usp_addGenre @genre = 'Musical', @genreDescription = 'singing and dancing play an essential part';
EXECUTE usp_addGenre @genre = 'Comedy', @genreDescription = 'intended to make an audience laugh';
EXECUTE usp_addGenre @genre = 'Animation', @genreDescription = 'a combination of drawerings into a movie';
EXECUTE usp_addGenre @genre = 'Fantasy', @genreDescription = 'things that are impossible or improbable.';
------------End Genre Procedure
------------Add Keyword Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addKeyword'
	)
	DROP PROCEDURE usp_addKeyword;

GO


CREATE PROCEDURE usp_addKeyword

@keyword nvarchar(25)

AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbKeyword
			(keyword)
		VALUES( @keyword);

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbKeyword FAILED') ---RAISEERROR
	END CATCH
END

GO

EXECUTE usp_addKeyword @keyword = 'Rooster Cogburn';
EXECUTE usp_addKeyword @keyword = 'US Marshal';
EXECUTE usp_addKeyword @keyword = 'Oscar Award Winner';
EXECUTE usp_addKeyword @keyword = 'Gun Fighter';
EXECUTE usp_addKeyword @keyword = 'Family';
EXECUTE usp_addKeyword @keyword = 'Captain America';
EXECUTE usp_addKeyword @keyword = 'Iron Man';
EXECUTE usp_addKeyword @keyword = 'Thor';
EXECUTE usp_addKeyword @keyword = 'Circus';
EXECUTE usp_addKeyword @keyword = 'Barnum';
EXECUTE usp_addKeyword @keyword = 'Singing';
EXECUTE usp_addKeyword @keyword = 'Million Dreams';
EXECUTE usp_addKeyword @keyword = 'Wolverine';
EXECUTE usp_addKeyword @keyword = 'Mutants';
EXECUTE usp_addKeyword @keyword = 'Elastigirl';
EXECUTE usp_addKeyword @keyword = 'Dash';
EXECUTE usp_addKeyword @keyword = 'Jack Jack';
EXECUTE usp_addKeyword @keyword = 'Mercinary';
EXECUTE usp_addKeyword @keyword = 'Morbid';
EXECUTE usp_addKeyword @keyword = 'healing power';
EXECUTE usp_addKeyword @keyword = 'Jedi Knight';
EXECUTE usp_addKeyword @keyword = 'Darth Vader';
EXECUTE usp_addKeyword @keyword = 'Yoda';

-----------End Keyword Procedure
-----------Add Movie Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovie'
	)
	DROP PROCEDURE usp_addMovie;

GO


CREATE PROCEDURE usp_addMovie

@movieID nvarchar(12),
@title nvarchar(255)

AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbMovie
			(movieID, title, lastUpdatedBy, lastUpdatedDate)
		VALUES( @movieID, @title, 'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbMovie FAILED') ---RAISEERROR
	END CATCH
END

GO

EXECUTE usp_addMovie @movieID = 'TRGRT', @title = 'True Grit';
EXECUTE usp_addMovie @movieID = 'SonKElder', @title = 'The Sons of Katie Elder';
EXECUTE usp_addMovie @movieID = 'Avngrs', @title = 'The Avengers';
EXECUTE usp_addMovie @movieID = 'GrtstShwman', @title = 'Greatest Showman';
EXECUTE usp_addMovie @movieID = 'XMEN', @title = 'X-Men';
EXECUTE usp_addMovie @movieID = 'Incrdbles2', @title = 'Incredibles 2';
EXECUTE usp_addMovie @movieID = 'Deadpl', @title = 'Deadpool';
EXECUTE usp_addMovie @movieID = 'StrWrsIVNwHp', @title = 'Star Wars: Episode IV- New Hope';
------------End Movie Procedure
------------Add Question Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addQuestion'
	)
	DROP PROCEDURE usp_addQuestion;

GO


CREATE PROCEDURE usp_addQuestion

@question nvarchar(255)

AS 
BEGIN

	BEGIN TRY 

		INSERT INTO dbo.PbQuestion
			(question, lastUpdatedBy, lastUpdatedDate)
		VALUES( @question, 'RLAUB', GETDATE());

	END TRY 

	BEGIN CATCH
		PRINT('INSERT INTO PbQuestion FAILED') ---RAISEERROR
	END CATCH
END

GO

EXECUTE usp_addQuestion @question = 'What was the name of your first elementary school?';
EXECUTE usp_addQuestion @question = 'What was the name of your first pet?';
EXECUTE usp_addQuestion @question = 'What is your mothers maiden name?';
EXECUTE usp_addQuestion @question = 'What was your favorite subject in school?';
EXECUTE usp_addQuestion @question = 'What is the place where you were born?';
EXECUTE usp_addQuestion @question = '';
------------End Question Procedure
------------Add MovieItem Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieItem'
	)
	DROP PROCEDURE usp_addMovieItem;

GO
CREATE PROCEDURE usp_addMovieItem
@movieID nvarchar(12),
@copyNumber int,
@movieType nvarchar(1)

AS
BEGIN
	DECLARE @pbMovie_id int;

	SELECT @pbMovie_id = pbMovie_id FROM PbMovie 
	WHERE movieID = @movieID;

	BEGIN TRY
		INSERT INTO dbo.PbMovieItem
			(pbMovie_id, copyNumber, movieType, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbMovie_id, @copyNumber, @movieType, 'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbMovieItem FAILED')
	END CATCH

END

GO

EXECUTE usp_addMovieItem @movieID = 'TRGRT', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'TRGRT', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'TRGRT', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'TRGRT', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'SonKElder', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'SonKElder', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'SonKElder', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'SonKElder', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Avngrs', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Avngrs', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Avngrs', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Avngrs', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'GrtstShwman', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'GrtstShwman', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'GrtstShwman', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'GrtstShwman', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'XMEN', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'XMEN', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'XMEN', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'XMEN', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Incrdbles2', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Incrdbles2', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Incrdbles2', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Incrdbles2', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Deadpl', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Deadpl', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'Deadpl', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'Deadpl', @copyNumber = 2, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'StrWrsIVNwHp', @copyNumber = 1, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'StrWrsIVNwHp', @copyNumber = 2, @movieType = 'D';
EXECUTE usp_addMovieItem @movieID = 'StrWrsIVNwHp', @copyNumber = 1, @movieType = 'B';
EXECUTE usp_addMovieItem @movieID = 'StrWrsIVNwHp', @copyNumber = 2, @movieType = 'B';
-----------End MovieItem Procedure
-----------Add UserQuestion Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addUserQuestion'
	)
	DROP PROCEDURE usp_addUserQuestion;

GO
CREATE PROCEDURE usp_addUserQuestion
@answer nvarchar(255),
@userFirstName nvarchar(25),
@userLastName nvarchar(255),
@question nvarchar(255)

AS
BEGIN
	DECLARE @pbUser_id int,
			@pbQuestion_id int;

	SELECT @pbUser_id = pbUser_id FROM PbUser 
	WHERE userFirstName = @userFirstName AND userLastName = @userLastName;
	
	SELECT @pbQuestion_id = pbQuestion_id FROM PbQuestion 
	WHERE question = @question;

	BEGIN TRY
		INSERT INTO dbo.PbUserQuestion
			(pbUser_id, pbQuestion_id, answer, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbUser_id, @pbQuestion_id, @answer, 'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbUserQuestion FAILED')
	END CATCH

END

GO

EXECUTE usp_addUserQuestion @userFirstName = 'Drew', @userLastName = 'Weidman', @question = 'What was the name of your first elementary school?', @answer = 'Woods Cross';
EXECUTE usp_addUserQuestion @userFirstName = 'Drew', @userLastName = 'Weidman', @question = 'What is the place where you were born?', @answer = 'Ogden, UT';
EXECUTE usp_addUserQuestion @userFirstName = 'Spencer', @userLastName = 'Hilton', @question = 'What is the place where you were born?', @answer = 'Salt Lake City, UT';
EXECUTE usp_addUserQuestion @userFirstName = 'Spencer', @userLastName = 'Hilton', @question = 'What was your favorite subject in school?', @answer = 'Computer Science';
EXECUTE usp_addUserQuestion @userFirstName = 'Josh', @userLastName = 'Jensen', @question = 'What was the name of your first pet?', @answer = 'Bobby';
EXECUTE usp_addUserQuestion @userFirstName = 'Josh', @userLastName = 'Jensen', @question = 'What is your mothers maiden name?', @answer = 'Smith';
EXECUTE usp_addUserQuestion @userFirstName = 'Waldo', @userLastName = 'Wildcat', @question = 'What is the make and model of your first car?', @answer = 'Honda Civic';
EXECUTE usp_addUserQuestion @userFirstName = 'Waldo', @userLastName = 'Wildcat', @question = 'What was your favorite subject in school?', @answer = 'Math';
-----------End UserQuestion Procedure
-----------Add MovieActor Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieActor'
	)
	DROP PROCEDURE usp_addMovieActor;

GO
CREATE PROCEDURE usp_addMovieActor
@movieID nvarchar(12),
@actorFirstName nvarchar(25),
@actorLastName nvarchar(255)
AS
BEGIN
	DECLARE @pbMovie_id int,
			@pbActor_id int;

	SELECT @pbMovie_id = pbMovie_id FROM PbMovie 
	WHERE movieID = @movieID;
	SELECT @pbActor_id = pbActor_id FROM PbActor
	WHERE actorFirstName = @actorFirstName AND actorLastName = @actorLastName;

	BEGIN TRY
		INSERT INTO dbo.PbMovieActor
			(pbMovie_id, pbActor_id, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbMovie_id, @pbActor_id, 'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbMovieActor FAILED')
	END CATCH

END

GO

EXECUTE usp_addMovieActor @movieID = 'TRGRT', @actorFirstName = 'John', @actorLastName = 'Wayne';
EXECUTE usp_addMovieActor @movieID = 'TRGRT', @actorFirstName = 'Glen', @actorLastName = 'Campbell';
EXECUTE usp_addMovieActor @movieID = 'SonKElder', @actorFirstName = 'John', @actorLastName = 'Wayne';
EXECUTE usp_addMovieActor @movieID = 'SonKElder', @actorFirstName = 'Dean', @actorLastName = 'Martin';
EXECUTE usp_addMovieActor @movieID = 'Avngrs', @actorFirstName = 'Robert', @actorLastName = 'Downey Jr.';
EXECUTE usp_addMovieActor @movieID = 'Avngrs', @actorFirstName = 'Chris', @actorLastName = 'Evans';
EXECUTE usp_addMovieActor @movieID = 'GrtstShwman', @actorFirstName = 'Hugh', @actorLastName = 'Jackman';
EXECUTE usp_addMovieActor @movieID = 'GrtstShwman', @actorFirstName = 'Michelle', @actorLastName = 'Williams';
EXECUTE usp_addMovieActor @movieID = 'XMEN', @actorFirstName = 'Patrick', @actorLastName = 'Stewart';
EXECUTE usp_addMovieActor @movieID = 'XMEN', @actorFirstName = 'Hugh', @actorLastName = 'Jackman';
EXECUTE usp_addMovieActor @movieID = 'Incrdbles2', @actorFirstName = 'Craig T', @actorLastName = 'Nelson';
EXECUTE usp_addMovieActor @movieID = 'Incrdbles2', @actorFirstName = 'Holly', @actorLastName = 'Hunter';
EXECUTE usp_addMovieActor @movieID = 'Deadpl', @actorFirstName = 'Ryan', @actorLastName = 'Reynolds';
EXECUTE usp_addMovieActor @movieID = 'Deadpl', @actorFirstName = 'Glen', @actorLastName = 'Campbell';
EXECUTE usp_addMovieActor @movieID = 'StrWrsIVNwHp', @actorFirstName = 'Mark', @actorLastName = 'Hamill';
EXECUTE usp_addMovieActor @movieID = 'StrWrsIVNwHp', @actorFirstName = 'Carrie', @actorLastName = 'Fisher';
-----------End MovieActor Procedure
-----------Add MovieDirector Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieDirector'
	)
	DROP PROCEDURE usp_addMovieDirector;

GO
CREATE PROCEDURE usp_addMovieDirector
@movieID nvarchar(12),
@directorFirstName nvarchar(25),
@directorLastName nvarchar(255)

AS
BEGIN
	DECLARE @pbMovie_id int,
			@pbDirector_id int;

	SELECT @pbMovie_id = pbMovie_id FROM PbMovie 
	WHERE movieID = @movieID;
	SELECT @pbDirector_id = pbDirector_id FROM PbDirector
	WHERE directorFirstName = @directorFirstName AND directorLastName = @directorLastName;

	BEGIN TRY
		INSERT INTO dbo.PbMovieDirector
			(pbMovie_id, pbDirector_id, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbMovie_id, @pbDirector_id,'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbMovieDirector FAILED')
	END CATCH

END

GO

EXECUTE usp_addMovieDirector @movieID = 'TRGRT', @directorFirstName = 'Henry', @directorLastName = 'Hathaway';
EXECUTE usp_addMovieDirector @movieID = 'SonKElder', @directorFirstName = 'Henry', @directorLastName = 'Hathaway';
EXECUTE usp_addMovieDirector @movieID = 'Avngrs', @directorFirstName = 'Joss', @directorLastName = 'Whedon';
EXECUTE usp_addMovieDirector @movieID = 'GrtstShwman', @directorFirstName = 'Michael', @directorLastName = 'Gracey';
EXECUTE usp_addMovieDirector @movieID = 'XMEN', @directorFirstName = 'Bryan', @directorLastName = 'Singer';
EXECUTE usp_addMovieDirector @movieID = 'Incrdbles2', @directorFirstName = 'Brad', @directorLastName = 'Bird';
EXECUTE usp_addMovieDirector @movieID = 'Deadpl', @directorFirstName = 'Tim', @directorLastName = 'Miller';
EXECUTE usp_addMovieDirector @movieID = 'StrWrsIVNwHp', @directorFirstName = 'George', @directorLastName = 'Lucas';
-----------End MovieDirector Procedure
-----------Add MovieKeyword Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieKeyword'
	)
	DROP PROCEDURE usp_addMovieKeyword;

GO
CREATE PROCEDURE usp_addMovieKeyword
@keyword nvarchar(25),
@movieID nvarchar(12)

AS
BEGIN
	DECLARE @pbMovie_id int,
			@pbKeyword_id int;

	SELECT @pbMovie_id = pbMovie_id FROM PbMovie 
	WHERE movieID = @movieID;
	SELECT @pbKeyword_id = pbKeyword_id FROM PbKeyword
	WHERE keyword = @keyword;

	BEGIN TRY
		INSERT INTO dbo.PbMovieKeyword
			(pbMovie_id, pbKeyword_id, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbMovie_id, @pbKeyword_id,'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbMovieDirector FAILED')
	END CATCH

END

GO

EXECUTE usp_addMovieKeyword @movieID = 'TRGRT', @keyword ='Rooster Cogburn';
EXECUTE usp_addMovieKeyword @movieID = 'TRGRT', @keyword ='US Marshal';
EXECUTE usp_addMovieKeyword @movieID = 'TRGRT', @keyword ='Oscar Award Winner';
EXECUTE usp_addMovieKeyword @movieID = 'SonKElder', @keyword ='Gun Fighter';
EXECUTE usp_addMovieKeyword @movieID = 'SonKElder', @keyword ='Family';
EXECUTE usp_addMovieKeyword @movieID = 'Avngrs', @keyword ='Captain America';
EXECUTE usp_addMovieKeyword @movieID = 'Avngrs', @keyword ='Iron Man';
EXECUTE usp_addMovieKeyword @movieID = 'Avngrs', @keyword ='Thor';
EXECUTE usp_addMovieKeyword @movieID = 'GrtstShwman', @keyword ='Circus';
EXECUTE usp_addMovieKeyword @movieID = 'GrtstShwman', @keyword ='Barnum';
EXECUTE usp_addMovieKeyword @movieID = 'GrtstShwman', @keyword ='Singing';
EXECUTE usp_addMovieKeyword @movieID = 'GrtstShwman', @keyword ='Million Dreams';
EXECUTE usp_addMovieKeyword @movieID = 'XMEN', @keyword ='Wolverine';
EXECUTE usp_addMovieKeyword @movieID = 'XMEN', @keyword ='Mutants';
EXECUTE usp_addMovieKeyword @movieID = 'Incrdbles2', @keyword ='Elastigirl';
EXECUTE usp_addMovieKeyword @movieID = 'Incrdbles2', @keyword ='Dash';
EXECUTE usp_addMovieKeyword @movieID = 'Incrdbles2', @keyword ='Jack Jack';
EXECUTE usp_addMovieKeyword @movieID = 'Deadpl', @keyword ='Mercinary';
EXECUTE usp_addMovieKeyword @movieID = 'Deadpl', @keyword ='Morbid';
EXECUTE usp_addMovieKeyword @movieID = 'Deadpl', @keyword ='healing power';
EXECUTE usp_addMovieKeyword @movieID = 'StrWrsIVNwHp', @keyword ='Jedi Knight';
EXECUTE usp_addMovieKeyword @movieID = 'StrWrsIVNwHp', @keyword ='Darth Vader';
EXECUTE usp_addMovieKeyword @movieID = 'StrWrsIVNwHp', @keyword ='Yoda';

-----------End MovieKeyword Procedure
-----------Add MovieGenre Procedure
IF EXISTS(
	SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieGenre'
	)
	DROP PROCEDURE usp_addMovieGenre;

GO
CREATE PROCEDURE usp_addMovieGenre
@movieID nvarchar(12),
@genre nvarchar(25)

AS
BEGIN
	DECLARE @pbMovie_id int,
			@pbGenre_id int;

	SELECT @pbMovie_id = pbMovie_id FROM PbMovie 
	WHERE movieID = @movieID;
	SELECT @pbGenre_id = pbGenre_id FROM PbGenre
	WHERE genre = @genre;

	BEGIN TRY
		INSERT INTO dbo.PbMovieGenre
			(pbMovie_id, pbGenre_id, lastUpdatedBy, lastUpdatedDate)
			VALUES(@pbMovie_id, @pbGenre_id, 'RLAUB', GETDATE());
	END TRY

	BEGIN CATCH
		PRINT('INSERT INTO pbMovieGenre FAILED')
	END CATCH

END

GO

EXECUTE usp_addMovieGenre @movieID = 'TRGRT', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'TRGRT', @genre ='Drama';
EXECUTE usp_addMovieGenre @movieID = 'TRGRT', @genre ='Western';
EXECUTE usp_addMovieGenre @movieID = 'SonKElder', @genre ='Western';
EXECUTE usp_addMovieGenre @movieID = 'Avngrs', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'Avngrs', @genre ='Action';
EXECUTE usp_addMovieGenre @movieID = 'Avngrs', @genre ='Sci-Fi';
EXECUTE usp_addMovieGenre @movieID = 'GrtstShwman', @genre ='Biography';
EXECUTE usp_addMovieGenre @movieID = 'GrtstShwman', @genre ='Drama';
EXECUTE usp_addMovieGenre @movieID = 'GrtstShwman', @genre ='Musical';
EXECUTE usp_addMovieGenre @movieID = 'XMEN', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'XMEN', @genre ='Action';
EXECUTE usp_addMovieGenre @movieID = 'XMEN', @genre ='Sci-Fi';
EXECUTE usp_addMovieGenre @movieID = 'Incrdbles2', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'Incrdbles2', @genre ='Action';
EXECUTE usp_addMovieGenre @movieID = 'Incrdbles2', @genre ='Animation';
EXECUTE usp_addMovieGenre @movieID = 'Deadpl', @genre ='Action';
EXECUTE usp_addMovieGenre @movieID = 'Deadpl', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'Deadpl', @genre ='Comedy';
EXECUTE usp_addMovieGenre @movieID = 'StrWrsIVNwHp', @genre ='Action';
EXECUTE usp_addMovieGenre @movieID = 'StrWrsIVNwHp', @genre ='Adventure';
EXECUTE usp_addMovieGenre @movieID = 'StrWrsIVNwHp', @genre ='Fantasy';
-----------End MovieGenre Procedure

-------------------------------------------------------------------------------------
-- Assignment 8
-------------------------------------------------------------------------------------


----------------------------
---Create a view
----------------------------
IF EXISTS
	(SELECT * FROM sys.sysobjects
	WHERE id=OBJECT_ID(N'udv_movieActor'))
	DROP VIEW dbo.udv_movieActor;

GO
CREATE VIEW dbo.udv_movieActor
AS

SELECT actorFirstName AS "First Name", actorLastName AS "Last Name", title AS "Movie Title"
FROM pbActor a INNER JOIN pbMovieActor ma
ON a.pbActor_id = ma.pbActor_id
INNER JOIN pbMovie m
ON m.pbMovie_id = ma.pbMovie_id;

GO

SELECT * FROM dbo.udv_movieActor;

-------Rental History view
IF EXISTS
	(SELECT * FROM sys.sysobjects
	WHERE id=OBJECT_ID(N'udv_rentalHistory'))
	DROP VIEW dbo.udv_rentalHistory;
	
GO
CREATE VIEW dbo.udv_rentalHistory
AS


SELECT rh.pbMovieItem_id, title, rh.pbUser_id, userFirstName, userLastName
FROM PbRentalHistory rh INNER JOIN PbUser u
ON rh.pbUser_id = u.pbUser_id
INNER JOIN PbMovieItem mi
ON rh.pbMovieItem_id = mi.pbMovieItem_id
INNER JOIN pbMovie mo
ON mi.pbMovie_id = mo.pbMovie_id


GO




----------------------------
---Create a function
----------------------------
--Create a function to return the pbUser_id when given a UserID.  Name the function udf_getUserID.
IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getUserID')
	)
	DROP FUNCTION dbo.udf_getUserID;

GO
CREATE FUNCTION udf_getUserID (@userId nvarchar(9))
RETURNS int
AS
	BEGIN
		DECLARE @pbUser_id int;
			SELECT @pbUser_id = pbUser_id
				FROM PbUser
				WHERE userId = @userId;
			IF @pbUser_id IS NULL 
			SET @pbUser_id = -1;
			RETURN @pbUser_id;
		END

GO

--SELECT dbo.udf_getUserID('PB0000001');
--Create a function to return the pbMovieItem_id when given a MovieID, MovieType and CopyNumber.  Name the function udf_getMovieItemID.

IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getMovieItemID')
	)
	DROP FUNCTION dbo.udf_getMovieItemID;

GO
CREATE FUNCTION udf_getMovieItemID (@movieID nvarchar(12), @movieType nvarchar(1), @copyNumber int)
RETURNS int
AS
	BEGIN
		DECLARE @pbMovieItem_id int;
			SELECT @pbMovieItem_id = pbMovieItem_id
				FROM PbMovieItem
				WHERE (pbMovie_id = (SELECT pbMovie_id
									FROM PbMovie
									WHERE movieID = @movieID))
				AND movieType = @movieType
				AND copyNumber = @copyNumber;
			IF @pbMovieItem_id IS NULL 
			SET @pbMovieItem_id = -1;
			RETURN @pbMovieItem_id;
		END

GO



--Create a function to return the pbMovie_id when give a movieTitle. Name the function udf_getMovieID.
IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getMovieID')
	)
	DROP FUNCTION dbo.udf_getMovieID;

GO
CREATE FUNCTION udf_getMovieID (@title nvarchar(255))
RETURNS int
AS
	BEGIN
		DECLARE @pbMovie_id int;
			SELECT @pbMovie_id = pbMovie_id
				FROM PbMovie
				WHERE title = @title;
			IF @pbMovie_id IS NULL 
			SET @pbMovie_id = -1;
			RETURN @pbMovie_id;
		END

GO

--Create a function to return the pbActor_id when given an actorFirstName and actorLastName. Name the function udf_getActorID.
IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getActorID')
	)
	DROP FUNCTION dbo.udf_getActorID;

GO
CREATE FUNCTION udf_getActorID (@actorFirstName nvarchar(25), @actorLastName nvarchar(50))
RETURNS int
AS
	BEGIN
		DECLARE @pbActor_id int;
			SELECT @pbActor_id = pbActor_id
				FROM PbActor
				WHERE actorFirstName = @actorFirstName
				AND actorLastName = @actorLastName;
			IF @pbActor_id IS NULL 
			SET @pbActor_id = -1;
			RETURN @pbActor_id;
		END

GO

--Create a function to return the pbDirector_id when given an directorFirstName and directorLastName. Name the function udf_getDirectorID.
IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getDirectorID')
	)
	DROP FUNCTION dbo.udf_getDirectorID;

GO
CREATE FUNCTION udf_getDirectorID (@directorFirstName nvarchar(25), @directorLastName nvarchar(50))
RETURNS int
AS
	BEGIN
		DECLARE @pbDirector_id int;
			SELECT @pbDirector_id = pbDirector_id
				FROM PbDirector
				WHERE directorFirstName = @directorFirstName
				AND directorLastName = @directorLastName;
			IF @pbDirector_id IS NULL 
			SET @pbDirector_id = -1;
			RETURN @pbDirector_id;
		END

GO

--Create a function to return the pbGenre_id when given a genre Name the function udf_getGenreID.

IF EXISTS	
	(SELECT * FROM sys.sysobjects
	WHERE id = OBJECT_ID(N'udf_getGenreID')
	)
	DROP FUNCTION dbo.udf_getGenreID;

GO
CREATE FUNCTION udf_getGenreID (@genre nvarchar(25))
RETURNS int
AS
	BEGIN
		DECLARE @pbGenre_id int;
			SELECT @pbGenre_id = pbGenre_id
				FROM PbGenre
				WHERE genre = @genre;
			IF @pbGenre_id IS NULL 
			SET @pbGenre_id = -1;
			RETURN @pbGenre_id;
		END

GO



----------------------------
---Create a Trigger
----------------------------
/*
CREATE TRIGGER udt_DoSomething
ON TABLE or VIEW

FOR | AFTER | INSTEAD OF | (INSERT|UPDATE|DELETE)

AFTER INSERT
INSTEAD OF INSERT

SELECT * FROM sys.sysobjects 
WHERE id = OBJECT_ID(N'udt_reservationHistory')
DROP TRIGGER dbo.udt_reservationHistory;
GO

CREATE TRIGGER dbo.udt_reservationHistory
ON dbo.PbMovieReservation
AFTER INSERT

AS
	BEGIN 
		INSERT INTO dbo.PbReservationHistory
		(
		pbUser_id,
		pbMovie_id,
		movieType,
		reservationDate,
		lastUpdatedBy,
		lastUpdatedDate
		)
		(SELECT pbUser_id, pbMovie_id, movieType, reservationDate, lastUpdatedBy, lastUpdatedDate
		FROM inserted)
	END
-------------------------	*/
IF EXISTS(
SELECT * FROM sys.sysobjects 
WHERE id = OBJECT_ID(N'udt_rentalHistory'))
DROP TRIGGER dbo.udt_rentalHistory;
GO

CREATE TRIGGER dbo.udt_rentalHistory
ON dbo.PbMovieRental
AFTER INSERT

AS
	BEGIN 
		INSERT INTO dbo.PbRentalHistory
		(
		pbUser_id,
		pbMovieItem_id,
		rentalDate,
		dueDate,
		lastUpdatedBy,
		lastUpdatedDate
		)
		(SELECT pbUser_id, pbMovieItem_id, rentalDate, dueDate, lastUpdatedBy, lastUpdatedDate
		FROM inserted)
	END


	
----------------------------
---Create MovieRental Procedure
----------------------------

IF EXISTS	
	(SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieRentals'
	)
	DROP PROCEDURE dbo.usp_addMovieRentals;
GO

CREATE PROCEDURE usp_addMovieRentals



--need to add other things
@userId nvarchar(9), 
@copyNumber int,
@movieType nvarchar(1),
@movieID nvarchar(12)

AS

BEGIN TRY

	IF (@userId is NULL)
		BEGIN
		PRINT ('Invalid UserId')
		RETURN -1
		END
	
	IF ((SELECT banStatus
		FROM PbUser
		WHERE pbUser_id = dbo.udf_getUserID(@userId)
		) = 'B')
	BEGIN
	PRINT('Banned users cannot rent a movie')
	RETURN -1
	END
	

	IF (( SELECT customerType
		FROM PbUser 
		WHERE pbUser_id = dbo.udf_getUserID(@userId)
		) = 'S')
	BEGIN
		IF ((SELECT COUNT(*)
		FROM pbMovieRental
		WHERE pbUser_id = dbo.udf_getUserID(@userId)
		AND returnDate IS NULL) >= 2)
		
		
		BEGIN
		PRINT('Standard Customers can not rent more than 2 movies')
		RETURN -1
		END
		
	END
	
	ELSE
		BEGIN
		IF ((SELECT COUNT(*)
		FROM pbMovieRental
		WHERE pbUser_id = dbo.udf_getUserID(@userId)
		AND returnDate IS NULL) >= 4)
		
		
		BEGIN
		PRINT('Premium Customers can not rent more than 4 movies')
		RETURN -1
		END
		
	END



INSERT INTO PbMovieRental
	(pbUser_id, pbMovieItem_id, rentalDate, dueDate, returnDate, lastUpdatedBy, lastUpdatedDate)
	VALUES
	(dbo.udf_getUserID(@userId),
	 dbo.udf_getMovieItemID(@movieID, @movieType, @copyNumber), 
	 GETDATE(),
	 GETDATE()+3,
	 NULL,
	 'RLAUB',
	 GETDATE()
	 );

END TRY

BEGIN CATCH
PRINT ('Insert into MovieRental Failed');
END CATCH

---Stored Procedure for pbMovieReservation

IF EXISTS	
	(SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'usp_addMovieReservation'
	)
	DROP PROCEDURE dbo.usp_addMovieReservation;
GO

CREATE PROCEDURE usp_addMovieReservation
--Variables
@userID nvarchar(9),
@title nvarchar(255),
@movieType nvarchar(1)
AS

BEGIN TRY
	IF (( SELECT customerType
		FROM PbUser 
		WHERE pbUser_id = dbo.udf_getUserID(@userId)
		) = 'P')
		BEGIN
			IF ((SELECT COUNT(*)
			FROM pbMovieReservation
			WHERE pbUser_id = dbo.udf_getUserID(@userId)
			AND reservationDate IS NULL) >= 4)
		
		
			BEGIN
			PRINT('Premium Customers can not reserve more than 4 movies')
			RETURN -1
			END
		END
	
	ELSE
		BEGIN
		IF ((SELECT COUNT(*)
			FROM pbMovieReservation
			WHERE pbUser_id = dbo.udf_getUserID(@userId)
			AND reservationDate IS NULL) >= 0)
		BEGIN
		PRINT('Standard Customers can not reserve movies')
		RETURN -1
		END
		END
	

INSERT INTO PbMovieReservation
	(pbMovie_id, pbUser_id, reservationDate, movieType, lastUpdatedBy, lastUpdatedDate)
	VALUES
	(dbo.udf_getMovieID(@title),
	dbo.udf_getUserID(@userId),
	GETDATE(),
	@movieType,
	'RLAUB',
	GETDATE()
	)
END TRY

BEGIN CATCH
PRINT('Insert into MovieReservation Failed');
END CATCH


-------SQL Statements calls & inserts

--SQL statement to call your reservation procedure under valid conditions, according to the scenario.


EXECUTE usp_addMovieReservation @title = 'Incredibles 2', @userId = 'PB0000001', @movieType = 'D';


--SQL statements to call your reservation procedure under each invalid condition, according to the scenario.

EXECUTE usp_addMovieReservation @title = 'Deadpool', @userId = 'PB0000027', @movieType = 'B';


--SQL statement to call your rental routine under valid conditions, according to the scenario.

EXECUTE usp_addMovieRentals @userId = 'PB0000027', @copyNumber = '1', @movieType = 'B', @movieID = 'XMEN';


-- SQL statements to call your rental routine under each invalid condition, according to the scenario.


EXECUTE usp_addMovieRentals @userId = 'PB0000033', @copyNumber = '2', @movieType = 'D', @movieID = 'TRGRT';

-- SQL Statements to insert 6 movie rentals for valid users so that the Rental History table will have data in it.

EXECUTE usp_addMovieRentals @userId = 'PB0000027', @copyNumber = 1, @movieType = 'B', @movieID = 'XMEN';
EXECUTE usp_addMovieRentals @userId = 'PB0000021', @copyNumber = 2, @movieType = 'D', @movieID = 'XMEN';
EXECUTE usp_addMovieRentals @userId = 'PB0000101', @copyNumber = 2, @movieType = 'B', @movieID = 'TRGRT';
EXECUTE usp_addMovieRentals @userId = 'PB0000177', @copyNumber = 1, @movieType = 'D', @movieID = 'Deadpl';
EXECUTE usp_addMovieRentals @userId = 'PB0000021', @copyNumber = 1, @movieType = 'B', @movieID = 'Avngrs';
EXECUTE usp_addMovieRentals @userId = 'PB0000001', @copyNumber = 1, @movieType = 'D', @movieID = 'SonKElder';

--SQL Statements to query your MovieReservation and MovieRental tables to show all records.

SELECT * FROM dbo.PbMovieReservation
SELECT * FROM dbo.PbMovieRental


--SQL Statement to query the rental history view.
SELECT * FROM udv_rentalHistory;