# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.28)
# Database: test
# Generation Time: 2020-01-21 07:37:17 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;

INSERT INTO `cities` (`id`, `name`)
VALUES
	(1,'Bangladesh'),
	(2,'Cittagong');

/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` varchar(255) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;

INSERT INTO `logs` (`id`, `data`, `entity_id`)
VALUES
	(9,'USER ACCOUNT OPENED',9),
	(10,'old-number: we and new-number: 01772793058,',7),
	(11,'old-age: 10 and new-age: 30,',7),
	(12,'old-email: we and new-email: imran@gmail.com,',7),
	(13,'old-email: WE and new-email: omar@gmail.com,',9),
	(14,'USER ACCOUNT OPENED',10),
	(15,'USER ACCOUNT OPENED',11),
	(16,'old-age: 20 and new-age: 78,',11),
	(17,'USER ACCOUNT OPENED',12),
	(18,'old-age: 60 and new-age: 50,',12),
	(19,'old-number: 0199999 and new-number: 0999333,',12),
	(20,'old-age: 50 and new-age: 40,',12);

/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `delivery_address` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;

INSERT INTO `orders` (`id`, `user_id`, `delivery_address`, `amount`)
VALUES
	(1,7,'Banani11',33),
	(2,9,'Gulshan2',300),
	(3,9,'Banani',130),
	(4,11,'Uttara',20);

/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `uuid` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `email`, `number`, `uuid`, `age`, `city_id`)
VALUES
	(7,'imran','imran@gmail.com','01772793058','e526d2f1bfe073e',30,1),
	(9,'omar','omar@gmail.com','01772793053','e323613869f5d23',12,2),
	(10,'nafi','nafi@gmail.com','01772793051','c4c35f433986033',23,1),
	(11,'tanvir','tanvir@gmail.com','01772793053','a6526ec8a68e5b4',78,1),
	(12,'mitul','mitul@gmail.com','0999333','e81f259b6114568',40,NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `BeforeUserInsert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    IF NEW.uuid IS NULL THEN
       SET NEW.uuid = SUBSTR(SHA1(uuid()), 1, 15);
    END IF;
    
    IF NEW.age < 10 OR NEW.age IS NULL THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'Age must be greater than or equal 10';
    END IF;  
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `AfterUserInsert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
   INSERT INTO `logs` (`data`, `entity_id`) VALUES ('USER ACCOUNT OPENED',NEW.id);
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `BeforeUserUpdate` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
    IF NEW.age < 10 THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'Age must be greater than or equal 10';
    END IF; 
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `AfterUserUpdate` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
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
   
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `BeforeUserDelete` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
    IF OLD.id in (select user_id from orders) THEN
       SIGNAL SQLSTATE '45000' 
       SET MESSAGE_TEXT = 'This user has orders. deletion failed.';
    END IF;   
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`%` */ /*!50003 TRIGGER `AfterUserDelete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
   INSERT INTO `logs` (`data`, `entity_id`) VALUES ('USER ACCOUNT DELETED',OLD.id);
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
