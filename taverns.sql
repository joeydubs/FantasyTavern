DROP TABLE IF EXISTS ServiceSupplies;
DROP TABLE IF EXISTS ClassAssignments;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Notes;
DROP TABLE IF EXISTS SaleItems;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS GuestStatuses;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Statuses;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Rats;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Locations;

--/////////////////////////////////////////////////////
-- Locations Seed

CREATE TABLE Locations (
	locationID INT IDENTITY(1,1) PRIMARY KEY,
	town VARCHAR(100),
	country VARCHAR(100)
);

INSERT INTO Locations (town, country)
VALUES ('Solace', 'Abanasinia');

INSERT INTO Locations (town, country)
VALUES ('Diagon Alley', 'England');

INSERT INTO Locations (town, country)
VALUES ('Bywater', 'Shire');

INSERT INTO Locations (town, country)
VALUES ('Hogsmeade', 'Britain');

INSERT INTO Locations (town, country)
VALUES ('New York City', 'New York');

--/////////////////////////////////////////////////////
-- Roles Seed

CREATE TABLE Roles (
	roleID INT IDENTITY(1,1) PRIMARY KEY,
	roleName VARCHAR(100),
	roleDescription VARCHAR(240)
);

INSERT INTO Roles (roleName, roleDescription)
VALUES ('Owner', 'This Role is a Tavern owner');

INSERT INTO Roles (roleName, roleDescription)
VALUES ('Manager', 'This Role runs the Tavern');

INSERT INTO Roles (roleName, roleDescription)
VALUES ('Bar Tender', 'This Role manages the bar and bar sales');

INSERT INTO Roles (roleName, roleDescription)
VALUES ('Inn Keeper', 'This Roles manages room rentals');

INSERT INTO Roles (roleName, roleDescription)
VALUES ('Stable Master', 'This Role tends the Stables');

--/////////////////////////////////////////////////////
-- Users Seed

CREATE TABLE Users (
	userID INT IDENTITY(1,1) PRIMARY KEY,
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	username VARCHAR(100) NOT NULL UNIQUE,
	userPassword VARCHAR(20),
	roleID INT FOREIGN KEY REFERENCES Roles(roleID)
);

INSERT INTO Users (firstName, lastName, username, userPassword, roleID)
SELECT 'Otik', 'Sandath', 'osandath', 'SecurePassword1', Roles.roleID
FROM Roles
WHERE roleName = 'Owner';

INSERT INTO Users (firstName, lastName, username, userPassword, roleID)
SELECT 'Daisy', 'Dodderidge', 'ddodderidge', 'SecurePassword2', Roles.roleID
FROM Roles
WHERE roleName = 'Owner';

INSERT INTO Users (firstName, lastName, username, userPassword, roleID)
SELECT 'Samwise', 'Gamgee', 'sgamgee', 'SecurePassword3', Roles.roleID
FROM Roles
WHERE roleName = 'Owner';

INSERT INTO Users (firstName, lastName, username, userPassword, roleID)
SELECT 'Madam', 'Rosmerta', 'mrosmerta', 'SecurePassword4', Roles.roleID
FROM Roles
WHERE roleName = 'Owner';

INSERT INTO Users (firstName, lastName, username, userPassword, roleID)
SELECT 'Carl', 'MacLaren', 'cmaclaren', 'SecurePassword5', Roles.roleID
FROM Roles
WHERE roleName = 'Owner';

--/////////////////////////////////////////////////////
-- Taverns Seed

CREATE TABLE Taverns (
	tavernID INT IDENTITY(1,1) PRIMARY KEY,
	tavernName VARCHAR(100),
	numFloors INT,
	locationID INT FOREIGN KEY REFERENCES Locations(locationID),
	ownerID INT FOREIGN KEY REFERENCES Users(userID)
);

INSERT INTO Taverns (tavernName, numFloors, locationID, ownerID)
SELECT 'Inn of the Last Home', 3, Locations.locationID, Users.userID
FROM Locations, Users
WHERE Locations.town = 'Solace'
AND Users.username = 'osandath';

INSERT INTO Taverns (tavernName, numFloors, locationID, ownerID)
SELECT 'The Leaky Cauldron', 2, Locations.locationID, Users.userID
FROM Locations, Users
WHERE Locations.town = 'Diagon Alley'
AND Users.username = 'ddodderidge';

INSERT INTO Taverns (tavernName, numFloors, locationID, ownerID)
SELECT 'The Green Dragon Inn', 1, Locations.locationID, Users.userID
FROM Locations, Users
WHERE Locations.town = 'Bywater'
AND Users.username = 'sgamgee';

INSERT INTO Taverns (tavernName, numFloors, locationID, ownerID)
SELECT 'The Three Broomsticks', 2, Locations.locationID, Users.userID
FROM Locations, Users
WHERE Locations.town = 'Hogsmeade'
AND Users.username = 'mrosmerta';

