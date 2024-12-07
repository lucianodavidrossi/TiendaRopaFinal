-- Creación de tablas

CREATE TABLE clientes (
  cliente_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(20),
  direccion VARCHAR(255)
);

CREATE TABLE productos (
  producto_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  descripcion VARCHAR(255),
  precio DECIMAL(10, 2),
  stock INT,
  categoria_id INT,
  FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

CREATE TABLE categorias (
  categoria_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
);

CREATE TABLE proveedores (
  proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  contacto VARCHAR(50),
  telefono VARCHAR(20),
  direccion VARCHAR(255)
);

CREATE TABLE compras (
  compra_id INT PRIMARY KEY AUTO_INCREMENT,
  proveedor_id INT,
  fecha DATETIME,
  total DECIMAL(10, 2),
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
);

CREATE TABLE detalles_compras (
  detalle_compra_id INT PRIMARY KEY AUTO_INCREMENT,
  compra_id INT,
  producto_id INT,
  cantidad INT,
  precio_unitario DECIMAL(10, 2),
  FOREIGN KEY (compra_id) REFERENCES compras(compra_id),
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

CREATE TABLE ventas (
  venta_id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  fecha DATETIME,
  total DECIMAL(10, 2),
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE detalles_ventas (
  detalle_venta_id INT PRIMARY KEY AUTO_INCREMENT,
  venta_id INT,
  producto_id INT,
  cantidad INT,
  precio_unitario DECIMAL(10, 2),
  FOREIGN KEY (venta_id) REFERENCES ventas(venta_id),
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

CREATE TABLE empleados (
  empleado_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(20),
  puesto VARCHAR(50)
);

CREATE TABLE roles (
  rol_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
);

CREATE TABLE inventario (
  inventario_id INT PRIMARY KEY AUTO_INCREMENT,
  producto_id INT,
  cantidad INT,
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

CREATE TABLE departamentos (
  departamento_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
);

CREATE TABLE empleados_departamentos (
  empleado_id INT,
  departamento_id INT,
  PRIMARY KEY (empleado_id, departamento_id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id),
  FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
);

CREATE TABLE descuentos (
  descuento_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  porcentaje DECIMAL(5, 2),
  fecha_inicio DATETIME,
  fecha_fin DATETIME
);

CREATE TABLE ventas_descuentos (
  venta_id INT,
  descuento_id INT,
  PRIMARY KEY (venta_id, descuento_id),
  FOREIGN KEY (venta_id) REFERENCES ventas(venta_id),
  FOREIGN KEY (descuento_id) REFERENCES descuentos(descuento_id)
);

-- Inserción de datos en la tabla clientes
INSERT INTO clientes (nombre, apellido, email, telefono, direccion)
VALUES 
  ('Luciano', 'Pérez', 'luciano@ejemplo.com', '123456789', 'Calle 123'),
  ('Mariana', 'González', 'mariana@ejemplo.com', '987654321', 'Calle 456');

-- Inserción de datos en la tabla categorias
INSERT INTO categorias (nombre)
VALUES ('Camisas'), ('Pantalones'), ('Zapatos');

-- Inserción de datos en la tabla productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria_id)
VALUES 
  ('Camisa Básica', 'Camisa de algodón', 25.00, 100, 1),
  ('Pantalón Casual', 'Pantalón de mezclilla', 40.00, 50, 2);

-- Inserción de datos en la tabla proveedores
INSERT INTO proveedores (nombre, contacto, telefono, direccion)
VALUES 
  ('Proveedor A', 'Contacto A', '123123123', 'Av. Principal 1'),
  ('Proveedor B', 'Contacto B', '456456456', 'Av. Secundaria 2');

-- Inserción de datos en la tabla compras
INSERT INTO compras (proveedor_id, fecha, total)
VALUES 
  (1, '2024-10-01', 500.00),
  (2, '2024-10-02', 750.00);

-- Inserción de datos en la tabla detalles_compras
INSERT INTO detalles_compras (compra_id, producto_id, cantidad, precio_unitario)
VALUES 
  (1, 1, 10, 25.00),
  (2, 2, 20, 40.00);

-- Inserción de datos en la tabla ventas
INSERT INTO ventas (cliente_id, fecha, total)
VALUES 
  (1, '2024-10-05', 100.00),
  (2, '2024-10-06', 80.00);

-- Inserción de datos en la tabla detalles_ventas
INSERT INTO detalles_ventas (venta_id, producto_id, cantidad, precio_unitario)
VALUES 
  (1, 1, 2, 25.00),
  (2, 2, 2, 40.00);

-- Reporte de ventas por cliente
SELECT c.nombre, c.apellido, SUM(v.total) AS total_gastado
FROM clientes c
JOIN ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.nombre, c.apellido
ORDER BY total_gastado DESC;

-- Reporte de inventario bajo
SELECT p.nombre, p.stock
FROM productos p
WHERE p.stock < 10;
