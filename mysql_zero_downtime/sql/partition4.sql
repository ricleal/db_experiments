CALL CopyDataWithSleep();

-- Full outer join is not supported in MySQL, so we use a union of left and right joins
-- Check for rows in Person_new that are different, missing, or extra compared to Person
SELECT
    id,
    STATUS
FROM
    (
        SELECT
            COALESCE(p.id, pn.id) AS id,
            CASE
                WHEN p.id IS NULL THEN 'Missing in Person'
                WHEN pn.id IS NULL THEN 'Extra in Person_new'
                WHEN p.name != pn.name
                OR p.email != pn.email
                OR p.phone != pn.phone
                OR p.address != pn.address
                OR p.city != pn.city
                OR p.zip_code != pn.zip_code
                OR p.updated_at != pn.updated_at
                OR p.created_at != pn.created_at THEN 'Different'
                ELSE 'Identical'
            END AS STATUS
        FROM
            Person p
            LEFT JOIN Person_new pn ON p.id = pn.id
        UNION
        -- Check for rows in Person that are missing or extra in Person_new
        SELECT
            COALESCE(p.id, pn.id) AS id,
            CASE
                WHEN pn.id IS NULL THEN 'Extra in Person_new'
                WHEN p.name != pn.name
                OR p.email != pn.email
                OR p.phone != pn.phone
                OR p.address != pn.address
                OR p.city != pn.city
                OR p.zip_code != pn.zip_code
                OR p.updated_at != pn.updated_at
                OR p.created_at != pn.created_at THEN 'Different'
                ELSE 'Identical'
            END AS STATUS
        FROM
            Person p
            RIGHT JOIN Person_new pn ON p.id = pn.id
    ) AS subquery
WHERE
    STATUS != 'Identical';
