--CONSULTAS DEL INCISO 1 AL 11-- 
--1. Mostrar a los usuarios la lista de todos los vehiculos que se encuentran en STOCK--

select V.VehicleID, M.NombreMarca, MO.NombreModelo, V.Anio, V.Cilindraje, V.TipoVehiculo, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where V.Estado = 'Disponible';

--2. Obtener informacion detallada de un vehiculo al proporcionar su codigo

select V.*, M.NombreMarca, MO.NombreModelo
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where V.VehicleID = VehicleID

--3 Ingresar nuevos vehiculos para venta. 

INSERT INTO Vehiculo (MarcaID, ModeloID, Anio, AnioProduccion, Chasis, Combustible, Cilindraje, 
TipoVehiculo, PrecioAdquisicion, PrecioVenta)
VALUES (1, 1, 2022, 2021, 'CHS1234567890', 'Gasolina', 2000, 'Sedán', 15000.00, 18000.00);

select * from Vehiculo;

--4. Consultar el inventario ordendado por modelo, marca o año 

-- 3.1 Por modelo 
select V.VehicleID, MO.NombreModelo, M.NombreMarca, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
order by MO.NombreModelo;

-- 3.2 por marca 
select V.VehicleID, MO.NombreModelo, M.NombreMarca, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
order by M.NombreMarca;

-- 3.3 por año 

select V.VehicleID, MO.NombreModelo, M.NombreMarca, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
order by V.Anio;

--5. Filtro de busqueda por modelo y año.
select V.VehicleID, M.NombreMarca, MO.NombreModelo, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where MO.NombreModelo = NombreModelo and V.Anio = Anio

--6. Filtro de busqueda por rango de precio y categoria 
select V.VehicleID, M.NombreMarca, MO.NombreModelo, V.TipoVehiculo, V.PrecioVenta
from Vehiculo V
JOIN Marca M ON V.MarcaID = M.MarcaID
JOIN Modelo MO ON V.ModeloID = MO.ModeloID
WHERE V.PrecioVenta BETWEEN PrecioAdquisicion AND PrecioVenta
  AND V.TipoVehiculo = TipoVehiculo;

  --7 Dar de baja un vehiculo al venderse y reflajarlo en ingresos
  -- Registrar la venta
insert into Venta (VehicleID, ClienteID, PrecioVenta, DescuentoAplicado)
VALUES (VehicleID, ClienteID, PrecioVenta, Descuento);

-- Cambiar estado del vehículo
UPDATE Vehiculo
SET Estado = 'Vendido'
WHERE VehicleID = VehicleID

--8. Aplicar un % de descuento maximo 10 sobre el precio de la venta
UPDATE Vehiculo
SET PrecioVenta = PrecioVenta - (PrecioVenta * @Descuento / 100.0)
WHERE VehicleID = VehicleID AND Descuento <= 10;

--9. Vehiculo mas antiguo en STOCK
select top 1 V.VehicleID, M.NombreMarca, MO.NombreModelo, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where V.Estado = 'Disponible'
order by V.Anio asc;

-- 10. Vehiculo con mayor cilindraje
select top 1 V.VehicleID, M.NombreMarca, MO.NombreModelo, V.Cilindraje, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where V.Estado = 'Disponible'
order BY V.Cilindraje desc;

-- 11. Vehiculo con el precio mas bajo 
select top 1 V.VehicleID, M.NombreMarca, MO.NombreModelo, V.Anio, V.PrecioVenta
from Vehiculo V
JOIN Marca M on V.MarcaID = M.MarcaID
JOIN Modelo MO on V.ModeloID = MO.ModeloID
where V.Estado = 'Disponible'
order by V.PrecioVenta asc;

