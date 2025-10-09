using AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace AutosNARLA_MVC.Views
{
    public partial class FrmClientes : Form
    {
        private ClienteController controller = new ClienteController();

        public FrmClientes()
        {
            InitializeComponent();
        }

        private void FrmClientes_Load(object sender, EventArgs e)
        {
            CargarClientes();
        }

        private void CargarClientes()
        {
            List<Cliente> lista = controller.ListarClientes();
            dgvClientes.DataSource = lista;
            dgvClientes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvClientes.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvClientes.ReadOnly = true;
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            string texto = txtBuscar.Text.Trim();
            if (string.IsNullOrEmpty(texto))
            {
                CargarClientes();
                return;
            }

            List<Cliente> listaFiltrada = controller.BuscarClientePorNombre(texto);
            dgvClientes.DataSource = listaFiltrada;
        }

        private void btnCargar_Click(object sender, EventArgs e)
        {
            CargarClientes();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            FrmAgregarCliente frm = new FrmAgregarCliente();
            frm.ShowDialog();
            CargarClientes(); // refresca lista después de agregar
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}


