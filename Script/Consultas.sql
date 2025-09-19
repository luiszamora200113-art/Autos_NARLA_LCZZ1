select * from Vehiculo;

select COUNT(*) as TotalClientes from Cliente;

select COUNT(*) as TotalVentas from Venta;


select v.VentaID, c.Nombres, c.Apellidos, ve.Chasis, v.PrecioVenta, v.DescuentoAplicado
from Venta v
JOIN Cliente c on v.ClienteID = c.ClienteID
JOIN Vehiculo ve on v.VehicleID = ve.VehicleID;

select top 5 v.VehicleID, m.NombreMarca, mo.NombreModelo, v.Anio, v.PrecioVenta
from Vehiculo v
JOIN Marca m on v.MarcaID = m.MarcaID
JOIN Modelo mo on v.ModeloID = mo.ModeloID;

