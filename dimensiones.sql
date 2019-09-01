DROP TABLE IF EXISTS `dimension_fechas`;
CREATE TABLE `dimension_fechas` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`fecha` TIMESTAMP NOT NULL DEFAULT now(),
    `dia` varchar(255) NOT NULL,
    `mes` varchar(255) NOT NULL,
	`año` varchar(255) NOT NULL,
	`segmento` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `dimension_sucursales`;
CREATE TABLE `dimension_sucursales` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `dimension_perros`;
CREATE TABLE `dimension_perros` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `dimension_bebidas`;
CREATE TABLE `dimension_bebidas` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `dimension_clientes`;
CREATE TABLE `dimension_clientes` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`nombre` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);
