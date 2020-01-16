-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-12-2019 a las 08:55:22
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `erronka4grupo2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spFindUserByUsername` (IN `pUser` VARCHAR(256))  NO SQL
BEGIN
SELECT usuario.*  FROM usuario WHERE usuario.nombreUsuario=pUser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_del_equipo` (IN `vIdEquipo` INT)  NO SQL
SELECT equipo_categoria.idCategoria, categoria.nombre
FROM equipo_categoria
INNER JOIN categoria ON equipo_categoria.idCategoria=categoria.idCategoria
WHERE equipo_categoria.idEquipo = vIdEquipo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categoria_load` ()  NO SQL
SELECT *
FROM categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_equipo` (IN `_idEquipo` INT)  NO SQL
DELETE FROM `equipo` WHERE equipo.idEquipo = _idEquipo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_jugador` (IN `_idUsuario` INT)  NO SQL
DELETE FROM `jugador` WHERE jugador.idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tecnico` (IN `_idUsuario` INT)  NO SQL
DELETE FROM `tecnico` WHERE tecnico.idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_entrenador_by_idTecnico` (IN `vIdTecnico` INT)  NO SQL
SELECT *
FROM entrenador
WHERE entrenador.idTecnico = vIdTecnico$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_equipo_load` ()  NO SQL
SELECT *
FROM equipo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_admin_by_user_id` (IN `pUserId` VARCHAR(64))  NO SQL
BEGIN
SELECT admin.*  FROM admin WHERE admin.idUsuario=pUserId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_equipo` (IN `vNombre` VARCHAR(50), IN `vIdCategoria` INT)  BEGIN
  INSERT INTO equipo (equipo.nombre ) values ( vNombre );
  INSERT INTO equipo_categoria ( equipo_categoria.idEquipo, equipo_categoria.idCategoria ) values ( EQUIPO_LAST_ID(), vIdCategoria );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_equipo_en_usuario` (IN `vIdEquipo` INT)  NO SQL
