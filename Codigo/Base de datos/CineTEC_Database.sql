-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 28-05-2018 a las 03:31:16
-- Versión del servidor: 5.7.21
-- Versión de PHP: 5.6.35

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

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `blockUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `blockUser` (IN `pUsername` VARCHAR(100))  NO SQL
    COMMENT 'Procedure that block user'
BEGIN
UPDATE user
SET user.avaliability = false
WHERE user.nickname = pUsername;
END$$

DROP PROCEDURE IF EXISTS `getActorById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getActorById` (IN `pIdMovie` INT(11))  NO SQL
    COMMENT 'Procedure that get all the Actor by Id Movie'
BEGIN
SELECT actor.idActor AS IdActor, actor.name AS Name
FROM actor
INNER JOIN moviehasactor ON moviehasactor.idMovie = pIdMovie
GROUP BY IdActor;
END$$

DROP PROCEDURE IF EXISTS `getAllMovie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllMovie` ()  NO SQL
    COMMENT 'Procedure that returns all the movies'
BEGIN 
SELECT movie.idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.image AS Image, movie.year AS Year
FROM movie;

END$$

DROP PROCEDURE IF EXISTS `getAllUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUser` ()  NO SQL
    COMMENT 'Procedure that get all the users '
BEGIN
SELECT user.idUser, user.avaliability, user.nickname, user.name, user.password, user.mail
FROM user;
END$$

DROP PROCEDURE IF EXISTS `getComment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getComment` (IN `pMovie` VARCHAR(100))  NO SQL
BEGIN
SELECT usercommentmovie.idComment AS IdComment, usercommentmovie.dateComment AS DateComment, usercommentmovie.Comment AS CommentMade, getNameByIdMovie(usercommentmovie.idUser) AS UserWho
FROM usercommentmovie
WHERE usercommentmovie.idMovie = getIdMovie(pMovie);
END$$

DROP PROCEDURE IF EXISTS `getFavoriteMovieByUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFavoriteMovieByUser` (IN `pUsername` VARCHAR(100))  NO SQL
    COMMENT 'Procedure that get all the favorites movies by username'
BEGIN
SELECT movie.idMovie, movie.gender, movie.director, movie.calification, movie.name, movie.image, movie.year
FROM movie
INNER JOIN usermarkmovie ON usermarkmovie.idMovie = movie.idMovie INNER JOIN user ON getIdUser(pUsername) = usermarkmovie.idUser
GROUP BY movie.idMovie;
END$$

DROP PROCEDURE IF EXISTS `getKeywordById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getKeywordById` (IN `pIdMovie` INT(11))  NO SQL
    COMMENT 'Procedure that get all the keywords by id movie'
BEGIN
SELECT keyword.idKeyword, keyword.name
FROM keyword
INNER JOIN moviehaskeyword ON moviehaskeyword.idMovie = pIdMovie;
END$$

DROP PROCEDURE IF EXISTS `getMovieByActor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByActor` (IN `pActor` VARCHAR(100))  NO SQL
BEGIN 
SELECT movie.idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.image AS Image, movie.year AS Year
FROM movie, moviehasactor, actor 
WHERE movie.idMovie = moviehasactor.idMovie AND moviehasactor.idActor = actor.idActor AND actor.name = pActor;
END$$

DROP PROCEDURE IF EXISTS `getMovieByDirector`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByDirector` (IN `pDirector` VARCHAR(100))  NO SQL
BEGIN 
SELECT idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.year AS Year
FROM movie
WHERE pDirector = director;
END$$

DROP PROCEDURE IF EXISTS `getMovieByGender`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByGender` (IN `pGender` VARCHAR(100))  NO SQL
BEGIN 
SELECT idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.year AS Year
FROM movie
WHERE pGender = gender;
END$$

DROP PROCEDURE IF EXISTS `getMovieByKeyword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByKeyword` (IN `pKeyword` VARCHAR(100))  NO SQL
BEGIN 
SELECT movie.idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.image AS Image, movie.year AS Year
FROM movie, moviehaskeyword, keyword 
WHERE movie.idMovie = moviehaskeyword.idMovie AND moviehaskeyword.idKeyword = keyword.idKeyword AND keyword.name = pKeyword;
END$$

DROP PROCEDURE IF EXISTS `getMovieByName`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByName` (IN `pName` VARCHAR(100))  NO SQL
BEGIN 
SELECT movie.idMovie AS IdMovie, movie.gender AS Gender, movie.director AS Director, movie.calification AS Calification, movie.name AS Name, movie.image AS Image, movie.year AS Year
FROM movie
WHERE name = pName;
END$$

