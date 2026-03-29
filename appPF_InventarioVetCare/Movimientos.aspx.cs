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
    public partial class Movimientos : System.Web.UI.Page
    {

        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
                CrearTablaTemporal();
            }
        }

        // 1. Llenamos el DropDownList con el SP que creamos
        void CargarProductos()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProductosActivos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                ddlProducto.DataSource = cmd.ExecuteReader();
                ddlProducto.DataTextField = "nombre";
                ddlProducto.DataValueField = "id_producto";
                ddlProducto.DataBind();
                ddlProducto.Items.Insert(0, new ListItem("-- Seleccione Producto --", "0"));
            }
        }

        // 2. Creamos la estructura de la tabla que se verá en el GridView
        void CrearTablaTemporal()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("id_producto");
            dt.Columns.Add("NombreProducto");
            dt.Columns.Add("Cantidad");
            ViewState["DetalleMov"] = dt;
        }

        // 3. Botón para añadir a la lista (Sin guardar en DB aún)
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (ddlProducto.SelectedValue == "0" || string.IsNullOrEmpty(txtCantidad.Text)) return;

            DataTable dt = (DataTable)ViewState["DetalleMov"];
            dt.Rows.Add(ddlProducto.SelectedValue, ddlProducto.SelectedItem.Text, txtCantidad.Text);

            ViewState["DetalleMov"] = dt;
            gvDetalleTemporal.DataSource = dt;
            gvDetalleTemporal.DataBind();

            // Limpiamos selección de producto y cantidad
            ddlProducto.SelectedIndex = 0;
            txtCantidad.Text = "";
        }

        // 4. EL PROCESADO FINAL: Aquí llamamos al SP potente
        protected void btnProcesar_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["DetalleMov"];
            if (dt.Rows.Count == 0 || ddlTipoMovimiento.SelectedValue == "") return;

            // Suponemos que el ID de usuario viene del Login (Session)
            int idUsuario = Convert.ToInt32(Session["id_usuario"] ?? 1);

            try
            {
                using (SqlConnection con = new SqlConnection(strConexion))
                {
                    con.Open();
                    foreach (DataRow row in dt.Rows)
                    {
                        SqlCommand cmd = new SqlCommand("SP_RegistrarMovimiento", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@tipo_movimiento", ddlTipoMovimiento.SelectedValue);
                        cmd.Parameters.AddWithValue("@documento_referencia", txtReferencia.Text.Trim());
                        cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                        cmd.Parameters.AddWithValue("@id_producto", row["id_producto"]);
                        cmd.Parameters.AddWithValue("@cantidad", row["Cantidad"]);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Si todo sale bien, limpiamos y avisamos
                Response.Write("<script>alert('¡Movimiento procesado y stock actualizado!');</script>");
                LimpiarTodo();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        void LimpiarTodo()
        {
            ddlTipoMovimiento.SelectedIndex = 0;
            txtReferencia.Text = "";
            CrearTablaTemporal();
            gvDetalleTemporal.DataSource = (DataTable)ViewState["DetalleMov"];
            gvDetalleTemporal.DataBind();
        }
    }
}