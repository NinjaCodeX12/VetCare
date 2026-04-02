using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Productos : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                ListarProductos();
                CargarCategorias();
            }
        }

        // Método para cargar las categorías en el DropDownList
        void CargarCategorias()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarCategorias", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                // Se enlazan las categorías al DropDownList
                ddlCategoria.DataSource = cmd.ExecuteReader();
                ddlCategoria.DataTextField = "nombre";
                ddlCategoria.DataValueField = "id_categoria";
                ddlCategoria.DataBind();

                // Se agrega una opción inicial
                ddlCategoria.Items.Insert(0, new ListItem("-- Seleccione Categoría --", "0"));
            }
        }

        // Método para listar los productos
        void ListarProductos()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProductos", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Se enlazan los datos al GridView
                gvProductos.DataSource = dt;
                gvProductos.DataBind();

                // Se actualizan los indicadores
                lblTotal.Text = dt.Rows.Count.ToString();

                // Se calcula cuántos productos tienen stock crítico
                object criticos = dt.Compute("Count(id_producto)", "stock_actual < 5");
                lblCritico.Text = criticos.ToString();
            }
        }

        // Método para guardar o actualizar un producto
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Se define el procedimiento según sea insertar o editar
            string sp = (hfIdProducto.Value == "0") ? "SP_InsertarProducto" : "SP_EditarProducto";

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Si es edición, se envía el ID
                if (hfIdProducto.Value != "0")
                    cmd.Parameters.AddWithValue("@id_producto", hfIdProducto.Value);

                // Se envían los datos del formulario
                cmd.Parameters.AddWithValue("@nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@descripcion", "VetCare Pro");
                cmd.Parameters.AddWithValue("@stock_actual", int.Parse(txtStock.Text));
                cmd.Parameters.AddWithValue("@stock_minimo", 5);
                cmd.Parameters.AddWithValue("@precio_venta", decimal.Parse(txtPrecio.Text));
                cmd.Parameters.AddWithValue("@fecha_vencimiento", DateTime.Now.AddMonths(12));
                cmd.Parameters.AddWithValue("@id_categoria", ddlCategoria.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se limpian los campos y se actualiza la lista
            Limpiar();
            ListarProductos();
        }

        // Evento para seleccionar un producto y cargarlo en el formulario
        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvProductos.SelectedIndex;

            // Se obtienen los datos desde DataKeys
            hfIdProducto.Value = gvProductos.DataKeys[index].Values["id_producto"].ToString();
            txtNombre.Text = gvProductos.DataKeys[index].Values["nombre"].ToString();
            txtPrecio.Text = gvProductos.DataKeys[index].Values["precio_venta"].ToString();
            txtStock.Text = gvProductos.DataKeys[index].Values["stock_actual"].ToString();

            // Se selecciona la categoría correspondiente
            string idCat = gvProductos.DataKeys[index].Values["id_categoria"].ToString();
            if (ddlCategoria.Items.FindByValue(idCat) != null)
            {
                ddlCategoria.SelectedValue = idCat;
            }

            // Se cambia el botón a modo edición
            btnGuardar.Text = "Actualizar Registro";
            btnGuardar.CssClass = "btn btn-modern btn-warning shadow-sm";
        }

        // Método para eliminar un producto
        protected void gvProductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvProductos.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarProducto", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_producto", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se actualiza la lista después de eliminar
            ListarProductos();
        }

        // Evento del botón limpiar
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        // Método para limpiar los campos del formulario
        void Limpiar()
        {
            hfIdProducto.Value = "0";

            txtNombre.Text = "";
            txtPrecio.Text = "";
            txtStock.Text = "";

            // Se restablece el botón a modo guardar
            btnGuardar.Text = "Guardar Cambios";
            btnGuardar.CssClass = "btn btn-modern btn-primary shadow-sm";
        }
    }
}