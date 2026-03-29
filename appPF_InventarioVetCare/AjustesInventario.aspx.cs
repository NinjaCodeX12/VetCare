using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace appPF_InventarioVetCare
{
    public partial class AjustesInventario : System.Web.UI.Page
    {
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarProductos();
                listarAjustes();
            }
        }

        // 🔥 CARGAR PRODUCTOS
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
            }
        }

        // 🔥 LISTAR
        void listarAjustes()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_ajustes", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAjustes.DataSource = dt;
                gvAjustes.DataBind();
            }
        }

        // 🔥 GUARDAR AJUSTE
        protected void btnAjustar_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                alerta.Visible = true;
                alerta.CssClass = "alert alert-warning";
                lblAlerta.Text = "⚠ Ingresa una cantidad válida";
                return;
            }
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_insertar_ajuste", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@cantidad", int.Parse(txtCantidad.Text));
                    cmd.Parameters.AddWithValue("@motivo", txtMotivo.Text);
                    cmd.Parameters.AddWithValue("@id_producto", ddlProducto.SelectedValue);
                    cmd.Parameters.AddWithValue("@id_usuario", 1);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // ✅ MENSAJE ÉXITO
                alerta.Visible = true;
                alerta.CssClass = "alert alert-success";
                lblAlerta.Text = "✅ Ajuste registrado correctamente";

                listarAjustes();
                limpiar();
            }
            catch (Exception ex)
            {
                // ❌ ERROR
                alerta.Visible = true;
                alerta.CssClass = "alert alert-danger";
                lblAlerta.Text = "❌ " + ex.Message;
            }
        }

        // 🔥 LIMPIAR
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        void limpiar()
        {
            txtCantidad.Text = "";
            txtMotivo.Text = "";
            ddlProducto.SelectedIndex = 0;
        }
    }
}