using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace appPF_InventarioVetCare
{
    public partial class Empleados : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde Web.config
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Evento que se ejecuta al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se ejecuta solo la primera vez
            if (!IsPostBack)
            {
                listar();
            }
        }

        // Método para listar los empleados
        void listar()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_empleados", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Se enlazan los datos al GridView
                gvEmpleados.DataSource = dt;
                gvEmpleados.DataBind();
            }
        }

        // Método para guardar o actualizar un empleado
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd;

                    // Se determina si es insertar o actualizar
                    if (string.IsNullOrEmpty(hfId.Value))
                        cmd = new SqlCommand("sp_insertar_empleado", con);
                    else
                        cmd = new SqlCommand("sp_actualizar_empleado", con);

                    cmd.CommandType = CommandType.StoredProcedure;

                    // Si es actualización, se envía el ID
                    if (!string.IsNullOrEmpty(hfId.Value))
                        cmd.Parameters.AddWithValue("@id_empleado", hfId.Value);

                    // Se envían los datos del formulario
                    cmd.Parameters.AddWithValue("@nombre", txtNombre.Text.Trim());
                    cmd.Parameters.AddWithValue("@apellido", txtApellido.Text.Trim());
                    cmd.Parameters.AddWithValue("@dni", txtDni.Text.Trim());
                    cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                alerta.Visible = true;
                alerta.CssClass = "alert alert-success";
                lblAlerta.Text = "Guardado correctamente";

                // Se actualiza la lista y se limpian los campos
                listar();
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

        // Evento para seleccionar un empleado y cargarlo en el formulario
        protected void gvEmpleados_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Se obtiene el ID del empleado seleccionado
            hfId.Value = gvEmpleados.SelectedDataKey.Values["id_empleado"].ToString();

            // Se cargan los datos en los campos del formulario
            txtNombre.Text = gvEmpleados.SelectedDataKey.Values["nombre"].ToString();
            txtApellido.Text = gvEmpleados.SelectedDataKey.Values["apellido"].ToString();
            txtDni.Text = gvEmpleados.SelectedDataKey.Values["dni"].ToString();
            txtTelefono.Text = gvEmpleados.SelectedDataKey.Values["telefono"].ToString();

            // Se muestra mensaje indicando modo edición
            alerta.Visible = true;
            alerta.CssClass = "alert alert-info";
            lblAlerta.Text = "Editando empleado seleccionado";
        }

        // Método para eliminar un empleado desde el GridView
        protected void gvEmpleados_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_eliminar_empleado", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Se obtiene el ID del empleado a eliminar
                    cmd.Parameters.AddWithValue("@id_empleado",
                        gvEmpleados.DataKeys[e.RowIndex].Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de eliminación
                alerta.Visible = true;
                alerta.CssClass = "alert alert-warning";
                lblAlerta.Text = "Empleado eliminado";

                listar();
            }
            catch
            {
                // Mensaje de error
                alerta.Visible = true;
                alerta.CssClass = "alert alert-danger";
                lblAlerta.Text = "Error al eliminar";
            }
        }

        // Evento del botón limpiar
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        // Método para limpiar los campos del formulario
        void limpiar()
        {
            hfId.Value = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtDni.Text = "";
            txtTelefono.Text = "";
        }
    }
}   