-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: activmind
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add token',8,'add_tokenproxy'),(30,'Can change token',8,'change_tokenproxy'),(31,'Can delete token',8,'delete_tokenproxy'),(32,'Can view token',8,'view_tokenproxy'),(33,'Can add user info',9,'add_userinfo'),(34,'Can change user info',9,'change_userinfo'),(35,'Can delete user info',9,'delete_userinfo'),(36,'Can view user info',9,'view_userinfo'),(37,'Can add user info',10,'add_userinfo'),(38,'Can change user info',10,'change_userinfo'),(39,'Can delete user info',10,'delete_userinfo'),(40,'Can view user info',10,'view_userinfo'),(41,'Can add medicament',11,'add_medicament'),(42,'Can change medicament',11,'change_medicament'),(43,'Can delete medicament',11,'delete_medicament'),(44,'Can view medicament',11,'view_medicament'),(45,'Can add task',12,'add_task'),(46,'Can change task',12,'change_task'),(47,'Can delete task',12,'delete_task'),(48,'Can view task',12,'view_task'),(49,'Can add activity',13,'add_activity'),(50,'Can change activity',13,'change_activity'),(51,'Can delete activity',13,'delete_activity'),(52,'Can view activity',13,'view_activity'),(53,'Can add sport',14,'add_sport'),(54,'Can change sport',14,'change_sport'),(55,'Can delete sport',14,'delete_sport'),(56,'Can view sport',14,'view_sport');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_core_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `core_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('07f58044dfa5694f0788218de8b9153c06857ae3','2024-03-07 21:34:32.040696',14),('10dc6312bdd4baf33271c7c32430f8222908ce99','2024-02-20 20:47:50.736492',5),('23b5180c8281a5a172a6bd457fbc485ce9b32968','2024-02-20 22:11:33.711900',6),('44441f29d825713f572d8f501277f98fc1284813','2024-02-24 01:11:30.107563',8),('512bf06960d4d4c43896d24c86b190b5be10c42d','2024-03-08 22:22:46.789647',18),('51ef586a285358107d33865588adab3395c37168','2024-03-08 22:24:43.624148',19),('592ecb3371914307bdf6d95bd7000a6a9571e5fd','2024-02-24 01:13:47.496934',9),('5fdee20b521703cee5070195c848b888cb7de50e','2024-03-07 21:35:33.074845',15),('60891f2a20c655fb8b8bf2f2aae4d3349f37c0ce','2024-03-07 23:26:16.051273',17),('647db93f7b803bb0e83ac4cf7205ceaa2f5c33f0','2024-03-07 21:18:44.840475',12),('7ff90ca05293d2d96d498e668008bc35c2ab2395','2024-03-07 21:19:44.827996',13),('bf5e58e338cdf350ba66be4f7f19e55a1d1f43bc','2024-02-20 20:39:04.129278',4),('dde72b1ab0cd1180b92047492137fe53d0f8b523','2024-03-07 22:36:08.679278',16),('dec1e2649ab9f7a86f471616b8c214d7635342c8','2024-02-20 22:30:04.475927',7),('f169d04a4db030c1c644023f985fa76920d2a69a','2024-02-25 04:47:12.834727',10),('fd7747b59e9fe24fa0324dbcd9b47e392c3c515c','2024-03-07 21:12:55.536051',11);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_activity`
--

DROP TABLE IF EXISTS `core_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `location` varchar(50) NOT NULL,
  `text` varchar(100) NOT NULL,
  `task_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_activity_task_id_02ef3036_fk_core_task_id` (`task_id`),
  CONSTRAINT `core_activity_task_id_02ef3036_fk_core_task_id` FOREIGN KEY (`task_id`) REFERENCES `core_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_activity`
--

LOCK TABLES `core_activity` WRITE;
/*!40000 ALTER TABLE `core_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customuser`
--

DROP TABLE IF EXISTS `core_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customuser`
--

LOCK TABLES `core_customuser` WRITE;
/*!40000 ALTER TABLE `core_customuser` DISABLE KEYS */;
INSERT INTO `core_customuser` VALUES (1,'pbkdf2_sha256$720000$jWbxev6QdW2GrjT113SXaG$9EDKUL4pXmx6Y2Ivvt+0nyBgKAk2tLLV3Ix8Qhq7Wh0=','2024-03-12 21:59:54.703898',1,'admin@admin.com',1,1,'2024-02-20 18:44:33.396451','P'),(2,'pbkdf2_sha256$600000$7ZoSJAUKR6YM5z5UbVD3kr$r4VhCU21CQcluZ5PYnlte23wTEFiwu9EVCBJ8CIyMqc=',NULL,0,'pedram@email.com',1,0,'2024-02-20 20:16:23.468898','P'),(3,'pbkdf2_sha256$600000$LnyR6BKdnaoSRcYv7ibMQZ$B6cUMGDWwfzPBtALuAqQOd1paWxQCkBQYdvytdvIc1g=',NULL,0,'pedram@admin.com',1,0,'2024-02-20 20:33:53.896914','P'),(4,'pbkdf2_sha256$600000$fZVCPKkT3dmoKlwOS03Xnh$y5BNTPd4oCOcuR0EPY08GcxbxH+uPRThWtrVhfeaIBA=','2024-02-20 20:39:48.028627',0,'alex@admin.com',1,0,'2024-02-20 20:39:04.121099','P'),(5,'pbkdf2_sha256$600000$uYrcXuXUAPzAoO1r6wVlpA$p1JmNr01byn6DqpwkE8oLG3YsJ9n0cpK/jHGJuL/qu4=','2024-02-20 21:10:01.626097',0,'alex2@gmail.com',1,0,'2024-02-20 20:47:50.726231','P'),(6,'pbkdf2_sha256$600000$b1e1I1ZNxQC4mucBf4gzod$1iJWihby0SnCAEzy1W/RpZdP++TMUJUU8+AT2Dk020k=','2024-02-20 22:18:45.401832',0,'alex5@gmail.com',1,0,'2024-02-20 22:11:33.683592','P'),(7,'pbkdf2_sha256$600000$UQzW977wfVzeWw5IZbOtG4$QVcBUTTE/BydHP37vLytoZ3/i8BDTi4TtlnI9ZcM52A=',NULL,0,'frelix@gmail.com',1,0,'2024-02-20 22:30:04.465610','P'),(8,'pbkdf2_sha256$600000$xjiUWGXY760oehHKrxr7sL$GOWSrsX5RHtj8/Z1DTfg+juvrCxCVvrB9OY+fAIGFdc=',NULL,0,'alex7@gmail.com',1,0,'2024-02-24 01:11:30.091845','P'),(9,'pbkdf2_sha256$600000$BvwT11Vz0AbktYgpodDgkL$Rr18bwcjDgwm6S1QiYuN9BBr56595OZAwgJ4vLsvLTw=',NULL,0,'alex8@gmail.com',1,0,'2024-02-24 01:13:47.486272','P'),(10,'pbkdf2_sha256$600000$EbAQaASiyHXrB0NQrEKex6$zdeLId2lHMQU7FW4ZOO760qjlEKsNeht8VifKuaEuYo=','2024-02-25 04:47:23.978009',0,'pedram.pourmajidian@gmail.com',1,0,'2024-02-25 04:47:12.818007','P'),(11,'123 45678',NULL,0,'test@activ.com',1,0,'2024-03-07 21:12:55.518779','P'),(12,'sd  dfdf',NULL,0,'test2@activ.com',1,0,'2024-03-07 21:18:44.824177','P'),(13,'125 788',NULL,0,'test3@ac.sd',1,0,'2024-03-07 21:19:44.827996','P'),(14,'pbkdf2_sha256$720000$0TAeEPmeBZFooq7nkNZYUl$K2i9ONu0dnGsJq/A5MoeL6E4RqGK5ABa1RlZ/BzUMC4=',NULL,0,'pedram.pourmsdian@gmail.com',1,0,'2024-03-07 21:34:32.034101','P'),(15,'pbkdf2_sha256$720000$vmJpoXNvwA080pK4uEjhYz$4Ky4EZ3EatnOYUPu0/C5vj68dLI8h494et4PNU6z+Pg=',NULL,0,'admain@admin.com',1,0,'2024-03-07 21:35:33.064699','P'),(16,'pbkdf2_sha256$720000$kDj4eZEtVkW4wgqo6yN7ba$bHokq+ipQRQC2RyYAms4W266ZHMpDSJJS+407/WmOiE=',NULL,0,'test4@activ.com',1,0,'2024-03-07 22:36:08.670102','P'),(17,'pbkdf2_sha256$720000$kVxlOIQUmPY9Z0JcriDR9r$3qp0GoWnynibrAqqskzhO+zWje+GJefZ+W9Ggh0q+Ms=','2024-03-08 23:55:10.801210',0,'user@activ.com',1,0,'2024-03-07 23:26:16.036302','P'),(18,'pbkdf2_sha256$720000$z0mIczTV9Ru402y0wpsofT$AtARfdpe5Rx5pqbyNbu+XNqX6ieUwXTr/kTDUYsnq0g=','2024-03-08 22:23:26.258024',0,'user2@activ.com',1,0,'2024-03-08 22:22:46.788147','P'),(19,'pbkdf2_sha256$720000$WECtrhXEJP61GTtnXdFsE1$J8W6euhlHoqom+d3s5Dl3/dM3Abi71/SyAlWGv5/2h8=','2024-03-09 00:38:15.024883',0,'user3@activ.com',1,0,'2024-03-08 22:24:43.607656','P');
/*!40000 ALTER TABLE `core_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customuser_associated_user`
--

DROP TABLE IF EXISTS `core_customuser_associated_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customuser_associated_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `from_customuser_id` bigint NOT NULL,
  `to_customuser_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customuser_associated_user`
