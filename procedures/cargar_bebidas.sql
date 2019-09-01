CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_bebidas`()
BEGIN
	insert into dimension_bebidas (id, nombre)		
		select id, nombre from perros_calientes.bebidas;
END