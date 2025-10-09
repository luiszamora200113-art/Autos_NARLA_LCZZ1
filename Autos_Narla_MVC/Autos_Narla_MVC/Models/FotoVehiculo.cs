using System;
using System.ComponentModel.DataAnnotations;

namespace AutosNARLA_MVC.Models
{

    /// Representa una foto asociada a un vehículo.

    public class FotoVehiculo
    {
        public int FotoID { get; set; }

        [Required]
        public int VehicleID { get; set; }  // FK hacia Vehiculo

        [Required]
        [StringLength(500)]
        public string RutaFoto { get; set; }  // puede ser ruta local o URL
    }
}
