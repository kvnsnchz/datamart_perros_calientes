CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_clientes`()
BEGIN
	insert into dimension_clientes (id, nombre)
		select id, nombre from perros_calientes.clientes;
END

