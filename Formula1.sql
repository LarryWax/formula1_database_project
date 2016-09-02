-- MySQL dump 10.13  Distrib 5.7.13, for Linux (x86_64)
--
-- Host: localhost    Database: Formula1
-- ------------------------------------------------------
-- Server version	5.7.13-0ubuntu0.16.04.2

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

--
-- Table structure for table `buyed_drivers`
--

DROP TABLE IF EXISTS `buyed_drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyed_drivers` (
  `user_id` varchar(12) NOT NULL,
  `driver_id` tinyint(4) NOT NULL,
  UNIQUE KEY `user_id` (`user_id`,`driver_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `buyed_drivers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `buyed_drivers_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id_d`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyed_drivers`
--

LOCK TABLES `buyed_drivers` WRITE;
/*!40000 ALTER TABLE `buyed_drivers` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyed_drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drivers` (
  `id_d` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `surname` varchar(12) NOT NULL,
  `price` tinyint(4) NOT NULL,
  `img_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_d`),
  UNIQUE KEY `name` (`name`,`surname`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
INSERT INTO `drivers` VALUES (3,'Lewis','Hamilton',50,NULL),(4,'Nico','Rosberg',50,NULL),(5,'Sebastian','Vettel',50,NULL),(6,'Kimi','Raikkonen',50,NULL),(7,'Felipe','Massa',40,NULL),(8,'Valtteri','Bottas',40,NULL),(9,'Daniel','Ricciardo',40,NULL),(10,'Max','Verstappen',40,NULL),(11,'Nico','Hulkenberg',30,NULL),(12,'Sergio','Perez',30,NULL),(13,'Daniil','Kvyat',30,NULL),(14,'Carlos','Sainz Jr',30,NULL),(15,'Felipe','Nasr',20,NULL),(16,'Marcus','Ericsson',20,NULL),(17,'Fernando','Alonso',40,NULL),(18,'Jenson','Button',40,NULL),(19,'Pascal','Wherlein',20,NULL),(20,'Rio','Haryanto',20,NULL),(21,'Kevin','Magnussen',20,NULL),(22,'Jolyon','Palmer',20,NULL),(23,'Romain','Grosjean',30,NULL),(24,'Esteban','Gutierrez',30,NULL);
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers_vote`
--

DROP TABLE IF EXISTS `drivers_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drivers_vote` (
  `driver_id` tinyint(4) NOT NULL,
  `track_id` tinyint(4) NOT NULL,
  `vote` tinyint(4) NOT NULL,
  UNIQUE KEY `driver_id` (`driver_id`,`track_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `drivers_vote_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id_d`),
  CONSTRAINT `drivers_vote_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `track` (`id_t`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers_vote`
--

LOCK TABLES `drivers_vote` WRITE;
/*!40000 ALTER TABLE `drivers_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `drivers_vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`formula1`@`localhost`*/ /*!50003 TRIGGER update_ranking AFTER INSERT ON drivers_vote FOR EACH ROW UPDATE user_ranking ur JOIN (SELECT user_id, SUM(vote) as new_points FROM drivers_vote dv, formation f WHERE new.track_id = f.track_id AND (new.driver_id = f.driver_id1 OR new.driver_id = f.driver_id2) GROUP BY user_id) as q ON ur.user_id = q.user_id SET ur.points = (ur.points + q.new_points) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `formation`
--

DROP TABLE IF EXISTS `formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formation` (
  `user_id` varchar(12) NOT NULL,
  `driver_id1` tinyint(4) NOT NULL,
  `driver_id2` tinyint(4) NOT NULL,
  `track_id` tinyint(4) NOT NULL,
  `date` datetime NOT NULL,
  UNIQUE KEY `user_id` (`user_id`,`track_id`),
  KEY `driver_id1` (`driver_id1`),
  KEY `driver_id2` (`driver_id2`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `formation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `formation_ibfk_2` FOREIGN KEY (`driver_id1`) REFERENCES `drivers` (`id_d`),
  CONSTRAINT `formation_ibfk_3` FOREIGN KEY (`driver_id2`) REFERENCES `drivers` (`id_d`),
  CONSTRAINT `formation_ibfk_4` FOREIGN KEY (`track_id`) REFERENCES `track` (`id_t`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formation`
--

LOCK TABLES `formation` WRITE;
/*!40000 ALTER TABLE `formation` DISABLE KEYS */;
/*!40000 ALTER TABLE `formation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`formula1`@`localhost`*/ /*!50003 TRIGGER check_date BEFORE INSERT ON formation FOR EACH ROW BEGIN DECLARE due_date DATETIME; SET due_date = (SELECT date FROM track WHERE track.id_t = new.track_id); IF (new.date > due_date) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: formation insertion time is expired.'; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `group_subscription`
--

DROP TABLE IF EXISTS `group_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_subscription` (
  `group_id` varchar(12) NOT NULL,
  `user_id` varchar(12) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `group_subscription_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id_g`),
  CONSTRAINT `group_subscription_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_subscription`
--

LOCK TABLES `group_subscription` WRITE;
/*!40000 ALTER TABLE `group_subscription` DISABLE KEYS */;
INSERT INTO `group_subscription` VALUES ('padrepio','prova1',1),('padrepio','prova2',0);
/*!40000 ALTER TABLE `group_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id_t` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `info` varchar(150) DEFAULT NULL,
  `img_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_t`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (3,'Scuderia Ferrari',NULL,NULL),(4,'McLaren Honda',NULL,NULL),(5,'Williams',NULL,NULL),(6,'Mercedes AMG',NULL,NULL),(7,'Force India',NULL,NULL),(8,'Haas',NULL,NULL),(9,'Red Bull Racing',NULL,NULL),(10,'Sauber',NULL,NULL),(11,'Toro Rosso',NULL,NULL),(12,'Manor',NULL,NULL),(13,'Renault',NULL,NULL);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `team_ranking`
--

DROP TABLE IF EXISTS `team_ranking`;
/*!50001 DROP VIEW IF EXISTS `team_ranking`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `team_ranking` AS SELECT 
 1 AS `team_id`,
 1 AS `team_points`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `team_subscription`
--

DROP TABLE IF EXISTS `team_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_subscription` (
  `team_id` tinyint(4) NOT NULL,
  `user_id` varchar(12) NOT NULL,
  UNIQUE KEY `team_id` (`team_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `team_subscription_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`id_t`),
  CONSTRAINT `team_subscription_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_subscription`
--

LOCK TABLES `team_subscription` WRITE;
/*!40000 ALTER TABLE `team_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `id_t` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `place` varchar(12) NOT NULL,
  `info` varchar(150) DEFAULT NULL,
  `date` datetime NOT NULL,
  `img_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_t`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (24,'Melbourne','Australia',NULL,'2016-03-19 23:59:59',NULL),(25,'Sakhir','Bahrain',NULL,'2016-04-02 23:59:59',NULL),(26,'Shanghai','Cina',NULL,'2016-04-16 23:59:59',NULL),(27,'Sochi','Russia',NULL,'2016-04-30 23:59:59',NULL),(28,'Barcellona','Spagna',NULL,'2016-05-14 23:59:59',NULL),(29,'Montecarlo','Monaco',NULL,'2016-05-28 23:59:59',NULL),(30,'Montreal','Canada',NULL,'2016-06-11 23:59:59',NULL),(31,'Baku','Azerbaijan',NULL,'2016-06-18 23:59:59',NULL),(32,'Spielberg','Austria',NULL,'2016-07-02 23:59:59',NULL),(33,'Silverstone','UK',NULL,'2016-07-09 23:59:59',NULL),(34,'Hungaroring','Ungheria',NULL,'2016-07-23 23:59:59',NULL),(35,'Hockenheim','Germania',NULL,'2016-07-30 23:59:59',NULL),(36,'Spa','Belgio',NULL,'2016-08-27 23:59:59',NULL),(37,'Monza','Italia',NULL,'2016-09-03 23:59:59',NULL),(38,'Marina Bay','Singapore',NULL,'2016-09-17 23:59:59',NULL),(39,'Kuala Lumpur','Malesia',NULL,'2016-10-01 23:59:59',NULL),(40,'Suzuka','Giappone',NULL,'2016-10-08 23:59:59',NULL),(41,'Austin','Texas, USA',NULL,'2016-10-22 23:59:59',NULL),(42,'Mexico City','Messico',NULL,'2016-10-29 23:59:59',NULL),(43,'Interlagos','Brasile',NULL,'2016-11-12 23:59:59',NULL),(44,'Yas Marina','Abu Dhabi',NULL,'2016-11-26 23:59:59',NULL);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(12) NOT NULL,
  `email` varchar(30) NOT NULL,
  `passwd` varchar(64) NOT NULL,
  `money` tinyint(3) unsigned NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('larrywax','g.danna@live.it','asdsadsadfsa',100),('prova1','prova@prova.com','passababsasfsdv',100),('prova2','prova2@prova.com','dsdasgasfgsdg',100);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ranking`
--

DROP TABLE IF EXISTS `user_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ranking` (
  `user_id` varchar(12) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_ranking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ranking`
--

LOCK TABLES `user_ranking` WRITE;
/*!40000 ALTER TABLE `user_ranking` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_group`
--

DROP TABLE IF EXISTS `users_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_group` (
  `id_g` varchar(12) NOT NULL,
  `passwd` varchar(64) NOT NULL,
  `img_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_g`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_group`
--

LOCK TABLES `users_group` WRITE;
/*!40000 ALTER TABLE `users_group` DISABLE KEYS */;
INSERT INTO `users_group` VALUES ('padrepio','sadfsdfs','./img/padre');
/*!40000 ALTER TABLE `users_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `team_ranking`
--

/*!50001 DROP VIEW IF EXISTS `team_ranking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`formula1`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `team_ranking` AS select `ts`.`team_id` AS `team_id`,sum(`ur`.`points`) AS `team_points` from (`user_ranking` `ur` join `team_subscription` `ts`) where (`ur`.`user_id` = `ts`.`user_id`) group by `ts`.`team_id` order by `team_points` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-02 16:26:34
