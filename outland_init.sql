-- drop database user if exists 
DROP USER IF EXISTS 'outland_user'@'localhost';

-- create outland_user
CREATE USER 'outland_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adventures';

-- grant all privileges to the outland_adventures database to user outland_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO 'outland_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Trip;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Location;


-- Create Location table
CREATE TABLE Location (

    location_id    INT  NOT NULL  AUTO_INCREMENT,
    location_name    VARCHAR(50)  NOT NULL,
    season    VARCHAR(6)  NOT NULL,
    total_bookings    INT,
    
    PRIMARY KEY(location_id)

);


-- Create Inventory table
CREATE TABLE Inventory ( 

    category    VARCHAR(50)  NOT NULL,
    quantity    INT  NOT NULL,
    total_sales    INT,
    
    PRIMARY KEY(category)

);


-- Create Employee table
CREATE TABLE Employee ( 

    employee_id    INT  NOT NULL  AUTO_INCREMENT,
    employee_first_name    VARCHAR(50)  NOT NULL,
    employee_last_name    VARCHAR(50)  NOT NULL,
    job_title    VARCHAR(50),
    employee_visa    VARCHAR(20),
    employee_passport    VARCHAR(20),
    employee_airfare    VARCHAR(20),
    
    PRIMARY KEY(employee_id)

);


-- Create Trip table
CREATE TABLE Trip (

    trip_id    INT  NOT NULL  AUTO_INCREMENT,
    trip_type    VARCHAR(50)  NOT NULL,
    start_date    DATE  NOT NULL,
    end_date    DATE  NOT NULL,
    number_of_bookings    INT,
    location_id    INT  NOT NULL,
    employee_id    INT  NOT NULL,
    
    PRIMARY KEY(trip_id),
    
    CONSTRAINT fk_location
    FOREIGN KEY (location_id)
        REFERENCES Location(location_id),
    
    CONSTRAINT fk_employee
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)

);


-- Create Equipment table
CREATE TABLE Equipment (

    equipment_id    INT  NOT NULL  AUTO_INCREMENT,
    equipment_name    VARCHAR(100)  NOT NULL,
    type    VARCHAR(6),
    purchase_date    DATE  NOT NULL,
    category    VARCHAR(50)  NOT NULL,
    
    PRIMARY KEY(equipment_id),
    
    CONSTRAINT fk_inventory
    FOREIGN KEY (category)
        REFERENCES Inventory(category) 

);


-- Create Address table
CREATE TABLE Address (
    
    address    VARCHAR(50)  NOT NULL,
    city    VARCHAR(50)  NOT NULL,
    state    VARCHAR(50)  NOT NULL,
    zip_code    INT  NOT NULL,
    
    PRIMARY KEY(address)
    
);


-- Create Customer table
CREATE TABLE Customer (

    customer_id    INT  NOT NULL  AUTO_INCREMENT,
    first_name    VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email    VARCHAR(100),
    phone    VARCHAR(20),
    address    VARCHAR(200),
    visa_status    VARCHAR(20),
    passport_status    VARCHAR(20),
    airfare_status    VARCHAR(20),
    equipment_id    INT,
    trip_id    INT,

    PRIMARY KEY(customer_id),
    
    CONSTRAINT fk_address
    FOREIGN KEY(address)
        REFERENCES Address(address),
    
    CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
        REFERENCES Equipment(equipment_id),
    
    CONSTRAINT fk_trip
    FOREIGN KEY(trip_id)
        REFERENCES Trip(trip_id)

);


-- Insert data into Location table
INSERT INTO Location (location_name, season, total_bookings)  
    VALUES  
    ('Africa', 'Spring', 22),
    ('Asia','Spring', 38),
    ('Europe', 'Spring', 25),
    ('Africa', 'Fall', 7),
    ('Asia', 'Fall', 30),
    ('Europe', 'Fall', 17); 


-- Insert data into Inventory table
INSERT INTO Inventory (category, quantity, total_sales)
    VALUES
    ('Tents', 19, 22),
    ('Backpacks', 25, 7),
    ('Jackets', 43, 43),
    ('Pants', 18, 37),
    ('Hiking Gear', 15, 12),
    ('Sleeping Gear', 24, 26),
    ('Misc. Gear', 38, 9);
  

-- Insert data into Employee table 
INSERT INTO Employee (employee_first_name, employee_last_name, job_title, employee_visa, employee_passport, employee_airfare)
    VALUES
    ('Blythe', 'Timmerson', 'Owner', 'Valid', 'Valid', 'Scheduled'),
    ('Jim', 'Ford', 'Owner', 'Valid', 'Valid', 'Scheduled'),
    ('John', 'MacNell', 'Camping Guide', 'Valid', 'Valid', 'Scheduled'),
    ('D.B.', 'Marland', 'Hiking Guide', 'Valid', 'Valid', 'Scheduled'),
    ('Anita', 'Gallegos', 'Marketing Manager', 'Valid', 'Valid', 'Not Scheduled'),
    ('Dimitrios', 'Stravopolous', 'Inventory Manager', 'Valid', 'Valid', 'Not Scheduled'),
    ('Mei', 'Wong', 'Website Manager', 'Valid', 'Valid', 'Not Scheduled');


