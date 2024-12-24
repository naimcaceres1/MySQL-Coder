Entidades y Atributos

Telefonos
    - id_telefono: Identificador único para cada teléfono.
    - num_telefono: Número de teléfono, único en la base de datos.

Puestos
    - id_puesto: Identificador único del puesto de trabajo.
    - nom_puesto: Nombre del puesto de trabajo (ejemplo: vendedor, gerente).


Paises
    - id_pais: Identificador único del país.
    - nom_pais: Nombre del país, único en la base de datos.


Ciudades
    - id_ciudad: Identificador único de la ciudad.
    - nom_ciudad: Nombre de la ciudad, único en la base de datos.


Categoria_producto
    - id_categoria: Identificador único de la categoría de producto.
    - nombre: Nombre de la categoría de producto (ejemplo: ropa, calzado), único en la base de datos.

Talles
    - id_talle: Identificador único del talle.
    - talle: Descripción del talle (ejemplo: S, M, L, XL), único en la base de datos.

Sucursales
    - id_sucursal: Identificador único de la sucursal.
    - nom_sucursal: Nombre de la sucursal, único en la base de datos.

Pais_ciudad
    - id_pais_ciudad: Identificador único de la relación entre país y ciudad.
    - id_pais: Referencia al país.
    - id_ciudad: Referencia a la ciudad.

Salarios
    - id_salario: Identificador único del salario.
    - id_puesto: Referencia al puesto de trabajo.
    - salario: Monto del salario para el puesto.

Productos
    - id_producto: Identificador único del producto.
    - coleccion: Nombre de la colección o temporada del producto.
    - precio: Precio del producto.
    - id_talle: Referencia al talle del producto.
    - id_categoria: Referencia a la categoría del producto.

Personas
    - id_persona: Identificador único de la persona.
    - nombre: Nombre de la persona.
    - apellido: Apellido de la persona.
    - cedula: Número de identificación, único para cada persona.
    - id_telefono: Referencia al número de teléfono de la persona.
    - email: Dirección de correo electrónico, única.
    - direccion: Dirección de residencia.
    - fecha_ingreso: Fecha en la que la persona ingresó a la empresa.
    - fecha_salida: Fecha en la que la persona dejó la empresa (si corresponde).
    - id_puesto: Referencia al puesto que ocupa la persona en la empresa.
    - id_pais_ciudad: Referencia al país y ciudad de residencia.

Empleados
    - id_persona: Referencia única a la persona que es empleado.
    - nro_empleado: Número de empleado, único.

Socios
    - id_persona: Referencia única a la persona que es socio.
    - num_socio: Número de socio, único.

Ventas
    - id_venta: Identificador único de la venta.
    - fecha_venta: Fecha y hora de la venta.
    - num_socio: Referencia opcional al socio que realizó la compra.
    - nro_empleado: Referencia al empleado que realizó la venta.
    - id_sucursal: Referencia a la sucursal donde se realizó la venta.
    - num_venta: Número de venta, único.

Detalle_ventas
    - id_detalle_venta: Identificador único del detalle de la venta.
    - id_venta: Referencia a la venta.
    - id_producto: Referencia al producto vendido.
    - cantidad: Cantidad de productos en la venta.
    - prc_unitario: Precio unitario del producto.
    - total: Total calculado para la línea de detalle (cantidad * prc_unitario).

Inventario
    - id_inventario: Identificador único del inventario.
    - id_sucursal: Referencia a la sucursal.
    - id_producto: Referencia al producto en el inventario.
    - cantidad: Cantidad de este producto en la sucursal.

Jornales
    - id_jornal: Identificador único del registro de trabajo.
    - id_persona: Referencia al empleado que registra el jornal.
    - id_sucursal: Referencia a la sucursal donde trabajó.
    - fecha: Fecha del registro.
    - hora_entrada: Hora de entrada del empleado.
    - hora_salida: Hora de salida del empleado.

Proveedores
    - id_proveedor: Identificador único del proveedor.
    - nombre: Nombre del proveedor, único.
    - id_telefono: Referencia al número de teléfono del proveedor.
    - id_pais_ciudad: Referencia a la ciudad y país del proveedor.
    - Relación: Información de los proveedores que abastecen a la tienda.


Relaciones

Detalle_Ventas - Ventas
    - Cardinalidad: 1 a N
    - Relación: Cada venta puede tener múltiples detalles de venta (productos comprados en esa venta), pero cada detalle de venta pertenece a una única venta.

Ventas - Sucursal
    - Cardinalidad: N a 1
    - Relación: Una venta se realiza en una sucursal específica, pero una sucursal puede registrar múltiples ventas.


Ventas - Socio
    - Cardinalidad: N a 1
    - Relación: Una venta puede estar asociada a un socio específico, mientras que un socio puede realizar múltiples ventas.

Inventario - Sucursal
    Cardinalidad: N a 1
    Relación: El inventario se organiza por sucursal, y cada sucursal puede tener múltiples productos en su inventario.

Inventario - Producto
    - Cardinalidad: N a 1
    - Relación: Cada inventario contiene referencias a productos específicos, y cada producto puede aparecer en múltiples inventarios de diferentes sucursales.

Producto - Talles
    - Cardinalidad: N a 1
    - Relación: Un producto está disponible en diferentes talles, pero cada talle corresponde a múltiples productos.

Producto - Categoria_Producto
    - Cardinalidad: N a 1
    - Relación: Cada producto pertenece a una categoría de producto, mientras que una categoría puede abarcar varios productos.

Proveedor - Sucursal
    - Cardinalidad: N a N
    - Relación: Un proveedor puede abastecer a varias sucursales y una sucursal puede tener múltiples proveedores.


Proveedor - Telefono
    - Cardinalidad: 1 a N
    - Relación: Un proveedor puede tener varios números de teléfono.


Telefono - Persona
    - Cardinalidad: 1 a N
    - Relación: Cada número de teléfono puede estar asociado a múltiples personas.

Persona - Ciudad
    - Cardinalidad: N a 1 (a través de la entidad Pais)
    - Relación: Una persona reside en una ciudad específica, que está ubicada en un país. Varias personas pueden residir en la misma ciudad.

Persona - Empleado
    - Cardinalidad: 1 a 1
    - Relación: Una persona puede ser un empleado, y un empleado es una persona.


Persona - Socio
    - Cardinalidad: 1 a 1
    - Relación: Una persona puede ser socio, y un socio es una persona.

Empleado - Puesto
    - Cardinalidad: N a 1
    - Relación: Un empleado ocupa un puesto específico, pero un puesto puede estar ocupado por múltiples empleados.

Puesto - Salario
    - Cardinalidad: 1 a 1
    - Relación: Cada puesto tiene un salario único.

Jornal - Empleado 
    - Cardinalidad: N a 1
    - Relación: Un jornal está asociado a un empleado específico, y un empleado puede tener múltiples registros de jornal.

Jornal - Sucursal
    - Cardinalidad: N a 1
    - Relación: Cada registro de jornal se asocia a una sucursal donde el empleado trabajó.

Pais - Ciudad
    - Cardinalidad: 1 a N
    - Relación: Cada país contiene varias ciudades, pero una ciudad solo pertenece a un país.