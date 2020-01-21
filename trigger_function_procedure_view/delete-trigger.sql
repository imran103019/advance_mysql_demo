/* BEFORE DELETE TRIGGER */
DELIMITER //
CREATE TRIGGER `BeforeUserDelete`
BEFORE DELETE ON users 
FOR EACH ROW
BEGIN
    IF OLD.id in (select user_id from orders) THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'This user has orders. deletion failed.';
    END IF;   
END //
DELIMITER ; 

/* AFTER DELETE TRIGGER */
DELIMITER //
CREATE TRIGGER `AfterUserDelete`
AFTER DELETE ON users 
FOR EACH ROW
BEGIN
   INSERT INTO `logs` (`data`, `entity_id`) VALUES ('USER ACCOUNT DELETED',OLD.id);
END //
DELIMITER ;