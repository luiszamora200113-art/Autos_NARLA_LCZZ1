using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AutosNARLA_MVC.Controllers
{
    public class VentaController
    {
        //  Registrar una nueva venta
        public void RegistrarVenta(int clienteId, Venta venta)
        {
            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                SqlTransaction transaccion = conexion.BeginTransaction();

                try
                {
                    // 1️ Insertar venta en la tabla Venta
                    string queryVenta = @"INSERT INTO Venta 
                        (VehicleID, ClienteID, FechaVenta, PrecioVenta, DescuentoAplicado)
                        VALUES (@VehicleID, @ClienteID, @FechaVenta, @PrecioVenta, @DescuentoAplicado)";

                    SqlCommand cmdVenta = new SqlCommand(queryVenta, conexion, transaccion);
                    cmdVenta.Parameters.AddWithValue("@VehicleID", venta.VehicleID);
                    cmdVenta.Parameters.AddWithValue("@ClienteID", venta.ClienteID);
                    cmdVenta.Parameters.AddWithValue("@FechaVenta", venta.FechaVenta);
                    cmdVenta.Parameters.AddWithValue("@PrecioVenta", venta.PrecioVenta);
                    cmdVenta.Parameters.AddWithValue("@DescuentoAplicado", venta.DescuentoAplicado);
                    cmdVenta.ExecuteNonQuery();

                    // 2️ Cambiar estado del vehículo a "Vendido"
                    string queryVehiculo = @"UPDATE Vehiculo SET Estado = 'Vendido' WHERE VehicleID = @VehicleID";
                    SqlCommand cmdVehiculo = new SqlCommand(queryVehiculo, conexion, transaccion);
                    cmdVehiculo.Parameters.AddWithValue("@VehicleID", venta.VehicleID);
                    cmdVehiculo.ExecuteNonQuery();

                    // 3️ Confirmar transacción
                    transaccion.Commit();
                }
                catch (Exception ex)
                {
                    transaccion.Rollback();
                    throw new Exception("Error al registrar la venta: " + ex.Message);
                }
            }
        }

        //  Listar todas las ventas
        public List<Venta> ListarVentas()
        {
            List<Venta> ventas = new List<Venta>();

            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"SELECT v.VentaID, v.VehicleID, v.ClienteID, v.FechaVenta, 
                                 v.PrecioVenta, v.DescuentoAplicado
                                 FROM Venta v
                                 ORDER BY v.FechaVenta DESC";

                SqlCommand cmd = new SqlCommand(query, conexion);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ventas.Add(new Venta
                    {
                        VentaID = (int)reader["VentaID"],
                        VehicleID = (int)reader["VehicleID"],
                        ClienteID = (int)reader["ClienteID"],
                        FechaVenta = Convert.ToDateTime(reader["FechaVenta"]),
                        PrecioVenta = Convert.ToDecimal(reader["PrecioVenta"]),
                        DescuentoAplicado = Convert.ToDecimal(reader["DescuentoAplicado"])
                    });
                }

                reader.Close();
            }

            return ventas;
        }

        //  Buscar venta por ID
        public Venta BuscarVentaPorID(int ventaId)
        {
            Venta venta = null;

            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"SELECT * FROM Venta WHERE VentaID = @VentaID";
                SqlCommand cmd = new SqlCommand(query, conexion);
                cmd.Parameters.AddWithValue("@VentaID", ventaId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    venta = new Venta
                    {
                        VentaID = (int)reader["VentaID"],
                        VehicleID = (int)reader["VehicleID"],
                        ClienteID = (int)reader["ClienteID"],
                        FechaVenta = Convert.ToDateTime(reader["FechaVenta"]),
                        PrecioVenta = Convert.ToDecimal(reader["PrecioVenta"]),
                        DescuentoAplicado = Convert.ToDecimal(reader["DescuentoAplicado"])
                    };
                }

                reader.Close();
            }

            return venta;
        }

        //  Aplicar descuento (máx. 10%)
        public void AplicarDescuento(int ventaId, decimal nuevoDescuento)
        {
            if (nuevoDescuento > 10)
                throw new Exception("El descuento no puede superar el 10%.");

            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"UPDATE Venta 
                                 SET DescuentoAplicado = @Descuento
                                 WHERE VentaID = @VentaID";

                SqlCommand cmd = new SqlCommand(query, conexion);
                cmd.Parameters.AddWithValue("@Descuento", nuevoDescuento);
                cmd.Parameters.AddWithValue("@VentaID", ventaId);
                cmd.ExecuteNonQuery();
            }
        }

        internal bool RegistrarVenta(int clienteId, int vehiculoId, decimal precio, decimal descuento)
        {
            throw new NotImplementedException();
        }
    }  // fin de la clase
}      // fin del namespace


