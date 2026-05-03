/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sofit_gym
-- ------------------------------------------------------
-- Server version	11.4.10-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `analisis_energetico`
--

DROP TABLE IF EXISTS `analisis_energetico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `analisis_energetico` (
  `id_analisis` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date NOT NULL,
  `calorias_consumidas` int(11) DEFAULT NULL,
  `calorias_gastadas_estimadas` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `recomendacion` text DEFAULT NULL,
  PRIMARY KEY (`id_analisis`),
  KEY `fk_analisis_cliente` (`cedula_cliente`),
  CONSTRAINT `fk_analisis_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analisis_energetico`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `analisis_energetico` WRITE;
/*!40000 ALTER TABLE `analisis_energetico` DISABLE KEYS */;
/*!40000 ALTER TABLE `analisis_energetico` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `asistencia_clase`
--

DROP TABLE IF EXISTS `asistencia_clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_clase` (
  `id_asistencia` int(11) NOT NULL AUTO_INCREMENT,
  `id_clase` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `asistio` tinyint(1) DEFAULT 1,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_asistencia`),
  KEY `fk_asistencia_clase_clase` (`id_clase`),
  KEY `fk_asistencia_clase_cliente` (`cedula_cliente`),
  CONSTRAINT `fk_asistencia_clase_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE CASCADE,
  CONSTRAINT `fk_asistencia_clase_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_clase`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `asistencia_clase` WRITE;
/*!40000 ALTER TABLE `asistencia_clase` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencia_clase` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `asistencia_gimnasio`
--