INSERT INTO Taverns (tavernName, numFloors, locationID, ownerID)
SELECT 'MacLaren''s Pub', 1, Locations.locationID, Users.userID
FROM Locations, Users
WHERE Locations.town = 'New York City'
AND Users.username = 'cmaclaren';

--/////////////////////////////////////////////////////
-- Rats Seed

CREATE TABLE Rats (
	ratID INT IDENTITY(1,1) PRIMARY KEY,
	ratName VARCHAR(100),
	tavernID INT FOREIGN KEY REFERENCES Taverns(tavernID)
);

INSERT INTO Rats (ratName, tavernID)
SELECT 'Nigel Ratburn', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Leaky Cauldron';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Remy', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Three Broomsticks';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Nicodemus', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'MacLaren''s Pub';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Master Splinter', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'Inn of the Last Home';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Gus-Gus', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Leaky Cauldron';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Professor Ratigan', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Green Dragon Inn';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Rizzo', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Green Dragon Inn';

INSERT INTO Rats (ratName, tavernID)
SELECT 'Peter Pettigrew', Taverns.tavernID
FROM Taverns
WHERE tavernName = 'The Three Broomsticks';

--/////////////////////////////////////////////////////
-- Supplies Seed

CREATE TABLE Supplies (
	supplyID INT IDENTITY(1,1) PRIMARY KEY,
	unitOfMeasure VARCHAR(25),
	supplyName VARCHAR(100)
);

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Roll', 'Toilet Paper');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Keg', 'Dark Ale');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Keg', 'Butterbeer');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Pound', 'Flour');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Carton', 'Eggs');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Case', 'Mugs');

INSERT INTO Supplies (unitOfMeasure, supplyName)
VALUES ('Bundle', 'Firewood');

--/////////////////////////////////////////////////////
-- Inventory Seed

CREATE TABLE Inventory (
	supplyID INT FOREIGN KEY REFERENCES Supplies(supplyID),
	tavernID INT FOREIGN KEY REFERENCES Taverns(tavernID),
	quantity INT,
	lastUpdated DATETIME,
	lastValidated DATETIME
);

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 5, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Firewood'
AND Taverns.tavernName = 'The Leaky Cauldron';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 15, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Toilet Paper'
AND Taverns.tavernName = 'MacLaren''s Pub';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 3, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Dark Ale'
AND Taverns.tavernName = 'The Three Broomsticks';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 4, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Dark Ale'
AND Taverns.tavernName = 'The Leaky Cauldron';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 6, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Butterbeer'
AND Taverns.tavernName = 'The Three Broomsticks';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 13, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Mugs'
AND Taverns.tavernName = 'The Leaky Cauldron';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 4, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Dark Ale'
AND Taverns.tavernName = 'MacLaren''s Pub';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 5, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Dark Ale'
AND Taverns.tavernName = 'Inn of the Last Home';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 17, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Mugs'
AND Taverns.tavernName = 'Inn of the Last Home';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 2, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Butterbeer'
AND Taverns.tavernName = 'The Green Dragon Inn';

INSERT INTO Inventory (supplyID, tavernID, quantity, lastUpdated, lastValidated)
SELECT Supplies.supplyID, Taverns.tavernID, 10, GETDATE(), NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Flour'
AND Taverns.tavernName = 'The Green Dragon Inn';

--/////////////////////////////////////////////////////
-- Orders Seed

CREATE TABLE Orders (
	orderID INT IDENTITY(1,1) PRIMARY KEY,
	supplyID INT FOREIGN KEY REFERENCES Supplies(supplyID),
	tavernID INT FOREIGN KEY REFERENCES Taverns(tavernID),
	cost DECIMAL,
	quantity INT,
	dateReceived DATETIME
);

INSERT INTO Orders (supplyID, tavernID, cost, quantity, dateReceived)
SELECT Supplies.supplyID, Taverns.tavernID, 4.23, 2, NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Eggs'
AND Taverns.tavernName = 'Inn of the Last Home'

INSERT INTO Orders (supplyID, tavernID, cost, quantity, dateReceived)
SELECT Supplies.supplyID, Taverns.tavernID, 12.50, 24, NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Toilet Paper'
AND Taverns.tavernName = 'The Leaky Cauldron'

INSERT INTO Orders (supplyID, tavernID, cost, quantity, dateReceived)
SELECT Supplies.supplyID, Taverns.tavernID, 43.26, 2, NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Mugs'
AND Taverns.tavernName = 'The Three Broomsticks'

INSERT INTO Orders (supplyID, tavernID, cost, quantity, dateReceived)
SELECT Supplies.supplyID, Taverns.tavernID, 15.50, 2, NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Firewood'
AND Taverns.tavernName = 'MacLaren''s Pub'

