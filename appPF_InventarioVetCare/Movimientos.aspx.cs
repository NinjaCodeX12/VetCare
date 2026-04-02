using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Movimientos : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                CargarProductos();
                CrearTablaTemporal();
            }
        }

        // Método para cargar los productos activos en el DropDownList
        void CargarProductos()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProductosActivos", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                // Se enlazan los datos al DropDownList
                ddlProducto.DataSource = cmd.ExecuteReader();
                ddlProducto.DataTextField = "nombre";
                ddlProducto.DataValueField = "id_producto";
                ddlProducto.DataBind();

                // Se agrega una opción por defecto
                ddlProducto.Items.Insert(0, new ListItem("-- Seleccione Producto --", "0"));
            }
        }

        // Método para crear una tabla temporal en memoria (ViewState)
        void CrearTablaTemporal()
        {
            DataTable dt = new DataTable();

            // Se definen las columnas de la tabla
            dt.Columns.Add("id_producto");
            dt.Columns.Add("NombreProducto");
            dt.Columns.Add("Cantidad");

            // Se guarda en ViewState para mantener los datos entre postbacks
            ViewState["DetalleMov"] = dt;
        }

        // Evento para agregar productos a la lista temporal
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            // Validación básica
            if (ddlProducto.SelectedValue == "0" || string.IsNullOrEmpty(txtCantidad.Text))
                return;

            // Se obtiene la tabla del ViewState
            DataTable dt = (DataTable)ViewState["DetalleMov"];

            // Se agrega una nueva fila
            dt.Rows.Add(
                ddlProducto.SelectedValue,
                ddlProducto.SelectedItem.Text,
                txtCantidad.Text
            );

            // Se actualiza el ViewState
            ViewState["DetalleMov"] = dt;

            // Se enlaza al GridView
            gvDetalleTemporal.DataSource = dt;
            gvDetalleTemporal.DataBind();

            // Se limpian los controles
            ddlProducto.SelectedIndex = 0;
            txtCantidad.Text = "";
        }

        // Evento para procesar el movimiento y guardarlo en la base de datos
        protected void btnProcesar_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["DetalleMov"];

            // Validaciones básicas
            if (dt.Rows.Count == 0 || ddlTipoMovimiento.SelectedValue == "")
                return;

            // Se obtiene el ID del usuario desde la sesión
            int idUsuario = Convert.ToInt32(Session["id_usuario"] ?? 1);

            try
            {
                using (SqlConnection con = new SqlConnection(strConexion))
                {
                    con.Open();

                    // Se recorre cada producto agregado
                    foreach (DataRow row in dt.Rows)
                    {
                        SqlCommand cmd = new SqlCommand("SP_RegistrarMovimiento", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Se envían los parámetros al procedimiento almacenado
                        cmd.Parameters.AddWithValue("@tipo_movimiento", ddlTipoMovimiento.SelectedValue);
                        cmd.Parameters.AddWithValue("@documento_referencia", txtReferencia.Text.Trim());
                        cmd.Parameters.AddWithValue("@id_usuario", idUsuario);
                        cmd.Parameters.AddWithValue("@id_producto", row["id_producto"]);
                        cmd.Parameters.AddWithValue("@cantidad", row["Cantidad"]);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Mensaje de éxito
                Response.Write("<script>alert('Movimiento procesado y stock actualizado');</script>");

                // Se limpian todos los datos
                LimpiarTodo();
            }
            catch (Exception ex)
            {
                // Mensaje de error
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        // Método para limpiar todos los controles y reiniciar la tabla temporal
        void LimpiarTodo()
        {
            ddlTipoMovimiento.SelectedIndex = 0;
            txtReferencia.Text = "";

            // Se reinicia la tabla temporal
            CrearTablaTemporal();

            // Se vuelve a enlazar el GridView vacío
            gvDetalleTemporal.DataSource = (DataTable)ViewState["DetalleMov"];
            gvDetalleTemporal.DataBind();
        }
    }
}