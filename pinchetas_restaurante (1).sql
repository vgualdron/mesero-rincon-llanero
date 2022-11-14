-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-11-2022 a las 13:38:53
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
-- Base de datos: `pinchetas_restaurante`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `depurar_pedidos` (IN `fecha` DATETIME, IN `fecha2` DATETIME)  NO SQL
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE idPedido INT;
    DECLARE cur1 CURSOR FOR select 
							pedi_id
							from pinchetas_restaurante.pedido where pedi_fecha BETWEEN DATE_ADD(fecha, INTERVAL 0 SECOND) AND DATE_ADD(fecha2, INTERVAL 86399 SECOND)
                            and (pedi_numerofactura is null
									or pedi_numerofactura = '');

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;
    read_loop: LOOP
      FETCH cur1 INTO idPedido;
        IF done THEN
          LEAVE read_loop;
        END IF;
		        
        delete from pinchetas_restaurante.detallepedido where pedi_id = idPedido;
        delete from pinchetas_restaurante.pedido where pedi_id = idPedido;
        
    END LOOP;

    CLOSE cur1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `enviar_a_facturado_el_pedido` (IN `idpedido` BIGINT, IN `idestado` INT, IN `registradopor` BIGINT, IN `fechacambio` DATETIME)  NO SQL
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE idProducto1, idProducto2 INT;
    DECLARE cantidad1, cantidad2 FLOAT;
    DECLARE cur1 CURSOR FOR SELECT
                            prod_id,
                            IF(ISNULL(prod_id2), prod_cantidad , 0.5 * prod_cantidad) as cantidad1,
                            prod_id2,
                            IF(ISNULL(prod_id2), 0 , 0.5 * prod_cantidad) as cantidad2
                            FROM pinchetas_restaurante.detallepedido depe
                            WHERE depe.pedi_id = idpedido;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	UPDATE pinchetas_restaurante.pedido 
              SET espe_id = idestado, pedi_registradopor = registradopor, pedi_fechacambio = fechacambio
              WHERE pedi_id = idpedido;
    OPEN cur1;
    read_loop: LOOP
      FETCH cur1 INTO idProducto1, cantidad1, idProducto2, cantidad2;
        IF done THEN
          LEAVE read_loop;
        END IF;
		        
        CALL pinchetas_restaurante.modificar_stock_producto(idProducto1, cantidad1, 'restar');
        
        IF cantidad2 > 0 THEN
          CALL pinchetas_restaurante.modificar_stock_producto(idProducto2, cantidad2, 'restar');
        END IF;
        
    END LOOP;

    CLOSE cur1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_stock_producto` (IN `idproducto` BIGINT, IN `cantidad` FLOAT, IN `accion` VARCHAR(255))  NO SQL
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE idHijo INT;
    DECLARE cantidadDependiente INT;
    DECLARE cur1 CURSOR FOR SELECT
                              prod_idhijo,
                              COALESCE(NULL, 1, depr_cantidad) as depr_cantidad
                            FROM pinchetas_restaurante.dependenciaproducto depr
                            WHERE depr.prod_idpadre = idproducto;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;
    read_loop: LOOP
      FETCH cur1 INTO idHijo,cantidadDependiente;
        IF done THEN
          LEAVE read_loop;
        END IF;
		
        IF accion = 'restar' THEN
          UPDATE pinchetas_restaurante.producto SET prod_cantidad = (prod_cantidad - (cantidad * cantidadDependiente))
          WHERE prod_id = idHijo;
        END IF;
        
        IF accion = 'sumar' THEN
          UPDATE pinchetas_restaurante.producto SET prod_cantidad = (prod_cantidad + cantidad)
          WHERE prod_id = idHijo;
        END IF;

    END LOOP;

    CLOSE cur1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_dependenciaproducto` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._dependenciaproducto ( 
    depr_id,
    prod_idpadre,
    prod_idhijo,
    depr_registradopor,
    depr_fechacambio,
    operacion 
) 
SELECT 
    depr_id,
    prod_idpadre,
    prod_idhijo,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.dependenciaproducto 
WHERE depr_id = p_id; 
DELETE FROM pinchetas_restaurante.dependenciaproducto WHERE depr_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_detallepedido` (IN `p_id` BIGINT, IN `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._detallepedido ( 
    depe_id,
    depe_descripcion,
    pedi_id,
    prod_id,
    prod_costo,
    prod_cantidad,
    prod_precio,
    depe_registradopor,
    depe_fechacambio,
    operacion 
) 
SELECT 
    depe_id,
    depe_descripcion,
    pedi_id,
    prod_id,
    prod_costo,
    prod_cantidad,
    prod_precio,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.detallepedido 
WHERE depe_id = p_id;
DELETE FROM pinchetas_restaurante.detallepedido WHERE depe_id = p_id;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_estado` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._estado ( 
    esta_id,
    esta_descripcion,
    esta_orden,
    esta_registradopor,
    esta_fechacambio,
    operacion 
) 
SELECT 
    esta_id,
    esta_descripcion,
    esta_orden,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.estado 
WHERE esta_id = p_id; 
DELETE FROM pinchetas_restaurante.estado WHERE esta_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_estadopedido` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._estadopedido ( 
    espe_id,
    espe_descripcion,
    espe_orden,
    espe_estado,
    espe_editablepedido,
    espe_registradopor,
    espe_fechacambio,
    operacion 
) 
SELECT 
    espe_id,
    espe_descripcion,
    espe_orden,
    espe_estado,
    espe_editablepedido,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.estadopedido 
WHERE espe_id = p_id; 
DELETE FROM pinchetas_restaurante.estadopedido WHERE espe_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_factura` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._factura ( 
    fact_id,
    fact_fecha,
    fact_total,
    pege_idmesero,
    mesa_id,
    pedi_id,
    fact_registradopor,
    fact_fechacambio,
    operacion 
) 
SELECT 
    fact_id,
    fact_fecha,
    fact_total,
    pege_idmesero,
    mesa_id,
    pedi_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.factura 
WHERE fact_id = p_id; 
DELETE FROM pinchetas_restaurante.factura WHERE fact_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_gasto` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._gasto ( 
    gast_id,
    gast_descripcion,
    gast_valor,
    gast_fecha,
    pege_idregistrador,
    gast_registradopor,
    gast_fechacambio,
    operacion 
) 
SELECT 
    gast_id,
    gast_descripcion,
    gast_valor,
    gast_fecha,
    pege_idregistrador,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.gasto 
WHERE gast_id = p_id; 
DELETE FROM pinchetas_restaurante.gasto WHERE gast_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_mesa` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._mesa ( 
    mesa_id,
    mesa_descripcion,
    mesa_orden,
    mesa_estado,
    mesa_registradopor,
    mesa_fechacambio,
    operacion 
) 
SELECT 
    mesa_id,
    mesa_descripcion,
    mesa_orden,
    mesa_estado,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.mesa 
WHERE mesa_id = p_id; 
DELETE FROM pinchetas_restaurante.mesa WHERE mesa_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_pedido` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._pedido ( 
    pedi_id,
    pedi_fecha,
    pege_idmesero,
    mesa_id,
    espe_id,
    pedi_registradopor,
    pedi_fechacambio,
    pedi_tipopago,
    pedi_bandera,
    pedi_nombrecliente,
    pedi_direccioncliente,
    pedi_telefonocliente,
    pedi_numerofactura,
    pedi_prefijofactura,
    operacion 
) 
SELECT 
    pedi_id,
    pedi_fecha,
    pege_idmesero,
    mesa_id,
    espe_id,
    id_registradopor,
    NOW(),
    pedi_tipopago,
    pedi_bandera,
    pedi_nombrecliente,
    pedi_direccioncliente,
    pedi_telefonocliente,
    pedi_numerofactura,
    pedi_prefijofactura,
    'D' 
FROM pinchetas_restaurante.pedido 
WHERE pedi_id = p_id; 
DELETE FROM pinchetas_restaurante.pedido WHERE pedi_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_producto` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._producto ( 
    prod_id,
    prod_descripcion,
    prod_orden,
    prod_costo,
    prod_precio,
    prod_cantidad,
    prod_estado,
    tipr_id,
    prod_registradopor,
    prod_fechacambio,
    operacion 
) 
SELECT 
    prod_id,
    prod_descripcion,
    prod_orden,
    prod_costo,
    prod_precio,
    prod_cantidad,
    prod_estado,
    tipr_id,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.producto 
WHERE prod_id = p_id; 
DELETE FROM pinchetas_restaurante.producto WHERE prod_id = p_id; 
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento_eliminar_tipoproducto` (`p_id` BIGINT, `id_registradopor` BIGINT)  BEGIN
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO pinchetas_restaurante._tipoproducto ( 
    tipr_id,
    tipr_descripcion,
    tipr_orden,
    tipr_estado,
    tipr_registradopor,
    tipr_fechacambio,
    operacion 
) 
SELECT 
    tipr_id,
    tipr_descripcion,
    tipr_orden,
    tipr_estado,
    id_registradopor,
    NOW(),
    'D' 
