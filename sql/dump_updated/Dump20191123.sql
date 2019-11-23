-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: updated_schema
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `name` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `unit` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (1,1,'chicken tenders',200,'grams'),(2,1,'oil',1000,'ml'),(3,1,'flour',500,'grams'),(4,1,'batter',500,'ml'),(5,2,'noodles',500,'grams'),(6,2,'ground beef',250,'grams'),(7,2,'tomato sauce',50,'ml'),(8,3,'Fruit Loops Cereal',50,'grams'),(9,3,'Milk',50,'ml');
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe`
--

DROP TABLE IF EXISTS `Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `serving_size` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `instructions` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `source` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe`
--

LOCK TABLES `Recipe` WRITE;
/*!40000 ALTER TABLE `Recipe` DISABLE KEYS */;
INSERT INTO `Recipe` VALUES (1,'Crispy Chicken Tenders',6,25,2,'First take the chicken. Then Coat it in flour. Dip it in batter. Coat it again. Lastly, fry until brown'),(2,'Spaghetti',4,20,1,'Boil noodles until soft. Cook the ground beef and add the sauce. Mix noodles with sauce and meat.'),(3,'Fruit Loops',1,2,NULL,'Pour the cereal into a bowl. Add milk to desired milkiness');
/*!40000 ALTER TABLE `Recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_tag`
--

DROP TABLE IF EXISTS `Recipe_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe_tag` (
  `recipe_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  KEY `recipe_id` (`recipe_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `recipe_tag_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
  CONSTRAINT `recipe_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_tag`
--

LOCK TABLES `Recipe_tag` WRITE;
/*!40000 ALTER TABLE `Recipe_tag` DISABLE KEYS */;
INSERT INTO `Recipe_tag` VALUES (3,1),(3,3),(1,3),(1,5),(1,4),(2,2),(1,4);
/*!40000 ALTER TABLE `Recipe_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Source`
--

DROP TABLE IF EXISTS `Source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `year_published` int(11) DEFAULT NULL,
  `author` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Source`
--

LOCK TABLES `Source` WRITE;
/*!40000 ALTER TABLE `Source` DISABLE KEYS */;
INSERT INTO `Source` VALUES (1,'Cookbook Extravaganza',2002,'Rachel Ray'),(2,'Ahmad\'s Great Dishes',2019,'Ahmad El-Bobou');
/*!40000 ALTER TABLE `Source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag`
--

LOCK TABLES `Tag` WRITE;
/*!40000 ALTER TABLE `Tag` DISABLE KEYS */;
INSERT INTO `Tag` VALUES (1,'breakfast'),(2,'Italian'),(3,'American'),(4,'dinner'),(5,'fried');
/*!40000 ALTER TABLE `Tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-23 20:57:11