DROP TABLE IF EXISTS `asistencia_gimnasio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia_gimnasio` (
  `id_asistencia` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` datetime NOT NULL,
  `tipo` enum('Entrada','Salida') NOT NULL,
  PRIMARY KEY (`id_asistencia`),
  KEY `fk_asistencia_cliente` (`cedula_cliente`),
  KEY `idx_asistencias_fecha` (`fecha`),
  CONSTRAINT `fk_asistencia_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia_gimnasio`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `asistencia_gimnasio` WRITE;
/*!40000 ALTER TABLE `asistencia_gimnasio` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencia_gimnasio` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `clase`
--

DROP TABLE IF EXISTS `clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clase` (
  `id_clase` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_trabajador` varchar(15) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `cupos_ocupados` int(11) DEFAULT 0,
  `capacidad_maxima` int(11) NOT NULL,
  `estado` enum('Programado','En curso','Finalizado','Cancelado') DEFAULT 'Programado',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  PRIMARY KEY (`id_clase`),
  KEY `fk_clase_instructor` (`cedula_trabajador`),
  CONSTRAINT `fk_clase_instructor` FOREIGN KEY (`cedula_trabajador`) REFERENCES `trabajador` (`cedula_trabajador`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clase`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `clase` WRITE;
/*!40000 ALTER TABLE `clase` DISABLE KEYS */;
INSERT INTO `clase` VALUES
(1,'T-00000002','Yoga',NULL,0,20,'Programado','2026-04-26 10:00:00','2026-04-26 11:00:00');
/*!40000 ALTER TABLE `clase` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cedula_cliente` varchar(15) NOT NULL,
  `id_membresia` int(11) NOT NULL,
  PRIMARY KEY (`cedula_cliente`),
  KEY `cliente_membresia_FK` (`id_membresia`),
  CONSTRAINT `cliente_membresia_FK` FOREIGN KEY (`id_membresia`) REFERENCES `membresia` (`id_membresia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_persona_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES
('V-11111111',0),
('V-22222222',0),
('32632',17),
('323532',18),
('52523',19);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `consulta_asistente`
--

DROP TABLE IF EXISTS `consulta_asistente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta_asistente` (
  `id_consulta` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `cedula_cliente` varchar(15) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `tipo` text DEFAULT NULL,
  `pregunta` text DEFAULT NULL,
  `respuesta` text DEFAULT NULL,
  PRIMARY KEY (`id_consulta`),
  KEY `idx_consultas_fecha` (`fecha`),
  KEY `consulta_asistente_usuario_FK` (`id_usuario`),
  CONSTRAINT `consulta_asistente_usuario_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta_asistente`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `consulta_asistente` WRITE;
/*!40000 ALTER TABLE `consulta_asistente` DISABLE KEYS */;
INSERT INTO `consulta_asistente` VALUES
(1,1,NULL,'2026-04-26 02:55:55',NULL,'¿Qué ajustes de rutina recomiendas?','Aumentar series de sentadilla a 5.');
/*!40000 ALTER TABLE `consulta_asistente` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ejercicio`
--

DROP TABLE IF EXISTS `ejercicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejercicio` (
  `id_ejercicio` int(11) NOT NULL AUTO_INCREMENT,
  `id_dificultad` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `grupo_muscular` varchar(100) DEFAULT NULL,
  `equipo_requerido` text DEFAULT NULL,
  PRIMARY KEY (`id_ejercicio`),
  KEY `ejercicio_tipo_dificultad_FK` (`id_dificultad`),
  CONSTRAINT `ejercicio_tipo_dificultad_FK` FOREIGN KEY (`id_dificultad`) REFERENCES `tipo_dificultad` (`id_dificultad`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejercicio`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ejercicio` WRITE;
/*!40000 ALTER TABLE `ejercicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `ejercicio` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `codigo_equipo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `estado` enum('Operativo','Mantenimiento','Fuera de Servicio') DEFAULT 'Operativo',
  `ubicacion` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`codigo_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES
('EQ-001','Cinta de correr','Cardio','Operativo',NULL,1);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `estado_membresia`
--

DROP TABLE IF EXISTS `estado_membresia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_membresia` (
  `id_estado` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_membresia`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `estado_membresia` WRITE;
/*!40000 ALTER TABLE `estado_membresia` DISABLE KEYS */;
INSERT INTO `estado_membresia` VALUES
(1,'Activo'),
(2,'Vencido'),
(3,'Moroso');
/*!40000 ALTER TABLE `estado_membresia` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `horario_trabajador`
--

DROP TABLE IF EXISTS `horario_trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario_trabajador` (
  `id_horario` int(11) NOT NULL,
  `cedula_trabajador` varchar(15) NOT NULL,
  `dia_semana` varchar(15) DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  PRIMARY KEY (`id_horario`),
  KEY `horario_trabajador_trabajador_FK` (`cedula_trabajador`),
  CONSTRAINT `horario_trabajador_trabajador_FK` FOREIGN KEY (`cedula_trabajador`) REFERENCES `trabajador` (`cedula_trabajador`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario_trabajador`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `horario_trabajador` WRITE;
/*!40000 ALTER TABLE `horario_trabajador` DISABLE KEYS */;
/*!40000 ALTER TABLE `horario_trabajador` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `inscripcion_clase`
--

DROP TABLE IF EXISTS `inscripcion_clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripcion_clase` (
  `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT,
  `id_clase` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `estado` enum('Activo','Cancelado') DEFAULT 'Activo',
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_inscripcion`),
  UNIQUE KEY `uk_cliente_clase` (`cedula_cliente`,`id_clase`),
  KEY `fk_inscripcion_clase` (`id_clase`),
  CONSTRAINT `fk_inscripcion_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE CASCADE,
  CONSTRAINT `fk_inscripcion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripcion_clase`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `inscripcion_clase` WRITE;
/*!40000 ALTER TABLE `inscripcion_clase` DISABLE KEYS */;
INSERT INTO `inscripcion_clase` VALUES
(1,1,'V-11111111','Activo','2026-04-26 20:03:02');
/*!40000 ALTER TABLE `inscripcion_clase` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mantenimiento_equipo`
--

DROP TABLE IF EXISTS `mantenimiento_equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mantenimiento_equipo` (
  `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_equipo` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` enum('Preventivo','Correctivo') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `tecnico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_mantenimiento`),
  KEY `fk_mantenimiento_equipo` (`codigo_equipo`),
  CONSTRAINT `fk_mantenimiento_equipo` FOREIGN KEY (`codigo_equipo`) REFERENCES `equipo` (`codigo_equipo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mantenimiento_equipo`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mantenimiento_equipo` WRITE;
/*!40000 ALTER TABLE `mantenimiento_equipo` DISABLE KEYS */;
INSERT INTO `mantenimiento_equipo` VALUES
(1,'EQ-001','2026-03-15','Preventivo','Lubricación y calibración',NULL,NULL);
/*!40000 ALTER TABLE `mantenimiento_equipo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `membresia`
--

DROP TABLE IF EXISTS `membresia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresia` (
  `id_membresia` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL DEFAULT 3,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_membresia`),
  KEY `fk_membresia_tipo` (`id_tipo`),
  KEY `membresia_estado_membresia_FK` (`id_estado`),
  CONSTRAINT `fk_membresia_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_membresia` (`id_tipo`) ON UPDATE CASCADE,
  CONSTRAINT `membresia_estado_membresia_FK` FOREIGN KEY (`id_estado`) REFERENCES `estado_membresia` (`id_estado`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci COMMENT='Deberia tener:\n- Activo\n- Vencido\n- Moroso';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresia`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `membresia` WRITE;
/*!40000 ALTER TABLE `membresia` DISABLE KEYS */;
INSERT INTO `membresia` VALUES
(0,1,1,'2026-04-06','2026-04-07'),
(13,1,1,NULL,NULL),
(14,1,1,NULL,NULL),
(15,1,1,'2026-05-21','2026-05-27'),
(16,1,1,'2026-05-20','2026-05-31'),
(17,1,1,'2026-05-18','2026-05-30'),
(18,1,1,'2026-05-14','2026-05-27'),
(19,1,1,'2026-05-11','2026-05-30');
/*!40000 ALTER TABLE `membresia` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_notificacion` int(11) NOT NULL,
  `id_tipo_canal` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `mensaje` text NOT NULL,
  `estado` enum('Pendiente','Enviado','Fallido') DEFAULT 'Pendiente',
  `fecha_programada` datetime DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `fk_notificacion_cliente` (`cedula_cliente`),
  KEY `idx_notificaciones_pendientes` (`fecha_programada`,`estado`),
  KEY `notificacion_tipo_notificacion_FK` (`id_tipo_notificacion`),
  KEY `notificacion_tipo_canal_FK` (`id_tipo_canal`),
  CONSTRAINT `fk_notificacion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificacion_tipo_canal_FK` FOREIGN KEY (`id_tipo_canal`) REFERENCES `tipo_canal` (`id_tipo`) ON UPDATE CASCADE,
  CONSTRAINT `notificacion_tipo_notificacion_FK` FOREIGN KEY (`id_tipo_notificacion`) REFERENCES `tipo_notificacion` (`id_tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `comprobante_url` varchar(255) DEFAULT NULL,
  `estado` enum('Pagado','Pendiente','Atrasado') DEFAULT 'Pagado',
  `fecha_pago` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `fk_pago_cliente` (`cedula_cliente`),
  KEY `idx_pagos_cliente_estado` (`cedula_cliente`,`estado`),
  CONSTRAINT `fk_pago_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pago`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pago` WRITE;
/*!40000 ALTER TABLE `pago` DISABLE KEYS */;
INSERT INTO `pago` VALUES
(1,'V-11111111',30.00,'Efectivo',NULL,'Pagado','2026-04-01','2026-04-30');
/*!40000 ALTER TABLE `pago` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `cedula_persona` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` int(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cedula_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES
('323532','asfas','asg','hola@gmail.com',363,'asaa','2026-05-06','2026-05-03 00:00:00',1),
('32632','aasga','sga','hola@gmail.com',23623,'asfas','2026-05-11','2026-05-03 19:38:57',1),
('52523','afs','asfa','hola@gmail.com',3252363,'asfas','2026-05-07','2026-05-03 00:00:00',1),
('T-00000001','sag','AFa',NULL,NULL,NULL,NULL,'2026-04-26 16:46:02',0),
('T-00000002','asga','asgas','',NULL,NULL,NULL,'2026-04-26 16:46:02',0),
('V-11111111','AD','F','hola@gmail.com',412532584,NULL,NULL,'2026-04-26 16:45:34',1),
('V-22222222','A','D',NULL,NULL,NULL,NULL,'2026-04-26 16:45:34',0);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `codigo_producto` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock_minimo` int(11) DEFAULT 0,
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `unidad_medida` varchar(20) DEFAULT 'unidad',
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`codigo_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES
('PROT001','Proteína Whey',NULL,45.00,0,15,'unidad',1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `rutina`
--

DROP TABLE IF EXISTS `rutina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutina` (
  `id_rutina` int(11) NOT NULL AUTO_INCREMENT,
  `id_dificultad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `objetivo` text DEFAULT NULL,
  `duracion_semanas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_rutina`),
  KEY `rutina_tipo_rutina_FK` (`id_dificultad`),
  CONSTRAINT `rutina_tipo_rutina_FK` FOREIGN KEY (`id_dificultad`) REFERENCES `tipo_dificultad` (`id_dificultad`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutina`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `rutina` WRITE;
/*!40000 ALTER TABLE `rutina` DISABLE KEYS */;
INSERT INTO `rutina` VALUES
(1,1,'Fuerza Básica','Full body',NULL,NULL);
/*!40000 ALTER TABLE `rutina` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `rutina_asignada`
--

DROP TABLE IF EXISTS `rutina_asignada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutina_asignada` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `id_rutina` int(11) NOT NULL,
  `fecha_asignacion` date NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('Activa','Completada','Cancelada') DEFAULT 'Activa',
  `progreso` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`id_asignacion`),
  KEY `fk_asignacion_cliente` (`cedula_cliente`),
  KEY `fk_asignacion_rutina` (`id_rutina`),
  CONSTRAINT `fk_asignacion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_asignacion_rutina` FOREIGN KEY (`id_rutina`) REFERENCES `rutina` (`id_rutina`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutina_asignada`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `rutina_asignada` WRITE;
/*!40000 ALTER TABLE `rutina_asignada` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutina_asignada` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `seguimiento_fisico`
--

DROP TABLE IF EXISTS `seguimiento_fisico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguimiento_fisico` (
  `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date DEFAULT NULL,
  `altura_cm` decimal(5,2) DEFAULT NULL,
  `peso_kg` decimal(5,2) DEFAULT NULL,
  `cintura_cm` decimal(5,2) DEFAULT NULL,
  `cadera_cm` decimal(5,2) DEFAULT NULL,
  `pecho_cm` decimal(5,2) DEFAULT NULL,
  `muslo_cm` decimal(5,2) DEFAULT NULL,
  `hombros_cm` decimal(5,2) DEFAULT NULL,
  `pantorrilla_cm` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_seguimiento`),
  KEY `seguimiento_fisico_cliente_FK` (`cedula_cliente`),
  CONSTRAINT `seguimiento_fisico_cliente_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimiento_fisico`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `seguimiento_fisico` WRITE;
/*!40000 ALTER TABLE `seguimiento_fisico` DISABLE KEYS */;
/*!40000 ALTER TABLE `seguimiento_fisico` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `seguimiento_nutricional`
--

DROP TABLE IF EXISTS `seguimiento_nutricional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguimiento_nutricional` (
  `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date DEFAULT NULL,
  `proteinas_g` decimal(5,2) DEFAULT NULL,
  `carbohidratos_g` decimal(5,2) DEFAULT NULL,
  `grasas_g` decimal(5,2) DEFAULT NULL,
  `calorias_diarias` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_seguimiento`),
  KEY `plan_nutricional_cliente_FK` (`cedula_cliente`),
  CONSTRAINT `plan_nutricional_cliente_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimiento_nutricional`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `seguimiento_nutricional` WRITE;
/*!40000 ALTER TABLE `seguimiento_nutricional` DISABLE KEYS */;
/*!40000 ALTER TABLE `seguimiento_nutricional` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tipo_canal`
--

DROP TABLE IF EXISTS `tipo_canal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_canal` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_canal`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tipo_canal` WRITE;
/*!40000 ALTER TABLE `tipo_canal` DISABLE KEYS */;
INSERT INTO `tipo_canal` VALUES
(1,'App'),
(2,'Email'),
(3,'WhatsApp');
/*!40000 ALTER TABLE `tipo_canal` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tipo_dificultad`
--

DROP TABLE IF EXISTS `tipo_dificultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_dificultad` (
  `id_dificultad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_dificultad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_dificultad`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tipo_dificultad` WRITE;
/*!40000 ALTER TABLE `tipo_dificultad` DISABLE KEYS */;
INSERT INTO `tipo_dificultad` VALUES
(1,'Principiante'),
(2,'Intermedio'),
(3,'Avanzado');
/*!40000 ALTER TABLE `tipo_dificultad` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tipo_membresia`
--

DROP TABLE IF EXISTS `tipo_membresia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_membresia` (
  `id_tipo` int(11) NOT NULL COMMENT '1 = Mensual\n2 = Trimestral\n3 = Anual',
  `nombre` varchar(100) NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_membresia`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tipo_membresia` WRITE;
/*!40000 ALTER TABLE `tipo_membresia` DISABLE KEYS */;
INSERT INTO `tipo_membresia` VALUES
(1,'Mensual',0),
(2,'Trimuestral',0),
(3,'Anual',0);
/*!40000 ALTER TABLE `tipo_membresia` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tipo_notificacion`
--

DROP TABLE IF EXISTS `tipo_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_notificacion` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_notificacion`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tipo_notificacion` WRITE;
/*!40000 ALTER TABLE `tipo_notificacion` DISABLE KEYS */;
INSERT INTO `tipo_notificacion` VALUES
(1,'Pago de vencimiento'),
(2,'Recordatorio de clase'),
(3,'Promoción'),
(4,'Otro');
/*!40000 ALTER TABLE `tipo_notificacion` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `tipo_rol`
--

DROP TABLE IF EXISTS `tipo_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_rol` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_rol`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `tipo_rol` WRITE;
/*!40000 ALTER TABLE `tipo_rol` DISABLE KEYS */;
INSERT INTO `tipo_rol` VALUES
(1,'Gerente'),
(2,'Entrenador'),
(3,'Recepcionista'),
(4,'Cliente');
/*!40000 ALTER TABLE `tipo_rol` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `trabajador`
--

DROP TABLE IF EXISTS `trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trabajador` (
  `cedula_trabajador` varchar(15) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  PRIMARY KEY (`cedula_trabajador`),
  KEY `trabajador_tipo_rol_FK` (`id_rol`),
  CONSTRAINT `trabajador_persona_FK` FOREIGN KEY (`cedula_trabajador`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trabajador_tipo_rol_FK` FOREIGN KEY (`id_rol`) REFERENCES `tipo_rol` (`id_rol`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajador`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `trabajador` WRITE;
/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` VALUES
('T-00000001',1,NULL,NULL),
('T-00000002',2,NULL,NULL);
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `cedula_persona` varchar(15) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `ultimo_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `usuario_persona_FK` (`cedula_persona`),
  KEY `usuario_tipo_rol_FK` (`id_rol`),
  CONSTRAINT `usuario_persona_FK` FOREIGN KEY (`cedula_persona`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_tipo_rol_FK` FOREIGN KEY (`id_rol`) REFERENCES `tipo_rol` (`id_rol`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,2,'T-00000001','carlos.perez','admin123',NULL),
(2,2,'T-00000002','ana.gomez','ana123',NULL),
(3,4,'V-11111111','luis.martinez','cliente123',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `venta_producto`
--

DROP TABLE IF EXISTS `venta_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_producto` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_producto` varchar(20) NOT NULL,
  `cedula_cliente` varchar(15) DEFAULT NULL,
  `cantidad_vendida` decimal(10,2) DEFAULT NULL,
  `monto_total` varchar(100) DEFAULT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_venta`),
  KEY `fk_venta_cliente` (`cedula_cliente`),
  KEY `idx_ventas_fecha` (`fecha`),
  KEY `venta_producto_producto_FK` (`codigo_producto`),
  CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `venta_producto_producto_FK` FOREIGN KEY (`codigo_producto`) REFERENCES `producto` (`codigo_producto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_producto`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `venta_producto` WRITE;
/*!40000 ALTER TABLE `venta_producto` DISABLE KEYS */;
INSERT INTO `venta_producto` VALUES
(1,'PROT001','V-11111111',45.00,NULL,'Efectivo','2026-04-26 02:55:55');
/*!40000 ALTER TABLE `venta_producto` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Temporary table structure for view `vista_cliente`
--

DROP TABLE IF EXISTS `vista_cliente`;
/*!50001 DROP VIEW IF EXISTS `vista_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_cliente` AS SELECT
 1 AS `cedula_persona`,
  1 AS `nombre`,
  1 AS `apellido`,
  1 AS `correo`,
  1 AS `telefono`,
  1 AS `direccion`,
  1 AS `fecha_nacimiento`,
  1 AS `fecha_registro`,
  1 AS `nombre_tipo_membresia`,
  1 AS `nombre_estado_membresia`,
  1 AS `fecha_inicio`,
  1 AS `fecha_fin` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_demanda_productos`
--

DROP TABLE IF EXISTS `vista_demanda_productos`;
/*!50001 DROP VIEW IF EXISTS `vista_demanda_productos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_demanda_productos` AS SELECT
 1 AS `codigo`,
  1 AS `nombre`,
  1 AS `unidades_vendidas`,
  1 AS `ingresos_totales` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_deudores`
--

DROP TABLE IF EXISTS `vista_deudores`;
/*!50001 DROP VIEW IF EXISTS `vista_deudores`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_deudores` AS SELECT
 1 AS `cedula`,
  1 AS `nombre`,
  1 AS `apellido`,
  1 AS `correo`,
  1 AS `monto_deuda`,
  1 AS `fecha_vencimiento`,
  1 AS `dias_mora` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_ingresos_mensuales`
--

DROP TABLE IF EXISTS `vista_ingresos_mensuales`;
/*!50001 DROP VIEW IF EXISTS `vista_ingresos_mensuales`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_ingresos_mensuales` AS SELECT
 1 AS `mes`,
  1 AS `total_ingresos`,
  1 AS `cantidad_transacciones` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vista_ocupacion`
--

DROP TABLE IF EXISTS `vista_ocupacion`;
/*!50001 DROP VIEW IF EXISTS `vista_ocupacion`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_ocupacion` AS SELECT
 1 AS `fecha`,
  1 AS `hora`,
  1 AS `clientes_unicos`,
  1 AS `total_accesos` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'sofit_gym'
--

--
-- Final view structure for view `vista_cliente`
--

/*!50001 DROP VIEW IF EXISTS `vista_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_cliente` AS select `p`.`cedula_persona` AS `cedula_persona`,`p`.`nombre` AS `nombre`,`p`.`apellido` AS `apellido`,`p`.`correo` AS `correo`,`p`.`telefono` AS `telefono`,`p`.`direccion` AS `direccion`,`p`.`fecha_nacimiento` AS `fecha_nacimiento`,`p`.`fecha_registro` AS `fecha_registro`,`tm`.`nombre` AS `nombre_tipo_membresia`,`em`.`nombre` AS `nombre_estado_membresia`,`m`.`fecha_inicio` AS `fecha_inicio`,`m`.`fecha_fin` AS `fecha_fin` from ((((`persona` `p` left join `cliente` `c` on(`p`.`cedula_persona` = `c`.`cedula_cliente`)) left join `membresia` `m` on(`c`.`id_membresia` = `m`.`id_membresia`)) left join `tipo_membresia` `tm` on(`m`.`id_tipo` = `tm`.`id_tipo`)) left join `estado_membresia` `em` on(`m`.`id_estado` = `em`.`id_estado`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_demanda_productos`
--

/*!50001 DROP VIEW IF EXISTS `vista_demanda_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_demanda_productos` AS select `p`.`codigo_producto` AS `codigo`,`p`.`nombre` AS `nombre`,sum(`v`.`cantidad_vendida`) AS `unidades_vendidas`,sum(`v`.`monto_total`) AS `ingresos_totales` from (`producto` `p` join `venta_producto` `v` on(`p`.`codigo_producto` = `v`.`codigo_producto`)) group by `p`.`codigo_producto`,`p`.`nombre` order by sum(`v`.`cantidad_vendida`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_deudores`
--

/*!50001 DROP VIEW IF EXISTS `vista_deudores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_deudores` AS select `c`.`cedula_cliente` AS `cedula`,`per`.`nombre` AS `nombre`,`per`.`apellido` AS `apellido`,`per`.`correo` AS `correo`,`pa`.`monto` AS `monto_deuda`,`pa`.`fecha_vencimiento` AS `fecha_vencimiento`,to_days(curdate()) - to_days(`pa`.`fecha_vencimiento`) AS `dias_mora` from ((`pago` `pa` left join `cliente` `c` on(`pa`.`cedula_cliente` = `c`.`cedula_cliente`)) left join `persona` `per` on(`c`.`cedula_cliente` = `per`.`cedula_persona`)) where `pa`.`estado` in ('Pendiente','Atrasado') and `pa`.`fecha_vencimiento` < curdate() order by to_days(curdate()) - to_days(`pa`.`fecha_vencimiento`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ingresos_mensuales`
--

/*!50001 DROP VIEW IF EXISTS `vista_ingresos_mensuales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ingresos_mensuales` AS select date_format(`p`.`fecha_pago`,'%Y-%m') AS `mes`,sum(`p`.`monto`) AS `total_ingresos`,count(`p`.`id_pago`) AS `cantidad_transacciones` from `pago` `p` where `p`.`estado` = 'Pagado' group by date_format(`p`.`fecha_pago`,'%Y-%m') order by date_format(`p`.`fecha_pago`,'%Y-%m') desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ocupacion`
--

/*!50001 DROP VIEW IF EXISTS `vista_ocupacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ocupacion` AS select cast(`a`.`fecha` as date) AS `fecha`,hour(`a`.`fecha`) AS `hora`,count(distinct `a`.`cedula_cliente`) AS `clientes_unicos`,count(0) AS `total_accesos` from `asistencia_gimnasio` `a` where `a`.`tipo` = 'Entrada' group by `a`.`fecha`,hour(`a`.`fecha`) order by cast(`a`.`fecha` as date) desc,hour(`a`.`fecha`) */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-03 17:32:19
