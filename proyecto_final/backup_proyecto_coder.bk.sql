-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_coder
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Current Database: `proyecto_coder`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `proyecto_coder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `proyecto_coder`;

--
-- Table structure for table `categoria_producto`
--

DROP TABLE IF EXISTS `categoria_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_producto` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_producto`
--

LOCK TABLES `categoria_producto` WRITE;
/*!40000 ALTER TABLE `categoria_producto` DISABLE KEYS */;
INSERT INTO `categoria_producto` VALUES (1,'Casual'),(5,'Deportes'),(4,'Pelotas'),(2,'Running'),(3,'Training');
/*!40000 ALTER TABLE `categoria_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudades`
--

DROP TABLE IF EXISTS `ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudades` (
  `id_ciudad` int NOT NULL AUTO_INCREMENT,
  `nom_ciudad` varchar(20) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  UNIQUE KEY `nom_ciudad` (`nom_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
INSERT INTO `ciudades` VALUES (5,'Asunci├│n'),(9,'Bogot├í'),(2,'Buenos Aires'),(10,'Caracas'),(7,'La Paz'),(6,'Lima'),(1,'Montevideo'),(8,'Quito'),(4,'Santiago'),(3,'S├úo Paulo');
/*!40000 ALTER TABLE `ciudades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_ventas`
--

DROP TABLE IF EXISTS `detalle_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_ventas` (
  `id_detalle_venta` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `prc_unitario` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle_venta`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_ventas`
--

LOCK TABLES `detalle_ventas` WRITE;
/*!40000 ALTER TABLE `detalle_ventas` DISABLE KEYS */;
INSERT INTO `detalle_ventas` VALUES (21,11,51,2,1200.00,2400.00),(22,12,52,1,2200.00,2200.00),(23,13,53,3,1500.00,4500.00),(24,14,54,1,800.00,800.00),(25,15,55,2,1000.00,2000.00),(26,16,56,1,1300.00,1300.00),(27,17,57,1,2500.00,2500.00),(28,18,58,2,2000.00,4000.00),(29,19,59,1,1400.00,1400.00),(30,20,60,1,600.00,600.00),(31,11,51,-2,1200.00,-2400.00),(32,11,51,2,1200.00,2400.00),(33,11,51,10,1200.00,12000.00);
/*!40000 ALTER TABLE `detalle_ventas` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_stock` BEFORE INSERT ON `detalle_ventas` FOR EACH ROW BEGIN
    DECLARE stock_actual INT;

    SELECT cantidad INTO stock_actual
    FROM inventario
    WHERE id_producto = NEW.id_producto
      AND id_sucursal = (
          SELECT id_sucursal FROM ventas WHERE id_venta = NEW.id_venta
      )
    LIMIT 1;

    IF stock_actual IS NULL OR stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para este producto.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_stock` AFTER INSERT ON `detalle_ventas` FOR EACH ROW BEGIN
    UPDATE inventario
    SET cantidad = cantidad - NEW.cantidad
    WHERE id_producto = NEW.id_producto
      AND id_sucursal = (
          SELECT id_sucursal FROM ventas WHERE id_venta = NEW.id_venta
      )
    LIMIT 1;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se pudo actualizar el inventario.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id_persona` int NOT NULL,
  `nro_empleado` int NOT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `nro_empleado` (`nro_empleado`),
  UNIQUE KEY `uq_empleado_persona` (`id_persona`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (22,102),(23,103),(24,104),(25,105),(26,106),(27,107),(28,108),(29,109),(30,110);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `registrar_fecha_salida` BEFORE DELETE ON `empleados` FOR EACH ROW BEGIN
    UPDATE personas
    SET fecha_salida = CURRENT_DATE
    WHERE id_persona = OLD.id_persona;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se encontr├│ el registro en personas para actualizar la fecha de salida.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_inventario`),
  UNIQUE KEY `unique_sucursal_producto` (`id_sucursal`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (11,1,51,82),(12,1,52,150),(13,1,53,200),(14,2,54,80),(15,2,55,50),(16,2,56,120),(17,3,57,90),(18,3,58,70),(19,3,59,140),(20,4,60,30),(21,4,51,202),(22,4,52,300),(23,5,53,120),(24,5,54,180),(25,6,55,100),(26,6,56,220),(27,6,57,110),(28,7,58,40),(29,7,59,70),(30,7,60,60),(31,8,51,92),(32,8,52,130),(33,8,53,160),(34,9,54,70),(35,9,55,50),(36,10,56,40),(37,10,57,60),(38,10,58,20),(39,10,59,30),(40,10,60,100);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jornales`
--

DROP TABLE IF EXISTS `jornales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jornales` (
  `id_jornal` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `id_sucursal` int NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time NOT NULL,
  `hora_salida` time NOT NULL,
  PRIMARY KEY (`id_jornal`),
  KEY `id_persona` (`id_persona`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `jornales_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`),
  CONSTRAINT `jornales_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jornales`
--

LOCK TABLES `jornales` WRITE;
/*!40000 ALTER TABLE `jornales` DISABLE KEYS */;
INSERT INTO `jornales` VALUES (31,21,1,'2023-11-25','08:00:00','16:00:00'),(32,22,2,'2023-11-26','09:00:00','17:00:00'),(33,23,3,'2023-11-27','10:00:00','18:00:00'),(34,24,4,'2023-11-28','11:00:00','19:00:00'),(35,25,5,'2023-11-29','12:00:00','20:00:00'),(36,26,6,'2023-11-30','13:00:00','21:00:00'),(37,27,7,'2023-12-01','14:00:00','22:00:00'),(38,28,8,'2023-12-02','15:00:00','23:00:00'),(39,29,9,'2023-12-03','08:00:00','16:00:00'),(40,30,10,'2023-12-04','09:00:00','17:00:00');
/*!40000 ALTER TABLE `jornales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais_ciudad`
--

DROP TABLE IF EXISTS `pais_ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais_ciudad` (
  `id_pais_ciudad` int NOT NULL AUTO_INCREMENT,
  `id_pais` int NOT NULL,
  `id_ciudad` int NOT NULL,
  PRIMARY KEY (`id_pais_ciudad`),
  UNIQUE KEY `id_pais` (`id_pais`,`id_ciudad`),
  KEY `id_ciudad` (`id_ciudad`),
  CONSTRAINT `pais_ciudad_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`),
  CONSTRAINT `pais_ciudad_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudades` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais_ciudad`
--

LOCK TABLES `pais_ciudad` WRITE;
/*!40000 ALTER TABLE `pais_ciudad` DISABLE KEYS */;
INSERT INTO `pais_ciudad` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `pais_ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paises` (
  `id_pais` int NOT NULL AUTO_INCREMENT,
  `nom_pais` varchar(20) NOT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE KEY `nom_pais` (`nom_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES (2,'Argentina'),(7,'Bolivia'),(3,'Brasil'),(4,'Chile'),(9,'Colombia'),(8,'Ecuador'),(5,'Paraguay'),(6,'Per├║'),(1,'Uruguay'),(10,'Venezuela');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `id_persona` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `id_telefono` int NOT NULL,
  `email` varchar(50) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_salida` date DEFAULT NULL,
  `id_puesto` int NOT NULL,
  `id_pais_ciudad` int NOT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `cedula` (`cedula`),
  UNIQUE KEY `id_telefono` (`id_telefono`),
  UNIQUE KEY `email` (`email`),
  KEY `id_puesto` (`id_puesto`),
  KEY `id_pais_ciudad` (`id_pais_ciudad`),
  CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`id_telefono`) REFERENCES `telefonos` (`id_telefono`),
  CONSTRAINT `personas_ibfk_2` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`id_puesto`),
  CONSTRAINT `personas_ibfk_3` FOREIGN KEY (`id_pais_ciudad`) REFERENCES `pais_ciudad` (`id_pais_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (21,'Juan','P├®rez','12345678',1,'juan.perez@example.com','Calle 1','2023-01-10','2024-11-27',6,1),(22,'Mar├¡a','G├│mez','23456789',2,'maria.gomez@example.com','Calle 2','2023-02-15',NULL,7,2),(23,'Carlos','L├│pez','34567890',3,'carlos.lopez@example.com','Calle 3','2023-03-05',NULL,8,3),(24,'Ana','Mart├¡nez','45678901',4,'ana.martinez@example.com','Calle 4','2023-04-20',NULL,9,4),(25,'Luis','Rodr├¡guez','56789012',5,'luis.rodriguez@example.com','Calle 5','2023-05-25',NULL,1,5),(26,'Laura','S├ínchez','67890123',6,'laura.sanchez@example.com','Calle 6','2023-06-15',NULL,2,6),(27,'Diego','Gonz├ílez','78901234',7,'diego.gonzalez@example.com','Calle 7','2023-07-01',NULL,3,7),(28,'Sof├¡a','Torres','89012345',8,'sofia.torres@example.com','Calle 8','2023-08-10',NULL,4,8),(29,'Miguel','D├¡az','90123456',9,'miguel.diaz@example.com','Calle 9','2023-09-20',NULL,5,9),(30,'Luc├¡a','Fern├índez','01234567',10,'lucia.fernandez@example.com','Calle 10','2023-10-30',NULL,6,10),(31,'Andrea','M├®ndez','12345001',11,'andrea.mendez@example.com','Calle Principal 101','2023-01-01',NULL,9,1),(32,'Pedro','Sosa','12345002',12,'pedro.sosa@example.com','Calle Principal 102','2023-01-02',NULL,6,2),(33,'Clara','Fern├índez','12345003',13,'clara.fernandez@example.com','Calle Principal 103','2023-01-03',NULL,8,3),(34,'Jorge','P├®rez','12345004',14,'jorge.perez@example.com','Calle Principal 104','2023-01-04',NULL,5,4),(35,'Luc├¡a','Su├írez','12345005',15,'lucia.suarez@example.com','Calle Principal 105','2023-01-05',NULL,4,5),(36,'Gonzalo','D├¡az','12345006',16,'gonzalo.diaz@example.com','Calle Principal 106','2023-01-06',NULL,2,6),(37,'Paola','Rojas','12345007',17,'paola.rojas@example.com','Calle Principal 107','2023-01-07',NULL,3,7),(38,'Diego','Mart├¡nez','12345008',18,'diego.martinez@example.com','Calle Principal 108','2023-01-08',NULL,7,8),(39,'Valeria','L├│pez','12345009',19,'valeria.lopez@example.com','Calle Principal 109','2023-01-09',NULL,1,9),(40,'Rodrigo','Garc├¡a','12345010',20,'rodrigo.garcia@example.com','Calle Principal 110','2023-01-10',NULL,9,10);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `coleccion` varchar(30) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_talle` int NOT NULL,
  `id_categoria` int NOT NULL,
  `tipo_producto` enum('accesorio','indumentaria','calzado') NOT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `id_talle` (`id_talle`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_talle`) REFERENCES `talles` (`id_talle`),
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_producto` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (51,'Verano Casual',1200.00,2,1,'indumentaria'),(52,'Running Pro',2200.00,3,2,'calzado'),(53,'Training Fit',1500.00,4,3,'indumentaria'),(54,'Bal├│n Oficial',800.00,3,4,'accesorio'),(55,'Kit Deportivo',1000.00,5,5,'indumentaria'),(56,'Camiseta Running',1300.00,3,2,'indumentaria'),(57,'Zapatillas Urbanas',2500.00,6,1,'calzado'),(58,'Pelota Profesional',2000.00,6,4,'accesorio'),(59,'Pantal├│n Training',1400.00,4,3,'indumentaria'),(60,'Accesorio Deportivo',600.00,7,5,'accesorio'),(61,'Verano Casual',1200.00,2,1,'indumentaria'),(62,'Running Pro',2200.00,3,2,'calzado'),(63,'Training Fit',1500.00,4,3,'indumentaria'),(64,'Bal├│n Oficial',800.00,3,4,'accesorio'),(65,'Kit Deportivo',1000.00,5,5,'indumentaria'),(66,'Camiseta Running',1300.00,3,2,'indumentaria'),(67,'Zapatillas Urbanas',2500.00,6,1,'calzado'),(68,'Pelota Profesional',2000.00,6,4,'accesorio'),(69,'Pantal├│n Training',1400.00,4,3,'indumentaria'),(70,'Accesorio Deportivo',600.00,7,5,'accesorio');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `id_telefono` int NOT NULL,
  `id_pais_ciudad` int NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `id_telefono` (`id_telefono`),
  KEY `id_pais_ciudad` (`id_pais_ciudad`),
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_telefono`) REFERENCES `telefonos` (`id_telefono`),
  CONSTRAINT `proveedores_ibfk_2` FOREIGN KEY (`id_pais_ciudad`) REFERENCES `pais_ciudad` (`id_pais_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (21,'Deportes Pro',21,1),(22,'Accesorios Sport',22,2),(23,'Calzado Top',23,3),(24,'Indumentaria Max',24,4),(25,'Balones Premium',25,5),(26,'Training Gear',26,6),(27,'Sports Wear',27,7),(28,'Quito Sports',28,8),(29,'Bogot├í Fit',29,9),(30,'Caracas Gear',30,10);
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos`
--

DROP TABLE IF EXISTS `puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puestos` (
  `id_puesto` int NOT NULL AUTO_INCREMENT,
  `nom_puesto` varchar(30) NOT NULL,
  PRIMARY KEY (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (1,'Contador'),(2,'Recursos Humanos'),(3,'Gerente'),(4,'Administrador'),(5,'Auditor├¡a'),(6,'Vendedores'),(7,'Jefe'),(8,'Encargados'),(9,'Limpieza');
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salarios`
--

DROP TABLE IF EXISTS `salarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salarios` (
  `id_salario` int NOT NULL AUTO_INCREMENT,
  `id_puesto` int NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_salario`),
  KEY `id_puesto` (`id_puesto`),
  CONSTRAINT `salarios_ibfk_1` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salarios`
--

LOCK TABLES `salarios` WRITE;
/*!40000 ALTER TABLE `salarios` DISABLE KEYS */;
INSERT INTO `salarios` VALUES (1,9,25000.00),(2,6,30150.00),(3,8,40000.00),(4,5,50000.00),(5,4,60000.00),(6,2,70000.00),(7,3,100000.00),(8,7,130000.00),(9,1,110000.00),(10,6,31000.00),(11,6,32000.00),(12,4,61000.00),(13,4,62000.00),(14,2,71000.00);
/*!40000 ALTER TABLE `salarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socios` (
  `id_persona` int NOT NULL,
  `num_socio` int NOT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `num_socio` (`num_socio`),
  UNIQUE KEY `uq_socio_persona` (`id_persona`),
  CONSTRAINT `socios_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (22,201),(24,202),(26,203),(28,204),(30,205),(21,206),(23,207),(25,208),(27,209),(29,210);
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `id_sucursal` int NOT NULL AUTO_INCREMENT,
  `nom_sucursal` varchar(30) NOT NULL,
  PRIMARY KEY (`id_sucursal`),
  UNIQUE KEY `nom_sucursal` (`nom_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (9,'Buceo'),(3,'Carrasco'),(1,'Centro'),(8,'Ciudad Vieja'),(10,'Cord├│n'),(6,'Malv├¡n'),(2,'Pocitos'),(7,'Prado'),(5,'Punta Carretas'),(4,'Tres Cruces');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talles`
--

DROP TABLE IF EXISTS `talles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `talles` (
  `id_talle` int NOT NULL AUTO_INCREMENT,
  `talle` varchar(30) NOT NULL,
  PRIMARY KEY (`id_talle`),
  UNIQUE KEY `talle` (`talle`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talles`
--

LOCK TABLES `talles` WRITE;
/*!40000 ALTER TABLE `talles` DISABLE KEYS */;
INSERT INTO `talles` VALUES (4,'L'),(3,'M'),(2,'S'),(5,'XL'),(1,'XS'),(6,'XXL'),(7,'XXXL');
/*!40000 ALTER TABLE `talles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefonos`
--

DROP TABLE IF EXISTS `telefonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefonos` (
  `id_telefono` int NOT NULL AUTO_INCREMENT,
  `num_telefono` varchar(10) NOT NULL,
  PRIMARY KEY (`id_telefono`),
  UNIQUE KEY `num_telefono` (`num_telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefonos`
--

LOCK TABLES `telefonos` WRITE;
/*!40000 ALTER TABLE `telefonos` DISABLE KEYS */;
INSERT INTO `telefonos` VALUES (9,'091012345'),(10,'091123456'),(1,'091234567'),(2,'091345678'),(3,'091456789'),(4,'091567890'),(5,'091678901'),(6,'091789012'),(7,'091890123'),(8,'091901234'),(19,'092012345'),(20,'092123456'),(11,'092234567'),(12,'092345678'),(13,'092456789'),(14,'092567890'),(15,'092678901'),(16,'092789012'),(17,'092890123'),(18,'092901234'),(29,'093012345'),(30,'093123456'),(21,'093234567'),(22,'093345678'),(23,'093456789'),(24,'093567890'),(25,'093678901'),(26,'093789012'),(27,'093890123'),(28,'093901234');
/*!40000 ALTER TABLE `telefonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha_venta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `num_socio` int DEFAULT NULL,
  `nro_empleado` int NOT NULL,
  `id_sucursal` int NOT NULL,
  `num_venta` int NOT NULL,
  PRIMARY KEY (`id_venta`),
  UNIQUE KEY `num_venta` (`num_venta`),
  KEY `id_sucursal` (`id_sucursal`),
  KEY `fk_ventas_num_socio` (`num_socio`),
  KEY `ventas_ibfk_2` (`nro_empleado`),
  CONSTRAINT `fk_ventas_num_socio` FOREIGN KEY (`num_socio`) REFERENCES `socios` (`num_socio`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`num_socio`) REFERENCES `socios` (`num_socio`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`nro_empleado`) REFERENCES `empleados` (`nro_empleado`) ON DELETE CASCADE,
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (11,'2023-11-20 13:00:00',201,101,1,1001),(12,'2023-11-21 14:00:00',202,102,2,1002),(13,'2023-11-22 15:00:00',203,103,3,1003),(14,'2023-11-23 16:00:00',204,104,4,1004),(15,'2023-11-24 17:00:00',205,105,5,1005),(16,'2023-11-25 18:00:00',206,106,6,1006),(17,'2023-11-26 19:00:00',207,107,7,1007),(18,'2023-11-27 20:00:00',208,108,8,1008),(19,'2023-11-28 21:00:00',209,109,9,1009),(20,'2023-11-29 22:00:00',210,110,10,1010),(25,'2024-01-01 13:00:00',201,101,1,1012);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_detalle_ventas_productos`
--

DROP TABLE IF EXISTS `vw_detalle_ventas_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_detalle_ventas_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_detalle_ventas_productos` AS SELECT 
 1 AS `id_venta`,
 1 AS `numero_venta`,
 1 AS `producto`,
 1 AS `categoria`,
 1 AS `cantidad`,
 1 AS `precio_unitario`,
 1 AS `precio_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_empleados_salarios`
--

DROP TABLE IF EXISTS `vw_empleados_salarios`;
/*!50001 DROP VIEW IF EXISTS `vw_empleados_salarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empleados_salarios` AS SELECT 
 1 AS `empleado_id`,
 1 AS `nombre_empleado`,
 1 AS `puesto`,
 1 AS `salario`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inventario_sucursal`
--

DROP TABLE IF EXISTS `vw_inventario_sucursal`;
/*!50001 DROP VIEW IF EXISTS `vw_inventario_sucursal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inventario_sucursal` AS SELECT 
 1 AS `id_inventario`,
 1 AS `nom_sucursal`,
 1 AS `producto`,
 1 AS `categoria`,
 1 AS `talle`,
 1 AS `cantidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_detalle`
--

DROP TABLE IF EXISTS `vw_productos_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_detalle` AS SELECT 
 1 AS `id_producto`,
 1 AS `coleccion_producto`,
 1 AS `precio`,
 1 AS `categoria`,
 1 AS `talle`,
 1 AS `tipo_producto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_proveedores_resumen`
--

DROP TABLE IF EXISTS `vw_proveedores_resumen`;
/*!50001 DROP VIEW IF EXISTS `vw_proveedores_resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_proveedores_resumen` AS SELECT 
 1 AS `proveedor`,
 1 AS `telefono`,
 1 AS `ciudad`,
 1 AS `pais`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_ventas_detalle`
--

DROP TABLE IF EXISTS `vw_ventas_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_ventas_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_ventas_detalle` AS SELECT 
 1 AS `id_venta`,
 1 AS `fecha_venta`,
 1 AS `num_socio`,
 1 AS `socio`,
 1 AS `nro_empleado`,
 1 AS `empleado`,
 1 AS `sucursal`,
 1 AS `num_venta`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `proyecto_coder`
--

USE `proyecto_coder`;

--
-- Final view structure for view `vw_detalle_ventas_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_detalle_ventas_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_detalle_ventas_productos` AS select `dv`.`id_venta` AS `id_venta`,`v`.`num_venta` AS `numero_venta`,`p`.`coleccion` AS `producto`,`c`.`nombre` AS `categoria`,`dv`.`cantidad` AS `cantidad`,`dv`.`prc_unitario` AS `precio_unitario`,`dv`.`total` AS `precio_total` from (((`detalle_ventas` `dv` join `ventas` `v` on((`dv`.`id_venta` = `v`.`id_venta`))) join `productos` `p` on((`dv`.`id_producto` = `p`.`id_producto`))) join `categoria_producto` `c` on((`p`.`id_categoria` = `c`.`id_categoria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_empleados_salarios`
--

/*!50001 DROP VIEW IF EXISTS `vw_empleados_salarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empleados_salarios` AS select `e`.`id_persona` AS `empleado_id`,concat(`p`.`nombre`,' ',`p`.`apellido`) AS `nombre_empleado`,`pu`.`nom_puesto` AS `puesto`,`s`.`salario` AS `salario` from (((`empleados` `e` join `personas` `p` on((`e`.`id_persona` = `p`.`id_persona`))) join `puestos` `pu` on((`p`.`id_puesto` = `pu`.`id_puesto`))) join `salarios` `s` on((`pu`.`id_puesto` = `s`.`id_puesto`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inventario_sucursal`
--

/*!50001 DROP VIEW IF EXISTS `vw_inventario_sucursal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inventario_sucursal` AS select `i`.`id_inventario` AS `id_inventario`,`s`.`nom_sucursal` AS `nom_sucursal`,`p`.`coleccion` AS `producto`,`c`.`nombre` AS `categoria`,`t`.`talle` AS `talle`,`i`.`cantidad` AS `cantidad` from ((((`inventario` `i` join `sucursales` `s` on((`i`.`id_sucursal` = `s`.`id_sucursal`))) join `productos` `p` on((`i`.`id_producto` = `p`.`id_producto`))) join `categoria_producto` `c` on((`p`.`id_categoria` = `c`.`id_categoria`))) join `talles` `t` on((`p`.`id_talle` = `t`.`id_talle`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_detalle` AS select `p`.`id_producto` AS `id_producto`,`p`.`coleccion` AS `coleccion_producto`,`p`.`precio` AS `precio`,`c`.`nombre` AS `categoria`,`t`.`talle` AS `talle`,`p`.`tipo_producto` AS `tipo_producto` from ((`productos` `p` join `categoria_producto` `c` on((`p`.`id_categoria` = `c`.`id_categoria`))) join `talles` `t` on((`p`.`id_talle` = `t`.`id_talle`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_proveedores_resumen`
--

/*!50001 DROP VIEW IF EXISTS `vw_proveedores_resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_proveedores_resumen` AS select `pr`.`nombre` AS `proveedor`,`t`.`num_telefono` AS `telefono`,`c`.`nom_ciudad` AS `ciudad`,`p`.`nom_pais` AS `pais` from ((((`proveedores` `pr` join `telefonos` `t` on((`pr`.`id_telefono` = `t`.`id_telefono`))) join `pais_ciudad` `pc` on((`pr`.`id_pais_ciudad` = `pc`.`id_pais_ciudad`))) join `ciudades` `c` on((`pc`.`id_ciudad` = `c`.`id_ciudad`))) join `paises` `p` on((`pc`.`id_pais` = `p`.`id_pais`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_ventas_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_ventas_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ventas_detalle` AS select `v`.`id_venta` AS `id_venta`,`v`.`fecha_venta` AS `fecha_venta`,`v`.`num_socio` AS `num_socio`,concat(`ps`.`nombre`,' ',`ps`.`apellido`) AS `socio`,`v`.`nro_empleado` AS `nro_empleado`,concat(`pe`.`nombre`,' ',`pe`.`apellido`) AS `empleado`,`suc`.`nom_sucursal` AS `sucursal`,`v`.`num_venta` AS `num_venta` from (((((`ventas` `v` left join `socios` `so` on((`v`.`num_socio` = `so`.`num_socio`))) left join `personas` `ps` on((`so`.`id_persona` = `ps`.`id_persona`))) left join `empleados` `e` on((`v`.`nro_empleado` = `e`.`nro_empleado`))) left join `personas` `pe` on((`e`.`id_persona` = `pe`.`id_persona`))) left join `sucursales` `suc` on((`v`.`id_sucursal` = `suc`.`id_sucursal`))) */;
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

-- Dump completed on 2024-12-26 17:02:57
