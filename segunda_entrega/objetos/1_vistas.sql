
-- Esta vista muestra información detallada de los productos. Incluye la colección, precio, categoría, talle y tipo de producto.
CREATE OR REPLACE VIEW vw_productos_detalle AS
SELECT 
    p.id_producto,
    p.coleccion AS coleccion_producto,
    p.precio,
    c.nombre AS categoria,
    t.talle,
    p.tipo_producto
FROM productos p
JOIN categoria_producto c ON p.id_categoria = c.id_categoria
JOIN talles t ON p.id_talle = t.id_talle;


-- Esta vista permite ver el detalle de las ventas realizadas. Muestra la fecha, el socio que realizó la compra, 
-- el empleado que la atendió y en qué sucursal se realizó, junto con el número único de la venta.
CREATE OR REPLACE VIEW vw_ventas_detalle AS
SELECT 
    v.id_venta,
    v.fecha_venta,
    v.num_socio,
    CONCAT(pe.nombre, ' ', pe.apellido) AS socio,
    v.nro_empleado,
    CONCAT(em.nombre, ' ', em.apellido) AS empleado,
    s.nom_sucursal AS sucursal,
    v.num_venta
FROM ventas v
LEFT JOIN socios s ON v.num_socio = s.num_socio
LEFT JOIN personas pe ON s.id_persona = pe.id_persona
LEFT JOIN empleados e ON v.nro_empleado = e.nro_empleado
LEFT JOIN personas em ON e.id_persona = em.id_persona
LEFT JOIN sucursales s ON v.id_sucursal = s.id_sucursal;


-- Esta vista nos ayuda a visualizar el inventario de cada sucursal. Muestra cuántos productos hay disponibles,
-- junto con su categoría y talle, organizados por cada sucursal.
CREATE OR REPLACE VIEW vw_inventario_sucursal AS
SELECT 
    i.id_inventario,
    s.nom_sucursal,
    p.coleccion AS producto,
    c.nombre AS categoria,
    t.talle,
    i.cantidad
FROM inventario i
JOIN sucursales s ON i.id_sucursal = s.id_sucursal
JOIN productos p ON i.id_producto = p.id_producto
JOIN categoria_producto c ON p.id_categoria = c.id_categoria
JOIN talles t ON p.id_talle = t.id_talle;


-- Esta vista muestra los empleados con el puesto que ocupan y cuánto ganan. 
CREATE OR REPLACE VIEW vw_empleados_salarios AS
SELECT 
    e.id_persona AS empleado_id,
    CONCAT(p.nombre, ' ', p.apellido) AS nombre_empleado,
    pu.nom_puesto AS puesto,
    s.salario
FROM empleados e
JOIN personas p ON e.id_persona = p.id_persona
JOIN puestos pu ON p.id_puesto = pu.id_puesto
JOIN salarios s ON pu.id_puesto = s.id_puesto;


-- Esta vista muestra un resumen de los proveedores. Incluye el nombre del proveedor, su teléfono y la ciudad donde trabaja.
CREATE OR REPLACE VIEW vw_proveedores_resumen AS
SELECT 
    pr.nombre AS proveedor,
    t.num_telefono AS telefono,
    c.nom_ciudad AS ciudad,
    p.nom_pais AS pais
FROM proveedores pr
JOIN telefonos t ON pr.id_telefono = t.id_telefono
JOIN pais_ciudad pc ON pr.id_pais_ciudad = pc.id_pais_ciudad
JOIN ciudades c ON pc.id_ciudad = c.id_ciudad
JOIN paises p ON pc.id_pais = p.id_pais;

-- Esta vista detalla las ventas con los productos comprados en cada una. Muestra el número de venta, 
-- el producto, la cantidad comprada, el precio unitario y el total pagado.
CREATE OR REPLACE VIEW vw_detalle_ventas_productos AS
SELECT 
    dv.id_venta,
    v.num_venta AS numero_venta,
    p.coleccion AS producto,
    c.nombre AS categoria,
    dv.cantidad,
    dv.prc_unitario AS precio_unitario,
    dv.total AS precio_total
FROM detalle_ventas dv
JOIN ventas v ON dv.id_venta = v.id_venta
JOIN productos p ON dv.id_producto = p.id_producto
JOIN categoria_producto c ON p.id_categoria = c.id_categoria;
