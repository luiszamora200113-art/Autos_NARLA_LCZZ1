USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'AutosNARLA')
BEGIN
    ALTER DATABASE AutosNARLA SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AutosNARLA;
END
GO

CREATE DATABASE AutosNARLA;
GO

USE AutosNARLA;
GO


-- Tabla Marca
CREATE TABLE Marca (
    MarcaID INT IDENTITY(1,1) PRIMARY KEY,
    NombreMarca VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla Modelo
CREATE TABLE Modelo (
    ModeloID INT IDENTITY(1,1) PRIMARY KEY,
    MarcaID INT NOT NULL,
    NombreModelo VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Modelo_Marca FOREIGN KEY (MarcaID) REFERENCES Marca(MarcaID)
);

-- Tabla Vehiculo
CREATE TABLE Vehiculo (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    MarcaID INT NOT NULL,
    ModeloID INT NOT NULL,
    Anio INT NOT NULL,
    AnioProduccion INT,
    Chasis VARCHAR(20) NOT NULL UNIQUE,  -- VIN o número de chasis
    Combustible VARCHAR(20),
    Cilindraje INT,
    TipoVehiculo VARCHAR(50),
    PrecioAdquisicion DECIMAL(10,2),
    PrecioVenta DECIMAL(10,2),
    Estado VARCHAR(20) DEFAULT 'Disponible',
    FechaRegistro DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Vehiculo_Marca FOREIGN KEY (MarcaID) REFERENCES Marca(MarcaID),
    CONSTRAINT FK_Vehiculo_Modelo FOREIGN KEY (ModeloID) REFERENCES Modelo(ModeloID),
    CONSTRAINT CK_Vehiculo_Estado CHECK (Estado IN ('Disponible','Vendido'))
);

-- Tabla FotoVehiculo
CREATE TABLE FotoVehiculo (
    FotoID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    RutaFoto VARCHAR(255),
    CONSTRAINT FK_FotoVehiculo_Vehiculo FOREIGN KEY (VehicleID) REFERENCES Vehiculo(VehicleID)
);

-- Tabla Cliente
CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100),
    Apellidos VARCHAR(100),
    Telefono VARCHAR(20),
    Correo VARCHAR(100),
    Direccion VARCHAR(255)
);

-- Tabla Venta
CREATE TABLE Venta (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    ClienteID INT NOT NULL,
    FechaVenta DATETIME DEFAULT GETDATE(),
    PrecioVenta DECIMAL(10,2),
    DescuentoAplicado DECIMAL(4,2),
    CONSTRAINT FK_Venta_Vehiculo FOREIGN KEY (VehicleID) REFERENCES Vehiculo(VehicleID),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    CONSTRAINT CK_Venta_Descuento CHECK (DescuentoAplicado <= 10)
);