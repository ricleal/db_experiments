START TRANSACTION;

CREATE TRIGGER person_insert_trigger
AFTER
INSERT
    ON Person FOR EACH ROW BEGIN
INSERT INTO
    Person_new (
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
VALUES
    (
        NEW.id,
        NEW.name,
        NEW.email,
        NEW.phone,
        NEW.address,
        NEW.city,
        NEW.zip_code,
        NEW.updated_at,
        NEW.created_at
    );

END;

CREATE TRIGGER person_update_trigger
AFTER
UPDATE
    ON Person FOR EACH ROW BEGIN
UPDATE
    Person_new
SET
    name = NEW.name,
    email = NEW.email,
    phone = NEW.phone,
    address = NEW.address,
    city = NEW.city,
    zip_code = NEW.zip_code,
    updated_at = NEW.updated_at
WHERE
    id = NEW.id;

END;

CREATE TRIGGER person_delete_trigger
AFTER
    DELETE ON Person FOR EACH ROW BEGIN
DELETE FROM
    Person_new
WHERE
    id = OLD.id;

END;

COMMIT;
