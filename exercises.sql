--Exercise 1
CREATE DATABASE decodemtl_test;
CREATE DATABASE decodemtl_addressbook;

--Exercise 2
DROP DATABASE decodemtl_test;

--Exercise 3
SHOW databases;

--Exercise 4, 5, 6, 7, 8
USE decodemtl_addressbook;
CREATE TABLE Account(
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    createdOn DATETIME,
    modifiedOn DATETIME
);
CREATE TABLE AddressBook(
    id INT AUTO_INCREMENT PRIMARY KEY,
    accountId INT,
    name VARCHAR(255),
    createdOn DATETIME,
    modifiedOn DATETIME
);
CREATE TABLE Entry(
    id INT AUTO_INCREMENT PRIMARY KEY,
    addressBook INT,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    birthday DATETIME,
    type ENUM('home', 'work', 'other'),
    subtype ENUM('phone', 'address', 'email'),
    contentLineOne VARCHAR(255),
    contentLineTwo VARCHAR(255),
    contentLineThree VARCHAR(255),
    contentLineFour VARCHAR(255),
    contentLineFive VARCHAR(255)
    );
CREATE TABLE Test(
    id INT AUTO_INCREMENT PRIMARY KEY
);

DROP TABLE Test;

SHOW tables;
/*
+---------------------------------+
| Tables_in_decodemtl_addressbook |
+---------------------------------+
| Account                         |
| AddressBook                     |
| Entry                           |
+---------------------------------+*/


--Exercise 9
CREATE DATABASE barn;

USE barn;

CREATE TABLE chicken_barn(
    id INT AUTO_INCREMENT PRIMARY KEY,
    dateOfBirth DATE,
    gender ENUM('F', 'M'),
    quantity INT
);

INSERT INTO chicken_barn 
    (dateOfBirth, gender, quantity)
VALUES 
    ('2017-01-01', 'M', 10),
    ('2017-01-01', 'F', 5),
    ('2017-01-01', 'M', 2),
    ('2017-01-01', 'F', 3),
    ('2017-01-02', 'M', 3),
    ('2017-03-01', 'F', 2);

SELECT dateOfBirth, (select case 1 WHEN gender = 'M' THEN 'Roosters' ELSE 'Chicks' END) as gender, sum(quantity) as quantity
FROM chicken_barn
WHERE dateOfBirth = "2017-01-01"
GROUP BY gender;

/* OUTPUT
+-------------+----------+----------+
| dateOfBirth | gender   | quantity |
+-------------+----------+----------+
| 2017-01-01  | Chicks   |        8 |
| 2017-01-01  | Roosters |       12 |
+-------------+----------+----------+*/

--Exercise 10
CREATE DATABASE hotel;

USE hotel;

-----------------------------Create table rooms 
CREATE TABLE rooms(
    id INT AUTO_INCREMENT PRIMARY KEY,
    startDate DATETIME NOT NULL,
    endDate DATETIME NOT NULL,
    status BOOLEAN NOT NULL,
    floorNumber INT NOT NULL,
    roomNumber INT NOT NULL,
    typeOfRoom INT NOT NULL,
    capacity INT NOT NULL,
    numberOfWindows INT NOT NULL,
    features INT NOT NULL
    -- INDEX type_of_room(typeOfRoom),
    -- FOREIGN KEY (typeOfRoom)
    --     REFERENCES rooms(id)
    --     ON DELETE CASCADE,
    -- INDEX feat(features),
    -- FOREIGN KEY (features)
    --     REFERENCES room_features(id)
    --     ON DELETE CASCADE    
);

-----------------------------check if Foreign keys were created    
SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'hotel'
AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'rooms';

-----------------------------Insert values into the table
INSERT INTO rooms
    (startDate, endDate, status, floorNumber, roomNumber, typeOfRoom, capacity, numberOfWindows, features)
VALUES
    ('2017-07-01 15:00:00', '2017-07-15 15:00:00', 1, 5, 524, 14, 4, 8, 2),
    ('2017-07-01 15:00:00', '2017-07-15 15:00:00', 1, 3, 325, 14, 5, 10, 1),
    ('2017-07-01 15:00:00', '2017-07-05 15:00:00', 0, 4, 442, 14, 3, 7, '3'),
    ('2017-07-01 15:00:00', '2017-07-04 15:00:00', 0, 8, 855, 14, 2, 4, 1),
    ('2017-07-01 15:00:00', '2017-07-15 15:00:00', 1, 7, 785, 14, 4, 8, 2),
    ('2017-07-01 15:00:00', '2017-07-15 15:00:00', 1, 10, 1024, 14, 4, 8, 2),
    ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 10, 1075, 9, 1, 2, 0),
    ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 3, 375, 5, 1, 2, 0);

-----------------------------Create table type_of_rooms
CREATE TABLE room_features(
    id INT AUTO_INCREMENT PRIMARY KEY,
    feature VARCHAR(255)
);

INSERT INTO room_features
    (feature)
VALUES
    ('kitchen'), ('carpets'), ('tv'), ('wi-fi');
    
-----------------------------Create table type_of_rooms
CREATE TABLE type_of_rooms(
    id INT AUTO_INCREMENT PRIMARY KEY,
    typeOfRoom VARCHAR(255)
);

INSERT INTO type_of_rooms
    (typeOfRoom)
VALUES
    ('janitor'), ('closets'), ('public'), ('laundry room'), ('gym'), ('regular'), ('penthouse'), ('vip');
    
-----------------------------The list of Rooms available for rent on a specific date
select date = '2017-07-10 00:00:00'
SELECT * 
FROM rooms 
WHERE date > 



-----------------------------The list of Rooms which can be occupied by at least 3 people on a specific date
-----------------------------The amount of unrentable Rooms (janitor closets, public laundry room, gym, etc.)
-----------------------------The amount of Rooms having a private Kitchen
-----------------------------The average amount of windows per Floor
-----------------------------The amount of Floors having Rooms with carpets
