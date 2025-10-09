using System;
using System.Data.SqlClient;

namespace AutosNARLA_MVC.Controllers
{
    public class ConexionDB
    {
        // Ajusta tu conexión según tu entorno:
        private static string connectionString =
            "Server=localhost;Database=AutosNARLA;User Id=autos_narla;Password=Autos_NarlaLZ13;";

        public static SqlConnection ObtenerConexion()
        {
            try
            {
                SqlConnection conexion = new SqlConnection(connectionString);
                conexion.Open();
                return conexion;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al conectar con la base de datos: " + ex.Message);
            }
        }
    }
}

