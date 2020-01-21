/* FUNCTION */ 
DELIMITER //
DROP FUNCTION IF EXISTS GetTotalSaleByUserId //
CREATE FUNCTION GetTotalSaleByUserId(
    u_id INT
) RETURNS INT

BEGIN
    DECLARE total_sale INT;
    SELECT sum(amount) into total_sale from orders where user_id = u_id;
    RETURN total_sale;
END //

DELIMITER ;