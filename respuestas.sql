select fechas.fecha, fechas.dia, fechas.segmento, sucursal.nombre as nombre_sucursal,
		perro.nombre as perro_nombre, count(venta.perro_id) as cantidad_vendida
	from hecho_ventas_pedidos as venta
    join dimension_fechas as fechas on venta.fecha_id = fechas.id
    join dimension_perros as perro on venta.perro_id = perro.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fechas.dia, fechas.segmento, sucursal.id, perro_nombre, fechas.fecha
    order by nombre_sucursal, fechas.fecha, fechas.segmento;
    
select fechas.fecha, fechas.dia, sucursal.nombre as nombre_sucursal, sum( if(bebidas > 0, 1, 0) ) as bebidas, count(venta.id) as total,
		concat( round( sum( if(bebidas > 0, 1, 0) ) * 100 / count(venta.id), 2), '%') as porcentaje
	from hecho_ventas as venta
    join dimension_fechas as fechas on venta.fecha_id = fechas.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fechas.dia, sucursal.id, fechas.fecha
    order by nombre_sucursal, fechas.fecha;

select fechas.fecha, fechas.dia, sucursal.nombre as nombre_sucursal, count(perro_id) as perros,
        concat( round( sum(if(cantidad = 0, 1, 0)) * 100 / count(perro_id), 2), '%') as con_todos_ingredientes,
		concat( round( sum(if(cantidad = 1, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_un_ingredientes,
		concat( round( sum(if(cantidad = 2, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_dos_ingredientes,
		concat( round( sum(if(cantidad = 3, 1, 0)) * 100 / count(perro_id), 2), '%') as menos_tres_ingredientes,
		concat( round( sum(if(cantidad = 4, 1, 0)) * 100 / count(perro_id), 2), '%') as sin_nada
	from hechos_ingredientes_eliminados as ingrediente_eliminado
    join dimension_fechas as fechas on ingrediente_eliminado.fecha_id = fechas.id
    join dimension_sucursales as sucursal on ingrediente_eliminado.sucursal_id = sucursal.id
    group by fechas.dia, sucursal.id, fechas.fecha
    order by nombre_sucursal, fechas.fecha;
    
select fechas.fecha, fechas.dia, sucursal.nombre as nombre_sucursal, venta.sucursal_id, sum(precio) as ganancias
	from hecho_ventas_pedidos as venta
    join dimension_fechas as fechas on venta.fecha_id = fechas.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fechas.dia, sucursal_id, fechas.fecha
    order by sucursal.nombre, fechas.fecha;
    
select fechas.fecha, fechas.dia, venta.sucursal_id, sucursal.nombre as nombre_sucursal, count(venta.id) numero_clientes
	from hecho_ventas_pedidos as venta
    join dimension_fechas as fechas on venta.fecha_id = fechas.id
    join dimension_sucursales as sucursal on venta.sucursal_id = sucursal.id
    group by fechas.dia, fechas.fecha, sucursal.id
    order by nombre_sucursal;