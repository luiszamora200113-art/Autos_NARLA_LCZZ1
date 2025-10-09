using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace AutosNARLA_MVC.Models
{

    /// Representa una marca (ej. Toyota, Honda).

    public class Marca
    {
        public int MarcaID { get; set; }

        [Required]
        [StringLength(100)]
        public string NombreMarca { get; set; }

        // Navegación: lista de modelos 
        public List<Modelo> Modelos { get; set; } = new List<Modelo>();
    }
}


