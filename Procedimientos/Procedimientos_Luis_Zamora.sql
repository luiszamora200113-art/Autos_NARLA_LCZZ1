-- ============================================
-- PROYECTO AUTOS NARLA
-- PROCEDIMIENTOS Y CONSULTAS - Luis Zamora
-- ============================================

-- TABLA: CLIENTE
-- sp_ListarClientes
-- sp_FiltrarClientePorNombre
-- sp_ActualizarCliente

USE AutosNARLA;
GO


-- 1️ sp_ListarClientes
-- Muestra todos los clientes registrados

IF OBJECT_ID('dbo.sp_ListarClientes','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarClientes;
GO
CREATE PROCEDURE dbo.sp_ListarClientes
AS
BEGIN
    SET NOCOUNT ON;


    SELECT ClienteID, Nombres, Apellidos, Telefono, Correo, Direccion
    FROM dbo.Cliente
    ORDER BY Apellidos, Nombres;
END
GO


 EXEC dbo.sp_ListarClientes;


-- 2️ sp_FiltrarClientePorNombre
-- Busca clientes por nombre o apellido


IF OBJECT_ID('dbo.sp_FiltrarClientePorNombre','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarClientePorNombre;
GO
CREATE PROCEDURE dbo.sp_FiltrarClientePorNombre
    @Busqueda VARCHAR(100)  -- Ejemplo: '%Juan%'
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ClienteID, Nombres, Apellidos, Telefono, Correo, Direccion
    FROM dbo.Cliente
    WHERE Nombres LIKE @Busqueda OR Apellidos LIKE @Busqueda
    ORDER BY Apellidos, Nombres;
END
GO


EXEC dbo.sp_FiltrarClientePorNombre @Busqueda = '%Luis%';


-- 3️ sp_ActualizarClienteContacto
-- Actualiza teléfono, correo o dirección


IF OBJECT_ID('dbo.sp_ActualizarClienteContacto','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarClienteContacto;
GO
CREATE PROCEDURE dbo.sp_ActualizarClienteContacto
    @ClienteID INT,
    @Telefono VARCHAR(20) = NULL,
    @Correo VARCHAR(100) = NULL,
    @Direccion VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que el cliente exista
        IF NOT EXISTS(SELECT 1 FROM dbo.Cliente WHERE ClienteID = @ClienteID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 55001, 'El cliente no existe.', 1;
        END

        -- Actualizar solo los campos que se envían
        UPDATE dbo.Cliente
        SET Telefono = COALESCE(@Telefono, Telefono),
            Correo = COALESCE(@Correo, Correo),
            Direccion = COALESCE(@Direccion, Direccion)
        WHERE ClienteID = @ClienteID;

        COMMIT TRANSACTION;
        SELECT 'Datos de cliente actualizados correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

EXEC dbo.sp_ActualizarClienteContacto
    @ClienteID = 1,
    @Telefono = '555-0001',
    @Correo = 'nuevo_correo@example.com';

    SELECT * FROM Cliente WHERE ClienteID = 1;

-- TABLA: MARCA
-- sp_ListarMarcas
-- sp_FiltrarMarcaPorNombre
-- sp_ActualizarMarcaNombre

USE AutosNARLA;
GO


-- 1️ sp_ListarMarcas
-- Muestra todas las marcas registradas


IF OBJECT_ID('dbo.sp_ListarMarcas','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarMarcas;
GO
CREATE PROCEDURE dbo.sp_ListarMarcas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MarcaID, NombreMarca
    FROM dbo.Marca
    ORDER BY NombreMarca;
END
GO
-- PRUEBAS
EXEC dbo.sp_ListarMarcas;



-- 2️ sp_FiltrarMarcaPorNombre
-- Busca marcas que contengan una palabra


IF OBJECT_ID('dbo.sp_FiltrarMarcaPorNombre','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarMarcaPorNombre;
GO
CREATE PROCEDURE dbo.sp_FiltrarMarcaPorNombre
    @TextoBusqueda VARCHAR(100)  -- Ejemplo: '%Toy%'
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MarcaID, NombreMarca
    FROM dbo.Marca
    WHERE NombreMarca LIKE @TextoBusqueda
    ORDER BY NombreMarca;
END
GO
-- PRUEBAS
EXEC dbo.sp_FiltrarMarcaPorNombre @TextoBusqueda = '%Toy%';


-- 3️ sp_ActualizarMarcaNombre
-- Actualiza el nombre de una marca específica


IF OBJECT_ID('dbo.sp_ActualizarMarcaNombre','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarMarcaNombre;
GO
CREATE PROCEDURE dbo.sp_ActualizarMarcaNombre
    @MarcaID INT,
    @NuevoNombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que la marca exista
        IF NOT EXISTS (SELECT 1 FROM dbo.Marca WHERE MarcaID = @MarcaID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 51001, 'La marca especificada no existe.', 1;
        END

        -- Actualizar nombre
        UPDATE dbo.Marca
        SET NombreMarca = @NuevoNombre
        WHERE MarcaID = @MarcaID;

        COMMIT TRANSACTION;

        SELECT 'Nombre de la marca actualizado correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

-- PRUEBAS
SELECT * FROM Marca;
EXEC dbo.sp_ActualizarMarcaNombre
    @MarcaID = 1,
    @NuevoNombre = 'Toyota Motors';


 SELECT * FROM Marca WHERE MarcaID = 1;

-- TABLA: MODELO
-- sp_ListarModelos
-- sp_FiltrarModeloPorMarca
-- sp_ActualizarModeloNombre

USE AutosNARLA;
GO

-- 1️⃣ sp_ListarModelos
-- Muestra todos los modelos con su marca asociada


IF OBJECT_ID('dbo.sp_ListarModelos','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarModelos;
GO
CREATE PROCEDURE dbo.sp_ListarModelos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT mo.ModeloID,
           mo.NombreModelo,
           ma.MarcaID,
           ma.NombreMarca
    FROM dbo.Modelo mo
    INNER JOIN dbo.Marca ma ON mo.MarcaID = ma.MarcaID
    ORDER BY ma.NombreMarca, mo.NombreModelo;
END
GO

--- PRUEBAS
EXEC dbo.sp_ListarModelos;


-- 2️ sp_FiltrarModeloPorMarca
-- Muestra los modelos pertenecientes a una marca


IF OBJECT_ID('dbo.sp_FiltrarModeloPorMarca','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarModeloPorMarca;
GO
CREATE PROCEDURE dbo.sp_FiltrarModeloPorMarca
    @MarcaID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT mo.ModeloID,
           mo.NombreModelo,
           mo.MarcaID,
           ma.NombreMarca
    FROM dbo.Modelo mo
    INNER JOIN dbo.Marca ma ON mo.MarcaID = ma.MarcaID
    WHERE mo.MarcaID = @MarcaID
    ORDER BY mo.NombreModelo;
END
GO

--PRUEBAS
SELECT * FROM Marca;
EXEC dbo.sp_FiltrarModeloPorMarca @MarcaID = 1;


-- 3️ sp_ActualizarModeloNombre
-- Actualiza el nombre de un modelo existente


IF OBJECT_ID('dbo.sp_ActualizarModeloNombre','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarModeloNombre;
GO
CREATE PROCEDURE dbo.sp_ActualizarModeloNombre
    @ModeloID INT,
    @NuevoNombre VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia
        IF NOT EXISTS (SELECT 1 FROM dbo.Modelo WHERE ModeloID = @ModeloID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 52001, 'El modelo especificado no existe.', 1;
        END

        -- Actualizar nombre
        UPDATE dbo.Modelo
        SET NombreModelo = @NuevoNombre
        WHERE ModeloID = @ModeloID;

        COMMIT TRANSACTION;
        SELECT 'Nombre del modelo actualizado correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

--PRUEBAS
SELECT * FROM Modelo;
EXEC dbo.sp_ActualizarModeloNombre
    @ModeloID = 1,
    @NuevoNombre = 'Corolla XLE';
SELECT * FROM Modelo WHERE ModeloID = 1;

-- TABLA: VEHICULO
-- sp_ListarVehiculos
-- sp_FiltrarVehiculosPorPrecio
-- sp_ActualizarPrecioVehiculo
USE AutosNARLA;
GO

-- Procedimientos para la tabla Vehiculo


-- 1️ PROCEDIMIENTO: sp_ListarVehiculos
-- Muestra todos los vehículos registrados
IF OBJECT_ID('dbo.sp_ListarVehiculos','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarVehiculos;
GO
CREATE PROCEDURE dbo.sp_ListarVehiculos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT v.VehicleID, v.Chasis, ma.NombreMarca, mo.NombreModelo,
           v.Anio, v.Cilindraje, v.TipoVehiculo,
           v.PrecioAdquisicion, v.PrecioVenta, v.Estado, v.FechaRegistro
    FROM dbo.Vehiculo v
    LEFT JOIN dbo.Marca ma ON v.MarcaID = ma.MarcaID
    LEFT JOIN dbo.Modelo mo ON v.ModeloID = mo.ModeloID
    ORDER BY v.FechaRegistro DESC;
END
GO

EXEC dbo.sp_ListarVehiculos;

-- 2️ PROCEDIMIENTO: sp_FiltrarVehiculos
-- Filtra vehículos por parámetros opcionales
IF OBJECT_ID('dbo.sp_FiltrarVehiculos','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarVehiculos;
GO
CREATE PROCEDURE dbo.sp_FiltrarVehiculos
    @MarcaID INT = NULL,
    @ModeloID INT = NULL,
    @Anio INT = NULL,
    @PrecioMin DECIMAL(10,2) = NULL,
    @PrecioMax DECIMAL(10,2) = NULL,
    @Estado VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT v.VehicleID, v.Chasis, ma.NombreMarca, mo.NombreModelo,
           v.Anio, v.PrecioVenta, v.Estado
    FROM dbo.Vehiculo v
    LEFT JOIN dbo.Marca ma ON v.MarcaID = ma.MarcaID
    LEFT JOIN dbo.Modelo mo ON v.ModeloID = mo.ModeloID
    WHERE (@MarcaID IS NULL OR v.MarcaID = @MarcaID)
      AND (@ModeloID IS NULL OR v.ModeloID = @ModeloID)
      AND (@Anio IS NULL OR v.Anio = @Anio)
      AND (@PrecioMin IS NULL OR v.PrecioVenta >= @PrecioMin)
      AND (@PrecioMax IS NULL OR v.PrecioVenta <= @PrecioMax)
      AND (@Estado IS NULL OR v.Estado = @Estado)
    ORDER BY v.PrecioVenta;
END
GO

EXEC dbo.sp_FiltrarVehiculos;
EXEC dbo.sp_FiltrarVehiculos @MarcaID = 1;

-- 3️ PROCEDIMIENTO: sp_ActualizarVehiculoPrecioEstado
-- Actualiza el precio y/o estado del vehículo
IF OBJECT_ID('dbo.sp_ActualizarVehiculoPrecioEstado','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarVehiculoPrecioEstado;
GO
CREATE PROCEDURE dbo.sp_ActualizarVehiculoPrecioEstado
    @VehicleID INT,
    @NuevoPrecioVenta DECIMAL(10,2) = NULL,
    @NuevoEstado VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculo WHERE VehicleID = @VehicleID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 53001, 'Vehículo no existe.', 1;
        END

        UPDATE dbo.Vehiculo
        SET PrecioVenta = COALESCE(@NuevoPrecioVenta, PrecioVenta),
            Estado = COALESCE(@NuevoEstado, Estado)
        WHERE VehicleID = @VehicleID;

        COMMIT TRANSACTION;
        SELECT 'Vehículo actualizado correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

EXEC dbo.sp_ActualizarVehiculoPrecioEstado
    @VehicleID = 1,
    @NuevoPrecioVenta = 15500,
    @NuevoEstado = 'Vendido';

SELECT * FROM Vehiculo WHERE VehicleID = 1;

-- TABLA: FOTOVEHICULO
-- sp_ListarFotosPorVehiculo
-- sp_FiltrarFotoPorID
-- sp_ActualizarRutaFoto
USE AutosNARLA;
GO


-- 1️ sp_ListarFotosPorVehiculo
-- Lista todas las fotos asociadas a un vehículo


IF OBJECT_ID('dbo.sp_ListarFotosPorVehiculo','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarFotosPorVehiculo;
GO
CREATE PROCEDURE dbo.sp_ListarFotosPorVehiculo
    @VehicleID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT FotoID,
           VehicleID,
           RutaFoto
    FROM dbo.FotoVehiculo
    WHERE VehicleID = @VehicleID
    ORDER BY FotoID;
END
GO

--PRUEBAS
SELECT TOP 5 * FROM Vehiculo;
EXEC dbo.sp_ListarFotosPorVehiculo @VehicleID = 1;


-- 2️ sp_FiltrarFotoPorID
-- Muestra una foto específica por su ID


IF OBJECT_ID('dbo.sp_FiltrarFotoPorID','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarFotoPorID;
GO
CREATE PROCEDURE dbo.sp_FiltrarFotoPorID
    @FotoID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT FotoID,
           VehicleID,
           RutaFoto
    FROM dbo.FotoVehiculo
    WHERE FotoID = @FotoID;
END
GO

--PRUEBAS
SELECT TOP 5 * FROM FotoVehiculo;
EXEC dbo.sp_FiltrarFotoPorID @FotoID = 1;


-- 3️⃣ sp_ActualizarRutaFoto
-- Actualiza la ruta de una foto existente


IF OBJECT_ID('dbo.sp_ActualizarRutaFoto','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarRutaFoto;
GO
CREATE PROCEDURE dbo.sp_ActualizarRutaFoto
    @FotoID INT,
    @NuevaRuta VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar si la foto existe
        IF NOT EXISTS (SELECT 1 FROM dbo.FotoVehiculo WHERE FotoID = @FotoID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 54001, 'La foto especificada no existe.', 1;
        END

        -- Actualizar ruta
        UPDATE dbo.FotoVehiculo
        SET RutaFoto = @NuevaRuta
        WHERE FotoID = @FotoID;

        COMMIT TRANSACTION;

        SELECT 'Ruta de la foto actualizada correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

--- PRUEBAS
SELECT * FROM FotoVehiculo;
EXEC dbo.sp_ActualizarRutaFoto
    @FotoID = 1,
    @NuevaRuta = 'C:\imagenes\vehiculos\toyota_corolla_frontal.jpg'; -- SOLO COMO EJEMPLO. 
    SELECT * FROM FotoVehiculo WHERE FotoID = 1;

-- TABLA: VENTA
-- sp_ListarVentas
-- sp_FiltrarVentas
-- sp_ActualizarVenta

USE AutosNARLA;
GO

-- 1️⃣ sp_ListarVentas
-- Muestra todas las ventas realizadas con detalle


IF OBJECT_ID('dbo.sp_ListarVentas','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarVentas;
GO
CREATE PROCEDURE dbo.sp_ListarVentas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT v.VentaID,
           v.VehicleID,
           ve.Chasis,
           ma.NombreMarca,
           mo.NombreModelo,
           c.ClienteID,
           CONCAT(c.Nombres, ' ', c.Apellidos) AS Cliente,
           v.FechaVenta,
           v.PrecioVenta,
           v.DescuentoAplicado,
           v.PrecioVenta * (1 - ISNULL(v.DescuentoAplicado,0)/100.0) AS PrecioFinal
    FROM dbo.Venta v
    INNER JOIN dbo.Vehiculo ve ON v.VehicleID = ve.VehicleID
    INNER JOIN dbo.Marca ma ON ve.MarcaID = ma.MarcaID
    INNER JOIN dbo.Modelo mo ON ve.ModeloID = mo.ModeloID
    INNER JOIN dbo.Cliente c ON v.ClienteID = c.ClienteID
    ORDER BY v.FechaVenta DESC;
END
GO

-- PRUEBAS

EXEC dbo.sp_ListarVentas;



-- 2️ sp_FiltrarVentas
-- Filtra ventas por cliente y/o rango de fechas


IF OBJECT_ID('dbo.sp_FiltrarVentas','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_FiltrarVentas;
GO
CREATE PROCEDURE dbo.sp_FiltrarVentas
    @ClienteID INT = NULL,
    @FechaDesde DATE = NULL,
    @FechaHasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT v.VentaID,
           v.VehicleID,
           ve.Chasis,
           CONCAT(c.Nombres, ' ', c.Apellidos) AS Cliente,
           v.FechaVenta,
           v.PrecioVenta,
           v.DescuentoAplicado,
           v.PrecioVenta * (1 - ISNULL(v.DescuentoAplicado,0)/100.0) AS PrecioFinal
    FROM dbo.Venta v
    INNER JOIN dbo.Vehiculo ve ON v.VehicleID = ve.VehicleID
    INNER JOIN dbo.Cliente c ON v.ClienteID = c.ClienteID
    WHERE (@ClienteID IS NULL OR v.ClienteID = @ClienteID)
      AND (@FechaDesde IS NULL OR v.FechaVenta >= @FechaDesde)
      AND (@FechaHasta IS NULL OR v.FechaVenta <= @FechaHasta)
    ORDER BY v.FechaVenta DESC;
END
GO

-- PRUEBAS
EXEC dbo.sp_FiltrarVentas @ClienteID = 1;
EXEC dbo.sp_FiltrarVentas @FechaDesde = '2024-01-01', @FechaHasta = '2025-12-31';
EXEC dbo.sp_FiltrarVentas;



-- 3️ sp_ActualizarVenta
-- Actualiza el precio o descuento de una venta


IF OBJECT_ID('dbo.sp_ActualizarVenta','P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ActualizarVenta;
GO
CREATE PROCEDURE dbo.sp_ActualizarVenta
    @VentaID INT,
    @NuevoPrecio DECIMAL(10,2) = NULL,
    @NuevoDescuento DECIMAL(5,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia
        IF NOT EXISTS (SELECT 1 FROM dbo.Venta WHERE VentaID = @VentaID)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 56001, 'La venta especificada no existe.', 1;
        END

        -- Validar descuento máximo (por ejemplo, 10%)
        IF @NuevoDescuento IS NOT NULL AND @NuevoDescuento > 10
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 56002, 'El descuento no puede superar el 10%.', 1;
        END

        -- Actualizar solo los campos enviados
        UPDATE dbo.Venta
        SET PrecioVenta = COALESCE(@NuevoPrecio, PrecioVenta),
            DescuentoAplicado = COALESCE(@NuevoDescuento, DescuentoAplicado)
        WHERE VentaID = @VentaID;

        COMMIT TRANSACTION;

        SELECT 'Venta actualizada correctamente' AS Resultado;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO


-- PRUEBAS
SELECT TOP 5 * FROM Venta;
EXEC dbo.sp_ActualizarVenta
    @VentaID = 1,
    @NuevoPrecio = 9800.00,
    @NuevoDescuento = 5;

SELECT * FROM Venta WHERE VentaID = 1;

-- CONSULTAS CON FUNCIONES AGREGADAS
-- (COUNT, SUM, AVG, MAX, MIN)


-- 1️ Total de ventas registradas


SELECT COUNT(*) AS TotalVentas
FROM dbo.Venta;


-- 2️ Total de ingresos generados (ya con descuento)


SELECT 
    SUM(PrecioVenta * (1 - ISNULL(DescuentoAplicado,0)/100.0)) AS IngresoTotal
FROM dbo.Venta;


-- 3️ Promedio de precio de venta


SELECT 
    AVG(PrecioVenta) AS PromedioPrecioVenta
FROM dbo.Venta;


-- 4️ Precio máximo y mínimo de venta


SELECT 
    MAX(PrecioVenta) AS PrecioMasAlto,
    MIN(PrecioVenta) AS PrecioMasBajo
FROM dbo.Venta;


-- 5️ Ventas totales agrupadas por marca


SELECT 
    ma.NombreMarca,
    COUNT(v.VentaID) AS CantidadVentas,
    SUM(v.PrecioVenta * (1 - ISNULL(v.DescuentoAplicado,0)/100.0)) AS TotalRecaudado
FROM dbo.Venta v
INNER JOIN dbo.Vehiculo ve ON v.VehicleID = ve.VehicleID
INNER JOIN dbo.Marca ma ON ve.MarcaID = ma.MarcaID
GROUP BY ma.NombreMarca
ORDER BY TotalRecaudado DESC;


-- 6️ Ventas agrupadas por cliente

SELECT 
    CONCAT(c.Nombres, ' ', c.Apellidos) AS Cliente,
    COUNT(v.VentaID) AS ComprasRealizadas,
    SUM(v.PrecioVenta * (1 - ISNULL(v.DescuentoAplicado,0)/100.0)) AS TotalGastado
FROM dbo.Venta v
INNER JOIN dbo.Cliente c ON v.ClienteID = c.ClienteID
GROUP BY c.Nombres, c.Apellidos
ORDER BY TotalGastado DESC;

