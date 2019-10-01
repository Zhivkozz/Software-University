CREATE DATABASE TripService;

USE TripService;

CREATE TABLE Cities
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(20) NOT NULL,
	CountryCode CHAR(2) NOT NULL
);

CREATE TABLE Hotels
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(30) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES [dbo].[Cities]([Id]) NOT NULL,
	EmployeeCount INT NOT NULL,
	BaseRate DECIMAL(15, 2)
);

CREATE TABLE Rooms
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Price DECIMAL(15, 2) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	Beds INT NOT NULL,
	HotelId INT FOREIGN KEY REFERENCES [dbo].[Hotels]([Id]) NOT NULL
);

CREATE TABLE Trips
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	RoomId INT FOREIGN KEY REFERENCES [dbo].[Rooms]([Id]) NOT NULL,
	BookDate DATE NOT NULL,
	ArrivalDate DATE NOT NULL,
	ReturnDate DATE NOT NULL,
	CancelDate DATE,
	CONSTRAINT CHK_BookDate CHECK (BookDate < ArrivalDate),
	CONSTRAINT CHK_ArrivalDate CHECK (ArrivalDate < ReturnDate)
);

CREATE TABLE Accounts
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(50) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES [dbo].[Cities]([Id]) NOT NULL,
	BirthDate DATE NOT NULL,
	Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE AccountsTrips
(
	AccountId INT FOREIGN KEY REFERENCES [dbo].[Accounts]([Id]) NOT NULL,
	TripId INT FOREIGN KEY REFERENCES [dbo].[Trips]([Id]) NOT NULL,
	Luggage INT NOT NULL CHECK(Luggage >= 0),
	CONSTRAINT PK_AccountsTrips PRIMARY KEY (AccountId, TripId)
);