FROM pinchetas_restaurante.tipoproducto 
WHERE tipr_id = p_id; 
DELETE FROM pinchetas_restaurante.tipoproducto WHERE tipr_id = p_id; 
COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dependenciaproducto`
--

CREATE TABLE `dependenciaproducto` (
  `depr_id` bigint(20) NOT NULL,
  `depr_cantidad` float DEFAULT NULL,
  `prod_idpadre` bigint(20) NOT NULL,
  `prod_idhijo` bigint(20) NOT NULL,
  `depr_registradopor` bigint(20) NOT NULL,
  `depr_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `dependenciaproducto`
--

INSERT INTO `dependenciaproducto` (`depr_id`, `depr_cantidad`, `prod_idpadre`, `prod_idhijo`, `depr_registradopor`, `depr_fechacambio`) VALUES
(1, NULL, 324, 324, 1, '2022-11-02 22:16:32'),
(2, NULL, 325, 325, 1, '2022-11-02 22:17:11'),
(3, NULL, 326, 326, 1, '2022-11-02 22:17:53'),
(4, NULL, 327, 327, 1, '2022-11-02 22:18:29'),
(5, NULL, 328, 328, 1, '2022-11-02 22:19:30'),
(6, NULL, 329, 329, 1, '2022-11-02 22:20:05'),
(7, NULL, 330, 330, 1, '2022-11-02 22:20:38'),
(8, NULL, 331, 331, 1, '2022-11-02 22:22:37'),
(9, NULL, 332, 332, 1, '2022-11-02 22:25:18'),
(10, NULL, 333, 333, 1, '2022-11-02 22:26:03'),
(11, NULL, 334, 334, 1, '2022-11-02 22:26:42'),
(12, NULL, 335, 335, 1, '2022-11-02 22:27:26'),
(13, NULL, 336, 336, 1, '2022-11-02 22:27:58'),
(14, NULL, 337, 337, 1, '2022-11-02 22:29:33'),
(15, NULL, 338, 338, 1, '2022-11-02 22:30:02'),
(16, NULL, 339, 339, 1, '2022-11-02 22:30:29'),
(17, NULL, 340, 340, 1, '2022-11-02 22:30:59'),
(18, NULL, 341, 341, 1, '2022-11-02 22:33:33'),
(19, NULL, 342, 342, 1, '2022-11-02 22:34:03'),
(20, NULL, 343, 343, 1, '2022-11-02 22:34:38'),
(21, NULL, 344, 344, 1, '2022-11-02 22:35:05'),
(22, NULL, 345, 345, 1, '2022-11-02 22:35:40'),
(23, NULL, 346, 346, 1, '2022-11-02 22:36:24');

