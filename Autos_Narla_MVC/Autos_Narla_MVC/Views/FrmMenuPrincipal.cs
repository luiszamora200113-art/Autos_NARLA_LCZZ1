using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Autos_Narla_MVC.Views
{
    public partial class FrmMenuPrincipal: Form
    {
        public FrmMenuPrincipal()
        {
            InitializeComponent();
        }
        private void salir_Click(object sender, EventArgs e)
        {
            var confirmar = MessageBox.Show(
        "¿Desea salir del sistema?",
        "Confirmar salida",
        MessageBoxButtons.YesNo,
        MessageBoxIcon.Question
         );

            if (confirmar == DialogResult.Yes)
                Application.Exit();
        }

        private void Vehiculos_Click(object sender, EventArgs e)
        {
            Views.FrmVehiculos frm = new Views.FrmVehiculos();
            DialogResult dialogResult = frm.ShowDialog();
        }

        private void Clientes_Click(object sender, EventArgs e)
        {
            Views.FrmClientes frm = new Views.FrmClientes();
            frm.ShowDialog();
        }

        private void ventas_Click(object sender, EventArgs e)
        {
            Views.FrmVentas frm = new Views.FrmVentas();
            frm.ShowDialog();
        }
    }

    internal class FrmVehiculos
    {
        public FrmVehiculos()
        {
        }

        internal DialogResult ShowDialog()
        {
            throw new NotImplementedException();
        }
    }

    internal class FrmClientes
    {
        internal void ShowDialog()
        {
            throw new NotImplementedException();
        }
    }

    internal class FrmVentas
    {
        internal void ShowDialog()
        {
            throw new NotImplementedException();
        }
    }
}




