using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Clientes : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                ListarClientes();
            }
        }

        // Método para listar los clientes usando un procedimiento almacenado
        void ListarClientes()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarClientes", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                // Se ejecuta el comando y se enlaza directamente al GridView
                gvClientes.DataSource = cmd.ExecuteReader();
                gvClientes.DataBind();
            }
        }

        // Método para guardar o actualizar un cliente
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Se determina si es insertar o actualizar según el ID
            string sp = (hfIdCliente.Value == "0") ? "SP_InsertarCliente" : "SP_EditarCliente";

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Si es edición, se envía el ID
                if (hfIdCliente.Value != "0")
                    cmd.Parameters.AddWithValue("@id_cliente", hfIdCliente.Value);

                // Se envían los datos del formulario como parámetros
                cmd.Parameters.AddWithValue("@dni_ruc", txtDni.Text.Trim());
                cmd.Parameters.AddWithValue("@nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@direccion", txtDireccion.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se limpian los campos y se actualiza la lista
            Limpiar();
            ListarClientes();
        }

        // Evento que se ejecuta al seleccionar un cliente del GridView
        protected void gvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvClientes.SelectedIndex;

            // Se cargan los datos del cliente seleccionado en los controles
            hfIdCliente.Value = gvClientes.DataKeys[index].Values["id_cliente"].ToString();
            txtDni.Text = gvClientes.DataKeys[index].Values["dni_ruc"].ToString();
            txtNombre.Text = gvClientes.DataKeys[index].Values["nombre_completo"].ToString();
            txtTelefono.Text = gvClientes.DataKeys[index].Values["telefono"].ToString();
            txtEmail.Text = gvClientes.DataKeys[index].Values["email"].ToString();
            txtDireccion.Text = gvClientes.DataKeys[index].Values["direccion"].ToString();

            // Se cambia el botón a modo actualización
            btnGuardar.Text = "Actualizar Cliente";
            btnGuardar.CssClass = "btn btn-warning w-100 shadow-sm";
        }

        // Método para eliminar un cliente desde el GridView
        protected void gvClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Se obtiene el ID del cliente seleccionado
            int id = Convert.ToInt32(gvClientes.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarCliente", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Se envía el ID como parámetro
                cmd.Parameters.AddWithValue("@id_cliente", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Se actualiza la lista después de eliminar
            ListarClientes();
        }

        // Evento del botón limpiar
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        // Método para limpiar los campos del formulario
        void Limpiar()
        {
            hfIdCliente.Value = "0";

            txtDni.Text = "";
            txtNombre.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";

            // Se restablece el botón a modo guardar
            btnGuardar.Text = "Guardar Cliente";
            btnGuardar.CssClass = "btn btn-primary w-100 shadow-sm";
        }
    }
}