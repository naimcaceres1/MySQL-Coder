
-- Esta función devuelve el total de ventas realizadas por un socio específico.
DELIMITER //

CREATE FUNCTION total_ventas_socio(num_socio INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dv.total) INTO total
    FROM detalle_ventas dv
    JOIN ventas v ON dv.id_venta = v.id_venta
    WHERE v.num_socio = num_socio;
    RETURN IFNULL(total, 0.00);
END //

DELIMITER ;



-- Esta función devuelve la cantidad de un producto en una sucursal específica.
DELIMITER //

CREATE FUNCTION verificar_inventario(p_id_producto INT, p_id_sucursal INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_cantidad INT DEFAULT 0;
    
    SELECT SUM(cantidad) INTO total_cantidad
    FROM inventario
    WHERE id_producto = p_id_producto AND id_sucursal = p_id_sucursal;

    RETURN IFNULL(total_cantidad, 0);
END //
DELIMITER ;




-- Esta función incrementa el salario de un puesto en un 0.5% cada mes.
DELIMITER //

CREATE FUNCTION incrementar_salario(p_id_puesto INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE salario_actual DECIMAL(10,2);

    SELECT salario INTO salario_actual
    FROM salarios
    WHERE id_puesto = p_id_puesto
    LIMIT 1;

    SET salario_actual = salario_actual * 1.005;

    UPDATE salarios
    SET salario = salario_actual
    WHERE id_puesto = p_id_puesto
    LIMIT 1;

    RETURN salario_actual;
END //

DELIMITER ;