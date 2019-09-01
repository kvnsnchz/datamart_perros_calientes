CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hecho_ventas`()
BEGIN
	insert into hecho_ventas (fecha_id, sucursal_id, cliente_id, bebidas, perros)
		
    select 
        get_fecha_id(factura.fecha) as fecha_id, 
        sucursal.id as sucursal_id, 
        factura.cliente_id as cliente_id, 
        sum((select sum(cantidad) from perros_calientes.bebidas_pedidos where pedido.id = pedido_id)) as bebidas,
        count(perro_id) as perros
    from perros_calientes.pedidos as pedido
    join perros_calientes.facturas as factura on pedido.factura_id = facturas.id
    join perros_calientes.sucursales as sucursal on facturas.sucursal_id = sucursales.id
    group by factura_id
    order by fecha_id, sucursal_id;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hecho_ventas_pedidos`()
BEGIN
	insert into hecho_ventas_pedidos (fecha_id, sucursal_id, cliente_id, perro_id, bebidas, precio)
    
    select 
        get_fecha_id(factura.fecha) as fecha_id, 
        factura.sucursal_id, 
        factura.cliente_id, 
        perro_id, 
        (select sum(cantidad) from perros_calientes.bebidas_pedidos where pedido.id = pedido_id) as bebidas, 
        (perro.precio + (select sum(bebida.precio * cantidad) from perros_calientes.bebidas_pedidos bebida_pedido join perros_calientes.bebidas as bebida on bebida_id = bebida.id where pedido.id = pedido_id )) as precio
	from perros_calientes.pedidos  as pedido
    join perros_calientes.perros as perro on pedido.perro_id = perro.id
    join perros_calientes.facturas as factura on pedido.factura_id = factura.id
	join perros_calientes.sucursales as sucursal on factura.sucursal_id = sucursal.id
order by fecha_id;

END

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hechos_ingredientes_eliminados`()
BEGIN
	insert into hechos_ingredientes_eliminados (fecha_id, sucursal_id, cliente_id, perro_id, cantidad)
 
	select 
        get_fecha_id (factura.fecha) as fecha_id, 
        sucursal.id as sucursal_id,
        factura.cliente_id, 
        pedido.perro_id,
        count(ingrediente_eliminado.ingrediente_id) as cantidad
    from perros_calientes.pedidos as pedido
    left join perros_calientes.ingredientes_eliminados as ingrediente_eliminado on pedido.id = ingrediente_eliminado.pedido_id
    join perros_calientes.facturas as factura on pedido.factura_id = factura.id
    join perros_calientes.sucursales as sucursal on factura.sucursal_id = sucursal.id
    group by pedido.id, pedido.perro_id
    order by fecha_id, sucursal_id;
END

