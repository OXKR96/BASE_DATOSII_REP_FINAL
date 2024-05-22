Consultas para la Extracción de Registros desde la Base de Datos Jardinería a la Base de Datos Staging:


-- Extracción de datos de la tabla Empleado
SELECT id_empleado,nombre, apellido1, apellido2, ID_oficina, ID_jefe, puesto
FROM empleado;
--actualizamos la estracion de Empleado
SELECT 
    e.id_empleado,
    e.nombre,
    e.apellido1,
    e.apellido2,
    o.descripcion AS descripcion_oficina,
    e.ID_jefe,
    e.puesto
FROM 
    empleado e
JOIN 
    oficina o ON e.ID_oficina = o.id_oficina;


-- Extracción de datos de la tabla Cliente
SELECT id_cliente,nombre_cliente, nombre_contacto, apellido_contacto, telefono, linea_direccion1 as Direccion,  codigo_postal, limite_credito
FROM cliente;



-- Extracción de datos de la tabla Producto
SELECT ID_producto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor
FROM producto;

--actualizamos la extracion de producto donde metimos tambien que añada el mobre de la categoria y no el id SELECT 

SELECT 
    p.[ID_producto],
    p.[CodigoProducto] AS[CodigoBarras],
    p.[nombre],
    c.[Desc_Categoria] AS [Categoria],
    p.[dimensiones],
    p.[proveedor],
    p.[descripcion],
    p.[cantidad_en_stock],
    p.[precio_venta],
    p.[precio_proveedor]
FROM 
    [jardineria].[dbo].[producto] p
JOIN 
    [dbo].[Categoria_producto] c
ON 
    p.[Categoria] = c.[Id_Categoria];


--Extraccion de datos tabla tiempo
select id_tiempo, Anio,Mes,Dia,Dia_Semana
from tiempo;



--Extracion de datos tabal ventas
SELECT ID_venta,Fecha_Venta,ID_Cliente,ID_Producto,Cantidad_Vendida,Precio_Unitario,ID_Empleado
FROM Ventas;



