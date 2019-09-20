delimiter //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hecho_ventas`()
BEGIN

    declare inicio varchar(50);
    declare fin varchar(50);
    
    set inicio = date_sub(concat(curdate(), ' 00:00:00'), interval 7 day);
    set fin = date_sub(concat(curdate(), ' 23:59:59'), interval 1 day);

	insert into hecho_ventas (fecha_id, sucursal_id, cliente_id, bebidas, perros)
		
    select 
        get_fecha_id(factura.fecha) as fecha_id, 
        sucursal.id as sucursal_id, 
        factura.cliente_id as cliente_id, 
        ifnull(sum((select sum(cantidad) from perros_calientes.bebidas_pedidos where pedido.id = pedido_id)), 0) as bebidas,
        count(perro_id) as perros
    from perros_calientes.pedidos as pedido
    join perros_calientes.facturas as factura on pedido.factura_id = factura.id
    join perros_calientes.sucursales as sucursal on facturas.sucursal_id = sucursal.id
    where pedido.fecha >= inicio and pedido.fecha <= fin
    group by factura_id
    order by fecha_id, sucursal_id;
END //


CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hecho_ventas_pedidos`()
BEGIN

    declare inicio varchar(50);
    declare fin varchar(50);
    
    set inicio = date_sub(concat(curdate(), ' 00:00:00'), interval 7 day);
    set fin = date_sub(concat(curdate(), ' 23:59:59'), interval 1 day);

	insert into hecho_ventas_pedidos (fecha_id, sucursal_id, cliente_id, perro_id, bebidas, precio)
    
    select 
        get_fecha_id(factura.fecha) as fecha_id, 
        factura.sucursal_id, 
        factura.cliente_id, 
        perro_id, 
        ifnull((select sum(cantidad) from perros_calientes.bebidas_pedidos where pedido.id = pedido_id), 0) as bebidas, 
        (perro.precio + ifnull((select sum(bebida.precio * cantidad) from perros_calientes.bebidas_pedidos bebida_pedido join perros_calientes.bebidas as bebida on bebida_id = bebida.id where pedido.id = pedido_id ), 0)) as precio
	from perros_calientes.pedidos  as pedido
    join perros_calientes.perros as perro on pedido.perro_id = perro.id
    join perros_calientes.facturas as factura on pedido.factura_id = factura.id
	join perros_calientes.sucursales as sucursal on factura.sucursal_id = sucursal.id
    where pedido.fecha >= inicio and pedido.fecha <= fin
    order by fecha_id;

END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_hecho_ingredientes_eliminados`()
BEGIN

    declare inicio varchar(50);
    declare fin varchar(50);
    
    set inicio = date_sub(concat(curdate(), ' 00:00:00'), interval 7 day);
    set fin = date_sub(concat(curdate(), ' 23:59:59'), interval 1 day);

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
    where pedido.fecha >= inicio and pedido.fecha <= fin
    group by pedido.id, pedido.perro_id
    order by fecha_id, sucursal_id;
END //

delimiter ;