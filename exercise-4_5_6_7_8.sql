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