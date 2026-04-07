using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace appPF_InventarioVetCare
{
    public partial class Clientes : System.Web.UI.Page
    {
        // Cadena de conexión desde Web.config
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarClientes();
            }
        }

        // Listar clientes en Repeater
        void ListarClientes()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("SP_ListarClientes", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                da.Fill(dt);

                rpClientes.DataSource = dt;
                rpClientes.DataBind();

                // Actualizar total de clientes
                lblTotalClientes.Text = dt.Rows.Count.ToString();
            }
        }

        // Guardar o actualizar cliente
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string sp = (hfIdCliente.Value == "0") ? "SP_InsertarCliente" : "SP_EditarCliente";

                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand(sp, con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (hfIdCliente.Value != "0")
                        cmd.Parameters.AddWithValue("@id_cliente", hfIdCliente.Value);

                    cmd.Parameters.AddWithValue("@dni_ruc", txtDni.Text.Trim());
                    cmd.Parameters.AddWithValue("@nombre_completo", txtNombre.Text.Trim());
                    cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@direccion", txtDireccion.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "mostrarMensaje('success','Cliente guardado correctamente');", true);

                Limpiar();
                ListarClientes();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    $"mostrarMensaje('error','{ex.Message}');", true);
            }
        }

        // Limpiar campos
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        void Limpiar()
        {
            hfIdCliente.Value = "0";
            txtDni.Text = "";
            txtNombre.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";

            btnGuardar.Text = "Guardar Cliente";
            btnGuardar.CssClass = "btn btn-primary w-100";
        }

        // Eliminar cliente desde Repeater
        protected void EliminarCliente(object sender, EventArgs e)
        {
            int id = int.Parse(hfEliminarCliente.Value);

            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("SP_EliminarCliente", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_cliente", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    "mostrarMensaje('success','Cliente eliminado correctamente');", true);

                ListarClientes();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "msg",
                    $"mostrarMensaje('error','{ex.Message}');", true);
            }
        }
    }
}