-- SQL query that copies everything from the Person table to the Person_new table, ignoring rows with duplicate id
INSERT
    IGNORE INTO Person_new (
        id,
        name,
        email,
        phone,
        address,
        city,
        zip_code,
        updated_at,
        created_at
    )
SELECT
    id,
    name,
    email,
    phone,
    address,
    city,
    zip_code,
    updated_at,
    created_at
FROM
    Person;
