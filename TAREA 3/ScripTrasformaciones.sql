USE StaginJardineria
GO

SELECT [Id_Categoria]
      ,[Desc_Categoria]
      ,[descripcion_texto]
      ,[descripcion_html]
      ,[imagen]
  FROM [dbo].[Categoria_producto]

GO



	--Codigo trasformacion de producto
	SELECT [ID_producto],
	   [codigoBarras],
       UPPER([nombre]) AS [nombre],
       [Categoria],
       [dimensiones],
       UPPER([proveedor]) AS [proveedor],
       UPPER([descripcion]) AS [descripcion],
       [cantidad_en_stock],
       [precio_venta],
       [precio_proveedor],
       ([precio_venta] - [precio_proveedor]) AS [utilidad]
FROM [dbo].[DestinoProducto_ST];

--codigo de trasformacion de cliente

	SELECT 
    UPPER([ID_cliente]) AS [ID_cliente],
    UPPER([nombre_cliente]) AS [nombre_cliente],
    UPPER(CONCAT([nombre_contacto], ' ', [apellido_contacto])) AS [nombre_apellido_contacto],
    UPPER([telefono]) AS [telefono],
    UPPER([Direccion]) AS [direccion],
    UPPER([limite_credito]) AS [limite_credito]
FROM 
    [StaginJardineria].[dbo].[DestinoCliente_ST];

	--codigo trasformcion empleado
	SELECT 
    [id_empleado],
    UPPER([nombre]) AS [nombre],
    UPPER(CONCAT([apellido1], ' ', [apellido2])) AS [apellidos],
    UPPER([descripcion_oficina]) AS [descripcion_oficina],
    [ID_jefe],
    UPPER([puesto]) AS [puesto]
FROM 
    [dbo].[DestinoEmpleado_ST];


	--codigo trasformacino de region
	  SELECT 
	 [ciudad]As[Codigo_Ciudad],
    UPPER(CONCAT([ciudad_0], ', ', [pais])) AS [ciudad_pais],
    UPPER([region]) AS [region]
FROM 
    [StaginJardineria].[dbo].[DestinoRegion_ST];


	--condigo de trasformacion de venta
	
SELECT 
    [Secuencia],
    [ID_Pedido],
    CASE 
        WHEN dv.[Fecha_Venta] IS NULL THEN 'VENTA NO CONCRETADA'
        ELSE CONVERT(varchar, dv.[Fecha_Venta], 103)
    END AS [Fecha_Venta],
    ISNULL(dc.[nombre_cliente], '') AS [Nombre_Cliente],
    ISNULL(dp.[nombre], '') AS [Nombre_Producto],
    ISNULL(CONCAT(de.[nombre], ' ', de.[apellidos]), '') AS [Nombre_Empleado],
    [Cantidad_Vendida],
    [Precio_Unitario],
    dv.[ID_Empleado], -- Especificamos de qué tabla proviene 'ID_Empleado'
    [Cantidad_Vendida] * [Precio_Unitario] AS [Subtotal],
    CASE 
        WHEN dv.[Fecha_Venta] IS NULL THEN NULL
        ELSE SUM([Cantidad_Vendida] * [Precio_Unitario]) OVER (PARTITION BY [ID_Pedido]) 
    END AS [Total]
FROM 
    [StaginJardineria].[dbo].[DestinoVenta_ST] dv
LEFT JOIN 
    [dbo].[DimCliente] dc ON dv.[ID_Cliente] = dc.[ID_cliente]
LEFT JOIN 
    [dbo].[DimProducto] dp ON dv.[ID_Producto] = dp.[ID_producto]
LEFT JOIN 
    [dbo].[DimEmpleado] de ON dv.[ID_Empleado] = de.[id_empleado];
