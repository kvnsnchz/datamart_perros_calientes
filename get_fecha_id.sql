delimiter //

CREATE DEFINER=`root`@`localhost` FUNCTION `get_fecha_id`(fecha VARCHAR(20)) RETURNS int(11)
BEGIN
	DECLARE ret_value INTEGER;
    DECLARE id VARCHAR(20);
    DECLARE hora INTEGER DEFAULT hour(fecha);
    DECLARE segmento INTEGER DEFAULT 1;
	DECLARE mes VARCHAR(20);
	DECLARE dia VARCHAR(20);
    
    if month(fecha) < 10 then
		set mes = concat('0', month(fecha));
	else
		 set mes = month(fecha);
    end if;
    
	if day(fecha) < 10 then
		set dia = concat('0', day(fecha));
	else
		set dia = day(fecha);
    end if;
    
	if hora > 5 && hora < 12 then
		set segmento = 1;
	elseif hora > 11 && hora < 19 then 
		set segmento = 2;
	else
		set segmento = 3;
	end if;
    
	SET id = concat( year(fecha), concat(mes, dia) );
    
RETURN concat(id, segmento);
END //

delimiter ;