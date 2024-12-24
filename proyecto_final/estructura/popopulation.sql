USE proyecto_coder;

INSERT INTO puestos (nom_puesto) VALUES
('Contador'),
('Recursos Humanos'),
('Gerente'),
('Administrador'),
('Auditoría'),
('Vendedores'),
('Jefe'),
('Encargados'),
('Limpieza');

INSERT INTO salarios (id_puesto, salario) VALUES
(9, 25000.00),  
(6, 30000.00), 
(8, 40000.00), 
(5, 50000.00), 
(4, 60000.00),  
(2, 70000.00),  
(3, 100000.00), 
(7, 130000.00), 
(1, 110000.00); 

INSERT INTO categoria_producto (nombre) VALUES
('Casual'),
('Running'),
('Training'),
('Pelotas'),
('Deportes');

INSERT INTO talles (talle) VALUES
('XS'),
('S'),
('M'),
('L'),
('XL'),
('XXL'),
('XXXL'),
('Único');


INSERT INTO productos (coleccion, precio, id_talle, id_categoria, tipo_producto) VALUES
('Verano Casual', 1200.00, 2, 1, 'indumentaria'),   
('Running Pro', 2200.00, 3, 2, 'calzado'),          
('Training Fit', 1500.00, 4, 3, 'indumentaria'),    
('Balón Oficial', 800.00, 3, 4, 'accesorio'),       
('Kit Deportivo', 1000.00, 5, 5, 'indumentaria'),   
('Camiseta Running', 1300.00, 3, 2, 'indumentaria'),
('Zapatillas Urbanas', 2500.00, 6, 1, 'calzado'),   
('Pelota Profesional', 2000.00, 6, 4, 'accesorio'), 
('Pantalón Training', 1400.00, 4, 3, 'indumentaria'), 
('Accesorio Deportivo', 600.00, 7, 5, 'accesorio'); 

INSERT INTO paises (nom_pais) VALUES
('Uruguay'),
('Argentina'),
('Brasil'),
('Chile'),
('Paraguay'),
('Perú'),
('Bolivia'),
('Ecuador'),
('Colombia'),
('Venezuela');


INSERT INTO ciudades (nom_ciudad) VALUES
('Montevideo'),
('Buenos Aires'),
('São Paulo'),
('Santiago'),
('Asunción'),
('Lima'),
('La Paz'),
('Quito'),
('Bogotá'),
('Caracas');

INSERT INTO pais_ciudad (id_pais, id_ciudad) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO sucursales (nom_sucursal) VALUES
('Centro'),
('Pocitos'),
('Carrasco'),
('Tres Cruces'),
('Punta Carretas'),
('Malvín'),
('Prado'),
('Ciudad Vieja'),
('Buceo'),
('Cordón');

INSERT INTO telefonos (num_telefono) VALUES
('091234567'), 
('091345678'),
('091456789'),
('091567890'), 
('091678901'), 
('091789012'), 
('091890123'), 
('091901234'),
('091012345'),
('091123456'), 
('092234567'),
('092345678'), 
('092456789'),
('092567890'),
('092678901'),
('092789012'), 
('092890123'), 
('092901234'), 
('092012345'), 
('092123456'); 


INSERT INTO personas (nombre, apellido, cedula, id_telefono, email, direccion, fecha_ingreso, id_puesto, id_pais_ciudad) VALUES
('Juan', 'Pérez', '12345678', 1, 'juan.perez@example.com', 'Calle 1', '2023-01-10', 6, 1),
('María', 'Gómez', '23456789', 2, 'maria.gomez@example.com', 'Calle 2', '2023-02-15', 7, 2),
('Carlos', 'López', '34567890', 3, 'carlos.lopez@example.com', 'Calle 3', '2023-03-05', 8, 3),
('Ana', 'Martínez', '45678901', 4, 'ana.martinez@example.com', 'Calle 4', '2023-04-20', 9, 4),
('Luis', 'Rodríguez', '56789012', 5, 'luis.rodriguez@example.com', 'Calle 5', '2023-05-25', 1, 5),
('Laura', 'Sánchez', '67890123', 6, 'laura.sanchez@example.com', 'Calle 6', '2023-06-15', 2, 6),
('Diego', 'González', '78901234', 7, 'diego.gonzalez@example.com', 'Calle 7', '2023-07-01', 3, 7),
('Sofía', 'Torres', '89012345', 8, 'sofia.torres@example.com', 'Calle 8', '2023-08-10', 4, 8),
('Miguel', 'Díaz', '90123456', 9, 'miguel.diaz@example.com', 'Calle 9', '2023-09-20', 5, 9),
('Lucía', 'Fernández', '01234567', 10, 'lucia.fernandez@example.com', 'Calle 10', '2023-10-30', 6, 10),
('Andrea', 'Méndez', '12345001', 11, 'andrea.mendez@example.com', 'Calle Principal 101', '2023-01-01', 9, 1),
('Pedro', 'Sosa', '12345002', 12, 'pedro.sosa@example.com', 'Calle Principal 102', '2023-01-02', 6, 2),    
('Clara', 'Fernández', '12345003', 13, 'clara.fernandez@example.com', 'Calle Principal 103', '2023-01-03', 8, 3), 
('Jorge', 'Pérez', '12345004', 14, 'jorge.perez@example.com', 'Calle Principal 104', '2023-01-04', 5, 4),  
('Lucía', 'Suárez', '12345005', 15, 'lucia.suarez@example.com', 'Calle Principal 105', '2023-01-05', 4, 5), 
('Gonzalo', 'Díaz', '12345006', 16, 'gonzalo.diaz@example.com', 'Calle Principal 106', '2023-01-06', 2, 6),  
('Paola', 'Rojas', '12345007', 17, 'paola.rojas@example.com', 'Calle Principal 107', '2023-01-07', 3, 7),  
('Diego', 'Martínez', '12345008', 18, 'diego.martinez@example.com', 'Calle Principal 108', '2023-01-08', 7, 8), 
('Valeria', 'López', '12345009', 19, 'valeria.lopez@example.com', 'Calle Principal 109', '2023-01-09', 1, 9), 
('Rodrigo', 'García', '12345010', 20, 'rodrigo.garcia@example.com', 'Calle Principal 110', '2023-01-10', 9, 10); 


