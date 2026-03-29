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
    public partial class Proveedores : System.Web.UI.Page
    {

        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarProveedores();
            }
        }

        void ListarProveedores()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProveedores", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                gvProveedores.DataSource = cmd.ExecuteReader();
                gvProveedores.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Usamos los nombres de los SP que creamos antes
            string sp = (hfIdProveedor.Value == "0") ? "SP_InsertarProveedor" : "SP_ActualizarProveedor";

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                if (hfIdProveedor.Value != "0")
                    cmd.Parameters.AddWithValue("@id_proveedor", hfIdProveedor.Value);

                cmd.Parameters.AddWithValue("@ruc", txtRuc.Text.Trim());
                cmd.Parameters.AddWithValue("@razon_social", txtRazonSocial.Text.Trim());
                cmd.Parameters.AddWithValue("@direccion", txtDireccion.Text.Trim());
                cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Limpiar();
            ListarProveedores();
        }

        protected void gvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvProveedores.SelectedIndex;

            // Recuperamos los datos de los DataKeys del GridView
            hfIdProveedor.Value = gvProveedores.DataKeys[index].Values["id_proveedor"].ToString();
            txtRuc.Text = gvProveedores.DataKeys[index].Values["ruc"].ToString();
            txtRazonSocial.Text = gvProveedores.DataKeys[index].Values["razon_social"].ToString();
            txtTelefono.Text = gvProveedores.DataKeys[index].Values["telefono"].ToString();
            txtEmail.Text = gvProveedores.DataKeys[index].Values["email"].ToString();
            txtDireccion.Text = gvProveedores.DataKeys[index].Values["direccion"].ToString();

            btnGuardar.Text = "Actualizar Proveedor";
            btnGuardar.CssClass = "btn btn-warning w-100 shadow-sm";
        }

        protected void gvProveedores_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvProveedores.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarProveedor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_proveedor", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            ListarProveedores();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        void Limpiar()
        {
            hfIdProveedor.Value = "0";
            txtRuc.Text = "";
            txtRazonSocial.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";
            btnGuardar.Text = "Guardar Proveedor";
            btnGuardar.CssClass = "btn btn-primary w-100 shadow-sm";
        }
    }
}