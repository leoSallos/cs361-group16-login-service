USE lserve;

DROP VIEW IF EXISTS v_userInfo;

CREATE VIEW v_userInfo AS 
    SELECT userID, 
        username, 
        firstname, 
        lastname, 
        email,
        allowAds 
    FROM LS_Users;

/* user access */
DROP PROCEDURE IF EXISTS sp_access_user;
DELIMITER //
CREATE PROCEDURE sp_access_user(
    IN _un varchar(25),
    IN _pw varchar(25)
) 
BEGIN
	SET FOREIGN_KEY_CHECKS=0;
	SET AUTOCOMMIT = 0;

    SELECT vui.userID, vui.username, vui.firstname, vui.lastname, vui.email, vui.allowAds 
        FROM v_userInfo vui 
    LEFT JOIN lserve.LS_Users ui 
        ON vui.userID = ui.userID 
        WHERE ui.password = _pw AND ui.username = _un;

    SET FOREIGN_KEY_CHECKS=1;
END //
DELIMITER ;