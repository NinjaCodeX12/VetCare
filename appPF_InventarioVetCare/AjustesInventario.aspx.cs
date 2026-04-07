using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class AjustesInventario : System.Web.UI.Page
    {
        // Cadena de conexión desde Web.config
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar productos en el DropDownList
                cargarProductos();

                // Listar ajustes en la tabla
                listarAjustes();
            }
        }

        // Cargar productos en DropDownList
        void cargarProductos()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT id_producto, nombre FROM producto", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlProducto.DataSource = dt;
                ddlProducto.DataTextField = "nombre";
                ddlProducto.DataValueField = "id_producto";
                ddlProducto.DataBind();
                ddlProducto.Items.Insert(0, new ListItem("-- Seleccione Productos --", "0"));
            }
        }

        // Listar ajustes en el Repeater
        void listarAjustes()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_ajustes", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Enlaza los datos al Repeater
                rpAjustes.DataSource = dt;
                rpAjustes.DataBind();

                // Actualiza el total de ajustes
                lblTotalAjustes.Text = dt.Rows.Count.ToString();
            }
        }

        // Registrar nuevo ajuste
        protected void btnAjustar_Click(object sender, EventArgs e)
        {
            // Validar que la cantidad sea numérica
            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "mostrarMensaje('error','Ingresa una cantidad válida');", true);
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_insertar_ajuste", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@cantidad", cantidad);
                    cmd.Parameters.AddWithValue("@motivo", txtMotivo.Text.Trim());
                    cmd.Parameters.AddWithValue("@id_producto", ddlProducto.SelectedValue);
                    cmd.Parameters.AddWithValue("@id_usuario", 1); // Cambiar según usuario logueado

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito con SweetAlert
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", "mostrarMensaje('success','Ajuste registrado correctamente');", true);

                // Actualizar tabla y limpiar campos
                listarAjustes();
                limpiar();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg", $"mostrarMensaje('error','{ex.Message}');", true);
            }
        }

        // Limpiar campos desde el botón
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        // Limpiar campos del formulario
        void limpiar()
        {
            txtCantidad.Text = "";
            txtMotivo.Text = "";
            ddlProducto.SelectedIndex = 0;
        }
    }
}