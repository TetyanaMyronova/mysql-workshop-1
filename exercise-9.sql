--Exercise 9
CREATE DATABASE barn;

USE barn;

CREATE TABLE chicken_barn(
    id INT AUTO_INCREMENT PRIMARY KEY,
    dateOfBirth DATE,
    typeOfAnimal ENUM('Hen', 'Chicken', 'Rooster'),
    quantity INT
);

INSERT INTO chicken_barn 
    (dateOfBirth, typeOfAnimal, quantity)
VALUES 
    ('2017-01-01', 'Hen', 10),
    ('2017-01-01', 'Chicken', 5),
    ('2017-01-01', 'Chicken', 2),
    ('2017-01-01', 'Rooster', 3),
    ('2017-01-02', 'Rooster', 3),
    ('2017-03-01', 'Hen', 2);

SELECT dateOfBirth, typeOfAnimal, sum(quantity) as quantity
FROM chicken_barn
WHERE dateOfBirth = "2017-01-01"
GROUP BY typeOfAnimal;

/* OUTPUT
+-------------+--------------+----------+
| dateOfBirth | typeOfAnimal | quantity |
+-------------+--------------+----------+
| 2017-01-01  | Hen          |       10 |
| 2017-01-01  | Chicken      |        7 |
| 2017-01-01  | Rooster      |        3 |
+-------------+--------------+----------+*/