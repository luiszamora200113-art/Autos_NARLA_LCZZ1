using System;

namespace Autos_Narla_MVC.Views
{
    partial class FrmMenuPrincipal
    {
        
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

       
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Titulo1 = new System.Windows.Forms.Label();
            this.Vehiculos = new System.Windows.Forms.Button();
            this.Agregar = new System.Windows.Forms.Button();
            this.Clientes = new System.Windows.Forms.Button();
            this.ventas = new System.Windows.Forms.Button();
            this.salir = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // Titulo1
            // 
            this.Titulo1.AutoSize = true;
            this.Titulo1.Location = new System.Drawing.Point(178, 32);
            this.Titulo1.Name = "Titulo1";
            this.Titulo1.Size = new System.Drawing.Size(309, 20);
            this.Titulo1.TabIndex = 0;
            this.Titulo1.Text = "AUTOS NARLA - SISTEMA DE GESTION";
            // 
            // Vehiculos
            // 
            this.Vehiculos.Location = new System.Drawing.Point(260, 70);
            this.Vehiculos.Name = "Vehiculos";
            this.Vehiculos.Size = new System.Drawing.Size(128, 62);
            this.Vehiculos.TabIndex = 1;
            this.Vehiculos.Text = "Listado de Vehiculos";
            this.Vehiculos.UseVisualStyleBackColor = true;
            this.Vehiculos.Click += new System.EventHandler(this.Vehiculos_Click);
            // 
            // Agregar
            // 
            this.Agregar.Location = new System.Drawing.Point(260, 164);
            this.Agregar.Name = "Agregar";
            this.Agregar.Size = new System.Drawing.Size(128, 62);
            this.Agregar.TabIndex = 2;
            this.Agregar.Text = "Agregar Vehiculos";
            this.Agregar.UseVisualStyleBackColor = true;
            this.Agregar.Click += new System.EventHandler(this.Agregar_Click);
            // 
            // Clientes
            // 
            this.Clientes.Location = new System.Drawing.Point(260, 253);
            this.Clientes.Name = "Clientes";
            this.Clientes.Size = new System.Drawing.Size(128, 62);
            this.Clientes.TabIndex = 3;
            this.Clientes.Text = "Clientes";
            this.Clientes.UseVisualStyleBackColor = true;
            this.Clientes.Click += new System.EventHandler(this.Clientes_Click);
            // 
            // ventas
            // 
            this.ventas.Location = new System.Drawing.Point(260, 341);
            this.ventas.Name = "ventas";
            this.ventas.Size = new System.Drawing.Size(128, 62);
            this.ventas.TabIndex = 4;
            this.ventas.Text = "Ventas";
            this.ventas.UseVisualStyleBackColor = true;
            this.ventas.Click += new System.EventHandler(this.ventas_Click);
            // 
            // salir
            // 
            this.salir.Location = new System.Drawing.Point(260, 436);
            this.salir.Name = "salir";
            this.salir.Size = new System.Drawing.Size(128, 62);
            this.salir.TabIndex = 5;
            this.salir.Text = "Salir";
            this.salir.UseVisualStyleBackColor = true;
            this.salir.Click += new System.EventHandler(this.salir_Click);
            // 
            // FrmMenuPrincipal
            // 
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(700, 558);
            this.Controls.Add(this.salir);
            this.Controls.Add(this.ventas);
            this.Controls.Add(this.Clientes);
            this.Controls.Add(this.Agregar);
            this.Controls.Add(this.Vehiculos);
            this.Controls.Add(this.Titulo1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FrmMenuPrincipal";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Menu Principal - Autos Narla";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        private void Agregar_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        #endregion

        private System.Windows.Forms.Label lbltitulo;
        private System.Windows.Forms.Button btnVehiculos;
        private System.Windows.Forms.Button btnAgregarVehiculo;
        private System.Windows.Forms.Button btnClientes;
        private System.Windows.Forms.Button btnVentas;
        private System.Windows.Forms.Button btnSalir;
        private System.Windows.Forms.Label Titulo1;
        private System.Windows.Forms.Button Vehiculos;
        private System.Windows.Forms.Button Agregar;
        private System.Windows.Forms.Button Clientes;
        private System.Windows.Forms.Button ventas;
        private System.Windows.Forms.Button salir;
    }
}