"""
Written by Benjamin Andrew, Taylor Nairn, and Joshua Rex
7 July 2023
CSD 310 Module 10 Assignment
"""

import mysql.connector 
from mysql.connector import errorcode

config = { 
    "host": "127.0.0.1", 
    "user": "outland_user", 
    "password": "adventures", 
    "database": "outland_adventures",
    "raise_on_warnings": True
}


try:
    # Connect to database
    db = mysql.connector.connect(**config)
    print("Database user {} connected to MySQL on host {} with database {}\n".format(config["user"], config["host"], config["database"]))

    # Create a cursor object to execute SQL queries
    cursor = db.cursor()

    # Get information from Customer, Location, Trip, Equipment, Inventory, Employee
    cursor.execute("SELECT location_id, location_name, season, total_bookings FROM Location")
    Location = cursor.fetchall()

    cursor.execute("SELECT category, quantity, total_sales FROM Inventory")
    Inventory = cursor.fetchall()

    cursor.execute("SELECT employee_id, employee_first_name, employee_last_name, job_title, employee_visa, "
                   "employee_passport, employee_airfare FROM Employee")
    Employee = cursor.fetchall()

    cursor.execute("SELECT trip_id, trip_type, start_date, end_date, "
                   "number_of_bookings, location_id, employee_id FROM Trip")
    Trip = cursor.fetchall()

    cursor.execute("SELECT equipment_id, equipment_name, type, purchase_date, "
                   "category FROM Equipment")
    Equipment = cursor.fetchall()

    cursor.execute("SELECT address, city, state, zip_code FROM Address")
    Address = cursor.fetchall()

    cursor.execute("SELECT customer_id, first_name, last_name, email, phone, "
                   "address, visa_status, passport_status, airfare_status, "
                   "equipment_id, trip_id FROM Customer")
    Customer = cursor.fetchall()

    # Close the cursor
    cursor.close()

    # Display data in each table
    print("-- DISPLAYING Location RECORDS --")
    for item in Location:
        print("Location ID: {}\nLocation Name: {}\nSeason: {}\nTotal Bookings: {}\n".format(item[0], item[1], item[2],
                                                                                            item[3]))

    print("-- DISPLAYING Inventory RECORDS --")
    for thing in Inventory:
        print("Category: {}\nQuantity: {}\nTotal Sales: {}\n".format(thing[0], thing[1], thing[2]))

    print("-- DISPLAYING Employee RECORDS --")
    for emp in Employee:
        print(
            "Employee ID: {}\nEmployee First Name: {}\nEmployee Last Name: {}\nJob Title: {}\nEmployee Visa: {}\nEmployee Passport: {}\nEmployee Airfare: {}\n".format(
                emp[0], emp[1], emp[2], emp[3], emp[4], emp[5], emp[6]))

    print("-- DISPLAYING Trip RECORDS --")
    for place in Trip:
        print(
            "Trip ID: {}\nTrip Type: {}\nStart Date: {}\nEnd Date: {}\nNumber Of Bookings: {}\nLocation ID: {}\nEmployee ID: {}\n".format(
                place[0], place[1], place[2], place[3], place[4], place[5], place[6]))

    print("-- DISPLAYING Equipment RECORDS --")
    for eq in Equipment:
        print("Equipment ID: {}\nEquipment Name: {}\nType: {}\nPurchase Date: {}\nCategory: {}\n".format(eq[0], eq[1],
                                                                                                         eq[2], eq[3],
                                                                                                         eq[4]))

    print("-- DISPLAYING Address RECORDS --")
    for add in Address:
        print("Address: {}\nCity: {}\nState: {}\nZip Code: {}\n".format(add[0], add[1], add[2], add[3]))

    print("-- DISPLAYING Customer RECORDS --")
    for cus in Customer:
        print(
            "Customer ID: {}\nFirst Name: {}\nLast Name: {}\nEamil: {}\nPhone: {}\nAddress: {}\nVisa Status: {}\nPassport Status: {}\nAirfare Status: {}\nEqupiment ID: {}\nTrip ID: {}\n".format(
                cus[0], cus[1], cus[2], cus[3], cus[4], cus[5], cus[6], cus[7], cus[8], cus[9], cus[10]))

except mysql.connector.Error as err: 
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)
finally:
    db.close()
