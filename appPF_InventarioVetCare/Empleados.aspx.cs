using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace appPF_InventarioVetCare
{
    public partial class Empleados : System.Web.UI.Page
    {
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listar();
            }
        }

        // 🔥 LISTAR
        void listar()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_empleados", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvEmpleados.DataSource = dt;
                gvEmpleados.DataBind();
            }
        }

        // 🔥 GUARDAR (INSERTAR / ACTUALIZAR)
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd;

                    if (string.IsNullOrEmpty(hfId.Value))
                        cmd = new SqlCommand("sp_insertar_empleado", con);
                    else
                        cmd = new SqlCommand("sp_actualizar_empleado", con);

                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!string.IsNullOrEmpty(hfId.Value))
                        cmd.Parameters.AddWithValue("@id_empleado", hfId.Value);

                    cmd.Parameters.AddWithValue("@nombre", txtNombre.Text);
                    cmd.Parameters.AddWithValue("@apellido", txtApellido.Text);
                    cmd.Parameters.AddWithValue("@dni", txtDni.Text);
                    cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // ✅ MENSAJE ÉXITO
                alerta.Visible = true;
                alerta.CssClass = "alert alert-success";
                lblAlerta.Text = "✅ Guardado correctamente";

                listar();
                limpiar();
            }
            catch (Exception ex)
            {
                alerta.Visible = true;
                alerta.CssClass = "alert alert-danger";
                lblAlerta.Text = "❌ " + ex.Message;
            }
        }

        // 🔥 SELECCIONAR (EDITAR EN FORMULARIO)
        protected void gvEmpleados_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfId.Value = gvEmpleados.SelectedDataKey.Values["id_empleado"].ToString();

            txtNombre.Text = gvEmpleados.SelectedDataKey.Values["nombre"].ToString();
            txtApellido.Text = gvEmpleados.SelectedDataKey.Values["apellido"].ToString();
            txtDni.Text = gvEmpleados.SelectedDataKey.Values["dni"].ToString();
            txtTelefono.Text = gvEmpleados.SelectedDataKey.Values["telefono"].ToString();

            // 🔥 AQUÍ YA NO HAY MODAL → solo carga en el formulario
            alerta.Visible = true;
            alerta.CssClass = "alert alert-info";
            lblAlerta.Text = "✏ Editando empleado seleccionado";
        }

        // 🔥 ELIMINAR
        protected void gvEmpleados_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_eliminar_empleado", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_empleado",
                        gvEmpleados.DataKeys[e.RowIndex].Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                alerta.Visible = true;
                alerta.CssClass = "alert alert-warning";
                lblAlerta.Text = "🗑 Empleado eliminado";

                listar();
            }
            catch
            {
                alerta.Visible = true;
                alerta.CssClass = "alert alert-danger";
                lblAlerta.Text = "❌ Error al eliminar";
            }
        }

        // 🔥 LIMPIAR
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

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