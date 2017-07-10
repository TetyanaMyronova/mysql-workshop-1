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
    features INT NOT NULL);
    -- INDEX type_of_room(typeOfRoom),
    -- FOREIGN KEY (typeOfRoom)
    --     REFERENCES rooms(id)
    --     ON DELETE CASCADE,
    -- INDEX feat(features),
    -- FOREIGN KEY (features)
    --     REFERENCES room_features(id)
    --     ON DELETE CASCADE    
-- );

-----------------------------check if Foreign keys were created    
-- SELECT * FROM information_schema.TABLE_CONSTRAINTS 
-- WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
-- AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'hotel'
-- AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'rooms';

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
SELECT *
FROM rooms 
WHERE endDate < "2017-07-10 00:00:00" and status = 0; 

/*+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+
| id | startDate           | endDate             | status | floorNumber | roomNumber | typeOfRoom | capacity | numberOfWindows | features |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+
|  3 | 2017-07-01 15:00:00 | 2017-07-05 15:00:00 |      0 |           4 |        442 |         14 |        3 |               7 |        3 |
|  4 | 2017-07-01 15:00:00 | 2017-07-04 15:00:00 |      0 |           8 |        855 |         14 |        2 |               4 |        1 |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+*/


-----------------------------The list of Rooms which can be occupied by at least 3 people on a specific date
SELECT *
FROM rooms 
WHERE endDate < "2017-07-10 00:00:00" and capacity >= 3; 

/*+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+
| id | startDate           | endDate             | status | floorNumber | roomNumber | typeOfRoom | capacity | numberOfWindows | features |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+
|  3 | 2017-07-01 15:00:00 | 2017-07-05 15:00:00 |      0 |           4 |        442 |         14 |        3 |               7 |        3 |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+*/

-----------------------------The amount of unrentable Rooms (janitor closets, public laundry room, gym, etc.)
SELECT rooms.*, tor.typeOfRoom
FROM rooms
INNER JOIN type_of_rooms tor ON rooms.typeOfRoom=tor.id
WHERE rooms.typeOfRoom NOT IN (14,15,16);

/*+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+------------+
| id | startDate           | endDate             | status | floorNumber | roomNumber | typeOfRoom | capacity | numberOfWindows | features | typeOfRoom |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+------------+
|  7 | 0000-00-00 00:00:00 | 0000-00-00 00:00:00 |      1 |          10 |       1075 |          9 |        1 |               2 |        0 | janitor    |
|  8 | 0000-00-00 00:00:00 | 0000-00-00 00:00:00 |      1 |           3 |        375 |          5 |        1 |               2 |        0 | gym        |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+------------+*/

-----------------------------The amount of Rooms having a private Kitchen
SELECT rooms.*, rf.feature
FROM rooms
INNER JOIN room_features rf ON rooms.features = rf.id
WHERE rooms.features = 1;

/*+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+
| id | startDate           | endDate             | status | floorNumber | roomNumber | typeOfRoom | capacity | numberOfWindows | features | feature |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+
|  2 | 2017-07-01 15:00:00 | 2017-07-15 15:00:00 |      1 |           3 |        325 |         14 |        5 |              10 |        1 | kitchen |
|  4 | 2017-07-01 15:00:00 | 2017-07-04 15:00:00 |      0 |           8 |        855 |         14 |        2 |               4 |        1 | kitchen |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+*/

-----------------------------The average amount of windows per Floor
SELECT floorNumber, sum(numberOfWindows)/max(floorNumber) as AVGnumberOfWindows
FROM rooms
GROUP BY floorNumber;

/*+-------------+--------------------+
| floorNumber | AVGnumberOfWindows |
+-------------+--------------------+
|           3 |             4.0000 |
|           4 |             1.7500 |
|           5 |             1.6000 |
|           7 |             1.1429 |
|           8 |             0.5000 |
|          10 |             1.0000 |
+-------------+--------------------+*/

-----------------------------The amount of windows per Floor
SELECT floorNumber, sum(numberOfWindows) as numberOfWindows
FROM rooms
GROUP BY floorNumber;

/*+-------------+-----------------+
| floorNumber | numberOfWindows |
+-------------+-----------------+
|           3 |              12 |
|           4 |               7 |
|           5 |               8 |
|           7 |               8 |
|           8 |               4 |
|          10 |              10 |
+-------------+-----------------+*/

-----------------------------The amount of Floors having Rooms with carpets
SELECT rooms.*, rf.feature
FROM rooms
INNER JOIN room_features rf ON rooms.features = rf.id
WHERE rooms.features = 2;

/*+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+
| id | startDate           | endDate             | status | floorNumber | roomNumber | typeOfRoom | capacity | numberOfWindows | features | feature |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+
|  1 | 2017-07-01 15:00:00 | 2017-07-15 15:00:00 |      1 |           5 |        524 |         14 |        4 |               8 |        2 | carpets |
|  5 | 2017-07-01 15:00:00 | 2017-07-15 15:00:00 |      1 |           7 |        785 |         14 |        4 |               8 |        2 | carpets |
|  6 | 2017-07-01 15:00:00 | 2017-07-15 15:00:00 |      1 |          10 |       1024 |         14 |        4 |               8 |        2 | carpets |
+----+---------------------+---------------------+--------+-------------+------------+------------+----------+-----------------+----------+---------+*/