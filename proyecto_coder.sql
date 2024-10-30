CREATE DATABASE proyecto_coder;

USE proyecto_coder;

CREATE TABLE telefonos(
    id_telefono INT AUTO_INCREMENT PRIMARY KEY,
    num_telefono VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE puestos(
    id_puesto INT AUTO_INCREMENT PRIMARY KEY,
    nom_puesto VARCHAR(30) NOT NULL
);

CREATE TABLE paises(
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nom_pais VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE ciudades(
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    nom_ciudad VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE categoria_producto(
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE talles(
    id_talle INT AUTO_INCREMENT PRIMARY KEY,
    talle VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE sucursales(
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nom_sucursal VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE pais_ciudad (
    id_pais_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    id_pais INT NOT NULL,
    id_ciudad INT NOT NULL,
    UNIQUE (id_pais, id_ciudad),
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    FOREIGN KEY (id_ciudad) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE salarios(
    id_salario INT AUTO_INCREMENT PRIMARY KEY,
    id_puesto INT NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_puesto) REFERENCES puestos(id_puesto)
);

CREATE TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    coleccion VARCHAR(30) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_talle INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_talle) REFERENCES talles(id_talle),
    FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria)
);

CREATE TABLE personas(
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    cedula VARCHAR(10) UNIQUE NOT NULL,
    id_telefono INT UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_salida DATE,
    id_puesto INT NOT NULL,
    id_pais_ciudad INT NOT NULL,
    FOREIGN KEY (id_telefono) REFERENCES telefonos(id_telefono),
    FOREIGN KEY (id_puesto) REFERENCES puestos(id_puesto),
    FOREIGN KEY (id_pais_ciudad) REFERENCES pais_ciudad(id_pais_ciudad)
);

CREATE TABLE empleados(
    id_persona INT PRIMARY KEY,
    nro_empleado INT UNIQUE NOT NULL,
    FOREIGN KEY(id_persona) REFERENCES personas(id_persona)
);

CREATE TABLE socios(
    id_persona INT PRIMARY KEY,
    num_socio INT UNIQUE NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

CREATE TABLE ventas(
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    num_socio INT,
    nro_empleado INT NOT NULL,
    id_sucursal INT NOT NULL,
    num_venta INT UNIQUE NOT NULL,
    FOREIGN KEY (num_socio) REFERENCES socios(num_socio),
    FOREIGN KEY (nro_empleado) REFERENCES empleados(nro_empleado),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE detalle_ventas(
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    prc_unitario DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE inventario(
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE KEY unique_sucursal_producto (id_sucursal, id_producto)
);


CREATE TABLE jornales(
    id_jornal INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT NOT NULL,
    id_sucursal INT NOT NULL,
    fecha DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE proveedores(
	id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    id_telefono INT NOT NULL,
    id_pais_ciudad INT NOT NULL,
    FOREIGN KEY(id_telefono) REFERENCES telefonos(id_telefono),
    FOREIGN KEY(id_pais_ciudad) REFERENCES pais_ciudad(id_pais_ciudad)
);

ALTER TABLE socios
	ADD CONSTRAINT uq_socio_persona UNIQUE (id_persona);

ALTER TABLE empleados
	ADD CONSTRAINT uq_empleado_persona UNIQUE (id_persona);

ALTER TABLE ventas
	MODIFY num_socio INT NULL;

ALTER TABLE ventas
	ADD CONSTRAINT fk_ventas_num_socio FOREIGN KEY (num_socio) REFERENCES socios (num_socio);