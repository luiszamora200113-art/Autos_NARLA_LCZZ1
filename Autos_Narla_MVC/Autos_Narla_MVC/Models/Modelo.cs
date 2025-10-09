using System.ComponentModel.DataAnnotations;

namespace AutosNARLA_MVC.Models
{

    /// Representa un modelo perteneciente a una marca (ej. Corolla).

    public class Modelo
    {
        public int ModeloID { get; set; }

        [Required]
        public int MarcaID { get; set; }    // FK hacia Marca

        [Required]
        [StringLength(150)]
        public string NombreModelo { get; set; }

        // Navegación opcional
        public Marca Marca { get; set; }
    }
}

