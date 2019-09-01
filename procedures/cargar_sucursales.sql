CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_sucursales`()
BEGIN
	insert into dimension_sucursales (id, nombre)
		select id, nombre from perros_calientes.sucursales;
END