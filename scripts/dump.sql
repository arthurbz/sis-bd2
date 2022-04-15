-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: db_app_db2
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `amizade`
--

DROP TABLE IF EXISTS `amizade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amizade` (
  `fk_leitor1` bigint NOT NULL,
  `fk_leitor2` bigint NOT NULL,
  PRIMARY KEY (`fk_leitor1`,`fk_leitor2`),
  KEY `fk_amizade_leitor2` (`fk_leitor2`),
  CONSTRAINT `fk_amizade_leitor1` FOREIGN KEY (`fk_leitor1`) REFERENCES `leitor` (`id_leitor`),
  CONSTRAINT `fk_amizade_leitor2` FOREIGN KEY (`fk_leitor2`) REFERENCES `leitor` (`id_leitor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amizade`
--

LOCK TABLES `amizade` WRITE;
/*!40000 ALTER TABLE `amizade` DISABLE KEYS */;
INSERT INTO `amizade` VALUES (2,1),(3,1),(4,1),(5,1),(1,2),(3,2),(1,3),(4,3),(5,3),(1,4),(5,4),(2,5),(4,5);
/*!40000 ALTER TABLE `amizade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id_autor` bigint NOT NULL AUTO_INCREMENT,
  `autor_nome` varchar(100) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Platão','2000-01-01'),(2,'Sêneca','2000-01-01'),(3,'Vitor E. Frankl','2000-01-01'),(4,'Andrew Tanenbaum','2000-01-01');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioteca`
--

DROP TABLE IF EXISTS `biblioteca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biblioteca` (
  `id_biblioteca` bigint NOT NULL AUTO_INCREMENT,
  `fk_leitor` bigint DEFAULT NULL,
  `biblioteca_nome` varchar(100) DEFAULT NULL,
  `biblioteca_tema` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_biblioteca`),
  KEY `fk_biblioteca_leitor` (`fk_leitor`),
  CONSTRAINT `fk_biblioteca_leitor` FOREIGN KEY (`fk_leitor`) REFERENCES `leitor` (`id_leitor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioteca`
--

LOCK TABLES `biblioteca` WRITE;
/*!40000 ALTER TABLE `biblioteca` DISABLE KEYS */;
INSERT INTO `biblioteca` VALUES (1,1,'A Gioteca, a bibliteca do Gio','Melhor um livro na mão que dois no chão'),(2,1,'AGIOTECA 2.0','A biblioteca dos agiotas'),(3,3,'Minha Biblioteca','Livros legais');
/*!40000 ALTER TABLE `biblioteca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioteca_tem_livro`
--

DROP TABLE IF EXISTS `biblioteca_tem_livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biblioteca_tem_livro` (
  `id_biblioteca_livro` bigint NOT NULL AUTO_INCREMENT,
  `fk_biblioteca` bigint DEFAULT NULL,
  `fk_livro` bigint DEFAULT NULL,
  PRIMARY KEY (`id_biblioteca_livro`),
  KEY `fk_biblioteca_livro` (`fk_livro`),
  CONSTRAINT `fk_biblioteca_livro` FOREIGN KEY (`fk_livro`) REFERENCES `livro` (`id_livro`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioteca_tem_livro`
--

LOCK TABLES `biblioteca_tem_livro` WRITE;
/*!40000 ALTER TABLE `biblioteca_tem_livro` DISABLE KEYS */;
INSERT INTO `biblioteca_tem_livro` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,1),(5,2,1),(6,2,3),(7,3,1),(8,3,2);
/*!40000 ALTER TABLE `biblioteca_tem_livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leitor`
--

DROP TABLE IF EXISTS `leitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leitor` (
  `id_leitor` bigint NOT NULL AUTO_INCREMENT,
  `leitor_nome` varchar(100) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_leitor`),
  CONSTRAINT `check_sexo` CHECK (((`sexo` = _utf8mb4'M') or (`sexo` = _utf8mb4'F')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leitor`
--

LOCK TABLES `leitor` WRITE;
/*!40000 ALTER TABLE `leitor` DISABLE KEYS */;
INSERT INTO `leitor` VALUES (1,'Guilherme Giordani','2000-10-08','M'),(2,'Leonardo Bortolini','2000-05-10','M'),(3,'Cléber Macieski','1992-12-03','M'),(4,'Arthur Bassotto Ziero','2001-02-02','M'),(5,'Alguma Vs. Sr.','2002-02-02','F');
/*!40000 ALTER TABLE `leitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leitor_tem_livro`
--

DROP TABLE IF EXISTS `leitor_tem_livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leitor_tem_livro` (
  `fk_leitor` bigint NOT NULL,
  `fk_livro` bigint NOT NULL,
  `quantidade` int DEFAULT NULL,
  PRIMARY KEY (`fk_leitor`,`fk_livro`),
  KEY `fk_ltl_livro` (`fk_livro`),
  CONSTRAINT `fk_ltl_leitor` FOREIGN KEY (`fk_leitor`) REFERENCES `leitor` (`id_leitor`),
  CONSTRAINT `fk_ltl_livro` FOREIGN KEY (`fk_livro`) REFERENCES `livro` (`id_livro`),
  CONSTRAINT `check_quantidade` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leitor_tem_livro`
--

LOCK TABLES `leitor_tem_livro` WRITE;
/*!40000 ALTER TABLE `leitor_tem_livro` DISABLE KEYS */;
INSERT INTO `leitor_tem_livro` VALUES (1,1,2),(1,3,1),(2,4,3),(3,2,1),(4,1,1),(4,2,1),(4,3,1),(4,4,1),(5,2,2),(5,3,1);
/*!40000 ALTER TABLE `leitor_tem_livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leitura`
--

DROP TABLE IF EXISTS `leitura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leitura` (
  `id_leitura` bigint NOT NULL AUTO_INCREMENT,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `opiniao_leitor` varchar(1000) DEFAULT NULL,
  `classificacao` int DEFAULT NULL,
  `fk_leitor` bigint NOT NULL,
  `fk_livro` bigint NOT NULL,
  PRIMARY KEY (`id_leitura`),
  KEY `fk_leitura_leitor` (`fk_leitor`),
  KEY `fk_leitura_livro` (`fk_livro`),
  CONSTRAINT `fk_leitura_leitor` FOREIGN KEY (`fk_leitor`) REFERENCES `leitor` (`id_leitor`),
  CONSTRAINT `fk_leitura_livro` FOREIGN KEY (`fk_livro`) REFERENCES `livro` (`id_livro`),
  CONSTRAINT `check_classificacao` CHECK (((`classificacao` >= 0) and (`classificacao` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leitura`
--

LOCK TABLES `leitura` WRITE;
/*!40000 ALTER TABLE `leitura` DISABLE KEYS */;
INSERT INTO `leitura` VALUES (1,'2021-01-01','2021-03-10','Muito bom',8,1,3),(2,'2021-03-09','2021-05-01','Complexo demais pro meu gosto',8,2,1),(3,'2021-01-01','2021-03-10','Não gostei 100%',4,3,4),(4,'2021-01-01','2021-02-10','Melhor que já li',10,1,3),(5,'2021-01-01','2021-03-10',NULL,10,3,3),(6,'2021-01-01','2021-03-10','Gostei até, mas ... ... ...',6,5,1),(7,'2021-01-01','2021-03-10','Muito bom!!! Gostei por que ...',9,4,2),(8,'2021-01-01','2021-03-10','Sim, gostei por tal e tal motivo',8,3,2);
/*!40000 ALTER TABLE `leitura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `id_livro` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) DEFAULT NULL,
  `tema` varchar(100) DEFAULT NULL,
  `paginas` int DEFAULT NULL,
  `data_publicacao` date DEFAULT NULL,
  `fk_autor` bigint DEFAULT NULL,
  PRIMARY KEY (`id_livro`),
  KEY `fk_livro_autor` (`fk_autor`),
  CONSTRAINT `fk_livro_autor` FOREIGN KEY (`fk_autor`) REFERENCES `autor` (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` VALUES (1,'A República','Filosofia',365,'2021-12-31',1),(2,'Sobre a brevidade da vida','Filosofia',120,'2021-12-31',2),(3,'Em busca de sentido','Filosofia',200,'2021-12-31',3),(4,'Sistemas Operacionais Modernos','Computadores',1000,'2021-12-31',4);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-15 14:40:33