INSERT INTO empleados (id_persona, nro_empleado) VALUES
(21, 101),
(22, 102),
(23, 103),
(24, 104),
(25, 105),
(26, 106),
(27, 107),
(28, 108),
(29, 109),
(30, 110);

INSERT INTO socios (id_persona, num_socio) VALUES
(22, 201),
(24, 202),
(26, 203),
(28, 204),
(30, 205),
(21, 206),
(23, 207),
(25, 208),
(27, 209),
(29, 210);

INSERT INTO jornales (id_persona, id_sucursal, fecha, hora_entrada, hora_salida) VALUES
(21, 1, '2023-11-25', '08:00:00', '16:00:00'),
(22, 2, '2023-11-26', '09:00:00', '17:00:00'),
(23, 3, '2023-11-27', '10:00:00', '18:00:00'),
(24, 4, '2023-11-28', '11:00:00', '19:00:00'),
(25, 5, '2023-11-29', '12:00:00', '20:00:00'),
(26, 6, '2023-11-30', '13:00:00', '21:00:00'),
(27, 7, '2023-12-01', '14:00:00', '22:00:00'),
(28, 8, '2023-12-02', '15:00:00', '23:00:00'),
(29, 9, '2023-12-03', '08:00:00', '16:00:00'),
(30, 10, '2023-12-04', '09:00:00', '17:00:00');

INSERT INTO ventas (fecha_venta, num_socio, nro_empleado, id_sucursal, num_venta) VALUES
('2023-11-20 10:00:00', 201, 101, 1, 1001),
('2023-11-21 11:00:00', 202, 102, 2, 1002),
('2023-11-22 12:00:00', 203, 103, 3, 1003),
('2023-11-23 13:00:00', 204, 104, 4, 1004),
('2023-11-24 14:00:00', 205, 105, 5, 1005),
('2023-11-25 15:00:00', 206, 106, 6, 1006),
('2023-11-26 16:00:00', 207, 107, 7, 1007),
('2023-11-27 17:00:00', 208, 108, 8, 1008),
('2023-11-28 18:00:00', 209, 109, 9, 1009),
('2023-11-29 19:00:00', 210, 110, 10, 1010);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, prc_unitario, total) VALUES
(11, 51, 2, 1200.00, 2400.00),
(12, 52, 1, 2200.00, 2200.00),
(13, 53, 3, 1500.00, 4500.00),
(14, 54, 1, 800.00, 800.00),
(15, 55, 2, 1000.00, 2000.00),
(16, 56, 1, 1300.00, 1300.00),
(17, 57, 1, 2500.00, 2500.00),
(18, 58, 2, 2000.00, 4000.00),
(19, 59, 1, 1400.00, 1400.00),
(20, 60, 1, 600.00, 600.00);

INSERT INTO inventario (id_sucursal, id_producto, cantidad) VALUES
(1, 51, 100), 
(1, 52, 150), 
(1, 53, 200), 
(2, 54, 80),  
(2, 55, 50),  
(2, 56, 120), 
(3, 57, 90),  
(3, 58, 70),  
(3, 59, 140), 
(4, 60, 30),  
(4, 51, 200), 
(4, 52, 300), 
(5, 53, 120), 
(5, 54, 180), 
(6, 55, 100), 
(6, 56, 220), 
(6, 57, 110), 
(7, 58, 40), 
(7, 59, 70), 
(7, 60, 60), 
(8, 51, 90),  
(8, 52, 130), 
(8, 53, 160), 
(9, 54, 70),   
(9, 55, 50),   
(10, 56, 40),  
(10, 57, 60), 
(10, 58, 20),  
(10, 59, 30),  
(10, 60, 100); 


INSERT INTO telefonos (num_telefono) VALUES
('093234567'),
('093345678'), 
('093456789'), 
('093567890'), 
('093678901'), 
('093789012'), 
('093890123'),
('093901234'), 
('093012345'), 
('093123456'); 



INSERT INTO proveedores (nombre, id_telefono, id_pais_ciudad) VALUES
('Deportes Pro', 21, 1), 
('Accesorios Sport', 22, 2), 
('Calzado Top', 23, 3),  
('Indumentaria Max', 24, 4),
('Balones Premium', 25, 5), 
('Training Gear', 26, 6),
('Sports Wear', 27, 7),  
('Quito Sports', 28, 8), 
('Bogotá Fit', 29, 9),  
('Caracas Gear', 30, 10);  
