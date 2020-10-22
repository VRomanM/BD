SELECT 
    usr.id,
    usr.name,
    ifNull(lkCount.likeCount,0) likeCount,
    ifNull(myLkCount.myLikeCount,0) myLikeCount,
    ifNull(mutualLike.mutualLike,0) mutualLike
FROM
    user usr
        LEFT JOIN
    (SELECT 
        lk.id_object userID,
            SUM(IFNULL(lk.object_type, 0)) likeCount
    FROM
        likes lk
    WHERE
        lk.object_type = 1
    GROUP BY userID) lkCount ON usr.id = lkCount.userID
        LEFT JOIN
    (SELECT 
        lk.id_user userID,
            SUM(IFNULL(lk.object_type, 0)) mylikeCount
    FROM
        likes lk
    WHERE
        lk.object_type = 1
    GROUP BY userID) myLkCount ON usr.id = myLkCount.userID
        LEFT JOIN
    (SELECT 
        lk.id_user userID, SUM(lk.object_type) mutualLike
    FROM
        likes lk
    JOIN likes lk1 ON TRUE
    WHERE
        lk.object_type = 1
            AND lk1.object_type = 1
            AND lk.id_user = lk1.id_object
            AND lk.id_object = lk1.id_user
    GROUP BY userID) mutualLike ON usr.id = mutualLike.userID