INSERT INTO usuario ( usuario.idEquipo )
VALUES ( vIdEquipo )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_idCat_equipo_categoria` (IN `vIdCategoria` INT)  NO SQL
INSERT INTO equipo_categoria(equipo_categoria.idEquipo, equipo_categoria.idCategoria)
VALUES(EQUIPO_LAST_ID(), vIdCategoria)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_jugador` (IN `vNombre` VARCHAR(50))  NO SQL
INSERT INTO jugador ( jugador.idUsuario, jugador.nombre )
VALUES ( USUARIO_LAST_ID(), vNombre )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_nombre_equipo` (IN `vNombre` VARCHAR(50))  NO SQL
INSERT INTO equipo(equipo.nombre)
VALUES(vNombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_opinion` (IN `vEmail` VARCHAR(50), IN `vTexto` VARCHAR(255))  NO SQL
INSERT INTO opiniones (opiniones.email, opiniones.fecha, opiniones.texto)
VALUES (vEmail, CURRENT_DATE, vTexto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_tecnico` (IN `vNombre` VARCHAR(50), IN `vLicencia` VARCHAR(50))  NO SQL
INSERT INTO tecnico ( tecnico.idUsuario, tecnico.nombre, tecnico.licencia )
VALUES ( USUARIO_LAST_ID(), vNombre, vLicencia )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jugador_by_idUsuario` (IN `vIdUsuario` INT)  NO SQL
SELECT *
FROM jugador
WHERE jugador.idUsuario = vIdUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jugador_load` ()  NO SQL
SELECT *
FROM jugador$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_load_opiniones` ()  NO SQL
SELECT *
FROM opiniones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nombre_categoria` (IN `vIdCategoria` INT)  NO SQL
SELECT categoria.nombre
FROM categoria
WHERE categoria.idCategoria = vIdCategoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tecnico_by_idUsuario` (IN `vIdUsuario` INT)  NO SQL
SELECT *
FROM tecnico
WHERE tecnico.idUsuario = vIdUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tecnico_load` ()  NO SQL
SELECT *
FROM tecnico$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_by_equipo` (IN `vIdEquipo` INT)  NO SQL
SELECT *
FROM usuario
WHERE usuario.idEquipo = vIdEquipo$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `EQUIPO_LAST_ID` () RETURNS INT(11) NO SQL
RETURN (SELECT equipo.idEquipo FROM equipo ORDER BY equipo.idEquipo DESC LIMIT 1)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `USUARIO_LAST_ID` () RETURNS INT(11) NO SQL
RETURN (SELECT usuario.idUsuario FROM usuario ORDER BY usuario.idUsuario DESC LIMIT 1)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `idAdmin` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`idAdmin`, `idUsuario`, `nombre`) VALUES
(1, 5, 'admin'),
(2, 2, 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nombre`) VALUES
(1, 'Alevin'),
(2, 'Infantil'),
(3, 'Senior');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ddmm`
--

CREATE TABLE `ddmm` (
  `idDDMM` int(11) NOT NULL,
  `idJugador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ddmm`
--

INSERT INTO `ddmm` (`idDDMM`, `idJugador`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `idEquipo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`idEquipo`, `nombre`) VALUES
(1, 'Petanca Pensionista'),
(2, 'New Petanca'),
(3, 'Baby Petanca');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_categoria`
--

CREATE TABLE `equipo_categoria` (
  `idEquipo` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `equipo_categoria`
--

INSERT INTO `equipo_categoria` (`idEquipo`, `idCategoria`) VALUES
(1, 3),
(2, 2),
(3, 1),
(1, 3),
(2, 2),
(3, 1),
(1, 3),
(2, 2),
(3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idJugador` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`idJugador`, `idUsuario`, `nombre`) VALUES
(1, 1, 'Carlos'),
(2, 2, 'Bogdan'),
(3, 3, 'Xabier');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opiniones`
--

CREATE TABLE `opiniones` (
  `idOpinion` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `texto` mediumtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `opiniones`
--

INSERT INTO `opiniones` (`idOpinion`, `idUsuario`, `email`, `fecha`, `texto`) VALUES
(2, 1, 'isla.carlos.99@gmail.com', '2019-12-18', 'Esto es la primera prueba correcta de insertar opiniones en la base de datos.'),
(3, 2, 'eneko@gmail.com', '2019-12-18', 'Esta es la segunda prueba de insertar opiniones en la base de datos.'),
(4, 3, 'gorka@gmail.com', '2019-12-18', 'esta es la tercera prueba para insertar opiniones en la base de datos.'),
(5, 5, 'isla.carlos.99@gmail.com', '2019-12-18', 'esta es la cuarta prueba de insertar opiniones en la base de datos.'),
(6, 6, 'eneko@gmail.com', '2019-12-18', 'esta es la quinta prueba de insertar opiniones en la base de datos.'),
(7, 7, 'isla.carlos.99@gmail.com', '2019-12-18', 'bsefndijvfkd djqNKEDLZBDK SNDASJCDBCK S<DNANLJ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `tecnico` (
  `idTecnico` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `licencia` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `tecnico` (`idTecnico`, `idUsuario`, `licencia`, `nombre`) VALUES
(1, 6, 'entrenador', 'Jose'),
(2, 7, 'delegado', 'Ramon');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(2562) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nombreUsuario` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idEquipo`, `password`, `email`, `nombreUsuario`, `admin`) VALUES
(1, 1, '123', '', '', 0),
(2, 2, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', 'la-contraseña-es-1234', 'bogdan-apc', 1),
(3, 3, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', 'qwerty', 0),
(5, NULL, '123', '', '', 1),
(6, 1, '123', '', '', 0),
(7, 1, '123', '', '', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`idAdmin`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `ddmm`
--
ALTER TABLE `ddmm`
  ADD PRIMARY KEY (`idDDMM`),
  ADD KEY `idJugador` (`idJugador`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`idEquipo`);

--
-- Indices de la tabla `equipo_categoria`
--
ALTER TABLE `equipo_categoria`
  ADD KEY `idEquipo` (`idEquipo`),
  ADD KEY `idEquipo_2` (`idEquipo`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idJugador`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`idTecnico`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idEquipo` (`idEquipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `idAdmin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ddmm`
--
ALTER TABLE `ddmm`
  MODIFY `idDDMM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `idEquipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `idJugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `idTecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ddmm`
--
ALTER TABLE `ddmm`
  ADD CONSTRAINT `ddmm_ibfk_1` FOREIGN KEY (`idJugador`) REFERENCES `jugador` (`idJugador`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `equipo_categoria`
--
ALTER TABLE `equipo_categoria`
  ADD CONSTRAINT `equipo_categoria_ibfk_1` FOREIGN KEY (`idEquipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `equipo_categoria_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idEquipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
