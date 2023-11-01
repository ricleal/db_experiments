-- this just a test: instead of creating a new table, we use an existing one
-- Attention: there will be a significant down time with this approach!

ALTER TABLE Person DROP PRIMARY KEY, ADD PRIMARY KEY(ID, zip_code);

ALTER TABLE Person 
PARTITION BY RANGE COLUMNS(zip_code) (
    PARTITION p0 VALUES LESS THAN ('10000'),
    PARTITION p1 VALUES LESS THAN ('20000'),
    PARTITION p2 VALUES LESS THAN ('30000'),
    PARTITION p3 VALUES LESS THAN ('40000'),
    PARTITION p4 VALUES LESS THAN ('50000'),
    PARTITION p5 VALUES LESS THAN ('60000'),
    PARTITION p6 VALUES LESS THAN ('70000'),
    PARTITION p7 VALUES LESS THAN ('80000'),
    PARTITION p8 VALUES LESS THAN ('90000'),
    PARTITION p9 VALUES LESS THAN (MAXVALUE)
);