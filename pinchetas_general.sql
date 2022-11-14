-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-11-2022 a las 13:38:46
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pinchetas_general`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_aplicacion` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._aplicacion ( 
    apli_id,
    apli_descripcion,
    apli_url,
    apli_icono,
    apli_orden,
    apli_registradopor,
    apli_fechacambio,
    operacion 
) 
SELECT 
    apli_id,
    apli_descripcion,
    apli_url,
    apli_icono,
    apli_orden,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.aplicacion 
WHERE apli_id = p_id; 
DELETE FROM pinchetas_general.aplicacion WHERE apli_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_departamento` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._departamento ( 
    depa_id,
    depa_descripcion,
    depa_orden,
    pais_id,
    depa_registradopor,
    depa_fechacambio,
    operacion 
) 
SELECT 
    depa_id,
    depa_descripcion,
    depa_orden,
    pais_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.departamento 
WHERE depa_id = p_id; 
DELETE FROM pinchetas_general.departamento WHERE depa_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_funcionalidad` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._funcionalidad ( 
    func_id,
    func_descripcion,
    func_tipo,
    func_url,
    func_icono,
    func_orden,
    apli_id,
    func_idpadre,
    func_registradopor,
    func_fechacambio,
    operacion 
) 
SELECT 
    func_id,
    func_descripcion,
    func_tipo,
    func_url,
    func_icono,
    func_orden,
    apli_id,
    func_idpadre,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.funcionalidad 
WHERE func_id = p_id; 
DELETE FROM pinchetas_general.funcionalidad WHERE func_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_ingresousuario` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._ingresousuario ( 
    inus_id,
    usua_id,
    inus_usuario,
    inus_clave,
    inus_return,
    inus_fechacambio,
    inus_registradopor,
    operacion 
) 
SELECT 
    inus_id,
    usua_id,
    inus_usuario,
    inus_clave,
    inus_return,
    NOW(),
    id_registradopor,
    'D' 
FROM pinchetas_general.ingresousuario 
WHERE inus_id = p_id; 
DELETE FROM pinchetas_general.ingresousuario WHERE inus_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_municipio` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._municipio ( 
    muni_id,
    muni_descripcion,
    muni_orden,
    depa_id,
    muni_registradorpor,
    muni_fechacambio,
    operacion 
) 
SELECT 
    muni_id,
    muni_descripcion,
    muni_orden,
    depa_id,
    muni_registradorpor,
    NOW(),
    'D' 
FROM pinchetas_general.municipio 
WHERE muni_id = p_id; 
DELETE FROM pinchetas_general.municipio WHERE muni_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_pais` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._pais ( 
    pais_id,
    pais_descripcion,
    pais_codigo,
    pais_iso,
    pais_registradopor,
    pais_fechacambio,
    operacion 
) 
SELECT 
    pais_id,
    pais_descripcion,
    pais_codigo,
    pais_iso,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.pais 
WHERE pais_id = p_id; 
DELETE FROM pinchetas_general.pais WHERE pais_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_parametro` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._parametro ( 
    para_id,
    para_nombre,
    para_descripcion,
    para_registradopor,
    para_fechacambio,
    operacion 
) 
SELECT 
    para_id,
    para_nombre,
    para_descripcion,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.parametro 
WHERE para_id = p_id; 
DELETE FROM pinchetas_general.parametro WHERE para_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_parametroano` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._parametroano ( 
    paan_id,
    paan_descripcion,
    paan_ano,
    paan_valor,
    paan_fechainicio,
    paan_fechafin,
    para_id,
    paan_registradopor,
    paan_fechacambio,
    operacion 
) 
SELECT 
    paan_id,
    paan_descripcion,
    paan_ano,
    paan_valor,
    paan_fechainicio,
    paan_fechafin,
    para_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.parametroano 
WHERE paan_id = p_id; 
DELETE FROM pinchetas_general.parametroano WHERE paan_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_personageneral` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._personageneral ( 
    pege_id,
    pege_documento,
    tido_id,
    pege_direccion,
    pege_telefono,
    pege_correo,
    muni_id,
    pege_registradopor,
    pege_fechacambio,
    operacion 
) 
SELECT 
    pege_id,
    pege_documento,
    tido_id,
    pege_direccion,
    pege_telefono,
    pege_correo,
    muni_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.personageneral 
WHERE pege_id = p_id; 
DELETE FROM pinchetas_general.personageneral WHERE pege_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_personajuridica` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._personajuridica ( 
    peju_id,
    peju_razonsocial,
    peju_nombrerepresentante,
    peju_codigodane,
    pege_id,
    peju_registradorpor,
    peju_fechacambio,
    operacion 
) 
SELECT 
    peju_id,
    peju_razonsocial,
    peju_nombrerepresentante,
    peju_codigodane,
    pege_id,
    peju_registradorpor,
    NOW(),
    'D' 
FROM pinchetas_general.personajuridica 
WHERE peju_id = p_id; 
DELETE FROM pinchetas_general.personajuridica WHERE peju_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_personanatural` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._personanatural ( 
    pena_id,
    pena_documento,
    pena_primernombre,
    pena_segundonombre,
    pena_primerapellido,
    pena_segundoapellido,
    pena_fechanacimiento,
    pena_sexo,
    pena_foto,
    pege_id,
    ciud_id,
    pena_registradopor,
    pena_fechacambio,
    operacion 
) 
SELECT 
    pena_id,
    pena_documento,
    pena_primernombre,
    pena_segundonombre,
    pena_primerapellido,
    pena_segundoapellido,
    pena_fechanacimiento,
    pena_sexo,
    pena_foto,
    pege_id,
    ciud_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.personanatural 
WHERE pena_id = p_id; 
DELETE FROM pinchetas_general.personanatural WHERE pena_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_reporte` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._reporte ( 
    repo_id,
    repo_nombre,
    repo_descripcion,
    repo_sql,
    repo_tipo,
    anle_id,
    repo_registradopor,
    repo_fechacambio,
    operacion 
) 
SELECT 
    repo_id,
    repo_nombre,
    repo_descripcion,
    repo_sql,
    repo_tipo,
    anle_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.reporte 
WHERE repo_id = p_id; 
DELETE FROM pinchetas_general.reporte WHERE repo_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_rol` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._rol ( 
    rol_id,
    rol_descripcion,
    rol_orden,
    rol_visible,
    rol_registradopor,
    rol_fechacambio,
    operacion 
) 
SELECT 
    rol_id,
    rol_descripcion,
    rol_orden,
    rol_visible,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.rol 
WHERE rol_id = p_id; 
DELETE FROM pinchetas_general.rol WHERE rol_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_rolfuncionalidad` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._rolfuncionalidad ( 
    rofu_id,
    rol_id,
    func_id,
    apli_id,
    rofu_registradopor,
    rofu_fechacambio,
    operacion 
) 
SELECT 
    rofu_id,
    rol_id,
    func_id,
    apli_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.rolfuncionalidad 
WHERE rofu_id = p_id; 
DELETE FROM pinchetas_general.rolfuncionalidad WHERE rofu_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_tipodocumento` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._tipodocumento ( 
    tido_id,
    tido_descripcion,
    tido_abreviatura,
    tido_orden,
    tido_regisradopor,
    tido_fechacambio,
    operacion 
) 
SELECT 
    tido_id,
    tido_descripcion,
    tido_abreviatura,
    tido_orden,
    tido_regisradopor,
    NOW(),
    'D' 
FROM pinchetas_general.tipodocumento 
WHERE tido_id = p_id; 
DELETE FROM pinchetas_general.tipodocumento WHERE tido_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_usuario` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._usuario ( 
    usua_id,
    usua_cuenta,
    usua_clave,
    pege_id,
    usua_registradopor,
    usua_fechacambio,
    operacion 
) 
SELECT 
    usua_id,
    usua_cuenta,
    usua_clave,
    pege_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.usuario 
WHERE usua_id = p_id; 
DELETE FROM pinchetas_general.usuario WHERE usua_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_usuariorol` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_general._usuariorol ( 
    usro_id,
    usua_id,
    rol_id,
    usro_registradopor,
    usro_fechacambio,
    operacion 
) 
SELECT 
    usro_id,
    usua_id,
    rol_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_general.usuariorol 
