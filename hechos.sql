DROP TABLE IF EXISTS `hecho_ventas`;
CREATE TABLE `hecho_ventas` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `fecha_id` INT NOT NULL,
    `sucursal_id` INT NOT NULL,
	`cliente_id` INT NOT NULL,
    `bebidas` INT NOT NULL,
    `perros` INT NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `hecho_ventas` ADD CONSTRAINT `hecho_ventas_fecha_fk` FOREIGN KEY (`fecha_id`) REFERENCES `dimension_fechas`(`id`) ON DELETE CASCADE;
ALTER TABLE `hecho_ventas` ADD CONSTRAINT `hecho_ventas_sucursal_fk` FOREIGN KEY (`sucursal_id`) REFERENCES `dimension_sucursales`(`id`) ON DELETE CASCADE;
ALTER TABLE `hecho_ventas` ADD CONSTRAINT `hecho_ventas_cliente_fk` FOREIGN KEY (`cliente_id`) REFERENCES `dimension_clientes`(`id`) ON DELETE CASCADE;

DROP TABLE IF EXISTS `hecho_ventas_pedidos`;
CREATE TABLE `hecho_ventas_pedidos` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `fecha_id` INT NOT NULL,
    `sucursal_id` INT NOT NULL,
	`cliente_id` INT NOT NULL,
    `perro_id` INT NULL DEFAULT NULL,
    `bebidas` INT NOT NULL,
	`precio` DOUBLE NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `hecho_ventas_pedidos` ADD CONSTRAINT `hecho_ventas_pedidos_fecha_fk` FOREIGN KEY (`fecha_id`) REFERENCES `dimension_fechas`(`id`) ON DELETE CASCADE;
ALTER TABLE `hecho_ventas_pedidos` ADD CONSTRAINT `hecho_ventas_pedidos_sucursal_fk` FOREIGN KEY (`sucursal_id`) REFERENCES `dimension_sucursales`(`id`) ON DELETE CASCADE;
ALTER TABLE `hecho_ventas_pedidos` ADD CONSTRAINT `hecho_ventas_pedidos_cliente_fk` FOREIGN KEY (`cliente_id`) REFERENCES `dimension_clientes`(`id`) ON DELETE CASCADE;
ALTER TABLE `hecho_ventas_pedidos` ADD CONSTRAINT `hecho_ventas_pedidos_perro_fk` FOREIGN KEY (`perro_id`) REFERENCES `dimension_perros`(`id`) ON DELETE CASCADE;

DROP TABLE IF EXISTS `hechos_ingredientes_eliminados`;
CREATE TABLE `hechos_ingredientes_eliminados` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `fecha_id` INT NOT NULL,
	`sucursal_id` INT NOT NULL,
	`cliente_id` INT NOT NULL,
    `perro_id` INT NOT NULL,
    `cantidad` INT NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `hechos_ingredientes_eliminados` ADD CONSTRAINT `hechos_ingredientes_eliminados_fecha_fk` FOREIGN KEY (`fecha_id`) REFERENCES `dimension_fechas`(`id`) ON DELETE CASCADE;
ALTER TABLE `hechos_ingredientes_eliminados` ADD CONSTRAINT `hechos_ingredientes_eliminados_sucursal_fk` FOREIGN KEY (`perro_id`) REFERENCES `dimension_perros`(`id`) ON DELETE CASCADE;
ALTER TABLE `hechos_ingredientes_eliminados` ADD CONSTRAINT `hechos_ingredientes_eliminados_cliente_fk` FOREIGN KEY (`sucursal_id`) REFERENCES `dimension_sucursales`(`id`) ON DELETE CASCADE;
ALTER TABLE `hechos_ingredientes_eliminados` ADD CONSTRAINT `hechos_ingredientes_eliminados_perro_fk` FOREIGN KEY (`cliente_id`) REFERENCES `dimension_clientes`(`id`) ON DELETE CASCADE;

