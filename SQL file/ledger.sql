CREATE DATABASE  IF NOT EXISTS `ledger` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ledger`;
-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 35.188.103.63    Database: ledger
-- ------------------------------------------------------
-- Server version	5.7.14-google-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='a9d86b01-bccd-11e9-883e-42010a80059b:1-240687';

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase` (
  `pcode` varchar(255) NOT NULL,
  `purchase_amount` double NOT NULL,
  `trans_date` date NOT NULL,
  PRIMARY KEY (`pcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` VALUES ('A',900,'2019-12-19'),('C',100,'2019-10-18'),('D',300,'2019-10-18'),('E',1000,'2019-11-18'),('F',900,'2019-11-18'),('G',300,'2019-11-18'),('H',400,'2019-12-18');
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `pcode` varchar(255) NOT NULL,
  `sales_amount` double NOT NULL,
  `trans_date` date NOT NULL,
  PRIMARY KEY (`pcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES ('A',900,'2019-12-19'),('B',100,'2019-12-19'),('C',100,'2019-10-18'),('D',300,'2019-10-18'),('E',1000,'2019-11-18'),('F',900,'2019-11-18'),('G',300,'2019-11-18'),('H',400,'2019-12-18');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tier`
--

DROP TABLE IF EXISTS `tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tier` (
  `id` int(11) NOT NULL,
  `min_value` decimal(8,2) DEFAULT NULL,
  `max_val` decimal(8,2) DEFAULT NULL,
  `discount` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tier`
--

LOCK TABLES `tier` WRITE;
/*!40000 ALTER TABLE `tier` DISABLE KEYS */;
INSERT INTO `tier` VALUES (1,0.00,1000.00,2.00),(2,1001.00,5000.00,5.00),(3,5001.00,NULL,7.50);
/*!40000 ALTER TABLE `tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ledger'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_tier_calc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`mathew`@`%` PROCEDURE `proc_tier_calc`(
IN fromDate DATETIME,
IN toDate DATETIME
)
BEGIN
		
	DECLARE totalSale DEC(10,2) DEFAULT 0.0;
    DECLARE claimTotal DEC(10,2) DEFAULT 0.0;
    DECLARE tierOneMax DEC(10,2) DEFAULT 0.0;
    DECLARE tierTwoMax DEC(10,2) DEFAULT 0.0;
    DECLARE tierOnePerc DEC(10,2) DEFAULT 0.0;
    DECLARE tierTwoPerc DEC(10,2) DEFAULT 0.0;
    DECLARE tierThreePerc DEC(10,2) DEFAULT 0.0;
    
    SELECT sum(SALES_AMOUNT) INTO totalSale  FROM sales where TRANS_DATE>=fromDate and TRANS_DATE<=toDate;
    select max_val into tierOneMax from tier where id=1;
    select max_val into tierTwoMax from tier where id=2;
	select discount into tierOnePerc from tier where id=1;
    select discount into tierTwoPerc from tier where id=2;
    select discount into tierThreePerc from tier where id=3;

    IF totalSale > 0 THEN
     CASE 
        WHEN  totalSale>=tierOneMax THEN
           SET claimTotal= totalSale * (tierOnePerc/100);
        WHEN totalSale>=tierTwoMax THEN
            SET claimTotal= (totalSale * (tierOnePerc/100)) + ((totalSale - tierOneMax) * (tierTwoPerc/100));
        ELSE
			SET claimTotal= (tierOneMax*(tierOnePerc/100)) + ((tierTwoMax - tierOneMax)*(tierTwoPerc/100)) + ((totalSale-(tierTwoMax+tierOneMax))*(tierThreePerc/100));
    END CASE;
    
    END IF;
    SELECT claimTotal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-22 23:26:45
