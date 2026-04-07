using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Usuarios : System.Web.UI.Page
    {
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

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
            using (SqlConnection con = new SqlConnection(cn))
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

        void ListarUsuarios()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarUsuarios", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Filtro", "");
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rpUsuarios.DataSource = dt;
                rpUsuarios.DataBind();
                lblTotalUsuarios.Text = dt.Rows.Count.ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                bool esNuevo = string.IsNullOrEmpty(hfIdUsuario.Value) || hfIdUsuario.Value == "0";
                string sp = esNuevo ? "SP_InsertarUsuario" : "SP_EditarUsuario";

                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand(sp, con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!esNuevo) cmd.Parameters.AddWithValue("@id_usuario", hfIdUsuario.Value);

                    cmd.Parameters.AddWithValue("@username", txtUser.Text.Trim());
                    cmd.Parameters.AddWithValue("@rol", ddlRol.SelectedValue);
                    cmd.Parameters.AddWithValue("@id_empleado", ddlEmpleado.SelectedValue);

                    if (esNuevo) cmd.Parameters.AddWithValue("@clave", txtPass.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ListarUsuarios();
                Limpiar();
                ScriptManager.RegisterStartupScript(this, GetType(), "ok", "mensajeGuardado();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", $"mensajeError('{ex.Message.Replace("'", "")}');", true);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("SP_EliminarUsuario", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario", hfEliminar.Value);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                ListarUsuarios();
                ScriptManager.RegisterStartupScript(this, GetType(), "del", "mensajeEliminado();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", $"mensajeError('{ex.Message}');", true);
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        void Limpiar()
        {
            hfIdUsuario.Value = "";
            txtUser.Text = "";
            txtPass.Text = "";
            ddlEmpleado.SelectedIndex = 0;
            ddlRol.SelectedIndex = 0;
            divPassword.Style["display"] = "block";
        }
    }
}