DROP PROCEDURE IF EXISTS `getMovieByYear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMovieByYear` (IN `pYear` INT)  NO SQL
BEGIN
SELECT name, director, gender, year, calification
FROM movie
WHERE year = pYear;
END$$

DROP PROCEDURE IF EXISTS `insertActor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertActor` (IN `pName` VARCHAR(100), IN `pMovie` VARCHAR(100))  NO SQL
    COMMENT 'Procedimiento que inserta en la tabla Actor'
BEGIN
INSERT INTO actor(actor.idActor, actor.name)
VALUES (NULL, pName);

INSERT INTO moviehasactor(moviehasactor.idMovieActor, moviehasactor.idMovie, moviehasactor.idActor)
VALUES(NULL, getIdMovie(pMovie), getIdActor(pName));
END$$

DROP PROCEDURE IF EXISTS `insertAdministrator`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAdministrator` (IN `pNickname` VARCHAR(100), IN `pPassword` VARCHAR(100), IN `pMail` VARCHAR(100), IN `pName` VARCHAR(100))  NO SQL
    COMMENT 'Procedimiento que inserta en la tabla administrador'
BEGIN 
INSERT INTO administrator(administrator.idAdministrator, administrator.password, administrator.nickname, administrator.name, administrator.mail)
VALUES(NULL, pPassword, pNickname, pName, pMail);
END$$

DROP PROCEDURE IF EXISTS `insertComment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertComment` (IN `pUsername` VARCHAR(100), IN `pMovie` VARCHAR(100), IN `pComment` TEXT)  NO SQL
    COMMENT 'Procedure that insert a comment in the table userCommentMovie.'
BEGIN
INSERT INTO usercommentmovie(usercommentmovie.idComment, usercommentmovie.dateComment, usercommentmovie.Comment, usercommentmovie.idUser, usercommentmovie.idMovie)
VALUES (NULL, CURRENT_TIMESTAMP, pComment, getIdUser(pUsername), getIdMovie(pMovie));
END$$

DROP PROCEDURE IF EXISTS `insertFavoriteMovie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertFavoriteMovie` (IN `pUsername` VARCHAR(100), IN `pMovie` VARCHAR(100), IN `pFavorite` BOOLEAN)  NO SQL
    COMMENT 'Procedure that insert the favorite movie by the user'
BEGIN
INSERT INTO usermarkmovie(usermarkmovie.idMark, usermarkmovie.favorite, usermarkmovie.idUser, usermarkmovie.idMovie)
VALUES (NULL, pFavorite, getIdUser(pUsername), getIdMovie(pMovie));
END$$

DROP PROCEDURE IF EXISTS `insertKeyword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertKeyword` (IN `pName` VARCHAR(100), IN `pMovie` VARCHAR(100))  NO SQL
    COMMENT 'Procedimiento que inserta en la tabla Keyword'
BEGIN
INSERT INTO keyword(keyword.idKeyword, keyword.name)
VALUES(NULL, pName);

INSERT INTO moviehaskeyword(moviehaskeyword.idMovieKeyword, moviehaskeyword.idMovie, moviehaskeyword.idKeyword)
VALUES(NULL, getIdMovie(pMovie), getIdKeyword(pName));
END$$

DROP PROCEDURE IF EXISTS `insertMovie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMovie` (IN `pGender` VARCHAR(100), IN `pDirector` VARCHAR(100), IN `pName` VARCHAR(100), IN `pReleaseYear` INT, IN `pAdministrator` VARCHAR(100))  NO SQL
    COMMENT 'Procedimiento que inserta en la tabla Movie'
BEGIN
INSERT INTO Movie(movie.idMovie, movie.gender, movie.director, movie.calification, movie.name, movie.image, movie.year)
VALUES(NULL, pGender, pDirector, 0, pName, NULL, pReleaseYear);

INSERT INTO administratorregistermovie(administratorregistermovie.idRegisterMovie, administratorregistermovie.idAdministrator, administratorregistermovie.idMovie)
VALUES(NULL, getIdAdministrator(pAdministrator), getIdMovie(pName));
END$$

DROP PROCEDURE IF EXISTS `insertRate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertRate` (IN `pUsername` VARCHAR(100), IN `pMovie` VARCHAR(100), IN `pCalification` FLOAT)  NO SQL
    COMMENT 'Procedure that insert into table userRateMovie'
BEGIN
INSERT INTO userratemovie(userratemovie.idRate, userratemovie.pCalification, userratemovie.idUser, userratemovie.idMovie)
VALUES(NULL, pCalification, getIdUser(pUsername), getIdMovie(pMovie));
END$$

DROP PROCEDURE IF EXISTS `insertUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser` (IN `pNickname` VARCHAR(100), IN `pPassword` VARCHAR(100), IN `pMail` VARCHAR(100), IN `pName` VARCHAR(100))  NO SQL
    COMMENT 'Procedimiento que inserta en la tabla usuario'
BEGIN 
INSERT INTO user(user.idUser, user.avaliability, user.nickname, user.name, user.password, user.mail)
VALUES(NULL, TRUE, pNickname, pName, pPassword, pMail);
END$$

DROP PROCEDURE IF EXISTS `unblockUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `unblockUser` (IN `pUsername` VARCHAR(100))  NO SQL
    COMMENT 'Procedure that unblock an user'
