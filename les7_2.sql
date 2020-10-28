SELECT 
    lk.id_user
FROM
    likes lk
        JOIN
    likes lk1 ON lk.id_user = lk1.id_user
        AND lk1.object_type = 1
        AND lk1.id_object = 2
        LEFT JOIN
    likes lk2 ON lk.id_user = lk2.id_user
        AND lk2.object_type = 1
        AND lk2.id_object = 3
WHERE
    lk.object_type = 1 AND lk.id_object = 1
        AND lk2.id_object IS NULL
