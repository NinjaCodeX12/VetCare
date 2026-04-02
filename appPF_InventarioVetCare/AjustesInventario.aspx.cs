using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace appPF_InventarioVetCare
{
    public partial class AjustesInventario : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                cargarProductos();
                listarAjustes();
            }
        }

        // Método para cargar los productos en el DropDownList
        void cargarProductos()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT id_producto, nombre FROM producto", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Se asignan los datos al DropDownList
                ddlProducto.DataSource = dt;
                ddlProducto.DataTextField = "nombre";
                ddlProducto.DataValueField = "id_producto";
                ddlProducto.DataBind();
            }
        }

        // Método para listar los ajustes de inventario
        void listarAjustes()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_ajustes", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Se enlazan los datos al GridView
                gvAjustes.DataSource = dt;
                gvAjustes.DataBind();
            }
        }

        // Método para registrar un nuevo ajuste de inventario
        protected void btnAjustar_Click(object sender, EventArgs e)
        {
            // Validación para verificar que la cantidad sea numérica
            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                alerta.Visible = true;
                alerta.CssClass = "alert alert-warning";
                lblAlerta.Text = "Ingresa una cantidad válida";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_insertar_ajuste", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Se envían los parámetros al procedimiento almacenado
                    cmd.Parameters.AddWithValue("@cantidad", cantidad);
                    cmd.Parameters.AddWithValue("@motivo", txtMotivo.Text.Trim());
                    cmd.Parameters.AddWithValue("@id_producto", ddlProducto.SelectedValue);
                    cmd.Parameters.AddWithValue("@id_usuario", 1);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                alerta.Visible = true;
                alerta.CssClass = "alert alert-success";
                lblAlerta.Text = "Ajuste registrado correctamente";

                // Se actualiza la lista y se limpian los campos
                listarAjustes();
                limpiar();
            }
            catch (Exception ex)
            {
                // Mensaje de error
                alerta.Visible = true;
                alerta.CssClass = "alert alert-danger";
                lblAlerta.Text = ex.Message;
            }
        }

        // Evento para limpiar los campos desde el botón
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        // Método para limpiar 
        void limpiar()
        {
            txtCantidad.Text = "";
            txtMotivo.Text = "";
            ddlProducto.SelectedIndex = 0;
        }
    }
}