--

LOCK TABLES `core_customuser_associated_user` WRITE;
/*!40000 ALTER TABLE `core_customuser_associated_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customuser_associated_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customuser_groups`
--

DROP TABLE IF EXISTS `core_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_customuser_groups_customuser_id_group_id_7990e9c6_uniq` (`customuser_id`,`group_id`),
  KEY `core_customuser_groups_group_id_301aeff4_fk_auth_group_id` (`group_id`),
  CONSTRAINT `core_customuser_grou_customuser_id_976bc4d7_fk_core_cust` FOREIGN KEY (`customuser_id`) REFERENCES `core_customuser` (`id`),
  CONSTRAINT `core_customuser_groups_group_id_301aeff4_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customuser_groups`
--

LOCK TABLES `core_customuser_groups` WRITE;
/*!40000 ALTER TABLE `core_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customuser_user_permissions`
--

DROP TABLE IF EXISTS `core_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_customuser_user_per_customuser_id_permission_49ea742a_uniq` (`customuser_id`,`permission_id`),
  KEY `core_customuser_user_permission_id_80ceaab9_fk_auth_perm` (`permission_id`),
  CONSTRAINT `core_customuser_user_customuser_id_ebd2ce6c_fk_core_cust` FOREIGN KEY (`customuser_id`) REFERENCES `core_customuser` (`id`),
  CONSTRAINT `core_customuser_user_permission_id_80ceaab9_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customuser_user_permissions`
--

LOCK TABLES `core_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `core_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_medicament`
--

DROP TABLE IF EXISTS `core_medicament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_medicament` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dosage` varchar(100) NOT NULL,
  `infosupport` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_medicament`
--

LOCK TABLES `core_medicament` WRITE;
/*!40000 ALTER TABLE `core_medicament` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_medicament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_sport`
--

DROP TABLE IF EXISTS `core_sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_sport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Sporttype` varchar(20) NOT NULL,
  `repeatation_number` int NOT NULL,
  `info` varchar(100) NOT NULL,
  `task_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_sport_task_id_0c9db38c_fk_core_task_id` (`task_id`),
  CONSTRAINT `core_sport_task_id_0c9db38c_fk_core_task_id` FOREIGN KEY (`task_id`) REFERENCES `core_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_sport`
--

LOCK TABLES `core_sport` WRITE;
/*!40000 ALTER TABLE `core_sport` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_task`
--

DROP TABLE IF EXISTS `core_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `discription` varchar(200) NOT NULL,
  `creation_date` datetime(6) NOT NULL,
  `do_date` date NOT NULL,
  `start_time` time(6) NOT NULL,
  `end_time` time(6) DEFAULT NULL,
  `repetation` tinyint(1) NOT NULL,
  `alarm` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `done` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_task_user_id_4cb533ff_fk_core_customuser_id` (`user_id`),
  CONSTRAINT `core_task_user_id_4cb533ff_fk_core_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `core_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_task`
--

LOCK TABLES `core_task` WRITE;
/*!40000 ALTER TABLE `core_task` DISABLE KEYS */;
INSERT INTO `core_task` VALUES (3,'test3','test3 dis','2024-03-11 00:25:01.532623','2024-03-10','21:25:00.000000','21:30:00.000000',1,0,18,1),(4,'test4','test34','2024-03-11 00:26:45.906220','2024-03-10','22:00:00.000000','23:00:00.000000',1,0,18,1),(5,'test5','test5 des','2024-03-11 00:33:12.178349','2024-03-10','22:00:00.000000','23:00:00.000000',1,0,18,1),(6,'test6','test6 des','2024-03-11 00:48:22.682997','2024-03-10','10:15:00.000000','16:15:00.000000',1,1,18,1),(16,'tasktest','testdiscription','2024-03-12 19:44:28.453037','2024-03-02','22:20:00.000000','22:25:00.000000',0,1,19,0),(17,'test1','test desc','2024-03-12 19:51:03.540819','2024-03-12','20:00:00.000000','20:30:00.000000',0,1,19,0),(18,'tas4','tw','2024-03-12 20:55:10.394560','2024-03-12','20:20:00.000000','20:25:00.000000',0,1,19,0),(20,'test fir','discription','2024-03-12 21:17:31.366219','2024-03-12','20:22:00.000000','22:20:00.000000',0,1,19,0);
/*!40000 ALTER TABLE `core_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userinfo`
--

DROP TABLE IF EXISTS `core_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_userinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `address_number` int DEFAULT NULL,
  `address_street` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_postal_code` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `core_userinfo_user_id_6fcb5dbd_fk_core_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `core_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userinfo`
--

LOCK TABLES `core_userinfo` WRITE;
/*!40000 ALTER TABLE `core_userinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_core_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `core_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(13,'core','activity'),(6,'core','customuser'),(11,'core','medicament'),(14,'core','sport'),(12,'core','task'),(10,'core','userinfo'),(5,'sessions','session'),(9,'users','userinfo');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-02-20 18:41:33.289123'),(2,'contenttypes','0002_remove_content_type_name','2024-02-20 18:41:33.433656'),(3,'auth','0001_initial','2024-02-20 18:41:34.380855'),(4,'auth','0002_alter_permission_name_max_length','2024-02-20 18:41:34.543342'),(5,'auth','0003_alter_user_email_max_length','2024-02-20 18:41:34.552638'),(6,'auth','0004_alter_user_username_opts','2024-02-20 18:41:34.568339'),(7,'auth','0005_alter_user_last_login_null','2024-02-20 18:41:34.588052'),(8,'auth','0006_require_contenttypes_0002','2024-02-20 18:41:34.601320'),(9,'auth','0007_alter_validators_add_error_messages','2024-02-20 18:41:34.616163'),(10,'auth','0008_alter_user_username_max_length','2024-02-20 18:41:34.630040'),(11,'auth','0009_alter_user_last_name_max_length','2024-02-20 18:41:34.646822'),(12,'auth','0010_alter_group_name_max_length','2024-02-20 18:41:34.675810'),(13,'auth','0011_update_proxy_permissions','2024-02-20 18:41:34.692415'),(14,'auth','0012_alter_user_first_name_max_length','2024-02-20 18:41:34.702701'),(15,'core','0001_initial','2024-02-20 18:41:35.440569'),(16,'admin','0001_initial','2024-02-20 18:41:35.740600'),(17,'admin','0002_logentry_remove_auto_add','2024-02-20 18:41:35.756065'),(18,'admin','0003_logentry_add_action_flag_choices','2024-02-20 18:41:35.785676'),(19,'sessions','0001_initial','2024-02-20 18:41:35.879221'),(20,'core','0002_alter_customuser_type','2024-02-20 18:44:11.588614'),(21,'authtoken','0001_initial','2024-02-20 20:38:43.239867'),(22,'authtoken','0002_auto_20160226_1747','2024-02-20 20:38:43.288144'),(23,'authtoken','0003_tokenproxy','2024-02-20 20:38:43.298266'),(24,'core','0003_rename_customuser_user','2024-03-05 22:00:03.100017'),(25,'core','0004_rename_user_customuser','2024-03-05 22:00:04.124815'),(26,'core','0005_alter_customuser_type','2024-03-05 22:00:04.140447'),(27,'users','0001_initial','2024-03-05 22:00:04.414445'),(28,'core','0006_alter_customuser_email_alter_customuser_type_and_more','2024-03-07 19:59:48.565913'),(29,'users','0002_delete_userinfo','2024-03-07 19:59:48.605878'),(30,'core','0007_customuser_user_type','2024-03-07 22:34:41.993532'),(31,'core','0008_medicament_task_sport_activity','2024-03-10 22:46:47.220042'),(32,'core','0009_task_done_alter_task_user','2024-03-12 13:27:04.597978'),(33,'core','0010_alter_customuser_email_alter_task_alarm_and_more','2024-03-28 20:24:53.113144'),(34,'core','0011_remove_customuser_type','2024-03-28 20:24:53.182145'),(35,'core','0012_remove_customuser_user_type','2024-03-28 20:24:53.240831'),(36,'core','0013_customuser_user_type','2024-03-28 20:24:53.333078'),(37,'core','0014_remove_customuser_user_type','2024-03-28 20:24:53.400374'),(38,'core','0015_customuser_user_type','2024-03-28 20:24:53.517529');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('021vbx62698u2upwhgpnlczk9hdl1m0p','.eJxVjEEOwiAQRe_C2pABplBcuvcMZGBAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hYnEWSpx-t0jpkdsO-E7tNss0t3WZotwVedAurzPn5-Vw_w4q9fqtrR8dQnQRkgaHNBqlgHAwHhktsS46a7KI3kICrYeChYkTeGdsNkW8P7FsNwM:1rcV6z:60uHHQ8am4qU-KWbaLdUeSQ0gLbHBovFvyLdqIPoWD0','2024-03-05 18:45:01.923696'),('8srlzyl3lduvchcrrawl4m3ujje27o4y','.eJxVjDsOwjAQBe_iGlleJ_5R0ucM1nq9SwIokfKpEHcnkVJA-2bmvVXGbe3ztvCch6quCoK6_I4F6cnjQeoDx_ukaRrXeSj6UPRJF91NlV-30_076HHp97okA4CRvBWbmlZa13JELywpVXZhx2RYIAZvTAlsHTQWo3NClEhAfb7-Ujfn:1rik1I:hfAbJAXXZG-cMZSJtIF8_jfmqAdoI_Ruiqwhsl01fac','2024-03-22 23:52:56.845308'),('avxiuahxht5ltnsv63e0wehdshr757hp','.eJxVjDsOwjAQBe_iGlleJ_5R0ucM1nq9SwIokfKpEHcnkVJA-2bmvVXGbe3ztvCch6quCoK6_I4F6cnjQeoDx_ukaRrXeSj6UPRJF91NlV-30_076HHp97okA4CRvBWbmlZa13JELywpVXZhx2RYIAZvTAlsHTQWo3NClEhAfb7-Ujfn:1rik3S:gJJoGKOnI2bepU6AZee9HH5ULKjd0Fr56h1Txq991xw','2024-03-22 23:55:10.809664'),('bf2bkbbbd7zacntx1jyq9afxaku1ftp6','.eJxVjDsOwjAQBe_iGln-xWYp6XMGa9dr4wBypDipEHeHSCmgfTPzXiLitta49bzEicVFaBCn35EwPXLbCd-x3WaZ5rYuE8ldkQftcpw5P6-H-3dQsddvrYoBxRCcchDYWEDvXDIhBFaDxUSkjPLWFZt9Yl0Mn2kg7cAzGNIo3h_jsjdx:1riieC:c5FcTDJbDQAnqpD0bVfLcrmuEyl9WAA3XyabmIAPR3I','2024-03-22 22:25:00.530943'),('diyhzs4dja5x8ycyimcm1phyoll0s6iw','.eJxVjDEOgzAMRe-SuYpiSHDSsTtnQI5tCm0FEoGp6t0LEkO7_vfef5uOtnXotqJLN4q5GjCX3y0TP3U6gDxous-W52ldxmwPxZ602HYWfd1O9-9goDLsda56dg0kTw1G9hIiYR3BuaCKjMIJApAKcG6ir3edXF8JgE8JFZP5fAHcSTen:1rkAA6:AvjdRfRz2InfqcaamtFKyeMt7Dg2y3Hu02kk0a_5O48','2024-03-26 21:59:54.725079'),('knagq1wx0mbbyugcwnmpqnwd1xo48nxj','.eJxVjMsOwiAQRf-FtSEMUGbq0r3fQHgMUjUlKe3K-O_apAvd3nPOfQkftrX6rfPipyzOAkicfscY0oPnneR7mG9NpjavyxTlrsiDdnltmZ-Xw_07qKHXb00atLE2EY2sHCU3gHZlVNEicjKp0AhBG4VQEJ0NCpHAAqNWagAu4v0BzF42ZA:1riicg:0K7RMXCk8pw1x4lJ1Hq6uKiCJfntC-U-xjUDS4VvROM','2024-03-22 22:23:26.283032'),('mntpf4kq6aikad4ugw0302enmvg9j762','.eJxVjDsOwjAQBe_iGln-xWYp6XMGa9dr4wBypDipEHeHSCmgfTPzXiLitta49bzEicVFaBCn35EwPXLbCd-x3WaZ5rYuE8ldkQftcpw5P6-H-3dQsddvrYoBxRCcchDYWEDvXDIhBFaDxUSkjPLWFZt9Yl0Mn2kg7cAzGNIo3h_jsjdx:1rikj9:wimbEFP_ViulAYP33E9D8z-FMXbkGJ27kikG0QuE6GM','2024-03-23 00:38:15.034555'),('q95quk3wy1xthoobcs9vomwbdfnbb65g','.eJxVjEEOwiAQRe_C2pDCwJS6dN8zEBimUjWQlHZlvLtt0oVu_3vvv4UP25r91njxcxJXYcXld4uBnlwOkB6h3KukWtZljvJQ5EmbHGvi1-10_w5yaHmvwTjSiHZgzRZYJR0SBqSOQbPqexfB0G4Y0gYJJlRdMmxpmKzDyCA-X9WSN6g:1rcXNJ:MP4Vv17sWqHxlz90fTr9H2ZqHXWK0eD43RoYdpDfLPI','2024-03-05 21:10:01.639382'),('r1e9zvzds1xwyb0yb8pyassod3drbccy','.eJxVjDsOwjAQBe_iGlleJ_5R0ucM1nq9SwIokfKpEHcnkVJA-2bmvVXGbe3ztvCch6quCoK6_I4F6cnjQeoDx_ukaRrXeSj6UPRJF91NlV-30_076HHp97okA4CRvBWbmlZa13JELywpVXZhx2RYIAZvTAlsHTQWo3NClEhAfb7-Ujfn:1riiae:yDjsfAeeXY8OlrJTnaHcqs1iOBCQV1BcU2WofHoh0Xk','2024-03-22 22:21:20.205802'),('vz98uovr33w7w4j1v4y3puzcsanrdtx7','.eJxVjDsOwjAQBe_iGln-xWYp6XMGa9dr4wBypDipEHeHSCmgfTPzXiLitta49bzEicVFaBCn35EwPXLbCd-x3WaZ5rYuE8ldkQftcpw5P6-H-3dQsddvrYoBxRCcchDYWEDvXDIhBFaDxUSkjPLWFZt9Yl0Mn2kg7cAzGNIo3h_jsjdx:1rik24:rrPk_8sING4e4HdD0QbTl8dKVF7hlMBQKV4eYMcX-WA','2024-03-22 23:53:44.284746');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-29 19:36:11
