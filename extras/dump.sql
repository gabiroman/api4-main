-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.16-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para turnerodb
CREATE DATABASE IF NOT EXISTS `turnerodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `turnerodb`;

-- Volcando estructura para tabla turnerodb.pacientes
CREATE TABLE IF NOT EXISTS `pacientes` (
  `dni` int(8) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  KEY `DNI` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla turnerodb.pacientes: ~4 rows (aproximadamente)
DELETE FROM `pacientes`;
INSERT INTO `pacientes` (`dni`, `apellidos`, `nombres`) VALUES
	(11111111, 'Diaz', 'Bruno'),
	(11111112, 'Moreno', 'Mariano'),
	(11111113, 'Azurduy', 'Juana'),
	(11222333, 'Gimenez', 'Susana');

-- Volcando estructura para tabla turnerodb.turnos
CREATE TABLE IF NOT EXISTS `turnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  UNIQUE KEY `fecha_inicio` (`fecha_inicio`),
  UNIQUE KEY `fecha_fin` (`fecha_fin`),
  KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla turnerodb.turnos: ~6 rows (aproximadamente)
DELETE FROM `turnos`;
INSERT INTO `turnos` (`id`, `fecha_inicio`, `fecha_fin`) VALUES
	(1, '2022-11-08 10:00:00', '2022-11-08 10:15:00'),
	(2, '2022-11-08 10:15:00', '2022-11-08 11:00:00'),
	(3, '2022-11-08 14:00:00', '2022-11-08 14:30:00'),
	(5, '2022-11-08 14:30:00', '2022-11-08 15:00:00'),
	(6, '2022-11-09 11:00:00', '2022-11-09 11:30:00'),
	(7, '2022-11-09 15:00:00', '2022-11-09 15:30:00');

-- Volcando estructura para tabla turnerodb.turnos_pacientes
CREATE TABLE IF NOT EXISTS `turnos_pacientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `turno_id` int(11) NOT NULL,
  `paciente_dni` int(8) NOT NULL,
  KEY `FK_turnos_pacientes_turnos` (`turno_id`),
  KEY `FK_turnos_pacientes_pacientes` (`paciente_dni`),
  KEY `ID` (`id`,`turno_id`,`paciente_dni`) USING BTREE,
  CONSTRAINT `FK_turnos_pacientes_pacientes` FOREIGN KEY (`paciente_dni`) REFERENCES `pacientes` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_turnos_pacientes_turnos` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla turnerodb.turnos_pacientes: ~0 rows (aproximadamente)
DELETE FROM `turnos_pacientes`;
INSERT INTO `turnos_pacientes` (`id`, `turno_id`, `paciente_dni`) VALUES
	(4, 1, 11111111);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
