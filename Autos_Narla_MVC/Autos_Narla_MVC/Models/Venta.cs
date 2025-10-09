using System;
using System.ComponentModel.DataAnnotations;

namespace AutosNARLA_MVC.Models
{

    /// Representa una venta realizada.

    public class Venta
    {
        public int VentaID { get; set; }

        [Required]
        public int VehicleID { get; set; }   // FK hacia Vehiculo

        [Required]
        public int ClienteID { get; set; }   // FK hacia Cliente

        public DateTime FechaVenta { get; set; } = DateTime.Now;

        [Range(0, double.MaxValue)]
        public decimal PrecioVenta { get; set; }

        [Range(0, 10)] // regla de negocio: descuento máximo 10%
        public decimal DescuentoAplicado { get; set; } = 0m;

        // Calculado (no mapeado necesariamente en DB): precio neto después del descuento
        public decimal PrecioFinal => PrecioVenta * (1 - (DescuentoAplicado / 100m));
    }
}

