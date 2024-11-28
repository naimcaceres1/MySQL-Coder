-- Este trigger previene que se pueda realziar una venta de un producto sin stock suficiente en el inventario.
DELIMITER //

CREATE TRIGGER validar_stock BEFORE INSERT ON detalle_ventas
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;

    SELECT cantidad INTO stock_actual
    FROM inventario
    WHERE id_producto = NEW.id_producto
      AND id_sucursal = (
          SELECT id_sucursal FROM ventas WHERE id_venta = NEW.id_venta
      )
    LIMIT 1;

    IF stock_actual IS NULL OR stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para este producto.';
    END IF;
END //
DELIMITER ;

-- Este trigger descuenta automáticamente el inventario después de registrar un detalle de venta.
DELIMITER //

DROP TRIGGER IF EXISTS actualizar_stock;
CREATE TRIGGER actualizar_stock AFTER INSERT ON detalle_ventas
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET cantidad = cantidad - NEW.cantidad
    WHERE id_producto = NEW.id_producto
      AND id_sucursal = (
          SELECT id_sucursal FROM ventas WHERE id_venta = NEW.id_venta
      )
    LIMIT 1;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se pudo actualizar el inventario.';
    END IF;
END //
DELIMITER ;


-- Registra automáticamente la fecha de salida al eliminar un empleado.
DELIMITER //
DROP TRIGGER IF EXISTS registrar_fecha_salida;
CREATE TRIGGER registrar_fecha_salida BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
    UPDATE personas
    SET fecha_salida = CURRENT_DATE
    WHERE id_persona = OLD.id_persona;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se encontró el registro en personas para actualizar la fecha de salida.';
    END IF;
END //
DELIMITER ;

