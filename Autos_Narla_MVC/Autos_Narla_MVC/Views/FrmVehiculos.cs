using AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Controllers.AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace AutosNARLA_MVC.Views
{
    public partial class FrmVehiculos : Form
    {
        private VehiculoController controller = new VehiculoController();


        public FrmVehiculos()
        {
            InitializeComponent();
        }

        private void FrmVehiculos_Load(object sender, EventArgs e)
        {
            try
            {
                CargarVehiculos();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar vehículos: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void CargarVehiculos()
        {
            List<Vehiculo> lista = controller.BuscarVehiculo();
            dgvVehiculos.DataSource = lista;
            dgvVehiculos.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvVehiculos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvVehiculos.ReadOnly = true;
        }

        private void btnFiltrar_Click(object sender, EventArgs e)
        {
            try
            {
                string texto = txtFiltro.Text.Trim();
                if (string.IsNullOrEmpty(texto))
                {
                    CargarVehiculos();
                    return;
                }

                List<Vehiculo> listaFiltrada = controller.BuscarVehiculo(texto);
                dgvVehiculos.DataSource = listaFiltrada;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error en filtro: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCargar_Click(object sender, EventArgs e)
        {
            CargarVehiculos();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}