--
-- Disparadores `dependenciaproducto`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_dependenciaproducto` AFTER INSERT ON `dependenciaproducto` FOR EACH ROW INSERT INTO pinchetas_restaurante._dependenciaproducto ( 
    depr_id,
    depr_cantidad,
    prod_idpadre,
    prod_idhijo,
    depr_registradopor,
    depr_fechacambio,
    operacion 
) 
VALUES ( 
    new.depr_id,
    new.depr_cantidad,
    new.prod_idpadre,
    new.prod_idhijo,
    new.depr_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_dependenciaproducto` AFTER UPDATE ON `dependenciaproducto` FOR EACH ROW INSERT INTO pinchetas_restaurante._dependenciaproducto ( 
    depr_id,
    prod_idpadre,
    prod_idhijo,
    depr_registradopor,
    depr_fechacambio,
    operacion 
) 
VALUES ( 
    new.depr_id,
    new.prod_idpadre,
    new.prod_idhijo,
    new.depr_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `depe_id` bigint(20) NOT NULL,
  `depe_referencia` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `depe_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_id` bigint(20) NOT NULL,
  `prod_id` bigint(20) NOT NULL,
  `prod_id2` int(100) DEFAULT NULL,
  `prod_costo` int(11) DEFAULT NULL,
  `prod_cantidad` float NOT NULL,
  `prod_precio` int(11) DEFAULT NULL,
  `depe_registradopor` bigint(20) NOT NULL,
  `depe_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detallepedido`
--

INSERT INTO `detallepedido` (`depe_id`, `depe_referencia`, `depe_descripcion`, `pedi_id`, `prod_id`, `prod_id2`, `prod_costo`, `prod_cantidad`, `prod_precio`, `depe_registradopor`, `depe_fechacambio`) VALUES
(1, NULL, NULL, 33030, 329, NULL, 11000, 2, 22000, 1, '2022-11-04 21:52:11'),
(2, NULL, NULL, 33031, 345, NULL, 8000, 1, 16000, 1, '2022-11-04 22:28:54'),
(3, NULL, NULL, 33031, 325, NULL, 7000, 1, 14000, 1, '2022-11-04 22:29:06'),
(4, NULL, 'sin vegetales', 33032, 333, NULL, 7500, 1, 15000, 1, '2022-11-04 23:26:59'),
(5, NULL, 'sin piña', 33032, 329, NULL, 11000, 2, 22000, 1, '2022-11-04 23:27:54'),
(6, NULL, NULL, 33032, 327, NULL, 9000, 1, 18000, 1, '2022-11-04 23:30:01'),
(7, NULL, NULL, 33032, 327, NULL, 9000, 1, 18000, 1, '2022-11-04 23:30:38'),
(8, NULL, NULL, 33032, 339, NULL, 4500, 1, 9000, 1, '2022-11-04 23:35:17'),
(9, NULL, NULL, 33033, 333, NULL, 7500, 1, 15000, 1, '2022-11-05 00:12:18'),
(10, NULL, NULL, 33033, 325, NULL, 7000, 1, 14000, 1, '2022-11-05 00:20:48'),
(11, NULL, NULL, 33034, 329, NULL, 11000, 1, 22000, 1, '2022-11-05 12:38:13'),
(12, NULL, NULL, 33034, 333, NULL, 7500, 1, 15000, 1, '2022-11-05 12:38:30'),
(13, NULL, 'SIN CEBOLLA', 33035, 329, NULL, 11000, 3, 22000, 1, '2022-11-05 12:44:49'),
(14, NULL, 'SIN CEBOLLA', 33035, 338, NULL, 4000, 2, 8000, 1, '2022-11-05 12:48:25'),
(15, NULL, NULL, 33035, 345, NULL, 8000, 1, 16000, 1, '2022-11-05 12:47:16');

--
-- Disparadores `detallepedido`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_detallepedido` AFTER INSERT ON `detallepedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._detallepedido ( 
    depe_id,
    depe_referencia,
    depe_descripcion,
    pedi_id,
    prod_id,
    prod_costo,
    prod_cantidad,
    prod_precio,
    depe_registradopor,
    depe_fechacambio,
    operacion 
) 
VALUES ( 
    new.depe_id,
    new.depe_referencia,
    new.depe_descripcion,
    new.pedi_id,
    new.prod_id,
    new.prod_costo,
    new.prod_cantidad,
    new.prod_precio,
    new.depe_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_detallepedido` AFTER UPDATE ON `detallepedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._detallepedido ( 
    depe_id,
    depe_referencia,
    depe_descripcion,
    pedi_id,
    prod_id,
    prod_costo,
    prod_cantidad,
    prod_precio,
    depe_registradopor,
    depe_fechacambio,
    operacion 
) 
VALUES ( 
    new.depe_id,
    new.depe_referencia,
    new.depe_descripcion,
    new.pedi_id,
    new.prod_id,
    new.prod_costo,
    new.prod_cantidad,
    new.prod_precio,
    new.depe_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `esta_id` bigint(20) NOT NULL,
  `esta_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `esta_orden` int(11) NOT NULL,
  `esta_registradopor` bigint(20) NOT NULL,
  `esta_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`esta_id`, `esta_descripcion`, `esta_orden`, `esta_registradopor`, `esta_fechacambio`) VALUES
(1, 'ACTIVO', 2, 1, '2019-03-17 03:33:15'),
(2, 'INACTIVO', 3, 1, '2019-03-17 03:33:28'),
(3, 'ACTIVO SOLO INVENTARIO', 1, 1, '2021-09-16 07:56:50');

--
-- Disparadores `estado`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_estado` AFTER INSERT ON `estado` FOR EACH ROW INSERT INTO pinchetas_restaurante._estado ( 
    esta_id,
    esta_descripcion,
    esta_orden,
    esta_registradopor,
    esta_fechacambio,
    operacion 
) 
VALUES ( 
    new.esta_id,
    new.esta_descripcion,
    new.esta_orden,
    new.esta_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_estado` AFTER UPDATE ON `estado` FOR EACH ROW INSERT INTO pinchetas_restaurante._estado ( 
    esta_id,
    esta_descripcion,
    esta_orden,
    esta_registradopor,
    esta_fechacambio,
    operacion 
) 
VALUES ( 
    new.esta_id,
    new.esta_descripcion,
    new.esta_orden,
    new.esta_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadopedido`
--

CREATE TABLE `estadopedido` (
  `espe_id` bigint(20) NOT NULL,
  `espe_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `espe_orden` int(11) NOT NULL,
  `espe_estado` text COLLATE utf8_spanish_ci NOT NULL,
  `espe_editablepedido` text COLLATE utf8_spanish_ci NOT NULL,
  `espe_registradopor` bigint(20) NOT NULL,
  `espe_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estadopedido`
--

INSERT INTO `estadopedido` (`espe_id`, `espe_descripcion`, `espe_orden`, `espe_estado`, `espe_editablepedido`, `espe_registradopor`, `espe_fechacambio`) VALUES
(1, 'CREADO', 1, 'ACTIVO', 'SI', 1, '0000-00-00 00:00:00'),
(2, 'INICIADO', 2, 'ACTIVO', 'SI', 1, '0000-00-00 00:00:00'),
(3, 'PREPARANDO', 3, 'ACTIVO', 'NO', 1, '0000-00-00 00:00:00'),
(4, 'ENTREGADO', 4, 'ACTIVO', 'NO', 1, '0000-00-00 00:00:00'),
(5, 'FACTURADO', 5, 'ACTIVO', 'NO', 1, '0000-00-00 00:00:00'),
(6, 'ANULADO', 0, 'ACTIVO', 'NO', 1, '0000-00-00 00:00:00'),
(7, 'PAGO', 6, 'ACTIVO', 'NO', 1, '0000-00-00 00:00:00');

--
-- Disparadores `estadopedido`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_estadopedido` AFTER INSERT ON `estadopedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._estadopedido ( 
    espe_id,
    espe_descripcion,
    espe_orden,
    espe_estado,
    espe_editablepedido,
    espe_registradopor,
    espe_fechacambio,
    operacion 
) 
VALUES ( 
    new.espe_id,
    new.espe_descripcion,
    new.espe_orden,
    new.espe_estado,
    new.espe_editablepedido,
    new.espe_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_estadopedido` AFTER UPDATE ON `estadopedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._estadopedido ( 
    espe_id,
    espe_descripcion,
    espe_orden,
    espe_estado,
    espe_editablepedido,
    espe_registradopor,
    espe_fechacambio,
    operacion 
) 
VALUES ( 
    new.espe_id,
    new.espe_descripcion,
    new.espe_orden,
    new.espe_estado,
    new.espe_editablepedido,
    new.espe_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `fact_id` bigint(20) NOT NULL,
  `fact_fecha` datetime NOT NULL,
  `fact_total` int(11) NOT NULL,
  `pege_idmesero` bigint(20) NOT NULL,
  `mesa_id` bigint(20) NOT NULL,
  `pedi_id` bigint(20) NOT NULL,
  `fact_registradopor` bigint(20) NOT NULL,
  `fact_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `factura`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_factura` AFTER INSERT ON `factura` FOR EACH ROW INSERT INTO pinchetas_restaurante._factura ( 
    fact_id,
    fact_fecha,
    fact_total,
    pege_idmesero,
    mesa_id,
    pedi_id,
    fact_registradopor,
    fact_fechacambio,
    operacion 
) 
VALUES ( 
    new.fact_id,
    new.fact_fecha,
    new.fact_total,
    new.pege_idmesero,
    new.mesa_id,
    new.pedi_id,
    new.fact_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_factura` AFTER UPDATE ON `factura` FOR EACH ROW INSERT INTO pinchetas_restaurante._factura ( 
    fact_id,
    fact_fecha,
    fact_total,
    pege_idmesero,
    mesa_id,
    pedi_id,
    fact_registradopor,
    fact_fechacambio,
    operacion 
) 
VALUES ( 
    new.fact_id,
    new.fact_fecha,
    new.fact_total,
    new.pege_idmesero,
    new.mesa_id,
    new.pedi_id,
    new.fact_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto`
--

CREATE TABLE `gasto` (
  `gast_id` bigint(20) NOT NULL,
  `gast_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `gast_valor` int(11) NOT NULL,
  `gast_fecha` date NOT NULL,
  `pege_idregistrador` bigint(20) NOT NULL,
  `gast_registradopor` bigint(20) NOT NULL,
  `gast_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `gasto`
--

INSERT INTO `gasto` (`gast_id`, `gast_descripcion`, `gast_valor`, `gast_fecha`, `pege_idregistrador`, `gast_registradopor`, `gast_fechacambio`) VALUES
(1, 'GLOBOS DECORACIÓN', 10000, '2022-11-05', 1, 1, '2022-11-05 13:02:58');

--
-- Disparadores `gasto`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_gasto` AFTER INSERT ON `gasto` FOR EACH ROW INSERT INTO pinchetas_restaurante._gasto ( 
    gast_id,
    gast_descripcion,
    gast_valor,
    gast_fecha,
    pege_idregistrador,
    gast_registradopor,
    gast_fechacambio,
    operacion 
) 
VALUES ( 
    new.gast_id,
    new.gast_descripcion,
    new.gast_valor,
    new.gast_fecha,
    new.pege_idregistrador,
    new.gast_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_gasto` AFTER UPDATE ON `gasto` FOR EACH ROW INSERT INTO pinchetas_restaurante._gasto ( 
    gast_id,
    gast_descripcion,
    gast_valor,
    gast_fecha,
    pege_idregistrador,
    gast_registradopor,
    gast_fechacambio,
    operacion 
) 
VALUES ( 
    new.gast_id,
    new.gast_descripcion,
    new.gast_valor,
    new.gast_fecha,
    new.pege_idregistrador,
    new.gast_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE `mesa` (
  `mesa_id` bigint(20) NOT NULL,
  `mesa_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `mesa_orden` int(11) NOT NULL,
  `mesa_estado` text COLLATE utf8_spanish_ci NOT NULL,
  `mesa_registradopor` bigint(20) NOT NULL,
  `mesa_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`mesa_id`, `mesa_descripcion`, `mesa_orden`, `mesa_estado`, `mesa_registradopor`, `mesa_fechacambio`) VALUES
(1, 'MESA 1', 1, 'ACTIVO', 1, '2019-03-17 03:41:43'),
(2, 'MESA 2', 2, 'ACTIVO', 1, '2019-03-17 03:41:57'),
(3, 'MESA 3', 3, 'ACTIVO', 1, '2019-03-17 03:42:09'),
(4, 'MESA 4', 4, 'ACTIVO', 1, '2019-03-17 03:42:22'),
(5, 'MESA 5', 5, 'ACTIVO', 1, '2019-03-17 03:43:55'),
(6, 'MESA 6', 6, 'ACTIVO', 1, '2019-03-17 03:42:46'),
(7, 'MESA 7', 7, 'ACTIVO', 1, '2019-03-17 03:44:11'),
(8, 'MESA 8', 8, 'ACTIVO', 1, '2019-03-17 03:44:26'),
(9, 'MESA 9', 9, 'ACTIVO', 1, '2019-03-17 03:44:41'),
(10, 'MESA 10', 10, 'ACTIVO', 1, '2019-03-17 03:44:51'),
(12, 'MESA 13', 13, 'ACTIVO', 1, '2020-10-31 21:24:51'),
(13, 'MESA 11', 11, 'ACTIVO', 1, '2020-10-31 21:24:28'),
(14, 'MESA 12', 12, 'ACTIVO', 1, '2020-10-31 21:24:39'),
(15, 'MESA 14', 14, 'ACTIVO', 1, '2020-10-31 21:25:11'),
(16, 'MESA 15', 15, 'ACTIVO', 1, '2020-10-31 21:25:22'),
(17, 'DOMICILIO 1', 30, 'ACTIVO', 1, '2020-10-31 21:29:02'),
(18, 'DOMICILIO 2', 31, 'ACTIVO', 1, '2020-10-31 21:29:08'),
(19, 'DOMICILIO 3', 32, 'ACTIVO', 1, '2020-10-31 21:29:14'),
(26, 'DE LLEVAR 1', 36, 'ACTIVO', 1, '2019-07-29 17:00:38'),
(27, 'DE LLEVAR 2', 37, 'ACTIVO', 1, '2019-07-29 17:00:48'),
(28, 'DE LLEVAR 3', 38, 'ACTIVO', 1, '2019-07-29 17:00:56'),
(29, 'DE LLEVAR 4', 39, 'ACTIVO', 1, '2019-11-01 21:11:35'),
(30, 'DE LLEVAR 5', 40, 'ACTIVO', 1, '2019-11-01 21:11:44'),
(36, 'DOMICILIO 4', 33, 'ACTIVO', 1, '2020-10-31 21:29:25'),
(37, 'DOMICILIO 5', 34, 'ACTIVO', 1, '2020-10-31 21:29:38');

--
-- Disparadores `mesa`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_mesa` AFTER INSERT ON `mesa` FOR EACH ROW INSERT INTO pinchetas_restaurante._mesa ( 
    mesa_id,
    mesa_descripcion,
    mesa_orden,
    mesa_estado,
    mesa_registradopor,
    mesa_fechacambio,
    operacion 
) 
VALUES ( 
    new.mesa_id,
    new.mesa_descripcion,
    new.mesa_orden,
    new.mesa_estado,
    new.mesa_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_mesa` AFTER UPDATE ON `mesa` FOR EACH ROW INSERT INTO pinchetas_restaurante._mesa ( 
    mesa_id,
    mesa_descripcion,
    mesa_orden,
    mesa_estado,
    mesa_registradopor,
    mesa_fechacambio,
    operacion 
) 
VALUES ( 
    new.mesa_id,
    new.mesa_descripcion,
    new.mesa_orden,
    new.mesa_estado,
    new.mesa_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `pedi_id` bigint(20) NOT NULL,
  `pedi_fecha` datetime NOT NULL,
  `pege_idmesero` bigint(20) NOT NULL,
  `mesa_id` bigint(20) NOT NULL,
  `espe_id` bigint(20) NOT NULL,
  `pedi_registradopor` bigint(20) NOT NULL,
  `pedi_fechacambio` datetime NOT NULL,
  `pedi_tipopago` text COLLATE utf8_spanish_ci NOT NULL,
  `pedi_bandera` tinyint(1) NOT NULL,
  `pedi_nombrecliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_direccioncliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_telefonocliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_prefijofactura` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_numerofactura` bigint(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`pedi_id`, `pedi_fecha`, `pege_idmesero`, `mesa_id`, `espe_id`, `pedi_registradopor`, `pedi_fechacambio`, `pedi_tipopago`, `pedi_bandera`, `pedi_nombrecliente`, `pedi_direccioncliente`, `pedi_telefonocliente`, `pedi_prefijofactura`, `pedi_numerofactura`) VALUES
(33029, '2022-11-02 22:22:55', 1, 1, 6, 1, '2022-11-04 00:00:00', 'EFECTIVO', 0, '', '', '', NULL, NULL),
(33030, '2022-11-04 21:51:55', 1, 1, 7, 1, '2022-11-04 00:00:00', 'EFECTIVO', 1, '', '', '', 'RI', 1),
(33031, '2022-11-04 22:28:18', 1, 1, 7, 1, '2022-11-04 00:00:00', 'EFECTIVO', 1, '', '', '', 'RI', 2),
(33032, '2022-11-04 23:05:39', 1, 2, 7, 1, '2022-11-04 00:00:00', 'EFECTIVO', 1, '', '', '', 'RI', 3),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 00:00:00', 'EFECTIVO', 0, '', '', '', NULL, NULL),
(33034, '2022-11-05 00:20:17', 1, 2, 2, 1, '2022-11-05 00:00:00', 'EFECTIVO', 0, '', '', '', NULL, NULL),
(33035, '2022-11-05 12:44:26', 1, 5, 7, 1, '2022-11-05 00:00:00', 'EFECTIVO', 1, 'VICTOR', 'CALLE', '3043427319', 'RI', 4),
(33036, '2022-11-05 12:57:05', 1, 3, 1, 1, '2022-11-05 12:57:05', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL),
(33037, '2022-11-05 13:00:03', 1, 4, 1, 1, '2022-11-05 13:00:03', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL),
(33038, '2022-11-05 13:00:43', 1, 5, 6, 1, '2022-11-05 00:00:00', 'EFECTIVO', 0, '', '', '', NULL, NULL);

--
-- Disparadores `pedido`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_pedido` AFTER INSERT ON `pedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._pedido ( 
    pedi_id,
    pedi_fecha,
    pege_idmesero,
    mesa_id,
    espe_id,
    pedi_registradopor,
    pedi_fechacambio,
    pedi_tipopago,
    pedi_bandera,
    pedi_nombrecliente,
    pedi_direccioncliente,
    pedi_telefonocliente,
    pedi_numerofactura,
    pedi_prefijofactura,
    operacion 
) 
VALUES ( 
    new.pedi_id,
    new.pedi_fecha,
    new.pege_idmesero,
    new.mesa_id,
    new.espe_id,
    new.pedi_registradopor,
    NOW(),
    new.pedi_tipopago,
    new.pedi_bandera,
    new.pedi_nombrecliente,
    new.pedi_direccioncliente,
    new.pedi_telefonocliente,
    new.pedi_numerofactura,
    new.pedi_prefijofactura,
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_pedido` AFTER UPDATE ON `pedido` FOR EACH ROW INSERT INTO pinchetas_restaurante._pedido ( 
    pedi_id,
    pedi_fecha,
    pege_idmesero,
    mesa_id,
    espe_id,
    pedi_registradopor,
    pedi_fechacambio,
    pedi_tipopago,
    pedi_bandera,
    pedi_nombrecliente,
    pedi_direccioncliente,
    pedi_telefonocliente,
    pedi_numerofactura,
    pedi_prefijofactura,
    operacion 
) 
VALUES ( 
    new.pedi_id,
    new.pedi_fecha,
    new.pege_idmesero,
    new.mesa_id,
    new.espe_id,
    new.pedi_registradopor,
    NOW(),
    new.pedi_tipopago,
    new.pedi_bandera,
    new.pedi_nombrecliente,
    new.pedi_direccioncliente,
    new.pedi_telefonocliente,
    new.pedi_numerofactura,
    new.pedi_prefijofactura,
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prod_id` bigint(20) NOT NULL,
  `prod_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `prod_orden` int(11) NOT NULL,
  `prod_costo` int(11) NOT NULL,
  `prod_precio` int(11) NOT NULL,
  `prod_cantidad` float NOT NULL,
  `prod_estado` text COLLATE utf8_spanish_ci NOT NULL,
  `tipr_id` bigint(20) NOT NULL,
  `prod_registradopor` bigint(20) NOT NULL,
  `prod_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`prod_id`, `prod_descripcion`, `prod_orden`, `prod_costo`, `prod_precio`, `prod_cantidad`, `prod_estado`, `tipr_id`, `prod_registradopor`, `prod_fechacambio`) VALUES
(324, 'HAMBURGUESA CLASICA', 1, 7000, 14000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:16:32'),
(325, 'HAMBURGUESA CHICKEN CLASSIC', 2, 7000, 14000, 999, 'ACTIVO', 40, 1, '2022-11-02 22:17:11'),
(326, 'HAMBURGUESA CHICKEN CRISPY', 3, 7000, 14000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:17:53'),
(327, 'HAMBURGUESA CAMPESINA', 4, 9000, 18000, 998, 'ACTIVO', 40, 1, '2022-11-02 22:18:42'),
(328, 'HAMBURGUESA RANCHERA', 5, 9000, 18000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:19:30'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 1000, 'ACTIVO', 40, 1, '2022-11-05 13:11:18'),
(330, 'HAMBURGUESA ORIGEN', 7, 11000, 22000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:20:38'),
(331, 'SALCHIPAPA CLASICA', 1, 6000, 12000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:22:37'),
(332, 'SALCHIPAPA CLASICA RANCHERA', 2, 7500, 15000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:25:18'),
(333, 'SALCHIPAPA CHICKEN', 3, 7500, 15000, 999, 'ACTIVO', 41, 1, '2022-11-02 22:26:03'),
(334, 'SALCHIPAPA VAQUERA', 4, 9000, 18000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:26:42'),
(335, 'SALCHIPAPA SAL-CHICHA-RON', 5, 11000, 22000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:27:26'),
(336, 'SALCHIPAPA ORIGEN', 6, 12000, 24000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:27:58'),
(337, 'PERRO SENCILLO', 1, 3000, 6000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:29:33'),
(338, 'PERRO AMERICANO', 1, 4000, 8000, 998, 'ACTIVO', 42, 1, '2022-11-02 22:30:02'),
(339, 'PERRO ALEMAN', 3, 4500, 9000, 999, 'ACTIVO', 42, 1, '2022-11-02 22:30:29'),
(340, 'PERRO CON POLLO', 4, 5000, 10000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:30:59'),
(341, 'MAICITO DE POLLO', 1, 8000, 16000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:33:33'),
(342, 'MAICITO DE CARNE', 2, 9000, 18000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:34:03'),
(343, 'MAICITO MIXTO', 3, 9000, 18000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:34:38'),
(344, 'PINCHO DE POLLO', 1, 7000, 14000, 1000, 'ACTIVO', 44, 1, '2022-11-02 22:35:05'),
(345, 'PINCHO DE CARNE', 2, 8000, 16000, 998, 'ACTIVO', 44, 1, '2022-11-02 22:35:40'),
(346, 'PINCHO MIXTO', 3, 8000, 16000, 1000, 'ACTIVO', 44, 1, '2022-11-02 22:36:24');

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_producto` AFTER INSERT ON `producto` FOR EACH ROW INSERT INTO pinchetas_restaurante._producto ( 
    prod_id,
    prod_descripcion,
    prod_orden,
    prod_costo,
    prod_precio,
    prod_cantidad,
    prod_estado,
    tipr_id,
    prod_registradopor,
    prod_fechacambio,
    operacion 
) 
VALUES ( 
    new.prod_id,
    new.prod_descripcion,
    new.prod_orden,
    new.prod_costo,
    new.prod_precio,
    new.prod_cantidad,
    new.prod_estado,
    new.tipr_id,
    new.prod_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_producto` AFTER UPDATE ON `producto` FOR EACH ROW INSERT INTO pinchetas_restaurante._producto ( 
    prod_id,
    prod_descripcion,
    prod_orden,
    prod_costo,
    prod_precio,
    prod_cantidad,
    prod_estado,
    tipr_id,
    prod_registradopor,
    prod_fechacambio,
    operacion 
) 
VALUES ( 
    new.prod_id,
    new.prod_descripcion,
    new.prod_orden,
    new.prod_costo,
    new.prod_precio,
    new.prod_cantidad,
    new.prod_estado,
    new.tipr_id,
    new.prod_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoproducto`
--

CREATE TABLE `tipoproducto` (
  `tipr_id` bigint(20) NOT NULL,
  `tipr_descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `tipr_orden` int(11) NOT NULL,
  `tipr_estado` text COLLATE utf8_spanish_ci NOT NULL,
  `tipr_registradopor` bigint(20) NOT NULL,
  `tipr_fechacambio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipoproducto`
--

INSERT INTO `tipoproducto` (`tipr_id`, `tipr_descripcion`, `tipr_orden`, `tipr_estado`, `tipr_registradopor`, `tipr_fechacambio`) VALUES
(23, 'INGREDIENTES (Gramos)', 0, 'ACTIVO SOLO INVENTARIO', 1, '2021-09-17 22:11:58'),
(35, 'RESERVAS', 9, 'ACTIVO', 1, '2022-11-02 20:01:41'),
(40, 'HAMBURGUESAS', 2, 'ACTIVO', 1, '2022-11-02 21:16:46'),
(41, 'SALCHIPAPAS', 3, 'ACTIVO', 1, '2022-11-02 21:17:17'),
(42, 'PERROS', 4, 'ACTIVO', 1, '2022-11-02 21:17:40'),
(43, 'MAICITOS', 6, 'ACTIVO', 1, '2022-11-02 21:18:05'),
(44, 'PINCHOS', 7, 'ACTIVO', 1, '2022-11-02 21:19:17'),
(45, 'FRAPES', 11, 'ACTIVO', 1, '2022-11-04 23:43:03'),
(46, 'JUGOS NATURALES', 12, 'ACTIVO', 1, '2022-11-04 23:43:14'),
(47, 'BEBIDAS EN BOTELLA', 13, 'ACTIVO', 1, '2022-11-04 23:43:37'),
(48, 'CERVEZAS', 14, 'ACTIVO', 1, '2022-11-04 23:44:04'),
(49, 'COCTELES', 15, 'ACTIVO', 1, '2022-11-04 23:44:25');

--
-- Disparadores `tipoproducto`
--
DELIMITER $$
CREATE TRIGGER `disparador_insertar_tipoproducto` AFTER INSERT ON `tipoproducto` FOR EACH ROW INSERT INTO pinchetas_restaurante._tipoproducto ( 
    tipr_id,
    tipr_descripcion,
    tipr_orden,
    tipr_estado,
    tipr_registradopor,
    tipr_fechacambio,
    operacion 
) 
VALUES ( 
    new.tipr_id,
    new.tipr_descripcion,
    new.tipr_orden,
    new.tipr_estado,
    new.tipr_registradopor,
    NOW(),
    'I' 
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disparador_modificar_tipoproducto` AFTER UPDATE ON `tipoproducto` FOR EACH ROW INSERT INTO pinchetas_restaurante._tipoproducto ( 
    tipr_id,
    tipr_descripcion,
    tipr_orden,
    tipr_estado,
    tipr_registradopor,
    tipr_fechacambio,
    operacion 
) 
VALUES ( 
    new.tipr_id,
    new.tipr_descripcion,
    new.tipr_orden,
    new.tipr_estado,
    new.tipr_registradopor,
    NOW(),
    'U' 
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_dependenciaproducto`
--

CREATE TABLE `_dependenciaproducto` (
  `depr_id` bigint(20) DEFAULT NULL,
  `depr_cantidad` float DEFAULT NULL,
  `prod_idpadre` bigint(20) DEFAULT NULL,
  `prod_idhijo` bigint(20) DEFAULT NULL,
  `depr_registradopor` bigint(20) DEFAULT NULL,
  `depr_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_dependenciaproducto`
--

INSERT INTO `_dependenciaproducto` (`depr_id`, `depr_cantidad`, `prod_idpadre`, `prod_idhijo`, `depr_registradopor`, `depr_fechacambio`, `operacion`) VALUES
(1, NULL, 324, 324, 1, '2022-11-02 22:16:32', 'I'),
(2, NULL, 325, 325, 1, '2022-11-02 22:17:11', 'I'),
(3, NULL, 326, 326, 1, '2022-11-02 22:17:53', 'I'),
(4, NULL, 327, 327, 1, '2022-11-02 22:18:29', 'I'),
(5, NULL, 328, 328, 1, '2022-11-02 22:19:30', 'I'),
(6, NULL, 329, 329, 1, '2022-11-02 22:20:05', 'I'),
(7, NULL, 330, 330, 1, '2022-11-02 22:20:38', 'I'),
(8, NULL, 331, 331, 1, '2022-11-02 22:22:37', 'I'),
(9, NULL, 332, 332, 1, '2022-11-02 22:25:18', 'I'),
(10, NULL, 333, 333, 1, '2022-11-02 22:26:03', 'I'),
(11, NULL, 334, 334, 1, '2022-11-02 22:26:42', 'I'),
(12, NULL, 335, 335, 1, '2022-11-02 22:27:26', 'I'),
(13, NULL, 336, 336, 1, '2022-11-02 22:27:58', 'I'),
(14, NULL, 337, 337, 1, '2022-11-02 22:29:33', 'I'),
(15, NULL, 338, 338, 1, '2022-11-02 22:30:02', 'I'),
(16, NULL, 339, 339, 1, '2022-11-02 22:30:29', 'I'),
(17, NULL, 340, 340, 1, '2022-11-02 22:30:59', 'I'),
(18, NULL, 341, 341, 1, '2022-11-02 22:33:33', 'I'),
(19, NULL, 342, 342, 1, '2022-11-02 22:34:03', 'I'),
(20, NULL, 343, 343, 1, '2022-11-02 22:34:38', 'I'),
(21, NULL, 344, 344, 1, '2022-11-02 22:35:05', 'I'),
(22, NULL, 345, 345, 1, '2022-11-02 22:35:40', 'I'),
(23, NULL, 346, 346, 1, '2022-11-02 22:36:24', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_detallepedido`
--

CREATE TABLE `_detallepedido` (
  `depe_id` bigint(20) DEFAULT NULL,
  `depe_referencia` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `depe_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_id` bigint(20) DEFAULT NULL,
  `prod_id` bigint(20) DEFAULT NULL,
  `prod_costo` int(11) DEFAULT NULL,
  `prod_cantidad` float DEFAULT NULL,
  `prod_precio` int(11) DEFAULT NULL,
  `depe_registradopor` bigint(20) DEFAULT NULL,
  `depe_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_detallepedido`
--

INSERT INTO `_detallepedido` (`depe_id`, `depe_referencia`, `depe_descripcion`, `pedi_id`, `prod_id`, `prod_costo`, `prod_cantidad`, `prod_precio`, `depe_registradopor`, `depe_fechacambio`, `operacion`) VALUES
(1, NULL, NULL, 33030, 329, 11000, 2, 22000, 1, '2022-11-04 21:52:11', 'I'),
(2, NULL, NULL, 33031, 345, 8000, 1, 16000, 1, '2022-11-04 22:28:54', 'I'),
(3, NULL, NULL, 33031, 325, 7000, 1, 14000, 1, '2022-11-04 22:29:06', 'I'),
(4, NULL, 'sin vegetales', 33032, 333, 7500, 1, 15000, 1, '2022-11-04 23:26:59', 'I'),
(5, NULL, 'sin piña', 33032, 329, 11000, 2, 22000, 1, '2022-11-04 23:27:54', 'I'),
(6, NULL, NULL, 33032, 327, 9000, 1, 18000, 1, '2022-11-04 23:30:01', 'I'),
(7, NULL, NULL, 33032, 327, 9000, 1, 18000, 1, '2022-11-04 23:30:38', 'I'),
(8, NULL, NULL, 33032, 339, 4500, 1, 9000, 1, '2022-11-04 23:35:17', 'I'),
(9, NULL, NULL, 33033, 333, 7500, 1, 15000, 1, '2022-11-05 00:12:18', 'I'),
(10, NULL, NULL, 33033, 325, 7000, 1, 14000, 1, '2022-11-05 00:20:48', 'I'),
(11, NULL, NULL, 33034, 329, 11000, 1, 22000, 1, '2022-11-05 12:38:13', 'I'),
(12, NULL, NULL, 33034, 333, 7500, 1, 15000, 1, '2022-11-05 12:38:30', 'I'),
(13, NULL, 'SIN CEBOLLA', 33035, 329, 11000, 3, 22000, 1, '2022-11-05 12:44:49', 'I'),
(14, NULL, 'SIN CEBOLLA', 33035, 339, 4500, 2, 9000, 1, '2022-11-05 12:45:12', 'I'),
(15, NULL, NULL, 33035, 345, 8000, 1, 16000, 1, '2022-11-05 12:47:16', 'I'),
(14, NULL, 'SIN CEBOLLA', 33035, 338, 4000, 2, 8000, 1, '2022-11-05 12:48:25', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_estado`
--

CREATE TABLE `_estado` (
  `esta_id` bigint(20) DEFAULT NULL,
  `esta_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `esta_orden` int(11) DEFAULT NULL,
  `esta_registradopor` bigint(20) DEFAULT NULL,
  `esta_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_estadopedido`
--

CREATE TABLE `_estadopedido` (
  `espe_id` bigint(20) DEFAULT NULL,
  `espe_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `espe_orden` int(11) DEFAULT NULL,
  `espe_estado` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `espe_editablepedido` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `espe_registradopor` bigint(20) DEFAULT NULL,
  `espe_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_factura`
--

CREATE TABLE `_factura` (
  `fact_id` bigint(20) DEFAULT NULL,
  `fact_fecha` datetime DEFAULT NULL,
  `fact_total` int(11) DEFAULT NULL,
  `pege_idmesero` bigint(20) DEFAULT NULL,
  `mesa_id` bigint(20) DEFAULT NULL,
  `pedi_id` bigint(20) DEFAULT NULL,
  `fact_registradopor` bigint(20) DEFAULT NULL,
  `fact_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_gasto`
--

CREATE TABLE `_gasto` (
  `gast_id` bigint(20) DEFAULT NULL,
  `gast_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `gast_valor` int(11) DEFAULT NULL,
  `gast_fecha` datetime DEFAULT NULL,
  `pege_idregistrador` bigint(20) DEFAULT NULL,
  `gast_registradopor` bigint(20) DEFAULT NULL,
  `gast_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_gasto`
--

INSERT INTO `_gasto` (`gast_id`, `gast_descripcion`, `gast_valor`, `gast_fecha`, `pege_idregistrador`, `gast_registradopor`, `gast_fechacambio`, `operacion`) VALUES
(1, 'GLOBOS DECORACIÓN', 10000, '2022-11-05 00:00:00', 1, 1, '2022-11-05 13:02:58', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_mesa`
--

CREATE TABLE `_mesa` (
  `mesa_id` bigint(20) DEFAULT NULL,
  `mesa_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `mesa_orden` int(11) DEFAULT NULL,
  `mesa_estado` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `mesa_registradopor` bigint(20) DEFAULT NULL,
  `mesa_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_mesa`
--

INSERT INTO `_mesa` (`mesa_id`, `mesa_descripcion`, `mesa_orden`, `mesa_estado`, `mesa_registradopor`, `mesa_fechacambio`, `operacion`) VALUES
(17, 'DOMICILIO 1', 32, 'ACTIVO', 1, '2022-11-02 19:49:04', 'U'),
(18, 'DOMICILIO 2', 33, 'ACTIVO', 1, '2022-11-02 19:49:08', 'U'),
(36, 'DOMICILIO 4', 33, 'ACTIVO', 1, '2022-11-02 19:49:28', 'U'),
(19, 'DOMICILIO 3', 32, 'ACTIVO', 1, '2022-11-02 19:49:32', 'U'),
(18, 'DOMICILIO 2', 31, 'ACTIVO', 1, '2022-11-02 19:49:36', 'U'),
(17, 'DOMICILIO 1', 30, 'ACTIVO', 1, '2022-11-02 19:49:40', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_pedido`
--

CREATE TABLE `_pedido` (
  `pedi_id` bigint(20) DEFAULT NULL,
  `pedi_fecha` datetime DEFAULT NULL,
  `pege_idmesero` bigint(20) DEFAULT NULL,
  `mesa_id` bigint(20) DEFAULT NULL,
  `espe_id` bigint(20) DEFAULT NULL,
  `pedi_registradopor` bigint(20) DEFAULT NULL,
  `pedi_fechacambio` datetime DEFAULT NULL,
  `pedi_tipopago` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_bandera` tinyint(1) DEFAULT NULL,
  `pedi_nombrecliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_direccioncliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_telefonocliente` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `pedi_numerofactura` bigint(255) DEFAULT NULL,
  `pedi_prefijofactura` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_pedido`
--

INSERT INTO `_pedido` (`pedi_id`, `pedi_fecha`, `pege_idmesero`, `mesa_id`, `espe_id`, `pedi_registradopor`, `pedi_fechacambio`, `pedi_tipopago`, `pedi_bandera`, `pedi_nombrecliente`, `pedi_direccioncliente`, `pedi_telefonocliente`, `pedi_numerofactura`, `pedi_prefijofactura`, `operacion`) VALUES
(33029, '2022-11-02 22:22:55', 1, 1, 1, 1, '2022-11-02 22:22:55', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33029, '2022-11-02 22:22:55', 1, 1, 6, 1, '2022-11-04 21:51:24', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 1, 1, '2022-11-04 21:51:55', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33030, '2022-11-04 21:51:55', 1, 1, 2, 1, '2022-11-04 21:52:14', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 21:52:20', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 21:52:35', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 21:53:15', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 21:54:45', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:00:22', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:00:33', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:01:53', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:08:32', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:11:49', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 5, 1, '2022-11-04 22:14:29', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 7, 1, '2022-11-04 22:28:07', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33030, '2022-11-04 21:51:55', 1, 1, 7, 1, '2022-11-04 22:28:07', 'EFECTIVO', 1, '', '', '', 1, 'RI', 'U'),
(33031, '2022-11-04 22:28:18', 1, 1, 1, 1, '2022-11-04 22:28:18', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33031, '2022-11-04 22:28:18', 1, 1, 2, 1, '2022-11-04 22:29:18', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33031, '2022-11-04 22:28:18', 1, 1, 2, 1, '2022-11-04 22:29:35', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33031, '2022-11-04 22:28:18', 1, 1, 5, 1, '2022-11-04 22:36:38', 'EFECTIVO', 1, '', '', '', 2, 'RI', 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 1, 1, '2022-11-04 23:05:39', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33032, '2022-11-04 23:05:39', 1, 2, 2, 1, '2022-11-04 23:27:02', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 2, 1, '2022-11-04 23:27:27', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 5, 1, '2022-11-04 23:36:35', 'EFECTIVO', 1, '', '', '', 3, 'RI', 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 5, 1, '2022-11-04 23:36:51', 'EFECTIVO', 1, '', '', '', 3, 'RI', 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 7, 1, '2022-11-04 23:37:26', 'EFECTIVO', 1, '', '', '', 3, 'RI', 'U'),
(33032, '2022-11-04 23:05:39', 1, 2, 7, 1, '2022-11-04 23:37:26', 'EFECTIVO', 1, '', '', '', 3, 'RI', 'U'),
(33031, '2022-11-04 22:28:18', 1, 1, 7, 1, '2022-11-04 23:52:48', 'EFECTIVO', 1, '', '', '', 2, 'RI', 'U'),
(33031, '2022-11-04 22:28:18', 1, 1, 7, 1, '2022-11-04 23:52:48', 'EFECTIVO', 1, '', '', '', 2, 'RI', 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 1, 1, '2022-11-04 23:52:52', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33033, '2022-11-04 23:52:52', 1, 1, 2, 1, '2022-11-05 00:12:23', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33034, '2022-11-05 00:20:17', 1, 2, 1, 1, '2022-11-05 00:20:17', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33033, '2022-11-04 23:52:52', 1, 1, 2, 1, '2022-11-05 00:20:27', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 00:22:15', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 12:18:41', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 12:18:53', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33034, '2022-11-05 00:20:17', 1, 2, 2, 1, '2022-11-05 12:38:15', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33035, '2022-11-05 12:44:26', 1, 3, 1, 1, '2022-11-05 12:44:26', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33035, '2022-11-05 12:44:26', 1, 3, 2, 1, '2022-11-05 12:45:23', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33035, '2022-11-05 12:44:26', 1, 3, 2, 1, '2022-11-05 12:48:51', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33035, '2022-11-05 12:44:26', 1, 5, 2, 1, '2022-11-05 12:49:35', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33035, '2022-11-05 12:44:26', 1, 5, 2, 1, '2022-11-05 12:52:00', 'EFECTIVO', 1, 'VICTOR', 'CALLE', '3043427319', 4, 'RI', 'U'),
(33035, '2022-11-05 12:44:26', 1, 5, 5, 1, '2022-11-05 12:52:05', 'EFECTIVO', 1, 'VICTOR', 'CALLE', '3043427319', 4, 'RI', 'U'),
(33035, '2022-11-05 12:44:26', 1, 5, 7, 1, '2022-11-05 12:54:37', 'EFECTIVO', 1, 'VICTOR', 'CALLE', '3043427319', 4, 'RI', 'U'),
(33035, '2022-11-05 12:44:26', 1, 5, 7, 1, '2022-11-05 12:54:37', 'EFECTIVO', 1, 'VICTOR', 'CALLE', '3043427319', 4, 'RI', 'U'),
(33036, '2022-11-05 12:57:05', 1, 3, 1, 1, '2022-11-05 12:57:05', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33037, '2022-11-05 13:00:03', 1, 4, 1, 1, '2022-11-05 13:00:03', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33038, '2022-11-05 13:00:43', 1, 5, 1, 1, '2022-11-05 13:00:43', 'EFECTIVO', 0, NULL, NULL, NULL, NULL, NULL, 'I'),
(33038, '2022-11-05 13:00:43', 1, 5, 6, 1, '2022-11-05 13:00:52', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 13:20:27', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 13:20:34', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U'),
(33033, '2022-11-04 23:52:52', 1, 1, 5, 1, '2022-11-05 13:20:44', 'EFECTIVO', 0, '', '', '', NULL, NULL, 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_producto`
--

CREATE TABLE `_producto` (
  `prod_id` bigint(20) DEFAULT NULL,
  `prod_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `prod_orden` int(11) DEFAULT NULL,
  `prod_costo` int(11) DEFAULT NULL,
  `prod_precio` int(11) DEFAULT NULL,
  `prod_cantidad` float DEFAULT NULL,
  `prod_estado` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipr_id` bigint(20) DEFAULT NULL,
  `prod_registradopor` bigint(20) DEFAULT NULL,
  `prod_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_producto`
--

INSERT INTO `_producto` (`prod_id`, `prod_descripcion`, `prod_orden`, `prod_costo`, `prod_precio`, `prod_cantidad`, `prod_estado`, `tipr_id`, `prod_registradopor`, `prod_fechacambio`, `operacion`) VALUES
(324, 'HAMBURGUESA CLASICA', 1, 7000, 14000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:16:32', 'I'),
(325, 'HAMBURGUESA CHICKEN CLASSIC', 2, 7000, 14000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:17:11', 'I'),
(326, 'HAMBURGUESA CHICKEN CRISPY', 3, 7000, 14000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:17:53', 'I'),
(327, 'HAMBURGUESA CAMPESINA', 4, 9000, 18000, 4, 'ACTIVO', 40, 1, '2022-11-02 22:18:29', 'I'),
(327, 'HAMBURGUESA CAMPESINA', 4, 9000, 18000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:18:42', 'U'),
(328, 'HAMBURGUESA RANCHERA', 5, 9000, 18000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:19:30', 'I'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:20:05', 'I'),
(330, 'HAMBURGUESA ORIGEN', 7, 11000, 22000, 1000, 'ACTIVO', 40, 1, '2022-11-02 22:20:38', 'I'),
(331, 'SALCHIPAPA CLASICA', 1, 6000, 12000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:22:37', 'I'),
(332, 'SALCHIPAPA CLASICA RANCHERA', 2, 7500, 15000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:25:18', 'I'),
(333, 'SALCHIPAPA CHICKEN', 3, 7500, 15000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:26:03', 'I'),
(334, 'SALCHIPAPA VAQUERA', 4, 9000, 18000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:26:42', 'I'),
(335, 'SALCHIPAPA SAL-CHICHA-RON', 5, 11000, 22000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:27:26', 'I'),
(336, 'SALCHIPAPA ORIGEN', 6, 12000, 24000, 1000, 'ACTIVO', 41, 1, '2022-11-02 22:27:58', 'I'),
(337, 'PERRO SENCILLO', 1, 3000, 6000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:29:33', 'I'),
(338, 'PERRO AMERICANO', 1, 4000, 8000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:30:02', 'I'),
(339, 'PERRO ALEMAN', 3, 4500, 9000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:30:29', 'I'),
(340, 'PERRO CON POLLO', 4, 5000, 10000, 1000, 'ACTIVO', 42, 1, '2022-11-02 22:30:59', 'I'),
(341, 'MAICITO DE POLLO', 1, 8000, 16000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:33:33', 'I'),
(342, 'MAICITO DE CARNE', 2, 9000, 18000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:34:03', 'I'),
(343, 'MAICITO MIXTO', 3, 9000, 18000, 1000, 'ACTIVO', 43, 1, '2022-11-02 22:34:38', 'I'),
(344, 'PINCHO DE POLLO', 1, 7000, 14000, 1000, 'ACTIVO', 44, 1, '2022-11-02 22:35:05', 'I'),
(345, 'PINCHO DE CARNE', 2, 8000, 16000, 1000, 'ACTIVO', 44, 1, '2022-11-02 22:35:40', 'I'),
(346, 'PINCHO MIXTO', 3, 8000, 16000, 1000, 'ACTIVO', 44, 1, '2022-11-02 22:36:24', 'I'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 998, 'ACTIVO', 40, 1, '2022-11-04 22:28:07', 'U'),
(333, 'SALCHIPAPA CHICKEN', 3, 7500, 15000, 999, 'ACTIVO', 41, 1, '2022-11-04 23:37:26', 'U'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 996, 'ACTIVO', 40, 1, '2022-11-04 23:37:26', 'U'),
(327, 'HAMBURGUESA CAMPESINA', 4, 9000, 18000, 999, 'ACTIVO', 40, 1, '2022-11-04 23:37:26', 'U'),
(327, 'HAMBURGUESA CAMPESINA', 4, 9000, 18000, 998, 'ACTIVO', 40, 1, '2022-11-04 23:37:26', 'U'),
(339, 'PERRO ALEMAN', 3, 4500, 9000, 999, 'ACTIVO', 42, 1, '2022-11-04 23:37:26', 'U'),
(345, 'PINCHO DE CARNE', 2, 8000, 16000, 999, 'ACTIVO', 44, 1, '2022-11-04 23:52:48', 'U'),
(325, 'HAMBURGUESA CHICKEN CLASSIC', 2, 7000, 14000, 999, 'ACTIVO', 40, 1, '2022-11-04 23:52:48', 'U'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 993, 'ACTIVO', 40, 1, '2022-11-05 12:54:37', 'U'),
(338, 'PERRO AMERICANO', 1, 4000, 8000, 998, 'ACTIVO', 42, 1, '2022-11-05 12:54:37', 'U'),
(345, 'PINCHO DE CARNE', 2, 8000, 16000, 998, 'ACTIVO', 44, 1, '2022-11-05 12:54:37', 'U'),
(329, 'HAMBURGUESA 3 CERDITOS', 6, 11000, 22000, 1000, 'ACTIVO', 40, 1, '2022-11-05 13:11:18', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_tipoproducto`
--

CREATE TABLE `_tipoproducto` (
  `tipr_id` bigint(20) DEFAULT NULL,
  `tipr_descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipr_orden` int(11) DEFAULT NULL,
  `tipr_estado` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipr_registradopor` bigint(20) DEFAULT NULL,
  `tipr_fechacambio` datetime DEFAULT NULL,
  `operacion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `_tipoproducto`
--

INSERT INTO `_tipoproducto` (`tipr_id`, `tipr_descripcion`, `tipr_orden`, `tipr_estado`, `tipr_registradopor`, `tipr_fechacambio`, `operacion`) VALUES
(23, 'INGREDIENTES (Gramos)', 0, 'ACTIVO SOLO INVENTARIO', 1, '2022-11-02 19:53:29', 'U'),
(26, 'ADICIONALES DE DINERO', 8, 'ACTIVO', 1, '2022-11-02 20:01:19', 'U'),
(28, 'GENERAL', 7, 'ACTIVO', 1, '2022-11-02 20:01:32', 'U'),
(35, 'RESERVAS', 9, 'ACTIVO', 1, '2022-11-02 20:01:41', 'U'),
(27, 'ADICIONALES DE PROTEÍNA  ', 0, 'ACTIVO', 1, '2022-11-02 20:01:54', 'U'),
(14, 'BEBIDAS', 1, 'ACTIVO', 1, '2022-11-02 20:02:05', 'U'),
(40, 'HAMBURGUESAS', 2, 'ACTIVO', 1, '2022-11-02 21:16:46', 'I'),
(41, 'SALCHIPAPAS', 2, 'ACTIVO', 1, '2022-11-02 21:17:08', 'I'),
(41, 'SALCHIPAPAS', 3, 'ACTIVO', 1, '2022-11-02 21:17:17', 'U'),
(42, 'PERROS', 4, 'ACTIVO', 1, '2022-11-02 21:17:40', 'I'),
(43, 'MAICITOS', 6, 'ACTIVO', 1, '2022-11-02 21:18:05', 'I'),
(28, 'GENERAL', 10, 'ACTIVO', 1, '2022-11-02 21:19:02', 'U'),
(44, 'PINCHOS', 7, 'ACTIVO', 1, '2022-11-02 21:19:17', 'I'),
(45, 'FRAPES', 11, 'ACTIVO', 1, '2022-11-04 23:43:03', 'I'),
(46, 'JUGOS NATURALES', 12, 'ACTIVO', 1, '2022-11-04 23:43:14', 'I'),
(47, 'BEBIDAS EN BOTELLA', 13, 'ACTIVO', 1, '2022-11-04 23:43:37', 'I'),
(14, 'BEBIDAS', 1, 'ACTIVO', 1, '2022-11-04 23:43:43', 'D'),
(48, 'CERVEZAS', 14, 'ACTIVO', 1, '2022-11-04 23:44:04', 'I'),
(49, 'COCTELES', 15, 'ACTIVO', 1, '2022-11-04 23:44:25', 'I');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dependenciaproducto`
--
ALTER TABLE `dependenciaproducto`
  ADD PRIMARY KEY (`depr_id`),
  ADD KEY `foranea_dependenciaproducto_con_producto_padre` (`prod_idpadre`),
  ADD KEY `foranea_dependenciaproducto_con_producto_hijo` (`prod_idhijo`);

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD PRIMARY KEY (`depe_id`),
  ADD KEY `foranea_detallepedido_con_pedido` (`pedi_id`),
  ADD KEY `foranea_detallepedido_con_producto` (`prod_id`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`esta_id`);

--
-- Indices de la tabla `estadopedido`
--
ALTER TABLE `estadopedido`
  ADD PRIMARY KEY (`espe_id`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`fact_id`),
  ADD KEY `foranea_factura_con_mesa` (`mesa_id`),
  ADD KEY `foranea_factura_con_pedido` (`pedi_id`),
  ADD KEY `foranea_factura_con_personageneral_mesero` (`pege_idmesero`);

--
-- Indices de la tabla `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`gast_id`),
  ADD KEY `foranea_gasto_con_personageneral` (`pege_idregistrador`);

--
-- Indices de la tabla `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`mesa_id`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`pedi_id`),
  ADD KEY `foranea_pedido_con_mesa` (`mesa_id`),
  ADD KEY `foranea_pedido_con_estadopedido` (`espe_id`),
  ADD KEY `foranea_pedido_con_personageneral_mesero` (`pege_idmesero`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prod_id`),
  ADD KEY `foranea_with_tipo_producto` (`tipr_id`);

--
-- Indices de la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  ADD PRIMARY KEY (`tipr_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dependenciaproducto`
--
ALTER TABLE `dependenciaproducto`
  MODIFY `depr_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  MODIFY `depe_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `esta_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estadopedido`
--
ALTER TABLE `estadopedido`
  MODIFY `espe_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `fact_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto`
--
ALTER TABLE `gasto`
  MODIFY `gast_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `mesa_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `pedi_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33039;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `prod_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;

--
-- AUTO_INCREMENT de la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  MODIFY `tipr_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dependenciaproducto`
--
ALTER TABLE `dependenciaproducto`
  ADD CONSTRAINT `foranea_dependenciaproducto_con_producto_hijo` FOREIGN KEY (`prod_idhijo`) REFERENCES `producto` (`prod_id`),
  ADD CONSTRAINT `foranea_dependenciaproducto_con_producto_padre` FOREIGN KEY (`prod_idpadre`) REFERENCES `producto` (`prod_id`);

--
-- Filtros para la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD CONSTRAINT `foranea_detallepedido_con_pedido` FOREIGN KEY (`pedi_id`) REFERENCES `pedido` (`pedi_id`),
  ADD CONSTRAINT `foranea_detallepedido_con_producto` FOREIGN KEY (`prod_id`) REFERENCES `producto` (`prod_id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `foranea_factura_con_mesa` FOREIGN KEY (`mesa_id`) REFERENCES `mesa` (`mesa_id`),
  ADD CONSTRAINT `foranea_factura_con_pedido` FOREIGN KEY (`pedi_id`) REFERENCES `pedido` (`pedi_id`),
  ADD CONSTRAINT `foranea_factura_con_personageneral_mesero` FOREIGN KEY (`pege_idmesero`) REFERENCES `pinchetas_general`.`personageneral` (`pege_id`);

--
-- Filtros para la tabla `gasto`
--
ALTER TABLE `gasto`
  ADD CONSTRAINT `foranea_gasto_con_personageneral` FOREIGN KEY (`pege_idregistrador`) REFERENCES `pinchetas_general`.`personageneral` (`pege_id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `foranea_with_tipo_producto` FOREIGN KEY (`tipr_id`) REFERENCES `tipoproducto` (`tipr_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
