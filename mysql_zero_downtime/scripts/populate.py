#!/usr/bin/env python

# This script will populate the database with fake data.
# if we pass an argument, it will sleep for that many seconds
# between each insert. This is to simulate a flow of data into the database.

ROWS = 1000

import time
import os
import sys

import mysql.connector
from mysql.connector import Error
from faker import Faker

fake = Faker()


db_host = os.environ.get('MYSQL_HOST', 'localhost')
db_port = os.environ.get('MYSQL_PORT', '3306')
db_name = os.environ.get('MYSQL_DATABASE')
db_user = os.environ.get('MYSQL_ROOT_USER', 'root')
db_pass = os.environ.get('MYSQL_ROOT_PASSWORD')

# CREATE TABLE IF NOT EXISTS Person (
#     id varchar(36) NOT NULL,
#     name varchar(255),
#     email varchar(255),
#     phone varchar(31),
#     address varchar(255),
#     city varchar(127),
#     zip_code varchar(15),
#     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
#     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#     PRIMARY KEY (ID)
# );


def populate(interval: int = 0):

    conn = None
    print("Connecting to MySQL...")
    print("host: %s" % db_host)
    print("database: %s" % db_name)
    print("user: %s" % db_user)
    print("password: %s" % db_pass)
    try:
        conn = mysql.connector.connect(
            host=db_host,
            port=db_port,
            database=db_name,
            user=db_user,
            password=db_pass
        )

        if conn.is_connected():
            cursor = conn.cursor()

            row = {}
            for n in range(ROWS):
                row = [
                    fake.uuid4(),
                    fake.name(),
                    fake.email(),
                    fake.phone_number(),
                    fake.street_address(),
                    fake.city(),
                    fake.zipcode(),
                ]
                cursor.execute(f"""
                    INSERT INTO `Person` (id, name, email, phone, address, city, zip_code) 
                    VALUES ('{row[0]}', '{row[1]}', '{row[2]}', '{row[3]}', '{row[4]}', '{row[5]}', '{row[6]}')""")

                if interval > 0:
                    conn.commit()
                    time.sleep(interval)
                elif n % 100 == 0:
                    print("iteration %s" % n)
                    conn.commit()

    except Error as e:
        print("error:", e)
        pass
    except Exception as e:
        print("Unknown error: %s", e)
    finally:
        # closing database connection.
        if (conn and conn.is_connected()):
            conn.commit()
            cursor.close()
            conn.close()


if __name__ == "__main__":
    # print usage
    if len(sys.argv) > 2:
        print("Usage: %s [interval]" % sys.argv[0])
        sys.exit(1)

    # if there is one argument, it is the interval
    if len(sys.argv) == 2:
        populate(int(sys.argv[1]))
    else:
        populate()
