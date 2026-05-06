/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 10.4.32-MariaDB : Database - final_desarrollo_web
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`final_desarrollo_web` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `final_desarrollo_web`;

/*Table structure for table `categorias` */

DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_categoria` (`nombre_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `categorias` */

/*Table structure for table `detalle_listas` */

DROP TABLE IF EXISTS `detalle_listas`;

CREATE TABLE `detalle_listas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_lista` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_al_momento` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_detalle_listas_listas` (`id_lista`),
  KEY `fk_detalle_listas_productos` (`id_producto`),
  CONSTRAINT `fk_detalle_listas_listas` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_detalle_listas_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_listas` */

/*Table structure for table `estados_lista` */

DROP TABLE IF EXISTS `estados_lista`;

CREATE TABLE `estados_lista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_estado` (`nombre_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `estados_lista` */

/*Table structure for table `estados_productos` */

DROP TABLE IF EXISTS `estados_productos`;

CREATE TABLE `estados_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_estado` (`nombre_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `estados_productos` */

/*Table structure for table `estados_usuario` */

DROP TABLE IF EXISTS `estados_usuario`;

CREATE TABLE `estados_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_estado` (`nombre_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `estados_usuario` */

/*Table structure for table `listas` */

DROP TABLE IF EXISTS `listas`;

CREATE TABLE `listas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_cliente` int(11) NOT NULL,
  `id_estado_lista` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `bloqueado_por_id` int(11) DEFAULT NULL,
  `fecha_bloqueo` datetime DEFAULT NULL,
  `id_vendedor_final` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_listas_usuarios_cliente` (`id_usuario_cliente`),
  KEY `fk_listas_usuarios_bloqueo` (`bloqueado_por_id`),
  KEY `fk_listas_usuarios_vendedor` (`id_vendedor_final`),
  KEY `fk_listas_estados_lista` (`id_estado_lista`),
  CONSTRAINT `fk_listas_estados_lista` FOREIGN KEY (`id_estado_lista`) REFERENCES `estados_lista` (`id`),
  CONSTRAINT `fk_listas_usuarios_bloqueo` FOREIGN KEY (`bloqueado_por_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_listas_usuarios_cliente` FOREIGN KEY (`id_usuario_cliente`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_listas_usuarios_vendedor` FOREIGN KEY (`id_vendedor_final`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `listas` */

/*Table structure for table `perfiles_usuarios` */

DROP TABLE IF EXISTS `perfiles_usuarios`;

CREATE TABLE `perfiles_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `razon_social` varchar(150) DEFAULT NULL,
  `correo_electronico` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  CONSTRAINT `fk_perfiles_usuarios_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `perfiles_usuarios` */

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) NOT NULL,
  `codigo_local` varchar(50) NOT NULL,
  `nombre_producto` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `detalles_tecnicos` text DEFAULT NULL,
  `precio` decimal(12,2) NOT NULL,
  `precio_oferta` decimal(12,2) DEFAULT 0.00,
  `en_oferta` tinyint(1) DEFAULT 0,
  `id_estado_producto` int(11) NOT NULL,
  `url_imagen_producto` varchar(255) DEFAULT NULL,
  `creado_en` datetime DEFAULT current_timestamp(),
  `actualizado_en` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_local` (`codigo_local`),
  KEY `fk_productos_categorias` (`id_categoria`),
  KEY `fk_productos_estados_producto` (`id_estado_producto`),
  CONSTRAINT `fk_productos_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  CONSTRAINT `fk_productos_estados_producto` FOREIGN KEY (`id_estado_producto`) REFERENCES `estados_productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `productos` */

/*Table structure for table `recuperacion_contrasenas` */

DROP TABLE IF EXISTS `recuperacion_contrasenas`;

CREATE TABLE `recuperacion_contrasenas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `codigo_hash` varchar(255) NOT NULL,
  `fecha_expiracion` datetime NOT NULL,
  `fecha_generacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_recuperacion_usuarios` (`id_usuario`),
  CONSTRAINT `fk_recuperacion_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `recuperacion_contrasenas` */

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `roles` */

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuil_cuit` varchar(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `cuil_cuit` (`cuil_cuit`),
  KEY `fk_usuarios_roles` (`id_rol`),
  KEY `fk_estados_usuarios` (`id_estado`),
  CONSTRAINT `fk_estados_usuarios` FOREIGN KEY (`id_estado`) REFERENCES `estados_usuario` (`id`),
  CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
