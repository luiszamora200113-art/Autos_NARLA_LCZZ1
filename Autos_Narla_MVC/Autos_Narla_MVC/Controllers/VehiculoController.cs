using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AutosNARLA_MVC.Controllers
{
    namespace AutosNARLA_MVC.Controllers
    {
        public class VehiculoController
        {

            // Método BuscarVehiculo()
            public List<Vehiculo> BuscarVehiculo(string texto)
            {
                List<Vehiculo> lista = new List<Vehiculo>();

                using (SqlConnection conexion = ConexionDB.ObtenerConexion())
                {
                    string query = @"SELECT * FROM Vehiculo 
                                 WHERE TipoVehiculo LIKE @texto 
                                    OR Estado LIKE @texto";
                    SqlCommand cmd = new SqlCommand(query, conexion);
                    cmd.Parameters.AddWithValue("@texto", "%" + texto + "%");
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        lista.Add(new Vehiculo
                        {
                            VehicleID = (int)reader["VehicleID"],
                            MarcaID = (int)reader["MarcaID"],
                            ModeloID = (int)reader["ModeloID"],
                            TipoVehiculo = reader["TipoVehiculo"].ToString(),
                            PrecioVenta = Convert.ToDecimal(reader["PrecioVenta"]),
                            Estado = reader["Estado"].ToString()
                        });
                    }

                    reader.Close();
                }

                return lista;
            } // 👈 Este cierra el método BuscarVehiculo

            internal List<Vehiculo> BuscarVehiculo()
            {
                throw new NotImplementedException();
            }

            internal List<Vehiculo> ListarVehiculosDisponibles()
            {
                throw new NotImplementedException();
            }
        }
    }
}









