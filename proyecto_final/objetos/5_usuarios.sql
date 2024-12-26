USE proyecto_coder;

CREATE USER 'vendedor'@'%' IDENTIFIED BY 'vendedor123';
	GRANT SELECT ON vw_productos_detalle TO 'vendedor'@'%';
	GRANT SELECT ON vw_ventas_detalle TO 'vendedor'@'%';
	GRANT SELECT ON vw_inventario_sucursal TO 'vendedor'@'%';
	GRANT SELECT ON vw_detalle_ventas_productos TO 'vendedor'@'%';

CREATE USER 'gerente'@'%' IDENTIFIED BY 'gerente123';
	GRANT SELECT ON vw_productos_detalle TO 'gerente'@'%';
	GRANT SELECT ON vw_ventas_detalle TO 'gerente'@'%';
	GRANT SELECT ON vw_inventario_sucursal TO 'gerente'@'%';
	GRANT SELECT ON vw_proveedores_resumen TO 'gerente'@'%';
	GRANT SELECT ON vw_detalle_ventas_productos TO 'gerente'@'%';
    
CREATE USER 'auditor'@'%' IDENTIFIED BY 'auditor123';
	GRANT SELECT ON vw_productos_detalle TO 'auditor'@'%';
	GRANT SELECT ON vw_ventas_detalle TO 'auditor'@'%';
	GRANT SELECT ON vw_inventario_sucursal TO 'auditor'@'%';
	GRANT SELECT ON vw_empleados_salarios TO 'auditor'@'%';
	GRANT SELECT ON vw_proveedores_resumen TO 'auditor'@'%';
	GRANT SELECT ON vw_detalle_ventas_productos TO 'auditor'@'%';