WHERE usro_id = p_id; 
DELETE FROM pinchetas_general.usuariorol WHERE usro_id = p_id; 
COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicacion`
--

CREATE TABLE `aplicacion` (
  `apli_id` bigint(20) NOT NULL,
  `apli_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `apli_url` text COLLATE utf8_spanish_ci NOT NULL,
  `apli_icono` text COLLATE utf8_spanish_ci NOT NULL,
  `apli_orden` bigint(20) NOT NULL,
  `apli_registradopor` bigint(20) NOT NULL,
  `apli_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `aplicacion`
--

INSERT INTO `aplicacion` (`apli_id`, `apli_descripcion`, `apli_url`, `apli_icono`, `apli_orden`, `apli_registradopor`, `apli_fechacambio`) VALUES
(1, 'General', '../../general/front/', 'fa fa-cogs', 1, 1, '2018-11-21 00:00:00'),
(2, 'Administración', '../../administracion-restaurante/front/', 'fa fa-tasks', 2, 1, '2019-03-17 00:17:44'),
(4, 'Mesero', '../../mesero/front/', 'fa fa-glass', 4, 1, '2019-03-10 00:00:00');

--
-- Disparadores `aplicacion`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_aplicacion` AFTER INSERT ON `aplicacion` FOR EACH ROW INSERT INTO pinchetas_general._aplicacion ( 
    apli_id,
    apli_descripcion,
    apli_url,
    apli_icono,
    apli_orden,
    apli_registradopor,
    apli_fechacambio,
    operacion 
) 
VALUES ( 
    new.apli_id,
    new.apli_descripcion,
    new.apli_url,
    new.apli_icono,
    new.apli_orden,
    new.apli_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_aplicacion` AFTER UPDATE ON `aplicacion` FOR EACH ROW INSERT INTO pinchetas_general._aplicacion ( 
    apli_id,
    apli_descripcion,
    apli_url,
    apli_icono,
    apli_orden,
    apli_registradopor,
    apli_fechacambio,
    operacion 
) 
VALUES ( 
    new.apli_id,
    new.apli_descripcion,
    new.apli_url,
    new.apli_icono,
    new.apli_orden,
    new.apli_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `depa_id` bigint(20) NOT NULL,
  `depa_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `depa_orden` bigint(20) DEFAULT NULL,
  `pais_id` bigint(20) NOT NULL,
  `depa_registradopor` bigint(20) NOT NULL,
  `depa_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`depa_id`, `depa_descripcion`, `depa_orden`, `pais_id`, `depa_registradopor`, `depa_fechacambio`) VALUES
(1, 'Amazonas', 1, 1, 1, '2022-11-11 02:05:34'),
(2, 'Antioquia', 2, 1, 1, '2022-11-11 02:05:34'),
(3, 'Arauca', 3, 1, 1, '2022-11-11 02:05:34'),
(4, 'Atlántico', 4, 1, 1, '2022-11-11 02:05:34'),
(5, 'Bogotá, D.C.', 5, 1, 1, '2022-11-11 02:05:34'),
(6, 'Bolívar', 6, 1, 1, '2022-11-11 02:05:34'),
(7, 'Boyacá', 7, 1, 1, '2022-11-11 02:05:34'),
(8, 'Caldas', 8, 1, 1, '2022-11-11 02:05:34'),
(9, 'Caquetá', 9, 1, 1, '2022-11-11 02:05:34'),
(10, 'Casanare', 10, 1, 1, '2022-11-11 02:05:34'),
(11, 'Cauca', 11, 1, 1, '2022-11-11 02:05:34'),
(12, 'Cesar', 12, 1, 1, '2022-11-11 02:05:34'),
(13, 'Chocó', 13, 1, 1, '2022-11-11 02:05:34'),
(14, 'Córdoba', 14, 1, 1, '2022-11-11 02:05:34'),
(15, 'Cundinamarca', 15, 1, 1, '2022-11-11 02:05:34'),
(16, 'Guainia', 16, 1, 1, '2022-11-11 02:05:34'),
(17, 'Guaviare', 17, 1, 1, '2022-11-11 02:05:34'),
(18, 'Huila', 18, 1, 1, '2022-11-11 02:05:34'),
(19, 'La Guajira', 19, 1, 1, '2022-11-11 02:05:34'),
(20, 'Magdalena', 20, 1, 1, '2022-11-11 02:05:34'),
(21, 'Meta', 21, 1, 1, '2022-11-11 02:05:34'),
(22, 'N. de Santander', 22, 1, 1, '2022-11-11 02:05:34'),
(23, 'Nariño', 23, 1, 1, '2022-11-11 02:05:34'),
(24, 'Putumayo', 24, 1, 1, '2022-11-11 02:05:34'),
(25, 'Quindío', 25, 1, 1, '2022-11-11 02:05:34'),
(26, 'Risaralda', 26, 1, 1, '2022-11-11 02:05:34'),
(27, 'San Andrés', 27, 1, 1, '2022-11-11 02:05:34'),
(28, 'Santander', 28, 1, 1, '2022-11-11 02:05:34'),
(29, 'Sucre', 29, 1, 1, '2022-11-11 02:05:34'),
(30, 'Tolima', 30, 1, 1, '2022-11-11 02:05:34'),
(31, 'Valle del Cauca', 31, 1, 1, '2022-11-11 02:05:34'),
(32, 'Vaupés', 32, 1, 1, '2022-11-11 02:05:34'),
(33, 'Vichada', 33, 1, 1, '2022-11-11 02:05:34');

--
-- Disparadores `departamento`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_departamento` AFTER INSERT ON `departamento` FOR EACH ROW INSERT INTO pinchetas_general._departamento ( 
    depa_id,
    depa_descripcion,
    depa_orden,
    pais_id,
    depa_registradopor,
    depa_fechacambio,
    operacion 
) 
VALUES ( 
    new.depa_id,
    new.depa_descripcion,
    new.depa_orden,
    new.pais_id,
    new.depa_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_departamento` AFTER UPDATE ON `departamento` FOR EACH ROW INSERT INTO pinchetas_general._departamento ( 
    depa_id,
    depa_descripcion,
    depa_orden,
    pais_id,
    depa_registradopor,
    depa_fechacambio,
    operacion 
) 
VALUES ( 
    new.depa_id,
    new.depa_descripcion,
    new.depa_orden,
    new.pais_id,
    new.depa_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionalidad`
--

CREATE TABLE `funcionalidad` (
  `func_id` bigint(20) NOT NULL,
  `func_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `func_tipo` text COLLATE utf8_spanish_ci NOT NULL,
  `func_url` text COLLATE utf8_spanish_ci NOT NULL,
  `func_icono` text COLLATE utf8_spanish_ci NOT NULL,
  `func_orden` bigint(20) NOT NULL,
  `apli_id` bigint(20) NOT NULL,
  `func_idpadre` bigint(20) DEFAULT NULL,
  `func_registradopor` bigint(20) NOT NULL,
  `func_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `funcionalidad`
--

INSERT INTO `funcionalidad` (`func_id`, `func_descripcion`, `func_tipo`, `func_url`, `func_icono`, `func_orden`, `apli_id`, `func_idpadre`, `func_registradopor`, `func_fechacambio`) VALUES
(11, 'ROL', 'FUNCIONALIDAD', '/rol/', 'fa fa-user-secret ', 10, 1, NULL, 1, '2019-03-11 02:05:34'),
(15, 'FUNCIONALIDAD', 'FUNCIONALIDAD', '/funcionalidad/', 'fa fa-check-circle', 11, 1, NULL, 1, '2019-03-11 02:02:13'),
(16, 'APLICACIÓN', 'FUNCIONALIDAD', '/aplicacion/', 'fa fa-mobile', 99, 1, NULL, 1, '2019-03-11 02:03:51'),
(18, 'GASTOS', 'FUNCIONALIDAD', '/gasto/', 'fa fa-usd', 3, 2, NULL, 1, '2019-03-17 00:10:52'),
(19, 'TIPO PRODUCTO', 'FUNCIONALIDAD', '/tipoproducto/', 'fa fa-check-circle-o ', 6, 2, NULL, 1, '2022-11-02 17:49:51'),
(20, 'GESTIONAR ESTADOS', 'FUNCIONALIDAD', '/estado/', 'fa fa-thumbs-up', 7, 2, NULL, 1, '2019-03-17 03:56:08'),
(21, 'GESTIONAR MESA', 'FUNCIONALIDAD', '/mesa/', 'fa fa-cutlery', 8, 2, NULL, 1, '2019-03-17 03:55:40'),
(22, 'GEST. PRODUCTOS', 'FUNCIONALIDAD', '/producto/', 'fa fa-product-hunt', 5, 2, NULL, 1, '2022-11-02 17:49:27'),
(23, 'DEPE. DE PRODUCTO', 'FUNCIONALIDAD', '/dependenciaproducto/', 'fa fa-refresh', 7, 2, NULL, 1, '2022-11-02 17:51:15'),
(25, 'CARGAR STOCK ', 'FUNCIONALIDAD', '/cargarstock/', 'fa fa-upload', 8, 2, NULL, 1, '2022-11-02 17:52:04'),
(26, 'LISTAR STOCK', 'FUNCIONALIDAD', '/listarstock/', 'fa fa-list-ol', 10, 2, NULL, 1, '2022-11-02 17:52:41'),
(27, 'GESTIONAR PEDIDO', 'FUNCIONALIDAD', '/pedido/', 'fa fa-cutlery', 1, 4, NULL, 1, '2019-03-24 17:33:26'),
(29, 'GASTOS DE HOY', 'FUNCIONALIDAD', '/gasto/', 'fa fa-usd', 3, 4, NULL, 1, '2019-03-21 20:21:53'),
(30, 'COPIA FACTURA', 'FUNCIONALIDAD', '/copiafactura/', 'fa fa-file-text-o', 4, 2, NULL, 1, '2022-11-02 17:46:19'),
(31, 'CIERRE DE CAJA', 'FUNCIONALIDAD', '/cierrecaja/', 'fa fa-dollar', 3, 2, NULL, 1, '2019-03-25 07:17:56'),
(32, 'PERSONA NATURAL', 'FUNCIONALIDAD', '/personanatural/', 'fa fa-user', 4, 1, NULL, 1, '2019-03-25 05:31:02'),
(33, 'CUENTAS USUARIO', 'FUNCIONALIDAD', '/cuentausuario/', 'fa fa-lock', 5, 1, NULL, 1, '2022-11-02 17:45:51'),
(35, 'ABRIR CAJA', 'FUNCIONALIDAD', '/openbox/', 'fa fa-dropbox', 0, 4, NULL, 1, '2022-11-02 17:55:08'),
(38, 'REPORTES', 'FUNCIONALIDAD', '/verreportes/', 'fa fa-file-excel-o', 99, 2, NULL, 1, '2022-11-02 17:53:21'),
(39, 'CONTROL FISCAL', 'FUNCIONALIDAD', '/controlfiscal/', 'fa fa-gavel', 3, 2, NULL, 1, '2019-07-29 11:31:13');

--
-- Disparadores `funcionalidad`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_funcionalidad` AFTER INSERT ON `funcionalidad` FOR EACH ROW INSERT INTO pinchetas_general._funcionalidad ( 
    func_id,
    func_descripcion,
    func_tipo,
    func_url,
    func_icono,
    func_orden,
    apli_id,
    func_idpadre,
    func_registradopor,
    func_fechacambio,
    operacion 
) 
VALUES ( 
    new.func_id,
    new.func_descripcion,
    new.func_tipo,
    new.func_url,
    new.func_icono,
    new.func_orden,
    new.apli_id,
    new.func_idpadre,
    new.func_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_funcionalidad` AFTER UPDATE ON `funcionalidad` FOR EACH ROW INSERT INTO pinchetas_general._funcionalidad ( 
    func_id,
    func_descripcion,
    func_tipo,
    func_url,
    func_icono,
    func_orden,
    apli_id,
    func_idpadre,
    func_registradopor,
    func_fechacambio,
    operacion 
) 
VALUES ( 
    new.func_id,
    new.func_descripcion,
    new.func_tipo,
    new.func_url,
    new.func_icono,
    new.func_orden,
    new.apli_id,
    new.func_idpadre,
    new.func_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresousuario`
--

CREATE TABLE `ingresousuario` (
  `inus_id` bigint(20) NOT NULL,
  `usua_id` bigint(20) NOT NULL,
  `inus_usuario` text COLLATE utf8_spanish_ci NOT NULL,
  `inus_clave` text COLLATE utf8_spanish_ci NOT NULL,
  `inus_return` text COLLATE utf8_spanish_ci NOT NULL,
  `inus_fechacambio` datetime NOT NULL,
  `inus_registradopor` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `ingresousuario`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_ingresousuario` AFTER INSERT ON `ingresousuario` FOR EACH ROW INSERT INTO pinchetas_general._ingresousuario ( 
    inus_id,
    usua_id,
    inus_usuario,
    inus_clave,
    inus_return,
    inus_fechacambio,
    inus_registradopor,
    operacion 
) 
VALUES ( 
    new.inus_id,
    new.usua_id,
    new.inus_usuario,
    new.inus_clave,
    new.inus_return,
    NOW(),
    new.inus_registradopor,
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_ingresousuario` AFTER UPDATE ON `ingresousuario` FOR EACH ROW INSERT INTO pinchetas_general._ingresousuario ( 
    inus_id,
    usua_id,
    inus_usuario,
    inus_clave,
    inus_return,
    inus_fechacambio,
    inus_registradopor,
    operacion 
) 
VALUES ( 
    new.inus_id,
    new.usua_id,
    new.inus_usuario,
    new.inus_clave,
    new.inus_return,
    NOW(),
    new.inus_registradopor,
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipio`
--

CREATE TABLE `municipio` (
  `muni_id` bigint(20) NOT NULL,
  `muni_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `muni_orden` bigint(20) DEFAULT NULL,
  `depa_id` bigint(20) NOT NULL,
  `muni_registradorpor` bigint(20) NOT NULL,
  `muni_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `municipio`
--

INSERT INTO `municipio` (`muni_id`, `muni_descripcion`, `muni_orden`, `depa_id`, `muni_registradorpor`, `muni_fechacambio`) VALUES
(1, 'El Encanto', 1, 1, 1, '2022-11-11 02:05:34'),
(2, 'La Chorrera', 2, 1, 1, '2022-11-11 02:05:34'),
(3, 'La Pedrera', 3, 1, 1, '2022-11-11 02:05:34'),
(4, 'La Victoria', 4, 1, 1, '2022-11-11 02:05:34'),
(5, 'Leticia', 5, 1, 1, '2022-11-11 02:05:34'),
(6, 'Miriti - Paraná', 6, 1, 1, '2022-11-11 02:05:34'),
(7, 'Puerto Alegría', 7, 1, 1, '2022-11-11 02:05:34'),
(8, 'Puerto Arica', 8, 1, 1, '2022-11-11 02:05:34'),
(9, 'Puerto Nariño', 9, 1, 1, '2022-11-11 02:05:34'),
(10, 'Puerto Santander', 10, 1, 1, '2022-11-11 02:05:34'),
(11, 'Tarapacá', 11, 1, 1, '2022-11-11 02:05:34'),
(12, 'Abejorral', 1, 2, 1, '2022-11-11 02:05:34'),
(13, 'Abriaquí', 2, 2, 1, '2022-11-11 02:05:34'),
(14, 'Alejandría', 3, 2, 1, '2022-11-11 02:05:34'),
(15, 'Amagá', 4, 2, 1, '2022-11-11 02:05:34'),
(16, 'Amalfi', 5, 2, 1, '2022-11-11 02:05:34'),
(17, 'Andes', 6, 2, 1, '2022-11-11 02:05:34'),
(18, 'Angelópolis', 7, 2, 1, '2022-11-11 02:05:34'),
(19, 'Angostura', 8, 2, 1, '2022-11-11 02:05:34'),
(20, 'Anorí', 9, 2, 1, '2022-11-11 02:05:34'),
(21, 'Anzá', 10, 2, 1, '2022-11-11 02:05:34'),
(22, 'Apartadó', 11, 2, 1, '2022-11-11 02:05:34'),
(23, 'Arboletes', 12, 2, 1, '2022-11-11 02:05:34'),
(24, 'Argelia', 13, 2, 1, '2022-11-11 02:05:34'),
(25, 'Armenia', 14, 2, 1, '2022-11-11 02:05:34'),
(26, 'Barbosa', 15, 2, 1, '2022-11-11 02:05:34'),
(27, 'Bello', 16, 2, 1, '2022-11-11 02:05:34'),
(28, 'Belmira', 17, 2, 1, '2022-11-11 02:05:34'),
(29, 'Betania', 18, 2, 1, '2022-11-11 02:05:34'),
(30, 'Betulia', 19, 2, 1, '2022-11-11 02:05:34'),
(31, 'Briceño', 20, 2, 1, '2022-11-11 02:05:34'),
(32, 'Buriticá', 21, 2, 1, '2022-11-11 02:05:34'),
(33, 'Cáceres', 22, 2, 1, '2022-11-11 02:05:34'),
(34, 'Caicedo', 23, 2, 1, '2022-11-11 02:05:34'),
(35, 'Caldas', 24, 2, 1, '2022-11-11 02:05:34'),
(36, 'Campamento', 25, 2, 1, '2022-11-11 02:05:34'),
(37, 'Caracolí', 26, 2, 1, '2022-11-11 02:05:34'),
(38, 'Caramanta', 27, 2, 1, '2022-11-11 02:05:34'),
(39, 'Carepa', 28, 2, 1, '2022-11-11 02:05:34'),
(40, 'Carolina', 29, 2, 1, '2022-11-11 02:05:34'),
(41, 'Caucasia', 30, 2, 1, '2022-11-11 02:05:34'),
(42, 'Cañasgordas', 31, 2, 1, '2022-11-11 02:05:34'),
(43, 'Chigorodó', 32, 2, 1, '2022-11-11 02:05:34'),
(44, 'Cisneros', 33, 2, 1, '2022-11-11 02:05:34'),
(45, 'Ciudad Bolivar', 34, 2, 1, '2022-11-11 02:05:34'),
(46, 'Cocorná', 35, 2, 1, '2022-11-11 02:05:34'),
(47, 'Concepción', 36, 2, 1, '2022-11-11 02:05:34'),
(48, 'Concordia', 37, 2, 1, '2022-11-11 02:05:34'),
(49, 'Copacabana', 38, 2, 1, '2022-11-11 02:05:34'),
(50, 'Dabeiba', 39, 2, 1, '2022-11-11 02:05:34'),
(51, 'Don Matías', 40, 2, 1, '2022-11-11 02:05:34'),
(52, 'Ebéjico', 41, 2, 1, '2022-11-11 02:05:34'),
(53, 'El Bagre', 42, 2, 1, '2022-11-11 02:05:34'),
(54, 'El Carmen de Viboral', 43, 2, 1, '2022-11-11 02:05:34'),
(55, 'El Santuario', 44, 2, 1, '2022-11-11 02:05:34'),
(56, 'Entrerrios', 45, 2, 1, '2022-11-11 02:05:34'),
(57, 'Envigado', 46, 2, 1, '2022-11-11 02:05:34'),
(58, 'Fredonia', 47, 2, 1, '2022-11-11 02:05:34'),
(59, 'Frontino', 48, 2, 1, '2022-11-11 02:05:34'),
(60, 'Giraldo', 49, 2, 1, '2022-11-11 02:05:34'),
(61, 'Girardota', 50, 2, 1, '2022-11-11 02:05:34'),
(62, 'Gómez Plata', 51, 2, 1, '2022-11-11 02:05:34'),
(63, 'Granada', 52, 2, 1, '2022-11-11 02:05:34'),
(64, 'Guadalupe', 53, 2, 1, '2022-11-11 02:05:34'),
(65, 'Guarne', 54, 2, 1, '2022-11-11 02:05:34'),
(66, 'Guatapé', 55, 2, 1, '2022-11-11 02:05:34'),
(67, 'Heliconia', 56, 2, 1, '2022-11-11 02:05:34'),
(68, 'Hispania', 57, 2, 1, '2022-11-11 02:05:34'),
(69, 'Itagüí', 58, 2, 1, '2022-11-11 02:05:34'),
(70, 'Ituango', 59, 2, 1, '2022-11-11 02:05:34'),
(71, 'Jardín', 60, 2, 1, '2022-11-11 02:05:34'),
(72, 'Jericó', 61, 2, 1, '2022-11-11 02:05:34'),
(73, 'La Ceja', 62, 2, 1, '2022-11-11 02:05:34'),
(74, 'La Estrella', 63, 2, 1, '2022-11-11 02:05:34'),
(75, 'La Pintada', 64, 2, 1, '2022-11-11 02:05:34'),
(76, 'La Unión', 65, 2, 1, '2022-11-11 02:05:34'),
(77, 'Liborina', 66, 2, 1, '2022-11-11 02:05:34'),
(78, 'Maceo', 67, 2, 1, '2022-11-11 02:05:34'),
(79, 'Marinilla', 68, 2, 1, '2022-11-11 02:05:34'),
(80, 'Medellín', 69, 2, 1, '2022-11-11 02:05:34'),
(81, 'Montebello', 70, 2, 1, '2022-11-11 02:05:34'),
(82, 'Murindó', 71, 2, 1, '2022-11-11 02:05:34'),
(83, 'Mutatá', 72, 2, 1, '2022-11-11 02:05:34'),
(84, 'Nariño', 73, 2, 1, '2022-11-11 02:05:34'),
(85, 'Nechí', 74, 2, 1, '2022-11-11 02:05:34'),
(86, 'Necoclí', 75, 2, 1, '2022-11-11 02:05:34'),
(87, 'Olaya', 76, 2, 1, '2022-11-11 02:05:34'),
(88, 'Peque', 77, 2, 1, '2022-11-11 02:05:34'),
(89, 'Peñol', 78, 2, 1, '2022-11-11 02:05:34'),
(90, 'Pueblorrico', 79, 2, 1, '2022-11-11 02:05:34'),
(91, 'Puerto Berrío', 80, 2, 1, '2022-11-11 02:05:34'),
(92, 'Puerto Nare', 81, 2, 1, '2022-11-11 02:05:34'),
(93, 'Puerto Triunfo', 82, 2, 1, '2022-11-11 02:05:34'),
(94, 'Remedios', 83, 2, 1, '2022-11-11 02:05:34'),
(95, 'Retiro', 84, 2, 1, '2022-11-11 02:05:34'),
(96, 'Rionegro', 85, 2, 1, '2022-11-11 02:05:34'),
(97, 'Sabanalarga', 86, 2, 1, '2022-11-11 02:05:34'),
(98, 'Sabaneta', 87, 2, 1, '2022-11-11 02:05:34'),
(99, 'Salgar', 88, 2, 1, '2022-11-11 02:05:34'),
(100, 'San Andres de Cuerquia', 89, 2, 1, '2022-11-11 02:05:34'),
(101, 'San Carlos', 90, 2, 1, '2022-11-11 02:05:34'),
(102, 'San Francisco', 91, 2, 1, '2022-11-11 02:05:34'),
(103, 'San Jerónimo', 92, 2, 1, '2022-11-11 02:05:34'),
(104, 'San José de la Montaña', 93, 2, 1, '2022-11-11 02:05:34'),
(105, 'San Juan de Urabá', 94, 2, 1, '2022-11-11 02:05:34'),
(106, 'San Luis', 95, 2, 1, '2022-11-11 02:05:34'),
(107, 'San Pedro', 96, 2, 1, '2022-11-11 02:05:34'),
(108, 'San Pedro de Urabá', 97, 2, 1, '2022-11-11 02:05:34'),
(109, 'San Rafael', 98, 2, 1, '2022-11-11 02:05:34'),
(110, 'San Roque', 99, 2, 1, '2022-11-11 02:05:34'),
(111, 'Santa Bárbara', 100, 2, 1, '2022-11-11 02:05:34'),
(112, 'Santafé de Antioquia', 101, 2, 1, '2022-11-11 02:05:34'),
(113, 'Santa Rosa de Osos', 102, 2, 1, '2022-11-11 02:05:34'),
(114, 'Santo Domingo', 103, 2, 1, '2022-11-11 02:05:34'),
(115, 'San Vicente', 104, 2, 1, '2022-11-11 02:05:34'),
(116, 'Segovia', 105, 2, 1, '2022-11-11 02:05:34'),
(117, 'Sonsón', 106, 2, 1, '2022-11-11 02:05:34'),
(118, 'Sopetrán', 107, 2, 1, '2022-11-11 02:05:34'),
(119, 'Támesis', 108, 2, 1, '2022-11-11 02:05:34'),
(120, 'Tarazá', 109, 2, 1, '2022-11-11 02:05:34'),
(121, 'Tarso', 110, 2, 1, '2022-11-11 02:05:34'),
(122, 'Titiribí', 111, 2, 1, '2022-11-11 02:05:34'),
(123, 'Toledo', 112, 2, 1, '2022-11-11 02:05:34'),
(124, 'Turbo', 113, 2, 1, '2022-11-11 02:05:34'),
(125, 'Uramita', 114, 2, 1, '2022-11-11 02:05:34'),
(126, 'Urrao', 115, 2, 1, '2022-11-11 02:05:34'),
(127, 'Valdivia', 116, 2, 1, '2022-11-11 02:05:34'),
(128, 'Valparaíso', 117, 2, 1, '2022-11-11 02:05:34'),
(129, 'Vegachí', 118, 2, 1, '2022-11-11 02:05:34'),
(130, 'Venecia', 119, 2, 1, '2022-11-11 02:05:34'),
(131, 'Vigía del Fuerte', 120, 2, 1, '2022-11-11 02:05:34'),
(132, 'Yalí', 121, 2, 1, '2022-11-11 02:05:34'),
(133, 'Yarumal', 122, 2, 1, '2022-11-11 02:05:34'),
(134, 'Yolombó', 123, 2, 1, '2022-11-11 02:05:34'),
(135, 'Yondó', 124, 2, 1, '2022-11-11 02:05:34'),
(136, 'Zaragoza', 125, 2, 1, '2022-11-11 02:05:34'),
(137, 'Arauca', 1, 3, 1, '2022-11-11 02:05:34'),
(138, 'Arauquita', 2, 3, 1, '2022-11-11 02:05:34'),
(139, 'Cravo Norte', 3, 3, 1, '2022-11-11 02:05:34'),
(140, 'Fortul', 4, 3, 1, '2022-11-11 02:05:34'),
(141, 'Puerto Rondón', 5, 3, 1, '2022-11-11 02:05:34'),
(142, 'Saravena', 6, 3, 1, '2022-11-11 02:05:34'),
(143, 'Tame', 7, 3, 1, '2022-11-11 02:05:34'),
(144, 'Baranoa', 1, 4, 1, '2022-11-11 02:05:34'),
(145, 'Barranquilla', 2, 4, 1, '2022-11-11 02:05:34'),
(146, 'Campo de la Cruz', 3, 4, 1, '2022-11-11 02:05:34'),
(147, 'Candelaria', 4, 4, 1, '2022-11-11 02:05:34'),
(148, 'Galapa', 5, 4, 1, '2022-11-11 02:05:34'),
(149, 'Juan de Acosta', 6, 4, 1, '2022-11-11 02:05:34'),
(150, 'Luruaco', 7, 4, 1, '2022-11-11 02:05:34'),
(151, 'Malambo', 8, 4, 1, '2022-11-11 02:05:34'),
(152, 'Manatí', 9, 4, 1, '2022-11-11 02:05:34'),
(153, 'Palmar de Varela', 10, 4, 1, '2022-11-11 02:05:34'),
(154, 'Piojó', 11, 4, 1, '2022-11-11 02:05:34'),
(155, 'Polonuevo', 12, 4, 1, '2022-11-11 02:05:34'),
(156, 'Ponedera', 13, 4, 1, '2022-11-11 02:05:34'),
(157, 'Puerto Colombia', 14, 4, 1, '2022-11-11 02:05:34'),
(158, 'Repelón', 15, 4, 1, '2022-11-11 02:05:34'),
(159, 'Sabanagrande', 16, 4, 1, '2022-11-11 02:05:34'),
(160, 'Sabanalarga', 17, 4, 1, '2022-11-11 02:05:34'),
(161, 'Santa Lucía', 18, 4, 1, '2022-11-11 02:05:34'),
(162, 'Santo Tomás', 19, 4, 1, '2022-11-11 02:05:34'),
(163, 'Soledad', 20, 4, 1, '2022-11-11 02:05:34'),
(164, 'Suan', 21, 4, 1, '2022-11-11 02:05:34'),
(165, 'Tubará', 22, 4, 1, '2022-11-11 02:05:34'),
(166, 'Usiacurí', 23, 4, 1, '2022-11-11 02:05:34'),
(167, 'Bogotá, D.C.', 1, 5, 1, '2022-11-11 02:05:34'),
(168, 'Achí', 1, 6, 1, '2022-11-11 02:05:34'),
(169, 'Altos del Rosario', 2, 6, 1, '2022-11-11 02:05:34'),
(170, 'Arenal', 3, 6, 1, '2022-11-11 02:05:34'),
(171, 'Arjona', 4, 6, 1, '2022-11-11 02:05:34'),
(172, 'Arroyohondo', 5, 6, 1, '2022-11-11 02:05:34'),
(173, 'Barranco de Loba', 6, 6, 1, '2022-11-11 02:05:34'),
(174, 'Calamar', 7, 6, 1, '2022-11-11 02:05:34'),
(175, 'Cantagallo', 8, 6, 1, '2022-11-11 02:05:34'),
(176, 'Cartagena de Indias', 9, 6, 1, '2022-11-11 02:05:34'),
(177, 'Cicuco', 10, 6, 1, '2022-11-11 02:05:34'),
(178, 'Clemencia', 11, 6, 1, '2022-11-11 02:05:34'),
(179, 'Córdoba', 12, 6, 1, '2022-11-11 02:05:34'),
(180, 'El Carmen de Bolívar', 13, 6, 1, '2022-11-11 02:05:34'),
(181, 'El Guamo', 14, 6, 1, '2022-11-11 02:05:34'),
(182, 'El Peñón', 15, 6, 1, '2022-11-11 02:05:34'),
(183, 'Hatillo de Loba', 16, 6, 1, '2022-11-11 02:05:34'),
(184, 'Magangué', 17, 6, 1, '2022-11-11 02:05:34'),
(185, 'Mahates', 18, 6, 1, '2022-11-11 02:05:34'),
(186, 'Margarita', 19, 6, 1, '2022-11-11 02:05:34'),
(187, 'María la Baja', 20, 6, 1, '2022-11-11 02:05:34'),
(188, 'Mompós', 21, 6, 1, '2022-11-11 02:05:34'),
(189, 'Montecristo', 22, 6, 1, '2022-11-11 02:05:34'),
(190, 'Morales', 23, 6, 1, '2022-11-11 02:05:34'),
(191, 'Norosí', 24, 6, 1, '2022-11-11 02:05:34'),
(192, 'Pinillos', 25, 6, 1, '2022-11-11 02:05:34'),
(193, 'Regidor', 26, 6, 1, '2022-11-11 02:05:34'),
(194, 'Río Viejo', 27, 6, 1, '2022-11-11 02:05:34'),
(195, 'San Cristóbal', 28, 6, 1, '2022-11-11 02:05:34'),
(196, 'San Estanislao', 29, 6, 1, '2022-11-11 02:05:34'),
(197, 'San Fernando', 30, 6, 1, '2022-11-11 02:05:34'),
(198, 'San Jacinto', 31, 6, 1, '2022-11-11 02:05:34'),
(199, 'San Jacinto del Cauca', 32, 6, 1, '2022-11-11 02:05:34'),
(200, 'San Juan Nepomuceno', 33, 6, 1, '2022-11-11 02:05:34'),
(201, 'San Martin de Loba', 34, 6, 1, '2022-11-11 02:05:34'),
(202, 'San Pablo', 35, 6, 1, '2022-11-11 02:05:34'),
(203, 'Santa Catalina', 36, 6, 1, '2022-11-11 02:05:34'),
(204, 'Santa Rosa', 37, 6, 1, '2022-11-11 02:05:34'),
(205, 'Santa Rosa del Sur', 38, 6, 1, '2022-11-11 02:05:34'),
(206, 'Simití', 39, 6, 1, '2022-11-11 02:05:34'),
(207, 'Soplaviento', 40, 6, 1, '2022-11-11 02:05:34'),
(208, 'Talaigua Nuevo', 41, 6, 1, '2022-11-11 02:05:34'),
(209, 'Tiquisio', 42, 6, 1, '2022-11-11 02:05:34'),
(210, 'Turbaco', 43, 6, 1, '2022-11-11 02:05:34'),
(211, 'Turbana', 44, 6, 1, '2022-11-11 02:05:34'),
(212, 'Villanueva', 45, 6, 1, '2022-11-11 02:05:34'),
(213, 'Zambrano', 46, 6, 1, '2022-11-11 02:05:34'),
(214, 'Almeida', 1, 7, 1, '2022-11-11 02:05:34'),
(215, 'Aquitania', 2, 7, 1, '2022-11-11 02:05:34'),
(216, 'Arcabuco', 3, 7, 1, '2022-11-11 02:05:34'),
(217, 'Belén', 4, 7, 1, '2022-11-11 02:05:34'),
(218, 'Berbeo', 5, 7, 1, '2022-11-11 02:05:34'),
(219, 'Betéitiva', 6, 7, 1, '2022-11-11 02:05:34'),
(220, 'Boavita', 7, 7, 1, '2022-11-11 02:05:34'),
(221, 'Boyacá', 8, 7, 1, '2022-11-11 02:05:34'),
(222, 'Briceño', 9, 7, 1, '2022-11-11 02:05:34'),
(223, 'Buenavista', 10, 7, 1, '2022-11-11 02:05:34'),
(224, 'Busbanzá', 11, 7, 1, '2022-11-11 02:05:34'),
(225, 'Caldas', 12, 7, 1, '2022-11-11 02:05:34'),
(226, 'Campohermoso', 13, 7, 1, '2022-11-11 02:05:34'),
(227, 'Cerinza', 14, 7, 1, '2022-11-11 02:05:34'),
(228, 'Chinavita', 15, 7, 1, '2022-11-11 02:05:34'),
(229, 'Chiquinquirá', 16, 7, 1, '2022-11-11 02:05:34'),
(230, 'Chíquiza', 17, 7, 1, '2022-11-11 02:05:34'),
(231, 'Chiscas', 18, 7, 1, '2022-11-11 02:05:34'),
(232, 'Chita', 19, 7, 1, '2022-11-11 02:05:34'),
(233, 'Chitaraque', 20, 7, 1, '2022-11-11 02:05:34'),
(234, 'Chivatá', 21, 7, 1, '2022-11-11 02:05:34'),
(235, 'Chivor', 22, 7, 1, '2022-11-11 02:05:34'),
(236, 'Ciénega', 23, 7, 1, '2022-11-11 02:05:34'),
(237, 'Cómbita', 24, 7, 1, '2022-11-11 02:05:34'),
(238, 'Coper', 25, 7, 1, '2022-11-11 02:05:34'),
(239, 'Corrales', 26, 7, 1, '2022-11-11 02:05:34'),
(240, 'Covarachía', 27, 7, 1, '2022-11-11 02:05:34'),
(241, 'Cubará', 28, 7, 1, '2022-11-11 02:05:34'),
(242, 'Cucaita', 29, 7, 1, '2022-11-11 02:05:34'),
(243, 'Cuítiva', 30, 7, 1, '2022-11-11 02:05:34'),
(244, 'Duitama', 31, 7, 1, '2022-11-11 02:05:34'),
(245, 'El Cocuy', 32, 7, 1, '2022-11-11 02:05:34'),
(246, 'El Espino', 33, 7, 1, '2022-11-11 02:05:34'),
(247, 'Firavitoba', 34, 7, 1, '2022-11-11 02:05:34'),
(248, 'Floresta', 35, 7, 1, '2022-11-11 02:05:34'),
(249, 'Gachantivá', 36, 7, 1, '2022-11-11 02:05:34'),
(250, 'Gameza', 37, 7, 1, '2022-11-11 02:05:34'),
(251, 'Garagoa', 38, 7, 1, '2022-11-11 02:05:34'),
(252, 'Guacamayas', 39, 7, 1, '2022-11-11 02:05:34'),
(253, 'Guateque', 40, 7, 1, '2022-11-11 02:05:34'),
(254, 'Guayatá', 41, 7, 1, '2022-11-11 02:05:34'),
(255, 'Güicán', 42, 7, 1, '2022-11-11 02:05:34'),
(256, 'Iza', 43, 7, 1, '2022-11-11 02:05:34'),
(257, 'Jenesano', 44, 7, 1, '2022-11-11 02:05:34'),
(258, 'Jericó', 45, 7, 1, '2022-11-11 02:05:34'),
(259, 'Labranzagrande', 46, 7, 1, '2022-11-11 02:05:34'),
(260, 'La Capilla', 47, 7, 1, '2022-11-11 02:05:34'),
(261, 'La Uvita', 48, 7, 1, '2022-11-11 02:05:34'),
(262, 'La Victoria', 49, 7, 1, '2022-11-11 02:05:34'),
(263, 'Macanal', 50, 7, 1, '2022-11-11 02:05:34'),
(264, 'Maripí', 51, 7, 1, '2022-11-11 02:05:34'),
(265, 'Miraflores', 52, 7, 1, '2022-11-11 02:05:34'),
(266, 'Mongua', 53, 7, 1, '2022-11-11 02:05:34'),
(267, 'Monguí', 54, 7, 1, '2022-11-11 02:05:34'),
(268, 'Moniquirá', 55, 7, 1, '2022-11-11 02:05:34'),
(269, 'Motavita', 56, 7, 1, '2022-11-11 02:05:34'),
(270, 'Muzo', 57, 7, 1, '2022-11-11 02:05:34'),
(271, 'Nobsa', 58, 7, 1, '2022-11-11 02:05:34'),
(272, 'Nuevo Colón', 59, 7, 1, '2022-11-11 02:05:34'),
(273, 'Oicatá', 60, 7, 1, '2022-11-11 02:05:34'),
(274, 'Otanche', 61, 7, 1, '2022-11-11 02:05:34'),
(275, 'Pachavita', 62, 7, 1, '2022-11-11 02:05:34'),
(276, 'Páez', 63, 7, 1, '2022-11-11 02:05:34'),
(277, 'Paipa', 64, 7, 1, '2022-11-11 02:05:34'),
(278, 'Pajarito', 65, 7, 1, '2022-11-11 02:05:34'),
(279, 'Panqueba', 66, 7, 1, '2022-11-11 02:05:34'),
(280, 'Pauna', 67, 7, 1, '2022-11-11 02:05:34'),
(281, 'Paya', 68, 7, 1, '2022-11-11 02:05:34'),
(282, 'Paz de Río', 69, 7, 1, '2022-11-11 02:05:34'),
(283, 'Pesca', 70, 7, 1, '2022-11-11 02:05:34'),
(284, 'Pisba', 71, 7, 1, '2022-11-11 02:05:34'),
(285, 'Puerto Boyacá', 72, 7, 1, '2022-11-11 02:05:34'),
(286, 'Quípama', 73, 7, 1, '2022-11-11 02:05:34'),
(287, 'Ramiriquí', 74, 7, 1, '2022-11-11 02:05:34'),
(288, 'Ráquira', 75, 7, 1, '2022-11-11 02:05:34'),
(289, 'Rondón', 76, 7, 1, '2022-11-11 02:05:34'),
(290, 'Saboyá', 77, 7, 1, '2022-11-11 02:05:34'),
(291, 'Sáchica', 78, 7, 1, '2022-11-11 02:05:34'),
(292, 'Samacá', 79, 7, 1, '2022-11-11 02:05:34'),
(293, 'San Eduardo', 80, 7, 1, '2022-11-11 02:05:34'),
(294, 'San José de Pare', 81, 7, 1, '2022-11-11 02:05:34'),
(295, 'San Luis de Gaceno', 82, 7, 1, '2022-11-11 02:05:34'),
(296, 'San Mateo', 83, 7, 1, '2022-11-11 02:05:34'),
(297, 'San Miguel de Sema', 84, 7, 1, '2022-11-11 02:05:34'),
(298, 'San Pablo de Borbur', 85, 7, 1, '2022-11-11 02:05:34'),
(299, 'Santa María', 86, 7, 1, '2022-11-11 02:05:34'),
(300, 'Santana', 87, 7, 1, '2022-11-11 02:05:34'),
(301, 'Santa Rosa de Viterbo', 88, 7, 1, '2022-11-11 02:05:34'),
(302, 'Santa Sofía', 89, 7, 1, '2022-11-11 02:05:34'),
(303, 'Sativanorte', 90, 7, 1, '2022-11-11 02:05:34'),
(304, 'Sativasur', 91, 7, 1, '2022-11-11 02:05:34'),
(305, 'Siachoque', 92, 7, 1, '2022-11-11 02:05:34'),
(306, 'Soatá', 93, 7, 1, '2022-11-11 02:05:34'),
(307, 'Socha', 94, 7, 1, '2022-11-11 02:05:34'),
(308, 'Socotá', 95, 7, 1, '2022-11-11 02:05:34'),
(309, 'Sogamoso', 96, 7, 1, '2022-11-11 02:05:34'),
(310, 'Somondoco', 97, 7, 1, '2022-11-11 02:05:34'),
(311, 'Sora', 98, 7, 1, '2022-11-11 02:05:34'),
(312, 'Soracá', 99, 7, 1, '2022-11-11 02:05:34'),
(313, 'Sotaquirá', 100, 7, 1, '2022-11-11 02:05:34'),
(314, 'Susacón', 101, 7, 1, '2022-11-11 02:05:34'),
(315, 'Sutamarchán', 102, 7, 1, '2022-11-11 02:05:34'),
(316, 'Sutatenza', 103, 7, 1, '2022-11-11 02:05:34'),
(317, 'Tasco', 104, 7, 1, '2022-11-11 02:05:34'),
(318, 'Tenza', 105, 7, 1, '2022-11-11 02:05:34'),
(319, 'Tibaná', 106, 7, 1, '2022-11-11 02:05:34'),
(320, 'Tibasosa', 107, 7, 1, '2022-11-11 02:05:34'),
(321, 'Tinjacá', 108, 7, 1, '2022-11-11 02:05:34'),
(322, 'Tipacoque', 109, 7, 1, '2022-11-11 02:05:34'),
(323, 'Toca', 110, 7, 1, '2022-11-11 02:05:34'),
(324, 'Togüí', 111, 7, 1, '2022-11-11 02:05:34'),
(325, 'Tópaga', 112, 7, 1, '2022-11-11 02:05:34'),
(326, 'Tota', 113, 7, 1, '2022-11-11 02:05:34'),
(327, 'Tunja', 114, 7, 1, '2022-11-11 02:05:34'),
(328, 'Tununguá', 115, 7, 1, '2022-11-11 02:05:34'),
(329, 'Turmequé', 116, 7, 1, '2022-11-11 02:05:34'),
(330, 'Tuta', 117, 7, 1, '2022-11-11 02:05:34'),
(331, 'Tutazá', 118, 7, 1, '2022-11-11 02:05:34'),
(332, 'Úmbita', 119, 7, 1, '2022-11-11 02:05:34'),
(333, 'Ventaquemada', 120, 7, 1, '2022-11-11 02:05:34'),
(334, 'Villa de Leyva', 121, 7, 1, '2022-11-11 02:05:34'),
(335, 'Viracacha', 122, 7, 1, '2022-11-11 02:05:34'),
(336, 'Zetaquira', 123, 7, 1, '2022-11-11 02:05:34'),
(337, 'Aguadas', 1, 8, 1, '2022-11-11 02:05:34'),
(338, 'Anserma', 2, 8, 1, '2022-11-11 02:05:34'),
(339, 'Aranzazu', 3, 8, 1, '2022-11-11 02:05:34'),
(340, 'Belalcázar', 4, 8, 1, '2022-11-11 02:05:34'),
(341, 'Chinchiná', 5, 8, 1, '2022-11-11 02:05:34'),
(342, 'Filadelfia', 6, 8, 1, '2022-11-11 02:05:34'),
(343, 'La Dorada', 7, 8, 1, '2022-11-11 02:05:34'),
(344, 'La Merced', 8, 8, 1, '2022-11-11 02:05:34'),
(345, 'Manizales', 9, 8, 1, '2022-11-11 02:05:34'),
(346, 'Manzanares', 10, 8, 1, '2022-11-11 02:05:34'),
(347, 'Marmato', 11, 8, 1, '2022-11-11 02:05:34'),
(348, 'Marquetalia', 12, 8, 1, '2022-11-11 02:05:34'),
(349, 'Marulanda', 13, 8, 1, '2022-11-11 02:05:34'),
(350, 'Neira', 14, 8, 1, '2022-11-11 02:05:34'),
(351, 'Norcasia', 15, 8, 1, '2022-11-11 02:05:34'),
(352, 'Pácora', 16, 8, 1, '2022-11-11 02:05:34'),
(353, 'Palestina', 17, 8, 1, '2022-11-11 02:05:34'),
(354, 'Pensilvania', 18, 8, 1, '2022-11-11 02:05:34'),
(355, 'Riosucio', 19, 8, 1, '2022-11-11 02:05:34'),
(356, 'Risaralda', 20, 8, 1, '2022-11-11 02:05:34'),
(357, 'Salamina', 21, 8, 1, '2022-11-11 02:05:34'),
(358, 'Samaná', 22, 8, 1, '2022-11-11 02:05:34'),
(359, 'San José', 23, 8, 1, '2022-11-11 02:05:34'),
(360, 'Supía', 24, 8, 1, '2022-11-11 02:05:34'),
(361, 'Victoria', 25, 8, 1, '2022-11-11 02:05:34'),
(362, 'Villamaría', 26, 8, 1, '2022-11-11 02:05:34'),
(363, 'Viterbo', 27, 8, 1, '2022-11-11 02:05:34'),
(364, 'Albania', 1, 9, 1, '2022-11-11 02:05:34'),
(365, 'Belén de los Andaquíes', 2, 9, 1, '2022-11-11 02:05:34'),
(366, 'Cartagena del Chairá', 3, 9, 1, '2022-11-11 02:05:34'),
(367, 'Curillo', 4, 9, 1, '2022-11-11 02:05:34'),
(368, 'El Doncello', 5, 9, 1, '2022-11-11 02:05:34'),
(369, 'El Paujil', 6, 9, 1, '2022-11-11 02:05:34'),
(370, 'Florencia', 7, 9, 1, '2022-11-11 02:05:34'),
(371, 'La Montañita', 8, 9, 1, '2022-11-11 02:05:34'),
(372, 'Milán', 9, 9, 1, '2022-11-11 02:05:34'),
(373, 'Morelia', 10, 9, 1, '2022-11-11 02:05:34'),
(374, 'Puerto Rico', 11, 9, 1, '2022-11-11 02:05:34'),
(375, 'San Jose del Fragua', 12, 9, 1, '2022-11-11 02:05:34'),
(376, 'San Vicente del Caguán', 13, 9, 1, '2022-11-11 02:05:34'),
(377, 'Solano', 14, 9, 1, '2022-11-11 02:05:34'),
(378, 'Solita', 15, 9, 1, '2022-11-11 02:05:34'),
(379, 'Valparaíso', 16, 9, 1, '2022-11-11 02:05:34'),
(380, 'Aguazul', 1, 10, 1, '2022-11-11 02:05:34'),
(381, 'Chameza', 2, 10, 1, '2022-11-11 02:05:34'),
(382, 'Hato Corozal', 3, 10, 1, '2022-11-11 02:05:34'),
(383, 'La Salina', 4, 10, 1, '2022-11-11 02:05:34'),
(384, 'Maní', 5, 10, 1, '2022-11-11 02:05:34'),
(385, 'Monterrey', 6, 10, 1, '2022-11-11 02:05:34'),
(386, 'Nunchía', 7, 10, 1, '2022-11-11 02:05:34'),
(387, 'Orocué', 8, 10, 1, '2022-11-11 02:05:34'),
(388, 'Paz de Ariporo', 9, 10, 1, '2022-11-11 02:05:34'),
(389, 'Pore', 10, 10, 1, '2022-11-11 02:05:34'),
(390, 'Recetor', 11, 10, 1, '2022-11-11 02:05:34'),
(391, 'Sabanalarga', 12, 10, 1, '2022-11-11 02:05:34'),
(392, 'Sácama', 13, 10, 1, '2022-11-11 02:05:34'),
(393, 'San Luis de Palenque', 14, 10, 1, '2022-11-11 02:05:34'),
(394, 'Támara', 15, 10, 1, '2022-11-11 02:05:34'),
(395, 'Tauramena', 16, 10, 1, '2022-11-11 02:05:34'),
(396, 'Trinidad', 17, 10, 1, '2022-11-11 02:05:34'),
(397, 'Villanueva', 18, 10, 1, '2022-11-11 02:05:34'),
(398, 'Yopal', 19, 10, 1, '2022-11-11 02:05:34'),
(399, 'Almaguer', 1, 11, 1, '2022-11-11 02:05:34'),
(400, 'Argelia', 2, 11, 1, '2022-11-11 02:05:34'),
(401, 'Balboa', 3, 11, 1, '2022-11-11 02:05:34'),
(402, 'Bolivar', 4, 11, 1, '2022-11-11 02:05:34'),
(403, 'Buenos Aires', 5, 11, 1, '2022-11-11 02:05:34'),
(404, 'Cajibío', 6, 11, 1, '2022-11-11 02:05:34'),
(405, 'Caldono', 7, 11, 1, '2022-11-11 02:05:34'),
(406, 'Caloto', 8, 11, 1, '2022-11-11 02:05:34'),
(407, 'Corinto', 9, 11, 1, '2022-11-11 02:05:34'),
(408, 'El Tambo', 10, 11, 1, '2022-11-11 02:05:34'),
(409, 'Florencia', 11, 11, 1, '2022-11-11 02:05:34'),
(410, 'Guachené', 12, 11, 1, '2022-11-11 02:05:34'),
(411, 'Guapi', 13, 11, 1, '2022-11-11 02:05:34'),
(412, 'Inzá', 14, 11, 1, '2022-11-11 02:05:34'),
(413, 'Jambaló', 15, 11, 1, '2022-11-11 02:05:34'),
(414, 'La Sierra', 16, 11, 1, '2022-11-11 02:05:34'),
(415, 'La Vega', 17, 11, 1, '2022-11-11 02:05:34'),
(416, 'López', 18, 11, 1, '2022-11-11 02:05:34'),
(417, 'Mercaderes', 19, 11, 1, '2022-11-11 02:05:34'),
(418, 'Miranda', 20, 11, 1, '2022-11-11 02:05:34'),
(419, 'Morales', 21, 11, 1, '2022-11-11 02:05:34'),
(420, 'Padilla', 22, 11, 1, '2022-11-11 02:05:34'),
(421, 'Páez', 23, 11, 1, '2022-11-11 02:05:34'),
(422, 'Patía', 24, 11, 1, '2022-11-11 02:05:34'),
(423, 'Piamonte', 25, 11, 1, '2022-11-11 02:05:34'),
(424, 'Piendamó', 26, 11, 1, '2022-11-11 02:05:34'),
(425, 'Popayán', 27, 11, 1, '2022-11-11 02:05:34'),
(426, 'Puerto Tejada', 28, 11, 1, '2022-11-11 02:05:34'),
(427, 'Puracé', 29, 11, 1, '2022-11-11 02:05:34'),
(428, 'Rosas', 30, 11, 1, '2022-11-11 02:05:34'),
(429, 'San Sebastián', 31, 11, 1, '2022-11-11 02:05:34'),
(430, 'Santander de Quilichao', 32, 11, 1, '2022-11-11 02:05:34'),
(431, 'Santa Rosa', 33, 11, 1, '2022-11-11 02:05:34'),
(432, 'Silvia', 34, 11, 1, '2022-11-11 02:05:34'),
(433, 'Sotará', 35, 11, 1, '2022-11-11 02:05:34'),
(434, 'Suárez', 36, 11, 1, '2022-11-11 02:05:34'),
(435, 'Sucre', 37, 11, 1, '2022-11-11 02:05:34'),
(436, 'Timbío', 38, 11, 1, '2022-11-11 02:05:34'),
(437, 'Timbiquí', 39, 11, 1, '2022-11-11 02:05:34'),
(438, 'Toribío', 40, 11, 1, '2022-11-11 02:05:34'),
(439, 'Totoró', 41, 11, 1, '2022-11-11 02:05:34'),
(440, 'Villa Rica', 42, 11, 1, '2022-11-11 02:05:34'),
(441, 'Aguachica', 1, 12, 1, '2022-11-11 02:05:34'),
(442, 'Agustín Codazzi', 2, 12, 1, '2022-11-11 02:05:34'),
(443, 'Astrea', 3, 12, 1, '2022-11-11 02:05:34'),
(444, 'Becerril', 4, 12, 1, '2022-11-11 02:05:34'),
(445, 'Bosconia', 5, 12, 1, '2022-11-11 02:05:34'),
(446, 'Chimichagua', 6, 12, 1, '2022-11-11 02:05:34'),
(447, 'Chiriguaná', 7, 12, 1, '2022-11-11 02:05:34'),
(448, 'Curumaní', 8, 12, 1, '2022-11-11 02:05:34'),
(449, 'El Copey', 9, 12, 1, '2022-11-11 02:05:34'),
(450, 'El Paso', 10, 12, 1, '2022-11-11 02:05:34'),
(451, 'Gamarra', 11, 12, 1, '2022-11-11 02:05:34'),
(452, 'González', 12, 12, 1, '2022-11-11 02:05:34'),
(453, 'La Gloria', 13, 12, 1, '2022-11-11 02:05:34'),
(454, 'La Jagua de Ibirico', 14, 12, 1, '2022-11-11 02:05:34'),
(455, 'La Paz', 15, 12, 1, '2022-11-11 02:05:34'),
(456, 'Manaure', 16, 12, 1, '2022-11-11 02:05:34'),
(457, 'Pailitas', 17, 12, 1, '2022-11-11 02:05:34'),
(458, 'Pelaya', 18, 12, 1, '2022-11-11 02:05:34'),
(459, 'Pueblo Bello', 19, 12, 1, '2022-11-11 02:05:34'),
(460, 'Río de Oro', 20, 12, 1, '2022-11-11 02:05:34'),
(461, 'San Alberto', 21, 12, 1, '2022-11-11 02:05:34'),
(462, 'San Diego', 22, 12, 1, '2022-11-11 02:05:34'),
(463, 'San Martín', 23, 12, 1, '2022-11-11 02:05:34'),
(464, 'Tamalameque', 24, 12, 1, '2022-11-11 02:05:34'),
(465, 'Valledupar', 25, 12, 1, '2022-11-11 02:05:34'),
(466, 'Acandí', 1, 13, 1, '2022-11-11 02:05:34'),
(467, 'Alto Baudó', 2, 13, 1, '2022-11-11 02:05:34'),
(468, 'Atrato', 3, 13, 1, '2022-11-11 02:05:34'),
(469, 'Bagadó', 4, 13, 1, '2022-11-11 02:05:34'),
(470, 'Bahía Solano', 5, 13, 1, '2022-11-11 02:05:34'),
(471, 'Bajo Baudó', 6, 13, 1, '2022-11-11 02:05:34'),
(472, 'Belén de Bajirá', 7, 13, 1, '2022-11-11 02:05:34'),
(473, 'Bojayá', 8, 13, 1, '2022-11-11 02:05:34'),
(474, 'Carmen del Darién', 9, 13, 1, '2022-11-11 02:05:34'),
(475, 'Cértegui', 10, 13, 1, '2022-11-11 02:05:34'),
(476, 'Condoto', 11, 13, 1, '2022-11-11 02:05:34'),
(477, 'El Cantón del San Pablo', 12, 13, 1, '2022-11-11 02:05:34'),
(478, 'El Carmen de Atrato', 13, 13, 1, '2022-11-11 02:05:34'),
(479, 'El Litoral del San Juan', 14, 13, 1, '2022-11-11 02:05:34'),
(480, 'Istmina', 15, 13, 1, '2022-11-11 02:05:34'),
(481, 'Juradó', 16, 13, 1, '2022-11-11 02:05:34'),
(482, 'Lloró', 17, 13, 1, '2022-11-11 02:05:34'),
(483, 'Medio Atrato', 18, 13, 1, '2022-11-11 02:05:34'),
(484, 'Medio Baudó', 19, 13, 1, '2022-11-11 02:05:34'),
(485, 'Medio San Juan', 20, 13, 1, '2022-11-11 02:05:34'),
(486, 'Nóvita', 21, 13, 1, '2022-11-11 02:05:34'),
(487, 'Nuquí', 22, 13, 1, '2022-11-11 02:05:34'),
(488, 'Quibdó', 23, 13, 1, '2022-11-11 02:05:34'),
(489, 'Río Iró', 24, 13, 1, '2022-11-11 02:05:34'),
(490, 'Río Quito', 25, 13, 1, '2022-11-11 02:05:34'),
(491, 'Riosucio', 26, 13, 1, '2022-11-11 02:05:34'),
(492, 'San José del Palmar', 27, 13, 1, '2022-11-11 02:05:34'),
(493, 'Sipí', 28, 13, 1, '2022-11-11 02:05:34'),
(494, 'Tadó', 29, 13, 1, '2022-11-11 02:05:34'),
(495, 'Unguía', 30, 13, 1, '2022-11-11 02:05:34'),
(496, 'Unión Panamericana', 31, 13, 1, '2022-11-11 02:05:34'),
(497, 'Ayapel', 1, 14, 1, '2022-11-11 02:05:34'),
(498, 'Buenavista', 2, 14, 1, '2022-11-11 02:05:34'),
(499, 'Canalete', 3, 14, 1, '2022-11-11 02:05:34'),
(500, 'Cereté', 4, 14, 1, '2022-11-11 02:05:34'),
(501, 'Chimá', 5, 14, 1, '2022-11-11 02:05:34'),
(502, 'Chinú', 6, 14, 1, '2022-11-11 02:05:34'),
(503, 'Ciénaga de Oro', 7, 14, 1, '2022-11-11 02:05:34'),
(504, 'Cotorra', 8, 14, 1, '2022-11-11 02:05:34'),
(505, 'La Apartada', 9, 14, 1, '2022-11-11 02:05:34'),
(506, 'Lorica', 10, 14, 1, '2022-11-11 02:05:34'),
(507, 'Los Córdobas', 11, 14, 1, '2022-11-11 02:05:34'),
(508, 'Momil', 12, 14, 1, '2022-11-11 02:05:34'),
(509, 'Montelíbano', 13, 14, 1, '2022-11-11 02:05:34'),
(510, 'Montería', 14, 14, 1, '2022-11-11 02:05:34'),
(511, 'Moñitos', 15, 14, 1, '2022-11-11 02:05:34'),
(512, 'Planeta Rica', 16, 14, 1, '2022-11-11 02:05:34'),
(513, 'Pueblo Nuevo', 17, 14, 1, '2022-11-11 02:05:34'),
(514, 'Puerto Escondido', 18, 14, 1, '2022-11-11 02:05:34'),
(515, 'Puerto Libertador', 19, 14, 1, '2022-11-11 02:05:34'),
(516, 'Purísima', 20, 14, 1, '2022-11-11 02:05:34'),
(517, 'Sahagún', 21, 14, 1, '2022-11-11 02:05:34'),
(518, 'San Andrés Sotavento', 22, 14, 1, '2022-11-11 02:05:34'),
(519, 'San Antero', 23, 14, 1, '2022-11-11 02:05:34'),
(520, 'San Bernardo del Viento', 24, 14, 1, '2022-11-11 02:05:34'),
(521, 'San Carlos', 25, 14, 1, '2022-11-11 02:05:34'),
(522, 'San José de Uré', 26, 14, 1, '2022-11-11 02:05:34'),
(523, 'San Pelayo', 27, 14, 1, '2022-11-11 02:05:34'),
(524, 'Tierralta', 28, 14, 1, '2022-11-11 02:05:34'),
(525, 'Tuchín', 29, 14, 1, '2022-11-11 02:05:34'),
(526, 'Valencia', 30, 14, 1, '2022-11-11 02:05:34'),
(527, 'Agua de Dios', 1, 15, 1, '2022-11-11 02:05:34'),
(528, 'Albán', 2, 15, 1, '2022-11-11 02:05:34'),
(529, 'Anapoima', 3, 15, 1, '2022-11-11 02:05:34'),
(530, 'Anolaima', 4, 15, 1, '2022-11-11 02:05:34'),
(531, 'Apulo', 5, 15, 1, '2022-11-11 02:05:34'),
(532, 'Arbeláez', 6, 15, 1, '2022-11-11 02:05:34'),
(533, 'Beltrán', 7, 15, 1, '2022-11-11 02:05:34'),
(534, 'Bituima', 8, 15, 1, '2022-11-11 02:05:34'),
(535, 'Bojacá', 9, 15, 1, '2022-11-11 02:05:34'),
(536, 'Cabrera', 10, 15, 1, '2022-11-11 02:05:34'),
(537, 'Cachipay', 11, 15, 1, '2022-11-11 02:05:34'),
(538, 'Cajicá', 12, 15, 1, '2022-11-11 02:05:34'),
(539, 'Caparrapí', 13, 15, 1, '2022-11-11 02:05:34'),
(540, 'Cáqueza', 14, 15, 1, '2022-11-11 02:05:34'),
(541, 'Carmen de Carupa', 15, 15, 1, '2022-11-11 02:05:34'),
(542, 'Chaguaní', 16, 15, 1, '2022-11-11 02:05:34'),
(543, 'Chía', 17, 15, 1, '2022-11-11 02:05:34'),
(544, 'Chipaque', 18, 15, 1, '2022-11-11 02:05:34'),
(545, 'Choachí', 19, 15, 1, '2022-11-11 02:05:34'),
(546, 'Chocontá', 20, 15, 1, '2022-11-11 02:05:34'),
(547, 'Cogua', 21, 15, 1, '2022-11-11 02:05:34'),
(548, 'Cota', 22, 15, 1, '2022-11-11 02:05:34'),
(549, 'Cucunubá', 23, 15, 1, '2022-11-11 02:05:34'),
(550, 'El Colegio', 24, 15, 1, '2022-11-11 02:05:34'),
(551, 'El Peñón', 25, 15, 1, '2022-11-11 02:05:34'),
(552, 'El Rosal', 26, 15, 1, '2022-11-11 02:05:34'),
(553, 'Facatativá', 27, 15, 1, '2022-11-11 02:05:34'),
(554, 'Fómeque', 28, 15, 1, '2022-11-11 02:05:34'),
(555, 'Fosca', 29, 15, 1, '2022-11-11 02:05:34'),
(556, 'Funza', 30, 15, 1, '2022-11-11 02:05:34'),
(557, 'Fúquene', 31, 15, 1, '2022-11-11 02:05:34'),
(558, 'Fusagasugá', 32, 15, 1, '2022-11-11 02:05:34'),
(559, 'Gachala', 33, 15, 1, '2022-11-11 02:05:34'),
(560, 'Gachancipá', 34, 15, 1, '2022-11-11 02:05:34'),
(561, 'Gachetá', 35, 15, 1, '2022-11-11 02:05:34'),
(562, 'Gama', 36, 15, 1, '2022-11-11 02:05:34'),
(563, 'Girardot', 37, 15, 1, '2022-11-11 02:05:34'),
(564, 'Granada', 38, 15, 1, '2022-11-11 02:05:34'),
(565, 'Guachetá', 39, 15, 1, '2022-11-11 02:05:34'),
(566, 'Guaduas', 40, 15, 1, '2022-11-11 02:05:34'),
(567, 'Guasca', 41, 15, 1, '2022-11-11 02:05:34'),
(568, 'Guataquá', 42, 15, 1, '2022-11-11 02:05:34'),
(569, 'Guatavita', 43, 15, 1, '2022-11-11 02:05:34'),
(570, 'Guayabal de Siquima', 44, 15, 1, '2022-11-11 02:05:34'),
(571, 'Guayabetal', 45, 15, 1, '2022-11-11 02:05:34'),
(572, 'Gutiérrez', 46, 15, 1, '2022-11-11 02:05:34'),
(573, 'Jerusalén', 47, 15, 1, '2022-11-11 02:05:34'),
(574, 'Junín', 48, 15, 1, '2022-11-11 02:05:34'),
(575, 'La Calera', 49, 15, 1, '2022-11-11 02:05:34'),
(576, 'La Mesa', 50, 15, 1, '2022-11-11 02:05:34'),
(577, 'La Palma', 51, 15, 1, '2022-11-11 02:05:34'),
(578, 'La Peña', 52, 15, 1, '2022-11-11 02:05:34'),
(579, 'La Vega', 53, 15, 1, '2022-11-11 02:05:34'),
(580, 'Lenguazaque', 54, 15, 1, '2022-11-11 02:05:34'),
(581, 'Machetá', 55, 15, 1, '2022-11-11 02:05:34'),
(582, 'Madrid', 56, 15, 1, '2022-11-11 02:05:34'),
(583, 'Manta', 57, 15, 1, '2022-11-11 02:05:34'),
(584, 'Medina', 58, 15, 1, '2022-11-11 02:05:34'),
(585, 'Mosquera', 59, 15, 1, '2022-11-11 02:05:34'),
(586, 'Nariño', 60, 15, 1, '2022-11-11 02:05:34'),
(587, 'Nemocón', 61, 15, 1, '2022-11-11 02:05:34'),
(588, 'Nilo', 62, 15, 1, '2022-11-11 02:05:34'),
(589, 'Nimaima', 63, 15, 1, '2022-11-11 02:05:34'),
(590, 'Nocaima', 64, 15, 1, '2022-11-11 02:05:34'),
(591, 'Pacho', 65, 15, 1, '2022-11-11 02:05:34'),
(592, 'Paime', 66, 15, 1, '2022-11-11 02:05:34'),
(593, 'Pandi', 67, 15, 1, '2022-11-11 02:05:34'),
(594, 'Paratebueno', 68, 15, 1, '2022-11-11 02:05:34'),
(595, 'Pasca', 69, 15, 1, '2022-11-11 02:05:34'),
(596, 'Puerto Salgar', 70, 15, 1, '2022-11-11 02:05:34'),
(597, 'Pulí', 71, 15, 1, '2022-11-11 02:05:34'),
(598, 'Quebradanegra', 72, 15, 1, '2022-11-11 02:05:34'),
(599, 'Quetame', 73, 15, 1, '2022-11-11 02:05:34'),
(600, 'Quipile', 74, 15, 1, '2022-11-11 02:05:34'),
(601, 'Ricaurte', 75, 15, 1, '2022-11-11 02:05:34'),
(602, 'San Antonio del Tequendama', 76, 15, 1, '2022-11-11 02:05:34'),
(603, 'San Bernardo', 77, 15, 1, '2022-11-11 02:05:34'),
(604, 'San Cayetano', 78, 15, 1, '2022-11-11 02:05:34'),
(605, 'San Francisco', 79, 15, 1, '2022-11-11 02:05:34'),
(606, 'San Juan de Río Seco', 80, 15, 1, '2022-11-11 02:05:34'),
(607, 'Sasaima', 81, 15, 1, '2022-11-11 02:05:34'),
(608, 'Sesquilé', 82, 15, 1, '2022-11-11 02:05:34'),
(609, 'Sibaté', 83, 15, 1, '2022-11-11 02:05:34'),
(610, 'Silvania', 84, 15, 1, '2022-11-11 02:05:34'),
(611, 'Simijaca', 85, 15, 1, '2022-11-11 02:05:34'),
(612, 'Soacha', 86, 15, 1, '2022-11-11 02:05:34'),
(613, 'Sopó', 87, 15, 1, '2022-11-11 02:05:34'),
(614, 'Subachoque', 88, 15, 1, '2022-11-11 02:05:34'),
(615, 'Suesca', 89, 15, 1, '2022-11-11 02:05:34'),
(616, 'Supatá', 90, 15, 1, '2022-11-11 02:05:34'),
(617, 'Susa', 91, 15, 1, '2022-11-11 02:05:34'),
(618, 'Sutatausa', 92, 15, 1, '2022-11-11 02:05:34'),
(619, 'Tabio', 93, 15, 1, '2022-11-11 02:05:34'),
(620, 'Tausa', 94, 15, 1, '2022-11-11 02:05:34'),
(621, 'Tena', 95, 15, 1, '2022-11-11 02:05:34'),
(622, 'Tenjo', 96, 15, 1, '2022-11-11 02:05:34'),
(623, 'Tibacuy', 97, 15, 1, '2022-11-11 02:05:34'),
(624, 'Tibirita', 98, 15, 1, '2022-11-11 02:05:34'),
(625, 'Tocaima', 99, 15, 1, '2022-11-11 02:05:34'),
(626, 'Tocancipá', 100, 15, 1, '2022-11-11 02:05:34'),
(627, 'Topaipí', 101, 15, 1, '2022-11-11 02:05:34'),
(628, 'Ubalá', 102, 15, 1, '2022-11-11 02:05:34'),
(629, 'Ubaque', 103, 15, 1, '2022-11-11 02:05:34'),
(630, 'Une', 104, 15, 1, '2022-11-11 02:05:34'),
(631, 'Útica', 105, 15, 1, '2022-11-11 02:05:34'),
(632, 'Venecia', 106, 15, 1, '2022-11-11 02:05:34'),
(633, 'Vergara', 107, 15, 1, '2022-11-11 02:05:34'),
(634, 'Vianí', 108, 15, 1, '2022-11-11 02:05:34'),
(635, 'Villa de San Diego de Ubaté', 109, 15, 1, '2022-11-11 02:05:34'),
(636, 'Villagómez', 110, 15, 1, '2022-11-11 02:05:34'),
(637, 'Villapinzón', 111, 15, 1, '2022-11-11 02:05:34'),
(638, 'Villeta', 112, 15, 1, '2022-11-11 02:05:34'),
(639, 'Viotá', 113, 15, 1, '2022-11-11 02:05:34'),
(640, 'Yacopí', 114, 15, 1, '2022-11-11 02:05:34'),
(641, 'Zipacón', 115, 15, 1, '2022-11-11 02:05:34'),
(642, 'Zipaquirá', 116, 15, 1, '2022-11-11 02:05:34'),
(643, 'Barranco Minas', 1, 16, 1, '2022-11-11 02:05:34'),
(644, 'Cacahual', 2, 16, 1, '2022-11-11 02:05:34'),
(645, 'Inírida', 3, 16, 1, '2022-11-11 02:05:34'),
(646, 'La Guadalupe', 4, 16, 1, '2022-11-11 02:05:34'),
(647, 'Mapiripana', 5, 16, 1, '2022-11-11 02:05:34'),
(648, 'Morichal', 6, 16, 1, '2022-11-11 02:05:34'),
(649, 'Pana Pana', 7, 16, 1, '2022-11-11 02:05:34'),
(650, 'Puerto Colombia', 8, 16, 1, '2022-11-11 02:05:34'),
(651, 'San Felipe', 9, 16, 1, '2022-11-11 02:05:34'),
(652, 'Calamar', 1, 17, 1, '2022-11-11 02:05:34'),
(653, 'El Retorno', 2, 17, 1, '2022-11-11 02:05:34'),
(654, 'Miraflores', 3, 17, 1, '2022-11-11 02:05:34'),
(655, 'San José del Guaviare', 4, 17, 1, '2022-11-11 02:05:34'),
(656, 'Acevedo', 1, 18, 1, '2022-11-11 02:05:34'),
(657, 'Agrado', 2, 18, 1, '2022-11-11 02:05:34'),
(658, 'Aipe', 3, 18, 1, '2022-11-11 02:05:34'),
(659, 'Algeciras', 4, 18, 1, '2022-11-11 02:05:34'),
(660, 'Altamira', 5, 18, 1, '2022-11-11 02:05:34'),
(661, 'Baraya', 6, 18, 1, '2022-11-11 02:05:34'),
(662, 'Campoalegre', 7, 18, 1, '2022-11-11 02:05:34'),
(663, 'Colombia', 8, 18, 1, '2022-11-11 02:05:34'),
(664, 'Elías', 9, 18, 1, '2022-11-11 02:05:34'),
(665, 'Garzón', 10, 18, 1, '2022-11-11 02:05:34'),
(666, 'Gigante', 11, 18, 1, '2022-11-11 02:05:34'),
(667, 'Guadalupe', 12, 18, 1, '2022-11-11 02:05:34'),
(668, 'Hobo', 13, 18, 1, '2022-11-11 02:05:34'),
(669, 'Íquira', 14, 18, 1, '2022-11-11 02:05:34'),
(670, 'Isnos', 15, 18, 1, '2022-11-11 02:05:34'),
(671, 'La Argentina', 16, 18, 1, '2022-11-11 02:05:34'),
(672, 'La Plata', 17, 18, 1, '2022-11-11 02:05:34'),
(673, 'Nátaga', 18, 18, 1, '2022-11-11 02:05:34'),
(674, 'Neiva', 19, 18, 1, '2022-11-11 02:05:34'),
(675, 'Oporapa', 20, 18, 1, '2022-11-11 02:05:34'),
(676, 'Paicol', 21, 18, 1, '2022-11-11 02:05:34'),
(677, 'Palermo', 22, 18, 1, '2022-11-11 02:05:34'),
(678, 'Palestina', 23, 18, 1, '2022-11-11 02:05:34'),
(679, 'Pital', 24, 18, 1, '2022-11-11 02:05:34'),
(680, 'Pitalito', 25, 18, 1, '2022-11-11 02:05:34'),
(681, 'Rivera', 26, 18, 1, '2022-11-11 02:05:34'),
(682, 'Saladoblanco', 27, 18, 1, '2022-11-11 02:05:34'),
(683, 'San Agustín', 28, 18, 1, '2022-11-11 02:05:34'),
(684, 'Santa María', 29, 18, 1, '2022-11-11 02:05:34'),
(685, 'Suaza', 30, 18, 1, '2022-11-11 02:05:34'),
(686, 'Tarqui', 31, 18, 1, '2022-11-11 02:05:34'),
(687, 'Tello', 32, 18, 1, '2022-11-11 02:05:34'),
(688, 'Teruel', 33, 18, 1, '2022-11-11 02:05:34'),
(689, 'Tesalia', 34, 18, 1, '2022-11-11 02:05:34'),
(690, 'Timaná', 35, 18, 1, '2022-11-11 02:05:34'),
(691, 'Villavieja', 36, 18, 1, '2022-11-11 02:05:34'),
(692, 'Yaguará', 37, 18, 1, '2022-11-11 02:05:34'),
(693, 'Albania', 1, 19, 1, '2022-11-11 02:05:34'),
(694, 'Barrancas', 2, 19, 1, '2022-11-11 02:05:34'),
(695, 'Dibulla', 3, 19, 1, '2022-11-11 02:05:34'),
(696, 'Distracción', 4, 19, 1, '2022-11-11 02:05:34'),
(697, 'El Molino', 5, 19, 1, '2022-11-11 02:05:34'),
(698, 'Fonseca', 6, 19, 1, '2022-11-11 02:05:34'),
(699, 'Hatonuevo', 7, 19, 1, '2022-11-11 02:05:34'),
(700, 'La Jagua del Pilar', 8, 19, 1, '2022-11-11 02:05:34'),
(701, 'Maicao', 9, 19, 1, '2022-11-11 02:05:34'),
(702, 'Manaure', 10, 19, 1, '2022-11-11 02:05:34'),
(703, 'Riohacha', 11, 19, 1, '2022-11-11 02:05:34'),
(704, 'San Juan del Cesar', 12, 19, 1, '2022-11-11 02:05:34'),
(705, 'Uribia', 13, 19, 1, '2022-11-11 02:05:34'),
(706, 'Urumita', 14, 19, 1, '2022-11-11 02:05:34'),
(707, 'Villanueva', 15, 19, 1, '2022-11-11 02:05:34'),
(708, 'Algarrobo', 1, 20, 1, '2022-11-11 02:05:34'),
(709, 'Aracataca', 2, 20, 1, '2022-11-11 02:05:34'),
(710, 'Ariguaní', 3, 20, 1, '2022-11-11 02:05:34'),
(711, 'Cerro San Antonio', 4, 20, 1, '2022-11-11 02:05:34'),
(712, 'Chibolo', 5, 20, 1, '2022-11-11 02:05:34'),
(713, 'Ciénaga', 6, 20, 1, '2022-11-11 02:05:34'),
(714, 'Concordia', 7, 20, 1, '2022-11-11 02:05:34'),
(715, 'El Banco', 8, 20, 1, '2022-11-11 02:05:34'),
(716, 'El Piñón', 9, 20, 1, '2022-11-11 02:05:34'),
(717, 'El Retén', 10, 20, 1, '2022-11-11 02:05:34'),
(718, 'Fundación', 11, 20, 1, '2022-11-11 02:05:34'),
(719, 'Guamal', 12, 20, 1, '2022-11-11 02:05:34'),
(720, 'Nueva Granada', 13, 20, 1, '2022-11-11 02:05:34'),
(721, 'Pedraza', 14, 20, 1, '2022-11-11 02:05:34'),
(722, 'Pijiño del Carmen', 15, 20, 1, '2022-11-11 02:05:34'),
(723, 'Pivijay', 16, 20, 1, '2022-11-11 02:05:34'),
(724, 'Plato', 17, 20, 1, '2022-11-11 02:05:34'),
(725, 'Puebloviejo', 18, 20, 1, '2022-11-11 02:05:34'),
(726, 'Remolino', 19, 20, 1, '2022-11-11 02:05:34'),
(727, 'Sabanas de San Ángel', 20, 20, 1, '2022-11-11 02:05:34'),
(728, 'Salamina', 21, 20, 1, '2022-11-11 02:05:34'),
(729, 'San Sebastián de Buenavista', 22, 20, 1, '2022-11-11 02:05:34'),
(730, 'Santa Ana', 23, 20, 1, '2022-11-11 02:05:34'),
(731, 'Santa Barbara de Pinto', 24, 20, 1, '2022-11-11 02:05:34'),
(732, 'Santa Marta', 25, 20, 1, '2022-11-11 02:05:34'),
(733, 'San Zenón', 26, 20, 1, '2022-11-11 02:05:34'),
(734, 'Sitionuevo', 27, 20, 1, '2022-11-11 02:05:34'),
(735, 'Tenerife', 28, 20, 1, '2022-11-11 02:05:34'),
(736, 'Zapayán', 29, 20, 1, '2022-11-11 02:05:34'),
(737, 'Zona Bananera', 30, 20, 1, '2022-11-11 02:05:34'),
(738, 'Acacías', 1, 21, 1, '2022-11-11 02:05:34'),
(739, 'Barranca de Upía', 2, 21, 1, '2022-11-11 02:05:34'),
(740, 'Cabuyaro', 3, 21, 1, '2022-11-11 02:05:34'),
(741, 'Castilla La Nueva', 4, 21, 1, '2022-11-11 02:05:34'),
(742, 'Cubarral', 5, 21, 1, '2022-11-11 02:05:34'),
(743, 'Cumaral', 6, 21, 1, '2022-11-11 02:05:34'),
(744, 'El Calvario', 7, 21, 1, '2022-11-11 02:05:34'),
(745, 'El Castillo', 8, 21, 1, '2022-11-11 02:05:34'),
(746, 'El Dorado', 9, 21, 1, '2022-11-11 02:05:34'),
(747, 'Fuente de Oro', 10, 21, 1, '2022-11-11 02:05:34'),
(748, 'Granada', 11, 21, 1, '2022-11-11 02:05:34'),
(749, 'Guamal', 12, 21, 1, '2022-11-11 02:05:34'),
(750, 'La Macarena', 13, 21, 1, '2022-11-11 02:05:34'),
(751, 'Lejanías', 14, 21, 1, '2022-11-11 02:05:34'),
(752, 'Mapiripán', 15, 21, 1, '2022-11-11 02:05:34'),
(753, 'Mesetas', 16, 21, 1, '2022-11-11 02:05:34'),
(754, 'Puerto Concordia', 17, 21, 1, '2022-11-11 02:05:34'),
(755, 'Puerto Gaitán', 18, 21, 1, '2022-11-11 02:05:34'),
(756, 'Puerto Lleras', 19, 21, 1, '2022-11-11 02:05:34'),
(757, 'Puerto López', 20, 21, 1, '2022-11-11 02:05:34'),
(758, 'Puerto Rico', 21, 21, 1, '2022-11-11 02:05:34'),
(759, 'Restrepo', 22, 21, 1, '2022-11-11 02:05:34'),
(760, 'San Carlos de Guaroa', 23, 21, 1, '2022-11-11 02:05:34'),
(761, 'San Juan de Arama', 24, 21, 1, '2022-11-11 02:05:34'),
(762, 'San Juanito', 25, 21, 1, '2022-11-11 02:05:34'),
(763, 'San Martín', 26, 21, 1, '2022-11-11 02:05:34'),
(764, 'Uribe', 27, 21, 1, '2022-11-11 02:05:34'),
(765, 'Villavicencio', 28, 21, 1, '2022-11-11 02:05:34'),
(766, 'Vistahermosa', 29, 21, 1, '2022-11-11 02:05:34'),
(767, 'Abrego', 1, 22, 1, '2022-11-11 02:05:34'),
(768, 'Arboledas', 2, 22, 1, '2022-11-11 02:05:34'),
(769, 'Bochalema', 3, 22, 1, '2022-11-11 02:05:34'),
(770, 'Bucarasica', 4, 22, 1, '2022-11-11 02:05:34'),
(771, 'Cachirá', 5, 22, 1, '2022-11-11 02:05:34'),
(772, 'Cácota', 6, 22, 1, '2022-11-11 02:05:34'),
(773, 'Chinácota', 7, 22, 1, '2022-11-11 02:05:34'),
(774, 'Chitagá', 8, 22, 1, '2022-11-11 02:05:34'),
(775, 'Convención', 9, 22, 1, '2022-11-11 02:05:34'),
(776, 'Cúcuta', 10, 22, 1, '2022-11-11 02:05:34'),
(777, 'Cucutilla', 11, 22, 1, '2022-11-11 02:05:34'),
(778, 'Durania', 12, 22, 1, '2022-11-11 02:05:34'),
(779, 'El Carmen', 13, 22, 1, '2022-11-11 02:05:34'),
(780, 'El Tarra', 14, 22, 1, '2022-11-11 02:05:34'),
(781, 'El Zulia', 15, 22, 1, '2022-11-11 02:05:34'),
(782, 'Gramalote', 16, 22, 1, '2022-11-11 02:05:34'),
(783, 'Hacarí', 17, 22, 1, '2022-11-11 02:05:34'),
(784, 'Herrán', 18, 22, 1, '2022-11-11 02:05:34'),
(785, 'Labateca', 19, 22, 1, '2022-11-11 02:05:34'),
(786, 'La Esperanza', 20, 22, 1, '2022-11-11 02:05:34'),
(787, 'La Playa', 21, 22, 1, '2022-11-11 02:05:34'),
(788, 'Los Patios', 22, 22, 1, '2022-11-11 02:05:34'),
(789, 'Lourdes', 23, 22, 1, '2022-11-11 02:05:34'),
(790, 'Mutiscua', 24, 22, 1, '2022-11-11 02:05:34'),
(791, 'Ocaña', 25, 22, 1, '2022-11-11 02:05:34'),
(792, 'Pamplona', 26, 22, 1, '2022-11-11 02:05:34'),
(793, 'Pamplonita', 27, 22, 1, '2022-11-11 02:05:34'),
(794, 'Puerto Santander', 28, 22, 1, '2022-11-11 02:05:34'),
(795, 'Ragonvalia', 29, 22, 1, '2022-11-11 02:05:34'),
(796, 'Salazar', 30, 22, 1, '2022-11-11 02:05:34'),
(797, 'San Calixto', 31, 22, 1, '2022-11-11 02:05:34'),
(798, 'San Cayetano', 32, 22, 1, '2022-11-11 02:05:34'),
(799, 'Santiago', 33, 22, 1, '2022-11-11 02:05:34'),
(800, 'Sardinata', 34, 22, 1, '2022-11-11 02:05:34'),
(801, 'Silos', 35, 22, 1, '2022-11-11 02:05:34'),
(802, 'Teorama', 36, 22, 1, '2022-11-11 02:05:34'),
(803, 'Tibú', 37, 22, 1, '2022-11-11 02:05:34'),
(804, 'Toledo', 38, 22, 1, '2022-11-11 02:05:34'),
(805, 'Villa Caro', 39, 22, 1, '2022-11-11 02:05:34'),
(806, 'Villa del Rosario', 40, 22, 1, '2022-11-11 02:05:34'),
(807, 'Albán', 1, 23, 1, '2022-11-11 02:05:34'),
(808, 'Aldana', 2, 23, 1, '2022-11-11 02:05:34'),
(809, 'Ancuyá', 3, 23, 1, '2022-11-11 02:05:34'),
(810, 'Arboleda', 4, 23, 1, '2022-11-11 02:05:34'),
(811, 'Barbacoas', 5, 23, 1, '2022-11-11 02:05:34'),
(812, 'Belén', 6, 23, 1, '2022-11-11 02:05:34'),
(813, 'Buesaco', 7, 23, 1, '2022-11-11 02:05:34'),
(814, 'Chachagüí', 8, 23, 1, '2022-11-11 02:05:34'),
(815, 'Colón', 9, 23, 1, '2022-11-11 02:05:34'),
(816, 'Consacá', 10, 23, 1, '2022-11-11 02:05:34'),
(817, 'Contadero', 11, 23, 1, '2022-11-11 02:05:34'),
(818, 'Córdoba', 12, 23, 1, '2022-11-11 02:05:34'),
(819, 'Cuaspud', 13, 23, 1, '2022-11-11 02:05:34'),
(820, 'Cumbal', 14, 23, 1, '2022-11-11 02:05:34'),
(821, 'Cumbitara', 15, 23, 1, '2022-11-11 02:05:34'),
(822, 'El Charco', 16, 23, 1, '2022-11-11 02:05:34'),
(823, 'El Peñol', 17, 23, 1, '2022-11-11 02:05:34'),
(824, 'El Rosario', 18, 23, 1, '2022-11-11 02:05:34'),
(825, 'El Tablón de Gómez', 19, 23, 1, '2022-11-11 02:05:34'),
(826, 'El Tambo', 20, 23, 1, '2022-11-11 02:05:34'),
(827, 'Francisco Pizarro', 21, 23, 1, '2022-11-11 02:05:34'),
(828, 'Funes', 22, 23, 1, '2022-11-11 02:05:34'),
(829, 'Guachucal', 23, 23, 1, '2022-11-11 02:05:34'),
(830, 'Guaitarilla', 24, 23, 1, '2022-11-11 02:05:34'),
(831, 'Gualmatan', 25, 23, 1, '2022-11-11 02:05:34'),
(832, 'Iles', 26, 23, 1, '2022-11-11 02:05:34'),
(833, 'Imués', 27, 23, 1, '2022-11-11 02:05:34'),
(834, 'Ipiales', 28, 23, 1, '2022-11-11 02:05:34'),
(835, 'La Cruz', 29, 23, 1, '2022-11-11 02:05:34'),
(836, 'La Florida', 30, 23, 1, '2022-11-11 02:05:34'),
(837, 'La Llanada', 31, 23, 1, '2022-11-11 02:05:34'),
(838, 'La Tola', 32, 23, 1, '2022-11-11 02:05:34'),
(839, 'La Unión', 33, 23, 1, '2022-11-11 02:05:34'),
(840, 'Leiva', 34, 23, 1, '2022-11-11 02:05:34'),
(841, 'Linares', 35, 23, 1, '2022-11-11 02:05:34'),
(842, 'Los Andes', 36, 23, 1, '2022-11-11 02:05:34'),
(843, 'Magüí', 37, 23, 1, '2022-11-11 02:05:34'),
(844, 'Mallama', 38, 23, 1, '2022-11-11 02:05:34'),
(845, 'Mosquera', 39, 23, 1, '2022-11-11 02:05:34'),
(846, 'Nariño', 40, 23, 1, '2022-11-11 02:05:34'),
(847, 'Olaya Herrera', 41, 23, 1, '2022-11-11 02:05:34'),
(848, 'Ospina', 42, 23, 1, '2022-11-11 02:05:34'),
(849, 'Pasto', 43, 23, 1, '2022-11-11 02:05:34'),
(850, 'Policarpa', 44, 23, 1, '2022-11-11 02:05:34'),
(851, 'Potosí', 45, 23, 1, '2022-11-11 02:05:34'),
(852, 'Providencia', 46, 23, 1, '2022-11-11 02:05:34'),
(853, 'Puerres', 47, 23, 1, '2022-11-11 02:05:34'),
(854, 'Pupiales', 48, 23, 1, '2022-11-11 02:05:34'),
(855, 'Ricaurte', 49, 23, 1, '2022-11-11 02:05:34'),
(856, 'Roberto Payán', 50, 23, 1, '2022-11-11 02:05:34'),
(857, 'Samaniego', 51, 23, 1, '2022-11-11 02:05:34'),
(858, 'San Andrés de Tumaco', 52, 23, 1, '2022-11-11 02:05:34'),
(859, 'San Bernardo', 53, 23, 1, '2022-11-11 02:05:34'),
(860, 'Sandoná', 54, 23, 1, '2022-11-11 02:05:34'),
(861, 'San Lorenzo', 55, 23, 1, '2022-11-11 02:05:34'),
(862, 'San Pablo', 56, 23, 1, '2022-11-11 02:05:34'),
(863, 'San Pedro de Cartago', 57, 23, 1, '2022-11-11 02:05:34'),
(864, 'Santa Bárbara', 58, 23, 1, '2022-11-11 02:05:34'),
(865, 'Santacruz', 59, 23, 1, '2022-11-11 02:05:34'),
(866, 'Sapuyes', 60, 23, 1, '2022-11-11 02:05:34'),
(867, 'Taminango', 61, 23, 1, '2022-11-11 02:05:34'),
(868, 'Tangua', 62, 23, 1, '2022-11-11 02:05:34'),
(869, 'Túquerres', 63, 23, 1, '2022-11-11 02:05:34'),
(870, 'Yacuanquer', 64, 23, 1, '2022-11-11 02:05:34'),
(871, 'Colón', 1, 24, 1, '2022-11-11 02:05:34'),
(872, 'Leguízamo', 2, 24, 1, '2022-11-11 02:05:34'),
(873, 'Mocoa', 3, 24, 1, '2022-11-11 02:05:34'),
(874, 'Orito', 4, 24, 1, '2022-11-11 02:05:34'),
(875, 'Puerto Asís', 5, 24, 1, '2022-11-11 02:05:34'),
(876, 'Puerto Caicedo', 6, 24, 1, '2022-11-11 02:05:34'),
(877, 'Puerto Guzmán', 7, 24, 1, '2022-11-11 02:05:34'),
(878, 'San Francisco', 8, 24, 1, '2022-11-11 02:05:34'),
(879, 'San Miguel', 9, 24, 1, '2022-11-11 02:05:34'),
(880, 'Santiago', 10, 24, 1, '2022-11-11 02:05:34'),
(881, 'Sibundoy', 11, 24, 1, '2022-11-11 02:05:34'),
(882, 'Valle del Guamuez', 12, 24, 1, '2022-11-11 02:05:34'),
(883, 'Villagarzón', 13, 24, 1, '2022-11-11 02:05:34'),
(884, 'Armenia', 1, 25, 1, '2022-11-11 02:05:34'),
(885, 'Buenavista', 2, 25, 1, '2022-11-11 02:05:34'),
(886, 'Calarcá', 3, 25, 1, '2022-11-11 02:05:34'),
(887, 'Circasia', 4, 25, 1, '2022-11-11 02:05:34'),
(888, 'Córdoba', 5, 25, 1, '2022-11-11 02:05:34'),
(889, 'Filandia', 6, 25, 1, '2022-11-11 02:05:34'),
(890, 'Génova', 7, 25, 1, '2022-11-11 02:05:34'),
(891, 'La Tebaida', 8, 25, 1, '2022-11-11 02:05:34'),
(892, 'Montenegro', 9, 25, 1, '2022-11-11 02:05:34'),
(893, 'Pijao', 10, 25, 1, '2022-11-11 02:05:34'),
(894, 'Quimbaya', 11, 25, 1, '2022-11-11 02:05:34'),
(895, 'Salento', 12, 25, 1, '2022-11-11 02:05:34'),
(896, 'Apía', 1, 26, 1, '2022-11-11 02:05:34'),
(897, 'Balboa', 2, 26, 1, '2022-11-11 02:05:34'),
(898, 'Belén de Umbría', 3, 26, 1, '2022-11-11 02:05:34'),
(899, 'Dosquebradas', 4, 26, 1, '2022-11-11 02:05:34'),
(900, 'Guática', 5, 26, 1, '2022-11-11 02:05:34'),
(901, 'La Celia', 6, 26, 1, '2022-11-11 02:05:34'),
(902, 'La Virginia', 7, 26, 1, '2022-11-11 02:05:34'),
(903, 'Marsella', 8, 26, 1, '2022-11-11 02:05:34'),
(904, 'Mistrató', 9, 26, 1, '2022-11-11 02:05:34'),
(905, 'Pereira', 10, 26, 1, '2022-11-11 02:05:34'),
(906, 'Pueblo Rico', 11, 26, 1, '2022-11-11 02:05:34'),
(907, 'Quinchía', 12, 26, 1, '2022-11-11 02:05:34'),
(908, 'Santa Rosa de Cabal', 13, 26, 1, '2022-11-11 02:05:34'),
(909, 'Santuario', 14, 26, 1, '2022-11-11 02:05:34'),
(910, 'Providencia', 1, 27, 1, '2022-11-11 02:05:34'),
(911, 'San Andrés', 2, 27, 1, '2022-11-11 02:05:34'),
(912, 'Aguada', 1, 28, 1, '2022-11-11 02:05:34'),
(913, 'Albania', 2, 28, 1, '2022-11-11 02:05:34'),
(914, 'Aratoca', 3, 28, 1, '2022-11-11 02:05:34'),
(915, 'Barbosa', 4, 28, 1, '2022-11-11 02:05:34'),
(916, 'Barichara', 5, 28, 1, '2022-11-11 02:05:34'),
(917, 'Barrancabermeja', 6, 28, 1, '2022-11-11 02:05:34'),
(918, 'Betulia', 7, 28, 1, '2022-11-11 02:05:34'),
(919, 'Bolívar', 8, 28, 1, '2022-11-11 02:05:34'),
(920, 'Bucaramanga', 9, 28, 1, '2022-11-11 02:05:34'),
(921, 'Cabrera', 10, 28, 1, '2022-11-11 02:05:34'),
(922, 'California', 11, 28, 1, '2022-11-11 02:05:34'),
(923, 'Capitanejo', 12, 28, 1, '2022-11-11 02:05:34'),
(924, 'Carcasí', 13, 28, 1, '2022-11-11 02:05:34'),
(925, 'Cepitá', 14, 28, 1, '2022-11-11 02:05:34'),
(926, 'Cerrito', 15, 28, 1, '2022-11-11 02:05:34'),
(927, 'Charalá', 16, 28, 1, '2022-11-11 02:05:34'),
(928, 'Charta', 17, 28, 1, '2022-11-11 02:05:34'),
(929, 'Chima', 18, 28, 1, '2022-11-11 02:05:34'),
(930, 'Chipatá', 19, 28, 1, '2022-11-11 02:05:34'),
(931, 'Cimitarra', 20, 28, 1, '2022-11-11 02:05:34'),
(932, 'Concepción', 21, 28, 1, '2022-11-11 02:05:34'),
(933, 'Confines', 22, 28, 1, '2022-11-11 02:05:34'),
(934, 'Contratación', 23, 28, 1, '2022-11-11 02:05:34'),
(935, 'Coromoro', 24, 28, 1, '2022-11-11 02:05:34'),
(936, 'Curití', 25, 28, 1, '2022-11-11 02:05:34'),
(937, 'El Carmen de Chucurí', 26, 28, 1, '2022-11-11 02:05:34'),
(938, 'El Guacamayo', 27, 28, 1, '2022-11-11 02:05:34'),
(939, 'El Peñón', 28, 28, 1, '2022-11-11 02:05:34'),
(940, 'El Playón', 29, 28, 1, '2022-11-11 02:05:34'),
(941, 'Encino', 30, 28, 1, '2022-11-11 02:05:34'),
(942, 'Enciso', 31, 28, 1, '2022-11-11 02:05:34'),
(943, 'Florián', 32, 28, 1, '2022-11-11 02:05:34'),
(944, 'Floridablanca', 33, 28, 1, '2022-11-11 02:05:34'),
(945, 'Galán', 34, 28, 1, '2022-11-11 02:05:34'),
(946, 'Gámbita', 35, 28, 1, '2022-11-11 02:05:34'),
(947, 'Girón', 36, 28, 1, '2022-11-11 02:05:34'),
(948, 'Guaca', 37, 28, 1, '2022-11-11 02:05:34'),
(949, 'Guadalupe', 38, 28, 1, '2022-11-11 02:05:34'),
(950, 'Guapotá', 39, 28, 1, '2022-11-11 02:05:34'),
(951, 'Guavatá', 40, 28, 1, '2022-11-11 02:05:34'),
(952, 'Güepsa', 41, 28, 1, '2022-11-11 02:05:34'),
(953, 'Hato', 42, 28, 1, '2022-11-11 02:05:34'),
(954, 'Jesús María', 43, 28, 1, '2022-11-11 02:05:34'),
(955, 'Jordán', 44, 28, 1, '2022-11-11 02:05:34'),
(956, 'La Belleza', 45, 28, 1, '2022-11-11 02:05:34'),
(957, 'Landázuri', 46, 28, 1, '2022-11-11 02:05:34'),
(958, 'La Paz', 47, 28, 1, '2022-11-11 02:05:34'),
(959, 'Lebrija', 48, 28, 1, '2022-11-11 02:05:34'),
(960, 'Los Santos', 49, 28, 1, '2022-11-11 02:05:34'),
(961, 'Macaravita', 50, 28, 1, '2022-11-11 02:05:34'),
(962, 'Málaga', 51, 28, 1, '2022-11-11 02:05:34'),
(963, 'Matanza', 52, 28, 1, '2022-11-11 02:05:34'),
(964, 'Mogotes', 53, 28, 1, '2022-11-11 02:05:34'),
(965, 'Molagavita', 54, 28, 1, '2022-11-11 02:05:34'),
(966, 'Ocamonte', 55, 28, 1, '2022-11-11 02:05:34'),
(967, 'Oiba', 56, 28, 1, '2022-11-11 02:05:34'),
(968, 'Onzaga', 57, 28, 1, '2022-11-11 02:05:34'),
(969, 'Palmar', 58, 28, 1, '2022-11-11 02:05:34'),
(970, 'Palmas del Socorro', 59, 28, 1, '2022-11-11 02:05:34'),
(971, 'Páramo', 60, 28, 1, '2022-11-11 02:05:34'),
(972, 'Piedecuesta', 61, 28, 1, '2022-11-11 02:05:34'),
(973, 'Pinchote', 62, 28, 1, '2022-11-11 02:05:34'),
(974, 'Puente Nacional', 63, 28, 1, '2022-11-11 02:05:34');
INSERT INTO `municipio` (`muni_id`, `muni_descripcion`, `muni_orden`, `depa_id`, `muni_registradorpor`, `muni_fechacambio`) VALUES
(975, 'Puerto Parra', 64, 28, 1, '2022-11-11 02:05:34'),
(976, 'Puerto Wilches', 65, 28, 1, '2022-11-11 02:05:34'),
(977, 'Rionegro', 66, 28, 1, '2022-11-11 02:05:34'),
(978, 'Sabana de Torres', 67, 28, 1, '2022-11-11 02:05:34'),
(979, 'San Andrés', 68, 28, 1, '2022-11-11 02:05:34'),
(980, 'San Benito', 69, 28, 1, '2022-11-11 02:05:34'),
(981, 'San Gil', 70, 28, 1, '2022-11-11 02:05:34'),
(982, 'San Joaquín', 71, 28, 1, '2022-11-11 02:05:34'),
(983, 'San José de Miranda', 72, 28, 1, '2022-11-11 02:05:34'),
(984, 'San Miguel', 73, 28, 1, '2022-11-11 02:05:34'),
(985, 'Santa Bárbara', 74, 28, 1, '2022-11-11 02:05:34'),
(986, 'Santa Helena del Opón', 75, 28, 1, '2022-11-11 02:05:34'),
(987, 'San Vicente de Chucurí', 76, 28, 1, '2022-11-11 02:05:34'),
(988, 'Simacota', 77, 28, 1, '2022-11-11 02:05:34'),
(989, 'Socorro', 78, 28, 1, '2022-11-11 02:05:34'),
(990, 'Suaita', 79, 28, 1, '2022-11-11 02:05:34'),
(991, 'Sucre', 80, 28, 1, '2022-11-11 02:05:34'),
(992, 'Suratá', 81, 28, 1, '2022-11-11 02:05:34'),
(993, 'Tona', 82, 28, 1, '2022-11-11 02:05:34'),
(994, 'Valle de San José', 83, 28, 1, '2022-11-11 02:05:34'),
(995, 'Vélez', 84, 28, 1, '2022-11-11 02:05:34'),
(996, 'Vetas', 85, 28, 1, '2022-11-11 02:05:34'),
(997, 'Villanueva', 86, 28, 1, '2022-11-11 02:05:34'),
(998, 'Zapatoca', 87, 28, 1, '2022-11-11 02:05:34'),
(999, 'Buenavista', 1, 29, 1, '2022-11-11 02:05:34'),
(1000, 'Caimito', 2, 29, 1, '2022-11-11 02:05:34'),
(1001, 'Chalán', 3, 29, 1, '2022-11-11 02:05:34'),
(1002, 'Colosó', 4, 29, 1, '2022-11-11 02:05:34'),
(1003, 'Corozal', 5, 29, 1, '2022-11-11 02:05:34'),
(1004, 'Coveñas', 6, 29, 1, '2022-11-11 02:05:34'),
(1005, 'El Roble', 7, 29, 1, '2022-11-11 02:05:34'),
(1006, 'Galeras', 8, 29, 1, '2022-11-11 02:05:34'),
(1007, 'Guaranda', 9, 29, 1, '2022-11-11 02:05:34'),
(1008, 'La Unión', 10, 29, 1, '2022-11-11 02:05:34'),
(1009, 'Los Palmitos', 11, 29, 1, '2022-11-11 02:05:34'),
(1010, 'Majagual', 12, 29, 1, '2022-11-11 02:05:34'),
(1011, 'Morroa', 13, 29, 1, '2022-11-11 02:05:34'),
(1012, 'Ovejas', 14, 29, 1, '2022-11-11 02:05:34'),
(1013, 'Palmito', 15, 29, 1, '2022-11-11 02:05:34'),
(1014, 'Sampués', 16, 29, 1, '2022-11-11 02:05:34'),
(1015, 'San Benito Abad', 17, 29, 1, '2022-11-11 02:05:34'),
(1016, 'San Juan de Betulia', 18, 29, 1, '2022-11-11 02:05:34'),
(1017, 'San Luis de Since', 19, 29, 1, '2022-11-11 02:05:34'),
(1018, 'San Marcos', 20, 29, 1, '2022-11-11 02:05:34'),
(1019, 'San Onofre', 21, 29, 1, '2022-11-11 02:05:34'),
(1020, 'San Pedro', 22, 29, 1, '2022-11-11 02:05:34'),
(1021, 'Santiago de Tolú', 23, 29, 1, '2022-11-11 02:05:34'),
(1022, 'Sincelejo', 24, 29, 1, '2022-11-11 02:05:34'),
(1023, 'Sucre', 25, 29, 1, '2022-11-11 02:05:34'),
(1024, 'Tolú Viejo', 26, 29, 1, '2022-11-11 02:05:34'),
(1025, 'Alpujarra', 1, 30, 1, '2022-11-11 02:05:34'),
(1026, 'Alvarado', 2, 30, 1, '2022-11-11 02:05:34'),
(1027, 'Ambalema', 3, 30, 1, '2022-11-11 02:05:34'),
(1028, 'Anzoátegui', 4, 30, 1, '2022-11-11 02:05:34'),
(1029, 'Armero', 5, 30, 1, '2022-11-11 02:05:34'),
(1030, 'Ataco', 6, 30, 1, '2022-11-11 02:05:34'),
(1031, 'Cajamarca', 7, 30, 1, '2022-11-11 02:05:34'),
(1032, 'Carmen de Apicalá', 8, 30, 1, '2022-11-11 02:05:34'),
(1033, 'Casabianca', 9, 30, 1, '2022-11-11 02:05:34'),
(1034, 'Chaparral', 10, 30, 1, '2022-11-11 02:05:34'),
(1035, 'Coello', 11, 30, 1, '2022-11-11 02:05:34'),
(1036, 'Coyaima', 12, 30, 1, '2022-11-11 02:05:34'),
(1037, 'Cunday', 13, 30, 1, '2022-11-11 02:05:34'),
(1038, 'Dolores', 14, 30, 1, '2022-11-11 02:05:34'),
(1039, 'Espinal', 15, 30, 1, '2022-11-11 02:05:34'),
(1040, 'Falan', 16, 30, 1, '2022-11-11 02:05:34'),
(1041, 'Flandes', 17, 30, 1, '2022-11-11 02:05:34'),
(1042, 'Fresno', 18, 30, 1, '2022-11-11 02:05:34'),
(1043, 'Guamo', 19, 30, 1, '2022-11-11 02:05:34'),
(1044, 'Herveo', 20, 30, 1, '2022-11-11 02:05:34'),
(1045, 'Honda', 21, 30, 1, '2022-11-11 02:05:34'),
(1046, 'Ibagué', 22, 30, 1, '2022-11-11 02:05:34'),
(1047, 'Icononzo', 23, 30, 1, '2022-11-11 02:05:34'),
(1048, 'Lérida', 24, 30, 1, '2022-11-11 02:05:34'),
(1049, 'Líbano', 25, 30, 1, '2022-11-11 02:05:34'),
(1050, 'Mariquita', 26, 30, 1, '2022-11-11 02:05:34'),
(1051, 'Melgar', 27, 30, 1, '2022-11-11 02:05:34'),
(1052, 'Murillo', 28, 30, 1, '2022-11-11 02:05:34'),
(1053, 'Natagaima', 29, 30, 1, '2022-11-11 02:05:34'),
(1054, 'Ortega', 30, 30, 1, '2022-11-11 02:05:34'),
(1055, 'Palocabildo', 31, 30, 1, '2022-11-11 02:05:34'),
(1056, 'Piedras', 32, 30, 1, '2022-11-11 02:05:34'),
(1057, 'Planadas', 33, 30, 1, '2022-11-11 02:05:34'),
(1058, 'Prado', 34, 30, 1, '2022-11-11 02:05:34'),
(1059, 'Purificación', 35, 30, 1, '2022-11-11 02:05:34'),
(1060, 'Rioblanco', 36, 30, 1, '2022-11-11 02:05:34'),
(1061, 'Roncesvalles', 37, 30, 1, '2022-11-11 02:05:34'),
(1062, 'Rovira', 38, 30, 1, '2022-11-11 02:05:34'),
(1063, 'Saldaña', 39, 30, 1, '2022-11-11 02:05:34'),
(1064, 'San Antonio', 40, 30, 1, '2022-11-11 02:05:34'),
(1065, 'San Luis', 41, 30, 1, '2022-11-11 02:05:34'),
(1066, 'Santa Isabel', 42, 30, 1, '2022-11-11 02:05:34'),
(1067, 'Suárez', 43, 30, 1, '2022-11-11 02:05:34'),
(1068, 'Valle de San Juan', 44, 30, 1, '2022-11-11 02:05:34'),
(1069, 'Venadillo', 45, 30, 1, '2022-11-11 02:05:34'),
(1070, 'Villahermosa', 46, 30, 1, '2022-11-11 02:05:34'),
(1071, 'Villarrica', 47, 30, 1, '2022-11-11 02:05:34'),
(1072, 'Alcalá', 1, 31, 1, '2022-11-11 02:05:34'),
(1073, 'Andalucía', 2, 31, 1, '2022-11-11 02:05:34'),
(1074, 'Ansermanuevo', 3, 31, 1, '2022-11-11 02:05:34'),
(1075, 'Argelia', 4, 31, 1, '2022-11-11 02:05:34'),
(1076, 'Bolívar', 5, 31, 1, '2022-11-11 02:05:34'),
(1077, 'Buenaventura', 6, 31, 1, '2022-11-11 02:05:34'),
(1078, 'Bugalagrande', 7, 31, 1, '2022-11-11 02:05:34'),
(1079, 'Caicedonia', 8, 31, 1, '2022-11-11 02:05:34'),
(1080, 'Cali', 9, 31, 1, '2022-11-11 02:05:34'),
(1081, 'Calima', 10, 31, 1, '2022-11-11 02:05:34'),
(1082, 'Candelaria', 11, 31, 1, '2022-11-11 02:05:34'),
(1083, 'Cartago', 12, 31, 1, '2022-11-11 02:05:34'),
(1084, 'Dagua', 13, 31, 1, '2022-11-11 02:05:34'),
(1085, 'El Águila', 14, 31, 1, '2022-11-11 02:05:34'),
(1086, 'El Cairo', 15, 31, 1, '2022-11-11 02:05:34'),
(1087, 'El Cerrito', 16, 31, 1, '2022-11-11 02:05:34'),
(1088, 'El Dovio', 17, 31, 1, '2022-11-11 02:05:34'),
(1089, 'Florida', 18, 31, 1, '2022-11-11 02:05:34'),
(1090, 'Ginebra', 19, 31, 1, '2022-11-11 02:05:34'),
(1091, 'Guacarí', 20, 31, 1, '2022-11-11 02:05:34'),
(1092, 'Guadalajara de Buga', 21, 31, 1, '2022-11-11 02:05:34'),
(1093, 'Jamundí', 22, 31, 1, '2022-11-11 02:05:34'),
(1094, 'La Cumbre', 23, 31, 1, '2022-11-11 02:05:34'),
(1095, 'La Unión', 24, 31, 1, '2022-11-11 02:05:34'),
(1096, 'La Victoria', 25, 31, 1, '2022-11-11 02:05:34'),
(1097, 'Obando', 26, 31, 1, '2022-11-11 02:05:34'),
(1098, 'Palmira', 27, 31, 1, '2022-11-11 02:05:34'),
(1099, 'Pradera', 28, 31, 1, '2022-11-11 02:05:34'),
(1100, 'Restrepo', 29, 31, 1, '2022-11-11 02:05:34'),
(1101, 'Riofrío', 30, 31, 1, '2022-11-11 02:05:34'),
(1102, 'Roldanillo', 31, 31, 1, '2022-11-11 02:05:34'),
(1103, 'San Pedro', 32, 31, 1, '2022-11-11 02:05:34'),
(1104, 'Sevilla', 33, 31, 1, '2022-11-11 02:05:34'),
(1105, 'Toro', 34, 31, 1, '2022-11-11 02:05:34'),
(1106, 'Trujillo', 35, 31, 1, '2022-11-11 02:05:34'),
(1107, 'Tuluá', 36, 31, 1, '2022-11-11 02:05:34'),
(1108, 'Ulloa', 37, 31, 1, '2022-11-11 02:05:34'),
(1109, 'Versalles', 38, 31, 1, '2022-11-11 02:05:34'),
(1110, 'Vijes', 39, 31, 1, '2022-11-11 02:05:34'),
(1111, 'Yotoco', 40, 31, 1, '2022-11-11 02:05:34'),
(1112, 'Yumbo', 41, 31, 1, '2022-11-11 02:05:34'),
(1113, 'Zarzal', 42, 31, 1, '2022-11-11 02:05:34'),
(1114, 'Carurú', 1, 32, 1, '2022-11-11 02:05:34'),
(1115, 'Mitú', 2, 32, 1, '2022-11-11 02:05:34'),
(1116, 'Pacoa', 3, 32, 1, '2022-11-11 02:05:34'),
(1117, 'Papunaua', 4, 32, 1, '2022-11-11 02:05:34'),
(1118, 'Taraira', 5, 32, 1, '2022-11-11 02:05:34'),
(1119, 'Yavaraté', 6, 32, 1, '2022-11-11 02:05:34'),
(1120, 'Cumaribo', 1, 33, 1, '2022-11-11 02:05:34'),
(1121, 'La Primavera', 2, 33, 1, '2022-11-11 02:05:34'),
(1122, 'Puerto Carreño', 3, 33, 1, '2022-11-11 02:05:34'),
(1123, 'Santa Rosalía', 4, 33, 1, '2022-11-11 02:05:34');

--
-- Disparadores `municipio`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_municipio` AFTER INSERT ON `municipio` FOR EACH ROW INSERT INTO pinchetas_general._municipio ( 
    muni_id,
    muni_descripcion,
    muni_orden,
    depa_id,
    muni_registradorpor,
    muni_fechacambio,
    operacion 
) 
VALUES ( 
    new.muni_id,
    new.muni_descripcion,
    new.muni_orden,
    new.depa_id,
    new.muni_registradorpor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_municipio` AFTER UPDATE ON `municipio` FOR EACH ROW INSERT INTO pinchetas_general._municipio ( 
    muni_id,
    muni_descripcion,
    muni_orden,
    depa_id,
    muni_registradorpor,
    muni_fechacambio,
    operacion 
) 
VALUES ( 
    new.muni_id,
    new.muni_descripcion,
    new.muni_orden,
    new.depa_id,
    new.muni_registradorpor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `pais_id` bigint(20) NOT NULL,
  `pais_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `pais_codigo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_iso` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_registradopor` bigint(20) NOT NULL,
  `pais_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`pais_id`, `pais_descripcion`, `pais_codigo`, `pais_iso`, `pais_registradopor`, `pais_fechacambio`) VALUES
(1, 'Colombia', '57', 'CO', 1, '0000-00-00 00:00:00');

--
-- Disparadores `pais`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_pais` AFTER INSERT ON `pais` FOR EACH ROW INSERT INTO pinchetas_general._pais ( 
    pais_id,
    pais_descripcion,
    pais_codigo,
    pais_iso,
    pais_registradopor,
    pais_fechacambio,
    operacion 
) 
VALUES ( 
    new.pais_id,
    new.pais_descripcion,
    new.pais_codigo,
    new.pais_iso,
    new.pais_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_pais` AFTER UPDATE ON `pais` FOR EACH ROW INSERT INTO pinchetas_general._pais ( 
    pais_id,
    pais_descripcion,
    pais_codigo,
    pais_iso,
    pais_registradopor,
    pais_fechacambio,
    operacion 
) 
VALUES ( 
    new.pais_id,
    new.pais_descripcion,
    new.pais_codigo,
    new.pais_iso,
    new.pais_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametro`
--

CREATE TABLE `parametro` (
  `para_id` bigint(20) NOT NULL,
  `para_nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `para_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `para_registradopor` bigint(20) NOT NULL,
  `para_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `parametro`
--

INSERT INTO `parametro` (`para_id`, `para_nombre`, `para_descripcion`, `para_registradopor`, `para_fechacambio`) VALUES
(1, 'PARAMETROS PINCHETAS', '_-_', 1, '0000-00-00 00:00:00');

--
-- Disparadores `parametro`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_parametro` AFTER INSERT ON `parametro` FOR EACH ROW INSERT INTO pinchetas_general._parametro ( 
    para_id,
    para_nombre,
    para_descripcion,
    para_registradopor,
    para_fechacambio,
    operacion 
) 
VALUES ( 
    new.para_id,
    new.para_nombre,
    new.para_descripcion,
    new.para_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_parametro` AFTER UPDATE ON `parametro` FOR EACH ROW INSERT INTO pinchetas_general._parametro ( 
    para_id,
    para_nombre,
    para_descripcion,
    para_registradopor,
    para_fechacambio,
    operacion 
) 
VALUES ( 
    new.para_id,
    new.para_nombre,
    new.para_descripcion,
    new.para_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametroano`
--

CREATE TABLE `parametroano` (
  `paan_id` bigint(20) NOT NULL,
  `paan_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `paan_ano` int(11) NOT NULL,
  `paan_valor` text COLLATE utf8_spanish_ci NOT NULL,
  `paan_fechainicio` datetime NOT NULL,
  `paan_fechafin` datetime NOT NULL,
  `para_id` bigint(20) NOT NULL,
  `paan_registradopor` bigint(20) NOT NULL,
  `paan_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `parametroano`
--

INSERT INTO `parametroano` (`paan_id`, `paan_descripcion`, `paan_ano`, `paan_valor`, `paan_fechainicio`, `paan_fechafin`, `para_id`, `paan_registradopor`, `paan_fechacambio`) VALUES
(1, 'RESOLUCION_FACTURA', 2019, 'RES. 18764013936884 DE 02/06/2021', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2020-10-30 17:14:10'),
(2, 'NIT_EMPRESA', 2019, '60288568-0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2020-10-30 17:15:04'),
(3, 'NOMBRE_EMPRESA', 2019, 'ZORAIDA NUÑEZ GONZALEZ', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2020-10-30 16:53:13'),
(4, 'DIRECCION_EMPRESA', 2019, 'CL 5 NRO. 6 - 75 NIÑA CECI', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2020-10-30 16:52:36'),
(5, 'TELEFONO_EMPRESA', 2019, '3212974198', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '0000-00-00 00:00:00'),
(6, 'PREFIJO_CAJA', 2019, 'RI', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2020-10-30 16:53:28'),
(7, 'RANGO_FACTURACION', 2019, 'DE OR 1 A OR 3000', '2019-07-29 11:00:35', '2019-07-29 11:00:35', 1, 1, '2020-10-30 17:12:37'),
(8, 'PREFIJO_CAJA_FE', 2021, 'FES', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '0000-00-00 00:00:00'),
(10, 'RANGO_FACTURACION_FE', 2021, 'DE FES 1 A FES 500', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '0000-00-00 00:00:00');

--
-- Disparadores `parametroano`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_parametroano` AFTER INSERT ON `parametroano` FOR EACH ROW INSERT INTO pinchetas_general._parametroano ( 
    paan_id,
    paan_descripcion,
    paan_ano,
    paan_valor,
    paan_fechainicio,
    paan_fechafin,
    para_id,
    paan_registradopor,
    paan_fechacambio,
    operacion 
) 
VALUES ( 
    new.paan_id,
    new.paan_descripcion,
    new.paan_ano,
    new.paan_valor,
    new.paan_fechainicio,
    new.paan_fechafin,
    new.para_id,
    new.paan_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_parametroano` AFTER UPDATE ON `parametroano` FOR EACH ROW INSERT INTO pinchetas_general._parametroano ( 
    paan_id,
    paan_descripcion,
    paan_ano,
    paan_valor,
    paan_fechainicio,
    paan_fechafin,
    para_id,
    paan_registradopor,
    paan_fechacambio,
    operacion 
) 
VALUES ( 
    new.paan_id,
    new.paan_descripcion,
    new.paan_ano,
    new.paan_valor,
    new.paan_fechainicio,
    new.paan_fechafin,
    new.para_id,
    new.paan_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personageneral`
--

CREATE TABLE `personageneral` (
  `pege_id` bigint(255) NOT NULL,
  `pege_documento` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tido_id` bigint(255) DEFAULT NULL,
  `pege_direccion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_telefono` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_correo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `muni_id` bigint(20) DEFAULT NULL,
  `pege_registradopor` bigint(20) NOT NULL,
  `pege_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `personageneral`
--

INSERT INTO `personageneral` (`pege_id`, `pege_documento`, `tido_id`, `pege_direccion`, `pege_telefono`, `pege_correo`, `muni_id`, `pege_registradopor`, `pege_fechacambio`) VALUES
(1, '1090484833', 1, NULL, NULL, NULL, NULL, 1, '2018-11-13 00:00:00'),
(40, '1234', NULL, NULL, NULL, NULL, NULL, 1, '2022-11-02 18:09:23');

--
-- Disparadores `personageneral`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_personageneral` AFTER INSERT ON `personageneral` FOR EACH ROW INSERT INTO pinchetas_general._personageneral ( 
    pege_id,
    pege_documento,
    tido_id,
    pege_direccion,
    pege_telefono,
    pege_correo,
    muni_id,
    pege_registradopor,
    pege_fechacambio,
    operacion 
) 
VALUES ( 
    new.pege_id,
    new.pege_documento,
    new.tido_id,
    new.pege_direccion,
    new.pege_telefono,
    new.pege_correo,
    new.muni_id,
    new.pege_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_personageneral` AFTER UPDATE ON `personageneral` FOR EACH ROW INSERT INTO pinchetas_general._personageneral ( 
    pege_id,
    pege_documento,
    tido_id,
    pege_direccion,
    pege_telefono,
    pege_correo,
    muni_id,
    pege_registradopor,
    pege_fechacambio,
    operacion 
) 
VALUES ( 
    new.pege_id,
    new.pege_documento,
    new.tido_id,
    new.pege_direccion,
    new.pege_telefono,
    new.pege_correo,
    new.muni_id,
    new.pege_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajuridica`
--

CREATE TABLE `personajuridica` (
  `peju_id` bigint(20) NOT NULL,
  `peju_razonsocial` text COLLATE utf8_spanish_ci NOT NULL,
  `peju_nombrerepresentante` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `peju_codigodane` bigint(20) DEFAULT NULL,
  `pege_id` bigint(20) NOT NULL,
  `peju_registradorpor` bigint(20) NOT NULL,
  `peju_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `personajuridica`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_personajuridica` AFTER INSERT ON `personajuridica` FOR EACH ROW INSERT INTO pinchetas_general._personajuridica ( 
    peju_id,
    peju_razonsocial,
    peju_nombrerepresentante,
    peju_codigodane,
    pege_id,
    peju_registradorpor,
    peju_fechacambio,
    operacion 
) 
VALUES ( 
    new.peju_id,
    new.peju_razonsocial,
    new.peju_nombrerepresentante,
    new.peju_codigodane,
    new.pege_id,
    new.peju_registradorpor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_personajuridica` AFTER UPDATE ON `personajuridica` FOR EACH ROW INSERT INTO pinchetas_general._personajuridica ( 
    peju_id,
    peju_razonsocial,
    peju_nombrerepresentante,
    peju_codigodane,
    pege_id,
    peju_registradorpor,
    peju_fechacambio,
    operacion 
) 
VALUES ( 
    new.peju_id,
    new.peju_razonsocial,
    new.peju_nombrerepresentante,
    new.peju_codigodane,
    new.pege_id,
    new.peju_registradorpor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personanatural`
--

CREATE TABLE `personanatural` (
  `pena_id` bigint(20) NOT NULL,
  `pena_documento` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_primernombre` text COLLATE utf8_spanish_ci NOT NULL,
  `pena_segundonombre` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_primerapellido` text COLLATE utf8_spanish_ci NOT NULL,
  `pena_segundoapellido` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_fechanacimiento` date DEFAULT NULL,
  `pena_sexo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_foto` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_id` bigint(20) NOT NULL,
  `ciud_id` bigint(20) NOT NULL,
  `pena_registradopor` bigint(20) NOT NULL,
  `pena_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `personanatural`
--

INSERT INTO `personanatural` (`pena_id`, `pena_documento`, `pena_primernombre`, `pena_segundonombre`, `pena_primerapellido`, `pena_segundoapellido`, `pena_fechanacimiento`, `pena_sexo`, `pena_foto`, `pege_id`, `ciud_id`, `pena_registradopor`, `pena_fechacambio`) VALUES
(1, '1090484833', 'Victor', 'Hernando', 'Gualdron', 'Ruiz', '1995-01-23', 'M', NULL, 1, 0, 1, '2019-03-25 04:41:53'),
(38, '1234', 'nombre', '', 'apellido', NULL, NULL, NULL, NULL, 40, 0, 1, '2022-11-02 18:09:23');

--
-- Disparadores `personanatural`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_personanatural` AFTER INSERT ON `personanatural` FOR EACH ROW INSERT INTO pinchetas_general._personanatural ( 
    pena_id,
    pena_documento,
    pena_primernombre,
    pena_segundonombre,
    pena_primerapellido,
    pena_segundoapellido,
    pena_fechanacimiento,
    pena_sexo,
    pena_foto,
    pege_id,
    ciud_id,
    pena_registradopor,
    pena_fechacambio,
    operacion 
) 
VALUES ( 
    new.pena_id,
    new.pena_documento,
    new.pena_primernombre,
    new.pena_segundonombre,
    new.pena_primerapellido,
    new.pena_segundoapellido,
    new.pena_fechanacimiento,
    new.pena_sexo,
    new.pena_foto,
    new.pege_id,
    new.ciud_id,
    new.pena_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_personanatural` AFTER UPDATE ON `personanatural` FOR EACH ROW INSERT INTO pinchetas_general._personanatural ( 
    pena_id,
    pena_documento,
    pena_primernombre,
    pena_segundonombre,
    pena_primerapellido,
    pena_segundoapellido,
    pena_fechanacimiento,
    pena_sexo,
    pena_foto,
    pege_id,
    ciud_id,
    pena_registradopor,
    pena_fechacambio,
    operacion 
) 
VALUES ( 
    new.pena_id,
    new.pena_documento,
    new.pena_primernombre,
    new.pena_segundonombre,
    new.pena_primerapellido,
    new.pena_segundoapellido,
    new.pena_fechanacimiento,
    new.pena_sexo,
    new.pena_foto,
    new.pege_id,
    new.ciud_id,
    new.pena_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte`
--

CREATE TABLE `reporte` (
  `repo_id` bigint(20) DEFAULT NULL,
  `repo_nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `repo_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `repo_sql` text COLLATE utf8_spanish_ci NOT NULL,
  `repo_tipo` text COLLATE utf8_spanish_ci NOT NULL,
  `anle_id` bigint(20) DEFAULT NULL,
  `repo_registradopor` bigint(20) DEFAULT NULL,
  `repo_fechacambio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reporte`
--

INSERT INTO `reporte` (`repo_id`, `repo_nombre`, `repo_descripcion`, `repo_sql`, `repo_tipo`, `anle_id`, `repo_registradopor`, `repo_fechacambio`) VALUES
(1, 'LISTAR CLIENTES', 'reporte que muestra la lista de los clientes que estan registrados en el sistema', 'Select distinct\r\npedi_nombrecliente AS NOMBRE,\r\npedi_telefonocliente AS TELEFONO,\r\npedi_direccioncliente AS DIRECCION\r\nfrom pinchetas_restaurante.pedido pedi\r\nWHERE pedi_nombrecliente is not null\r\nAND pedi_nombrecliente != \'\';', 'CSV', 2019, 1, '0000-00-00 00:00:00');

--
-- Disparadores `reporte`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_reporte` AFTER INSERT ON `reporte` FOR EACH ROW INSERT INTO pinchetas_general._reporte ( 
    repo_id,
    repo_nombre,
    repo_descripcion,
    repo_sql,
    repo_tipo,
    anle_id,
    repo_registradopor,
    repo_fechacambio,
    operacion 
) 
VALUES ( 
    new.repo_id,
    new.repo_nombre,
    new.repo_descripcion,
    new.repo_sql,
    new.repo_tipo,
    new.anle_id,
    new.repo_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_reporte` AFTER UPDATE ON `reporte` FOR EACH ROW INSERT INTO pinchetas_general._reporte ( 
    repo_id,
    repo_nombre,
    repo_descripcion,
    repo_sql,
    repo_tipo,
    anle_id,
    repo_registradopor,
    repo_fechacambio,
    operacion 
) 
VALUES ( 
    new.repo_id,
    new.repo_nombre,
    new.repo_descripcion,
    new.repo_sql,
    new.repo_tipo,
    new.anle_id,
    new.repo_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` bigint(20) NOT NULL,
  `rol_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `rol_orden` bigint(20) DEFAULT NULL,
  `rol_visible` text COLLATE utf8_spanish_ci NOT NULL,
  `rol_registradopor` bigint(20) NOT NULL,
  `rol_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_descripcion`, `rol_orden`, `rol_visible`, `rol_registradopor`, `rol_fechacambio`) VALUES
(1, 'administrador dev.', 1, 'NO', 1, '2019-03-10 15:21:25'),
(2, 'cajero', 3, 'SI', 1, '2018-12-07 00:00:00'),
(5, 'administrador', 2, 'SI', 1, '2019-03-10 00:00:00'),
(7, 'mesero', 4, 'SI', 1, '2019-03-11 02:11:59'),
(9, 'cliente', 5, 'SI', 1, '0000-00-00 00:00:00');

--
-- Disparadores `rol`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_rol` AFTER INSERT ON `rol` FOR EACH ROW INSERT INTO pinchetas_general._rol ( 
    rol_id,
    rol_descripcion,
    rol_orden,
    rol_visible,
    rol_registradopor,
    rol_fechacambio,
    operacion 
) 
VALUES ( 
    new.rol_id,
    new.rol_descripcion,
    new.rol_orden,
    new.rol_visible,
    new.rol_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_rol` AFTER UPDATE ON `rol` FOR EACH ROW INSERT INTO pinchetas_general._rol ( 
    rol_id,
    rol_descripcion,
    rol_orden,
    rol_visible,
    rol_registradopor,
    rol_fechacambio,
    operacion 
) 
VALUES ( 
    new.rol_id,
    new.rol_descripcion,
    new.rol_orden,
    new.rol_visible,
    new.rol_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolfuncionalidad`
--

CREATE TABLE `rolfuncionalidad` (
  `rofu_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `func_id` bigint(20) NOT NULL,
  `apli_id` bigint(20) NOT NULL,
  `rofu_registradopor` bigint(20) NOT NULL,
  `rofu_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rolfuncionalidad`
--

INSERT INTO `rolfuncionalidad` (`rofu_id`, `rol_id`, `func_id`, `apli_id`, `rofu_registradopor`, `rofu_fechacambio`) VALUES
(349, 1, 16, 1, 1, '2022-11-02 18:01:57'),
(350, 1, 33, 1, 1, '2022-11-02 18:01:57'),
(351, 1, 15, 1, 1, '2022-11-02 18:01:57'),
(352, 1, 32, 1, 1, '2022-11-02 18:01:57'),
(353, 1, 11, 1, 1, '2022-11-02 18:01:57'),
(354, 1, 25, 2, 1, '2022-11-02 18:02:18'),
(355, 1, 31, 2, 1, '2022-11-02 18:02:18'),
(356, 1, 30, 2, 1, '2022-11-02 18:02:18'),
(357, 1, 39, 2, 1, '2022-11-02 18:02:18'),
(358, 1, 23, 2, 1, '2022-11-02 18:02:18'),
(359, 1, 18, 2, 1, '2022-11-02 18:02:18'),
(360, 1, 22, 2, 1, '2022-11-02 18:02:18'),
(361, 1, 20, 2, 1, '2022-11-02 18:02:18'),
(362, 1, 21, 2, 1, '2022-11-02 18:02:18'),
(363, 1, 26, 2, 1, '2022-11-02 18:02:18'),
(364, 1, 38, 2, 1, '2022-11-02 18:02:18'),
(365, 1, 19, 2, 1, '2022-11-02 18:02:18'),
(366, 1, 35, 4, 1, '2022-11-02 18:02:30'),
(367, 1, 29, 4, 1, '2022-11-02 18:02:30'),
(368, 1, 27, 4, 1, '2022-11-02 18:02:30'),
(369, 5, 33, 1, 1, '2022-11-02 18:03:24'),
(370, 5, 32, 1, 1, '2022-11-02 18:03:24'),
(380, 5, 35, 4, 1, '2022-11-02 18:04:29'),
(381, 5, 29, 4, 1, '2022-11-02 18:04:29'),
(382, 5, 27, 4, 1, '2022-11-02 18:04:29'),
(383, 2, 25, 2, 1, '2022-11-02 18:05:25'),
(384, 2, 31, 2, 1, '2022-11-02 18:05:25'),
(385, 2, 18, 2, 1, '2022-11-02 18:05:25'),
(386, 2, 21, 2, 1, '2022-11-02 18:05:25'),
(387, 2, 26, 2, 1, '2022-11-02 18:05:25'),
(388, 2, 19, 2, 1, '2022-11-02 18:05:25'),
(389, 2, 23, 2, 1, '2022-11-02 18:05:25'),
(390, 2, 22, 2, 1, '2022-11-02 18:05:25'),
(391, 2, 35, 4, 1, '2022-11-02 18:05:47'),
(392, 2, 29, 4, 1, '2022-11-02 18:05:47'),
(393, 2, 27, 4, 1, '2022-11-02 18:05:47'),
(394, 7, 27, 4, 1, '2022-11-02 18:06:00'),
(395, 5, 25, 2, 1, '2022-11-05 13:15:50'),
(396, 5, 31, 2, 1, '2022-11-05 13:15:50'),
(397, 5, 39, 2, 1, '2022-11-05 13:15:50'),
(398, 5, 23, 2, 1, '2022-11-05 13:15:50'),
(399, 5, 18, 2, 1, '2022-11-05 13:15:50'),
(400, 5, 22, 2, 1, '2022-11-05 13:15:50'),
(401, 5, 21, 2, 1, '2022-11-05 13:15:50'),
(402, 5, 26, 2, 1, '2022-11-05 13:15:50'),
(403, 5, 19, 2, 1, '2022-11-05 13:15:50'),
(404, 5, 38, 2, 1, '2022-11-05 13:15:50');

--
-- Disparadores `rolfuncionalidad`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_rolfuncionalidad` AFTER INSERT ON `rolfuncionalidad` FOR EACH ROW INSERT INTO pinchetas_general._rolfuncionalidad ( 
    rofu_id,
    rol_id,
    func_id,
    apli_id,
    rofu_registradopor,
    rofu_fechacambio,
    operacion 
) 
VALUES ( 
    new.rofu_id,
    new.rol_id,
    new.func_id,
    new.apli_id,
    new.rofu_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_rolfuncionalidad` AFTER UPDATE ON `rolfuncionalidad` FOR EACH ROW INSERT INTO pinchetas_general._rolfuncionalidad ( 
    rofu_id,
    rol_id,
    func_id,
    apli_id,
    rofu_registradopor,
    rofu_fechacambio,
    operacion 
) 
VALUES ( 
    new.rofu_id,
    new.rol_id,
    new.func_id,
    new.apli_id,
    new.rofu_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `tido_id` bigint(20) NOT NULL,
  `tido_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `tido_abreviatura` text COLLATE utf8_spanish_ci NOT NULL,
  `tido_orden` bigint(20) DEFAULT NULL,
  `tido_regisradopor` bigint(20) NOT NULL,
  `tido_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`tido_id`, `tido_descripcion`, `tido_abreviatura`, `tido_orden`, `tido_regisradopor`, `tido_fechacambio`) VALUES
(1, 'Cédula de Ciudadanía', 'CC', 2, 1, '2018-11-13 00:00:00'),
(5, 'Número de identificación tributaria', 'NIT', 1, 1, '0000-00-00 00:00:00'),
(6, 'NIT de otro país', 'FOREIGN_NIT', 3, 1, '0000-00-00 00:00:00'),
(7, 'Pasaporte', 'PP', 4, 1, '0000-00-00 00:00:00'),
(8, 'Permiso especial de permanencia', 'PEP', 5, 1, '0000-00-00 00:00:00'),
(9, 'Documento de identificación extranjero', 'DIE', 6, 1, '0000-00-00 00:00:00'),
(10, 'Cédula de extranjería', 'CE', 7, 1, '0000-00-00 00:00:00'),
(11, 'Tarjeta de extranjería', 'TE', 8, 1, '0000-00-00 00:00:00'),
(12, 'Tarjeta de identidad', 'TE', 9, 1, '0000-00-00 00:00:00'),
(13, 'Registro civil', 'RC', 10, 1, '0000-00-00 00:00:00'),
(14, 'Número único de identificación personal', 'NUIP', 11, 1, '0000-00-00 00:00:00');

--
-- Disparadores `tipodocumento`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_tipodocumento` AFTER INSERT ON `tipodocumento` FOR EACH ROW INSERT INTO pinchetas_general._tipodocumento ( 
    tido_id,
    tido_descripcion,
    tido_abreviatura,
    tido_orden,
    tido_regisradopor,
    tido_fechacambio,
    operacion 
) 
VALUES ( 
    new.tido_id,
    new.tido_descripcion,
    new.tido_abreviatura,
    new.tido_orden,
    new.tido_regisradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_tipodocumento` AFTER UPDATE ON `tipodocumento` FOR EACH ROW INSERT INTO pinchetas_general._tipodocumento ( 
    tido_id,
    tido_descripcion,
    tido_abreviatura,
    tido_orden,
    tido_regisradopor,
    tido_fechacambio,
    operacion 
) 
VALUES ( 
    new.tido_id,
    new.tido_descripcion,
    new.tido_abreviatura,
    new.tido_orden,
    new.tido_regisradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usua_id` bigint(20) NOT NULL,
  `usua_cuenta` text COLLATE utf8_spanish_ci NOT NULL,
  `usua_clave` text COLLATE utf8_spanish_ci NOT NULL,
  `pege_id` bigint(20) NOT NULL,
  `usua_registradopor` bigint(20) NOT NULL,
  `usua_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usua_id`, `usua_cuenta`, `usua_clave`, `pege_id`, `usua_registradopor`, `usua_fechacambio`) VALUES
(1, '1090484833', '13171638', 1, 1, '2018-07-06 00:00:00'),
(37, '1234', '1234', 40, 1, '2022-11-02 18:09:23');

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_usuario` AFTER INSERT ON `usuario` FOR EACH ROW INSERT INTO pinchetas_general._usuario ( 
    usua_id,
    usua_cuenta,
    usua_clave,
    pege_id,
    usua_registradopor,
    usua_fechacambio,
    operacion 
) 
VALUES ( 
    new.usua_id,
    new.usua_cuenta,
    new.usua_clave,
    new.pege_id,
    new.usua_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_usuario` AFTER UPDATE ON `usuario` FOR EACH ROW INSERT INTO pinchetas_general._usuario ( 
    usua_id,
    usua_cuenta,
    usua_clave,
    pege_id,
    usua_registradopor,
    usua_fechacambio,
    operacion 
) 
VALUES ( 
    new.usua_id,
    new.usua_cuenta,
    new.usua_clave,
    new.pege_id,
    new.usua_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariorol`
--

CREATE TABLE `usuariorol` (
  `usro_id` bigint(20) NOT NULL,
  `usua_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `usro_registradopor` bigint(20) NOT NULL,
  `usro_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuariorol`
--

INSERT INTO `usuariorol` (`usro_id`, `usua_id`, `rol_id`, `usro_registradopor`, `usro_fechacambio`) VALUES
(1, 1, 1, 1, '2018-11-21 00:00:00'),
(77, 37, 5, 1, '2022-11-02 18:09:55');

--
-- Disparadores `usuariorol`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_usuariorol` AFTER INSERT ON `usuariorol` FOR EACH ROW INSERT INTO pinchetas_general._usuariorol ( 
    usro_id,
    usua_id,
    rol_id,
    usro_registradopor,
    usro_fechacambio,
    operacion 
) 
VALUES ( 
    new.usro_id,
    new.usua_id,
    new.rol_id,
    new.usro_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_usuariorol` AFTER UPDATE ON `usuariorol` FOR EACH ROW INSERT INTO pinchetas_general._usuariorol ( 
    usro_id,
    usua_id,
    rol_id,
    usro_registradopor,
    usro_fechacambio,
    operacion 
) 
VALUES ( 
    new.usro_id,
    new.usua_id,
    new.rol_id,
    new.usro_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_aplicacion`
--

CREATE TABLE `_aplicacion` (
  `apli_id` bigint(20) DEFAULT NULL,
  `apli_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `apli_url` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `apli_icono` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `apli_orden` bigint(20) DEFAULT NULL,
  `apli_registradopor` bigint(20) DEFAULT NULL,
  `apli_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_departamento`
--

CREATE TABLE `_departamento` (
  `depa_id` bigint(20) DEFAULT NULL,
  `depa_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `depa_orden` bigint(20) DEFAULT NULL,
  `pais_id` bigint(20) DEFAULT NULL,
  `depa_registradopor` bigint(20) DEFAULT NULL,
  `depa_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_departamento`
--

INSERT INTO `_departamento` (`depa_id`, `depa_descripcion`, `depa_orden`, `pais_id`, `depa_registradopor`, `depa_fechacambio`, `operacion`) VALUES
(1, 'Amazonas', 1, 1, 1, '2022-11-10 11:24:02', 'I'),
(2, 'Antioquia', 2, 1, 1, '2022-11-10 11:24:02', 'I'),
(3, 'Arauca', 3, 1, 1, '2022-11-10 11:24:02', 'I'),
(4, 'Atlántico', 4, 1, 1, '2022-11-10 11:24:02', 'I'),
(5, 'Bogotá, D.C.', 5, 1, 1, '2022-11-10 11:24:02', 'I'),
(6, 'Bolívar', 6, 1, 1, '2022-11-10 11:24:02', 'I'),
(7, 'Boyacá', 7, 1, 1, '2022-11-10 11:24:02', 'I'),
(8, 'Caldas', 8, 1, 1, '2022-11-10 11:24:02', 'I'),
(9, 'Caquetá', 9, 1, 1, '2022-11-10 11:24:02', 'I'),
(10, 'Casanare', 10, 1, 1, '2022-11-10 11:24:02', 'I'),
(11, 'Cauca', 11, 1, 1, '2022-11-10 11:24:02', 'I'),
(12, 'Cesar', 12, 1, 1, '2022-11-10 11:24:02', 'I'),
(13, 'Chocó', 13, 1, 1, '2022-11-10 11:24:02', 'I'),
(14, 'Córdoba', 14, 1, 1, '2022-11-10 11:24:02', 'I'),
(15, 'Cundinamarca', 15, 1, 1, '2022-11-10 11:24:02', 'I'),
(16, 'Guainia', 16, 1, 1, '2022-11-10 11:24:02', 'I'),
(17, 'Guaviare', 17, 1, 1, '2022-11-10 11:24:02', 'I'),
(18, 'Huila', 18, 1, 1, '2022-11-10 11:24:02', 'I'),
(19, 'La Guajira', 19, 1, 1, '2022-11-10 11:24:02', 'I'),
(20, 'Magdalena', 20, 1, 1, '2022-11-10 11:24:02', 'I'),
(21, 'Meta', 21, 1, 1, '2022-11-10 11:24:02', 'I'),
(22, 'N. de Santander', 22, 1, 1, '2022-11-10 11:24:02', 'I'),
(23, 'Nariño', 23, 1, 1, '2022-11-10 11:24:02', 'I'),
(24, 'Putumayo', 24, 1, 1, '2022-11-10 11:24:02', 'I'),
(25, 'Quindío', 25, 1, 1, '2022-11-10 11:24:02', 'I'),
(26, 'Risaralda', 26, 1, 1, '2022-11-10 11:24:02', 'I'),
(27, 'San Andrés', 27, 1, 1, '2022-11-10 11:24:02', 'I'),
(28, 'Santander', 28, 1, 1, '2022-11-10 11:24:02', 'I'),
(29, 'Sucre', 29, 1, 1, '2022-11-10 11:24:02', 'I'),
(30, 'Tolima', 30, 1, 1, '2022-11-10 11:24:02', 'I'),
(31, 'Valle del Cauca', 31, 1, 1, '2022-11-10 11:24:02', 'I'),
(32, 'Vaupés', 32, 1, 1, '2022-11-10 11:24:02', 'I'),
(33, 'Vichada', 33, 1, 1, '2022-11-10 11:24:02', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_funcionalidad`
--

CREATE TABLE `_funcionalidad` (
  `func_id` bigint(20) DEFAULT NULL,
  `func_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `func_tipo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `func_url` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `func_icono` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `func_orden` bigint(20) DEFAULT NULL,
  `apli_id` bigint(20) DEFAULT NULL,
  `func_idpadre` bigint(20) DEFAULT NULL,
  `func_registradopor` bigint(20) DEFAULT NULL,
  `func_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_funcionalidad`
--

INSERT INTO `_funcionalidad` (`func_id`, `func_descripcion`, `func_tipo`, `func_url`, `func_icono`, `func_orden`, `apli_id`, `func_idpadre`, `func_registradopor`, `func_fechacambio`, `operacion`) VALUES
(34, 'ASIGNAR ROL A USUARIO', 'FUNCIONALIDAD', '/CALL procedimiento_eliminar_rol(?, ?);/', 'fa fa-address-card-o', 6, 1, NULL, 1, '2022-11-02 16:17:48', 'U'),
(33, 'Gestionar cuenta de usuario', 'FUNCIONALIDAD', '/cuentausuario/', 'fa fa-lock', 5, 1, NULL, 1, '2022-11-02 17:44:30', 'U'),
(33, 'CUENTAS DE USUARIO', 'FUNCIONALIDAD', '/cuentausuario/', 'fa fa-lock', 5, 1, NULL, 1, '2022-11-02 17:45:11', 'U'),
(33, 'CUENTAS USUARIO', 'FUNCIONALIDAD', '/cuentausuario/', 'fa fa-lock', 5, 1, NULL, 1, '2022-11-02 17:45:51', 'U'),
(30, 'COPIA FACTURA', 'FUNCIONALIDAD', '/copiafactura/', 'fa fa-file-text-o', 4, 2, NULL, 1, '2022-11-02 17:46:19', 'U'),
(22, 'GEST. PRODUCTOS', 'FUNCIONALIDAD', '/producto/', '', 5, 2, NULL, 1, '2022-11-02 17:46:41', 'U'),
(22, 'GEST. PRODUCTOS', 'FUNCIONALIDAD', '/producto/', 'fa fa-product-hunt', 5, 2, NULL, 1, '2022-11-02 17:49:27', 'U'),
(19, 'TIPO PRODUCTO', 'FUNCIONALIDAD', '/tipoproducto/', 'fa fa-check-circle-o ', 6, 2, NULL, 1, '2022-11-02 17:49:51', 'U'),
(23, 'DEPE. DE PRODUCTO', 'FUNCIONALIDAD', '/dependenciaproducto/', 'fa fa-refresh', 7, 2, NULL, 1, '2022-11-02 17:51:15', 'U'),
(25, 'CARGAR STOCK ', 'FUNCIONALIDAD', '/cargarstock/', 'fa fa-upload', 8, 2, NULL, 1, '2022-11-02 17:52:04', 'U'),
(26, 'LISTAR STOCK', 'FUNCIONALIDAD', '/listarstock/', 'fa fa-list-ol', 10, 2, NULL, 1, '2022-11-02 17:52:41', 'U'),
(38, 'REPORTES', 'FUNCIONALIDAD', '/verreportes/', 'fa fa-file-excel-o', 99, 2, NULL, 1, '2022-11-02 17:53:21', 'U'),
(35, 'ABRIR CAJA', 'FUNCIONALIDAD', '/openbox/', 'fa fa-dropbox', 0, 4, NULL, 1, '2022-11-02 17:55:08', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_ingresousuario`
--

CREATE TABLE `_ingresousuario` (
  `inus_id` bigint(20) DEFAULT NULL,
  `usua_id` bigint(20) DEFAULT NULL,
  `inus_usuario` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `inus_clave` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `inus_return` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `inus_fechacambio` datetime DEFAULT NULL,
  `inus_registradopor` bigint(20) DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_municipio`
--

CREATE TABLE `_municipio` (
  `muni_id` bigint(20) DEFAULT NULL,
  `muni_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `muni_orden` bigint(20) DEFAULT NULL,
  `depa_id` bigint(20) DEFAULT NULL,
  `muni_registradorpor` bigint(20) DEFAULT NULL,
  `muni_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_municipio`
--

INSERT INTO `_municipio` (`muni_id`, `muni_descripcion`, `muni_orden`, `depa_id`, `muni_registradorpor`, `muni_fechacambio`, `operacion`) VALUES
(4, 'fdsdf', 1, 1, 1, '2022-11-10 11:35:18', 'I'),
(1, 'vbbvc', 1, 1, 1, '2022-11-10 11:36:09', 'I'),
(1, 'El Encanto', 1, 1, 1, '2022-11-11 15:35:53', 'I'),
(2, 'La Chorrera', 2, 1, 1, '2022-11-11 15:35:53', 'I'),
(3, 'La Pedrera', 3, 1, 1, '2022-11-11 15:35:53', 'I'),
(4, 'La Victoria', 4, 1, 1, '2022-11-11 15:35:53', 'I'),
(5, 'Leticia', 5, 1, 1, '2022-11-11 15:35:53', 'I'),
(6, 'Miriti - Paraná', 6, 1, 1, '2022-11-11 15:35:53', 'I'),
(7, 'Puerto Alegría', 7, 1, 1, '2022-11-11 15:35:53', 'I'),
(8, 'Puerto Arica', 8, 1, 1, '2022-11-11 15:35:53', 'I'),
(9, 'Puerto Nariño', 9, 1, 1, '2022-11-11 15:35:53', 'I'),
(10, 'Puerto Santander', 10, 1, 1, '2022-11-11 15:35:53', 'I'),
(11, 'Tarapacá', 11, 1, 1, '2022-11-11 15:35:53', 'I'),
(12, 'Abejorral', 1, 2, 1, '2022-11-11 15:35:53', 'I'),
(13, 'Abriaquí', 2, 2, 1, '2022-11-11 15:35:53', 'I'),
(14, 'Alejandría', 3, 2, 1, '2022-11-11 15:35:53', 'I'),
(15, 'Amagá', 4, 2, 1, '2022-11-11 15:35:53', 'I'),
(16, 'Amalfi', 5, 2, 1, '2022-11-11 15:35:53', 'I'),
(17, 'Andes', 6, 2, 1, '2022-11-11 15:35:53', 'I'),
(18, 'Angelópolis', 7, 2, 1, '2022-11-11 15:35:53', 'I'),
(19, 'Angostura', 8, 2, 1, '2022-11-11 15:35:53', 'I'),
(20, 'Anorí', 9, 2, 1, '2022-11-11 15:35:53', 'I'),
(21, 'Anzá', 10, 2, 1, '2022-11-11 15:35:53', 'I'),
(22, 'Apartadó', 11, 2, 1, '2022-11-11 15:35:53', 'I'),
(23, 'Arboletes', 12, 2, 1, '2022-11-11 15:35:53', 'I'),
(24, 'Argelia', 13, 2, 1, '2022-11-11 15:35:53', 'I'),
(25, 'Armenia', 14, 2, 1, '2022-11-11 15:35:53', 'I'),
(26, 'Barbosa', 15, 2, 1, '2022-11-11 15:35:53', 'I'),
(27, 'Bello', 16, 2, 1, '2022-11-11 15:35:53', 'I'),
(28, 'Belmira', 17, 2, 1, '2022-11-11 15:35:53', 'I'),
(29, 'Betania', 18, 2, 1, '2022-11-11 15:35:53', 'I'),
(30, 'Betulia', 19, 2, 1, '2022-11-11 15:35:53', 'I'),
(31, 'Briceño', 20, 2, 1, '2022-11-11 15:35:53', 'I'),
(32, 'Buriticá', 21, 2, 1, '2022-11-11 15:35:53', 'I'),
(33, 'Cáceres', 22, 2, 1, '2022-11-11 15:35:53', 'I'),
(34, 'Caicedo', 23, 2, 1, '2022-11-11 15:35:53', 'I'),
(35, 'Caldas', 24, 2, 1, '2022-11-11 15:35:53', 'I'),
(36, 'Campamento', 25, 2, 1, '2022-11-11 15:35:53', 'I'),
(37, 'Caracolí', 26, 2, 1, '2022-11-11 15:35:53', 'I'),
(38, 'Caramanta', 27, 2, 1, '2022-11-11 15:35:53', 'I'),
(39, 'Carepa', 28, 2, 1, '2022-11-11 15:35:53', 'I'),
(40, 'Carolina', 29, 2, 1, '2022-11-11 15:35:53', 'I'),
(41, 'Caucasia', 30, 2, 1, '2022-11-11 15:35:53', 'I'),
(42, 'Cañasgordas', 31, 2, 1, '2022-11-11 15:35:53', 'I'),
(43, 'Chigorodó', 32, 2, 1, '2022-11-11 15:35:53', 'I'),
(44, 'Cisneros', 33, 2, 1, '2022-11-11 15:35:53', 'I'),
(45, 'Ciudad Bolivar', 34, 2, 1, '2022-11-11 15:35:53', 'I'),
(46, 'Cocorná', 35, 2, 1, '2022-11-11 15:35:53', 'I'),
(47, 'Concepción', 36, 2, 1, '2022-11-11 15:35:53', 'I'),
(48, 'Concordia', 37, 2, 1, '2022-11-11 15:35:53', 'I'),
(49, 'Copacabana', 38, 2, 1, '2022-11-11 15:35:53', 'I'),
(50, 'Dabeiba', 39, 2, 1, '2022-11-11 15:35:53', 'I'),
(51, 'Don Matías', 40, 2, 1, '2022-11-11 15:35:53', 'I'),
(52, 'Ebéjico', 41, 2, 1, '2022-11-11 15:35:53', 'I'),
(53, 'El Bagre', 42, 2, 1, '2022-11-11 15:35:53', 'I'),
(54, 'El Carmen de Viboral', 43, 2, 1, '2022-11-11 15:35:53', 'I'),
(55, 'El Santuario', 44, 2, 1, '2022-11-11 15:35:53', 'I'),
(56, 'Entrerrios', 45, 2, 1, '2022-11-11 15:35:53', 'I'),
(57, 'Envigado', 46, 2, 1, '2022-11-11 15:35:53', 'I'),
(58, 'Fredonia', 47, 2, 1, '2022-11-11 15:35:53', 'I'),
(59, 'Frontino', 48, 2, 1, '2022-11-11 15:35:53', 'I'),
(60, 'Giraldo', 49, 2, 1, '2022-11-11 15:35:53', 'I'),
(61, 'Girardota', 50, 2, 1, '2022-11-11 15:35:53', 'I'),
(62, 'Gómez Plata', 51, 2, 1, '2022-11-11 15:35:53', 'I'),
(63, 'Granada', 52, 2, 1, '2022-11-11 15:35:53', 'I'),
(64, 'Guadalupe', 53, 2, 1, '2022-11-11 15:35:53', 'I'),
(65, 'Guarne', 54, 2, 1, '2022-11-11 15:35:53', 'I'),
(66, 'Guatapé', 55, 2, 1, '2022-11-11 15:35:53', 'I'),
(67, 'Heliconia', 56, 2, 1, '2022-11-11 15:35:53', 'I'),
(68, 'Hispania', 57, 2, 1, '2022-11-11 15:35:53', 'I'),
(69, 'Itagüí', 58, 2, 1, '2022-11-11 15:35:53', 'I'),
(70, 'Ituango', 59, 2, 1, '2022-11-11 15:35:53', 'I'),
(71, 'Jardín', 60, 2, 1, '2022-11-11 15:35:53', 'I'),
(72, 'Jericó', 61, 2, 1, '2022-11-11 15:35:53', 'I'),
(73, 'La Ceja', 62, 2, 1, '2022-11-11 15:35:53', 'I'),
(74, 'La Estrella', 63, 2, 1, '2022-11-11 15:35:53', 'I'),
(75, 'La Pintada', 64, 2, 1, '2022-11-11 15:35:53', 'I'),
(76, 'La Unión', 65, 2, 1, '2022-11-11 15:35:53', 'I'),
(77, 'Liborina', 66, 2, 1, '2022-11-11 15:35:53', 'I'),
(78, 'Maceo', 67, 2, 1, '2022-11-11 15:35:53', 'I'),
(79, 'Marinilla', 68, 2, 1, '2022-11-11 15:35:53', 'I'),
(80, 'Medellín', 69, 2, 1, '2022-11-11 15:35:53', 'I'),
(81, 'Montebello', 70, 2, 1, '2022-11-11 15:35:53', 'I'),
(82, 'Murindó', 71, 2, 1, '2022-11-11 15:35:53', 'I'),
(83, 'Mutatá', 72, 2, 1, '2022-11-11 15:35:53', 'I'),
(84, 'Nariño', 73, 2, 1, '2022-11-11 15:35:53', 'I'),
(85, 'Nechí', 74, 2, 1, '2022-11-11 15:35:53', 'I'),
(86, 'Necoclí', 75, 2, 1, '2022-11-11 15:35:53', 'I'),
(87, 'Olaya', 76, 2, 1, '2022-11-11 15:35:53', 'I'),
(88, 'Peque', 77, 2, 1, '2022-11-11 15:35:53', 'I'),
(89, 'Peñol', 78, 2, 1, '2022-11-11 15:35:53', 'I'),
(90, 'Pueblorrico', 79, 2, 1, '2022-11-11 15:35:53', 'I'),
(91, 'Puerto Berrío', 80, 2, 1, '2022-11-11 15:35:53', 'I'),
(92, 'Puerto Nare', 81, 2, 1, '2022-11-11 15:35:53', 'I'),
(93, 'Puerto Triunfo', 82, 2, 1, '2022-11-11 15:35:53', 'I'),
(94, 'Remedios', 83, 2, 1, '2022-11-11 15:35:53', 'I'),
(95, 'Retiro', 84, 2, 1, '2022-11-11 15:35:53', 'I'),
(96, 'Rionegro', 85, 2, 1, '2022-11-11 15:35:53', 'I'),
(97, 'Sabanalarga', 86, 2, 1, '2022-11-11 15:35:53', 'I'),
(98, 'Sabaneta', 87, 2, 1, '2022-11-11 15:35:53', 'I'),
(99, 'Salgar', 88, 2, 1, '2022-11-11 15:35:53', 'I'),
(100, 'San Andres de Cuerquia', 89, 2, 1, '2022-11-11 15:35:53', 'I'),
(101, 'San Carlos', 90, 2, 1, '2022-11-11 15:35:53', 'I'),
(102, 'San Francisco', 91, 2, 1, '2022-11-11 15:35:53', 'I'),
(103, 'San Jerónimo', 92, 2, 1, '2022-11-11 15:35:53', 'I'),
(104, 'San José de la Montaña', 93, 2, 1, '2022-11-11 15:35:53', 'I'),
(105, 'San Juan de Urabá', 94, 2, 1, '2022-11-11 15:35:53', 'I'),
(106, 'San Luis', 95, 2, 1, '2022-11-11 15:35:53', 'I'),
(107, 'San Pedro', 96, 2, 1, '2022-11-11 15:35:53', 'I'),
(108, 'San Pedro de Urabá', 97, 2, 1, '2022-11-11 15:35:53', 'I'),
(109, 'San Rafael', 98, 2, 1, '2022-11-11 15:35:53', 'I'),
(110, 'San Roque', 99, 2, 1, '2022-11-11 15:35:53', 'I'),
(111, 'Santa Bárbara', 100, 2, 1, '2022-11-11 15:35:53', 'I'),
(112, 'Santafé de Antioquia', 101, 2, 1, '2022-11-11 15:35:53', 'I'),
(113, 'Santa Rosa de Osos', 102, 2, 1, '2022-11-11 15:35:53', 'I'),
(114, 'Santo Domingo', 103, 2, 1, '2022-11-11 15:35:53', 'I'),
(115, 'San Vicente', 104, 2, 1, '2022-11-11 15:35:53', 'I'),
(116, 'Segovia', 105, 2, 1, '2022-11-11 15:35:53', 'I'),
(117, 'Sonsón', 106, 2, 1, '2022-11-11 15:35:53', 'I'),
(118, 'Sopetrán', 107, 2, 1, '2022-11-11 15:35:53', 'I'),
(119, 'Támesis', 108, 2, 1, '2022-11-11 15:35:53', 'I'),
(120, 'Tarazá', 109, 2, 1, '2022-11-11 15:35:53', 'I'),
(121, 'Tarso', 110, 2, 1, '2022-11-11 15:35:53', 'I'),
(122, 'Titiribí', 111, 2, 1, '2022-11-11 15:35:53', 'I'),
(123, 'Toledo', 112, 2, 1, '2022-11-11 15:35:53', 'I'),
(124, 'Turbo', 113, 2, 1, '2022-11-11 15:35:53', 'I'),
(125, 'Uramita', 114, 2, 1, '2022-11-11 15:35:53', 'I'),
(126, 'Urrao', 115, 2, 1, '2022-11-11 15:35:53', 'I'),
(127, 'Valdivia', 116, 2, 1, '2022-11-11 15:35:53', 'I'),
(128, 'Valparaíso', 117, 2, 1, '2022-11-11 15:35:53', 'I'),
(129, 'Vegachí', 118, 2, 1, '2022-11-11 15:35:53', 'I'),
(130, 'Venecia', 119, 2, 1, '2022-11-11 15:35:53', 'I'),
(131, 'Vigía del Fuerte', 120, 2, 1, '2022-11-11 15:35:53', 'I'),
(132, 'Yalí', 121, 2, 1, '2022-11-11 15:35:53', 'I'),
(133, 'Yarumal', 122, 2, 1, '2022-11-11 15:35:53', 'I'),
(134, 'Yolombó', 123, 2, 1, '2022-11-11 15:35:53', 'I'),
(135, 'Yondó', 124, 2, 1, '2022-11-11 15:35:53', 'I'),
(136, 'Zaragoza', 125, 2, 1, '2022-11-11 15:35:53', 'I'),
(137, 'Arauca', 1, 3, 1, '2022-11-11 15:35:53', 'I'),
(138, 'Arauquita', 2, 3, 1, '2022-11-11 15:35:53', 'I'),
(139, 'Cravo Norte', 3, 3, 1, '2022-11-11 15:35:53', 'I'),
(140, 'Fortul', 4, 3, 1, '2022-11-11 15:35:53', 'I'),
(141, 'Puerto Rondón', 5, 3, 1, '2022-11-11 15:35:53', 'I'),
(142, 'Saravena', 6, 3, 1, '2022-11-11 15:35:53', 'I'),
(143, 'Tame', 7, 3, 1, '2022-11-11 15:35:53', 'I'),
(144, 'Baranoa', 1, 4, 1, '2022-11-11 15:35:53', 'I'),
(145, 'Barranquilla', 2, 4, 1, '2022-11-11 15:35:53', 'I'),
(146, 'Campo de la Cruz', 3, 4, 1, '2022-11-11 15:35:53', 'I'),
(147, 'Candelaria', 4, 4, 1, '2022-11-11 15:35:53', 'I'),
(148, 'Galapa', 5, 4, 1, '2022-11-11 15:35:53', 'I'),
(149, 'Juan de Acosta', 6, 4, 1, '2022-11-11 15:35:53', 'I'),
(150, 'Luruaco', 7, 4, 1, '2022-11-11 15:35:53', 'I'),
(151, 'Malambo', 8, 4, 1, '2022-11-11 15:35:53', 'I'),
(152, 'Manatí', 9, 4, 1, '2022-11-11 15:35:53', 'I'),
(153, 'Palmar de Varela', 10, 4, 1, '2022-11-11 15:35:53', 'I'),
(154, 'Piojó', 11, 4, 1, '2022-11-11 15:35:53', 'I'),
(155, 'Polonuevo', 12, 4, 1, '2022-11-11 15:35:53', 'I'),
(156, 'Ponedera', 13, 4, 1, '2022-11-11 15:35:53', 'I'),
(157, 'Puerto Colombia', 14, 4, 1, '2022-11-11 15:35:53', 'I'),
(158, 'Repelón', 15, 4, 1, '2022-11-11 15:35:53', 'I'),
(159, 'Sabanagrande', 16, 4, 1, '2022-11-11 15:35:53', 'I'),
(160, 'Sabanalarga', 17, 4, 1, '2022-11-11 15:35:53', 'I'),
(161, 'Santa Lucía', 18, 4, 1, '2022-11-11 15:35:53', 'I'),
(162, 'Santo Tomás', 19, 4, 1, '2022-11-11 15:35:53', 'I'),
(163, 'Soledad', 20, 4, 1, '2022-11-11 15:35:53', 'I'),
(164, 'Suan', 21, 4, 1, '2022-11-11 15:35:53', 'I'),
(165, 'Tubará', 22, 4, 1, '2022-11-11 15:35:53', 'I'),
(166, 'Usiacurí', 23, 4, 1, '2022-11-11 15:35:53', 'I'),
(167, 'Bogotá, D.C.', 1, 5, 1, '2022-11-11 15:35:53', 'I'),
(168, 'Achí', 1, 6, 1, '2022-11-11 15:35:53', 'I'),
(169, 'Altos del Rosario', 2, 6, 1, '2022-11-11 15:35:53', 'I'),
(170, 'Arenal', 3, 6, 1, '2022-11-11 15:35:53', 'I'),
(171, 'Arjona', 4, 6, 1, '2022-11-11 15:35:53', 'I'),
(172, 'Arroyohondo', 5, 6, 1, '2022-11-11 15:35:53', 'I'),
(173, 'Barranco de Loba', 6, 6, 1, '2022-11-11 15:35:53', 'I'),
(174, 'Calamar', 7, 6, 1, '2022-11-11 15:35:53', 'I'),
(175, 'Cantagallo', 8, 6, 1, '2022-11-11 15:35:53', 'I'),
(176, 'Cartagena de Indias', 9, 6, 1, '2022-11-11 15:35:53', 'I'),
(177, 'Cicuco', 10, 6, 1, '2022-11-11 15:35:53', 'I'),
(178, 'Clemencia', 11, 6, 1, '2022-11-11 15:35:53', 'I'),
(179, 'Córdoba', 12, 6, 1, '2022-11-11 15:35:53', 'I'),
(180, 'El Carmen de Bolívar', 13, 6, 1, '2022-11-11 15:35:53', 'I'),
(181, 'El Guamo', 14, 6, 1, '2022-11-11 15:35:53', 'I'),
(182, 'El Peñón', 15, 6, 1, '2022-11-11 15:35:53', 'I'),
(183, 'Hatillo de Loba', 16, 6, 1, '2022-11-11 15:35:53', 'I'),
(184, 'Magangué', 17, 6, 1, '2022-11-11 15:35:53', 'I'),
(185, 'Mahates', 18, 6, 1, '2022-11-11 15:35:53', 'I'),
(186, 'Margarita', 19, 6, 1, '2022-11-11 15:35:53', 'I'),
(187, 'María la Baja', 20, 6, 1, '2022-11-11 15:35:53', 'I'),
(188, 'Mompós', 21, 6, 1, '2022-11-11 15:35:53', 'I'),
(189, 'Montecristo', 22, 6, 1, '2022-11-11 15:35:53', 'I'),
(190, 'Morales', 23, 6, 1, '2022-11-11 15:35:53', 'I'),
(191, 'Norosí', 24, 6, 1, '2022-11-11 15:35:53', 'I'),
(192, 'Pinillos', 25, 6, 1, '2022-11-11 15:35:53', 'I'),
(193, 'Regidor', 26, 6, 1, '2022-11-11 15:35:53', 'I'),
(194, 'Río Viejo', 27, 6, 1, '2022-11-11 15:35:53', 'I'),
(195, 'San Cristóbal', 28, 6, 1, '2022-11-11 15:35:53', 'I'),
(196, 'San Estanislao', 29, 6, 1, '2022-11-11 15:35:53', 'I'),
(197, 'San Fernando', 30, 6, 1, '2022-11-11 15:35:53', 'I'),
(198, 'San Jacinto', 31, 6, 1, '2022-11-11 15:35:53', 'I'),
(199, 'San Jacinto del Cauca', 32, 6, 1, '2022-11-11 15:35:53', 'I'),
(200, 'San Juan Nepomuceno', 33, 6, 1, '2022-11-11 15:35:53', 'I'),
(201, 'San Martin de Loba', 34, 6, 1, '2022-11-11 15:35:53', 'I'),
(202, 'San Pablo', 35, 6, 1, '2022-11-11 15:35:53', 'I'),
(203, 'Santa Catalina', 36, 6, 1, '2022-11-11 15:35:53', 'I'),
(204, 'Santa Rosa', 37, 6, 1, '2022-11-11 15:35:53', 'I'),
(205, 'Santa Rosa del Sur', 38, 6, 1, '2022-11-11 15:35:53', 'I'),
(206, 'Simití', 39, 6, 1, '2022-11-11 15:35:53', 'I'),
(207, 'Soplaviento', 40, 6, 1, '2022-11-11 15:35:53', 'I'),
(208, 'Talaigua Nuevo', 41, 6, 1, '2022-11-11 15:35:53', 'I'),
(209, 'Tiquisio', 42, 6, 1, '2022-11-11 15:35:53', 'I'),
(210, 'Turbaco', 43, 6, 1, '2022-11-11 15:35:53', 'I'),
(211, 'Turbana', 44, 6, 1, '2022-11-11 15:35:53', 'I'),
(212, 'Villanueva', 45, 6, 1, '2022-11-11 15:35:53', 'I'),
(213, 'Zambrano', 46, 6, 1, '2022-11-11 15:35:53', 'I'),
(214, 'Almeida', 1, 7, 1, '2022-11-11 15:35:53', 'I'),
(215, 'Aquitania', 2, 7, 1, '2022-11-11 15:35:53', 'I'),
(216, 'Arcabuco', 3, 7, 1, '2022-11-11 15:35:53', 'I'),
(217, 'Belén', 4, 7, 1, '2022-11-11 15:35:53', 'I'),
(218, 'Berbeo', 5, 7, 1, '2022-11-11 15:35:53', 'I'),
(219, 'Betéitiva', 6, 7, 1, '2022-11-11 15:35:53', 'I'),
(220, 'Boavita', 7, 7, 1, '2022-11-11 15:35:53', 'I'),
(221, 'Boyacá', 8, 7, 1, '2022-11-11 15:35:53', 'I'),
(222, 'Briceño', 9, 7, 1, '2022-11-11 15:35:53', 'I'),
(223, 'Buenavista', 10, 7, 1, '2022-11-11 15:35:53', 'I'),
(224, 'Busbanzá', 11, 7, 1, '2022-11-11 15:35:53', 'I'),
(225, 'Caldas', 12, 7, 1, '2022-11-11 15:35:53', 'I'),
(226, 'Campohermoso', 13, 7, 1, '2022-11-11 15:35:53', 'I'),
(227, 'Cerinza', 14, 7, 1, '2022-11-11 15:35:53', 'I'),
(228, 'Chinavita', 15, 7, 1, '2022-11-11 15:35:53', 'I'),
(229, 'Chiquinquirá', 16, 7, 1, '2022-11-11 15:35:53', 'I'),
(230, 'Chíquiza', 17, 7, 1, '2022-11-11 15:35:53', 'I'),
(231, 'Chiscas', 18, 7, 1, '2022-11-11 15:35:53', 'I'),
(232, 'Chita', 19, 7, 1, '2022-11-11 15:35:53', 'I'),
(233, 'Chitaraque', 20, 7, 1, '2022-11-11 15:35:53', 'I'),
(234, 'Chivatá', 21, 7, 1, '2022-11-11 15:35:53', 'I'),
(235, 'Chivor', 22, 7, 1, '2022-11-11 15:35:53', 'I'),
(236, 'Ciénega', 23, 7, 1, '2022-11-11 15:35:53', 'I'),
(237, 'Cómbita', 24, 7, 1, '2022-11-11 15:35:53', 'I'),
(238, 'Coper', 25, 7, 1, '2022-11-11 15:35:53', 'I'),
(239, 'Corrales', 26, 7, 1, '2022-11-11 15:35:53', 'I'),
(240, 'Covarachía', 27, 7, 1, '2022-11-11 15:35:53', 'I'),
(241, 'Cubará', 28, 7, 1, '2022-11-11 15:35:53', 'I'),
(242, 'Cucaita', 29, 7, 1, '2022-11-11 15:35:53', 'I'),
(243, 'Cuítiva', 30, 7, 1, '2022-11-11 15:35:53', 'I'),
(244, 'Duitama', 31, 7, 1, '2022-11-11 15:35:53', 'I'),
(245, 'El Cocuy', 32, 7, 1, '2022-11-11 15:35:53', 'I'),
(246, 'El Espino', 33, 7, 1, '2022-11-11 15:35:53', 'I'),
(247, 'Firavitoba', 34, 7, 1, '2022-11-11 15:35:53', 'I'),
(248, 'Floresta', 35, 7, 1, '2022-11-11 15:35:53', 'I'),
(249, 'Gachantivá', 36, 7, 1, '2022-11-11 15:35:53', 'I'),
(250, 'Gameza', 37, 7, 1, '2022-11-11 15:35:53', 'I'),
(251, 'Garagoa', 38, 7, 1, '2022-11-11 15:35:53', 'I'),
(252, 'Guacamayas', 39, 7, 1, '2022-11-11 15:35:53', 'I'),
(253, 'Guateque', 40, 7, 1, '2022-11-11 15:35:53', 'I'),
(254, 'Guayatá', 41, 7, 1, '2022-11-11 15:35:53', 'I'),
(255, 'Güicán', 42, 7, 1, '2022-11-11 15:35:53', 'I'),
(256, 'Iza', 43, 7, 1, '2022-11-11 15:35:53', 'I'),
(257, 'Jenesano', 44, 7, 1, '2022-11-11 15:35:53', 'I'),
(258, 'Jericó', 45, 7, 1, '2022-11-11 15:35:53', 'I'),
(259, 'Labranzagrande', 46, 7, 1, '2022-11-11 15:35:53', 'I'),
(260, 'La Capilla', 47, 7, 1, '2022-11-11 15:35:53', 'I'),
(261, 'La Uvita', 48, 7, 1, '2022-11-11 15:35:53', 'I'),
(262, 'La Victoria', 49, 7, 1, '2022-11-11 15:35:53', 'I'),
(263, 'Macanal', 50, 7, 1, '2022-11-11 15:35:53', 'I'),
(264, 'Maripí', 51, 7, 1, '2022-11-11 15:35:53', 'I'),
(265, 'Miraflores', 52, 7, 1, '2022-11-11 15:35:53', 'I'),
(266, 'Mongua', 53, 7, 1, '2022-11-11 15:35:53', 'I'),
(267, 'Monguí', 54, 7, 1, '2022-11-11 15:35:53', 'I'),
(268, 'Moniquirá', 55, 7, 1, '2022-11-11 15:35:53', 'I'),
(269, 'Motavita', 56, 7, 1, '2022-11-11 15:35:53', 'I'),
(270, 'Muzo', 57, 7, 1, '2022-11-11 15:35:53', 'I'),
(271, 'Nobsa', 58, 7, 1, '2022-11-11 15:35:53', 'I'),
(272, 'Nuevo Colón', 59, 7, 1, '2022-11-11 15:35:53', 'I'),
(273, 'Oicatá', 60, 7, 1, '2022-11-11 15:35:53', 'I'),
(274, 'Otanche', 61, 7, 1, '2022-11-11 15:35:53', 'I'),
(275, 'Pachavita', 62, 7, 1, '2022-11-11 15:35:53', 'I'),
(276, 'Páez', 63, 7, 1, '2022-11-11 15:35:53', 'I'),
(277, 'Paipa', 64, 7, 1, '2022-11-11 15:35:53', 'I'),
(278, 'Pajarito', 65, 7, 1, '2022-11-11 15:35:53', 'I'),
(279, 'Panqueba', 66, 7, 1, '2022-11-11 15:35:53', 'I'),
(280, 'Pauna', 67, 7, 1, '2022-11-11 15:35:53', 'I'),
(281, 'Paya', 68, 7, 1, '2022-11-11 15:35:53', 'I'),
(282, 'Paz de Río', 69, 7, 1, '2022-11-11 15:35:53', 'I'),
(283, 'Pesca', 70, 7, 1, '2022-11-11 15:35:53', 'I'),
(284, 'Pisba', 71, 7, 1, '2022-11-11 15:35:53', 'I'),
(285, 'Puerto Boyacá', 72, 7, 1, '2022-11-11 15:35:53', 'I'),
(286, 'Quípama', 73, 7, 1, '2022-11-11 15:35:53', 'I'),
(287, 'Ramiriquí', 74, 7, 1, '2022-11-11 15:35:53', 'I'),
(288, 'Ráquira', 75, 7, 1, '2022-11-11 15:35:53', 'I'),
(289, 'Rondón', 76, 7, 1, '2022-11-11 15:35:53', 'I'),
(290, 'Saboyá', 77, 7, 1, '2022-11-11 15:35:53', 'I'),
(291, 'Sáchica', 78, 7, 1, '2022-11-11 15:35:53', 'I'),
(292, 'Samacá', 79, 7, 1, '2022-11-11 15:35:53', 'I'),
(293, 'San Eduardo', 80, 7, 1, '2022-11-11 15:35:53', 'I'),
(294, 'San José de Pare', 81, 7, 1, '2022-11-11 15:35:53', 'I'),
(295, 'San Luis de Gaceno', 82, 7, 1, '2022-11-11 15:35:53', 'I'),
(296, 'San Mateo', 83, 7, 1, '2022-11-11 15:35:53', 'I'),
(297, 'San Miguel de Sema', 84, 7, 1, '2022-11-11 15:35:53', 'I'),
(298, 'San Pablo de Borbur', 85, 7, 1, '2022-11-11 15:35:53', 'I'),
(299, 'Santa María', 86, 7, 1, '2022-11-11 15:35:53', 'I'),
(300, 'Santana', 87, 7, 1, '2022-11-11 15:35:53', 'I'),
(301, 'Santa Rosa de Viterbo', 88, 7, 1, '2022-11-11 15:35:53', 'I'),
(302, 'Santa Sofía', 89, 7, 1, '2022-11-11 15:35:53', 'I'),
(303, 'Sativanorte', 90, 7, 1, '2022-11-11 15:35:53', 'I'),
(304, 'Sativasur', 91, 7, 1, '2022-11-11 15:35:53', 'I'),
(305, 'Siachoque', 92, 7, 1, '2022-11-11 15:35:53', 'I'),
(306, 'Soatá', 93, 7, 1, '2022-11-11 15:35:53', 'I'),
(307, 'Socha', 94, 7, 1, '2022-11-11 15:35:53', 'I'),
(308, 'Socotá', 95, 7, 1, '2022-11-11 15:35:53', 'I'),
(309, 'Sogamoso', 96, 7, 1, '2022-11-11 15:35:53', 'I'),
(310, 'Somondoco', 97, 7, 1, '2022-11-11 15:35:53', 'I'),
(311, 'Sora', 98, 7, 1, '2022-11-11 15:35:53', 'I'),
(312, 'Soracá', 99, 7, 1, '2022-11-11 15:35:53', 'I'),
(313, 'Sotaquirá', 100, 7, 1, '2022-11-11 15:35:53', 'I'),
(314, 'Susacón', 101, 7, 1, '2022-11-11 15:35:53', 'I'),
(315, 'Sutamarchán', 102, 7, 1, '2022-11-11 15:35:53', 'I'),
(316, 'Sutatenza', 103, 7, 1, '2022-11-11 15:35:53', 'I'),
(317, 'Tasco', 104, 7, 1, '2022-11-11 15:35:53', 'I'),
(318, 'Tenza', 105, 7, 1, '2022-11-11 15:35:53', 'I'),
(319, 'Tibaná', 106, 7, 1, '2022-11-11 15:35:53', 'I'),
(320, 'Tibasosa', 107, 7, 1, '2022-11-11 15:35:53', 'I'),
(321, 'Tinjacá', 108, 7, 1, '2022-11-11 15:35:53', 'I'),
(322, 'Tipacoque', 109, 7, 1, '2022-11-11 15:35:53', 'I'),
(323, 'Toca', 110, 7, 1, '2022-11-11 15:35:53', 'I'),
(324, 'Togüí', 111, 7, 1, '2022-11-11 15:35:53', 'I'),
(325, 'Tópaga', 112, 7, 1, '2022-11-11 15:35:53', 'I'),
(326, 'Tota', 113, 7, 1, '2022-11-11 15:35:53', 'I'),
(327, 'Tunja', 114, 7, 1, '2022-11-11 15:35:53', 'I'),
(328, 'Tununguá', 115, 7, 1, '2022-11-11 15:35:53', 'I'),
(329, 'Turmequé', 116, 7, 1, '2022-11-11 15:35:53', 'I'),
(330, 'Tuta', 117, 7, 1, '2022-11-11 15:35:53', 'I'),
(331, 'Tutazá', 118, 7, 1, '2022-11-11 15:35:53', 'I'),
(332, 'Úmbita', 119, 7, 1, '2022-11-11 15:35:53', 'I'),
(333, 'Ventaquemada', 120, 7, 1, '2022-11-11 15:35:53', 'I'),
(334, 'Villa de Leyva', 121, 7, 1, '2022-11-11 15:35:53', 'I'),
(335, 'Viracacha', 122, 7, 1, '2022-11-11 15:35:53', 'I'),
(336, 'Zetaquira', 123, 7, 1, '2022-11-11 15:35:53', 'I'),
(337, 'Aguadas', 1, 8, 1, '2022-11-11 15:35:53', 'I'),
(338, 'Anserma', 2, 8, 1, '2022-11-11 15:35:53', 'I'),
(339, 'Aranzazu', 3, 8, 1, '2022-11-11 15:35:53', 'I'),
(340, 'Belalcázar', 4, 8, 1, '2022-11-11 15:35:53', 'I'),
(341, 'Chinchiná', 5, 8, 1, '2022-11-11 15:35:53', 'I'),
(342, 'Filadelfia', 6, 8, 1, '2022-11-11 15:35:53', 'I'),
(343, 'La Dorada', 7, 8, 1, '2022-11-11 15:35:53', 'I'),
(344, 'La Merced', 8, 8, 1, '2022-11-11 15:35:53', 'I'),
(345, 'Manizales', 9, 8, 1, '2022-11-11 15:35:53', 'I'),
(346, 'Manzanares', 10, 8, 1, '2022-11-11 15:35:53', 'I'),
(347, 'Marmato', 11, 8, 1, '2022-11-11 15:35:53', 'I'),
(348, 'Marquetalia', 12, 8, 1, '2022-11-11 15:35:53', 'I'),
(349, 'Marulanda', 13, 8, 1, '2022-11-11 15:35:53', 'I'),
(350, 'Neira', 14, 8, 1, '2022-11-11 15:35:53', 'I'),
(351, 'Norcasia', 15, 8, 1, '2022-11-11 15:35:53', 'I'),
(352, 'Pácora', 16, 8, 1, '2022-11-11 15:35:53', 'I'),
(353, 'Palestina', 17, 8, 1, '2022-11-11 15:35:53', 'I'),
(354, 'Pensilvania', 18, 8, 1, '2022-11-11 15:35:53', 'I'),
(355, 'Riosucio', 19, 8, 1, '2022-11-11 15:35:53', 'I'),
(356, 'Risaralda', 20, 8, 1, '2022-11-11 15:35:53', 'I'),
(357, 'Salamina', 21, 8, 1, '2022-11-11 15:35:53', 'I'),
(358, 'Samaná', 22, 8, 1, '2022-11-11 15:35:53', 'I'),
(359, 'San José', 23, 8, 1, '2022-11-11 15:35:53', 'I'),
(360, 'Supía', 24, 8, 1, '2022-11-11 15:35:53', 'I'),
(361, 'Victoria', 25, 8, 1, '2022-11-11 15:35:53', 'I'),
(362, 'Villamaría', 26, 8, 1, '2022-11-11 15:35:53', 'I'),
(363, 'Viterbo', 27, 8, 1, '2022-11-11 15:35:53', 'I'),
(364, 'Albania', 1, 9, 1, '2022-11-11 15:35:54', 'I'),
(365, 'Belén de los Andaquíes', 2, 9, 1, '2022-11-11 15:35:54', 'I'),
(366, 'Cartagena del Chairá', 3, 9, 1, '2022-11-11 15:35:54', 'I'),
(367, 'Curillo', 4, 9, 1, '2022-11-11 15:35:54', 'I'),
(368, 'El Doncello', 5, 9, 1, '2022-11-11 15:35:54', 'I'),
(369, 'El Paujil', 6, 9, 1, '2022-11-11 15:35:54', 'I'),
(370, 'Florencia', 7, 9, 1, '2022-11-11 15:35:54', 'I'),
(371, 'La Montañita', 8, 9, 1, '2022-11-11 15:35:54', 'I'),
(372, 'Milán', 9, 9, 1, '2022-11-11 15:35:54', 'I'),
(373, 'Morelia', 10, 9, 1, '2022-11-11 15:35:54', 'I'),
(374, 'Puerto Rico', 11, 9, 1, '2022-11-11 15:35:54', 'I'),
(375, 'San Jose del Fragua', 12, 9, 1, '2022-11-11 15:35:54', 'I'),
(376, 'San Vicente del Caguán', 13, 9, 1, '2022-11-11 15:35:54', 'I'),
(377, 'Solano', 14, 9, 1, '2022-11-11 15:35:54', 'I'),
(378, 'Solita', 15, 9, 1, '2022-11-11 15:35:54', 'I'),
(379, 'Valparaíso', 16, 9, 1, '2022-11-11 15:35:54', 'I'),
(380, 'Aguazul', 1, 10, 1, '2022-11-11 15:35:54', 'I'),
(381, 'Chameza', 2, 10, 1, '2022-11-11 15:35:54', 'I'),
(382, 'Hato Corozal', 3, 10, 1, '2022-11-11 15:35:54', 'I'),
(383, 'La Salina', 4, 10, 1, '2022-11-11 15:35:54', 'I'),
(384, 'Maní', 5, 10, 1, '2022-11-11 15:35:54', 'I'),
(385, 'Monterrey', 6, 10, 1, '2022-11-11 15:35:54', 'I'),
(386, 'Nunchía', 7, 10, 1, '2022-11-11 15:35:54', 'I'),
(387, 'Orocué', 8, 10, 1, '2022-11-11 15:35:54', 'I'),
(388, 'Paz de Ariporo', 9, 10, 1, '2022-11-11 15:35:54', 'I'),
(389, 'Pore', 10, 10, 1, '2022-11-11 15:35:54', 'I'),
(390, 'Recetor', 11, 10, 1, '2022-11-11 15:35:54', 'I'),
(391, 'Sabanalarga', 12, 10, 1, '2022-11-11 15:35:54', 'I'),
(392, 'Sácama', 13, 10, 1, '2022-11-11 15:35:54', 'I'),
(393, 'San Luis de Palenque', 14, 10, 1, '2022-11-11 15:35:54', 'I'),
(394, 'Támara', 15, 10, 1, '2022-11-11 15:35:54', 'I'),
(395, 'Tauramena', 16, 10, 1, '2022-11-11 15:35:54', 'I'),
(396, 'Trinidad', 17, 10, 1, '2022-11-11 15:35:54', 'I'),
(397, 'Villanueva', 18, 10, 1, '2022-11-11 15:35:54', 'I'),
(398, 'Yopal', 19, 10, 1, '2022-11-11 15:35:54', 'I'),
(399, 'Almaguer', 1, 11, 1, '2022-11-11 15:35:54', 'I'),
(400, 'Argelia', 2, 11, 1, '2022-11-11 15:35:54', 'I'),
(401, 'Balboa', 3, 11, 1, '2022-11-11 15:35:54', 'I'),
(402, 'Bolivar', 4, 11, 1, '2022-11-11 15:35:54', 'I'),
(403, 'Buenos Aires', 5, 11, 1, '2022-11-11 15:35:54', 'I'),
(404, 'Cajibío', 6, 11, 1, '2022-11-11 15:35:54', 'I'),
(405, 'Caldono', 7, 11, 1, '2022-11-11 15:35:54', 'I'),
(406, 'Caloto', 8, 11, 1, '2022-11-11 15:35:54', 'I'),
(407, 'Corinto', 9, 11, 1, '2022-11-11 15:35:54', 'I'),
(408, 'El Tambo', 10, 11, 1, '2022-11-11 15:35:54', 'I'),
(409, 'Florencia', 11, 11, 1, '2022-11-11 15:35:54', 'I'),
(410, 'Guachené', 12, 11, 1, '2022-11-11 15:35:54', 'I'),
(411, 'Guapi', 13, 11, 1, '2022-11-11 15:35:54', 'I'),
(412, 'Inzá', 14, 11, 1, '2022-11-11 15:35:54', 'I'),
(413, 'Jambaló', 15, 11, 1, '2022-11-11 15:35:54', 'I'),
(414, 'La Sierra', 16, 11, 1, '2022-11-11 15:35:54', 'I'),
(415, 'La Vega', 17, 11, 1, '2022-11-11 15:35:54', 'I'),
(416, 'López', 18, 11, 1, '2022-11-11 15:35:54', 'I'),
(417, 'Mercaderes', 19, 11, 1, '2022-11-11 15:35:54', 'I'),
(418, 'Miranda', 20, 11, 1, '2022-11-11 15:35:54', 'I'),
(419, 'Morales', 21, 11, 1, '2022-11-11 15:35:54', 'I'),
(420, 'Padilla', 22, 11, 1, '2022-11-11 15:35:54', 'I'),
(421, 'Páez', 23, 11, 1, '2022-11-11 15:35:54', 'I'),
(422, 'Patía', 24, 11, 1, '2022-11-11 15:35:54', 'I'),
(423, 'Piamonte', 25, 11, 1, '2022-11-11 15:35:54', 'I'),
(424, 'Piendamó', 26, 11, 1, '2022-11-11 15:35:54', 'I'),
(425, 'Popayán', 27, 11, 1, '2022-11-11 15:35:54', 'I'),
(426, 'Puerto Tejada', 28, 11, 1, '2022-11-11 15:35:54', 'I'),
(427, 'Puracé', 29, 11, 1, '2022-11-11 15:35:54', 'I'),
(428, 'Rosas', 30, 11, 1, '2022-11-11 15:35:54', 'I'),
(429, 'San Sebastián', 31, 11, 1, '2022-11-11 15:35:54', 'I'),
(430, 'Santander de Quilichao', 32, 11, 1, '2022-11-11 15:35:54', 'I'),
(431, 'Santa Rosa', 33, 11, 1, '2022-11-11 15:35:54', 'I'),
(432, 'Silvia', 34, 11, 1, '2022-11-11 15:35:54', 'I'),
(433, 'Sotará', 35, 11, 1, '2022-11-11 15:35:54', 'I'),
(434, 'Suárez', 36, 11, 1, '2022-11-11 15:35:54', 'I'),
(435, 'Sucre', 37, 11, 1, '2022-11-11 15:35:54', 'I'),
(436, 'Timbío', 38, 11, 1, '2022-11-11 15:35:54', 'I'),
(437, 'Timbiquí', 39, 11, 1, '2022-11-11 15:35:54', 'I'),
(438, 'Toribío', 40, 11, 1, '2022-11-11 15:35:54', 'I'),
(439, 'Totoró', 41, 11, 1, '2022-11-11 15:35:54', 'I'),
(440, 'Villa Rica', 42, 11, 1, '2022-11-11 15:35:54', 'I'),
(441, 'Aguachica', 1, 12, 1, '2022-11-11 15:35:54', 'I'),
(442, 'Agustín Codazzi', 2, 12, 1, '2022-11-11 15:35:54', 'I'),
(443, 'Astrea', 3, 12, 1, '2022-11-11 15:35:54', 'I'),
(444, 'Becerril', 4, 12, 1, '2022-11-11 15:35:54', 'I'),
(445, 'Bosconia', 5, 12, 1, '2022-11-11 15:35:54', 'I'),
(446, 'Chimichagua', 6, 12, 1, '2022-11-11 15:35:54', 'I'),
(447, 'Chiriguaná', 7, 12, 1, '2022-11-11 15:35:54', 'I'),
(448, 'Curumaní', 8, 12, 1, '2022-11-11 15:35:54', 'I'),
(449, 'El Copey', 9, 12, 1, '2022-11-11 15:35:54', 'I'),
(450, 'El Paso', 10, 12, 1, '2022-11-11 15:35:54', 'I'),
(451, 'Gamarra', 11, 12, 1, '2022-11-11 15:35:54', 'I'),
(452, 'González', 12, 12, 1, '2022-11-11 15:35:54', 'I'),
(453, 'La Gloria', 13, 12, 1, '2022-11-11 15:35:54', 'I'),
(454, 'La Jagua de Ibirico', 14, 12, 1, '2022-11-11 15:35:54', 'I'),
(455, 'La Paz', 15, 12, 1, '2022-11-11 15:35:54', 'I'),
(456, 'Manaure', 16, 12, 1, '2022-11-11 15:35:54', 'I'),
(457, 'Pailitas', 17, 12, 1, '2022-11-11 15:35:54', 'I'),
(458, 'Pelaya', 18, 12, 1, '2022-11-11 15:35:54', 'I'),
(459, 'Pueblo Bello', 19, 12, 1, '2022-11-11 15:35:54', 'I'),
(460, 'Río de Oro', 20, 12, 1, '2022-11-11 15:35:54', 'I'),
(461, 'San Alberto', 21, 12, 1, '2022-11-11 15:35:54', 'I'),
(462, 'San Diego', 22, 12, 1, '2022-11-11 15:35:54', 'I'),
(463, 'San Martín', 23, 12, 1, '2022-11-11 15:35:54', 'I'),
(464, 'Tamalameque', 24, 12, 1, '2022-11-11 15:35:54', 'I'),
(465, 'Valledupar', 25, 12, 1, '2022-11-11 15:35:54', 'I'),
(466, 'Acandí', 1, 13, 1, '2022-11-11 15:35:54', 'I'),
(467, 'Alto Baudó', 2, 13, 1, '2022-11-11 15:35:54', 'I'),
(468, 'Atrato', 3, 13, 1, '2022-11-11 15:35:54', 'I'),
(469, 'Bagadó', 4, 13, 1, '2022-11-11 15:35:54', 'I'),
(470, 'Bahía Solano', 5, 13, 1, '2022-11-11 15:35:54', 'I'),
(471, 'Bajo Baudó', 6, 13, 1, '2022-11-11 15:35:54', 'I'),
(472, 'Belén de Bajirá', 7, 13, 1, '2022-11-11 15:35:54', 'I'),
(473, 'Bojayá', 8, 13, 1, '2022-11-11 15:35:54', 'I'),
(474, 'Carmen del Darién', 9, 13, 1, '2022-11-11 15:35:54', 'I'),
(475, 'Cértegui', 10, 13, 1, '2022-11-11 15:35:54', 'I'),
(476, 'Condoto', 11, 13, 1, '2022-11-11 15:35:54', 'I'),
(477, 'El Cantón del San Pablo', 12, 13, 1, '2022-11-11 15:35:54', 'I'),
(478, 'El Carmen de Atrato', 13, 13, 1, '2022-11-11 15:35:54', 'I'),
(479, 'El Litoral del San Juan', 14, 13, 1, '2022-11-11 15:35:54', 'I'),
(480, 'Istmina', 15, 13, 1, '2022-11-11 15:35:54', 'I'),
(481, 'Juradó', 16, 13, 1, '2022-11-11 15:35:54', 'I'),
(482, 'Lloró', 17, 13, 1, '2022-11-11 15:35:54', 'I'),
(483, 'Medio Atrato', 18, 13, 1, '2022-11-11 15:35:54', 'I'),
(484, 'Medio Baudó', 19, 13, 1, '2022-11-11 15:35:54', 'I'),
(485, 'Medio San Juan', 20, 13, 1, '2022-11-11 15:35:54', 'I'),
(486, 'Nóvita', 21, 13, 1, '2022-11-11 15:35:54', 'I'),
(487, 'Nuquí', 22, 13, 1, '2022-11-11 15:35:54', 'I'),
(488, 'Quibdó', 23, 13, 1, '2022-11-11 15:35:54', 'I'),
(489, 'Río Iró', 24, 13, 1, '2022-11-11 15:35:54', 'I'),
(490, 'Río Quito', 25, 13, 1, '2022-11-11 15:35:54', 'I'),
(491, 'Riosucio', 26, 13, 1, '2022-11-11 15:35:54', 'I'),
(492, 'San José del Palmar', 27, 13, 1, '2022-11-11 15:35:54', 'I'),
(493, 'Sipí', 28, 13, 1, '2022-11-11 15:35:54', 'I'),
(494, 'Tadó', 29, 13, 1, '2022-11-11 15:35:54', 'I'),
(495, 'Unguía', 30, 13, 1, '2022-11-11 15:35:54', 'I'),
(496, 'Unión Panamericana', 31, 13, 1, '2022-11-11 15:35:54', 'I'),
(497, 'Ayapel', 1, 14, 1, '2022-11-11 15:35:54', 'I'),
(498, 'Buenavista', 2, 14, 1, '2022-11-11 15:35:54', 'I'),
(499, 'Canalete', 3, 14, 1, '2022-11-11 15:35:54', 'I'),
(500, 'Cereté', 4, 14, 1, '2022-11-11 15:35:54', 'I'),
(501, 'Chimá', 5, 14, 1, '2022-11-11 15:35:54', 'I'),
(502, 'Chinú', 6, 14, 1, '2022-11-11 15:35:54', 'I'),
(503, 'Ciénaga de Oro', 7, 14, 1, '2022-11-11 15:35:54', 'I'),
(504, 'Cotorra', 8, 14, 1, '2022-11-11 15:35:54', 'I'),
(505, 'La Apartada', 9, 14, 1, '2022-11-11 15:35:54', 'I'),
(506, 'Lorica', 10, 14, 1, '2022-11-11 15:35:54', 'I'),
(507, 'Los Córdobas', 11, 14, 1, '2022-11-11 15:35:54', 'I'),
(508, 'Momil', 12, 14, 1, '2022-11-11 15:35:54', 'I'),
(509, 'Montelíbano', 13, 14, 1, '2022-11-11 15:35:54', 'I'),
(510, 'Montería', 14, 14, 1, '2022-11-11 15:35:54', 'I'),
(511, 'Moñitos', 15, 14, 1, '2022-11-11 15:35:54', 'I'),
(512, 'Planeta Rica', 16, 14, 1, '2022-11-11 15:35:54', 'I'),
(513, 'Pueblo Nuevo', 17, 14, 1, '2022-11-11 15:35:54', 'I'),
(514, 'Puerto Escondido', 18, 14, 1, '2022-11-11 15:35:54', 'I'),
(515, 'Puerto Libertador', 19, 14, 1, '2022-11-11 15:35:54', 'I'),
(516, 'Purísima', 20, 14, 1, '2022-11-11 15:35:54', 'I'),
(517, 'Sahagún', 21, 14, 1, '2022-11-11 15:35:54', 'I'),
(518, 'San Andrés Sotavento', 22, 14, 1, '2022-11-11 15:35:54', 'I'),
(519, 'San Antero', 23, 14, 1, '2022-11-11 15:35:54', 'I'),
(520, 'San Bernardo del Viento', 24, 14, 1, '2022-11-11 15:35:54', 'I'),
(521, 'San Carlos', 25, 14, 1, '2022-11-11 15:35:54', 'I'),
(522, 'San José de Uré', 26, 14, 1, '2022-11-11 15:35:54', 'I'),
(523, 'San Pelayo', 27, 14, 1, '2022-11-11 15:35:54', 'I'),
(524, 'Tierralta', 28, 14, 1, '2022-11-11 15:35:54', 'I'),
(525, 'Tuchín', 29, 14, 1, '2022-11-11 15:35:54', 'I'),
(526, 'Valencia', 30, 14, 1, '2022-11-11 15:35:54', 'I'),
(527, 'Agua de Dios', 1, 15, 1, '2022-11-11 15:35:54', 'I'),
(528, 'Albán', 2, 15, 1, '2022-11-11 15:35:54', 'I'),
(529, 'Anapoima', 3, 15, 1, '2022-11-11 15:35:54', 'I'),
(530, 'Anolaima', 4, 15, 1, '2022-11-11 15:35:54', 'I'),
(531, 'Apulo', 5, 15, 1, '2022-11-11 15:35:54', 'I'),
(532, 'Arbeláez', 6, 15, 1, '2022-11-11 15:35:54', 'I'),
(533, 'Beltrán', 7, 15, 1, '2022-11-11 15:35:54', 'I'),
(534, 'Bituima', 8, 15, 1, '2022-11-11 15:35:54', 'I'),
(535, 'Bojacá', 9, 15, 1, '2022-11-11 15:35:54', 'I'),
(536, 'Cabrera', 10, 15, 1, '2022-11-11 15:35:54', 'I'),
(537, 'Cachipay', 11, 15, 1, '2022-11-11 15:35:54', 'I'),
(538, 'Cajicá', 12, 15, 1, '2022-11-11 15:35:54', 'I'),
(539, 'Caparrapí', 13, 15, 1, '2022-11-11 15:35:54', 'I'),
(540, 'Cáqueza', 14, 15, 1, '2022-11-11 15:35:54', 'I'),
(541, 'Carmen de Carupa', 15, 15, 1, '2022-11-11 15:35:54', 'I'),
(542, 'Chaguaní', 16, 15, 1, '2022-11-11 15:35:54', 'I'),
(543, 'Chía', 17, 15, 1, '2022-11-11 15:35:54', 'I'),
(544, 'Chipaque', 18, 15, 1, '2022-11-11 15:35:54', 'I'),
(545, 'Choachí', 19, 15, 1, '2022-11-11 15:35:54', 'I'),
(546, 'Chocontá', 20, 15, 1, '2022-11-11 15:35:54', 'I'),
(547, 'Cogua', 21, 15, 1, '2022-11-11 15:35:54', 'I'),
(548, 'Cota', 22, 15, 1, '2022-11-11 15:35:54', 'I'),
(549, 'Cucunubá', 23, 15, 1, '2022-11-11 15:35:54', 'I'),
(550, 'El Colegio', 24, 15, 1, '2022-11-11 15:35:54', 'I'),
(551, 'El Peñón', 25, 15, 1, '2022-11-11 15:35:54', 'I'),
(552, 'El Rosal', 26, 15, 1, '2022-11-11 15:35:54', 'I'),
(553, 'Facatativá', 27, 15, 1, '2022-11-11 15:35:54', 'I'),
(554, 'Fómeque', 28, 15, 1, '2022-11-11 15:35:54', 'I'),
(555, 'Fosca', 29, 15, 1, '2022-11-11 15:35:54', 'I'),
(556, 'Funza', 30, 15, 1, '2022-11-11 15:35:54', 'I'),
(557, 'Fúquene', 31, 15, 1, '2022-11-11 15:35:54', 'I'),
(558, 'Fusagasugá', 32, 15, 1, '2022-11-11 15:35:54', 'I'),
(559, 'Gachala', 33, 15, 1, '2022-11-11 15:35:54', 'I'),
(560, 'Gachancipá', 34, 15, 1, '2022-11-11 15:35:54', 'I'),
(561, 'Gachetá', 35, 15, 1, '2022-11-11 15:35:54', 'I'),
(562, 'Gama', 36, 15, 1, '2022-11-11 15:35:54', 'I'),
(563, 'Girardot', 37, 15, 1, '2022-11-11 15:35:54', 'I'),
(564, 'Granada', 38, 15, 1, '2022-11-11 15:35:54', 'I'),
(565, 'Guachetá', 39, 15, 1, '2022-11-11 15:35:54', 'I'),
(566, 'Guaduas', 40, 15, 1, '2022-11-11 15:35:54', 'I'),
(567, 'Guasca', 41, 15, 1, '2022-11-11 15:35:54', 'I'),
(568, 'Guataquá', 42, 15, 1, '2022-11-11 15:35:54', 'I'),
(569, 'Guatavita', 43, 15, 1, '2022-11-11 15:35:54', 'I'),
(570, 'Guayabal de Siquima', 44, 15, 1, '2022-11-11 15:35:54', 'I'),
(571, 'Guayabetal', 45, 15, 1, '2022-11-11 15:35:54', 'I'),
(572, 'Gutiérrez', 46, 15, 1, '2022-11-11 15:35:54', 'I'),
(573, 'Jerusalén', 47, 15, 1, '2022-11-11 15:35:54', 'I'),
(574, 'Junín', 48, 15, 1, '2022-11-11 15:35:54', 'I'),
(575, 'La Calera', 49, 15, 1, '2022-11-11 15:35:54', 'I'),
(576, 'La Mesa', 50, 15, 1, '2022-11-11 15:35:54', 'I'),
(577, 'La Palma', 51, 15, 1, '2022-11-11 15:35:54', 'I'),
(578, 'La Peña', 52, 15, 1, '2022-11-11 15:35:54', 'I'),
(579, 'La Vega', 53, 15, 1, '2022-11-11 15:35:54', 'I'),
(580, 'Lenguazaque', 54, 15, 1, '2022-11-11 15:35:54', 'I'),
(581, 'Machetá', 55, 15, 1, '2022-11-11 15:35:54', 'I'),
(582, 'Madrid', 56, 15, 1, '2022-11-11 15:35:54', 'I'),
(583, 'Manta', 57, 15, 1, '2022-11-11 15:35:54', 'I'),
(584, 'Medina', 58, 15, 1, '2022-11-11 15:35:54', 'I'),
(585, 'Mosquera', 59, 15, 1, '2022-11-11 15:35:54', 'I'),
(586, 'Nariño', 60, 15, 1, '2022-11-11 15:35:54', 'I'),
(587, 'Nemocón', 61, 15, 1, '2022-11-11 15:35:54', 'I'),
(588, 'Nilo', 62, 15, 1, '2022-11-11 15:35:54', 'I'),
(589, 'Nimaima', 63, 15, 1, '2022-11-11 15:35:54', 'I'),
(590, 'Nocaima', 64, 15, 1, '2022-11-11 15:35:54', 'I'),
(591, 'Pacho', 65, 15, 1, '2022-11-11 15:35:54', 'I'),
(592, 'Paime', 66, 15, 1, '2022-11-11 15:35:54', 'I'),
(593, 'Pandi', 67, 15, 1, '2022-11-11 15:35:54', 'I'),
(594, 'Paratebueno', 68, 15, 1, '2022-11-11 15:35:54', 'I'),
(595, 'Pasca', 69, 15, 1, '2022-11-11 15:35:54', 'I'),
(596, 'Puerto Salgar', 70, 15, 1, '2022-11-11 15:35:54', 'I'),
(597, 'Pulí', 71, 15, 1, '2022-11-11 15:35:54', 'I'),
(598, 'Quebradanegra', 72, 15, 1, '2022-11-11 15:35:54', 'I'),
(599, 'Quetame', 73, 15, 1, '2022-11-11 15:35:54', 'I'),
(600, 'Quipile', 74, 15, 1, '2022-11-11 15:35:54', 'I'),
(601, 'Ricaurte', 75, 15, 1, '2022-11-11 15:35:54', 'I'),
(602, 'San Antonio del Tequendama', 76, 15, 1, '2022-11-11 15:35:54', 'I'),
(603, 'San Bernardo', 77, 15, 1, '2022-11-11 15:35:54', 'I'),
(604, 'San Cayetano', 78, 15, 1, '2022-11-11 15:35:54', 'I'),
(605, 'San Francisco', 79, 15, 1, '2022-11-11 15:35:54', 'I'),
(606, 'San Juan de Río Seco', 80, 15, 1, '2022-11-11 15:35:54', 'I'),
(607, 'Sasaima', 81, 15, 1, '2022-11-11 15:35:54', 'I'),
(608, 'Sesquilé', 82, 15, 1, '2022-11-11 15:35:54', 'I'),
(609, 'Sibaté', 83, 15, 1, '2022-11-11 15:35:54', 'I'),
(610, 'Silvania', 84, 15, 1, '2022-11-11 15:35:54', 'I'),
(611, 'Simijaca', 85, 15, 1, '2022-11-11 15:35:54', 'I'),
(612, 'Soacha', 86, 15, 1, '2022-11-11 15:35:54', 'I'),
(613, 'Sopó', 87, 15, 1, '2022-11-11 15:35:54', 'I'),
(614, 'Subachoque', 88, 15, 1, '2022-11-11 15:35:54', 'I'),
(615, 'Suesca', 89, 15, 1, '2022-11-11 15:35:54', 'I'),
(616, 'Supatá', 90, 15, 1, '2022-11-11 15:35:54', 'I'),
(617, 'Susa', 91, 15, 1, '2022-11-11 15:35:54', 'I'),
(618, 'Sutatausa', 92, 15, 1, '2022-11-11 15:35:54', 'I'),
(619, 'Tabio', 93, 15, 1, '2022-11-11 15:35:54', 'I'),
(620, 'Tausa', 94, 15, 1, '2022-11-11 15:35:54', 'I'),
(621, 'Tena', 95, 15, 1, '2022-11-11 15:35:54', 'I'),
(622, 'Tenjo', 96, 15, 1, '2022-11-11 15:35:54', 'I'),
(623, 'Tibacuy', 97, 15, 1, '2022-11-11 15:35:54', 'I'),
(624, 'Tibirita', 98, 15, 1, '2022-11-11 15:35:54', 'I'),
(625, 'Tocaima', 99, 15, 1, '2022-11-11 15:35:54', 'I'),
(626, 'Tocancipá', 100, 15, 1, '2022-11-11 15:35:54', 'I'),
(627, 'Topaipí', 101, 15, 1, '2022-11-11 15:35:54', 'I'),
(628, 'Ubalá', 102, 15, 1, '2022-11-11 15:35:54', 'I'),
(629, 'Ubaque', 103, 15, 1, '2022-11-11 15:35:54', 'I'),
(630, 'Une', 104, 15, 1, '2022-11-11 15:35:54', 'I'),
(631, 'Útica', 105, 15, 1, '2022-11-11 15:35:54', 'I'),
(632, 'Venecia', 106, 15, 1, '2022-11-11 15:35:54', 'I'),
(633, 'Vergara', 107, 15, 1, '2022-11-11 15:35:54', 'I'),
(634, 'Vianí', 108, 15, 1, '2022-11-11 15:35:54', 'I'),
(635, 'Villa de San Diego de Ubaté', 109, 15, 1, '2022-11-11 15:35:54', 'I'),
(636, 'Villagómez', 110, 15, 1, '2022-11-11 15:35:54', 'I'),
(637, 'Villapinzón', 111, 15, 1, '2022-11-11 15:35:54', 'I'),
(638, 'Villeta', 112, 15, 1, '2022-11-11 15:35:54', 'I'),
(639, 'Viotá', 113, 15, 1, '2022-11-11 15:35:54', 'I'),
(640, 'Yacopí', 114, 15, 1, '2022-11-11 15:35:54', 'I'),
(641, 'Zipacón', 115, 15, 1, '2022-11-11 15:35:54', 'I'),
(642, 'Zipaquirá', 116, 15, 1, '2022-11-11 15:35:54', 'I'),
(643, 'Barranco Minas', 1, 16, 1, '2022-11-11 15:35:54', 'I'),
(644, 'Cacahual', 2, 16, 1, '2022-11-11 15:35:54', 'I'),
(645, 'Inírida', 3, 16, 1, '2022-11-11 15:35:54', 'I'),
(646, 'La Guadalupe', 4, 16, 1, '2022-11-11 15:35:54', 'I'),
(647, 'Mapiripana', 5, 16, 1, '2022-11-11 15:35:54', 'I'),
(648, 'Morichal', 6, 16, 1, '2022-11-11 15:35:54', 'I'),
(649, 'Pana Pana', 7, 16, 1, '2022-11-11 15:35:54', 'I'),
(650, 'Puerto Colombia', 8, 16, 1, '2022-11-11 15:35:54', 'I'),
(651, 'San Felipe', 9, 16, 1, '2022-11-11 15:35:54', 'I'),
(652, 'Calamar', 1, 17, 1, '2022-11-11 15:35:54', 'I'),
(653, 'El Retorno', 2, 17, 1, '2022-11-11 15:35:54', 'I'),
(654, 'Miraflores', 3, 17, 1, '2022-11-11 15:35:54', 'I'),
(655, 'San José del Guaviare', 4, 17, 1, '2022-11-11 15:35:54', 'I'),
(656, 'Acevedo', 1, 18, 1, '2022-11-11 15:35:54', 'I'),
(657, 'Agrado', 2, 18, 1, '2022-11-11 15:35:54', 'I'),
(658, 'Aipe', 3, 18, 1, '2022-11-11 15:35:54', 'I'),
(659, 'Algeciras', 4, 18, 1, '2022-11-11 15:35:54', 'I'),
(660, 'Altamira', 5, 18, 1, '2022-11-11 15:35:54', 'I'),
(661, 'Baraya', 6, 18, 1, '2022-11-11 15:35:54', 'I'),
(662, 'Campoalegre', 7, 18, 1, '2022-11-11 15:35:54', 'I'),
(663, 'Colombia', 8, 18, 1, '2022-11-11 15:35:54', 'I'),
(664, 'Elías', 9, 18, 1, '2022-11-11 15:35:54', 'I'),
(665, 'Garzón', 10, 18, 1, '2022-11-11 15:35:54', 'I'),
(666, 'Gigante', 11, 18, 1, '2022-11-11 15:35:54', 'I'),
(667, 'Guadalupe', 12, 18, 1, '2022-11-11 15:35:54', 'I'),
(668, 'Hobo', 13, 18, 1, '2022-11-11 15:35:54', 'I'),
(669, 'Íquira', 14, 18, 1, '2022-11-11 15:35:54', 'I'),
(670, 'Isnos', 15, 18, 1, '2022-11-11 15:35:54', 'I'),
(671, 'La Argentina', 16, 18, 1, '2022-11-11 15:35:54', 'I'),
(672, 'La Plata', 17, 18, 1, '2022-11-11 15:35:54', 'I'),
(673, 'Nátaga', 18, 18, 1, '2022-11-11 15:35:54', 'I'),
(674, 'Neiva', 19, 18, 1, '2022-11-11 15:35:54', 'I'),
(675, 'Oporapa', 20, 18, 1, '2022-11-11 15:35:54', 'I'),
(676, 'Paicol', 21, 18, 1, '2022-11-11 15:35:54', 'I'),
(677, 'Palermo', 22, 18, 1, '2022-11-11 15:35:54', 'I'),
(678, 'Palestina', 23, 18, 1, '2022-11-11 15:35:54', 'I'),
(679, 'Pital', 24, 18, 1, '2022-11-11 15:35:54', 'I'),
(680, 'Pitalito', 25, 18, 1, '2022-11-11 15:35:54', 'I'),
(681, 'Rivera', 26, 18, 1, '2022-11-11 15:35:54', 'I'),
(682, 'Saladoblanco', 27, 18, 1, '2022-11-11 15:35:54', 'I'),
(683, 'San Agustín', 28, 18, 1, '2022-11-11 15:35:54', 'I'),
(684, 'Santa María', 29, 18, 1, '2022-11-11 15:35:54', 'I'),
(685, 'Suaza', 30, 18, 1, '2022-11-11 15:35:54', 'I'),
(686, 'Tarqui', 31, 18, 1, '2022-11-11 15:35:54', 'I'),
(687, 'Tello', 32, 18, 1, '2022-11-11 15:35:54', 'I'),
(688, 'Teruel', 33, 18, 1, '2022-11-11 15:35:54', 'I'),
(689, 'Tesalia', 34, 18, 1, '2022-11-11 15:35:54', 'I'),
(690, 'Timaná', 35, 18, 1, '2022-11-11 15:35:54', 'I'),
(691, 'Villavieja', 36, 18, 1, '2022-11-11 15:35:54', 'I'),
(692, 'Yaguará', 37, 18, 1, '2022-11-11 15:35:54', 'I'),
(693, 'Albania', 1, 19, 1, '2022-11-11 15:35:54', 'I'),
(694, 'Barrancas', 2, 19, 1, '2022-11-11 15:35:54', 'I'),
(695, 'Dibulla', 3, 19, 1, '2022-11-11 15:35:54', 'I'),
(696, 'Distracción', 4, 19, 1, '2022-11-11 15:35:54', 'I'),
(697, 'El Molino', 5, 19, 1, '2022-11-11 15:35:54', 'I'),
(698, 'Fonseca', 6, 19, 1, '2022-11-11 15:35:54', 'I'),
(699, 'Hatonuevo', 7, 19, 1, '2022-11-11 15:35:54', 'I'),
(700, 'La Jagua del Pilar', 8, 19, 1, '2022-11-11 15:35:54', 'I'),
(701, 'Maicao', 9, 19, 1, '2022-11-11 15:35:54', 'I'),
(702, 'Manaure', 10, 19, 1, '2022-11-11 15:35:54', 'I'),
(703, 'Riohacha', 11, 19, 1, '2022-11-11 15:35:54', 'I'),
(704, 'San Juan del Cesar', 12, 19, 1, '2022-11-11 15:35:54', 'I'),
(705, 'Uribia', 13, 19, 1, '2022-11-11 15:35:54', 'I'),
(706, 'Urumita', 14, 19, 1, '2022-11-11 15:35:54', 'I'),
(707, 'Villanueva', 15, 19, 1, '2022-11-11 15:35:54', 'I'),
(708, 'Algarrobo', 1, 20, 1, '2022-11-11 15:35:54', 'I'),
(709, 'Aracataca', 2, 20, 1, '2022-11-11 15:35:54', 'I'),
(710, 'Ariguaní', 3, 20, 1, '2022-11-11 15:35:54', 'I'),
(711, 'Cerro San Antonio', 4, 20, 1, '2022-11-11 15:35:54', 'I'),
(712, 'Chibolo', 5, 20, 1, '2022-11-11 15:35:54', 'I'),
(713, 'Ciénaga', 6, 20, 1, '2022-11-11 15:35:54', 'I'),
(714, 'Concordia', 7, 20, 1, '2022-11-11 15:35:54', 'I'),
(715, 'El Banco', 8, 20, 1, '2022-11-11 15:35:54', 'I'),
(716, 'El Piñón', 9, 20, 1, '2022-11-11 15:35:54', 'I'),
(717, 'El Retén', 10, 20, 1, '2022-11-11 15:35:54', 'I'),
(718, 'Fundación', 11, 20, 1, '2022-11-11 15:35:54', 'I'),
(719, 'Guamal', 12, 20, 1, '2022-11-11 15:35:54', 'I'),
(720, 'Nueva Granada', 13, 20, 1, '2022-11-11 15:35:54', 'I'),
(721, 'Pedraza', 14, 20, 1, '2022-11-11 15:35:54', 'I'),
(722, 'Pijiño del Carmen', 15, 20, 1, '2022-11-11 15:35:54', 'I'),
(723, 'Pivijay', 16, 20, 1, '2022-11-11 15:35:54', 'I'),
(724, 'Plato', 17, 20, 1, '2022-11-11 15:35:54', 'I'),
(725, 'Puebloviejo', 18, 20, 1, '2022-11-11 15:35:54', 'I'),
(726, 'Remolino', 19, 20, 1, '2022-11-11 15:35:54', 'I'),
(727, 'Sabanas de San Ángel', 20, 20, 1, '2022-11-11 15:35:54', 'I'),
(728, 'Salamina', 21, 20, 1, '2022-11-11 15:35:54', 'I'),
(729, 'San Sebastián de Buenavista', 22, 20, 1, '2022-11-11 15:35:54', 'I'),
(730, 'Santa Ana', 23, 20, 1, '2022-11-11 15:35:54', 'I'),
(731, 'Santa Barbara de Pinto', 24, 20, 1, '2022-11-11 15:35:54', 'I'),
(732, 'Santa Marta', 25, 20, 1, '2022-11-11 15:35:54', 'I'),
(733, 'San Zenón', 26, 20, 1, '2022-11-11 15:35:54', 'I'),
(734, 'Sitionuevo', 27, 20, 1, '2022-11-11 15:35:54', 'I'),
(735, 'Tenerife', 28, 20, 1, '2022-11-11 15:35:54', 'I'),
(736, 'Zapayán', 29, 20, 1, '2022-11-11 15:35:54', 'I'),
(737, 'Zona Bananera', 30, 20, 1, '2022-11-11 15:35:54', 'I'),
(738, 'Acacías', 1, 21, 1, '2022-11-11 15:35:54', 'I'),
(739, 'Barranca de Upía', 2, 21, 1, '2022-11-11 15:35:54', 'I'),
(740, 'Cabuyaro', 3, 21, 1, '2022-11-11 15:35:54', 'I'),
(741, 'Castilla La Nueva', 4, 21, 1, '2022-11-11 15:35:54', 'I'),
(742, 'Cubarral', 5, 21, 1, '2022-11-11 15:35:54', 'I'),
(743, 'Cumaral', 6, 21, 1, '2022-11-11 15:35:54', 'I'),
(744, 'El Calvario', 7, 21, 1, '2022-11-11 15:35:54', 'I'),
(745, 'El Castillo', 8, 21, 1, '2022-11-11 15:35:54', 'I'),
(746, 'El Dorado', 9, 21, 1, '2022-11-11 15:35:54', 'I'),
(747, 'Fuente de Oro', 10, 21, 1, '2022-11-11 15:35:54', 'I'),
(748, 'Granada', 11, 21, 1, '2022-11-11 15:35:54', 'I'),
(749, 'Guamal', 12, 21, 1, '2022-11-11 15:35:54', 'I'),
(750, 'La Macarena', 13, 21, 1, '2022-11-11 15:35:54', 'I'),
(751, 'Lejanías', 14, 21, 1, '2022-11-11 15:35:54', 'I'),
(752, 'Mapiripán', 15, 21, 1, '2022-11-11 15:35:54', 'I'),
(753, 'Mesetas', 16, 21, 1, '2022-11-11 15:35:54', 'I'),
(754, 'Puerto Concordia', 17, 21, 1, '2022-11-11 15:35:54', 'I'),
(755, 'Puerto Gaitán', 18, 21, 1, '2022-11-11 15:35:54', 'I'),
(756, 'Puerto Lleras', 19, 21, 1, '2022-11-11 15:35:54', 'I'),
(757, 'Puerto López', 20, 21, 1, '2022-11-11 15:35:54', 'I'),
(758, 'Puerto Rico', 21, 21, 1, '2022-11-11 15:35:54', 'I'),
(759, 'Restrepo', 22, 21, 1, '2022-11-11 15:35:54', 'I'),
(760, 'San Carlos de Guaroa', 23, 21, 1, '2022-11-11 15:35:54', 'I'),
(761, 'San Juan de Arama', 24, 21, 1, '2022-11-11 15:35:54', 'I'),
(762, 'San Juanito', 25, 21, 1, '2022-11-11 15:35:54', 'I'),
(763, 'San Martín', 26, 21, 1, '2022-11-11 15:35:54', 'I'),
(764, 'Uribe', 27, 21, 1, '2022-11-11 15:35:54', 'I'),
(765, 'Villavicencio', 28, 21, 1, '2022-11-11 15:35:54', 'I'),
(766, 'Vistahermosa', 29, 21, 1, '2022-11-11 15:35:54', 'I'),
(767, 'Abrego', 1, 22, 1, '2022-11-11 15:35:54', 'I'),
(768, 'Arboledas', 2, 22, 1, '2022-11-11 15:35:54', 'I'),
(769, 'Bochalema', 3, 22, 1, '2022-11-11 15:35:54', 'I'),
(770, 'Bucarasica', 4, 22, 1, '2022-11-11 15:35:54', 'I'),
(771, 'Cachirá', 5, 22, 1, '2022-11-11 15:35:54', 'I'),
(772, 'Cácota', 6, 22, 1, '2022-11-11 15:35:54', 'I'),
(773, 'Chinácota', 7, 22, 1, '2022-11-11 15:35:54', 'I'),
(774, 'Chitagá', 8, 22, 1, '2022-11-11 15:35:54', 'I'),
(775, 'Convención', 9, 22, 1, '2022-11-11 15:35:54', 'I'),
(776, 'Cúcuta', 10, 22, 1, '2022-11-11 15:35:54', 'I'),
(777, 'Cucutilla', 11, 22, 1, '2022-11-11 15:35:54', 'I'),
(778, 'Durania', 12, 22, 1, '2022-11-11 15:35:54', 'I'),
(779, 'El Carmen', 13, 22, 1, '2022-11-11 15:35:54', 'I'),
(780, 'El Tarra', 14, 22, 1, '2022-11-11 15:35:54', 'I'),
(781, 'El Zulia', 15, 22, 1, '2022-11-11 15:35:54', 'I'),
(782, 'Gramalote', 16, 22, 1, '2022-11-11 15:35:54', 'I'),
(783, 'Hacarí', 17, 22, 1, '2022-11-11 15:35:54', 'I'),
(784, 'Herrán', 18, 22, 1, '2022-11-11 15:35:54', 'I'),
(785, 'Labateca', 19, 22, 1, '2022-11-11 15:35:54', 'I'),
(786, 'La Esperanza', 20, 22, 1, '2022-11-11 15:35:54', 'I'),
(787, 'La Playa', 21, 22, 1, '2022-11-11 15:35:54', 'I'),
(788, 'Los Patios', 22, 22, 1, '2022-11-11 15:35:54', 'I'),
(789, 'Lourdes', 23, 22, 1, '2022-11-11 15:35:54', 'I'),
(790, 'Mutiscua', 24, 22, 1, '2022-11-11 15:35:54', 'I'),
(791, 'Ocaña', 25, 22, 1, '2022-11-11 15:35:54', 'I'),
(792, 'Pamplona', 26, 22, 1, '2022-11-11 15:35:54', 'I'),
(793, 'Pamplonita', 27, 22, 1, '2022-11-11 15:35:54', 'I'),
(794, 'Puerto Santander', 28, 22, 1, '2022-11-11 15:35:54', 'I'),
(795, 'Ragonvalia', 29, 22, 1, '2022-11-11 15:35:54', 'I'),
(796, 'Salazar', 30, 22, 1, '2022-11-11 15:35:54', 'I'),
(797, 'San Calixto', 31, 22, 1, '2022-11-11 15:35:54', 'I'),
(798, 'San Cayetano', 32, 22, 1, '2022-11-11 15:35:54', 'I'),
(799, 'Santiago', 33, 22, 1, '2022-11-11 15:35:54', 'I'),
(800, 'Sardinata', 34, 22, 1, '2022-11-11 15:35:54', 'I'),
(801, 'Silos', 35, 22, 1, '2022-11-11 15:35:54', 'I'),
(802, 'Teorama', 36, 22, 1, '2022-11-11 15:35:54', 'I'),
(803, 'Tibú', 37, 22, 1, '2022-11-11 15:35:54', 'I'),
(804, 'Toledo', 38, 22, 1, '2022-11-11 15:35:54', 'I'),
(805, 'Villa Caro', 39, 22, 1, '2022-11-11 15:35:54', 'I'),
(806, 'Villa del Rosario', 40, 22, 1, '2022-11-11 15:35:54', 'I'),
(807, 'Albán', 1, 23, 1, '2022-11-11 15:35:54', 'I'),
(808, 'Aldana', 2, 23, 1, '2022-11-11 15:35:54', 'I'),
(809, 'Ancuyá', 3, 23, 1, '2022-11-11 15:35:54', 'I'),
(810, 'Arboleda', 4, 23, 1, '2022-11-11 15:35:54', 'I'),
(811, 'Barbacoas', 5, 23, 1, '2022-11-11 15:35:54', 'I'),
(812, 'Belén', 6, 23, 1, '2022-11-11 15:35:54', 'I'),
(813, 'Buesaco', 7, 23, 1, '2022-11-11 15:35:54', 'I'),
(814, 'Chachagüí', 8, 23, 1, '2022-11-11 15:35:54', 'I'),
(815, 'Colón', 9, 23, 1, '2022-11-11 15:35:54', 'I'),
(816, 'Consacá', 10, 23, 1, '2022-11-11 15:35:54', 'I'),
(817, 'Contadero', 11, 23, 1, '2022-11-11 15:35:54', 'I'),
(818, 'Córdoba', 12, 23, 1, '2022-11-11 15:35:54', 'I'),
(819, 'Cuaspud', 13, 23, 1, '2022-11-11 15:35:54', 'I'),
(820, 'Cumbal', 14, 23, 1, '2022-11-11 15:35:54', 'I'),
(821, 'Cumbitara', 15, 23, 1, '2022-11-11 15:35:54', 'I'),
(822, 'El Charco', 16, 23, 1, '2022-11-11 15:35:54', 'I'),
(823, 'El Peñol', 17, 23, 1, '2022-11-11 15:35:54', 'I'),
(824, 'El Rosario', 18, 23, 1, '2022-11-11 15:35:54', 'I'),
(825, 'El Tablón de Gómez', 19, 23, 1, '2022-11-11 15:35:54', 'I'),
(826, 'El Tambo', 20, 23, 1, '2022-11-11 15:35:54', 'I'),
(827, 'Francisco Pizarro', 21, 23, 1, '2022-11-11 15:35:54', 'I'),
(828, 'Funes', 22, 23, 1, '2022-11-11 15:35:54', 'I'),
(829, 'Guachucal', 23, 23, 1, '2022-11-11 15:35:54', 'I'),
(830, 'Guaitarilla', 24, 23, 1, '2022-11-11 15:35:54', 'I'),
(831, 'Gualmatan', 25, 23, 1, '2022-11-11 15:35:54', 'I'),
(832, 'Iles', 26, 23, 1, '2022-11-11 15:35:54', 'I'),
(833, 'Imués', 27, 23, 1, '2022-11-11 15:35:54', 'I'),
(834, 'Ipiales', 28, 23, 1, '2022-11-11 15:35:54', 'I'),
(835, 'La Cruz', 29, 23, 1, '2022-11-11 15:35:54', 'I'),
(836, 'La Florida', 30, 23, 1, '2022-11-11 15:35:54', 'I'),
(837, 'La Llanada', 31, 23, 1, '2022-11-11 15:35:54', 'I'),
(838, 'La Tola', 32, 23, 1, '2022-11-11 15:35:54', 'I'),
(839, 'La Unión', 33, 23, 1, '2022-11-11 15:35:54', 'I'),
(840, 'Leiva', 34, 23, 1, '2022-11-11 15:35:54', 'I'),
(841, 'Linares', 35, 23, 1, '2022-11-11 15:35:54', 'I'),
(842, 'Los Andes', 36, 23, 1, '2022-11-11 15:35:54', 'I'),
(843, 'Magüí', 37, 23, 1, '2022-11-11 15:35:54', 'I'),
(844, 'Mallama', 38, 23, 1, '2022-11-11 15:35:54', 'I'),
(845, 'Mosquera', 39, 23, 1, '2022-11-11 15:35:54', 'I'),
(846, 'Nariño', 40, 23, 1, '2022-11-11 15:35:54', 'I'),
(847, 'Olaya Herrera', 41, 23, 1, '2022-11-11 15:35:54', 'I'),
(848, 'Ospina', 42, 23, 1, '2022-11-11 15:35:54', 'I'),
(849, 'Pasto', 43, 23, 1, '2022-11-11 15:35:54', 'I'),
(850, 'Policarpa', 44, 23, 1, '2022-11-11 15:35:54', 'I'),
(851, 'Potosí', 45, 23, 1, '2022-11-11 15:35:54', 'I'),
(852, 'Providencia', 46, 23, 1, '2022-11-11 15:35:54', 'I'),
(853, 'Puerres', 47, 23, 1, '2022-11-11 15:35:54', 'I'),
(854, 'Pupiales', 48, 23, 1, '2022-11-11 15:35:54', 'I'),
(855, 'Ricaurte', 49, 23, 1, '2022-11-11 15:35:54', 'I'),
(856, 'Roberto Payán', 50, 23, 1, '2022-11-11 15:35:54', 'I'),
(857, 'Samaniego', 51, 23, 1, '2022-11-11 15:35:54', 'I'),
(858, 'San Andrés de Tumaco', 52, 23, 1, '2022-11-11 15:35:54', 'I'),
(859, 'San Bernardo', 53, 23, 1, '2022-11-11 15:35:54', 'I'),
(860, 'Sandoná', 54, 23, 1, '2022-11-11 15:35:54', 'I'),
(861, 'San Lorenzo', 55, 23, 1, '2022-11-11 15:35:54', 'I'),
(862, 'San Pablo', 56, 23, 1, '2022-11-11 15:35:54', 'I'),
(863, 'San Pedro de Cartago', 57, 23, 1, '2022-11-11 15:35:54', 'I'),
(864, 'Santa Bárbara', 58, 23, 1, '2022-11-11 15:35:54', 'I'),
(865, 'Santacruz', 59, 23, 1, '2022-11-11 15:35:54', 'I'),
(866, 'Sapuyes', 60, 23, 1, '2022-11-11 15:35:54', 'I'),
(867, 'Taminango', 61, 23, 1, '2022-11-11 15:35:54', 'I'),
(868, 'Tangua', 62, 23, 1, '2022-11-11 15:35:54', 'I'),
(869, 'Túquerres', 63, 23, 1, '2022-11-11 15:35:54', 'I'),
(870, 'Yacuanquer', 64, 23, 1, '2022-11-11 15:35:54', 'I'),
(871, 'Colón', 1, 24, 1, '2022-11-11 15:35:54', 'I'),
(872, 'Leguízamo', 2, 24, 1, '2022-11-11 15:35:54', 'I'),
(873, 'Mocoa', 3, 24, 1, '2022-11-11 15:35:54', 'I'),
(874, 'Orito', 4, 24, 1, '2022-11-11 15:35:54', 'I'),
(875, 'Puerto Asís', 5, 24, 1, '2022-11-11 15:35:54', 'I'),
(876, 'Puerto Caicedo', 6, 24, 1, '2022-11-11 15:35:54', 'I'),
(877, 'Puerto Guzmán', 7, 24, 1, '2022-11-11 15:35:54', 'I'),
(878, 'San Francisco', 8, 24, 1, '2022-11-11 15:35:54', 'I'),
(879, 'San Miguel', 9, 24, 1, '2022-11-11 15:35:54', 'I'),
(880, 'Santiago', 10, 24, 1, '2022-11-11 15:35:54', 'I'),
(881, 'Sibundoy', 11, 24, 1, '2022-11-11 15:35:54', 'I'),
(882, 'Valle del Guamuez', 12, 24, 1, '2022-11-11 15:35:54', 'I'),
(883, 'Villagarzón', 13, 24, 1, '2022-11-11 15:35:54', 'I'),
(884, 'Armenia', 1, 25, 1, '2022-11-11 15:35:54', 'I'),
(885, 'Buenavista', 2, 25, 1, '2022-11-11 15:35:54', 'I'),
(886, 'Calarcá', 3, 25, 1, '2022-11-11 15:35:54', 'I');
INSERT INTO `_municipio` (`muni_id`, `muni_descripcion`, `muni_orden`, `depa_id`, `muni_registradorpor`, `muni_fechacambio`, `operacion`) VALUES
(887, 'Circasia', 4, 25, 1, '2022-11-11 15:35:54', 'I'),
(888, 'Córdoba', 5, 25, 1, '2022-11-11 15:35:54', 'I'),
(889, 'Filandia', 6, 25, 1, '2022-11-11 15:35:54', 'I'),
(890, 'Génova', 7, 25, 1, '2022-11-11 15:35:54', 'I'),
(891, 'La Tebaida', 8, 25, 1, '2022-11-11 15:35:54', 'I'),
(892, 'Montenegro', 9, 25, 1, '2022-11-11 15:35:54', 'I'),
(893, 'Pijao', 10, 25, 1, '2022-11-11 15:35:54', 'I'),
(894, 'Quimbaya', 11, 25, 1, '2022-11-11 15:35:54', 'I'),
(895, 'Salento', 12, 25, 1, '2022-11-11 15:35:54', 'I'),
(896, 'Apía', 1, 26, 1, '2022-11-11 15:35:54', 'I'),
(897, 'Balboa', 2, 26, 1, '2022-11-11 15:35:54', 'I'),
(898, 'Belén de Umbría', 3, 26, 1, '2022-11-11 15:35:54', 'I'),
(899, 'Dosquebradas', 4, 26, 1, '2022-11-11 15:35:54', 'I'),
(900, 'Guática', 5, 26, 1, '2022-11-11 15:35:54', 'I'),
(901, 'La Celia', 6, 26, 1, '2022-11-11 15:35:54', 'I'),
(902, 'La Virginia', 7, 26, 1, '2022-11-11 15:35:54', 'I'),
(903, 'Marsella', 8, 26, 1, '2022-11-11 15:35:54', 'I'),
(904, 'Mistrató', 9, 26, 1, '2022-11-11 15:35:54', 'I'),
(905, 'Pereira', 10, 26, 1, '2022-11-11 15:35:54', 'I'),
(906, 'Pueblo Rico', 11, 26, 1, '2022-11-11 15:35:54', 'I'),
(907, 'Quinchía', 12, 26, 1, '2022-11-11 15:35:54', 'I'),
(908, 'Santa Rosa de Cabal', 13, 26, 1, '2022-11-11 15:35:54', 'I'),
(909, 'Santuario', 14, 26, 1, '2022-11-11 15:35:54', 'I'),
(910, 'Providencia', 1, 27, 1, '2022-11-11 15:35:54', 'I'),
(911, 'San Andrés', 2, 27, 1, '2022-11-11 15:35:54', 'I'),
(912, 'Aguada', 1, 28, 1, '2022-11-11 15:35:54', 'I'),
(913, 'Albania', 2, 28, 1, '2022-11-11 15:35:54', 'I'),
(914, 'Aratoca', 3, 28, 1, '2022-11-11 15:35:54', 'I'),
(915, 'Barbosa', 4, 28, 1, '2022-11-11 15:35:54', 'I'),
(916, 'Barichara', 5, 28, 1, '2022-11-11 15:35:54', 'I'),
(917, 'Barrancabermeja', 6, 28, 1, '2022-11-11 15:35:54', 'I'),
(918, 'Betulia', 7, 28, 1, '2022-11-11 15:35:54', 'I'),
(919, 'Bolívar', 8, 28, 1, '2022-11-11 15:35:54', 'I'),
(920, 'Bucaramanga', 9, 28, 1, '2022-11-11 15:35:54', 'I'),
(921, 'Cabrera', 10, 28, 1, '2022-11-11 15:35:54', 'I'),
(922, 'California', 11, 28, 1, '2022-11-11 15:35:54', 'I'),
(923, 'Capitanejo', 12, 28, 1, '2022-11-11 15:35:54', 'I'),
(924, 'Carcasí', 13, 28, 1, '2022-11-11 15:35:54', 'I'),
(925, 'Cepitá', 14, 28, 1, '2022-11-11 15:35:54', 'I'),
(926, 'Cerrito', 15, 28, 1, '2022-11-11 15:35:54', 'I'),
(927, 'Charalá', 16, 28, 1, '2022-11-11 15:35:54', 'I'),
(928, 'Charta', 17, 28, 1, '2022-11-11 15:35:54', 'I'),
(929, 'Chima', 18, 28, 1, '2022-11-11 15:35:54', 'I'),
(930, 'Chipatá', 19, 28, 1, '2022-11-11 15:35:54', 'I'),
(931, 'Cimitarra', 20, 28, 1, '2022-11-11 15:35:54', 'I'),
(932, 'Concepción', 21, 28, 1, '2022-11-11 15:35:54', 'I'),
(933, 'Confines', 22, 28, 1, '2022-11-11 15:35:54', 'I'),
(934, 'Contratación', 23, 28, 1, '2022-11-11 15:35:54', 'I'),
(935, 'Coromoro', 24, 28, 1, '2022-11-11 15:35:54', 'I'),
(936, 'Curití', 25, 28, 1, '2022-11-11 15:35:54', 'I'),
(937, 'El Carmen de Chucurí', 26, 28, 1, '2022-11-11 15:35:54', 'I'),
(938, 'El Guacamayo', 27, 28, 1, '2022-11-11 15:35:54', 'I'),
(939, 'El Peñón', 28, 28, 1, '2022-11-11 15:35:54', 'I'),
(940, 'El Playón', 29, 28, 1, '2022-11-11 15:35:54', 'I'),
(941, 'Encino', 30, 28, 1, '2022-11-11 15:35:54', 'I'),
(942, 'Enciso', 31, 28, 1, '2022-11-11 15:35:54', 'I'),
(943, 'Florián', 32, 28, 1, '2022-11-11 15:35:54', 'I'),
(944, 'Floridablanca', 33, 28, 1, '2022-11-11 15:35:54', 'I'),
(945, 'Galán', 34, 28, 1, '2022-11-11 15:35:54', 'I'),
(946, 'Gámbita', 35, 28, 1, '2022-11-11 15:35:54', 'I'),
(947, 'Girón', 36, 28, 1, '2022-11-11 15:35:54', 'I'),
(948, 'Guaca', 37, 28, 1, '2022-11-11 15:35:54', 'I'),
(949, 'Guadalupe', 38, 28, 1, '2022-11-11 15:35:54', 'I'),
(950, 'Guapotá', 39, 28, 1, '2022-11-11 15:35:54', 'I'),
(951, 'Guavatá', 40, 28, 1, '2022-11-11 15:35:54', 'I'),
(952, 'Güepsa', 41, 28, 1, '2022-11-11 15:35:54', 'I'),
(953, 'Hato', 42, 28, 1, '2022-11-11 15:35:54', 'I'),
(954, 'Jesús María', 43, 28, 1, '2022-11-11 15:35:54', 'I'),
(955, 'Jordán', 44, 28, 1, '2022-11-11 15:35:54', 'I'),
(956, 'La Belleza', 45, 28, 1, '2022-11-11 15:35:54', 'I'),
(957, 'Landázuri', 46, 28, 1, '2022-11-11 15:35:54', 'I'),
(958, 'La Paz', 47, 28, 1, '2022-11-11 15:35:54', 'I'),
(959, 'Lebrija', 48, 28, 1, '2022-11-11 15:35:54', 'I'),
(960, 'Los Santos', 49, 28, 1, '2022-11-11 15:35:54', 'I'),
(961, 'Macaravita', 50, 28, 1, '2022-11-11 15:35:54', 'I'),
(962, 'Málaga', 51, 28, 1, '2022-11-11 15:35:54', 'I'),
(963, 'Matanza', 52, 28, 1, '2022-11-11 15:35:54', 'I'),
(964, 'Mogotes', 53, 28, 1, '2022-11-11 15:35:54', 'I'),
(965, 'Molagavita', 54, 28, 1, '2022-11-11 15:35:54', 'I'),
(966, 'Ocamonte', 55, 28, 1, '2022-11-11 15:35:54', 'I'),
(967, 'Oiba', 56, 28, 1, '2022-11-11 15:35:54', 'I'),
(968, 'Onzaga', 57, 28, 1, '2022-11-11 15:35:54', 'I'),
(969, 'Palmar', 58, 28, 1, '2022-11-11 15:35:54', 'I'),
(970, 'Palmas del Socorro', 59, 28, 1, '2022-11-11 15:35:54', 'I'),
(971, 'Páramo', 60, 28, 1, '2022-11-11 15:35:54', 'I'),
(972, 'Piedecuesta', 61, 28, 1, '2022-11-11 15:35:54', 'I'),
(973, 'Pinchote', 62, 28, 1, '2022-11-11 15:35:54', 'I'),
(974, 'Puente Nacional', 63, 28, 1, '2022-11-11 15:35:54', 'I'),
(975, 'Puerto Parra', 64, 28, 1, '2022-11-11 15:35:54', 'I'),
(976, 'Puerto Wilches', 65, 28, 1, '2022-11-11 15:35:54', 'I'),
(977, 'Rionegro', 66, 28, 1, '2022-11-11 15:35:54', 'I'),
(978, 'Sabana de Torres', 67, 28, 1, '2022-11-11 15:35:54', 'I'),
(979, 'San Andrés', 68, 28, 1, '2022-11-11 15:35:54', 'I'),
(980, 'San Benito', 69, 28, 1, '2022-11-11 15:35:54', 'I'),
(981, 'San Gil', 70, 28, 1, '2022-11-11 15:35:54', 'I'),
(982, 'San Joaquín', 71, 28, 1, '2022-11-11 15:35:54', 'I'),
(983, 'San José de Miranda', 72, 28, 1, '2022-11-11 15:35:54', 'I'),
(984, 'San Miguel', 73, 28, 1, '2022-11-11 15:35:54', 'I'),
(985, 'Santa Bárbara', 74, 28, 1, '2022-11-11 15:35:54', 'I'),
(986, 'Santa Helena del Opón', 75, 28, 1, '2022-11-11 15:35:54', 'I'),
(987, 'San Vicente de Chucurí', 76, 28, 1, '2022-11-11 15:35:54', 'I'),
(988, 'Simacota', 77, 28, 1, '2022-11-11 15:35:54', 'I'),
(989, 'Socorro', 78, 28, 1, '2022-11-11 15:35:54', 'I'),
(990, 'Suaita', 79, 28, 1, '2022-11-11 15:35:54', 'I'),
(991, 'Sucre', 80, 28, 1, '2022-11-11 15:35:54', 'I'),
(992, 'Suratá', 81, 28, 1, '2022-11-11 15:35:54', 'I'),
(993, 'Tona', 82, 28, 1, '2022-11-11 15:35:54', 'I'),
(994, 'Valle de San José', 83, 28, 1, '2022-11-11 15:35:54', 'I'),
(995, 'Vélez', 84, 28, 1, '2022-11-11 15:35:54', 'I'),
(996, 'Vetas', 85, 28, 1, '2022-11-11 15:35:54', 'I'),
(997, 'Villanueva', 86, 28, 1, '2022-11-11 15:35:54', 'I'),
(998, 'Zapatoca', 87, 28, 1, '2022-11-11 15:35:54', 'I'),
(999, 'Buenavista', 1, 29, 1, '2022-11-11 15:35:54', 'I'),
(1000, 'Caimito', 2, 29, 1, '2022-11-11 15:35:54', 'I'),
(1001, 'Chalán', 3, 29, 1, '2022-11-11 15:35:54', 'I'),
(1002, 'Colosó', 4, 29, 1, '2022-11-11 15:35:54', 'I'),
(1003, 'Corozal', 5, 29, 1, '2022-11-11 15:35:54', 'I'),
(1004, 'Coveñas', 6, 29, 1, '2022-11-11 15:35:54', 'I'),
(1005, 'El Roble', 7, 29, 1, '2022-11-11 15:35:54', 'I'),
(1006, 'Galeras', 8, 29, 1, '2022-11-11 15:35:54', 'I'),
(1007, 'Guaranda', 9, 29, 1, '2022-11-11 15:35:54', 'I'),
(1008, 'La Unión', 10, 29, 1, '2022-11-11 15:35:54', 'I'),
(1009, 'Los Palmitos', 11, 29, 1, '2022-11-11 15:35:54', 'I'),
(1010, 'Majagual', 12, 29, 1, '2022-11-11 15:35:54', 'I'),
(1011, 'Morroa', 13, 29, 1, '2022-11-11 15:35:54', 'I'),
(1012, 'Ovejas', 14, 29, 1, '2022-11-11 15:35:54', 'I'),
(1013, 'Palmito', 15, 29, 1, '2022-11-11 15:35:54', 'I'),
(1014, 'Sampués', 16, 29, 1, '2022-11-11 15:35:54', 'I'),
(1015, 'San Benito Abad', 17, 29, 1, '2022-11-11 15:35:54', 'I'),
(1016, 'San Juan de Betulia', 18, 29, 1, '2022-11-11 15:35:54', 'I'),
(1017, 'San Luis de Since', 19, 29, 1, '2022-11-11 15:35:54', 'I'),
(1018, 'San Marcos', 20, 29, 1, '2022-11-11 15:35:54', 'I'),
(1019, 'San Onofre', 21, 29, 1, '2022-11-11 15:35:54', 'I'),
(1020, 'San Pedro', 22, 29, 1, '2022-11-11 15:35:54', 'I'),
(1021, 'Santiago de Tolú', 23, 29, 1, '2022-11-11 15:35:54', 'I'),
(1022, 'Sincelejo', 24, 29, 1, '2022-11-11 15:35:54', 'I'),
(1023, 'Sucre', 25, 29, 1, '2022-11-11 15:35:54', 'I'),
(1024, 'Tolú Viejo', 26, 29, 1, '2022-11-11 15:35:54', 'I'),
(1025, 'Alpujarra', 1, 30, 1, '2022-11-11 15:35:54', 'I'),
(1026, 'Alvarado', 2, 30, 1, '2022-11-11 15:35:54', 'I'),
(1027, 'Ambalema', 3, 30, 1, '2022-11-11 15:35:54', 'I'),
(1028, 'Anzoátegui', 4, 30, 1, '2022-11-11 15:35:54', 'I'),
(1029, 'Armero', 5, 30, 1, '2022-11-11 15:35:54', 'I'),
(1030, 'Ataco', 6, 30, 1, '2022-11-11 15:35:54', 'I'),
(1031, 'Cajamarca', 7, 30, 1, '2022-11-11 15:35:54', 'I'),
(1032, 'Carmen de Apicalá', 8, 30, 1, '2022-11-11 15:35:54', 'I'),
(1033, 'Casabianca', 9, 30, 1, '2022-11-11 15:35:54', 'I'),
(1034, 'Chaparral', 10, 30, 1, '2022-11-11 15:35:54', 'I'),
(1035, 'Coello', 11, 30, 1, '2022-11-11 15:35:54', 'I'),
(1036, 'Coyaima', 12, 30, 1, '2022-11-11 15:35:54', 'I'),
(1037, 'Cunday', 13, 30, 1, '2022-11-11 15:35:54', 'I'),
(1038, 'Dolores', 14, 30, 1, '2022-11-11 15:35:54', 'I'),
(1039, 'Espinal', 15, 30, 1, '2022-11-11 15:35:54', 'I'),
(1040, 'Falan', 16, 30, 1, '2022-11-11 15:35:54', 'I'),
(1041, 'Flandes', 17, 30, 1, '2022-11-11 15:35:54', 'I'),
(1042, 'Fresno', 18, 30, 1, '2022-11-11 15:35:54', 'I'),
(1043, 'Guamo', 19, 30, 1, '2022-11-11 15:35:54', 'I'),
(1044, 'Herveo', 20, 30, 1, '2022-11-11 15:35:54', 'I'),
(1045, 'Honda', 21, 30, 1, '2022-11-11 15:35:54', 'I'),
(1046, 'Ibagué', 22, 30, 1, '2022-11-11 15:35:54', 'I'),
(1047, 'Icononzo', 23, 30, 1, '2022-11-11 15:35:54', 'I'),
(1048, 'Lérida', 24, 30, 1, '2022-11-11 15:35:54', 'I'),
(1049, 'Líbano', 25, 30, 1, '2022-11-11 15:35:54', 'I'),
(1050, 'Mariquita', 26, 30, 1, '2022-11-11 15:35:54', 'I'),
(1051, 'Melgar', 27, 30, 1, '2022-11-11 15:35:54', 'I'),
(1052, 'Murillo', 28, 30, 1, '2022-11-11 15:35:54', 'I'),
(1053, 'Natagaima', 29, 30, 1, '2022-11-11 15:35:54', 'I'),
(1054, 'Ortega', 30, 30, 1, '2022-11-11 15:35:54', 'I'),
(1055, 'Palocabildo', 31, 30, 1, '2022-11-11 15:35:54', 'I'),
(1056, 'Piedras', 32, 30, 1, '2022-11-11 15:35:54', 'I'),
(1057, 'Planadas', 33, 30, 1, '2022-11-11 15:35:54', 'I'),
(1058, 'Prado', 34, 30, 1, '2022-11-11 15:35:54', 'I'),
(1059, 'Purificación', 35, 30, 1, '2022-11-11 15:35:54', 'I'),
(1060, 'Rioblanco', 36, 30, 1, '2022-11-11 15:35:54', 'I'),
(1061, 'Roncesvalles', 37, 30, 1, '2022-11-11 15:35:54', 'I'),
(1062, 'Rovira', 38, 30, 1, '2022-11-11 15:35:54', 'I'),
(1063, 'Saldaña', 39, 30, 1, '2022-11-11 15:35:54', 'I'),
(1064, 'San Antonio', 40, 30, 1, '2022-11-11 15:35:54', 'I'),
(1065, 'San Luis', 41, 30, 1, '2022-11-11 15:35:54', 'I'),
(1066, 'Santa Isabel', 42, 30, 1, '2022-11-11 15:35:54', 'I'),
(1067, 'Suárez', 43, 30, 1, '2022-11-11 15:35:54', 'I'),
(1068, 'Valle de San Juan', 44, 30, 1, '2022-11-11 15:35:54', 'I'),
(1069, 'Venadillo', 45, 30, 1, '2022-11-11 15:35:54', 'I'),
(1070, 'Villahermosa', 46, 30, 1, '2022-11-11 15:35:54', 'I'),
(1071, 'Villarrica', 47, 30, 1, '2022-11-11 15:35:54', 'I'),
(1072, 'Alcalá', 1, 31, 1, '2022-11-11 15:35:54', 'I'),
(1073, 'Andalucía', 2, 31, 1, '2022-11-11 15:35:54', 'I'),
(1074, 'Ansermanuevo', 3, 31, 1, '2022-11-11 15:35:54', 'I'),
(1075, 'Argelia', 4, 31, 1, '2022-11-11 15:35:54', 'I'),
(1076, 'Bolívar', 5, 31, 1, '2022-11-11 15:35:54', 'I'),
(1077, 'Buenaventura', 6, 31, 1, '2022-11-11 15:35:54', 'I'),
(1078, 'Bugalagrande', 7, 31, 1, '2022-11-11 15:35:54', 'I'),
(1079, 'Caicedonia', 8, 31, 1, '2022-11-11 15:35:54', 'I'),
(1080, 'Cali', 9, 31, 1, '2022-11-11 15:35:54', 'I'),
(1081, 'Calima', 10, 31, 1, '2022-11-11 15:35:54', 'I'),
(1082, 'Candelaria', 11, 31, 1, '2022-11-11 15:35:54', 'I'),
(1083, 'Cartago', 12, 31, 1, '2022-11-11 15:35:54', 'I'),
(1084, 'Dagua', 13, 31, 1, '2022-11-11 15:35:54', 'I'),
(1085, 'El Águila', 14, 31, 1, '2022-11-11 15:35:54', 'I'),
(1086, 'El Cairo', 15, 31, 1, '2022-11-11 15:35:54', 'I'),
(1087, 'El Cerrito', 16, 31, 1, '2022-11-11 15:35:54', 'I'),
(1088, 'El Dovio', 17, 31, 1, '2022-11-11 15:35:54', 'I'),
(1089, 'Florida', 18, 31, 1, '2022-11-11 15:35:54', 'I'),
(1090, 'Ginebra', 19, 31, 1, '2022-11-11 15:35:54', 'I'),
(1091, 'Guacarí', 20, 31, 1, '2022-11-11 15:35:54', 'I'),
(1092, 'Guadalajara de Buga', 21, 31, 1, '2022-11-11 15:35:54', 'I'),
(1093, 'Jamundí', 22, 31, 1, '2022-11-11 15:35:54', 'I'),
(1094, 'La Cumbre', 23, 31, 1, '2022-11-11 15:35:54', 'I'),
(1095, 'La Unión', 24, 31, 1, '2022-11-11 15:35:54', 'I'),
(1096, 'La Victoria', 25, 31, 1, '2022-11-11 15:35:54', 'I'),
(1097, 'Obando', 26, 31, 1, '2022-11-11 15:35:54', 'I'),
(1098, 'Palmira', 27, 31, 1, '2022-11-11 15:35:54', 'I'),
(1099, 'Pradera', 28, 31, 1, '2022-11-11 15:35:54', 'I'),
(1100, 'Restrepo', 29, 31, 1, '2022-11-11 15:35:54', 'I'),
(1101, 'Riofrío', 30, 31, 1, '2022-11-11 15:35:54', 'I'),
(1102, 'Roldanillo', 31, 31, 1, '2022-11-11 15:35:54', 'I'),
(1103, 'San Pedro', 32, 31, 1, '2022-11-11 15:35:54', 'I'),
(1104, 'Sevilla', 33, 31, 1, '2022-11-11 15:35:54', 'I'),
(1105, 'Toro', 34, 31, 1, '2022-11-11 15:35:54', 'I'),
(1106, 'Trujillo', 35, 31, 1, '2022-11-11 15:35:54', 'I'),
(1107, 'Tuluá', 36, 31, 1, '2022-11-11 15:35:54', 'I'),
(1108, 'Ulloa', 37, 31, 1, '2022-11-11 15:35:54', 'I'),
(1109, 'Versalles', 38, 31, 1, '2022-11-11 15:35:54', 'I'),
(1110, 'Vijes', 39, 31, 1, '2022-11-11 15:35:54', 'I'),
(1111, 'Yotoco', 40, 31, 1, '2022-11-11 15:35:54', 'I'),
(1112, 'Yumbo', 41, 31, 1, '2022-11-11 15:35:54', 'I'),
(1113, 'Zarzal', 42, 31, 1, '2022-11-11 15:35:54', 'I'),
(1114, 'Carurú', 1, 32, 1, '2022-11-11 15:35:54', 'I'),
(1115, 'Mitú', 2, 32, 1, '2022-11-11 15:35:54', 'I'),
(1116, 'Pacoa', 3, 32, 1, '2022-11-11 15:35:54', 'I'),
(1117, 'Papunaua', 4, 32, 1, '2022-11-11 15:35:54', 'I'),
(1118, 'Taraira', 5, 32, 1, '2022-11-11 15:35:54', 'I'),
(1119, 'Yavaraté', 6, 32, 1, '2022-11-11 15:35:54', 'I'),
(1120, 'Cumaribo', 1, 33, 1, '2022-11-11 15:35:54', 'I'),
(1121, 'La Primavera', 2, 33, 1, '2022-11-11 15:35:54', 'I'),
(1122, 'Puerto Carreño', 3, 33, 1, '2022-11-11 15:35:54', 'I'),
(1123, 'Santa Rosalía', 4, 33, 1, '2022-11-11 15:35:54', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_pais`
--

CREATE TABLE `_pais` (
  `pais_id` bigint(20) DEFAULT NULL,
  `pais_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_codigo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_iso` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pais_registradopor` bigint(20) DEFAULT NULL,
  `pais_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_parametro`
--

CREATE TABLE `_parametro` (
  `para_id` bigint(20) DEFAULT NULL,
  `para_nombre` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `para_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `para_registradopor` bigint(20) DEFAULT NULL,
  `para_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_parametroano`
--

CREATE TABLE `_parametroano` (
  `paan_id` bigint(20) DEFAULT NULL,
  `paan_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `paan_ano` int(11) DEFAULT NULL,
  `paan_valor` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `paan_fechainicio` datetime DEFAULT NULL,
  `paan_fechafin` datetime DEFAULT NULL,
  `para_id` bigint(20) DEFAULT NULL,
  `paan_registradopor` bigint(20) DEFAULT NULL,
  `paan_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_parametroano`
--

INSERT INTO `_parametroano` (`paan_id`, `paan_descripcion`, `paan_ano`, `paan_valor`, `paan_fechainicio`, `paan_fechafin`, `para_id`, `paan_registradopor`, `paan_fechacambio`, `operacion`) VALUES
(3, 'NOMBRE_EMPRESA', 2019, 'ZORAIDA NUÑEZ GONZALEZ', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2022-11-04 22:09:53', 'U'),
(2, 'NIT_EMPRESA', 2019, '60288568-0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2022-11-04 22:10:04', 'U'),
(5, 'TELEFONO_EMPRESA', 2019, '3212974198', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2022-11-04 22:10:45', 'U'),
(4, 'DIRECCION_EMPRESA', 2019, 'CL 5 NRO. 6 - 75 NIÑA CECI', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '2022-11-04 22:11:09', 'U'),
(7, 'RANGO_FACTURACION', 2019, 'DE OR 3001 A RI 30000', '2019-07-29 11:00:35', '2019-07-29 11:00:35', 1, 1, '2022-11-04 22:11:20', 'U'),
(7, 'RANGO_FACTURACION', 2019, 'DE OR 1 A RI 30000', '2019-07-29 11:00:35', '2019-07-29 11:00:35', 1, 1, '2022-11-04 22:11:26', 'U'),
(7, 'RANGO_FACTURACION', 2019, 'DE OR 1 A OR 3000', '2019-07-29 11:00:35', '2019-07-29 11:00:35', 1, 1, '2022-11-04 22:11:35', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_personageneral`
--

CREATE TABLE `_personageneral` (
  `pege_id` bigint(255) DEFAULT NULL,
  `pege_documento` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tido_id` bigint(255) DEFAULT NULL,
  `pege_direccion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_telefono` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_correo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `muni_id` bigint(20) DEFAULT NULL,
  `pege_registradopor` bigint(20) DEFAULT NULL,
  `pege_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_personageneral`
--

INSERT INTO `_personageneral` (`pege_id`, `pege_documento`, `tido_id`, `pege_direccion`, `pege_telefono`, `pege_correo`, `muni_id`, `pege_registradopor`, `pege_fechacambio`, `operacion`) VALUES
(40, '1234', NULL, NULL, NULL, NULL, NULL, 1, '2022-11-02 18:09:23', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_personajuridica`
--

CREATE TABLE `_personajuridica` (
  `peju_id` bigint(20) DEFAULT NULL,
  `peju_razonsocial` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `peju_nombrerepresentante` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `peju_codigodane` bigint(20) DEFAULT NULL,
  `pege_id` bigint(20) DEFAULT NULL,
  `peju_registradorpor` bigint(20) DEFAULT NULL,
  `peju_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_personanatural`
--

CREATE TABLE `_personanatural` (
  `pena_id` bigint(20) DEFAULT NULL,
  `pena_documento` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_primernombre` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_segundonombre` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_primerapellido` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_segundoapellido` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_fechanacimiento` date DEFAULT NULL,
  `pena_sexo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pena_foto` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_id` bigint(20) DEFAULT NULL,
  `ciud_id` bigint(20) DEFAULT NULL,
  `pena_registradopor` bigint(20) DEFAULT NULL,
  `pena_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_personanatural`
--

INSERT INTO `_personanatural` (`pena_id`, `pena_documento`, `pena_primernombre`, `pena_segundonombre`, `pena_primerapellido`, `pena_segundoapellido`, `pena_fechanacimiento`, `pena_sexo`, `pena_foto`, `pege_id`, `ciud_id`, `pena_registradopor`, `pena_fechacambio`, `operacion`) VALUES
(38, '1234', 'nombre', '', 'apellido', NULL, NULL, NULL, NULL, 40, 0, 1, '2022-11-02 18:09:23', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_reporte`
--

CREATE TABLE `_reporte` (
  `repo_id` bigint(20) DEFAULT NULL,
  `repo_nombre` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `repo_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `repo_sql` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `repo_tipo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `anle_id` bigint(20) DEFAULT NULL,
  `repo_registradopor` bigint(20) DEFAULT NULL,
  `repo_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_rol`
--

CREATE TABLE `_rol` (
  `rol_id` bigint(20) DEFAULT NULL,
  `rol_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `rol_orden` bigint(20) DEFAULT NULL,
  `rol_visible` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `rol_registradopor` bigint(20) DEFAULT NULL,
  `rol_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_rol`
--

INSERT INTO `_rol` (`rol_id`, `rol_descripcion`, `rol_orden`, `rol_visible`, `rol_registradopor`, `rol_fechacambio`, `operacion`) VALUES
(8, 'supervisor', 2, 'SI', 1, '2022-11-02 16:08:15', 'D'),
(1, 'administrador dev.', 1, 'SI', 1, '2022-11-02 18:01:36', 'U'),
(1, 'administrador dev.', 1, 'no', 1, '2022-11-02 18:06:27', 'U'),
(1, 'administrador dev.', 1, 'NO', 1, '2022-11-02 18:06:30', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_rolfuncionalidad`
--

CREATE TABLE `_rolfuncionalidad` (
  `rofu_id` bigint(20) DEFAULT NULL,
  `rol_id` bigint(20) DEFAULT NULL,
  `func_id` bigint(20) DEFAULT NULL,
  `apli_id` bigint(20) DEFAULT NULL,
  `rofu_registradopor` bigint(20) DEFAULT NULL,
  `rofu_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_rolfuncionalidad`
--

INSERT INTO `_rolfuncionalidad` (`rofu_id`, `rol_id`, `func_id`, `apli_id`, `rofu_registradopor`, `rofu_fechacambio`, `operacion`) VALUES
(327, 5, 33, 1, 1, '2022-11-02 16:01:49', 'I'),
(328, 5, 32, 1, 1, '2022-11-02 16:01:49', 'I'),
(329, 5, 11, 1, 1, '2022-11-02 16:01:49', 'I'),
(330, 7, 27, 4, 1, '2022-11-02 16:11:35', 'I'),
(331, 5, 25, 2, 1, '2022-11-02 16:12:23', 'I'),
(332, 5, 31, 2, 1, '2022-11-02 16:12:23', 'I'),
(333, 5, 39, 2, 1, '2022-11-02 16:12:23', 'I'),
(334, 5, 23, 2, 1, '2022-11-02 16:12:23', 'I'),
(335, 5, 18, 2, 1, '2022-11-02 16:12:23', 'I'),
(336, 5, 30, 2, 1, '2022-11-02 16:12:23', 'I'),
(337, 5, 21, 2, 1, '2022-11-02 16:12:23', 'I'),
(338, 5, 22, 2, 1, '2022-11-02 16:12:23', 'I'),
(339, 5, 19, 2, 1, '2022-11-02 16:12:23', 'I'),
(340, 5, 26, 2, 1, '2022-11-02 16:12:23', 'I'),
(341, 5, 38, 2, 1, '2022-11-02 16:12:23', 'I'),
(342, 5, 35, 4, 1, '2022-11-02 16:12:50', 'I'),
(343, 5, 27, 4, 1, '2022-11-02 16:12:50', 'I'),
(344, 5, 29, 4, 1, '2022-11-02 16:12:50', 'I'),
(345, 5, 33, 1, 1, '2022-11-02 17:40:18', 'I'),
(346, 5, 32, 1, 1, '2022-11-02 17:40:18', 'I'),
(347, 5, 11, 1, 1, '2022-11-02 17:40:18', 'I'),
(348, 5, 15, 1, 1, '2022-11-02 17:40:18', 'I'),
(349, 1, 16, 1, 1, '2022-11-02 18:01:57', 'I'),
(350, 1, 33, 1, 1, '2022-11-02 18:01:57', 'I'),
(351, 1, 15, 1, 1, '2022-11-02 18:01:57', 'I'),
(352, 1, 32, 1, 1, '2022-11-02 18:01:57', 'I'),
(353, 1, 11, 1, 1, '2022-11-02 18:01:57', 'I'),
(354, 1, 25, 2, 1, '2022-11-02 18:02:18', 'I'),
(355, 1, 31, 2, 1, '2022-11-02 18:02:18', 'I'),
(356, 1, 30, 2, 1, '2022-11-02 18:02:18', 'I'),
(357, 1, 39, 2, 1, '2022-11-02 18:02:18', 'I'),
(358, 1, 23, 2, 1, '2022-11-02 18:02:18', 'I'),
(359, 1, 18, 2, 1, '2022-11-02 18:02:18', 'I'),
(360, 1, 22, 2, 1, '2022-11-02 18:02:18', 'I'),
(361, 1, 20, 2, 1, '2022-11-02 18:02:18', 'I'),
(362, 1, 21, 2, 1, '2022-11-02 18:02:18', 'I'),
(363, 1, 26, 2, 1, '2022-11-02 18:02:18', 'I'),
(364, 1, 38, 2, 1, '2022-11-02 18:02:18', 'I'),
(365, 1, 19, 2, 1, '2022-11-02 18:02:18', 'I'),
(366, 1, 35, 4, 1, '2022-11-02 18:02:30', 'I'),
(367, 1, 29, 4, 1, '2022-11-02 18:02:30', 'I'),
(368, 1, 27, 4, 1, '2022-11-02 18:02:30', 'I'),
(369, 5, 33, 1, 1, '2022-11-02 18:03:24', 'I'),
(370, 5, 32, 1, 1, '2022-11-02 18:03:24', 'I'),
(371, 5, 25, 2, 1, '2022-11-02 18:04:18', 'I'),
(372, 5, 31, 2, 1, '2022-11-02 18:04:18', 'I'),
(373, 5, 39, 2, 1, '2022-11-02 18:04:18', 'I'),
(374, 5, 23, 2, 1, '2022-11-02 18:04:18', 'I'),
(375, 5, 18, 2, 1, '2022-11-02 18:04:18', 'I'),
(376, 5, 22, 2, 1, '2022-11-02 18:04:18', 'I'),
(377, 5, 21, 2, 1, '2022-11-02 18:04:18', 'I'),
(378, 5, 26, 2, 1, '2022-11-02 18:04:18', 'I'),
(379, 5, 19, 2, 1, '2022-11-02 18:04:18', 'I'),
(380, 5, 35, 4, 1, '2022-11-02 18:04:29', 'I'),
(381, 5, 29, 4, 1, '2022-11-02 18:04:29', 'I'),
(382, 5, 27, 4, 1, '2022-11-02 18:04:29', 'I'),
(383, 2, 25, 2, 1, '2022-11-02 18:05:25', 'I'),
(384, 2, 31, 2, 1, '2022-11-02 18:05:25', 'I'),
(385, 2, 18, 2, 1, '2022-11-02 18:05:25', 'I'),
(386, 2, 21, 2, 1, '2022-11-02 18:05:25', 'I'),
(387, 2, 26, 2, 1, '2022-11-02 18:05:25', 'I'),
(388, 2, 19, 2, 1, '2022-11-02 18:05:25', 'I'),
(389, 2, 23, 2, 1, '2022-11-02 18:05:25', 'I'),
(390, 2, 22, 2, 1, '2022-11-02 18:05:25', 'I'),
(391, 2, 35, 4, 1, '2022-11-02 18:05:47', 'I'),
(392, 2, 29, 4, 1, '2022-11-02 18:05:47', 'I'),
(393, 2, 27, 4, 1, '2022-11-02 18:05:47', 'I'),
(394, 7, 27, 4, 1, '2022-11-02 18:06:00', 'I'),
(395, 5, 25, 2, 1, '2022-11-05 13:15:50', 'I'),
(396, 5, 31, 2, 1, '2022-11-05 13:15:50', 'I'),
(397, 5, 39, 2, 1, '2022-11-05 13:15:50', 'I'),
(398, 5, 23, 2, 1, '2022-11-05 13:15:50', 'I'),
(399, 5, 18, 2, 1, '2022-11-05 13:15:50', 'I'),
(400, 5, 22, 2, 1, '2022-11-05 13:15:50', 'I'),
(401, 5, 21, 2, 1, '2022-11-05 13:15:50', 'I'),
(402, 5, 26, 2, 1, '2022-11-05 13:15:50', 'I'),
(403, 5, 19, 2, 1, '2022-11-05 13:15:50', 'I'),
(404, 5, 38, 2, 1, '2022-11-05 13:15:50', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_tipodocumento`
--

CREATE TABLE `_tipodocumento` (
  `tido_id` bigint(20) DEFAULT NULL,
  `tido_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tido_abreviatura` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tido_orden` bigint(20) DEFAULT NULL,
  `tido_regisradopor` bigint(20) DEFAULT NULL,
  `tido_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_usuario`
--

CREATE TABLE `_usuario` (
  `usua_id` bigint(20) DEFAULT NULL,
  `usua_cuenta` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `usua_clave` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pege_id` bigint(20) DEFAULT NULL,
  `usua_registradopor` bigint(20) DEFAULT NULL,
  `usua_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_usuario`
--

INSERT INTO `_usuario` (`usua_id`, `usua_cuenta`, `usua_clave`, `pege_id`, `usua_registradopor`, `usua_fechacambio`, `operacion`) VALUES
(37, '1234', '1234', 40, 1, '2022-11-02 18:09:23', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_usuariorol`
--

CREATE TABLE `_usuariorol` (
  `usro_id` bigint(20) DEFAULT NULL,
  `usua_id` bigint(20) DEFAULT NULL,
  `rol_id` bigint(20) DEFAULT NULL,
  `usro_registradopor` bigint(20) DEFAULT NULL,
  `usro_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_usuariorol`
--

INSERT INTO `_usuariorol` (`usro_id`, `usua_id`, `rol_id`, `usro_registradopor`, `usro_fechacambio`, `operacion`) VALUES
(1, 1, 1, 1, '2022-11-02 18:00:41', 'U'),
(77, 37, 5, 1, '2022-11-02 18:09:55', 'I');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aplicacion`
--
ALTER TABLE `aplicacion`
  ADD PRIMARY KEY (`apli_id`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`depa_id`),
  ADD KEY `foranea_pais` (`pais_id`);

--
-- Indices de la tabla `funcionalidad`
--
ALTER TABLE `funcionalidad`
  ADD PRIMARY KEY (`func_id`),
  ADD KEY `foranea_aplicacion` (`apli_id`);

--
-- Indices de la tabla `ingresousuario`
--
ALTER TABLE `ingresousuario`
  ADD PRIMARY KEY (`inus_id`);

--
-- Indices de la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD PRIMARY KEY (`muni_id`),
  ADD KEY `foranea_departamento` (`depa_id`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`pais_id`);

--
-- Indices de la tabla `parametro`
--
ALTER TABLE `parametro`
  ADD PRIMARY KEY (`para_id`);

--
-- Indices de la tabla `parametroano`
--
ALTER TABLE `parametroano`
  ADD PRIMARY KEY (`paan_id`),
  ADD KEY `foranea_parametro` (`para_id`);

--
-- Indices de la tabla `personageneral`
--
ALTER TABLE `personageneral`
  ADD PRIMARY KEY (`pege_id`),
  ADD KEY `foranea_tipodocumento` (`tido_id`),
  ADD KEY `foranea_municipio` (`muni_id`);

--
-- Indices de la tabla `personajuridica`
--
ALTER TABLE `personajuridica`
  ADD PRIMARY KEY (`peju_id`),
  ADD KEY `foranea_personageneral` (`pege_id`);

--
-- Indices de la tabla `personanatural`
--
ALTER TABLE `personanatural`
  ADD PRIMARY KEY (`pena_id`),
  ADD KEY `foranea_personanatural` (`pege_id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `rolfuncionalidad`
--
ALTER TABLE `rolfuncionalidad`
  ADD PRIMARY KEY (`rofu_id`),
  ADD KEY `foranea_with_rol_` (`rol_id`),
  ADD KEY `foranea_with_apli_` (`apli_id`),
  ADD KEY `foranea_with_funcionalidad_` (`func_id`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`tido_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usua_id`),
  ADD KEY `foranea_con_personageneral` (`pege_id`);

--
-- Indices de la tabla `usuariorol`
--
ALTER TABLE `usuariorol`
  ADD PRIMARY KEY (`usro_id`),
  ADD KEY `foranea_con_rol` (`rol_id`),
  ADD KEY `foranea_with_usua` (`usua_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aplicacion`
--
ALTER TABLE `aplicacion`
  MODIFY `apli_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `depa_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `funcionalidad`
--
ALTER TABLE `funcionalidad`
  MODIFY `func_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `ingresousuario`
--
ALTER TABLE `ingresousuario`
  MODIFY `inus_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `municipio`
--
ALTER TABLE `municipio`
  MODIFY `muni_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1124;

--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `pais_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `parametro`
--
ALTER TABLE `parametro`
  MODIFY `para_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `parametroano`
--
ALTER TABLE `parametroano`
  MODIFY `paan_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personageneral`
--
ALTER TABLE `personageneral`
  MODIFY `pege_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `personajuridica`
--
ALTER TABLE `personajuridica`
  MODIFY `peju_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personanatural`
--
ALTER TABLE `personanatural`
  MODIFY `pena_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rol_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `rolfuncionalidad`
--
ALTER TABLE `rolfuncionalidad`
  MODIFY `rofu_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=405;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `tido_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usua_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `usuariorol`
--
ALTER TABLE `usuariorol`
  MODIFY `usro_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `foranea_pais` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`pais_id`);

--
-- Filtros para la tabla `funcionalidad`
--
ALTER TABLE `funcionalidad`
  ADD CONSTRAINT `foranea_aplicacion` FOREIGN KEY (`apli_id`) REFERENCES `aplicacion` (`apli_id`);

--
-- Filtros para la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD CONSTRAINT `foranea_departamento` FOREIGN KEY (`depa_id`) REFERENCES `departamento` (`depa_id`);

--
-- Filtros para la tabla `parametroano`
--
ALTER TABLE `parametroano`
  ADD CONSTRAINT `foranea_parametro` FOREIGN KEY (`para_id`) REFERENCES `parametro` (`para_id`);

--
-- Filtros para la tabla `personageneral`
--
ALTER TABLE `personageneral`
  ADD CONSTRAINT `foranea_municipio` FOREIGN KEY (`muni_id`) REFERENCES `municipio` (`muni_id`),
  ADD CONSTRAINT `foranea_tipodocumento` FOREIGN KEY (`tido_id`) REFERENCES `tipodocumento` (`tido_id`);

--
-- Filtros para la tabla `personajuridica`
--
ALTER TABLE `personajuridica`
  ADD CONSTRAINT `foranea_personageneral` FOREIGN KEY (`pege_id`) REFERENCES `personageneral` (`pege_id`);

--
-- Filtros para la tabla `personanatural`
--
ALTER TABLE `personanatural`
  ADD CONSTRAINT `foranea_personanatural` FOREIGN KEY (`pege_id`) REFERENCES `personageneral` (`pege_id`);

--
-- Filtros para la tabla `rolfuncionalidad`
--
ALTER TABLE `rolfuncionalidad`
  ADD CONSTRAINT `foranea_with_apli_` FOREIGN KEY (`apli_id`) REFERENCES `aplicacion` (`apli_id`),
  ADD CONSTRAINT `foranea_with_funcionalidad_` FOREIGN KEY (`func_id`) REFERENCES `funcionalidad` (`func_id`),
  ADD CONSTRAINT `foranea_with_rol_` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `foranea_con_personageneral` FOREIGN KEY (`pege_id`) REFERENCES `personageneral` (`pege_id`);

--
-- Filtros para la tabla `usuariorol`
--
ALTER TABLE `usuariorol`
  ADD CONSTRAINT `foranea_con_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`),
  ADD CONSTRAINT `foranea_with_usua` FOREIGN KEY (`usua_id`) REFERENCES `usuario` (`usua_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