-- Insert data into Trip table
INSERT INTO Trip (trip_type, start_date, end_date, number_of_bookings, location_id, employee_id)
    VALUES  
    ('Camping', '2022-04-08', '2022-04-23', 12,
        (SELECT location_id FROM Location WHERE location_name = 'Africa'        AND season = 'Spring'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'MacNell'  AND job_title = 'Camping Guide')),
        
    ('Hiking', '2022-04-29', '2022-05-14', 21,
        (SELECT location_id FROM Location WHERE location_name = 'Asia'          AND season = 'Spring'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'Marland'  AND job_title = 'Hiking Guide')),
        
    ('Hiking', '2022-05-27', '2022-06-11', 25,
        (SELECT location_id FROM Location WHERE location_name = 'Europe'        AND season = 'Spring'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'Marland'  AND job_title = 'Hiking Guide')),
        
    ('Camping', '2022-09-02', '2022-09-17', 7,
        (SELECT location_id FROM Location WHERE location_name = 'Africa'        AND season = 'Fall'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'MacNell'  AND job_title = 'Camping Guide')),
        
    ('Camping', '2022-09-30', '2022-10-15', 12,
        (SELECT location_id FROM Location WHERE location_name = 'Asia'          AND season = 'Fall'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'MacNell'  AND job_title = 'Camping Guide')),
        
    ('Hiking', '2022-10-28', '2022-11-12', 17,
        (SELECT location_id FROM Location WHERE location_name = 'Europe'        AND season = 'Fall'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'Marland'  AND job_title = 'Hiking Guide')),
    
    ('Hiking', '2023-04-07', '2023-04-22', 10,
        (SELECT location_id FROM Location WHERE location_name = 'Africa'        AND season = 'Spring'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'Marland'  AND job_title = 'Hiking Guide')),
    
    ('Camping', '2023-05-05', '2023-05-20', 17,
        (SELECT location_id FROM Location WHERE location_name = 'Asia'          AND season = 'Spring'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'MacNell'  AND job_title = 'Camping Guide')),
        
    ('Hiking', '2023-10-02', '2023-10-17', 18,
        (SELECT location_id FROM Location WHERE location_name = 'Asia'          AND season = 'Fall'),
        (SELECT employee_id FROM Employee WHERE employee_last_name = 'Marland'  AND job_title = 'Hiking Guide'));


-- Insert data into Equipment table  
INSERT INTO Equipment (equipment_name, type, purchase_date, category)
    VALUES
    ('Tent', 'Rental', '2019-06-27', 'Tents'),
    ('Ruck Sack', 'Rental', '2021-06-26', 'Backpacks'),
    ('Camel Back', NULL, '2022-06-25', 'Backpacks'),
    ('Walking Cane', 'Rental', '2022-06-25', 'Hiking Gear'),
    ('Rain Jacket', NULL, '2019-06-27', 'Jackets'),
    ('Rain Slacks', 'Rental', '2019-06-27', 'Pants'),
    ('Sleeping Bag', 'Rental', '2017-06-29', 'Sleeping Gear'); 


-- Insert data into Address table
INSERT INTO Address (address, city, state, zip_code)
    VALUES
    ('123 Blanc Ave', 'Huntsville', 'Alabama', 82649),
    ('1823 Beach Dr', 'Bellevue', 'Nebraska', 22341),
    ('01 Dutch Blvd', 'Sitka', 'Alaska', 11112),
    ('1550 Marcus Dr', 'Seattle', 'Washington', 11223),
    ('7272 Cherry ln', 'Tampa', 'Florida', 33821),
    ('841 Valor Rd', 'Colorado Springs', 'Colorado', 67673);


-- Insert data into Customer table
INSERT INTO Customer (first_name, last_name, email, phone, address, visa_status, passport_status, airfare_status, equipment_id, trip_id)
    VALUES
    ('Randy', 'Miles', 'rmiles@duelue.com', '1(555)987-6543',
    (SELECT address FROM Address WHERE address = '123 Blanc Ave.'), 'Valid', 'Valid', 'Scheduled', 3, 7),
    ('Sandy', 'Scott', 'sscot@duelue.com', '1(555)845-9173',
    (SELECT address FROM Address WHERE address = '1823 Beach Drive'), 'Valid', 'Invalid', 'Scheduled', 4, 2),
    ('Yenifer', 'Knight', 'yknight@duelue.com', '1(555)693-0472',
    (SELECT address FROM Address WHERE address = '7272 Cherry ln'), 'Valid', 'Valid', 'Scheduled', 2, 3),
    ('Wulf', 'Vasquez', 'wvasquez@duelue.com', '1(555)747-5584',
    (SELECT address FROM Address WHERE address = '01 Dutch Blv.'), 'Valid', 'Valid', 'Not Scheduled', 1, 4),
    ('Brunhilda', 'Walsh', 'bwalsh@duelue.com', '1(555)889-1766',
    (SELECT address FROM Address WHERE address = '1550 Marcus Drive'), 'Valid', 'Valid', 'Scheduled', 6, 1),
    ('Yeska', 'Wushan', 'ywushan@duelue.com', '1(555)189-1278',
    (SELECT address FROM Address WHERE address = '841 Valor Road'), 'Not Valid', 'Valid', 'Scheduled', NULL, 8);


