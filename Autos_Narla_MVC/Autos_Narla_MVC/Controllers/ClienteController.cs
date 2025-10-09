using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AutosNARLA_MVC.Controllers
{
    public class ClienteController
    {
        // Método para listar todos los clientes
        public List<Cliente> ListarClientes()
        {
            List<Cliente> clientes = new List<Cliente>();

            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = "SELECT * FROM Cliente ORDER BY Nombres";
                SqlCommand cmd = new SqlCommand(query, conexion);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    clientes.Add(new Cliente
                    {
                        ClienteID = (int)reader["ClienteID"],
                        Nombres = reader["Nombres"].ToString(),
                        Apellidos = reader["Apellidos"].ToString(),
                        Telefono = reader["Telefono"].ToString(),
                        Correo = reader["Correo"].ToString(),
                        Direccion = reader["Direccion"].ToString()
                    });
                }

                reader.Close();
            }

            return clientes;
        }

        // Método para agregar un nuevo cliente
        public void AgregarCliente(Cliente c)
        {
            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"INSERT INTO Cliente 
                                (Nombres, Apellidos, Telefono, Correo, Direccion)
                                 VALUES (@Nombres, @Apellidos, @Telefono, @Correo, @Direccion)";

                SqlCommand cmd = new SqlCommand(query, conexion);
                cmd.Parameters.AddWithValue("@Nombres", c.Nombres);
                cmd.Parameters.AddWithValue("@Apellidos", c.Apellidos);
                cmd.Parameters.AddWithValue("@Telefono", c.Telefono);
                cmd.Parameters.AddWithValue("@Correo", c.Correo);
                cmd.Parameters.AddWithValue("@Direccion", c.Direccion);

                cmd.ExecuteNonQuery();
            }
        }

        // Buscar cliente por nombre o apellido (consulta parcial)
        public List<Cliente> BuscarClientePorNombre(string texto)
        {
            List<Cliente> resultados = new List<Cliente>();

            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"SELECT * FROM Cliente 
                                 WHERE Nombres LIKE @Texto OR Apellidos LIKE @Texto";

                SqlCommand cmd = new SqlCommand(query, conexion);
                cmd.Parameters.AddWithValue("@Texto", "%" + texto + "%");
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    resultados.Add(new Cliente
                    {
                        ClienteID = (int)reader["ClienteID"],
                        Nombres = reader["Nombres"].ToString(),
                        Apellidos = reader["Apellidos"].ToString(),
                        Telefono = reader["Telefono"].ToString(),
                        Correo = reader["Correo"].ToString(),
                        Direccion = reader["Direccion"].ToString()
                    });
                }

                reader.Close();
            }

            return resultados;
        }

        // Actualizar datos de un cliente
        public void ActualizarCliente(Cliente c)
        {
            using (SqlConnection conexion = ConexionDB.ObtenerConexion())
            {
                string query = @"UPDATE Cliente SET
                                 Nombres = @Nombres,
                                 Apellidos = @Apellidos,
                                 Telefono = @Telefono,
                                 Correo = @Correo,
                                 Direccion = @Direccion
                                 WHERE ClienteID = @ClienteID";

                SqlCommand cmd = new SqlCommand(query, conexion);
                cmd.Parameters.AddWithValue("@Nombres", c.Nombres);
                cmd.Parameters.AddWithValue("@Apellidos", c.Apellidos);
                cmd.Parameters.AddWithValue("@Telefono", c.Telefono);
                cmd.Parameters.AddWithValue("@Correo", c.Correo);
                cmd.Parameters.AddWithValue("@Direccion", c.Direccion);
                cmd.Parameters.AddWithValue("@ClienteID", c.ClienteID);

                cmd.ExecuteNonQuery();
            }
        }
    }
}
