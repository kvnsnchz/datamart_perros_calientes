CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_perros`()
BEGIN
	insert into dimension_perros (id, nombre)
    select id, nombre from perros_calientes.perros; 
END