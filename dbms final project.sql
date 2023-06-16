-- Query 1: Create all the necessary tables, such as blood donor table, blood inventory table etc.

-- This table will contain all the details of donors who will donate blood in the blood bank

CREATE TABLE Blood_Donor 
( donor_ID int NOT NULL primary KEY, 
 donor_name varchar(50) NOT NULL, 
 donor_age varchar(50),
 donor_sex varchar(50), 
 donor_Bgroup varchar(10) NOT NULL, 
 location_ID int NOT NULL 
-- CONSTRAINT bdID_pk PRIMARY KEY (bd_ID)
);

-- Inserting some dummmy details of donors here

INSERT into Blood_Donor
VALUES(1501,'Shayna',25,'F','B+',1100),
(1601,'Kanika',35,'F','A+',1100),
(1602,'Ishika',22,'F','O+',1200),
(1502,'Avantika',29,'F','O+',1300),
(1503,'Shyam',42,'M','A-',1300),
(1504,'Dinesh',44,'M','AB+',1200),
(1603,'Pratham',33,'F','AB-',1400),
(1607,'Khushi',31,'F','AB+',1200),
(1609,'Varsha',24,'F','B-',1500),
(1606,'Sarthak',29,'M','O-',1200);
select * from Blood_Donor;

-- This table sets up a basic table structure for keeping track of blood inventory by blood group and status.

CREATE TABLE BloodInventory
( blood_id int NOT NULL primary key,
 blood_group varchar(10) NOT NULL,
 status int
 -- CONSTRAINT blood_id_pk PRIMARY KEY (blood_id)
);

-- Inserting some dummmy details of the blood type donated by the donors here

INSERT into BloodInventory
VALUES(1001, 'B+', 1),
(1002, 'A+', 1),
(1003, 'O+', 1),
(1004, 'O+', 1),
(1005, 'A-', 0),
(1006, 'AB+', 1),
(1007, 'AB-', 1),
(1008, 'AB+', 0),
(1009, 'B-', 1),
(1010, 'O-', 0);

Select * from BloodInventory;

-- This table defines the relation between the donor and the inventory. 

CREATE TABLE blood_donation (
donor_ID INT,
reci_ID INT,
donation_date DATE,
expiration_date DATE,
FOREIGN KEY (donor_id) REFERENCES blood_donor(donor_id),
FOREIGN KEY (reci_id) REFERENCES recipient(reci_id)
);

-- Inserting the values of columns referenced from the Blood_Donor and Recipient table

INSERT into Blood_donation
VALUES(1501,10001,'2023-04-10','2023-05-22'),
(1601,10002,'2023-04-09','2023-05-23'),
(1602,10003,'2023-05-16','2023-05-16' ),
(1502,10004,'2023-02-03','2023-03-17' ),
(1503,10005,'2023-04-01','2023-05-13'),
(1504,10006,'2023-03-28','2023-05-09'),
(1603,10007,'2023-02-06','2023-03-20'),
(1607,10008,'2023-04-09','2023-05-21'),
(1609,10009,'2023-04-11','2023-05-23'),
(1606,10010,'2023-03-15','2023-04-26');

select * from blood_donation;
-- This table stores data of recipients who have recieved blood from the blood inventory

CREATE TABLE Recipient
( reci_ID int NOT NULL primary key,
 reci_name varchar(100) NOT NULL,
 reci_age varchar(100),
 reci_Bgrp varchar(100),
 reci_Bqnty float,
 City_ID int NOT NULL,
 reci_sex varchar(100),
 reci_reg_date date
-- CONSTRAINT reciid_pk PRIMARY KEY (reci_id)
);

-- Inserting dummy values of recipients who have received blood from the blood inventory

INSERT into Recipient
VALUES(10001,'Aakash',25,'B+',1.5,1100,'M','2023-03-17'),
(10002,'Keshav',60,'A+',1,1100,'M','2023-03-16'),
(10003,'Yuvraj',35,'AB+',0.5,1200,'M','2023-03-11'),
(10004,'Sanyam',66,'B+',1,1300,'M','2023-04-10'),
(10005,'Aryaman',53,'B-',1,1400,'M','2023-04-07'),
(10006,'Nakul',45,'O+',1.5,1500,'M','2023-03-23'),
(10007,'Dhiraj',22,'AB-',1,1500,'F','2023-04-17'),
(10008,'Dharam',25,'B+',2,1300,'F','2023-03-14'),
(10009,'Anurag',30,'A+',1.5,1100,'M','2023-03-15'),
(10010,'Rishab',25,'AB+',3.5,1200,'M','2023-04-09');

select * from recipient;

-- Query 2: Retrieve the list of all blood units with their current availability status.
Select * from BloodInventory where status = 1;

-- Query 3: Update the inventory of blood units after a new donation.
UPDATE BloodInventory
SET status = status +1
where blood_id = 1001;
Select * from BloodInventory;

-- Query 4: Retrieve the list of all blood donors along with their personal details and donation history.
SELECT 
  Blood_Donor.donor_ID, 
  donor_name, 
  donor_age, 
  donor_sex, 
  donor_Bgroup, 
  COUNT(*) as num_donations,
  MAX(donation_date) as last_donation_date
FROM 
  Blood_Donor 
  LEFT JOIN Blood_Donation ON Blood_Donor.donor_ID = Blood_Donation.donor_ID
GROUP BY 
  donor_ID, 
  donor_name, 
  donor_age, 
  donor_sex, 
  donor_Bgroup
ORDER BY 
  donor_name;
  
-- Query 5: Add a new blood donor to the database.
INSERT into Blood_Donor
VALUES(1510,'Samridhi',20,'F','B+','2023-04-11','2023-05-23',1100);
Select * from Blood_Donor;

-- Query 6: Update the information of a blood donor.
UPDATE Blood_Donor
SET donor_name = 'Sam', donor_age = '21', donor_sex = 'F'
WHERE donor_ID = 1510;
Select * from Blood_Donor;

-- Query 7: Add a new blood unit to the inventory.
insert into BloodInventory
values(1011,'O+',1);
select * from bloodinventory;

-- Query 8: Retrieve the information of all the donors whose blood group is AB+ .
SELECT *
FROM Blood_Donor
WHERE donor_Bgroup = 'AB+';

-- Query 9: Delete the information of a specific donor.
DELETE FROM Blood_Donor
WHERE donor_ID = 1510;
Select * from Blood_Donor;

-- Query 10: Retrieve the list of blood units that are about to expire in the next 30 days.
SELECT *
FROM blood_donation
WHERE expiration_date <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) and expiration_date > now();



