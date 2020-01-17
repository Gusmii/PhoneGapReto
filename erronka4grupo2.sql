-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-01-2020 a las 13:41:01
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.1.32

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_opinion` (IN `vIdUsuario` INT, IN `vEmail` VARCHAR(50), IN `vTexto` VARCHAR(255))  NO SQL
INSERT INTO opiniones (opiniones.idUsuario, opiniones.email, opiniones.fecha, opiniones.texto)
VALUES (vIdUsuario, vEmail, CURRENT_DATE, vTexto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_tecnico` (IN `vNombre` VARCHAR(50), IN `vLicencia` VARCHAR(50))  NO SQL
INSERT INTO tecnico ( tecnico.idUsuario, tecnico.nombre, tecnico.licencia )
VALUES ( USUARIO_LAST_ID(), vNombre, vLicencia )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jugador_by_idUsuario` (IN `vIdUsuario` INT)  NO SQL
SELECT *
FROM jugador
WHERE jugador.idUsuario = vIdUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jugador_con_mas_votos` ()  NO SQL
SELECT jugador.fotoPerfil AS 'fotoPerfil', categoria.nombre AS 'categoria', jugador.nombre AS 'jugador',  MAX(votos_recibidos) AS 'votos' FROM (SELECT votos.idCategoria, votos.idJugadorVotado, COUNT(votos.idJugadorVotado) AS 'votos_recibidos'
FROM votos  
GROUP BY votos.idJugadorVotado) as tb
JOIN jugador ON tb.idJugadorVotado=jugador.idJugador
JOIN usuario ON jugador.idUsuario=usuario.idUsuario
JOIN equipo ON usuario.idEquipo=equipo.idEquipo
JOIN equipo_categoria ON equipo.idEquipo=equipo_categoria.idEquipo
JOIN categoria ON equipo_categoria.idCategoria=categoria.idCategoria
GROUP by tb.idCategoria$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_votos_load` ()  NO SQL
SELECT *
FROM votos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_votos_totales` (IN `vIdJugador` INT)  NO SQL
SELECT categoria.nombre AS 'categoria', COUNT(votos.idJugadorVotado) AS 'votos'
FROM votos
JOIN categoria ON votos.idCategoria = categoria.idCategoria
WHERE votos.idJugadorVotado = vIdJugador$$

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
-- Estructura de tabla para la tabla `fotos_equipos`
--

CREATE TABLE `fotos_equipos` (
  `idFoto` int(11) NOT NULL,
  `IdEquipo` int(11) NOT NULL,
  `fotoEquipo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `privado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idJugador` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fotoPerfil` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'https://image.flaticon.com/icons/png/512/1685/1685087.png'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`idJugador`, `idUsuario`, `nombre`, `fotoPerfil`) VALUES
(1, 1, 'Carlos', 'https://scontent-mad1-1.cdninstagram.com/v/t51.2885-15/e35/73096340_147261636593369_2989453184324637307_n.jpg?_nc_ht=scontent-mad1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=cnfKWF6wEJUAX8ack0o&oh=bb0d5012e6ded33eadb1f7d6914582d2&oe=5EA75E24'),
(2, 2, 'Bogdan', 'https://image.flaticon.com/icons/png/512/1685/1685087.png'),
(3, 3, 'Xabier', 'https://image.flaticon.com/icons/png/512/1685/1685087.png'),
(4, 8, 'Gusmano', 'https://image.flaticon.com/icons/png/512/1685/1685087.png'),
(5, 9, 'Jose', 'https://image.flaticon.com/icons/png/512/1685/1685087.png'),
(6, 10, 'Federico', 'https://image.flaticon.com/icons/png/512/1685/1685087.png'),
(7, 11, 'Julen', 'https://image.flaticon.com/icons/png/512/1685/1685087.png');

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
(4, 3, 'gorka@gmail.com', '2019-12-18', 'Esta es la cuarta prueba de insertar opiniones en la base de datos.'),
(5, 5, 'isla.carlos.99@gmail.com', '2019-12-18', 'esta es la cuarta prueba de insertar opiniones en la base de datos.'),
(6, 6, 'eneko@gmail.com', '2019-12-18', 'esta es la quinta prueba de insertar opiniones en la base de datos.'),
(7, 7, 'isla.carlos.99@gmail.com', '2019-12-18', 'Esta es la sexta prueba de insertar opiniones en la base de datos.'),
(9, 3, 'isla.carlos.99@gmail.com', '2019-12-19', 'Esta es la novena prueba de insertar opiniones en la base de datos.');

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
(2, 7, 'delegado', 'Ramon'),
(3, 12, 'Delegado', 'Manuel');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idEquipo` int(11) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nombreUsuario` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idEquipo`, `password`, `email`, `nombreUsuario`, `admin`) VALUES
(1, 1, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(2, 2, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', 'la-contraseña-es-1234', 'bogdan-apc', 1),
(3, 3, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', 'qwerty', 0),
(5, NULL, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 1),
(6, 1, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(7, 1, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(8, 1, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(9, 1, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(10, 2, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(11, 2, '$2y$10$jNiP5vCy4oYEkNmyBaKD6uszRLncoSRduADoQhBUYJ4LTvIX/IikG', '', '', 0),
(12, 2, '', '', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `votos`
--

CREATE TABLE `votos` (
  `idVoto` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `idJugadorVotado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `votos`
--

INSERT INTO `votos` (`idVoto`, `idUsuario`, `idCategoria`, `idJugadorVotado`) VALUES
(1, 7, 3, 1),
(2, 9, 3, 1),
(3, 3, 3, 1),
(4, 10, 3, 1),
(5, 5, 2, 2),
(6, 7, 2, 2),
(7, 1, 2, 2),
(8, 11, 2, 2),
(9, 6, 1, 3),
(10, 8, 1, 3),
(11, 2, 1, 3),
(12, 8, 3, 4),
(13, 11, 3, 5),
(14, 3, 2, 6),
(15, 10, 2, 7);

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
-- Indices de la tabla `fotos_equipos`
--
ALTER TABLE `fotos_equipos`
  ADD PRIMARY KEY (`idFoto`),
  ADD UNIQUE KEY `IdEquipo` (`IdEquipo`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idJugador`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `opiniones`
--
ALTER TABLE `opiniones`
  ADD PRIMARY KEY (`idOpinion`),
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
-- Indices de la tabla `votos`
--
ALTER TABLE `votos`
  ADD PRIMARY KEY (`idVoto`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idJugadorVotado` (`idJugadorVotado`);

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
  MODIFY `idEquipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `fotos_equipos`
--
ALTER TABLE `fotos_equipos`
  MODIFY `idFoto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `idJugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `opiniones`
--
ALTER TABLE `opiniones`
  MODIFY `idOpinion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `idTecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `votos`
--
ALTER TABLE `votos`
  MODIFY `idVoto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
-- Filtros para la tabla `fotos_equipos`
--
ALTER TABLE `fotos_equipos`
  ADD CONSTRAINT `fotos_equipos_ibfk_1` FOREIGN KEY (`IdEquipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opiniones`
--
ALTER TABLE `opiniones`
  ADD CONSTRAINT `opiniones_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

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

--
-- Filtros para la tabla `votos`
--
ALTER TABLE `votos`
  ADD CONSTRAINT `votos_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `votos_ibfk_2` FOREIGN KEY (`idJugadorVotado`) REFERENCES `jugador` (`idJugador`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
