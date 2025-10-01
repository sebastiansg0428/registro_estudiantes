-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-10-2025 a las 16:10:47
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
-- Base de datos: `registro_estudiantes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `correo`, `contraseña`) VALUES
(15, 'sebastiansg0428@gmail.com', '$2a$10$D6xT7iU4NgUKlzoy8aRF4e7yRKV/IMCEDXY.WVD.sz/Q2Yga40oxK'),
(18, 'drago2223@hotmail.com', '$2a$10$rL3ORRO/NMIc6N3jK8zKdusN7ZqpLerIFe2FWO4pawZEtGCVn9Y5u'),
(19, 'drago99@hotmail.com', '$2a$10$Q7aR8wkE80OGyCk91XsmoOCe6vh8Ra1wMR.uRZts.qQUJzav6CC4q'),
(21, 'sebastiansg0428@gmail.com', '$2a$10$HOJGAWJax4O8dTpkxZAQTedF0YpEjOjmZ2hjQ7tksSxqVgbeBVvNC'),
(22, 'pin@hotmail.com', '$2a$10$GRouugBZxigREuFb1J.h5uqEDCHltqLDzr5EJvq.UewmpBRg9TQoC'),
(23, 'drago12@hotmail.com', '$2a$10$45oL53EdLcPruLiRA5MSROK5jd/5O6D6epJcEqr4QYvBa2eXW1CNC'),
(24, 'drago55@hotmail.com', '$2a$10$D.BNxoWIrhWXQzP2oYNMLu.Fz8IprBRLyqyVErxwrUPYdREw.M4Ta'),
(25, 'sebas12@gmail.com', '$2a$10$Lm9nOZV9d5Xf22.FpEhUcu3FVrdZarevBPGpMkpQF6Dx1vI3P7FtC'),
(26, 'PINPON@HOTMAIL.COM', '$2a$10$n/ZjsOAfrtpdyDsBRQu3euwZH7ZzYWPVl6dyjZqjOqrOjOXcFTKtK'),
(27, 'SEBAS56@PIN.COM', '$2a$10$8zCjuBsKs5ji1dJLob.EUOJ1XCB9jyw0VbadEJH9aJsTt5E3hUPJi');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
