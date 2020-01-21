/* PROCEDURE */ 
CREATE OR REPLACE VIEW user_order_stats AS
SELECT u.id, 
       u.name, 
       c.name        AS city, 
       count(o.id)   AS count_order, 
       Sum(o.amount) AS sale_amount 
FROM   users AS u 
       JOIN orders AS o 
         ON o.user_id = u.id 
       JOIN cities AS c 
         ON c.id = u.city_id 
GROUP  BY 1 