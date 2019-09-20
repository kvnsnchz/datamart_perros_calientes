delimiter //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_fechas`()
BEGIN
	insert into dimension_fechas (id, fecha, dia, mes, año, segmento)
		select id, fecha, dia, mes, año, segmento from perros_calientes.dimension_fechas;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_sucursales`()
BEGIN
	insert into dimension_sucursales (id, nombre)
		select id, nombre from perros_calientes.sucursales;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_clientes`()
BEGIN
	insert into dimension_clientes (id, nombre)
		select id, nombre from perros_calientes.clientes;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_perros`()
BEGIN
	insert into dimension_perros (id, nombre)
    select id, nombre from perros_calientes.perros; 
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_bebidas`()
BEGIN
	insert into dimension_bebidas (id, nombre)		
		select id, nombre from perros_calientes.bebidas;
END //

delimiter ;