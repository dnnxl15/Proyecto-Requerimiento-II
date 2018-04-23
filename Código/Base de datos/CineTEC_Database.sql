-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-04-2018 a las 22:36:39
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cinetec`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actor`
--

CREATE TABLE `actor` (
  `idActor` int(11) NOT NULL COMMENT 'Llave primaria de la tabla Actor',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del actor'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla Actor';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrator`
--

CREATE TABLE `administrator` (
  `idAdministrator` int(11) NOT NULL COMMENT 'Llave primaria de la tabla Administrator',
  `password` varchar(100) NOT NULL COMMENT 'Contraseña del Administrador',
  `nickname` varchar(100) NOT NULL COMMENT 'Username del usuario',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del usuario',
  `mail` varchar(100) NOT NULL COMMENT 'Correo del usuario'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla Administrator';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `keyword`
--

CREATE TABLE `keyword` (
  `idKeyword` int(11) NOT NULL COMMENT 'Llave primaria de la tabla keyword',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del keyword'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movie`
--

CREATE TABLE `movie` (
  `idMovie` int(11) NOT NULL COMMENT 'Llave primaria de la tabla Movie',
  `gender` varchar(100) NOT NULL COMMENT 'Genero de la película',
  `director` varchar(100) NOT NULL COMMENT 'Director de la película',
  `calification` float NOT NULL COMMENT 'Calificación de la película',
  `name` varchar(100) NOT NULL COMMENT 'Nombre de la película',
  `image` varchar(100) DEFAULT NULL COMMENT 'Imagen de la película',
  `year` int(11) NOT NULL COMMENT 'Año de la película'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla Movie';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moviehasactor`
--

CREATE TABLE `moviehasactor` (
  `idMovieActor` int(11) NOT NULL COMMENT 'Llave primaria de Movie Actor',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de película',
  `idActor` int(11) NOT NULL COMMENT 'Llave foránea de Actor'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moviehaskeyword`
--

CREATE TABLE `moviehaskeyword` (
  `idMovieKeyword` int(11) NOT NULL COMMENT 'Llave primaria de MovieKeyword',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de Movie',
  `idKeyword` int(11) NOT NULL COMMENT 'Llave foránea de Keyword'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `idUser` int(11) NOT NULL,
  `avaliability` tinyint(1) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `mail` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla Person';

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`idUser`, `avaliability`, `nickname`, `name`, `password`, `mail`) VALUES
(1, 0, 'dnnxl', 'Daniel', '123456', 'dnnxl15@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usercommentmovie`
--

CREATE TABLE `usercommentmovie` (
  `idComment` int(11) NOT NULL COMMENT 'Llave primaria de comentario',
  `dateComment` date NOT NULL COMMENT 'Dia que se realizó el comentario',
  `Comment` varchar(100) NOT NULL COMMENT 'Comentario realizado',
  `idUser` int(11) NOT NULL COMMENT 'Llave foránea del usuario',
  `idMovie` int(11) NOT NULL COMMENT 'LLave foránea de la tabla movie'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Comentarios de usuarios en las películas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usermarkmovie`
--

CREATE TABLE `usermarkmovie` (
  `idMark` int(11) NOT NULL COMMENT 'Llave primaria de la tabla UserMarkMovie',
  `calification` float NOT NULL COMMENT 'Calificación de la película de cada usuario',
  `favorite` tinyint(1) NOT NULL COMMENT 'Película marcada como favorito de cada usuario',
  `idUser` int(11) NOT NULL COMMENT 'Llave foránea de usuario',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de película'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla UserMarkMovie';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`idActor`);

--
-- Indices de la tabla `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`idAdministrator`);

--
-- Indices de la tabla `keyword`
--
ALTER TABLE `keyword`
  ADD PRIMARY KEY (`idKeyword`);

--
-- Indices de la tabla `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`idMovie`);

--
-- Indices de la tabla `moviehasactor`
--
ALTER TABLE `moviehasactor`
  ADD PRIMARY KEY (`idMovieActor`),
  ADD UNIQUE KEY `idMovieActor` (`idMovieActor`),
  ADD KEY `idActor` (`idActor`),
  ADD KEY `idMovie` (`idMovie`);

--
-- Indices de la tabla `moviehaskeyword`
--
ALTER TABLE `moviehaskeyword`
  ADD PRIMARY KEY (`idMovieKeyword`),
  ADD KEY `idKeyword` (`idKeyword`),
  ADD KEY `idMovie` (`idMovie`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`);

--
-- Indices de la tabla `usercommentmovie`
--
ALTER TABLE `usercommentmovie`
  ADD PRIMARY KEY (`idComment`),
  ADD KEY `idMovie` (`idMovie`),
  ADD KEY `idUser` (`idUser`);

--
-- Indices de la tabla `usermarkmovie`
--
ALTER TABLE `usermarkmovie`
  ADD PRIMARY KEY (`idMark`),
  ADD KEY `idMovie` (`idMovie`),
  ADD KEY `idUser` (`idUser`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actor`
--
ALTER TABLE `actor`
  MODIFY `idActor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Actor';

--
-- AUTO_INCREMENT de la tabla `administrator`
--
ALTER TABLE `administrator`
  MODIFY `idAdministrator` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Administrator';

--
-- AUTO_INCREMENT de la tabla `keyword`
--
ALTER TABLE `keyword`
  MODIFY `idKeyword` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla keyword';

--
-- AUTO_INCREMENT de la tabla `movie`
--
ALTER TABLE `movie`
  MODIFY `idMovie` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Movie';

--
-- AUTO_INCREMENT de la tabla `moviehasactor`
--
ALTER TABLE `moviehasactor`
  MODIFY `idMovieActor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de Movie Actor';

--
-- AUTO_INCREMENT de la tabla `moviehaskeyword`
--
ALTER TABLE `moviehaskeyword`
  MODIFY `idMovieKeyword` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de MovieKeyword';

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usercommentmovie`
--
ALTER TABLE `usercommentmovie`
  MODIFY `idComment` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de comentario';

--
-- AUTO_INCREMENT de la tabla `usermarkmovie`
--
ALTER TABLE `usermarkmovie`
  MODIFY `idMark` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla UserMarkMovie';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `moviehasactor`
--
ALTER TABLE `moviehasactor`
  ADD CONSTRAINT `moviehasactor_ibfk_1` FOREIGN KEY (`idActor`) REFERENCES `actor` (`idActor`),
  ADD CONSTRAINT `moviehasactor_ibfk_2` FOREIGN KEY (`idMovie`) REFERENCES `movie` (`idMovie`);

--
-- Filtros para la tabla `moviehaskeyword`
--
ALTER TABLE `moviehaskeyword`
  ADD CONSTRAINT `moviehaskeyword_ibfk_1` FOREIGN KEY (`idKeyword`) REFERENCES `keyword` (`idKeyword`),
  ADD CONSTRAINT `moviehaskeyword_ibfk_2` FOREIGN KEY (`idMovie`) REFERENCES `movie` (`idMovie`);

--
-- Filtros para la tabla `usercommentmovie`
--
ALTER TABLE `usercommentmovie`
  ADD CONSTRAINT `usercommentmovie_ibfk_1` FOREIGN KEY (`idMovie`) REFERENCES `movie` (`idMovie`),
  ADD CONSTRAINT `usercommentmovie_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);

--
-- Filtros para la tabla `usermarkmovie`
--
ALTER TABLE `usermarkmovie`
  ADD CONSTRAINT `usermarkmovie_ibfk_1` FOREIGN KEY (`idMovie`) REFERENCES `movie` (`idMovie`),
  ADD CONSTRAINT `usermarkmovie_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
