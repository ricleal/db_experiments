--  copy data from the Person table to the Person_new table in chunks with a sleep between each chunk
CREATE PROCEDURE CopyDataWithSleep()
BEGIN
    DECLARE chunk_size INT DEFAULT 1000;
    DECLARE start_index INT DEFAULT 0;
    DECLARE total_rows INT;

    -- Get the total number of rows in Person
    SELECT COUNT(*) INTO total_rows FROM Person;

    WHILE start_index < total_rows DO
        -- Copy data from Person to Person_new in chunks
        INSERT IGNORE INTO Person_new (id, name, email, phone, address, city, zip_code, updated_at, created_at)
        SELECT id, name, email, phone, address, city, zip_code, updated_at, created_at
        FROM Person
        LIMIT start_index, chunk_size;

        -- Increment the start index for the next chunk
        SET start_index = start_index + chunk_size;

        -- Add a sleep to avoid overloading the CPU
        -- You can adjust the sleep time based on your needs
        DO SLEEP(1);
    END WHILE;
END 