BEGIN
UPDATE user
SET user.avaliability = true
WHERE user.nickname = pUsername;
END$$

DROP PROCEDURE IF EXISTS `unmarkFavoriteMovie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `unmarkFavoriteMovie` (IN `pMovie` VARCHAR(100), IN `pUsername` VARCHAR(100))  NO SQL
    COMMENT 'Procedure that unmark a favorite movie'
BEGIN
DELETE FROM usermarkmovie 
WHERE usermarkmovie.idUser = getIdUser(pUsername) AND usermarkmovie.idMovie = getIdMovie(pMovie);
END$$

DROP PROCEDURE IF EXISTS `updateMovie`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMovie` (IN `pGender` VARCHAR(100), IN `pDirector` VARCHAR(100), IN `pYear` VARCHAR(100), IN `pNewName` VARCHAR(100), IN `pOldName` VARCHAR(100))  NO SQL
    SQL SECURITY INVOKER
    COMMENT 'Procedure that update the movie'
BEGIN
UPDATE movie
SET movie.gender = pGender, movie.director = pDirector, movie.year = pYear, movie.name = pNewName
WHERE movie.name = pOldName;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `existAdministrator`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `existAdministrator` (`pUsername` VARCHAR(100), `pPassword` VARCHAR(100)) RETURNS TINYINT(1) NO SQL
    COMMENT 'Function that returns a boolean if the user administrator exists'
BEGIN
	DECLARE vExistsUser BOOLEAN DEFAULT false;
    DECLARE vUserId INT DEFAULT 0;
  	SELECT administrator.idAdministrator INTO vUserId FROM administrator
    WHERE administrator.nickname = pUsername AND administrator.password = pPassword;
    IF(vUserId = 0) THEN
    	SET vExistsUser := false;
    ELSE
    	SET vExistsUser := true;
    END IF;
    RETURN vExistsUser;
END$$

DROP FUNCTION IF EXISTS `existsUser`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `existsUser` (`pUsername` VARCHAR(100), `pPassword` VARCHAR(100)) RETURNS TINYINT(1) NO SQL
BEGIN
	DECLARE vExistsUser BOOLEAN DEFAULT false;
    DECLARE vUserId INT DEFAULT 0;
  	SELECT user.idUser INTO vUserId FROM user
    WHERE user.nickname = pUsername AND user.password = pPassword;
    IF(vUserId = 0) THEN
    	SET vExistsUser := false;
    ELSE
    	SET vExistsUser := true;
    END IF;
    RETURN vExistsUser;
END$$

DROP FUNCTION IF EXISTS `getIdActor`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getIdActor` (`pName` VARCHAR(100)) RETURNS INT(11) NO SQL
    COMMENT 'The function return the id of the actor and receive the name.'
BEGIN
	DECLARE vActorId INT(11) DEFAULT 0;
  	SELECT actor.idActor INTO vActorId FROM actor WHERE actor.name = pName;
  	RETURN vActorId;
END$$

DROP FUNCTION IF EXISTS `getIdAdministrator`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getIdAdministrator` (`pUsername` VARCHAR(100)) RETURNS INT(11) NO SQL
    COMMENT 'The function returns the id of the administrator, by username.'
BEGIN
	DECLARE vUserId INT(11) DEFAULT 0;
  	SELECT administrator.idAdministrator INTO vUserId FROM administrator WHERE administrator.nickname = pUsername;
  	RETURN vUserId;
END$$

DROP FUNCTION IF EXISTS `getIdKeyword`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getIdKeyword` (`pName` VARCHAR(100)) RETURNS INT(11) NO SQL
    COMMENT 'The function return the id of the keyword and receive the name.'
BEGIN
	DECLARE vKeywordId INT(11) DEFAULT 0;
  	SELECT keyword.idKeyword INTO vKeywordId FROM keyword WHERE keyword.name = pName;
  	RETURN vKeywordId;
END$$

DROP FUNCTION IF EXISTS `getIdMovie`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getIdMovie` (`pMovieName` VARCHAR(100)) RETURNS INT(11) NO SQL
    COMMENT 'Function that get the movie id by the name.'
