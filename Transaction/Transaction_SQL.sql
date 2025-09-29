-- Transaction_SQL.sql
USE AutosNARLA;
GO

/**********************************
  1) InsertarVehiculosconFotos
  Inserta vehículo + hasta 6 fotos con validación (máx 4 unidades disponibles por modelo)
***********************************/
IF OBJECT_ID('dbo.InsertarVehiculosconFotos','P') IS NOT NULL
    DROP PROCEDURE dbo.InsertarVehiculosconFotos;
GO

CREATE PROCEDURE dbo.InsertarVehiculosconFotos
    @MarcaID INT,
    @ModeloID INT,
    @Anio INT,
    @AnioProduccion INT = NULL,
    @Chasis VARCHAR(50),
    @Combustible VARCHAR(50) = NULL,
    @Cilindraje INT = NULL,
    @TipoVehiculo VARCHAR(50) = NULL,
    @PrecioAdquisicion DECIMAL(12,2) = NULL,
    @PrecioVenta DECIMAL(12,2) = NULL,
    @Estado VARCHAR(20) = 'Disponible',
    @Foto1 VARCHAR(255) = NULL,
    @Foto2 VARCHAR(255) = NULL,
    @Foto3 VARCHAR(255) = NULL,
    @Foto4 VARCHAR(255) = NULL,
    @Foto5 VARCHAR(255) = NULL,
    @Foto6 VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validación: máximo 4 unidades disponibles por mismo modelo
        DECLARE @cnt INT;
        SELECT @cnt = COUNT(*) FROM Vehiculo WHERE ModeloID = @ModeloID AND Estado = 'Disponible';
        IF @cnt >= 4
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50001, 'Error: ya existen 4 o más unidades de este modelo en venta.', 1;
        END

        -- Insertar vehículo
        INSERT INTO Vehiculo (MarcaID, ModeloID, Anio, AnioProduccion, Chasis, Combustible, Cilindraje, TipoVehiculo, PrecioAdquisicion, PrecioVenta, Estado, FechaRegistro)
        VALUES (@MarcaID, @ModeloID, @Anio, @AnioProduccion, @Chasis, @Combustible, @Cilindraje, @TipoVehiculo, @PrecioAdquisicion, @PrecioVenta, @Estado, SYSUTCDATETIME());

        DECLARE @newVehicleID INT = SCOPE_IDENTITY();

        -- Insertar fotos opcionales
        IF @Foto1 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto1);
        IF @Foto2 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto2);
        IF @Foto3 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto3);
        IF @Foto4 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto4);
        IF @Foto5 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto5);
        IF @Foto6 IS NOT NULL INSERT INTO FotoVehiculo (VehicleID, RutaFoto) VALUES (@newVehicleID, @Foto6);

        COMMIT TRANSACTION;
        SELECT @newVehicleID AS NewVehicleID;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

/**********************************
  2) RegistrarVenta
  Registra venta (insert Venta + update Vehiculo) con validaciones
***********************************/
IF OBJECT_ID('dbo.RegistrarVenta','P') IS NOT NULL
    DROP PROCEDURE dbo.RegistrarVenta;
GO

CREATE PROCEDURE dbo.RegistrarVenta
    @VehicleID INT,
    @ClienteID INT,
    @PrecioVenta DECIMAL(12,2),
    @DescuentoAplicado DECIMAL(5,2) = 0
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1) Validar existencia y estado del vehículo
        DECLARE @estadoActual VARCHAR(20);
        SELECT @estadoActual = Estado FROM Vehiculo WHERE VehicleID = @VehicleID;
        IF @estadoActual IS NULL
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50002, 'Error: el vehículo no existe.', 1;
        END
        IF @estadoActual <> 'Disponible'
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50003, 'Error: vehículo no disponible para venta.', 1;
        END

        -- 2) Validar descuento (máx 10%)
        IF @DescuentoAplicado < 0 OR @DescuentoAplicado > 10
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50004, 'Error: descuento fuera de rango [0,10].', 1;
        END

        -- 3) Insertar venta
        INSERT INTO Venta (VehicleID, ClienteID, FechaVenta, PrecioVenta, DescuentoAplicado)
        VALUES (@VehicleID, @ClienteID, SYSUTCDATETIME(), @PrecioVenta, @DescuentoAplicado);

        -- 4) Actualizar estado del vehículo
        UPDATE Vehiculo SET Estado = 'Vendido' WHERE VehicleID = @VehicleID;

        COMMIT TRANSACTION;
        SELECT SCOPE_IDENTITY() AS NewSaleID;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

/**********************************
  3) EliminarVehiculos
  Elimina vehículo y sus fotos solo si no está vendido
***********************************/
IF OBJECT_ID('dbo.EliminarVehiculos','P') IS NOT NULL
    DROP PROCEDURE dbo.EliminarVehiculos;
GO

CREATE PROCEDURE dbo.EliminarVehiculos
    @VehicleID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @estado VARCHAR(20);
        SELECT @estado = Estado FROM Vehiculo WHERE VehicleID = @VehicleID;
        IF @estado IS NULL
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50005, 'Error: vehículo no existe.', 1;
        END

        IF @estado = 'Vendido'
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50006, 'Error: vehículo vendido. No puede eliminarse.', 1;
        END

        DELETE FROM FotoVehiculo WHERE VehicleID = @VehicleID;
        DELETE FROM Vehiculo WHERE VehicleID = @VehicleID;

        COMMIT TRANSACTION;
        SELECT @VehicleID AS DeletedVehicleID;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO


