using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Categorias : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde el archivo Web.config
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez que se carga la página
            if (!IsPostBack)
            {
                ListarCategorias();
            }
        }

        // Método para listar las categorías usando un procedimiento almacenado
        void ListarCategorias()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarCategorias", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                // Se almacenan los datos en un DataTable
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                // Se enlazan los datos al GridView
                gvCategorias.DataSource = dt;
                gvCategorias.DataBind();

                // Se muestra el total de categorías
                lblTotalCat.Text = dt.Rows.Count.ToString();
            }
        }

        // Método para guardar una nueva categoría
        protected void btnGuardarCat_Click(object sender, EventArgs e)
        {
            // Validación básica para evitar campos vacíos
            if (string.IsNullOrWhiteSpace(txtNombreCat.Text))
                return;

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertarCategoria", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Se envía el nombre de la categoría como parámetro
                cmd.Parameters.AddWithValue("@nombre", txtNombreCat.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se limpia el campo de texto
            txtNombreCat.Text = "";

            // Se actualiza la lista de categorías
            ListarCategorias();
        }

        // Método para eliminar una categoría seleccionada del GridView
        protected void gvCategorias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Se obtiene el ID de la categoría seleccionada
            int id = Convert.ToInt32(gvCategorias.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarCategoria", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Se envía el ID como parámetro
                cmd.Parameters.AddWithValue("@id_categoria", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se actualiza la lista después de eliminar
            ListarCategorias();
        }

        // Evento para manejar el cambio de página del GridView
        protected void gvCategorias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Se cambia el índice de la página
            gvCategorias.PageIndex = e.NewPageIndex;

            // Se recargan los datos
            ListarCategorias();
        }
    }
}