BEGIN
	DECLARE vMovieId INT(11) DEFAULT 0;
  	SELECT movie.idMovie INTO vMovieId FROM movie WHERE movie.name = pMovieName;
  	RETURN vMovieId;
END$$

DROP FUNCTION IF EXISTS `getIdUser`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getIdUser` (`pUsername` VARCHAR(100)) RETURNS INT(11) NO SQL
    COMMENT 'Función que retorna el id del usuario por nombre de usuario'
BEGIN
	DECLARE vUserId INT(11) DEFAULT 0;
  	SELECT user.idUser INTO vUserId FROM user WHERE user.nickname = pUsername;
  	RETURN vUserId;
END$$

DROP FUNCTION IF EXISTS `getNameByIdMovie`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getNameByIdMovie` (`pIdMovie` INT(11)) RETURNS VARCHAR(100) CHARSET latin1 NO SQL
BEGIN
	DECLARE vIdMovie VARCHAR(100) DEFAULT "";
  	SELECT movie.name INTO vIdMovie FROM movie WHERE movie.idMovie = pIdMovie;
  	RETURN vIdMovie;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actor`
--

DROP TABLE IF EXISTS `actor`;
CREATE TABLE IF NOT EXISTS `actor` (
  `idActor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Actor',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del actor',
  PRIMARY KEY (`idActor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Tabla Actor';

--
-- Volcado de datos para la tabla `actor`
--

INSERT INTO `actor` (`idActor`, `name`) VALUES
(3, 'Juan Oscar'),
(4, 'Pablo García'),
(5, 'Daniel Gomez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrator`
--

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `idAdministrator` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Administrator',
  `password` varchar(100) NOT NULL COMMENT 'Contraseña del Administrador',
  `nickname` varchar(100) NOT NULL COMMENT 'Username del usuario',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del usuario',
  `mail` varchar(100) NOT NULL COMMENT 'Correo del usuario',
  PRIMARY KEY (`idAdministrator`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Tabla Administrator';

--
-- Volcado de datos para la tabla `administrator`
--

INSERT INTO `administrator` (`idAdministrator`, `password`, `nickname`, `name`, `mail`) VALUES
(1, '145236', 'Osquitar', 'Oscar', 'oscar@gmail.com'),
(2, '123654789', 'Pancho', 'Pancho Gomez del toto', 'panchis@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administratorregistermovie`
--

DROP TABLE IF EXISTS `administratorregistermovie`;
CREATE TABLE IF NOT EXISTS `administratorregistermovie` (
  `idRegisterMovie` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key in the table',
  `idAdministrator` int(11) NOT NULL COMMENT 'Llave foránea de administrator',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de movie',
  PRIMARY KEY (`idRegisterMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Tabla Administrador registra película';

--
-- Volcado de datos para la tabla `administratorregistermovie`
--

INSERT INTO `administratorregistermovie` (`idRegisterMovie`, `idAdministrator`, `idMovie`) VALUES
(1, 2, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `keyword`
--

DROP TABLE IF EXISTS `keyword`;
CREATE TABLE IF NOT EXISTS `keyword` (
  `idKeyword` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla keyword',
  `name` varchar(100) NOT NULL COMMENT 'Nombre del keyword',
  PRIMARY KEY (`idKeyword`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `keyword`
--

INSERT INTO `keyword` (`idKeyword`, `name`) VALUES
(1, 'Miedo'),
(2, 'Acción');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movie`
--

DROP TABLE IF EXISTS `movie`;
CREATE TABLE IF NOT EXISTS `movie` (
  `idMovie` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla Movie',
  `gender` varchar(100) NOT NULL COMMENT 'Genero de la película',
  `director` varchar(100) NOT NULL COMMENT 'Director de la película',
  `calification` float NOT NULL COMMENT 'Calificación de la película',
  `name` varchar(100) NOT NULL COMMENT 'Nombre de la película',
  `image` varchar(100) DEFAULT NULL COMMENT 'Imagen de la película',
  `year` int(11) NOT NULL COMMENT 'Año de la película',
  PRIMARY KEY (`idMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Tabla Movie';

--
-- Volcado de datos para la tabla `movie`
--

INSERT INTO `movie` (`idMovie`, `gender`, `director`, `calification`, `name`, `image`, `year`) VALUES
(1, 'Novela', 'Juan Pancho Gomez', 0, 'La búsqueda de Nemo', NULL, 2014),
(5, 'Miedo', 'Juanes', 0, 'qué pasó?', NULL, 2010);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moviehasactor`
--

DROP TABLE IF EXISTS `moviehasactor`;
CREATE TABLE IF NOT EXISTS `moviehasactor` (
  `idMovieActor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de Movie Actor',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de película',
  `idActor` int(11) NOT NULL COMMENT 'Llave foránea de Actor',
  PRIMARY KEY (`idMovieActor`),
  UNIQUE KEY `idMovieActor` (`idMovieActor`),
  KEY `idActor` (`idActor`),
  KEY `idMovie` (`idMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `moviehasactor`
--

INSERT INTO `moviehasactor` (`idMovieActor`, `idMovie`, `idActor`) VALUES
(2, 1, 3),
(3, 1, 4),
(4, 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moviehaskeyword`
--

DROP TABLE IF EXISTS `moviehaskeyword`;
CREATE TABLE IF NOT EXISTS `moviehaskeyword` (
  `idMovieKeyword` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de MovieKeyword',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de Movie',
  `idKeyword` int(11) NOT NULL COMMENT 'Llave foránea de Keyword',
  PRIMARY KEY (`idMovieKeyword`),
  KEY `idKeyword` (`idKeyword`),
  KEY `idMovie` (`idMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `moviehaskeyword`
--

INSERT INTO `moviehaskeyword` (`idMovieKeyword`, `idMovie`, `idKeyword`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `avaliability` tinyint(1) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `mail` varchar(100) NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Tabla Person';

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`idUser`, `avaliability`, `nickname`, `name`, `password`, `mail`) VALUES
(1, 1, 'dnnxl', 'Daniel', '123456', 'dnnxl15@gmail.com'),
(2, 1, 'dnnis', 'Dennis', '789654', 'denn@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usercommentmovie`
--

DROP TABLE IF EXISTS `usercommentmovie`;
CREATE TABLE IF NOT EXISTS `usercommentmovie` (
  `idComment` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de comentario',
  `dateComment` date NOT NULL COMMENT 'Dia que se realizó el comentario',
  `Comment` varchar(100) NOT NULL COMMENT 'Comentario realizado',
  `idUser` int(11) NOT NULL COMMENT 'Llave foránea del usuario',
  `idMovie` int(11) NOT NULL COMMENT 'LLave foránea de la tabla movie',
  PRIMARY KEY (`idComment`),
  KEY `idMovie` (`idMovie`),
  KEY `idUser` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Comentarios de usuarios en las películas';

--
-- Volcado de datos para la tabla `usercommentmovie`
--

INSERT INTO `usercommentmovie` (`idComment`, `dateComment`, `Comment`, `idUser`, `idMovie`) VALUES
(1, '2018-04-29', 'Muy bonita', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usermarkmovie`
--

DROP TABLE IF EXISTS `usermarkmovie`;
CREATE TABLE IF NOT EXISTS `usermarkmovie` (
  `idMark` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de la tabla UserMarkMovie',
  `favorite` tinyint(1) NOT NULL COMMENT 'Película marcada como favorito de cada usuario',
  `idUser` int(11) NOT NULL COMMENT 'Llave foránea de usuario',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de película',
  PRIMARY KEY (`idMark`),
  KEY `idMovie` (`idMovie`),
  KEY `idUser` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='Tabla UserMarkMovie';

--
-- Volcado de datos para la tabla `usermarkmovie`
--

INSERT INTO `usermarkmovie` (`idMark`, `favorite`, `idUser`, `idMovie`) VALUES
(4, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `userratemovie`
--

DROP TABLE IF EXISTS `userratemovie`;
CREATE TABLE IF NOT EXISTS `userratemovie` (
  `idRate` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria de userRateMovie',
  `pCalification` float NOT NULL COMMENT 'Puntuación de la película',
  `idUser` int(11) NOT NULL COMMENT 'Llave foránea de user',
  `idMovie` int(11) NOT NULL COMMENT 'Llave foránea de Movie',
  PRIMARY KEY (`idRate`),
  KEY `idUser` (`idUser`),
  KEY `idMovie` (`idMovie`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `userratemovie`
--

INSERT INTO `userratemovie` (`idRate`, `pCalification`, `idUser`, `idMovie`) VALUES
(1, 3.5, 1, 1);

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

--
-- Filtros para la tabla `userratemovie`
--
ALTER TABLE `userratemovie`
  ADD CONSTRAINT `userratemovie_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  ADD CONSTRAINT `userratemovie_ibfk_2` FOREIGN KEY (`idMovie`) REFERENCES `movie` (`idMovie`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
