USE AutosNARLA;
GO

-- Insertar marcas
INSERT INTO Marca (NombreMarca) VALUES
('Toyota'), ('Honda'), ('Ford'), ('Nissan'), ('Chevrolet');

-- Insertar modelos
INSERT INTO Modelo (MarcaID, NombreModelo) VALUES
(1, 'Corolla'),
(1, 'Hilux'),
(2, 'Civic'),
(2, 'CR-V'),
(3, 'F-150'),
(3, 'Mustang'),
(4, 'Sentra'),
(4, 'Navara'),
(5, 'Aveo'),
(5, 'Silverado');

-- Insertar clientes
INSERT INTO Cliente (Nombres, Apellidos, Telefono, Correo, Direccion) VALUES
('Luis', 'Zamora', '88889999', 'luis@example.com', 'Managua'),
('Ana', 'Lopez', '77778888', 'ana@example.com', 'León'),
('Carlos', 'Perez', '66667777', 'carlos@example.com', 'Masaya'),
('Maria', 'Gomez', '55556666', 'maria@example.com', 'Chinandega'),
('Jose', 'Martinez', '44445555', 'jose@example.com', 'Granada');

USE AutosNARLA;
GO

-- Insertar 50 vehículos de prueba
INSERT INTO Vehiculo (MarcaID, ModeloID, Anio, AnioProduccion, Chasis, Combustible, Cilindraje, TipoVehiculo, PrecioAdquisicion, PrecioVenta, Estado)
VALUES
(1, 1, 2018, 2017, 'JT87345198210001', 'Gasolina', 1800, 'Sedan', 7200.00, 9500.00, 'Disponible'),
(1, 2, 2019, 2018, 'JT87345198210002', 'Diesel', 3000, 'Camioneta', 15800.00, 18900.00, 'Disponible'),
(2, 3, 2020, 2019, 'HN45239847120003', 'Gasolina', 1600, 'Sedan', 8100.00, 10400.00, 'Disponible'),
(2, 4, 2021, 2020, 'HN45239847120004', 'Gasolina', 2400, 'SUV', 16200.00, 20000.00, 'Disponible'),
(3, 5, 2017, 2016, 'FD76123987452005', 'Gasolina', 5000, 'Camioneta', 12100.00, 15000.00, 'Disponible'),
(3, 6, 2019, 2019, 'FD76123987452006', 'Gasolina', 5000, 'Deportivo', 20500.00, 26200.00, 'Disponible'),
(4, 7, 2018, 2017, 'NS98123764582007', 'Gasolina', 1800, 'Sedan', 6900.00, 9100.00, 'Disponible'),
(4, 8, 2020, 2019, 'NS98123764582008', 'Diesel', 2800, 'Camioneta', 14100.00, 17600.00, 'Disponible'),
(5, 9, 2019, 2018, 'CH19283746552009', 'Gasolina', 1600, 'Sedan', 6400.00, 8500.00, 'Disponible'),
(5, 10, 2021, 2020, 'CH19283746552010', 'Gasolina', 4500, 'Camioneta', 18200.00, 22100.00, 'Disponible'),
(1, 1, 2020, 2019, 'JT12345678910111', 'Gasolina', 1800, 'Sedan', 7300.00, 9600.00, 'Disponible'),
(1, 2, 2019, 2019, 'JT12345678910112', 'Diesel', 2700, 'Camioneta', 14900.00, 18400.00, 'Disponible'),
(2, 3, 2018, 2017, 'HN12345678910113', 'Gasolina', 1600, 'Sedan', 7900.00, 10300.00, 'Disponible'),
(2, 4, 2021, 2020, 'HN12345678910114', 'Gasolina', 2200, 'SUV', 15900.00, 19800.00, 'Disponible'),
(3, 5, 2017, 2016, 'FD12345678910115', 'Gasolina', 5200, 'Camioneta', 12300.00, 15100.00, 'Disponible'),
(3, 6, 2020, 2019, 'FD12345678910116', 'Gasolina', 5100, 'Deportivo', 20800.00, 26300.00, 'Disponible'),
(4, 7, 2018, 2018, 'NS12345678910117', 'Gasolina', 1900, 'Sedan', 7000.00, 9200.00, 'Disponible'),
(4, 8, 2020, 2019, 'NS12345678910118', 'Diesel', 2800, 'Camioneta', 14300.00, 17800.00, 'Disponible'),
(5, 9, 2019, 2018, 'CH12345678910119', 'Gasolina', 1700, 'Sedan', 6600.00, 8600.00, 'Disponible'),
(5, 10, 2021, 2020, 'CH12345678910120', 'Gasolina', 4400, 'Camioneta', 18400.00, 22200.00, 'Disponible'),
(1, 1, 2017, 2016, 'JT22345678910121', 'Gasolina', 1800, 'Sedan', 7100.00, 9400.00, 'Disponible'),
(1, 2, 2020, 2019, 'JT22345678910122', 'Diesel', 2900, 'Camioneta', 15300.00, 18600.00, 'Disponible'),
(2, 3, 2019, 2018, 'HN22345678910123', 'Gasolina', 1600, 'Sedan', 8200.00, 10600.00, 'Disponible'),
(2, 4, 2021, 2020, 'HN22345678910124', 'Gasolina', 2400, 'SUV', 16500.00, 20200.00, 'Disponible'),
(3, 5, 2016, 2015, 'FD22345678910125', 'Gasolina', 4900, 'Camioneta', 11900.00, 14800.00, 'Disponible'),
(3, 6, 2018, 2017, 'FD22345678910126', 'Gasolina', 5000, 'Deportivo', 20200.00, 25900.00, 'Disponible'),
(4, 7, 2017, 2016, 'NS22345678910127', 'Gasolina', 1800, 'Sedan', 6800.00, 9000.00, 'Disponible'),
(4, 8, 2020, 2019, 'NS22345678910128', 'Diesel', 2900, 'Camioneta', 14600.00, 17900.00, 'Disponible'),
(5, 9, 2018, 2017, 'CH22345678910129', 'Gasolina', 1600, 'Sedan', 6700.00, 8700.00, 'Disponible'),
(5, 10, 2021, 2020, 'CH22345678910130', 'Gasolina', 4300, 'Camioneta', 18100.00, 22000.00, 'Disponible'),
(1, 1, 2019, 2018, 'JT32345678910131', 'Gasolina', 1800, 'Sedan', 7500.00, 9700.00, 'Disponible'),
(1, 2, 2020, 2019, 'JT32345678910132', 'Diesel', 2800, 'Camioneta', 15500.00, 18700.00, 'Disponible'),
(2, 3, 2021, 2020, 'HN32345678910133', 'Gasolina', 1600, 'Sedan', 8300.00, 10700.00, 'Disponible'),
(2, 4, 2021, 2020, 'HN32345678910134', 'Gasolina', 2500, 'SUV', 16800.00, 20500.00, 'Disponible'),
(3, 5, 2017, 2016, 'FD32345678910135', 'Gasolina', 5100, 'Camioneta', 12200.00, 15000.00, 'Disponible'),
(3, 6, 2019, 2018, 'FD32345678910136', 'Gasolina', 5200, 'Deportivo', 21000.00, 26500.00, 'Disponible'),
(4, 7, 2018, 2017, 'NS32345678910137', 'Gasolina', 1900, 'Sedan', 7100.00, 9300.00, 'Disponible'),
(4, 8, 2019, 2018, 'NS32345678910138', 'Diesel', 2700, 'Camioneta', 14400.00, 17700.00, 'Disponible'),
(5, 9, 2019, 2018, 'CH32345678910139', 'Gasolina', 1700, 'Sedan', 6800.00, 8800.00, 'Disponible'),
(5, 10, 2020, 2019, 'CH32345678910140', 'Gasolina', 4200, 'Camioneta', 18300.00, 22100.00, 'Disponible'),
(1, 1, 2020, 2019, 'JT42345678910141', 'Gasolina', 1800, 'Sedan', 7600.00, 9800.00, 'Disponible'),
(1, 2, 2019, 2018, 'JT42345678910142', 'Diesel', 3000, 'Camioneta', 15700.00, 18800.00, 'Disponible'),
(2, 3, 2021, 2020, 'HN42345678910143', 'Gasolina', 1600, 'Sedan', 8400.00, 10800.00, 'Disponible'),
(2, 4, 2021, 2020, 'HN42345678910144', 'Gasolina', 2300, 'SUV', 17000.00, 20600.00, 'Disponible'),
(3, 5, 2018, 2017, 'FD42345678910145', 'Gasolina', 5000, 'Camioneta', 12400.00, 15200.00, 'Disponible'),
(3, 6, 2019, 2019, 'FD42345678910146', 'Gasolina', 5100, 'Deportivo', 21200.00, 26600.00, 'Disponible'),
(4, 7, 2017, 2016, 'NS42345678910147', 'Gasolina', 1800, 'Sedan', 6900.00, 9100.00, 'Disponible'),
(4, 8, 2020, 2019, 'NS42345678910148', 'Diesel', 2900, 'Camioneta', 14500.00, 17800.00, 'Disponible'),
(5, 9, 2019, 2018, 'CH42345678910149', 'Gasolina', 1600, 'Sedan', 6900.00, 8900.00, 'Disponible'),
(5, 10, 2021, 2020, 'CH42345678910150', 'Gasolina', 4100, 'Camioneta', 18500.00, 22300.00, 'Disponible');


-- Insertar ventas (ejemplo de 2)
INSERT INTO Venta (VehicleID, ClienteID, PrecioVenta, DescuentoAplicado)
VALUES
(1, 1, 9200.00, 5),
(3, 2, 10000.00, 0);
