using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Proveedores : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                ListarProveedores();
            }
        }

        // Método para listar los proveedores
        void ListarProveedores()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarProveedores", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                // Se ejecuta el comando y se enlaza al GridView
                gvProveedores.DataSource = cmd.ExecuteReader();
                gvProveedores.DataBind();
            }
        }

        // Método para guardar o actualizar un proveedor
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Se determina si es insertar o actualizar
            string sp = (hfIdProveedor.Value == "0") ? "SP_InsertarProveedor" : "SP_ActualizarProveedor";

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Si es actualización, se envía el ID
                if (hfIdProveedor.Value != "0")
                    cmd.Parameters.AddWithValue("@id_proveedor", hfIdProveedor.Value);

                // Se envían los datos del formulario
                cmd.Parameters.AddWithValue("@ruc", txtRuc.Text.Trim());
                cmd.Parameters.AddWithValue("@razon_social", txtRazonSocial.Text.Trim());
                cmd.Parameters.AddWithValue("@direccion", txtDireccion.Text.Trim());
                cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se limpian los campos y se actualiza la lista
            Limpiar();
            ListarProveedores();
        }

        // Evento para seleccionar un proveedor y cargarlo en el formulario
        protected void gvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvProveedores.SelectedIndex;

            // Se obtienen los datos desde DataKeys
            hfIdProveedor.Value = gvProveedores.DataKeys[index].Values["id_proveedor"].ToString();
            txtRuc.Text = gvProveedores.DataKeys[index].Values["ruc"].ToString();
            txtRazonSocial.Text = gvProveedores.DataKeys[index].Values["razon_social"].ToString();
            txtTelefono.Text = gvProveedores.DataKeys[index].Values["telefono"].ToString();
            txtEmail.Text = gvProveedores.DataKeys[index].Values["email"].ToString();
            txtDireccion.Text = gvProveedores.DataKeys[index].Values["direccion"].ToString();

            // Se cambia el botón a modo edición
            btnGuardar.Text = "Actualizar Proveedor";
            btnGuardar.CssClass = "btn btn-warning w-100 shadow-sm";
        }

        // Método para eliminar un proveedor desde el GridView
        protected void gvProveedores_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Se obtiene el ID del proveedor seleccionado
            int id = Convert.ToInt32(gvProveedores.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarProveedor", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Se envía el ID como parámetro
                cmd.Parameters.AddWithValue("@id_proveedor", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se actualiza la lista después de eliminar
            ListarProveedores();
        }

        // Evento del botón limpiar
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        // Método para limpiar los campos del formulario
        void Limpiar()
        {
            hfIdProveedor.Value = "0";

            txtRuc.Text = "";
            txtRazonSocial.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";

            // Se restablece el botón a modo guardar
            btnGuardar.Text = "Guardar Proveedor";
            btnGuardar.CssClass = "btn btn-primary w-100 shadow-sm";
        }
    }
}