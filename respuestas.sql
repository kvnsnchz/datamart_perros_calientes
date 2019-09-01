SET GLOBAL log_bin_trust_function_creators = 1;

/*Respuesta 1*/
select fecha.dia, fecha.segmento, sucursal.nombre as nombre_sucursal,
		perro.nombre as perro_nombre, count(venta.perro_id) as cantidad_vendida
	from hecho_ventas_pedidos as venta
    join dimension_fechas as fecha on venta.fecha_id = fecha.id
    join dimension_perros as perro on venta.perro_id = perro.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fecha.dia, fecha.segmento, sucursal.id, perro_nombre
    order by nombre_sucursal, fecha.dia, fecha.segmento;
    
/*Respuesta 2*/
select fecha.dia, sucursal.nombre as nombre_sucursal, sum( if(bebidas > 0, 1, 0) ) as bebidas, count(venta.id) as total,
		concat( round( sum( if(bebidas > 0, 1, 0) ) * 100 / count(venta.id), 2), '%') as porcentaje
	from hecho_ventas as venta
    join dimension_fechas as fecha on venta.fecha_id = fecha.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fecha.dia, sucursal.id
    order by nombre_sucursal, fecha.dia;
    
/*Respuesta 3*/
select fecha.dia, sucursal.nombre as nombre_sucursal, count(perro_id) as perros,
        concat( round( sum(if(cantidad = 0, 1, 0)) * 100 / count(perro_id), 2), '%') as con_todos_ingredientes,
		concat( round( sum(if(cantidad = 1, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_un_ingredientes,
		concat( round( sum(if(cantidad = 2, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_dos_ingredientes,
		concat( round( sum(if(cantidad = 3, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_dos_ingredientes,
	from hechos_ingredientes_eliminados as ingrediente_eliminado
    join dimension_fechas as fecha on ingrediente_eliminado.fecha_id = fecha.id
    join dimension_sucursales as sucursal on ingrediente_eliminado.sucursal_id = sucursal.id
    group by fecha.dia, sucursal.id
    order by nombre_sucursal, fecha.dia;
    
/*Respuesta 4*/
select fecha.dia, sucursal.nombre, venta.sucursal_id, sum(precio) as ganancias
	from hecho_ventas_ as venta
    join dim_fechas as fecha on venta.fecha_id = fecha.id
    join dim_sucursales as sucursal on venta.sucursal_id = sucursal.sucursal_id
    group by fecha.dia, sucursal_id
    order by sucursal.nombre;
    
/*5.- Cantidad de clientes atendidos al dia*/
select fecha.dia, venta.sucursal_id, sucursal.nombre as nombre_sucursal, count(venta.id) numero_clientes
	from hecho_ventas_pedidos as venta
    join dimension_fechas as fecha on venta.fecha_id = fecha.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fecha.dia, sucursal.id
    order by nombre_sucursal;