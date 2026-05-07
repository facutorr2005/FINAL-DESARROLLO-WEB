-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2026 a las 20:01:58
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `final_desarrollo_web`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_listas`
--

CREATE TABLE `detalle_listas` (
  `id` int(11) NOT NULL,
  `id_lista` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_al_momento` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_lista`
--

CREATE TABLE `estados_lista` (
  `id` int(11) NOT NULL,
  `nombre_estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_lista`
--

INSERT INTO `estados_lista` (`id`, `nombre_estado`) VALUES
(2, 'En Proceso'),
(3, 'Finalizada'),
(1, 'Pendiente'),
(4, 'Rechazada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_producto`
--

CREATE TABLE `estados_producto` (
  `id` int(11) NOT NULL,
  `nombre_estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_producto`
--

INSERT INTO `estados_producto` (`id`, `nombre_estado`) VALUES
(3, 'Dado de Baja'),
(1, 'En Stock'),
(2, 'Sin Stock');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_usuario`
--

CREATE TABLE `estados_usuario` (
  `id` int(11) NOT NULL,
  `nombre_estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados_usuario`
--

INSERT INTO `estados_usuario` (`id`, `nombre_estado`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listas`
--

CREATE TABLE `listas` (
  `id` int(11) NOT NULL,
  `id_usuario_cliente` int(11) NOT NULL,
  `id_estado_lista` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `bloqueado_por_id` int(11) DEFAULT NULL,
  `fecha_bloqueo` datetime DEFAULT NULL,
  `id_vendedor_final` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles_usuarios`
--

CREATE TABLE `perfiles_usuarios` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `razon_social` varchar(150) DEFAULT NULL,
  `correo_electronico` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
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
  `actualizado_en` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperacion_contrasenas`
--

CREATE TABLE `recuperacion_contrasenas` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `codigo_hash` varchar(255) NOT NULL,
  `fecha_expiracion` datetime NOT NULL,
  `fecha_generacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre_rol`) VALUES
(1, 'Administrador'),
(3, 'Secretario'),
(4, 'Usuario'),
(2, 'Vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `cuil_cuit` varchar(11) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL DEFAULT 1,
  `fecha_alta` datetime DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `detalle_listas`
--
ALTER TABLE `detalle_listas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_listas_listas` (`id_lista`),
  ADD KEY `fk_detalle_listas_productos` (`id_producto`);

--
-- Indices de la tabla `estados_lista`
--
ALTER TABLE `estados_lista`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_estado` (`nombre_estado`);

--
-- Indices de la tabla `estados_producto`
--
ALTER TABLE `estados_producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_estado` (`nombre_estado`);

--
-- Indices de la tabla `estados_usuario`
--
ALTER TABLE `estados_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_estado` (`nombre_estado`);

--
-- Indices de la tabla `listas`
--
ALTER TABLE `listas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_listas_usuarios_cliente` (`id_usuario_cliente`),
  ADD KEY `fk_listas_usuarios_bloqueo` (`bloqueado_por_id`),
  ADD KEY `fk_listas_usuarios_vendedor` (`id_vendedor_final`),
  ADD KEY `fk_listas_estados_lista` (`id_estado_lista`);

--
-- Indices de la tabla `perfiles_usuarios`
--
ALTER TABLE `perfiles_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_local` (`codigo_local`),
  ADD KEY `fk_productos_categorias` (`id_categoria`),
  ADD KEY `fk_productos_estados_producto` (`id_estado_producto`);

--
-- Indices de la tabla `recuperacion_contrasenas`
--
ALTER TABLE `recuperacion_contrasenas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_recuperacion_usuarios` (`id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_rol` (`nombre_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuil_cuit` (`cuil_cuit`),
  ADD KEY `fk_usuarios_roles` (`id_rol`),
  ADD KEY `fk_estados_usuarios` (`id_estado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_listas`
--
ALTER TABLE `detalle_listas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estados_lista`
--
ALTER TABLE `estados_lista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estados_producto`
--
ALTER TABLE `estados_producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estados_usuario`
--
ALTER TABLE `estados_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `listas`
--
ALTER TABLE `listas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `perfiles_usuarios`
--
ALTER TABLE `perfiles_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recuperacion_contrasenas`
--
ALTER TABLE `recuperacion_contrasenas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_listas`
--
ALTER TABLE `detalle_listas`
  ADD CONSTRAINT `fk_detalle_listas_listas` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_detalle_listas_productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `listas`
--
ALTER TABLE `listas`
  ADD CONSTRAINT `fk_listas_estados_lista` FOREIGN KEY (`id_estado_lista`) REFERENCES `estados_lista` (`id`),
  ADD CONSTRAINT `fk_listas_usuarios_bloqueo` FOREIGN KEY (`bloqueado_por_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_listas_usuarios_cliente` FOREIGN KEY (`id_usuario_cliente`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_listas_usuarios_vendedor` FOREIGN KEY (`id_vendedor_final`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `perfiles_usuarios`
--
ALTER TABLE `perfiles_usuarios`
  ADD CONSTRAINT `fk_perfiles_usuarios_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `fk_productos_estados_producto` FOREIGN KEY (`id_estado_producto`) REFERENCES `estados_producto` (`id`);

--
-- Filtros para la tabla `recuperacion_contrasenas`
--
ALTER TABLE `recuperacion_contrasenas`
  ADD CONSTRAINT `fk_recuperacion_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_estados_usuarios` FOREIGN KEY (`id_estado`) REFERENCES `estados_usuario` (`id`),
  ADD CONSTRAINT `fk_usuarios_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
