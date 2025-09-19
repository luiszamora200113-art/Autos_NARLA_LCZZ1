USE AutosNARLA;
GO

-- Insertar 20 clientes ficticios
INSERT INTO Cliente (Nombres, Apellidos, Telefono, Correo, Direccion) VALUES
('Luis', 'Zamora', '88889999', 'luis.z@example.com', 'Managua'),
('Ana', 'Lopez', '77778888', 'ana.lopez@example.com', 'León'),
('Carlos', 'Perez', '66667777', 'carlos.p@example.com', 'Masaya'),
('Maria', 'Gomez', '55556666', 'maria.g@example.com', 'Chinandega'),
('Jose', 'Martinez', '44445555', 'jose.m@example.com', 'Granada'),
('Karla', 'Hernandez', '33334444', 'karla.h@example.com', 'Estelí'),
('Ricardo', 'Gutierrez', '22223333', 'ricardo.g@example.com', 'Matagalpa'),
('Elena', 'Rivas', '11112222', 'elena.r@example.com', 'Jinotega'),
('Daniel', 'Castillo', '99990000', 'daniel.c@example.com', 'Bluefields'),
('Laura', 'Torres', '88887777', 'laura.t@example.com', 'Managua'),
('Miguel', 'Ortiz', '77776666', 'miguel.o@example.com', 'Masaya'),
('Sofia', 'Fernandez', '66665555', 'sofia.f@example.com', 'León'),
('Andres', 'Diaz', '55554444', 'andres.d@example.com', 'Rivas'),
('Gabriela', 'Morales', '44443333', 'gabriela.m@example.com', 'Carazo'),
('Javier', 'Sanchez', '33332222', 'javier.s@example.com', 'Boaco'),
('Patricia', 'Aguilar', '22221111', 'patricia.a@example.com', 'Chontales'),
('Fernando', 'Navarro', '11110000', 'fernando.n@example.com', 'Nueva Segovia'),
('Lucia', 'Vega', '99998888', 'lucia.v@example.com', 'Madriz'),
('Hugo', 'Cruz', '88887776', 'hugo.c@example.com', 'Managua'),
('Rosa', 'Lopez', '77776665', 'rosa.l@example.com', 'León');

-- Insertar 10 ventas de prueba
-- OJO: aquí debes asegurarte de que los VehicleID usados existan (ej: del 1 al 50)
INSERT INTO Venta (VehicleID, ClienteID, PrecioVenta, DescuentoAplicado) VALUES
(1, 1, 9200.00, 5),
(3, 2, 10000.00, 0),
(5, 3, 14800.00, 2),
(7, 4, 8900.00, 0),
(10, 5, 21500.00, 3),
(12, 6, 18200.00, 0),
(15, 7, 15000.00, 1),
(20, 8, 22000.00, 10),  -- descuento máximo permitido
(25, 9, 14700.00, 0),
(30, 10, 18500.00, 4);