INSERT INTO Orders (supplyID, tavernID, cost, quantity, dateReceived)
SELECT Supplies.supplyID, Taverns.tavernID, 63.25, 3, NULL
FROM Supplies, Taverns
WHERE Supplies.supplyName = 'Dark Ale'
AND Taverns.tavernName = 'The Green Dragon Inn'

--/////////////////////////////////////////////////////
-- Statuses Seed

CREATE TABLE Statuses (
	statusID INT IDENTITY(1,1) PRIMARY KEY,
	statusName VARCHAR(50)
);

INSERT INTO Statuses (statusName)
VALUES ('Active');

INSERT INTO Statuses (statusName)
VALUES ('Inactive');

INSERT INTO Statuses (statusName)
VALUES ('Out of Stock');

INSERT INTO Statuses (statusName)
VALUES ('On Order');

--/////////////////////////////////////////////////////
-- Services Seed

CREATE TABLE Services (
	serviceID INT IDENTITY(1,1) PRIMARY KEY,
	serviceName VARCHAR(100),
	tavernID INT FOREIGN KEY REFERENCES Taverns(tavernID),
	currentStatus INT FOREIGN KEY REFERENCES Statuses(statusID)
);

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Pint of Dark Ale', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Green Dragon Inn'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Boot Shining', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'MacLaren''s Pub'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Conference Room', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Three Broomsticks'
AND Statuses.statusName = 'Inactive';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Room', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Leaky Cauldron'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Weapon Sharpening', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'Inn of the Last Home'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Spa', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'Inn of the Last Home'
AND Statuses.statusName = 'Inactive';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Party Room', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Green Dragon Inn'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Pint of Butterbeer', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'MacLaren''s Pub'
AND Statuses.statusName = 'Out of Stock';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Room', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Three Broomsticks'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Laundry', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'The Leaky Cauldron'
AND Statuses.statusName = 'Active';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Pint of Dark Ale', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'Inn of the Last Home'
AND Statuses.statusName = 'On Order';

INSERT INTO Services (serviceName, tavernID, currentStatus)
SELECT 'Room', Taverns.tavernID, Statuses.statusID
FROM Statuses, Taverns
WHERE Taverns.tavernName = 'Inn of the Last Home'
AND Statuses.statusName = 'Active';

--/////////////////////////////////////////////////////
-- Guests Seed

CREATE TABLE Guests (
	guestID INT IDENTITY(1,1) PRIMARY KEY,
	firstName VARCHAR(50),
	lastName VARCHAR(50)
);

INSERT INTO Guests (firstName, lastName)
VALUES ('Sirius', 'Black');

INSERT INTO Guests (firstName, lastName)
VALUES ('Frodo', 'Baggins');

INSERT INTO Guests (firstName, lastName)
VALUES ('Ted', 'Mosby');

INSERT INTO Guests (firstName, lastName)
VALUES ('James', 'Bond');

INSERT INTO Guests (firstName, lastName)
VALUES ('Han', 'Solo');

INSERT INTO Guests (firstName, lastName)
VALUES ('Sherlock', 'Holmes');

INSERT INTO Guests (firstName, lastName)
VALUES ('Geoffrey', 'Chaucer');

--/////////////////////////////////////////////////////
-- Sales Seed

CREATE TABLE Sales (
	saleID INT IDENTITY(1,1) PRIMARY KEY,
	amount DECIMAL,
	guestID INT FOREIGN KEY REFERENCES Guests(guestID),
	tavernID INT FOREIGN KEY REFERENCES Taverns(tavernID)
);

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 12.53, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 7
AND Taverns.tavernID = 1;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 17.32, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 1
AND Taverns.tavernID = 3;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 42.71, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 3
AND Taverns.tavernID = 4;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 23.74, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 2
AND Taverns.tavernID = 5;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 4.62, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 6
AND Taverns.tavernID = 2;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 47.32, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 4
AND Taverns.tavernID = 1;

INSERT INTO Sales (amount, guestID, tavernID)
SELECT 94.29, Guests.guestID, Taverns.tavernID
FROM Guests, Taverns
WHERE Guests.guestID = 5
AND Taverns.tavernID = 4;

--/////////////////////////////////////////////////////
-- SaleItems Seed

