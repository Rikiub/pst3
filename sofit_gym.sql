-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-05-2026 a las 07:35:01
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
-- Base de datos: `sofit_gym`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analisis_energetico`
--

CREATE TABLE `analisis_energetico` (
  `id_analisis` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date NOT NULL,
  `calorias_consumidas` int(11) DEFAULT NULL,
  `calorias_gastadas_estimadas` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `recomendacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_clase`
--

CREATE TABLE `asistencia_clase` (
  `id_asistencia` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `asistio` tinyint(1) DEFAULT 1,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia_gimnasio`
--

CREATE TABLE `asistencia_gimnasio` (
  `id_asistencia` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` datetime NOT NULL,
  `tipo` enum('Entrada','Salida') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE `clase` (
  `id_clase` int(11) NOT NULL,
  `cedula_trabajador` varchar(15) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `cupos_ocupados` int(11) DEFAULT 0,
  `capacidad_maxima` int(11) NOT NULL,
  `estado` enum('Programado','En curso','Finalizado','Cancelado') DEFAULT 'Programado',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id_clase`, `cedula_trabajador`, `nombre`, `descripcion`, `cupos_ocupados`, `capacidad_maxima`, `estado`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 'T-00000002', 'Yoga', NULL, 0, 20, 'Programado', '2026-04-26 10:00:00', '2026-04-26 11:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `cedula_cliente` varchar(15) NOT NULL,
  `id_membresia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cedula_cliente`, `id_membresia`) VALUES
