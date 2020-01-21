/* BEFORE UPDATE TRIGGER */
DELIMITER //
CREATE TRIGGER `BeforeUserUpdate`
BEFORE UPDATE ON users 
FOR EACH ROW
BEGIN
    IF NEW.age < 10 THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'Age must be greater than or equal 10';
    END IF; 
END //
DELIMITER ;


/* AFTER UPDATE TRIGGER */
DELIMITER //
CREATE TRIGGER `AfterUserUpdate`
AFTER UPDATE ON users 
FOR EACH ROW
BEGIN
   DECLARE data_text TEXT;
   IF NEW.number !=  OLD.number THEN
     SET data_text = CONCAT('old-number: ', OLD.number,' and new-number: ', NEW.number, ','); 
     INSERT INTO `logs` (`data`, `entity_id`) VALUES (data_text,NEW.id);
   END IF;
   
   IF NEW.age !=  OLD.age THEN
     SET data_text = CONCAT('old-age: ',OLD.age,' and new-age: ', NEW.age,',');
     INSERT INTO `logs` (`data`, `entity_id`) VALUES (data_text,NEW.id);
   END IF;
   
   IF NEW.email !=  OLD.email THEN
     SET data_text = CONCAT('old-email: ',OLD.email,' and new-email: ', NEW.email,',');  
     INSERT INTO `logs` (`data`, `entity_id`) VALUES (data_text,NEW.id);
   END IF;
   
END //
DELIMITER ;