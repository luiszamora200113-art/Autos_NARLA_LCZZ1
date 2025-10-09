using AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Models;
using System;
using System.Windows.Forms;

namespace AutosNARLA_MVC.Views
{
    public partial class FrmAgregarCliente : Form
    {
        private ClienteController controller = new ClienteController();
        private object txtNombres;
        private object txtApellidos;
        private object txtTelefono;
        private object txtDireccion;
        private object txtCorreo;

        public FrmAgregarCliente()
        {
            InitializeComponent();
        }

        private void InitializeComponent()
        {
            throw new NotImplementedException();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!(!string.IsNullOrEmpty(txtNombres.Text)
                    && !string.IsNullOrEmpty(txtApellidos.Text)))
                {
                    MessageBox.Show("Debe llenar los campos obligatorios (Nombres y Apellidos).",
                        "Campos requeridos", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                Cliente c = new Cliente { Nombres = txtNombres.Text.Trim(), Apellidos = txtApellidos.Text.Trim(), Telefono = txtTelefono.text.Trim(), Correo = txtCorreo.Text.Trim(), Direccion = txtDireccion.Text.Trim() };

                controller.AgregarCliente(c);
                MessageBox.Show(" Cliente agregado correctamente.",
                    "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al agregar cliente: " + ex.Message,
                    "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}

