start TRANSACTION;

-- Rename existing 'person' table to a temporary name
RENAME TABLE Person TO Person_old;

-- Rename 'person_new' to 'person'
RENAME TABLE Person_new TO Person;

-- Drop the insert trigger
DROP TRIGGER IF EXISTS person_insert_trigger;

-- Drop the update trigger
DROP TRIGGER IF EXISTS person_update_trigger;

-- Drop the delete trigger
DROP TRIGGER IF EXISTS person_delete_trigger;

COMMIT;

-- Optionally, you can drop the old 'person_temp' table if needed
-- DROP TABLE IF EXISTS person_temp;
