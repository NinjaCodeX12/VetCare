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
    public partial class Productos : System.Web.UI.Page
    {
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarProductos();
                CargarCategorias();
            }
        }

        void CargarCategorias()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                // Usaremos el mismo SP que crearemos para el CRUD de categorías
                SqlCommand cmd = new SqlCommand("SP_ListarCategorias", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();

                ddlCategoria.DataSource = cmd.ExecuteReader();
                ddlCategoria.DataTextField = "nombre"; // Lo que el usuario lee
                ddlCategoria.DataValueField = "id_categoria";     // El ID que se guarda
                ddlCategoria.DataBind();

                // Agregamos una opción neutra al inicio
                ddlCategoria.Items.Insert(0, new ListItem("-- Seleccione Categoría --", "0"));
            }
        }

        void ListarProductos()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProductos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvProductos.DataSource = dt;
                gvProductos.DataBind();

                // Actualizar contadores dinámicos
                lblTotal.Text = dt.Rows.Count.ToString();
                object criticos = dt.Compute("Count(id_producto)", "stock_actual < 5");
                lblCritico.Text = criticos.ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string sp = (hfIdProducto.Value == "0") ? "SP_InsertarProducto" : "SP_EditarProducto";
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;
                if (hfIdProducto.Value != "0") cmd.Parameters.AddWithValue("@id_producto", hfIdProducto.Value);

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
            Limpiar();
            ListarProductos();
        }

        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Obtenemos el índice de la fila seleccionada
            int index = gvProductos.SelectedIndex;

            // JALAMOS LOS DATOS DIRECTO DE LOS DATAKEYS (Sin HTML)
            hfIdProducto.Value = gvProductos.DataKeys[index].Values["id_producto"].ToString();
            txtNombre.Text = gvProductos.DataKeys[index].Values["nombre"].ToString();
            txtPrecio.Text = gvProductos.DataKeys[index].Values["precio_venta"].ToString();
            txtStock.Text = gvProductos.DataKeys[index].Values["stock_actual"].ToString();

            // También seleccionamos la categoría correcta en el combo
            string idCat = gvProductos.DataKeys[index].Values["id_categoria"].ToString();
            if (ddlCategoria.Items.FindByValue(idCat) != null)
            {
                ddlCategoria.SelectedValue = idCat;
            }

            // Cambiar visual del botón
            btnGuardar.Text = "Actualizar Registro";
            btnGuardar.CssClass = "btn btn-modern btn-warning shadow-sm";
        }

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
            ListarProductos();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e) { Limpiar(); }

        void Limpiar()
        {
            hfIdProducto.Value = "0";
            txtNombre.Text = ""; txtPrecio.Text = ""; txtStock.Text = "";
            btnGuardar.Text = "Guardar Cambios";
            btnGuardar.CssClass = "btn btn-modern btn-primary shadow-sm";
        }
    }
}