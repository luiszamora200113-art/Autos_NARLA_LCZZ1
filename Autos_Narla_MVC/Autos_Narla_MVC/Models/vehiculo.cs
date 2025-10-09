using System;

namespace AutosNARLA_MVC.Models
{
    public class Vehiculo
    {
        public int VehicleID { get; set; }
        public int MarcaID { get; set; }
        public int ModeloID { get; set; }
        public string Chasis { get; set; }
        public int Anio { get; set; }
        public string Combustible { get; set; }
        public int Cilindraje { get; set; }
        public string TipoVehiculo { get; set; }
        public decimal PrecioAdquisicion { get; set; }
        public decimal PrecioVenta { get; set; }
        public string Estado { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}