('V-11111111', 0),
('V-22222222', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consulta_asistente`
--

CREATE TABLE `consulta_asistente` (
  `id_consulta` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `cedula_cliente` varchar(15) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `tipo` text DEFAULT NULL,
  `pregunta` text DEFAULT NULL,
  `respuesta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consulta_asistente`
--

INSERT INTO `consulta_asistente` (`id_consulta`, `id_usuario`, `cedula_cliente`, `fecha`, `tipo`, `pregunta`, `respuesta`) VALUES
(1, 1, NULL, '2026-04-26 02:55:55', NULL, '¿Qué ajustes de rutina recomiendas?', 'Aumentar series de sentadilla a 5.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicio`
--

CREATE TABLE `ejercicio` (
  `id_ejercicio` int(11) NOT NULL,
  `id_dificultad` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `grupo_muscular` varchar(100) DEFAULT NULL,
  `equipo_requerido` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `codigo_equipo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `estado` enum('Operativo','Mantenimiento','Fuera de Servicio') DEFAULT 'Operativo',
  `ubicacion` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`codigo_equipo`, `nombre`, `tipo`, `estado`, `ubicacion`, `activo`) VALUES
('EQ-001', 'Cinta de correr', 'Cardio', 'Operativo', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_membresia`
--

CREATE TABLE `estado_membresia` (
  `id_estado` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_membresia`
--

INSERT INTO `estado_membresia` (`id_estado`, `nombre`) VALUES
(1, 'Activo'),
(2, 'Vencido'),
(3, 'Moroso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario_trabajador`
--

CREATE TABLE `horario_trabajador` (
  `id_horario` int(11) NOT NULL,
  `cedula_trabajador` varchar(15) NOT NULL,
  `dia_semana` varchar(15) DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion_clase`
--

CREATE TABLE `inscripcion_clase` (
  `id_inscripcion` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `estado` enum('Activo','Cancelado') DEFAULT 'Activo',
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripcion_clase`
--

INSERT INTO `inscripcion_clase` (`id_inscripcion`, `id_clase`, `cedula_cliente`, `estado`, `fecha`) VALUES
(1, 1, 'V-11111111', 'Activo', '2026-04-26 20:03:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento_equipo`
--

CREATE TABLE `mantenimiento_equipo` (
  `id_mantenimiento` int(11) NOT NULL,
  `codigo_equipo` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` enum('Preventivo','Correctivo') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `tecnico` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mantenimiento_equipo`
--

INSERT INTO `mantenimiento_equipo` (`id_mantenimiento`, `codigo_equipo`, `fecha`, `tipo`, `descripcion`, `costo`, `tecnico`) VALUES
(1, 'EQ-001', '2026-03-15', 'Preventivo', 'Lubricación y calibración', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `membresia`
--

CREATE TABLE `membresia` (
  `id_membresia` int(11) NOT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT 3,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Deberia tener:\n- Activo\n- Vencido\n- Moroso';

--
-- Volcado de datos para la tabla `membresia`
--

INSERT INTO `membresia` (`id_membresia`, `id_tipo`, `id_estado`, `fecha_inicio`, `fecha_fin`) VALUES
(0, 1, NULL, '2026-04-06 00:00:00', '2026-04-07 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL,
  `id_tipo_notificacion` int(11) NOT NULL,
  `id_tipo_canal` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `mensaje` text NOT NULL,
  `estado` enum('Pendiente','Enviado','Fallido') DEFAULT 'Pendiente',
  `fecha_programada` datetime DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `comprobante_url` varchar(255) DEFAULT NULL,
  `estado` enum('Pagado','Pendiente','Atrasado') DEFAULT 'Pagado',
  `fecha_pago` date NOT NULL,
  `fecha_vencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `cedula_cliente`, `monto`, `metodo_pago`, `comprobante_url`, `estado`, `fecha_pago`, `fecha_vencimiento`) VALUES
(1, 'V-11111111', 30.00, 'Efectivo', NULL, 'Pagado', '2026-04-01', '2026-04-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `cedula_persona` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` int(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `activo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`cedula_persona`, `nombre`, `apellido`, `correo`, `telefono`, `direccion`, `fecha_nacimiento`, `fecha_registro`, `activo`) VALUES
('T-00000001', 'sag', 'AFa', NULL, NULL, NULL, NULL, '2026-04-26 16:46:02', 0),
('T-00000002', 'asga', 'asgas', '', NULL, NULL, NULL, '2026-04-26 16:46:02', 0),
('V-11111111', 'AD', 'F', NULL, NULL, NULL, NULL, '2026-04-26 16:45:34', 0),
('V-22222222', 'A', 'D', NULL, NULL, NULL, NULL, '2026-04-26 16:45:34', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigo_producto` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock_minimo` int(11) DEFAULT 0,
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `unidad_medida` varchar(20) DEFAULT 'unidad',
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codigo_producto`, `nombre`, `categoria`, `precio_venta`, `stock_minimo`, `stock_actual`, `unidad_medida`, `activo`) VALUES
('PROT001', 'Proteína Whey', NULL, 45.00, 0, 15, 'unidad', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutina`
--

CREATE TABLE `rutina` (
  `id_rutina` int(11) NOT NULL,
  `id_dificultad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `objetivo` text DEFAULT NULL,
  `duracion_semanas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rutina`
--

INSERT INTO `rutina` (`id_rutina`, `id_dificultad`, `nombre`, `descripcion`, `objetivo`, `duracion_semanas`) VALUES
(1, 1, 'Fuerza Básica', 'Full body', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutina_asignada`
--

CREATE TABLE `rutina_asignada` (
  `id_asignacion` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `id_rutina` int(11) NOT NULL,
  `fecha_asignacion` date NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('Activa','Completada','Cancelada') DEFAULT 'Activa',
  `progreso` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_fisico`
--

CREATE TABLE `seguimiento_fisico` (
  `id_seguimiento` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date DEFAULT NULL,
  `altura_cm` decimal(5,2) DEFAULT NULL,
  `peso_kg` decimal(5,2) DEFAULT NULL,
  `cintura_cm` decimal(5,2) DEFAULT NULL,
  `cadera_cm` decimal(5,2) DEFAULT NULL,
  `pecho_cm` decimal(5,2) DEFAULT NULL,
  `muslo_cm` decimal(5,2) DEFAULT NULL,
  `hombros_cm` decimal(5,2) DEFAULT NULL,
  `pantorrilla_cm` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento_nutricional`
--

CREATE TABLE `seguimiento_nutricional` (
  `id_seguimiento` int(11) NOT NULL,
  `cedula_cliente` varchar(15) NOT NULL,
  `fecha` date DEFAULT NULL,
  `proteinas_g` decimal(5,2) DEFAULT NULL,
  `carbohidratos_g` decimal(5,2) DEFAULT NULL,
  `grasas_g` decimal(5,2) DEFAULT NULL,
  `calorias_diarias` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_canal`
--

CREATE TABLE `tipo_canal` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_canal`
--

INSERT INTO `tipo_canal` (`id_tipo`, `nombre`) VALUES
(1, 'App'),
(2, 'Email'),
(3, 'WhatsApp');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_dificultad`
--

CREATE TABLE `tipo_dificultad` (
  `id_dificultad` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_dificultad`
--

INSERT INTO `tipo_dificultad` (`id_dificultad`, `nombre`) VALUES
(1, 'Principiante'),
(2, 'Intermedio'),
(3, 'Avanzado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_membresia`
--

CREATE TABLE `tipo_membresia` (
  `id_tipo` int(11) NOT NULL COMMENT '1 = Mensual\n2 = Trimestral\n3 = Anual',
  `nombre` varchar(100) NOT NULL,
  `monto` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_membresia`
--

INSERT INTO `tipo_membresia` (`id_tipo`, `nombre`, `monto`) VALUES
(1, 'Mensual', 0),
(2, 'Trimuestral', 0),
(3, 'Anual', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_notificacion`
--

CREATE TABLE `tipo_notificacion` (
  `id_tipo` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_notificacion`
--

INSERT INTO `tipo_notificacion` (`id_tipo`, `nombre`) VALUES
(1, 'Pago de vencimiento'),
(2, 'Recordatorio de clase'),
(3, 'Promoción'),
(4, 'Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_rol`
--

CREATE TABLE `tipo_rol` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_rol`
--

INSERT INTO `tipo_rol` (`id_rol`, `nombre`) VALUES
(1, 'Gerente'),
(2, 'Entrenador'),
(3, 'Recepcionista'),
(4, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `cedula_trabajador` varchar(15) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajador`
--

INSERT INTO `trabajador` (`cedula_trabajador`, `id_rol`, `salario`, `fecha_contratacion`) VALUES
('T-00000001', 1, NULL, NULL),
('T-00000002', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `cedula_persona` varchar(15) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `ultimo_acceso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `id_rol`, `cedula_persona`, `usuario`, `contrasena`, `ultimo_acceso`) VALUES
(1, 2, 'T-00000001', 'carlos.perez', 'admin123', NULL),
(2, 2, 'T-00000002', 'ana.gomez', 'ana123', NULL),
(3, 4, 'V-11111111', 'luis.martinez', 'cliente123', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_producto`
--

CREATE TABLE `venta_producto` (
  `id_venta` int(11) NOT NULL,
  `codigo_producto` varchar(20) NOT NULL,
  `cedula_cliente` varchar(15) DEFAULT NULL,
  `cantidad_vendida` decimal(10,2) DEFAULT NULL,
  `monto_total` varchar(100) DEFAULT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta_producto`
--

INSERT INTO `venta_producto` (`id_venta`, `codigo_producto`, `cedula_cliente`, `cantidad_vendida`, `monto_total`, `metodo_pago`, `fecha`) VALUES
(1, 'PROT001', 'V-11111111', 45.00, NULL, 'Efectivo', '2026-04-26 02:55:55');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_cliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_cliente` (
`cedula_persona` varchar(15)
,`nombre` varchar(50)
,`apellido` varchar(50)
,`correo` varchar(100)
,`telefono` int(20)
,`direccion` text
,`fecha_nacimiento` date
,`fecha_registro` datetime
,`nombre_tipo_membresia` varchar(100)
,`nombre_estado_membresia` varchar(100)
,`fecha_inicio` datetime
,`fecha_fin` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_demanda_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_demanda_productos` (
`codigo` varchar(20)
,`nombre` varchar(100)
,`unidades_vendidas` decimal(32,2)
,`ingresos_totales` double
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_deudores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_deudores` (
`cedula` varchar(15)
,`nombre` varchar(50)
,`apellido` varchar(50)
,`correo` varchar(100)
,`monto_deuda` decimal(10,2)
,`fecha_vencimiento` date
,`dias_mora` int(7)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ingresos_mensuales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_ingresos_mensuales` (
`mes` varchar(7)
,`total_ingresos` decimal(32,2)
,`cantidad_transacciones` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ocupacion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_ocupacion` (
`fecha` date
,`hora` int(2)
,`clientes_unicos` bigint(21)
,`total_accesos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_cliente`
--
DROP TABLE IF EXISTS `vista_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_cliente`  AS SELECT `p`.`cedula_persona` AS `cedula_persona`, `p`.`nombre` AS `nombre`, `p`.`apellido` AS `apellido`, `p`.`correo` AS `correo`, `p`.`telefono` AS `telefono`, `p`.`direccion` AS `direccion`, `p`.`fecha_nacimiento` AS `fecha_nacimiento`, `p`.`fecha_registro` AS `fecha_registro`, `tm`.`nombre` AS `nombre_tipo_membresia`, `em`.`nombre` AS `nombre_estado_membresia`, `m`.`fecha_inicio` AS `fecha_inicio`, `m`.`fecha_fin` AS `fecha_fin` FROM ((((`persona` `p` left join `cliente` `c` on(`p`.`cedula_persona` = `c`.`cedula_cliente`)) left join `membresia` `m` on(`c`.`id_membresia` = `m`.`id_membresia`)) left join `tipo_membresia` `tm` on(`m`.`id_tipo` = `tm`.`id_tipo`)) left join `estado_membresia` `em` on(`m`.`id_estado` = `em`.`id_estado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_demanda_productos`
--
DROP TABLE IF EXISTS `vista_demanda_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_demanda_productos`  AS SELECT `p`.`codigo_producto` AS `codigo`, `p`.`nombre` AS `nombre`, sum(`v`.`cantidad_vendida`) AS `unidades_vendidas`, sum(`v`.`monto_total`) AS `ingresos_totales` FROM (`producto` `p` join `venta_producto` `v` on(`p`.`codigo_producto` = `v`.`codigo_producto`)) GROUP BY `p`.`codigo_producto`, `p`.`nombre` ORDER BY sum(`v`.`cantidad_vendida`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_deudores`
--
DROP TABLE IF EXISTS `vista_deudores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_deudores`  AS SELECT `c`.`cedula_cliente` AS `cedula`, `per`.`nombre` AS `nombre`, `per`.`apellido` AS `apellido`, `per`.`correo` AS `correo`, `pa`.`monto` AS `monto_deuda`, `pa`.`fecha_vencimiento` AS `fecha_vencimiento`, to_days(curdate()) - to_days(`pa`.`fecha_vencimiento`) AS `dias_mora` FROM ((`pago` `pa` left join `cliente` `c` on(`pa`.`cedula_cliente` = `c`.`cedula_cliente`)) left join `persona` `per` on(`c`.`cedula_cliente` = `per`.`cedula_persona`)) WHERE `pa`.`estado` in ('Pendiente','Atrasado') AND `pa`.`fecha_vencimiento` < curdate() ORDER BY to_days(curdate()) - to_days(`pa`.`fecha_vencimiento`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ingresos_mensuales`
--
DROP TABLE IF EXISTS `vista_ingresos_mensuales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_ingresos_mensuales`  AS SELECT date_format(`p`.`fecha_pago`,'%Y-%m') AS `mes`, sum(`p`.`monto`) AS `total_ingresos`, count(`p`.`id_pago`) AS `cantidad_transacciones` FROM `pago` AS `p` WHERE `p`.`estado` = 'Pagado' GROUP BY date_format(`p`.`fecha_pago`,'%Y-%m') ORDER BY date_format(`p`.`fecha_pago`,'%Y-%m') DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ocupacion`
--
DROP TABLE IF EXISTS `vista_ocupacion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_ocupacion`  AS SELECT cast(`a`.`fecha` as date) AS `fecha`, hour(`a`.`fecha`) AS `hora`, count(distinct `a`.`cedula_cliente`) AS `clientes_unicos`, count(0) AS `total_accesos` FROM `asistencia_gimnasio` AS `a` WHERE `a`.`tipo` = 'Entrada' GROUP BY `a`.`fecha`, hour(`a`.`fecha`) ORDER BY cast(`a`.`fecha` as date) DESC, hour(`a`.`fecha`) ASC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `analisis_energetico`
--
ALTER TABLE `analisis_energetico`
  ADD PRIMARY KEY (`id_analisis`),
  ADD KEY `fk_analisis_cliente` (`cedula_cliente`);

--
-- Indices de la tabla `asistencia_clase`
--
ALTER TABLE `asistencia_clase`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `fk_asistencia_clase_clase` (`id_clase`),
  ADD KEY `fk_asistencia_clase_cliente` (`cedula_cliente`);

--
-- Indices de la tabla `asistencia_gimnasio`
--
ALTER TABLE `asistencia_gimnasio`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `fk_asistencia_cliente` (`cedula_cliente`),
  ADD KEY `idx_asistencias_fecha` (`fecha`);

--
-- Indices de la tabla `clase`
--
ALTER TABLE `clase`
  ADD PRIMARY KEY (`id_clase`),
  ADD KEY `fk_clase_instructor` (`cedula_trabajador`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cedula_cliente`),
  ADD KEY `cliente_membresia_FK` (`id_membresia`);

--
-- Indices de la tabla `consulta_asistente`
--
ALTER TABLE `consulta_asistente`
  ADD PRIMARY KEY (`id_consulta`),
  ADD KEY `idx_consultas_fecha` (`fecha`),
  ADD KEY `consulta_asistente_usuario_FK` (`id_usuario`);

--
-- Indices de la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  ADD PRIMARY KEY (`id_ejercicio`),
  ADD KEY `ejercicio_tipo_dificultad_FK` (`id_dificultad`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`codigo_equipo`);

--
-- Indices de la tabla `estado_membresia`
--
ALTER TABLE `estado_membresia`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `horario_trabajador`
--
ALTER TABLE `horario_trabajador`
  ADD PRIMARY KEY (`id_horario`),
  ADD KEY `horario_trabajador_trabajador_FK` (`cedula_trabajador`);

--
-- Indices de la tabla `inscripcion_clase`
--
ALTER TABLE `inscripcion_clase`
  ADD PRIMARY KEY (`id_inscripcion`),
  ADD UNIQUE KEY `uk_cliente_clase` (`cedula_cliente`,`id_clase`),
  ADD KEY `fk_inscripcion_clase` (`id_clase`);

--
-- Indices de la tabla `mantenimiento_equipo`
--
ALTER TABLE `mantenimiento_equipo`
  ADD PRIMARY KEY (`id_mantenimiento`),
  ADD KEY `fk_mantenimiento_equipo` (`codigo_equipo`);

--
-- Indices de la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD PRIMARY KEY (`id_membresia`),
  ADD KEY `fk_membresia_tipo` (`id_tipo`),
  ADD KEY `membresia_estado_membresia_FK` (`id_estado`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `fk_notificacion_cliente` (`cedula_cliente`),
  ADD KEY `idx_notificaciones_pendientes` (`fecha_programada`,`estado`),
  ADD KEY `notificacion_tipo_notificacion_FK` (`id_tipo_notificacion`),
  ADD KEY `notificacion_tipo_canal_FK` (`id_tipo_canal`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `fk_pago_cliente` (`cedula_cliente`),
  ADD KEY `idx_pagos_cliente_estado` (`cedula_cliente`,`estado`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`cedula_persona`),
  ADD UNIQUE KEY `personas_unique` (`correo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo_producto`);

--
-- Indices de la tabla `rutina`
--
ALTER TABLE `rutina`
  ADD PRIMARY KEY (`id_rutina`),
  ADD KEY `rutina_tipo_rutina_FK` (`id_dificultad`);

--
-- Indices de la tabla `rutina_asignada`
--
ALTER TABLE `rutina_asignada`
  ADD PRIMARY KEY (`id_asignacion`),
  ADD KEY `fk_asignacion_cliente` (`cedula_cliente`),
  ADD KEY `fk_asignacion_rutina` (`id_rutina`);

--
-- Indices de la tabla `seguimiento_fisico`
--
ALTER TABLE `seguimiento_fisico`
  ADD PRIMARY KEY (`id_seguimiento`),
  ADD KEY `seguimiento_fisico_cliente_FK` (`cedula_cliente`);

--
-- Indices de la tabla `seguimiento_nutricional`
--
ALTER TABLE `seguimiento_nutricional`
  ADD PRIMARY KEY (`id_seguimiento`),
  ADD KEY `plan_nutricional_cliente_FK` (`cedula_cliente`);

--
-- Indices de la tabla `tipo_canal`
--
ALTER TABLE `tipo_canal`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `tipo_dificultad`
--
ALTER TABLE `tipo_dificultad`
  ADD PRIMARY KEY (`id_dificultad`);

--
-- Indices de la tabla `tipo_membresia`
--
ALTER TABLE `tipo_membresia`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `tipo_notificacion`
--
ALTER TABLE `tipo_notificacion`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `tipo_rol`
--
ALTER TABLE `tipo_rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD PRIMARY KEY (`cedula_trabajador`),
  ADD KEY `trabajador_tipo_rol_FK` (`id_rol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `usuario_persona_FK` (`cedula_persona`),
  ADD KEY `usuario_tipo_rol_FK` (`id_rol`);

--
-- Indices de la tabla `venta_producto`
--
ALTER TABLE `venta_producto`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `fk_venta_cliente` (`cedula_cliente`),
  ADD KEY `idx_ventas_fecha` (`fecha`),
  ADD KEY `venta_producto_producto_FK` (`codigo_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `analisis_energetico`
--
ALTER TABLE `analisis_energetico`
  MODIFY `id_analisis` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asistencia_clase`
--
ALTER TABLE `asistencia_clase`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asistencia_gimnasio`
--
ALTER TABLE `asistencia_gimnasio`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clase`
--
ALTER TABLE `clase`
  MODIFY `id_clase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `consulta_asistente`
--
ALTER TABLE `consulta_asistente`
  MODIFY `id_consulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  MODIFY `id_ejercicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripcion_clase`
--
ALTER TABLE `inscripcion_clase`
  MODIFY `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `mantenimiento_equipo`
--
ALTER TABLE `mantenimiento_equipo`
  MODIFY `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `membresia`
--
ALTER TABLE `membresia`
  MODIFY `id_membresia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rutina`
--
ALTER TABLE `rutina`
  MODIFY `id_rutina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rutina_asignada`
--
ALTER TABLE `rutina_asignada`
  MODIFY `id_asignacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `seguimiento_fisico`
--
ALTER TABLE `seguimiento_fisico`
  MODIFY `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento_nutricional`
--
ALTER TABLE `seguimiento_nutricional`
  MODIFY `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_canal`
--
ALTER TABLE `tipo_canal`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_dificultad`
--
ALTER TABLE `tipo_dificultad`
  MODIFY `id_dificultad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `venta_producto`
--
ALTER TABLE `venta_producto`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `analisis_energetico`
--
ALTER TABLE `analisis_energetico`
  ADD CONSTRAINT `fk_analisis_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `asistencia_clase`
--
ALTER TABLE `asistencia_clase`
  ADD CONSTRAINT `fk_asistencia_clase_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_asistencia_clase_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `asistencia_gimnasio`
--
ALTER TABLE `asistencia_gimnasio`
  ADD CONSTRAINT `fk_asistencia_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `clase`
--
ALTER TABLE `clase`
  ADD CONSTRAINT `fk_clase_instructor` FOREIGN KEY (`cedula_trabajador`) REFERENCES `trabajador` (`cedula_trabajador`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_membresia_FK` FOREIGN KEY (`id_membresia`) REFERENCES `membresia` (`id_membresia`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cliente_persona_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `consulta_asistente`
--
ALTER TABLE `consulta_asistente`
  ADD CONSTRAINT `consulta_asistente_usuario_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  ADD CONSTRAINT `ejercicio_tipo_dificultad_FK` FOREIGN KEY (`id_dificultad`) REFERENCES `tipo_dificultad` (`id_dificultad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `horario_trabajador`
--
ALTER TABLE `horario_trabajador`
  ADD CONSTRAINT `horario_trabajador_trabajador_FK` FOREIGN KEY (`cedula_trabajador`) REFERENCES `trabajador` (`cedula_trabajador`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscripcion_clase`
--
ALTER TABLE `inscripcion_clase`
  ADD CONSTRAINT `fk_inscripcion_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_inscripcion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `mantenimiento_equipo`
--
ALTER TABLE `mantenimiento_equipo`
  ADD CONSTRAINT `fk_mantenimiento_equipo` FOREIGN KEY (`codigo_equipo`) REFERENCES `equipo` (`codigo_equipo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `membresia`
--
ALTER TABLE `membresia`
  ADD CONSTRAINT `fk_membresia_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_membresia` (`id_tipo`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `membresia_estado_membresia_FK` FOREIGN KEY (`id_estado`) REFERENCES `estado_membresia` (`id_estado`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD CONSTRAINT `fk_notificacion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notificacion_tipo_canal_FK` FOREIGN KEY (`id_tipo_canal`) REFERENCES `tipo_canal` (`id_tipo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `notificacion_tipo_notificacion_FK` FOREIGN KEY (`id_tipo_notificacion`) REFERENCES `tipo_notificacion` (`id_tipo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_pago_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `rutina`
--
ALTER TABLE `rutina`
  ADD CONSTRAINT `rutina_tipo_rutina_FK` FOREIGN KEY (`id_dificultad`) REFERENCES `tipo_dificultad` (`id_dificultad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `rutina_asignada`
--
ALTER TABLE `rutina_asignada`
  ADD CONSTRAINT `fk_asignacion_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asignacion_rutina` FOREIGN KEY (`id_rutina`) REFERENCES `rutina` (`id_rutina`) ON DELETE CASCADE;

--
-- Filtros para la tabla `seguimiento_fisico`
--
ALTER TABLE `seguimiento_fisico`
  ADD CONSTRAINT `seguimiento_fisico_cliente_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `seguimiento_nutricional`
--
ALTER TABLE `seguimiento_nutricional`
  ADD CONSTRAINT `plan_nutricional_cliente_FK` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD CONSTRAINT `trabajador_persona_FK` FOREIGN KEY (`cedula_trabajador`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trabajador_tipo_rol_FK` FOREIGN KEY (`id_rol`) REFERENCES `tipo_rol` (`id_rol`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_persona_FK` FOREIGN KEY (`cedula_persona`) REFERENCES `persona` (`cedula_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_tipo_rol_FK` FOREIGN KEY (`id_rol`) REFERENCES `tipo_rol` (`id_rol`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta_producto`
--
ALTER TABLE `venta_producto`
  ADD CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_producto_producto_FK` FOREIGN KEY (`codigo_producto`) REFERENCES `producto` (`codigo_producto`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
