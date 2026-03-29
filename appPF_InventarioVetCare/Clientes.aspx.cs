using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Clientes : System.Web.UI.Page
    {
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { ListarClientes(); }
        }

        void ListarClientes()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarClientes", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                gvClientes.DataSource = cmd.ExecuteReader();
                gvClientes.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string sp = (hfIdCliente.Value == "0") ? "SP_InsertarCliente" : "SP_EditarCliente";

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                if (hfIdCliente.Value != "0") cmd.Parameters.AddWithValue("@id_cliente", hfIdCliente.Value);

                cmd.Parameters.AddWithValue("@dni_ruc", txtDni.Text.Trim());
                cmd.Parameters.AddWithValue("@nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@direccion", txtDireccion.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Limpiar();
            ListarClientes();
        }

        protected void gvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvClientes.SelectedIndex;
            hfIdCliente.Value = gvClientes.DataKeys[index].Values["id_cliente"].ToString();
            txtDni.Text = gvClientes.DataKeys[index].Values["dni_ruc"].ToString();
            txtNombre.Text = gvClientes.DataKeys[index].Values["nombre_completo"].ToString();
            txtTelefono.Text = gvClientes.DataKeys[index].Values["telefono"].ToString();
            txtEmail.Text = gvClientes.DataKeys[index].Values["email"].ToString();
            txtDireccion.Text = gvClientes.DataKeys[index].Values["direccion"].ToString();

            btnGuardar.Text = "Actualizar Cliente";
            btnGuardar.CssClass = "btn btn-warning w-100 shadow-sm";
        }

        protected void gvClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvClientes.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarCliente", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_cliente", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            ListarClientes();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        void Limpiar()
        {
            hfIdCliente.Value = "0";
            txtDni.Text = ""; txtNombre.Text = ""; txtTelefono.Text = "";
            txtEmail.Text = ""; txtDireccion.Text = "";
            btnGuardar.Text = "Guardar Cliente";
            btnGuardar.CssClass = "btn btn-primary w-100 shadow-sm";
        }
    }
}