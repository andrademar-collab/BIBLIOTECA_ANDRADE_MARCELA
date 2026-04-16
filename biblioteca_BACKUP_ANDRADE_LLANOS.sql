CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Mariana','Enríquez'),(2,'Rick','Riordan'),(3,'Alice','Oseman'),(4,'Stephen','King'),(5,'Liliana','Bodoc'),(6,'Agatha','Christie'),(7,'Leigh','Bardugo'),(8,'Quino',' '),(9,'Neil','Gaiman'),(10,'Victoria','Aveyard');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editorial` (
  `id_editorial` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id_editorial`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editorial`
--

LOCK TABLES `editorial` WRITE;
/*!40000 ALTER TABLE `editorial` DISABLE KEYS */;
INSERT INTO `editorial` VALUES (3,'Anagrama'),(4,'Ivrea'),(5,'Océano'),(2,'Penguin Random House'),(1,'Planeta'),(6,'Salamandra'),(7,'Siglo XXI'),(9,'Sudamericana'),(8,'Urano'),(10,'V&R Editoras');
/*!40000 ALTER TABLE `editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejemplar`
--

DROP TABLE IF EXISTS `ejemplar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejemplar` (
  `id_ejemplar` int NOT NULL AUTO_INCREMENT,
  `id_libro` int NOT NULL,
  PRIMARY KEY (`id_ejemplar`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `ejemplar_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejemplar`
--

LOCK TABLES `ejemplar` WRITE;
/*!40000 ALTER TABLE `ejemplar` DISABLE KEYS */;
INSERT INTO `ejemplar` VALUES (1,1),(2,1),(3,1),(4,2),(5,2),(6,3),(7,3),(8,3),(9,4),(10,4),(11,5),(12,5),(13,5),(14,6),(15,6),(16,7),(17,7),(18,7),(19,8),(20,8),(21,9),(22,10),(23,11),(24,12),(25,13),(26,14),(27,15),(28,16),(29,16),(30,17),(31,18),(32,19),(33,20),(34,21),(35,22),(36,23),(37,24),(38,25);
/*!40000 ALTER TABLE `ejemplar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genero` (
  `id_genero` int NOT NULL AUTO_INCREMENT,
  `genero` varchar(20) NOT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE KEY `genero` (`genero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (6,'Aventura'),(4,'Ciencia Ficción'),(9,'Fantasía'),(8,'Historieta'),(1,'Misterio'),(3,'Mitología Griega'),(7,'Novela'),(10,'Policial'),(2,'Romance'),(5,'Terror');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `anio_publicacion` year NOT NULL,
  `id_autor` int NOT NULL,
  `id_editorial` int NOT NULL,
  `id_genero` int NOT NULL,
  PRIMARY KEY (`id_libro`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `id_autor` (`id_autor`),
  KEY `id_editorial` (`id_editorial`),
  KEY `id_genero` (`id_genero`),
  CONSTRAINT `libro_ibfk_1` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`),
  CONSTRAINT `libro_ibfk_2` FOREIGN KEY (`id_editorial`) REFERENCES `editorial` (`id_editorial`),
  CONSTRAINT `libro_ibfk_3` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'Nuestra parte de noche','9789877253641',2019,1,3,5),(2,'Las cosas que perdimos en el fuego','9789877120936',2016,1,3,5),(3,'El ladrón del rayo','9788498386264',2005,2,6,3),(4,'El mar de los monstruos','9788498386271',2006,2,6,3),(5,'Heartstopper vol 1','9789877475173',2019,3,10,8),(6,'Heartstopper vol 2','9789877475180',2019,3,10,8),(7,'It (Eso)','9789506440442',1986,4,2,5),(8,'El resplandor','9789500420105',1977,4,2,5),(9,'Los días del Venado','9789875666276',2000,5,9,9),(10,'Diez negritos','9789504924760',1939,6,1,1),(11,'Asesinato en el Orient Express','9789504924777',1934,6,1,10),(12,'Sombra y hueso','9789876098656',2012,7,10,9),(13,'Toda Mafalda','9789505156054',1993,8,4,8),(14,'Coraline','9788416240210',2002,9,6,5),(15,'American Gods','9788416240685',2001,9,2,9),(16,'La reina roja','9789876099684',2015,10,1,9),(17,'Seis de cuervos','9789877472486',2015,7,10,6),(18,'Misery','9789506440411',1987,4,2,5),(19,'La profecía del rastro','9788498380897',2007,2,6,3),(20,'El imperio de las tormentas','9789877472493',2016,10,8,9),(21,'Cien años de soledad','9789500700924',1967,5,9,7),(22,'El misterio de la guía de ferrocarriles','9788466336499',1936,6,1,10),(23,'Buenos días, princesa','9789504928683',2012,3,1,2),(24,'Sandman: Preludios y Nocturnos','9788417292211',1989,9,4,8),(25,'Los días del Fuego','9789875666283',2002,5,9,9);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_ejemplar` int NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  PRIMARY KEY (`id_prestamo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_ejemplar` (`id_ejemplar`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`id_ejemplar`) REFERENCES `ejemplar` (`id_ejemplar`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,1,1,'2026-03-01','2026-03-21',NULL),(2,6,23,'2026-03-01','2026-03-21',NULL),(3,2,4,'2026-03-05','2026-03-25',NULL),(4,3,6,'2026-03-10','2026-03-30',NULL),(5,9,20,'2026-03-10','2026-03-30',NULL),(6,4,9,'2026-03-15','2026-04-04',NULL),(7,5,11,'2026-03-20','2026-04-09',NULL),(8,7,15,'2026-03-22','2026-04-11',NULL),(9,8,17,'2026-03-28','2026-04-17',NULL),(10,10,25,'2026-04-01','2026-04-21',NULL);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_verificar_usuario_apto_prestamo` BEFORE INSERT ON `prestamo` FOR EACH ROW BEGIN
     
	-- Verificar que usuario no tenga ningun prestamo activo "atrasado"
    IF EXISTS (
		SELECT 1
        FROM view_prestamos_activos
        WHERE 
			id_usuario = NEW.id_usuario
            AND dias_restantes < 0
	) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario tiene prestamos atrasados. No puede solicitar un préstamo nuevo.';
	END IF;
    
    -- Verificar que usuario no tenga ningun prestamo activo "en término"
    IF EXISTS (
		SELECT 1
        FROM view_prestamos_activos
        WHERE
			id_usuario = NEW.id_usuario
            AND dias_restantes >= 0
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario tiene prestamos en curso. No puede solicitar un préstamo nuevo.';
	END IF;
    
	-- Verificar si el usuario esta sancionado por atraso
    IF EXISTS (
		SELECT 1
        FROM biblioteca.prestamo
		WHERE 
			id_usuario = NEW.id_usuario
			AND fecha_devolucion IS NOT NULL-- filtra prestamos finalizados
            AND fecha_devolucion > fecha_vencimiento
            AND DATEDIFF(CURDATE(), fecha_devolucion) < 20
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Usuario sancionado. Aun no puede solicitar un prestamo.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(20) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Lucas','Martínez','42123456','lucas.m@mail.com','2000-05-15','1144556677'),(2,'Micaela','García','43987654','mica.g@mail.com','2002-11-20','1122334455'),(3,'Enzo','Fernández','41555666','enzo.f@mail.com','2009-01-10','1133445566'),(4,'Valentina','Pérez','45111222','valen.p@mail.com','2004-03-30','1166778899'),(5,'Julián','Álvarez','44333444','julian.a@mail.com','2003-07-22','1155667788'),(6,'Sofía','Rodríguez','42000111','sofi.rod@mail.com','2000-09-05','2214455667'),(7,'Mateo','López','46777888','mateo.l@mail.com','2006-02-14','3416677889'),(8,'Camila','Sosa','43222111','cami.s@mail.com','2001-12-12','1199887766'),(9,'Bautista','Gómez','44888999','bauti.g@mail.com','2003-05-05','1177665544'),(10,'Delfina','Ruiz','41999000','delfina.r@mail.com','2002-08-25','1188776655');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_validar_edad_usuario` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
	DECLARE v_edad INT;
    
    -- Validar que la fecha de nacimiento sea anterior a la fecha actual
    IF NEW.fecha_nacimiento >= CURDATE() THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La fecha de nacimiento debe ser anterior a la fecha actual.';
	END IF;
    
    -- Calcular la edad del usuario en años
    SET v_edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE());
    
    -- Validar que el usuario tenga entre 16 y 26 años (regla de negocio)
    IF v_edad < 16 OR v_edad > 26 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario debe tener entre 16 y 26 años para registrarse.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `view_disponibilidad_ejemplares`
--

DROP TABLE IF EXISTS `view_disponibilidad_ejemplares`;
/*!50001 DROP VIEW IF EXISTS `view_disponibilidad_ejemplares`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_disponibilidad_ejemplares` AS SELECT 
 1 AS `id_ejemplar`,
 1 AS `id_libro`,
 1 AS `titulo`,
 1 AS `autor`,
 1 AS `anio_publicacion`,
 1 AS `isbn`,
 1 AS `editorial`,
 1 AS `genero`,
 1 AS `disponibilidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_nro_prestamos_por_usuario`
--

DROP TABLE IF EXISTS `view_nro_prestamos_por_usuario`;
/*!50001 DROP VIEW IF EXISTS `view_nro_prestamos_por_usuario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_nro_prestamos_por_usuario` AS SELECT 
 1 AS `id_usuario`,
 1 AS `nombre`,
 1 AS `fecha_nacimiento`,
 1 AS `edad`,
 1 AS `email`,
 1 AS `prestamos_realizados`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_prestamos_activos`
--

DROP TABLE IF EXISTS `view_prestamos_activos`;
/*!50001 DROP VIEW IF EXISTS `view_prestamos_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_prestamos_activos` AS SELECT 
 1 AS `id_prestamo`,
 1 AS `id_usuario`,
 1 AS `usuario`,
 1 AS `dni`,
 1 AS `email`,
 1 AS `id_ejemplar`,
 1 AS `titulo`,
 1 AS `fecha_prestamo`,
 1 AS `fecha_vencimiento`,
 1 AS `dias_restantes`,
 1 AS `estado_prestamo`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'biblioteca'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calcular_edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcular_edad`(p_id_usuario INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE v_fecha_nacimiento DATE;
    DECLARE v_edad INT;
    
    -- Buscar la fecha de nacimiento del usuario
    SELECT fecha_nacimiento INTO v_fecha_nacimiento
    FROM biblioteca.usuario
    WHERE id_usuario = p_id_usuario;
    
    -- Calcular la edad
    SET v_edad = TIMESTAMPDIFF(YEAR, v_fecha_nacimiento, CURDATE());
    
    RETURN v_edad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_dias_restantes_vencimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_dias_restantes_vencimiento`(p_id_prestamo INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE v_fecha_vencimiento DATE;
    DECLARE v_dias_restantes INT;
    
    -- Buscar la fecha de vencimiento del prestamo
    SELECT fecha_vencimiento INTO v_fecha_vencimiento
	FROM biblioteca.prestamo
	WHERE 
		id_prestamo = p_id_prestamo
		AND fecha_devolucion IS NULL;
        
    -- Calcular los dias restantes para el vencimiento del prestamo
    SET v_dias_restantes = DATEDIFF(v_fecha_vencimiento, CURDATE());
    RETURN v_dias_restantes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_prestamos_x_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_prestamos_x_usuario`(p_id_usuario INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE v_nro_prestamos INT;
    
    -- Contar el nro de prestamos realizados por usuario
    SELECT
		COUNT(*) INTO v_nro_prestamos
    FROM biblioteca.prestamo
    WHERE 
		id_usuario = p_id_usuario;
    
    RETURN v_nro_prestamos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_devolucion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_devolucion`(IN p_id_prestamo INT)
BEGIN
	DECLARE v_estado_prestamo VARCHAR(10);
    DECLARE v_mensaje VARCHAR(100);

	-- Ver el estado del prestamo (ATRASADO/EN TERMINO/VENCE HOY)
	SELECT estado_prestamo INTO v_estado_prestamo 
	FROM view_prestamos_activos
	WHERE id_prestamo = p_id_prestamo;
    
    -- Insertar la fecha de devolución
    UPDATE biblioteca.prestamo 
    SET fecha_devolucion = CURDATE()
    WHERE id_prestamo = p_id_prestamo;
    
    -- Definir el mensaje de retorno segun el estado del prestamo
    IF v_estado_prestamo = 'ATRASADO' THEN
        SET v_mensaje = 'Devolución tardía. No puede solicitar ningún préstamo en 20 días.';
	ELSE
		SET v_mensaje = 'Devolución registrada con éxito. El usuario puede solicitar un nuevo préstamo.';
	END IF;
    
    -- Mostrar el mensaje de retorno
    SELECT v_mensaje AS resultado_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_prestamo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_prestamo`(IN p_id_usuario INT, IN p_id_ejemplar INT)
BEGIN
    
	-- Insertar datos para el registro del prestamo
	INSERT INTO biblioteca.prestamo (id_usuario, id_ejemplar, fecha_prestamo, fecha_vencimiento)
    VALUES (p_id_usuario, p_id_ejemplar, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 20 DAY));
    
    -- Mensaje de confirmacion
    SELECT 
		CONCAT('Préstamo Nro. ', LAST_INSERT_ID(), ' registrado correctamente. Vencimiento: ', DATE_ADD(CURDATE(), INTERVAL 20 DAY))
		AS resultado_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_disponibilidad_ejemplares`
--

/*!50001 DROP VIEW IF EXISTS `view_disponibilidad_ejemplares`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_disponibilidad_ejemplares` AS select `e`.`id_ejemplar` AS `id_ejemplar`,`l`.`id_libro` AS `id_libro`,`l`.`titulo` AS `titulo`,concat(`a`.`nombre`,' ',`a`.`apellido`) AS `autor`,`l`.`anio_publicacion` AS `anio_publicacion`,`l`.`isbn` AS `isbn`,`ed`.`nombre` AS `editorial`,`g`.`genero` AS `genero`,(case when (`p`.`id_prestamo` is not null) then 'PRESTADO' when (`p`.`id_prestamo` is null) then 'DISPONIBLE' end) AS `disponibilidad` from (((((`ejemplar` `e` join `libro` `l` on((`e`.`id_libro` = `l`.`id_libro`))) join `autor` `a` on((`l`.`id_autor` = `a`.`id_autor`))) join `editorial` `ed` on((`l`.`id_editorial` = `ed`.`id_editorial`))) join `genero` `g` on((`l`.`id_genero` = `g`.`id_genero`))) left join `prestamo` `p` on(((`e`.`id_ejemplar` = `p`.`id_ejemplar`) and (`p`.`fecha_devolucion` is null)))) order by `e`.`id_ejemplar` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_nro_prestamos_por_usuario`
--

/*!50001 DROP VIEW IF EXISTS `view_nro_prestamos_por_usuario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_nro_prestamos_por_usuario` AS select `u`.`id_usuario` AS `id_usuario`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `nombre`,`u`.`fecha_nacimiento` AS `fecha_nacimiento`,`fn_calcular_edad`(`u`.`id_usuario`) AS `edad`,`u`.`email` AS `email`,`fn_prestamos_x_usuario`(`u`.`id_usuario`) AS `prestamos_realizados` from `usuario` `u` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_prestamos_activos`
--

/*!50001 DROP VIEW IF EXISTS `view_prestamos_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_prestamos_activos` AS select `p`.`id_prestamo` AS `id_prestamo`,`u`.`id_usuario` AS `id_usuario`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `usuario`,`u`.`dni` AS `dni`,`u`.`email` AS `email`,`e`.`id_ejemplar` AS `id_ejemplar`,`l`.`titulo` AS `titulo`,`p`.`fecha_prestamo` AS `fecha_prestamo`,`p`.`fecha_vencimiento` AS `fecha_vencimiento`,`fn_dias_restantes_vencimiento`(`p`.`id_prestamo`) AS `dias_restantes`,(case when (`fn_dias_restantes_vencimiento`(`p`.`id_prestamo`) < 0) then 'ATRASADO' when (`fn_dias_restantes_vencimiento`(`p`.`id_prestamo`) = 0) then 'VENCE HOY' when (`fn_dias_restantes_vencimiento`(`p`.`id_prestamo`) > 0) then 'EN TERMINO' end) AS `estado_prestamo` from (((`prestamo` `p` join `usuario` `u` on((`p`.`id_usuario` = `u`.`id_usuario`))) join `ejemplar` `e` on((`p`.`id_ejemplar` = `e`.`id_ejemplar`))) join `libro` `l` on((`e`.`id_libro` = `l`.`id_libro`))) where (`p`.`fecha_devolucion` is null) */;
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

-- Dump completed on 2026-04-16 16:24:28
