using AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Controllers.AutosNARLA_MVC.Controllers;
using AutosNARLA_MVC.Models;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace AutosNARLA_MVC.Views
{
    public partial class FrmVentas : Form
    {
        private VentaController ventaController = new VentaController();
        private VehiculoController vehiculoController = new VehiculoController();
        private ClienteController clienteController = new ClienteController();

        public FrmVentas()
        {
            InitializeComponent();
        }

        private void FrmVentas_Load(object sender, EventArgs e)
        {
            CargarClientes();
            CargarVehiculos();
        }

        private void CargarClientes()
        {
            List<Cliente> clientes = clienteController.ListarClientes();
            cboCliente.DataSource = clientes;
            cboCliente.DisplayMember = "Nombres";
            cboCliente.ValueMember = "ClienteID";
        }

        private void CargarVehiculos()
        {
            List<Vehiculo> vehiculos = vehiculoController.ListarVehiculosDisponibles();
            cboVehiculo.DataSource = vehiculos;
            cboVehiculo.DisplayMember = "TipoVehiculo";
            cboVehiculo.ValueMember = "VehicleID";
        }

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                int clienteId = Convert.ToInt32(cboCliente.SelectedValue);
                int vehiculoId = Convert.ToInt32(cboVehiculo.SelectedValue);
                decimal precio = Convert.ToDecimal(txtPrecio.Text);
                decimal descuento = Convert.ToDecimal(txtDescuento.Text);

                bool resultado = ventaController.RegistrarVenta(clienteId, vehiculoId, precio, descuento);

                if (resultado)
                {
                    MessageBox.Show("Venta registrada correctamente.", "Éxito", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    CargarVehiculos(); // refresca lista (el vehículo vendido desaparece)
                }
                else
                {
                    MessageBox.Show(" No se pudo completar la venta.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar venta: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}

