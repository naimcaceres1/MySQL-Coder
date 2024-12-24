-- Este procedimiento inserta una nueva venta y devuelve el ID generado.
DELIMITER //

CREATE PROCEDURE registrar_venta(
    IN p_fecha TIMESTAMP,
    IN p_num_socio INT,
    IN p_nro_empleado INT,
    IN p_id_sucursal INT,
    IN p_num_venta INT
)
BEGIN
    INSERT INTO ventas (fecha_venta, num_socio, nro_empleado, id_sucursal, num_venta)
    VALUES (p_fecha, p_num_socio, p_nro_empleado, p_id_sucursal, p_num_venta);
END //

DELIMITER ;



-- Este procedimiento descuenta la cantidad de productos vendidos del inventario.
DELIMITER //

CREATE PROCEDURE actualizar_inventario(
    IN p_id_producto INT,
    IN p_id_sucursal INT,
    IN p_cantidad INT
)
BEGIN
    UPDATE inventario
    SET cantidad = cantidad - p_cantidad
    WHERE id_producto = p_id_producto AND id_sucursal = p_id_sucursal;
END //
DELIMITER ;


-- Registra una devolución, actualizando inventario y creando un registro.
DELIMITER //

CREATE PROCEDURE registrar_devolucion(
    IN p_id_venta INT,
    IN p_id_producto INT,
    IN p_cantidad INT,
    IN p_razon TEXT
)
BEGIN
    INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, prc_unitario, total)
    VALUES (p_id_venta, p_id_producto, -p_cantidad, 
            (SELECT precio FROM productos WHERE id_producto = p_id_producto),
            -(SELECT precio FROM productos WHERE id_producto = p_id_producto) * p_cantidad);

    UPDATE inventario
    SET cantidad = cantidad + p_cantidad
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;