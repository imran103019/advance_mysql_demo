/* PROCEDURE */ 
DELIMITER //
DROP PROCEDURE IF EXISTS GetLogsByUserId //
CREATE PROCEDURE GetLogsByUserId(
    IN user_id int(100)
)
BEGIN
    SELECT * from logs where entity_id = user_id;
END //

DELIMITER ; 