CREATE TABLE SaleItems (
	saleID INT FOREIGN KEY REFERENCES Sales(saleID),
	serviceID INT FOREIGN KEY REFERENCES Services(serviceID),
	quantity INT
);

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 1
FROM Sales, Services
WHERE Sales.saleID = 1
AND Services.serviceID = 5;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 4
FROM Sales, Services
WHERE Sales.saleID = 1
AND Services.serviceID = 6;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 3
FROM Sales, Services
WHERE Sales.saleID = 1
AND Services.serviceID = 12;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 4
FROM Sales, Services
WHERE Sales.saleID = 2
AND Services.serviceID = 1;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 6
FROM Sales, Services
WHERE Sales.saleID = 2
AND Services.serviceID = 7;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 7
FROM Sales, Services
WHERE Sales.saleID = 3
AND Services.serviceID = 9;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 7
FROM Sales, Services
WHERE Sales.saleID = 4
AND Services.serviceID = 2;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 5
FROM Sales, Services
WHERE Sales.saleID = 4
AND Services.serviceID = 8;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 34
FROM Sales, Services
WHERE Sales.saleID = 5
AND Services.serviceID = 4;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 3
FROM Sales, Services
WHERE Sales.saleID = 5
AND Services.serviceID = 10;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 5
FROM Sales, Services
WHERE Sales.saleID = 6
AND Services.serviceID = 11;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 4
FROM Sales, Services
WHERE Sales.saleID = 7
AND Services.serviceID = 3;

INSERT INTO SaleItems (saleID, serviceID, quantity)
SELECT Sales.saleID, Services.serviceID, 1
FROM Sales, Services
WHERE Sales.saleID = 7
AND Services.serviceID = 9;

--/////////////////////////////////////////////////////

DROP TABLE IF EXISTS Rats;

CREATE TABLE Notes (
	noteID INT IDENTITY PRIMARY KEY,
	guestID INT FOREIGN KEY REFERENCES Guests(guestID),
	noteText VARCHAR(240)
);

INSERT INTO Notes (guestID, noteText)
VALUES (1, 'Greatest adventurer of all time.')

INSERT INTO Notes (guestID, noteText)
VALUES (1, 'Not much to look at.')

INSERT INTO Notes (guestID, noteText)
VALUES (2, 'Needs constant entertainment.')

INSERT INTO Notes (guestID, noteText)
VALUES (3, 'Likes slaying dragons.')

INSERT INTO Notes (guestID, noteText)
VALUES (4, 'Second greatest adventurer of all time. So close.')

INSERT INTO Notes (guestID, noteText)
VALUES (5, 'Likes pale ale?')

-- This should fail.
-- INSERT INTO Notes (guestID, noteText)
-- VALUES (10, 'This guest doesn''t exist. Unbelievable.')

CREATE TABLE GuestStatuses (
	guestStatusID INT IDENTITY PRIMARY KEY,
	statusName VARCHAR(20)
);

INSERT INTO GuestStatuses (statusName)
VALUES ('Sick');

INSERT INTO GuestStatuses (statusName)
VALUES ('Fine');

INSERT INTO GuestStatuses (statusName)
VALUES ('Bored');

INSERT INTO GuestStatuses (statusName)
VALUES ('Hangry');

INSERT INTO GuestStatuses (statusName)
VALUES ('Drunk');

ALTER TABLE Guests ADD birthday DATETIME;
ALTER TABLE Guests ADD cakeday DATETIME;
ALTER TABLE Guests ADD guestStatusID INT FOREIGN KEY REFERENCES GuestStatuses(guestStatusID);

CREATE TABLE Classes (
	classID INT IDENTITY PRIMARY KEY,
	className VARCHAR(20)
);

INSERT INTO Classes (className)
VALUES ('Mage');

INSERT INTO Classes (className)
VALUES ('Paladin');

INSERT INTO Classes (className)
VALUES ('Warrior');

INSERT INTO Classes (className)
VALUES ('Shaman');

INSERT INTO Classes (className)
VALUES ('Ranger');

CREATE TABLE ClassAssignments (
	classID INT,
	guestID INT,
	currentLevel INT,
	PRIMARY KEY (classID, guestID)
);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (1, 1, 5);

-- This should fail
-- INSERT INTO ClassAssignments (classID, guestID, currentLevel)
-- VALUES (1, 1, 2);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (2, 1, 3);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (2, 2, 34);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (4, 3, 12);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (3, 4, 51);

INSERT INTO ClassAssignments (classID, guestID, currentLevel)
VALUES (5, 5, 21);

CREATE TABLE ServiceSupplies (
	serviceID INT NOT NULL,
	supplyID INT NOT NULL,
	quantity INT
);

ALTER TABLE ServiceSupplies ADD FOREIGN KEY (serviceID) REFERENCES Services(serviceID);
ALTER TABLE ServiceSupplies ADD FOREIGN KEY (supplyID) REFERENCES Supplies(supplyID);
ALTER TABLE ServiceSupplies ADD CONSTRAINT PK_ServiceSupply PRIMARY KEY (serviceID, supplyID);

INSERT INTO ServiceSupplies (serviceID, supplyID, quantity)
VALUES (1, 2, 1);

INSERT INTO ServiceSupplies (serviceID, supplyID, quantity)
VALUES (8, 3, 1);

INSERT INTO ServiceSupplies (serviceID, supplyID, quantity)
VALUES (11, 2, 1);