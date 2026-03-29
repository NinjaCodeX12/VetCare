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
    public partial class Usuarios : System.Web.UI.Page
    {
        // Asegúrate de que en tu Web.config la conexión se llame "conexion"
        string strCon = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEmpleados();
                ListarUsuarios();
            }
        }




        void CargarEmpleados()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarEmpleadosActivos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                ddlEmpleado.DataSource = cmd.ExecuteReader();
                ddlEmpleado.DataTextField = "nombre_completo";
                ddlEmpleado.DataValueField = "id_empleado";
                ddlEmpleado.DataBind();
                ddlEmpleado.Items.Insert(0, new ListItem("-- Seleccione Empleado --", "0"));
            }
        }

        void ListarUsuarios(string textoBusqueda = "")
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarUsuarios", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Enviamos el filtro al SP
                cmd.Parameters.AddWithValue("@Filtro", textoBusqueda);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsuarios.DataSource = dt;
                gvUsuarios.DataBind();
            }
        }


        // Agrega el evento del botón buscar
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            ListarUsuarios(txtBuscar.Text.Trim());
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string sp = (hfIdUsuario.Value == "0") ? "SP_InsertarUsuario" : "SP_EditarUsuario";

            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                if (hfIdUsuario.Value != "0")
                    cmd.Parameters.AddWithValue("@id_usuario", hfIdUsuario.Value);

                cmd.Parameters.AddWithValue("@username", txtUser.Text.Trim());
                cmd.Parameters.AddWithValue("@rol", ddlRol.SelectedValue);
                cmd.Parameters.AddWithValue("@id_empleado", ddlEmpleado.SelectedValue);

                if (hfIdUsuario.Value == "0")
                    cmd.Parameters.AddWithValue("@clave", txtPass.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Limpiar();
            ListarUsuarios();
        }

        protected void gvUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = gvUsuarios.SelectedIndex;

            // AQUÍ ESTABA EL ERROR: Se eliminó txtNombre porque ya no existe en el diseño
            hfIdUsuario.Value = gvUsuarios.DataKeys[i].Values["id_usuario"].ToString();
            txtUser.Text = gvUsuarios.DataKeys[i].Values["username"].ToString();
            ddlRol.SelectedValue = gvUsuarios.DataKeys[i].Values["rol"].ToString();
            ddlEmpleado.SelectedValue = gvUsuarios.DataKeys[i].Values["id_empleado"].ToString();

            divPassword.Visible = false;
            btnGuardar.Text = "Actualizar Staff";
            btnGuardar.CssClass = "btn btn-warning shadow-sm fw-bold";
        }

        protected void gvUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarUsuario", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_usuario", gvUsuarios.DataKeys[e.RowIndex].Values["id_usuario"]);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            ListarUsuarios();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e) { Limpiar(); }

        void Limpiar()
        {
            hfIdUsuario.Value = "0";
            txtUser.Text = "";
            txtPass.Text = "";
            if (ddlEmpleado.Items.Count > 0) ddlEmpleado.SelectedIndex = 0;
            divPassword.Visible = true;
            btnGuardar.Text = "Registrar Usuario";
            btnGuardar.CssClass = "btn btn-primary shadow-sm fw-bold";
        }

        protected void btnLimpiar_Click1(object sender, EventArgs e)
        {

        }
    }
}