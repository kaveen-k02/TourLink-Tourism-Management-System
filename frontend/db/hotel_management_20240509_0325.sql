-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: hotel_management
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_logger`
--

DROP TABLE IF EXISTS `activity_logger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_logger` (
  `id` char(128) NOT NULL,
  `relate_id` char(128) NOT NULL,
  `description_type` char(128) NOT NULL,
  `description` char(128) NOT NULL,
  `comment` text DEFAULT NULL,
  `insert_user_id` char(128) NOT NULL,
  `update_user_id` char(128) NOT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `rating_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `insert_user_id` (`insert_user_id`),
  KEY `update_user_id` (`update_user_id`),
  CONSTRAINT `activity_logger_ibfk_1` FOREIGN KEY (`insert_user_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `activity_logger_ibfk_2` FOREIGN KEY (`update_user_id`) REFERENCES `tbl_user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logger`
--

LOCK TABLES `activity_logger` WRITE;
/*!40000 ALTER TABLE `activity_logger` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_logger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_ratings`
--

DROP TABLE IF EXISTS `hotel_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotel_ratings` (
  `id` char(128) NOT NULL,
  `tourist_id` char(128) NOT NULL,
  `hotel_id` char(128) NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `rating_date` datetime DEFAULT current_timestamp(),
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tourist_id` (`tourist_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `FKtkh93quievy4divmrc73iljej` (`tourist_id`),
  CONSTRAINT `FKtkh93quievy4divmrc73iljej` FOREIGN KEY (`tourist_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `hotel_ratings_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_ratings`
--

LOCK TABLES `hotel_ratings` WRITE;
/*!40000 ALTER TABLE `hotel_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotels` (
  `id` char(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `insert_user_id` char(128) NOT NULL,
  `update_user_id` char(128) DEFAULT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  `insert_datetime` date DEFAULT NULL,
  `update_datetime` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `decription` text DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `id` char(128) NOT NULL,
  `hotel_id` char(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `room_type` varchar(255) NOT NULL,
  `bed_type` varchar(255) NOT NULL,
  `max_adults` varchar(255) NOT NULL,
  `max_children` varchar(255) NOT NULL,
  `insert_user_id` char(128) NOT NULL,
  `update_user_id` char(128) DEFAULT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  `insert_datetime` date DEFAULT NULL,
  `update_datetime` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `packages_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_log`
--

DROP TABLE IF EXISTS `payment_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_log` (
  `id` varchar(255) NOT NULL,
  `insert_date` datetime(6) DEFAULT NULL,
  `insert_user_id` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  `update_date` date DEFAULT NULL,
  `update_user_id` varchar(255) DEFAULT NULL,
  `user_package_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_log`
--

LOCK TABLES `payment_log` WRITE;
/*!40000 ALTER TABLE `payment_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` char(128) NOT NULL,
  `user_id` char(128) NOT NULL,
  `package_id` char(128) NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `comment` text DEFAULT NULL,
  `rating_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_driver_guide_package`
--

DROP TABLE IF EXISTS `tbl_driver_guide_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_driver_guide_package` (
  `id` char(128) NOT NULL,
  `user_id` char(128) NOT NULL,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `no_of_peoples` decimal(10,2) DEFAULT NULL,
  `insert_user_id` char(128) DEFAULT NULL,
  `update_user_id` char(128) DEFAULT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tbl_driver_guide_package_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_driver_guide_package`
--

LOCK TABLES `tbl_driver_guide_package` WRITE;
/*!40000 ALTER TABLE `tbl_driver_guide_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_driver_guide_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_driver_guide_ratings`
--

DROP TABLE IF EXISTS `tbl_driver_guide_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_driver_guide_ratings` (
  `id` char(128) NOT NULL,
  `tourist_id` char(128) NOT NULL,
  `user_id` char(128) NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `comment` text DEFAULT NULL,
  `rating_date` datetime DEFAULT current_timestamp(),
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `toursit_id` (`tourist_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `FKtgid040f6sxu6idx991qlpwbl` FOREIGN KEY (`tourist_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `tbl_driver_guide_ratings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_driver_guide_ratings`
--

LOCK TABLES `tbl_driver_guide_ratings` WRITE;
/*!40000 ALTER TABLE `tbl_driver_guide_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_driver_guide_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_other_facilities`
--

DROP TABLE IF EXISTS `tbl_other_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_other_facilities` (
  `ID` varchar(255) NOT NULL,
  `user_account_id` varchar(255) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `service_description` text DEFAULT NULL,
  `service_location` varchar(100) DEFAULT NULL,
  `price` varchar(100) DEFAULT NULL,
  `availability` int(11) DEFAULT NULL,
  `insert_user_id` varchar(255) DEFAULT NULL,
  `update_user_id` varchar(100) DEFAULT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `user_account_id` (`user_account_id`),
  CONSTRAINT `tbl_other_facilities_ibfk_1` FOREIGN KEY (`user_account_id`) REFERENCES `tbl_user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_other_facilities`
--

LOCK TABLES `tbl_other_facilities` WRITE;
/*!40000 ALTER TABLE `tbl_other_facilities` DISABLE KEYS */;
INSERT INTO `tbl_other_facilities` VALUES ('OF001','b5b30300-2d4d-4fff-9491-d9cec9a51ed7','Gym','Fully equipped gym with modern facilities','Hotel premises','20.00',50,'b5b30300-2d4d-4fff-9491-d9cec9a51ed7',NULL,'2024-04-17 00:00:00','2024-04-17 00:00:00',0,0),('OF002','1','Spa','Relaxing spa offering various treatments and massages','Hotel premises','100.00',10,'',NULL,'2024-04-17 18:59:36','2024-04-17 18:59:36',0,0),('OF003','1','Restaurant','Fine dining restaurant serving local and international cuisine','Hotel premises','1',NULL,'',NULL,'2024-04-17 00:00:00','2024-04-17 00:00:00',0,0);
/*!40000 ALTER TABLE `tbl_other_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tourist_package`
--

DROP TABLE IF EXISTS `tbl_tourist_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_tourist_package` (
  `id` char(128) NOT NULL,
  `tourist_id` char(128) NOT NULL,
  `user_id` char(128) NOT NULL,
  `driver_guide_package_id` char(128) NOT NULL,
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tourist_id` (`tourist_id`),
  KEY `user_id` (`user_id`),
  KEY `driver_guide_package_id` (`driver_guide_package_id`),
  CONSTRAINT `tbl_tourist_package_ibfk_1` FOREIGN KEY (`tourist_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `tbl_tourist_package_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user_account` (`id`),
  CONSTRAINT `tbl_tourist_package_ibfk_3` FOREIGN KEY (`driver_guide_package_id`) REFERENCES `tbl_driver_guide_package` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tourist_package`
--

LOCK TABLES `tbl_tourist_package` WRITE;
/*!40000 ALTER TABLE `tbl_tourist_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tourist_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_travel_insurance`
--

DROP TABLE IF EXISTS `tbl_travel_insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_travel_insurance` (
  `ID` varchar(255) NOT NULL,
  `coverage_type` varchar(50) NOT NULL,
  `coverage_limit` varchar(100) NOT NULL,
  `deductible` varchar(100) DEFAULT NULL,
  `coverage_period` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `restrictions` text DEFAULT NULL,
  `additional_info` text DEFAULT NULL,
  `age_limit` varchar(100) DEFAULT NULL,
  `adventure_sports_coverage` varchar(100) DEFAULT NULL,
  `pre_existing_condition_coverage` varchar(100) DEFAULT NULL,
  `region_coverage` varchar(100) DEFAULT NULL,
  `insert_user_id` varchar(100) NOT NULL,
  `update_user_id` varchar(100) DEFAULT NULL,
  `insert_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  `price` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_travel_insurance`
--

LOCK TABLES `tbl_travel_insurance` WRITE;
/*!40000 ALTER TABLE `tbl_travel_insurance` DISABLE KEYS */;
INSERT INTO `tbl_travel_insurance` VALUES ('TI001','Medical Expenses','100000.00','100.00','Two weeks','Covers medical treatment due to illness or injury during the trip','Coverage limited to treatment necessitated by the accident or illness occurring during the trip','Emergency services may require pre-authorization','75','1','0','Worldwide','user123',NULL,'2024-04-17 00:00:00','2024-05-03 22:53:34',0,0,'150.00','Basic Plan'),('TI002','Emergency Evacuation','250000.00',NULL,'One week','Covers the cost of emergency evacuation to the nearest adequate medical facility','Must be medically necessary and ordered by a physician','Evacuation services may be subject to geographical limitations and availability','80','1','0','Worldwide excluding Antarctica','user456',NULL,'2024-04-17 18:42:41','2024-05-03 22:53:34',0,0,'200.00','Premium Plan'),('TI003','Trip Cancellation','5000.00',NULL,'One month','Covers cancellation of the trip due to unforeseen circumstances like illness or natural disasters','Cancellation must be due to reasons covered in the policy','Cancellation coverage may require documentation and proof',NULL,'1','0','Europe','user789',NULL,'2024-04-17 18:42:41','2024-05-03 22:53:34',0,0,'100.00','Standard Plan');
/*!40000 ALTER TABLE `tbl_travel_insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `id` varchar(255) NOT NULL,
  `role_id` varchar(255) NOT NULL,
  `user_account_id` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(128) NOT NULL,
  `age` varchar(128) NOT NULL,
  `country` varchar(128) NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(230) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `insert_user_id` varchar(100) DEFAULT NULL,
  `update_user_id` varchar(100) DEFAULT NULL,
  `insert_datetime` datetime DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `update_datetime` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_account_id` (`user_account_id`),
  CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `tbl_user_role` (`id`),
  CONSTRAINT `tbl_user_ibfk_2` FOREIGN KEY (`user_account_id`) REFERENCES `tbl_user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES ('bbe08065-f2db-40b9-93b2-789fec4070fb','1','b5b30300-2d4d-4fff-9491-d9cec9a51ed7','ishan','sudesh','23','srilanka','123@gmail.com',NULL,'0815673546',0,NULL,NULL,NULL,NULL,NULL,'home sweet home');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_account`
--

DROP TABLE IF EXISTS `tbl_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user_account` (
  `id` char(128) NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `STATUS` tinyint(4) DEFAULT 0,
  `SORT_ORDER` int(11) DEFAULT NULL,
  `insert_datetime` date DEFAULT NULL,
  `update_datetime` date DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjtwyx8senx4rmiycvmtxx7y91` (`role_id`),
  CONSTRAINT `FKjtwyx8senx4rmiycvmtxx7y91` FOREIGN KEY (`role_id`) REFERENCES `tbl_user_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_account`
--

LOCK TABLES `tbl_user_account` WRITE;
/*!40000 ALTER TABLE `tbl_user_account` DISABLE KEYS */;
INSERT INTO `tbl_user_account` VALUES ('1','a','$2a$10$lVTxCKb8s68qwOUmWI8ue.wiEqbdCLVEmOhyjlIfdBbu6VzjFHZG.',0,NULL,NULL,NULL,'3'),('b5b30300-2d4d-4fff-9491-d9cec9a51ed7','123@gmail.com','$2a$10$GA0xuow8Xkt3DXB5ZQlt1et8Ip27Lt4Y.CAMHJydebDL9UdwGqaGO',0,NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `tbl_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_role`
--

DROP TABLE IF EXISTS `tbl_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user_role` (
  `id` varchar(255) NOT NULL,
  `name` char(128) NOT NULL DEFAULT '0',
  `description` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_role`
--

LOCK TABLES `tbl_user_role` WRITE;
/*!40000 ALTER TABLE `tbl_user_role` DISABLE KEYS */;
INSERT INTO `tbl_user_role` VALUES ('1','ROLE_ADMIN',NULL,0),('2','ROLE_DRIVER',NULL,0),('3','ROLE_TOURIST',NULL,0),('4','ROLE_GUIDE',NULL,0);
/*!40000 ALTER TABLE `tbl_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_packages`
--

DROP TABLE IF EXISTS `user_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_packages` (
  `id` varchar(255) NOT NULL,
  `dgname` varchar(255) DEFAULT NULL,
  `bdtype` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `hotel_id` varchar(255) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `insert_user_id` varchar(255) DEFAULT NULL,
  `max_adult` varchar(255) DEFAULT NULL,
  `max_child` varchar(255) DEFAULT NULL,
  `no_of_pep` int(11) DEFAULT NULL,
  `p_name` varchar(255) DEFAULT NULL,
  `package_id` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `rm_type` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  `toursit_id` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `update_user_id` varchar(255) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_packages`
--

LOCK TABLES `user_packages` WRITE;
/*!40000 ALTER TABLE `user_packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hotel_management'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-09  3:25:51