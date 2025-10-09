using System.ComponentModel.DataAnnotations;

namespace AutosNARLA_MVC.Models
{

    /// Representa un cliente del autolote.

    public class Cliente
    {
        public int ClienteID { get; set; }

        [Required]
        [StringLength(100)]
        public string Nombres { get; set; }

        [Required]
        [StringLength(100)]
        public string Apellidos { get; set; }

        [StringLength(30)]
        public string Telefono { get; set; }

        [EmailAddress]
        [StringLength(150)]
        public string Correo { get; set; }

        [StringLength(300)]
        public string Direccion { get; set; }

        // Propiedad de conveniencia
        public string NombreCompleto => $"{Nombres} {Apellidos}";
    }
}
