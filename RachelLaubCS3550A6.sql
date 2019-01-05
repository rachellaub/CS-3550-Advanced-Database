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
	movieID nvarchar(15) NOT NULL,
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

EXECUTE usp_addActor @actorFirstname = 'Denzel', @actorLastName = 'Washington';


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

EXECUTE usp_addMovieItem @movieID = 'TRGRT', @copyNumber = 3, @movieType = 'D';

SELECT * FROM PbMovieItem
WHERE copyNumber = 3;



